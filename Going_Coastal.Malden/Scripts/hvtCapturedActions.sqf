/* 
* This script will run if the officer is forced to surrender.
* A capture action will be added.
* Once captured, move, drop, and load actions will be added to the officer
*/

_unit = _this select 0;

// Remove all weapons, setCaptive, and make unit do the surrender animation
removeAllWeapons _unit;
_unit setCaptive true;
_unit playMoveNow "AmovPercMstpSsurWnonDnon";

// Disable AI features
_unit disableAI "AUTOCOMBAT";
_unit disableAI "FSM";
_unit disableAI "CHECKVISIBLE";
_unit disableAI "TARGET";
_unit disableAI "PATH";
_unit disableAI "MOVE";

// Add capture action
[
	_unit,                                                                           	// Object the action is attached to
	"Capture <t color='#469CED'>Officer</t>",                                                 // Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",                      			// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",                     			 // Progress icon shown on screen
	"((_target distance _this < 3) && (alive _target))",                                      	// Condition for the action to be shown
	"((_caller distance _target < 3) && (alive _target) && (!isNull _caller))",                    // Condition for the action to progress
	{},                                                                                  // Code executed when action starts
	{},                                                                                  // Code executed on every progress tick
	{
		_target = _this select 0;
		_caller = _this select 1;
		_id = _this select 2;
		_arguments = _this select 3;

		[_target, _id] remoteExec ["BIS_fnc_holdActionRemove", [0,-2] select (isMultiplayer && isDedicated), _target ];
		[_target, "Acts_AidlPsitMstpSsurWnonDnon03"] remoteExec ["switchMove", [0,-2] select (isMultiplayer && isDedicated), _target ];
		
		// Make the HVT join the player's group. This will ensure that the HVT stays in a vehicle he's loaded into
		[_target] joinsilent (group _caller);
	
		// Set captured variable to false
		_target setVariable ["isCaptured", true, true];
	
		// Set carried variable to false, var tracks to see if unit is being carried
		_target setVariable ["isCarried", false, true];
		
		// Add HVT move actions
		[_target, 
			[ 	
				"<t color='#D22E2E'>Pickup HVT</t>",
				{	
					_target = _this select 0;
					_caller = _this select 1;
					_id = _this select 2;
					
					
					[_target,_caller] spawn  
					{
						_hvt = _this select 0;
						_caller = _this select 1;
					
						waitUntil {sleep 0.5; !alive _hvt || !alive _caller || !(_hvt getVariable "isCarried")}; 

						// Check if HVT is dead
						if (!alive _hvt) exitwith 
						{
							detach _hvt;
							{_caller removeaction _x} foreach [dropHVT,loadHVT];
						};
							
						// Check if player carrying HVT is dead or downed
						if (!alive _caller) exitwith
						{ 	
							detach _hvt;
							{_caller removeaction _x} foreach [dropHVT,loadHVT];
							_hvt setVariable ["isCarried",false,true];
						};	
					};  
						
					[_target] spawn 
					{
						_hvt = _this select 0;
						
						_hvt switchMove "InBaseMoves_HandsBehindBack2"; 
						while {alive _hvt && _hvt getVariable "isCarried" && !(objectParent _hvt isKindOf "man")} do 
						{
							waitUntil {animationState _hvt != "InBaseMoves_HandsBehindBack2"}; 
							_hvt switchMove "InBaseMoves_HandsBehindBack2";
						};
					};

					_target attachto [_caller,[-.25,.8,0]];

					// Set carried variable to true
					_target setVariable ["isCarried", true, true];
					
					// Add action to put HVT down on the ground
					dropHVT = _caller addaction 
					[
						"<t color='#B0171F'>Put Down HVT</t>",
						{	
							_target = _this select 0;
							_caller = _this select 1;
							_id = _this select 2;
							_arguments = _this select 3;
			
							_hvtUnit = _arguments select 0;

							{_caller removeaction _x} foreach [dropHVT,loadHVT];

							detach _hvtUnit; 

							// Set carried variable to false
							_hvtUnit setVariable ["isCarried", false, true];
							
							waitUntil {animationState _hvtUnit != "InBaseMoves_HandsBehindBack2"}; 
							[_hvtUnit, "Acts_AidlPsitMstpSsurWnonDnon03"] remoteExec ["switchMove", [0,-2] select (isMultiplayer && isDedicated), _hvtUnit ];
						},
						[_target],
						10,
						true,
						true,
						"",
						"(alive _target)"
						,3
						,false
					];
					
					// Create action to load HVT into pelican
					loadHVT = _caller addAction
					[
						"<t color='#B0171F'>Load HVT into Vehicle</t>",
						{	
							_target = _this select 0;
							_caller = _this select 1;
							_id = _this select 2;
							_arguments = _this select 3;
			
							_hvtUnit = _arguments select 0;
							
							_loadVehicle =  cursorObject; // Return the vehicle the player is looking at 
							
							_cargo = fullCrew [_loadVehicle, "cargo", true];
							_turrets = fullCrew [_loadVehicle, "turret", true];
							_seatNum = "";
							
							// Find an available cargo seat
							if (!(count _cargo isEqualTo 0)) then
							{
								reverse _cargo;
								_seatNum = [_cargo, [0, 2]] call BIS_fnc_returnNestedElement;
							}
							else // Find an available turret seat
							{
								_seatNum =  count _turrets - 1;
							};
							
							
							if (_seatNum isEqualType 0 && _loadVehicle emptyPositions "cargo" > 0) then
							{
								
								detach _hvtUnit;
								
								// Set carried variable to false
								_hvtUnit setVariable ["isCarried", false, true];
								
								{_caller removeaction _x} foreach [dropHVT,loadHVT];
								
								waitUntil {animationState _hvtUnit != "InBaseMoves_HandsBehindBack2"};
								
								_hvtUnit assignAsCargoindex [_loadVehicle,_seatNum];	
								[_hvtUnit,[_loadVehicle,_seatNum]] remoteExec  ["moveincargo", [0,-2] select isDedicated];
								
								//[_hvtUnit, _loadVehicle] remoteExec ["moveInCargo",[0,-2] select (isMultiplayer && isDedicated)];
								
								//_hvtUnit setUnloadInCombat [false,false]; // Stops HVT from leaving the vehicle it's put in
								
								(group _hvtUnit) addvehicle _loadVehicle; // Add the vehicle to the HVT's group
								
								
								
								waitUntil {!(isNull objectParent _hvtUnit)}; // waitUntil HVT is in a vehicle
								
								
							}
							else
							{
								hintsilent "No cargo seats available in the vehicle!";
							};
							
						},
						[_target],
						10,
						true,
						true,
						"",
						"(alive _target) && (cursorObject isKindOf 'air') && _this distance cursorObject < 7"
						,3
						,false
					];
				},
				[_target],
				10,
				true,
				true,
				"",
				"(_target distance _this < 3) && (alive _target) && !(_target getVariable 'isCarried')"
			] 
		] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), _target ];
	},                                                									// Code executed on completion
	{},                                                                                  // Code executed on interrupted
	[_unit],                                                                           // Arguments passed to the scripts as _this select 3
	5,                                                                                  	// Action duration [s]
	10,                                                                                  // Priority
	true,                                                                                // Remove on completion
	false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select (isMultiplayer && isDedicated), _unit];
