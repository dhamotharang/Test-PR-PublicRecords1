//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Name_Summary_2,B_Name_Summary_3,B_Name_Summary_4,CFG_Compile,E_Address,E_Geo_Link,E_Input_P_I_I,E_Person,E_Property,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Name_Summary_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Name_Summary_2(__in,__cfg).__ENH_Name_Summary_2) __ENH_Name_Summary_2 := B_Name_Summary_2(__in,__cfg).__ENH_Name_Summary_2;
  SHARED __EE5016816 := __ENH_Name_Summary_2;
  EXPORT __ST149868_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
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
  EXPORT __ST149861_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST149868_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_3(__in,__cfg).__ST60095_Layout) Name_Summary_Source_List_;
    KEL.typ.ndataset(B_Name_Summary_3(__in,__cfg).__ST60095_Layout) Name_Summary_Source_List_Sorted_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST60039_Layout) Translated_Sources_;
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
  SHARED __ST149861_Layout __ND5016778__Project(B_Name_Summary_2(__in,__cfg).__ST167045_Layout __PP5016592) := TRANSFORM
    __EE5016819 := __PP5016592.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE5016819),__ST149868_Layout),__NL(__EE5016819));
    __CC10870 := '-99999';
    __CC10872 := '-99998';
    __BS5016665 := __T(__PP5016592.Name_Summary_Source_List_Sorted_);
    __EE5016771 := __PP5016592.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP5016592.P___Inp_Cln_Name_First_,IN,__CN([__CC10870,__CC10872])),__OP2(__PP5016592.P___Inp_Cln_Name_Last_,IN,__CN([__CC10870,__CC10872]))),__OP2(__PP5016592.P___Inp_Cln_D_O_B_,IN,__CN([__CC10870,__CC10872]))))=>__ECAST(KEL.typ.nstr,__CN(__CC10870)), NOT EXISTS(__BS5016665(__T(__NOT(__OP2(__T(__PP5016592.Name_Summary_Source_List_Sorted_).Translated_Source_Code_,=,__CN(__CC10872))))))=>__ECAST(KEL.typ.nstr,__CN(__CC10872)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE5016771,LEFT.Translated_Source_Code_,__CN('|'))));
    SELF := __PP5016592;
  END;
  EXPORT __ENH_Name_Summary_1 := PROJECT(__EE5016816,__ND5016778__Project(LEFT));
END;
