//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: PROC_BUILD_LIENS_BASE

// DEPENDENT ON : liensV2.Mapping_ILFDLN_Main,
//				  liensV2.ILFederal_DID,
//				  liensV2.Mapping_NYC_Main,
//				  liensV2.NYC_DID,
//				  liensV2.Mapping_NYC_Main,
//				  liensV2.NYC_DID,
//				  liensV2.Mapping_NYFDLN_Main,
//				  liensV2.NYFederal_DID,
//				  liensV2.Mapping_Service_Abstract_Main,
//				  liensV2.Service_Abstract_DID,
//				  liensV2.Mapping_Chicago_law_Main,
//				  liensV2.Chicago_law_DID,
//				  liensV2.Mapping_CA_Federal_Main,
//				  liensV2.CA_Federal_DID,
//				  Liensv2.AddSuperFileContents
//				  Liensv2.Clear_Liensv2_Input_SuperFiles
//				  liensv2.Layout_liens_main_module.layout_filing_status

// PURPOSE	 	: Create new files for party and main Liensv2 files and add the
//				  base file for all sources except Hogan
//////////////////////////////////////////////////////////////////////////////////////////

import ut, liensV2, Data_Services, PromoteSupers;

///////////////////////////////////////////////////////////////////////////////////////
// NEW ATTRIBUTES ADDED:
// 
// Liensv2.AddSuperFileContents - Adds the contents of the input Liensv2 file
//								  to the corresponding building input superfile
//								  based on the source passed in as param.
// Liensv2.Clear_Liensv2_Input_SuperFiles - Removes only logical files in the input
//											Liensv2 file that are included in the
//											building input superfile and clears the 
//											building superfile.
///////////////////////////////////////////////////////////////////////////////////////


// Check if input liens superfile exists and has atleast on subfile in it

checkfileexists(string FileName)
 := if(fileservices.SuperFileExists(FileName) and fileservices.GetSuperFileSubCount(Filename) > 0,
	 true,
	 false
	)
 ;

///////////////////////////////////////
//build ILFDLN main & party base file//
///////////////////////////////////////
PromoteSupers.MAC_SF_BuildProcess(liensV2.Mapping_ILFDLN_Main,
                       '~thor_data400::base::Liens::Main::ILFDLN',bld_ILFDLN_main, 2);
											 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_ILFDLN_party	:= liensV2.ILfederal_DID;
	ds_ILFDLN_main 	:= liensV2.Mapping_ILFDLN_Main;
	ds_ILFDLN_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_ILFDLN_party, ds_ILFDLN_main);
				   
PromoteSupers.MAC_SF_BuildProcess(ds_ILFDLN_fix,
                       '~thor_data400::base::Liens::party::ILFDLN', bld_ILFDLN_party,2);											 

///////////////////////////////////////											 
//build NYC main & party base file/////
///////////////////////////////////////
PromoteSupers.MAC_SF_BuildProcess(liensV2.Mapping_NYC_Main,
                       '~thor_data400::base::Liens::Main::NYC',bld_NYC_main, 2);
											 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_NYC_party 	:= liensV2.NYC_DID;
	ds_NYC_main 	:= liensV2.Mapping_NYC_Main;
	ds_NYC_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_NYC_party, ds_NYC_main);
				   
PromoteSupers.MAC_SF_BuildProcess(ds_NYC_fix,
                       '~thor_data400::base::Liens::party::NYC', bld_NYC_party,2);											 			 

///////////////////////////////////////
//build NYFDLN main & party base file//
///////////////////////////////////////
PromoteSupers.MAC_SF_BuildProcess(liensV2.Mapping_NYFDLN_Main,
                       '~thor_data400::base::Liens::Main::NYFDLN',bld_NYFDLN_main, 2);
				   										 
//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_NYFDN_party:= liensV2.NYfederal_DID;
	ds_NYFDN_main := liensV2.Mapping_NYFDLN_Main;
	ds_NYFDN_fix	:= LiensV2._Functions.fn_PopDtFirstSeen(ds_NYFDN_party, ds_NYFDN_main);
				   
PromoteSupers.MAC_SF_BuildProcess(ds_NYFDN_fix,
                       '~thor_data400::base::Liens::party::NYFDLN', bld_NYFDLN_party, 2);				  											 

/////////////////////////////////////////////////											 
//build service abstract main & party base file//
/////////////////////////////////////////////////
PromoteSupers.MAC_SF_BuildProcess(liensV2.Mapping_Service_ABSTRACT_Main,
                       '~thor_data400::base::Liens::Main::SA',bld_SA_main, 2);
				  
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_SA_party 	:= liensV2.Service_Abstract_DID;
	ds_SA_main 		:= liensV2.Mapping_service_abstract_Main;
	ds_SA_fix			:= LiensV2._Functions.fn_PopDtFirstSeen(ds_SA_party, ds_SA_main);
				   
PromoteSupers.MAC_SF_BuildProcess(ds_SA_fix,
                       '~thor_data400::base::Liens::party::SA', bld_sa_party, 2);

////////////////////////////////////////////
//build chicage law main & party base file//
////////////////////////////////////////////
PromoteSupers.MAC_SF_BuildProcess(liensV2.Mapping_chicago_law_Main,
                       '~thor_data400::base::Liens::Main::chicago_law',bld_CGL_main, 2);
											 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_CGL_party 	:= LiensV2.Chicago_Law_DID;
	ds_CGL_main 	:= liensV2.Mapping_chicago_law_Main;
	ds_CGL_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_CGL_party, ds_CGL_main);										 
				   
PromoteSupers.MAC_SF_BuildProcess(ds_CGL_fix,
                       '~thor_data400::base::Liens::party::chicago_law', bld_CGL_party,2);											 										 

///////////////////////////////////////////					   
//build CA_federal main & party base file//
///////////////////////////////////////////
PromoteSupers.MAC_SF_BuildProcess(liensV2.Mapping_CA_federal_Main,
                       '~thor_data400::base::Liens::Main::CA_federal', bld_CA_federal_main, 2,,true);
				   									 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_CA_party 	:= liensV2.CA_federal_DID;
	ds_CA_main 		:= liensV2.Mapping_CA_federal_Main;
	ds_CA_fix			:= LiensV2._Functions.fn_PopDtFirstSeen(ds_CA_party, ds_CA_main);
				   
PromoteSupers.MAC_SF_BuildProcess(ds_CA_fix,
                       '~thor_data400::base::Liens::party::CA_federal', bld_CA_federal_party,2,,true);		

///////////////////////////////////
//build MA main & party base file//
///////////////////////////////////
PromoteSupers.MAC_SF_BuildProcess(liensV2.Mapping_MA_Main,
                       '~thor_data400::base::Liens::Main::MA',bld_MA_main, 2,,true);
				   										 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_MA_party 	:= LiensV2.MA_DID;
	ds_MA_main 		:= LiensV2.Mapping_MA_Main;
	ds_MA_fix			:= LiensV2._Functions.fn_PopDtFirstSeen(ds_MA_party, ds_MA_main);
				   
PromoteSupers.MAC_SF_BuildProcess(ds_MA_fix,
                       '~thor_data400::base::Liens::party::MA', bld_MA_party, 2,,true);											 									 

export proc_build_liens_base := sequential(
										  // ILFDLN
										  if(checkfileexists('~thor_data400::in::liensv2::ilfdln::federal'),
										  sequential(Liensv2.AddSuperFileContents('ILFDLN'),
										  bld_ILFDLN_main,bld_ILFDLN_party,Liensv2.Clear_Liensv2_Input_SuperFiles('ILFDLN')),
										  output('No New files for ILFDLN')),
										  
										  // NYC
										  if(checkfileexists('~thor_data400::in::liensv2::nyc::judgmts'),
										  sequential(Liensv2.AddSuperFileContents('NYC'),
										  bld_NYC_main,bld_NYC_party,Liensv2.Clear_Liensv2_Input_SuperFiles('NYC')),
										  output('No New files for NYC')),
										  
										  //NYFDLN
										  if(checkfileexists('~thor_data400::in::liensv2::nyf::federal'),
										  sequential(Liensv2.AddSuperFileContents('NYFDLN'),
										  bld_NYFDLN_main,bld_NYFDLN_party,Liensv2.Clear_Liensv2_Input_SuperFiles('NYFDLN')),
										  output('No New files for NYFDLN')),
										  
										  //SA
										  if(checkfileexists('~thor_data400::in::liensv2::sab::servabs'),
										  sequential(Liensv2.AddSuperFileContents('SA'),
										  bld_SA_main,bld_sa_party,Liensv2.Clear_Liensv2_Input_SuperFiles('SA')),
										  output('No New files for SA')),
										  
										  //CGL
										  if(checkfileexists('~thor_data400::in::liensv2::cgl::fstlien') or 
											 checkfileexists('~thor_data400::in::liensv2::cgl::fstrles') or
											 checkfileexists('~thor_data400::in::liensv2::cgl::judgmts') or
											 checkfileexists('~thor_data400::in::liensv2::cgl::satjmts') or
											 checkfileexists('~thor_data400::in::liensv2::cgl::subjmts') or
											 checkfileexists('~thor_data400::in::liensv2::cgl::vacjmts') or
											 checkfileexists('~thor_data400::in::liensv2::cgl::disjmts'),
										  sequential(Liensv2.AddSuperFileContents('CGL'),
										  bld_CGL_main,bld_cgl_party,Liensv2.Clear_Liensv2_Input_SuperFiles('CGL')),
										  output('No New files for CGL')),
										  
										  //CA
										  if(checkfileexists('~thor_data400::in::liensv2::caf::busdtor') or
											 checkfileexists('~thor_data400::in::liensv2::caf::bussecp') or
											 checkfileexists('~thor_data400::in::liensv2::caf::chgfilg') or
											 checkfileexists('~thor_data400::in::liensv2::caf::filings') or
											 checkfileexists('~thor_data400::in::liensv2::caf::perdtor') or
											 checkfileexists('~thor_data400::in::liensv2::caf::persecp'),
										  sequential(Liensv2.AddSuperFileContents('CA'),
										  bld_CA_federal_main,bld_ca_federal_party,Liensv2.Clear_Liensv2_Input_SuperFiles('CA')),
										  output('No New files for CA')),
										  
										  //MA
										  if(checkfileexists('~thor_data400::in::liensv2::ma::childsupportlien') or 
											 checkfileexists('~thor_data400::in::liensv2::ma::welflien') or
											 checkfileexists('~thor_data400::in::liensv2::ma::writs') or
											 checkfileexists('~thor_data400::in::liensv2::ma::writsname'),
										  sequential(Liensv2.AddSuperFileContents('MA'),
										  bld_MA_main,bld_MA_party,Liensv2.Clear_Liensv2_Input_SuperFiles('MA')),
										  output('No New files for MA'))

										  ) ;