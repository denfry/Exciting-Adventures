// ============================================================
//  Exciting Adventures — «Хроники Бездны»
//  Атмосферные подсказки к ключевым предметам сюжетной кампании.
//  Чистая косметика: на рецепты, баланс и геймплей НЕ влияет.
//  Проверяется при запуске в logs/crafttweaker.log.
// ============================================================

<item:minecraft:nether_star>.addShiftTooltip(
    Component.literal("«Осколок угасшей звезды — и холодное сердце Бездны.»").withStyle(<formatting:dark_purple>),
    Component.literal("[Удерживай SHIFT — Хроники Бездны]").withStyle(<formatting:dark_gray>)
);

<item:minecraft:echo_shard>.addTooltip(
    Component.literal("Эхо шепчет именами тех, кого поглотила глубина.").withStyle(<formatting:dark_aqua>)
);

<item:minecraft:heart_of_the_sea>.addTooltip(
    Component.literal("В нём бьётся пульс затонувших чертогов Бездны.").withStyle(<formatting:blue>)
);

<item:minecraft:totem_of_undying>.addTooltip(
    Component.literal("Ещё один вдох вопреки воле Бездны.").withStyle(<formatting:gold>)
);

<item:waystones:warp_stone>.addTooltip(
    Component.literal("Камень, что помнит дорогу домой из любой тьмы.").withStyle(<formatting:aqua>)
);

<item:naturescompass:naturescompass>.addTooltip(
    Component.literal("Стрелка тянется туда, где мир ещё не сломлен.").withStyle(<formatting:green>)
);

<item:simplyswords:arcanethyst>.addShiftTooltip(
    Component.literal("Кристалл, в котором спит чужая, древняя сила.").withStyle(<formatting:light_purple>),
    Component.literal("[Удерживай SHIFT — Хроники Бездны]").withStyle(<formatting:dark_gray>)
);
