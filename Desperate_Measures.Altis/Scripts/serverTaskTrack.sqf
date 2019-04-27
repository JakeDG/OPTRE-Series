if (!isServer) exitWith {};

// Factory task
[] spawn
{
	waitUntil {sleep 1.0; !isNil "ftryCleared"};
	["clearTask_1", "succeeded"] call FHQ_fnc_ttSetTaskState; 
};

// Bomb task
[] spawn
{
	waitUntil {sleep 1.0; ({(_x getVariable "isDisarmed")} count [bomb_1,bomb_2,bomb_3,bomb_4] == 4)};
	["bombTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
};

// Factory tasks complete
[] spawn
{
	waitUntil {sleep 1.0; ["clearTask_1", "bombTask"] call FHQ_fnc_ttAreTasksCompleted};
	["clearTask_1", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	["factoryMkr", "ColorRed", "X_fact"] call AD_fnc_crossMkr;
	sleep 2.0;
	
	// Save the game in singleplayer
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	sleep 1.0;
	
	//[] remoteExec ["clearRadio",[0,-2] select (isMultiplayer && isDedicated)];
	[] spawn 
	{
		"Overture" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
		sleep 120;
		"" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	};
	
	//[cmd, "Good job out there Pheonix, but your work isn't done."] remoteExec ["sideChat",[0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#469CED'>Command:</t> Good job out there Pheonix, but your work isn't done.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 12, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];

	sleep 8.0;
	
	//[cmd, "The Innies have retreated to a small abandoned factory northwest of your position."] remoteExec ["sideChat",[0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#469CED'>Command:</t> The Innies have retreated to a small abandoned factory northwest of your position.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 12, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 8.0;
	
	//[cmd, "You are to neutralize that area of all insurrectionist activity immediately."] remoteExec ["sideChat",[0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#469CED'>Command:</t> You are to neutralize that area of all insurrectionist activity immediately.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 12, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 8.0;
	
	// Assign next primary objective
	[phoenix, [["clearTask_2", "primTasks"], "The Innies appear to have retreated to an <marker name='outpost'>abandoned factory complex</marker> northwest of the Traxus factory. Neutralize all insurrectionists at the factory.", "Clear Rebel Factory", "", getMarkerPos "outpost", "assigned", "attack"]] call FHQ_fnc_ttAddTasks;
	sleep 5.0;
	
	[] remoteExec ["clearRadio",[0,-2] select (isMultiplayer && isDedicated)];
	//[cmd, "Also, be advised, we are sending you some supplies if you need to stock up. Command out!"] remoteExec ["sideChat",[0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#469CED'>Command:</t> Also, be advised, we are sending you some supplies if you need to stock up. Command out!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 12, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 3.0;
	
	parseText format ["<t color='#FFFFFF' size='3'>A Pelican is inbound to drop off supplies for you!</t><br/><t color='#469CED' size='1.3'>The drop location has been marked on your map!</t>"] remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated)];
	
	_supMkr = createMarker ["supplyMkr", getMarkerPos "splyMkrPos"]; 
	_supMkr setMarkerShape "ICON"; 
	"supplyMkr" setMarkerType "hd_end"; 
	"supplyMkr" setMarkerColor "ColorBLUFOR"; 
	"supplyMkr" setMarkertext "Resupply Pods";
};

// Innie factory
[] spawn
{
	waitUntil {sleep 1.0; !isNil "secFtryCleared"};
	["clearTask_2", "succeeded"] call FHQ_fnc_ttSetTaskState;
	
	// Save the game in singleplayer
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	sleep 1.0;
};

// Extract task
[] spawn
{
	waitUntil {sleep 1.0; ["clearTask_1", "bombTask", "clearTask_2"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 1.0;
	
	["primTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 4.0;
	[["Overture",121]] remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	
	_extMkr = createMarker ["extMkr", (getPos ext)];
	"extMkr" setMarkerText "Extraction";
	"extMkr" setMarkerColor "ColorBlufor";
	"extMkr" setMarkerType "hd_pickup";
	
	// Assign evac objective
	[phoenix, ["extTask", "Board the inbound Pelican to extract from the area.", "Extraction", "", getMarkerPos "extMkr", "assigned"]] call FHQ_fnc_ttAddTasks;
	
	sleep 3.0;
	//[cmd, "Gentlemen, it's time to pull you out of there. A Pelican is inbound to pick you up. Head to the extraction point we've marked on your map."] remoteExec ["sideChat",[0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#469CED'>Command:</t> Gentlemen, it's time to pull you out of there. A Falcon is inbound to pick you up. Head to the extraction point we've marked on your map.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 12, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
};

// Extracted, end mission
[] spawn
{
	waitUntil {sleep 1.0; ({(_x in extPel)} count units phoenix == {alive _x} count units phoenix)};
	
	["extTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	[1,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
	//[10,0.35] remoteExec ["fadeSound", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 1.0;
	"LoneWolf" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	[10,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 3.0;
	
	[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 35.0;
	
	activateKey "MissionCompleted";
	sleep 1.0;
	["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
};

// Insertion stuff
[] spawn
{
	waitUntil {sleep 1.0; {!(_x in insHeli)} count units phoenix == {alive _x} count units phoenix};
	
	// Fade out intro song
	[15,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 15.0;
	"" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	sleep 15.0;
	[15,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
};