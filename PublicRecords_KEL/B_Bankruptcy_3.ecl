//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Bankruptcy_4,CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bankruptcy_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4;
  SHARED __EE20029 := __ENH_Bankruptcy_4;
  EXPORT __ST16639_Layout := RECORD
    KEL.typ.nstr Bankruptcy_Source_;
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
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Seen_Discharged_Date_;
    KEL.typ.nkdate Last_Seen_Record_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST16632_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST16639_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Court_Information_Layout) Court_Information_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Monetary_Value_Layout) Monetary_Value_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Status_Layout) Status_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Comments_Layout) Comments_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.kdate Boca_Shell_History_Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST16632_Layout __ND20674__Project(B_Bankruptcy_4(__in,__cfg).__ST16775_Layout __PP19632) := TRANSFORM
    __EE19753 := __PP19632.Records_;
    __ST16639_Layout __ND20264__Project(B_Bankruptcy_4(__in,__cfg).__ST16782_Layout __PP20263) := TRANSFORM
      SELF.Last_Seen_Record_Date_ := MAP(__T(__AND(__NT(__PP20263.Last_Seen_Discharged_Date_),__NOT(__NT(__PP20263.Date_Filed_))))=>__ECAST(KEL.typ.nkdate,__PP20263.Date_Filed_),__T(__AND(__NOT(__NT(__PP20263.Last_Seen_Discharged_Date_)),__NT(__PP20263.Date_Filed_)))=>__ECAST(KEL.typ.nkdate,__PP20263.Last_Seen_Discharged_Date_),__ECAST(KEL.typ.nkdate,KEL.Routines.MaxN(__PP20263.Last_Seen_Discharged_Date_,__PP20263.Date_Filed_)));
      SELF := __PP20263;
    END;
    SELF.Records_ := __PROJECT(__EE19753,__ND20264__Project(LEFT));
    SELF := __PP19632;
  END;
  EXPORT __ENH_Bankruptcy_3 := PROJECT(__EE20029,__ND20674__Project(LEFT));
END;
