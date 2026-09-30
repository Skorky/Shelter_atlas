# Úkryty — interní iOS PoC

Nativní SwiftUI aplikace pro iOS 17+ (iPhone a iPad), MapKit, Core Location. Bez externích závislostí. Projekt není určen k publikaci, dokud se nevyjasní licence dat.

## Spuštění

1. Otevřete `Ukryty.xcodeproj` v Xcode (doporučeno Xcode 16 nebo novější).
2. Vyberte schéma **Ukryty** a iPhone simulátor s iOS 17+. Stiskněte Run.
3. Pro fyzický iPhone nastavte vlastní **Team** v Signing & Capabilities; případně změňte bundle identifier. Vývojářský tým není v projektu předvyplněn.
4. Aplikace načte TERINOS automaticky. Klepněte na **Aktualizovat moji polohu** a povolte polohu při používání aplikace. V simulátoru nastavte testovací polohu přes Features → Location → Custom Location, například 50.083, 14.426.
5. Klepnutím na pin nebo kartu nejbližšího evidovaného úkrytu otevřete detail. **Navigovat přes Apple Maps** otevře pěší trasu k evidovanému bodu.
6. Při nedostupném serveru otevřete nabídku **… → Zobrazit demonstrační data**. Tři fiktivní body v Praze slouží jen k ověření UI; navigace je u nich vypnuta. Návrat k reálným datům: **Načíst TERINOS znovu**.

## Chování a omezení

- UI používá „Nejbližší evidovaný úkryt“. Evidence nepotvrzuje zpřístupnění, provozuschopnost ani bezpečí. Navigace neověřuje vchod či přístupnost.
- Vzdálenost je vzdušná přes `CLLocation.distance(from:)`, nikoli délka trasy. Výpočet pracuje s naposledy vyžádanou polohou, zobrazuje přesnost a po dvou minutách vyžaduje obnovení. Nejde o průběžnou navigaci.
- Poloha se neposílá do TERINOS. Aplikace neobsahuje analytiku, vlastní backend ani trvalou databázi úkrytů. TERINOS používá ephemeral URLSession bez diskové cache. Mapové podklady a Apple Maps využívají služby Apple.
- Záznamy bez použitelných geometrických souřadnic se vynechají a jejich počet se zobrazí. Hodnota `platna_sour` se vypisuje jako původní údaj; její význam bez číselníku neodhadujeme.
- Pole stavu ani určení nemají v metadatech číselník. Aplikace je zobrazuje samostatně, bez vlastní interpretace.
- Při obnovení se stará data vymažou. Neúplná dávka znamená chybu, nikoliv částečný seznam prezentovaný jako kompletní. Změny dat během načítání nejsou transakčně izolované; chybějící ID vyvolá opakování uživatelem.
- Pro tento PoC se zobrazují všechny piny. U větších budoucích datasetů je vhodné doplnit clustering nebo dotazy podle výřezu.

## Ověřené rozhraní TERINOS

Ověřeno 29. 9. 2026 před implementací dekódování:

- [Metadata vrstvy](https://gis.izscr.cz/arcgis/rest/services/terinos_sluzby/ukryty_cr_evid/MapServer/0?f=pjson): `ukryty_cr_evid`, bodová geometrie, původní SR 102067 / 5514, `maxRecordCount = 2000`, podporované JSON dotazy a stránkování. Popis datové vrstvy obsahoval datum 2026_03_24; nejde o potvrzení aktuálnosti jednotlivých záznamů.
- [Skutečný REST query endpoint](https://gis.izscr.cz/arcgis/rest/services/terinos_sluzby/ukryty_cr_evid/MapServer/0/query) a formulář jeho parametrů jsou dostupné.
- **Datovou JSON odpověď se ze zdejší sítě nepodařilo získat:** dotazy skončily timeoutem nebo chybou přístupového nástroje. Dekodér vychází z ověřených metadat a standardního ArcGIS JSON formátu. Testovací odpovědi jsou syntetické, nejsou vydávány za zachycená produkční data. Živý integrační test je stále potřeba provést v síti s přístupem k TERINOS.

| Pole | Typ v metadatech | Použití |
| --- | --- | --- |
| `objectid` | OID | Jedinečný identifikátor |
| `misto`, `kraj` | String | Místo, kraj |
| `ev_číslo` | Double | Evidenční číslo |
| `kapacita` | Double | Kapacita, bez zaokrouhlení při dekódování |
| `stav`, `stav_terin` | String | Dva samostatné údaje o stavu |
| `urceni`, `určení` | String | Dvě samostatná pole určení |
| `odolnost` | String | Odolnost |
| `platna_sour` | Double | Původní hodnota příznaku souřadnic |

Nejdříve dotaz `where=1=1&returnIdsOnly=true&f=json`, poté dávky 300 ID s `objectIds`, explicitním seznamem `outFields`, `returnGeometry=true` a `outSR=4326`. Pro mapu se dekóduje vrácená geometrie `x = longitude`, `y = latitude`, nikoli pomocná pole `wgs_x/wgs_y`. Každá dávka musí obsahovat přesně požadovaná ID, nepřekročit transfer limit a mít SR 4326. Serverové chyby uvnitř HTTP 200 jsou zpracovány jako chyby.

## Architektura

- `Core/Shelter.swift`: datový model, nejbližší bod, `ShelterSnapshot`, protokol `ShelterService` a explicitní fiktivní demo.
- `Core/ArcGISShelterService.swift`: síťové dotazy, kontrola úplnosti a dekódování ArcGIS.
- `UI/ShelterStore.swift`: načítání, rušení předchozích požadavků, ochrana proti přepsání novějšího výsledku, loading/error stav. Dostává službu přes inicializátor.
- `UI/LocationStore.swift`: oprávnění a jednorázové získání polohy, publikace na hlavním vlákně.
- `UI/ContentView.swift`, `ShelterDetail.swift`: mapa, výběr bodu a detail s navigací.

Jiný zdroj stačí implementovat jako `ShelterService`. Offline cache může později službu obalit; bude vhodné rozšířit snapshot o původ, stáří a stav synchronizace. Současné UI neoznačuje čas načtení jako čas aktualizace zdroje.

## Ověření

- Úspěšný Debug build pro arm64 iOS simulátor pomocí Xcode 27.0, bez podpisu.
- 6 automatických XCTest testů prošlo bez chyb na macOS: české klíče a nullable hodnoty, osy souřadnic, chybné geometrie, ArcGIS chyba v JSON, URL parametry, nejbližší bod a prázdný seznam, načtení 301 ID ve více dávkách a odmítnutí neúplné dávky.
- UI nebylo spuštěno: CoreSimulator nebyl v prostředí automatického ověření dostupný. GPS oprávnění, vykreslení mapy a předání Apple Maps vyžadují ruční kontrolu v simulátoru / telefonu.

Z kořene projektu:

```sh
xcodebuild -project Ukryty.xcodeproj -scheme Ukryty -sdk iphonesimulator \
  -configuration Debug -derivedDataPath /tmp/UkrytyDerivedData \
  CODE_SIGNING_ALLOWED=NO ARCHS=arm64 build
swift test
```

Testy jádra jsou samostatný Swift Package; nemají závislost na simulátoru. V Xcode je lze otevřít přes `Package.swift`.

Ruční kontrola před dalším použitím: povolená / zamítnutá / přibližná poloha, vypnutý internet a opakování, přepnutí demo → TERINOS během načítání, klepnutí na pin a opakované otevření detailu, velký text a otočení iPadu, návrat z Nastavení a Apple Maps. Pro živé ověření zkontrolujte počty načtených ID, originální hodnoty detailu a geografické umístění několika bodů.
