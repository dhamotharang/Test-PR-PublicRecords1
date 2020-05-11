//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Sele_Phone_Number_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Phone,E_Sele_Phone_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Phone_Number_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Phone_Number_4().__ENH_Sele_Phone_Number_4) __ENH_Sele_Phone_Number_4 := B_Sele_Phone_Number_4(__in,__cfg).__ENH_Sele_Phone_Number_4;
  SHARED __EE1163782 := __ENH_Sele_Phone_Number_4;
  EXPORT __ST147477_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST147439_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Best_Phone_Details_Layout) Best_Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Phone_Details_Layout) Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Marketability_Layout) Marketability_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST147477_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST147439_Layout __ND1164048__Project(B_Sele_Phone_Number_4(__in,__cfg).__ST156109_Layout __PP1163595) := TRANSFORM
    __EE1163715 := __PP1163595.Data_Sources_;
    SELF.Data_Sources_ := __PROJECT(__EE1163715,__ST147477_Layout);
    SELF := __PP1163595;
  END;
  EXPORT __ENH_Sele_Phone_Number_3 := PROJECT(__EE1163782,__ND1164048__Project(LEFT));
END;
