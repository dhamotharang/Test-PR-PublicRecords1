//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Sele_Overflow_2,B_Business_Sele_Overflow_3,CFG_Compile,E_Business_Sele_Overflow FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_Overflow_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_Overflow_2(__in,__cfg).__ENH_Business_Sele_Overflow_2) __ENH_Business_Sele_Overflow_2 := B_Business_Sele_Overflow_2(__in,__cfg).__ENH_Business_Sele_Overflow_2;
  SHARED __EE1364562 := __ENH_Business_Sele_Overflow_2;
  EXPORT __ST136753_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(B_Business_Sele_Overflow_2(__in,__cfg).__ST140391_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nstr Most_Recent_Status_Filing_Description_;
    KEL.typ.nint S_O_S_Incorporation_Old_Date_;
    KEL.typ.nint S_O_S_Unique_State_Count_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST136753_Layout __ND1364576__Project(B_Business_Sele_Overflow_2(__in,__cfg).__ST140364_Layout __PP1363969) := TRANSFORM
    __EE1364428 := __PP1363969.S_O_S_Statuses_;
    __EE1364443 := __PP1363969.S_O_S_Statuses_;
    __ST76865_Layout := RECORD
      KEL.typ.nint Days_Since_Status_;
      KEL.typ.epoch Archive___Date_ := 0;
      KEL.typ.epoch Date_First_Seen_ := 0;
      KEL.typ.epoch Date_Last_Seen_ := 0;
      KEL.typ.epoch Hybrid_Archive_Date_ := 0;
      KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    END;
    __EE1364453 := PROJECT(TABLE(PROJECT(__T(__EE1364443),__ST76865_Layout),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Days_Since_Status_},Days_Since_Status_,MERGE),__ST76865_Layout);
    __BS1364429 := __T(__EE1364428);
    __EE1364568 := __BS1364429(__T(__OP2(__T(__EE1364428).Days_Since_Status_,=,KEL.Aggregates.MinN(__EE1364453,__EE1364453.Days_Since_Status_))));
    SELF.Most_Recent_Status_Filing_Description_ := (__EE1364568)[1].S_O_S_Status_Description_;
    SELF.S_O_S_Unique_State_Count_ := __OP2(__OP2(KEL.Aggregates.CountN(__PP1363969.S_O_S_Foreign_States_),+,KEL.Aggregates.CountN(__PP1363969.S_O_S_Domestic_States_)),-,__CN(__PP1363969.S_O_S_Filing_States_Count_Dups_));
    SELF := __PP1363969;
  END;
  EXPORT __ENH_Business_Sele_Overflow_1 := PROJECT(__EE1364562,__ND1364576__Project(LEFT));
END;
