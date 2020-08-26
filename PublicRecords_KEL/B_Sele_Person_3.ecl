//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Sele_Person_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Person,E_Sele_Person,E_Surname,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Sele_Person_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4;
  SHARED __EE4083249 := __ENH_Sele_Person_4;
  SHARED __ST945255_Layout := RECORD
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
    KEL.typ.ndataset(B_Sele_Person_4(__in,__cfg).__ST87447_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.bool Sele_Person_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE4084105 := __EE4083249;
  SHARED __EE4085098 := __EE4084105(__T(__AND(__EE4084105.Two_Years_,__CN(__EE4084105.Is_Executive_Ever_ AND __NN(__EE4084105.Legal_)))));
  SHARED __ST4084555_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE4085112 := PROJECT(TABLE(PROJECT(__EE4085098,__ST4084555_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),Legal_,Contact_},Legal_,Contact_,MERGE),__ST4084555_Layout);
  SHARED __EE4083262 := __EE4083249;
  SHARED __EE4083269 := __EE4083262(__NN(__EE4083262.Legal_));
  SHARED __ST4084587_Layout := RECORD
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
    KEL.typ.ndataset(B_Sele_Person_4(__in,__cfg).__ST87447_Layout) Relatives__1_;
    KEL.typ.nbool Two_Years__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST4084587_Layout __ND4084562__Project(B_Sele_Person_4(__in,__cfg).__ST191592_Layout __PP4084561) := TRANSFORM
    SELF.Legal__1_ := __PP4084561.Legal_;
    SELF.Contact__1_ := __PP4084561.Contact_;
    SELF.Ult_I_D__1_ := __PP4084561.Ult_I_D_;
    SELF.Org_I_D__1_ := __PP4084561.Org_I_D_;
    SELF.Sele_I_D__1_ := __PP4084561.Sele_I_D_;
    SELF.Contact_Info__1_ := __PP4084561.Contact_Info_;
    SELF.Data_Sources__1_ := __PP4084561.Data_Sources_;
    SELF.Age_In_Days__1_ := __PP4084561.Age_In_Days_;
    SELF.Assoc_Date__1_ := __PP4084561.Assoc_Date_;
    SELF.Is_Executive_Ever__1_ := __PP4084561.Is_Executive_Ever_;
    SELF.Relatives__1_ := __PP4084561.Relatives_;
    SELF.Two_Years__1_ := __PP4084561.Two_Years_;
    SELF := __PP4084561;
  END;
  SHARED __EE4084628 := PROJECT(__EE4083269,__ND4084562__Project(LEFT));
  SHARED __ST4084681_Layout := RECORD
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
    KEL.typ.ndataset(B_Sele_Person_4(__in,__cfg).__ST87447_Layout) Relatives__1_;
    KEL.typ.nbool Two_Years__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4085118(__ST4084555_Layout __EE4085112, __ST4084587_Layout __EE4084628) := __EEQP(__EE4084628.Legal__1_,__EE4085112.Legal_);
  __ST4084681_Layout __JT4085118(__ST4084555_Layout __l, __ST4084587_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4085158 := JOIN(__EE4085112,__EE4084628,__JC4085118(LEFT,RIGHT),__JT4085118(LEFT,RIGHT),INNER,HASH);
  SHARED __EE4085169 := __EE4085158.Relatives__1_;
  __JC4085178(B_Sele_Person_4(__in,__cfg).__ST87447_Layout __EE4085169) := __T(__OP2(__EE4085158.Contact_,=,__EE4085169.Relative_));
  SHARED __EE4085179 := __EE4085158(EXISTS(__CHILDJOINFILTER(__EE4085169,__JC4085178)));
  __JC4085269(B_Sele_Person_4(__in,__cfg).__ST191592_Layout __EE4083249, __ST4084681_Layout __EE4085179) := __EEQP(__EE4083249.Ult_I_D_,__EE4085179.Ult_I_D__1_) AND __EEQP(__EE4083249.Two_Years_,__EE4085179.Two_Years__1_) AND __EEQP(__EE4083249.Sele_I_D_,__EE4085179.Sele_I_D__1_) AND __EEQP(__EE4083249.Relatives_,__EE4085179.Relatives__1_) AND __EEQP(__EE4083249.Org_I_D_,__EE4085179.Org_I_D__1_) AND __EEQP(__EE4083249.Legal_,__EE4085179.Legal__1_) AND __EE4083249.Is_Executive_Ever_ = __EE4085179.Is_Executive_Ever__1_ AND __EEQP(__EE4083249.Data_Sources_,__EE4085179.Data_Sources__1_) AND __EEQP(__EE4083249.Contact_Info_,__EE4085179.Contact_Info__1_) AND __EEQP(__EE4083249.Contact_,__EE4085179.Contact__1_) AND __EEQP(__EE4083249.Assoc_Date_,__EE4085179.Assoc_Date__1_) AND __EEQP(__EE4083249.Age_In_Days_,__EE4085179.Age_In_Days__1_) AND __T(__AND(__EEQ(__EE4083249.Ult_I_D_,__EE4085179.Ult_I_D__1_),__AND(__EEQ(__EE4083249.Two_Years_,__EE4085179.Two_Years__1_),__AND(__EEQ(__EE4083249.Sele_I_D_,__EE4085179.Sele_I_D__1_),__AND(__EEQ(__EE4083249.Relatives_,__EE4085179.Relatives__1_),__AND(__EEQ(__EE4083249.Org_I_D_,__EE4085179.Org_I_D__1_),__AND(__EEQ(__EE4083249.Legal_,__EE4085179.Legal__1_),__AND(__CN(__EE4083249.Is_Executive_Ever_ = __EE4085179.Is_Executive_Ever__1_),__AND(__EEQ(__EE4083249.Data_Sources_,__EE4085179.Data_Sources__1_),__AND(__EEQ(__EE4083249.Contact_Info_,__EE4085179.Contact_Info__1_),__AND(__EEQ(__EE4083249.Contact_,__EE4085179.Contact__1_),__AND(__EEQ(__EE4083249.Assoc_Date_,__EE4085179.Assoc_Date__1_),__EEQ(__EE4083249.Age_In_Days_,__EE4085179.Age_In_Days__1_)))))))))))));
  __JF4085269(__ST4084681_Layout __EE4085179) := __NN(__EE4085179.Ult_I_D__1_) OR __NN(__EE4085179.Two_Years__1_) OR __NN(__EE4085179.Sele_I_D__1_) OR __NN(__EE4085179.Relatives__1_) OR __NN(__EE4085179.Org_I_D__1_) OR __NN(__EE4085179.Legal__1_) OR __NN(__EE4085179.Data_Sources__1_) OR __NN(__EE4085179.Contact_Info__1_) OR __NN(__EE4085179.Contact__1_) OR __NN(__EE4085179.Assoc_Date__1_) OR __NN(__EE4085179.Age_In_Days__1_);
  SHARED __EE4085308 := JOIN(__EE4083249,__EE4085179,__JC4085269(LEFT,RIGHT),TRANSFORM(__ST945255_Layout,SELF:=LEFT,SELF.Sele_Person_:=__JF4085269(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST943714_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.bool Relative_Is_Business_Contact_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST182320_Layout := RECORD
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
    KEL.typ.ndataset(__ST943714_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST182320_Layout __ND4085313__Project(__ST945255_Layout __PP4085309) := TRANSFORM
    __EE4085368 := __PP4085309.Contact_Info_;
    __CC10430 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
    __EE4085384 := __PP4085309.Contact_Info_;
    SELF.Assoc_Fs_Date_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE4085368,KEL.era.ToDate(__T(__EE4085368).Date_First_Seen_)),>,__CC10430)),__ECAST(KEL.typ.nkdate,__CC10430),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE4085384,KEL.era.ToDate(__T(__EE4085384).Date_First_Seen_))));
    __EE4085400 := __PP4085309.Relatives_;
    __ST943714_Layout __ND4085408__Project(B_Sele_Person_4(__in,__cfg).__ST87447_Layout __PP4085404) := TRANSFORM
      SELF.Relative_Is_Business_Contact_ := __PP4085309.Sele_Person_;
      SELF := __PP4085404;
    END;
    SELF.Relatives_ := __PROJECT(__EE4085400,__ND4085408__Project(LEFT));
    SELF := __PP4085309;
  END;
  EXPORT __ENH_Sele_Person_3 := PROJECT(__EE4085308,__ND4085313__Project(LEFT));
END;
