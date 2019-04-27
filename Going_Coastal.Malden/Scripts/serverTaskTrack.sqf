if (!isServer) exitWith {};

// Main tasks thread
[] spawn 
{
	// Lavalle task
	[] spawn
	{
		waitUntil {sleep 1.0; !isNil "lavalleCleared"};
		["lavalleTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		//["lavalleMkr", "ColorRed", "X_lavalle"] call AD_fnc_crossMkr;
		{_x setMarkerColor "ColorBlufor"} forEach ["lavalleMkr","lavalleAreaMkr_1","lavalleAreaMkr_2"];
		sleep 3.0;
		
		// Save the game in singleplayer
		if (!isMultiplayer && savingEnabled) then {saveGame;};
		sleep 1.0;
	};
		
	// T-junction task
	[] spawn
	{
		waitUntil {sleep 1.0; !isNil "tJuncCleared"};
		["tJuncTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		//["tJuncMkr", "ColorRed", "X_tJunc"] call AD_fnc_crossMkr;
		{_x setMarkerColor "ColorBlufor"} forEach ["tJuncMkr","tJuncAreaMkr_1","tJuncAreaMkr_2"];
		sleep 3.0;
		
		// Save the game in singleplayer
		if (!isMultiplayer && savingEnabled) then {saveGame;};
		sleep 1.0;
	};
		
	// Farm task
	[] spawn
	{
		waitUntil {sleep 1.0; !isNil "farmCleared"};
		["farmTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		//["farmMkr", "ColorRed", "X_farm"] call AD_fnc_crossMkr;
		{_x setMarkerColor "ColorBlufor"} forEach ["farmMkr","farmAreaMkr_1","farmAreaMkr_2"];
		sleep 3.0;
		
		// Save the game in singleplayer
		if (!isMultiplayer && savingEnabled) then {saveGame;};
		sleep 1.0;
	};

	// Complete highway tasks
	waitUntil {sleep 1.0; ["lavalleTask", "tJuncTask", "farmTask"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 3.0;
	["highwayTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 5.0;
	
	
	/**********************************************************************************************************************************************/
	

	// HQ speaks
	[
		[
			"Command",
			"Good work, Phoenix. Highway-99 is almost ours. All that stands in our way is the town of La Pessangne to the southwest.",
			10,
			"RadioAmbient2"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 11.0;
	
	[
		[
			"Command",
			"Phoenix, you are to assault the Town of La Pessangne and neutralize all threats present in the town.",
			8,
			"RadioAmbient6"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 2.0;
	
	// Create town assault
	[phoenix, [["townTasks", "primTasks"], "Assault the town", "Assault La Pessangne", "", getMarkerPos "townMkr", "assigned", "ATTACK"]] call FHQ_fnc_ttAddTasks;
	sleep 10.0;
	
	// HQ speaks
	[
		[
			"Command",
			"Phoenix, be advised, intel suggests there is a mechanized URF garrison defending the town. Expect heavy resistance, out.",
			10,
			"RadioAmbient8"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 2.0;
	
	// Create clear town center task 	
	[phoenix, [["centerTask", "townTasks"], "Secure Town Center", "Secure Town Center", "", "", "created", "ATTACK"]] call FHQ_fnc_ttAddTasks;
	
	// Town center task
	[] spawn
	{
		waitUntil {sleep 1.0; !isNil "townCleared"};
		["centerTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	};
	sleep 5.0;
	
	// Create destroy AT defenses task
	[phoenix, [["atGunTask", "townTasks"], "Clear AT Defenses", "Clear AT Defenses", "", "", "created", "DESTROY"]] call FHQ_fnc_ttAddTasks;
	sleep 2.0;
	
	// AT Task
	[] spawn
	{
		waitUntil {sleep 1.0; {{alive _x} count (crew vehicle _x) == 0} count [at_1] == 1};
		["atGunTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	};
	sleep 5.0;
	
	// Create eliminate vehicles task
	[phoenix, [["vehTask", "townTasks"], "Eliminate vehicles", "Eliminate Armor", "", "", "created", "CAR"]] call FHQ_fnc_ttAddTasks;
	
	// Eliminate vehicles task
	[] spawn
	{
		waitUntil {sleep 1.0; {alive _x || canMove _x} count [veh_1] == 0};
		["vehTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	};
	
	// Town tasks completed
	waitUntil {sleep 1.0; ["atGunTask", "centerTask", "vehTask"] call FHQ_fnc_ttAreTasksCompleted};
	["townTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	"townMkr" setMarkerColor "ColorBLUFOR";
	sleep 3.0;
	
	/*******************************************************************************************************************************************/
	
	[] spawn 
	{
		// HQ speaks
		[
			[
				"Command",
				"Excellent job, Phoenix. With that town cleared we can establish a new front on Malden and hit the Innies were it hurts.",
				10,
				"RadioAmbient2"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 12.0;
		
		[
			[
				"Command",
				"We're sending a Pelican to extract you guys and drop off some Marines to hold the town, out.",
				10,
				"RadioAmbient8"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 16.0;
		
		// Kilo 2-2 speaks
		[
			[
				"Kilo 2-2",
				"Phoenix, this is Kilo 2-2, we're on own way to the extraction point. ETA: 1 minute, out.",
				10,
				"RadioAmbient6"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	};

	// Create mock extraction objective
	[phoenix, ["extMockTask", "<marker name='extMkr'>Extract</marker> from the area via <font color='#469CED'>Kilo 2-2's Pelican</font>", "Extract","Extract", getMarkerPos "extMockMkr", "assigned"]] call FHQ_fnc_ttAddTasks;
	
	// Set extract marker
	_extMockPos = createMarker ["extMockMkr_1", getMarkerPos "extMockMkr"];
	_extMockPos setMarkerText "Extraction";
	_extMockPos setMarkerColor "ColorBlufor";
	_extMockPos setMarkerType "hd_pickup";
	
	// Run pelican crash script and wait until the pelican has "crashed"
	_crashHandle = execVM "Scripts\pelicanCrash.sqf";
	
	waitUntil {sleep 1.0; scriptDone _crashHandle};
	sleep 5.0;
	
	// Kilo 2-2 and command speak
	[
		[
			"Kilo 2-2",
			"*Cough* Kilo 2-2 to command, we've crashed in a clearing in the woods south of La Pessangne at grid 028049. *Cough* Requesting MEDEVAC. Multiple wounded and KIA.",
			12,
			"RadioAmbient8"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	
	// Set crash site marker
	_crashSitePos = createMarker ["crashSiteMkr_1", getMarkerPos "crashSiteMkr"];
	_crashSitePos setMarkerText "Kilo 2-2's Crash Site";
	_crashSitePos setMarkerColor "ColorBlufor";
	_crashSitePos setMarkerType "hd_objective";
	sleep 14.0;
	
	[
		[
			"Command",
			"Copy Kilo 2-2. MEDEVAC is unavailable until the anti-air threat in your area is dealt with. We are dispatching Phoenix to your location to assist, out.",
			12,
			"RadioAmbient2"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 14.0;
	
	[
		[
			"Command",
			"Phoenix, you need to get to Kilo 2-2's crash site ASAP to help them while we try to locate the position of the anti-air threat, out.",
			10,
			"RadioAmbient6"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 2.0;
	
	// Create pelican crash site objective
	[phoenix, [["crashTask", "primTasks"], "Advance to the crash site", "Advance to Crash Site", "", getMarkerPos "crashSiteMkr", "assigned", "RUN"]] call FHQ_fnc_ttAddTasks;

	// Timer to get to crash site
	_timer = 0;
	
	while {_timer <= 500 && isNil "atCrashSite"} do
	{
		_timer = _timer + 1;
		sleep 1.0;
	};
	
	// if players have not arrived by the time the countdown is over, then fail the "Advance to Crash Site objective" and start the assault
	if (isNil "atCrashSite") then
	{
		["crashTask", "failed"] call FHQ_fnc_ttSetTaskState;
		sleep 3.0;
		
		// Save the game in singleplayer
		if (!isMultiplayer && savingEnabled) then {saveGame;};
		sleep 1.0;
	
		[
			[
				"Command",
				"Kilo 2-2, be advised we are detecting multiple hostiles closing from several directions towards the crash site. Recommend you dig in and hold your position, out.",
				12,
				"RadioAmbient2"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 14.0;
		
		[
			[
				"Kilo 2-2",
				"Roger Command, Kilo 2-2 copies, out. Phoenix, where the hell are you guys! We need you at the crash site ASAP!",
				12,
				"RadioAmbient6"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 14.0;
		
		// Create defend crash site objective
		[phoenix, [["crashDefendTask", "primTasks"], "Defend the crash site", "Defend the Crash Site", "", getMarkerPos "crashSiteMkr", "assigned","DEFEND"]] call FHQ_fnc_ttAddTasks;
	}
	else	 // Give the players who succeeded in getting to the crash site at a reasonable haste some extra time to prepare for the assault
	{
		["crashTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		sleep 3.0;
		
		// Kilo 2-2 speaks
		[
			[
				"Kilo 2-2",
				"Phoenix, its good to see you guys. We've got multiple wounded and...",
				8,
				"RadioAmbient6"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 10.0;
		
		// HQ speaks
		[
			[
				"Command",
				"Kilo 2-2, be advised we are detecting multiple hostiles closing in from several directions towards the crash site. Recommend you dig in and hold your position, out.",
				12,
				"RadioAmbient2"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 14.0;
		
		// Kilo 2-2 speaks
		[
			[
				"Kilo 2-2",
				"Roger Command, Kilo 2-2 copies all, out. Phoenix, we don't have long until they are right on top of us. There's some supplies that survived the crash. Perhaps you can make some use of it. The marines and my crew will do what we can.",
				14,
				"RadioAmbient8"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 2.0;
		
		// Create defend crash site objective
		[phoenix, [["crashDefendTask", "primTasks"], "Defend the crash site", "Defend the Crash Site", "", getMarkerPos "crashSiteMkr", "assigned","DEFEND"]] call FHQ_fnc_ttAddTasks;
		
		// Give players who show up on-time between 90 seconds to 2 minutes to setup a defense
		sleep random [10,15,20];
		
	};
	
	// Run crash site assault script
	_assaultHandle = execVM "Scripts\crashSiteAssault.sqf";

	// Defend crash site objective
	waitUntil {sleep 1.0; scriptDone _assaultHandle};
	
	["crashDefendTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 5.0;
	
	// Save the game in singleplayer
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	sleep 1.0;
	
	// Kilo 2-2 speaks
	[["RadioAmbient2"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	["Kilo 2-2", "Looks like that was the last of them! Suck on that you Innie bastards! Thanks for the assist, Phoenix. We owe you one.", 10] call AD_fnc_subtitle;
	// Kilo 2-2 speaks
	[
		[
			"Kilo 2-2",
			"Suck on that you Innie bastards! Looks like that was the last of them! Thanks for the assist, Phoenix. We owe you one.",
			10,
			"RadioAmbient2"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 12.0;
	
	// If anti-air is still alive then assign the objective to destroy it
	if (alive aa_1) then
	{
		// HQ speaks
		[
			[
				"Command",
				"Phoenix, we've scanned the area for radar signatures and located the SAM site that took out Kilo 2-2. It's just northwest of Kilo 2-2's crash site at grid 024051.",
				10,
				"RadioAmbient8"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 12.0;
		
		[
			[
				"Command",
				"Move to that area and destroy the anti-air so we can dispatch MEDEVAC teams to Kilo 2-2's position, out.",
				10,
				"RadioAmbient6"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 2.0;
		
		// Create destroy anti-air objective
		[phoenix, [["aaTask", "primTasks"], "Destroy anti-air", "Destroy Anti-Air", "", getMarkerPos "aaMkr", "assigned", "DESTROY"]] call FHQ_fnc_ttAddTasks;
		
		// Destroy anti-air objective
		waitUntil {sleep 1.0; !alive aa_1};
	
		["aaTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		sleep 3.0;
		
		// Save the game in singleplayer
		if (!isMultiplayer && savingEnabled) then {saveGame;};
		sleep 1.0;
	}
	else
	{
		// HQ comments about Phoenix destroying the AA earlier
		[["RadioAmbient2"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		["Command", "Phoenix, we've scanned the whole area and it looks like you destroyed the only anti-air threat in the area earlier. We're dispatching the MEDEVAC teams now.", 10] call AD_fnc_subtitle;
		[
			[
				"Command",
				"Phoenix, we've scanned the whole area for radar signatures and it looks like you destroyed the only anti-air threat in the area earlier. We are dispatching the MEDEVAC teams to Kilo 2-2's position now.",
				12,
				"RadioAmbient2"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 14.0;
	};
	
	// HQ speaks
	[
		[
			"Command",
			"Nice one, Phoenix. With that AA neutralized we're dispatching the MEDEVAC teams now. However, we've got a new task for you guys. Stand by.",
			10,
			"RadioAmbient8"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 12.0;
	
	[
		[
			"Command",
			"Some of the Marines from Bravo company have made it to La Pessangne. They are reporting that they've recovered intel saying that a URF officer by the name of Colonel Adams fell back to the Hamlet of Arette once you guys took Highway-99.",
			14,
			"RadioAmbient2"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 16.0;
	
	[
		[
			"Command",
			"If these these reports are true, then we could deal a huge blow to the innies.",
			8,
			"RadioAmbient6"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 10.0;
	
	[
		[
			"Command",
			"Phoenix, your new objective is to move to Arette and kill or capture Colonel Adams using any means necessary. Good luck, out.",
			10,
			"RadioAmbient8"
		], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 2.0;
	
	// Create capture or kill officer objective
	[phoenix, [["officerTask", "primTasks"], "Kill or capture officer", "Kill or Capture HVT", "", getMarkerPos "aretteMkr", "assigned", "KILL"]] call FHQ_fnc_ttAddTasks;
	
	// Make officer surrender if his guards are dealt with
	[] spawn
	{
		waitUntil {sleep 1.0; {alive _x} count [offGuard_1] == 0 || !alive insOfficer};
		
		// Force officer to surrender and add action to "capture him"
		if (alive insOfficer) then 
		{
			// Run officer captured script to create capture, move, and drop actions
			[insOfficer] execVM "Scripts\hvtCapturedActions.sqf";
		};
	};
	
	// Capture or kill officer objective
	waitUntil {sleep 1.0; !alive insOfficer || insOfficer getVariable "isCaptured"};
	
	["officerTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 5.0;
	
	// Check if players killed or captured officer
	if (alive insOfficer) then 
	{
		// HQ speaks
		[
			[
				"Command",
				"Nice job capturing the HVT, Phoenix. Now, keep him alive until we can extract you, over.",
				10,
				"RadioAmbient8"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 5.0;
		
		// Create a keep officer alive objective
		[phoenix, [["officerAliveTask", "primTasks"], "Keep the officer alive until he is safely extracted.", "Keep HVT Alive", "", insOfficer, "created", "DEFEND"]] call FHQ_fnc_ttAddTasks;
		sleep 3.0;
		
		[] spawn
		{
			waitUntil {sleep 1.0; !alive insOfficer};
			
			// Fail objective
			["officerAliveTask", "failed"] call FHQ_fnc_ttSetTaskState;
			sleep 3.0;
			
			// HQ Diag
			
			// Fail the mission
			["End_OfficerDown",false,true,false] remoteExec ["BIS_fnc_endMission"];
		};
		
		if (isNil "aretteCleared") then
		{
			
			// HQ Diag
			[
				[
					"Command",
					"Phoenix, before we can send extraction, you need to clear Arette of hostile forces, over.",
					6,
					"RadioAmbient8"
				], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 2.0;
			
			// Assign clear arette objective
			[phoenix, [["aretteTask","primTasks"], "Clear Arette of hostile forces.", "Secure Arette", "", getMarkerPos "aretteMkr", "assigned"]] call FHQ_fnc_ttAddTasks;
			
			// waitUntil arette cleared
			waitUntil {sleep 1.0; !isNil "aretteCleared"};
			
			// HQ Diag
			[
				[
					"Command",
					"Okay Phoenix, with Arette now secure, we are sending in Kilo 3-1 to extract you and the HVT.",
					6,
					"RadioAmbient8"
				], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 8.0;
			
			[
				[
					"Command",
					"Excellent job today gentlemen! Everything you've accomplished greatly assisted our offensive and the Marines on the front lines. See you back at base, out.",
					12,
					"RadioAmbient2"
				], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 2.0;
			
			// Run extract script
			execVM "Scripts\extract.sqf";
		}
		else
		{
			// HQ Diag
			[
				[
					"Command",
					"Okay Phoenix, with Arette now secure, we are sending in Kilo 3-1 to extract you and the HVT. ETA 2 minutes.",
					6,
					"RadioAmbient8"
				], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 8.0;
			
			[
				[
					"Command",
					"Excellent job today gentlemen! Everything you've accomplished greatly assisted our offensive and the Marines on the front lines. See you back at base, out.",
					12,
					"RadioAmbient2"
				], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 2.0;
			
			// Run extract script
			execVM "Scripts\extract.sqf";
		};
	}
	else // Have players leave the area on their own accord if they kill the officer
	{
		// HQ Diag
		[
			[
				"Command",
				"Phoenix, good job neutralizing Colonel Adams. That will deal a serious blow to the URF command.",
				10,
				"RadioAmbient6"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 12.0;
		
		[
			[
				"Command",
				"Now, leave the area by any means. You've done fine work today gentlemen. The West Coast of Malden is ours thanks to you. Command, out.",
				10,
				"RadioAmbient8"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 2.0;

		// Create markers that show the area players have to leave
		_extExtAltMkr_1 = createMarker ["extExtAtlrMkr_1", getPos leaveTgr];
		_extExtAltMkr_1 setMarkerShape "ELLIPSE";
		_extExtAltMkr_1 setMarkerSize [400, 400];
		_extExtAltMkr_1 setMarkerColor "ColorOPFOR";
		_extExtAltMkr_1 setMarkerBrush "FDiagonal";
		
		_extExtAltMkr_2 = createMarker ["extExtAtlrMkr_2", getPos leaveTgr];
		_extExtAltMkr_2 setMarkerShape "ELLIPSE";
		_extExtAltMkr_2 setMarkerSize [400, 400];
		_extExtAltMkr_2 setMarkerColor "ColorOPFOR";
		_extExtAltMkr_2 setMarkerBrush "Border";
		
		// Create leave the area objective
		[phoenix, ["extLeaveTask", "Leave the area by any means necessary.", "Leave the Area", "", getMarkerPos "extExtAtlrMkr_1", "assigned"]] call FHQ_fnc_ttAddTasks;
		
		// Extracted Alt. OBJECTIVE
		waitUntil {sleep 1.0; !isNil "extractedAlt"};
		
		// Extracted objective complete
		["extLeaveTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		
		activateKey "MissionCompleted";
		sleep 10.0;
		["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
	};
};