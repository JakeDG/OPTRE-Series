// Loadouts for Sabre Team
if (!(local player)) exitWith {};
waitUntil {!isNull player};

_unit = _this select 0;
_unitClass = typeOf _unit;

// Remove all gear from unit
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;


switch (_unitClass) do 
{
	////////////////////////////////
	///// Light Police Loadout //////
	////////////////////////////////
	case "I_officer_F":
	{
		comment "Add containers";
		_unit forceAddUniform "U_B_GEN_Commander_F";
		_unit addItemToUniform "OPTRE_Biofoam";
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
		_unit addVest "V_TacVest_blk_POLICE";
		for "_i" from 1 to 2 do {_unit addItemToVest "OPTRE_8Rnd_127x40_Mag";};
		_unit addHeadgear "H_Cap_police";

		comment "Add weapons";
		_unit addWeapon "OPTRE_M6G";
		_unit addHandgunItem "OPTRE_M6G_Flashlight";
		_unit addHandgunItem "OPTRE_M6G_Scope";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
	};
	
	//////////////////////////////////////////
	//////// Light Shotgun Loadout /////////
	/////////////////////////////////////////
	
	case "I_Soldier_lite_F":
	{
		comment "Add containers";
		_unit forceAddUniform "U_B_GEN_Commander_F";
		_unit addItemToUniform "OPTRE_Biofoam";
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
		_unit addVest "V_TacVest_blk_POLICE";
		for "_i" from 1 to 6 do {_unit addItemToVest "OPTRE_6Rnd_8Gauge_Pellets";};
		_unit addHeadgear "H_Cap_police";

		comment "Add weapons";
		_unit addWeapon "OPTRE_M45";
		_unit addWeapon "OPTRE_M6G";
		_unit addHandgunItem "OPTRE_M6G_Flashlight";
		_unit addHandgunItem "OPTRE_M6G_Scope";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
	};
	
	/////////////////////////////////////////////
	//////// Heavy Assault Rifle Loadout ////////
	/////////////////////////////////////////////
	
	case "I_soldier_F":
	{	
		_num = floor(random 3);
		
		if (_num >= 1) then // Give assault rifle
		{
			comment "Add containers";
			_unit forceAddUniform "U_B_GEN_Soldier_F";
			_unit addItemToUniform "OPTRE_Biofoam";
			for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
			_unit addVest "V_TacVest_blk_POLICE";
			for "_i" from 1 to 4 do {_unit addItemToVest "OPTRE_60Rnd_762x51_Mag";};
			_unit addItemToVest "OPTRE_M9_Frag";
			_unit addHeadgear "H_PASGT_basic_blue_F";

			comment "Add weapons";
			_unit addWeapon "OPTRE_MA5B";
			_unit addWeapon "OPTRE_M6G";
			_unit addHandgunItem "OPTRE_M6G_Flashlight";
			_unit addHandgunItem "OPTRE_M6G_Scope";
		}
		else // Give SMG
		{
			comment "Add containers";
			_unit forceAddUniform "U_B_GEN_Soldier_F";
			_unit addItemToUniform "OPTRE_Biofoam";
			for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
			_unit addVest "V_TacVest_blk_POLICE";
			for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_60Rnd_5x23mm_Mag";};
			_unit addItemToVest "OPTRE_M9_Frag";
			_unit addHeadgear "H_PASGT_basic_blue_F";

			comment "Add weapons";
			_unit addWeapon "OPTRE_M7";
			_unit addWeapon "OPTRE_M6G";
			_unit addHandgunItem "OPTRE_M6G_Flashlight";
			_unit addHandgunItem "OPTRE_M6G_Scope";
		};

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";
	};
};