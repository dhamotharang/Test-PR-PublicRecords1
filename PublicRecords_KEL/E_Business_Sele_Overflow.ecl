//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Business_Sele_Overflow(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr E_B_R_Number_;
    KEL.typ.nint E_F_X_Number_;
    KEL.typ.nstr D_U_N_S_Number_;
    KEL.typ.nstr S_O_S_Key_;
    KEL.typ.nstr S_O_S_Entity_Description_;
    KEL.typ.nstr S_O_S_Name_Type_Description_;
    KEL.typ.nkdate S_O_S_Process_Date_;
    KEL.typ.nstr S_O_S_Status_Code_;
    KEL.typ.nstr S_O_S_Status_Description_;
    KEL.typ.nkdate S_O_S_Status_Date_;
    KEL.typ.nstr S_O_S_Incorporation_State_;
    KEL.typ.nkdate S_O_S_Incorporation_Date_;
    KEL.typ.nstr S_O_S_Foreign_State_Code_;
    KEL.typ.nkdate S_O_S_Foreign_State_Date_;
    KEL.typ.nstr S_O_S_Foreign_Domestic_Indicator_;
    KEL.typ.nstr S_O_S_Original_Business_Type_Description_;
    KEL.typ.nstr S_O_S_Original_Org_Structure_Description_;
    KEL.typ.nstr S_O_S_Original_Charter_Number_;
    KEL.typ.nstr S_O_S_Term_Exist_Code_;
    KEL.typ.nstr S_O_S_Registered_Agent_Name_;
    KEL.typ.nkdate S_O_S_Registered_Agent_Effective_Date_;
    KEL.typ.nkdate S_O_S_Registered_Agent_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Registered_Agent_Date_Last_Seen_;
    KEL.typ.nstr S_O_S_Code_;
    KEL.typ.nstr Filing___Code_;
    KEL.typ.nstr Registration_Status_;
    KEL.typ.nstr Registration_Status_Description_;
    KEL.typ.nkdate E_B_R_Process_Date_;
    KEL.typ.nkdate Retirement_Plan_Begin_Date_;
    KEL.typ.nkdate Retirement_Plan_Effective_Date_;
    KEL.typ.nstr Retirement_Plan_Entity_Indicator_;
    KEL.typ.nint Retirement_Total_Participants_;
    KEL.typ.nint Retirement_Total_Active_Participants_;
    KEL.typ.nint Retirement_Participant_Receiving_Count_;
    KEL.typ.nint Retirement_Participant_Future_Count_;
    KEL.typ.nint Retirement_Receiving_Benefit_Count_;
    KEL.typ.nint Retirement_Participant_Account_Balance_Count_;
    KEL.typ.nint Retirement_Participant_Partially_Vested_Count_;
    KEL.typ.nint Retirement_Plan_Pension_Benefit_I_D_;
    KEL.typ.nint Retirement_Plan_Welfare_Benefit_Indicator_;
    KEL.typ.nstr Gov_Debarred_Classification_;
    KEL.typ.nstr Gov_Debarred_Exclusion_Program_;
    KEL.typ.nstr Gov_Debarred_Exclusion_Type_;
    KEL.typ.nstr Gov_Debarred_Excluding_Agency_;
    KEL.typ.nkdate Gov_Debarred_Active_Date_;
    KEL.typ.nstr Gov_Debarred_Termination_Date_;
    KEL.typ.nbool Header_Hit_Flag_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),ebrnumber(DEFAULT:E_B_R_Number_:\'\'),efxnumber(DEFAULT:E_F_X_Number_:0),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),soskey(DEFAULT:S_O_S_Key_:\'\'),sosentitydescription(DEFAULT:S_O_S_Entity_Description_:\'\'),sosnametypedescription(DEFAULT:S_O_S_Name_Type_Description_:\'\'),sosprocessdate(DEFAULT:S_O_S_Process_Date_:DATE),sosstatuscode(DEFAULT:S_O_S_Status_Code_:\'\'),sosstatusdescription(DEFAULT:S_O_S_Status_Description_:\'\'),sosstatusdate(DEFAULT:S_O_S_Status_Date_:DATE),sosincorporationstate(DEFAULT:S_O_S_Incorporation_State_:\'\'),sosincorporationdate(DEFAULT:S_O_S_Incorporation_Date_:DATE),sosforeignstatecode(DEFAULT:S_O_S_Foreign_State_Code_:\'\'),sosforeignstatedate(DEFAULT:S_O_S_Foreign_State_Date_:DATE),sosforeigndomesticindicator(DEFAULT:S_O_S_Foreign_Domestic_Indicator_:\'\'),sosoriginalbusinesstypedescription(DEFAULT:S_O_S_Original_Business_Type_Description_:\'\'),sosoriginalorgstructuredescription(DEFAULT:S_O_S_Original_Org_Structure_Description_:\'\'),sosoriginalcharternumber(DEFAULT:S_O_S_Original_Charter_Number_:\'\'),sostermexistcode(DEFAULT:S_O_S_Term_Exist_Code_:\'\'),sosregisteredagentname(DEFAULT:S_O_S_Registered_Agent_Name_:\'\'),sosregisteredagenteffectivedate(DEFAULT:S_O_S_Registered_Agent_Effective_Date_:DATE),sosregisteredagentdatefirstseen(DEFAULT:S_O_S_Registered_Agent_Date_First_Seen_:DATE),sosregisteredagentdatelastseen(DEFAULT:S_O_S_Registered_Agent_Date_Last_Seen_:DATE),soscode(DEFAULT:S_O_S_Code_:\'\'),filing_code(DEFAULT:Filing___Code_:\'\'),registrationstatus(DEFAULT:Registration_Status_:\'\'),registrationstatusdescription(DEFAULT:Registration_Status_Description_:\'\'),ebrprocessdate(DEFAULT:E_B_R_Process_Date_:DATE),retirementplanbegindate(DEFAULT:Retirement_Plan_Begin_Date_:DATE),retirementplaneffectivedate(DEFAULT:Retirement_Plan_Effective_Date_:DATE),retirementplanentityindicator(DEFAULT:Retirement_Plan_Entity_Indicator_:\'\'),retirementtotalparticipants(DEFAULT:Retirement_Total_Participants_:\'\'),retirementtotalactiveparticipants(DEFAULT:Retirement_Total_Active_Participants_:\'\'),retirementparticipantreceivingcount(DEFAULT:Retirement_Participant_Receiving_Count_:\'\'),retirementparticipantfuturecount(DEFAULT:Retirement_Participant_Future_Count_:\'\'),retirementreceivingbenefitcount(DEFAULT:Retirement_Receiving_Benefit_Count_:\'\'),retirementparticipantaccountbalancecount(DEFAULT:Retirement_Participant_Account_Balance_Count_:\'\'),retirementparticipantpartiallyvestedcount(DEFAULT:Retirement_Participant_Partially_Vested_Count_:\'\'),retirementplanpensionbenefitid(DEFAULT:Retirement_Plan_Pension_Benefit_I_D_:\'\'),retirementplanwelfarebenefitindicator(DEFAULT:Retirement_Plan_Welfare_Benefit_Indicator_:\'\'),govdebarredclassification(DEFAULT:Gov_Debarred_Classification_:\'\'),govdebarredexclusionprogram(DEFAULT:Gov_Debarred_Exclusion_Program_:\'\'),govdebarredexclusiontype(DEFAULT:Gov_Debarred_Exclusion_Type_:\'\'),govdebarredexcludingagency(DEFAULT:Gov_Debarred_Excluding_Agency_:\'\'),govdebarredactivedate(DEFAULT:Gov_Debarred_Active_Date_:DATE),govdebarredterminationdate(DEFAULT:Gov_Debarred_Termination_Date_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid)));
  SHARED __d1_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid)));
  SHARED __d2_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid)));
  SHARED __d3_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid)));
  SHARED __d4_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid)));
  SHARED __d5_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid)));
  SHARED __d6_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim + __d4_Trim + __d5_Trim + __d6_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)0) + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)0);
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Business_Sele_Overflow::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Business_Sele_Overflow');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Business_Sele_Overflow');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),ebr_file_number(OVERRIDE:E_B_R_Number_:\'\'),efxnumber(DEFAULT:E_F_X_Number_:0),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),soskey(DEFAULT:S_O_S_Key_:\'\'),sosentitydescription(DEFAULT:S_O_S_Entity_Description_:\'\'),sosnametypedescription(DEFAULT:S_O_S_Name_Type_Description_:\'\'),sosprocessdate(DEFAULT:S_O_S_Process_Date_:DATE),sosstatuscode(DEFAULT:S_O_S_Status_Code_:\'\'),sosstatusdescription(DEFAULT:S_O_S_Status_Description_:\'\'),sosstatusdate(DEFAULT:S_O_S_Status_Date_:DATE),sosincorporationstate(DEFAULT:S_O_S_Incorporation_State_:\'\'),sosincorporationdate(DEFAULT:S_O_S_Incorporation_Date_:DATE),sosforeignstatecode(DEFAULT:S_O_S_Foreign_State_Code_:\'\'),sosforeignstatedate(DEFAULT:S_O_S_Foreign_State_Date_:DATE),sosforeigndomesticindicator(DEFAULT:S_O_S_Foreign_Domestic_Indicator_:\'\'),sosoriginalbusinesstypedescription(DEFAULT:S_O_S_Original_Business_Type_Description_:\'\'),sosoriginalorgstructuredescription(DEFAULT:S_O_S_Original_Org_Structure_Description_:\'\'),sosoriginalcharternumber(DEFAULT:S_O_S_Original_Charter_Number_:\'\'),sostermexistcode(DEFAULT:S_O_S_Term_Exist_Code_:\'\'),sosregisteredagentname(DEFAULT:S_O_S_Registered_Agent_Name_:\'\'),sosregisteredagenteffectivedate(DEFAULT:S_O_S_Registered_Agent_Effective_Date_:DATE),sosregisteredagentdatefirstseen(DEFAULT:S_O_S_Registered_Agent_Date_First_Seen_:DATE),sosregisteredagentdatelastseen(DEFAULT:S_O_S_Registered_Agent_Date_Last_Seen_:DATE),soscode(DEFAULT:S_O_S_Code_:\'\'),filing_code(DEFAULT:Filing___Code_:\'\'),registrationstatus(DEFAULT:Registration_Status_:\'\'),registrationstatusdescription(DEFAULT:Registration_Status_Description_:\'\'),ebrprocessdate(DEFAULT:E_B_R_Process_Date_:DATE),retirementplanbegindate(DEFAULT:Retirement_Plan_Begin_Date_:DATE),retirementplaneffectivedate(DEFAULT:Retirement_Plan_Effective_Date_:DATE),retirementplanentityindicator(DEFAULT:Retirement_Plan_Entity_Indicator_:\'\'),retirementtotalparticipants(DEFAULT:Retirement_Total_Participants_:\'\'),retirementtotalactiveparticipants(DEFAULT:Retirement_Total_Active_Participants_:\'\'),retirementparticipantreceivingcount(DEFAULT:Retirement_Participant_Receiving_Count_:\'\'),retirementparticipantfuturecount(DEFAULT:Retirement_Participant_Future_Count_:\'\'),retirementreceivingbenefitcount(DEFAULT:Retirement_Receiving_Benefit_Count_:\'\'),retirementparticipantaccountbalancecount(DEFAULT:Retirement_Participant_Account_Balance_Count_:\'\'),retirementparticipantpartiallyvestedcount(DEFAULT:Retirement_Participant_Partially_Vested_Count_:\'\'),retirementplanpensionbenefitid(DEFAULT:Retirement_Plan_Pension_Benefit_I_D_:\'\'),retirementplanwelfarebenefitindicator(DEFAULT:Retirement_Plan_Welfare_Benefit_Indicator_:\'\'),govdebarredclassification(DEFAULT:Gov_Debarred_Classification_:\'\'),govdebarredexclusionprogram(DEFAULT:Gov_Debarred_Exclusion_Program_:\'\'),govdebarredexclusiontype(DEFAULT:Gov_Debarred_Exclusion_Type_:\'\'),govdebarredexcludingagency(DEFAULT:Gov_Debarred_Excluding_Agency_:\'\'),govdebarredactivedate(DEFAULT:Gov_Debarred_Active_Date_:DATE),govdebarredterminationdate(DEFAULT:Gov_Debarred_Termination_Date_:\'\'),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_BIPV2__Key_BH_Linking_Ids_Vault__Key_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key'),__Mapping0_Transform(LEFT)));
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),ebrnumber(DEFAULT:E_B_R_Number_:\'\'),efxnumber(DEFAULT:E_F_X_Number_:0),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),soskey(DEFAULT:S_O_S_Key_:\'\'),sosentitydescription(DEFAULT:S_O_S_Entity_Description_:\'\'),sosnametypedescription(DEFAULT:S_O_S_Name_Type_Description_:\'\'),sosprocessdate(DEFAULT:S_O_S_Process_Date_:DATE),sosstatuscode(DEFAULT:S_O_S_Status_Code_:\'\'),sosstatusdescription(DEFAULT:S_O_S_Status_Description_:\'\'),sosstatusdate(DEFAULT:S_O_S_Status_Date_:DATE),sosincorporationstate(DEFAULT:S_O_S_Incorporation_State_:\'\'),sosincorporationdate(DEFAULT:S_O_S_Incorporation_Date_:DATE),sosforeignstatecode(DEFAULT:S_O_S_Foreign_State_Code_:\'\'),sosforeignstatedate(DEFAULT:S_O_S_Foreign_State_Date_:DATE),sosforeigndomesticindicator(DEFAULT:S_O_S_Foreign_Domestic_Indicator_:\'\'),sosoriginalbusinesstypedescription(DEFAULT:S_O_S_Original_Business_Type_Description_:\'\'),sosoriginalorgstructuredescription(DEFAULT:S_O_S_Original_Org_Structure_Description_:\'\'),sosoriginalcharternumber(DEFAULT:S_O_S_Original_Charter_Number_:\'\'),sostermexistcode(DEFAULT:S_O_S_Term_Exist_Code_:\'\'),sosregisteredagentname(DEFAULT:S_O_S_Registered_Agent_Name_:\'\'),sosregisteredagenteffectivedate(DEFAULT:S_O_S_Registered_Agent_Effective_Date_:DATE),sosregisteredagentdatefirstseen(DEFAULT:S_O_S_Registered_Agent_Date_First_Seen_:DATE),sosregisteredagentdatelastseen(DEFAULT:S_O_S_Registered_Agent_Date_Last_Seen_:DATE),rawfields.sos_code(OVERRIDE:S_O_S_Code_:\'\'),rawfields.filing_cod(OVERRIDE:Filing___Code_:\'\'),rawfields.status(OVERRIDE:Registration_Status_:\'\'),rawfields.stat_des(OVERRIDE:Registration_Status_Description_:\'\'),ebrprocessdate(DEFAULT:E_B_R_Process_Date_:DATE),retirementplanbegindate(DEFAULT:Retirement_Plan_Begin_Date_:DATE),retirementplaneffectivedate(DEFAULT:Retirement_Plan_Effective_Date_:DATE),retirementplanentityindicator(DEFAULT:Retirement_Plan_Entity_Indicator_:\'\'),retirementtotalparticipants(DEFAULT:Retirement_Total_Participants_:\'\'),retirementtotalactiveparticipants(DEFAULT:Retirement_Total_Active_Participants_:\'\'),retirementparticipantreceivingcount(DEFAULT:Retirement_Participant_Receiving_Count_:\'\'),retirementparticipantfuturecount(DEFAULT:Retirement_Participant_Future_Count_:\'\'),retirementreceivingbenefitcount(DEFAULT:Retirement_Receiving_Benefit_Count_:\'\'),retirementparticipantaccountbalancecount(DEFAULT:Retirement_Participant_Account_Balance_Count_:\'\'),retirementparticipantpartiallyvestedcount(DEFAULT:Retirement_Participant_Partially_Vested_Count_:\'\'),retirementplanpensionbenefitid(DEFAULT:Retirement_Plan_Pension_Benefit_I_D_:\'\'),retirementplanwelfarebenefitindicator(DEFAULT:Retirement_Plan_Welfare_Benefit_Indicator_:\'\'),govdebarredclassification(DEFAULT:Gov_Debarred_Classification_:\'\'),govdebarredexclusionprogram(DEFAULT:Gov_Debarred_Exclusion_Program_:\'\'),govdebarredexclusiontype(DEFAULT:Gov_Debarred_Exclusion_Type_:\'\'),govdebarredexcludingagency(DEFAULT:Gov_Debarred_Excluding_Agency_:\'\'),govdebarredactivedate(DEFAULT:Gov_Debarred_Active_Date_:DATE),govdebarredterminationdate(DEFAULT:Gov_Debarred_Termination_Date_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_BusReg__Key_BusReg_Company_LinkIds_Vault_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault'));
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),file_number(OVERRIDE:E_B_R_Number_:\'\'),efxnumber(DEFAULT:E_F_X_Number_:0),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),soskey(DEFAULT:S_O_S_Key_:\'\'),sosentitydescription(DEFAULT:S_O_S_Entity_Description_:\'\'),sosnametypedescription(DEFAULT:S_O_S_Name_Type_Description_:\'\'),sosprocessdate(DEFAULT:S_O_S_Process_Date_:DATE),sosstatuscode(DEFAULT:S_O_S_Status_Code_:\'\'),sosstatusdescription(DEFAULT:S_O_S_Status_Description_:\'\'),sosstatusdate(DEFAULT:S_O_S_Status_Date_:DATE),sosincorporationstate(DEFAULT:S_O_S_Incorporation_State_:\'\'),sosincorporationdate(DEFAULT:S_O_S_Incorporation_Date_:DATE),sosforeignstatecode(DEFAULT:S_O_S_Foreign_State_Code_:\'\'),sosforeignstatedate(DEFAULT:S_O_S_Foreign_State_Date_:DATE),sosforeigndomesticindicator(DEFAULT:S_O_S_Foreign_Domestic_Indicator_:\'\'),sosoriginalbusinesstypedescription(DEFAULT:S_O_S_Original_Business_Type_Description_:\'\'),sosoriginalorgstructuredescription(DEFAULT:S_O_S_Original_Org_Structure_Description_:\'\'),sosoriginalcharternumber(DEFAULT:S_O_S_Original_Charter_Number_:\'\'),sostermexistcode(DEFAULT:S_O_S_Term_Exist_Code_:\'\'),sosregisteredagentname(DEFAULT:S_O_S_Registered_Agent_Name_:\'\'),sosregisteredagenteffectivedate(DEFAULT:S_O_S_Registered_Agent_Effective_Date_:DATE),sosregisteredagentdatefirstseen(DEFAULT:S_O_S_Registered_Agent_Date_First_Seen_:DATE),sosregisteredagentdatelastseen(DEFAULT:S_O_S_Registered_Agent_Date_Last_Seen_:DATE),soscode(DEFAULT:S_O_S_Code_:\'\'),filing_code(DEFAULT:Filing___Code_:\'\'),registrationstatus(DEFAULT:Registration_Status_:\'\'),registrationstatusdescription(DEFAULT:Registration_Status_Description_:\'\'),process_date(OVERRIDE:E_B_R_Process_Date_:DATE),retirementplanbegindate(DEFAULT:Retirement_Plan_Begin_Date_:DATE),retirementplaneffectivedate(DEFAULT:Retirement_Plan_Effective_Date_:DATE),retirementplanentityindicator(DEFAULT:Retirement_Plan_Entity_Indicator_:\'\'),retirementtotalparticipants(DEFAULT:Retirement_Total_Participants_:\'\'),retirementtotalactiveparticipants(DEFAULT:Retirement_Total_Active_Participants_:\'\'),retirementparticipantreceivingcount(DEFAULT:Retirement_Participant_Receiving_Count_:\'\'),retirementparticipantfuturecount(DEFAULT:Retirement_Participant_Future_Count_:\'\'),retirementreceivingbenefitcount(DEFAULT:Retirement_Receiving_Benefit_Count_:\'\'),retirementparticipantaccountbalancecount(DEFAULT:Retirement_Participant_Account_Balance_Count_:\'\'),retirementparticipantpartiallyvestedcount(DEFAULT:Retirement_Participant_Partially_Vested_Count_:\'\'),retirementplanpensionbenefitid(DEFAULT:Retirement_Plan_Pension_Benefit_I_D_:\'\'),retirementplanwelfarebenefitindicator(DEFAULT:Retirement_Plan_Welfare_Benefit_Indicator_:\'\'),govdebarredclassification(DEFAULT:Gov_Debarred_Classification_:\'\'),govdebarredexclusionprogram(DEFAULT:Gov_Debarred_Exclusion_Program_:\'\'),govdebarredexclusiontype(DEFAULT:Gov_Debarred_Exclusion_Type_:\'\'),govdebarredexcludingagency(DEFAULT:Gov_Debarred_Excluding_Agency_:\'\'),govdebarredactivedate(DEFAULT:Gov_Debarred_Active_Date_:DATE),govdebarredterminationdate(DEFAULT:Gov_Debarred_Termination_Date_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_EBR__Key_5600_Demographic_Data_LinkIds_Vault_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault'));
  SHARED Hybrid_Archive_Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),ebrnumber(DEFAULT:E_B_R_Number_:\'\'),efxnumber(DEFAULT:E_F_X_Number_:0),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),soskey(DEFAULT:S_O_S_Key_:\'\'),sosentitydescription(DEFAULT:S_O_S_Entity_Description_:\'\'),sosnametypedescription(DEFAULT:S_O_S_Name_Type_Description_:\'\'),sosprocessdate(DEFAULT:S_O_S_Process_Date_:DATE),sosstatuscode(DEFAULT:S_O_S_Status_Code_:\'\'),sosstatusdescription(DEFAULT:S_O_S_Status_Description_:\'\'),sosstatusdate(DEFAULT:S_O_S_Status_Date_:DATE),sosincorporationstate(DEFAULT:S_O_S_Incorporation_State_:\'\'),sosincorporationdate(DEFAULT:S_O_S_Incorporation_Date_:DATE),sosforeignstatecode(DEFAULT:S_O_S_Foreign_State_Code_:\'\'),sosforeignstatedate(DEFAULT:S_O_S_Foreign_State_Date_:DATE),sosforeigndomesticindicator(DEFAULT:S_O_S_Foreign_Domestic_Indicator_:\'\'),sosoriginalbusinesstypedescription(DEFAULT:S_O_S_Original_Business_Type_Description_:\'\'),sosoriginalorgstructuredescription(DEFAULT:S_O_S_Original_Org_Structure_Description_:\'\'),sosoriginalcharternumber(DEFAULT:S_O_S_Original_Charter_Number_:\'\'),sostermexistcode(DEFAULT:S_O_S_Term_Exist_Code_:\'\'),sosregisteredagentname(DEFAULT:S_O_S_Registered_Agent_Name_:\'\'),sosregisteredagenteffectivedate(DEFAULT:S_O_S_Registered_Agent_Effective_Date_:DATE),sosregisteredagentdatefirstseen(DEFAULT:S_O_S_Registered_Agent_Date_First_Seen_:DATE),sosregisteredagentdatelastseen(DEFAULT:S_O_S_Registered_Agent_Date_Last_Seen_:DATE),soscode(DEFAULT:S_O_S_Code_:\'\'),filing_code(DEFAULT:Filing___Code_:\'\'),registrationstatus(DEFAULT:Registration_Status_:\'\'),registrationstatusdescription(DEFAULT:Registration_Status_Description_:\'\'),ebrprocessdate(DEFAULT:E_B_R_Process_Date_:DATE),form_plan_year_begin_date(OVERRIDE:Retirement_Plan_Begin_Date_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),plan_eff_date(OVERRIDE:Retirement_Plan_Effective_Date_:DATE),type_plan_entity_ind(OVERRIDE:Retirement_Plan_Entity_Indicator_:\'\'),tot_partcp_boy_cnt(OVERRIDE:Retirement_Total_Participants_:\'\'),tot_active_partcp_cnt(OVERRIDE:Retirement_Total_Active_Participants_:\'\'),rtd_sep_partcp_rcvg_cnt(OVERRIDE:Retirement_Participant_Receiving_Count_:\'\'),rtd_sep_partcp_fut_cnt(OVERRIDE:Retirement_Participant_Future_Count_:\'\'),benef_rcvg_bnft_cnt(OVERRIDE:Retirement_Receiving_Benefit_Count_:\'\'),partcp_account_bal_cnt(OVERRIDE:Retirement_Participant_Account_Balance_Count_:\'\'),sep_partcp_partl_vstd_cnt(OVERRIDE:Retirement_Participant_Partially_Vested_Count_:\'\'),pension_benefit_plan_id(OVERRIDE:Retirement_Plan_Pension_Benefit_I_D_:\'\'),welfare_benefit_plan_ind(OVERRIDE:Retirement_Plan_Welfare_Benefit_Indicator_:\'\'),govdebarredclassification(DEFAULT:Gov_Debarred_Classification_:\'\'),govdebarredexclusionprogram(DEFAULT:Gov_Debarred_Exclusion_Program_:\'\'),govdebarredexclusiontype(DEFAULT:Gov_Debarred_Exclusion_Type_:\'\'),govdebarredexcludingagency(DEFAULT:Gov_Debarred_Excluding_Agency_:\'\'),govdebarredactivedate(DEFAULT:Gov_Debarred_Active_Date_:DATE),govdebarredterminationdate(DEFAULT:Gov_Debarred_Termination_Date_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_IRS5500__Key_LinkIds_Vault_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault'));
  SHARED Hybrid_Archive_Date_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping4 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),ebrnumber(DEFAULT:E_B_R_Number_:\'\'),efxnumber(DEFAULT:E_F_X_Number_:0),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),soskey(DEFAULT:S_O_S_Key_:\'\'),sosentitydescription(DEFAULT:S_O_S_Entity_Description_:\'\'),sosnametypedescription(DEFAULT:S_O_S_Name_Type_Description_:\'\'),sosprocessdate(DEFAULT:S_O_S_Process_Date_:DATE),sosstatuscode(DEFAULT:S_O_S_Status_Code_:\'\'),sosstatusdescription(DEFAULT:S_O_S_Status_Description_:\'\'),sosstatusdate(DEFAULT:S_O_S_Status_Date_:DATE),sosincorporationstate(DEFAULT:S_O_S_Incorporation_State_:\'\'),sosincorporationdate(DEFAULT:S_O_S_Incorporation_Date_:DATE),sosforeignstatecode(DEFAULT:S_O_S_Foreign_State_Code_:\'\'),sosforeignstatedate(DEFAULT:S_O_S_Foreign_State_Date_:DATE),sosforeigndomesticindicator(DEFAULT:S_O_S_Foreign_Domestic_Indicator_:\'\'),sosoriginalbusinesstypedescription(DEFAULT:S_O_S_Original_Business_Type_Description_:\'\'),sosoriginalorgstructuredescription(DEFAULT:S_O_S_Original_Org_Structure_Description_:\'\'),sosoriginalcharternumber(DEFAULT:S_O_S_Original_Charter_Number_:\'\'),sostermexistcode(DEFAULT:S_O_S_Term_Exist_Code_:\'\'),sosregisteredagentname(DEFAULT:S_O_S_Registered_Agent_Name_:\'\'),sosregisteredagenteffectivedate(DEFAULT:S_O_S_Registered_Agent_Effective_Date_:DATE),sosregisteredagentdatefirstseen(DEFAULT:S_O_S_Registered_Agent_Date_First_Seen_:DATE),sosregisteredagentdatelastseen(DEFAULT:S_O_S_Registered_Agent_Date_Last_Seen_:DATE),soscode(DEFAULT:S_O_S_Code_:\'\'),filing_code(DEFAULT:Filing___Code_:\'\'),registrationstatus(DEFAULT:Registration_Status_:\'\'),registrationstatusdescription(DEFAULT:Registration_Status_Description_:\'\'),ebrprocessdate(DEFAULT:E_B_R_Process_Date_:DATE),retirementplanbegindate(DEFAULT:Retirement_Plan_Begin_Date_:DATE),retirementplaneffectivedate(DEFAULT:Retirement_Plan_Effective_Date_:DATE),retirementplanentityindicator(DEFAULT:Retirement_Plan_Entity_Indicator_:\'\'),retirementtotalparticipants(DEFAULT:Retirement_Total_Participants_:\'\'),retirementtotalactiveparticipants(DEFAULT:Retirement_Total_Active_Participants_:\'\'),retirementparticipantreceivingcount(DEFAULT:Retirement_Participant_Receiving_Count_:\'\'),retirementparticipantfuturecount(DEFAULT:Retirement_Participant_Future_Count_:\'\'),retirementreceivingbenefitcount(DEFAULT:Retirement_Receiving_Benefit_Count_:\'\'),retirementparticipantaccountbalancecount(DEFAULT:Retirement_Participant_Account_Balance_Count_:\'\'),retirementparticipantpartiallyvestedcount(DEFAULT:Retirement_Participant_Partially_Vested_Count_:\'\'),retirementplanpensionbenefitid(DEFAULT:Retirement_Plan_Pension_Benefit_I_D_:\'\'),retirementplanwelfarebenefitindicator(DEFAULT:Retirement_Plan_Welfare_Benefit_Indicator_:\'\'),classification(OVERRIDE:Gov_Debarred_Classification_:\'\'),exclusionprogram(OVERRIDE:Gov_Debarred_Exclusion_Program_:\'\'),exclusiontype(OVERRIDE:Gov_Debarred_Exclusion_Type_:\'\'),excludingagency(OVERRIDE:Gov_Debarred_Excluding_Agency_:\'\'),activedate(OVERRIDE:Gov_Debarred_Active_Date_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),terminationdate(OVERRIDE:Gov_Debarred_Termination_Date_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_4Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d4_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d4_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_SAM__Key_LinkId_Vault_Invalid := __d4_UID_Mapped(UID = 0);
  SHARED __d4_Prefiltered := __d4_UID_Mapped(UID <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault'));
  SHARED Hybrid_Archive_Date_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping5 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),ebrnumber(DEFAULT:E_B_R_Number_:\'\'),efx_id(OVERRIDE:E_F_X_Number_:0),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),soskey(DEFAULT:S_O_S_Key_:\'\'),sosentitydescription(DEFAULT:S_O_S_Entity_Description_:\'\'),sosnametypedescription(DEFAULT:S_O_S_Name_Type_Description_:\'\'),sosprocessdate(DEFAULT:S_O_S_Process_Date_:DATE),sosstatuscode(DEFAULT:S_O_S_Status_Code_:\'\'),sosstatusdescription(DEFAULT:S_O_S_Status_Description_:\'\'),sosstatusdate(DEFAULT:S_O_S_Status_Date_:DATE),sosincorporationstate(DEFAULT:S_O_S_Incorporation_State_:\'\'),sosincorporationdate(DEFAULT:S_O_S_Incorporation_Date_:DATE),sosforeignstatecode(DEFAULT:S_O_S_Foreign_State_Code_:\'\'),sosforeignstatedate(DEFAULT:S_O_S_Foreign_State_Date_:DATE),sosforeigndomesticindicator(DEFAULT:S_O_S_Foreign_Domestic_Indicator_:\'\'),sosoriginalbusinesstypedescription(DEFAULT:S_O_S_Original_Business_Type_Description_:\'\'),sosoriginalorgstructuredescription(DEFAULT:S_O_S_Original_Org_Structure_Description_:\'\'),sosoriginalcharternumber(DEFAULT:S_O_S_Original_Charter_Number_:\'\'),sostermexistcode(DEFAULT:S_O_S_Term_Exist_Code_:\'\'),sosregisteredagentname(DEFAULT:S_O_S_Registered_Agent_Name_:\'\'),sosregisteredagenteffectivedate(DEFAULT:S_O_S_Registered_Agent_Effective_Date_:DATE),sosregisteredagentdatefirstseen(DEFAULT:S_O_S_Registered_Agent_Date_First_Seen_:DATE),sosregisteredagentdatelastseen(DEFAULT:S_O_S_Registered_Agent_Date_Last_Seen_:DATE),soscode(DEFAULT:S_O_S_Code_:\'\'),filing_code(DEFAULT:Filing___Code_:\'\'),registrationstatus(DEFAULT:Registration_Status_:\'\'),registrationstatusdescription(DEFAULT:Registration_Status_Description_:\'\'),ebrprocessdate(DEFAULT:E_B_R_Process_Date_:DATE),retirementplanbegindate(DEFAULT:Retirement_Plan_Begin_Date_:DATE),retirementplaneffectivedate(DEFAULT:Retirement_Plan_Effective_Date_:DATE),retirementplanentityindicator(DEFAULT:Retirement_Plan_Entity_Indicator_:\'\'),retirementtotalparticipants(DEFAULT:Retirement_Total_Participants_:\'\'),retirementtotalactiveparticipants(DEFAULT:Retirement_Total_Active_Participants_:\'\'),retirementparticipantreceivingcount(DEFAULT:Retirement_Participant_Receiving_Count_:\'\'),retirementparticipantfuturecount(DEFAULT:Retirement_Participant_Future_Count_:\'\'),retirementreceivingbenefitcount(DEFAULT:Retirement_Receiving_Benefit_Count_:\'\'),retirementparticipantaccountbalancecount(DEFAULT:Retirement_Participant_Account_Balance_Count_:\'\'),retirementparticipantpartiallyvestedcount(DEFAULT:Retirement_Participant_Partially_Vested_Count_:\'\'),retirementplanpensionbenefitid(DEFAULT:Retirement_Plan_Pension_Benefit_I_D_:\'\'),retirementplanwelfarebenefitindicator(DEFAULT:Retirement_Plan_Welfare_Benefit_Indicator_:\'\'),govdebarredclassification(DEFAULT:Gov_Debarred_Classification_:\'\'),govdebarredexclusionprogram(DEFAULT:Gov_Debarred_Exclusion_Program_:\'\'),govdebarredexclusiontype(DEFAULT:Gov_Debarred_Exclusion_Type_:\'\'),govdebarredexcludingagency(DEFAULT:Gov_Debarred_Excluding_Agency_:\'\'),govdebarredactivedate(DEFAULT:Gov_Debarred_Active_Date_:DATE),govdebarredterminationdate(DEFAULT:Gov_Debarred_Termination_Date_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_5Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d5_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d5_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Equifax_Business_Data__Key_LinkIds_Vault_Invalid := __d5_UID_Mapped(UID = 0);
  SHARED __d5_Prefiltered := __d5_UID_Mapped(UID <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault'));
  SHARED Hybrid_Archive_Date_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping6 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),ebrnumber(DEFAULT:E_B_R_Number_:\'\'),efxnumber(DEFAULT:E_F_X_Number_:0),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),corp_key(OVERRIDE:S_O_S_Key_:\'\'),corp_entity_desc(OVERRIDE:S_O_S_Entity_Description_:\'\'),corp_ln_name_type_desc(OVERRIDE:S_O_S_Name_Type_Description_:\'\'),corp_process_date(OVERRIDE:S_O_S_Process_Date_:DATE),corp_status_cd(OVERRIDE:S_O_S_Status_Code_:\'\'),corp_status_desc(OVERRIDE:S_O_S_Status_Description_:\'\'),corp_status_date(OVERRIDE:S_O_S_Status_Date_:DATE),corp_inc_state(OVERRIDE:S_O_S_Incorporation_State_:\'\'),corp_inc_date(OVERRIDE:S_O_S_Incorporation_Date_:DATE),corp_forgn_state_cd(OVERRIDE:S_O_S_Foreign_State_Code_:\'\'),corp_forgn_date(OVERRIDE:S_O_S_Foreign_State_Date_:DATE),corp_foreign_domestic_ind(OVERRIDE:S_O_S_Foreign_Domestic_Indicator_:\'\'),corp_orig_bus_type_desc(OVERRIDE:S_O_S_Original_Business_Type_Description_:\'\'),corp_orig_org_structure_desc(OVERRIDE:S_O_S_Original_Org_Structure_Description_:\'\'),corp_orig_sos_charter_nbr(OVERRIDE:S_O_S_Original_Charter_Number_:\'\'),corp_term_exist_cd(OVERRIDE:S_O_S_Term_Exist_Code_:\'\'),corp_ra_name(OVERRIDE:S_O_S_Registered_Agent_Name_:\'\'),corp_ra_effective_date(OVERRIDE:S_O_S_Registered_Agent_Effective_Date_:DATE),corp_ra_dt_first_seen(OVERRIDE:S_O_S_Registered_Agent_Date_First_Seen_:DATE),corp_ra_dt_last_seen(OVERRIDE:S_O_S_Registered_Agent_Date_Last_Seen_:DATE),soscode(DEFAULT:S_O_S_Code_:\'\'),filing_code(DEFAULT:Filing___Code_:\'\'),registrationstatus(DEFAULT:Registration_Status_:\'\'),registrationstatusdescription(DEFAULT:Registration_Status_Description_:\'\'),ebrprocessdate(DEFAULT:E_B_R_Process_Date_:DATE),retirementplanbegindate(DEFAULT:Retirement_Plan_Begin_Date_:DATE),retirementplaneffectivedate(DEFAULT:Retirement_Plan_Effective_Date_:DATE),retirementplanentityindicator(DEFAULT:Retirement_Plan_Entity_Indicator_:\'\'),retirementtotalparticipants(DEFAULT:Retirement_Total_Participants_:\'\'),retirementtotalactiveparticipants(DEFAULT:Retirement_Total_Active_Participants_:\'\'),retirementparticipantreceivingcount(DEFAULT:Retirement_Participant_Receiving_Count_:\'\'),retirementparticipantfuturecount(DEFAULT:Retirement_Participant_Future_Count_:\'\'),retirementreceivingbenefitcount(DEFAULT:Retirement_Receiving_Benefit_Count_:\'\'),retirementparticipantaccountbalancecount(DEFAULT:Retirement_Participant_Account_Balance_Count_:\'\'),retirementparticipantpartiallyvestedcount(DEFAULT:Retirement_Participant_Partially_Vested_Count_:\'\'),retirementplanpensionbenefitid(DEFAULT:Retirement_Plan_Pension_Benefit_I_D_:\'\'),retirementplanwelfarebenefitindicator(DEFAULT:Retirement_Plan_Welfare_Benefit_Indicator_:\'\'),govdebarredclassification(DEFAULT:Gov_Debarred_Classification_:\'\'),govdebarredexclusionprogram(DEFAULT:Gov_Debarred_Exclusion_Program_:\'\'),govdebarredexclusiontype(DEFAULT:Gov_Debarred_Exclusion_Type_:\'\'),govdebarredexcludingagency(DEFAULT:Gov_Debarred_Excluding_Agency_:\'\'),govdebarredactivedate(DEFAULT:Gov_Debarred_Active_Date_:DATE),govdebarredterminationdate(DEFAULT:Gov_Debarred_Termination_Date_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_6Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d6_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d6_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d6_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Corp2__Key_LinkIDs_Vault_Invalid := __d6_UID_Mapped(UID = 0);
  SHARED __d6_Prefiltered := __d6_UID_Mapped(UID <> 0);
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6;
  EXPORT Vendor_Identification_Layout := RECORD
    KEL.typ.nstr E_B_R_Number_;
    KEL.typ.nint E_F_X_Number_;
    KEL.typ.nstr D_U_N_S_Number_;
    KEL.typ.nstr S_O_S_Key_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT S_O_S_Company_Types_Layout := RECORD
    KEL.typ.nstr S_O_S_Entity_Description_;
    KEL.typ.nstr S_O_S_Original_Business_Type_Description_;
    KEL.typ.nstr S_O_S_Original_Org_Structure_Description_;
    KEL.typ.nstr S_O_S_Name_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT S_O_S_Registered_Agents_Layout := RECORD
    KEL.typ.nstr S_O_S_Registered_Agent_Name_;
    KEL.typ.nkdate S_O_S_Registered_Agent_Effective_Date_;
    KEL.typ.nkdate S_O_S_Registered_Agent_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Registered_Agent_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT S_O_S_Statuses_Layout := RECORD
    KEL.typ.nstr S_O_S_Status_Code_;
    KEL.typ.nstr S_O_S_Status_Description_;
    KEL.typ.nkdate S_O_S_Status_Date_;
    KEL.typ.nkdate S_O_S_Process_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT S_O_S_Incorporation_Details_Layout := RECORD
    KEL.typ.nstr S_O_S_Key_;
    KEL.typ.nstr S_O_S_Incorporation_State_;
    KEL.typ.nkdate S_O_S_Incorporation_Date_;
    KEL.typ.nkdate S_O_S_Foreign_State_Date_;
    KEL.typ.nstr S_O_S_Foreign_State_Code_;
    KEL.typ.nstr S_O_S_Foreign_Domestic_Indicator_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT S_O_S_Charter_Numbers_Layout := RECORD
    KEL.typ.nstr S_O_S_Original_Charter_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT S_O_S_Term_Exist_Codes_Layout := RECORD
    KEL.typ.nstr S_O_S_Term_Exist_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Government_Debarred_Layout := RECORD
    KEL.typ.nstr Gov_Debarred_Classification_;
    KEL.typ.nstr Gov_Debarred_Exclusion_Program_;
    KEL.typ.nstr Gov_Debarred_Exclusion_Type_;
    KEL.typ.nstr Gov_Debarred_Excluding_Agency_;
    KEL.typ.nkdate Gov_Debarred_Active_Date_;
    KEL.typ.nstr Gov_Debarred_Termination_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Retirement_Plan_Information_Layout := RECORD
    KEL.typ.nkdate Retirement_Plan_Begin_Date_;
    KEL.typ.nkdate Retirement_Plan_Effective_Date_;
    KEL.typ.nstr Retirement_Plan_Entity_Indicator_;
    KEL.typ.nint Retirement_Total_Participants_;
    KEL.typ.nint Retirement_Total_Active_Participants_;
    KEL.typ.nint Retirement_Participant_Receiving_Count_;
    KEL.typ.nint Retirement_Participant_Future_Count_;
    KEL.typ.nint Retirement_Receiving_Benefit_Count_;
    KEL.typ.nint Retirement_Participant_Partially_Vested_Count_;
    KEL.typ.nint Retirement_Participant_Account_Balance_Count_;
    KEL.typ.nint Retirement_Plan_Pension_Benefit_I_D_;
    KEL.typ.nint Retirement_Plan_Welfare_Benefit_Indicator_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Processing_Dates_Layout := RECORD
    KEL.typ.nkdate S_O_S_Process_Date_;
    KEL.typ.nkdate E_B_R_Process_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Business_Registration_Layout := RECORD
    KEL.typ.nstr S_O_S_Code_;
    KEL.typ.nstr Filing___Code_;
    KEL.typ.nstr Registration_Status_;
    KEL.typ.nstr Registration_Status_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Business_Sele_Overflow_Group := __PostFilter;
  Layout Business_Sele_Overflow__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Ult_I_D_ := KEL.Intake.SingleValue(__recs,Ult_I_D_);
    SELF.Org_I_D_ := KEL.Intake.SingleValue(__recs,Org_I_D_);
    SELF.Sele_I_D_ := KEL.Intake.SingleValue(__recs,Sele_I_D_);
    SELF.Vendor_Identification_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),E_B_R_Number_,E_F_X_Number_,D_U_N_S_Number_,S_O_S_Key_},E_B_R_Number_,E_F_X_Number_,D_U_N_S_Number_,S_O_S_Key_),Vendor_Identification_Layout)(__NN(E_B_R_Number_) OR __NN(E_F_X_Number_) OR __NN(D_U_N_S_Number_) OR __NN(S_O_S_Key_)));
    SELF.S_O_S_Company_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Entity_Description_,S_O_S_Original_Business_Type_Description_,S_O_S_Original_Org_Structure_Description_,S_O_S_Name_Type_Description_},S_O_S_Entity_Description_,S_O_S_Original_Business_Type_Description_,S_O_S_Original_Org_Structure_Description_,S_O_S_Name_Type_Description_),S_O_S_Company_Types_Layout)(__NN(S_O_S_Entity_Description_) OR __NN(S_O_S_Original_Business_Type_Description_) OR __NN(S_O_S_Original_Org_Structure_Description_) OR __NN(S_O_S_Name_Type_Description_)));
    SELF.S_O_S_Registered_Agents_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Registered_Agent_Name_,S_O_S_Registered_Agent_Effective_Date_,S_O_S_Registered_Agent_Date_First_Seen_,S_O_S_Registered_Agent_Date_Last_Seen_},S_O_S_Registered_Agent_Name_,S_O_S_Registered_Agent_Effective_Date_,S_O_S_Registered_Agent_Date_First_Seen_,S_O_S_Registered_Agent_Date_Last_Seen_),S_O_S_Registered_Agents_Layout)(__NN(S_O_S_Registered_Agent_Name_) OR __NN(S_O_S_Registered_Agent_Effective_Date_) OR __NN(S_O_S_Registered_Agent_Date_First_Seen_) OR __NN(S_O_S_Registered_Agent_Date_Last_Seen_)));
    SELF.S_O_S_Statuses_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Status_Code_,S_O_S_Status_Description_,S_O_S_Status_Date_,S_O_S_Process_Date_},S_O_S_Status_Code_,S_O_S_Status_Description_,S_O_S_Status_Date_,S_O_S_Process_Date_),S_O_S_Statuses_Layout)(__NN(S_O_S_Status_Code_) OR __NN(S_O_S_Status_Description_) OR __NN(S_O_S_Status_Date_) OR __NN(S_O_S_Process_Date_)));
    SELF.S_O_S_Incorporation_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Key_,S_O_S_Incorporation_State_,S_O_S_Incorporation_Date_,S_O_S_Foreign_State_Date_,S_O_S_Foreign_State_Code_,S_O_S_Foreign_Domestic_Indicator_},S_O_S_Key_,S_O_S_Incorporation_State_,S_O_S_Incorporation_Date_,S_O_S_Foreign_State_Date_,S_O_S_Foreign_State_Code_,S_O_S_Foreign_Domestic_Indicator_),S_O_S_Incorporation_Details_Layout)(__NN(S_O_S_Key_) OR __NN(S_O_S_Incorporation_State_) OR __NN(S_O_S_Incorporation_Date_) OR __NN(S_O_S_Foreign_State_Date_) OR __NN(S_O_S_Foreign_State_Code_) OR __NN(S_O_S_Foreign_Domestic_Indicator_)));
    SELF.S_O_S_Charter_Numbers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Original_Charter_Number_},S_O_S_Original_Charter_Number_),S_O_S_Charter_Numbers_Layout)(__NN(S_O_S_Original_Charter_Number_)));
    SELF.S_O_S_Term_Exist_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Term_Exist_Code_},S_O_S_Term_Exist_Code_),S_O_S_Term_Exist_Codes_Layout)(__NN(S_O_S_Term_Exist_Code_)));
    SELF.Government_Debarred_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Gov_Debarred_Classification_,Gov_Debarred_Exclusion_Program_,Gov_Debarred_Exclusion_Type_,Gov_Debarred_Excluding_Agency_,Gov_Debarred_Active_Date_,Gov_Debarred_Termination_Date_},Gov_Debarred_Classification_,Gov_Debarred_Exclusion_Program_,Gov_Debarred_Exclusion_Type_,Gov_Debarred_Excluding_Agency_,Gov_Debarred_Active_Date_,Gov_Debarred_Termination_Date_),Government_Debarred_Layout)(__NN(Gov_Debarred_Classification_) OR __NN(Gov_Debarred_Exclusion_Program_) OR __NN(Gov_Debarred_Exclusion_Type_) OR __NN(Gov_Debarred_Excluding_Agency_) OR __NN(Gov_Debarred_Active_Date_) OR __NN(Gov_Debarred_Termination_Date_)));
    SELF.Retirement_Plan_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Retirement_Plan_Begin_Date_,Retirement_Plan_Effective_Date_,Retirement_Plan_Entity_Indicator_,Retirement_Total_Participants_,Retirement_Total_Active_Participants_,Retirement_Participant_Receiving_Count_,Retirement_Participant_Future_Count_,Retirement_Receiving_Benefit_Count_,Retirement_Participant_Partially_Vested_Count_,Retirement_Participant_Account_Balance_Count_,Retirement_Plan_Pension_Benefit_I_D_,Retirement_Plan_Welfare_Benefit_Indicator_},Retirement_Plan_Begin_Date_,Retirement_Plan_Effective_Date_,Retirement_Plan_Entity_Indicator_,Retirement_Total_Participants_,Retirement_Total_Active_Participants_,Retirement_Participant_Receiving_Count_,Retirement_Participant_Future_Count_,Retirement_Receiving_Benefit_Count_,Retirement_Participant_Partially_Vested_Count_,Retirement_Participant_Account_Balance_Count_,Retirement_Plan_Pension_Benefit_I_D_,Retirement_Plan_Welfare_Benefit_Indicator_),Retirement_Plan_Information_Layout)(__NN(Retirement_Plan_Begin_Date_) OR __NN(Retirement_Plan_Effective_Date_) OR __NN(Retirement_Plan_Entity_Indicator_) OR __NN(Retirement_Total_Participants_) OR __NN(Retirement_Total_Active_Participants_) OR __NN(Retirement_Participant_Receiving_Count_) OR __NN(Retirement_Participant_Future_Count_) OR __NN(Retirement_Receiving_Benefit_Count_) OR __NN(Retirement_Participant_Partially_Vested_Count_) OR __NN(Retirement_Participant_Account_Balance_Count_) OR __NN(Retirement_Plan_Pension_Benefit_I_D_) OR __NN(Retirement_Plan_Welfare_Benefit_Indicator_)));
    SELF.Processing_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Process_Date_,E_B_R_Process_Date_},S_O_S_Process_Date_,E_B_R_Process_Date_),Processing_Dates_Layout)(__NN(S_O_S_Process_Date_) OR __NN(E_B_R_Process_Date_)));
    SELF.Business_Registration_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Code_,Filing___Code_,Registration_Status_,Registration_Status_Description_},S_O_S_Code_,Filing___Code_,Registration_Status_,Registration_Status_Description_),Business_Registration_Layout)(__NN(S_O_S_Code_) OR __NN(Filing___Code_) OR __NN(Registration_Status_) OR __NN(Registration_Status_Description_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,Header_Hit_Flag_},Source_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Business_Sele_Overflow__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Vendor_Identification_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vendor_Identification_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(E_B_R_Number_) OR __NN(E_F_X_Number_) OR __NN(D_U_N_S_Number_) OR __NN(S_O_S_Key_)));
    SELF.S_O_S_Company_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_O_S_Company_Types_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_O_S_Entity_Description_) OR __NN(S_O_S_Original_Business_Type_Description_) OR __NN(S_O_S_Original_Org_Structure_Description_) OR __NN(S_O_S_Name_Type_Description_)));
    SELF.S_O_S_Registered_Agents_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_O_S_Registered_Agents_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_O_S_Registered_Agent_Name_) OR __NN(S_O_S_Registered_Agent_Effective_Date_) OR __NN(S_O_S_Registered_Agent_Date_First_Seen_) OR __NN(S_O_S_Registered_Agent_Date_Last_Seen_)));
    SELF.S_O_S_Statuses_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_O_S_Statuses_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_O_S_Status_Code_) OR __NN(S_O_S_Status_Description_) OR __NN(S_O_S_Status_Date_) OR __NN(S_O_S_Process_Date_)));
    SELF.S_O_S_Incorporation_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_O_S_Incorporation_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_O_S_Key_) OR __NN(S_O_S_Incorporation_State_) OR __NN(S_O_S_Incorporation_Date_) OR __NN(S_O_S_Foreign_State_Date_) OR __NN(S_O_S_Foreign_State_Code_) OR __NN(S_O_S_Foreign_Domestic_Indicator_)));
    SELF.S_O_S_Charter_Numbers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_O_S_Charter_Numbers_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_O_S_Original_Charter_Number_)));
    SELF.S_O_S_Term_Exist_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_O_S_Term_Exist_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_O_S_Term_Exist_Code_)));
    SELF.Government_Debarred_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Government_Debarred_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Gov_Debarred_Classification_) OR __NN(Gov_Debarred_Exclusion_Program_) OR __NN(Gov_Debarred_Exclusion_Type_) OR __NN(Gov_Debarred_Excluding_Agency_) OR __NN(Gov_Debarred_Active_Date_) OR __NN(Gov_Debarred_Termination_Date_)));
    SELF.Retirement_Plan_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Retirement_Plan_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Retirement_Plan_Begin_Date_) OR __NN(Retirement_Plan_Effective_Date_) OR __NN(Retirement_Plan_Entity_Indicator_) OR __NN(Retirement_Total_Participants_) OR __NN(Retirement_Total_Active_Participants_) OR __NN(Retirement_Participant_Receiving_Count_) OR __NN(Retirement_Participant_Future_Count_) OR __NN(Retirement_Receiving_Benefit_Count_) OR __NN(Retirement_Participant_Partially_Vested_Count_) OR __NN(Retirement_Participant_Account_Balance_Count_) OR __NN(Retirement_Plan_Pension_Benefit_I_D_) OR __NN(Retirement_Plan_Welfare_Benefit_Indicator_)));
    SELF.Processing_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Processing_Dates_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_O_S_Process_Date_) OR __NN(E_B_R_Process_Date_)));
    SELF.Business_Registration_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Business_Registration_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_O_S_Code_) OR __NN(Filing___Code_) OR __NN(Registration_Status_) OR __NN(Registration_Status_Description_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Business_Sele_Overflow_Group,COUNT(ROWS(LEFT))=1),GROUP,Business_Sele_Overflow__Single_Rollup(LEFT)) + ROLLUP(HAVING(Business_Sele_Overflow_Group,COUNT(ROWS(LEFT))>1),GROUP,Business_Sele_Overflow__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Ult_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Ult_I_D_);
  EXPORT Org_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Org_I_D_);
  EXPORT Sele_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sele_I_D_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_BIPV2__Key_BH_Linking_Ids_Vault__Key_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_BusReg__Key_BusReg_Company_LinkIds_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_EBR__Key_5600_Demographic_Data_LinkIds_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_IRS5500__Key_LinkIds_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_SAM__Key_LinkId_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Equifax_Business_Data__Key_LinkIds_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Corp2__Key_LinkIDs_Vault_Invalid),COUNT(Ult_I_D__SingleValue_Invalid),COUNT(Org_I_D__SingleValue_Invalid),COUNT(Sele_I_D__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_BIPV2__Key_BH_Linking_Ids_Vault__Key_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_BusReg__Key_BusReg_Company_LinkIds_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_EBR__Key_5600_Demographic_Data_LinkIds_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_IRS5500__Key_LinkIds_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_SAM__Key_LinkId_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Equifax_Business_Data__Key_LinkIds_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Corp2__Key_LinkIDs_Vault_Invalid,KEL.typ.int Ult_I_D__SingleValue_Invalid,KEL.typ.int Org_I_D__SingleValue_Invalid,KEL.typ.int Sele_I_D__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_BIPV2__Key_BH_Linking_Ids_Vault__Key_Invalid),COUNT(__d0)},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','ebr_file_number',COUNT(__d0(__NL(E_B_R_Number_))),COUNT(__d0(__NN(E_B_R_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','EFXNumber',COUNT(__d0(__NL(E_F_X_Number_))),COUNT(__d0(__NN(E_F_X_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','DUNSNumber',COUNT(__d0(__NL(D_U_N_S_Number_))),COUNT(__d0(__NN(D_U_N_S_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSKey',COUNT(__d0(__NL(S_O_S_Key_))),COUNT(__d0(__NN(S_O_S_Key_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSEntityDescription',COUNT(__d0(__NL(S_O_S_Entity_Description_))),COUNT(__d0(__NN(S_O_S_Entity_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSNameTypeDescription',COUNT(__d0(__NL(S_O_S_Name_Type_Description_))),COUNT(__d0(__NN(S_O_S_Name_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSProcessDate',COUNT(__d0(__NL(S_O_S_Process_Date_))),COUNT(__d0(__NN(S_O_S_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSStatusCode',COUNT(__d0(__NL(S_O_S_Status_Code_))),COUNT(__d0(__NN(S_O_S_Status_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSStatusDescription',COUNT(__d0(__NL(S_O_S_Status_Description_))),COUNT(__d0(__NN(S_O_S_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSStatusDate',COUNT(__d0(__NL(S_O_S_Status_Date_))),COUNT(__d0(__NN(S_O_S_Status_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSIncorporationState',COUNT(__d0(__NL(S_O_S_Incorporation_State_))),COUNT(__d0(__NN(S_O_S_Incorporation_State_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSIncorporationDate',COUNT(__d0(__NL(S_O_S_Incorporation_Date_))),COUNT(__d0(__NN(S_O_S_Incorporation_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSForeignStateCode',COUNT(__d0(__NL(S_O_S_Foreign_State_Code_))),COUNT(__d0(__NN(S_O_S_Foreign_State_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSForeignStateDate',COUNT(__d0(__NL(S_O_S_Foreign_State_Date_))),COUNT(__d0(__NN(S_O_S_Foreign_State_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSForeignDomesticIndicator',COUNT(__d0(__NL(S_O_S_Foreign_Domestic_Indicator_))),COUNT(__d0(__NN(S_O_S_Foreign_Domestic_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSOriginalBusinessTypeDescription',COUNT(__d0(__NL(S_O_S_Original_Business_Type_Description_))),COUNT(__d0(__NN(S_O_S_Original_Business_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSOriginalOrgStructureDescription',COUNT(__d0(__NL(S_O_S_Original_Org_Structure_Description_))),COUNT(__d0(__NN(S_O_S_Original_Org_Structure_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSOriginalCharterNumber',COUNT(__d0(__NL(S_O_S_Original_Charter_Number_))),COUNT(__d0(__NN(S_O_S_Original_Charter_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSTermExistCode',COUNT(__d0(__NL(S_O_S_Term_Exist_Code_))),COUNT(__d0(__NN(S_O_S_Term_Exist_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSRegisteredAgentName',COUNT(__d0(__NL(S_O_S_Registered_Agent_Name_))),COUNT(__d0(__NN(S_O_S_Registered_Agent_Name_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSRegisteredAgentEffectiveDate',COUNT(__d0(__NL(S_O_S_Registered_Agent_Effective_Date_))),COUNT(__d0(__NN(S_O_S_Registered_Agent_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSRegisteredAgentDateFirstSeen',COUNT(__d0(__NL(S_O_S_Registered_Agent_Date_First_Seen_))),COUNT(__d0(__NN(S_O_S_Registered_Agent_Date_First_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSRegisteredAgentDateLastSeen',COUNT(__d0(__NL(S_O_S_Registered_Agent_Date_Last_Seen_))),COUNT(__d0(__NN(S_O_S_Registered_Agent_Date_Last_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','SOSCode',COUNT(__d0(__NL(S_O_S_Code_))),COUNT(__d0(__NN(S_O_S_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','Filing_Code',COUNT(__d0(__NL(Filing___Code_))),COUNT(__d0(__NN(Filing___Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RegistrationStatus',COUNT(__d0(__NL(Registration_Status_))),COUNT(__d0(__NN(Registration_Status_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RegistrationStatusDescription',COUNT(__d0(__NL(Registration_Status_Description_))),COUNT(__d0(__NN(Registration_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','EBRProcessDate',COUNT(__d0(__NL(E_B_R_Process_Date_))),COUNT(__d0(__NN(E_B_R_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementPlanBeginDate',COUNT(__d0(__NL(Retirement_Plan_Begin_Date_))),COUNT(__d0(__NN(Retirement_Plan_Begin_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementPlanEffectiveDate',COUNT(__d0(__NL(Retirement_Plan_Effective_Date_))),COUNT(__d0(__NN(Retirement_Plan_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementPlanEntityIndicator',COUNT(__d0(__NL(Retirement_Plan_Entity_Indicator_))),COUNT(__d0(__NN(Retirement_Plan_Entity_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementTotalParticipants',COUNT(__d0(__NL(Retirement_Total_Participants_))),COUNT(__d0(__NN(Retirement_Total_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementTotalActiveParticipants',COUNT(__d0(__NL(Retirement_Total_Active_Participants_))),COUNT(__d0(__NN(Retirement_Total_Active_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementParticipantReceivingCount',COUNT(__d0(__NL(Retirement_Participant_Receiving_Count_))),COUNT(__d0(__NN(Retirement_Participant_Receiving_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementParticipantFutureCount',COUNT(__d0(__NL(Retirement_Participant_Future_Count_))),COUNT(__d0(__NN(Retirement_Participant_Future_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementReceivingBenefitCount',COUNT(__d0(__NL(Retirement_Receiving_Benefit_Count_))),COUNT(__d0(__NN(Retirement_Receiving_Benefit_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementParticipantAccountBalanceCount',COUNT(__d0(__NL(Retirement_Participant_Account_Balance_Count_))),COUNT(__d0(__NN(Retirement_Participant_Account_Balance_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementParticipantPartiallyVestedCount',COUNT(__d0(__NL(Retirement_Participant_Partially_Vested_Count_))),COUNT(__d0(__NN(Retirement_Participant_Partially_Vested_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementPlanPensionBenefitID',COUNT(__d0(__NL(Retirement_Plan_Pension_Benefit_I_D_))),COUNT(__d0(__NN(Retirement_Plan_Pension_Benefit_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','RetirementPlanWelfareBenefitIndicator',COUNT(__d0(__NL(Retirement_Plan_Welfare_Benefit_Indicator_))),COUNT(__d0(__NN(Retirement_Plan_Welfare_Benefit_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','GovDebarredClassification',COUNT(__d0(__NL(Gov_Debarred_Classification_))),COUNT(__d0(__NN(Gov_Debarred_Classification_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','GovDebarredExclusionProgram',COUNT(__d0(__NL(Gov_Debarred_Exclusion_Program_))),COUNT(__d0(__NN(Gov_Debarred_Exclusion_Program_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','GovDebarredExclusionType',COUNT(__d0(__NL(Gov_Debarred_Exclusion_Type_))),COUNT(__d0(__NN(Gov_Debarred_Exclusion_Type_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','GovDebarredExcludingAgency',COUNT(__d0(__NL(Gov_Debarred_Excluding_Agency_))),COUNT(__d0(__NN(Gov_Debarred_Excluding_Agency_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','GovDebarredActiveDate',COUNT(__d0(__NL(Gov_Debarred_Active_Date_))),COUNT(__d0(__NN(Gov_Debarred_Active_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','GovDebarredTerminationDate',COUNT(__d0(__NL(Gov_Debarred_Termination_Date_))),COUNT(__d0(__NN(Gov_Debarred_Termination_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BIPV2__Key_BH_Linking_Ids_Vault__Key','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_BusReg__Key_BusReg_Company_LinkIds_Vault_Invalid),COUNT(__d1)},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','ultid',COUNT(__d1(__NL(Ult_I_D_))),COUNT(__d1(__NN(Ult_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','orgid',COUNT(__d1(__NL(Org_I_D_))),COUNT(__d1(__NN(Org_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','seleid',COUNT(__d1(__NL(Sele_I_D_))),COUNT(__d1(__NN(Sele_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','EBRNumber',COUNT(__d1(__NL(E_B_R_Number_))),COUNT(__d1(__NN(E_B_R_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','EFXNumber',COUNT(__d1(__NL(E_F_X_Number_))),COUNT(__d1(__NN(E_F_X_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','DUNSNumber',COUNT(__d1(__NL(D_U_N_S_Number_))),COUNT(__d1(__NN(D_U_N_S_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSKey',COUNT(__d1(__NL(S_O_S_Key_))),COUNT(__d1(__NN(S_O_S_Key_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSEntityDescription',COUNT(__d1(__NL(S_O_S_Entity_Description_))),COUNT(__d1(__NN(S_O_S_Entity_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSNameTypeDescription',COUNT(__d1(__NL(S_O_S_Name_Type_Description_))),COUNT(__d1(__NN(S_O_S_Name_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSProcessDate',COUNT(__d1(__NL(S_O_S_Process_Date_))),COUNT(__d1(__NN(S_O_S_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSStatusCode',COUNT(__d1(__NL(S_O_S_Status_Code_))),COUNT(__d1(__NN(S_O_S_Status_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSStatusDescription',COUNT(__d1(__NL(S_O_S_Status_Description_))),COUNT(__d1(__NN(S_O_S_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSStatusDate',COUNT(__d1(__NL(S_O_S_Status_Date_))),COUNT(__d1(__NN(S_O_S_Status_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSIncorporationState',COUNT(__d1(__NL(S_O_S_Incorporation_State_))),COUNT(__d1(__NN(S_O_S_Incorporation_State_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSIncorporationDate',COUNT(__d1(__NL(S_O_S_Incorporation_Date_))),COUNT(__d1(__NN(S_O_S_Incorporation_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSForeignStateCode',COUNT(__d1(__NL(S_O_S_Foreign_State_Code_))),COUNT(__d1(__NN(S_O_S_Foreign_State_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSForeignStateDate',COUNT(__d1(__NL(S_O_S_Foreign_State_Date_))),COUNT(__d1(__NN(S_O_S_Foreign_State_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSForeignDomesticIndicator',COUNT(__d1(__NL(S_O_S_Foreign_Domestic_Indicator_))),COUNT(__d1(__NN(S_O_S_Foreign_Domestic_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSOriginalBusinessTypeDescription',COUNT(__d1(__NL(S_O_S_Original_Business_Type_Description_))),COUNT(__d1(__NN(S_O_S_Original_Business_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSOriginalOrgStructureDescription',COUNT(__d1(__NL(S_O_S_Original_Org_Structure_Description_))),COUNT(__d1(__NN(S_O_S_Original_Org_Structure_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSOriginalCharterNumber',COUNT(__d1(__NL(S_O_S_Original_Charter_Number_))),COUNT(__d1(__NN(S_O_S_Original_Charter_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSTermExistCode',COUNT(__d1(__NL(S_O_S_Term_Exist_Code_))),COUNT(__d1(__NN(S_O_S_Term_Exist_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSRegisteredAgentName',COUNT(__d1(__NL(S_O_S_Registered_Agent_Name_))),COUNT(__d1(__NN(S_O_S_Registered_Agent_Name_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSRegisteredAgentEffectiveDate',COUNT(__d1(__NL(S_O_S_Registered_Agent_Effective_Date_))),COUNT(__d1(__NN(S_O_S_Registered_Agent_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSRegisteredAgentDateFirstSeen',COUNT(__d1(__NL(S_O_S_Registered_Agent_Date_First_Seen_))),COUNT(__d1(__NN(S_O_S_Registered_Agent_Date_First_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','SOSRegisteredAgentDateLastSeen',COUNT(__d1(__NL(S_O_S_Registered_Agent_Date_Last_Seen_))),COUNT(__d1(__NN(S_O_S_Registered_Agent_Date_Last_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','rawfields.sos_code',COUNT(__d1(__NL(S_O_S_Code_))),COUNT(__d1(__NN(S_O_S_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','rawfields.filing_cod',COUNT(__d1(__NL(Filing___Code_))),COUNT(__d1(__NN(Filing___Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','rawfields.status',COUNT(__d1(__NL(Registration_Status_))),COUNT(__d1(__NN(Registration_Status_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','rawfields.stat_des',COUNT(__d1(__NL(Registration_Status_Description_))),COUNT(__d1(__NN(Registration_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','EBRProcessDate',COUNT(__d1(__NL(E_B_R_Process_Date_))),COUNT(__d1(__NN(E_B_R_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementPlanBeginDate',COUNT(__d1(__NL(Retirement_Plan_Begin_Date_))),COUNT(__d1(__NN(Retirement_Plan_Begin_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementPlanEffectiveDate',COUNT(__d1(__NL(Retirement_Plan_Effective_Date_))),COUNT(__d1(__NN(Retirement_Plan_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementPlanEntityIndicator',COUNT(__d1(__NL(Retirement_Plan_Entity_Indicator_))),COUNT(__d1(__NN(Retirement_Plan_Entity_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementTotalParticipants',COUNT(__d1(__NL(Retirement_Total_Participants_))),COUNT(__d1(__NN(Retirement_Total_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementTotalActiveParticipants',COUNT(__d1(__NL(Retirement_Total_Active_Participants_))),COUNT(__d1(__NN(Retirement_Total_Active_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementParticipantReceivingCount',COUNT(__d1(__NL(Retirement_Participant_Receiving_Count_))),COUNT(__d1(__NN(Retirement_Participant_Receiving_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementParticipantFutureCount',COUNT(__d1(__NL(Retirement_Participant_Future_Count_))),COUNT(__d1(__NN(Retirement_Participant_Future_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementReceivingBenefitCount',COUNT(__d1(__NL(Retirement_Receiving_Benefit_Count_))),COUNT(__d1(__NN(Retirement_Receiving_Benefit_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementParticipantAccountBalanceCount',COUNT(__d1(__NL(Retirement_Participant_Account_Balance_Count_))),COUNT(__d1(__NN(Retirement_Participant_Account_Balance_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementParticipantPartiallyVestedCount',COUNT(__d1(__NL(Retirement_Participant_Partially_Vested_Count_))),COUNT(__d1(__NN(Retirement_Participant_Partially_Vested_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementPlanPensionBenefitID',COUNT(__d1(__NL(Retirement_Plan_Pension_Benefit_I_D_))),COUNT(__d1(__NN(Retirement_Plan_Pension_Benefit_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','RetirementPlanWelfareBenefitIndicator',COUNT(__d1(__NL(Retirement_Plan_Welfare_Benefit_Indicator_))),COUNT(__d1(__NN(Retirement_Plan_Welfare_Benefit_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','GovDebarredClassification',COUNT(__d1(__NL(Gov_Debarred_Classification_))),COUNT(__d1(__NN(Gov_Debarred_Classification_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','GovDebarredExclusionProgram',COUNT(__d1(__NL(Gov_Debarred_Exclusion_Program_))),COUNT(__d1(__NN(Gov_Debarred_Exclusion_Program_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','GovDebarredExclusionType',COUNT(__d1(__NL(Gov_Debarred_Exclusion_Type_))),COUNT(__d1(__NN(Gov_Debarred_Exclusion_Type_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','GovDebarredExcludingAgency',COUNT(__d1(__NL(Gov_Debarred_Excluding_Agency_))),COUNT(__d1(__NN(Gov_Debarred_Excluding_Agency_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','GovDebarredActiveDate',COUNT(__d1(__NL(Gov_Debarred_Active_Date_))),COUNT(__d1(__NN(Gov_Debarred_Active_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','GovDebarredTerminationDate',COUNT(__d1(__NL(Gov_Debarred_Termination_Date_))),COUNT(__d1(__NN(Gov_Debarred_Termination_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','HeaderHitFlag',COUNT(__d1(__NL(Header_Hit_Flag_))),COUNT(__d1(__NN(Header_Hit_Flag_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.BusReg__Key_BusReg_Company_LinkIds_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_EBR__Key_5600_Demographic_Data_LinkIds_Vault_Invalid),COUNT(__d2)},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','ultid',COUNT(__d2(__NL(Ult_I_D_))),COUNT(__d2(__NN(Ult_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','orgid',COUNT(__d2(__NL(Org_I_D_))),COUNT(__d2(__NN(Org_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','seleid',COUNT(__d2(__NL(Sele_I_D_))),COUNT(__d2(__NN(Sele_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','file_number',COUNT(__d2(__NL(E_B_R_Number_))),COUNT(__d2(__NN(E_B_R_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','EFXNumber',COUNT(__d2(__NL(E_F_X_Number_))),COUNT(__d2(__NN(E_F_X_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','DUNSNumber',COUNT(__d2(__NL(D_U_N_S_Number_))),COUNT(__d2(__NN(D_U_N_S_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSKey',COUNT(__d2(__NL(S_O_S_Key_))),COUNT(__d2(__NN(S_O_S_Key_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSEntityDescription',COUNT(__d2(__NL(S_O_S_Entity_Description_))),COUNT(__d2(__NN(S_O_S_Entity_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSNameTypeDescription',COUNT(__d2(__NL(S_O_S_Name_Type_Description_))),COUNT(__d2(__NN(S_O_S_Name_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSProcessDate',COUNT(__d2(__NL(S_O_S_Process_Date_))),COUNT(__d2(__NN(S_O_S_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSStatusCode',COUNT(__d2(__NL(S_O_S_Status_Code_))),COUNT(__d2(__NN(S_O_S_Status_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSStatusDescription',COUNT(__d2(__NL(S_O_S_Status_Description_))),COUNT(__d2(__NN(S_O_S_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSStatusDate',COUNT(__d2(__NL(S_O_S_Status_Date_))),COUNT(__d2(__NN(S_O_S_Status_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSIncorporationState',COUNT(__d2(__NL(S_O_S_Incorporation_State_))),COUNT(__d2(__NN(S_O_S_Incorporation_State_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSIncorporationDate',COUNT(__d2(__NL(S_O_S_Incorporation_Date_))),COUNT(__d2(__NN(S_O_S_Incorporation_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSForeignStateCode',COUNT(__d2(__NL(S_O_S_Foreign_State_Code_))),COUNT(__d2(__NN(S_O_S_Foreign_State_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSForeignStateDate',COUNT(__d2(__NL(S_O_S_Foreign_State_Date_))),COUNT(__d2(__NN(S_O_S_Foreign_State_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSForeignDomesticIndicator',COUNT(__d2(__NL(S_O_S_Foreign_Domestic_Indicator_))),COUNT(__d2(__NN(S_O_S_Foreign_Domestic_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSOriginalBusinessTypeDescription',COUNT(__d2(__NL(S_O_S_Original_Business_Type_Description_))),COUNT(__d2(__NN(S_O_S_Original_Business_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSOriginalOrgStructureDescription',COUNT(__d2(__NL(S_O_S_Original_Org_Structure_Description_))),COUNT(__d2(__NN(S_O_S_Original_Org_Structure_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSOriginalCharterNumber',COUNT(__d2(__NL(S_O_S_Original_Charter_Number_))),COUNT(__d2(__NN(S_O_S_Original_Charter_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSTermExistCode',COUNT(__d2(__NL(S_O_S_Term_Exist_Code_))),COUNT(__d2(__NN(S_O_S_Term_Exist_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSRegisteredAgentName',COUNT(__d2(__NL(S_O_S_Registered_Agent_Name_))),COUNT(__d2(__NN(S_O_S_Registered_Agent_Name_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSRegisteredAgentEffectiveDate',COUNT(__d2(__NL(S_O_S_Registered_Agent_Effective_Date_))),COUNT(__d2(__NN(S_O_S_Registered_Agent_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSRegisteredAgentDateFirstSeen',COUNT(__d2(__NL(S_O_S_Registered_Agent_Date_First_Seen_))),COUNT(__d2(__NN(S_O_S_Registered_Agent_Date_First_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSRegisteredAgentDateLastSeen',COUNT(__d2(__NL(S_O_S_Registered_Agent_Date_Last_Seen_))),COUNT(__d2(__NN(S_O_S_Registered_Agent_Date_Last_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','SOSCode',COUNT(__d2(__NL(S_O_S_Code_))),COUNT(__d2(__NN(S_O_S_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','Filing_Code',COUNT(__d2(__NL(Filing___Code_))),COUNT(__d2(__NN(Filing___Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RegistrationStatus',COUNT(__d2(__NL(Registration_Status_))),COUNT(__d2(__NN(Registration_Status_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RegistrationStatusDescription',COUNT(__d2(__NL(Registration_Status_Description_))),COUNT(__d2(__NN(Registration_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','process_date',COUNT(__d2(__NL(E_B_R_Process_Date_))),COUNT(__d2(__NN(E_B_R_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementPlanBeginDate',COUNT(__d2(__NL(Retirement_Plan_Begin_Date_))),COUNT(__d2(__NN(Retirement_Plan_Begin_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementPlanEffectiveDate',COUNT(__d2(__NL(Retirement_Plan_Effective_Date_))),COUNT(__d2(__NN(Retirement_Plan_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementPlanEntityIndicator',COUNT(__d2(__NL(Retirement_Plan_Entity_Indicator_))),COUNT(__d2(__NN(Retirement_Plan_Entity_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementTotalParticipants',COUNT(__d2(__NL(Retirement_Total_Participants_))),COUNT(__d2(__NN(Retirement_Total_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementTotalActiveParticipants',COUNT(__d2(__NL(Retirement_Total_Active_Participants_))),COUNT(__d2(__NN(Retirement_Total_Active_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementParticipantReceivingCount',COUNT(__d2(__NL(Retirement_Participant_Receiving_Count_))),COUNT(__d2(__NN(Retirement_Participant_Receiving_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementParticipantFutureCount',COUNT(__d2(__NL(Retirement_Participant_Future_Count_))),COUNT(__d2(__NN(Retirement_Participant_Future_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementReceivingBenefitCount',COUNT(__d2(__NL(Retirement_Receiving_Benefit_Count_))),COUNT(__d2(__NN(Retirement_Receiving_Benefit_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementParticipantAccountBalanceCount',COUNT(__d2(__NL(Retirement_Participant_Account_Balance_Count_))),COUNT(__d2(__NN(Retirement_Participant_Account_Balance_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementParticipantPartiallyVestedCount',COUNT(__d2(__NL(Retirement_Participant_Partially_Vested_Count_))),COUNT(__d2(__NN(Retirement_Participant_Partially_Vested_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementPlanPensionBenefitID',COUNT(__d2(__NL(Retirement_Plan_Pension_Benefit_I_D_))),COUNT(__d2(__NN(Retirement_Plan_Pension_Benefit_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','RetirementPlanWelfareBenefitIndicator',COUNT(__d2(__NL(Retirement_Plan_Welfare_Benefit_Indicator_))),COUNT(__d2(__NN(Retirement_Plan_Welfare_Benefit_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','GovDebarredClassification',COUNT(__d2(__NL(Gov_Debarred_Classification_))),COUNT(__d2(__NN(Gov_Debarred_Classification_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','GovDebarredExclusionProgram',COUNT(__d2(__NL(Gov_Debarred_Exclusion_Program_))),COUNT(__d2(__NN(Gov_Debarred_Exclusion_Program_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','GovDebarredExclusionType',COUNT(__d2(__NL(Gov_Debarred_Exclusion_Type_))),COUNT(__d2(__NN(Gov_Debarred_Exclusion_Type_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','GovDebarredExcludingAgency',COUNT(__d2(__NL(Gov_Debarred_Excluding_Agency_))),COUNT(__d2(__NN(Gov_Debarred_Excluding_Agency_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','GovDebarredActiveDate',COUNT(__d2(__NL(Gov_Debarred_Active_Date_))),COUNT(__d2(__NN(Gov_Debarred_Active_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','GovDebarredTerminationDate',COUNT(__d2(__NL(Gov_Debarred_Termination_Date_))),COUNT(__d2(__NN(Gov_Debarred_Termination_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_IRS5500__Key_LinkIds_Vault_Invalid),COUNT(__d3)},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','ultid',COUNT(__d3(__NL(Ult_I_D_))),COUNT(__d3(__NN(Ult_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','orgid',COUNT(__d3(__NL(Org_I_D_))),COUNT(__d3(__NN(Org_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','seleid',COUNT(__d3(__NL(Sele_I_D_))),COUNT(__d3(__NN(Sele_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','EBRNumber',COUNT(__d3(__NL(E_B_R_Number_))),COUNT(__d3(__NN(E_B_R_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','EFXNumber',COUNT(__d3(__NL(E_F_X_Number_))),COUNT(__d3(__NN(E_F_X_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','DUNSNumber',COUNT(__d3(__NL(D_U_N_S_Number_))),COUNT(__d3(__NN(D_U_N_S_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSKey',COUNT(__d3(__NL(S_O_S_Key_))),COUNT(__d3(__NN(S_O_S_Key_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSEntityDescription',COUNT(__d3(__NL(S_O_S_Entity_Description_))),COUNT(__d3(__NN(S_O_S_Entity_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSNameTypeDescription',COUNT(__d3(__NL(S_O_S_Name_Type_Description_))),COUNT(__d3(__NN(S_O_S_Name_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSProcessDate',COUNT(__d3(__NL(S_O_S_Process_Date_))),COUNT(__d3(__NN(S_O_S_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSStatusCode',COUNT(__d3(__NL(S_O_S_Status_Code_))),COUNT(__d3(__NN(S_O_S_Status_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSStatusDescription',COUNT(__d3(__NL(S_O_S_Status_Description_))),COUNT(__d3(__NN(S_O_S_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSStatusDate',COUNT(__d3(__NL(S_O_S_Status_Date_))),COUNT(__d3(__NN(S_O_S_Status_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSIncorporationState',COUNT(__d3(__NL(S_O_S_Incorporation_State_))),COUNT(__d3(__NN(S_O_S_Incorporation_State_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSIncorporationDate',COUNT(__d3(__NL(S_O_S_Incorporation_Date_))),COUNT(__d3(__NN(S_O_S_Incorporation_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSForeignStateCode',COUNT(__d3(__NL(S_O_S_Foreign_State_Code_))),COUNT(__d3(__NN(S_O_S_Foreign_State_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSForeignStateDate',COUNT(__d3(__NL(S_O_S_Foreign_State_Date_))),COUNT(__d3(__NN(S_O_S_Foreign_State_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSForeignDomesticIndicator',COUNT(__d3(__NL(S_O_S_Foreign_Domestic_Indicator_))),COUNT(__d3(__NN(S_O_S_Foreign_Domestic_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSOriginalBusinessTypeDescription',COUNT(__d3(__NL(S_O_S_Original_Business_Type_Description_))),COUNT(__d3(__NN(S_O_S_Original_Business_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSOriginalOrgStructureDescription',COUNT(__d3(__NL(S_O_S_Original_Org_Structure_Description_))),COUNT(__d3(__NN(S_O_S_Original_Org_Structure_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSOriginalCharterNumber',COUNT(__d3(__NL(S_O_S_Original_Charter_Number_))),COUNT(__d3(__NN(S_O_S_Original_Charter_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSTermExistCode',COUNT(__d3(__NL(S_O_S_Term_Exist_Code_))),COUNT(__d3(__NN(S_O_S_Term_Exist_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSRegisteredAgentName',COUNT(__d3(__NL(S_O_S_Registered_Agent_Name_))),COUNT(__d3(__NN(S_O_S_Registered_Agent_Name_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSRegisteredAgentEffectiveDate',COUNT(__d3(__NL(S_O_S_Registered_Agent_Effective_Date_))),COUNT(__d3(__NN(S_O_S_Registered_Agent_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSRegisteredAgentDateFirstSeen',COUNT(__d3(__NL(S_O_S_Registered_Agent_Date_First_Seen_))),COUNT(__d3(__NN(S_O_S_Registered_Agent_Date_First_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSRegisteredAgentDateLastSeen',COUNT(__d3(__NL(S_O_S_Registered_Agent_Date_Last_Seen_))),COUNT(__d3(__NN(S_O_S_Registered_Agent_Date_Last_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','SOSCode',COUNT(__d3(__NL(S_O_S_Code_))),COUNT(__d3(__NN(S_O_S_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','Filing_Code',COUNT(__d3(__NL(Filing___Code_))),COUNT(__d3(__NN(Filing___Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','RegistrationStatus',COUNT(__d3(__NL(Registration_Status_))),COUNT(__d3(__NN(Registration_Status_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','RegistrationStatusDescription',COUNT(__d3(__NL(Registration_Status_Description_))),COUNT(__d3(__NN(Registration_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','EBRProcessDate',COUNT(__d3(__NL(E_B_R_Process_Date_))),COUNT(__d3(__NN(E_B_R_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','form_plan_year_begin_date',COUNT(__d3(__NL(Retirement_Plan_Begin_Date_))),COUNT(__d3(__NN(Retirement_Plan_Begin_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','plan_eff_date',COUNT(__d3(__NL(Retirement_Plan_Effective_Date_))),COUNT(__d3(__NN(Retirement_Plan_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','type_plan_entity_ind',COUNT(__d3(__NL(Retirement_Plan_Entity_Indicator_))),COUNT(__d3(__NN(Retirement_Plan_Entity_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','tot_partcp_boy_cnt',COUNT(__d3(__NL(Retirement_Total_Participants_))),COUNT(__d3(__NN(Retirement_Total_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','tot_active_partcp_cnt',COUNT(__d3(__NL(Retirement_Total_Active_Participants_))),COUNT(__d3(__NN(Retirement_Total_Active_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','rtd_sep_partcp_rcvg_cnt',COUNT(__d3(__NL(Retirement_Participant_Receiving_Count_))),COUNT(__d3(__NN(Retirement_Participant_Receiving_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','rtd_sep_partcp_fut_cnt',COUNT(__d3(__NL(Retirement_Participant_Future_Count_))),COUNT(__d3(__NN(Retirement_Participant_Future_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','benef_rcvg_bnft_cnt',COUNT(__d3(__NL(Retirement_Receiving_Benefit_Count_))),COUNT(__d3(__NN(Retirement_Receiving_Benefit_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','partcp_account_bal_cnt',COUNT(__d3(__NL(Retirement_Participant_Account_Balance_Count_))),COUNT(__d3(__NN(Retirement_Participant_Account_Balance_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','sep_partcp_partl_vstd_cnt',COUNT(__d3(__NL(Retirement_Participant_Partially_Vested_Count_))),COUNT(__d3(__NN(Retirement_Participant_Partially_Vested_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','pension_benefit_plan_id',COUNT(__d3(__NL(Retirement_Plan_Pension_Benefit_I_D_))),COUNT(__d3(__NN(Retirement_Plan_Pension_Benefit_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','welfare_benefit_plan_ind',COUNT(__d3(__NL(Retirement_Plan_Welfare_Benefit_Indicator_))),COUNT(__d3(__NN(Retirement_Plan_Welfare_Benefit_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','GovDebarredClassification',COUNT(__d3(__NL(Gov_Debarred_Classification_))),COUNT(__d3(__NN(Gov_Debarred_Classification_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','GovDebarredExclusionProgram',COUNT(__d3(__NL(Gov_Debarred_Exclusion_Program_))),COUNT(__d3(__NN(Gov_Debarred_Exclusion_Program_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','GovDebarredExclusionType',COUNT(__d3(__NL(Gov_Debarred_Exclusion_Type_))),COUNT(__d3(__NN(Gov_Debarred_Exclusion_Type_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','GovDebarredExcludingAgency',COUNT(__d3(__NL(Gov_Debarred_Excluding_Agency_))),COUNT(__d3(__NN(Gov_Debarred_Excluding_Agency_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','GovDebarredActiveDate',COUNT(__d3(__NL(Gov_Debarred_Active_Date_))),COUNT(__d3(__NN(Gov_Debarred_Active_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','GovDebarredTerminationDate',COUNT(__d3(__NL(Gov_Debarred_Termination_Date_))),COUNT(__d3(__NN(Gov_Debarred_Termination_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.IRS5500__Key_LinkIds_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_SAM__Key_LinkId_Vault_Invalid),COUNT(__d4)},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','ultid',COUNT(__d4(__NL(Ult_I_D_))),COUNT(__d4(__NN(Ult_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','orgid',COUNT(__d4(__NL(Org_I_D_))),COUNT(__d4(__NN(Org_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','seleid',COUNT(__d4(__NL(Sele_I_D_))),COUNT(__d4(__NN(Sele_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','EBRNumber',COUNT(__d4(__NL(E_B_R_Number_))),COUNT(__d4(__NN(E_B_R_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','EFXNumber',COUNT(__d4(__NL(E_F_X_Number_))),COUNT(__d4(__NN(E_F_X_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','DUNSNumber',COUNT(__d4(__NL(D_U_N_S_Number_))),COUNT(__d4(__NN(D_U_N_S_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSKey',COUNT(__d4(__NL(S_O_S_Key_))),COUNT(__d4(__NN(S_O_S_Key_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSEntityDescription',COUNT(__d4(__NL(S_O_S_Entity_Description_))),COUNT(__d4(__NN(S_O_S_Entity_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSNameTypeDescription',COUNT(__d4(__NL(S_O_S_Name_Type_Description_))),COUNT(__d4(__NN(S_O_S_Name_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSProcessDate',COUNT(__d4(__NL(S_O_S_Process_Date_))),COUNT(__d4(__NN(S_O_S_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSStatusCode',COUNT(__d4(__NL(S_O_S_Status_Code_))),COUNT(__d4(__NN(S_O_S_Status_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSStatusDescription',COUNT(__d4(__NL(S_O_S_Status_Description_))),COUNT(__d4(__NN(S_O_S_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSStatusDate',COUNT(__d4(__NL(S_O_S_Status_Date_))),COUNT(__d4(__NN(S_O_S_Status_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSIncorporationState',COUNT(__d4(__NL(S_O_S_Incorporation_State_))),COUNT(__d4(__NN(S_O_S_Incorporation_State_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSIncorporationDate',COUNT(__d4(__NL(S_O_S_Incorporation_Date_))),COUNT(__d4(__NN(S_O_S_Incorporation_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSForeignStateCode',COUNT(__d4(__NL(S_O_S_Foreign_State_Code_))),COUNT(__d4(__NN(S_O_S_Foreign_State_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSForeignStateDate',COUNT(__d4(__NL(S_O_S_Foreign_State_Date_))),COUNT(__d4(__NN(S_O_S_Foreign_State_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSForeignDomesticIndicator',COUNT(__d4(__NL(S_O_S_Foreign_Domestic_Indicator_))),COUNT(__d4(__NN(S_O_S_Foreign_Domestic_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSOriginalBusinessTypeDescription',COUNT(__d4(__NL(S_O_S_Original_Business_Type_Description_))),COUNT(__d4(__NN(S_O_S_Original_Business_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSOriginalOrgStructureDescription',COUNT(__d4(__NL(S_O_S_Original_Org_Structure_Description_))),COUNT(__d4(__NN(S_O_S_Original_Org_Structure_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSOriginalCharterNumber',COUNT(__d4(__NL(S_O_S_Original_Charter_Number_))),COUNT(__d4(__NN(S_O_S_Original_Charter_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSTermExistCode',COUNT(__d4(__NL(S_O_S_Term_Exist_Code_))),COUNT(__d4(__NN(S_O_S_Term_Exist_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSRegisteredAgentName',COUNT(__d4(__NL(S_O_S_Registered_Agent_Name_))),COUNT(__d4(__NN(S_O_S_Registered_Agent_Name_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSRegisteredAgentEffectiveDate',COUNT(__d4(__NL(S_O_S_Registered_Agent_Effective_Date_))),COUNT(__d4(__NN(S_O_S_Registered_Agent_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSRegisteredAgentDateFirstSeen',COUNT(__d4(__NL(S_O_S_Registered_Agent_Date_First_Seen_))),COUNT(__d4(__NN(S_O_S_Registered_Agent_Date_First_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSRegisteredAgentDateLastSeen',COUNT(__d4(__NL(S_O_S_Registered_Agent_Date_Last_Seen_))),COUNT(__d4(__NN(S_O_S_Registered_Agent_Date_Last_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','SOSCode',COUNT(__d4(__NL(S_O_S_Code_))),COUNT(__d4(__NN(S_O_S_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','Filing_Code',COUNT(__d4(__NL(Filing___Code_))),COUNT(__d4(__NN(Filing___Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RegistrationStatus',COUNT(__d4(__NL(Registration_Status_))),COUNT(__d4(__NN(Registration_Status_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RegistrationStatusDescription',COUNT(__d4(__NL(Registration_Status_Description_))),COUNT(__d4(__NN(Registration_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','EBRProcessDate',COUNT(__d4(__NL(E_B_R_Process_Date_))),COUNT(__d4(__NN(E_B_R_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementPlanBeginDate',COUNT(__d4(__NL(Retirement_Plan_Begin_Date_))),COUNT(__d4(__NN(Retirement_Plan_Begin_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementPlanEffectiveDate',COUNT(__d4(__NL(Retirement_Plan_Effective_Date_))),COUNT(__d4(__NN(Retirement_Plan_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementPlanEntityIndicator',COUNT(__d4(__NL(Retirement_Plan_Entity_Indicator_))),COUNT(__d4(__NN(Retirement_Plan_Entity_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementTotalParticipants',COUNT(__d4(__NL(Retirement_Total_Participants_))),COUNT(__d4(__NN(Retirement_Total_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementTotalActiveParticipants',COUNT(__d4(__NL(Retirement_Total_Active_Participants_))),COUNT(__d4(__NN(Retirement_Total_Active_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementParticipantReceivingCount',COUNT(__d4(__NL(Retirement_Participant_Receiving_Count_))),COUNT(__d4(__NN(Retirement_Participant_Receiving_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementParticipantFutureCount',COUNT(__d4(__NL(Retirement_Participant_Future_Count_))),COUNT(__d4(__NN(Retirement_Participant_Future_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementReceivingBenefitCount',COUNT(__d4(__NL(Retirement_Receiving_Benefit_Count_))),COUNT(__d4(__NN(Retirement_Receiving_Benefit_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementParticipantAccountBalanceCount',COUNT(__d4(__NL(Retirement_Participant_Account_Balance_Count_))),COUNT(__d4(__NN(Retirement_Participant_Account_Balance_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementParticipantPartiallyVestedCount',COUNT(__d4(__NL(Retirement_Participant_Partially_Vested_Count_))),COUNT(__d4(__NN(Retirement_Participant_Partially_Vested_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementPlanPensionBenefitID',COUNT(__d4(__NL(Retirement_Plan_Pension_Benefit_I_D_))),COUNT(__d4(__NN(Retirement_Plan_Pension_Benefit_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','RetirementPlanWelfareBenefitIndicator',COUNT(__d4(__NL(Retirement_Plan_Welfare_Benefit_Indicator_))),COUNT(__d4(__NN(Retirement_Plan_Welfare_Benefit_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','classification',COUNT(__d4(__NL(Gov_Debarred_Classification_))),COUNT(__d4(__NN(Gov_Debarred_Classification_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','exclusionprogram',COUNT(__d4(__NL(Gov_Debarred_Exclusion_Program_))),COUNT(__d4(__NN(Gov_Debarred_Exclusion_Program_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','exclusiontype',COUNT(__d4(__NL(Gov_Debarred_Exclusion_Type_))),COUNT(__d4(__NN(Gov_Debarred_Exclusion_Type_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','excludingagency',COUNT(__d4(__NL(Gov_Debarred_Excluding_Agency_))),COUNT(__d4(__NN(Gov_Debarred_Excluding_Agency_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','activedate',COUNT(__d4(__NL(Gov_Debarred_Active_Date_))),COUNT(__d4(__NN(Gov_Debarred_Active_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','TerminationDate',COUNT(__d4(__NL(Gov_Debarred_Termination_Date_))),COUNT(__d4(__NN(Gov_Debarred_Termination_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.SAM__Key_LinkId_Vault','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Equifax_Business_Data__Key_LinkIds_Vault_Invalid),COUNT(__d5)},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','ultid',COUNT(__d5(__NL(Ult_I_D_))),COUNT(__d5(__NN(Ult_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','orgid',COUNT(__d5(__NL(Org_I_D_))),COUNT(__d5(__NN(Org_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','seleid',COUNT(__d5(__NL(Sele_I_D_))),COUNT(__d5(__NN(Sele_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','EBRNumber',COUNT(__d5(__NL(E_B_R_Number_))),COUNT(__d5(__NN(E_B_R_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','efx_id',COUNT(__d5(__NL(E_F_X_Number_))),COUNT(__d5(__NN(E_F_X_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','DUNSNumber',COUNT(__d5(__NL(D_U_N_S_Number_))),COUNT(__d5(__NN(D_U_N_S_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSKey',COUNT(__d5(__NL(S_O_S_Key_))),COUNT(__d5(__NN(S_O_S_Key_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSEntityDescription',COUNT(__d5(__NL(S_O_S_Entity_Description_))),COUNT(__d5(__NN(S_O_S_Entity_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSNameTypeDescription',COUNT(__d5(__NL(S_O_S_Name_Type_Description_))),COUNT(__d5(__NN(S_O_S_Name_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSProcessDate',COUNT(__d5(__NL(S_O_S_Process_Date_))),COUNT(__d5(__NN(S_O_S_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSStatusCode',COUNT(__d5(__NL(S_O_S_Status_Code_))),COUNT(__d5(__NN(S_O_S_Status_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSStatusDescription',COUNT(__d5(__NL(S_O_S_Status_Description_))),COUNT(__d5(__NN(S_O_S_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSStatusDate',COUNT(__d5(__NL(S_O_S_Status_Date_))),COUNT(__d5(__NN(S_O_S_Status_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSIncorporationState',COUNT(__d5(__NL(S_O_S_Incorporation_State_))),COUNT(__d5(__NN(S_O_S_Incorporation_State_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSIncorporationDate',COUNT(__d5(__NL(S_O_S_Incorporation_Date_))),COUNT(__d5(__NN(S_O_S_Incorporation_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSForeignStateCode',COUNT(__d5(__NL(S_O_S_Foreign_State_Code_))),COUNT(__d5(__NN(S_O_S_Foreign_State_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSForeignStateDate',COUNT(__d5(__NL(S_O_S_Foreign_State_Date_))),COUNT(__d5(__NN(S_O_S_Foreign_State_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSForeignDomesticIndicator',COUNT(__d5(__NL(S_O_S_Foreign_Domestic_Indicator_))),COUNT(__d5(__NN(S_O_S_Foreign_Domestic_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSOriginalBusinessTypeDescription',COUNT(__d5(__NL(S_O_S_Original_Business_Type_Description_))),COUNT(__d5(__NN(S_O_S_Original_Business_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSOriginalOrgStructureDescription',COUNT(__d5(__NL(S_O_S_Original_Org_Structure_Description_))),COUNT(__d5(__NN(S_O_S_Original_Org_Structure_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSOriginalCharterNumber',COUNT(__d5(__NL(S_O_S_Original_Charter_Number_))),COUNT(__d5(__NN(S_O_S_Original_Charter_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSTermExistCode',COUNT(__d5(__NL(S_O_S_Term_Exist_Code_))),COUNT(__d5(__NN(S_O_S_Term_Exist_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSRegisteredAgentName',COUNT(__d5(__NL(S_O_S_Registered_Agent_Name_))),COUNT(__d5(__NN(S_O_S_Registered_Agent_Name_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSRegisteredAgentEffectiveDate',COUNT(__d5(__NL(S_O_S_Registered_Agent_Effective_Date_))),COUNT(__d5(__NN(S_O_S_Registered_Agent_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSRegisteredAgentDateFirstSeen',COUNT(__d5(__NL(S_O_S_Registered_Agent_Date_First_Seen_))),COUNT(__d5(__NN(S_O_S_Registered_Agent_Date_First_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSRegisteredAgentDateLastSeen',COUNT(__d5(__NL(S_O_S_Registered_Agent_Date_Last_Seen_))),COUNT(__d5(__NN(S_O_S_Registered_Agent_Date_Last_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','SOSCode',COUNT(__d5(__NL(S_O_S_Code_))),COUNT(__d5(__NN(S_O_S_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','Filing_Code',COUNT(__d5(__NL(Filing___Code_))),COUNT(__d5(__NN(Filing___Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RegistrationStatus',COUNT(__d5(__NL(Registration_Status_))),COUNT(__d5(__NN(Registration_Status_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RegistrationStatusDescription',COUNT(__d5(__NL(Registration_Status_Description_))),COUNT(__d5(__NN(Registration_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','EBRProcessDate',COUNT(__d5(__NL(E_B_R_Process_Date_))),COUNT(__d5(__NN(E_B_R_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementPlanBeginDate',COUNT(__d5(__NL(Retirement_Plan_Begin_Date_))),COUNT(__d5(__NN(Retirement_Plan_Begin_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementPlanEffectiveDate',COUNT(__d5(__NL(Retirement_Plan_Effective_Date_))),COUNT(__d5(__NN(Retirement_Plan_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementPlanEntityIndicator',COUNT(__d5(__NL(Retirement_Plan_Entity_Indicator_))),COUNT(__d5(__NN(Retirement_Plan_Entity_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementTotalParticipants',COUNT(__d5(__NL(Retirement_Total_Participants_))),COUNT(__d5(__NN(Retirement_Total_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementTotalActiveParticipants',COUNT(__d5(__NL(Retirement_Total_Active_Participants_))),COUNT(__d5(__NN(Retirement_Total_Active_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementParticipantReceivingCount',COUNT(__d5(__NL(Retirement_Participant_Receiving_Count_))),COUNT(__d5(__NN(Retirement_Participant_Receiving_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementParticipantFutureCount',COUNT(__d5(__NL(Retirement_Participant_Future_Count_))),COUNT(__d5(__NN(Retirement_Participant_Future_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementReceivingBenefitCount',COUNT(__d5(__NL(Retirement_Receiving_Benefit_Count_))),COUNT(__d5(__NN(Retirement_Receiving_Benefit_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementParticipantAccountBalanceCount',COUNT(__d5(__NL(Retirement_Participant_Account_Balance_Count_))),COUNT(__d5(__NN(Retirement_Participant_Account_Balance_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementParticipantPartiallyVestedCount',COUNT(__d5(__NL(Retirement_Participant_Partially_Vested_Count_))),COUNT(__d5(__NN(Retirement_Participant_Partially_Vested_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementPlanPensionBenefitID',COUNT(__d5(__NL(Retirement_Plan_Pension_Benefit_I_D_))),COUNT(__d5(__NN(Retirement_Plan_Pension_Benefit_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','RetirementPlanWelfareBenefitIndicator',COUNT(__d5(__NL(Retirement_Plan_Welfare_Benefit_Indicator_))),COUNT(__d5(__NN(Retirement_Plan_Welfare_Benefit_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','GovDebarredClassification',COUNT(__d5(__NL(Gov_Debarred_Classification_))),COUNT(__d5(__NN(Gov_Debarred_Classification_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','GovDebarredExclusionProgram',COUNT(__d5(__NL(Gov_Debarred_Exclusion_Program_))),COUNT(__d5(__NN(Gov_Debarred_Exclusion_Program_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','GovDebarredExclusionType',COUNT(__d5(__NL(Gov_Debarred_Exclusion_Type_))),COUNT(__d5(__NN(Gov_Debarred_Exclusion_Type_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','GovDebarredExcludingAgency',COUNT(__d5(__NL(Gov_Debarred_Excluding_Agency_))),COUNT(__d5(__NN(Gov_Debarred_Excluding_Agency_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','GovDebarredActiveDate',COUNT(__d5(__NL(Gov_Debarred_Active_Date_))),COUNT(__d5(__NN(Gov_Debarred_Active_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','GovDebarredTerminationDate',COUNT(__d5(__NL(Gov_Debarred_Termination_Date_))),COUNT(__d5(__NN(Gov_Debarred_Termination_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Equifax_Business_Data__Key_LinkIds_Vault','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Corp2__Key_LinkIDs_Vault_Invalid),COUNT(__d6)},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','ultid',COUNT(__d6(__NL(Ult_I_D_))),COUNT(__d6(__NN(Ult_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','orgid',COUNT(__d6(__NL(Org_I_D_))),COUNT(__d6(__NN(Org_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','seleid',COUNT(__d6(__NL(Sele_I_D_))),COUNT(__d6(__NN(Sele_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','EBRNumber',COUNT(__d6(__NL(E_B_R_Number_))),COUNT(__d6(__NN(E_B_R_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','EFXNumber',COUNT(__d6(__NL(E_F_X_Number_))),COUNT(__d6(__NN(E_F_X_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','DUNSNumber',COUNT(__d6(__NL(D_U_N_S_Number_))),COUNT(__d6(__NN(D_U_N_S_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_key',COUNT(__d6(__NL(S_O_S_Key_))),COUNT(__d6(__NN(S_O_S_Key_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_entity_desc',COUNT(__d6(__NL(S_O_S_Entity_Description_))),COUNT(__d6(__NN(S_O_S_Entity_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_ln_name_type_desc',COUNT(__d6(__NL(S_O_S_Name_Type_Description_))),COUNT(__d6(__NN(S_O_S_Name_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_process_date',COUNT(__d6(__NL(S_O_S_Process_Date_))),COUNT(__d6(__NN(S_O_S_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_status_cd',COUNT(__d6(__NL(S_O_S_Status_Code_))),COUNT(__d6(__NN(S_O_S_Status_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_status_desc',COUNT(__d6(__NL(S_O_S_Status_Description_))),COUNT(__d6(__NN(S_O_S_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_status_date',COUNT(__d6(__NL(S_O_S_Status_Date_))),COUNT(__d6(__NN(S_O_S_Status_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_inc_state',COUNT(__d6(__NL(S_O_S_Incorporation_State_))),COUNT(__d6(__NN(S_O_S_Incorporation_State_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_inc_date',COUNT(__d6(__NL(S_O_S_Incorporation_Date_))),COUNT(__d6(__NN(S_O_S_Incorporation_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_forgn_state_cd',COUNT(__d6(__NL(S_O_S_Foreign_State_Code_))),COUNT(__d6(__NN(S_O_S_Foreign_State_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_forgn_date',COUNT(__d6(__NL(S_O_S_Foreign_State_Date_))),COUNT(__d6(__NN(S_O_S_Foreign_State_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_foreign_domestic_ind',COUNT(__d6(__NL(S_O_S_Foreign_Domestic_Indicator_))),COUNT(__d6(__NN(S_O_S_Foreign_Domestic_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_orig_bus_type_desc',COUNT(__d6(__NL(S_O_S_Original_Business_Type_Description_))),COUNT(__d6(__NN(S_O_S_Original_Business_Type_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_orig_org_structure_desc',COUNT(__d6(__NL(S_O_S_Original_Org_Structure_Description_))),COUNT(__d6(__NN(S_O_S_Original_Org_Structure_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_orig_sos_charter_nbr',COUNT(__d6(__NL(S_O_S_Original_Charter_Number_))),COUNT(__d6(__NN(S_O_S_Original_Charter_Number_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_term_exist_cd',COUNT(__d6(__NL(S_O_S_Term_Exist_Code_))),COUNT(__d6(__NN(S_O_S_Term_Exist_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_ra_name',COUNT(__d6(__NL(S_O_S_Registered_Agent_Name_))),COUNT(__d6(__NN(S_O_S_Registered_Agent_Name_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_ra_effective_date',COUNT(__d6(__NL(S_O_S_Registered_Agent_Effective_Date_))),COUNT(__d6(__NN(S_O_S_Registered_Agent_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_ra_dt_first_seen',COUNT(__d6(__NL(S_O_S_Registered_Agent_Date_First_Seen_))),COUNT(__d6(__NN(S_O_S_Registered_Agent_Date_First_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','corp_ra_dt_last_seen',COUNT(__d6(__NL(S_O_S_Registered_Agent_Date_Last_Seen_))),COUNT(__d6(__NN(S_O_S_Registered_Agent_Date_Last_Seen_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','SOSCode',COUNT(__d6(__NL(S_O_S_Code_))),COUNT(__d6(__NN(S_O_S_Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','Filing_Code',COUNT(__d6(__NL(Filing___Code_))),COUNT(__d6(__NN(Filing___Code_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RegistrationStatus',COUNT(__d6(__NL(Registration_Status_))),COUNT(__d6(__NN(Registration_Status_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RegistrationStatusDescription',COUNT(__d6(__NL(Registration_Status_Description_))),COUNT(__d6(__NN(Registration_Status_Description_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','EBRProcessDate',COUNT(__d6(__NL(E_B_R_Process_Date_))),COUNT(__d6(__NN(E_B_R_Process_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementPlanBeginDate',COUNT(__d6(__NL(Retirement_Plan_Begin_Date_))),COUNT(__d6(__NN(Retirement_Plan_Begin_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementPlanEffectiveDate',COUNT(__d6(__NL(Retirement_Plan_Effective_Date_))),COUNT(__d6(__NN(Retirement_Plan_Effective_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementPlanEntityIndicator',COUNT(__d6(__NL(Retirement_Plan_Entity_Indicator_))),COUNT(__d6(__NN(Retirement_Plan_Entity_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementTotalParticipants',COUNT(__d6(__NL(Retirement_Total_Participants_))),COUNT(__d6(__NN(Retirement_Total_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementTotalActiveParticipants',COUNT(__d6(__NL(Retirement_Total_Active_Participants_))),COUNT(__d6(__NN(Retirement_Total_Active_Participants_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementParticipantReceivingCount',COUNT(__d6(__NL(Retirement_Participant_Receiving_Count_))),COUNT(__d6(__NN(Retirement_Participant_Receiving_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementParticipantFutureCount',COUNT(__d6(__NL(Retirement_Participant_Future_Count_))),COUNT(__d6(__NN(Retirement_Participant_Future_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementReceivingBenefitCount',COUNT(__d6(__NL(Retirement_Receiving_Benefit_Count_))),COUNT(__d6(__NN(Retirement_Receiving_Benefit_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementParticipantAccountBalanceCount',COUNT(__d6(__NL(Retirement_Participant_Account_Balance_Count_))),COUNT(__d6(__NN(Retirement_Participant_Account_Balance_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementParticipantPartiallyVestedCount',COUNT(__d6(__NL(Retirement_Participant_Partially_Vested_Count_))),COUNT(__d6(__NN(Retirement_Participant_Partially_Vested_Count_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementPlanPensionBenefitID',COUNT(__d6(__NL(Retirement_Plan_Pension_Benefit_I_D_))),COUNT(__d6(__NN(Retirement_Plan_Pension_Benefit_I_D_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','RetirementPlanWelfareBenefitIndicator',COUNT(__d6(__NL(Retirement_Plan_Welfare_Benefit_Indicator_))),COUNT(__d6(__NN(Retirement_Plan_Welfare_Benefit_Indicator_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','GovDebarredClassification',COUNT(__d6(__NL(Gov_Debarred_Classification_))),COUNT(__d6(__NN(Gov_Debarred_Classification_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','GovDebarredExclusionProgram',COUNT(__d6(__NL(Gov_Debarred_Exclusion_Program_))),COUNT(__d6(__NN(Gov_Debarred_Exclusion_Program_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','GovDebarredExclusionType',COUNT(__d6(__NL(Gov_Debarred_Exclusion_Type_))),COUNT(__d6(__NN(Gov_Debarred_Exclusion_Type_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','GovDebarredExcludingAgency',COUNT(__d6(__NL(Gov_Debarred_Excluding_Agency_))),COUNT(__d6(__NN(Gov_Debarred_Excluding_Agency_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','GovDebarredActiveDate',COUNT(__d6(__NL(Gov_Debarred_Active_Date_))),COUNT(__d6(__NN(Gov_Debarred_Active_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','GovDebarredTerminationDate',COUNT(__d6(__NL(Gov_Debarred_Termination_Date_))),COUNT(__d6(__NN(Gov_Debarred_Termination_Date_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'BusinessSeleOverflow','PublicRecords_KEL.Files.NonFCRA.Corp2__Key_LinkIDs_Vault','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
