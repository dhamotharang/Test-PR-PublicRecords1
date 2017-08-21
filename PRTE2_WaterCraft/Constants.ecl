/********************************************************************************************************** 
	Name: 			Constants
	Created On: 07/15/2013
	By: 				ssivasubramanian
	Desc: 			Holds the non-functional constants needed by the water craft build module 	
***********************************************************************************************************/

IMPORT _Control, ut, PRTE2_Common, PRTE2_Watercraft, fcra;
	 
EXPORT Constants := MODULE	
	
//Base/Input/Key Prefix
	EXPORT IN_PREFIX 		:= '~prte::in::watercraft';
	EXPORT BASE_PREFIX	:= '~prte::base::prte2::watercraft';
	EXPORT KEY_PREFIX		:= '~prte::key::watercraft::';
		
// autokey
	EXPORT	ak_keyname 									:= KEY_PREFIX + '@version@::autokey::';
	EXPORT	ak_logical(string filedate) := KEY_PREFIX + filedate + '::autokey::';
	EXPORT	ak_qa_keyname 							:= KEY_PREFIX + 'qa::autokey::';
	EXPORT 	ak_typeStr := 'VESS';
	
	// fcra-restricted states:
  EXPORT states 							:= fcra.compliance.watercrafts.restricted_states;
	
// Support
	EXPORT EmailTargetFail				:= PRTE2_Common.Email.EmailTargetFail;	 
	EXPORT EmailTargetSuccess			:= PRTE2_Common.Email.EmailTargetSuccess;
		
END;