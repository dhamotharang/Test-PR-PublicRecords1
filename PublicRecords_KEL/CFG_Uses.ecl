﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT CFG_Uses := MODULE, VIRTUAL
  // **** Do not override these definitions - they are used to define the interface to KEL queries ****;
  EXPORT FDCLayout := RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
  EXPORT FDCDataset := DATASET(FDCLayout);
  EXPORT FDCDefault := PublicRecords_KEL.ECL_Functions.Dataset_FDC;
  EXPORT UNSIGNED8 Permit_Restricted := 0x1;
  EXPORT UNSIGNED8 Permit_NoRestriction := 0x2;
  EXPORT UNSIGNED8 Permit_FCRA := 0x4;
  EXPORT UNSIGNED8 Permit_NonFCRA := 0x8;
  EXPORT UNSIGNED8 Permit_GLBA := 0x10;
  EXPORT UNSIGNED8 Permit_DPPA := 0x20;
  EXPORT UNSIGNED8 Permit_Marketing := 0x40;
  EXPORT UNSIGNED8 Permit_InsuranceProduct := 0x80;
  EXPORT UNSIGNED8 Permit_Fares := 0x100;
  EXPORT UNSIGNED8 Permit_Experian := 0x200;
  EXPORT UNSIGNED8 Permit_ExperianFCRA := 0x400;
  EXPORT UNSIGNED8 Permit_TransUnion := 0x800;
  EXPORT UNSIGNED8 Permit_Equifax := 0x1000;
  EXPORT UNSIGNED8 Permit_Advo := 0x2000;
  EXPORT UNSIGNED8 Permit_Cortera := 0x4000;
  EXPORT UNSIGNED8 Permit_ExperianEBR := 0x8000;
  EXPORT UNSIGNED8 Permit_ExperianCRDB := 0x10000;
  EXPORT UNSIGNED8 Permit_SSNDeathMaster := 0x20000;
  EXPORT UNSIGNED8 Permit_FDN := 0x40000;
  EXPORT UNSIGNED8 Permit_InsuranceDL := 0x80000;
  EXPORT UNSIGNED8 Permit_SBFE := 0x100000;
  EXPORT UNSIGNED8 Permit_DNBDMI := 0x200000;
  EXPORT UNSIGNED8 Permit_Targus := 0x400000;
  EXPORT UNSIGNED8 Permit_Certegy := 0x800000;
  EXPORT UNSIGNED8 Permit_PreGLB := 0x1000000;
  EXPORT UNSIGNED8 Permit_LiensJudgments := 0x2000000;
  EXPORT UNSIGNED8 Permit_ExperianPhones := 0x4000000;
  EXPORT UNSIGNED8 Permit_Inquiries := 0x8000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup1 := 0x10000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup2 := 0x20000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup3 := 0x40000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup4 := 0x80000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup5 := 0x100000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup6 := 0x200000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup7 := 0x400000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup8 := 0x800000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup9 := 0x1000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup10 := 0x2000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup11 := 0x4000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup12 := 0x8000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup13 := 0x10000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup14 := 0x20000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup15 := 0x40000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup16 := 0x80000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup17 := 0x100000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup18 := 0x200000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup19 := 0x400000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup20 := 0x800000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup21 := 0x1000000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup22 := 0x2000000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup23 := 0x4000000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup24 := 0x8000000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup25 := 0x10000000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup26 := 0x20000000000000;
  EXPORT UNSIGNED8 Permit_DPPAGroup27 := 0x40000000000000;
  EXPORT UNSIGNED8 Permit_Unassigned9 := 0x80000000000000;
  EXPORT UNSIGNED8 Permit_Unassigned8 := 0x100000000000000;
  EXPORT UNSIGNED8 Permit_Unassigned7 := 0x200000000000000;
  EXPORT UNSIGNED8 Permit_Unassigned6 := 0x400000000000000;
  EXPORT UNSIGNED8 Permit_Unassigned5 := 0x800000000000000;
  EXPORT UNSIGNED8 Permit_Unassigned4 := 0x1000000000000000;
  EXPORT UNSIGNED8 Permit_Unassigned3 := 0x2000000000000000;
  EXPORT UNSIGNED8 Permit_Unassigned2 := 0x4000000000000000;
  EXPORT UNSIGNED8 Permit_Unassigned1 := 0x8000000000000000;
END;
