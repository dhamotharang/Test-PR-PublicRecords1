IMPORT $, PublicRecords_KEL;

EXPORT LIB_B2B_interface (
         DATASET($.layouts.Shell) shell,
         $.LIB_B2B_options options,
         set of string2 AllowedSourcesSet) := INTERFACE

  EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessSeleID) Results;
END;
