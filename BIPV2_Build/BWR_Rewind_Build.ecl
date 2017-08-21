// -- Will rewind a build in case of build issues that require rerunning the build starting from a particular point
// -- Run this on hthor
// -- it will restore any workunits it needs to in order to do it's job.
// -- look in BIPV2_Build.files().workunit_history_.qa to find the workunit from which you would like to start deleting
// -- only issue could be if the workunit manager failed and was not able to either put a file into BIPV2_Build.files().workunit_history_.qa
// --   or it did not even output a particular file because of a failure.  This should be exceedingly rare.
wk_ut.Rewind_Build(
   pversion            := '20160204'                                // version of the build you are rolling back
  ,PWuid               := 'W20160218-195630'                        // all files created in this workunit and subsequent workunits(more recent) in this build will be deleted.
  ,pWorkman_Superfile  := BIPV2_Build.files().workunit_history_.qa
  ,pDeleteFiles        := false                                     // true = output the files to the workunit + delete them.  false = output the files to the workunit
  ,pFilter             := ''                                        // optional additional regex filter for the files to delete.
);