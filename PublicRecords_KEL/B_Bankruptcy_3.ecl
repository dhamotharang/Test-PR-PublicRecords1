﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Bankruptcy_4,CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Bankruptcy_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4;
  SHARED __EE226011 := __ENH_Bankruptcy_4;
  EXPORT __ST84152_Layout := RECORD
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
  EXPORT __ST224774_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST84145_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST84152_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST224774_Layout) Best_Child_Record_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST84145_Layout __ND225979__Project(B_Bankruptcy_4(__in,__cfg).__ST89452_Layout __PP224819) := TRANSFORM
    __EE226014 := __PP224819.Records_;
    SELF.Records_ := __BN(PROJECT(__T(__EE226014),__ST84152_Layout),__NL(__EE226014));
    __EE225977 := __PP224819.Best_Child_Record_;
    __ST224774_Layout __ND225887__Project(B_Bankruptcy_4(__in,__cfg).__ST136901_Layout __PP225817) := TRANSFORM
      __CC15157 := 3652;
      SELF.Banko10_Year_Update_Filter_ := __AND(__AND(__AND(__PP225817.Is_Bankruptcy_,__OP2(__PP225817.Status_Update_Age_In_Days_,<=,__CN(__CC15157))),__NOT(__NT(__PP225817.Last_Status_Update_))),__OP2(__PP225817.Last_Status_Update_,<=,__PP224819.Current_Date_));
      __CC15143 := 365;
      SELF.Banko1_Year_ := __AND(__AND(__PP225817.Is_Bankruptcy_,__OP2(__PP225817.Filing_Age_In_Days_,<=,__CN(__CC15143))),__NOT(__NT(__PP225817.Filing_Age_In_Days_)));
      SELF.Banko1_Year_Update_Filter_ := __AND(__AND(__AND(__PP225817.Is_Bankruptcy_,__OP2(__PP225817.Status_Update_Age_In_Days_,<=,__CN(__CC15143))),__NOT(__NT(__PP225817.Last_Status_Update_))),__OP2(__PP225817.Last_Status_Update_,<=,__PP224819.Current_Date_));
      __CC15155 := 2556;
      SELF.Banko7_Year_ := __AND(__AND(__PP225817.Is_Bankruptcy_,__OP2(__PP225817.Filing_Age_In_Days_,<=,__CN(__CC15155))),__NOT(__NT(__PP225817.Filing_Age_In_Days_)));
      SELF.Banko7_Year_Update_Filter_ := __AND(__AND(__AND(__PP225817.Is_Bankruptcy_,__OP2(__PP225817.Status_Update_Age_In_Days_,<=,__CN(__CC15155))),__NOT(__NT(__PP225817.Last_Status_Update_))),__OP2(__PP225817.Last_Status_Update_,<=,__PP224819.Current_Date_));
      SELF.Bus_Change_Chapter_ := IF(__T(__OP2(__PP225817.Original_Chapter_,=,__CN('304'))),__ECAST(KEL.typ.nstr,__CN('15')),__ECAST(KEL.typ.nstr,__PP225817.Original_Chapter_));
      SELF := __PP225817;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE225977,__ND225887__Project(LEFT));
    SELF := __PP224819;
  END;
  EXPORT __ENH_Bankruptcy_3 := PROJECT(__EE226011,__ND225979__Project(LEFT));
END;
