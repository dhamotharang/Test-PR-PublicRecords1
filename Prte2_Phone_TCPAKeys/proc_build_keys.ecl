import dx_Phone_TCPA,_control, PRTE2_Common, PRTE, prte2, dops;


EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 	:= is_running_in_prod AND NOT skipDOPS;


phone_history := dataset([], dx_Phone_TCPA.layout.i_tcpa_phone_history);
phone_historyKey := INDEX(phone_history,
{  
 phone;
 },{phone_history},
  	'~prte::key::tcpa::' + filedate + '::phone_history');
	
//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, filedate, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean :='N');
		
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);
	
	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));

 Return sequential (
 BUILDindex(phone_historyKey),
// PerformUpdateOrNot,
 key_validation);

 End;
	
	
	
		
 