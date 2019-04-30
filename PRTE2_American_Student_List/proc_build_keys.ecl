import _control, AutoKeyB, AutoKeyB2, RoxieKeyBuild, PRTE, STD, prte2, tools,doxie, AutoStandardI,doxie_build, PRTE,PRTE2_Common, strata;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION


//Build Indexes
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.stu_DID,						Constants.SuperKeyName +'did',		              Constants.keyname +filedate+ '::did',	          did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.stu_DID_FCRA,				Constants.SuperKeyName_fcra +'did',			        Constants.keyname_fcra +filedate+ '::did',			did_fcra_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.DID,	              Constants.SuperKeyName +'did2',			            Constants.keyname +filedate+ '::did2',		      did2_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.DID_FCRA,						Constants.SuperKeyName_fcra +'did2',		        Constants.keyname_fcra +filedate+ '::DID2',			did2_fcra_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Address_List,				Constants.SuperKeyName_fcra +'address_list',		Constants.keyname +filedate+'::address_list',		address_list_key);


build_roxie_keys	:=	parallel(did_key, did_fcra_key, did2_key, did2_fcra_key, address_list_key);
										


// -- Move Keys to Built
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'did', 		      Constants.keyname+filedate+'::did', 	        mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_FCRA+ 'did', 		Constants.keyname_fcra+filedate+'::did', 		  mv_did_fcra_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'did2', 				Constants.keyname+filedate+'::did2', 			    mv_did2_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_FCRA+ 'did2', 		Constants.keyname_fcra+filedate+'::did2',	 		mv_did2_fcra_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'address_list', Constants.keyname+filedate+'::address_list', 	mv_address_list_key);

Move_keys	:=	parallel(mv_did_key, mv_did_fcra_key, mv_did2_key, mv_did2_fcra_key, mv_address_list_key);


//-- Move Keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	 +'did',	      'Q',	mv_did_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_FCRA	+'did',  	'Q',	mv_did_fcra_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'did2',			  'Q',	mv_did2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_FCRA	+'did2', 	'Q', 	mv_did2_fcra_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'address_list','Q',	mv_address_list_qa, 2);


To_qa	:=	parallel(mv_did_qa, mv_did_fcra_qa, mv_did2_qa, mv_did2_fcra_qa, mv_address_list_qa);

									 
build_autokeys := keys.autokeys(filedate);

// DF-21719 - Show counts of blanked out fields in thor_data400::key::fcra::american_student::qa::did2
cnt_asl_did2_fcra := OUTPUT(strata.macf_pops(prte2_american_student_list.keys.DID_FCRA,,,,,,FALSE,['county_number','delivery_point_barcode','fips_county',
																						 'gender','gender_code','head_of_household_first_name','head_of_household_gender','head_of_household_gender_code',
																						 'income_level','income_level_code','new_income_level','new_income_level_code','telephone','title']));



// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS              := is_running_in_prod AND NOT skipDOPS;
DOPS_Comment		 		:= OUTPUT('Skipping DOPS process');
updatedops					:= PRTE.UpdateVersion('AmericanstudentKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
updatedops_fcra			:= PRTE.UpdateVersion('FCRA_AmericanstudentKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');

// -- Actions
buildKey	:=	sequential(build_roxie_keys
												 ,Move_keys
												 ,to_qa
												 ,build_autokeys
                         ,cnt_asl_did2_fcra
												 ,if(not doDOPS, DOPS_Comment, parallel(updatedops, updatedops_fcra))												 
											);
									
return	buildKey;
end;
