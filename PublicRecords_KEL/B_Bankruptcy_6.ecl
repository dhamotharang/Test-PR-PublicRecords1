//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Bankruptcy_7,CFG_Compile,E_Bankruptcy,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bankruptcy_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7;
  SHARED __EE33686 := __ENH_Bankruptcy_7;
  EXPORT __ST32353_Layout := RECORD
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
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST32346_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST32353_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST32346_Layout __ND33985__Project(B_Bankruptcy_7(__in,__cfg).__ST32559_Layout __PP33433) := TRANSFORM
    __EE33492 := __PP33433.Records_;
    __ST32353_Layout __ND33960__Project(B_Bankruptcy_7(__in,__cfg).__ST32566_Layout __PP33836) := TRANSFORM
      SELF.Bankruptcy_Date_ := KEL.era.ToDate(__PP33836.Date_First_Seen_);
      SELF.Is_Debtor_ := __OP2(__PP33836.Name_Type_,IN,__CN(['D']));
      SELF := __PP33836;
    END;
    SELF.Records_ := __PROJECT(__EE33492,__ND33960__Project(LEFT));
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile.FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
    SELF.Has_Case_Number_ := __AND(__OP2(__FN1(KEL.Routines.TrimAll,__PP33433.Case_Number_),<>,__CN('')),__NOT(__NT(__PP33433.Case_Number_)));
    SELF := __PP33433;
  END;
  EXPORT __ENH_Bankruptcy_6 := PROJECT(__EE33686,__ND33985__Project(LEFT));
END;
