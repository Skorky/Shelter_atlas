//
//  FirstAidExtendedContent.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import Foundation

enum FirstAidExtendedContent {

    static let topics: [FirstAidTopic] = [

        // MARK: - Dítě nedýchá

        FirstAidTopic(
            id: "child-cpr",
            title: "Dítě nedýchá normálně",
            subtitle: "Resuscitace dítěte do puberty",
            symbolName: "figure.child",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Zkontrolujte bezpečnost místa.",
                "Oslovte dítě a zjistěte, zda reaguje.",
                "Pokud nereaguje, uvolněte dýchací cesty a zkontrolujte dýchání.",
                "Pokud nedýchá normálně, proveďte 5 úvodních vdechů.",
                "Zahajte stlačování hrudníku.",
                "Stlačujte frekvencí 100–120 za minutu.",
                "Pokud znáte dětskou resuscitaci, pokračujte v poměru 15 stlačení ku 2 vdechům.",
                "Je-li přítomen další zachránce, volejte 155 ihned. Jste-li sami, podle standardu nejprve přibližně 1 minutu resuscitujte a poté volejte 155.",
                "Pokračujte do příjezdu zdravotnické záchranné služby nebo dokud dítě nezačne reagovat a normálně dýchat."
            ],
            warnings: [
                "Dětská resuscitace zahrnuje umělé dýchání.",
                "Pokud nejste vyškoleni v dětské resuscitaci, postupujte jako při resuscitaci dospělého a řiďte se operátorem 155.",
                "Odstraňujte pouze překážku v ústech, kterou skutečně vidíte."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "child-cpr-recognition",
                    title: "Jak poznat závažný stav",
                    paragraphs: [
                        "Dítě nereaguje a nedýchá normálně nebo nedýchá vůbec.",
                        "Mohou se objevit změny barvy kůže nebo sliznic.",
                        "Při pochybnostech, zda dítě dýchá normálně, zahajte postup resuscitace."
                    ]
                ),

                FirstAidArticleSection(
                    id: "child-cpr-breaths",
                    title: "Pět úvodních vdechů",
                    paragraphs: [
                        "Po uvolnění dýchacích cest proveďte pět úvodních vdechů.",
                        "Vdechujte pouze tolik vzduchu, aby bylo patrné zvednutí hrudníku.",
                        "Pokud vdech nejde provést, zkontrolujte polohu hlavy a pouze viditelnou překážku v ústech."
                    ]
                ),

                FirstAidArticleSection(
                    id: "child-cpr-compressions",
                    title: "Stlačování hrudníku",
                    paragraphs: [
                        "Stlačujte dolní část hrudní kosti jednou nebo oběma rukama podle velikosti dítěte.",
                        "Hloubka stlačení má být přibližně jedna třetina předozadního průměru hrudníku, zhruba 5 cm u dítěte.",
                        "Frekvence je 100–120 stlačení za minutu."
                    ]
                ),

                FirstAidArticleSection(
                    id: "child-cpr-ratio",
                    title: "Stlačení a vdechy",
                    paragraphs: [
                        "Aktuální standard ČČK pro dětskou resuscitaci uvádí poměr 15 stlačení ku 2 vdechům.",
                        "Člověk bez speciálního tréninku v resuscitaci dětí má postupovat stejně jako při resuscitaci dospělého.",
                        "Operátor linky 155 vás může konkrétní situací provést."
                    ]
                )
            ],
            sourceName: "Český červený kříž – Standardy první pomoci, změny platné od 1. 1. 2026",
            sourceURL: "https://www.cervenykriz.eu/files/files/cz/standardy/standardy-prvni-pomoci-2023-ZL2026.pdf"
        ),

        // MARK: - Kojenec nedýchá

        FirstAidTopic(
            id: "infant-cpr",
            title: "Kojenec nedýchá normálně",
            subtitle: "Resuscitace dítěte do 1 roku",
            symbolName: "figure.and.child.holdinghands",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Zkontrolujte bezpečnost místa.",
                "Zjistěte, zda kojenec reaguje a normálně dýchá.",
                "Hlavu držte spíše v neutrální poloze bez výrazného záklonu.",
                "Pokud nedýchá normálně, proveďte 5 úvodních vdechů přes ústa i nos.",
                "Zahajte stlačování dolní části hrudní kosti.",
                "U kojence stlačujte pokud možno dvěma palci s obemknutím hrudníku.",
                "Hloubka stlačení je přibližně jedna třetina hrudníku, asi 4 cm.",
                "Stlačujte frekvencí 100–120 za minutu.",
                "Pokud znáte dětskou resuscitaci, pokračujte v poměru 15:2."
            ],
            warnings: [
                "Přílišný záklon hlavy může u kojence dýchací cesty zhoršit.",
                "Při vdechu použijte jen tolik vzduchu, aby se hrudník viditelně zvedl.",
                "Řiďte se pokyny operátora 155."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "infant-head",
                    title: "Poloha hlavy",
                    paragraphs: [
                        "U kojence se dýchací cesty uvolňují spíše neutrální polohou hlavy.",
                        "Výrazný záklon hlavy může průchodnost dýchacích cest naopak zhoršit."
                    ]
                ),

                FirstAidArticleSection(
                    id: "infant-breaths",
                    title: "Umělé vdechy",
                    paragraphs: [
                        "Zachránce obemkne svými ústy ústa i nos kojence.",
                        "Provede pět úvodních vdechů.",
                        "Vdechuje pouze tolik, aby bylo viditelné zvednutí hrudníku."
                    ]
                ),

                FirstAidArticleSection(
                    id: "infant-compressions",
                    title: "Stlačování hrudníku",
                    paragraphs: [
                        "Aktuální standard doporučuje u kojence stlačování dvěma palci, pokud možno s obemknutím hrudníku.",
                        "Hloubka je přibližně jedna třetina předozadního průměru hrudníku, asi 4 cm.",
                        "Frekvence je 100–120 stlačení za minutu."
                    ]
                )
            ],
            sourceName: "Český červený kříž – Standardy první pomoci, změny platné od 1. 1. 2026",
            sourceURL: "https://www.cervenykriz.eu/files/files/cz/standardy/standardy-prvni-pomoci-2023-ZL2026.pdf"
        ),

        // MARK: - Dušení dítěte

        FirstAidTopic(
            id: "child-choking",
            title: "Dítě se dusí",
            subtitle: "Cizí těleso v dýchacích cestách – nad 1 rok",
            symbolName: "lungs.fill",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Pokud dítě účinně kašle, povzbuzujte ho ke kašli a sledujte jeho stav.",
                "Pokud nemůže kašlat, mluvit, plakat nebo dýchat, předkloňte jej.",
                "Proveďte až 5 úderů dlaní mezi lopatky.",
                "Pokud překážka zůstává, proveďte až 5 stlačení nadbřišku.",
                "Střídejte údery mezi lopatky a stlačení nadbřišku.",
                "Pokud dítě ztratí vědomí, zahajte resuscitaci.",
                "V ústech odstraňujte pouze předmět, který skutečně vidíte."
            ],
            warnings: [
                "Nesahejte naslepo do úst dítěte.",
                "Po použití stlačení nadbřišku má být dítě odborně vyšetřeno.",
                "Po odstranění uzávěru dýchacích cest ČČK doporučuje lékařské vyšetření dítěte."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "child-choking-cough",
                    title: "Pokud dítě kašle",
                    paragraphs: [
                        "Účinný kašel je přirozený mechanismus pro odstranění cizího tělesa.",
                        "Dítě podporujte v kašli a průběžně sledujte, zda se stav nezhoršuje."
                    ]
                ),

                FirstAidArticleSection(
                    id: "child-choking-severe",
                    title: "Pokud nemůže dýchat",
                    paragraphs: [
                        "Proveďte až pět úderů mezi lopatky.",
                        "Pokud se dýchací cesty neuvolní, následuje až pět stlačení nadbřišku.",
                        "Tyto postupy se opakují do odstranění překážky nebo do ztráty vědomí."
                    ]
                ),

                FirstAidArticleSection(
                    id: "child-choking-unconscious",
                    title: "Pokud ztratí vědomí",
                    paragraphs: [
                        "Přejděte okamžitě k dětské resuscitaci.",
                        "Při kontrole úst odstraňujte pouze viditelný předmět.",
                        "Řiďte se pokyny operátora 155."
                    ]
                )
            ],
            sourceName: "Český červený kříž – Standard 2.9 Uzávěr dýchacích cest cizím tělesem",
            sourceURL: "https://www.cervenykriz.eu/files/files/cz/standardy/standardy-prvni-pomoci-2023-ZL2026.pdf"
        ),

        // MARK: - Dušení kojence

        FirstAidTopic(
            id: "infant-choking",
            title: "Kojenec se dusí",
            subtitle: "Cizí těleso v dýchacích cestách – do 1 roku",
            symbolName: "lungs.fill",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Pokud kojenec účinně kašle, pouze jej sledujte.",
                "Pokud nemůže kašlat, plakat nebo dýchat, položte jej obličejem dolů na předloktí a podepřete dolní čelist.",
                "Proveďte až 5 úderů mezi lopatky.",
                "Pokud překážka zůstává, otočte kojence na záda.",
                "Proveďte až 5 stlačení hrudníku jako při resuscitaci.",
                "Střídejte údery mezi lopatky a stlačení hrudníku.",
                "Pokud kojenec ztratí vědomí, zahajte dětskou resuscitaci."
            ],
            warnings: [
                "U kojence se při dušení neprovádějí stlačení nadbřišku.",
                "Nesahejte naslepo do úst.",
                "Po odstranění překážky má být dítě vyšetřeno lékařem."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "infant-choking-cough",
                    title: "Účinný kašel",
                    paragraphs: [
                        "Pokud kojenec dostatečně a účinně kašle, nepoužívejte vypuzovací manévry.",
                        "Neustále jej sledujte, protože stav se může rychle změnit."
                    ]
                ),

                FirstAidArticleSection(
                    id: "infant-choking-back",
                    title: "Údery mezi lopatky",
                    paragraphs: [
                        "Kojence položte hlavou a obličejem dolů na předloktí.",
                        "Podepřete dolní čelist tak, abyste nestlačovali měkké tkáně pod bradou.",
                        "Proveďte až pět výrazných úderů mezi lopatky."
                    ]
                ),

                FirstAidArticleSection(
                    id: "infant-choking-chest",
                    title: "Stlačení hrudníku",
                    paragraphs: [
                        "Pokud překážka zůstává, položte kojence na záda.",
                        "Proveďte až pět stlačení hrudníku jako při resuscitaci.",
                        "Střídejte tento postup s údery mezi lopatky."
                    ]
                )
            ],
            sourceName: "Český červený kříž – Standard 2.9 Uzávěr dýchacích cest cizím tělesem",
            sourceURL: "https://www.cervenykriz.eu/files/files/cz/standardy/standardy-prvni-pomoci-2023-ZL2026.pdf"
        ),

        // MARK: - Otrava

        FirstAidTopic(
            id: "poisoning",
            title: "Podezření na otravu",
            subtitle: "Léky, chemikálie, plyny nebo jiné látky",
            symbolName: "cross.vial.fill",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Nejdříve zajistěte vlastní bezpečnost.",
                "Přerušte další kontakt postiženého s podezřelou látkou, pokud to lze bezpečně.",
                "Pokuste se zjistit, o jakou látku šlo a v jakém množství.",
                "Uchovejte obal, název přípravku nebo jiné informace pro zdravotníky.",
                "Sledujte vědomí a dýchání.",
                "Při závažných příznacích volejte 155.",
                "Při podezření na otravu lze využít také Toxikologické informační středisko."
            ],
            warnings: [
                "Nevyvolávejte zvracení bez konkrétního odborného pokynu.",
                "Při žíravinách se nepokoušejte chemikálii neutralizovat jinou chemikálií.",
                "Nevstupujte do prostoru s neznámým nebo jedovatým plynem, pokud byste ohrozili sami sebe."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "poisoning-identify",
                    title: "Zjistěte látku",
                    paragraphs: [
                        "Průběh otravy závisí na konkrétní látce, množství a způsobu, kterým se dostala do těla.",
                        "Pokud je to možné, připravte obal, název přípravku nebo jiné informace o látce."
                    ]
                ),

                FirstAidArticleSection(
                    id: "poisoning-safety",
                    title: "Chraňte především sebe",
                    paragraphs: [
                        "Při otravě plynem, výparem nebo chemikálií může být ohrožen také zachránce.",
                        "Nevstupujte do nebezpečného prostoru bez odpovídající ochrany."
                    ]
                ),

                FirstAidArticleSection(
                    id: "poisoning-help",
                    title: "Odborná konzultace",
                    paragraphs: [
                        "ČČK uvádí možnost využít Toxikologické informační středisko také pro laickou veřejnost.",
                        "Při poruše vědomí, dýchání nebo jiných závažných příznacích volejte 155."
                    ]
                )
            ],
            sourceName: "Český červený kříž – Standardy první pomoci, část Otravy",
            sourceURL: "https://www.cervenykriz.eu/files/files/cz/standardy/standardy-prvni-pomoci-2023-ZL2026.pdf"
        ),

        // MARK: - Úraz hlavy

        FirstAidTopic(
            id: "head-injury",
            title: "Úraz hlavy",
            subtitle: "Podezření na závažné poranění hlavy",
            symbolName: "brain.fill",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Zkontrolujte bezpečnost a stav postiženého.",
                "Pokud je při vědomí, nechte jej v poloze, která mu vyhovuje, a sledujte jej.",
                "Při poruše vědomí postupujte podle zásad pro bezvědomí.",
                "Při závažném úrazu hlavy volejte 155.",
                "Zajistěte tepelný komfort a zabraňte podchlazení.",
                "Průběžně kontrolujte vědomí a dýchání."
            ],
            warnings: [
                "Varovné jsou porucha vědomí, výpadek paměti, zmatenost, opakované zvracení nebo výrazné zhoršování stavu.",
                "Závažným příznakem může být krvácení z uší nebo nosu či nestejná velikost zornic.",
                "Po úrazu může dojít ke zhoršení i s odstupem."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "head-signs",
                    title: "Varovné příznaky",
                    paragraphs: [
                        "ČČK mezi možné známky závažného poranění hlavy uvádí poruchu vědomí, výpadky paměti, změny chování, zmatenost, nevolnost, zvracení a bolest hlavy.",
                        "Objevit se může také krvácení z uší nebo nosu či nestejná velikost zornic."
                    ]
                ),

                FirstAidArticleSection(
                    id: "head-monitor",
                    title: "Sledování postiženého",
                    paragraphs: [
                        "Postiženého průběžně sledujte a reagujte na případné zhoršení.",
                        "Pokud se objeví porucha vědomí, je prioritou zachování průchodnosti dýchacích cest a kontrola dýchání."
                    ]
                ),

                FirstAidArticleSection(
                    id: "head-small",
                    title: "Menší poranění",
                    paragraphs: [
                        "ČČK uvádí, že u malého poranění hlavy bez poruchy vědomí a bez výpadku paměti může postačit sledování zodpovědnou osobou.",
                        "Při nejistotě nebo zhoršení stavu je vhodné vyhledat odbornou pomoc."
                    ]
                )
            ],
            sourceName: "Český červený kříž – Standard 3.1 Mozkolebeční poranění",
            sourceURL: "https://www.cervenykriz.eu/files/files/cz/standardy/standardy-prvni-pomoci-2023-ZL2026.pdf"
        ),

        // MARK: - Končetiny

        FirstAidTopic(
            id: "limb-injury",
            title: "Zlomenina nebo poranění končetiny",
            subtitle: "Závažné poranění ruky nebo nohy",
            symbolName: "figure.fall",
            emergencyNumber: "155",
            urgent: false,
            steps: [
                "Zkontrolujte bezpečnost.",
                "Zastavte případné závažné krvácení a ošetřete ránu.",
                "Poraněnou končetinu nezatěžujte.",
                "Zbytečně s ní nemanipulujte.",
                "Zkontrolujte prokrvení, citlivost a možnost pohybu.",
                "Při deformitě, poruše prokrvení, otevřené zlomenině nebo jiných závažných příznacích volejte 155.",
                "Nepokoušejte se zlomeninu rovnat ani napravovat kloub."
            ],
            warnings: [
                "Při běžné dostupnosti zdravotnické záchranné služby není rutinní dlahování zlomeniny součástí laické první pomoci.",
                "Zlomeniny dlouhých kostí mohou být spojeny s významným krvácením.",
                "Led nepřikládejte přímo na kůži."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "limb-signs",
                    title: "Známky závažného poranění",
                    paragraphs: [
                        "Varovná je deformita, nepřirozený pohyb, nemožnost končetinu zatížit nebo výrazná ztráta funkce.",
                        "Závažná je také bledá či chladná končetina, otevřená rána nebo silné krvácení."
                    ]
                ),

                FirstAidArticleSection(
                    id: "limb-do-not-move",
                    title: "Omezte pohyb",
                    paragraphs: [
                        "Poraněnou končetinu nezatěžujte a omezte manipulaci na nezbytné minimum.",
                        "Nepokoušejte se zlomeninu narovnávat ani napravovat vykloubený kloub."
                    ]
                ),

                FirstAidArticleSection(
                    id: "limb-minor",
                    title: "Lehčí poranění",
                    paragraphs: [
                        "Pokud nejsou přítomny závažné příznaky, ČČK doporučuje končetinu nezatěžovat, zvednout ji a případně chladit.",
                        "Při použití ledu chlaďte přes tkaninu a souvislé chlazení nemá přesáhnout 20 minut."
                    ]
                )
            ],
            sourceName: "Český červený kříž – Standard 4.2 Poranění končetin",
            sourceURL: "https://www.cervenykriz.eu/files/files/cz/standardy/standardy-prvni-pomoci-2023-ZL2026.pdf"
        )
    ]
}
