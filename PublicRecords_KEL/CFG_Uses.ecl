﻿//HPCC Systems KEL Compiler Version 0.11.4
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT CFG_Uses := MODULE, VIRTUAL
  // **** Do not override these definitions - they are used to define the interface to KEL queries ****;
  EXPORT FDCLayout := RECORDOF(PublicRecords_KEL.ECL_Functions.Blank_DataSet);
  EXPORT FDCDataset := DATASET(FDCLayout);
  EXPORT FDCDefault := PublicRecords_KEL.ECL_Functions.Blank_DataSet;
  EXPORT UNSIGNED8 Permit_FCRA := 0x1;
  EXPORT UNSIGNED8 Permit_nonFCRA := 0x2;
END;
