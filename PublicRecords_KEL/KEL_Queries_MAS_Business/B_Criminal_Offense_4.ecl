//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Criminal_Offense_5,CFG_Compile,E_Criminal_Offense,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Criminal_Offense_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Criminal_Offense_5(__in,__cfg).__ENH_Criminal_Offense_5) __ENH_Criminal_Offense_5 := B_Criminal_Offense_5(__in,__cfg).__ENH_Criminal_Offense_5;
  SHARED __EE2113695 := __ENH_Criminal_Offense_5;
  EXPORT __ST199333_Layout := RECORD
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
    KEL.typ.nbool Is_Felony_Non_F_C_R_A_;
    KEL.typ.nbool Is_Non_Felony_Records_Non_F_C_R_A_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST199286_Layout := RECORD
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
    KEL.typ.ndataset(__ST199333_Layout) Offense_Charges_;
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
  SHARED __ST199286_Layout __ND2114113__Project(B_Criminal_Offense_5(__in,__cfg).__ST203951_Layout __PP2113696) := TRANSFORM
    __EE2113856 := __PP2113696.Offense_Charges_;
    __ST199333_Layout __ND2114093__Project(B_Criminal_Offense_5(__in,__cfg).__ST203998_Layout __PP2113857) := TRANSFORM
      __CC13315 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('doc_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP2113857.Criminal_Date_),__ECAST(KEL.typ.nkdate,__CC13315));
      SELF.Is_Felony_Non_F_C_R_A_ := __AND(__AND(__NOT(__PP2113857.Dismissed_Charges_),IF(__T(__NT(__PP2113857.Offense_Score_)),__ECAST(KEL.typ.nbool,__CN(FALSE)),__ECAST(KEL.typ.nbool,__OP2(__PP2113857.Offense_Score_,=,__CN('F'))))),__OP2(__PP2113857.Offender_Level_,=,__CN('4')));
      SELF.Is_Non_Felony_Records_Non_F_C_R_A_ := __AND(__NOT(__PP2113857.Dismissed_Charges_),__NOT(__OP2(__PP2113857.Offense_Score_,=,__CN('F'))));
      SELF := __PP2113857;
    END;
    SELF.Offense_Charges_ := __PROJECT(__EE2113856,__ND2114093__Project(LEFT));
    SELF := __PP2113696;
  END;
  EXPORT __ENH_Criminal_Offense_4 := PROJECT(__EE2113695,__ND2114113__Project(LEFT));
END;
