/*
    Filename: fn_getTime.sqf
    Author: AlphaDog
    
    Description:
	Returns the exact time as a string.
	NOTE: Will be called on server!!!
   
    Parameter(s):
    NONE
   
	Example:
	[] call AD_fnc_getTime;
*/

private ["_date","_hour","_minute"];

// Get the date
_date = date;
_hour = _date select 3;
_minute = _date select 4; 

if (_hour < 10) then 
{
	_hour = format["0%1",_hour]; // Add a leading zero to the number
};

if (_minute < 10) then 
{
	_minute = format["0%1",_minute]; // Add a leading zero to the number
};

_time = format["%1:%2",_hour,_minute];

_time // Return the time