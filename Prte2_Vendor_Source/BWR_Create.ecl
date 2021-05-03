import STD, PRTE2, _control, PRTE, dops, orbit3; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'VendorSourceKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

SourceCodeBuild :=    DATASET([ ],Layouts.SourceCode);

SourceCodeKey := INDEX(SourceCodeBuild,{source_code},{SourceCodeBuild},prte2.constants.prefix + 'key::vendor_src_info::' + pversion + '::vendor_source'); 
                                

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean :='N');
	

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
	
	Key_Validation     := output(dops.ValidatePRCTFileLayout(pversion, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, dops_name, 'N'));

  orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE - Vendor Source Keys', pversion, 'PN', email_list:= _control.MyInfo.EmailAddressNormal);


BUILDIndex(SourceCodeKey);

PerformUpdateOrNot;
Key_validation;
orbit_update;

output ('successful');
