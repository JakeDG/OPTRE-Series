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

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		for "_i" from 1 to 4 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
		_unit addVest "OPTRE_UNSC_M52D_Armor_Rifleman";
		for "_i" from 1 to 6 do {_unit addItemToVest "OPTRE_36Rnd_95x40_Mag_Tracer";};
		for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_M9_Frag";};
		_unit addBackpack "OPTRE_ILCS_Rucksack_Heavy";
		for "_i" from 1 to 6 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_36Rnd_95x40_Mag_Tracer";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_M2_Smoke";};
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";

		comment "Add weapons";
		_unit addWeapon "OPTRE_BR55HB";
		_unit addPrimaryWeaponItem "OPTRE_BR55HB_Scope";
		_unit addWeapon "OPTRE_M6G_SF";
		_unit addWeapon "Rangefinder";
		_unit addHandgunItem "OPTRE_M6G_Flashlight";
		_unit addHandgunItem "OPTRE_M6G_Scope";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";
		
		if (isStealth) then
		{
			_unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F";
			_unit addHandgunItem "OPTRE_M6_silencer";
		};

	};
	
	////////////////////////////////
	//////// AT Loadout ////////
	////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_Rifleman_AT":		// REMOVED M41 Rocket launcher because of CTD bug in OPTRE v0.20
	{	
		[_unit,"Viper"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		for "_i" from 1 to 4 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
		_unit addVest "OPTRE_UNSC_M52D_Armor_Rifleman";
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 7 do {_unit addItemToVest "OPTRE_36Rnd_95x40_Mag";};
		_unit addBackpack "OPTRE_ILCS_Rucksack_Heavy";
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		for "_i" from 1 to 3 do {_unit addItemToBackpack "OPTRE_M41_Twin_HEAT";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_M2_Smoke";};
		
		_unit addItemToBackpack "OPTRE_M41_Twin_HEAP";
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";

		comment "Add weapons";
		_unit addWeapon "OPTRE_BR55HB";
		_unit addPrimaryWeaponItem "OPTRE_BR55HB_Scope";
		_unit addWeapon "OPTRE_M41_SSR";
		_unit addWeapon "OPTRE_M6G_SF";
		_unit addWeapon "Rangefinder";
		_unit addHandgunItem "OPTRE_M6G_Flashlight";
		_unit addHandgunItem "OPTRE_M6G_Scope";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";
		
		if (isStealth) then
		{
			_unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F";
			_unit addHandgunItem "OPTRE_M6_silencer";
		};
	};
	
	/////////////////////////////////////////
	//////// Sniper Loadout ///////////////
	///////////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_Scout_Sniper":
	{	
		[_unit,"Snake"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];
		
		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		for "_i" from 1 to 4 do {_unit addItemToUniform "OPTRE_16Rnd_127x40_Mag";};
		_unit addVest "OPTRE_UNSC_M52D_Armor_Sniper";
		for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_4Rnd_145x114_APFSDS_Mag";};
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		_unit addBackpack "OPTRE_ILCS_Rucksack_Black";
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		for "_i" from 1 to 10 do {_unit addItemToBackpack "OPTRE_4Rnd_145x114_APFSDS_Mag";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_M2_Smoke";};
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";

		comment "Add weapons";
		_unit addWeapon "OPTRE_SRS99D_SC_LS";
		_unit addPrimaryWeaponItem "OPTRE_SRS99_Scope";
		_unit addWeapon "OPTRE_M6C";
		//_unit addWeapon "OPTRE_M7_Folded";
		//_unit addHandgunItem "OPTRE_M7_Sight";
		_unit addHandgunItem "OPTRE_M6C_compensator";
		_unit addHandgunItem "OPTRE_M6C_Scope";
		_unit addWeapon "Rangefinder";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then
		{
			_unit addPrimaryWeaponItem "OPTRE_SRS99D_Suppressor";
			//_unit addHandgunItem "OPTRE_M7_silencer";
		};
	};
	
	//////////////////////////////////////////
	//////// Field Operative Loadout /////////
	/////////////////////////////////////////
	
	case "OPTRE_UNSC_ONI_Soldier_Operative":
	{	
		[_unit,"Ghost"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];
	
		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		for "_i" from 1 to 4 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
		for "_i" from 1 to 3 do {_unit addItemToBackpack "OPTRE_M2_Smoke";};
		_unit addVest "OPTRE_UNSC_M52D_Armor_Demolitions";
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_100Rnd_95x40_Box";};
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		_unit addBackpack "OPTRE_ILCS_Rucksack_Black";
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		_unit addItemToBackpack "ToolKit";
		//_unit addItemToBackpack "MineDetector";
		for "_i" from 1 to 4 do {_unit addItemToBackpack "OPTRE_100Rnd_95x40_Box";};
		_unit addHeadgear "OPTRE_UNSC_Recon_Helmet";

		comment "Add weapons";
		_unit addWeapon "OPTRE_M73";
		_unit addPrimaryWeaponItem "OPTRE_M73_SmartLink";
		_unit addPrimaryWeaponItem "bipod_01_F_blk";
		_unit addWeapon "OPTRE_M6G_SF";
		_unit addHandgunItem "OPTRE_M6G_Flashlight";
		_unit addHandgunItem "OPTRE_M6G_Scope";
		_unit addWeapon "Rangefinder";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then
		{
			_unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F";
			_unit addHandgunItem "OPTRE_M6_silencer";
		};
		
		_unit setUnitTrait ["engineer", true];
	};
	
	////////////////////////////////
	//////// Medic Loadout ////////
	////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_Paramedic":
	{	
		[_unit,"Jester"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		for "_i" from 1 to 4 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
		_unit addVest "OPTRE_UNSC_M52D_Armor_Medic";
		for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_15Rnd_762x51_Mag";};
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_M2_Smoke";};
		_unit addBackpack "OPTRE_ILCS_Rucksack_Medical";
		for "_i" from 1 to 10 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		_unit addItemToBackpack "OPTRE_MedKit";
		for "_i" from 1 to 6 do {_unit addItemToBackpack "OPTRE_15Rnd_762x51_Mag";};
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";

		comment "Add weapons";
		_unit addWeapon "OPTRE_M392_DMR";
		_unit addPrimaryWeaponItem "OPTRE_M392_Scope";
		_unit addWeapon "OPTRE_M6G_SF";
		_unit addHandgunItem "OPTRE_M6G_Flashlight";
		_unit addHandgunItem "OPTRE_M6G_Scope";
		_unit addWeapon "Rangefinder";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then
		{
			_unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F";
			_unit addHandgunItem "OPTRE_M6_silencer";
		};
		
		_unit setUnitTrait ["medic", true];
	};
	
	//////////////////////////////////
	//////// Marksmen Loadout ////////
	//////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_Marksman":
	{	
		[_unit,"Frost"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		for "_i" from 1 to 4 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
		_unit addVest "OPTRE_UNSC_M52D_Armor_Marksman";
		for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_15Rnd_762x51_Mag";};
		_unit addBackpack "OPTRE_ILCS_Rucksack_Black";
		for "_i" from 1 to 6 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_M2_Smoke";};
		for "_i" from 1 to 6 do {_unit addItemToBackpack "OPTRE_15Rnd_762x51_Mag";};
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";

		comment "Add weapons";
		_unit addWeapon "OPTRE_M393_DMR";
		_unit addPrimaryWeaponItem "OPTRE_M393_Scope";
		_unit addWeapon "OPTRE_M6G";
		_unit addHandgunItem "OPTRE_M6G_Flashlight";
		_unit addHandgunItem "OPTRE_M6G_Scope";
		_unit addWeapon "Rangefinder";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then
		{
			_unit addPrimaryWeaponItem "OPTRE_M393_Suppressor";
			_unit addHandgunItem "OPTRE_M6_silencer";
		};
	};
	
	////////////////////////////////////////////////
	//////// Demolitions Specialist Loadout ////////
	////////////////////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_DemolitionsExpert":
	{	
		[_unit,"Thanos"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];
		
		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		for "_i" from 1 to 3 do {_unit addItemToUniform "OPTRE_12Rnd_127x40_Mag";};
		_unit addItemToUniform "OPTRE_M9_Frag";
		_unit addVest "OPTRE_UNSC_M52D_Armor_Demolitions";
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 7 do {_unit addItemToVest "OPTRE_32Rnd_762x51_Mag";};
		_unit addBackpack "OPTRE_ILCS_Rucksack_Heavy";
		for "_i" from 1 to 6 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		_unit addItemToBackpack "ToolKit";
		_unit addItemToBackpack "MineDetector";
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_M2_Smoke";};
		for "_i" from 1 to 3 do {_unit addItemToBackpack "C7_Remote_Mag";};
		for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_32Rnd_762x51_Mag";};
		//_unit addItemToBackpack "C12_Remote_Mag";
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";

		comment "Add weapons";
		_unit addWeapon "OPTRE_MA5C";
		_unit addPrimaryWeaponItem "OPTRE_MA5C_SmartLink";
		_unit addWeapon "OPTRE_M6C";
		_unit addHandgunItem "OPTRE_M6C_compensator";
		_unit addHandgunItem "OPTRE_M6C_Laser";
		_unit addHandgunItem "OPTRE_M6C_Scope";
		_unit addWeapon "Rangefinder";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then
		{
			_unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F";
		};
		
		_unit setUnitTrait ["explosiveSpecialist", true];
	};
	
	///////////////////////////////////
	//////// Grenadier Loadout ////////
	///////////////////////////////////
	
	case "OPTRE_UNSC_ODST_Soldier_Rifleman_AR":
	{	
		[_unit,"Nomad"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), _unit];

		comment "Add containers";
		_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
		for "_i" from 1 to 4 do {_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag";};
		_unit addVest "OPTRE_UNSC_M52D_Armor_Rifleman";
		for "_i" from 1 to 5 do {_unit addItemToVest "OPTRE_M9_Frag";};
		for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_60Rnd_762x51_Mag";};
		_unit addBackpack "OPTRE_ILCS_Rucksack_Black";
		for "_i" from 1 to 6 do {_unit addItemToBackpack "OPTRE_Biofoam";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "OPTRE_M2_Smoke";};
		for "_i" from 1 to 15 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
		for "_i" from 1 to 6 do {_unit addItemToBackpack "OPTRE_60Rnd_762x51_Mag";};
		for "_i" from 1 to 5 do {_unit addItemToBackpack "1Rnd_Smoke_Grenade_shell";};
		_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";

		comment "Add weapons";
		_unit addWeapon "OPTRE_MA5BGL";
		_unit addPrimaryWeaponItem "OPTRE_MA5_SmartLink";
		_unit addWeapon "OPTRE_M6G";
		_unit addHandgunItem "OPTRE_M6G_Flashlight";
		_unit addHandgunItem "OPTRE_M6G_Scope";
		_unit addWeapon "Rangefinder";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "ItemGPS";
		_unit linkItem "OPTRE_NVG";

		if (isStealth) then
		{
			_unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F";
			_unit addHandgunItem "OPTRE_M6_silencer";
		};
	};
};

_unit setUnitTrait ["loadCoef", 0.85];