//Build keys for American Student List and move to QA.
//Bug ticket #116301 - incorrect field length for county field for DID key, but key not used so removing keybuild
import ut, RoxieKeyBuild, _control, strata;

export Proc_build_keys(string filedate) :=  
function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											American_student_list.key_stu_DID,
											'~thor_data400::key::American_Student::@version@::DID',
											'~thor_data400::key::American_Student::'+filedate+'::DID',
											AmericanStudentDidKeyOut
										   );
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											American_student_list.key_stu_DID_FCRA,
											'~thor_data400::key::fcra::American_Student::@version@::DID',
											'~thor_data400::key::fcra::American_Student::'+filedate+'::DID',
											AmericanStudentDidFCRAKeyOut
										   );										   

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											American_student_list.key_DID,
											'~thor_data400::key::American_Student::@version@::DID2',
											'~thor_data400::key::American_Student::'+filedate+'::DID2',
											AmericanStudentDidHistKeyOut
										   );
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											American_student_list.key_DID_FCRA,
											'~thor_data400::key::fcra::American_Student::@version@::DID2',
											'~thor_data400::key::fcra::American_Student::'+filedate+'::DID2',
											AmericanStudentDidHistFCRAKeyOut
										   );	
											 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											American_student_list.key_Address_List,
											'~thor_data400::key::American_Student::@version@::address_list',
											'~thor_data400::key::American_Student::'+filedate+'::address_list',
											AmericanStudentAddressList
										   );
		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::American_Student::@version@::DID',
									  '~thor_data400::key::American_Student::'+filedate+'::DID',
									  mv_did_key_built
									  );
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::fcra::American_Student::@version@::DID',
									  '~thor_data400::key::fcra::American_Student::'+filedate+'::DID',
									  mv_did_FCRA_key_built
									  );
										
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::American_Student::@version@::DID2',
									  '~thor_data400::key::American_Student::'+filedate+'::DID2',
									  mv_did_hist_key_built
									  );
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::fcra::American_Student::@version@::DID2',
									  '~thor_data400::key::fcra::American_Student::'+filedate+'::DID2',
									  mv_did_hist_FCRA_key_built
									  );
										
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::American_Student::@version@::address_list',
										'~thor_data400::key::American_Student::'+filedate+'::address_list',
										mv_Address_List_key_built
									  );	
									  
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::American_Student::@version@::DID', 'Q', mv_did_key_QA);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::fcra::American_Student::@version@::DID', 'Q', mv_did_fcra_key_QA);

RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::American_Student::@version@::DID2', 'Q', mv_did_hist_key_QA);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::fcra::American_Student::@version@::DID2', 'Q', mv_did_hist_fcra_key_QA);

RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::American_Student::@version@::address_list', 'Q', mv_address_list_key_QA);

//______________________________________________________________________________________________

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											American_student_list.key_stu_address,
											'~thor_data400::key::American_Student::@version@::Address',
											'~thor_data400::key::American_Student::'+filedate+'::Address',
											AmericanStudentAddrKeyOut
										   );
		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::American_Student::@version@::Address',
									  '~thor_data400::key::American_Student::'+filedate+'::Address',
									  mv_addr_key_built
									  );
									  
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::American_Student::@version@::Address', 'Q', mv_addr_key_QA);

// DF-21719 - Show counts of blanked out fields in thor_data400::key::fcra::american_student::qa::did2
cnt_asl_did2_fcra := OUTPUT(strata.macf_pops(American_student_list.key_DID_FCRA,,,,,,FALSE,['county_number','delivery_point_barcode','fips_county',
																						 'gender','gender_code','head_of_household_first_name','head_of_household_gender','head_of_household_gender_code',
																						 'income_level','income_level_code','new_income_level','new_income_level_code','telephone','title']));

//_______________________________________________________________________________________________

//Update Roxie Page with Key Version - Move to proc_build_all
// UpdateRoxiePage := sequential(RoxieKeybuild.updateversion('AmericanstudentKeys', filedate, _control.MyInfo.EmailAddressNotify)
											// ,RoxieKeybuild.updateversion('FCRA_AmericanstudentKeys', filedate, _control.MyInfo.EmailAddressNotify));
											
//_______________________________________________________________________________________________

return sequential(
					parallel(
							  // AmericanStudentDidKeyOut,
							  // AmericanStudentDidFCRAKeyOut,
								AmericanStudentDidHistKeyOut,
								AmericanStudentDidHistFCRAKeyOut,
								AmericanStudentAddressList
							  // AmericanStudentAddrKeyOut
							  ),
					parallel(
							  // mv_did_key_built, 
							  // mv_did_FCRA_key_built,
								mv_did_hist_key_built,
								mv_did_hist_FCRA_key_built,
								mv_Address_List_key_built
							  // mv_addr_key_built
							  ),
					parallel(
							  // mv_did_key_QA, 
							  // mv_did_fcra_key_QA,
								mv_did_hist_key_QA,
								mv_did_hist_fcra_key_QA,
								mv_address_list_key_QA
							  // mv_addr_key_QA
							  ),
							  // UpdateRoxiePage
					 cnt_asl_did2_fcra
					);	

end;