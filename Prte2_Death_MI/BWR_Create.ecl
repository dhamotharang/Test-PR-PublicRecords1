
import STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'Death_MIKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

ssnBuild :=    DATASET([ ],layouts);

ssnKey := INDEX(ssnBuild,
{ssn,customer_id},{ssnbuild},
prte2.constants.prefix + 'key::death_mi::' + pversion + '::ssn_customer_id'); 

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILD(ssnKey);

PerformUpdateOrNot;

output ('successful');

