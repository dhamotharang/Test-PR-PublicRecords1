import lib_fileservices, ut, doxie_ln;

//  Example of code to use:
//  Run on thor_dell400_2, thor_dell400 is normally low on space

// Step 1 Copy sprayed to IN########################################
// Currently any new update files need to be hard coded here																 
															 
//#workunit ('name', 'LNPropAddSprayedToIn');															 
// ln_property.fileProcessB_AddSprayedToIN('~thor_data400::', 
                                        // 'in::ln_assessor_YYYYMMDD_base', 
                                        // ln_property.fileNames.inAssessor);
// ln_property.fileProcessB_AddSprayedToIN('~thor_data400::', 
                                        // 'in::ln_deed_YYYYMMDD_base', 
                                        // ln_property.fileNames.inDeeds);	
// ln_property.fileProcessB_AddSprayedToIN('~thor_dell400_2::', 
                                        // 'in::ln_assessor_deed_YYYYMMDD_search', 
                                        // ln_property.fileNames.inSearch);	
// ln_property.fileProcessB_AddSprayedToIN('~thor_data400::', 
                                        // 'in::ln_deed_YYYYMMDD_addlnames', 
                                        // ln_property.fileNames.inAddlNames);
// ln_property.fileProcessB_AddSprayedToIN('~thor_data400::', 
                                        // 'whateverYouAssessorReplNameIs', 
                                        // ln_property.fileNames.inAssessorRepl);																				
// ln_property.fileProcessB_AddSprayedToIN('~thor_data400::', 
                                        // 'whateverYouDeedsReplNameIs', 
                                        // ln_property.fileNames.inDeedsRepl); 
// ln_property.fileProcessB_AddSprayedToIN('~thor_data400::', 
                                        // 'whateverYouSearchReplNameIs', 
                                        // ln_property.fileNames.inSearchRepl);
// ln_property.fileProcessB_AddSprayedToIN('~thor_data400::', 
                                        // 'whateverYourAddlNamesReplNameIs', 
                                        // ln_property.fileNames.inAddlNamesRepl);  																				
																														
																				
	
// Step 2 Build base files ########################################
// IMPORTANT, SET VERSION IN ln_property.version_build <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//#workunit ('name', 'LNPropBuildBaseFiles');															 
//ln_property.fileProcessC_BuildBaseFile();


// Step 3 Build property_did files ########################################
//#workunit ('name', 'LNPropBuildPropDIDBaseFile');															 
//ln_property.fileProcessD_BuildPropDIDBase();								
															

// Step 4  Accept SF to QA ########################################
//#workunit ('name', 'LNPropAcceptSuperfileToQA');															  
//ln_property.fileprocessE_AcceptSF_toQA('~thor_data400');


/*
  Step 5 Build Superkeys ######################################## 
  Make sure >>> ln_property.version <<< is set to the build version you want (usually todays date)
*/
//#workunit ('name', 'LNPropBuild_Keys');															 
//ln_property.fileProcessF_BuildKeys();


/*
   OPTIONAL Step.  Accept QA to prod ########################################
   If the QA files are good, they will need to be promoted to production.
	 Otherwise, skip this step and continue with Step 6, this will erase current QA key
	 and replace them with the BUILT versions just completed.
*/
//#workunit ('name', 'LNPropAcceptQASuperKeysProd');															 
//ln_property.fileprocessX_AcceptSKQA_toProd();


// Step 6 Accept SK to QA ########################################
//#workunit ('name', 'LNPropAcceptSuperKeysToQA');															 
//ln_property.fileprocessG_AcceptSK_toQA('~thor_data400');


// Step 7  Build Moxie Out Files ########################################
// #workunit ('name', 'Build Property Moxie Out Files');															 
// ln_property.fileProcessH_BuildMoxieOutFiles;


// Step 8  Build Moxie Keys ########################################+
// #workunit ('name', 'Build Property Moxie Keys');															 
// ln_property.fileProcessI_BuildMoxieKeys;


/*
  Step 9  DKC Files ########################################
	Make sure >>> LN_property.MOXIE_DKC_Server <<< is set to the correct dkc server
*/
// #workunit ('name', 'DKC Files');															 
// ln_property.fileProcessJ_DKC_files;


// Step 10  Add Moxie Keys to superfiles ########################################
// #workunit ('name', 'Add Moxie Keys to Superfiles');															 
// ln_property.fileProcessK_AddMoxieKeysToSuperfiles;










//  Note: File creation preparation ########################################

// cluster := '~thor_data400'; 

// assessorSF           := ln_property.filenames.inAssessor;
// deedSF               := ln_property.filenames.inDeeds;
// searchSF             := ln_property.filenames.inSearch;
// addl_namesSF         := ln_property.filenames.inAddlNames;	
// fileservices.createsuperfile(assessorSF);									
// fileservices.createsuperfile(deedSF);
// fileservices.createsuperfile(searchSF);
// fileservices.createsuperfile(addl_namesSF);

// assessorSFRepl           := ln_property.filenames.inAssessorRepl;
// deedSFRepl               := ln_property.filenames.inDeedsRepl;
// searchSFRepl             := ln_property.filenames.inSearchRepl;
// addl_namesSFRepl         := ln_property.filenames.inAddlNamesrepl;	
// fileservices.createsuperfile(assessorSFRepl);									
// fileservices.createsuperfile(deedSFRepl);
// fileservices.createsuperfile(searchSFRepl);
// fileservices.createsuperfile(addl_namesSFRepl);

// ut.mac_create_superfiles_standard('~thor_data400', '::base::ln_property', 'assessor');
// ut.mac_create_superfiles_standard('~thor_data400', '::base::ln_property', 'deed');
// ut.mac_create_superfiles_standard('~thor_data400', '::base::ln_property', 'search');
// ut.mac_create_superfiles_standard('~thor_data400', '::base::ln_property', 'addl_names');	
// ut.mac_create_superfiles_standard('~thor_data400', '::base::ln_property', 'property_did');

// ut.mac_create_superfiles_standard('~thor_data400', '::out::ln_property', 'assessor');
// ut.mac_create_superfiles_standard('~thor_data400', '::out::ln_property', 'deed');
// ut.mac_create_superfiles_standard('~thor_data400', '::out::ln_property', 'search');
// ut.mac_create_superfiles_standard('~thor_data400', '::out::ln_property', 'addl_names');	
																	
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'addr_search.fid');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'search_did');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'deed_parcelNum');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'assessor_parcelNum');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'deed.fid');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'assessor.fid');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'search.fid_county');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'bdid');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'addlnames.fid');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'search.fid');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'addr.full');
// ut.mac_create_superKeyFiles_standard('~thor_data400', '::key::ln_property', 'did.ownership');


                                      



 
 