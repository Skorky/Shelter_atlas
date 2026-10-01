import Foundation

enum FirstAidContent {

    static let topics: [FirstAidTopic] = [

        // MARK: - Resuscitace

        FirstAidTopic(
            id: "cpr",
            title: "Nedýchá normálně",
            subtitle: "Bezvědomí a resuscitace",
            symbolName: "heart.fill",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Zkontrolujte, zda je místo bezpečné.",
                "Oslovte postiženého a zjistěte, zda reaguje.",
                "Pokud nereaguje a nedýchá nebo nedýchá normálně, volejte 155.",
                "Začněte stlačovat střed hrudníku.",
                "Stlačujte frekvencí 100–120 za minutu.",
                "Je-li dostupný AED, nechte jej přinést, zapněte jej a postupujte podle jeho pokynů.",
                "Pokračujte v resuscitaci do příjezdu zdravotnické záchranné služby."
            ],
            warnings: [
                "Lapavé nebo nepravidelné nádechy nejsou normální dýchání.",
                "Při analýze rytmu nebo výboji AED se postiženého nedotýkejte.",
                "Řiďte se pokyny operátora linky 155."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "cpr-recognition",
                    title: "Jak stav rozpoznat",
                    paragraphs: [
                        "Závažným varovným stavem je člověk, který nereaguje a současně nedýchá nebo nedýchá normálně.",
                        "Za normální dýchání se nepovažují ojedinělé lapavé nebo nepravidelné nádechy.",
                        "Pokud si nejste jistí, volejte linku 155 a popište operátorovi, co vidíte."
                    ]
                ),

                FirstAidArticleSection(
                    id: "cpr-breathing",
                    title: "Kontrola vědomí a dýchání",
                    paragraphs: [
                        "Nejdříve zkontrolujte bezpečnost místa. Postiženého oslovte a ověřte, zda reaguje.",
                        "Pokud nereaguje, zaměřte se na to, zda normálně dýchá.",
                        "Při poruše vědomí a nenormálním dýchání je nutné jednat okamžitě."
                    ]
                ),

                FirstAidArticleSection(
                    id: "cpr-compressions",
                    title: "Stlačování hrudníku",
                    paragraphs: [
                        "Stlačování se provádí na středu hrudníku.",
                        "Doporučená frekvence je 100–120 stlačení za minutu.",
                        "U dospělého se hrudník stlačuje přibližně do hloubky 5–6 cm.",
                        "Mezi jednotlivými stlačeními umožněte hrudníku návrat do původní polohy."
                    ]
                ),

                FirstAidArticleSection(
                    id: "cpr-aed",
                    title: "Pokud je dostupný AED",
                    paragraphs: [
                        "Požádejte dalšího člověka, aby AED přinesl, zatímco pokračujete v resuscitaci.",
                        "Přístroj zapněte a dále postupujte podle jeho hlasových a obrazových pokynů.",
                        "Během analýzy srdečního rytmu ani během výboje se postiženého nikdo nesmí dotýkat."
                    ]
                ),

                FirstAidArticleSection(
                    id: "cpr-until",
                    title: "Jak dlouho pokračovat",
                    paragraphs: [
                        "V resuscitaci pokračujte podle pokynů operátora 155 a AED.",
                        "Pokračujte do převzetí postiženého zdravotnickou záchrannou službou nebo do změny jeho stavu.",
                        "Pokud začne postižený reagovat nebo normálně dýchat, znovu zhodnoťte jeho stav a dále se řiďte pokyny operátora."
                    ]
                )
            ],
            sourceName: "ZZS hl. m. Prahy / Český červený kříž",
            sourceURL: "https://www.zzshmp.cz/prvni-pomoc/bezvedomi-resuscitace/"
        ),

        // MARK: - AED

        FirstAidTopic(
            id: "aed",
            title: "AED",
            subtitle: "Automatizovaný externí defibrilátor",
            symbolName: "bolt.heart.fill",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Pokud postižený nereaguje a nedýchá normálně, volejte 155 a zahajte resuscitaci.",
                "Pošlete někoho pro AED, pokud je dostupný.",
                "AED zapněte.",
                "Nalepte elektrody podle obrázků na elektrodách nebo přístroji.",
                "Během analýzy rytmu se postiženého nedotýkejte.",
                "Pokud AED doporučí výboj, zajistěte, aby se postiženého nikdo nedotýkal.",
                "Po výboji nebo pokynu přístroje ihned pokračujte v resuscitaci."
            ],
            warnings: [
                "Řiďte se pokyny konkrétního AED.",
                "Při analýze a případném výboji se postiženého nesmí nikdo dotýkat."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "aed-what",
                    title: "Co je AED",
                    paragraphs: [
                        "AED je přístroj určený k analýze srdečního rytmu při náhlé zástavě oběhu.",
                        "Přístroj uživatele vede hlasovými nebo obrazovými pokyny.",
                        "Výboj doporučí pouze tehdy, pokud jej podle své analýzy vyhodnotí jako potřebný."
                    ]
                ),

                FirstAidArticleSection(
                    id: "aed-start",
                    title: "Jak začít",
                    paragraphs: [
                        "Nejdříve volejte 155 a zahajte resuscitaci.",
                        "Pokud je přítomen další člověk, pošlete jej pro AED.",
                        "Po přinesení přístroj zapněte a řiďte se jeho pokyny."
                    ]
                ),

                FirstAidArticleSection(
                    id: "aed-pads",
                    title: "Elektrody",
                    paragraphs: [
                        "Elektrody nalepte na hrudník podle obrázků uvedených přímo na elektrodách nebo na přístroji.",
                        "Po nalepení pokračujte podle instrukcí AED."
                    ]
                ),

                FirstAidArticleSection(
                    id: "aed-analysis",
                    title: "Analýza a výboj",
                    paragraphs: [
                        "Během analýzy srdečního rytmu se postiženého nikdo nesmí dotýkat.",
                        "Pokud přístroj doporučí výboj, znovu se ujistěte, že se postiženého nikdo nedotýká.",
                        "Poté postupujte přesně podle pokynů AED."
                    ]
                ),

                FirstAidArticleSection(
                    id: "aed-after",
                    title: "Po výboji",
                    paragraphs: [
                        "Ihned pokračujte v resuscitaci podle instrukcí přístroje.",
                        "Resuscitaci přerušujte pouze tehdy, když to vyžaduje AED nebo operátor linky 155.",
                        "Pokračujte do příjezdu zdravotnické záchranné služby."
                    ]
                )
            ],
            sourceName: "ZZS hl. m. Prahy / Český červený kříž",
            sourceURL: "https://www.zzshmp.cz/prvni-pomoc/automatizovany-externi-defibrilator-aed/"
        ),

        // MARK: - Krvácení

        FirstAidTopic(
            id: "bleeding",
            title: "Silně krvácí",
            subtitle: "Masivní zevní krvácení",
            symbolName: "drop.fill",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Zkontrolujte bezpečnost.",
                "Masivní krvácení zastavujte tlakem přímo do rány.",
                "Volejte 155.",
                "Ránu zakryjte obvazem nebo čistou tkaninou.",
                "Pokračujte podle pokynů operátora 155.",
                "Kontrolujte stav postiženého do příjezdu záchranné služby."
            ],
            warnings: [
                "Masivní krvácení může bezprostředně ohrožovat život.",
                "Pokud jsou dostupné ochranné rukavice, použijte je.",
                "Turniket použijte pouze tehdy, pokud víte, jak jej správně použít."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "bleeding-priority",
                    title: "Proč jednat okamžitě",
                    paragraphs: [
                        "Masivní zevní krvácení patří mezi bezprostředně život ohrožující stavy.",
                        "Jeho zastavení má vysokou prioritu už při prvním zhodnocení postiženého."
                    ]
                ),

                FirstAidArticleSection(
                    id: "bleeding-pressure",
                    title: "Tlak přímo do rány",
                    paragraphs: [
                        "Krvácení zastavujte silným tlakem přímo do rány.",
                        "Je-li to možné, použijte obvaz nebo čistou tkaninu.",
                        "Pokud máte ochranné rukavice, použijte je."
                    ]
                ),

                FirstAidArticleSection(
                    id: "bleeding-bandage",
                    title: "Tlakový obvaz a turniket",
                    paragraphs: [
                        "ZZS uvádí možnost použití tlakového obvazu.",
                        "Turniket může být použit při masivním krvácení, pokud zachránce ví, jak jej správně použít.",
                        "V nejistotě postupujte podle instrukcí operátora linky 155."
                    ]
                ),

                FirstAidArticleSection(
                    id: "bleeding-monitor",
                    title: "Další sledování",
                    paragraphs: [
                        "Po zastavení nebo omezení krvácení kontrolujte stav postiženého.",
                        "Sledujte zejména vědomí a dýchání.",
                        "Při zhoršení stavu znovu informujte operátora 155."
                    ]
                )
            ],
            sourceName: "ZZS hl. m. Prahy / Český červený kříž",
            sourceURL: "https://www.zzshmp.cz/prvni-pomoc/krvaceni/"
        ),

        // MARK: - Dušení

        FirstAidTopic(
            id: "choking",
            title: "Dusí se",
            subtitle: "Náhlé závažné potíže s dýcháním",
            symbolName: "lungs.fill",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Zkontrolujte bezpečnost.",
                "Pokud má postižený závažné potíže s dýcháním, volejte 155.",
                "Pokud má předepsanou vlastní chronickou medikaci pro podobné obtíže, může ji použít podle svého léčebného režimu.",
                "Kontrolujte vědomí a dýchání.",
                "Řiďte se pokyny operátora linky 155.",
                "Pokud přestane reagovat a nedýchá normálně, zahajte resuscitaci."
            ],
            warnings: [
                "Výrazná dušnost může být život ohrožující.",
                "Nepodávejte cizí léky.",
                "Při rychlém zhoršování nečekejte s voláním 155."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "choking-recognition",
                    title: "Závažné potíže s dýcháním",
                    paragraphs: [
                        "Dušnost znamená obtížné nebo nedostatečné dýchání.",
                        "Příčin může být mnoho a bez vyšetření nemusí být možné bezpečně určit, co obtíže způsobilo.",
                        "Při výrazných potížích s dýcháním volejte 155."
                    ]
                ),

                FirstAidArticleSection(
                    id: "choking-medication",
                    title: "Vlastní léky postiženého",
                    paragraphs: [
                        "Pokud má postižený kvůli chronickému onemocnění předepsanou vlastní medikaci pro podobné obtíže, může ji použít podle svého obvyklého doporučeného dávkování.",
                        "Nepoužívejte léky předepsané jiné osobě."
                    ]
                ),

                FirstAidArticleSection(
                    id: "choking-monitor",
                    title: "Kontrola stavu",
                    paragraphs: [
                        "Sledujte vědomí a dýchání.",
                        "Postupujte podle instrukcí operátora 155.",
                        "Při zhoršení stavu znovu volejte 155."
                    ]
                ),

                FirstAidArticleSection(
                    id: "choking-unconscious",
                    title: "Pokud postižený přestane reagovat",
                    paragraphs: [
                        "Pokud postižený nereaguje a nedýchá normálně, přejděte k postupu pro resuscitaci.",
                        "Operátor linky 155 vás může dalším postupem provést."
                    ]
                )
            ],
            sourceName: "ZZS hl. m. Prahy",
            sourceURL: "https://www.zzshmp.cz/prvni-pomoc/dusnost/"
        ),

        // MARK: - Mozková příhoda

        FirstAidTopic(
            id: "stroke",
            title: "Podezření na mrtvici",
            subtitle: "Náhlá porucha řeči, pohybu nebo pokles koutku",
            symbolName: "brain.head.profile",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Zkontrolujte bezpečnost.",
                "Při náhlé poruše řeči, pohybu, poklesu koutku, poruše vidění nebo zmatenosti volejte ihned 155.",
                "Nečekejte, zda se stav sám nezlepší.",
                "Kontrolujte vědomí a dýchání.",
                "Postupujte podle pokynů operátora 155."
            ],
            warnings: [
                "U podezření na cévní mozkovou příhodu je rychlost zásadní.",
                "Ani při částečném zlepšení příznaků neodkládejte odborné vyšetření."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "stroke-signs",
                    title: "Varovné příznaky",
                    paragraphs: [
                        "Mezi možné projevy cévní mozkové příhody patří náhle vzniklá porucha řeči nebo pohybu.",
                        "Dalším příznakem může být pokles koutku, porucha vidění nebo náhlá zmatenost.",
                        "Příznaky mohou vzniknout velmi rychle."
                    ]
                ),

                FirstAidArticleSection(
                    id: "stroke-call",
                    title: "Volejte okamžitě 155",
                    paragraphs: [
                        "Při podezření na mozkovou příhodu nečekejte, zda se stav nezlepší.",
                        "Volejte ihned zdravotnickou záchrannou službu.",
                        "Včasná pomoc může ovlivnit rozsah následků."
                    ]
                ),

                FirstAidArticleSection(
                    id: "stroke-monitor",
                    title: "Do příjezdu záchranné služby",
                    paragraphs: [
                        "Kontrolujte vědomí a dýchání.",
                        "Postupujte podle instrukcí operátora 155.",
                        "Při zhoršení stavu volejte znovu."
                    ]
                )
            ],
            sourceName: "ZZS hl. m. Prahy",
            sourceURL: "https://www.zzshmp.cz/prvni-pomoc/mozkova-prihoda/"
        ),

        // MARK: - Bolest na hrudi

        FirstAidTopic(
            id: "chest-pain",
            title: "Bolest na hrudi",
            subtitle: "Náhle vzniklá bolest na hrudi",
            symbolName: "heart.text.square.fill",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Zkontrolujte bezpečnost.",
                "Při náhle vzniklé bolesti na hrudi volejte 155.",
                "Omezte pohyb postiženého.",
                "Kontrolujte vědomí a dýchání.",
                "Postupujte podle pokynů operátora linky 155.",
                "Při zhoršení stavu volejte znovu 155."
            ],
            warnings: [
                "Neodkládejte volání 155 kvůli vlastní dopravě.",
                "Pokud postižený přestane reagovat a nedýchá normálně, zahajte resuscitaci.",
                "Podávání léků řešte podle pokynů operátora 155 nebo podle vlastní předepsané léčby postiženého."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "chest-recognition",
                    title: "Náhlá bolest na hrudi",
                    paragraphs: [
                        "Náhle vzniklá bolest na hrudi může být známkou závažného zdravotního stavu.",
                        "Bez odborného vyšetření nelze bezpečně určit její příčinu."
                    ]
                ),

                FirstAidArticleSection(
                    id: "chest-call",
                    title: "Volejte 155",
                    paragraphs: [
                        "Při náhle vzniklé bolesti na hrudi volejte zdravotnickou záchrannou službu.",
                        "Postiženého zbytečně fyzicky nezatěžujte a omezte jeho pohyb.",
                        "Postupujte podle instrukcí operátora."
                    ]
                ),

                FirstAidArticleSection(
                    id: "chest-monitor",
                    title: "Kontrola vědomí a dýchání",
                    paragraphs: [
                        "Průběžně sledujte, zda postižený reaguje a normálně dýchá.",
                        "Pokud přestane reagovat a nedýchá normálně, přejděte k resuscitaci."
                    ]
                ),

                FirstAidArticleSection(
                    id: "chest-medicine",
                    title: "Léky",
                    paragraphs: [
                        "ZZS Praha ve svém postupu uvádí možnost podání kyseliny acetylsalicylové po ověření alergie.",
                        "Protože vhodnost podání léku závisí na konkrétní situaci, v aplikaci doporučujeme řídit se pokyny operátora 155 nebo vlastní předepsanou léčbou postiženého."
                    ]
                )
            ],
            sourceName: "ZZS hl. m. Prahy",
            sourceURL: "https://www.zzshmp.cz/prvni-pomoc/bolesti-na-hrudi/"
        ),

        // MARK: - Popáleniny

        FirstAidTopic(
            id: "burn",
            title: "Popálenina",
            subtitle: "Popálení nebo opaření",
            symbolName: "flame.fill",
            emergencyNumber: "155",
            urgent: false,
            steps: [
                "Zkontrolujte bezpečnost.",
                "Dostaňte postiženého z dosahu zdroje tepla, pokud je to bezpečné.",
                "Při větším rozsahu popálení nebo u dítěte volejte 155.",
                "Šetrně odstraňte oděv a předměty, které zadržují teplo, pokud nejsou přilepené k poranění.",
                "Postižené místo lokálně chlaďte čistou chladnou tekoucí vodou.",
                "Zabraňte celkovému prochladnutí postiženého.",
                "Kontrolujte jeho stav."
            ],
            warnings: [
                "Oděv přilepený k poranění nestrhávejte.",
                "Při opaření nesvlékejte horkou tekutinou nasáklý oděv přes hlavu.",
                "Při zhoršení stavu volejte znovu 155."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "burn-safety",
                    title: "Nejdříve bezpečnost",
                    paragraphs: [
                        "Nejdříve ukončete působení zdroje tepla, pokud to lze provést bezpečně.",
                        "Dostaňte postiženého z dosahu tepla."
                    ]
                ),

                FirstAidArticleSection(
                    id: "burn-clothing",
                    title: "Oděv a předměty",
                    paragraphs: [
                        "Šetrně odstraňte předměty, které mohou zadržovat teplo, například prsteny.",
                        "Oděv odstraňujte opatrně.",
                        "Materiál přilepený k popálené tkáni nestrhávejte."
                    ]
                ),

                FirstAidArticleSection(
                    id: "burn-cooling",
                    title: "Chlazení",
                    paragraphs: [
                        "Popálené místo lokálně chlaďte čistou chladnou tekoucí vodou.",
                        "Současně dávejte pozor, aby nedošlo k celkovému prochladnutí postiženého."
                    ]
                ),

                FirstAidArticleSection(
                    id: "burn-emergency",
                    title: "Kdy volat 155",
                    paragraphs: [
                        "ZZS doporučuje volat při větším rozsahu popálení nebo u dětí.",
                        "Pokud si nejste závažností poranění jistí, kontaktujte zdravotnickou záchrannou službu.",
                        "Při zhoršení stavu volejte znovu."
                    ]
                ),

                FirstAidArticleSection(
                    id: "burn-scalding",
                    title: "Opaření",
                    paragraphs: [
                        "Při opaření může oděv nasáklý horkou tekutinou dál předávat teplo.",
                        "ZZS upozorňuje, že takový oděv nemá být při svlékání přetahován přes hlavu, aby nedošlo k dalšímu opaření obličeje."
                    ]
                )
            ],
            sourceName: "ZZS hl. m. Prahy",
            sourceURL: "https://www.zzshmp.cz/prvni-pomoc/popaleniny-opareniny/"
        ),

        // MARK: - Křeče

        FirstAidTopic(
            id: "seizure",
            title: "Záchvat křečí",
            subtitle: "Ochrana postiženého během záchvatu",
            symbolName: "waveform.path.ecg",
            emergencyNumber: "155",
            urgent: true,
            steps: [
                "Zkontrolujte bezpečnost.",
                "Volejte 155.",
                "Zabraňte nekontrolovanému pádu.",
                "Chraňte hlavu postiženého před poraněním.",
                "Po odeznění křečí zkontrolujte vědomí a dýchání.",
                "Pokud postižený nedýchá normálně, zahajte resuscitaci.",
                "Pokud dýchá, sledujte jeho stav do příjezdu zdravotnické záchranné služby."
            ],
            warnings: [
                "Nevkládejte postiženému nic do úst.",
                "Nesnažte se násilím zastavovat křečovité pohyby.",
                "Po záchvatu může být postižený zmatený."
            ],
            articleSections: [

                FirstAidArticleSection(
                    id: "seizure-during",
                    title: "Během křečí",
                    paragraphs: [
                        "Zajistěte bezpečnost okolí postiženého.",
                        "Pokud hrozí nekontrolovaný pád, pokuste se mu zabránit.",
                        "Chraňte hlavu postiženého před nárazy a poraněním."
                    ]
                ),

                FirstAidArticleSection(
                    id: "seizure-mouth",
                    title: "Nic nevkládejte do úst",
                    paragraphs: [
                        "Během záchvatu nevkládejte postiženému nic do úst.",
                        "Nesnažte se násilím otevírat čelist."
                    ]
                ),

                FirstAidArticleSection(
                    id: "seizure-after",
                    title: "Po odeznění křečí",
                    paragraphs: [
                        "Zkontrolujte vědomí a dýchání.",
                        "Postižený může být po záchvatu apatický, zmatený a může se probírat postupně.",
                        "Navažte kontakt klidně a opatrně."
                    ]
                ),

                FirstAidArticleSection(
                    id: "seizure-breathing",
                    title: "Pokud nedýchá normálně",
                    paragraphs: [
                        "Pokud postižený nereaguje a nedýchá normálně, zahajte resuscitaci.",
                        "Pokud je v bezvědomí, ale normálně dýchá, dále postupujte podle instrukcí operátora 155."
                    ]
                ),

                FirstAidArticleSection(
                    id: "seizure-monitor",
                    title: "Další sledování",
                    paragraphs: [
                        "Kontrolujte stav postiženého do příjezdu zdravotnické záchranné služby.",
                        "Při zhoršení stavu znovu volejte 155."
                    ]
                )
            ],
            sourceName: "ZZS hl. m. Prahy",
            sourceURL: "https://www.zzshmp.cz/prvni-pomoc/zachvat-kreci/"
        )
    ]
}
