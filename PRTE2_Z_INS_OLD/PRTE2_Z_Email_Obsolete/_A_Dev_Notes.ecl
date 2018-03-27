EXPORT _A_Dev_Notes := 'todo';
/* ****************************************************************************************************************************************
GENERAL CUSTOMER TEST SYSTEM NOTES:

*************** June 2015 --- this thing is really ugly and broken.
We are rewriting it into PRTE2_Email_Data













We saw Email_Data.Build_Base takes multiple input files and merges those sources into the final email data
We believe that CT data should just need one single input spreadsheet to populate the entire email data rather than multiple sources
So for CT we just selected one of these to be the CT base example - we are using the MediaOne source to emulate for our single CT source.

The initial incoming CT spreadsheet uses the recordset of, and will emulate the MediaOne incoming sprayed data. 
Everything in PRTE2_Email that starts with p1_ is more or less portions of the process for building as was done in the MediaOne module.
That p1 process will then do the "pre-processing" that happens to mediaOne data to prepare it which then becomes the 
incoming dataset for the regular Email_Data build process.  So this will be a two phase build process in that sense.
Everything else in the PRTE2_Email module that does not start with p1 - comes from the Email_data module

MAIN BUILD PROCESS STEPS:

PRTE2_Email._BWR_1_BuildMaster can be loaded as in a builder window and run
PRTE2_Email.Build_Master is equivalent to Email_Data.BWR_Build_Email which appears to be a function to be called from a BWR script
The larger Email_Data attributes were brought over pretty much as-is, for instance:
	PRTE2_Email.Build_Base and Build_keys are equivalent to the Email_Data.Build_Base and Build_keys
The larger Fn_xyz_something attributes are still stand alone, but the smaller ones are gathered into _functions
I also gathered literals into _constants and file and key definitions into _files and _keys and gathered layouts into _layouts

PRTE2_Email.Map_P1_As_Email stands in then for the Email_Data.Map_MediaOne_as_Email and we don't worry with any other email sources for now.
this also has to trigger off the initial build process for the MediaOne-like pre-build data.

QUESTIONS AND TODO STUFF:

//TODO - _constants - need file and directory names checked and confirmed in _constants

//TODO - Build_Base - 
  NOTE: Build_Base does not need to do Fn_Propagate_Src_From_Multiple_Srcs unless CT imports multiple
					-- does CT need to do the Propagate_Did step? Don't think it'll hurt anything to leave it in.

//TODO - Send_Build_Email_Notice - need email notices figured out especially in prod.

//TODO - Build_MASTER, etc - CustomerTest_Common.SuperFiles.Clear - DO WE NEED THIS?  
			If so, we'll need to clone CustomerTest_Common code over to Boca

//TODO ??? I Removed the superfile from p1 phase does this break the fact we might want history versions?? 

//TODO - Map_P1_As_Email 
Do I need a SEQUENTIAL to force top two lines to execute?
performs:  emailservice.mac_append_domain_flags(...)
  ==>> No idea if that mac in the emailservice module will operate outside of Email_data module
		 ALSO - determine what we want where we map the 3 email_src fields as MediaOne ???


//----------------------------------------------------------------------------------------------------------------------------
//TODO - for now renamed a number of attributes I don't think we need AND Attributes that I kept early version of.
PRTE2_Email.z_Fn_Rollup_Email_Data_ORIG
PRTE2_Email.z_p1_build_autokey_ORIG
PRTE2_Email.z_p1_proc_build_all_ORIG
PRTE2_Email.z_p1_procs_ORIG
PRTE2_Email.z_p1_build_base_ORIG

PRTE2_Email.z__BWR_FN_Build_Email_ORIG_TMP

**************************************************************************************************************************************** */
