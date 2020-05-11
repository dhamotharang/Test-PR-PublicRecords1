//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Sele_Phone_Number_2,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Phone,E_Sele_Phone_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Phone_Number_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Phone_Number_2().__ENH_Sele_Phone_Number_2) __ENH_Sele_Phone_Number_2 := B_Sele_Phone_Number_2(__in,__cfg).__ENH_Sele_Phone_Number_2;
  SHARED __EE2828253 := __ENH_Sele_Phone_Number_2;
  EXPORT __ST124777_Layout := RECORD
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
  EXPORT __ST124739_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Best_Phone_Details_Layout) Best_Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Phone_Details_Layout) Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Marketability_Layout) Marketability_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST124777_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST124739_Layout __ND2828519__Project(B_Sele_Phone_Number_2(__in,__cfg).__ST136828_Layout __PP2828066) := TRANSFORM
    __EE2828186 := __PP2828066.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE2828186),__ST124777_Layout),__NL(__EE2828186));
    SELF := __PP2828066;
  END;
  EXPORT __ENH_Sele_Phone_Number_1 := PROJECT(__EE2828253,__ND2828519__Project(LEFT));
END;
