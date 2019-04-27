/*
    Filename: fn_terminalAction.sqf
    Author: AlphaDog
    
    Description:
	Adds action to a data terminal to download intel from it. Plays animations to mimic th download from terminal. Option to have the terminal close after use.
	NOTE: Will be called on server!!!
   
    Parameter(s):
    0: Object  - The terminal to have the action applied to it.
	1: String - Custom action name.
	2: String - Text displayed while doing the action.
	3: String - Text displayed when action is done.
	4: (Optional) Boolean - Close the terminal after it's been hacked.
	
   Example:
   [terminal, "Some Custom Name", "downloading", "finished", false] call AD_fnc_terminalAction;
*/

if (!isServer) exitwith {};

private ["_terminal", "_actionText", "_textDL", "_textDone", "_closeOnUse"];

params [["_terminal", objNull, [objNull], 1], ["_text", "", [""], 1], ["_textDL", "", [""], 1], ["_textDone", "", [""], 1], ["_closeOnUse", true, [true], 1]];

if (!(_terminal isKindOf "Land_DataTerminal_01_F")) exitwith {["ERROR: %1 must be a data terminal", _terminal] call BIS_fnc_error; false};
if (_text == "" || _textDL == "" || _textDone == "") exitwith {["ERROR: Action text is empty!"] call BIS_fnc_error; false};

// Set custom name in text
_actionText = format ["<t color='#D22E2E'>%1</t>", _text];

// Add action to terminal for all players and JIPs
[_terminal, 
	[ 	
		_actionText,
		{	
			_target = _this select 0;
			_caller = _this select 1;
			_id = _this select 2;
			_closeTerm = _this select 3 select 0;
			_textDL = _this select 3 select 1;
			_textDone = _this select 3 select 2;
			
			if (!isNull _caller) then
			{
			
				[_target, _id] remoteExec ["removeAction",[0,-2] select (isMultiplayer && isDedicated),true];
				
				_relPos = _target modelToWorld [0,-0.77,0]; 
				_caller setPos _relPos;
				_caller setDir (getDir _target);
				[_caller,"Acts_TerminalOpen"] remoteExec ["switchMove",[0,-2] select (isMultiplayer && isDedicated)];
				sleep 1.0;
				[_target, 3] call BIS_fnc_dataTerminalAnimate;
				
				_output =
					[
						[_textDL,"<t size='0.7' font='PuristaSemiBold' shadow='1'>%1</t>",15],
						[_textDone,"<t color='#D22E2E' size='0.7' font='PuristaBold' shadow='1'>%1</t>",15]	
					];
					
				[_output,-safezoneX,0.7,"<t align='center'>%1</t>"] spawn BIS_fnc_typeText;
				sleep 5.8;
				
				_weaponType = switch (toLower (currentWeapon _caller)) do
				{
					case (toLower (primaryWeapon _caller)): {"rfl"};
					case (toLower (handgunWeapon _caller)): {"pst"};
					default {"non"};
				};

				_anim = format ["AmovPknlMstpSlowW%1Dnon",_weaponType];
				[_caller,_anim] remoteExec ["switchMove",[0,-2] select (isMultiplayer && isDedicated)];
				
				if (_closeTerm) then 
				{
					[_target, 0] call BIS_fnc_dataTerminalAnimate;
				};
				
				sleep 1.0;
				_target setVariable ["termHacked", true, true];
			};
		},
		[_closeOnUse, _textDL, _textDone],
		10,
		true,
		true,
		"",
		"((_target distance _this) < 3)"
	] 
] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), true ];

_terminal setVariable ["termHacked", false, true];

true
