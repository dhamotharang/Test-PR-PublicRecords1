//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Bankruptcy_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy(__in,__cfg).__Result;
  SHARED __EE97360 := __E_Bankruptcy;
  EXPORT __ST94449_Layout := RECORD
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
  EXPORT __ST94442_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST94449_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST94442_Layout __ND97636__Project(E_Bankruptcy(__in,__cfg).Layout __PP97117) := TRANSFORM
    __EE97172 := __PP97117.Records_;
    __ST94449_Layout __ND97613__Project(E_Bankruptcy(__in,__cfg).Records_Layout __PP97364) := TRANSFORM
      SELF.Child_Sort_List_ := MAP(__T(__NT(__PP97364.Disposition_))=>1,__T(__OP2(__PP97364.Disposition_,=,__CN('Dismissed')))=>2,__T(__OP2(__PP97364.Disposition_,=,__CN('Discharged')))=>3,__T(__OP2(__PP97364.Disposition_,=,__CN('Discharge NA')))=>4,__T(__OP2(__PP97364.Disposition_,=,__CN('Discharge Granted')))=>5,__T(__OP2(__PP97364.Disposition_,=,__CN('Closed')))=>6,7);
      SELF := __PP97364;
    END;
    SELF.Records_ := __PROJECT(__EE97172,__ND97613__Project(LEFT));
    SELF := __PP97117;
  END;
  EXPORT __ENH_Bankruptcy_7 := PROJECT(__EE97360,__ND97636__Project(LEFT));
END;
