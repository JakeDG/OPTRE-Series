/*
    Filename: fn_isNight.sqf
    Author: AlphaDog
    
    Description:
	Check if it's night time and return true or false
	NOTE: Will be called on server!!!
   
    Parameter(s):
    NONE
   
	Example:
	[] call AD_fnc_isNight;
*/

if (!isServer) exitWith {};

private ["_evening","_earlyMrn","_isNight"];

_evening = 19.5;
_earlyMrn = 4.5;

if (isNil "_isNight") then 
{
	if (daytime >= _evening || (daytime >= 0 && daytime < _earlyMrn)) then 
	{
		_isNight = true;
	}
	else
	{
		_isNight = false;
	};
};

_isNight // Return value