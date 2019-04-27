/*
    Filename: fn_getDate.sqf
    Author: AlphaDog
    
    Description:
	Returns the exact date as a string. Ex: July 3, 2017
	NOTE: Will be called on server!!!
   
    Parameter(s):
    NONE
   
	Example:
	[] call AD_fnc_getDate;
*/

private ["_date","_year","_month","_day"];

// Get the date
_date = date;
_year = _date select 0;
_month = _date select 1; 
_day = _date select 2; 

switch (_month) do 
{
	case 1: {_month = "January";};
	case 2: {_month = "February";};
	case 3: {_month = "March";};
	case 4: {_month = "April";};
	case 5: {_month = "May";};
	case 6: {_month = "June";};
	case 7: {_month = "July";};
	case 8: {_month = "August";};
	case 9: {_month = "September";};
	case 10: {_month = "October";};
	case 11: {_month = "November";};
	case 12: {_month = "December";};
};

_fullDate = format["%1 %2, %3",_month,_day,_year];

_fullDate  // Return date as month day, year