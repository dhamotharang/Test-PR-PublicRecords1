//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Bankruptcy_2,B_Bankruptcy_8,CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Bankruptcy_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_2().__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2;
  SHARED __EE2130786 := __ENH_Bankruptcy_2;
  EXPORT __ST110578_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST167734_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Bankruptcy_2(__in,__cfg).__ST1174430_Layout) Best_Child_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Bankruptcy_1 := PROJECT(__EE2130786,__ST110578_Layout);
END;
