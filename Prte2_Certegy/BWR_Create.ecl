//Prte2.layouts.DEFLT_CPA will probably not be needed in this BWR. Awaiting production update of Certegy.layouts.base.

import certegy,STD,PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'CertegyKeys';


pversion:=(string8)STD.Date.CurrentDate(True);

certegy_did :=    DATASET([ ],Certegy.layouts.base);

didKey := INDEX(certegy_did,{did},{certegy_did},prte2.constants.prefix + 'key::certegy::' + pversion + '::did'); 

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILD(didKey);
PerformUpdateOrNot;

output ('successful');





