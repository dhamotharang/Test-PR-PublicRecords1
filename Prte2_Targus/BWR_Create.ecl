import STD,PRTE2, _control, PRTE, Targus; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'TarguKeys';
dops_name_FCRA := 'FCRA_TargusKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

targus_out :=    DATASET([ ],Targus.Layout_Consumer_out);

addressKey := INDEX(targus_out,{prim_name, zip, prim_range, sec_range, predir, suffix},{targus_out},prte2.constants.prefix + 'key::targus::' + pversion + '::address'); 
addressFCRAKey := INDEX(targus_out,{prim_name, zip, prim_range, sec_range, predir, suffix},{targus_out},prte2.constants.prefix + 'key::targus::fcra::' + pversion + '::address'); 

didKey := INDEX(targus_out,{did},{targus_out},prte2.constants.prefix + 'key::targus::' + pversion + '::did'); 

phoneKey:=INDEX(targus_out,{p7:= phone_number[4..10],p3 := phone_number[1..3],st},{targus_out},prte2.constants.prefix + 'key::targus::' + pversion + '::p7.p3.st'); 
phoneFCRAKey:=INDEX(targus_out,{p7:= phone_number[4..10],p3 := phone_number[1..3],st},{targus_out},prte2.constants.prefix + 'key::targus::fcra::' + pversion + '::p7.p3.st'); 

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:= PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion(dops_name_FCRA,pversion,notifyEmail,'B','F','N');

	PerformUpdateOrNot	:= IF(not skipDops,parallel(updatedops,updatedops_FCRA),NoUpdate);
	
 BUILD(addressKey);
 
 BUILD(didKey);
 
 BUILD(phoneKey);
 
 BUILD(addressFCRAKey);
  
 BUILD(phoneFCRAKey);
 
 PerformUpdateOrNot;

output ('successful');