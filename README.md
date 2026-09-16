<div align="center">

<div style="width: 100%; height: 150px;"></div>

Факультет Программной Инженерии и Компьютерной Техники

</div>

<div align="center">

<div style="width: 100%; height: 200px;"></div>

<div style="font-size: 24pt; font-weight: bold;">Лабораторная работа №1</div>
<br/>
По дисциплине "Системы искусственного интелекта"

</div>

<div style="width: 100%; height: 100px;"></div>

<div align="right">

Выполнил: Снагин Станислав Максимович, P3315
Бондаренко Андрей Владимирович, P3315

Преподователь: Жданов Андрей  

Дмитриевич

</div>

<div style="width: 100%; height: 214px;"></div>

<p align="center" style="margin-bottom: 5px">Университет ИТМО</p>
<p align="center">Санкт-Петербург, 2026</p>

<div style="page-break-before: always;"></div>

## Ход работы

В качестве темы для базы знаний были взяты сущности из компьютерной игры Civilizarion 6. 

#### Листинг программы

```prolog
% Тематика - 6 цивилизация.

% Часть 1

% Основные юниты игры
unit_type(warrior).
unit_type(archer).
unit_type(horseman).
unit_type(catapult).
unit_type(karavella).
unit_type(swordsman).
unit_type(crossbowman).
unit_type(knight).
unit_type(trebuchet).
unit_type(caravel). % Каравелла (лодка из средневековья)
unit_type(scout).
unit_type(builder).
unit_type(settler).
unit_type(rock_band).

% и что они потребляют в качестве ресурсов

unit_resource(swordsman, iron).
unit_resource(horseman, horses).
unit_resource(knight, horses).
unit_resource(knight, iron).
unit_resource(crossbowman, iron).

% Как можно победить
win(score).
win(diplomacy).
win(war).
win(science).
win(culture).
win(religion).

% Эпохи

era(ancient).
era(classical).
era(medieval).
era(renaissance).
era(industrial).
era(modern).
era(information).

% Способности государств (у каждой цивы есть своя способность)

civilization(russia, mother_russia).
civilization(egypt, time_of_the_pyramids).
civilization(china, dynastic_tradition).
civilization(greece, platos_republic).
civilization(persia, satrapies).
civilization(mongolia, mongol_empire).

% Уникальные юниты цивилизации

civ_unit(rome, legion).
civ_unit(egypt, maryannu_chariot_archer).
civ_unit(greece, hoplite).
civ_unit(persia, immortal).
civ_unit(scotland, highlander).
civ_unit(japan, samurai).
civ_unit(russia, cossack).
civ_unit(china, chu_ko_nu).
civ_unit(mongolia, keshig).
civ_unit(zulu, impi).
civ_unit(korea, hwacha).

% Эра юнитов (тут про то, что современная пехота не может быть в средневековье, и тд)

unit_era(warrior, ancient).
unit_era(archer, ancient).
unit_era(scout, ancient).
unit_era(horseman, classical).
unit_era(swordsman, classical).
unit_era(catapult, classical).
unit_era(crossbowman, medieval).
unit_era(knight, medieval).
unit_era(trebuchet, medieval).
unit_era(caravel, renaissance).

% Какие здания открываются после изученных технологий

building_district(barracks, encampment).
building_district(archery_range, encampment).
building_district(stable, encampment).
building_district(lighthouse, harbor).
building_district(shipyard, harbor).
building_district(arena, entertainment_complex).

% Какие технологии открывают юнитов

tech_unit(bronze_working, warrior).
tech_unit(archery, archer).
tech_unit(horseback_riding, horseman).
tech_unit(iron_working, swordsman).
tech_unit(mathematics, catapult).
tech_unit(military_tactics, crossbowman).
tech_unit(chivalry, knight).
tech_unit(machinery, trebuchet).
tech_unit(naval_tradition, trireme).
tech_unit(cartography, caravel).

% 1 Эпохи должны идти по порядку
% era_before(E1, E2)     эпоха E1 наступает раньше E2.

era_before(ancient, classical).
era_before(ancient, medieval).
era_before(ancient, renaissance).
era_before(ancient, industrial).
era_before(ancient, modern).
era_before(ancient, information).

era_before(classical, medieval).
era_before(classical, renaissance).
era_before(classical, industrial).
era_before(classical, modern).
era_before(classical, information).

era_before(medieval, renaissance).
era_before(medieval, industrial).
era_before(medieval, modern).
era_before(medieval, information).

era_before(renaissance, industrial).
era_before(renaissance, modern).
era_before(renaissance, information).

era_before(industrial, modern).
era_before(industrial, information).

era_before(modern, information).

% Правила

% 1 В соотв. с эпохой юнит может быть доступен или нет

unit_available(Unit, Era) :-
    unit_era(Unit, UnitEra),
    \+ era_before(Era, UnitEra).

% 2 Есть ли у цивы уникальный юнит
civ_has_unique_unit(Civ, Unit) :-
    civ_unit(Civ, Unit).

% 3 Является ли юнит военным
is_military_unit(Unit) :-
    unit_type(Unit),
    \+ Unit = settler,
    \+ Unit = builder,
    \+ Unit = rock_band.

% 4 Доступен ли юнит в эпохе и требует ли он ресурсы
advanced_unit_check(Unit, Era, Resource) :-
    unit_available(Unit, Era),
    unit_resource(Unit, Resource).

% 5 Открывает ли технологию 
tech_unlocks_unit(Tech, Unit) :-
    tech_unit(Tech, Unit).

% 6 Доступно ли здание в районе
building_available(District, Building) :-
    building_district(Building, District).
```

```
% Запросы

unit_type(warrior).
civilization(rome, X).
building_type(barracks).
resource_type(iron).
era(medieval).

% Запросы с логическими операторами

% юнит является военным И доступен в классическую эпоху
is_military_unit(Unit), unit_era(Unit, classical).

% юнит требует iron ИЛИ horses
unit_resource(Unit, iron) ; unit_resource(Unit, horses).

% юнит является юнитом, НЕ является строителем, и требует ресурс
unit_type(Unit), \+ Unit = settler, \+ Unit = builder, unit_resource(Unit, _).

% Запросы с переменными

% % Какие юниты доступны в средневековье?
unit_era(Unit, medieval).

% Какие здания строятся на кампусе?
building_district(Building, encampment).


% Какие цивилизации имеют уникальных юнитов?
civ_unit(Civ, Unit).


% Какие технологии открывают осадные юниты?
tech_unit(Tech, Unit), unit_type(Unit).



% Запросы, требующие выполнения правил

% Юнит доступен в промышленной эпохе?
unit_available(Unit, industrial).


% Здание можно построить в harbor?
building_available(harbor, Building).

% % Какие юниты требуют ресурсы и доступны в информацию эпоху?
advanced_unit_check(Unit, information, Resource).

% Какие юниты открываются технологией рыцарство?
tech_unlocks_unit(chivalry, Unit).
```

<div style="page-break-before: always;"></div>

### Proteje

![alt text](<Screenshot 2026-09-15 154651.png>)
![alt text](<Screenshot 2026-09-15 154715.png>)

<div style="page-break-before: always;"></div>

## Вывод

В ходе выполнения лабораторной работы была разработана база знаний на языке Prolog, моделирующая мир стратегии Civilization VI: определены факты о типах юнитов, ресурсах, эпохах, цивилизациях и технологиях, а также реализованы правила проверки доступности юнитов по эпохе, принадлежности к военным типам, связи технологий с юнитами и зданий с районами.