EXPORT Build_Guide:=fail('DO NOT RUN THIS');
//#error('MUST SWAP PATCHED RAW FILE!! (RE-CLEAN ADDDRESSES FOR JAN 2017 INGEST)');
// v := header.version_build;
// if( v<>'20160223',fail('version needs to be reset to 20160223'));
// ACTION          <<<-->>>                        WUID              <<<-->>>                       // WILL KICK OFF THIS         <<<-->>>            // ECL SCHEDULE SOURCE / COMMENTS         <<<----|
// ----------------------------------------        -----------------------------------------------  // -----------------------------------------------// ----------------------------------------------|                                       
// "C:\Users\marcga01\Documents\Projects\Header\15-05a_BuildAssistScripts\BWR_Check_Equifax_for_New_Header.ecl"
// choosen(Header.Verify_XADL1_base_files,1000,1); #workunit('name','Report_Header_Files_pre_'+v);  //                                                //
// notify('Build_Header_raw','*');                 #workunit('name','Initiate_Header_raw');         // Header.proc_Header.STEP1                       // Header.BWR_Build
// *** notify('Build_Header_raw_Weekly','*');      #workunit('name','Initiate_Header_raw');         // Header.proc_Header.STEP1_incremental           // Header.BWR_Build
// W:\Projects\Header\Incremental Raw\build incremental header raw.ecl
// raw and built1 gets updated after the raw build
// notify('Create_Raw_Header_Stats','*');          #workunit('name','Initiate_Raw_Header_Stats');   // header_avb.Stat.build_file                     // Header_AVB._BWR_Check_for_new_Header_raw_CRON
// W:\projects\Header\BuildAssistScripts\Build_assist.fix_header_raw_sf.header.ecl
// W:\Projects\Header\suppress_header_records\check_and_update_boca_suppression.ecl
// notify('Build_Header_base','*');                #workunit('name','Initiate_Header_base');        // Header.proc_Header.STEP2               ->XADL  //
// notify('Build_XADL','*');                       #workunit('name','Initiate_Header_XADL');        // Header.proc_postHeaderBuilds.XADLkeys  ->Rel   //
// notify('Build_Relatives','*');                  #workunit('name','Initiate_Header_Relatives');   // Header.proc_postHeaderBuilds.relatives ->keys  //
// notify('Build_Header_Keys','*');                #workunit('name','Initiate_Header_Keys');           // Header.proc_postHeaderBuilds.headerKeys->fin   // Header, slimsorts, and relative Keys
// notify('Finalize_Header_build','*');            #workunit('name','Initiate_Header_Finalize');    // Header.proc_postHeaderBuilds.finalize  ->fcra  // ""
// notify('Verify_Header_keys','*');               #workunit('name','Initiate_Header_Verify_keys'); // Header.proc_postHeaderBuilds.verify_all_Keys   //
// notify('Build_FCRA_Header','*');                #workunit('name','Initiate_Header_Keys_FCRA');   // Header.proc_postHeaderBuilds.FCRAheader ->bool //
// notify('Build_Header_boolean','*');             #workunit('name','Initiate_Header_Keys_Boolean');// Header.proc_postHeaderBuilds.booleanSrch       //

// W:\projects\Header\15-05a_BuildAssistScripts\BWR_Manual_stale_keys_rename.ecl
// C:\Users\marcga01\Documents\Archive\projects\Header\15-05a_BuildAssistScripts\BWR_Verify_superfiles_header.ecl //( includes ..Verify_XADL1_base_files) (use gmarcan_prod for count generator
// C:\Users\marcga01\Documents\Archive\projects\Header\15-05a_BuildAssistScripts\BWR_Update_dops_header.ecl
// ----------------------------------------        -----------------------------------------------  // -----------------------------------------------// ----------------------------------------------|                                       

/* THESE SHOULD ** ALWAYS ** BE SANDBOXED

_Control.LibraryUse                         ( 2017-06-28T00:05:57Z ) (line 20-21 swapped as commented out)
_Control.mod_xADLversion                    ( 2017-06-28T00:05:56Z ) (QA_version line 18 set as false)
_Control.MyInfo                             ( 2017-07-18T23:25:53Z ) (specify build operator details)

Data_Services.Data_location                 ( 2017-06-29T22:05:11Z ) (Support run of key build post copy to 60 on 44)

doxie_build.file_offenders_keybuilding      ( 2017-06-28T00:06:18Z ) (file name sandboxed thor_Data400::base::Corrections_Offenders_' + doxie_build.buildstate + '_BUILt instead of '...building')
// **********************
Header.Blocked_data_new						          ( 2011-10-23T16:11:37Z ) (includes custome blockings and exclude newer ones)
Header.BWR_scheduled_alpharetta_copy_hh...  ( 2016-05-17T19:03:43Z ) <-- TEMP copy HHID to Alpharetta
Header.File_HHID_Current					          ( 2017-06-27T00:23:23Z ) (persist suffix: ...+_headerbuilding)
Header.Files_SeqdSrc                        ( 2017-03-28T19:50:14Z ) using stored version date for incremental
Header.Fn_Remove_EN_deletes                 <-- 2017-02-01T02:17:12Z (more specific filename to avoid incremental build collitions)
Header.GetPackageKeys                       ( 2017-01-17T21:49:37Z ) typo fix??
Header.Inputs_Clear                         <-- skipping property update for Feb 2017
Header.Inputs_Sequence
Header.Inputs_Set
Header.LogBuild                               ( 2016-12-20T14:11:10Z ) <-- aded overwrite
Header.PreProcess							                ( 2017-03-15T05:04:54Z ) (persist suffix: ...+_header)
Header.proc_Header                            ( 2017-04-05T20:46:02Z ) <-- testing inputs_sequence
Header.Stats
Header.Verify_XADL1_base_files
Header.version_build						              ( MODIFY ON NEW HEADER ) (duting build to ensure the right version is being built)

Header_AVB._BWR_Check_for_new_Header_raw_CRON ( 2016-10-26T18:55:30Z ) code to also run Relative_AVB 

InsuranceHeader_PostProcess.segmentation_keys ( 2015-01-11T22:22:29Z ) (key location has extra suffix in sandbox version)

InsuranceHeader_xLink.KeySuperFile			  ( 2014-09-22T17:19:30Z ) (conditioned type in sandbox isntead of fixed per checked-in)

Relationship.layout_GetRelationship 	      (2015-10-03T08:28:46Z ) (layout changes have not been migrated to prod yet)

VersionControl.mBuildFilenameVersions ***     ( 2013-10-01T16:46:35Z ) (different version of the code altogether)

wk_ut.get_WUQuery							  ( 2016-03-11T20:38:17Z ) TEMP Pending bug 195793 review/migration

zz_gmarcan.EmailWuidOutcome                   ( 2016-10-17T17:41:04Z ) <-- no direct impact. consider dropping sandbox

*/