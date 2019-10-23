import  STD,PRTE2, _control, PRTE;  

skipDOPS:=false;
string emailTo:='';
dops_name := 'HealthHDRShellKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops          :=  PRTE.UpdateVersion(dops_name, pversion, notifyEmail, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');	
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

Proc_Build_shell(pversion);

PerformUpdateOrNot;

output ('successful');


