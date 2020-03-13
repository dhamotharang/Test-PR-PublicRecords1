//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Bankruptcy_4,CFG_Compile,E_Bankruptcy,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Bankruptcy_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4;
  SHARED __EE410249 := __ENH_Bankruptcy_4;
  EXPORT __ST127487_Layout := RECORD
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.int Child_Sort_List_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST409299_Layout := RECORD
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.int Child_Sort_List_ := 0;
    KEL.typ.nbool Banko10_Year_;
    KEL.typ.nbool Banko10_Year_Update_Filter_;
    KEL.typ.nbool Banko1_Year_;
    KEL.typ.nbool Banko1_Year_Update_Filter_;
    KEL.typ.nbool Banko7_Year_;
    KEL.typ.nbool Banko7_Year_Update_Filter_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nstr Bus_Change_Chapter_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.str Modified_Disposition_ := '';
    KEL.typ.nint Status_Update_Age_In_Days_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST127480_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST127487_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST409299_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST127480_Layout __ND410226__Project(B_Bankruptcy_4(__in,__cfg).__ST135350_Layout __PP409341) := TRANSFORM
    __EE410252 := __PP409341.Records_;
    SELF.Records_ := __BN(PROJECT(__T(__EE410252),__ST127487_Layout),__NL(__EE410252));
    __EE410224 := __PP409341.Best_Child_Record_;
    __ST409299_Layout __ND410151__Project(B_Bankruptcy_4(__in,__cfg).__ST263272_Layout __PP409880) := TRANSFORM
      __CC18315 := 3652;
      __CC9035 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
      SELF.Banko10_Year_Update_Filter_ := __AND(__AND(__AND(__AND(__PP409880.Is_Bankruptcy_,__PP409880.Banko10_Year_),__OP2(__PP409880.Status_Update_Age_In_Days_,<=,__CN(__CC18315))),__NOT(__NT(__PP409880.Last_Status_Update_))),__OP2(__PP409880.Last_Status_Update_,<=,__CC9035));
      __CC18301 := 365;
      SELF.Banko1_Year_Update_Filter_ := __AND(__AND(__AND(__AND(__PP409880.Is_Bankruptcy_,__PP409880.Banko1_Year_),__OP2(__PP409880.Status_Update_Age_In_Days_,<=,__CN(__CC18301))),__NOT(__NT(__PP409880.Last_Status_Update_))),__OP2(__PP409880.Last_Status_Update_,<=,__CC9035));
      __CC18313 := 2556;
      SELF.Banko7_Year_Update_Filter_ := __AND(__AND(__AND(__AND(__PP409880.Is_Bankruptcy_,__PP409880.Banko7_Year_),__OP2(__PP409880.Status_Update_Age_In_Days_,<=,__CN(__CC18313))),__NOT(__NT(__PP409880.Last_Status_Update_))),__OP2(__PP409880.Last_Status_Update_,<=,__CC9035));
      SELF.Bus_Change_Chapter_ := IF(__T(__OP2(__PP409880.Original_Chapter_,=,__CN('304'))),__ECAST(KEL.typ.nstr,__CN('15')),__ECAST(KEL.typ.nstr,__PP409880.Original_Chapter_));
      SELF := __PP409880;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE410224,__ND410151__Project(LEFT));
    SELF := __PP409341;
  END;
  EXPORT __ENH_Bankruptcy_3 := PROJECT(__EE410249,__ND410226__Project(LEFT));
END;
