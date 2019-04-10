//Prte2.layouts.DEFLT_CPA will probably not be needed in this BWR. Awaiting production update of PhoneMart.layouts.base.

import PhoneMart, STD,PRTE2, _control, PRTE;  

skipDOPS:=false;
string emailTo:='';
dops_name := 'PhonemartKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

dPhoneMart_base :=    DATASET([ ],PhoneMart.Layouts.base);

layout_key_base := record
	PhoneMart.Layouts.base - [ScrubsBits1, ScrubsBits2];
end;

dPhoneMart_base_slim := PROJECT(dPhoneMart_base,layout_key_base);	

didKey := INDEX(dPhoneMart_base_slim,{unsigned6 l_did := did},{dPhoneMart_base_slim},prte2.constants.prefix + 'key::phonemart::' + pversion + '::did'); 

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILD(didKey);
PerformUpdateOrNot;

output ('successful');