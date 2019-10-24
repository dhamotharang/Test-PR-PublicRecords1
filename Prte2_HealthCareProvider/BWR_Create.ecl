import  STD,PRTE2, _control, PRTE;  

skipDOPS:=false;
string emailTo:='';
dops_name := 'HealthHDRKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops          :=  PRTE.UpdateVersion(dops_name, pversion, notifyEmail, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');	
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

Proc_Build_address(pversion);
Proc_Build_bdid(pversion);
Proc_Build_dea(pversion);
Proc_Build_dob(pversion);
Proc_Build_cnsmr_dob(pversion);
Proc_Build_fname(pversion);
Proc_Build_header(pversion);
Proc_Build_lexid(pversion);
Proc_Build_lic(pversion);
Proc_Build_lname(pversion);
Proc_Build_mname(pversion);
Proc_Build_name(pversion);
Proc_Build_Namestlic(pversion);
Proc_Build_npi(pversion);
Proc_Build_npi2(pversion);
Proc_Build_phone(pversion);
Proc_Build_refs(pversion);
Proc_Build_rid(pversion);
Proc_Build_source_rid(pversion);
Proc_Build_ssn(pversion);
Proc_Build_ssn2(pversion);
Proc_Build_tax(pversion);
Proc_Build_tax2(pversion);
Proc_Build_upin(pversion);
Proc_Build_vendorid(pversion);
Proc_Build_words(pversion);
Proc_Build_zip(pversion);

PerformUpdateOrNot;

output ('successful');


