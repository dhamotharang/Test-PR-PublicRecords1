
import POEsFromEmails,STD,PRTE2, _control, PRTE, BIPV2; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'POEsFromEmailsKeys';


pversion:=(string8)STD.Date.CurrentDate(True);

POE_did :=    DATASET([ ],POEsFromEmails.layouts.keybuild -BIPV2.IDlayouts.l_xlink_ids);

POEdidKey := INDEX(POE_did,{did},{POE_did},prte2.constants.prefix + 'key::poesfromemails::' + pversion + '::did'); 


//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILD(POEdidKey);
PerformUpdateOrNot;

output ('successful');





