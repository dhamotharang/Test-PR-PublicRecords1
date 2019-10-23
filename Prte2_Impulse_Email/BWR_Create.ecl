import STD,PRTE2, _control, PRTE, Impulse_Email; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'ImpulseEmailKeys';
dops_name_FCRA := 'FCRA_ImpulseEmailKeys';


pversion:=(string8)STD.Date.CurrentDate(True);

impulse_did :=    DATASET([ ],Impulse_Email.layouts.layout_Impulse_Email_Did_Key);

didKey := INDEX(impulse_did,{did},{impulse_did},prte2.constants.prefix + 'key::impulse_email::' + pversion + '::did'); 

didFCRAKey := INDEX(impulse_did,{did},{impulse_did},prte2.constants.prefix + 'key::impulse_email::fcra::' + pversion + '::did'); 

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:= PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion(dops_name_FCRA,pversion,notifyEmail,'B','F','N');

	PerformUpdateOrNot	:= IF(not skipDops,parallel(updatedops,updatedops_FCRA),NoUpdate);
	
BUILD(didKey);
BUILD(didFCRAKey);

PerformUpdateOrNot;

output ('successful');





