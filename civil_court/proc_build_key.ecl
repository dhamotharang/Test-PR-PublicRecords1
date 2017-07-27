// import ut;

// pre := sequential(
		// fileservices.startsuperfiletransaction(),
		// if (fileservices.getsuperfilesubcount('~thor_Data400::base::civil_court_BUILDING') > 0,
			// output('Nothing added to BUILDING Superfile'),
			// fileservices.addsuperfile('~thor_Data400::base::civil_court_BUILDING','~thor_data400::base::civil_court',0,true)),
		// fileservices.finishsuperfiletransaction()
		// );

// ut.MAC_SK_BuildProcess(civil_court.key_prep_did,'~thor_Data400::key::civil_court_did_','~thor_data400::key::civil_court_did',a)
// ut.MAC_SK_BuildProcess_v2(civil_court.key_cc_bdid,'~thor_Data400::key::cc_bdid',b);

// c := sequential(
		// fileservices.startsuperfiletransaction(),
		// fileservices.clearsuperfile('~thor_data400::base::civil_court_BUILT'),
		// fileservices.addsuperfile('~thor_data400::base::civil_court_BUILT','~thor_data400::base::civil_court_BUILDING',0,true),
		// fileservices.clearsuperfile('~thor_Data400::base::civil_court_BUILDING'),
		// fileservices.finishsuperfiletransaction()
		// );

// export proc_build_key := if (fileservices.getsuperfilesubname('~thor_data400::base::civil_court',1) = fileservices.getsuperfilesubname('~thor_data400::base::civil_court_BUILT',1),
		// output('BASE = BUILT, Nothing done.'),sequential(pre,a,b,c));
		
import  RoxieKeyBuild,ut,autokey,civil_court;

export Proc_Build_Key(string filedate) := function

SuperKeyNameParty    := civil_court.cluster +'Key::civil_court_party::@version@::';
BaseKeyNameParty 		:= civil_court.cluster +'Key::civil_court_party::'+filedate;

SuperKeyNameMatter    := civil_court.cluster +'Key::civil_court_matter::@version@::';
BaseKeyNameMatter 		:= civil_court.cluster +'Key::civil_court_matter::'+filedate;

SuperKeyNameActivity  := civil_court.cluster +'Key::civil_court_case_activity::@version@::';
BaseKeyNameActivity		:= civil_court.cluster +'Key::civil_court_case_activity::'+filedate;
																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(civil_court.key_caseID,SuperKeyNameParty+'caseID',BaseKeyNameParty+'::caseID',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(civil_court.key_caseID_matter,SuperKeyNameMatter+'caseID',BaseKeyNameMatter+'::caseID',key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(civil_court.key_caseID_activity,SuperKeyNameActivity+'caseID',BaseKeyNameActivity+'::caseID',key3);

//RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(civil_court.key_caseID,SuperKeyName+'caseID',BaseKeyName+'::caseID',key2);
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_aircraft_id,'~thor_data400::key::aircraft_id','~thor_data400::key::faa::'+filedate+'::aircraft_id',b4_key);

Keys := parallel(
								 key1,
                 key2,
								 key3
								 );

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyNameParty+'caseID',BaseKeyNameParty+'::caseID',mv1,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyNameMatter+'caseID',BaseKeyNameMatter+'::caseID',mv2,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyNameActivity+'caseID',BaseKeyNameActivity+'::caseID',mv3,Qa);
//RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'caseID',BaseKeyName+'::caseID',mv2,Qa);


Move_keys := parallel(
                       mv1,
                       mv2,
											 mv3
											 );

RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyNameParty+'caseID','Q',toq1,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyNameMatter+'caseID','Q',toq2,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyNameActivity+'caseID','Q',toq3,2);
//RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'addlfaresdeed_plus.fid','Q',toq2,2);

						
To_qa := parallel(
                   toq1,
                   toq2,
									 toq3
										 );

// Build Autokeys

autokeys := civil_court.proc_build_autokeys(filedate);

buildKey :=sequential(parallel(Keys,
             autokeys
						 ),
						Move_keys,
						to_qa
						);	

return buildKey ;

end;