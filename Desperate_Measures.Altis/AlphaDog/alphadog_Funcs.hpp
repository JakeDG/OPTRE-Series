/* AlphaDog's Immersive Functions 
 * Copyright 2016 by Jacob Gidley (AlphaDog). All rights reserved. Use of this software
 * is at your own risk. The copyright holder is in no way responsible for damages
 * resulting from the use of any of the functions listed in this function library.
 * Distribution of the software is only allowed with EXPLICIT authorization from the author. * In addition, no changes are allowed to the software without the permission from the author.
 * Distribution of this software is strictly prohibited.
 */

class alphadog_Functions // Functions I wrote
	{
		tag = "AD";

		class mission_Functions 
		{
			file = "AlphaDog\alphadog_funcs";
			class ambDead {};
			class animHeliDoors {};
			class artyFire {};
			class clientLoaded {};
			class crossMkr {};
			class getDate {};
			class getTime {};
			class hack {};
			class hostage {};
			class isNight {};
			class moveToLeader {};
			class pickPut {};
			class pickPutHold {};
			class soundAmp {};
			class subtitle {};
			class terminalAction {};
			class terminalActionHold {};
			class thanks {};
		};
	};

class thirdParty_Functions	// Functions not written by me, but that I modified!!!
	{
		tag = "TP";
		
		class thirdParty 
		{
			file = "AlphaDog\3rdParty";
			class createFireEffect {};
		};
	};