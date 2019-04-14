/*
 * Author: Alwarren
   Changed: Psycho
 
 * Re-Add first aid and Medikits.
 
 * Arguments:
	0: Unit (Object)
	
 * Example:
	[player] call AIS_System_fnc_restoreFaks;
 
 * Return value:
	-
*/

params ["_unit"];
private _items = _unit getVariable ["AIS_MedicalStore", [0,0,0,0,0,0,0,0,0,0,0]];


for "_i" from 1 to (_items select 0) do {_unit addItemToUniform "FirstAidKit"};
for "_i" from 1 to (_items select 1) do {_unit addItemToUniform "OPTRE_Biofoam"};
for "_i" from 1 to (_items select 2) do {_unit addItemToUniform "OPTRE_Medigel"};

for "_i" from 1 to (_items select 3) do {_unit addItemToVest "FirstAidKit"};	
for "_i" from 1 to (_items select 4) do {_unit addItemToVest "OPTRE_Biofoam"};
for "_i" from 1 to (_items select 5) do {_unit addItemToVest "OPTRE_Medigel"};

for "_i" from 1 to (_items select 6) do {_unit addItemTobackpack "FirstAidKit"};
for "_i" from 1 to (_items select 7) do {_unit addItemTobackpack "OPTRE_Biofoam"};
for "_i" from 1 to (_items select 8) do {_unit addItemTobackpack "OPTRE_Medigel"};

for "_i" from 1 to (_items select 9) do {_unit addItem "Medikit"};
for "_i" from 1 to (_items select 10) do {_unit addItem "OPTRE_MedKit"};

_unit setVariable ["AIS_MedicalStore", [0,0,0,0,0,0,0,0,0,0,0], true];

true