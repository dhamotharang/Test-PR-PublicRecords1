//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_U_C_C_9,B_U_C_C_10,B_U_C_C_11,B_U_C_C_9,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_U_C_C_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_9(__in,__cfg).__ENH_Sele_U_C_C_9) __ENH_Sele_U_C_C_9 := B_Sele_U_C_C_9(__in,__cfg).__ENH_Sele_U_C_C_9;
  SHARED VIRTUAL TYPEOF(B_U_C_C_9(__in,__cfg).__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9(__in,__cfg).__ENH_U_C_C_9;
  SHARED __EE1898298 := __ENH_Sele_U_C_C_9;
  SHARED __EE1898311 := __EE1898298;
  SHARED __EE1898318 := __EE1898311(__NN(__EE1898311.Filing_));
  SHARED __EE1898309 := __ENH_U_C_C_9;
  SHARED __ST297883_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST221377_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.ndataset(B_U_C_C_9(__in,__cfg).__ST221586_Layout) Sub_Filing__1_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nstr Best_Child_R_M_S_I_D_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST105313_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1898327(B_Sele_U_C_C_9(__in,__cfg).__ST221369_Layout __EE1898318, B_U_C_C_9(__in,__cfg).__ST221582_Layout __EE1898309) := __EEQP(__EE1898318.Filing_,__EE1898309.UID);
  __ST297883_Layout __JT1898327(B_Sele_U_C_C_9(__in,__cfg).__ST221369_Layout __l, B_U_C_C_9(__in,__cfg).__ST221582_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.Sub_Filing__1_ := __r.Sub_Filing_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1898402 := JOIN(__EE1898318,__EE1898309,__JC1898327(LEFT,RIGHT),__JT1898327(LEFT,RIGHT),INNER,HASH);
  SHARED __ST298046_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST221377_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.ndataset(B_U_C_C_9(__in,__cfg).__ST221586_Layout) Sub_Filing__1_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nstr Best_Child_R_M_S_I_D_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST105313_Layout) Best_U_C_C_Child_Record_;
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
  __JC1898419(__ST297883_Layout __EE1898402, B_Sele_U_C_C_9(__in,__cfg).__ST221377_Layout __EE1898405) := __T(__OP2(__EE1898405.R_M_S_I_D_,=,__EE1898402.Best_Child_R_M_S_I_D_));
  __ST298046_Layout __JT1898419(__ST297883_Layout __l, B_Sele_U_C_C_9(__in,__cfg).__ST221377_Layout __r) := TRANSFORM, SKIP(NOT(__JC1898419(__l,__r)))
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1898491 := NORMALIZE(__EE1898402,__T(LEFT.Sub_Filing_),__JT1898419(LEFT,RIGHT));
  SHARED __ST297662_Layout := RECORD
    KEL.typ.ntyp(E_U_C_C().Typ) ____grp___Filing_;
    KEL.typ.nstr ____grp___T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) ____grp___Legal_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST221377_Layout) ____grp___Sub_Filing_;
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
  SHARED __ST297662_Layout __ND1898496__Project(__ST298046_Layout __PP1898492) := TRANSFORM
    SELF.____grp___Filing_ := __PP1898492.Filing_;
    SELF.____grp___T_M_S_I_D_ := __PP1898492.T_M_S_I_D_;
    SELF.____grp___Legal_ := __PP1898492.Legal_;
    SELF.____grp___Sub_Filing_ := __PP1898492.Sub_Filing_;
    SELF.____grp___Org_I_D_ := __PP1898492.Org_I_D_;
    SELF.____grp___Sele_I_D_ := __PP1898492.Sele_I_D_;
    SELF.____grp___Data_Sources_ := __PP1898492.Data_Sources_;
    SELF.____grp___Ult_I_D_ := __PP1898492.Ult_I_D_;
    SELF := __PP1898492;
  END;
  SHARED __EE1898553 := PROJECT(__EE1898491,__ND1898496__Project(LEFT));
  SHARED __EE1898578 := GROUP(KEL.Routines.SortChildren(__EE1898553,'____grp___Sub_Filing_,____grp___Data_Sources_'),____grp___Filing_,____grp___T_M_S_I_D_,____grp___Legal_,____grp___Sub_Filing_,____grp___Org_I_D_,____grp___Sele_I_D_,____grp___Data_Sources_,____grp___Ult_I_D_,ALL);
  SHARED __EE1898582 := UNGROUP(TOPN(__EE1898578,1,__EE1898578.Party_Sort_List_,__T(____grp___Legal_),__T(____grp___T_M_S_I_D_),__T(____grp___Filing_),__T(____grp___Ult_I_D_),__T(____grp___Org_I_D_),__T(____grp___Sele_I_D_),__T(Party_Type_)));
  SHARED __ST298429_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST221377_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST297662_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1898633(B_Sele_U_C_C_9(__in,__cfg).__ST221369_Layout __EE1898298, __ST297662_Layout __EE1898582) := __EEQP(__EE1898298.Ult_I_D_,__EE1898582.____grp___Ult_I_D_) AND __EEQP(__EE1898298.T_M_S_I_D_,__EE1898582.____grp___T_M_S_I_D_) AND __EEQP(__EE1898298.Sub_Filing_,__EE1898582.____grp___Sub_Filing_) AND __EEQP(__EE1898298.Sele_I_D_,__EE1898582.____grp___Sele_I_D_) AND __EEQP(__EE1898298.Org_I_D_,__EE1898582.____grp___Org_I_D_) AND __EEQP(__EE1898298.Legal_,__EE1898582.____grp___Legal_) AND __EEQP(__EE1898298.Filing_,__EE1898582.____grp___Filing_) AND __EEQP(__EE1898298.Data_Sources_,__EE1898582.____grp___Data_Sources_);
  __ST298429_Layout __Join__ST298429_Layout(B_Sele_U_C_C_9(__in,__cfg).__ST221369_Layout __r, DATASET(__ST297662_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE1898668 := DENORMALIZE(DISTRIBUTE(__EE1898298,HASH(Legal_)),DISTRIBUTE(__EE1898582,HASH(____grp___Legal_)),__JC1898633(LEFT,RIGHT),GROUP,__Join__ST298429_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST220400_Layout := RECORD
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
  SHARED __ST220392_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST220400_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST297662_Layout) Best_Party_Types_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST220392_Layout __ND1898679__Project(__ST298429_Layout __PP1898675) := TRANSFORM
    __EE1898671 := __PP1898675.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE1898671),__ST220400_Layout),__NL(__EE1898671));
    __EE1898674 := __PP1898675.Exp1_;
    SELF.Best_Party_Types_ := __EE1898674;
    SELF := __PP1898675;
  END;
  SHARED __EE1898770 := PROJECT(__EE1898668,__ND1898679__Project(LEFT));
  EXPORT __ST297584_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST220400_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST221377_Layout) Best_Party_Types_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST297584_Layout __ND1898230__Project(__ST220392_Layout __PP1898226) := TRANSFORM
    __EE1898773 := __PP1898226.Best_Party_Types_;
    SELF.Best_Party_Types_ := __PROJECT(__EE1898773,B_Sele_U_C_C_9(__in,__cfg).__ST221377_Layout);
    SELF := __PP1898226;
  END;
  EXPORT __ENH_Sele_U_C_C_8 := PROJECT(__EE1898770,__ND1898230__Project(LEFT));
END;
