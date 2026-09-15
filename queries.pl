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
