//HPCC Systems KEL Compiler Version 0.11.6
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
    KEL.typ.nstr Inmate_Document_Number_;
    KEL.typ.nint State_Identification_Number_Assigned_;
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
    KEL.typ.nstr Fcra_Conviction_Flag_;
    KEL.typ.nstr Fcra_Traffic_Flag_;
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
  SHARED __Mapping := 'UID(UID),offenderkey(Offender_Key_),casenumber(Case_Number_:\'\'),courtdate(Court_Date_:DATE),courtdescription(Court_Description_:\'\'),casedate(Case_Date_:DATE),casetypedescription(Case_Type_Description_:\'\'),courtcode(Court_Code_:\'\'),courtfinalplea(Court_Final_Plea_:\'\'),courtoffensecode(Court_Offense_Code_:\'\'),courtoffensedescription(Court_Offense_Description_:\'\'),courtoffenseadditionaldescription(Court_Offense_Additional_Description_:\'\'),courtoffenselevel(Court_Offense_Level_:\'\'),courtstatute(Court_Statute_:\'\'),courtdispositiondate(Court_Disposition_Date_:DATE),courtdispositioncode(Court_Disposition_Code_:\'\'),courtdispositiondescription(Court_Disposition_Description_:\'\'),courtadditionaldispositiondescription(Court_Additional_Disposition_Description_:\'\'),dateofappeal(Date_Of_Appeal_:DATE),dateofverdict(Dateof_Verdict_:DATE),courtcounty(Court_County_:\'\'),courtoffenselevelmapped(Court_Offense_Level_Mapped_:\'\'),courtcost(Court_Cost_:0),courtfine(Court_Fine_:0),suspendedcourtfine(Suspended_Court_Fine_:\'\'),offensetown(Offense_Town_:\'\'),arrestoffenselevelmapped(Arrest_Offense_Level_Mapped_:\'\'),persistentoffensekey(Persistent_Offense_Key_:\'\'),stateofsource(State_Of_Source_:\'\'),countyofsource(County_Of_Source_:\'\'),departmentoflawenforcementnumber(Department_Of_Law_Enforcement_Number_:\'\'),federalbureauofinvestigationsnumber(Federal_Bureau_Of_Investigations_Number_:\'\'),inmatedocumentnumber(Inmate_Document_Number_:\'\'),stateidentificationnumberassigned(State_Identification_Number_Assigned_:0),datatype(Data_Type_:0),datasource(Data_Source_:\'\'),offensescore(Offense_Score_:\'\'),offensetype(Offense_Type_:\'\'),dateofoffence(Date_Of_Offence_:DATE),trafficticketnumber(Traffic_Ticket_Number_:\'\'),offensecategory(Offense_Category_:0),dateofarrest(Date_Of_Arrest_:DATE),agencyname(Agency_Name_:\'\'),agencycasenumber(Agency_Case_Number_:0),arrestoffensecode(Arrest_Offense_Code_:\'\'),arrestinitialchargedescription(Arrest_Initial_Charge_Description_:\'\'),arrestamendedchargedescription(Arrest_Amended_Charge_Description_:\'\'),arrestoffencetypedescription(Arrest_Offence_Type_Description_:\'\'),arrestoffenselevel(Arrest_Offense_Level_:\'\'),dateofdispositionforinitialcharge(Date_Of_Disposition_For_Initial_Charge_:DATE),initialchargedispositiondescription(Initial_Charge_Disposition_Description_:\'\'),additionaldispositiondescription(Additional_Disposition_Description_:\'\'),offenderlevel(Offender_Level_:0),offensedate(Offense_Date_:DATE),trafficflag(Traffic_Flag_:\'\'),convictionflag(Conviction_Flag_:\'\'),fcraoffensekey(Fcra_Offense_Key_:\'\'),fcraconvictionflag(Fcra_Conviction_Flag_:\'\'),fcratrafficflag(Fcra_Traffic_Flag_:\'\'),fcradate(Fcra_Date_:DATE),fcradatetype(Fcra_Date_Type_:\'\'),convictionoverridedate(Conviction_Override_Date_:DATE),convictionoverridedatetype(Conviction_Override_Date_Type_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.OffenderKey)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  EXPORT Lookup := PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Blank_DataSet);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.OffenderKey) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Blank_DataSet_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
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
  EXPORT Fcra_Data_Layout := RECORD
    KEL.typ.nstr Fcra_Offense_Key_;
    KEL.typ.nstr Fcra_Conviction_Flag_;
    KEL.typ.nstr Fcra_Traffic_Flag_;
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
    KEL.typ.nint Offender_Level_;
    KEL.typ.ndataset(Offense_Charges_Layout) Offense_Charges_;
    KEL.typ.ndataset(Criminal_Data_Sources_Layout) Criminal_Data_Sources_;
    KEL.typ.nstr County_Of_Source_;
    KEL.typ.nstr State_Of_Source_;
    KEL.typ.nstr Department_Of_Law_Enforcement_Number_;
    KEL.typ.nstr Federal_Bureau_Of_Investigations_Number_;
    KEL.typ.nstr Inmate_Document_Number_;
    KEL.typ.nint State_Identification_Number_Assigned_;
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
    KEL.typ.nstr Court_Offense_Level_;
    KEL.typ.nkdate Court_Date_;
    KEL.typ.nstr Court_County_;
    KEL.typ.nstr Arrest_Offense_Level_Mapped_;
    KEL.typ.nstr Court_Offense_Level_Mapped_;
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
    SELF.Offender_Level_ := KEL.Intake.SingleValue(__recs,Offender_Level_);
    SELF.Offense_Charges_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Case_Number_,Case_Date_,Case_Type_Description_,Offense_Date_,Offense_Score_,Data_Type_,Traffic_Flag_,Conviction_Flag_},Case_Number_,Case_Date_,Case_Type_Description_,Offense_Date_,Offense_Score_,Data_Type_,Traffic_Flag_,Conviction_Flag_),Offense_Charges_Layout)(__NN(Case_Number_) OR __NN(Case_Date_) OR __NN(Case_Type_Description_) OR __NN(Offense_Date_) OR __NN(Offense_Score_) OR __NN(Data_Type_) OR __NN(Traffic_Flag_) OR __NN(Conviction_Flag_)));
    SELF.Criminal_Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Data_Source_},Data_Source_),Criminal_Data_Sources_Layout)(__NN(Data_Source_)));
    SELF.County_Of_Source_ := KEL.Intake.SingleValue(__recs,County_Of_Source_);
    SELF.State_Of_Source_ := KEL.Intake.SingleValue(__recs,State_Of_Source_);
    SELF.Department_Of_Law_Enforcement_Number_ := KEL.Intake.SingleValue(__recs,Department_Of_Law_Enforcement_Number_);
    SELF.Federal_Bureau_Of_Investigations_Number_ := KEL.Intake.SingleValue(__recs,Federal_Bureau_Of_Investigations_Number_);
    SELF.Inmate_Document_Number_ := KEL.Intake.SingleValue(__recs,Inmate_Document_Number_);
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
    SELF.Court_Offense_Level_ := KEL.Intake.SingleValue(__recs,Court_Offense_Level_);
    SELF.Court_Date_ := KEL.Intake.SingleValue(__recs,Court_Date_);
    SELF.Court_County_ := KEL.Intake.SingleValue(__recs,Court_County_);
    SELF.Arrest_Offense_Level_Mapped_ := KEL.Intake.SingleValue(__recs,Arrest_Offense_Level_Mapped_);
    SELF.Court_Offense_Level_Mapped_ := KEL.Intake.SingleValue(__recs,Court_Offense_Level_Mapped_);
    SELF.Fcra_Data_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Fcra_Offense_Key_,Fcra_Conviction_Flag_,Fcra_Traffic_Flag_,Fcra_Date_,Fcra_Date_Type_},Fcra_Offense_Key_,Fcra_Conviction_Flag_,Fcra_Traffic_Flag_,Fcra_Date_,Fcra_Date_Type_),Fcra_Data_Layout)(__NN(Fcra_Offense_Key_) OR __NN(Fcra_Conviction_Flag_) OR __NN(Fcra_Traffic_Flag_) OR __NN(Fcra_Date_) OR __NN(Fcra_Date_Type_)));
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
    SELF.Fcra_Data_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Fcra_Data_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Fcra_Offense_Key_) OR __NN(Fcra_Conviction_Flag_) OR __NN(Fcra_Traffic_Flag_) OR __NN(Fcra_Date_) OR __NN(Fcra_Date_Type_)));
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
  EXPORT Offender_Level__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Offender_Level_);
  EXPORT County_Of_Source__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_Of_Source_);
  EXPORT State_Of_Source__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_Of_Source_);
  EXPORT Department_Of_Law_Enforcement_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Department_Of_Law_Enforcement_Number_);
  EXPORT Federal_Bureau_Of_Investigations_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Federal_Bureau_Of_Investigations_Number_);
  EXPORT Inmate_Document_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Inmate_Document_Number_);
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
  EXPORT Court_Offense_Level__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Offense_Level_);
  EXPORT Court_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Date_);
  EXPORT Court_County__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_County_);
  EXPORT Arrest_Offense_Level_Mapped__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Arrest_Offense_Level_Mapped_);
  EXPORT Court_Offense_Level_Mapped__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Offense_Level_Mapped_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Blank_DataSet_Invalid),COUNT(Offender_Key__SingleValue_Invalid),COUNT(Offense_Type__SingleValue_Invalid),COUNT(Date_Of_Offence__SingleValue_Invalid),COUNT(Offense_Category__SingleValue_Invalid),COUNT(Offender_Level__SingleValue_Invalid),COUNT(County_Of_Source__SingleValue_Invalid),COUNT(State_Of_Source__SingleValue_Invalid),COUNT(Department_Of_Law_Enforcement_Number__SingleValue_Invalid),COUNT(Federal_Bureau_Of_Investigations_Number__SingleValue_Invalid),COUNT(Inmate_Document_Number__SingleValue_Invalid),COUNT(State_Identification_Number_Assigned__SingleValue_Invalid),COUNT(Date_Of_Arrest__SingleValue_Invalid),COUNT(Agency_Name__SingleValue_Invalid),COUNT(Agency_Case_Number__SingleValue_Invalid),COUNT(Traffic_Ticket_Number__SingleValue_Invalid),COUNT(Arrest_Offense_Code__SingleValue_Invalid),COUNT(Arrest_Initial_Charge_Description__SingleValue_Invalid),COUNT(Arrest_Amended_Charge_Description__SingleValue_Invalid),COUNT(Arrest_Offense_Level__SingleValue_Invalid),COUNT(Date_Of_Disposition_For_Initial_Charge__SingleValue_Invalid),COUNT(Arrest_Offence_Type_Description__SingleValue_Invalid),COUNT(Initial_Charge_Disposition_Description__SingleValue_Invalid),COUNT(Additional_Disposition_Description__SingleValue_Invalid),COUNT(Court_Code__SingleValue_Invalid),COUNT(Court_Description__SingleValue_Invalid),COUNT(Court_Final_Plea__SingleValue_Invalid),COUNT(Court_Offense_Code__SingleValue_Invalid),COUNT(Court_Offense_Description__SingleValue_Invalid),COUNT(Court_Offense_Additional_Description__SingleValue_Invalid),COUNT(Court_Statute__SingleValue_Invalid),COUNT(Court_Disposition_Date__SingleValue_Invalid),COUNT(Court_Fine__SingleValue_Invalid),COUNT(Suspended_Court_Fine__SingleValue_Invalid),COUNT(Court_Cost__SingleValue_Invalid),COUNT(Court_Disposition_Code__SingleValue_Invalid),COUNT(Court_Disposition_Description__SingleValue_Invalid),COUNT(Court_Additional_Disposition_Description__SingleValue_Invalid),COUNT(Date_Of_Appeal__SingleValue_Invalid),COUNT(Dateof_Verdict__SingleValue_Invalid),COUNT(Offense_Town__SingleValue_Invalid),COUNT(Persistent_Offense_Key__SingleValue_Invalid),COUNT(Court_Offense_Level__SingleValue_Invalid),COUNT(Court_Date__SingleValue_Invalid),COUNT(Court_County__SingleValue_Invalid),COUNT(Arrest_Offense_Level_Mapped__SingleValue_Invalid),COUNT(Court_Offense_Level_Mapped__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Blank_DataSet_Invalid,KEL.typ.int Offender_Key__SingleValue_Invalid,KEL.typ.int Offense_Type__SingleValue_Invalid,KEL.typ.int Date_Of_Offence__SingleValue_Invalid,KEL.typ.int Offense_Category__SingleValue_Invalid,KEL.typ.int Offender_Level__SingleValue_Invalid,KEL.typ.int County_Of_Source__SingleValue_Invalid,KEL.typ.int State_Of_Source__SingleValue_Invalid,KEL.typ.int Department_Of_Law_Enforcement_Number__SingleValue_Invalid,KEL.typ.int Federal_Bureau_Of_Investigations_Number__SingleValue_Invalid,KEL.typ.int Inmate_Document_Number__SingleValue_Invalid,KEL.typ.int State_Identification_Number_Assigned__SingleValue_Invalid,KEL.typ.int Date_Of_Arrest__SingleValue_Invalid,KEL.typ.int Agency_Name__SingleValue_Invalid,KEL.typ.int Agency_Case_Number__SingleValue_Invalid,KEL.typ.int Traffic_Ticket_Number__SingleValue_Invalid,KEL.typ.int Arrest_Offense_Code__SingleValue_Invalid,KEL.typ.int Arrest_Initial_Charge_Description__SingleValue_Invalid,KEL.typ.int Arrest_Amended_Charge_Description__SingleValue_Invalid,KEL.typ.int Arrest_Offense_Level__SingleValue_Invalid,KEL.typ.int Date_Of_Disposition_For_Initial_Charge__SingleValue_Invalid,KEL.typ.int Arrest_Offence_Type_Description__SingleValue_Invalid,KEL.typ.int Initial_Charge_Disposition_Description__SingleValue_Invalid,KEL.typ.int Additional_Disposition_Description__SingleValue_Invalid,KEL.typ.int Court_Code__SingleValue_Invalid,KEL.typ.int Court_Description__SingleValue_Invalid,KEL.typ.int Court_Final_Plea__SingleValue_Invalid,KEL.typ.int Court_Offense_Code__SingleValue_Invalid,KEL.typ.int Court_Offense_Description__SingleValue_Invalid,KEL.typ.int Court_Offense_Additional_Description__SingleValue_Invalid,KEL.typ.int Court_Statute__SingleValue_Invalid,KEL.typ.int Court_Disposition_Date__SingleValue_Invalid,KEL.typ.int Court_Fine__SingleValue_Invalid,KEL.typ.int Suspended_Court_Fine__SingleValue_Invalid,KEL.typ.int Court_Cost__SingleValue_Invalid,KEL.typ.int Court_Disposition_Code__SingleValue_Invalid,KEL.typ.int Court_Disposition_Description__SingleValue_Invalid,KEL.typ.int Court_Additional_Disposition_Description__SingleValue_Invalid,KEL.typ.int Date_Of_Appeal__SingleValue_Invalid,KEL.typ.int Dateof_Verdict__SingleValue_Invalid,KEL.typ.int Offense_Town__SingleValue_Invalid,KEL.typ.int Persistent_Offense_Key__SingleValue_Invalid,KEL.typ.int Court_Offense_Level__SingleValue_Invalid,KEL.typ.int Court_Date__SingleValue_Invalid,KEL.typ.int Court_County__SingleValue_Invalid,KEL.typ.int Arrest_Offense_Level_Mapped__SingleValue_Invalid,KEL.typ.int Court_Offense_Level_Mapped__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','UID',COUNT(PublicRecords_KEL_ECL_Functions_Blank_DataSet_Invalid),COUNT(__d0)},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','OffenderKey',COUNT(__d0(__NL(Offender_Key_))),COUNT(__d0(__NN(Offender_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CaseNumber',COUNT(__d0(__NL(Case_Number_))),COUNT(__d0(__NN(Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtDate',COUNT(__d0(__NL(Court_Date_))),COUNT(__d0(__NN(Court_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtDescription',COUNT(__d0(__NL(Court_Description_))),COUNT(__d0(__NN(Court_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CaseDate',COUNT(__d0(__NL(Case_Date_))),COUNT(__d0(__NN(Case_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CaseTypeDescription',COUNT(__d0(__NL(Case_Type_Description_))),COUNT(__d0(__NN(Case_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtCode',COUNT(__d0(__NL(Court_Code_))),COUNT(__d0(__NN(Court_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtFinalPlea',COUNT(__d0(__NL(Court_Final_Plea_))),COUNT(__d0(__NN(Court_Final_Plea_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtOffenseCode',COUNT(__d0(__NL(Court_Offense_Code_))),COUNT(__d0(__NN(Court_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtOffenseDescription',COUNT(__d0(__NL(Court_Offense_Description_))),COUNT(__d0(__NN(Court_Offense_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtOffenseAdditionalDescription',COUNT(__d0(__NL(Court_Offense_Additional_Description_))),COUNT(__d0(__NN(Court_Offense_Additional_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtOffenseLevel',COUNT(__d0(__NL(Court_Offense_Level_))),COUNT(__d0(__NN(Court_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtStatute',COUNT(__d0(__NL(Court_Statute_))),COUNT(__d0(__NN(Court_Statute_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtDispositionDate',COUNT(__d0(__NL(Court_Disposition_Date_))),COUNT(__d0(__NN(Court_Disposition_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtDispositionCode',COUNT(__d0(__NL(Court_Disposition_Code_))),COUNT(__d0(__NN(Court_Disposition_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtDispositionDescription',COUNT(__d0(__NL(Court_Disposition_Description_))),COUNT(__d0(__NN(Court_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtAdditionalDispositionDescription',COUNT(__d0(__NL(Court_Additional_Disposition_Description_))),COUNT(__d0(__NN(Court_Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DateOfAppeal',COUNT(__d0(__NL(Date_Of_Appeal_))),COUNT(__d0(__NN(Date_Of_Appeal_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DateofVerdict',COUNT(__d0(__NL(Dateof_Verdict_))),COUNT(__d0(__NN(Dateof_Verdict_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtCounty',COUNT(__d0(__NL(Court_County_))),COUNT(__d0(__NN(Court_County_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtOffenseLevelMapped',COUNT(__d0(__NL(Court_Offense_Level_Mapped_))),COUNT(__d0(__NN(Court_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtCost',COUNT(__d0(__NL(Court_Cost_))),COUNT(__d0(__NN(Court_Cost_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CourtFine',COUNT(__d0(__NL(Court_Fine_))),COUNT(__d0(__NN(Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','SuspendedCourtFine',COUNT(__d0(__NL(Suspended_Court_Fine_))),COUNT(__d0(__NN(Suspended_Court_Fine_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','OffenseTown',COUNT(__d0(__NL(Offense_Town_))),COUNT(__d0(__NN(Offense_Town_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','ArrestOffenseLevelMapped',COUNT(__d0(__NL(Arrest_Offense_Level_Mapped_))),COUNT(__d0(__NN(Arrest_Offense_Level_Mapped_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','PersistentOffenseKey',COUNT(__d0(__NL(Persistent_Offense_Key_))),COUNT(__d0(__NN(Persistent_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','StateOfSource',COUNT(__d0(__NL(State_Of_Source_))),COUNT(__d0(__NN(State_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','CountyOfSource',COUNT(__d0(__NL(County_Of_Source_))),COUNT(__d0(__NN(County_Of_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DepartmentOfLawEnforcementNumber',COUNT(__d0(__NL(Department_Of_Law_Enforcement_Number_))),COUNT(__d0(__NN(Department_Of_Law_Enforcement_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','FederalBureauOfInvestigationsNumber',COUNT(__d0(__NL(Federal_Bureau_Of_Investigations_Number_))),COUNT(__d0(__NN(Federal_Bureau_Of_Investigations_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','InmateDocumentNumber',COUNT(__d0(__NL(Inmate_Document_Number_))),COUNT(__d0(__NN(Inmate_Document_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','StateIdentificationNumberAssigned',COUNT(__d0(__NL(State_Identification_Number_Assigned_))),COUNT(__d0(__NN(State_Identification_Number_Assigned_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DataType',COUNT(__d0(__NL(Data_Type_))),COUNT(__d0(__NN(Data_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DataSource',COUNT(__d0(__NL(Data_Source_))),COUNT(__d0(__NN(Data_Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','OffenseScore',COUNT(__d0(__NL(Offense_Score_))),COUNT(__d0(__NN(Offense_Score_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','OffenseType',COUNT(__d0(__NL(Offense_Type_))),COUNT(__d0(__NN(Offense_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DateOfOffence',COUNT(__d0(__NL(Date_Of_Offence_))),COUNT(__d0(__NN(Date_Of_Offence_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','TrafficTicketNumber',COUNT(__d0(__NL(Traffic_Ticket_Number_))),COUNT(__d0(__NN(Traffic_Ticket_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','OffenseCategory',COUNT(__d0(__NL(Offense_Category_))),COUNT(__d0(__NN(Offense_Category_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DateOfArrest',COUNT(__d0(__NL(Date_Of_Arrest_))),COUNT(__d0(__NN(Date_Of_Arrest_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','AgencyName',COUNT(__d0(__NL(Agency_Name_))),COUNT(__d0(__NN(Agency_Name_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','AgencyCaseNumber',COUNT(__d0(__NL(Agency_Case_Number_))),COUNT(__d0(__NN(Agency_Case_Number_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','ArrestOffenseCode',COUNT(__d0(__NL(Arrest_Offense_Code_))),COUNT(__d0(__NN(Arrest_Offense_Code_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','ArrestInitialChargeDescription',COUNT(__d0(__NL(Arrest_Initial_Charge_Description_))),COUNT(__d0(__NN(Arrest_Initial_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','ArrestAmendedChargeDescription',COUNT(__d0(__NL(Arrest_Amended_Charge_Description_))),COUNT(__d0(__NN(Arrest_Amended_Charge_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','ArrestOffenceTypeDescription',COUNT(__d0(__NL(Arrest_Offence_Type_Description_))),COUNT(__d0(__NN(Arrest_Offence_Type_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','ArrestOffenseLevel',COUNT(__d0(__NL(Arrest_Offense_Level_))),COUNT(__d0(__NN(Arrest_Offense_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DateOfDispositionForInitialCharge',COUNT(__d0(__NL(Date_Of_Disposition_For_Initial_Charge_))),COUNT(__d0(__NN(Date_Of_Disposition_For_Initial_Charge_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','InitialChargeDispositionDescription',COUNT(__d0(__NL(Initial_Charge_Disposition_Description_))),COUNT(__d0(__NN(Initial_Charge_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','AdditionalDispositionDescription',COUNT(__d0(__NL(Additional_Disposition_Description_))),COUNT(__d0(__NN(Additional_Disposition_Description_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','OffenderLevel',COUNT(__d0(__NL(Offender_Level_))),COUNT(__d0(__NN(Offender_Level_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','OffenseDate',COUNT(__d0(__NL(Offense_Date_))),COUNT(__d0(__NN(Offense_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','TrafficFlag',COUNT(__d0(__NL(Traffic_Flag_))),COUNT(__d0(__NN(Traffic_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','ConvictionFlag',COUNT(__d0(__NL(Conviction_Flag_))),COUNT(__d0(__NN(Conviction_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','FcraOffenseKey',COUNT(__d0(__NL(Fcra_Offense_Key_))),COUNT(__d0(__NN(Fcra_Offense_Key_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','FcraConvictionFlag',COUNT(__d0(__NL(Fcra_Conviction_Flag_))),COUNT(__d0(__NN(Fcra_Conviction_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','FcraTrafficFlag',COUNT(__d0(__NL(Fcra_Traffic_Flag_))),COUNT(__d0(__NN(Fcra_Traffic_Flag_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','FcraDate',COUNT(__d0(__NL(Fcra_Date_))),COUNT(__d0(__NN(Fcra_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','FcraDateType',COUNT(__d0(__NL(Fcra_Date_Type_))),COUNT(__d0(__NN(Fcra_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','ConvictionOverrideDate',COUNT(__d0(__NL(Conviction_Override_Date_))),COUNT(__d0(__NN(Conviction_Override_Date_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','ConvictionOverrideDateType',COUNT(__d0(__NL(Conviction_Override_Date_Type_))),COUNT(__d0(__NN(Conviction_Override_Date_Type_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CriminalOffense','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
