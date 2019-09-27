﻿// -- Will rewind a build in case of build issues that require rerunning the build starting from a particular point
// -- Run this on hthor
// -- it will restore any workunits it needs to in order to do it's job.
// -- look in BIPV2_Build.files().workunit_history_.qa to find the workunit from which you would like to start deleting
// -- only issue could be if the workunit manager failed and was not able to either put a file into BIPV2_Build.files().workunit_history_.qa
// --   or it did not even output a particular file because of a failure.  This should be exceedingly rare.
// ds_extra := dataset([
   // {'~thor_data400::key::bizlinkfull::20181002a::proxid::meow'                       ,'prod_esp.br.seisint.com'}
  // ,{'~thor_data400::key::bizlinkfull::20181002a::proxid::refs::l_address1'           ,'prod_esp.br.seisint.com'}
// ],{string name,string esp});
// to get the restore and/or delete working, you may have to add the output of this: ut.Credentials().fGetEncodedValues() as a constant to this: ut.Credentials().mac_add2Soapcall()
// in your sandbox to prevent errors since it is stored in a file and that causes errors.
workman.Rewind_Build(
   pversion            := '20190701'                                // version of the build you are rolling back
  ,PWuid               := 'W20190708-210116'                        // all files created in this workunit and subsequent workunits(more recent) in this build will be deleted.
  ,pWorkman_Superfile  := BIPV2_Build.files().workunit_history_.qa
  ,pDeleteFiles        := false                                     // true = output the files to the workunit + delete them.  false = output the files to the workunit
  ,pFilter             := '^(?!.*?_underlinks.*).*$'                                        // optional additional regex filter for the files to delete.
  ,pRestoreWuids       := true
);