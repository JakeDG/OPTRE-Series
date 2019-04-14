/*
 * Author: Alwarren
 
 * Remove first aid and Medikits
 
 * Arguments:
	0: Unit (Object)
	
 * Example:
	[player] call AIS_System_fnc_removeFaks;
 
 * Return value:
	BOOL - false if items already stored
*/

params ["_unit"];

// Count the number of FAK's and Medikits this unit has
_storage = _unit getVariable ["AIS_MedicalStore", [0,0,0,0,0,0,0,0,0,0,0]];
_storage params ["_fakUni","_bioUni","_medgUni","_fakVest","_bioVest","_medgVest","_fakBackP","_bioBackP","_medgBackP","_medK","_opMedK"];
_numFakUniform = _fakUni;
_numBioUniform = _bioUni;
_numMgelUniform = _medgUni;
_numFaksVest = _fakVest;
_numBioVest = _bioVest;
_numMgelVest = _medgVest;
_numFaksBackpack = _fakBackP;
_numBioBackpack = _bioBackP;
_numMedgBackpack = _medgBackP;
_numMedi = _medK;
_numOpMedi = _opMedK;

// Faks from the uniform
{
	if (_x == "FirstAidKit") then {
		_numFakUniform = _numFakUniform + 1;
		_unit removeItemFromUniform "FirstAidKit";
	};
	if (_x == "OPTRE_Biofoam") then {
		_numBioUniform = _numBioUniform + 1;
		_unit removeItemFromUniform "OPTRE_Biofoam";
	};
	if (_x == "OPTRE_Medigel") then {
		_numMgelUniform = _numMgelUniform + 1;
		_unit removeItemFromUniform "OPTRE_Medigel";
	};
	nil
} count (uniformItems _unit);

// Faks from the vest
{
	if (_x == "FirstAidKit") then {
		_numFaksVest = _numFaksVest + 1;
		_unit removeItemFromVest "FirstAidKit";
	};
	if (_x == "OPTRE_Biofoam") then {
		_numBioVest = _numBioVest + 1;
		_unit removeItemFromVest "OPTRE_Biofoam";
	};
	if (_x == "OPTRE_Medigel") then {
		_numMgelVest = _numMgelVest + 1;
		_unit removeItemFromVest "OPTRE_Medigel";
	};
	nil
} count (vestItems _unit);

// Faks and Medikits from the backpack. Kits can only be in backpack, so we don't search for them anywhere else
{
	if (_x == "FirstAidKit") then {
		_numFaksBackpack = _numFaksBackpack + 1;
		_unit removeItemFromBackpack "FirstAidKit";
	};
	if (_x == "OPTRE_Biofoam") then {
		_numBioBackpack = _numBioBackpack + 1;
		_unit removeItemFromBackpack "OPTRE_Biofoam";
	};
	if (_x == "OPTRE_Medigel") then {
		_numMedgBackpack = _numMedgBackpack + 1;
		_unit removeItemFromBackpack "OPTRE_Medigel";
	};
	if (_x == "OPTRE_MedKit") then {
		_numOpMedi = _numOpMedi + 1;
		_unit removeItemFromBackpack "OPTRE_MedKit";
	};
	if (_x == "Medikit") then {
		_numMedi = _numMedi + 1;
		_unit removeItemFromBackpack "Medikit";
	};
	nil
} count (backpackItems _unit);

// Store the result
_unit setVariable ["AIS_MedicalStore", [_numFakUniform,_numBioUniform,_numMgelUniform, _numFaksVest,_numBioVest,_numMgelVest, _numFaksBackpack, _numBioBackpack,_numMedgBackpack,_numMedi,_numOpMedi], true];

true