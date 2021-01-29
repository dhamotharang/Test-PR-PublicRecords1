﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Bankruptcy_8(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Bankruptcy(__cfg).__Result) __E_Bankruptcy := E_Bankruptcy(__cfg).__Result;
  SHARED __EE376472 := __E_Bankruptcy;
  EXPORT __ST258834_Layout := RECORD
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
  EXPORT __ST258827_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST258834_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST258827_Layout __ND5229658__Project(E_Bankruptcy(__cfg).Layout __PP376266) := TRANSFORM
    __EE376309 := __PP376266.Records_;
    __ST258834_Layout __ND5229637__Project(E_Bankruptcy(__cfg).Records_Layout __PP376622) := TRANSFORM
      SELF.Child_Sort_List_ := MAP(__T(__NT(__PP376622.Disposition_))=>1,__T(__OP2(__PP376622.Disposition_,=,__CN('Dismissed')))=>2,__T(__OP2(__PP376622.Disposition_,=,__CN('Discharged')))=>3,__T(__OP2(__PP376622.Disposition_,=,__CN('Discharge NA')))=>4,__T(__OP2(__PP376622.Disposition_,=,__CN('Discharge Granted')))=>5,__T(__OP2(__PP376622.Disposition_,=,__CN('Closed')))=>6,7);
      SELF := __PP376622;
    END;
    SELF.Records_ := __PROJECT(__EE376309,__ND5229637__Project(LEFT));
    SELF := __PP376266;
  END;
  EXPORT __ENH_Bankruptcy_8 := PROJECT(__EE376472,__ND5229658__Project(LEFT));
END;
