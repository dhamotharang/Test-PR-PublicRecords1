﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Bankruptcy_3,CFG_Compile,E_Bankruptcy,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bankruptcy_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3;
  SHARED __EE21326 := __ENH_Bankruptcy_3;
  EXPORT __ST16053_Layout := RECORD
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
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.nkdate Last_Seen_Record_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST16046_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST16053_Layout) Records_;
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
  SHARED __ST16046_Layout __ND22065__Project(B_Bankruptcy_3(__in,__cfg).__ST16632_Layout __PP20944) := TRANSFORM
    __EE21065 := __PP20944.Records_;
    __ST16053_Layout __ND22037__Project(B_Bankruptcy_3(__in,__cfg).__ST16639_Layout __PP21568) := TRANSFORM
      SELF.Filing_Age_In_Days_ := FN_Compile.FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP21568.Last_Seen_Record_Date_),__ECAST(KEL.typ.nkdate,__CN(__PP20944.Boca_Shell_History_Date_)));
      SELF.Is_Debtor_ := __OP2(__PP21568.Name_Type_,IN,__CN(['D']));
      SELF := __PP21568;
    END;
    SELF.Records_ := __PROJECT(__EE21065,__ND22037__Project(LEFT));
    SELF := __PP20944;
  END;
  EXPORT __ENH_Bankruptcy_2 := PROJECT(__EE21326,__ND22065__Project(LEFT));
END;
