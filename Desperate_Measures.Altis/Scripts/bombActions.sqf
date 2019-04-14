// Add disarm action to bombs in the factory

if (!isServer) exitWith {};

{
	_x setVariable ["isDisarmed", false, true];
	
	// Create disarm action for every connected client
	[
		_x,                                                                           		// Object the action is attached to
		"<t color='#469CED'>Disarm Bomb</t>",                                                    	// Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",                      			// Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",                     			 // Progress icon shown on screen
		"((_target distance _this < 3) && (alive _target))",                                      	// Condition for the action to be shown
		"((_caller distance _target < 3) && (alive _target) && (!isNull _this))",                   	// Condition for the action to progress
		{},                                                            						 // Code executed when action starts
		{																					// Code executed on every progress tick
			hint parseText "<t size='1.5' font='PuristaSemiBold' color='#FFFFFF'>Disarming...</t>"; 					
		},
		{																					// Code executed on completion
			_target = _this select 0;
			_id = _this select 2;
			
			[_target, _id] remoteExec ["BIS_fnc_holdActionRemove", [0,-2] select (isMultiplayer && isDedicated), _target ];
			
			hint parseText "<t size='1.5' font='PuristaBold' color='#2EFE2E'>Bomb Disarmed!</t>"; 

			// Set hack variable to false
			_target setVariable ["isDisarmed", true, true];
		},                                                									
		{																					// Code executed on interrupted
			hint parseText "<t size='1.5' font='PuristaBold' color='#D22E2E'>Disarm Stopped</t>";
		},                                                                 
		[],                                                                         	 // Arguments passed to the scripts as _this select 3
		7,                                                                            // Action duration [s]
		10,                                                                                  // Priority
		true,                                                                                // Remove on completion
		false                                                                                // Show in unconscious state 
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select (isMultiplayer && isDedicated), _x];

}forEach [bomb_1,bomb_2,bomb_3,bomb_4];