//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Tradeline_10,CFG_Compile,E_Tradeline,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Tradeline_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_10().__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10;
  SHARED __EE252925 := __ENH_Tradeline_10;
  EXPORT __ST168967_Layout := RECORD
    KEL.typ.nkdate A_R_Date_;
    KEL.typ.nint Total_A_R_;
    KEL.typ.nint Current_A_R_;
    KEL.typ.nint Aging1_To30_;
    KEL.typ.nint Aging31_To60_;
    KEL.typ.nint Aging61_To90_;
    KEL.typ.nint Aging91_Plus_;
    KEL.typ.nint Credit_Limit_;
    KEL.typ.nint Segment_I_D_;
    KEL.typ.nkdate File_Date_;
    KEL.typ.nstr Status_;
    KEL.typ.nkdate First_Sale_Date_;
    KEL.typ.nkdate Last_Sale_Date_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST168960_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST168967_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST168960_Layout __ND253092__Project(B_Tradeline_10(__in,__cfg).__ST169749_Layout __PP252737) := TRANSFORM
    __EE252786 := __PP252737.Records_;
    __ST168967_Layout __ND252933__Project(B_Tradeline_10(__in,__cfg).__ST169756_Layout __PP252929) := TRANSFORM
      __CC9544 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('cortera_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Record_Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP252929.Record_Date_),__ECAST(KEL.typ.nkdate,__CC9544));
      SELF := __PP252929;
    END;
    SELF.Records_ := __PROJECT(__EE252786,__ND252933__Project(LEFT));
    SELF.Current_Date_First_Of_Month_ := __FN3(KEL.Routines.DateFromParts,__PP252737.Current_Year_,__PP252737.Current_Month_,__CN(1));
    SELF := __PP252737;
  END;
  EXPORT __ENH_Tradeline_9 := PROJECT(__EE252925,__ND253092__Project(LEFT));
END;
