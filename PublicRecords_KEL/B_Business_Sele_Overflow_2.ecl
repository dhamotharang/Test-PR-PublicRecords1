//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Sele_Overflow_3,CFG_Compile,E_Business_Sele_Overflow,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_Overflow_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_Overflow_3(__in,__cfg).__ENH_Business_Sele_Overflow_3) __ENH_Business_Sele_Overflow_3 := B_Business_Sele_Overflow_3(__in,__cfg).__ENH_Business_Sele_Overflow_3;
  SHARED __EE7198812 := __ENH_Business_Sele_Overflow_3;
  SHARED __EE7198815 := __EE7198812;
  SHARED __ST1604652_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_Capped_;
    KEL.typ.nstr S_O_S_Dom_Filing_Max_Date_;
    KEL.typ.nstr S_O_S_Dom_Filing_Min_Date_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Domestic_Filing_;
    KEL.typ.int S_O_S_Domestic_Filing_Count_ := 0;
    KEL.typ.ndataset(B_Business_Sele_Overflow_3(__in,__cfg).__ST119349_Layout) S_O_S_Domestic_States_;
    KEL.typ.int S_O_S_Filing_Total_Count_ := 0;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Foreign_Filing_;
    KEL.typ.int S_O_S_Foreign_Filing_Count_ := 0;
    KEL.typ.ndataset(B_Business_Sele_Overflow_3(__in,__cfg).__ST119338_Layout) S_O_S_Foreign_States_;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_Capped_;
    KEL.typ.nstr S_O_S_Frgn_Filing_Max_Date_;
    KEL.typ.nstr S_O_S_Frgn_Filing_Min_Date_;
    KEL.typ.nstr S_O_S_Incorporation_State_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST1604652_Layout __JT7198826(B_Business_Sele_Overflow_3(__in,__cfg).__ST237076_Layout __l, B_Business_Sele_Overflow_3(__in,__cfg).__ST119349_Layout __r) := TRANSFORM
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE7198827 := NORMALIZE(__EE7198815,__T(LEFT.S_O_S_Domestic_States_),__JT7198826(LEFT,RIGHT));
  SHARED __ST1604820_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_Capped_;
    KEL.typ.nstr S_O_S_Dom_Filing_Max_Date_;
    KEL.typ.nstr S_O_S_Dom_Filing_Min_Date_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Domestic_Filing_;
    KEL.typ.int S_O_S_Domestic_Filing_Count_ := 0;
    KEL.typ.ndataset(B_Business_Sele_Overflow_3(__in,__cfg).__ST119349_Layout) S_O_S_Domestic_States_;
    KEL.typ.int S_O_S_Filing_Total_Count_ := 0;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Foreign_Filing_;
    KEL.typ.int S_O_S_Foreign_Filing_Count_ := 0;
    KEL.typ.ndataset(B_Business_Sele_Overflow_3(__in,__cfg).__ST119338_Layout) S_O_S_Foreign_States_;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_Capped_;
    KEL.typ.nstr S_O_S_Frgn_Filing_Max_Date_;
    KEL.typ.nstr S_O_S_Frgn_Filing_Min_Date_;
    KEL.typ.nstr S_O_S_Incorporation_State_;
    KEL.typ.nstr S_O_S_Incorporation_State__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7198961(__ST1604652_Layout __EE7198827, B_Business_Sele_Overflow_3(__in,__cfg).__ST119338_Layout __EE7198948) := __T(__OP2(__EE7198827.S_O_S_Incorporation_State_,=,__EE7198948.S_O_S_Incorporation_State_));
  __ST1604820_Layout __JT7198961(__ST1604652_Layout __l, B_Business_Sele_Overflow_3(__in,__cfg).__ST119338_Layout __r) := TRANSFORM, SKIP(NOT(__JC7198961(__l,__r)))
    SELF.S_O_S_Incorporation_State__1_ := __r.S_O_S_Incorporation_State_;
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE7198962 := NORMALIZE(__EE7198827,__T(LEFT.S_O_S_Foreign_States_),__JT7198961(LEFT,RIGHT));
  SHARED __ST1604238_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_O_S_Incorporation_State_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE7199096 := PROJECT(__EE7198962,TRANSFORM(__ST1604238_Layout,SELF.S_O_S_Incorporation_State_ := LEFT.S_O_S_Incorporation_State__1_,SELF := LEFT));
  SHARED __ST1604257_Layout := RECORD
    KEL.typ.int C_O_U_N_T___S_O_S_Foreign_States_ := 0;
    KEL.typ.nuid UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE7200233 := PROJECT(__CLEANANDDO(__EE7199096,TABLE(__EE7199096,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.typ.int C_O_U_N_T___S_O_S_Foreign_States_ := COUNT(GROUP),UID},UID,MERGE)),__ST1604257_Layout);
  SHARED __ST1604986_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_Capped_;
    KEL.typ.nstr S_O_S_Dom_Filing_Max_Date_;
    KEL.typ.nstr S_O_S_Dom_Filing_Min_Date_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Domestic_Filing_;
    KEL.typ.int S_O_S_Domestic_Filing_Count_ := 0;
    KEL.typ.ndataset(B_Business_Sele_Overflow_3(__in,__cfg).__ST119349_Layout) S_O_S_Domestic_States_;
    KEL.typ.int S_O_S_Filing_Total_Count_ := 0;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Foreign_Filing_;
    KEL.typ.int S_O_S_Foreign_Filing_Count_ := 0;
    KEL.typ.ndataset(B_Business_Sele_Overflow_3(__in,__cfg).__ST119338_Layout) S_O_S_Foreign_States_;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_Capped_;
    KEL.typ.nstr S_O_S_Frgn_Filing_Max_Date_;
    KEL.typ.nstr S_O_S_Frgn_Filing_Min_Date_;
    KEL.typ.int C_O_U_N_T___S_O_S_Foreign_States_ := 0;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7199117(B_Business_Sele_Overflow_3(__in,__cfg).__ST237076_Layout __EE7198812, __ST1604257_Layout __EE7200233) := __EEQP(__EE7198812.UID,__EE7200233.UID);
  __ST1604986_Layout __JT7199117(B_Business_Sele_Overflow_3(__in,__cfg).__ST237076_Layout __l, __ST1604257_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE7199118 := JOIN(__EE7198812,__EE7200233,__JC7199117(LEFT,RIGHT),__JT7199117(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST220160_Layout := RECORD
    KEL.typ.nstr S_O_S_Status_Code_;
    KEL.typ.nstr S_O_S_Status_Description_;
    KEL.typ.nkdate S_O_S_Status_Date_;
    KEL.typ.nkdate S_O_S_Process_Date_;
    KEL.typ.nint Days_Since_Status_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST220133_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(__ST220160_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_Capped_;
    KEL.typ.nstr S_O_S_Dom_Filing_Max_Date_;
    KEL.typ.nstr S_O_S_Dom_Filing_Min_Date_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Domestic_Filing_;
    KEL.typ.int S_O_S_Domestic_Filing_Count_ := 0;
    KEL.typ.ndataset(B_Business_Sele_Overflow_3(__in,__cfg).__ST119349_Layout) S_O_S_Domestic_States_;
    KEL.typ.int S_O_S_Filing_States_Count_Dups_ := 0;
    KEL.typ.int S_O_S_Filing_Total_Count_ := 0;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Foreign_Filing_;
    KEL.typ.int S_O_S_Foreign_Filing_Count_ := 0;
    KEL.typ.ndataset(B_Business_Sele_Overflow_3(__in,__cfg).__ST119338_Layout) S_O_S_Foreign_States_;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_Capped_;
    KEL.typ.nstr S_O_S_Frgn_Filing_Max_Date_;
    KEL.typ.nstr S_O_S_Frgn_Filing_Min_Date_;
    KEL.typ.nint S_O_S_Incorporation_New_Date_;
    KEL.typ.nint S_O_S_Incorporation_Old_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST220133_Layout __ND7200108__Project(__ST1604986_Layout __PP7199119) := TRANSFORM
    __EE7199372 := __PP7199119.S_O_S_Statuses_;
    __ST220160_Layout __ND7199377__Project(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Statuses_Layout __PP7199373) := TRANSFORM
      __CC13391 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Days_Since_Status_ := __FN2(KEL.Routines.MonthsBetween,__PP7199373.S_O_S_Process_Date_,__CC13391);
      SELF := __PP7199373;
    END;
    SELF.S_O_S_Statuses_ := __PROJECT(__EE7199372,__ND7199377__Project(LEFT));
    SELF.S_O_S_Filing_States_Count_Dups_ := __PP7199119.C_O_U_N_T___S_O_S_Foreign_States_;
    SELF.S_O_S_Incorporation_New_Date_ := KEL.Routines.MaxN(__ECAST(KEL.typ.nint,__PP7199119.S_O_S_Dom_Filing_Max_Date_),__ECAST(KEL.typ.nint,__PP7199119.S_O_S_Frgn_Filing_Max_Date_));
    __CC13700 := '-99997';
    SELF.S_O_S_Incorporation_Old_Date_ := IF(__T(__OP2(__CAST(KEL.typ.str,KEL.Routines.MinN(__ECAST(KEL.typ.nint,__PP7199119.S_O_S_Dom_Filing_Min_Date_),__ECAST(KEL.typ.nint,__PP7199119.S_O_S_Frgn_Filing_Min_Date_))),=,__CN(__CC13700))),__ECAST(KEL.typ.nint,KEL.Routines.MaxN(__ECAST(KEL.typ.nint,__PP7199119.S_O_S_Dom_Filing_Min_Date_),__ECAST(KEL.typ.nint,__PP7199119.S_O_S_Frgn_Filing_Min_Date_))),__ECAST(KEL.typ.nint,KEL.Routines.MinN(__ECAST(KEL.typ.nint,__PP7199119.S_O_S_Dom_Filing_Min_Date_),__ECAST(KEL.typ.nint,__PP7199119.S_O_S_Frgn_Filing_Min_Date_))));
    SELF := __PP7199119;
  END;
  EXPORT __ENH_Business_Sele_Overflow_2 := PROJECT(__EE7199118,__ND7200108__Project(LEFT));
END;
