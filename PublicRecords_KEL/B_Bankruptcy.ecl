//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Bankruptcy_1,B_Bankruptcy_2,CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Bankruptcy(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1;
  SHARED __EE8459073 := __ENH_Bankruptcy_1;
  EXPORT __ST131799_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST3027843_Layout := RECORD
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
    KEL.typ.nbool Bus_Chapter11_;
    KEL.typ.nbool Bus_Chapter12_;
    KEL.typ.nbool Bus_Chapter13_;
    KEL.typ.nbool Bus_Chapter15_;
    KEL.typ.nbool Bus_Chapter7_;
    KEL.typ.nbool Bus_Chapter9_;
    KEL.typ.nbool Bus_Chapter_Type_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nbool Chapter11_;
    KEL.typ.nbool Chapter12_;
    KEL.typ.nbool Chapter13_;
    KEL.typ.nbool Chapter15_;
    KEL.typ.nbool Chapter7_;
    KEL.typ.nbool Chapter_Type_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nbool Is_Disposed_;
    KEL.typ.str Modified_Disposition_ := '';
    KEL.typ.nint Status_Update_Age_In_Days_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST131792_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST131799_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST3027843_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST131792_Layout __ND8459050__Project(B_Bankruptcy_1(__in,__cfg).__ST176002_Layout __PP8458545) := TRANSFORM
    __EE8459076 := __PP8458545.Records_;
    SELF.Records_ := __BN(PROJECT(__T(__EE8459076),__ST131799_Layout),__NL(__EE8459076));
    __EE8459048 := __PP8458545.Best_Child_Record_;
    __ST3027843_Layout __ND8458965__Project(B_Bankruptcy_2(__in,__cfg).__ST1209505_Layout __PP8458665) := TRANSFORM
      SELF.Bus_Chapter12_ := __OP2(__PP8458665.Bus_Change_Chapter_,=,__CN('12'));
      SELF.Bus_Chapter15_ := __OP2(__PP8458665.Bus_Change_Chapter_,=,__CN('15'));
      SELF.Bus_Chapter9_ := __OP2(__PP8458665.Bus_Change_Chapter_,=,__CN('9'));
      SELF.Chapter11_ := __OP2(__PP8458665.Original_Chapter_,=,__CN('11'));
      SELF.Chapter12_ := __OP2(__PP8458665.Original_Chapter_,=,__CN('12'));
      SELF.Chapter15_ := __OP2(__PP8458665.Original_Chapter_,=,__CN('15'));
      SELF := __PP8458665;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE8459048,__ND8458965__Project(LEFT));
    SELF := __PP8458545;
  END;
  EXPORT __ENH_Bankruptcy := PROJECT(__EE8459073,__ND8459050__Project(LEFT));
END;
