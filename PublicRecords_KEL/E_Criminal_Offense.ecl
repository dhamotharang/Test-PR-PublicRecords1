//HPCC Systems KEL Compiler Version 0.11.4
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Criminal_Offense(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nkdate Court_Date_;
    KEL.typ.nstr Court_Description_;
    KEL.typ.nkdate Case_Date_;
    KEL.typ.nstr Case_Type_Description_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Court_Final_Plea_;
    KEL.typ.nstr Court_Offense_Code_;
    KEL.typ.nstr Court_Offense_Description_;
    KEL.typ.nstr Court_Offense_Additional_Description_;
    KEL.typ.nstr Court_Offense_Level_;
    KEL.typ.nstr Court_Statute_;
    KEL.typ.nkdate Court_Disposition_Date_;
    KEL.typ.nstr Court_Disposition_Code_;
    KEL.typ.nstr Court_Disposition_Description_;
    KEL.typ.nstr Court_Additional_Disposition_Description_;
    KEL.typ.nkdate Date_Of_Appeal_;
    KEL.typ.nkdate Dateof_Verdict_;
    KEL.typ.nstr Court_County_;
    KEL.typ.nstr Court_Offense_Level_Mapped_;
    KEL.typ.nint Court_Cost_;
    KEL.typ.nint Court_Fine_;
    KEL.typ.nstr Suspended_Court_Fine_;
    KEL.typ.nstr Offense_Town_;
    KEL.typ.nstr Arrest_Offense_Level_Mapped_;
    KEL.typ.nstr Persistent_Offense_Key_;
    KEL.typ.nstr State_Of_Source_;
    KEL.typ.nstr County_Of_Source_;
    KEL.typ.nstr Department_Of_Law_Enforcement_Number_;
    KEL.typ.nstr Federal_Bureau_Of_Investigations_Number_;
    KEL.typ.nstr Inmate_Number_;
    KEL.typ.nstr State_Identification_Number_Assigned_;
    KEL.typ.nint Data_Type_;
    KEL.typ.nstr Data_Source_;
    KEL.typ.nstr Offense_Score_;
    KEL.typ.nstr Offense_Type_;
    KEL.typ.nkdate Date_Of_Offence_;
    KEL.typ.nstr Traffic_Ticket_Number_;
    KEL.typ.nint Offense_Category_;
    KEL.typ.nkdate Date_Of_Arrest_;
    KEL.typ.nstr Agency_Name_;
    KEL.typ.nint Agency_Case_Number_;
    KEL.typ.nstr Arrest_Offense_Code_;
    KEL.typ.nstr Arrest_Initial_Charge_Description_;
    KEL.typ.nstr Arrest_Amended_Charge_Description_;
    KEL.typ.nstr Arrest_Offence_Type_Description_;
    KEL.typ.nstr Arrest_Offense_Level_;
    KEL.typ.nkdate Date_Of_Disposition_For_Initial_Charge_;
    KEL.typ.nstr Initial_Charge_Disposition_Description_;
    KEL.typ.nstr Additional_Disposition_Description_;
    KEL.typ.nint Offender_Level_;
    KEL.typ.nkdate Offense_Date_;
    KEL.typ.nstr Traffic_Flag_;
    KEL.typ.nstr Conviction_Flag_;
    KEL.typ.nstr Fcra_Offense_Key_;
    KEL.typ.nkdate Fcra_Date_;
    KEL.typ.nstr Fcra_Date_Type_;
    KEL.typ.nkdate Conviction_Override_Date_;
    KEL.typ.nstr Conviction_Override_Date_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED1 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),offenderkey(Offender_Key_),casenumber(Case_Number_:\'\'),courtdate(Court_Date_:DATE),courtdescription(Court_Description_:\'\'),casedate(Case_Date_:DATE),casetypedescription(Case_Type_Description_:\'\'),courtcode(Court_Code_:\'\'),courtfinalplea(Court_Final_Plea_:\'\'),courtoffensecode(Court_Offense_Code_:\'\'),courtoffensedescription(Court_Offense_Description_:\'\'),courtoffenseadditionaldescription(Court_Offense_Additional_Description_:\'\'),courtoffenselevel(Court_Offense_Level_:\'\'),courtstatute(Court_Statute_:\'\'),courtdispositiondate(Court_Disposition_Date_:DATE),courtdispositioncode(Court_Disposition_Code_:\'\'),courtdispositiondescription(Court_Disposition_Description_:\'\'),courtadditionaldispositiondescription(Court_Additional_Disposition_Description_:\'\'),dateofappeal(Date_Of_Appeal_:DATE),dateofverdict(Dateof_Verdict_:DATE),courtcounty(Court_County_:\'\'),courtoffenselevelmapped(Court_Offense_Level_Mapped_:\'\'),courtcost(Court_Cost_:0),courtfine(Court_Fine_:0),suspendedcourtfine(Suspended_Court_Fine_:\'\'),offensetown(Offense_Town_:\'\'),arrestoffenselevelmapped(Arrest_Offense_Level_Mapped_:\'\'),persistentoffensekey(Persistent_Offense_Key_:\'\'),stateofsource(State_Of_Source_:\'\'),countyofsource(County_Of_Source_:\'\'),departmentoflawenforcementnumber(Department_Of_Law_Enforcement_Number_:\'\'),federalbureauofinvestigationsnumber(Federal_Bureau_Of_Investigations_Number_:\'\'),inmatenumber(Inmate_Number_:\'\'),stateidentificationnumberassigned(State_Identification_Number_Assigned_:\'\'),datatype(Data_Type_:0),datasource(Data_Source_:\'\'),offensescore(Offense_Score_:\'\'),offensetype(Offense_Type_:\'\'),dateofoffence(Date_Of_Offence_:DATE),trafficticketnumber(Traffic_Ticket_Number_:\'\'),offensecategory(Offense_Category_:0),dateofarrest(Date_Of_Arrest_:DATE),agencyname(Agency_Name_:\'\'),agencycasenumber(Agency_Case_Number_:0),arrestoffensecode(Arrest_Offense_Code_:\'\'),arrestinitialchargedescription(Arrest_Initial_Charge_Description_:\'\'),arrestamendedchargedescription(Arrest_Amended_Charge_Description_:\'\'),arrestoffencetypedescription(Arrest_Offence_Type_Description_:\'\'),arrestoffenselevel(Arrest_Offense_Level_:\'\'),dateofdispositionforinitialcharge(Date_Of_Disposition_For_Initial_Charge_:DATE),initialchargedispositiondescription(Initial_Charge_Disposition_Description_:\'\'),additionaldispositiondescription(Additional_Disposition_Description_:\'\'),offenderlevel(Offender_Level_:0),offensedate(Offense_Date_:DATE),trafficflag(Traffic_Flag_:\'\'),convictionflag(Conviction_Flag_:\'\'),fcraoffensekey(Fcra_Offense_Key_:\'\'),fcradate(Fcra_Date_:DATE),fcradatetype(Fcra_Date_Type_:\'\'),convictionoverridedate(Conviction_Override_Date_:DATE),convictionoverridedatetype(Conviction_Override_Date_Type_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Offenders_Risk,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d1_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Punishment,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d2_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Offenses,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d3_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Court_Offenses,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d4_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d5_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d6_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim + __d4_Trim + __d5_Trim + __d6_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  EXPORT Lookup := PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(UID),offender_key(Offender_Key_),case_num(Case_Number_:\'\'),courtdate(Court_Date_:DATE),courtdescription(Court_Description_:\'\'),casedate(Case_Date_:DATE),casetypedescription(Case_Type_Description_:\'\'),courtcode(Court_Code_:\'\'),courtfinalplea(Court_Final_Plea_:\'\'),courtoffensecode(Court_Offense_Code_:\'\'),courtoffensedescription(Court_Offense_Description_:\'\'),courtoffenseadditionaldescription(Court_Offense_Additional_Description_:\'\'),courtoffenselevel(Court_Offense_Level_:\'\'),courtstatute(Court_Statute_:\'\'),courtdispositiondate(Court_Disposition_Date_:DATE),courtdispositioncode(Court_Disposition_Code_:\'\'),courtdispositiondescription(Court_Disposition_Description_:\'\'),courtadditionaldispositiondescription(Court_Additional_Disposition_Description_:\'\'),dateofappeal(Date_Of_Appeal_:DATE),dateofverdict(Dateof_Verdict_:DATE),courtcounty(Court_County_:\'\'),courtoffenselevelmapped(Court_Offense_Level_Mapped_:\'\'),courtcost(Court_Cost_:0),courtfine(Court_Fine_:0),suspendedcourtfine(Suspended_Court_Fine_:\'\'),offensetown(Offense_Town_:\'\'),arrestoffenselevelmapped(Arrest_Offense_Level_Mapped_:\'\'),persistentoffensekey(Persistent_Offense_Key_:\'\'),stateofsource(State_Of_Source_:\'\'),countyofsource(County_Of_Source_:\'\'),departmentoflawenforcementnumber(Department_Of_Law_Enforcement_Number_:\'\'),federalbureauofinvestigationsnumber(Federal_Bureau_Of_Investigations_Number_:\'\'),inmatenumber(Inmate_Number_:\'\'),stateidentificationnumberassigned(State_Identification_Number_Assigned_:\'\'),datatype(Data_Type_:0),datasource(Data_Source_:\'\'),offense_score(Offense_Score_:\'\'),offensetype(Offense_Type_:\'\'),dateofoffence(Date_Of_Offence_:DATE),trafficticketnumber(Traffic_Ticket_Number_:\'\'),offensecategory(Offense_Category_:0),dateofarrest(Date_Of_Arrest_:DATE),agencyname(Agency_Name_:\'\'),agencycasenumber(Agency_Case_Number_:0),arrestoffensecode(Arrest_Offense_Code_:\'\'),arrestinitialchargedescription(Arrest_Initial_Charge_Description_:\'\'),arrestamendedchargedescription(Arrest_Amended_Charge_Description_:\'\'),arrestoffencetypedescription(Arrest_Offence_Type_Description_:\'\'),arrestoffenselevel(Arrest_Offense_Level_:\'\'),dateofdispositionforinitialcharge(Date_Of_Disposition_For_Initial_Charge_:DATE),initialchargedispositiondescription(Initial_Charge_Disposition_Description_:\'\'),additionaldispositiondescription(Additional_Disposition_Description_:\'\'),criminal_offender_level(Offender_Level_:0),offensedate(Offense_Date_:DATE),trafficflag(Traffic_Flag_:\'\'),convictionflag(Conviction_Flag_:\'\'),fcraoffensekey(Fcra_Offense_Key_:\'\'),fcradate(Fcra_Date_:DATE),fcradatetype(Fcra_Date_Type_:\'\'),convictionoverridedate(Conviction_Override_Date_:DATE),convictionoverridedatetype(Conviction_Override_Date_Type_:\'\'),src(Source_:\'\'),earliest_offense_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_nonFCRA;
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders_Risk,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders_Risk),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenders_Risk);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'UID(UID),offender_key(Offender_Key_),casenumber(Case_Number_:\'\'),courtdate(Court_Date_:DATE),courtdescription(Court_Description_:\'\'),casedate(Case_Date_:DATE),casetypedescription(Case_Type_Description_:\'\'),courtcode(Court_Code_:\'\'),courtfinalplea(Court_Final_Plea_:\'\'),courtoffensecode(Court_Offense_Code_:\'\'),courtoffensedescription(Court_Offense_Description_:\'\'),courtoffenseadditionaldescription(Court_Offense_Additional_Description_:\'\'),courtoffenselevel(Court_Offense_Level_:\'\'),courtstatute(Court_Statute_:\'\'),courtdispositiondate(Court_Disposition_Date_:DATE),courtdispositioncode(Court_Disposition_Code_:\'\'),courtdispositiondescription(Court_Disposition_Description_:\'\'),courtadditionaldispositiondescription(Court_Additional_Disposition_Description_:\'\'),dateofappeal(Date_Of_Appeal_:DATE),dateofverdict(Dateof_Verdict_:DATE),courtcounty(Court_County_:\'\'),courtoffenselevelmapped(Court_Offense_Level_Mapped_:\'\'),courtcost(Court_Cost_:0),courtfine(Court_Fine_:0),suspendedcourtfine(Suspended_Court_Fine_:\'\'),offensetown(Offense_Town_:\'\'),arrestoffenselevelmapped(Arrest_Offense_Level_Mapped_:\'\'),persistentoffensekey(Persistent_Offense_Key_:\'\'),stateofsource(State_Of_Source_:\'\'),countyofsource(County_Of_Source_:\'\'),departmentoflawenforcementnumber(Department_Of_Law_Enforcement_Number_:\'\'),federalbureauofinvestigationsnumber(Federal_Bureau_Of_Investigations_Number_:\'\'),inmatenumber(Inmate_Number_:\'\'),stateidentificationnumberassigned(State_Identification_Number_Assigned_:\'\'),datatype(Data_Type_:0),datasource(Data_Source_:\'\'),offensescore(Offense_Score_:\'\'),offensetype(Offense_Type_:\'\'),dateofoffence(Date_Of_Offence_:DATE),trafficticketnumber(Traffic_Ticket_Number_:\'\'),offensecategory(Offense_Category_:0),dateofarrest(Date_Of_Arrest_:DATE),agencyname(Agency_Name_:\'\'),agencycasenumber(Agency_Case_Number_:0),arrestoffensecode(Arrest_Offense_Code_:\'\'),arrestinitialchargedescription(Arrest_Initial_Charge_Description_:\'\'),arrestamendedchargedescription(Arrest_Amended_Charge_Description_:\'\'),arrestoffencetypedescription(Arrest_Offence_Type_Description_:\'\'),arrestoffenselevel(Arrest_Offense_Level_:\'\'),dateofdispositionforinitialcharge(Date_Of_Disposition_For_Initial_Charge_:DATE),initialchargedispositiondescription(Initial_Charge_Disposition_Description_:\'\'),additionaldispositiondescription(Additional_Disposition_Description_:\'\'),offenderlevel(Offender_Level_:0),offensedate(Offense_Date_:DATE),trafficflag(Traffic_Flag_:\'\'),convictionflag(Conviction_Flag_:\'\'),fcraoffensekey(Fcra_Offense_Key_:\'\'),fcradate(Fcra_Date_:DATE),fcradatetype(Fcra_Date_Type_:\'\'),conviction_override_date(Conviction_Override_Date_:DATE),conviction_override_date_type(Conviction_Override_Date_Type_:\'\'),event_dt(Date_First_Seen_:EPOCH),process_date(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('DC');
    SELF.__Permits := CFG_Compile.Permit_nonFCRA;
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Punishment,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Punishment),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Punishment);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Punishment_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'UID(UID),offender_key(Offender_Key_),case_num(Case_Number_:\'\'),courtdate(Court_Date_:DATE),court_desc(Court_Description_:\'\'),casedate(Case_Date_:DATE),casetypedescription(Case_Type_Description_:\'\'),courtcode(Court_Code_:\'\'),courtfinalplea(Court_Final_Plea_:\'\'),off_code(Court_Offense_Code_:\'\'),off_desc_1(Court_Offense_Description_:\'\'),off_desc_2(Court_Offense_Additional_Description_:\'\'),off_lev(Court_Offense_Level_:\'\'),courtstatute(Court_Statute_:\'\'),ct_disp_dt(Court_Disposition_Date_:DATE),courtdispositioncode(Court_Disposition_Code_:\'\'),ct_disp_desc_1(Court_Disposition_Description_:\'\'),ct_disp_desc_2(Court_Additional_Disposition_Description_:\'\'),dateofappeal(Date_Of_Appeal_:DATE),dateofverdict(Dateof_Verdict_:DATE),court_county(Court_County_:\'\'),courtoffenselevelmapped(Court_Offense_Level_Mapped_:\'\'),courtcost(Court_Cost_:0),courtfine(Court_Fine_:0),suspendedcourtfine(Suspended_Court_Fine_:\'\'),offensetown(Offense_Town_:\'\'),arrestoffenselevelmapped(Arrest_Offense_Level_Mapped_:\'\'),offense_persistent_id(Persistent_Offense_Key_:\'\'),orig_state(State_Of_Source_:\'\'),countyofsource(County_Of_Source_:\'\'),departmentoflawenforcementnumber(Department_Of_Law_Enforcement_Number_:\'\'),federalbureauofinvestigationsnumber(Federal_Bureau_Of_Investigations_Number_:\'\'),inmatenumber(Inmate_Number_:\'\'),stateidentificationnumberassigned(State_Identification_Number_Assigned_:\'\'),data_type(Data_Type_:0),source_file(Data_Source_:\'\'),offense_score(Offense_Score_:\'\'),off_typ(Offense_Type_:\'\'),dateofoffence(Date_Of_Offence_:DATE),trafficticketnumber(Traffic_Ticket_Number_:\'\'),offensecategory(Offense_Category_:0),arr_date(Date_Of_Arrest_:DATE),agencyname(Agency_Name_:\'\'),agencycasenumber(Agency_Case_Number_:0),arrestoffensecode(Arrest_Offense_Code_:\'\'),arrestinitialchargedescription(Arrest_Initial_Charge_Description_:\'\'),arrestamendedchargedescription(Arrest_Amended_Charge_Description_:\'\'),arrestoffencetypedescription(Arrest_Offence_Type_Description_:\'\'),arrestoffenselevel(Arrest_Offense_Level_:\'\'),dateofdispositionforinitialcharge(Date_Of_Disposition_For_Initial_Charge_:DATE),initialchargedispositiondescription(Initial_Charge_Disposition_Description_:\'\'),additionaldispositiondescription(Additional_Disposition_Description_:\'\'),offenderlevel(Offender_Level_:0),off_date(Offense_Date_:DATE),fcra_traffic_flag(Traffic_Flag_:\'\'),fcra_conviction_flag(Conviction_Flag_:\'\'),fcra_offense_key(Fcra_Offense_Key_:\'\'),fcra_date(Fcra_Date_:DATE),fcra_date_type(Fcra_Date_Type_:\'\'),conviction_override_date(Conviction_Override_Date_:DATE),conviction_override_date_type(Conviction_Override_Date_Type_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('DC');
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenses),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenses);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'UID(UID),offender_key(Offender_Key_),court_case_number(Case_Number_:\'\'),court_dt(Court_Date_:DATE),court_desc(Court_Description_:\'\'),casedate(Case_Date_:DATE),casetypedescription(Case_Type_Description_:\'\'),court_cd(Court_Code_:\'\'),court_final_plea(Court_Final_Plea_:\'\'),court_off_code(Court_Offense_Code_:\'\'),court_off_desc_1(Court_Offense_Description_:\'\'),court_off_desc_2(Court_Offense_Additional_Description_:\'\'),court_off_lev(Court_Offense_Level_:\'\'),court_statute(Court_Statute_:\'\'),court_disp_date(Court_Disposition_Date_:DATE),court_disp_code(Court_Disposition_Code_:\'\'),court_disp_desc_1(Court_Disposition_Description_:\'\'),court_disp_desc_2(Court_Additional_Disposition_Description_:\'\'),appeal_date(Date_Of_Appeal_:DATE),convict_dt(Dateof_Verdict_:DATE),court_county(Court_County_:\'\'),court_off_lev_mapped(Court_Offense_Level_Mapped_:\'\'),sent_court_cost(Court_Cost_:0),sent_court_fine(Court_Fine_:0),sent_susp_court_fine(Suspended_Court_Fine_:\'\'),offense_town(Offense_Town_:\'\'),arr_off_lev_mapped(Arrest_Offense_Level_Mapped_:\'\'),offense_persistent_id(Persistent_Offense_Key_:\'\'),state_origin(State_Of_Source_:\'\'),countyofsource(County_Of_Source_:\'\'),departmentoflawenforcementnumber(Department_Of_Law_Enforcement_Number_:\'\'),federalbureauofinvestigationsnumber(Federal_Bureau_Of_Investigations_Number_:\'\'),inmatenumber(Inmate_Number_:\'\'),stateidentificationnumberassigned(State_Identification_Number_Assigned_:\'\'),data_type(Data_Type_:0),source_file(Data_Source_:\'\'),offense_score(Offense_Score_:\'\'),offensetype(Offense_Type_:\'\'),dateofoffence(Date_Of_Offence_:DATE),traffic_ticket_number(Traffic_Ticket_Number_:\'\'),offense_category(Offense_Category_:0),arr_date(Date_Of_Arrest_:DATE),le_agency_desc(Agency_Name_:\'\'),le_agency_case_number(Agency_Case_Number_:0),arr_off_code(Arrest_Offense_Code_:\'\'),arr_off_desc_1(Arrest_Initial_Charge_Description_:\'\'),arr_off_desc_2(Arrest_Amended_Charge_Description_:\'\'),arr_off_type_desc(Arrest_Offence_Type_Description_:\'\'),arr_off_lev(Arrest_Offense_Level_:\'\'),arr_disp_date(Date_Of_Disposition_For_Initial_Charge_:DATE),arr_disp_desc_1(Initial_Charge_Disposition_Description_:\'\'),arr_disp_desc_2(Additional_Disposition_Description_:\'\'),offenderlevel(Offender_Level_:0),off_date(Offense_Date_:DATE),fcra_traffic_flag(Traffic_Flag_:\'\'),fcra_conviction_flag(Conviction_Flag_:\'\'),fcra_offense_key(Fcra_Offense_Key_:\'\'),fcra_date(Fcra_Date_:DATE),fcra_date_type(Fcra_Date_Type_:\'\'),conviction_override_date(Conviction_Override_Date_:DATE),conviction_override_date_type(Conviction_Override_Date_Type_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Court_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Court_Offenses),SELF:=RIGHT));
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Court_Offenses);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(__d3_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT)));
  SHARED __Mapping4 := 'UID(UID),offender_key(Offender_Key_),case_num(Case_Number_:\'\'),courtdate(Court_Date_:DATE),courtdescription(Court_Description_:\'\'),date(Case_Date_:DATE),casetypedescription(Case_Type_Description_:\'\'),courtcode(Court_Code_:\'\'),courtfinalplea(Court_Final_Plea_:\'\'),courtoffensecode(Court_Offense_Code_:\'\'),courtoffensedescription(Court_Offense_Description_:\'\'),courtoffenseadditionaldescription(Court_Offense_Additional_Description_:\'\'),courtoffenselevel(Court_Offense_Level_:\'\'),courtstatute(Court_Statute_:\'\'),courtdispositiondate(Court_Disposition_Date_:DATE),courtdispositioncode(Court_Disposition_Code_:\'\'),courtdispositiondescription(Court_Disposition_Description_:\'\'),courtadditionaldispositiondescription(Court_Additional_Disposition_Description_:\'\'),dateofappeal(Date_Of_Appeal_:DATE),dateofverdict(Dateof_Verdict_:DATE),courtcounty(Court_County_:\'\'),courtoffenselevelmapped(Court_Offense_Level_Mapped_:\'\'),courtcost(Court_Cost_:0),courtfine(Court_Fine_:0),suspendedcourtfine(Suspended_Court_Fine_:\'\'),offensetown(Offense_Town_:\'\'),arrestoffenselevelmapped(Arrest_Offense_Level_Mapped_:\'\'),persistentoffensekey(Persistent_Offense_Key_:\'\'),stateofsource(State_Of_Source_:\'\'),countyofsource(County_Of_Source_:\'\'),departmentoflawenforcementnumber(Department_Of_Law_Enforcement_Number_:\'\'),federalbureauofinvestigationsnumber(Federal_Bureau_Of_Investigations_Number_:\'\'),inmatenumber(Inmate_Number_:\'\'),stateidentificationnumberassigned(State_Identification_Number_Assigned_:\'\'),datatype(Data_Type_:0),datasource(Data_Source_:\'\'),offense_score(Offense_Score_:\'\'),offensetype(Offense_Type_:\'\'),dateofoffence(Date_Of_Offence_:DATE),trafficticketnumber(Traffic_Ticket_Number_:\'\'),offensecategory(Offense_Category_:0),dateofarrest(Date_Of_Arrest_:DATE),agencyname(Agency_Name_:\'\'),agencycasenumber(Agency_Case_Number_:0),arrestoffensecode(Arrest_Offense_Code_:\'\'),arrestinitialchargedescription(Arrest_Initial_Charge_Description_:\'\'),arrestamendedchargedescription(Arrest_Amended_Charge_Description_:\'\'),arrestoffencetypedescription(Arrest_Offence_Type_Description_:\'\'),arrestoffenselevel(Arrest_Offense_Level_:\'\'),dateofdispositionforinitialcharge(Date_Of_Disposition_For_Initial_Charge_:DATE),initialchargedispositiondescription(Initial_Charge_Disposition_Description_:\'\'),additionaldispositiondescription(Additional_Disposition_Description_:\'\'),offenderlevel(Offender_Level_:0),offensedate(Offense_Date_:DATE),fcra_traffic_flag(Traffic_Flag_:\'\'),fcra_conviction_flag(Conviction_Flag_:\'\'),fcraoffensekey(Fcra_Offense_Key_:\'\'),fcradate(Fcra_Date_:DATE),fcradatetype(Fcra_Date_Type_:\'\'),convictionoverridedate(Conviction_Override_Date_:DATE),convictionoverridedatetype(Conviction_Override_Date_Type_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping4_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA),SELF:=RIGHT));
  SHARED __d4_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d4_UID_Mapped := JOIN(__d4_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d4_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA_Invalid := __d4_UID_Mapped(UID = 0);
  SHARED __d4_Prefiltered := __d4_UID_Mapped(UID <> 0);
  SHARED __d4 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4),__Mapping4_Transform(LEFT)));
  SHARED __Mapping5 := 'UID(UID),offender_key(Offender_Key_),case_num(Case_Number_:\'\'),courtdate(Court_Date_:DATE),case_court(Court_Description_:\'\'),case_date(Case_Date_:DATE),case_type_desc(Case_Type_Description_:\'\'),courtcode(Court_Code_:\'\'),courtfinalplea(Court_Final_Plea_:\'\'),courtoffensecode(Court_Offense_Code_:\'\'),courtoffensedescription(Court_Offense_Description_:\'\'),courtoffenseadditionaldescription(Court_Offense_Additional_Description_:\'\'),courtoffenselevel(Court_Offense_Level_:\'\'),courtstatute(Court_Statute_:\'\'),courtdispositiondate(Court_Disposition_Date_:DATE),courtdispositioncode(Court_Disposition_Code_:\'\'),courtdispositiondescription(Court_Disposition_Description_:\'\'),courtadditionaldispositiondescription(Court_Additional_Disposition_Description_:\'\'),dateofappeal(Date_Of_Appeal_:DATE),dateofverdict(Dateof_Verdict_:DATE),courtcounty(Court_County_:\'\'),courtoffenselevelmapped(Court_Offense_Level_Mapped_:\'\'),courtcost(Court_Cost_:0),courtfine(Court_Fine_:0),suspendedcourtfine(Suspended_Court_Fine_:\'\'),offensetown(Offense_Town_:\'\'),arrestoffenselevelmapped(Arrest_Offense_Level_Mapped_:\'\'),persistentoffensekey(Persistent_Offense_Key_:\'\'),stateofsource(State_Of_Source_:\'\'),county_of_origin(County_Of_Source_:\'\'),dle_num(Department_Of_Law_Enforcement_Number_:\'\'),fbi_num(Federal_Bureau_Of_Investigations_Number_:\'\'),doc_num(Inmate_Number_:\'\'),id_num(State_Identification_Number_Assigned_:\'\'),datatype(Data_Type_:0),datasource(Data_Source_:\'\'),offense_score(Offense_Score_:\'\'),offensetype(Offense_Type_:\'\'),dateofoffence(Date_Of_Offence_:DATE),trafficticketnumber(Traffic_Ticket_Number_:\'\'),offensecategory(Offense_Category_:0),dateofarrest(Date_Of_Arrest_:DATE),agencyname(Agency_Name_:\'\'),agencycasenumber(Agency_Case_Number_:0),arrestoffensecode(Arrest_Offense_Code_:\'\'),arrestinitialchargedescription(Arrest_Initial_Charge_Description_:\'\'),arrestamendedchargedescription(Arrest_Amended_Charge_Description_:\'\'),arrestoffencetypedescription(Arrest_Offence_Type_Description_:\'\'),arrestoffenselevel(Arrest_Offense_Level_:\'\'),dateofdispositionforinitialcharge(Date_Of_Disposition_For_Initial_Charge_:DATE),initialchargedispositiondescription(Initial_Charge_Disposition_Description_:\'\'),additionaldispositiondescription(Additional_Disposition_Description_:\'\'),offenderlevel(Offender_Level_:0),offensedate(Offense_Date_:DATE),fcra_traffic_flag(Traffic_Flag_:\'\'),fcra_conviction_flag(Conviction_Flag_:\'\'),fcraoffensekey(Fcra_Offense_Key_:\'\'),fcra_date(Fcra_Date_:DATE|Date_First_Seen_:EPOCH),fcra_date_type(Fcra_Date_Type_:\'\'),conviction_override_date(Conviction_Override_Date_:DATE),conviction_override_date_type(Conviction_Override_Date_Type_:\'\'),src(Source_:\'\'),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping5_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d5_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenders);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d5_UID_Mapped := JOIN(__d5_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d5_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid := __d5_UID_Mapped(UID = 0);
  SHARED __d5_Prefiltered := __d5_UID_Mapped(UID <> 0);
  SHARED __d5 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5),__Mapping5_Transform(LEFT)));
  SHARED __Mapping6 := 'UID(UID),offender_key(Offender_Key_),case_num(Case_Number_:\'\'),courtdate(Court_Date_:DATE),case_court(Court_Description_:\'\'),case_date(Case_Date_:DATE),case_type_desc(Case_Type_Description_:\'\'),courtcode(Court_Code_:\'\'),courtfinalplea(Court_Final_Plea_:\'\'),courtoffensecode(Court_Offense_Code_:\'\'),courtoffensedescription(Court_Offense_Description_:\'\'),courtoffenseadditionaldescription(Court_Offense_Additional_Description_:\'\'),courtoffenselevel(Court_Offense_Level_:\'\'),courtstatute(Court_Statute_:\'\'),courtdispositiondate(Court_Disposition_Date_:DATE),courtdispositioncode(Court_Disposition_Code_:\'\'),courtdispositiondescription(Court_Disposition_Description_:\'\'),courtadditionaldispositiondescription(Court_Additional_Disposition_Description_:\'\'),dateofappeal(Date_Of_Appeal_:DATE),dateofverdict(Dateof_Verdict_:DATE),courtcounty(Court_County_:\'\'),courtoffenselevelmapped(Court_Offense_Level_Mapped_:\'\'),courtcost(Court_Cost_:0),courtfine(Court_Fine_:0),suspendedcourtfine(Suspended_Court_Fine_:\'\'),offensetown(Offense_Town_:\'\'),arrestoffenselevelmapped(Arrest_Offense_Level_Mapped_:\'\'),persistentoffensekey(Persistent_Offense_Key_:\'\'),stateofsource(State_Of_Source_:\'\'),county_of_origin(County_Of_Source_:\'\'),dle_num(Department_Of_Law_Enforcement_Number_:\'\'),fbi_num(Federal_Bureau_Of_Investigations_Number_:\'\'),doc_num(Inmate_Number_:\'\'),id_num(State_Identification_Number_Assigned_:\'\'),datatype(Data_Type_:0),datasource(Data_Source_:\'\'),offense_score(Offense_Score_:\'\'),offensetype(Offense_Type_:\'\'),dateofoffence(Date_Of_Offence_:DATE),trafficticketnumber(Traffic_Ticket_Number_:\'\'),offensecategory(Offense_Category_:0),dateofarrest(Date_Of_Arrest_:DATE),agencyname(Agency_Name_:\'\'),agencycasenumber(Agency_Case_Number_:0),arrestoffensecode(Arrest_Offense_Code_:\'\'),arrestinitialchargedescription(Arrest_Initial_Charge_Description_:\'\'),arrestamendedchargedescription(Arrest_Amended_Charge_Description_:\'\'),arrestoffencetypedescription(Arrest_Offence_Type_Description_:\'\'),arrestoffenselevel(Arrest_Offense_Level_:\'\'),dateofdispositionforinitialcharge(Date_Of_Disposition_For_Initial_Charge_:DATE),initialchargedispositiondescription(Initial_Charge_Disposition_Description_:\'\'),additionaldispositiondescription(Additional_Disposition_Description_:\'\'),offenderlevel(Offender_Level_:0),offensedate(Offense_Date_:DATE),fcra_traffic_flag(Traffic_Flag_:\'\'),fcra_conviction_flag(Conviction_Flag_:\'\'),fcraoffensekey(Fcra_Offense_Key_:\'\'),fcra_date(Fcra_Date_:DATE),fcra_date_type(Fcra_Date_Type_:\'\'),conviction_override_date(Conviction_Override_Date_:DATE),conviction_override_date_type(Conviction_Override_Date_Type_:\'\'),src(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping6_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_nonFCRA;
    SELF := __r;
  END;
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d6_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenders);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d6_UID_Mapped := JOIN(__d6_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d6_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid := __d6_UID_Mapped(UID = 0);
  SHARED __d6_Prefiltered := __d6_UID_Mapped(UID <> 0);
  SHARED __d6 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6),__Mapping6_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6;
  EXPORT Offense_Charges_Layout := RECORD
    KEL.typ.nstr Case_Number_;
    KEL.typ.nkdate Case_Date_;
    KEL.typ.nstr Case_Type_Description_;
    KEL.typ.nkdate Offense_Date_;
    KEL.typ.nstr Offense_Score_;
    KEL.typ.nint Data_Type_;
    KEL.typ.nstr Traffic_Flag_;
    KEL.typ.nstr Conviction_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Criminal_Data_Sources_Layout := RECORD
    KEL.typ.nstr Data_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Court_Offense_Level_Layout := RECORD
    KEL.typ.nstr Court_Offense_Level_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Offender_Level_Layout := RECORD
    KEL.typ.nint Offender_Level_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Fcra_Data_Layout := RECORD
    KEL.typ.nstr Fcra_Offense_Key_;
    KEL.typ.nkdate Fcra_Date_;
    KEL.typ.nstr Fcra_Date_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Conviction_Overrides_Layout := RECORD
    KEL.typ.nkdate Conviction_Override_Date_;
    KEL.typ.nstr Conviction_Override_Date_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.nstr Offense_Type_;
    KEL.typ.nkdate Date_Of_Offence_;
    KEL.typ.nint Offense_Category_;
    KEL.typ.nstr County_Of_Source_;
    KEL.typ.nstr State_Of_Source_;
    KEL.typ.nstr Department_Of_Law_Enforcement_Number_;
    KEL.typ.nstr Federal_Bureau_Of_Investigations_Number_;
    KEL.typ.nstr Inmate_Number_;
    KEL.typ.nstr State_Identification_Number_Assigned_;
    KEL.typ.nkdate Date_Of_Arrest_;
    KEL.typ.nstr Agency_Name_;
    KEL.typ.nint Agency_Case_Number_;
    KEL.typ.nstr Traffic_Ticket_Number_;
    KEL.typ.nstr Arrest_Offense_Code_;
    KEL.typ.nstr Arrest_Initial_Charge_Description_;
    KEL.typ.nstr Arrest_Amended_Charge_Description_;
    KEL.typ.nstr Arrest_Offense_Level_;
    KEL.typ.nkdate Date_Of_Disposition_For_Initial_Charge_;
    KEL.typ.nstr Arrest_Offence_Type_Description_;
    KEL.typ.nstr Initial_Charge_Disposition_Description_;
    KEL.typ.nstr Additional_Disposition_Description_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Court_Description_;
    KEL.typ.nstr Court_Final_Plea_;
    KEL.typ.nstr Court_Offense_Code_;
    KEL.typ.nstr Court_Offense_Description_;
    KEL.typ.nstr Court_Offense_Additional_Description_;
    KEL.typ.nstr Court_Statute_;
    KEL.typ.nkdate Court_Disposition_Date_;
    KEL.typ.nint Court_Fine_;
    KEL.typ.nstr Suspended_Court_Fine_;
    KEL.typ.nint Court_Cost_;
    KEL.typ.nstr Court_Disposition_Code_;
    KEL.typ.nstr Court_Disposition_Description_;
    KEL.typ.nstr Court_Additional_Disposition_Description_;
    KEL.typ.nkdate Date_Of_Appeal_;
    KEL.typ.nkdate Dateof_Verdict_;
    KEL.typ.nstr Offense_Town_;
    KEL.typ.nstr Persistent_Offense_Key_;
    KEL.typ.nkdate Court_Date_;
    KEL.typ.nstr Court_County_;
    KEL.typ.nstr Arrest_Offense_Level_Mapped_;
    KEL.typ.nstr Court_Offense_Level_Mapped_;
    KEL.typ.ndataset(Offense_Charges_Layout) Offense_Charges_;
    KEL.typ.ndataset(Criminal_Data_Sources_Layout) Criminal_Data_Sources_;
    KEL.typ.ndataset(Court_Offense_Level_Layout) Court_Offense_Level_;
    KEL.typ.ndataset(Offender_Level_Layout) Offender_Level_;
    KEL.typ.ndataset(Fcra_Data_Layout) Fcra_Data_;
    KEL.typ.ndataset(Conviction_Overrides_Layout) Conviction_Overrides_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Criminal_Offense_Group := __PostFilter;
  Layout Criminal_Offense__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Offender_Key_ := KEL.Intake.SingleValue(__recs,Offender_Key_);
    SELF.Offense_Type_ := KEL.Intake.SingleValue(__recs,Offense_Type_);
    SELF.Date_Of_Offence_ := KEL.Intake.SingleValue(__recs,Date_Of_Offence_);
    SELF.Offense_Category_ := KEL.Intake.SingleValue(__recs,Offense_Category_);
    SELF.County_Of_Source_ := KEL.Intake.SingleValue(__recs,County_Of_Source_);
    SELF.State_Of_Source_ := KEL.Intake.SingleValue(__recs,State_Of_Source_);
    SELF.Department_Of_Law_Enforcement_Number_ := KEL.Intake.SingleValue(__recs,Department_Of_Law_Enforcement_Number_);
    SELF.Federal_Bureau_Of_Investigations_Number_ := KEL.Intake.SingleValue(__recs,Federal_Bureau_Of_Investigations_Number_);
    SELF.Inmate_Number_ := KEL.Intake.SingleValue(__recs,Inmate_Number_);
    SELF.State_Identification_Number_Assigned_ := KEL.Intake.SingleValue(__recs,State_Identification_Number_Assigned_);
    SELF.Date_Of_Arrest_ := KEL.Intake.SingleValue(__recs,Date_Of_Arrest_);
    SELF.Agency_Name_ := KEL.Intake.SingleValue(__recs,Agency_Name_);
    SELF.Agency_Case_Number_ := KEL.Intake.SingleValue(__recs,Agency_Case_Number_);
    SELF.Traffic_Ticket_Number_ := KEL.Intake.SingleValue(__recs,Traffic_Ticket_Number_);
    SELF.Arrest_Offense_Code_ := KEL.Intake.SingleValue(__recs,Arrest_Offense_Code_);
    SELF.Arrest_Initial_Charge_Description_ := KEL.Intake.SingleValue(__recs,Arrest_Initial_Charge_Description_);
    SELF.Arrest_Amended_Charge_Description_ := KEL.Intake.SingleValue(__recs,Arrest_Amended_Charge_Description_);
    SELF.Arrest_Offense_Level_ := KEL.Intake.SingleValue(__recs,Arrest_Offense_Level_);
    SELF.Date_Of_Disposition_For_Initial_Charge_ := KEL.Intake.SingleValue(__recs,Date_Of_Disposition_For_Initial_Charge_);
    SELF.Arrest_Offence_Type_Description_ := KEL.Intake.SingleValue(__recs,Arrest_Offence_Type_Description_);
    SELF.Initial_Charge_Disposition_Description_ := KEL.Intake.SingleValue(__recs,Initial_Charge_Disposition_Description_);
    SELF.Additional_Disposition_Description_ := KEL.Intake.SingleValue(__recs,Additional_Disposition_Description_);
    SELF.Court_Code_ := KEL.Intake.SingleValue(__recs,Court_Code_);
    SELF.Court_Description_ := KEL.Intake.SingleValue(__recs,Court_Description_);
    SELF.Court_Final_Plea_ := KEL.Intake.SingleValue(__recs,Court_Final_Plea_);
    SELF.Court_Offense_Code_ := KEL.Intake.SingleValue(__recs,Court_Offense_Code_);
    SELF.Court_Offense_Description_ := KEL.Intake.SingleValue(__recs,Court_Offense_Description_);
    SELF.Court_Offense_Additional_Description_ := KEL.Intake.SingleValue(__recs,Court_Offense_Additional_Description_);
    SELF.Court_Statute_ := KEL.Intake.SingleValue(__recs,Court_Statute_);
    SELF.Court_Disposition_Date_ := KEL.Intake.SingleValue(__recs,Court_Disposition_Date_);
    SELF.Court_Fine_ := KEL.Intake.SingleValue(__recs,Court_Fine_);
    SELF.Suspended_Court_Fine_ := KEL.Intake.SingleValue(__recs,Suspended_Court_Fine_);
    SELF.Court_Cost_ := KEL.Intake.SingleValue(__recs,Court_Cost_);
    SELF.Court_Disposition_Code_ := KEL.Intake.SingleValue(__recs,Court_Disposition_Code_);
    SELF.Court_Disposition_Description_ := KEL.Intake.SingleValue(__recs,Court_Disposition_Description_);
    SELF.Court_Additional_Disposition_Description_ := KEL.Intake.SingleValue(__recs,Court_Additional_Disposition_Description_);
    SELF.Date_Of_Appeal_ := KEL.Intake.SingleValue(__recs,Date_Of_Appeal_);
    SELF.Dateof_Verdict_ := KEL.Intake.SingleValue(__recs,Dateof_Verdict_);
    SELF.Offense_Town_ := KEL.Intake.SingleValue(__recs,Offense_Town_);
    SELF.Persistent_Offense_Key_ := KEL.Intake.SingleValue(__recs,Persistent_Offense_Key_);
    SELF.Court_Date_ := KEL.Intake.SingleValue(__recs,Court_Date_);
    SELF.Court_County_ := KEL.Intake.SingleValue(__recs,Court_County_);
    SELF.Arrest_Offense_Level_Mapped_ := KEL.Intake.SingleValue(__recs,Arrest_Offense_Level_Mapped_);
    SELF.Court_Offense_Level_Mapped_ := KEL.Intake.SingleValue(__recs,Court_Offense_Level_Mapped_);
    SELF.Offense_Charges_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Case_Number_,Case_Date_,Case_Type_Description_,Offense_Date_,Offense_Score_,Data_Type_,Traffic_Flag_,Conviction_Flag_},Case_Number_,Case_Date_,Case_Type_Description_,Offense_Date_,Offense_Score_,Data_Type_,Traffic_Flag_,Conviction_Flag_),Offense_Charges_Layout)(__NN(Case_Number_) OR __NN(Case_Date_) OR __NN(Case_Type_Description_) OR __NN(Offense_Date_) OR __NN(Offense_Score_) OR __NN(Data_Type_) OR __NN(Traffic_Flag_) OR __NN(Conviction_Flag_)));
    SELF.Criminal_Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Data_Source_},Data_Source_),Criminal_Data_Sources_Layout)(__NN(Data_Source_)));
    SELF.Court_Offense_Level_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Court_Offense_Level_},Court_Offense_Level_),Court_Offense_Level_Layout)(__NN(Court_Offense_Level_)));
    SELF.Offender_Level_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Offender_Level_},Offender_Level_),Offender_Level_Layout)(__NN(Offender_Level_)));
    SELF.Fcra_Data_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Fcra_Offense_Key_,Fcra_Date_,Fcra_Date_Type_},Fcra_Offense_Key_,Fcra_Date_,Fcra_Date_Type_),Fcra_Data_Layout)(__NN(Fcra_Offense_Key_) OR __NN(Fcra_Date_) OR __NN(Fcra_Date_Type_)));
    SELF.Conviction_Overrides_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Conviction_Override_Date_,Conviction_Override_Date_Type_},Conviction_Override_Date_,Conviction_Override_Date_Type_),Conviction_Overrides_Layout)(__NN(Conviction_Override_Date_) OR __NN(Conviction_Override_Date_Type_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Criminal_Offense__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Offense_Charges_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Offense_Charges_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Case_Number_) OR __NN(Case_Date_) OR __NN(Case_Type_Description_) OR __NN(Offense_Date_) OR __NN(Offense_Score_) OR __NN(Data_Type_) OR __NN(Traffic_Flag_) OR __NN(Conviction_Flag_)));
    SELF.Criminal_Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Criminal_Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Data_Source_)));
    SELF.Court_Offense_Level_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Court_Offense_Level_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Court_Offense_Level_)));
    SELF.Offender_Level_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Offender_Level_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Offender_Level_)));
    SELF.Fcra_Data_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Fcra_Data_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Fcra_Offense_Key_) OR __NN(Fcra_Date_) OR __NN(Fcra_Date_Type_)));
    SELF.Conviction_Overrides_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Conviction_Overrides_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Conviction_Override_Date_) OR __NN(Conviction_Override_Date_Type_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Criminal_Offense_Group,COUNT(ROWS(LEFT))=1),GROUP,Criminal_Offense__Single_Rollup(LEFT)) + ROLLUP(HAVING(Criminal_Offense_Group,COUNT(ROWS(LEFT))>1),GROUP,Criminal_Offense__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Offender_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Offender_Key_);
  EXPORT Offense_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Offense_Type_);
  EXPORT Date_Of_Offence__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Offence_);
  EXPORT Offense_Category__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Offense_Category_);
  EXPORT County_Of_Source__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_Of_Source_);
  EXPORT State_Of_Source__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_Of_Source_);
  EXPORT Department_Of_Law_Enforcement_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Department_Of_Law_Enforcement_Number_);
  EXPORT Federal_Bureau_Of_Investigations_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Federal_Bureau_Of_Investigations_Number_);
  EXPORT Inmate_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Inmate_Number_);
  EXPORT State_Identification_Number_Assigned__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_Identification_Number_Assigned_);
  EXPORT Date_Of_Arrest__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Arrest_);
  EXPORT Agency_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Agency_Name_);
  EXPORT Agency_Case_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Agency_Case_Number_);
  EXPORT Traffic_Ticket_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Traffic_Ticket_Number_);
  EXPORT Arrest_Offense_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Arrest_Offense_Code_);
  EXPORT Arrest_Initial_Charge_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Arrest_Initial_Charge_Description_);
  EXPORT Arrest_Amended_Charge_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Arrest_Amended_Charge_Description_);
  EXPORT Arrest_Offense_Level__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Arrest_Offense_Level_);
  EXPORT Date_Of_Disposition_For_Initial_Charge__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Disposition_For_Initial_Charge_);
  EXPORT Arrest_Offence_Type_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Arrest_Offence_Type_Description_);
  EXPORT Initial_Charge_Disposition_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Initial_Charge_Disposition_Description_);
  EXPORT Additional_Disposition_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Additional_Disposition_Description_);
  EXPORT Court_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Code_);
  EXPORT Court_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Description_);
  EXPORT Court_Final_Plea__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Final_Plea_);
  EXPORT Court_Offense_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Offense_Code_);
  EXPORT Court_Offense_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Offense_Description_);
  EXPORT Court_Offense_Additional_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Offense_Additional_Description_);
  EXPORT Court_Statute__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Statute_);
  EXPORT Court_Disposition_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Disposition_Date_);
  EXPORT Court_Fine__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Fine_);
  EXPORT Suspended_Court_Fine__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Suspended_Court_Fine_);
  EXPORT Court_Cost__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Cost_);
  EXPORT Court_Disposition_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Disposition_Code_);
  EXPORT Court_Disposition_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Disposition_Description_);
  EXPORT Court_Additional_Disposition_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Additional_Disposition_Description_);
  EXPORT Date_Of_Appeal__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Appeal_);
  EXPORT Dateof_Verdict__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Dateof_Verdict_);
  EXPORT Offense_Town__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Offense_Town_);
  EXPORT Persistent_Offense_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Persistent_Offense_Key_);
  EXPORT Court_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Date_);
  EXPORT Court_County__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_County_);
  EXPORT Arrest_Offense_Level_Mapped__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Arrest_Offense_Level_Mapped_);
  EXPORT Court_Offense_Level_Mapped__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Offense_Level_Mapped_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Punishment_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(Offender_Key__SingleValue_Invalid),COUNT(Offense_Type__SingleValue_Invalid),COUNT(Date_Of_Offence__SingleValue_Invalid),COUNT(Offense_Category__SingleValue_Invalid),COUNT(County_Of_Source__SingleValue_Invalid),COUNT(State_Of_Source__SingleValue_Invalid),COUNT(Department_Of_Law_Enforcement_Number__SingleValue_Invalid),COUNT(Federal_Bureau_Of_Investigations_Number__SingleValue_Invalid),COUNT(Inmate_Number__SingleValue_Invalid),COUNT(State_Identification_Number_Assigned__SingleValue_Invalid),COUNT(Date_Of_Arrest__SingleValue_Invalid),COUNT(Agency_Name__SingleValue_Invalid),COUNT(Agency_Case_Number__SingleValue_Invalid),COUNT(Traffic_Ticket_Number__SingleValue_Invalid),COUNT(Arrest_Offense_Code__SingleValue_Invalid),COUNT(Arrest_Initial_Charge_Description__SingleValue_Invalid),COUNT(Arrest_Amended_Charge_Description__SingleValue_Invalid),COUNT(Arrest_Offense_Level__SingleValue_Invalid),COUNT(Date_Of_Disposition_For_Initial_Charge__SingleValue_Invalid),COUNT(Arrest_Offence_Type_Description__SingleValue_Invalid),COUNT(Initial_Charge_Disposition_Description__SingleValue_Invalid),COUNT(Additional_Disposition_Description__SingleValue_Invalid),COUNT(Court_Code__SingleValue_Invalid),COUNT(Court_Description__SingleValue_Invalid),COUNT(Court_Final_Plea__SingleValue_Invalid),COUNT(Court_Offense_Code__SingleValue_Invalid),COUNT(Court_Offense_Description__SingleValue_Invalid),COUNT(Court_Offense_Additional_Description__SingleValue_Invalid),COUNT(Court_Statute__SingleValue_Invalid),COUNT(Court_Disposition_Date__SingleValue_Invalid),COUNT(Court_Fine__SingleValue_Invalid),COUNT(Suspended_Court_Fine__SingleValue_Invalid),COUNT(Court_Cost__SingleValue_Invalid),COUNT(Court_Disposition_Code__SingleValue_Invalid),COUNT(Court_Disposition_Description__SingleValue_Invalid),COUNT(Court_Additional_Disposition_Description__SingleValue_Invalid),COUNT(Date_Of_Appeal__SingleValue_Invalid),COUNT(Dateof_Verdict__SingleValue_Invalid),COUNT(Offense_Town__SingleValue_Invalid),COUNT(Persistent_Offense_Key__SingleValue_Invalid),COUNT(Court_Date__SingleValue_Invalid),COUNT(Court_County__SingleValue_Invalid),COUNT(Arrest_Offense_Level_Mapped__SingleValue_Invalid),COUNT(Court_Offense_Level_Mapped__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Punishment_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid,KEL.typ.int Offender_Key__SingleValue_Invalid,KEL.typ.int Offense_Type__SingleValue_Invalid,KEL.typ.int Date_Of_Offence__SingleValue_Invalid,KEL.typ.int Offense_Category__SingleValue_Invalid,KEL.typ.int County_Of_Source__SingleValue_Invalid,KEL.typ.int State_Of_Source__SingleValue_Invalid,KEL.typ.int Department_Of_Law_Enforcement_Number__SingleValue_Invalid,KEL.typ.int Federal_Bureau_Of_Investigations_Number__SingleValue_Invalid,KEL.typ.int Inmate_Number__SingleValue_Invalid,KEL.typ.int State_Identification_Number_Assigned__SingleValue_Invalid,KEL.typ.int Date_Of_Arrest__SingleValue_Invalid,KEL.typ.int Agency_Name__SingleValue_Invalid,KEL.typ.int Agency_Case_Number__SingleValue_Invalid,KEL.typ.int Traffic_Ticket_Number__SingleValue_Invalid,KEL.typ.int Arrest_Offense_Code__SingleValue_Invalid,KEL.typ.int Arrest_Initial_Charge_Description__SingleValue_Invalid,KEL.typ.int Arrest_Amended_Charge_Description__SingleValue_Invalid,KEL.typ.int Arrest_Offense_Level__SingleValue_Invalid,KEL.typ.int Date_Of_Disposition_For_Initial_Charge__SingleValue_Invalid,KEL.typ.int Arrest_Offence_Type_Description__SingleValue_Invalid,KEL.typ.int Initial_Charge_Disposition_Description__SingleValue_Invalid,KEL.typ.int Additional_Disposition_Description__SingleValue_Invalid,KEL.typ.int Court_Code__SingleValue_Invalid,KEL.typ.int Court_Description__SingleValue_Invalid,KEL.typ.int Court_Final_Plea__SingleValue_Invalid,KEL.typ.int Court_Offense_Code__SingleValue_Invalid,KEL.typ.int Court_Offense_Description__SingleValue_Invalid,KEL.typ.int Court_Offense_Additional_Description__SingleValue_Invalid,KEL.typ.int Court_Statute__SingleValue_Invalid,KEL.typ.int Court_Disposition_Date__SingleValue_Invalid,KEL.typ.int Court_Fine__SingleValue_Invalid,KEL.typ.int Suspended_Court_Fine__SingleValue_Invalid,KEL.typ.int Court_Cost__SingleValue_Invalid,KEL.typ.int Court_Disposition_Code__SingleValue_Invalid,KEL.typ.int Court_Disposition_Description__SingleValue_Invalid,KEL.typ.int Court_Additional_Disposition_Description__SingleValue_Invalid,KEL.typ.int Date_Of_Appeal__SingleValue_Invalid,KEL.typ.int Dateof_Verdict__SingleValue_Invalid,KEL.typ.int Offense_Town__SingleValue_Invalid,KEL.typ.int Persistent_Offense_Key__SingleValue_Invalid,KEL.typ.int Court_Date__SingleValue_Invalid,KEL.typ.int Court_County__SingleValue_Invalid,KEL.typ.int Arrest_Offense_Level_Mapped__SingleValue_Invalid,KEL.typ.int Court_Offense_Level_Mapped__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid),COUNT(__d0)},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d0(__NL(Offender_Key_))),COUNT(__d0(__NN(Offender_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_num',COUNT(__d0(__NL(Case_Number_))),COUNT(__d0(__NN(Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDate',COUNT(__d0(__NL(Court_Date_))),COUNT(__d0(__NN(Court_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDescription',COUNT(__d0(__NL(Court_Description_))),COUNT(__d0(__NN(Court_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseDate',COUNT(__d0(__NL(Case_Date_))),COUNT(__d0(__NN(Case_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseTypeDescription',COUNT(__d0(__NL(Case_Type_Description_))),COUNT(__d0(__NN(Case_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCode',COUNT(__d0(__NL(Court_Code_))),COUNT(__d0(__NN(Court_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFinalPlea',COUNT(__d0(__NL(Court_Final_Plea_))),COUNT(__d0(__NN(Court_Final_Plea_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseCode',COUNT(__d0(__NL(Court_Offense_Code_))),COUNT(__d0(__NN(Court_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseDescription',COUNT(__d0(__NL(Court_Offense_Description_))),COUNT(__d0(__NN(Court_Offense_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseAdditionalDescription',COUNT(__d0(__NL(Court_Offense_Additional_Description_))),COUNT(__d0(__NN(Court_Offense_Additional_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevel',COUNT(__d0(__NL(Court_Offense_Level_))),COUNT(__d0(__NN(Court_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtStatute',COUNT(__d0(__NL(Court_Statute_))),COUNT(__d0(__NN(Court_Statute_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDate',COUNT(__d0(__NL(Court_Disposition_Date_))),COUNT(__d0(__NN(Court_Disposition_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionCode',COUNT(__d0(__NL(Court_Disposition_Code_))),COUNT(__d0(__NN(Court_Disposition_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDescription',COUNT(__d0(__NL(Court_Disposition_Description_))),COUNT(__d0(__NN(Court_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtAdditionalDispositionDescription',COUNT(__d0(__NL(Court_Additional_Disposition_Description_))),COUNT(__d0(__NN(Court_Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfAppeal',COUNT(__d0(__NL(Date_Of_Appeal_))),COUNT(__d0(__NN(Date_Of_Appeal_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateofVerdict',COUNT(__d0(__NL(Dateof_Verdict_))),COUNT(__d0(__NN(Dateof_Verdict_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCounty',COUNT(__d0(__NL(Court_County_))),COUNT(__d0(__NN(Court_County_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevelMapped',COUNT(__d0(__NL(Court_Offense_Level_Mapped_))),COUNT(__d0(__NN(Court_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCost',COUNT(__d0(__NL(Court_Cost_))),COUNT(__d0(__NN(Court_Cost_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFine',COUNT(__d0(__NL(Court_Fine_))),COUNT(__d0(__NN(Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SuspendedCourtFine',COUNT(__d0(__NL(Suspended_Court_Fine_))),COUNT(__d0(__NN(Suspended_Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseTown',COUNT(__d0(__NL(Offense_Town_))),COUNT(__d0(__NN(Offense_Town_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevelMapped',COUNT(__d0(__NL(Arrest_Offense_Level_Mapped_))),COUNT(__d0(__NN(Arrest_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersistentOffenseKey',COUNT(__d0(__NL(Persistent_Offense_Key_))),COUNT(__d0(__NN(Persistent_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateOfSource',COUNT(__d0(__NL(State_Of_Source_))),COUNT(__d0(__NN(State_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyOfSource',COUNT(__d0(__NL(County_Of_Source_))),COUNT(__d0(__NN(County_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DepartmentOfLawEnforcementNumber',COUNT(__d0(__NL(Department_Of_Law_Enforcement_Number_))),COUNT(__d0(__NN(Department_Of_Law_Enforcement_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FederalBureauOfInvestigationsNumber',COUNT(__d0(__NL(Federal_Bureau_Of_Investigations_Number_))),COUNT(__d0(__NN(Federal_Bureau_Of_Investigations_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InmateNumber',COUNT(__d0(__NL(Inmate_Number_))),COUNT(__d0(__NN(Inmate_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateIdentificationNumberAssigned',COUNT(__d0(__NL(State_Identification_Number_Assigned_))),COUNT(__d0(__NN(State_Identification_Number_Assigned_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataType',COUNT(__d0(__NL(Data_Type_))),COUNT(__d0(__NN(Data_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSource',COUNT(__d0(__NL(Data_Source_))),COUNT(__d0(__NN(Data_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_score',COUNT(__d0(__NL(Offense_Score_))),COUNT(__d0(__NN(Offense_Score_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseType',COUNT(__d0(__NL(Offense_Type_))),COUNT(__d0(__NN(Offense_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfOffence',COUNT(__d0(__NL(Date_Of_Offence_))),COUNT(__d0(__NN(Date_Of_Offence_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TrafficTicketNumber',COUNT(__d0(__NL(Traffic_Ticket_Number_))),COUNT(__d0(__NN(Traffic_Ticket_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseCategory',COUNT(__d0(__NL(Offense_Category_))),COUNT(__d0(__NN(Offense_Category_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfArrest',COUNT(__d0(__NL(Date_Of_Arrest_))),COUNT(__d0(__NN(Date_Of_Arrest_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyName',COUNT(__d0(__NL(Agency_Name_))),COUNT(__d0(__NN(Agency_Name_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyCaseNumber',COUNT(__d0(__NL(Agency_Case_Number_))),COUNT(__d0(__NN(Agency_Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseCode',COUNT(__d0(__NL(Arrest_Offense_Code_))),COUNT(__d0(__NN(Arrest_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestInitialChargeDescription',COUNT(__d0(__NL(Arrest_Initial_Charge_Description_))),COUNT(__d0(__NN(Arrest_Initial_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestAmendedChargeDescription',COUNT(__d0(__NL(Arrest_Amended_Charge_Description_))),COUNT(__d0(__NN(Arrest_Amended_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenceTypeDescription',COUNT(__d0(__NL(Arrest_Offence_Type_Description_))),COUNT(__d0(__NN(Arrest_Offence_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevel',COUNT(__d0(__NL(Arrest_Offense_Level_))),COUNT(__d0(__NN(Arrest_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDispositionForInitialCharge',COUNT(__d0(__NL(Date_Of_Disposition_For_Initial_Charge_))),COUNT(__d0(__NN(Date_Of_Disposition_For_Initial_Charge_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InitialChargeDispositionDescription',COUNT(__d0(__NL(Initial_Charge_Disposition_Description_))),COUNT(__d0(__NN(Initial_Charge_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalDispositionDescription',COUNT(__d0(__NL(Additional_Disposition_Description_))),COUNT(__d0(__NN(Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','criminal_offender_level',COUNT(__d0(__NL(Offender_Level_))),COUNT(__d0(__NN(Offender_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseDate',COUNT(__d0(__NL(Offense_Date_))),COUNT(__d0(__NN(Offense_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TrafficFlag',COUNT(__d0(__NL(Traffic_Flag_))),COUNT(__d0(__NN(Traffic_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConvictionFlag',COUNT(__d0(__NL(Conviction_Flag_))),COUNT(__d0(__NN(Conviction_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraOffenseKey',COUNT(__d0(__NL(Fcra_Offense_Key_))),COUNT(__d0(__NN(Fcra_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraDate',COUNT(__d0(__NL(Fcra_Date_))),COUNT(__d0(__NN(Fcra_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraDateType',COUNT(__d0(__NL(Fcra_Date_Type_))),COUNT(__d0(__NN(Fcra_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConvictionOverrideDate',COUNT(__d0(__NL(Conviction_Override_Date_))),COUNT(__d0(__NN(Conviction_Override_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConvictionOverrideDateType',COUNT(__d0(__NL(Conviction_Override_Date_Type_))),COUNT(__d0(__NN(Conviction_Override_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Punishment_Invalid),COUNT(__d1)},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d1(__NL(Offender_Key_))),COUNT(__d1(__NN(Offender_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseNumber',COUNT(__d1(__NL(Case_Number_))),COUNT(__d1(__NN(Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDate',COUNT(__d1(__NL(Court_Date_))),COUNT(__d1(__NN(Court_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDescription',COUNT(__d1(__NL(Court_Description_))),COUNT(__d1(__NN(Court_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseDate',COUNT(__d1(__NL(Case_Date_))),COUNT(__d1(__NN(Case_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseTypeDescription',COUNT(__d1(__NL(Case_Type_Description_))),COUNT(__d1(__NN(Case_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCode',COUNT(__d1(__NL(Court_Code_))),COUNT(__d1(__NN(Court_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFinalPlea',COUNT(__d1(__NL(Court_Final_Plea_))),COUNT(__d1(__NN(Court_Final_Plea_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseCode',COUNT(__d1(__NL(Court_Offense_Code_))),COUNT(__d1(__NN(Court_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseDescription',COUNT(__d1(__NL(Court_Offense_Description_))),COUNT(__d1(__NN(Court_Offense_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseAdditionalDescription',COUNT(__d1(__NL(Court_Offense_Additional_Description_))),COUNT(__d1(__NN(Court_Offense_Additional_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevel',COUNT(__d1(__NL(Court_Offense_Level_))),COUNT(__d1(__NN(Court_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtStatute',COUNT(__d1(__NL(Court_Statute_))),COUNT(__d1(__NN(Court_Statute_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDate',COUNT(__d1(__NL(Court_Disposition_Date_))),COUNT(__d1(__NN(Court_Disposition_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionCode',COUNT(__d1(__NL(Court_Disposition_Code_))),COUNT(__d1(__NN(Court_Disposition_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDescription',COUNT(__d1(__NL(Court_Disposition_Description_))),COUNT(__d1(__NN(Court_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtAdditionalDispositionDescription',COUNT(__d1(__NL(Court_Additional_Disposition_Description_))),COUNT(__d1(__NN(Court_Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfAppeal',COUNT(__d1(__NL(Date_Of_Appeal_))),COUNT(__d1(__NN(Date_Of_Appeal_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateofVerdict',COUNT(__d1(__NL(Dateof_Verdict_))),COUNT(__d1(__NN(Dateof_Verdict_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCounty',COUNT(__d1(__NL(Court_County_))),COUNT(__d1(__NN(Court_County_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevelMapped',COUNT(__d1(__NL(Court_Offense_Level_Mapped_))),COUNT(__d1(__NN(Court_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCost',COUNT(__d1(__NL(Court_Cost_))),COUNT(__d1(__NN(Court_Cost_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFine',COUNT(__d1(__NL(Court_Fine_))),COUNT(__d1(__NN(Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SuspendedCourtFine',COUNT(__d1(__NL(Suspended_Court_Fine_))),COUNT(__d1(__NN(Suspended_Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseTown',COUNT(__d1(__NL(Offense_Town_))),COUNT(__d1(__NN(Offense_Town_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevelMapped',COUNT(__d1(__NL(Arrest_Offense_Level_Mapped_))),COUNT(__d1(__NN(Arrest_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersistentOffenseKey',COUNT(__d1(__NL(Persistent_Offense_Key_))),COUNT(__d1(__NN(Persistent_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateOfSource',COUNT(__d1(__NL(State_Of_Source_))),COUNT(__d1(__NN(State_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyOfSource',COUNT(__d1(__NL(County_Of_Source_))),COUNT(__d1(__NN(County_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DepartmentOfLawEnforcementNumber',COUNT(__d1(__NL(Department_Of_Law_Enforcement_Number_))),COUNT(__d1(__NN(Department_Of_Law_Enforcement_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FederalBureauOfInvestigationsNumber',COUNT(__d1(__NL(Federal_Bureau_Of_Investigations_Number_))),COUNT(__d1(__NN(Federal_Bureau_Of_Investigations_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InmateNumber',COUNT(__d1(__NL(Inmate_Number_))),COUNT(__d1(__NN(Inmate_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateIdentificationNumberAssigned',COUNT(__d1(__NL(State_Identification_Number_Assigned_))),COUNT(__d1(__NN(State_Identification_Number_Assigned_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataType',COUNT(__d1(__NL(Data_Type_))),COUNT(__d1(__NN(Data_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSource',COUNT(__d1(__NL(Data_Source_))),COUNT(__d1(__NN(Data_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseScore',COUNT(__d1(__NL(Offense_Score_))),COUNT(__d1(__NN(Offense_Score_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseType',COUNT(__d1(__NL(Offense_Type_))),COUNT(__d1(__NN(Offense_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfOffence',COUNT(__d1(__NL(Date_Of_Offence_))),COUNT(__d1(__NN(Date_Of_Offence_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TrafficTicketNumber',COUNT(__d1(__NL(Traffic_Ticket_Number_))),COUNT(__d1(__NN(Traffic_Ticket_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseCategory',COUNT(__d1(__NL(Offense_Category_))),COUNT(__d1(__NN(Offense_Category_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfArrest',COUNT(__d1(__NL(Date_Of_Arrest_))),COUNT(__d1(__NN(Date_Of_Arrest_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyName',COUNT(__d1(__NL(Agency_Name_))),COUNT(__d1(__NN(Agency_Name_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyCaseNumber',COUNT(__d1(__NL(Agency_Case_Number_))),COUNT(__d1(__NN(Agency_Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseCode',COUNT(__d1(__NL(Arrest_Offense_Code_))),COUNT(__d1(__NN(Arrest_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestInitialChargeDescription',COUNT(__d1(__NL(Arrest_Initial_Charge_Description_))),COUNT(__d1(__NN(Arrest_Initial_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestAmendedChargeDescription',COUNT(__d1(__NL(Arrest_Amended_Charge_Description_))),COUNT(__d1(__NN(Arrest_Amended_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenceTypeDescription',COUNT(__d1(__NL(Arrest_Offence_Type_Description_))),COUNT(__d1(__NN(Arrest_Offence_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevel',COUNT(__d1(__NL(Arrest_Offense_Level_))),COUNT(__d1(__NN(Arrest_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDispositionForInitialCharge',COUNT(__d1(__NL(Date_Of_Disposition_For_Initial_Charge_))),COUNT(__d1(__NN(Date_Of_Disposition_For_Initial_Charge_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InitialChargeDispositionDescription',COUNT(__d1(__NL(Initial_Charge_Disposition_Description_))),COUNT(__d1(__NN(Initial_Charge_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalDispositionDescription',COUNT(__d1(__NL(Additional_Disposition_Description_))),COUNT(__d1(__NN(Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenderLevel',COUNT(__d1(__NL(Offender_Level_))),COUNT(__d1(__NN(Offender_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseDate',COUNT(__d1(__NL(Offense_Date_))),COUNT(__d1(__NN(Offense_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TrafficFlag',COUNT(__d1(__NL(Traffic_Flag_))),COUNT(__d1(__NN(Traffic_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConvictionFlag',COUNT(__d1(__NL(Conviction_Flag_))),COUNT(__d1(__NN(Conviction_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraOffenseKey',COUNT(__d1(__NL(Fcra_Offense_Key_))),COUNT(__d1(__NN(Fcra_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraDate',COUNT(__d1(__NL(Fcra_Date_))),COUNT(__d1(__NN(Fcra_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraDateType',COUNT(__d1(__NL(Fcra_Date_Type_))),COUNT(__d1(__NN(Fcra_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date',COUNT(__d1(__NL(Conviction_Override_Date_))),COUNT(__d1(__NN(Conviction_Override_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date_type',COUNT(__d1(__NL(Conviction_Override_Date_Type_))),COUNT(__d1(__NN(Conviction_Override_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid),COUNT(__d2)},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d2(__NL(Offender_Key_))),COUNT(__d2(__NN(Offender_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_num',COUNT(__d2(__NL(Case_Number_))),COUNT(__d2(__NN(Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDate',COUNT(__d2(__NL(Court_Date_))),COUNT(__d2(__NN(Court_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_desc',COUNT(__d2(__NL(Court_Description_))),COUNT(__d2(__NN(Court_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseDate',COUNT(__d2(__NL(Case_Date_))),COUNT(__d2(__NN(Case_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseTypeDescription',COUNT(__d2(__NL(Case_Type_Description_))),COUNT(__d2(__NN(Case_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCode',COUNT(__d2(__NL(Court_Code_))),COUNT(__d2(__NN(Court_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFinalPlea',COUNT(__d2(__NL(Court_Final_Plea_))),COUNT(__d2(__NN(Court_Final_Plea_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','off_code',COUNT(__d2(__NL(Court_Offense_Code_))),COUNT(__d2(__NN(Court_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','off_desc_1',COUNT(__d2(__NL(Court_Offense_Description_))),COUNT(__d2(__NN(Court_Offense_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','off_desc_2',COUNT(__d2(__NL(Court_Offense_Additional_Description_))),COUNT(__d2(__NN(Court_Offense_Additional_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','off_lev',COUNT(__d2(__NL(Court_Offense_Level_))),COUNT(__d2(__NN(Court_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtStatute',COUNT(__d2(__NL(Court_Statute_))),COUNT(__d2(__NN(Court_Statute_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ct_disp_dt',COUNT(__d2(__NL(Court_Disposition_Date_))),COUNT(__d2(__NN(Court_Disposition_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionCode',COUNT(__d2(__NL(Court_Disposition_Code_))),COUNT(__d2(__NN(Court_Disposition_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ct_disp_desc_1',COUNT(__d2(__NL(Court_Disposition_Description_))),COUNT(__d2(__NN(Court_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ct_disp_desc_2',COUNT(__d2(__NL(Court_Additional_Disposition_Description_))),COUNT(__d2(__NN(Court_Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfAppeal',COUNT(__d2(__NL(Date_Of_Appeal_))),COUNT(__d2(__NN(Date_Of_Appeal_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateofVerdict',COUNT(__d2(__NL(Dateof_Verdict_))),COUNT(__d2(__NN(Dateof_Verdict_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_county',COUNT(__d2(__NL(Court_County_))),COUNT(__d2(__NN(Court_County_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevelMapped',COUNT(__d2(__NL(Court_Offense_Level_Mapped_))),COUNT(__d2(__NN(Court_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCost',COUNT(__d2(__NL(Court_Cost_))),COUNT(__d2(__NN(Court_Cost_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFine',COUNT(__d2(__NL(Court_Fine_))),COUNT(__d2(__NN(Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SuspendedCourtFine',COUNT(__d2(__NL(Suspended_Court_Fine_))),COUNT(__d2(__NN(Suspended_Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offensetown',COUNT(__d2(__NL(Offense_Town_))),COUNT(__d2(__NN(Offense_Town_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevelMapped',COUNT(__d2(__NL(Arrest_Offense_Level_Mapped_))),COUNT(__d2(__NN(Arrest_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_persistent_id',COUNT(__d2(__NL(Persistent_Offense_Key_))),COUNT(__d2(__NN(Persistent_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_state',COUNT(__d2(__NL(State_Of_Source_))),COUNT(__d2(__NN(State_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyOfSource',COUNT(__d2(__NL(County_Of_Source_))),COUNT(__d2(__NN(County_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DepartmentOfLawEnforcementNumber',COUNT(__d2(__NL(Department_Of_Law_Enforcement_Number_))),COUNT(__d2(__NN(Department_Of_Law_Enforcement_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FederalBureauOfInvestigationsNumber',COUNT(__d2(__NL(Federal_Bureau_Of_Investigations_Number_))),COUNT(__d2(__NN(Federal_Bureau_Of_Investigations_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InmateNumber',COUNT(__d2(__NL(Inmate_Number_))),COUNT(__d2(__NN(Inmate_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateIdentificationNumberAssigned',COUNT(__d2(__NL(State_Identification_Number_Assigned_))),COUNT(__d2(__NN(State_Identification_Number_Assigned_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','data_type',COUNT(__d2(__NL(Data_Type_))),COUNT(__d2(__NN(Data_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_file',COUNT(__d2(__NL(Data_Source_))),COUNT(__d2(__NN(Data_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_score',COUNT(__d2(__NL(Offense_Score_))),COUNT(__d2(__NN(Offense_Score_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','off_typ',COUNT(__d2(__NL(Offense_Type_))),COUNT(__d2(__NN(Offense_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfOffence',COUNT(__d2(__NL(Date_Of_Offence_))),COUNT(__d2(__NN(Date_Of_Offence_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TrafficTicketNumber',COUNT(__d2(__NL(Traffic_Ticket_Number_))),COUNT(__d2(__NN(Traffic_Ticket_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseCategory',COUNT(__d2(__NL(Offense_Category_))),COUNT(__d2(__NN(Offense_Category_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_date',COUNT(__d2(__NL(Date_Of_Arrest_))),COUNT(__d2(__NN(Date_Of_Arrest_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyName',COUNT(__d2(__NL(Agency_Name_))),COUNT(__d2(__NN(Agency_Name_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyCaseNumber',COUNT(__d2(__NL(Agency_Case_Number_))),COUNT(__d2(__NN(Agency_Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseCode',COUNT(__d2(__NL(Arrest_Offense_Code_))),COUNT(__d2(__NN(Arrest_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestInitialChargeDescription',COUNT(__d2(__NL(Arrest_Initial_Charge_Description_))),COUNT(__d2(__NN(Arrest_Initial_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestAmendedChargeDescription',COUNT(__d2(__NL(Arrest_Amended_Charge_Description_))),COUNT(__d2(__NN(Arrest_Amended_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenceTypeDescription',COUNT(__d2(__NL(Arrest_Offence_Type_Description_))),COUNT(__d2(__NN(Arrest_Offence_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevel',COUNT(__d2(__NL(Arrest_Offense_Level_))),COUNT(__d2(__NN(Arrest_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDispositionForInitialCharge',COUNT(__d2(__NL(Date_Of_Disposition_For_Initial_Charge_))),COUNT(__d2(__NN(Date_Of_Disposition_For_Initial_Charge_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InitialChargeDispositionDescription',COUNT(__d2(__NL(Initial_Charge_Disposition_Description_))),COUNT(__d2(__NN(Initial_Charge_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalDispositionDescription',COUNT(__d2(__NL(Additional_Disposition_Description_))),COUNT(__d2(__NN(Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenderLevel',COUNT(__d2(__NL(Offender_Level_))),COUNT(__d2(__NN(Offender_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','off_date',COUNT(__d2(__NL(Offense_Date_))),COUNT(__d2(__NN(Offense_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_traffic_flag',COUNT(__d2(__NL(Traffic_Flag_))),COUNT(__d2(__NN(Traffic_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_conviction_flag',COUNT(__d2(__NL(Conviction_Flag_))),COUNT(__d2(__NN(Conviction_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_offense_key',COUNT(__d2(__NL(Fcra_Offense_Key_))),COUNT(__d2(__NN(Fcra_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_date',COUNT(__d2(__NL(Fcra_Date_))),COUNT(__d2(__NN(Fcra_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_date_type',COUNT(__d2(__NL(Fcra_Date_Type_))),COUNT(__d2(__NN(Fcra_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date',COUNT(__d2(__NL(Conviction_Override_Date_))),COUNT(__d2(__NN(Conviction_Override_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date_type',COUNT(__d2(__NL(Conviction_Override_Date_Type_))),COUNT(__d2(__NN(Conviction_Override_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid),COUNT(__d3)},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d3(__NL(Offender_Key_))),COUNT(__d3(__NN(Offender_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_case_number',COUNT(__d3(__NL(Case_Number_))),COUNT(__d3(__NN(Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_dt',COUNT(__d3(__NL(Court_Date_))),COUNT(__d3(__NN(Court_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_desc',COUNT(__d3(__NL(Court_Description_))),COUNT(__d3(__NN(Court_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseDate',COUNT(__d3(__NL(Case_Date_))),COUNT(__d3(__NN(Case_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseTypeDescription',COUNT(__d3(__NL(Case_Type_Description_))),COUNT(__d3(__NN(Case_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_cd',COUNT(__d3(__NL(Court_Code_))),COUNT(__d3(__NN(Court_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_final_plea',COUNT(__d3(__NL(Court_Final_Plea_))),COUNT(__d3(__NN(Court_Final_Plea_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_off_code',COUNT(__d3(__NL(Court_Offense_Code_))),COUNT(__d3(__NN(Court_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_off_desc_1',COUNT(__d3(__NL(Court_Offense_Description_))),COUNT(__d3(__NN(Court_Offense_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_off_desc_2',COUNT(__d3(__NL(Court_Offense_Additional_Description_))),COUNT(__d3(__NN(Court_Offense_Additional_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_off_lev',COUNT(__d3(__NL(Court_Offense_Level_))),COUNT(__d3(__NN(Court_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_statute',COUNT(__d3(__NL(Court_Statute_))),COUNT(__d3(__NN(Court_Statute_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_disp_date',COUNT(__d3(__NL(Court_Disposition_Date_))),COUNT(__d3(__NN(Court_Disposition_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_disp_code',COUNT(__d3(__NL(Court_Disposition_Code_))),COUNT(__d3(__NN(Court_Disposition_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_disp_desc_1',COUNT(__d3(__NL(Court_Disposition_Description_))),COUNT(__d3(__NN(Court_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_disp_desc_2',COUNT(__d3(__NL(Court_Additional_Disposition_Description_))),COUNT(__d3(__NN(Court_Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','appeal_date',COUNT(__d3(__NL(Date_Of_Appeal_))),COUNT(__d3(__NN(Date_Of_Appeal_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','convict_dt',COUNT(__d3(__NL(Dateof_Verdict_))),COUNT(__d3(__NN(Dateof_Verdict_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_county',COUNT(__d3(__NL(Court_County_))),COUNT(__d3(__NN(Court_County_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','court_off_lev_mapped',COUNT(__d3(__NL(Court_Offense_Level_Mapped_))),COUNT(__d3(__NN(Court_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_court_cost',COUNT(__d3(__NL(Court_Cost_))),COUNT(__d3(__NN(Court_Cost_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_court_fine',COUNT(__d3(__NL(Court_Fine_))),COUNT(__d3(__NN(Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_susp_court_fine',COUNT(__d3(__NL(Suspended_Court_Fine_))),COUNT(__d3(__NN(Suspended_Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_town',COUNT(__d3(__NL(Offense_Town_))),COUNT(__d3(__NN(Offense_Town_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_off_lev_mapped',COUNT(__d3(__NL(Arrest_Offense_Level_Mapped_))),COUNT(__d3(__NN(Arrest_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_persistent_id',COUNT(__d3(__NL(Persistent_Offense_Key_))),COUNT(__d3(__NN(Persistent_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','state_origin',COUNT(__d3(__NL(State_Of_Source_))),COUNT(__d3(__NN(State_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyOfSource',COUNT(__d3(__NL(County_Of_Source_))),COUNT(__d3(__NN(County_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DepartmentOfLawEnforcementNumber',COUNT(__d3(__NL(Department_Of_Law_Enforcement_Number_))),COUNT(__d3(__NN(Department_Of_Law_Enforcement_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FederalBureauOfInvestigationsNumber',COUNT(__d3(__NL(Federal_Bureau_Of_Investigations_Number_))),COUNT(__d3(__NN(Federal_Bureau_Of_Investigations_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InmateNumber',COUNT(__d3(__NL(Inmate_Number_))),COUNT(__d3(__NN(Inmate_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateIdentificationNumberAssigned',COUNT(__d3(__NL(State_Identification_Number_Assigned_))),COUNT(__d3(__NN(State_Identification_Number_Assigned_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','data_type',COUNT(__d3(__NL(Data_Type_))),COUNT(__d3(__NN(Data_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_file',COUNT(__d3(__NL(Data_Source_))),COUNT(__d3(__NN(Data_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_score',COUNT(__d3(__NL(Offense_Score_))),COUNT(__d3(__NN(Offense_Score_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseType',COUNT(__d3(__NL(Offense_Type_))),COUNT(__d3(__NN(Offense_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfOffence',COUNT(__d3(__NL(Date_Of_Offence_))),COUNT(__d3(__NN(Date_Of_Offence_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','traffic_ticket_number',COUNT(__d3(__NL(Traffic_Ticket_Number_))),COUNT(__d3(__NN(Traffic_Ticket_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_category',COUNT(__d3(__NL(Offense_Category_))),COUNT(__d3(__NN(Offense_Category_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_date',COUNT(__d3(__NL(Date_Of_Arrest_))),COUNT(__d3(__NN(Date_Of_Arrest_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','le_agency_desc',COUNT(__d3(__NL(Agency_Name_))),COUNT(__d3(__NN(Agency_Name_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','le_agency_case_number',COUNT(__d3(__NL(Agency_Case_Number_))),COUNT(__d3(__NN(Agency_Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_off_code',COUNT(__d3(__NL(Arrest_Offense_Code_))),COUNT(__d3(__NN(Arrest_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_off_desc_1',COUNT(__d3(__NL(Arrest_Initial_Charge_Description_))),COUNT(__d3(__NN(Arrest_Initial_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_off_desc_2',COUNT(__d3(__NL(Arrest_Amended_Charge_Description_))),COUNT(__d3(__NN(Arrest_Amended_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_off_type_desc',COUNT(__d3(__NL(Arrest_Offence_Type_Description_))),COUNT(__d3(__NN(Arrest_Offence_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_off_lev',COUNT(__d3(__NL(Arrest_Offense_Level_))),COUNT(__d3(__NN(Arrest_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_disp_date',COUNT(__d3(__NL(Date_Of_Disposition_For_Initial_Charge_))),COUNT(__d3(__NN(Date_Of_Disposition_For_Initial_Charge_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_disp_desc_1',COUNT(__d3(__NL(Initial_Charge_Disposition_Description_))),COUNT(__d3(__NN(Initial_Charge_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arr_disp_desc_2',COUNT(__d3(__NL(Additional_Disposition_Description_))),COUNT(__d3(__NN(Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenderLevel',COUNT(__d3(__NL(Offender_Level_))),COUNT(__d3(__NN(Offender_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','off_date',COUNT(__d3(__NL(Offense_Date_))),COUNT(__d3(__NN(Offense_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_traffic_flag',COUNT(__d3(__NL(Traffic_Flag_))),COUNT(__d3(__NN(Traffic_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_conviction_flag',COUNT(__d3(__NL(Conviction_Flag_))),COUNT(__d3(__NN(Conviction_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_offense_key',COUNT(__d3(__NL(Fcra_Offense_Key_))),COUNT(__d3(__NN(Fcra_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_date',COUNT(__d3(__NL(Fcra_Date_))),COUNT(__d3(__NN(Fcra_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_date_type',COUNT(__d3(__NL(Fcra_Date_Type_))),COUNT(__d3(__NN(Fcra_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date',COUNT(__d3(__NL(Conviction_Override_Date_))),COUNT(__d3(__NN(Conviction_Override_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date_type',COUNT(__d3(__NL(Conviction_Override_Date_Type_))),COUNT(__d3(__NN(Conviction_Override_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA_Invalid),COUNT(__d4)},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d4(__NL(Offender_Key_))),COUNT(__d4(__NN(Offender_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_num',COUNT(__d4(__NL(Case_Number_))),COUNT(__d4(__NN(Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDate',COUNT(__d4(__NL(Court_Date_))),COUNT(__d4(__NN(Court_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDescription',COUNT(__d4(__NL(Court_Description_))),COUNT(__d4(__NN(Court_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date',COUNT(__d4(__NL(Case_Date_))),COUNT(__d4(__NN(Case_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseTypeDescription',COUNT(__d4(__NL(Case_Type_Description_))),COUNT(__d4(__NN(Case_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCode',COUNT(__d4(__NL(Court_Code_))),COUNT(__d4(__NN(Court_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFinalPlea',COUNT(__d4(__NL(Court_Final_Plea_))),COUNT(__d4(__NN(Court_Final_Plea_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseCode',COUNT(__d4(__NL(Court_Offense_Code_))),COUNT(__d4(__NN(Court_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseDescription',COUNT(__d4(__NL(Court_Offense_Description_))),COUNT(__d4(__NN(Court_Offense_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseAdditionalDescription',COUNT(__d4(__NL(Court_Offense_Additional_Description_))),COUNT(__d4(__NN(Court_Offense_Additional_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevel',COUNT(__d4(__NL(Court_Offense_Level_))),COUNT(__d4(__NN(Court_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtStatute',COUNT(__d4(__NL(Court_Statute_))),COUNT(__d4(__NN(Court_Statute_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDate',COUNT(__d4(__NL(Court_Disposition_Date_))),COUNT(__d4(__NN(Court_Disposition_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionCode',COUNT(__d4(__NL(Court_Disposition_Code_))),COUNT(__d4(__NN(Court_Disposition_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDescription',COUNT(__d4(__NL(Court_Disposition_Description_))),COUNT(__d4(__NN(Court_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtAdditionalDispositionDescription',COUNT(__d4(__NL(Court_Additional_Disposition_Description_))),COUNT(__d4(__NN(Court_Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfAppeal',COUNT(__d4(__NL(Date_Of_Appeal_))),COUNT(__d4(__NN(Date_Of_Appeal_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateofVerdict',COUNT(__d4(__NL(Dateof_Verdict_))),COUNT(__d4(__NN(Dateof_Verdict_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCounty',COUNT(__d4(__NL(Court_County_))),COUNT(__d4(__NN(Court_County_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevelMapped',COUNT(__d4(__NL(Court_Offense_Level_Mapped_))),COUNT(__d4(__NN(Court_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCost',COUNT(__d4(__NL(Court_Cost_))),COUNT(__d4(__NN(Court_Cost_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFine',COUNT(__d4(__NL(Court_Fine_))),COUNT(__d4(__NN(Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SuspendedCourtFine',COUNT(__d4(__NL(Suspended_Court_Fine_))),COUNT(__d4(__NN(Suspended_Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseTown',COUNT(__d4(__NL(Offense_Town_))),COUNT(__d4(__NN(Offense_Town_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevelMapped',COUNT(__d4(__NL(Arrest_Offense_Level_Mapped_))),COUNT(__d4(__NN(Arrest_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersistentOffenseKey',COUNT(__d4(__NL(Persistent_Offense_Key_))),COUNT(__d4(__NN(Persistent_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateOfSource',COUNT(__d4(__NL(State_Of_Source_))),COUNT(__d4(__NN(State_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyOfSource',COUNT(__d4(__NL(County_Of_Source_))),COUNT(__d4(__NN(County_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DepartmentOfLawEnforcementNumber',COUNT(__d4(__NL(Department_Of_Law_Enforcement_Number_))),COUNT(__d4(__NN(Department_Of_Law_Enforcement_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FederalBureauOfInvestigationsNumber',COUNT(__d4(__NL(Federal_Bureau_Of_Investigations_Number_))),COUNT(__d4(__NN(Federal_Bureau_Of_Investigations_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InmateNumber',COUNT(__d4(__NL(Inmate_Number_))),COUNT(__d4(__NN(Inmate_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateIdentificationNumberAssigned',COUNT(__d4(__NL(State_Identification_Number_Assigned_))),COUNT(__d4(__NN(State_Identification_Number_Assigned_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataType',COUNT(__d4(__NL(Data_Type_))),COUNT(__d4(__NN(Data_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSource',COUNT(__d4(__NL(Data_Source_))),COUNT(__d4(__NN(Data_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_score',COUNT(__d4(__NL(Offense_Score_))),COUNT(__d4(__NN(Offense_Score_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseType',COUNT(__d4(__NL(Offense_Type_))),COUNT(__d4(__NN(Offense_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfOffence',COUNT(__d4(__NL(Date_Of_Offence_))),COUNT(__d4(__NN(Date_Of_Offence_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TrafficTicketNumber',COUNT(__d4(__NL(Traffic_Ticket_Number_))),COUNT(__d4(__NN(Traffic_Ticket_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseCategory',COUNT(__d4(__NL(Offense_Category_))),COUNT(__d4(__NN(Offense_Category_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfArrest',COUNT(__d4(__NL(Date_Of_Arrest_))),COUNT(__d4(__NN(Date_Of_Arrest_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyName',COUNT(__d4(__NL(Agency_Name_))),COUNT(__d4(__NN(Agency_Name_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyCaseNumber',COUNT(__d4(__NL(Agency_Case_Number_))),COUNT(__d4(__NN(Agency_Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseCode',COUNT(__d4(__NL(Arrest_Offense_Code_))),COUNT(__d4(__NN(Arrest_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestInitialChargeDescription',COUNT(__d4(__NL(Arrest_Initial_Charge_Description_))),COUNT(__d4(__NN(Arrest_Initial_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestAmendedChargeDescription',COUNT(__d4(__NL(Arrest_Amended_Charge_Description_))),COUNT(__d4(__NN(Arrest_Amended_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenceTypeDescription',COUNT(__d4(__NL(Arrest_Offence_Type_Description_))),COUNT(__d4(__NN(Arrest_Offence_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevel',COUNT(__d4(__NL(Arrest_Offense_Level_))),COUNT(__d4(__NN(Arrest_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDispositionForInitialCharge',COUNT(__d4(__NL(Date_Of_Disposition_For_Initial_Charge_))),COUNT(__d4(__NN(Date_Of_Disposition_For_Initial_Charge_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InitialChargeDispositionDescription',COUNT(__d4(__NL(Initial_Charge_Disposition_Description_))),COUNT(__d4(__NN(Initial_Charge_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalDispositionDescription',COUNT(__d4(__NL(Additional_Disposition_Description_))),COUNT(__d4(__NN(Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenderLevel',COUNT(__d4(__NL(Offender_Level_))),COUNT(__d4(__NN(Offender_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseDate',COUNT(__d4(__NL(Offense_Date_))),COUNT(__d4(__NN(Offense_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_traffic_flag',COUNT(__d4(__NL(Traffic_Flag_))),COUNT(__d4(__NN(Traffic_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_conviction_flag',COUNT(__d4(__NL(Conviction_Flag_))),COUNT(__d4(__NN(Conviction_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraOffenseKey',COUNT(__d4(__NL(Fcra_Offense_Key_))),COUNT(__d4(__NN(Fcra_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraDate',COUNT(__d4(__NL(Fcra_Date_))),COUNT(__d4(__NN(Fcra_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraDateType',COUNT(__d4(__NL(Fcra_Date_Type_))),COUNT(__d4(__NN(Fcra_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConvictionOverrideDate',COUNT(__d4(__NL(Conviction_Override_Date_))),COUNT(__d4(__NN(Conviction_Override_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConvictionOverrideDateType',COUNT(__d4(__NL(Conviction_Override_Date_Type_))),COUNT(__d4(__NN(Conviction_Override_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(__d5)},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d5(__NL(Offender_Key_))),COUNT(__d5(__NN(Offender_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_num',COUNT(__d5(__NL(Case_Number_))),COUNT(__d5(__NN(Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDate',COUNT(__d5(__NL(Court_Date_))),COUNT(__d5(__NN(Court_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_court',COUNT(__d5(__NL(Court_Description_))),COUNT(__d5(__NN(Court_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_date',COUNT(__d5(__NL(Case_Date_))),COUNT(__d5(__NN(Case_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_type_desc',COUNT(__d5(__NL(Case_Type_Description_))),COUNT(__d5(__NN(Case_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCode',COUNT(__d5(__NL(Court_Code_))),COUNT(__d5(__NN(Court_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFinalPlea',COUNT(__d5(__NL(Court_Final_Plea_))),COUNT(__d5(__NN(Court_Final_Plea_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseCode',COUNT(__d5(__NL(Court_Offense_Code_))),COUNT(__d5(__NN(Court_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseDescription',COUNT(__d5(__NL(Court_Offense_Description_))),COUNT(__d5(__NN(Court_Offense_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseAdditionalDescription',COUNT(__d5(__NL(Court_Offense_Additional_Description_))),COUNT(__d5(__NN(Court_Offense_Additional_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevel',COUNT(__d5(__NL(Court_Offense_Level_))),COUNT(__d5(__NN(Court_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtStatute',COUNT(__d5(__NL(Court_Statute_))),COUNT(__d5(__NN(Court_Statute_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDate',COUNT(__d5(__NL(Court_Disposition_Date_))),COUNT(__d5(__NN(Court_Disposition_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionCode',COUNT(__d5(__NL(Court_Disposition_Code_))),COUNT(__d5(__NN(Court_Disposition_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDescription',COUNT(__d5(__NL(Court_Disposition_Description_))),COUNT(__d5(__NN(Court_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtAdditionalDispositionDescription',COUNT(__d5(__NL(Court_Additional_Disposition_Description_))),COUNT(__d5(__NN(Court_Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfAppeal',COUNT(__d5(__NL(Date_Of_Appeal_))),COUNT(__d5(__NN(Date_Of_Appeal_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateofVerdict',COUNT(__d5(__NL(Dateof_Verdict_))),COUNT(__d5(__NN(Dateof_Verdict_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCounty',COUNT(__d5(__NL(Court_County_))),COUNT(__d5(__NN(Court_County_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevelMapped',COUNT(__d5(__NL(Court_Offense_Level_Mapped_))),COUNT(__d5(__NN(Court_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCost',COUNT(__d5(__NL(Court_Cost_))),COUNT(__d5(__NN(Court_Cost_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFine',COUNT(__d5(__NL(Court_Fine_))),COUNT(__d5(__NN(Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SuspendedCourtFine',COUNT(__d5(__NL(Suspended_Court_Fine_))),COUNT(__d5(__NN(Suspended_Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseTown',COUNT(__d5(__NL(Offense_Town_))),COUNT(__d5(__NN(Offense_Town_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevelMapped',COUNT(__d5(__NL(Arrest_Offense_Level_Mapped_))),COUNT(__d5(__NN(Arrest_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersistentOffenseKey',COUNT(__d5(__NL(Persistent_Offense_Key_))),COUNT(__d5(__NN(Persistent_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateOfSource',COUNT(__d5(__NL(State_Of_Source_))),COUNT(__d5(__NN(State_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_of_origin',COUNT(__d5(__NL(County_Of_Source_))),COUNT(__d5(__NN(County_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dle_num',COUNT(__d5(__NL(Department_Of_Law_Enforcement_Number_))),COUNT(__d5(__NN(Department_Of_Law_Enforcement_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fbi_num',COUNT(__d5(__NL(Federal_Bureau_Of_Investigations_Number_))),COUNT(__d5(__NN(Federal_Bureau_Of_Investigations_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','doc_num',COUNT(__d5(__NL(Inmate_Number_))),COUNT(__d5(__NN(Inmate_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','id_num',COUNT(__d5(__NL(State_Identification_Number_Assigned_))),COUNT(__d5(__NN(State_Identification_Number_Assigned_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataType',COUNT(__d5(__NL(Data_Type_))),COUNT(__d5(__NN(Data_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSource',COUNT(__d5(__NL(Data_Source_))),COUNT(__d5(__NN(Data_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_score',COUNT(__d5(__NL(Offense_Score_))),COUNT(__d5(__NN(Offense_Score_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseType',COUNT(__d5(__NL(Offense_Type_))),COUNT(__d5(__NN(Offense_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfOffence',COUNT(__d5(__NL(Date_Of_Offence_))),COUNT(__d5(__NN(Date_Of_Offence_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TrafficTicketNumber',COUNT(__d5(__NL(Traffic_Ticket_Number_))),COUNT(__d5(__NN(Traffic_Ticket_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseCategory',COUNT(__d5(__NL(Offense_Category_))),COUNT(__d5(__NN(Offense_Category_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfArrest',COUNT(__d5(__NL(Date_Of_Arrest_))),COUNT(__d5(__NN(Date_Of_Arrest_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyName',COUNT(__d5(__NL(Agency_Name_))),COUNT(__d5(__NN(Agency_Name_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyCaseNumber',COUNT(__d5(__NL(Agency_Case_Number_))),COUNT(__d5(__NN(Agency_Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseCode',COUNT(__d5(__NL(Arrest_Offense_Code_))),COUNT(__d5(__NN(Arrest_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestInitialChargeDescription',COUNT(__d5(__NL(Arrest_Initial_Charge_Description_))),COUNT(__d5(__NN(Arrest_Initial_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestAmendedChargeDescription',COUNT(__d5(__NL(Arrest_Amended_Charge_Description_))),COUNT(__d5(__NN(Arrest_Amended_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenceTypeDescription',COUNT(__d5(__NL(Arrest_Offence_Type_Description_))),COUNT(__d5(__NN(Arrest_Offence_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevel',COUNT(__d5(__NL(Arrest_Offense_Level_))),COUNT(__d5(__NN(Arrest_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDispositionForInitialCharge',COUNT(__d5(__NL(Date_Of_Disposition_For_Initial_Charge_))),COUNT(__d5(__NN(Date_Of_Disposition_For_Initial_Charge_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InitialChargeDispositionDescription',COUNT(__d5(__NL(Initial_Charge_Disposition_Description_))),COUNT(__d5(__NN(Initial_Charge_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalDispositionDescription',COUNT(__d5(__NL(Additional_Disposition_Description_))),COUNT(__d5(__NN(Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenderLevel',COUNT(__d5(__NL(Offender_Level_))),COUNT(__d5(__NN(Offender_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseDate',COUNT(__d5(__NL(Offense_Date_))),COUNT(__d5(__NN(Offense_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_traffic_flag',COUNT(__d5(__NL(Traffic_Flag_))),COUNT(__d5(__NN(Traffic_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_conviction_flag',COUNT(__d5(__NL(Conviction_Flag_))),COUNT(__d5(__NN(Conviction_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraOffenseKey',COUNT(__d5(__NL(Fcra_Offense_Key_))),COUNT(__d5(__NN(Fcra_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_date',COUNT(__d5(__NL(Fcra_Date_))),COUNT(__d5(__NN(Fcra_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_date_type',COUNT(__d5(__NL(Fcra_Date_Type_))),COUNT(__d5(__NN(Fcra_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date',COUNT(__d5(__NL(Conviction_Override_Date_))),COUNT(__d5(__NN(Conviction_Override_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date_type',COUNT(__d5(__NL(Conviction_Override_Date_Type_))),COUNT(__d5(__NN(Conviction_Override_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(__d6)},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d6(__NL(Offender_Key_))),COUNT(__d6(__NN(Offender_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_num',COUNT(__d6(__NL(Case_Number_))),COUNT(__d6(__NN(Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDate',COUNT(__d6(__NL(Court_Date_))),COUNT(__d6(__NN(Court_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_court',COUNT(__d6(__NL(Court_Description_))),COUNT(__d6(__NN(Court_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_date',COUNT(__d6(__NL(Case_Date_))),COUNT(__d6(__NN(Case_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_type_desc',COUNT(__d6(__NL(Case_Type_Description_))),COUNT(__d6(__NN(Case_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCode',COUNT(__d6(__NL(Court_Code_))),COUNT(__d6(__NN(Court_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFinalPlea',COUNT(__d6(__NL(Court_Final_Plea_))),COUNT(__d6(__NN(Court_Final_Plea_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseCode',COUNT(__d6(__NL(Court_Offense_Code_))),COUNT(__d6(__NN(Court_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseDescription',COUNT(__d6(__NL(Court_Offense_Description_))),COUNT(__d6(__NN(Court_Offense_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseAdditionalDescription',COUNT(__d6(__NL(Court_Offense_Additional_Description_))),COUNT(__d6(__NN(Court_Offense_Additional_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevel',COUNT(__d6(__NL(Court_Offense_Level_))),COUNT(__d6(__NN(Court_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtStatute',COUNT(__d6(__NL(Court_Statute_))),COUNT(__d6(__NN(Court_Statute_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDate',COUNT(__d6(__NL(Court_Disposition_Date_))),COUNT(__d6(__NN(Court_Disposition_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionCode',COUNT(__d6(__NL(Court_Disposition_Code_))),COUNT(__d6(__NN(Court_Disposition_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtDispositionDescription',COUNT(__d6(__NL(Court_Disposition_Description_))),COUNT(__d6(__NN(Court_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtAdditionalDispositionDescription',COUNT(__d6(__NL(Court_Additional_Disposition_Description_))),COUNT(__d6(__NN(Court_Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfAppeal',COUNT(__d6(__NL(Date_Of_Appeal_))),COUNT(__d6(__NN(Date_Of_Appeal_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateofVerdict',COUNT(__d6(__NL(Dateof_Verdict_))),COUNT(__d6(__NN(Dateof_Verdict_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCounty',COUNT(__d6(__NL(Court_County_))),COUNT(__d6(__NN(Court_County_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtOffenseLevelMapped',COUNT(__d6(__NL(Court_Offense_Level_Mapped_))),COUNT(__d6(__NN(Court_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCost',COUNT(__d6(__NL(Court_Cost_))),COUNT(__d6(__NN(Court_Cost_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtFine',COUNT(__d6(__NL(Court_Fine_))),COUNT(__d6(__NN(Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SuspendedCourtFine',COUNT(__d6(__NL(Suspended_Court_Fine_))),COUNT(__d6(__NN(Suspended_Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseTown',COUNT(__d6(__NL(Offense_Town_))),COUNT(__d6(__NN(Offense_Town_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevelMapped',COUNT(__d6(__NL(Arrest_Offense_Level_Mapped_))),COUNT(__d6(__NN(Arrest_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersistentOffenseKey',COUNT(__d6(__NL(Persistent_Offense_Key_))),COUNT(__d6(__NN(Persistent_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateOfSource',COUNT(__d6(__NL(State_Of_Source_))),COUNT(__d6(__NN(State_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_of_origin',COUNT(__d6(__NL(County_Of_Source_))),COUNT(__d6(__NN(County_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dle_num',COUNT(__d6(__NL(Department_Of_Law_Enforcement_Number_))),COUNT(__d6(__NN(Department_Of_Law_Enforcement_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fbi_num',COUNT(__d6(__NL(Federal_Bureau_Of_Investigations_Number_))),COUNT(__d6(__NN(Federal_Bureau_Of_Investigations_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','doc_num',COUNT(__d6(__NL(Inmate_Number_))),COUNT(__d6(__NN(Inmate_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','id_num',COUNT(__d6(__NL(State_Identification_Number_Assigned_))),COUNT(__d6(__NN(State_Identification_Number_Assigned_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataType',COUNT(__d6(__NL(Data_Type_))),COUNT(__d6(__NN(Data_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSource',COUNT(__d6(__NL(Data_Source_))),COUNT(__d6(__NN(Data_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offense_score',COUNT(__d6(__NL(Offense_Score_))),COUNT(__d6(__NN(Offense_Score_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseType',COUNT(__d6(__NL(Offense_Type_))),COUNT(__d6(__NN(Offense_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfOffence',COUNT(__d6(__NL(Date_Of_Offence_))),COUNT(__d6(__NN(Date_Of_Offence_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TrafficTicketNumber',COUNT(__d6(__NL(Traffic_Ticket_Number_))),COUNT(__d6(__NN(Traffic_Ticket_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseCategory',COUNT(__d6(__NL(Offense_Category_))),COUNT(__d6(__NN(Offense_Category_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfArrest',COUNT(__d6(__NL(Date_Of_Arrest_))),COUNT(__d6(__NN(Date_Of_Arrest_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyName',COUNT(__d6(__NL(Agency_Name_))),COUNT(__d6(__NN(Agency_Name_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyCaseNumber',COUNT(__d6(__NL(Agency_Case_Number_))),COUNT(__d6(__NN(Agency_Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseCode',COUNT(__d6(__NL(Arrest_Offense_Code_))),COUNT(__d6(__NN(Arrest_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestInitialChargeDescription',COUNT(__d6(__NL(Arrest_Initial_Charge_Description_))),COUNT(__d6(__NN(Arrest_Initial_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestAmendedChargeDescription',COUNT(__d6(__NL(Arrest_Amended_Charge_Description_))),COUNT(__d6(__NN(Arrest_Amended_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenceTypeDescription',COUNT(__d6(__NL(Arrest_Offence_Type_Description_))),COUNT(__d6(__NN(Arrest_Offence_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ArrestOffenseLevel',COUNT(__d6(__NL(Arrest_Offense_Level_))),COUNT(__d6(__NN(Arrest_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDispositionForInitialCharge',COUNT(__d6(__NL(Date_Of_Disposition_For_Initial_Charge_))),COUNT(__d6(__NN(Date_Of_Disposition_For_Initial_Charge_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InitialChargeDispositionDescription',COUNT(__d6(__NL(Initial_Charge_Disposition_Description_))),COUNT(__d6(__NN(Initial_Charge_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalDispositionDescription',COUNT(__d6(__NL(Additional_Disposition_Description_))),COUNT(__d6(__NN(Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenderLevel',COUNT(__d6(__NL(Offender_Level_))),COUNT(__d6(__NN(Offender_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OffenseDate',COUNT(__d6(__NL(Offense_Date_))),COUNT(__d6(__NN(Offense_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_traffic_flag',COUNT(__d6(__NL(Traffic_Flag_))),COUNT(__d6(__NN(Traffic_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_conviction_flag',COUNT(__d6(__NL(Conviction_Flag_))),COUNT(__d6(__NN(Conviction_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FcraOffenseKey',COUNT(__d6(__NL(Fcra_Offense_Key_))),COUNT(__d6(__NN(Fcra_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_date',COUNT(__d6(__NL(Fcra_Date_))),COUNT(__d6(__NN(Fcra_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fcra_date_type',COUNT(__d6(__NL(Fcra_Date_Type_))),COUNT(__d6(__NN(Fcra_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date',COUNT(__d6(__NL(Conviction_Override_Date_))),COUNT(__d6(__NN(Conviction_Override_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conviction_override_date_type',COUNT(__d6(__NL(Conviction_Override_Date_Type_))),COUNT(__d6(__NN(Conviction_Override_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
