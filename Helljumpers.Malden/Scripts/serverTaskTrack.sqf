if (!isServer) exitWith {};

// Beach task
[] spawn
{
	waitUntil {sleep 1.0; !isNil "beachCleared"};
	["beachTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	["beachMkr", "ColorRed", "X_beach"] call AD_fnc_crossMkr;
	sleep 5.0;
	
	// Save the game in singleplayer
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	sleep 1.0;
	
	// Command message
	[
		[
			"Command",
			"Good job clearing the beach, Phoenix! Now push up with the Marines and take the old UNSC base to the southwest.",
			10,
			"RadioAmbient2"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 6.0;
	
	// Assign base parent task
	[phoenix, [["baseTasks", "primTasks"], "<font color='#469CED'>Clear the way</font> for the UNSC 5th Fleet by securing the <marker name='baseMkr'>old UNSC base</marker> that's southwest of the <marker name='beachMkr'>beach</marker>", "Secure Old UNSC Base", "", getMarkerPos "baseMkr", "assigned", "ATTACK"]] call FHQ_fnc_ttAddTasks;
	sleep 6.0;
	
	// Command message
	[
		[
			"Command",
			"Disable the orbital defense guns and destroy any anti-air systems that are still active in the base. Make sure to also secure the base's command tower. Let the Marines deal with the rest of the fodder.",
			10,
			"RadioAmbient8"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 3.0;
	
	// Create clear tower task
	[phoenix, [["towerTask", "baseTasks"], "<img image='images\tower.jpg' width='370' height='208'/><br/><br/><font color='#469CED'>Clear</font> out the <marker name='baseMkr'>base's</marker> command tower of all <font color='#469CED'>insurgent personnel</font>.", "Clear Command Tower", "", getPosATL towerObj, "created", "TARGET"]] call FHQ_fnc_ttAddTasks;
	
	// Clear Tower Task
	[] spawn 
	{
		waitUntil {sleep 1.0; !isNil "towerCleared"};
		["towerTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	};
	sleep 4.0;
	
	// Create destroy AA task
	[phoenix, [["aaTask", "baseTasks"], "<img image='images\aa.jpg' width='370' height='208'/><br/><br/><font color='#469CED'>Destroy</font> any and all autonomous <font color='#469CED'>anti-air defenses</font> you find in the <marker name='baseMkr'>base</marker> so our air support has a clear way into <font color='#469CED'>Malden's airspace</font>.<br/><br/><font color='#469CED'>Note:</font> According to our scans, we are detecting six active static anti-air units in the base.", "Neutralize Anti-Air", "", "", "created", "DESTROY"]] call FHQ_fnc_ttAddTasks;
	
	// AA Task
	[] spawn 
	{
		waitUntil {sleep 1.0; ({alive _x} count [aa_1, aa_2, aa_3, aa_4, aa_5, aa_6]) == 0};
		["aaTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	};
	sleep 4.0;
	
	// Create orbital guns task
	[phoenix, [["orbGunTask", "baseTasks"], "<img image='images\orbGun.jpg' width='370' height='208'/><br/><br/>Find a way to disable the <font color='#469CED'>two orbital guns</font> located in the <marker name='baseMkr'>base</marker>. Try searching the bunkers the guns are sitting on for a <font color='#469CED'>computer terminal to deactivate them</font>.<br/><br/><font color='#469CED'>Note:</font> Do not attempt to destroy the guns because it would take a round from one of our a cruisers to punch through their heavy armor.", "Disable Orbital Guns", "", "", "created", "Interact"]] call FHQ_fnc_ttAddTasks;
	
	// Select a random terminal in each orbital gun's bunker to be the one to hack
	_orbGunTerm1 = selectRandom [term_1a,term_1b,term_1c,term_1d];
	_orbGunTerm2 = selectRandom [term_2a,term_2b,term_2c,term_2d];
	
	// Add the "Disable" action to the selected terminals
	[_orbGunTerm1, "Disable Orbital Gun", 10, "Disabling Orbital Gun", "Orbital Gun Disabled", "Interrupted"] call AD_fnc_hack;
	[_orbGunTerm2, "Disable Orbital Gun", 10, "Disabling Orbital Gun", "Orbital Gun Disabled", "Interrupted"] call AD_fnc_hack;
	
	// Orbital Gun Task
	[_orbGunTerm1,_orbGunTerm2] spawn 
	{
		_term1 = _this select 0;
		_term2 = _this select 1;
		
		waitUntil {sleep 1.0; (_term1 getVariable "isHacked") && (_term2 getVariable "isHacked")};
		["orbGunTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	};
	sleep 7.0;
	
	// Command message
	[
		[
			"Command",
			"Phoenix, be sure to signal the Marines when you are ready for them to move in on the base. Command out.",
			8,
			"RadioAmbient6"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 3.0;
	
	// Add support item
	[[(leader phoenix), "MarinesAttack"], BIS_fnc_addCommMenuItem] remoteExec ["call", (leader phoenix)];
	sleep 1.0;
	
	// Message player when marines are attacking
	[] spawn
	{
		waitUntil {sleep 1.0; !isNil "marinesGo"};
		
		// Marine message
		[
			[
				"Marine",
				"Copy that, Phoenix. We're moving in now. Out.",
				10,
				"RadioAmbient2"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	};
	
	// Marine support hint
	parseText format ["<t color='#FFFFFF' size='3'>The Marines are standing by!</t><br/><t color='#469CED' size='1.3'>When you are ready, signal them to assault the base!</t>"] remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated)];
	
	// Change terminal color when gun deactivated
	[_orbGunTerm1] spawn
	{
		_term1 = _this select 0;
		waitUntil {sleep 1.0; (_term1 getVariable "isHacked")};
		[dTerm_1a, "green", "green", "green"] call BIS_fnc_DataTerminalColor;
		[dTerm_1b, "green", "green", "green"] call BIS_fnc_DataTerminalColor;
	};
	
	// Change terminal color when gun deactivated
	[_orbGunTerm2] spawn
	{
		_term2 = _this select 0;
		waitUntil {sleep 1.0; (_term2 getVariable "isHacked")};
		[dTerm_2a, "green", "green", "green"] call BIS_fnc_DataTerminalColor;
		[dTerm_2b, "green", "green", "green"] call BIS_fnc_DataTerminalColor;
	};
	
	// Base tasks completed
	[] spawn
	{
		waitUntil {sleep 1.0; ["towerTask", "aaTask", "orbGunTask"] call FHQ_fnc_ttAreTasksCompleted};
		sleep 5.0;
		
		["baseTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
		"baseMkr" setMarkerColor "ColorBLUFOR";
		sleep 3.0;
		
		// Save game in singleplayer
		if (!isMultiplayer && savingEnabled) then {saveGame;};
		sleep 2.0;

		// Command message
		[
			[
				"Command",
				"All callsigns be advised, we are detecting hostile forces converging on your position from multiple directions that we've marked on your maps. Recommend you dig in.",
				10,
				"RadioAmbient6"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		
		// Create markers
		_baseAttMkr1 = createMarker ["baseAttackMkr1", [6884.41,10249.2]]; 
		"baseAttackMkr1" setMarkerType "mil_arrow"; 
		"baseAttackMkr1" setMarkerColor "ColorOPFOR"; 
		"baseAttackMkr1" setMarkerDir 319.0;
		
		_baseAttMkr2 = createMarker ["baseAttackMkr2", [6035.17,10116.8]]; 
		"baseAttackMkr2" setMarkerType "mil_arrow"; 
		"baseAttackMkr2" setMarkerColor "ColorOPFOR"; 
		"baseAttackMkr2" setMarkerDir 37.0;
		
		_baseAttMkr3 = createMarker ["baseAttackMkr3", [5532.41,10640]]; 
		"baseAttackMkr3" setMarkerType "mil_arrow"; 
		"baseAttackMkr3" setMarkerColor "ColorOPFOR"; 
		"baseAttackMkr3" setMarkerDir 51.5;
		
		_baseAttMkr4 = createMarker ["baseAttackMkr4", [5729.77,11084.3]]; 
		"baseAttackMkr4" setMarkerType "mil_arrow"; 
		"baseAttackMkr4" setMarkerColor "ColorOPFOR"; 
		"baseAttackMkr4" setMarkerDir 133.0;
		
		// Commence base assault
		execVM "Scripts\baseAttack.sqf";
		sleep 12.0;

		// Command message
		[
			[
				"Command",
				"The fleet is mobile and en route to your position. ETA 5 mikes. Hold the area until we get there!",
				10,
				"RadioAmbient8"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		
		// Assign base defense task
		[phoenix, [["defendTask", "primTasks"], "<font color='#469CED'>Defend</font> the <marker name='baseMkr'>abandoned UNSC base</marker> from a large <font color='#469CED'>insurgent counterattack</font>.", "Defend the Base", "", getMarkerPos "baseMkr", "assigned", "DEFEND"]] call FHQ_fnc_ttAddTasks;
		
		// Fleet arrival time to base
		sleep random [285, 300, 315]; // Wait about 5 minutes
		
		// Delete the music event handler
		if (("Music" call BIS_fnc_getParamValue) == 1) then 
		{
			if (isDedicated) then
			{
				[["MusicStop", ehID]] remoteExec ["removeMusicEventHandler",-2,true]; // Remove everyones music event handlers
			}
			else
			{
				removeMusicEventHandler ["MusicStop", ehID]; // remove player host music event handler
			};
		};
		
		// Fade out music then fade in defense theme
		[5,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 5.0;
		"" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
		sleep 1.0;
		[5,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
		[["Lone_Wolf",29]]remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
		
		// Send in the fleet and complete the mission
		execVM "Scripts\fleetForce.sqf";
	};
};