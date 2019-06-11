//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Bank := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr _hit_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),routingnumber(Routing_Number_:\'\'),fullbankname(Full_Bankname_:\'\'),abbreviatedbankname(Abbreviated_Bankname_:\'\'),fractionalroutingnumber(Fractional_Routingnumber_:\'\'),headofficeroutingnumber(Headoffice_Routingnumber_:\'\'),headofficebranchcodes(Headoffice_Branchcodes_:\'\'),hit(_hit_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared(bank_routing_number_1 != '' AND bank_account_number_1 != '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1)));
  SHARED __d1_KELfiltered := KELOtto.fraudgovshared(bank_routing_number_2 != '' AND bank_account_number_2 != '');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_2)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Bank::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Bank');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Bank');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),bank_routing_number_1(Routing_Number_:\'\'),bank1fullbankname(Full_Bankname_:\'\'),bank1abbreviatedbankname(Abbreviated_Bankname_:\'\'),bank1fractionalroutingnumber(Fractional_Routingnumber_:\'\'),bank1headofficeroutingnumber(Headoffice_Routingnumber_:\'\'),bank1headofficebranchcodes(Headoffice_Branchcodes_:\'\'),bank1hit(_hit_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_fraudgovshared_1_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),bank_routing_number_2(Routing_Number_:\'\'),bank2fullbankname(Full_Bankname_:\'\'),bank2abbreviatedbankname(Abbreviated_Bankname_:\'\'),bank2fractionalroutingnumber(Fractional_Routingnumber_:\'\'),bank2headofficeroutingnumber(Headoffice_Routingnumber_:\'\'),bank2headofficebranchcodes(Headoffice_Branchcodes_:\'\'),bank2hit(_hit_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d1_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_2) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_fraudgovshared_2_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Source_Customers_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr _hit_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Bank_Group := __PostFilter;
  Layout Bank__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF.Source_Customers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Source_Customer_},_r_Source_Customer_),Source_Customers_Layout)(__NN(_r_Source_Customer_)));
    SELF.Routing_Number_ := KEL.Intake.SingleValue(__recs,Routing_Number_);
    SELF.Full_Bankname_ := KEL.Intake.SingleValue(__recs,Full_Bankname_);
    SELF.Abbreviated_Bankname_ := KEL.Intake.SingleValue(__recs,Abbreviated_Bankname_);
    SELF.Fractional_Routingnumber_ := KEL.Intake.SingleValue(__recs,Fractional_Routingnumber_);
    SELF.Headoffice_Routingnumber_ := KEL.Intake.SingleValue(__recs,Headoffice_Routingnumber_);
    SELF.Headoffice_Branchcodes_ := KEL.Intake.SingleValue(__recs,Headoffice_Branchcodes_);
    SELF._hit_ := KEL.Intake.SingleValue(__recs,_hit_);
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Bank__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Bank_Group,COUNT(ROWS(LEFT))=1),GROUP,Bank__Single_Rollup(LEFT)) + ROLLUP(HAVING(Bank_Group,COUNT(ROWS(LEFT))>1),GROUP,Bank__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Bank::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT Routing_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Routing_Number_);
  EXPORT Full_Bankname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Full_Bankname_);
  EXPORT Abbreviated_Bankname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Abbreviated_Bankname_);
  EXPORT Fractional_Routingnumber__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fractional_Routingnumber_);
  EXPORT Headoffice_Routingnumber__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Headoffice_Routingnumber_);
  EXPORT Headoffice_Branchcodes__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Headoffice_Branchcodes_);
  EXPORT _hit__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_hit_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(KELOtto_fraudgovshared_1_Invalid),COUNT(KELOtto_fraudgovshared_2_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(Routing_Number__SingleValue_Invalid),COUNT(Full_Bankname__SingleValue_Invalid),COUNT(Abbreviated_Bankname__SingleValue_Invalid),COUNT(Fractional_Routingnumber__SingleValue_Invalid),COUNT(Headoffice_Routingnumber__SingleValue_Invalid),COUNT(Headoffice_Branchcodes__SingleValue_Invalid),COUNT(_hit__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int KELOtto_fraudgovshared_1_Invalid,KEL.typ.int KELOtto_fraudgovshared_2_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int Routing_Number__SingleValue_Invalid,KEL.typ.int Full_Bankname__SingleValue_Invalid,KEL.typ.int Abbreviated_Bankname__SingleValue_Invalid,KEL.typ.int Fractional_Routingnumber__SingleValue_Invalid,KEL.typ.int Headoffice_Routingnumber__SingleValue_Invalid,KEL.typ.int Headoffice_Branchcodes__SingleValue_Invalid,KEL.typ.int _hit__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Bank','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_1_Invalid),COUNT(__d0)},
    {'Bank','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'Bank','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'Bank','KELOtto.fraudgovshared','bank_routing_number_1',COUNT(__d0(__NL(Routing_Number_))),COUNT(__d0(__NN(Routing_Number_)))},
    {'Bank','KELOtto.fraudgovshared','bank1FullBankname',COUNT(__d0(__NL(Full_Bankname_))),COUNT(__d0(__NN(Full_Bankname_)))},
    {'Bank','KELOtto.fraudgovshared','bank1AbbreviatedBankname',COUNT(__d0(__NL(Abbreviated_Bankname_))),COUNT(__d0(__NN(Abbreviated_Bankname_)))},
    {'Bank','KELOtto.fraudgovshared','bank1FractionalRoutingnumber',COUNT(__d0(__NL(Fractional_Routingnumber_))),COUNT(__d0(__NN(Fractional_Routingnumber_)))},
    {'Bank','KELOtto.fraudgovshared','bank1HeadofficeRoutingnumber',COUNT(__d0(__NL(Headoffice_Routingnumber_))),COUNT(__d0(__NN(Headoffice_Routingnumber_)))},
    {'Bank','KELOtto.fraudgovshared','bank1HeadofficeBranchcodes',COUNT(__d0(__NL(Headoffice_Branchcodes_))),COUNT(__d0(__NN(Headoffice_Branchcodes_)))},
    {'Bank','KELOtto.fraudgovshared','bank1hit',COUNT(__d0(__NL(_hit_))),COUNT(__d0(__NN(_hit_)))},
    {'Bank','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Bank','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Bank','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_2_Invalid),COUNT(__d1)},
    {'Bank','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'Bank','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d1(__NL(_r_Source_Customer_))),COUNT(__d1(__NN(_r_Source_Customer_)))},
    {'Bank','KELOtto.fraudgovshared','bank_routing_number_2',COUNT(__d1(__NL(Routing_Number_))),COUNT(__d1(__NN(Routing_Number_)))},
    {'Bank','KELOtto.fraudgovshared','bank2FullBankname',COUNT(__d1(__NL(Full_Bankname_))),COUNT(__d1(__NN(Full_Bankname_)))},
    {'Bank','KELOtto.fraudgovshared','bank2AbbreviatedBankname',COUNT(__d1(__NL(Abbreviated_Bankname_))),COUNT(__d1(__NN(Abbreviated_Bankname_)))},
    {'Bank','KELOtto.fraudgovshared','bank2FractionalRoutingnumber',COUNT(__d1(__NL(Fractional_Routingnumber_))),COUNT(__d1(__NN(Fractional_Routingnumber_)))},
    {'Bank','KELOtto.fraudgovshared','bank2HeadofficeRoutingnumber',COUNT(__d1(__NL(Headoffice_Routingnumber_))),COUNT(__d1(__NN(Headoffice_Routingnumber_)))},
    {'Bank','KELOtto.fraudgovshared','bank2HeadofficeBranchcodes',COUNT(__d1(__NL(Headoffice_Branchcodes_))),COUNT(__d1(__NN(Headoffice_Branchcodes_)))},
    {'Bank','KELOtto.fraudgovshared','bank2hit',COUNT(__d1(__NL(_hit_))),COUNT(__d1(__NN(_hit_)))},
    {'Bank','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Bank','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
