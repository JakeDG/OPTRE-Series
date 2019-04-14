/*
    Filename: fn_subTitle.sqf
    Author: AlphaDog
    
    Description:
	Displays a subtitle of a person speaking. This subtitle will be broadcast to every player on the server. Should be used for radio comms.
	NOTE: Will be called on server!!!
   
    Parameter(s):
    0: String - The speaker.
    1: String - What the speaker should say.
    2: Number - The amount of time the subtitle is displayed.
    3: (Optional) String - Color of speaker text - default: "#469CED" for my OPTRE missions or "#D22E2E" for my SABRE missions
    4: (Optional) Number - The time it takes for the subtitle to fade in - default: 0.25 seconds
    5: (Optional) Number - The resource layer that the test is displayed on - default: 198
    
   
   Example:
   ["HQ", "Looks like we've got trouble.", 10] call AD_fnc_subtitle;
*/

if (!isServer) exitwith {};

_this spawn 
{
	#define FADE_DURATION 0.5
	#define TEXT_COLOR "#469CED"
	
	private ["_speaker", "_phrase", "_displayTime", "_fadeTime", "_sound", "_spkrColor"];
	
	params [
		["_speaker", "", [""], 1], 
		["_phrase", "", [""], 1], 
		["_displayTime", 0, [999], [0,1]], 
		["_sound", "", [""],[0,1]],
		["_spkrColor", TEXT_COLOR, [""], [0,1]]
	];

	waitUntil {isNil "AD_subtitle_running"};
	AD_subtitle_running = true;
	
	// Create display and control
	disableSerialization;
	titleRsc ["RscDynamicText", "PLAIN"];
	private "_display";
	waitUntil {_display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)};
	private _ctrl = _display displayCtrl 9999;
	uiNamespace setVariable ["BIS_dynamicText", displayNull];

	// Position control
	private _w = 0.4 * safeZoneW;
	private _x = safeZoneX + (0.5 * safeZoneW - (_w / 2));
	private _y = safeZoneY + (0.73 * safeZoneH);
	private _h = safeZoneH;
	
	_ctrl ctrlSetPosition [_x,_y,_w,_h];

	// Hide control
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 0;
	
	// Show subtitle
	_text = parseText format ["<t align = 'center' shadow = '2' size = '0.6'><t color = '%1'>" + _speaker + ":</t> <t color = '#d0d0d0'>" + _phrase + "</t></t>",_spkrColor];
	_ctrl ctrlSetStructuredText _text;
	_ctrl ctrlSetFade 0;
	_ctrl ctrlCommit FADE_DURATION;
	
	// Play sound
	if (_sound != "") then { [_sound] call AD_fnc_soundAmp };
	
	// display the subtitle for the specified time
	sleep _displayTime;

	// Hide subtitle
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit FADE_DURATION + 0.5;

	AD_subtitle_running = nil;
};

true