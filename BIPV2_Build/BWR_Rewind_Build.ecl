// -- Will rewind a build in case of build issues that require rerunning the build starting from a particular point
// -- Run this on hthor
// -- it will restore any workunits it needs to in order to do it's job.
// -- look in BIPV2_Build.files().workunit_history_.qa to find the workunit from which you would like to start deleting
// -- only issue could be if the workunit manager failed and was not able to either put a file into BIPV2_Build.files().workunit_history_.qa
// --   or it did not even output a particular file because of a failure.  This should be exceedingly rare.
// ds_extra := dataset([
   // {'~thor_data400::key::bizlinkfull::20181002a::proxid::meow'                       ,'uspr-prod-thor-esp.risk.regn.net'}
  // ,{'~thor_data400::key::bizlinkfull::20181002a::proxid::refs::l_address1'           ,'uspr-prod-thor-esp.risk.regn.net'}
// ],{string name,string esp});
// to get the restore and/or delete working, you may have to add the output of this: ut.Credentials().fGetEncodedValues() as a constant to this: ut.Credentials().mac_add2Soapcall()
// in your sandbox to prevent errors since it is stored in a file and that causes errors.

// -- since using the virtual fileposition on hthor produces some garbage in the field, it needs to be run on thor first to get the real filename as a regular field.
// -- so run this piece of code first to create a regular file with the file position field as a regular field, then you pass that file into the rewind_build function.

// -----------------------------------------------------------------------------------------------------------
// -- 1. Run this code first on thor
// --    run this piece of code first to create a regular file with the file position field as a regular field(instead of virtual)
// -----------------------------------------------------------------------------------------------------------
lversion              := '20200303'                                                     ; // version of the build you are rolling back
lWuid                 := 'W20200317-053149'                                             ; // all files created in this workunit and subsequent workunits(more recent) in this build will be deleted.
temp_workman_filename := '~bipv2_build::'+ trim(lversion) + '::workunit_history::temp2' ; // temp workman filename of all workman steps to be deleted

ds_wuids      := BIPV2_Build.files().workunit_history_.qa(wuid != ''  ,lWuid = '' or wuid >= lWuid  ,lversion = '' or version = lversion);
ds_wuids_proj := project(ds_wuids ,transform(Workman.Layouts.wks_slim_filename2,self := left));

output(ds_wuids_proj  ,,temp_workman_filename,overwrite);

// -----------------------------------------------------------------------------------------------------------
// -- 2. Run this code second on hthor passing in the file created in the first step
// -----------------------------------------------------------------------------------------------------------
temp_workman_file := dataset(temp_workman_filename  ,Workman.Layouts.wks_slim_filename2 ,flat);

workman.Rewind_Build(
   pversion            := lversion                                // version of the build you are rolling back
  ,PWuid               := lWuid                                       // all files created in this workunit and subsequent workunits(more recent) in this build will be deleted.
  ,pWorkman_Superfile  := temp_workman_file
  // ,pWorkman_Superfile  := BIPV2_Build.files().workunit_history_.qa
  ,pDeleteFiles        := true                                     // true = output the files to the workunit + delete them.  false = output the files to the workunit
  ,pFilter             := ''                                        // optional additional regex filter for the files to delete.
  // ,pFilter             := '^(?!.*?_underlinks.*).*$'                                        // optional additional regex filter for the files to delete.
  ,pRestoreWuids       := false
);
