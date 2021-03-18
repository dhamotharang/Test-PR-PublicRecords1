//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Email,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Email_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Email(__in,__cfg).__Result) __E_Email := E_Email(__in,__cfg).__Result;
  SHARED __EE1026399 := __E_Email;
  EXPORT __ST230657_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Email_Address_;
    KEL.typ.ndataset(E_Email(__in,__cfg).Email_Rec_Key_Layout) Email_Rec_Key_;
    KEL.typ.nint Rules_;
    KEL.typ.nstr User_Name_;
    KEL.typ.nstr Domain_Name_;
    KEL.typ.nstr Domain_Type_;
    KEL.typ.nstr Domain_Root_;
    KEL.typ.nstr Domain_Extension_;
    KEL.typ.nint Is_Top_Level_Domain_State_;
    KEL.typ.nint Is_Top_Level_Domain_Generic_;
    KEL.typ.nint Is_Top_Level_Domain_Country_;
    KEL.typ.ndataset(E_Email(__in,__cfg).Original_Info_Layout) Original_Info_;
    KEL.typ.nstr E360_I_D_;
    KEL.typ.nstr Teramedia_I_D_;
    KEL.typ.ndataset(E_Email(__in,__cfg).Process_Date_Layout) Process_Date_;
    KEL.typ.ndataset(E_Email(__in,__cfg).Active_Code_Layout) Active_Code_;
    KEL.typ.ndataset(E_Email(__in,__cfg).Company_Layout) Company_;
    KEL.typ.ndataset(E_Email(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Emails7y_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST230657_Layout __ND6152756__Project(E_Email(__in,__cfg).Layout __PP1026204) := TRANSFORM
    __CC13243 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('email_build_version'))),__CN(__cfg.CurrentDate));
    __CC34216 := 2556;
    SELF.Emails7y_ := __OP2(FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__CC13243),__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP1026204.Date_Last_Seen_))),<,__CN(__CC34216));
    SELF := __PP1026204;
  END;
  EXPORT __ENH_Email_3 := PROJECT(__EE1026399,__ND6152756__Project(LEFT));
END;
