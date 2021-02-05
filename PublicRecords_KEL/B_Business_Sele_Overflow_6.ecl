//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Business_Sele_Overflow FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_Overflow_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business_Sele_Overflow(__in,__cfg).__Result) __E_Business_Sele_Overflow := E_Business_Sele_Overflow(__in,__cfg).__Result;
  SHARED __EE462616 := __E_Business_Sele_Overflow;
  EXPORT __ST252362_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Domestic_Filing_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Foreign_Filing_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST252362_Layout __ND5313243__Project(E_Business_Sele_Overflow(__in,__cfg).Layout __PP462148) := TRANSFORM
    __EE462459 := __PP462148.S_O_S_Incorporation_Details_;
    __BS463993 := __T(__EE462459);
    __EE5313241 := __BS463993(__T(__AND(__AND(__NOT(__NT(__T(__EE462459).S_O_S_Incorporation_State_)),__OP2(__T(__EE462459).S_O_S_Incorporation_State_,<>,__CN(''))),__OP2(__T(__EE462459).S_O_S_Foreign_Domestic_Indicator_,=,__CN('D')))));
    SELF.S_O_S_Domestic_Filing_ := __CN(__EE5313241);
    __EE462490 := __PP462148.S_O_S_Incorporation_Details_;
    __BS464195 := __T(__EE462490);
    __EE5313251 := __BS464195(__T(__AND(__AND(__NOT(__NT(__T(__EE462490).S_O_S_Foreign_State_Code_)),__OP2(__T(__EE462490).S_O_S_Foreign_State_Code_,<>,__CN(''))),__OP2(__T(__EE462490).S_O_S_Foreign_Domestic_Indicator_,=,__CN('F')))));
    SELF.S_O_S_Foreign_Filing_ := __CN(__EE5313251);
    SELF := __PP462148;
  END;
  EXPORT __ENH_Business_Sele_Overflow_6 := PROJECT(__EE462616,__ND5313243__Project(LEFT));
END;
