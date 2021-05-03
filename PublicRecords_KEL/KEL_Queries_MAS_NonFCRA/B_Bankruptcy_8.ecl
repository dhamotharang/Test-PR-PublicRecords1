//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Bankruptcy_9,CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Bankruptcy_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_9(__in,__cfg).__ENH_Bankruptcy_9) __ENH_Bankruptcy_9 := B_Bankruptcy_9(__in,__cfg).__ENH_Bankruptcy_9;
  SHARED __EE4691310 := __ENH_Bankruptcy_9;
  EXPORT __ST210045_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_9(__in,__cfg).__ST211660_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Bankruptcy_9(__in,__cfg).__ST211660_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST210045_Layout __ND4691436__Project(B_Bankruptcy_9(__in,__cfg).__ST211653_Layout __PP4690622) := TRANSFORM
    __EE4691152 := __PP4690622.Records_;
    __ST302663_Layout := RECORD
      KEL.typ.nkdate M_A_X___Date_Filed__1_;
      KEL.typ.nkdate M_A_X___Last_Status_Update__1_;
      KEL.typ.nint M_I_N___Child_Sort_List__1_;
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
    __BS4691314 := __T(__EE4691152);
    __EE4691339 := PROJECT(__CLEANANDDO(__BS4691314,TABLE(__BS4691314,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.Aggregates.MaxNG(__T(__EE4691152).Date_Filed_) M_A_X___Date_Filed__1_,KEL.Aggregates.MaxNG(__T(__EE4691152).Last_Status_Update_) M_A_X___Last_Status_Update__1_,KEL.Aggregates.MinNG(__CN(__T(__EE4691152).Child_Sort_List_)) M_I_N___Child_Sort_List__1_,Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Record_Type_,Last_Status_Update_,Child_Sort_List_},Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Record_Type_,Last_Status_Update_,Child_Sort_List_,MERGE)),__ST302663_Layout);
    __EE4691353 := TOPN(__EE4691339(__NN(__EE4691339.M_A_X___Date_Filed__1_) AND __NN(__EE4691339.M_A_X___Last_Status_Update__1_) AND __NN(__EE4691339.M_I_N___Child_Sort_List__1_)),1, -__T(__EE4691339.M_A_X___Date_Filed__1_), -__T(__EE4691339.M_A_X___Last_Status_Update__1_),__T(__EE4691339.M_I_N___Child_Sort_List__1_),__T(Source_Description_),__T(Original_Chapter_),__T(Filing_Type_),__T(Business_Flag_),__T(Corporate_Flag_),__T(Discharged_Date_),__T(Disposition_),__T(Debtor_Type_),__T(Debtor_Sequence_),__T(Disposition_Type_),__T(Disposition_Reason_),__T(Disposition_Type_Description_),__T(Name_Type_),__T(Screen_Description_),__T(Decoded_Description_),__T(Date_Filed_),__T(Record_Type_),__T(Last_Status_Update_));
    SELF.Best_Child_Record_ := __CN(PROJECT(__EE4691353,B_Bankruptcy_9(__in,__cfg).__ST211660_Layout));
    SELF.Has_Case_Number_ := __AND(__OP2(__FN1(KEL.Routines.TrimAll,__PP4690622.Case_Number_),<>,__CN('')),__NOT(__NT(__PP4690622.Case_Number_)));
    SELF := __PP4690622;
  END;
  EXPORT __ENH_Bankruptcy_8 := PROJECT(__EE4691310,__ND4691436__Project(LEFT));
END;
