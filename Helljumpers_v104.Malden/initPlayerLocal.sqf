waitUntil {!isNull player};

// Disable Teamswitching and sentences
enableTeamSwitch false;
enableSentences false;

100 cutText ["Loading...", "BLACK FADED", 1];

[player] execVM "Scripts\phoenixLoadouts.sqf";
{
	if (!isPlayer _x && player == (leader _x)) then 
	{
		waitUntil{local _x && alive _x && !isNil "isStealth"};
		[_x] execVM "Scripts\phoenixLoadouts.sqf";
		_x enableFatigue false;
		
		if (isStealth) then
		{
			_x setCombatMode "GREEN";
			//_x setBehaviour "STEALTH"; // Set phoenix team to stealth mode
		};
	};
}forEach units phoenix;

// Set fatigue
_paramfatigue = "Fatigue" call BIS_fnc_getParamValue;
if (_paramfatigue == 0) then
{
	player enableFatigue false;
};

100 cutText ["Loading Complete", "BLACK FADED", 1];
waitUntil{!isNil "BIS_fnc_init"};
[player] call AD_fnc_clientLoaded;

if (isNil "introDone") then 
{
	execVM "Scripts\intro.sqf";
}
else
{
	100 cutText ["You have joined the mission in progress.", "BLACK FADED", 1];
	player allowDamage false; // Make player unknowingly briefly invincible
	sleep 1.0;
	
	if ((leader player != player) && (player distance leader player) > 350) then
	{
		100 cutText ["You are being moved near the squad leader...", "BLACK FADED", 1];
		sleep  5.0;
		[player] call AD_fnc_moveToLeader;
	};
	
	if (("Music" call BIS_fnc_getParamValue) == 1) then 
	{
		waitUntil{sleep 1.0; !isNil "dedicatedMusic" && !isNil "trackList"};
		if (dedicatedMusic && ((["primTasks"] call FHQ_fnc_ttGetTaskState) != "completed")) then // Only works on dedicated servers
		{
			[] spawn
			{
				sleep 5.0;
				playMusic (selectRandom trackList);
			};
			ehID = addMusicEventHandler [
										"MusicStop", 
										{
											[] spawn
											{
												sleep 5.0;
												playMusic (selectRandom trackList);;
											};
										}
									];
		};
	};
	
	sleep 2.0;
	100 cutText ["", "BLACK FADED", 1];
	100 cutFadeOut 5;
	enableSentences true; // Re-enable sentences
	player allowDamage true; // Turn off player's invinciblity
};

// If mission is singleplayer, then restart the music event handler every time the mission is loaded from a save
if (!isMultiplayer) then 
{
	waitUntil {sleep 1.0; !isNil "trackList"};
	addMissionEventHandler ["Loaded", 
		{
			[] spawn
			{
				sleep 5.0;
				playMusic (selectRandom trackList);
			};
			ehID = addMusicEventHandler [
										"MusicStop", 
										{
											[] spawn
											{
												sleep 5.0;
												playMusic (selectRandom trackList);
											};
										}
									];
		}
	];
};
