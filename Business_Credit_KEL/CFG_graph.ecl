//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT CFG_graph := MODULE, VIRTUAL
  // **** Do not override these definitions - they are used to define the interface to KEL queries ****;
  EXPORT FDCLayout := RECORDOF(Business_Credit_KEL.File_SBFE_temp);
  EXPORT FDCDataset := DATASET(FDCLayout);
  EXPORT FDCDefault := Business_Credit_KEL.File_SBFE_temp;
  // **** These definitions may be overridden as needed ****;
  // Override to set the date to use for CURRENTDATE;
  EXPORT KEL.typ.kdate CurrentDate := KEL.Routines.Today();
END;
