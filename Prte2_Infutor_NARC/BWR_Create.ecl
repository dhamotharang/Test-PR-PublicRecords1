
import ProfileBooster,STD,PRTE2, _control, PRTE; 

skipDOPS:=true;
string emailTo:='';
dops_name := 'InfutorNARCKeys';


pversion:=(string8)STD.Date.CurrentDate(True);

infutor_did :=    DATASET([ ],ProfileBooster.Layouts.Layout_Infutor);

didKey := INDEX(infutor_did,{did},{infutor_did},prte2.constants.prefix + 'key::mktattr::' + pversion + '::infutor_did'); 

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILD(didKey);
PerformUpdateOrNot;

output ('successful');





