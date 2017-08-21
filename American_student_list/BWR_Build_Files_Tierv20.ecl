#workunit('name','BWR_Build_Files_Tierv20'); 

//Create a new base file with the new field tierv20 using the lastest base file from production
import American_student_list, AlloyMedia_student_list, Lib_FileServices, ut, PRTE;

//clear super files
clear_super_files := SEQUENTIAL(
				FileServices.StartSuperFileTransaction();
				FileServices.ClearSuperFile('~thor_data400::key::alloymedia_student_list::qa::did');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::qa::did');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::qa::did2');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::autokey::qa::address');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::autokey::qa::citystname');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::autokey::qa::name');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::autokey::qa::payload');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::autokey::qa::phone2');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::autokey::qa::ssn2');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::autokey::qa::stname');
				FileServices.ClearSuperFile('~thor_data400::key::american_student::autokey::qa::zip');
				FileServices.ClearSuperFile('~thor_data400::key::fcra::alloymedia_student_list::qa::did');
				FileServices.ClearSuperFile('~thor_data400::key::fcra::american_student::qa::did');
				FileServices.ClearSuperFile('~thor_data400::key::fcra::american_student::qa::did2');
				FileServices.ClearSuperFile('~thor_data400::base::alloymedia_student_list');
				FileServices.ClearSuperFile('~thor_data400::base::american_student_list');
				FileServices.FinishSuperFileTransaction();
	);


todaydate := thorlib.wuid()[2..9];

//College metadata reference file
collegeMetadata := American_student_list.file_college_metadata_lkp;

//American Student List base file. This file does not have tierv20 field
//The latest base file on prod. thor_data400::base::american_student_list_w20130607-120730
//asl_base_file := dataset('~thor_data400::base::american_student_list_w20130531-143344',
asl_base_file := dataset('~thor_data400::base::american_student_list_w20130607-120730',
										American_student_list.Layout_American_Student_Base_v2-American_student_list.layout_KeyExclusions_tier2,
										THOR);

//Alloymedia student file. This file does not have tierv20 field
alloy_base_file := dataset('~thor_data400::base::alloymedia_student_list_w20120213-162804',
										AlloyMedia_student_list.Layouts.Layout_base-AlloyMedia_student_list.Layouts.layout_KeyExclusions_tier2,
										THOR);

//Add tier2 information
American_student_list.Layout_American_Student_Base_v2	aslAddTierv20(asl_base_file pLeft, collegeMetadata pLkp) := TRANSFORM
			self.tier2		:=	pLkp.tierv20;
			self					:=	pLeft;
		END;
		
newAslBase	:=	JOIN(asl_base_file, collegeMetadata, 
										 StringLib.StringCleanSpaces(LEFT.COLLEGE_NAME) != '' AND 
										 StringLib.StringCleanSpaces(LEFT.COLLEGE_NAME) = StringLib.StringCleanSpaces(RIGHT.asl_matchkey_cn), 
										 aslAddTierv20(left,right), LEFT OUTER, LOOKUP);	

ut.MAC_SF_BuildProcess(newAslBase,American_student_list.thor_cluster + 'base::american_student_list',build_asl);

//Add tier2 information
AlloyMedia_student_list.Layouts.Layout_base	alloyAddTierv20(alloy_base_file pLeft, collegeMetadata pLkp) := TRANSFORM
			self.tier2		:=	pLkp.tierv20;
			self					:=	pLeft;
		END;

newAlloyBase	:=	JOIN(alloy_base_file, collegeMetadata, 
	                   StringLib.StringCleanSpaces(LEFT.school_act_code) != '' AND 
										 StringLib.StringCleanSpaces(LEFT.school_act_code) = StringLib.StringCleanSpaces(RIGHT.Alloy_MatchKey),
										 alloyAddTierv20(left,right), LEFT OUTER, LOOKUP);	


//ut.MAC_SF_BuildProcess(newAlloyBase,AlloyMedia_student_list.thor_cluster + 'base::alloymedia_student_list',build_alloy);
ut.MAC_SF_BuildProcess(newAlloyBase,AlloyMedia_student_list.thor_cluster + 'base::alloymedia_student_list',build_alloy,,,true);



asl_build_keys 					:=	American_student_list.Proc_build_keys(todaydate);
asl_build_stats 				:= American_student_list.Out_Base_Stats_Population(todaydate);
asl_build_stats_v2			:= American_student_list.Out_Base_Stats_Population_V2(todaydate);
asl_build_auto_keys 		:= American_student_list.Proc_Build_Autokeys(todaydate);

alloy_build_keys 				:=	alloymedia_student_list.Proc_build_keys(todaydate);
alloy_build_strata			:=	alloymedia_student_list.proc_build_strata(todaydate);
alloy_build_autokeys  	:=	alloymedia_student_list.Proc_build_autokeys(todaydate);

export BWR_Build_Files_Tierv20 := sequential(clear_super_files,
																						 build_asl, 
																						 build_alloy, 
																						 fileservices.sendemail('cathy.tio@lexisnexis.com',
																																		'Complete base files',
																																		'Complete build_asl and build_alloy');
																						 asl_build_keys,
																						 asl_build_stats,
																						 asl_build_stats_v2,
																						 asl_build_auto_keys,
																						 PRTE.Proc_Build_ASL_Keys(todaydate),
																						 alloy_build_keys,
																						// alloy_build_autokeys,
																						 alloy_build_strata,
																						 PRTE.Proc_Build_Alloy_Keys(todaydate),
																						 fileservices.sendemail('cathy.tio@lexisnexis.com',
																																		'Complete key files',
																																		'Complete asl_build_keys, asl_build_stats, asl_build_auto_keys, alloy_build_keys,and alloy_build_strata');
                                             );

