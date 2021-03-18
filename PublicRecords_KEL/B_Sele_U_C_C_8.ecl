//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_U_C_C_9,B_U_C_C_10,B_U_C_C_11,B_U_C_C_9,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_U_C_C_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_9(__in,__cfg).__ENH_Sele_U_C_C_9) __ENH_Sele_U_C_C_9 := B_Sele_U_C_C_9(__in,__cfg).__ENH_Sele_U_C_C_9;
  SHARED VIRTUAL TYPEOF(B_U_C_C_9(__in,__cfg).__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9(__in,__cfg).__ENH_U_C_C_9;
  SHARED __EE5428527 := __ENH_Sele_U_C_C_9;
  SHARED __EE5428540 := __EE5428527;
  SHARED __EE5428547 := __EE5428540(__NN(__EE5428540.Filing_));
  SHARED __EE5428538 := __ENH_U_C_C_9;
  SHARED __ST411033_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST268118_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.ndataset(B_U_C_C_9(__in,__cfg).__ST268327_Layout) Sub_Filing__1_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nstr Best_Child_R_M_S_I_D_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST118195_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5428556(B_Sele_U_C_C_9(__in,__cfg).__ST268110_Layout __EE5428547, B_U_C_C_9(__in,__cfg).__ST268323_Layout __EE5428538) := __EEQP(__EE5428547.Filing_,__EE5428538.UID);
  __ST411033_Layout __JT5428556(B_Sele_U_C_C_9(__in,__cfg).__ST268110_Layout __l, B_U_C_C_9(__in,__cfg).__ST268323_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.Sub_Filing__1_ := __r.Sub_Filing_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5428631 := JOIN(__EE5428547,__EE5428538,__JC5428556(LEFT,RIGHT),__JT5428556(LEFT,RIGHT),INNER,HASH);
  SHARED __ST411196_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST268118_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.ndataset(B_U_C_C_9(__in,__cfg).__ST268327_Layout) Sub_Filing__1_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nstr Best_Child_R_M_S_I_D_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST118195_Layout) Best_U_C_C_Child_Record_;
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
  __JC5428648(__ST411033_Layout __EE5428631, B_Sele_U_C_C_9(__in,__cfg).__ST268118_Layout __EE5428634) := __T(__OP2(__EE5428634.R_M_S_I_D_,=,__EE5428631.Best_Child_R_M_S_I_D_));
  __ST411196_Layout __JT5428648(__ST411033_Layout __l, B_Sele_U_C_C_9(__in,__cfg).__ST268118_Layout __r) := TRANSFORM, SKIP(NOT(__JC5428648(__l,__r)))
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5428720 := NORMALIZE(__EE5428631,__T(LEFT.Sub_Filing_),__JT5428648(LEFT,RIGHT));
  SHARED __ST410812_Layout := RECORD
    KEL.typ.ntyp(E_U_C_C().Typ) ____grp___Filing_;
    KEL.typ.nstr ____grp___T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) ____grp___Legal_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST268118_Layout) ____grp___Sub_Filing_;
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
  SHARED __ST410812_Layout __ND5428725__Project(__ST411196_Layout __PP5428721) := TRANSFORM
    SELF.____grp___Filing_ := __PP5428721.Filing_;
    SELF.____grp___T_M_S_I_D_ := __PP5428721.T_M_S_I_D_;
    SELF.____grp___Legal_ := __PP5428721.Legal_;
    SELF.____grp___Sub_Filing_ := __PP5428721.Sub_Filing_;
    SELF.____grp___Org_I_D_ := __PP5428721.Org_I_D_;
    SELF.____grp___Sele_I_D_ := __PP5428721.Sele_I_D_;
    SELF.____grp___Data_Sources_ := __PP5428721.Data_Sources_;
    SELF.____grp___Ult_I_D_ := __PP5428721.Ult_I_D_;
    SELF := __PP5428721;
  END;
  SHARED __EE5428782 := PROJECT(__EE5428720,__ND5428725__Project(LEFT));
  SHARED __EE5428807 := GROUP(KEL.Routines.SortChildren(__EE5428782,'____grp___Sub_Filing_,____grp___Data_Sources_'),____grp___Filing_,____grp___T_M_S_I_D_,____grp___Legal_,____grp___Sub_Filing_,____grp___Org_I_D_,____grp___Sele_I_D_,____grp___Data_Sources_,____grp___Ult_I_D_,ALL);
  SHARED __EE5428811 := UNGROUP(TOPN(__EE5428807,1,__EE5428807.Party_Sort_List_,__T(____grp___Legal_),__T(____grp___T_M_S_I_D_),__T(____grp___Filing_),__T(____grp___Ult_I_D_),__T(____grp___Org_I_D_),__T(____grp___Sele_I_D_),__T(Party_Type_)));
  SHARED __ST411579_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST268118_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST410812_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5428862(B_Sele_U_C_C_9(__in,__cfg).__ST268110_Layout __EE5428527, __ST410812_Layout __EE5428811) := __EEQP(__EE5428527.Ult_I_D_,__EE5428811.____grp___Ult_I_D_) AND __EEQP(__EE5428527.T_M_S_I_D_,__EE5428811.____grp___T_M_S_I_D_) AND __EEQP(__EE5428527.Sub_Filing_,__EE5428811.____grp___Sub_Filing_) AND __EEQP(__EE5428527.Sele_I_D_,__EE5428811.____grp___Sele_I_D_) AND __EEQP(__EE5428527.Org_I_D_,__EE5428811.____grp___Org_I_D_) AND __EEQP(__EE5428527.Legal_,__EE5428811.____grp___Legal_) AND __EEQP(__EE5428527.Filing_,__EE5428811.____grp___Filing_) AND __EEQP(__EE5428527.Data_Sources_,__EE5428811.____grp___Data_Sources_);
  __ST411579_Layout __Join__ST411579_Layout(B_Sele_U_C_C_9(__in,__cfg).__ST268110_Layout __r, DATASET(__ST410812_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE5428897 := DENORMALIZE(DISTRIBUTE(__EE5428527,HASH(Legal_)),DISTRIBUTE(__EE5428811,HASH(____grp___Legal_)),__JC5428862(LEFT,RIGHT),GROUP,__Join__ST411579_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST266219_Layout := RECORD
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
  SHARED __ST266211_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST266219_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST410812_Layout) Best_Party_Types_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST266211_Layout __ND5428908__Project(__ST411579_Layout __PP5428904) := TRANSFORM
    __EE5428900 := __PP5428904.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE5428900),__ST266219_Layout),__NL(__EE5428900));
    __EE5428903 := __PP5428904.Exp1_;
    SELF.Best_Party_Types_ := __EE5428903;
    SELF := __PP5428904;
  END;
  SHARED __EE5428999 := PROJECT(__EE5428897,__ND5428908__Project(LEFT));
  EXPORT __ST410734_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST266219_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST268118_Layout) Best_Party_Types_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST410734_Layout __ND5428459__Project(__ST266211_Layout __PP5428455) := TRANSFORM
    __EE5429002 := __PP5428455.Best_Party_Types_;
    SELF.Best_Party_Types_ := __PROJECT(__EE5429002,B_Sele_U_C_C_9(__in,__cfg).__ST268118_Layout);
    SELF := __PP5428455;
  END;
  EXPORT __ENH_Sele_U_C_C_8 := PROJECT(__EE5428999,__ND5428459__Project(LEFT));
END;
