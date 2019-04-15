if (!isServer) exitWith {};

/******************** SERVER VARIABLES ***********************/

/******************** SERVER SCRIPTS ***********************/
execVM "briefing.sqf";
execVM "Scripts\serverTaskTrack.sqf";

/******************** REMOTE EXECS ***********************/
// Add action to ammoboxes
{
	[_x, [ "<t color='#2B7ADA'>Open Virtual Arsenal</t>",{ ["Open",true] spawn BIS_fnc_arsenal; },[],10,true,true,"","(_target distance _this) < 3.5"] ] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), _x];
} forEach [arsenal_1,arsenal_2,arsenal_3,arsenal_4];

/* FIX for M41 Rocket launcher CTD bug */
/* Remove all occurrences of its existence */
[] spawn
{	
	{
		// Check for rocket launcher
		if (secondaryWeapon _x != "") then 
		{
			// Remove rocket launcher and its magazines from the unit
			_x removeWeapon (secondaryWeapon _x);
			_x removeMagazines "OPTRE_M41_Twin_HEAT";
			_x removeMagazines "OPTRE_M41_Twin_HEAP";
			
			// Add back a launcher (RPG-42 for Innies, PCML for UNSC)
			if (side _x == west) then
			{
				for "_i" from 1 to 3 do {_x addItemToBackpack "NLAW_F";};
				_x addWeapon "launch_NLAW_F";
			}
			else
			{
				for "_i" from 1 to 3 do {_x addItemToBackpack "RPG32_F";};
				_x addWeapon "launch_RPG32_F";
			};
		};
	} forEach (allUnits - units phoenix);
};

/******************** MISSION PARAMETERS ***********************/
// REVIVE PARAMETER IS SET IN SABRE TEAM INIT
// Set time
_paramTime = "Time" call BIS_fnc_getParamValue;
switch (_paramTime) do 
{
	case 0: // Morning
	{
		setDate [2517, 6, 6, 6, 31];
	};
};

// Set weather
_paramWeather = "Weather" call BIS_fnc_getParamValue;
switch (_paramWeather) do 
{
	case 0: // Clear
	{
		[0] call BIS_fnc_setOvercast;
	};
	case 1: // Cloudy
	{
		[0.25] call BIS_fnc_setOvercast;
	};
	case 2: // Overcast
	{
		[0.5] call BIS_fnc_setOvercast;
	};
	case 3: // Rainy
	{
		[0.75] call BIS_fnc_setOvercast;
	};
	case 4: // Stormy
	{
		[1] call BIS_fnc_setOvercast;
	};
};

// Difficulty
_paramDifficulty = "Difficulty" call BIS_fnc_getParamValue;
if (_paramDifficulty > 0) then // if user selects difficulty other than their own skill settings
{
	switch (_paramDifficulty) do // Sabre group skills were set within the editor
	{
		case 1: // Normal
		{ 
			{
				if ((side _x) == east) then
				{
					_x setSkill ["reloadspeed", 0.35];
					_x setSkill ["spotdistance", 0.3];
					_x setSkill ["aimingshake", 0.3];
					_x setSkill ["aimingspeed", 0.3];
					_x setSkill ["spottime", 0.3];
					_x setSkill ["aimingaccuracy", 0.25];
					_x setSkill ["commanding", 0.3];
					_x setSkill ["general", 0.35];
				};
				
			} forEach allUnits;
		
		};
		case 2: // Heroic
		{ 
			{	
				if ((side _x) == east) then
				{
					_x setSkill ["reloadspeed", 0.4];
					_x setSkill ["spotdistance", 0.45];
					_x setSkill ["aimingshake", 0.45];
					_x setSkill ["aimingspeed", 0.4];
					_x setSkill ["spottime", 0.45];
					_x setSkill ["aimingaccuracy", 0.4];
					_x setSkill ["commanding", 0.35];
					_x setSkill ["general", 0.4];
				};
				
			} forEach allUnits;
		};
		case 3: // Legendary
		{ 
			{
				if ((side _x) == east) then
				{
					_x setSkill ["reloadspeed", 0.45];
					_x setSkill ["spotdistance", 0.55];
					_x setSkill ["aimingshake", 0.5];
					_x setSkill ["aimingspeed", 0.45];
					_x setSkill ["spottime", 0.45];
					_x setSkill ["aimingaccuracy", 0.45];
					_x setSkill ["commanding", 0.5];
					_x setSkill ["general", 0.5];
				};
				
			} forEach allUnits;
		};
	};
};

// Set stealth
_paramStealth = "Stealth" call BIS_fnc_getParamValue;
if (_paramStealth == 1) then
{
	isStealth = true;
	publicVariable "isStealth";
}
else
{
	isStealth = false;
	publicVariable "isStealth";
};

// Set ambient music
_paramMusic = "Music" call BIS_fnc_getParamValue;
if (_paramMusic == 1) then 
{
	trackList = [
			"LeadTrack01_F_Tank",
			"MainTheme_F_Tank",
			"LeadTrack05_F_Tank",
			"LeadTrack01_F_Tacops",
			"LeadTrack02_F_Tacops",
			"LeadTrack03_F_Tacops",
			"OPTRE_Music_RescueMission",
			"OPTRE_Music_RockAnthemToSaveTheWorld",
			"OPTRE_Music_DesperateMeasures",
			"OPTRE_Music_OPTRETheme",
			"OPTRE_Music_BattleTanks",
			"OPTRE_Music_GoingLoud",
			"OPTRE_Music_TheFewTheBrave",
			"OPTRE_Music_IconSuite",
			"OPTRE_Music_RescueMission",
			"OPTRE_Music_RockAnthemToSaveTheWorld",
			"OPTRE_Music_ScorpionMix",
			"OPTRE_Music_SwordsInTheSky",
			"OPTRE_Music_ToGalaxy"
		];

	publicVariable "trackList";
		
	if (!isDedicated) then // All music is synced over the network through player host
	{
		ehID = addMusicEventHandler [
										"MusicStop", 
										{
											[] spawn
											{
												sleep 5.0;
												(selectRandom trackList) remoteExec ["playMusic",0];
											};
										}
									];
		dedicatedMusic = false;
		publicVariable "dedicatedMusic";
	}
	else
	{
		dedicatedMusic = true;
		publicVariable "dedicatedMusic";
	};
}
else
{
	dedicatedMusic = false;
	publicVariable "dedicatedMusic";
};

/******************** OTHER SERVER STUFF ***********************/
if (isMultiplayer || isDedicated) then
{
	enableSaving [false,false]; // Disable saving for multiplayer
}
else
{
	enableSaving [true,true]; // Enable saving for singleplayer
};

// Give AI's flashlights if it's night
if ([] call AD_fnc_isNight) then 
{
	[] spawn 
	{
		// Add flashlights to militia guns
		{
			if ((side _x) == east) then
			{
				_x addPrimaryWeaponItem "acc_flashlight";
				sleep 0.2;
				_x enablegunlights "forceOn";
			};
		} forEach allUnits;
	};
};

// Set Phoenix team's AI skill
{
	_x setSkill ["reloadspeed", 1.0];
	_x setSkill ["aimingshake", 0.90];
	_x setSkill ["aimingspeed", 0.90];
	_x setSkill ["spottime", 0.95];
	_x setSkill ["spotdistance", 0.95];
	_x setSkill ["aimingaccuracy", 0.90];
	_x setSkill ["commanding", 0.95];
	_x setSkill ["general", 0.95];
} forEach units phoenix;

// Increase Marines some skill
{
	if ((side _x == west) && (group _x != phoenix)) then
	{
		_x setSkill ["reloadspeed", 0.7];
		_x setSkill ["spotdistance", 0.65];
		_x setSkill ["aimingshake", 0.7];
		_x setSkill ["aimingspeed", 0.65];
		_x setSkill ["spottime", 0.7];
		_x setSkill ["aimingaccuracy", 0.6];
		_x setSkill ["commanding", 0.7];
		_x setSkill ["general", 0.9];
	};
} forEach allUnits;

// Constant check if everyone is down
[] spawn 
{
	waitUntil{sleep 5.0; (({_x getVariable ["AIS_unconscious", false]} count units phoenix) == ({alive _x} count units phoenix))};
	["End_AllDown",false,true,false] remoteExec ["BIS_fnc_endMission"];
};

waitUntil{sleep 1.0; !isNil "BIS_fnc_init"}; // Wait until server is ready
waitUntil{sleep 1.0; {_x getVariable ["isClientLoaded",false]} count (allPlayers - entities "HeadlessClient_F") == count (allPlayers - entities "HeadlessClient_F")}; // Wait until clients are all loaded
serverLoaded = true;
publicVariable "serverLoaded"; 