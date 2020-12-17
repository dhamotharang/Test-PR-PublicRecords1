IMPORT Business_Risk_BIP, PublicRecords_KEL;

EXPORT LIB_B2B_interface (
         DATASET(Business_Risk_BIP.layouts.Shell) shell,
         Business_Risk_BIP.LIB_B2B_options options,
         set of string2 AllowedSourcesSet) := INTERFACE

  EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutB2B) Results;
END;
