//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Aircraft(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr N_Number_;
    KEL.typ.nstr Serial_Number_;
    KEL.typ.nstr Manufacturer_Model_Code_;
    KEL.typ.nstr Engine_Manufacturer_Model_Code_;
    KEL.typ.nint Year_Manufactured_;
    KEL.typ.nkdate Last_Action_Date_;
    KEL.typ.nint Type_;
    KEL.typ.nstr Type_Engine_;
    KEL.typ.nstr Status_Code_;
    KEL.typ.nstr Transponder_Code_;
    KEL.typ.nstr Fractional_Owner_;
    KEL.typ.nstr Manufacturer_Name_;
    KEL.typ.nstr Model_Name_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),nnumber(DEFAULT:N_Number_:\'\'),serialnumber(DEFAULT:Serial_Number_:\'\'),manufacturermodelcode(DEFAULT:Manufacturer_Model_Code_:\'\'),enginemanufacturermodelcode(DEFAULT:Engine_Manufacturer_Model_Code_:\'\'),yearmanufactured(DEFAULT:Year_Manufactured_:0),lastactiondate(DEFAULT:Last_Action_Date_:DATE),type(DEFAULT:Type_:0),typeengine(DEFAULT:Type_Engine_:\'\'),statuscode(DEFAULT:Status_Code_:\'\'),transpondercode(DEFAULT:Transponder_Code_:\'\'),fractionalowner(DEFAULT:Fractional_Owner_:\'\'),manufacturername(DEFAULT:Manufacturer_Name_:\'\'),modelname(DEFAULT:Model_Name_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.n_number)));
  SHARED __d1_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.n_number)));
  SHARED __d2_Trim := PROJECT(PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.n_number)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Aircraft::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Aircraft');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Aircraft');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),n_number(OVERRIDE:N_Number_:\'\'),serial_number(OVERRIDE:Serial_Number_:\'\'),mfr_mdl_code(OVERRIDE:Manufacturer_Model_Code_:\'\'),eng_mfr_mdl(OVERRIDE:Engine_Manufacturer_Model_Code_:\'\'),year_mfr(OVERRIDE:Year_Manufactured_:0),last_action_date(OVERRIDE:Last_Action_Date_:DATE),type_aircraft(OVERRIDE:Type_:0),type_engine(OVERRIDE:Type_Engine_:\'\'),status_code(OVERRIDE:Status_Code_:\'\'),mode_s_code(OVERRIDE:Transponder_Code_:\'\'),fract_owner(OVERRIDE:Fractional_Owner_:\'\'),aircraft_mfr_name(OVERRIDE:Manufacturer_Name_:\'\'),model_name(OVERRIDE:Model_Name_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault,Lookup,TRIM((STRING)LEFT.n_number) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_FAA__Key_Aircraft_Id_Vault_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault'));
  SHARED Last_Action_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),n_number(OVERRIDE:N_Number_:\'\'),serial_number(OVERRIDE:Serial_Number_:\'\'),mfr_mdl_code(OVERRIDE:Manufacturer_Model_Code_:\'\'),eng_mfr_mdl(OVERRIDE:Engine_Manufacturer_Model_Code_:\'\'),year_mfr(OVERRIDE:Year_Manufactured_:0),last_action_date(OVERRIDE:Last_Action_Date_:DATE:Last_Action_Date_1Rule),type_aircraft(OVERRIDE:Type_:0),type_engine(OVERRIDE:Type_Engine_:\'\'),status_code(OVERRIDE:Status_Code_:\'\'),mode_s_code(OVERRIDE:Transponder_Code_:\'\'),fract_owner(OVERRIDE:Fractional_Owner_:\'\'),aircraft_mfr_name(OVERRIDE:Manufacturer_Name_:\'\'),model_name(OVERRIDE:Model_Name_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault,Lookup,TRIM((STRING)LEFT.n_number) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_FAA__key_aircraft_linkids_Vault_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault'));
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),n_number(OVERRIDE:N_Number_:\'\'),serial_number(OVERRIDE:Serial_Number_:\'\'),mfr_mdl_code(OVERRIDE:Manufacturer_Model_Code_:\'\'),eng_mfr_mdl(OVERRIDE:Engine_Manufacturer_Model_Code_:\'\'),year_mfr(OVERRIDE:Year_Manufactured_:0),last_action_date(OVERRIDE:Last_Action_Date_:DATE),type_aircraft(OVERRIDE:Type_:0),type_engine(OVERRIDE:Type_Engine_:\'\'),status_code(OVERRIDE:Status_Code_:\'\'),mode_s_code(OVERRIDE:Transponder_Code_:\'\'),fract_owner(OVERRIDE:Fractional_Owner_:\'\'),aircraft_mfr_name(OVERRIDE:Manufacturer_Name_:\'\'),model_name(OVERRIDE:Model_Name_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault,Lookup,TRIM((STRING)LEFT.n_number) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_FCRA_FAA__Key_Aircraft_Id_vault_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Ownership_Status_Layout := RECORD
    KEL.typ.nstr Status_Code_;
    KEL.typ.nstr Fractional_Owner_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Last_Action_Date_Layout := RECORD
    KEL.typ.nkdate Last_Action_Date_;
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
    KEL.typ.nstr N_Number_;
    KEL.typ.nstr Serial_Number_;
    KEL.typ.nstr Manufacturer_Model_Code_;
    KEL.typ.nstr Engine_Manufacturer_Model_Code_;
    KEL.typ.nint Year_Manufactured_;
    KEL.typ.nint Type_;
    KEL.typ.nstr Type_Engine_;
    KEL.typ.nstr Manufacturer_Name_;
    KEL.typ.nstr Model_Name_;
    KEL.typ.nstr Transponder_Code_;
    KEL.typ.ndataset(Ownership_Status_Layout) Ownership_Status_;
    KEL.typ.ndataset(Last_Action_Date_Layout) Last_Action_Date_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Aircraft_Group := __PostFilter;
  Layout Aircraft__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.N_Number_ := KEL.Intake.SingleValue(__recs,N_Number_);
    SELF.Serial_Number_ := KEL.Intake.SingleValue(__recs,Serial_Number_);
    SELF.Manufacturer_Model_Code_ := KEL.Intake.SingleValue(__recs,Manufacturer_Model_Code_);
    SELF.Engine_Manufacturer_Model_Code_ := KEL.Intake.SingleValue(__recs,Engine_Manufacturer_Model_Code_);
    SELF.Year_Manufactured_ := KEL.Intake.SingleValue(__recs,Year_Manufactured_);
    SELF.Type_ := KEL.Intake.SingleValue(__recs,Type_);
    SELF.Type_Engine_ := KEL.Intake.SingleValue(__recs,Type_Engine_);
    SELF.Manufacturer_Name_ := KEL.Intake.SingleValue(__recs,Manufacturer_Name_);
    SELF.Model_Name_ := KEL.Intake.SingleValue(__recs,Model_Name_);
    SELF.Transponder_Code_ := KEL.Intake.SingleValue(__recs,Transponder_Code_);
    SELF.Ownership_Status_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Status_Code_,Fractional_Owner_},Status_Code_,Fractional_Owner_),Ownership_Status_Layout)(__NN(Status_Code_) OR __NN(Fractional_Owner_)));
    SELF.Last_Action_Date_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Last_Action_Date_},Last_Action_Date_),Last_Action_Date_Layout)(__NN(Last_Action_Date_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Aircraft__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Ownership_Status_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Ownership_Status_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Status_Code_) OR __NN(Fractional_Owner_)));
    SELF.Last_Action_Date_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Last_Action_Date_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Last_Action_Date_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Aircraft_Group,COUNT(ROWS(LEFT))=1),GROUP,Aircraft__Single_Rollup(LEFT)) + ROLLUP(HAVING(Aircraft_Group,COUNT(ROWS(LEFT))>1),GROUP,Aircraft__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT N_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,N_Number_);
  EXPORT Serial_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Serial_Number_);
  EXPORT Manufacturer_Model_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Manufacturer_Model_Code_);
  EXPORT Engine_Manufacturer_Model_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Engine_Manufacturer_Model_Code_);
  EXPORT Year_Manufactured__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Year_Manufactured_);
  EXPORT Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Type_);
  EXPORT Type_Engine__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Type_Engine_);
  EXPORT Manufacturer_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Manufacturer_Name_);
  EXPORT Model_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Model_Name_);
  EXPORT Transponder_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Transponder_Code_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_FAA__Key_Aircraft_Id_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_FAA__key_aircraft_linkids_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_FAA__Key_Aircraft_Id_vault_Invalid),COUNT(N_Number__SingleValue_Invalid),COUNT(Serial_Number__SingleValue_Invalid),COUNT(Manufacturer_Model_Code__SingleValue_Invalid),COUNT(Engine_Manufacturer_Model_Code__SingleValue_Invalid),COUNT(Year_Manufactured__SingleValue_Invalid),COUNT(Type__SingleValue_Invalid),COUNT(Type_Engine__SingleValue_Invalid),COUNT(Manufacturer_Name__SingleValue_Invalid),COUNT(Model_Name__SingleValue_Invalid),COUNT(Transponder_Code__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_FAA__Key_Aircraft_Id_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_FAA__key_aircraft_linkids_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_FAA__Key_Aircraft_Id_vault_Invalid,KEL.typ.int N_Number__SingleValue_Invalid,KEL.typ.int Serial_Number__SingleValue_Invalid,KEL.typ.int Manufacturer_Model_Code__SingleValue_Invalid,KEL.typ.int Engine_Manufacturer_Model_Code__SingleValue_Invalid,KEL.typ.int Year_Manufactured__SingleValue_Invalid,KEL.typ.int Type__SingleValue_Invalid,KEL.typ.int Type_Engine__SingleValue_Invalid,KEL.typ.int Manufacturer_Name__SingleValue_Invalid,KEL.typ.int Model_Name__SingleValue_Invalid,KEL.typ.int Transponder_Code__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_FAA__Key_Aircraft_Id_Vault_Invalid),COUNT(__d0)},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','n_number',COUNT(__d0(__NL(N_Number_))),COUNT(__d0(__NN(N_Number_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','serial_number',COUNT(__d0(__NL(Serial_Number_))),COUNT(__d0(__NN(Serial_Number_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','mfr_mdl_code',COUNT(__d0(__NL(Manufacturer_Model_Code_))),COUNT(__d0(__NN(Manufacturer_Model_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','eng_mfr_mdl',COUNT(__d0(__NL(Engine_Manufacturer_Model_Code_))),COUNT(__d0(__NN(Engine_Manufacturer_Model_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','year_mfr',COUNT(__d0(__NL(Year_Manufactured_))),COUNT(__d0(__NN(Year_Manufactured_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','last_action_date',COUNT(__d0(__NL(Last_Action_Date_))),COUNT(__d0(__NN(Last_Action_Date_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','type_aircraft',COUNT(__d0(__NL(Type_))),COUNT(__d0(__NN(Type_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','type_engine',COUNT(__d0(__NL(Type_Engine_))),COUNT(__d0(__NN(Type_Engine_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','status_code',COUNT(__d0(__NL(Status_Code_))),COUNT(__d0(__NN(Status_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','mode_s_code',COUNT(__d0(__NL(Transponder_Code_))),COUNT(__d0(__NN(Transponder_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','fract_owner',COUNT(__d0(__NL(Fractional_Owner_))),COUNT(__d0(__NN(Fractional_Owner_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','aircraft_mfr_name',COUNT(__d0(__NL(Manufacturer_Name_))),COUNT(__d0(__NN(Manufacturer_Name_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','model_name',COUNT(__d0(__NL(Model_Name_))),COUNT(__d0(__NN(Model_Name_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_FAA__key_aircraft_linkids_Vault_Invalid),COUNT(__d1)},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','n_number',COUNT(__d1(__NL(N_Number_))),COUNT(__d1(__NN(N_Number_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','serial_number',COUNT(__d1(__NL(Serial_Number_))),COUNT(__d1(__NN(Serial_Number_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','mfr_mdl_code',COUNT(__d1(__NL(Manufacturer_Model_Code_))),COUNT(__d1(__NN(Manufacturer_Model_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','eng_mfr_mdl',COUNT(__d1(__NL(Engine_Manufacturer_Model_Code_))),COUNT(__d1(__NN(Engine_Manufacturer_Model_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','year_mfr',COUNT(__d1(__NL(Year_Manufactured_))),COUNT(__d1(__NN(Year_Manufactured_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','last_action_date',COUNT(__d1(__NL(Last_Action_Date_))),COUNT(__d1(__NN(Last_Action_Date_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','type_aircraft',COUNT(__d1(__NL(Type_))),COUNT(__d1(__NN(Type_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','type_engine',COUNT(__d1(__NL(Type_Engine_))),COUNT(__d1(__NN(Type_Engine_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','status_code',COUNT(__d1(__NL(Status_Code_))),COUNT(__d1(__NN(Status_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','mode_s_code',COUNT(__d1(__NL(Transponder_Code_))),COUNT(__d1(__NN(Transponder_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','fract_owner',COUNT(__d1(__NL(Fractional_Owner_))),COUNT(__d1(__NN(Fractional_Owner_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','aircraft_mfr_name',COUNT(__d1(__NL(Manufacturer_Name_))),COUNT(__d1(__NN(Manufacturer_Name_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','model_name',COUNT(__d1(__NL(Model_Name_))),COUNT(__d1(__NN(Model_Name_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.NonFCRA.FAA__key_aircraft_linkids_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_FAA__Key_Aircraft_Id_vault_Invalid),COUNT(__d2)},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','n_number',COUNT(__d2(__NL(N_Number_))),COUNT(__d2(__NN(N_Number_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','serial_number',COUNT(__d2(__NL(Serial_Number_))),COUNT(__d2(__NN(Serial_Number_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','mfr_mdl_code',COUNT(__d2(__NL(Manufacturer_Model_Code_))),COUNT(__d2(__NN(Manufacturer_Model_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','eng_mfr_mdl',COUNT(__d2(__NL(Engine_Manufacturer_Model_Code_))),COUNT(__d2(__NN(Engine_Manufacturer_Model_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','year_mfr',COUNT(__d2(__NL(Year_Manufactured_))),COUNT(__d2(__NN(Year_Manufactured_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','last_action_date',COUNT(__d2(__NL(Last_Action_Date_))),COUNT(__d2(__NN(Last_Action_Date_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','type_aircraft',COUNT(__d2(__NL(Type_))),COUNT(__d2(__NN(Type_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','type_engine',COUNT(__d2(__NL(Type_Engine_))),COUNT(__d2(__NN(Type_Engine_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','status_code',COUNT(__d2(__NL(Status_Code_))),COUNT(__d2(__NN(Status_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','mode_s_code',COUNT(__d2(__NL(Transponder_Code_))),COUNT(__d2(__NN(Transponder_Code_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','fract_owner',COUNT(__d2(__NL(Fractional_Owner_))),COUNT(__d2(__NN(Fractional_Owner_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','aircraft_mfr_name',COUNT(__d2(__NL(Manufacturer_Name_))),COUNT(__d2(__NN(Manufacturer_Name_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','model_name',COUNT(__d2(__NL(Model_Name_))),COUNT(__d2(__NN(Model_Name_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Aircraft','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
