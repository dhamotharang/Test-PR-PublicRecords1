import ut;

// Example: {'thor400_20::base::hss_name_source_prod','',true,ut.GetDate + ut.getTime()}
// No pattern value required just the supername and set it to true if you don't want to
// apply deletes to this super, false if the file is used in multiple supers and yet you want
// to apply deletes
// Used only for deletes
EXPORT ChangePatternSetup := dataset([{'thor::base::aidtemp::ace::cache::prod','',false,ut.GetDate + ut.getTime()},
																{'thor::base::aidtemp::raw::cache::prod','',false,ut.GetDate + ut.getTime()},
																{'thor::base::aidtemp::std::cache::prod','',false,ut.GetDate + ut.getTime()}],thorbackup.Layout_DeleteFilesInfo);