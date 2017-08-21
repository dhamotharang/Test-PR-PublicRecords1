/* SPRINT 2:

change seg stats, best, key bh linking ids to point to new lgid3 file -- check
add lgid3 to proc build all --check, but commented out
for build, turn off everything after lgid3.  xlink will run later
put in xlink stuff, track changes & remember my changes from last time(order of keys being built, add "built" versions that are used to build the dependent ones)
changed these last time to refer to built versions of keys to build them properly
BizLinkFull.Process_Biz_Layouts
BizLinkFull.Wheel

  BIPV2_Build.BIPV2FullKeys_Package
  BizLinkFull.keynames
  
compile key changes for updating dops
dropping wheel phonetic
removing wheel p_city_name & wheel quick p_city_name
adding wheel city_clean, & wheel quick city clean

add extra parameters to set of results for email(like in prox and dot)

changed attributes because of addition of lgid3:
BIPV2_Best.fn_Prep_for_Base
BIPV2_Best.In_Base
BIPV2_Best.Layouts
BIPV2.Key_BH_Linking_Ids
BIPV2_Build.BWR_Build_All
BIPV2_Build.proc_best
BIPV2_Build.proc_build_all
BIPV2_Build.proc_dotid
BIPV2_Build.proc_segmentation
BIPV2_PostProcess.fieldStats
BIPV2_PostProcess.fieldstats_org
BIPV2_PostProcess.fieldstats_prox
BIPV2_PostProcess.fieldstats_sele
BIPV2_PostProcess.proc_segmentation
BIPV2_PostProcess.segmentation

I have bipv2_dotid attributes sandboxed because they weren't syntax checking(made them match prod)

*/





/* SPRINT 1
//can't check in to dataland:
BIPV2_Best.Layouts
BIPv2_HRCHY.Layouts

//other peoples attributes:
BIPV2_Company_Names.functions 
BIPV2_Company_Names.files
BIPV2_Company_Names.layouts
DW's mod file
Todd's stuff

//DOT stuff
BIPV2_Files.files_dotid
BIPV2_Files.files_ingest
BIPV2_Files.layout_ingest
BIPV2_Files.tools_dotid


//bipv2_build atts -- migrated
BIPV2_Build._Atts
BIPV2_Build._Constants
BIPV2_Build._Notes
BIPV2_Build.BIPV2FullKeys_Package
BIPV2_Build.BIPV2WeeklyKeys_Package
BIPV2_Build.BWR_Build_All
BIPV2_Build.BWR_Build_All_Keys
BIPV2_Build.BWR_Copy_BIPV2FullKeys
BIPV2_Build.BWR_Promote2QA
BIPV2_Build.BWR_Rollback
BIPV2_Build.BWR_SetupPrecision
BIPV2_Build.BWR_Verify_Packages
BIPV2_Build.Copy_BIPV2FullKeys
BIPV2_Build.filenames
BIPV2_Build.key_contact_linkids
BIPV2_Build.key_directories_linkids
BIPV2_Build.keynames
BIPV2_Build.keys
BIPV2_Build.mod_email
BIPV2_Build.proc_best
BIPV2_Build.proc_build_all
BIPV2_Build.proc_copy_xlink_keys
BIPV2_Build.proc_dotid
BIPV2_Build.proc_hrchy
BIPV2_Build.proc_industry_license
BIPV2_Build.proc_ingest
BIPV2_Build.proc_misc_keys
BIPV2_Build.proc_proxid
BIPV2_Build.proc_relative
BIPV2_Build.proc_segmentation
BIPV2_Build.proc_weekly_keys
BIPV2_Build.proc_xlink
BIPV2_Build.Promote
BIPV2_Build.Promote2QA
BIPV2_Build.Rollback
BIPV2_Build.Send_Emails

//bipv2 files
//BIPV2_Files.files_proxid  //maybe not


//segmentation stats -- migrated
bipv2_postprocess._constants
bipv2_postprocess.fieldstats
bipv2_postprocess.fieldstats_org
bipv2_postprocess.fieldstats_prox
bipv2_postprocess.fieldstats_sele
bipv2_postprocess.filenames
bipv2_postprocess.files
bipv2_postprocess.layouts
bipv2_postprocess.proc_segmentation
bipv2_postprocess.promote
bipv2_postprocess.segmentation
bipv2_postprocess.send_emails
BIPV2_Files.files_segmentation
BIPV2_Files.layout_segmentation

// topbusiness stuff  -- migrated
topbusiness_bipv2._dataset
topbusiness_bipv2._flags
topbusiness_bipv2.build_industry_all
topbusiness_bipv2.build_industry_base
topbusiness_bipv2.file_industry_base
topbusiness_bipv2.filenames
topbusiness_bipv2.files
topbusiness_bipv2.key_industry_linkids
topbusiness_bipv2.keynames
topbusiness_bipv2.proc_build_industry_key
topbusiness_bipv2.promote
TopBusiness_BIPV2.Rollback
topbusiness_bipv2.send_email
TopBusiness_BIPV2.BWR_Promote2QA
TopBusiness_BIPV2.BWR_Rollback

// Xlink -- done -- migrated
bizlinkfull._constants
bizlinkfull.keynames
bizlinkfull.proc_build_all
bizlinkfull.promote
BizLinkFull.BWR_Promote2QA
BizLinkFull.BWR_Rollback
BizLinkFull.Rollback

//relatives -- done -- migrated
BIPV2_Build.proc_relative
BIPV2_Relative._Constants
BIPV2_Relative.BWR_Promote2QA
BIPV2_Relative.BWR_Rollback
BIPV2_Relative.In_DOT_Base
BIPV2_Relative.keynames
BIPV2_Relative.Promote
BIPV2_Relative.Rollback

//hrchy -- done -- migrated
bipv2_hrchy._constants
bipv2_hrchy.filenames
bipv2_hrchy.files
bipv2_hrchy.keynames
bipv2_hrchy.keys
bipv2_hrchy.layouts           //had to remove store number for now because don't have matching keys yet
bipv2_hrchy.mod_build
bipv2_hrchy.promote
BIPv2_HRCHY.BWR_Promote2QA
BIPv2_HRCHY.BWR_Rollback
BIPv2_HRCHY.Rollback
bipv2_build.proc_hrchy
BIPV2_Files.files_hrchy
BIPV2_Files.files_proxid
BIPV2_Build.mod_email

//best done -- migrated
bipv2_best.build_keys
bipv2_best.promote
BIPV2_Best.Keys_Best
bipv2_build.proc_best
BIPV2_Best_test6.BWR_Promote2QA
BIPV2_Best_test6.BWR_Rollback
BIPV2_Best_test6.Append_After_Best
BIPV2_Best_test6.layouts
bipv2_best_test6._constants

//done -- migrated
tools.constants
tools.fun_updatedops
tools.layout_fun_copyfiles
tools.macf_filesindex
tools.mod_rollback
tools.mod_rollbackbuild
tools.mod_Promote
tools.mod_PromoteBuild
tools.mod_SendEmails
//tools.Workunit_utils
*/