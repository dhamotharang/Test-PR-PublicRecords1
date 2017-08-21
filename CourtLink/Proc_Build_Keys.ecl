import _Control,CourtLink,roxiekeybuild,ut,doxie,doxie_files,Orbit3;

export proc_build_keys(string filedate) := function

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(CourtLink.key_CourtID_Docket,
										   '~thor_data400::key::CourtLink::@version@::CourtID_Docket','~thor_data400::key::CourtLink::'+filedate+'::CourtID_Docket',
										   bld_court_key);

// Move key to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CourtLink::@version@::CourtID_Docket','~thor_data400::key::CourtLink::'+filedate+'::CourtID_Docket',mv_court_key);

// Move key to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::courtLink::@version@::CourtID_Docket', 'Q', mv_court_key_qa);

build_keys 		:= sequential(bld_court_key, mv_court_key, mv_court_key_qa);

autokeys 		:= CourtLink.Proc_Build_AutoKeys(filedate);

//Upate Roxie Page
UpdateRoxiePage := RoxieKeybuild.updateversion('LitigiousDebtorKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N');

//Orbit Build Update
Orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('Litigious Debtors',(filedate),'N');
					
retval :=  sequential(build_keys
				,autokeys
				,UpdateRoxiePage
				,Orbit_update
				,output(CourtLink.key_CourtID_Docket(dt_vendor_first_reported = (unsigned4)filedate), named ('SampleRecords'))
				): success(CourtLink.Send_Email(filedate).KeySuccess), failure(CourtLink.Send_Email(filedate).KeyFailure);

return retval;
end;


 
 
 
 