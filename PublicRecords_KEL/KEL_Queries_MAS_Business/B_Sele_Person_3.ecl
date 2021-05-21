//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_Person_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Person,E_Sele_Person,E_Surname,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Person_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4;
  SHARED __EE2504977 := __ENH_Sele_Person_4;
  SHARED __ST799494_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.bool Is_Executive_Ever_ := FALSE;
    KEL.typ.ndataset(B_Sele_Person_4(__in,__cfg).__ST104699_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.bool Sele_Person_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE2506544 := __EE2504977;
  SHARED __EE2507537 := __EE2506544(__T(__AND(__EE2506544.Two_Years_,__CN(__EE2506544.Is_Executive_Ever_ AND __NN(__EE2506544.Legal_)))));
  SHARED __ST2506994_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE2507551 := PROJECT(TABLE(PROJECT(__EE2507537,__ST2506994_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Legal_,Contact_},Legal_,Contact_,MERGE),__ST2506994_Layout);
  SHARED __EE2504990 := __EE2504977;
  SHARED __EE2504997 := __EE2504990(__NN(__EE2504990.Legal_));
  SHARED __ST2507026_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal__1_;
    KEL.typ.ntyp(E_Person().Typ) Contact__1_;
    KEL.typ.nint Ult_I_D__1_;
    KEL.typ.nint Org_I_D__1_;
    KEL.typ.nint Sele_I_D__1_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info__1_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nint Age_In_Days__1_;
    KEL.typ.nkdate Assoc_Date__1_;
    KEL.typ.bool Is_Executive_Ever__1_ := FALSE;
    KEL.typ.ndataset(B_Sele_Person_4(__in,__cfg).__ST104699_Layout) Relatives__1_;
    KEL.typ.nbool Two_Years__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST2507026_Layout __ND2507001__Project(B_Sele_Person_4(__in,__cfg).__ST209494_Layout __PP2507000) := TRANSFORM
    SELF.Legal__1_ := __PP2507000.Legal_;
    SELF.Contact__1_ := __PP2507000.Contact_;
    SELF.Ult_I_D__1_ := __PP2507000.Ult_I_D_;
    SELF.Org_I_D__1_ := __PP2507000.Org_I_D_;
    SELF.Sele_I_D__1_ := __PP2507000.Sele_I_D_;
    SELF.Contact_Info__1_ := __PP2507000.Contact_Info_;
    SELF.Data_Sources__1_ := __PP2507000.Data_Sources_;
    SELF.Age_In_Days__1_ := __PP2507000.Age_In_Days_;
    SELF.Assoc_Date__1_ := __PP2507000.Assoc_Date_;
    SELF.Is_Executive_Ever__1_ := __PP2507000.Is_Executive_Ever_;
    SELF.Relatives__1_ := __PP2507000.Relatives_;
    SELF.Two_Years__1_ := __PP2507000.Two_Years_;
    SELF := __PP2507000;
  END;
  SHARED __EE2507067 := PROJECT(__EE2504997,__ND2507001__Project(LEFT));
  SHARED __ST2507120_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal__1_;
    KEL.typ.ntyp(E_Person().Typ) Contact__1_;
    KEL.typ.nint Ult_I_D__1_;
    KEL.typ.nint Org_I_D__1_;
    KEL.typ.nint Sele_I_D__1_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info__1_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nint Age_In_Days__1_;
    KEL.typ.nkdate Assoc_Date__1_;
    KEL.typ.bool Is_Executive_Ever__1_ := FALSE;
    KEL.typ.ndataset(B_Sele_Person_4(__in,__cfg).__ST104699_Layout) Relatives__1_;
    KEL.typ.nbool Two_Years__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2507557(__ST2506994_Layout __EE2507551, __ST2507026_Layout __EE2507067) := __EEQP(__EE2507067.Legal__1_,__EE2507551.Legal_);
  __ST2507120_Layout __JT2507557(__ST2506994_Layout __l, __ST2507026_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2507597 := JOIN(__EE2507551,__EE2507067,__JC2507557(LEFT,RIGHT),__JT2507557(LEFT,RIGHT),INNER,HASH);
  SHARED __EE2507608 := __EE2507597.Relatives__1_;
  __JC2507617(B_Sele_Person_4(__in,__cfg).__ST104699_Layout __EE2507608) := __T(__OP2(__EE2507597.Contact_,=,__EE2507608.Relative_));
  SHARED __EE2507618 := __EE2507597(EXISTS(__CHILDJOINFILTER(__EE2507608,__JC2507617)));
  __JC2507708(B_Sele_Person_4(__in,__cfg).__ST209494_Layout __EE2504977, __ST2507120_Layout __EE2507618) := __EEQP(__EE2504977.Ult_I_D_,__EE2507618.Ult_I_D__1_) AND __EEQP(__EE2504977.Two_Years_,__EE2507618.Two_Years__1_) AND __EEQP(__EE2504977.Sele_I_D_,__EE2507618.Sele_I_D__1_) AND __EEQP(__EE2504977.Relatives_,__EE2507618.Relatives__1_) AND __EEQP(__EE2504977.Org_I_D_,__EE2507618.Org_I_D__1_) AND __EEQP(__EE2504977.Legal_,__EE2507618.Legal__1_) AND __EE2504977.Is_Executive_Ever_ = __EE2507618.Is_Executive_Ever__1_ AND __EEQP(__EE2504977.Data_Sources_,__EE2507618.Data_Sources__1_) AND __EEQP(__EE2504977.Contact_Info_,__EE2507618.Contact_Info__1_) AND __EEQP(__EE2504977.Contact_,__EE2507618.Contact__1_) AND __EEQP(__EE2504977.Assoc_Date_,__EE2507618.Assoc_Date__1_) AND __EEQP(__EE2504977.Age_In_Days_,__EE2507618.Age_In_Days__1_) AND __T(__AND(__EEQ(__EE2504977.Ult_I_D_,__EE2507618.Ult_I_D__1_),__AND(__EEQ(__EE2504977.Two_Years_,__EE2507618.Two_Years__1_),__AND(__EEQ(__EE2504977.Sele_I_D_,__EE2507618.Sele_I_D__1_),__AND(__EEQ(__EE2504977.Relatives_,__EE2507618.Relatives__1_),__AND(__EEQ(__EE2504977.Org_I_D_,__EE2507618.Org_I_D__1_),__AND(__EEQ(__EE2504977.Legal_,__EE2507618.Legal__1_),__AND(__CN(__EE2504977.Is_Executive_Ever_ = __EE2507618.Is_Executive_Ever__1_),__AND(__EEQ(__EE2504977.Data_Sources_,__EE2507618.Data_Sources__1_),__AND(__EEQ(__EE2504977.Contact_Info_,__EE2507618.Contact_Info__1_),__AND(__EEQ(__EE2504977.Contact_,__EE2507618.Contact__1_),__AND(__EEQ(__EE2504977.Assoc_Date_,__EE2507618.Assoc_Date__1_),__EEQ(__EE2504977.Age_In_Days_,__EE2507618.Age_In_Days__1_)))))))))))));
  __JF2507708(__ST2507120_Layout __EE2507618) := __NN(__EE2507618.Ult_I_D__1_) OR __NN(__EE2507618.Two_Years__1_) OR __NN(__EE2507618.Sele_I_D__1_) OR __NN(__EE2507618.Relatives__1_) OR __NN(__EE2507618.Org_I_D__1_) OR __NN(__EE2507618.Legal__1_) OR __NN(__EE2507618.Data_Sources__1_) OR __NN(__EE2507618.Contact_Info__1_) OR __NN(__EE2507618.Contact__1_) OR __NN(__EE2507618.Assoc_Date__1_) OR __NN(__EE2507618.Age_In_Days__1_);
  SHARED __EE2507747 := JOIN(__EE2504977,__EE2507618,__JC2507708(LEFT,RIGHT),TRANSFORM(__ST799494_Layout,SELF:=LEFT,SELF.Sele_Person_:=__JF2507708(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST797953_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.bool Relative_Is_Business_Contact_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST201686_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.nkdate Assoc_Fs_Date_;
    KEL.typ.bool Is_Executive_Ever_ := FALSE;
    KEL.typ.ndataset(__ST797953_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST201686_Layout __ND2507752__Project(__ST799494_Layout __PP2507748) := TRANSFORM
    __EE2507807 := __PP2507748.Contact_Info_;
    __CC13546 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
    __EE2507823 := __PP2507748.Contact_Info_;
    SELF.Assoc_Fs_Date_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE2507807,KEL.era.ToDate(__T(__EE2507807).Date_First_Seen_)),>,__CC13546)),__ECAST(KEL.typ.nkdate,__CC13546),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE2507823,KEL.era.ToDate(__T(__EE2507823).Date_First_Seen_))));
    __EE2507839 := __PP2507748.Relatives_;
    __ST797953_Layout __ND2507847__Project(B_Sele_Person_4(__in,__cfg).__ST104699_Layout __PP2507843) := TRANSFORM
      SELF.Relative_Is_Business_Contact_ := __PP2507748.Sele_Person_;
      SELF := __PP2507843;
    END;
    SELF.Relatives_ := __PROJECT(__EE2507839,__ND2507847__Project(LEFT));
    SELF := __PP2507748;
  END;
  EXPORT __ENH_Sele_Person_3 := PROJECT(__EE2507747,__ND2507752__Project(LEFT));
END;
