
import STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'InfutorNARBKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

linkbuild :=    DATASET([ ],layouts);

LinkKey := INDEX(linkbuild,
{ultid,orgid,seleid,proxid,powid,empid,dotid},{linkbuild},
prte2.constants.prefix + 'key::infutor_narb::' + pversion + '::linkids'); 


	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);


BUILD(linkKey);

//PerformUpdateOrNot;

output ('successful');

