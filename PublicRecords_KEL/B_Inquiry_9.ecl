//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Inquiry_10,CFG_Compile,E_Inquiry,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Inquiry_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_10(__in,__cfg).__ENH_Inquiry_10) __ENH_Inquiry_10 := B_Inquiry_10(__in,__cfg).__ENH_Inquiry_10;
  SHARED __EE5065673 := __ENH_Inquiry_10;
  EXPORT __ST263723_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Search_Info_Layout) Search_Info_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Permissions_Layout) Permissions_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Bus_Intel_Layout) Bus_Intel_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Person_Info_Layout) Person_Info_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Business_Info_Layout) Business_Info_;
    KEL.typ.nint Fraudpoint_Score_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Agein_Days_;
    KEL.typ.str Inquiry_Function_Description_ := '';
    KEL.typ.str Inquiry_Industry_ := '';
    KEL.typ.str Inquiry_Method_ := '';
    KEL.typ.nint Inquiry_Product_Code_;
    KEL.typ.str Inquiry_Sub_Market_ := '';
    KEL.typ.str Inquiry_Vertical_ := '';
    KEL.typ.bool Is_Batch_Monitoring_Method_ := FALSE;
    KEL.typ.bool Is_Collection_ := FALSE;
    KEL.typ.nbool Is_Fcra_Ok_;
    KEL.typ.bool Is_Length_Sub_Market_ := FALSE;
    KEL.typ.nbool Is_Non_Fcra_Ok_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST263723_Layout __ND5065556__Project(B_Inquiry_10(__in,__cfg).__ST265391_Layout __PP5065181) := TRANSFORM
    __CC13149 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('inquiry_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Agein_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,FN_Compile(__cfg).FN_Time_Stamp_To_Date(__ECAST(KEL.typ.ntimestamp,KEL.era.EpochToNTimestamp(__PP5065181.Date_First_Seen_)))),__ECAST(KEL.typ.nkdate,__CC13149));
    __EE5065551 := __PP5065181.Search_Info_;
    SELF.Inquiry_Product_Code_ := (__T(__EE5065551))[1].Product_Code_;
    __CC33998 := ['BATCH','MONITORING'];
    SELF.Is_Batch_Monitoring_Method_ := KEL.Routines.ToUpperCase(TRIM(__PP5065181.Inquiry_Method_)) IN __CC33998;
    __CC34006 := ['COLLECTIONS','COLLECTION','COLLECTION LAW FIRM','DEBT BUYER','FIRST PARTY','THIRD PARTY'];
    __CC34012 := ['COLLECTIONS','RECEIVABLES MANAGEMENT','1PC','3PC'];
    SELF.Is_Collection_ := KEL.Routines.ToUpperCase(TRIM(__PP5065181.Inquiry_Industry_)) IN __CC34006 OR KEL.Routines.ToUpperCase(TRIM(__PP5065181.Inquiry_Vertical_)) IN __CC34012 OR __PP5065181.Is_Length_Sub_Market_;
    SELF.Is_Fcra_Ok_ := FN_Compile(__cfg).FN_Is_Fcra_Inquiry(__ECAST(KEL.typ.nstr,__CN(KEL.Routines.ToUpperCase(TRIM(__PP5065181.Inquiry_Function_Description_)))));
    SELF.Is_Non_Fcra_Ok_ := FN_Compile(__cfg).FN_Is_Non_Fcra_Inquiry(__ECAST(KEL.typ.nstr,__CN(KEL.Routines.ToUpperCase(TRIM(__PP5065181.Inquiry_Function_Description_)))));
    SELF := __PP5065181;
  END;
  EXPORT __ENH_Inquiry_9 := PROJECT(__EE5065673,__ND5065556__Project(LEFT));
END;
