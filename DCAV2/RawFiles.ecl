EXPORT RawFiles := MODULE
  IMPORT SALTTOOLS22;
// RawFile handling for btlt
  Full := '_control.IPAddress.bctlpedata10/prod_data_build_13/eval_data/dca/test/l*txt';
  EXPORT btlt_Names := SALTTOOLS22.mod_FilenamesInput('ingest_data::DCAV2::btlt::@version@','',SALTTOOLS22.mod_utilities.IpFromFull(Full),SALTTOOLS22.mod_utilities.DirectoryFromFull(Full),SALTTOOLS22.mod_utilities.WildCardFromFull(Full),0,,,,,'VARIABLE',,,,'\r\n',);
// The below can be used to note the 'hand spraying' of a particular file
  EXPORT btlt_NoteSpray(STRING name) := fileservices.addsuperfile(btlt_Names.sprayed, '~' + name);
  EXPORT btlt_Spray := SALTTOOLS22.fun_spray(SALTTOOLS22.mod_utilities.ConvertInput2SprayDataset(btlt_names.dall_filenames));
// Now the combined functions - allows all of the inputs to be treated as one
  EXPORT CreateSupers := SALTTOOLS22.mod_Utilities.CreateInputSupers(btlt_Names.dAll_filenames);
  EXPORT Promote := SALTTOOLS22.mod_PromoteInput('',btlt_Names.dAll_filenames);
  EXPORT Spray := SALTTOOLS22.fun_spray(SALTTOOLS22.mod_utilities.ConvertInput2SprayDataset(btlt_names.dall_filenames));
END;
