//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_U_C_C_9,B_U_C_C_10,B_U_C_C_11,B_U_C_C_9,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_U_C_C_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_9(__in,__cfg).__ENH_Sele_U_C_C_9) __ENH_Sele_U_C_C_9 := B_Sele_U_C_C_9(__in,__cfg).__ENH_Sele_U_C_C_9;
  SHARED VIRTUAL TYPEOF(B_U_C_C_9(__in,__cfg).__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9(__in,__cfg).__ENH_U_C_C_9;
  SHARED __EE1896955 := __ENH_Sele_U_C_C_9;
  SHARED __EE1896968 := __EE1896955;
  SHARED __EE1896975 := __EE1896968(__NN(__EE1896968.Filing_));
  SHARED __EE1896966 := __ENH_U_C_C_9;
  SHARED __ST296869_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST220369_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.ndataset(B_U_C_C_9(__in,__cfg).__ST220578_Layout) Sub_Filing__1_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nstr Best_Child_R_M_S_I_D_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST104821_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1896984(B_Sele_U_C_C_9(__in,__cfg).__ST220361_Layout __EE1896975, B_U_C_C_9(__in,__cfg).__ST220574_Layout __EE1896966) := __EEQP(__EE1896975.Filing_,__EE1896966.UID);
  __ST296869_Layout __JT1896984(B_Sele_U_C_C_9(__in,__cfg).__ST220361_Layout __l, B_U_C_C_9(__in,__cfg).__ST220574_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.Sub_Filing__1_ := __r.Sub_Filing_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1897059 := JOIN(__EE1896975,__EE1896966,__JC1896984(LEFT,RIGHT),__JT1896984(LEFT,RIGHT),INNER,HASH);
  SHARED __ST297032_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST220369_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.ndataset(B_U_C_C_9(__in,__cfg).__ST220578_Layout) Sub_Filing__1_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nstr Best_Child_R_M_S_I_D_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST104821_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
    KEL.typ.int Party_Sort_List_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1897076(__ST296869_Layout __EE1897059, B_Sele_U_C_C_9(__in,__cfg).__ST220369_Layout __EE1897062) := __T(__OP2(__EE1897062.R_M_S_I_D_,=,__EE1897059.Best_Child_R_M_S_I_D_));
  __ST297032_Layout __JT1897076(__ST296869_Layout __l, B_Sele_U_C_C_9(__in,__cfg).__ST220369_Layout __r) := TRANSFORM, SKIP(NOT(__JC1897076(__l,__r)))
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1897148 := NORMALIZE(__EE1897059,__T(LEFT.Sub_Filing_),__JT1897076(LEFT,RIGHT));
  SHARED __ST296648_Layout := RECORD
    KEL.typ.ntyp(E_U_C_C().Typ) ____grp___Filing_;
    KEL.typ.nstr ____grp___T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) ____grp___Legal_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST220369_Layout) ____grp___Sub_Filing_;
    KEL.typ.nint ____grp___Org_I_D_;
    KEL.typ.nint ____grp___Sele_I_D_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) ____grp___Data_Sources_;
    KEL.typ.nint ____grp___Ult_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
    KEL.typ.int Party_Sort_List_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST296648_Layout __ND1897153__Project(__ST297032_Layout __PP1897149) := TRANSFORM
    SELF.____grp___Filing_ := __PP1897149.Filing_;
    SELF.____grp___T_M_S_I_D_ := __PP1897149.T_M_S_I_D_;
    SELF.____grp___Legal_ := __PP1897149.Legal_;
    SELF.____grp___Sub_Filing_ := __PP1897149.Sub_Filing_;
    SELF.____grp___Org_I_D_ := __PP1897149.Org_I_D_;
    SELF.____grp___Sele_I_D_ := __PP1897149.Sele_I_D_;
    SELF.____grp___Data_Sources_ := __PP1897149.Data_Sources_;
    SELF.____grp___Ult_I_D_ := __PP1897149.Ult_I_D_;
    SELF := __PP1897149;
  END;
  SHARED __EE1897210 := PROJECT(__EE1897148,__ND1897153__Project(LEFT));
  SHARED __EE1897235 := GROUP(KEL.Routines.SortChildren(__EE1897210,'____grp___Sub_Filing_,____grp___Data_Sources_'),____grp___Filing_,____grp___T_M_S_I_D_,____grp___Legal_,____grp___Sub_Filing_,____grp___Org_I_D_,____grp___Sele_I_D_,____grp___Data_Sources_,____grp___Ult_I_D_,ALL);
  SHARED __EE1897239 := UNGROUP(TOPN(__EE1897235,1,__EE1897235.Party_Sort_List_,__T(____grp___Legal_),__T(____grp___T_M_S_I_D_),__T(____grp___Filing_),__T(____grp___Ult_I_D_),__T(____grp___Org_I_D_),__T(____grp___Sele_I_D_),__T(Party_Type_)));
  SHARED __ST297415_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST220369_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST296648_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1897290(B_Sele_U_C_C_9(__in,__cfg).__ST220361_Layout __EE1896955, __ST296648_Layout __EE1897239) := __EEQP(__EE1896955.Ult_I_D_,__EE1897239.____grp___Ult_I_D_) AND __EEQP(__EE1896955.T_M_S_I_D_,__EE1897239.____grp___T_M_S_I_D_) AND __EEQP(__EE1896955.Sub_Filing_,__EE1897239.____grp___Sub_Filing_) AND __EEQP(__EE1896955.Sele_I_D_,__EE1897239.____grp___Sele_I_D_) AND __EEQP(__EE1896955.Org_I_D_,__EE1897239.____grp___Org_I_D_) AND __EEQP(__EE1896955.Legal_,__EE1897239.____grp___Legal_) AND __EEQP(__EE1896955.Filing_,__EE1897239.____grp___Filing_) AND __EEQP(__EE1896955.Data_Sources_,__EE1897239.____grp___Data_Sources_);
  __ST297415_Layout __Join__ST297415_Layout(B_Sele_U_C_C_9(__in,__cfg).__ST220361_Layout __r, DATASET(__ST296648_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE1897325 := DENORMALIZE(DISTRIBUTE(__EE1896955,HASH(Legal_)),DISTRIBUTE(__EE1897239,HASH(____grp___Legal_)),__JC1897290(LEFT,RIGHT),GROUP,__Join__ST297415_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST219392_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
    KEL.typ.int Party_Sort_List_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST219384_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST219392_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST296648_Layout) Best_Party_Types_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST219384_Layout __ND1897336__Project(__ST297415_Layout __PP1897332) := TRANSFORM
    __EE1897328 := __PP1897332.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE1897328),__ST219392_Layout),__NL(__EE1897328));
    __EE1897331 := __PP1897332.Exp1_;
    SELF.Best_Party_Types_ := __EE1897331;
    SELF := __PP1897332;
  END;
  SHARED __EE1897427 := PROJECT(__EE1897325,__ND1897336__Project(LEFT));
  EXPORT __ST296570_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST219392_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST220369_Layout) Best_Party_Types_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST296570_Layout __ND1896887__Project(__ST219384_Layout __PP1896883) := TRANSFORM
    __EE1897430 := __PP1896883.Best_Party_Types_;
    SELF.Best_Party_Types_ := __PROJECT(__EE1897430,B_Sele_U_C_C_9(__in,__cfg).__ST220369_Layout);
    SELF := __PP1896883;
  END;
  EXPORT __ENH_Sele_U_C_C_8 := PROJECT(__EE1897427,__ND1896887__Project(LEFT));
END;
