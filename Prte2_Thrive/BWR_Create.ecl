import ProfileBooster,STD,PRTE2, _control, PRTE, Thrive; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'ThriveKeys';


pversion:=(string8)STD.Date.CurrentDate(True);

thrive_did :=    DATASET([ ],thrive.layouts.baseOld);

didKey := INDEX(thrive_did,{did},{thrive_did},prte2.constants.prefix + 'key::thrive::' + pversion + '::did'); 
didFCRAKey := INDEX(thrive_did,{did},{thrive_did},prte2.constants.prefix + 'key::thrive::fcra::' + pversion + '::did'); 


//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILD(didKey);
BUILD(didFCRAKey);
PerformUpdateOrNot;

output ('successful');





