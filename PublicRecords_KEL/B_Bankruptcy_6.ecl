﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Bankruptcy_7,CFG_Compile,E_Bankruptcy,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Bankruptcy_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7;
  SHARED __EE100860 := __ENH_Bankruptcy_7;
  EXPORT __ST93519_Layout := RECORD
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
    KEL.typ.int Child_Sort_List_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST93512_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST93519_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Bankruptcy_7(__in,__cfg).__ST94449_Layout) Best_Child_Record_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST93512_Layout __ND100999__Project(B_Bankruptcy_7(__in,__cfg).__ST94442_Layout __PP99229) := TRANSFORM
    __EE100863 := __PP99229.Records_;
    SELF.Records_ := __BN(PROJECT(__T(__EE100863),__ST93519_Layout),__NL(__EE100863));
    __EE100704 := __PP99229.Records_;
    __ST99635_Layout := RECORD
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
      KEL.typ.nkdate Date_Vendor_First_Reported_;
      KEL.typ.nkdate Date_Vendor_Last_Reported_;
      KEL.typ.nstr Record_Type_;
      KEL.typ.nkdate Last_Status_Update_;
      KEL.typ.int Child_Sort_List_ := 0;
      KEL.typ.epoch Date_First_Seen_ := 0;
      KEL.typ.epoch Date_Last_Seen_ := 0;
      KEL.typ.int __RecordCount := 0;
    END;
    __BS100867 := __T(__EE100704);
    __EE100894 := PROJECT(__CLEANANDDO(__BS100867,TABLE(__BS100867,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.Aggregates.MaxNG(__T(__EE100704).Date_Filed_) M_A_X___Date_Filed__1_,KEL.Aggregates.MaxNG(__T(__EE100704).Last_Status_Update_) M_A_X___Last_Status_Update__1_,KEL.Aggregates.MinNG(__CN(__T(__EE100704).Child_Sort_List_)) M_I_N___Child_Sort_List__1_,Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Record_Type_,Last_Status_Update_,Child_Sort_List_},Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Record_Type_,Last_Status_Update_,Child_Sort_List_,MERGE)),__ST99635_Layout);
    __EE100908 := TOPN(__EE100894(__NN(__EE100894.M_A_X___Date_Filed__1_) AND __NN(__EE100894.M_A_X___Last_Status_Update__1_) AND __NN(__EE100894.M_I_N___Child_Sort_List__1_)),1, -__T(__EE100894.M_A_X___Date_Filed__1_), -__T(__EE100894.M_A_X___Last_Status_Update__1_),__T(__EE100894.M_I_N___Child_Sort_List__1_),__T(Source_Description_),__T(Original_Chapter_),__T(Filing_Type_),__T(Business_Flag_),__T(Corporate_Flag_),__T(Discharged_Date_),__T(Disposition_),__T(Debtor_Type_),__T(Debtor_Sequence_),__T(Disposition_Type_),__T(Disposition_Reason_),__T(Disposition_Type_Description_),__T(Name_Type_),__T(Screen_Description_),__T(Decoded_Description_),__T(Date_Filed_),__T(Date_Vendor_First_Reported_),__T(Date_Vendor_Last_Reported_),__T(Record_Type_),__T(Last_Status_Update_));
    SELF.Best_Child_Record_ := __CN(PROJECT(__EE100908,B_Bankruptcy_7(__in,__cfg).__ST94449_Layout));
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
    SELF.Has_Case_Number_ := __AND(__OP2(__FN1(KEL.Routines.TrimAll,__PP99229.Case_Number_),<>,__CN('')),__NOT(__NT(__PP99229.Case_Number_)));
    SELF := __PP99229;
  END;
  EXPORT __ENH_Bankruptcy_6 := PROJECT(__EE100860,__ND100999__Project(LEFT));
END;
