//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Sele_Person_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Person,E_Sele_Person,E_Surname FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Person_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4;
  SHARED __EE650313 := __ENH_Sele_Person_4;
  EXPORT __ST134439_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.bool Is_Executive_Ever_ := FALSE;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST134439_Layout __ND650522__Project(B_Sele_Person_4(__in,__cfg).__ST140798_Layout __PP650159) := TRANSFORM
    __BS650251 := __T(__PP650159.Contact_Info_);
    SELF.Is_Executive_Ever_ := EXISTS(__BS650251(__T(__OP2(__T(__PP650159.Contact_Info_).Is_Executive_,=,__CN(TRUE)))));
    SELF := __PP650159;
  END;
  EXPORT __ENH_Sele_Person_3 := PROJECT(__EE650313,__ND650522__Project(LEFT));
END;
