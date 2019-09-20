
import PSS,STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'PSSKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

dkeybuild :=    DATASET([ ],PSS.layouts.keybuild);
bkeybuild :=    DATASET([ ],layouts.bdid_phone_layout);


didKey := INDEX(dkeybuild,{did},{dkeybuild},prte2.constants.prefix + 'key::pss::' + pversion + '::did'); 

bdidPhoneKey := INDEX(bkeybuild,{bdid,response_company_phone},{bkeybuild},prte2.constants.prefix + 'key::pss::' + pversion + '::bdid_phone'); 


//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILDIndex(didKey);

BUILDIndex(bdidPhoneKey);

PerformUpdateOrNot;

output ('successful');

