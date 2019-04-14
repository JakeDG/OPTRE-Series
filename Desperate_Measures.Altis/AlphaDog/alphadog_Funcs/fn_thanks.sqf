/*
    Filename: fn_thanks.sqf
    Author: AlphaDog
    
    Description:
	Thank the player for playing the mission using their steam name
	NOTE: Should be called on clients individually
   
    Parameter(s):
    None
   
   Example:
   N/A
*/

private ["_playerName", "_text"];

_playerName = profileNameSteam;

_text =
		[
			["Thank you for playing, ","%1",5],
			[_playerName + "!","<t color='#D22E2E'>%1</t><br/>",15],
			["Hope you enjoyed!","%1",15]
		]; 

[_text,-safeZoneX, safeZoneY+safeZoneH-0.4,"<t align='center'>%1</t>"] spawn BIS_fnc_typeText;

true