//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Criminal_Offense_4,CFG_Compile,E_Criminal_Offense FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Criminal_Offense_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4;
  SHARED __EE6300040 := __ENH_Criminal_Offense_4;
  EXPORT __ST240246_Layout := RECORD
    KEL.typ.nstr Case_Number_;
    KEL.typ.nkdate Case_Date_;
    KEL.typ.nstr Case_Type_Description_;
    KEL.typ.nkdate Offense_Date_;
    KEL.typ.nstr Offense_Score_;
    KEL.typ.nstr Offender_Level_;
    KEL.typ.nstr Data_Type_;
    KEL.typ.nstr Traffic_Flag_;
    KEL.typ.nstr Conviction_Flag_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Criminal_Date_;
    KEL.typ.nbool Dismissed_Charges_;
    KEL.typ.nbool Is_Criminal_Count_;
    KEL.typ.nbool Is_Felony_F_C_R_A_;
    KEL.typ.nbool Is_Felony_Non_F_C_R_A_;
    KEL.typ.nbool Is_Non_Felony_Records_;
    KEL.typ.nkdate My_Crim_Date_;
    KEL.typ.nstr Valid_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST240199_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.nstr Offense_Type_;
    KEL.typ.nkdate Date_Of_Offence_;
    KEL.typ.nint Offense_Category_;
    KEL.typ.nstr County_Of_Source_;
    KEL.typ.nstr State_Of_Source_;
    KEL.typ.nstr Department_Of_Law_Enforcement_Number_;
    KEL.typ.nstr Federal_Bureau_Of_Investigations_Number_;
    KEL.typ.nstr Inmate_Number_;
    KEL.typ.nstr State_Identification_Number_Assigned_;
    KEL.typ.nkdate Date_Of_Arrest_;
    KEL.typ.nstr Agency_Name_;
    KEL.typ.nstr Agency_Case_Number_;
    KEL.typ.nstr Traffic_Ticket_Number_;
    KEL.typ.nstr Arrest_Offense_Code_;
    KEL.typ.nstr Arrest_Initial_Charge_Description_;
    KEL.typ.nstr Arrest_Amended_Charge_Description_;
    KEL.typ.nstr Arrest_Offense_Level_;
    KEL.typ.nkdate Date_Of_Disposition_For_Initial_Charge_;
    KEL.typ.nstr Arrest_Offence_Type_Description_;
    KEL.typ.nstr Initial_Charge_Disposition_Description_;
    KEL.typ.nstr Additional_Disposition_Description_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Court_Description_;
    KEL.typ.nstr Court_Final_Plea_;
    KEL.typ.nstr Court_Offense_Code_;
    KEL.typ.nstr Court_Offense_Description_;
    KEL.typ.nstr Court_Offense_Additional_Description_;
    KEL.typ.nstr Court_Statute_;
    KEL.typ.nkdate Court_Disposition_Date_;
    KEL.typ.nint Court_Fine_;
    KEL.typ.nstr Suspended_Court_Fine_;
    KEL.typ.nint Court_Cost_;
    KEL.typ.nstr Court_Disposition_Code_;
    KEL.typ.nstr Court_Disposition_Description_;
    KEL.typ.nstr Court_Additional_Disposition_Description_;
    KEL.typ.nkdate Date_Of_Appeal_;
    KEL.typ.nkdate Dateof_Verdict_;
    KEL.typ.nstr Offense_Town_;
    KEL.typ.nstr Persistent_Offense_Key_;
    KEL.typ.nkdate Court_Date_;
    KEL.typ.nstr Court_County_;
    KEL.typ.nstr Arrest_Offense_Level_Mapped_;
    KEL.typ.nstr Court_Offense_Level_Mapped_;
    KEL.typ.ndataset(__ST240246_Layout) Offense_Charges_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Criminal_Data_Sources_Layout) Criminal_Data_Sources_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Court_Offense_Level_Layout) Court_Offense_Level_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Fcra_Data_Layout) Fcra_Data_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Conviction_Overrides_Layout) Conviction_Overrides_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST240199_Layout __ND6300484__Project(B_Criminal_Offense_4(__in,__cfg).__ST253423_Layout __PP6300041) := TRANSFORM
    __EE6300201 := __PP6300041.Offense_Charges_;
    __ST240246_Layout __ND6300464__Project(B_Criminal_Offense_4(__in,__cfg).__ST253470_Layout __PP6300202) := TRANSFORM
      SELF.Is_Felony_F_C_R_A_ := __AND(__AND(__AND(__AND(__NOT(__PP6300202.Dismissed_Charges_),IF(__T(__NT(__PP6300202.Offense_Score_)),__ECAST(KEL.typ.nbool,__CN(FALSE)),__ECAST(KEL.typ.nbool,__OP2(__PP6300202.Offense_Score_,=,__CN('F'))))),__NT(__PP6300202.Offender_Level_)),__OP2(__PP6300202.Conviction_Flag_,IN,__CN(['Y','D']))),__OP2(__PP6300202.Traffic_Flag_,=,__CN('N')));
      SELF := __PP6300202;
    END;
    SELF.Offense_Charges_ := __PROJECT(__EE6300201,__ND6300464__Project(LEFT));
    SELF := __PP6300041;
  END;
  EXPORT __ENH_Criminal_Offense_3 := PROJECT(__EE6300040,__ND6300484__Project(LEFT));
END;
