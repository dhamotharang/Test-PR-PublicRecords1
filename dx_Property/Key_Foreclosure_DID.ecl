IMPORT $, doxie, Data_Services;

inFile := $.Layouts.i_did;

EXPORT Key_Foreclosure_DID := INDEX(
  {inFile.did},
  {inFile.fid},
  $.names().i_foreclosure_did
  );
                                    