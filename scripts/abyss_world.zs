// ============================================================
//  Exciting Adventures — «Хроники Бездны»: отголоски в мире
//  Атмосферные подсказки к предметам, связанным с сюжетными
//  вехами мира (Глубокая Тьма, боссы, финал).
//  Чистая косметика: на рецепты, баланс и лут НЕ влияет.
//  Проверяется при запуске в logs/crafttweaker.log.
// ============================================================

<item:minecraft:sculk_catalyst>.addTooltip(
    Component.literal("Сердце Глубокой Тьмы бьётся даже вырванным из камня.").withStyle(<formatting:dark_aqua>)
);

<item:minecraft:sculk_shrieker>.addTooltip(
    Component.literal("Кричит твоим именем в темноте. Бездна слышит каждый отклик.").withStyle(<formatting:dark_aqua>)
);

<item:minecraft:recovery_compass>.addTooltip(
    Component.literal("Стрелка помнит, где Бездна забрала тебя в прошлый раз.").withStyle(<formatting:dark_purple>)
);

<item:minecraft:wither_skeleton_skull>.addShiftTooltip(
    Component.literal("Три таких черепа на песке душ будят бурю.").withStyle(<formatting:dark_gray>),
    Component.literal("[Удерживай SHIFT — Хроники Бездны]").withStyle(<formatting:dark_gray>)
);

<item:minecraft:dragon_head>.addTooltip(
    Component.literal("Трофей того, кто правил небом конца света.").withStyle(<formatting:light_purple>)
);

<item:minecraft:dragon_breath>.addTooltip(
    Component.literal("Дыхание Края — холодное, как пустота между звёздами.").withStyle(<formatting:light_purple>)
);

<item:minecraft:wither_rose>.addTooltip(
    Component.literal("Цветок растёт там, где ступала Лилит.").withStyle(<formatting:dark_purple>)
);

<item:minecraft:elytra>.addShiftTooltip(
    Component.literal("«Расправь крылья», — сказала она. И в этом была права.").withStyle(<formatting:gold>),
    Component.literal("[Удерживай SHIFT — Хроники Бездны]").withStyle(<formatting:dark_gray>)
);
