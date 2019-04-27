/*
    Filename: fn_crossMkr.sqf
    Author: AlphaDog
    
    Description:
	Crosses off a marker with an 'X'. To delete the marker, use the command: deleteMarker "xMkr_UniqueID";
	Be sure to include the unique ID you assigned the marker when it was created.
	NOTE: Will be called on server!!!
   
    Parameter(s):
	0: String - Marker to be crossed out
	1: String - Color of the marker
	2: String - Unique ID attached to the X marker.  EXAMPLE: xMkr_UniqueID
	
	Returns: String - The created marker's name.
   
	Example:
	["marker", "ColorRed", "UniqueID"] call AD_fnc_crossMkr;
*/

if (!isServer) exitWith {};

private ["_mkr", "_mkrColor", "_id"];

params [["_mkr", "", [""], 1], ["_mkrColor", "", [""], 1], ["_id", "", [""], 1]];

if (_mkr == "" || _mkrColor == "" || _id == "") exitwith {["ERROR: One of the marker fields is blank!"] call BIS_fnc_error; false};

// Create marker
_mkrName = "xMkr_"+_id;
_xMkr = createMarker [_mkrName, (getMarkerPos _mkr)];
_mkrName setMarkerColor _mkrColor;
_mkrName setMarkerType "hd_destroy";
_mkrName setMarkerDir 140;

_mkrName 