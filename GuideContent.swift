import Foundation

enum GuideContent {

    static let topics: [GuideTopic] = [

        // MARK: - UKRYTÍ

        GuideTopic(
            id: "shelter",
            title: "Ukrytí",
            subtitle: "Jak postupovat při nutnosti ukrytí",
            symbolName: "house.fill",

            sections: [
                GuideSection(
                    id: "shelter-first",
                    title: "Co udělat nejdříve",
                    items: [
                        "Co nejrychleji vyhledejte nejbližší vhodnou pevnou budovu.",
                        "Pokud už jste uvnitř vhodné budovy, zpravidla v ní zůstaňte.",
                        "Zavřete okna a dveře.",
                        "Vypněte ventilaci a klimatizaci, pokud hrozí nebezpečí zvenčí.",
                        "Sledujte oficiální informace a pokyny záchranných složek.",
                        "Nevycházejte ven bez vážného důvodu."
                    ]
                ),

                GuideSection(
                    id: "shelter-place",
                    title: "Jak vybrat místo",
                    items: [
                        "Využijte domov, školu, pracoviště nebo jinou pevnou budovu.",
                        "Auto ani autobusová zastávka nejsou vhodným úkrytem.",
                        "Konkrétní místnost vybírejte podle typu nebezpečí.",
                        "Vždy mají přednost aktuální pokyny záchranných složek."
                    ]
                ),

                GuideSection(
                    id: "shelter-important",
                    title: "Důležité",
                    items: [
                        "Stálý úkryt není automaticky totéž jako nejlepší místo pro okamžité ukrytí.",
                        "Při náhlém ohrožení bývá zásadní rychlost ukrytí.",
                        "Evidovaný úkryt v mapě nemusí být právě zpřístupněný."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "shelter-meaning",
                    title: "Co znamená ukrytí",
                    paragraphs: [
                        "Ukrytí je ochranné opatření, jehož cílem je co nejrychleji omezit působení nebezpečných vlivů z okolního prostředí. Neznamená automaticky přesun do speciálního krytu.",
                        "V mnoha situacích je nejbezpečnější vstoupit do nejbližší pevné budovy a zůstat uvnitř. Budova může chránit před větrem, troskami, kouřem, částí škodlivin ve vzduchu a podle své konstrukce také před ionizujícím zářením."
                    ]
                ),

                GuideArticleSection(
                    id: "shelter-building",
                    title: "Jakou budovu zvolit",
                    paragraphs: [
                        "Obecně je vhodnější pevná zděná nebo železobetonová budova než lehká konstrukce. Pokud už jste doma, ve škole nebo v zaměstnání a samotná budova není bezprostředně ohrožena, bývá často vhodnější zůstat uvnitř než se přesouvat ven.",
                        "Vyhýbejte se celoproskleným objektům a budovám ve špatném technickém stavu."
                    ]
                ),

                GuideArticleSection(
                    id: "shelter-chemical",
                    title: "Při chemickém úniku",
                    paragraphs: [
                        "Při úniku nebezpečné chemické látky se ukryjte v budově, zavřete okna a dveře a omezte přístup venkovního vzduchu.",
                        "Vypněte klimatizaci, rekuperaci a další systémy, které nasávají vzduch zvenčí.",
                        "Oficiální doporučení uvádí při chemickém úniku vyšší patra budovy, pokud možno na opačné straně od zdroje nebezpečí. Řada nebezpečných plynů a par je těžší než vzduch a může se držet při zemi.",
                        "Pokyny pro konkrétní látku ale mají vždy přednost před obecným pravidlem."
                    ]
                ),

                GuideArticleSection(
                    id: "shelter-radiation",
                    title: "Při radiační havárii",
                    paragraphs: [
                        "Při radiační havárii se doporučuje uzavřený zděný prostor, například sklepní nebo suterénní místnost.",
                        "Stavební materiál mezi člověkem a vnějším prostředím pomáhá snižovat působení záření. Vnitřní části budovy a prostory bez velkých oken mohou poskytovat lepší ochranu.",
                        "Jódové tablety neužívejte automaticky. Používají se pouze tehdy, pokud k tomu vydají pokyn příslušné orgány."
                    ]
                ),

                GuideArticleSection(
                    id: "shelter-wind",
                    title: "Při vichřici nebo tornádu",
                    paragraphs: [
                        "Držte se dál od oken. Vhodný je sklep, suterén nebo místnost bez oken v nejnižším patře.",
                        "Pokud se nemůžete přesunout do nejnižšího patra, vyhledejte střed budovy.",
                        "Malý objekt bez pevných základů není vhodným místem. Pokud je to bezpečně možné, přesuňte se do pevnější budovy."
                    ]
                ),

                GuideArticleSection(
                    id: "shelter-apartment",
                    title: "Bytový dům",
                    paragraphs: [
                        "V bytovém domě záleží volba místa na typu ohrožení. Při chemickém úniku mohou být vhodnější vyšší podlaží, zatímco při radiační události může být výhodnější suterén nebo vnitřní část budovy.",
                        "Nevycházejte na chodbu ani ven jen proto, abyste zjistili, co se děje. Informace sledujte prostřednictvím oficiálních kanálů."
                    ]
                ),

                GuideArticleSection(
                    id: "shelter-car",
                    title: "Když jste v autě",
                    paragraphs: [
                        "Automobil neposkytuje stejnou ochranu jako pevná budova. Pokud je možné bezpečně vstoupit do blízkého pevného objektu, je to zpravidla vhodnější.",
                        "Pokud přesun není možný, zavřete okna, omezte nasávání venkovního vzduchu a sledujte oficiální informace."
                    ]
                ),

                GuideArticleSection(
                    id: "shelter-duration",
                    title: "Jak dlouho zůstat uvnitř",
                    paragraphs: [
                        "Univerzální doba neexistuje. Záleží na typu události, počasí, směru šíření nebezpečí a dalších podmínkách.",
                        "Zůstaňte ukrytí a čekejte na další pokyny záchranných složek nebo odpovědných úřadů."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin / HZS ČR",
            sourceURL: "https://www.72h.gov.cz/cs/ukryt"
        ),

        // MARK: - EVAKUACE

        GuideTopic(
            id: "evacuation",
            title: "Evakuace",
            subtitle: "Co dělat při nařízené evakuaci",
            symbolName: "figure.walk",

            sections: [
                GuideSection(
                    id: "evacuation-first",
                    title: "Když je nařízena evakuace",
                    items: [
                        "Řiďte se pokyny záchranných složek a úřadů.",
                        "Připravte evakuační zavazadlo.",
                        "Vezměte děti, osoby vyžadující pomoc a domácí zvířata.",
                        "Přesuňte se na určené místo.",
                        "Nevracejte se do ohrožené oblasti bez povolení."
                    ]
                ),

                GuideSection(
                    id: "evacuation-bag",
                    title: "Co vzít",
                    items: [
                        "Doklady, klíče, hotovost a platební karty.",
                        "Pravidelně užívané léky a lékárničku.",
                        "Pitnou vodu a trvanlivé jídlo.",
                        "Telefon, nabíječku a powerbanku.",
                        "Oblečení, hygienu, spacák nebo deku.",
                        "Potřeby pro děti a zvířata."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "evacuation-meaning",
                    title: "Co je evakuace",
                    paragraphs: [
                        "Evakuace znamená organizovaný přesun osob, případně zvířat a věcí, z prostoru, kde hrozí nebezpečí, do bezpečnější oblasti.",
                        "Může být preventivní, například před očekávanou povodní, nebo velmi rychlá při bezprostředním ohrožení."
                    ]
                ),

                GuideArticleSection(
                    id: "evacuation-before",
                    title: "Před opuštěním domácnosti",
                    paragraphs: [
                        "Pokud je dostatek času a dostanete takový pokyn, zabezpečte domácnost. Uzavřete okna, vodu a plyn a vypněte elektrické spotřebiče.",
                        "Neprovádějte tyto úkony, pokud by vás zdržovaly v bezprostředně nebezpečné situaci."
                    ]
                ),

                GuideArticleSection(
                    id: "evacuation-bag-detail",
                    title: "Evakuační zavazadlo",
                    paragraphs: [
                        "Zavazadlo by mělo obsahovat především dokumenty, peníze, léky, vodu, trvanlivé jídlo, oblečení, hygienu a prostředky pro komunikaci.",
                        "Pro delší pobyt se hodí také spacák nebo deka, svítilna, rádio na baterie a náhradní baterie.",
                        "Zavazadlo označte jménem a kontaktními údaji."
                    ]
                ),

                GuideArticleSection(
                    id: "evacuation-children",
                    title: "Děti",
                    paragraphs: [
                        "Malému dítěti připravte identifikační kartičku se jménem, adresou a kontaktem na blízkou osobu.",
                        "Do zavazadla přidejte oblíbenou hračku nebo jiný předmět, který dítě zná a může mu pomoci zvládat stres."
                    ]
                ),

                GuideArticleSection(
                    id: "evacuation-pets",
                    title: "Domácí zvířata",
                    paragraphs: [
                        "Pro zvířata připravte krmivo, vodu, léky, misky a potřebnou dokumentaci.",
                        "Podle druhu zvířete mějte připravené vodítko, náhubek nebo přepravku."
                    ]
                ),

                GuideArticleSection(
                    id: "evacuation-return",
                    title: "Návrat domů",
                    paragraphs: [
                        "Do evakuované oblasti se nevracejte jen proto, že se situace zdá klidná.",
                        "Vyčkejte, až návrat povolí příslušné orgány nebo záchranné složky."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin",
            sourceURL: "https://www.72h.gov.cz/cs/evakuace"
        ),

        // MARK: - VŠEOBECNÁ VÝSTRAHA

        GuideTopic(
            id: "warning",
            title: "Všeobecná výstraha",
            subtitle: "Jak reagovat na varovný signál",
            symbolName: "speaker.wave.3.fill",

            sections: [
                GuideSection(
                    id: "warning-signal",
                    title: "Jak ji poznat",
                    items: [
                        "Kolísavý tón sirény trvající 140 sekund znamená všeobecnou výstrahu.",
                        "Jde o varování před obecným ohrožením."
                    ]
                ),

                GuideSection(
                    id: "warning-action",
                    title: "Co udělat",
                    items: [
                        "Rychle se ukryjte v nejbližší pevné budově.",
                        "Zavřete dveře a okna.",
                        "Vypněte ventilaci a klimatizaci.",
                        "Sledujte oficiální informace.",
                        "Zbytečně netelefonujte."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "warning-purpose",
                    title: "K čemu sirény slouží",
                    paragraphs: [
                        "Varovný systém má obyvatelstvo rychle upozornit na hrozící nebo probíhající nebezpečí.",
                        "Varování může přijít prostřednictvím sirén, místního rozhlasu, mobilních prostředků, zpráv úřadů nebo zasahujících složek."
                    ]
                ),

                GuideArticleSection(
                    id: "warning-difference",
                    title: "Ne každá siréna znamená ohrožení",
                    paragraphs: [
                        "Všeobecná výstraha má kolísavý tón a trvá 140 sekund.",
                        "Setkat se můžete také se zkouškou sirén nebo se signálem určeným ke svolání jednotek požární ochrany."
                    ]
                ),

                GuideArticleSection(
                    id: "warning-info",
                    title: "Co dělat potom",
                    paragraphs: [
                        "Po ukrytí si zajistěte přístup k informacím. Sledujte zprávy HZS, obce, kraje, Českého rozhlasu, České televize a dalších důvěryhodných zdrojů.",
                        "Při výpadku proudu může být velmi užitečné rádio na baterie."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin / HZS ČR",
            sourceURL: "https://www.72h.gov.cz/cs/ukryt"
        ),

        // MARK: - CHEMICKÁ HAVÁRIE

        GuideTopic(
            id: "chemical",
            title: "Chemická havárie",
            subtitle: "Postup při úniku nebezpečných látek",
            symbolName: "aqi.medium",

            sections: [
                GuideSection(
                    id: "chemical-first",
                    title: "Okamžitě",
                    items: [
                        "Vstupte do nejbližší pevné budovy.",
                        "Zavřete okna a dveře.",
                        "Vypněte ventilaci a klimatizaci.",
                        "Pokud není řečeno jinak, přesuňte se do vyšších pater.",
                        "Sledujte oficiální pokyny."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "chemical-behaviour",
                    title: "Proč se ukrýt uvnitř",
                    paragraphs: [
                        "Nebezpečná chemická látka se může šířit vzduchem a nemusí být vidět ani cítit.",
                        "Pevná budova umožňuje omezit přístup kontaminovaného venkovního vzduchu."
                    ]
                ),

                GuideArticleSection(
                    id: "chemical-air",
                    title: "Ventilace",
                    paragraphs: [
                        "Zavřete okna a dveře a vypněte systémy, které přivádějí vzduch zvenčí.",
                        "Pokud máte rekuperaci nebo centrální ventilaci, je dobré předem vědět, jak ji rychle vypnout."
                    ]
                ),

                GuideArticleSection(
                    id: "chemical-floor",
                    title: "Výběr patra",
                    paragraphs: [
                        "Oficiální doporučení uvádí při chemickém úniku vyšší patra budovy na opačné straně od zdroje nebezpečí.",
                        "Jde o obecné pravidlo. Konkrétní látky mají různé vlastnosti, takže aktuální pokyny záchranných složek mají vždy přednost."
                    ]
                ),

                GuideArticleSection(
                    id: "chemical-outside",
                    title: "Když jste byli venku",
                    paragraphs: [
                        "Pokud mohlo dojít ke kontaktu s nebezpečnou látkou, řiďte se pokyny k dekontaminaci.",
                        "Nezanášejte zbytečně případné znečištění do obytných prostor."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin / HZS ČR",
            sourceURL: "https://www.72h.gov.cz/cs/ukryt"
        ),

        // MARK: - RADIAČNÍ UDÁLOST

        GuideTopic(
            id: "radiation",
            title: "Radiační událost",
            subtitle: "Základní zásady ochrany",
            symbolName: "atom",

            sections: [
                GuideSection(
                    id: "radiation-first",
                    title: "Okamžitě",
                    items: [
                        "Vstupte do pevné budovy.",
                        "Vhodný je uzavřený zděný prostor.",
                        "Zavřete okna a dveře.",
                        "Omezte pobyt venku.",
                        "Sledujte oficiální pokyny.",
                        "Jódové tablety užívejte pouze na základě pokynu."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "radiation-protection",
                    title: "Čas, vzdálenost a stínění",
                    paragraphs: [
                        "Ochrana před ionizujícím zářením obecně využívá omezení času expozice, větší vzdálenost od zdroje a stínění materiálem.",
                        "Právě proto může pevná budova výrazně pomoci snížit expozici."
                    ]
                ),

                GuideArticleSection(
                    id: "radiation-place",
                    title: "Kde se ukrýt",
                    paragraphs: [
                        "Oficiální doporučení uvádí uzavřený zděný prostor, například sklepní nebo suterénní místnost.",
                        "Vhodné mohou být také vnitřní prostory budovy s co nejmenším počtem oken."
                    ]
                ),

                GuideArticleSection(
                    id: "radiation-iodine",
                    title: "Jódové tablety",
                    paragraphs: [
                        "Jódová profylaxe není univerzální ochrana před radiací.",
                        "Tablety neužívejte preventivně podle vlastního rozhodnutí. Užívejte je pouze tehdy, pokud to doporučí příslušné orgány."
                    ]
                ),

                GuideArticleSection(
                    id: "radiation-contamination",
                    title: "Kontaminace",
                    paragraphs: [
                        "Radioaktivní kontaminace znamená přítomnost radioaktivních látek například na oblečení, pokožce nebo předmětech.",
                        "Pokud jste byli venku v době možného spadu, další postup se řídí pokyny záchranných složek."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin / HZS ČR",
            sourceURL: "https://www.72h.gov.cz/cs/ukryt"
        ),

        // MARK: - POŽÁR

        GuideTopic(
            id: "fire",
            title: "Požár",
            subtitle: "Jak postupovat při požáru",
            symbolName: "flame.fill",

            sections: [
                GuideSection(
                    id: "fire-first",
                    title: "Při požáru",
                    items: [
                        "Zachovejte klid a rychle vyhodnoťte únikovou cestu.",
                        "Varujte ostatní osoby.",
                        "Volejte 150 nebo 112.",
                        "Při silném zakouření zbytečně neriskujte.",
                        "Nepoužívejte běžný výtah.",
                        "Do hořícího objektu se nevracejte."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "fire-small",
                    title: "Požár v počáteční fázi",
                    paragraphs: [
                        "Malý požár lze někdy uhasit hasicím přístrojem, hasicím sprejem, dekou nebo jiným vhodným prostředkem.",
                        "Do hašení se nepouštějte, pokud byste tím ohrozili sebe nebo si odřízli únikovou cestu."
                    ]
                ),

                GuideArticleSection(
                    id: "fire-oil",
                    title: "Hořící olej",
                    paragraphs: [
                        "Hořící olej na pánvi nikdy nehaste vodou.",
                        "Pokud je to bezpečné, vypněte zdroj tepla a plameny uduste vhodnou poklicí nebo prostředkem určeným k hašení."
                    ]
                ),

                GuideArticleSection(
                    id: "fire-smoke",
                    title: "Kouř",
                    paragraphs: [
                        "Při požáru představují velmi vážné nebezpečí zplodiny hoření.",
                        "V zakouřeném prostoru se pohybujte co nejníže při zemi, protože kouř se zpočátku hromadí u stropu."
                    ]
                ),

                GuideArticleSection(
                    id: "fire-trapped",
                    title: "Když nemůžete uniknout",
                    paragraphs: [
                        "Pokud je chodba silně zakouřená nebo jsou dveře horké, průchod nemusí být bezpečný.",
                        "Utěsněte dveře proti pronikání kouře, přesuňte se k oknu nebo balkonu a upozorněte na svou polohu."
                    ]
                ),

                GuideArticleSection(
                    id: "fire-prevention",
                    title: "Prevence",
                    paragraphs: [
                        "Nenechávejte vaření ani otevřený oheň bez dozoru.",
                        "Udržujte v pořádku elektroinstalaci, topidla a spalinové cesty.",
                        "Domácí detektor kouře může na vznikající požár upozornit velmi brzy."
                    ]
                )
            ],

            sourceName: "Hasičský záchranný sbor ČR",
            sourceURL: "https://hzscr.gov.cz/clanek/jak-se-vyvarovat-pozaru-v-dome-a-co-delat-v-pripade-jeho-vzniku.aspx"
        ),

        // MARK: - POVODEŇ

        GuideTopic(
            id: "flood",
            title: "Povodeň",
            subtitle: "Co dělat před a během povodně",
            symbolName: "water.waves",

            sections: [
                GuideSection(
                    id: "flood-first",
                    title: "Při ohrožení",
                    items: [
                        "Sledujte pokyny obce a záchranných složek.",
                        "Připravte evakuační zavazadlo.",
                        "Přesuňte se včas do bezpečné oblasti.",
                        "Nevstupujte zbytečně do zatopených míst.",
                        "Nepřibližujte se k rozbouřeným tokům."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "flood-before",
                    title: "Příprava před povodní",
                    paragraphs: [
                        "Zjistěte, zda se vaše bydliště nachází v záplavovém území a jakým způsobem probíhá případná evakuace.",
                        "Vytipujte si bezpečné místo, které nebude zaplaveno, a sledujte vývoj počasí a stav vodních toků."
                    ]
                ),

                GuideArticleSection(
                    id: "flood-house",
                    title: "Ochrana domácnosti",
                    paragraphs: [
                        "Je-li dostatek času, přesuňte cenné věci, potraviny a další vybavení do vyšších míst nebo pater.",
                        "Zabezpečte předměty, které by mohla voda odnést."
                    ]
                ),

                GuideArticleSection(
                    id: "flood-during",
                    title: "Během povodně",
                    paragraphs: [
                        "Dodržujte pokyny povodňových orgánů, policie a záchranářů.",
                        "Nevstupujte do míst, která jsou zatopená, a nepřibližujte se zbytečně k rozbouřeným vodním tokům.",
                        "Pokud hrozí zaplavení místa, kde se nacházíte, přesuňte se včas do bezpečnější oblasti."
                    ]
                ),

                GuideArticleSection(
                    id: "flood-evacuation",
                    title: "Evakuace při povodni",
                    paragraphs: [
                        "Pokud to podmínky dovolují, vypněte přívod elektrické energie, uzavřete plyn a vodu.",
                        "Vezměte evakuační zavazadlo a řiďte se pokyny k přesunu.",
                        "Bezpečnost osob má vždy přednost před ochranou majetku."
                    ]
                ),

                GuideArticleSection(
                    id: "flood-return",
                    title: "Po povodni",
                    paragraphs: [
                        "Do domu se vracejte až tehdy, když je to bezpečné.",
                        "Poškozená elektroinstalace, plyn, konstrukce nebo kontaminovaná voda mohou představovat další nebezpečí i poté, co voda opadne."
                    ]
                )
            ],

            sourceName: "Hasičský záchranný sbor ČR",
            sourceURL: "https://hzscr.gov.cz/hasicien/docDetail.aspx?docid=21656440"
        ),

        // MARK: - BLACKOUT

        GuideTopic(
            id: "blackout",
            title: "Výpadek elektřiny",
            subtitle: "Jak zvládnout delší blackout",
            symbolName: "bolt.slash.fill",

            sections: [
                GuideSection(
                    id: "blackout-first",
                    title: "První kroky",
                    items: [
                        "Zjistěte, zda jde jen o problém ve vaší domácnosti.",
                        "Zkontrolujte jističe.",
                        "Při větším výpadku odpojte elektrické spotřebiče.",
                        "Používejte telefon úsporně.",
                        "Lednici a mrazák otevírejte co nejméně.",
                        "Mějte připravenou svítilnu, rádio a hotovost."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "blackout-check",
                    title: "Je problém jen u vás?",
                    paragraphs: [
                        "Nejdříve ověřte, zda fungují ostatní světla a spotřebiče a zda nevypadl jistič.",
                        "Podívejte se, zda mají elektřinu okolní byty nebo domy."
                    ]
                ),

                GuideArticleSection(
                    id: "blackout-grid",
                    title: "Když je výpadek rozsáhlý",
                    paragraphs: [
                        "Rozsáhlý výpadek může postupně ovlivnit mobilní sítě, internet, obchody, platební terminály, bankomaty, čerpací stanice a další služby.",
                        "Proto je užitečné mít doma zásoby vody, jídla, hotovost, rádio, svítilnu a nabitou powerbanku."
                    ]
                ),

                GuideArticleSection(
                    id: "blackout-phone",
                    title: "Mobilní telefon",
                    paragraphs: [
                        "Telefon používejte jen v nutných případech a omezte datovou komunikaci.",
                        "Mobilní síť může být přetížená a záložní zdroje vysílačů mají omezenou výdrž."
                    ]
                ),

                GuideArticleSection(
                    id: "blackout-fridge",
                    title: "Lednice a mrazák",
                    paragraphs: [
                        "Dveře lednice a mrazáku otevírejte co nejméně.",
                        "Při tání kontrolujte okolí spotřebičů kvůli unikající vodě.",
                        "Rozmrazené potraviny zbytečně znovu nezamrazujte bez předchozí tepelné úpravy."
                    ]
                ),

                GuideArticleSection(
                    id: "blackout-cooking",
                    title: "Vaření",
                    paragraphs: [
                        "Je vhodné mít zásoby jídla, které není nutné tepelně upravovat.",
                        "Alternativní vařič nebo gril používejte bezpečně a způsobem odpovídajícím konkrétnímu zařízení. Zařízení produkující spaliny nepoužívejte nevhodným způsobem v uzavřeném prostoru."
                    ]
                ),

                GuideArticleSection(
                    id: "blackout-heat",
                    title: "Zima",
                    paragraphs: [
                        "Při výpadku topení soustřeďte domácnost pokud možno do jedné místnosti.",
                        "Používejte vrstvy oblečení, přikrývky a omezte únik tepla okny a dveřmi."
                    ]
                ),

                GuideArticleSection(
                    id: "blackout-money",
                    title: "Hotovost",
                    paragraphs: [
                        "Při výpadku nemusí fungovat platební terminály ani bankomaty.",
                        "Je proto užitečné mít doma přiměřenou rezervu hotovosti v různých hodnotách."
                    ]
                ),

                GuideArticleSection(
                    id: "blackout-return",
                    title: "Když se elektřina obnoví",
                    paragraphs: [
                        "Zkontrolujte spotřebiče a osvětlení.",
                        "Ujistěte se, že nezůstal zapnutý sporák nebo jiné zařízení, které by mohlo být nebezpečné.",
                        "Zkontrolujte stav potravin v lednici a mrazáku."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin",
            sourceURL: "https://www.72h.gov.cz/cs/bez-elektriny"
        ),

        // MARK: - DĚTI

        GuideTopic(
            id: "children",
            title: "Děti",
            subtitle: "Jak dětem pomoci zvládnout krizovou situaci",
            symbolName: "figure.2.and.child.holdinghands",

            sections: [
                GuideSection(
                    id: "children-first",
                    title: "Jak s dětmi mluvit",
                    items: [
                        "Mluvte jednoduše a přiměřeně věku.",
                        "Odpovídejte na jejich otázky.",
                        "Dejte jim prostor říct, čeho se bojí.",
                        "Snažte se zachovat klid.",
                        "Pokud je to možné, udržujte běžný režim."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "children-explain",
                    title: "Vysvětlujte, co se děje",
                    paragraphs: [
                        "Dítě potřebuje situaci chápat v rozsahu odpovídajícím jeho věku.",
                        "Nesnažte se předstírat, že se nic neděje. Jednoduché a pravdivé vysvětlení bývá užitečnější než nejistota."
                    ]
                ),

                GuideArticleSection(
                    id: "children-emotions",
                    title: "Emoce",
                    paragraphs: [
                        "Děti často velmi silně vnímají emoce dospělých.",
                        "Dejte jim prostor mluvit o strachu a dalších pocitech a jejich obavy nezlehčujte."
                    ]
                ),

                GuideArticleSection(
                    id: "children-routine",
                    title: "Režim",
                    paragraphs: [
                        "Pokud situace dovoluje, zachovejte známé prvky běžného dne.",
                        "Jídlo, spánek, hra a kontakt s blízkými mohou dítěti pomoci získat pocit jistoty."
                    ]
                ),

                GuideArticleSection(
                    id: "children-evacuation",
                    title: "Evakuace s dítětem",
                    paragraphs: [
                        "Malému dítěti připravte kartičku s adresou a kontaktem na blízkou osobu.",
                        "Do evakuačního zavazadla přibalte malou oblíbenou hračku nebo jiný známý předmět."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin",
            sourceURL: "https://www.72h.gov.cz/cs/deti"
        ),

        // MARK: - ZVÍŘATA

        GuideTopic(
            id: "pets",
            title: "Zvířata",
            subtitle: "Evakuace a péče o domácí zvířata",
            symbolName: "pawprint.fill",

            sections: [
                GuideSection(
                    id: "pets-first",
                    title: "Připravte",
                    items: [
                        "Krmivo a vodu.",
                        "Misky.",
                        "Pravidelně užívané léky.",
                        "Dokumentaci zvířete.",
                        "Vodítko, náhubek nebo přepravku."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "pets-preparation",
                    title: "Příprava předem",
                    paragraphs: [
                        "Mějte vybavení pro zvíře na jednom známém místě, abyste je nemuseli při evakuaci hledat.",
                        "Do zásob zahrňte jeho běžné krmivo, vodu, léky, misky a potřebnou dokumentaci."
                    ]
                ),

                GuideArticleSection(
                    id: "pets-transport",
                    title: "Bezpečný přesun",
                    paragraphs: [
                        "Psa mějte pod kontrolou na vodítku a podle potřeby použijte náhubek.",
                        "Kočku a další vhodná zvířata přepravujte v bezpečné přepravce."
                    ]
                ),

                GuideArticleSection(
                    id: "pets-stress",
                    title: "Stres zvířete",
                    paragraphs: [
                        "I běžně klidné zvíře se může v hlučném a neznámém prostředí chovat jinak.",
                        "Proto ho mějte pod kontrolou a dávejte pozor na možnost úniku."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin",
            sourceURL: "https://www.72h.gov.cz/cs/evakuace"
        ),

        // MARK: - PRVNÍ POMOC

        GuideTopic(
            id: "first-aid",
            title: "První pomoc",
            subtitle: "Základní postupy při ohrožení zdraví",
            symbolName: "cross.case.fill",

            sections: [
                GuideSection(
                    id: "first-aid-fast",
                    title: "Základní pravidlo",
                    items: [
                        "Při ohrožení života volejte 155.",
                        "Zkontrolujte reakci a dýchání postiženého.",
                        "Pokud nedýchá normálně, zahajte stlačování hrudníku.",
                        "Silné krvácení zastavujte přímým tlakem do rány.",
                        "Dbejte také na vlastní bezpečnost."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "first-aid-response",
                    title: "Reakce a dýchání",
                    paragraphs: [
                        "Oslovte postiženého a opatrně s ním zatřeste za ramena.",
                        "Pokud nereaguje, zprůchodněte dýchací cesty záklonem hlavy a přizvednutím brady a zkontrolujte dýchání."
                    ]
                ),

                GuideArticleSection(
                    id: "first-aid-call",
                    title: "Volejte 155",
                    paragraphs: [
                        "Při vážném stavu volejte zdravotnickou záchrannou službu na čísle 155.",
                        "Operátor vás může dalším postupem provést. Hovor neukončujte jako první."
                    ]
                ),

                GuideArticleSection(
                    id: "first-aid-cpr",
                    title: "Stlačování hrudníku",
                    paragraphs: [
                        "Pokud postižený nereaguje a nedýchá normálně, zahajte stlačování hrudníku.",
                        "Oficiální doporučení 72 hodin uvádí frekvenci 100 až 120 stlačení za minutu a hloubku přibližně 5 až 6 centimetrů u dospělého."
                    ]
                ),

                GuideArticleSection(
                    id: "first-aid-bleeding",
                    title: "Silné krvácení",
                    paragraphs: [
                        "Přiložte obvaz nebo čistou látku přímo na ránu a pevně tlačte.",
                        "Pokud je dostupná ochrana rukou, použijte jednorázové rukavice."
                    ]
                ),

                GuideArticleSection(
                    id: "first-aid-kit",
                    title: "Co mít v lékárničce",
                    paragraphs: [
                        "Oficiální doporučení zahrnuje pravidelně užívané léky, léky proti bolesti, horečce a průjmu, obvazy, náplasti, dezinfekci, jednorázové rukavice, škrtidlo, záchranářskou fólii, respirátory, teploměr, pinzetu a nůžky."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin",
            sourceURL: "https://www.72h.gov.cz/cs/prvni-pomoc"
        ),

        // MARK: - INFORMACE A KOMUNIKACE

        GuideTopic(
            id: "information",
            title: "Informace a komunikace",
            subtitle: "Jak získávat spolehlivé informace",
            symbolName: "antenna.radiowaves.left.and.right",

            sections: [
                GuideSection(
                    id: "information-fast",
                    title: "V krizi",
                    items: [
                        "Sledujte především oficiální zdroje.",
                        "Mějte rádio na baterie.",
                        "Šetřete baterii telefonu.",
                        "Zbytečně netelefonujte.",
                        "Nesdílejte neověřené informace."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "information-sources",
                    title: "Důvěryhodné zdroje",
                    paragraphs: [
                        "V krizové situaci používejte především informace státních institucí, krajů, obcí, policie, hasičů, zdravotnické záchranné služby a veřejnoprávních médií.",
                        "Lokálně mohou být důležité také obecní rozhlasy a oficiální informační aplikace obce."
                    ]
                ),

                GuideArticleSection(
                    id: "information-blackout",
                    title: "Když nefunguje internet",
                    paragraphs: [
                        "Rádio na baterie je důležitou zálohou pro situaci, kdy přestane fungovat internet nebo mobilní síť.",
                        "Telefonní čísla blízkých je vhodné mít uložená také na papíře."
                    ]
                ),

                GuideArticleSection(
                    id: "information-phone",
                    title: "Telefon",
                    paragraphs: [
                        "Telefon používejte v krizové situaci úsporně.",
                        "Zbytečné hovory mohou přetěžovat mobilní síť a zároveň rychle vybíjet baterii."
                    ]
                ),

                GuideArticleSection(
                    id: "information-rumours",
                    title: "Fámy a neověřené zprávy",
                    paragraphs: [
                        "V krizových situacích se mohou velmi rychle šířit nepravdivé nebo neúplné informace.",
                        "Než informaci předáte dál, ověřte ji z důvěryhodného zdroje. Zvláštní pozornost věnujte senzačním tvrzením bez jasného původu."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin",
            sourceURL: "https://www.72h.gov.cz/cs/informace-komunikace"
        ),

        // MARK: - NOUZOVÉ ZÁSOBY

        GuideTopic(
            id: "home-supplies",
            title: "Nouzové zásoby",
            subtitle: "Co mít doma připravené na prvních 72 hodin",
            symbolName: "shippingbox.fill",

            sections: [
                GuideSection(
                    id: "home-supplies-first",
                    title: "Základ",
                    items: [
                        "Mějte doma zásobu pitné vody a trvanlivého jídla.",
                        "Připravte lékárničku a potřebné léky.",
                        "Mějte rádio a svítilnu na baterie.",
                        "Připravte hotovost, powerbanku a náhradní baterie.",
                        "Počítejte i s hygienou, vařením, zvířaty a specifickými potřebami členů domácnosti."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "home-supplies-why",
                    title: "Proč zásoby potřebujeme",
                    paragraphs: [
                        "Při větší krizové situaci mohou být dočasně omezené dodávky vody, elektřiny a tepla. Nemusí fungovat internet, mobilní sítě, obchody, platební terminály, čerpací stanice ani veřejná doprava.",
                        "Český koncept 72 hodin počítá s tím, že domácnost zvládne první tři dny s tím, co má připravené doma, aby záchranné složky mohly přednostně pomáhat lidem v bezprostředním ohrožení."
                    ]
                ),

                GuideArticleSection(
                    id: "home-supplies-priority",
                    title: "Co má nejvyšší prioritu",
                    paragraphs: [
                        "Začněte vodou, jídlem, léky a možností získat informace. Dále se hodí svítilna, rádio na baterie, nabitá powerbanka, hotovost, hygienické potřeby a prostředky pro bezpečné vaření.",
                        "Zásoby přizpůsobte počtu lidí, dětem, zvířatům, zdravotním potřebám a podmínkám ve vašem bydlišti."
                    ]
                ),

                GuideArticleSection(
                    id: "home-supplies-bag",
                    title: "Domácí zásoby nejsou evakuační zavazadlo",
                    paragraphs: [
                        "Domácí zásoby jsou určené pro situaci, kdy zůstáváte doma bez běžných služeb. Evakuační zavazadlo je naopak omezený soubor věcí, které vezmete s sebou při rychlém opuštění domácnosti.",
                        "Je praktické mít obě věci připravené odděleně."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin",
            sourceURL: "https://www.72h.gov.cz/cs/nouzove-zasoby"
        ),

        // MARK: - VODA A HYGIENA

        GuideTopic(
            id: "water-hygiene",
            title: "Voda a hygiena",
            subtitle: "Jak zvládnout výpadek vody a nefunkční toaletu",
            symbolName: "drop.fill",

            sections: [
                GuideSection(
                    id: "water-hygiene-first",
                    title: "Když voda neteče",
                    items: [
                        "K pití používejte bezpečnou pitnou vodu podle pokynů dodavatele nebo úřadů.",
                        "Mějte doma balenou vodu a uzavíratelné nádoby pro případný odběr z cisteren.",
                        "Vodu používejte úsporně a oddělte zásobu na pití od ostatní spotřeby.",
                        "Na hygienu rukou lze při výpadku vody použít dezinfekci.",
                        "Pokud toaleta nefunguje, použijte nouzové řešení s odpadkovými pytli."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "water-hygiene-supply",
                    title: "Kolik vody připravit",
                    paragraphs: [
                        "České doporučení uvádí, že nouzově si dospělý člověk vystačí přibližně se dvěma litry pitné vody denně.",
                        "Celková potřeba je vyšší, pokud započítáme vaření a osobní hygienu. Proto je vhodné mít kromě balené vody také kanystry nebo jiné uzavíratelné nádoby pro případný odběr vody."
                    ]
                ),

                GuideArticleSection(
                    id: "water-hygiene-toilet",
                    title: "Nouzová toaleta",
                    paragraphs: [
                        "Při výpadku vody se nádržka běžné toalety po spláchnutí nemusí znovu naplnit.",
                        "Oficiální české doporučení jako nouzové řešení uvádí vložit do záchodové mísy odpadkový pytel a do něj savý materiál, například toaletní papír, noviny nebo kočkolit. Po použití pytel pečlivě zavažte, vložte do dalších dvou pytlů a zlikvidujte podle aktuálních místních pokynů."
                    ]
                ),

                GuideArticleSection(
                    id: "water-hygiene-hands",
                    title: "Hygiena rukou",
                    paragraphs: [
                        "Pokud není voda dostupná, používejte dezinfekci na ruce a šetřete pitnou vodu pro pití a přípravu jídla.",
                        "Mějte připravené hygienické potřeby, toaletní papír, odpadkové pytle a potřeby specifické pro členy domácnosti."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin",
            sourceURL: "https://www.72h.gov.cz/cs/voda"
        ),

        // MARK: - TEPLO A VAŘENÍ

        GuideTopic(
            id: "heat-cooking",
            title: "Teplo a vaření",
            subtitle: "Jak zvládnout výpadek topení a vařit bez elektřiny",
            symbolName: "thermometer.medium",

            sections: [
                GuideSection(
                    id: "heat-cooking-first",
                    title: "Při výpadku",
                    items: [
                        "Soustřeďte domácnost pokud možno do jedné místnosti.",
                        "Používejte vrstvy oblečení, deky a spacáky.",
                        "Omezte zbytečné úniky tepla okny a dveřmi.",
                        "Mějte jídlo, které lze sníst bez tepelné úpravy.",
                        "Alternativní vařiče používejte pouze způsobem určeným výrobcem a s dostatečným větráním."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "heat-cooking-warm",
                    title: "Jak udržet teplo",
                    paragraphs: [
                        "Pokud přestane fungovat vytápění, zmenšete prostor, který potřebujete udržovat v teple. Zavřete dveře do nepoužívaných místností a soustřeďte se do jedné místnosti.",
                        "Používejte více vrstev oblečení, čepici, teplé ponožky, deky nebo spacáky."
                    ]
                ),

                GuideArticleSection(
                    id: "heat-cooking-safe",
                    title: "Bezpečné alternativní vaření",
                    paragraphs: [
                        "Plynové vařiče, grily a další zařízení spalující palivo mohou vytvářet oxid uhelnatý a další spaliny. Používejte je jen v prostředí a způsobem, který výslovně dovoluje výrobce.",
                        "Zařízení určené pouze pro venkovní použití nepoužívejte v bytě, sklepě, garáži ani jiném uzavřeném prostoru."
                    ]
                ),

                GuideArticleSection(
                    id: "heat-cooking-food",
                    title: "Jídlo bez vaření",
                    paragraphs: [
                        "Část zásob by měla být použitelná i bez vaření, například trvanlivé pečivo, konzervy, hotová jídla nebo jiné potraviny, které běžně jíte a snášíte.",
                        "Při plánování počítejte také s vodou potřebnou pro přípravu jídla."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin / norské DSB",
            sourceURL: "https://www.72h.gov.cz/cs/bez-elektriny"
        ),

        // MARK: - SOUSEDSKÁ POMOC

        GuideTopic(
            id: "neighbours",
            title: "Sousedská pomoc",
            subtitle: "Jak si v krizi pomáhat v okolí",
            symbolName: "person.2.fill",

            sections: [
                GuideSection(
                    id: "neighbours-first",
                    title: "Myslete na okolí",
                    items: [
                        "Zjistěte, kdo ve vašem okolí může potřebovat pomoc.",
                        "Pomozte s předáváním důležitých informací.",
                        "Podle možností pomozte s nákupem, vodou nebo přesunem.",
                        "Sdílejte vybavení a zásoby jen tehdy, pokud tím neohrozíte vlastní domácnost.",
                        "V naléhavých případech přivolejte odbornou pomoc."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "neighbours-who",
                    title: "Kdo může potřebovat pomoc",
                    paragraphs: [
                        "Pomoc mohou potřebovat například lidé ve vyšším věku, lidé se zdravotním omezením, rodiny s malými dětmi, nemocní nebo lidé, kteří nerozumějí dobře česky.",
                        "Nejjednodušší je předem se zeptat, zda a s čím by v krizové situaci potřebovali pomoci."
                    ]
                ),

                GuideArticleSection(
                    id: "neighbours-sharing",
                    title: "Co lze sdílet",
                    paragraphs: [
                        "Sousedé si mohou pomoci například s dopravou, získáním vody, nákupem, předáním informací, společným vařením nebo zapůjčením vybavení.",
                        "Předem domluvená spolupráce bývá užitečnější než improvizace ve chvíli, kdy už krize probíhá."
                    ]
                ),

                GuideArticleSection(
                    id: "neighbours-safety",
                    title: "Pomáhejte bezpečně",
                    paragraphs: [
                        "Nevystavujte sebe ani ostatní zbytečnému nebezpečí. Pokud jde o akutní ohrožení života nebo zdraví, přivolejte záchranné složky.",
                        "Respektujte soukromí a přání lidí, kterým nabízíte pomoc."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin",
            sourceURL: "https://www.72h.gov.cz/cs/sousedi"
        ),

        // MARK: - SPECIFICKÉ POTŘEBY

        GuideTopic(
            id: "special-needs",
            title: "Specifické potřeby",
            subtitle: "Příprava při zdravotním omezení nebo závislosti na pomůckách",
            symbolName: "cross.case.fill",

            sections: [
                GuideSection(
                    id: "special-needs-first",
                    title: "Připravte si",
                    items: [
                        "Seznam pravidelně užívaných léků a důležitých kontaktů.",
                        "Potřebné zdravotní pomůcky a spotřební materiál.",
                        "Náhradní baterie nebo jiný způsob napájení pomůcek.",
                        "Papírovou kartičku s informací, jak vám lze pomoci.",
                        "Domluvenou osobu, která ví o vašich potřebách a může vám v krizi pomoci."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "special-needs-plan",
                    title: "Připravte plán podle svých potřeb",
                    paragraphs: [
                        "Zvažte, na čem jste každý den závislí: léky, elektřina, mobilita, komunikace, asistence nebo zdravotnická technika.",
                        "Promyslete alternativu pro případ výpadku elektřiny, vody, internetu nebo běžné pomoci."
                    ]
                ),

                GuideArticleSection(
                    id: "special-needs-card",
                    title: "Papírová karta",
                    paragraphs: [
                        "Může být užitečné mít u sebe papírovou kartu s důležitými zdravotními informacemi, kontakty a stručným popisem toho, jakou pomoc potřebujete.",
                        "Karta může pomoci záchranářům, sousedům nebo jiné osobě, pokud nebude možné vše vysvětlit osobně."
                    ]
                ),

                GuideArticleSection(
                    id: "special-needs-network",
                    title: "Domluvte si pomoc předem",
                    paragraphs: [
                        "Promluvte si s rodinou, přáteli, sousedy nebo asistenty o tom, co budete potřebovat při delším výpadku služeb nebo při evakuaci.",
                        "Pokud využíváte pravidelnou zdravotní či sociální službu, zjistěte si předem, jak může fungovat v mimořádné situaci."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin / norské DSB",
            sourceURL: "https://www.dsb.no/en/Safe-everyday-life/Self-preparedness/Self-preparedness-in-the-event-of-disabilities/"
        ),

        // MARK: - AUTO A MOBILITA

        GuideTopic(
            id: "mobility",
            title: "Auto a mobilita",
            subtitle: "Jak se připravit na omezenou dopravu",
            symbolName: "car.fill",

            sections: [
                GuideSection(
                    id: "mobility-first",
                    title: "Předem",
                    items: [
                        "Udržujte vozidlo provozuschopné a mějte dostatek paliva nebo energie.",
                        "Mějte ve vozidle povinnou a základní nouzovou výbavu.",
                        "Stáhněte si offline mapy a zvažte papírovou mapu.",
                        "Při evakuaci autem zvažte počasí, stav cest a dostupnost paliva.",
                        "V krizi používejte auto jen tehdy, když je to rozumné a bezpečné."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "mobility-readiness",
                    title: "Připravené vozidlo",
                    paragraphs: [
                        "Při rozsáhlejším výpadku nemusí fungovat čerpací stanice nebo nabíjecí infrastruktura. Proto je užitečné nenechávat nádrž nebo baterii dlouhodobě téměř prázdnou.",
                        "Pravidelně kontrolujte technický stav vozidla a mějte dostupnou lékárničku, výstražný trojúhelník a další povinnou či užitečnou výbavu."
                    ]
                ),

                GuideArticleSection(
                    id: "mobility-maps",
                    title: "Offline navigace",
                    paragraphs: [
                        "Mobilní data nebo některé online navigační služby nemusí být dostupné. Předem stažené offline mapy mohou pomoci při orientaci.",
                        "Papírová mapa nebo autoatlas je jednoduchá záloha, která nepotřebuje elektřinu ani datové připojení."
                    ]
                ),

                GuideArticleSection(
                    id: "mobility-crisis",
                    title: "Kdy auto raději nepoužívat",
                    paragraphs: [
                        "Při krizové situaci mohou být cesty blokované nebo potřebné pro záchranné složky. Nevyjíždějte bez důvodu jen proto, abyste se podívali, co se děje.",
                        "Při nařízené evakuaci se řiďte konkrétními pokyny odpovědných orgánů."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin / polský Poradnik bezpieczeństwa",
            sourceURL: "https://www.gov.pl/web/poradnikbezpieczenstwa/przygotuj-swoje-otoczenie"
        ),

        // MARK: - KYBERBEZPEČNOST

        GuideTopic(
            id: "cyber",
            title: "Kyberbezpečnost",
            subtitle: "Jak chránit účty a ověřovat informace",
            symbolName: "lock.shield.fill",

            sections: [
                GuideSection(
                    id: "cyber-first",
                    title: "Základní ochrana",
                    items: [
                        "Používejte unikátní a silná hesla.",
                        "Zapněte vícefaktorové ověřování, kde je dostupné.",
                        "Neotvírejte podezřelé odkazy a přílohy.",
                        "Pravidelně aktualizujte zařízení a aplikace.",
                        "Než krizovou informaci pošlete dál, ověřte její původ."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "cyber-phishing",
                    title: "Phishing a podvodné zprávy",
                    paragraphs: [
                        "Krizové situace mohou zneužívat podvodníci prostřednictvím falešných zpráv, sbírek, výzev k přihlášení nebo údajně naléhavých odkazů.",
                        "Pokud zpráva vyžaduje rychlé zadání hesla, platebních údajů nebo jiných citlivých informací, ověřte si její původ jinou cestou."
                    ]
                ),

                GuideArticleSection(
                    id: "cyber-accounts",
                    title: "Chraňte účty",
                    paragraphs: [
                        "Pro důležité účty používejte různá hesla a tam, kde je to možné, vícefaktorové ověření.",
                        "Aktualizace operačního systému a aplikací opravují také bezpečnostní chyby, proto je zbytečně neodkládejte."
                    ]
                ),

                GuideArticleSection(
                    id: "cyber-information",
                    title: "Ověřujte krizové informace",
                    paragraphs: [
                        "Při mimořádné události sledujte zejména oficiální zdroje státních institucí, obcí, krajů a záchranných složek.",
                        "Pozor na senzační obsah bez jasného zdroje, staré fotografie vydávané za aktuální a zprávy, které vás nutí okamžitě něco sdílet."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin / polský Poradnik bezpieczeństwa",
            sourceURL: "https://www.72h.gov.cz/cs/informace-komunikace"
        ),

        // MARK: - KONTROLA PŘIPRAVENOSTI

        GuideTopic(
            id: "preparedness-review",
            title: "Kontrola připravenosti",
            subtitle: "Jak udržovat zásoby a plán použitelné",
            symbolName: "checklist.checked",

            sections: [
                GuideSection(
                    id: "preparedness-review-first",
                    title: "Pravidelně zkontrolujte",
                    items: [
                        "Datum spotřeby jídla, vody a léků.",
                        "Funkčnost svítilen, rádia a dalšího vybavení.",
                        "Stav baterií a nabití powerbank.",
                        "Kontakty a rodinný krizový plán.",
                        "Vybavení dětí, zvířat a osob se specifickými potřebami."
                    ]
                )
            ],

            articleSections: [
                GuideArticleSection(
                    id: "preparedness-review-when",
                    title: "Jak často",
                    paragraphs: [
                        "Nouzové zásoby nejsou jednorázový nákup. Průběžně je spotřebovávejte a doplňujte tak, aby byly použitelné a odpovídaly aktuální domácnosti.",
                        "Norské DSB doporučuje projít domácí připravenost nejméně jednou ročně. V praxi je vhodné kontrolu udělat také po změně léků, přestěhování, narození dítěte nebo jiné významné změně domácnosti."
                    ]
                ),

                GuideArticleSection(
                    id: "preparedness-review-test",
                    title: "Vybavení také vyzkoušejte",
                    paragraphs: [
                        "Nestačí vědět, že rádio nebo vařič vlastníte. Ověřte, že víte, jak je použít, že fungují a že máte správné baterie nebo palivo.",
                        "Jednoduché vyzkoušení předem může odhalit chybějící kabel, vybitou baterii nebo jiný problém, který by v krizi zbytečně komplikoval situaci."
                    ]
                ),

                GuideArticleSection(
                    id: "preparedness-review-plan",
                    title: "Aktualizujte plán",
                    paragraphs: [
                        "Zkontrolujte telefonní čísla, místa setkání a osoby, které mají v rodině konkrétní úkoly.",
                        "Plán by měl odpovídat skutečným možnostem domácnosti a měl by mu rozumět každý, kdo jej může potřebovat."
                    ]
                )
            ],

            sourceName: "Ministerstvo vnitra ČR – 72 hodin / norské DSB",
            sourceURL: "https://www.dsb.no/en/Safe-everyday-life/Self-preparedness/Plan-your-self-preparedness/"
        )

    ]
}
