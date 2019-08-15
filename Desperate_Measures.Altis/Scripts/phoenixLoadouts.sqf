// Loadouts for Sabre Team
if (!(local player)) exitWith {};
waitUntil {!isNull player};
waitUntil {!isNil "isStealth"};

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
	///// Team Leader Loadout //////
	////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_TeamLeader":
	{
		[_unit,"Razer"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];
		
		comment "Add weapons";
		_unit addWeapon "OPTRE_BR55HB";
		_unit addPrimaryWeaponItem "OPTRE_BR55HB_Scope";
		_unit addPrimaryWeaponItem "OPTRE_36Rnd_95x40_Mag_Tracer";
		_unit addWeapon "OPTRE_M6C";
		_unit addHandgunItem "OPTRE_M6C_compensator";
		_unit addHandgunItem "OPTRE_M6C_Laser";
		_unit addHandgunItem "OPTRE_M6C_Scope";
		_unit addHandgunItem "OPTRE_12Rnd_127x40_Mag";

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		_unit addVest "OPTRE_UNSC_M52D_Armor_Rifleman";
		_unit addBackpack "OPTRE_ILCS_Rucksack_Black";

		comment "Add binoculars";
		_unit addMagazine "Laserbatteries";
		_unit addWeapon "OPTRE_Smartfinder";

		comment "Add items to containers";
		for "_i" from 1 to 3 do {_unit addItemToUniform "SmokeShell";};
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_12Rnd_127x40_Mag";};
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 8 do {_unit addItemToVest "OPTRE_36Rnd_95x40_Mag_Tracer";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_36Rnd_95x40_Mag_Tracer";};
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";
		_unit addGoggles "G_Tactical_Black";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then { _unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F"; };
	};
	
	////////////////////////////////
	//////// AT Loadout ////////
	////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_Rifleman_AT":
	{	
		[_unit,"Viper"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];

		comment "Add weapons";
		_unit addWeapon "OPTRE_MA5C";
		_unit addPrimaryWeaponItem "OPTRE_MA5C_SmartLink";
		_unit addPrimaryWeaponItem "OPTRE_32Rnd_762x51_Mag";
		_unit addWeapon "OPTRE_M41_SSR";
		_unit addSecondaryWeaponItem "OPTRE_M41_Twin_HEAT";
		_unit addWeapon "OPTRE_M6C";
		_unit addHandgunItem "OPTRE_M6C_compensator";
		_unit addHandgunItem "OPTRE_M6C_Laser";
		_unit addHandgunItem "OPTRE_M6C_Scope";
		_unit addHandgunItem "OPTRE_12Rnd_127x40_Mag";

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		_unit addVest "OPTRE_UNSC_M52D_Armor_Rifleman";
		_unit addBackpack "OPTRE_ILCS_Rucksack_Black";

		comment "Add binoculars";
		_unit addMagazine "Laserbatteries";
		_unit addWeapon "OPTRE_Smartfinder";

		comment "Add items to containers";
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_M2_Smoke";};
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_12Rnd_127x40_Mag";};
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 7 do {_unit addItemToVest "OPTRE_32Rnd_762x51_Mag";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_M41_Twin_HEAT";};
		_unit addItemToBackpack "OPTRE_M41_Twin_HEAP";
		for "_i" from 1 to 3 do {_unit addItemToBackpack "OPTRE_32Rnd_762x51_Mag";};
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";
		_unit addGoggles "G_Tactical_Black";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then { _unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F"; };
	};
	
	/////////////////////////////////////////
	//////// Sniper Loadout ////////
	///////////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_Scout_Sniper":
	{	
		[_unit,"Snake"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];

		comment "Add weapons";
		_unit addWeapon "OPTRE_SRS99D_SC_LS";
		_unit addPrimaryWeaponItem "OPTRE_SRS99_Scope";
		_unit addPrimaryWeaponItem "OPTRE_4Rnd_145x114_APFSDS_Mag";
		_unit addWeapon "OPTRE_M6C";
		_unit addHandgunItem "OPTRE_M6C_compensator";
		_unit addHandgunItem "OPTRE_M6C_Laser";
		_unit addHandgunItem "OPTRE_M6C_Scope";
		_unit addHandgunItem "OPTRE_16Rnd_127x40_Mag";

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		_unit addVest "OPTRE_UNSC_M52D_Armor_Sniper";
		_unit addBackpack "OPTRE_ILCS_Rucksack_Black";

		comment "Add binoculars";
		_unit addMagazine "Laserbatteries";
		_unit addWeapon "OPTRE_Smartfinder";

		comment "Add items to containers";
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_M2_Smoke";};
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_16Rnd_127x40_Mag";};
		for "_i" from 1 to 4 do {_unit addItemToVest "OPTRE_4Rnd_145x114_APFSDS_Mag";};
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		for "_i" from 1 to 16 do {_unit addItemToBackpack "OPTRE_4Rnd_145x114_APFSDS_Mag";};
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";
		_unit addGoggles "G_Tactical_Black";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then { _unit addPrimaryWeaponItem "OPTRE_SRS99D_Suppressor"; };
	};
	
	//////////////////////////////////////////
	//////// Field Operative Loadout /////////
	/////////////////////////////////////////
	
	case "OPTRE_UNSC_ONI_Soldier_Operative":
	{	
		[_unit,"Ghost"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];

		comment "Add weapons";
		_unit addWeapon "OPTRE_M73";
		_unit addPrimaryWeaponItem "OPTRE_M73_SmartLink";
		_unit addPrimaryWeaponItem "OPTRE_100Rnd_95x40_Box_Tracer";
		_unit addPrimaryWeaponItem "bipod_01_F_blk";
		_unit addWeapon "OPTRE_M6C";
		_unit addHandgunItem "OPTRE_M6C_compensator";
		_unit addHandgunItem "OPTRE_M6C_Laser";
		_unit addHandgunItem "OPTRE_M6C_Scope";
		_unit addHandgunItem "OPTRE_12Rnd_127x40_Mag";

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		_unit addVest "OPTRE_UNSC_M52D_Armor_Demolitions";
		_unit addBackpack "OPTRE_ILCS_Rucksack_Black";

		comment "Add binoculars";
		_unit addMagazine "Laserbatteries";
		_unit addWeapon "OPTRE_Smartfinder";

		comment "Add items to containers";
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_M2_Smoke";};
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_12Rnd_127x40_Mag";};
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 2 do {_unit addItemToVest "OPTRE_100Rnd_95x40_Box_Tracer";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		_unit addItemToBackpack "ToolKit";
		_unit addItemToBackpack "MineDetector";
		for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_100Rnd_95x40_Box_Tracer";};
		for "_i" from 1 to 3 do {_unit addItemToBackpack "C7_Remote_Mag";};
		_unit addHeadgear "OPTRE_UNSC_Recon_Helmet";
		_unit addGoggles "G_Tactical_Black";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then { _unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F"; };
	};

	////////////////////////////////
	//////// Medic Loadout ////////
	////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_Paramedic":
	{	
		[_unit,"Jester"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];

		comment "Add weapons";
		_unit addWeapon "OPTRE_M392_DMR";
		_unit addPrimaryWeaponItem "OPTRE_M392_Scope";
		_unit addPrimaryWeaponItem "OPTRE_15Rnd_762x51_Mag";
		_unit addWeapon "OPTRE_M6C";
		_unit addHandgunItem "OPTRE_M6C_compensator";
		_unit addHandgunItem "OPTRE_M6C_Laser";
		_unit addHandgunItem "OPTRE_M6C_Scope";
		_unit addHandgunItem "OPTRE_12Rnd_127x40_Mag";

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		_unit addVest "OPTRE_UNSC_M52D_Armor_Medic";
		_unit addBackpack "OPTRE_ILCS_Rucksack_Medical";

		comment "Add binoculars";
		_unit addMagazine "Laserbatteries";
		_unit addWeapon "OPTRE_Smartfinder";

		comment "Add items to containers";
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_12Rnd_127x40_Mag";};
		for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_15Rnd_762x51_Mag";};
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_M2_Smoke";};
		for "_i" from 1 to 10 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		_unit addItemToBackpack "OPTRE_MedKit";
		for "_i" from 1 to 10 do {_unit addItemToBackpack "OPTRE_15Rnd_762x51_Mag";};
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";
		_unit addGoggles "G_Tactical_Black";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then { _unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F"; };
	};
};

_unit setUnitTrait ["loadCoef", 0.75];