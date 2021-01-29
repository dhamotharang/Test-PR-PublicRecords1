//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_U_C_C(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Filing_Jurisdiction_;
    KEL.typ.nstr Filing_Number_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nkdate Filing_Date_;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nstr Filing_Status_;
    KEL.typ.nstr Filing_Time_;
    KEL.typ.nstr Status_Type_;
    KEL.typ.nstr Filing_Agency_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nstr Contract_Type_;
    KEL.typ.nkdate Vendor_Entry_Date_;
    KEL.typ.nkdate Vendor_Update_Date_;
    KEL.typ.nstr Statements_Filed_;
    KEL.typ.nstr Foreign_Flag_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Collateral_Desc_;
    KEL.typ.nstr Collateral_Machine_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),tmsid(DEFAULT:T_M_S_I_D_:\'\'),rmsid(DEFAULT:R_M_S_I_D_:\'\'),filingjurisdiction(DEFAULT:Filing_Jurisdiction_:\'\'),filingnumber(DEFAULT:Filing_Number_:\'\'),filingtype(DEFAULT:Filing_Type_:\'\'),filingdate(DEFAULT:Filing_Date_:DATE),originalfilingdate(DEFAULT:Original_Filing_Date_:DATE),filingstatus(DEFAULT:Filing_Status_:\'\'),filingtime(DEFAULT:Filing_Time_:\'\'),statustype(DEFAULT:Status_Type_:\'\'),filingagency(DEFAULT:Filing_Agency_:\'\'),expirationdate(DEFAULT:Expiration_Date_:DATE),contracttype(DEFAULT:Contract_Type_:\'\'),vendorentrydate(DEFAULT:Vendor_Entry_Date_:DATE),vendorupdatedate(DEFAULT:Vendor_Update_Date_:DATE),statementsfiled(DEFAULT:Statements_Filed_:\'\'),foreignflag(DEFAULT:Foreign_Flag_:\'\'),processdate(DEFAULT:Process_Date_:DATE),collateraldesc(DEFAULT:Collateral_Desc_:\'\'),collateralmachine(DEFAULT:Collateral_Machine_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.tmsid)));
  SHARED __d1_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.tmsid)));
  SHARED __d2_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.tmsid)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::U_C_C::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::U_C_C');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::U_C_C');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED Process_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),tmsid(OVERRIDE:T_M_S_I_D_:\'\'),rmsid(OVERRIDE:R_M_S_I_D_:\'\'),filingjurisdiction(DEFAULT:Filing_Jurisdiction_:\'\'),filingnumber(DEFAULT:Filing_Number_:\'\'),filingtype(DEFAULT:Filing_Type_:\'\'),filingdate(DEFAULT:Filing_Date_:DATE),originalfilingdate(DEFAULT:Original_Filing_Date_:DATE),filingstatus(DEFAULT:Filing_Status_:\'\'),filingtime(DEFAULT:Filing_Time_:\'\'),statustype(DEFAULT:Status_Type_:\'\'),filingagency(DEFAULT:Filing_Agency_:\'\'),expirationdate(DEFAULT:Expiration_Date_:DATE),contracttype(DEFAULT:Contract_Type_:\'\'),vendorentrydate(DEFAULT:Vendor_Entry_Date_:DATE),vendorupdatedate(DEFAULT:Vendor_Update_Date_:DATE),statementsfiled(DEFAULT:Statements_Filed_:\'\'),foreign_indc(OVERRIDE:Foreign_Flag_:\'\'),process_date(OVERRIDE:Process_Date_:DATE:Process_Date_0Rule),collateraldesc(DEFAULT:Collateral_Desc_:\'\'),collateralmachine(DEFAULT:Collateral_Machine_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault,Lookup,TRIM((STRING)LEFT.tmsid) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_LinkIds_Vault_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault'));
  SHARED Filing_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Original_Filing_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Expiration_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Vendor_Entry_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Vendor_Update_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),tmsid(OVERRIDE:T_M_S_I_D_:\'\'),rmsid(OVERRIDE:R_M_S_I_D_:\'\'),filing_jurisdiction(OVERRIDE:Filing_Jurisdiction_:\'\'),filing_number(OVERRIDE:Filing_Number_:\'\'),filing_type(OVERRIDE:Filing_Type_:\'\'),filing_date(OVERRIDE:Filing_Date_:DATE:Filing_Date_1Rule),orig_filing_date(OVERRIDE:Original_Filing_Date_:DATE:Original_Filing_Date_1Rule),filing_status(OVERRIDE:Filing_Status_:\'\'),filing_time(OVERRIDE:Filing_Time_:\'\'),status_type(OVERRIDE:Status_Type_:\'\'),filing_agency(OVERRIDE:Filing_Agency_:\'\'),expiration_date(OVERRIDE:Expiration_Date_:DATE:Expiration_Date_1Rule),contract_type(OVERRIDE:Contract_Type_:\'\'),vendor_entry_date(OVERRIDE:Vendor_Entry_Date_:DATE:Vendor_Entry_Date_1Rule),vendor_upd_date(OVERRIDE:Vendor_Update_Date_:DATE:Vendor_Update_Date_1Rule),statements_filed(OVERRIDE:Statements_Filed_:\'\'),foreignflag(DEFAULT:Foreign_Flag_:\'\'),process_date(OVERRIDE:Process_Date_:DATE),collateral_desc(OVERRIDE:Collateral_Desc_:\'\'),prim_machine(OVERRIDE:Collateral_Machine_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault,Lookup,TRIM((STRING)LEFT.tmsid) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_rmsid_main_Vault_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault'));
  SHARED Process_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),tmsid(OVERRIDE:T_M_S_I_D_:\'\'),rmsid(OVERRIDE:R_M_S_I_D_:\'\'),filingjurisdiction(DEFAULT:Filing_Jurisdiction_:\'\'),filingnumber(DEFAULT:Filing_Number_:\'\'),filingtype(DEFAULT:Filing_Type_:\'\'),filingdate(DEFAULT:Filing_Date_:DATE),originalfilingdate(DEFAULT:Original_Filing_Date_:DATE),filingstatus(DEFAULT:Filing_Status_:\'\'),filingtime(DEFAULT:Filing_Time_:\'\'),statustype(DEFAULT:Status_Type_:\'\'),filingagency(DEFAULT:Filing_Agency_:\'\'),expirationdate(DEFAULT:Expiration_Date_:DATE),contracttype(DEFAULT:Contract_Type_:\'\'),vendorentrydate(DEFAULT:Vendor_Entry_Date_:DATE),vendorupdatedate(DEFAULT:Vendor_Update_Date_:DATE),statementsfiled(DEFAULT:Statements_Filed_:\'\'),foreign_indc(OVERRIDE:Foreign_Flag_:\'\'),process_date(OVERRIDE:Process_Date_:DATE:Process_Date_2Rule),collateraldesc(DEFAULT:Collateral_Desc_:\'\'),collateralmachine(DEFAULT:Collateral_Machine_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault,Lookup,TRIM((STRING)LEFT.tmsid) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_rmsid_party_Vault_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Sub_Filing_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Filing_Jurisdiction_;
    KEL.typ.nstr Filing_Number_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nkdate Filing_Date_;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nstr Filing_Status_;
    KEL.typ.nstr Filing_Time_;
    KEL.typ.nstr Status_Type_;
    KEL.typ.nstr Filing_Agency_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nstr Contract_Type_;
    KEL.typ.nkdate Vendor_Entry_Date_;
    KEL.typ.nkdate Vendor_Update_Date_;
    KEL.typ.nstr Statements_Filed_;
    KEL.typ.nstr Foreign_Flag_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Collateral_Layout := RECORD
    KEL.typ.nstr Collateral_Desc_;
    KEL.typ.nstr Collateral_Machine_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(Sub_Filing_Layout) Sub_Filing_;
    KEL.typ.ndataset(Collateral_Layout) Collateral_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  U_C_C_Group := __PostFilter;
  Layout U_C_C__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.T_M_S_I_D_ := KEL.Intake.SingleValue(__recs,T_M_S_I_D_);
    SELF.Sub_Filing_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),R_M_S_I_D_,Filing_Jurisdiction_,Filing_Number_,Filing_Type_,Filing_Date_,Original_Filing_Date_,Filing_Status_,Filing_Time_,Status_Type_,Filing_Agency_,Expiration_Date_,Contract_Type_,Vendor_Entry_Date_,Vendor_Update_Date_,Statements_Filed_,Foreign_Flag_,Process_Date_},R_M_S_I_D_,Filing_Jurisdiction_,Filing_Number_,Filing_Type_,Filing_Date_,Original_Filing_Date_,Filing_Status_,Filing_Time_,Status_Type_,Filing_Agency_,Expiration_Date_,Contract_Type_,Vendor_Entry_Date_,Vendor_Update_Date_,Statements_Filed_,Foreign_Flag_,Process_Date_),Sub_Filing_Layout)(__NN(R_M_S_I_D_) OR __NN(Filing_Jurisdiction_) OR __NN(Filing_Number_) OR __NN(Filing_Type_) OR __NN(Filing_Date_) OR __NN(Original_Filing_Date_) OR __NN(Filing_Status_) OR __NN(Filing_Time_) OR __NN(Status_Type_) OR __NN(Filing_Agency_) OR __NN(Expiration_Date_) OR __NN(Contract_Type_) OR __NN(Vendor_Entry_Date_) OR __NN(Vendor_Update_Date_) OR __NN(Statements_Filed_) OR __NN(Foreign_Flag_) OR __NN(Process_Date_)));
    SELF.Collateral_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Collateral_Desc_,Collateral_Machine_},Collateral_Desc_,Collateral_Machine_),Collateral_Layout)(__NN(Collateral_Desc_) OR __NN(Collateral_Machine_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout U_C_C__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Sub_Filing_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Sub_Filing_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(R_M_S_I_D_) OR __NN(Filing_Jurisdiction_) OR __NN(Filing_Number_) OR __NN(Filing_Type_) OR __NN(Filing_Date_) OR __NN(Original_Filing_Date_) OR __NN(Filing_Status_) OR __NN(Filing_Time_) OR __NN(Status_Type_) OR __NN(Filing_Agency_) OR __NN(Expiration_Date_) OR __NN(Contract_Type_) OR __NN(Vendor_Entry_Date_) OR __NN(Vendor_Update_Date_) OR __NN(Statements_Filed_) OR __NN(Foreign_Flag_) OR __NN(Process_Date_)));
    SELF.Collateral_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Collateral_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Collateral_Desc_) OR __NN(Collateral_Machine_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(U_C_C_Group,COUNT(ROWS(LEFT))=1),GROUP,U_C_C__Single_Rollup(LEFT)) + ROLLUP(HAVING(U_C_C_Group,COUNT(ROWS(LEFT))>1),GROUP,U_C_C__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT T_M_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,T_M_S_I_D_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_LinkIds_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_rmsid_main_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_rmsid_party_Vault_Invalid),COUNT(T_M_S_I_D__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_LinkIds_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_rmsid_main_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_rmsid_party_Vault_Invalid,KEL.typ.int T_M_S_I_D__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_LinkIds_Vault_Invalid),COUNT(__d0)},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','tmsid',COUNT(__d0(__NL(T_M_S_I_D_))),COUNT(__d0(__NN(T_M_S_I_D_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','rmsid',COUNT(__d0(__NL(R_M_S_I_D_))),COUNT(__d0(__NN(R_M_S_I_D_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','FilingJurisdiction',COUNT(__d0(__NL(Filing_Jurisdiction_))),COUNT(__d0(__NN(Filing_Jurisdiction_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','FilingNumber',COUNT(__d0(__NL(Filing_Number_))),COUNT(__d0(__NN(Filing_Number_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','FilingType',COUNT(__d0(__NL(Filing_Type_))),COUNT(__d0(__NN(Filing_Type_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','FilingDate',COUNT(__d0(__NL(Filing_Date_))),COUNT(__d0(__NN(Filing_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','OriginalFilingDate',COUNT(__d0(__NL(Original_Filing_Date_))),COUNT(__d0(__NN(Original_Filing_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','FilingStatus',COUNT(__d0(__NL(Filing_Status_))),COUNT(__d0(__NN(Filing_Status_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','FilingTime',COUNT(__d0(__NL(Filing_Time_))),COUNT(__d0(__NN(Filing_Time_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','StatusType',COUNT(__d0(__NL(Status_Type_))),COUNT(__d0(__NN(Status_Type_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','FilingAgency',COUNT(__d0(__NL(Filing_Agency_))),COUNT(__d0(__NN(Filing_Agency_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','ExpirationDate',COUNT(__d0(__NL(Expiration_Date_))),COUNT(__d0(__NN(Expiration_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','ContractType',COUNT(__d0(__NL(Contract_Type_))),COUNT(__d0(__NN(Contract_Type_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','VendorEntryDate',COUNT(__d0(__NL(Vendor_Entry_Date_))),COUNT(__d0(__NN(Vendor_Entry_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','VendorUpdateDate',COUNT(__d0(__NL(Vendor_Update_Date_))),COUNT(__d0(__NN(Vendor_Update_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','StatementsFiled',COUNT(__d0(__NL(Statements_Filed_))),COUNT(__d0(__NN(Statements_Filed_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','foreign_indc',COUNT(__d0(__NL(Foreign_Flag_))),COUNT(__d0(__NN(Foreign_Flag_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','process_date',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','CollateralDesc',COUNT(__d0(__NL(Collateral_Desc_))),COUNT(__d0(__NN(Collateral_Desc_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','CollateralMachine',COUNT(__d0(__NL(Collateral_Machine_))),COUNT(__d0(__NN(Collateral_Machine_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_LinkIds_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_rmsid_main_Vault_Invalid),COUNT(__d1)},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','tmsid',COUNT(__d1(__NL(T_M_S_I_D_))),COUNT(__d1(__NN(T_M_S_I_D_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','rmsid',COUNT(__d1(__NL(R_M_S_I_D_))),COUNT(__d1(__NN(R_M_S_I_D_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','filing_jurisdiction',COUNT(__d1(__NL(Filing_Jurisdiction_))),COUNT(__d1(__NN(Filing_Jurisdiction_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','filing_number',COUNT(__d1(__NL(Filing_Number_))),COUNT(__d1(__NN(Filing_Number_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','filing_type',COUNT(__d1(__NL(Filing_Type_))),COUNT(__d1(__NN(Filing_Type_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','filing_date',COUNT(__d1(__NL(Filing_Date_))),COUNT(__d1(__NN(Filing_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','orig_filing_date',COUNT(__d1(__NL(Original_Filing_Date_))),COUNT(__d1(__NN(Original_Filing_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','filing_status',COUNT(__d1(__NL(Filing_Status_))),COUNT(__d1(__NN(Filing_Status_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','filing_time',COUNT(__d1(__NL(Filing_Time_))),COUNT(__d1(__NN(Filing_Time_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','status_type',COUNT(__d1(__NL(Status_Type_))),COUNT(__d1(__NN(Status_Type_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','filing_agency',COUNT(__d1(__NL(Filing_Agency_))),COUNT(__d1(__NN(Filing_Agency_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','expiration_date',COUNT(__d1(__NL(Expiration_Date_))),COUNT(__d1(__NN(Expiration_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','contract_type',COUNT(__d1(__NL(Contract_Type_))),COUNT(__d1(__NN(Contract_Type_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','vendor_entry_date',COUNT(__d1(__NL(Vendor_Entry_Date_))),COUNT(__d1(__NN(Vendor_Entry_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','vendor_upd_date',COUNT(__d1(__NL(Vendor_Update_Date_))),COUNT(__d1(__NN(Vendor_Update_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','statements_filed',COUNT(__d1(__NL(Statements_Filed_))),COUNT(__d1(__NN(Statements_Filed_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','ForeignFlag',COUNT(__d1(__NL(Foreign_Flag_))),COUNT(__d1(__NN(Foreign_Flag_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','process_date',COUNT(__d1(__NL(Process_Date_))),COUNT(__d1(__NN(Process_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','collateral_desc',COUNT(__d1(__NL(Collateral_Desc_))),COUNT(__d1(__NN(Collateral_Desc_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','prim_machine',COUNT(__d1(__NL(Collateral_Machine_))),COUNT(__d1(__NN(Collateral_Machine_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_main_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_UCCV2__Key_rmsid_party_Vault_Invalid),COUNT(__d2)},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','tmsid',COUNT(__d2(__NL(T_M_S_I_D_))),COUNT(__d2(__NN(T_M_S_I_D_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','rmsid',COUNT(__d2(__NL(R_M_S_I_D_))),COUNT(__d2(__NN(R_M_S_I_D_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','FilingJurisdiction',COUNT(__d2(__NL(Filing_Jurisdiction_))),COUNT(__d2(__NN(Filing_Jurisdiction_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','FilingNumber',COUNT(__d2(__NL(Filing_Number_))),COUNT(__d2(__NN(Filing_Number_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','FilingType',COUNT(__d2(__NL(Filing_Type_))),COUNT(__d2(__NN(Filing_Type_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','FilingDate',COUNT(__d2(__NL(Filing_Date_))),COUNT(__d2(__NN(Filing_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','OriginalFilingDate',COUNT(__d2(__NL(Original_Filing_Date_))),COUNT(__d2(__NN(Original_Filing_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','FilingStatus',COUNT(__d2(__NL(Filing_Status_))),COUNT(__d2(__NN(Filing_Status_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','FilingTime',COUNT(__d2(__NL(Filing_Time_))),COUNT(__d2(__NN(Filing_Time_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','StatusType',COUNT(__d2(__NL(Status_Type_))),COUNT(__d2(__NN(Status_Type_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','FilingAgency',COUNT(__d2(__NL(Filing_Agency_))),COUNT(__d2(__NN(Filing_Agency_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','ExpirationDate',COUNT(__d2(__NL(Expiration_Date_))),COUNT(__d2(__NN(Expiration_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','ContractType',COUNT(__d2(__NL(Contract_Type_))),COUNT(__d2(__NN(Contract_Type_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','VendorEntryDate',COUNT(__d2(__NL(Vendor_Entry_Date_))),COUNT(__d2(__NN(Vendor_Entry_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','VendorUpdateDate',COUNT(__d2(__NL(Vendor_Update_Date_))),COUNT(__d2(__NN(Vendor_Update_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','StatementsFiled',COUNT(__d2(__NL(Statements_Filed_))),COUNT(__d2(__NN(Statements_Filed_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','foreign_indc',COUNT(__d2(__NL(Foreign_Flag_))),COUNT(__d2(__NN(Foreign_Flag_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','process_date',COUNT(__d2(__NL(Process_Date_))),COUNT(__d2(__NN(Process_Date_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','CollateralDesc',COUNT(__d2(__NL(Collateral_Desc_))),COUNT(__d2(__NN(Collateral_Desc_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','CollateralMachine',COUNT(__d2(__NL(Collateral_Machine_))),COUNT(__d2(__NN(Collateral_Machine_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'UCC','PublicRecords_KEL.Files.NonFCRA.UCCV2__Key_rmsid_party_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
