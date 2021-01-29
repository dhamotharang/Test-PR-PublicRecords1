﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Person_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Person,E_Sele_Person,E_Surname,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Person_3(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_4(__cfg).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4(__cfg).__ENH_Sele_Person_4;
  SHARED __EE6530597 := __ENH_Sele_Person_4;
  SHARED __ST1226197_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.bool Is_Executive_Ever_ := FALSE;
    KEL.typ.ndataset(B_Sele_Person_4(__cfg).__ST116490_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.bool Sele_Person_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE6532164 := __EE6530597;
  SHARED __EE6533157 := __EE6532164(__T(__AND(__EE6532164.Two_Years_,__CN(__EE6532164.Is_Executive_Ever_ AND __NN(__EE6532164.Legal_)))));
  SHARED __ST6532614_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE6533171 := PROJECT(TABLE(PROJECT(__EE6533157,__ST6532614_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Legal_,Contact_},Legal_,Contact_,MERGE),__ST6532614_Layout);
  SHARED __EE6530610 := __EE6530597;
  SHARED __EE6530617 := __EE6530610(__NN(__EE6530610.Legal_));
  SHARED __ST6532646_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal__1_;
    KEL.typ.ntyp(E_Person().Typ) Contact__1_;
    KEL.typ.nint Ult_I_D__1_;
    KEL.typ.nint Org_I_D__1_;
    KEL.typ.nint Sele_I_D__1_;
    KEL.typ.ndataset(E_Sele_Person(__cfg).Contact_Info_Layout) Contact_Info__1_;
    KEL.typ.ndataset(E_Sele_Person(__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nint Age_In_Days__1_;
    KEL.typ.nkdate Assoc_Date__1_;
    KEL.typ.bool Is_Executive_Ever__1_ := FALSE;
    KEL.typ.ndataset(B_Sele_Person_4(__cfg).__ST116490_Layout) Relatives__1_;
    KEL.typ.nbool Two_Years__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST6532646_Layout __ND6532621__Project(B_Sele_Person_4(__cfg).__ST243707_Layout __PP6532620) := TRANSFORM
    SELF.Legal__1_ := __PP6532620.Legal_;
    SELF.Contact__1_ := __PP6532620.Contact_;
    SELF.Ult_I_D__1_ := __PP6532620.Ult_I_D_;
    SELF.Org_I_D__1_ := __PP6532620.Org_I_D_;
    SELF.Sele_I_D__1_ := __PP6532620.Sele_I_D_;
    SELF.Contact_Info__1_ := __PP6532620.Contact_Info_;
    SELF.Data_Sources__1_ := __PP6532620.Data_Sources_;
    SELF.Age_In_Days__1_ := __PP6532620.Age_In_Days_;
    SELF.Assoc_Date__1_ := __PP6532620.Assoc_Date_;
    SELF.Is_Executive_Ever__1_ := __PP6532620.Is_Executive_Ever_;
    SELF.Relatives__1_ := __PP6532620.Relatives_;
    SELF.Two_Years__1_ := __PP6532620.Two_Years_;
    SELF := __PP6532620;
  END;
  SHARED __EE6532687 := PROJECT(__EE6530617,__ND6532621__Project(LEFT));
  SHARED __ST6532740_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal__1_;
    KEL.typ.ntyp(E_Person().Typ) Contact__1_;
    KEL.typ.nint Ult_I_D__1_;
    KEL.typ.nint Org_I_D__1_;
    KEL.typ.nint Sele_I_D__1_;
    KEL.typ.ndataset(E_Sele_Person(__cfg).Contact_Info_Layout) Contact_Info__1_;
    KEL.typ.ndataset(E_Sele_Person(__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nint Age_In_Days__1_;
    KEL.typ.nkdate Assoc_Date__1_;
    KEL.typ.bool Is_Executive_Ever__1_ := FALSE;
    KEL.typ.ndataset(B_Sele_Person_4(__cfg).__ST116490_Layout) Relatives__1_;
    KEL.typ.nbool Two_Years__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6533177(__ST6532614_Layout __EE6533171, __ST6532646_Layout __EE6532687) := __EEQP(__EE6532687.Legal__1_,__EE6533171.Legal_);
  __ST6532740_Layout __JT6533177(__ST6532614_Layout __l, __ST6532646_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6533217 := JOIN(__EE6533171,__EE6532687,__JC6533177(LEFT,RIGHT),__JT6533177(LEFT,RIGHT),INNER,HASH);
  SHARED __EE6533228 := __EE6533217.Relatives__1_;
  __JC6533237(B_Sele_Person_4(__cfg).__ST116490_Layout __EE6533228) := __T(__OP2(__EE6533217.Contact_,=,__EE6533228.Relative_));
  SHARED __EE6533238 := __EE6533217(EXISTS(__CHILDJOINFILTER(__EE6533228,__JC6533237)));
  __JC6533328(B_Sele_Person_4(__cfg).__ST243707_Layout __EE6530597, __ST6532740_Layout __EE6533238) := __EEQP(__EE6530597.Ult_I_D_,__EE6533238.Ult_I_D__1_) AND __EEQP(__EE6530597.Two_Years_,__EE6533238.Two_Years__1_) AND __EEQP(__EE6530597.Sele_I_D_,__EE6533238.Sele_I_D__1_) AND __EEQP(__EE6530597.Relatives_,__EE6533238.Relatives__1_) AND __EEQP(__EE6530597.Org_I_D_,__EE6533238.Org_I_D__1_) AND __EEQP(__EE6530597.Legal_,__EE6533238.Legal__1_) AND __EE6530597.Is_Executive_Ever_ = __EE6533238.Is_Executive_Ever__1_ AND __EEQP(__EE6530597.Data_Sources_,__EE6533238.Data_Sources__1_) AND __EEQP(__EE6530597.Contact_Info_,__EE6533238.Contact_Info__1_) AND __EEQP(__EE6530597.Contact_,__EE6533238.Contact__1_) AND __EEQP(__EE6530597.Assoc_Date_,__EE6533238.Assoc_Date__1_) AND __EEQP(__EE6530597.Age_In_Days_,__EE6533238.Age_In_Days__1_) AND __T(__AND(__EEQ(__EE6530597.Ult_I_D_,__EE6533238.Ult_I_D__1_),__AND(__EEQ(__EE6530597.Two_Years_,__EE6533238.Two_Years__1_),__AND(__EEQ(__EE6530597.Sele_I_D_,__EE6533238.Sele_I_D__1_),__AND(__EEQ(__EE6530597.Relatives_,__EE6533238.Relatives__1_),__AND(__EEQ(__EE6530597.Org_I_D_,__EE6533238.Org_I_D__1_),__AND(__EEQ(__EE6530597.Legal_,__EE6533238.Legal__1_),__AND(__CN(__EE6530597.Is_Executive_Ever_ = __EE6533238.Is_Executive_Ever__1_),__AND(__EEQ(__EE6530597.Data_Sources_,__EE6533238.Data_Sources__1_),__AND(__EEQ(__EE6530597.Contact_Info_,__EE6533238.Contact_Info__1_),__AND(__EEQ(__EE6530597.Contact_,__EE6533238.Contact__1_),__AND(__EEQ(__EE6530597.Assoc_Date_,__EE6533238.Assoc_Date__1_),__EEQ(__EE6530597.Age_In_Days_,__EE6533238.Age_In_Days__1_)))))))))))));
  __JF6533328(__ST6532740_Layout __EE6533238) := __NN(__EE6533238.Ult_I_D__1_) OR __NN(__EE6533238.Two_Years__1_) OR __NN(__EE6533238.Sele_I_D__1_) OR __NN(__EE6533238.Relatives__1_) OR __NN(__EE6533238.Org_I_D__1_) OR __NN(__EE6533238.Legal__1_) OR __NN(__EE6533238.Data_Sources__1_) OR __NN(__EE6533238.Contact_Info__1_) OR __NN(__EE6533238.Contact__1_) OR __NN(__EE6533238.Assoc_Date__1_) OR __NN(__EE6533238.Age_In_Days__1_);
  SHARED __EE6533367 := JOIN(__EE6530597,__EE6533238,__JC6533328(LEFT,RIGHT),TRANSFORM(__ST1226197_Layout,SELF:=LEFT,SELF.Sele_Person_:=__JF6533328(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST1224656_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.bool Relative_Is_Business_Contact_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST232708_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.nkdate Assoc_Fs_Date_;
    KEL.typ.bool Is_Executive_Ever_ := FALSE;
    KEL.typ.ndataset(__ST1224656_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST232708_Layout __ND6533372__Project(__ST1226197_Layout __PP6533368) := TRANSFORM
    __EE6533427 := __PP6533368.Contact_Info_;
    __CC14610 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
    __EE6533443 := __PP6533368.Contact_Info_;
    SELF.Assoc_Fs_Date_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE6533427,KEL.era.ToDate(__T(__EE6533427).Date_First_Seen_)),>,__CC14610)),__ECAST(KEL.typ.nkdate,__CC14610),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE6533443,KEL.era.ToDate(__T(__EE6533443).Date_First_Seen_))));
    __EE6533459 := __PP6533368.Relatives_;
    __ST1224656_Layout __ND6533467__Project(B_Sele_Person_4(__cfg).__ST116490_Layout __PP6533463) := TRANSFORM
      SELF.Relative_Is_Business_Contact_ := __PP6533368.Sele_Person_;
      SELF := __PP6533463;
    END;
    SELF.Relatives_ := __PROJECT(__EE6533459,__ND6533467__Project(LEFT));
    SELF := __PP6533368;
  END;
  EXPORT __ENH_Sele_Person_3 := PROJECT(__EE6533367,__ND6533372__Project(LEFT));
END;
