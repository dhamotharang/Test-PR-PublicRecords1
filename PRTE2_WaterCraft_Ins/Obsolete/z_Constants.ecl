/********************************************************************************************************** 
	Name: 			_Constants
	Created On: 07/15/2013
	By: 				ssivasubramanian
	Desc: 			Holds the non-functional constants needed by the water craft build module 	
***********************************************************************************************************/

IMPORT _Control, ut, PRTE2_Common;
	 
EXPORT _Constants := MODULE	
	EXPORT Version								:= 'PRTE2';
			
	EXPORT CSVOutFieldSeparator		:= ',';
	EXPORT CSVOutQuote						:= '"';
	
	// Support
	EXPORT EmailTargetFail				:= PRTE2_Common.Email.EmailTargetFail;	 
	EXPORT EmailTargetSuccess			:= PRTE2_Common.Email.EmailTargetSuccess;	 
	
	EXPORT FULL_REBUILD_INDICATOR := TRUE;
	EXPORT ADD_NEW_ONLY_INDICATOR := FALSE;
	
END;