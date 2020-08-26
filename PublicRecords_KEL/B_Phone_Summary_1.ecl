//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Phone_Summary_2,B_Phone_Summary_3,CFG_Compile,E_Address,E_Geo_Link,E_Input_P_I_I,E_Person,E_Phone_Summary,E_Property,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Phone_Summary_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_2(__in,__cfg).__ENH_Phone_Summary_2) __ENH_Phone_Summary_2 := B_Phone_Summary_2(__in,__cfg).__ENH_Phone_Summary_2;
  SHARED __EE5156213 := __ENH_Phone_Summary_2;
  EXPORT __ST229895_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST229873_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Summary_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST229895_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Summary_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P_I___Src_W_Inp_P_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST56719_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST937634_Layout) Translated_D_O_B_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST229873_Layout __ND5156152__Project(B_Phone_Summary_2(__in,__cfg).__ST229701_Layout __PP5155892) := TRANSFORM
    __EE5156216 := __PP5155892.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE5156216),__ST229895_Layout),__NL(__EE5156216));
    __CC10888 := '-99999';
    __CC10893 := '-99998';
    __BS5155994 := __T(__PP5155892.Translated_D_O_B_Sources_);
    __EE5156145 := __PP5155892.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_List_Ev_ := MAP(__T(__OR(__OP2(__PP5155892.P___Inp_Cln_Phone_Home_,IN,__CN([__CC10888,__CC10893])),__OP2(__PP5155892.P___Inp_Cln_D_O_B_,IN,__CN([__CC10888,__CC10893]))))=>__ECAST(KEL.typ.nstr,__CN(__CC10888)), NOT EXISTS(__BS5155994(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__PP5155892.Translated_D_O_B_Sources_).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP5155892.P___Inp_Cln_D_O_B_))))=>__ECAST(KEL.typ.nstr,__CN(__CC10893)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE5156145,LEFT.Source_,__CN('|'))));
    SELF := __PP5155892;
  END;
  EXPORT __ENH_Phone_Summary_1 := PROJECT(__EE5156213,__ND5156152__Project(LEFT));
END;
