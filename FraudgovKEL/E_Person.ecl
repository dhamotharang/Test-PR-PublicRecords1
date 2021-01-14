//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT FraudgovKEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Ssn_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nstr _off__cat__list_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Zip4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),eventdate(Event_Date_:DATE),lexid(Lex_Id_:0),dateofbirth(Date_Of_Birth_:DATE),ssn(Ssn_:\'\'),emailaddress(Email_Address_:\'\'),title(Title_),firstname(First_Name_),middlename(Middle_Name_),lastname(Last_Name_),namesuffix(Name_Suffix_),rin_source(_rin__source_:0),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),primaryrange(Primary_Range_),predirectional(Predirectional_),primaryname(Primary_Name_),suffix(Suffix_),postdirectional(Postdirectional_),unitdesignation(Unit_Designation_),secondaryrange(Secondary_Range_),postalcity(Postal_City_),vanitycity(Vanity_City_),state(State_),zip(Zip_),zip4(Zip4_),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := FraudgovKEL.fraudgovshared((UNSIGNED)record_id > 0 AND (UNSIGNED)did <> 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)0);
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Person::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~fraudgov::temp::KEL::IDtoT::FraudgovKEL::Person');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~fraudgov::temp::KEL::TtoID::FraudgovKEL::Person');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),event_date(Event_Date_:DATE),did(Lex_Id_:0),dob(Date_Of_Birth_:DATE),ssn(Ssn_:\'\'|Deceased_Ssn_:\'\'),email_address(Email_Address_:\'\'),cleaned_name.title(Title_),cleaned_name.fname(First_Name_),cleaned_name.mname(Middle_Name_),cleaned_name.lname(Last_Name_),cleaned_name.name_suffix(Name_Suffix_),rin_source(_rin__source_:0),dod8(Deceased_Date_:DATE),dob8(Deceased_Date_Of_Birth_:DATE),fname(Deceased_First_:\'\'),mname(Deceased_Middle_:\'\'),lname(Deceased_Last_:\'\'),matchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),clean_address.prim_range(Primary_Range_),clean_address.predir(Predirectional_),clean_address.prim_name(Primary_Name_),clean_address.addr_suffix(Suffix_),clean_address.postdir(Postdirectional_),clean_address.unit_desig(Unit_Designation_),clean_address.sec_range(Secondary_Range_),clean_address.p_city_name(Postal_City_),clean_address.v_city_name(Vanity_City_),clean_address.st(State_),clean_address.zip(Zip_),clean_address.zip4(Zip4_),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(FraudgovKEL.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT FraudgovKEL_fraudgovshared_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Source_Customers_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Date_Of_Birth_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Ssn_Layout := RECORD
    KEL.typ.nkdate Event_Date_;
    KEL.typ.nstr Ssn_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Email_Address_Layout := RECORD
    KEL.typ.nkdate Event_Date_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Full_Name_Layout := RECORD
    KEL.typ.nkdate Event_Date_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Offenses_Layout := RECORD
    KEL.typ.nstr _off__cat__list_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Address_Layout := RECORD
    KEL.typ.nkdate Event_Date_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Zip4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(Offenses_Layout) Offenses_;
    KEL.typ.ndataset(Address_Layout) Address_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Person_Group := __PostFilter;
  Layout Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF.Lex_Id_ := KEL.Intake.SingleValue(__recs,Lex_Id_);
    SELF.Source_Customers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Source_Customer_},_r_Source_Customer_),Source_Customers_Layout)(__NN(_r_Source_Customer_)));
    SELF.Reported_Date_Of_Birth_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Of_Birth_},Date_Of_Birth_),Reported_Date_Of_Birth_Layout)(__NN(Date_Of_Birth_)));
    SELF.Reported_Ssn_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Date_,Ssn_},Event_Date_,Ssn_),Reported_Ssn_Layout)(__NN(Event_Date_) OR __NN(Ssn_)));
    SELF.Reported_Email_Address_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Date_,Email_Address_},Event_Date_,Email_Address_),Reported_Email_Address_Layout)(__NN(Event_Date_) OR __NN(Email_Address_)));
    SELF.Full_Name_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Date_,Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_},Event_Date_,Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_),Full_Name_Layout)(__NN(Event_Date_) OR __NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_)));
    SELF._rin__source_ := KEL.Intake.SingleValue(__recs,_rin__source_);
    SELF.Deceased_Date_ := KEL.Intake.SingleValue(__recs,Deceased_Date_);
    SELF.Deceased_Date_Of_Birth_ := KEL.Intake.SingleValue(__recs,Deceased_Date_Of_Birth_);
    SELF.Deceased_First_ := KEL.Intake.SingleValue(__recs,Deceased_First_);
    SELF.Deceased_Middle_ := KEL.Intake.SingleValue(__recs,Deceased_Middle_);
    SELF.Deceased_Last_ := KEL.Intake.SingleValue(__recs,Deceased_Last_);
    SELF.Deceased_Match_Code_ := KEL.Intake.SingleValue(__recs,Deceased_Match_Code_);
    SELF._isdeepdive_ := KEL.Intake.SingleValue(__recs,_isdeepdive_);
    SELF._county__death_ := KEL.Intake.SingleValue(__recs,_county__death_);
    SELF.Deceased_Ssn_ := KEL.Intake.SingleValue(__recs,Deceased_Ssn_);
    SELF._state__death__flag_ := KEL.Intake.SingleValue(__recs,_state__death__flag_);
    SELF._death__rec__src_ := KEL.Intake.SingleValue(__recs,_death__rec__src_);
    SELF._state__death__id_ := KEL.Intake.SingleValue(__recs,_state__death__id_);
    SELF._curr__incar__flag_ := KEL.Intake.SingleValue(__recs,_curr__incar__flag_);
    SELF._name__ssn__dob__match_ := KEL.Intake.SingleValue(__recs,_name__ssn__dob__match_);
    SELF.Offenses_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_off__cat__list_},_off__cat__list_),Offenses_Layout)(__NN(_off__cat__list_)));
    SELF.Address_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Date_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,Vanity_City_,State_,Zip_,Zip4_},Event_Date_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,Vanity_City_,State_,Zip_,Zip4_),Address_Layout)(__NN(Event_Date_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Unit_Designation_) OR __NN(Secondary_Range_) OR __NN(Postal_City_) OR __NN(Vanity_City_) OR __NN(State_) OR __NN(Zip_) OR __NN(Zip4_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.Reported_Date_Of_Birth_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Date_Of_Birth_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Date_Of_Birth_)));
    SELF.Reported_Ssn_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Ssn_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Date_) OR __NN(Ssn_)));
    SELF.Reported_Email_Address_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Email_Address_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Date_) OR __NN(Email_Address_)));
    SELF.Full_Name_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Full_Name_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Date_) OR __NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_)));
    SELF.Offenses_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Offenses_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_off__cat__list_)));
    SELF.Address_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Date_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Unit_Designation_) OR __NN(Secondary_Range_) OR __NN(Postal_City_) OR __NN(Vanity_City_) OR __NN(State_) OR __NN(Zip_) OR __NN(Zip4_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Person::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT Lex_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lex_Id_);
  EXPORT _rin__source__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_rin__source_);
  EXPORT Deceased_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Date_);
  EXPORT Deceased_Date_Of_Birth__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Date_Of_Birth_);
  EXPORT Deceased_First__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_First_);
  EXPORT Deceased_Middle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Middle_);
  EXPORT Deceased_Last__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Last_);
  EXPORT Deceased_Match_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Match_Code_);
  EXPORT _isdeepdive__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_isdeepdive_);
  EXPORT _county__death__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_county__death_);
  EXPORT Deceased_Ssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Ssn_);
  EXPORT _state__death__flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_state__death__flag_);
  EXPORT _death__rec__src__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_death__rec__src_);
  EXPORT _state__death__id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_state__death__id_);
  EXPORT _curr__incar__flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_curr__incar__flag_);
  EXPORT _name__ssn__dob__match__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_name__ssn__dob__match_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(FraudgovKEL_fraudgovshared_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(Lex_Id__SingleValue_Invalid),COUNT(_rin__source__SingleValue_Invalid),COUNT(Deceased_Date__SingleValue_Invalid),COUNT(Deceased_Date_Of_Birth__SingleValue_Invalid),COUNT(Deceased_First__SingleValue_Invalid),COUNT(Deceased_Middle__SingleValue_Invalid),COUNT(Deceased_Last__SingleValue_Invalid),COUNT(Deceased_Match_Code__SingleValue_Invalid),COUNT(_isdeepdive__SingleValue_Invalid),COUNT(_county__death__SingleValue_Invalid),COUNT(Deceased_Ssn__SingleValue_Invalid),COUNT(_state__death__flag__SingleValue_Invalid),COUNT(_death__rec__src__SingleValue_Invalid),COUNT(_state__death__id__SingleValue_Invalid),COUNT(_curr__incar__flag__SingleValue_Invalid),COUNT(_name__ssn__dob__match__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int FraudgovKEL_fraudgovshared_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int Lex_Id__SingleValue_Invalid,KEL.typ.int _rin__source__SingleValue_Invalid,KEL.typ.int Deceased_Date__SingleValue_Invalid,KEL.typ.int Deceased_Date_Of_Birth__SingleValue_Invalid,KEL.typ.int Deceased_First__SingleValue_Invalid,KEL.typ.int Deceased_Middle__SingleValue_Invalid,KEL.typ.int Deceased_Last__SingleValue_Invalid,KEL.typ.int Deceased_Match_Code__SingleValue_Invalid,KEL.typ.int _isdeepdive__SingleValue_Invalid,KEL.typ.int _county__death__SingleValue_Invalid,KEL.typ.int Deceased_Ssn__SingleValue_Invalid,KEL.typ.int _state__death__flag__SingleValue_Invalid,KEL.typ.int _death__rec__src__SingleValue_Invalid,KEL.typ.int _state__death__id__SingleValue_Invalid,KEL.typ.int _curr__incar__flag__SingleValue_Invalid,KEL.typ.int _name__ssn__dob__match__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Person','FraudgovKEL.fraudgovshared','UID',COUNT(FraudgovKEL_fraudgovshared_Invalid),COUNT(__d0)},
    {'Person','FraudgovKEL.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'Person','FraudgovKEL.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'Person','FraudgovKEL.fraudgovshared','event_date',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'Person','FraudgovKEL.fraudgovshared','did',COUNT(__d0(__NL(Lex_Id_))),COUNT(__d0(__NN(Lex_Id_)))},
    {'Person','FraudgovKEL.fraudgovshared','dob',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Person','FraudgovKEL.fraudgovshared','Ssn',COUNT(__d0(__NL(Ssn_))),COUNT(__d0(__NN(Ssn_)))},
    {'Person','FraudgovKEL.fraudgovshared','email_address',COUNT(__d0(__NL(Email_Address_))),COUNT(__d0(__NN(Email_Address_)))},
    {'Person','FraudgovKEL.fraudgovshared','cleaned_name.title',COUNT(__d0(__NL(Title_))),COUNT(__d0(__NN(Title_)))},
    {'Person','FraudgovKEL.fraudgovshared','cleaned_name.fname',COUNT(__d0(__NL(First_Name_))),COUNT(__d0(__NN(First_Name_)))},
    {'Person','FraudgovKEL.fraudgovshared','cleaned_name.mname',COUNT(__d0(__NL(Middle_Name_))),COUNT(__d0(__NN(Middle_Name_)))},
    {'Person','FraudgovKEL.fraudgovshared','cleaned_name.lname',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'Person','FraudgovKEL.fraudgovshared','cleaned_name.name_suffix',COUNT(__d0(__NL(Name_Suffix_))),COUNT(__d0(__NN(Name_Suffix_)))},
    {'Person','FraudgovKEL.fraudgovshared','rin_source',COUNT(__d0(__NL(_rin__source_))),COUNT(__d0(__NN(_rin__source_)))},
    {'Person','FraudgovKEL.fraudgovshared','dod8',COUNT(__d0(__NL(Deceased_Date_))),COUNT(__d0(__NN(Deceased_Date_)))},
    {'Person','FraudgovKEL.fraudgovshared','dob8',COUNT(__d0(__NL(Deceased_Date_Of_Birth_))),COUNT(__d0(__NN(Deceased_Date_Of_Birth_)))},
    {'Person','FraudgovKEL.fraudgovshared','fname',COUNT(__d0(__NL(Deceased_First_))),COUNT(__d0(__NN(Deceased_First_)))},
    {'Person','FraudgovKEL.fraudgovshared','mname',COUNT(__d0(__NL(Deceased_Middle_))),COUNT(__d0(__NN(Deceased_Middle_)))},
    {'Person','FraudgovKEL.fraudgovshared','lname',COUNT(__d0(__NL(Deceased_Last_))),COUNT(__d0(__NN(Deceased_Last_)))},
    {'Person','FraudgovKEL.fraudgovshared','matchcode',COUNT(__d0(__NL(Deceased_Match_Code_))),COUNT(__d0(__NN(Deceased_Match_Code_)))},
    {'Person','FraudgovKEL.fraudgovshared','isdeepdive',COUNT(__d0(__NL(_isdeepdive_))),COUNT(__d0(__NN(_isdeepdive_)))},
    {'Person','FraudgovKEL.fraudgovshared','county_death',COUNT(__d0(__NL(_county__death_))),COUNT(__d0(__NN(_county__death_)))},
    {'Person','FraudgovKEL.fraudgovshared','ssn',COUNT(__d0(__NL(Deceased_Ssn_))),COUNT(__d0(__NN(Deceased_Ssn_)))},
    {'Person','FraudgovKEL.fraudgovshared','state_death_flag',COUNT(__d0(__NL(_state__death__flag_))),COUNT(__d0(__NN(_state__death__flag_)))},
    {'Person','FraudgovKEL.fraudgovshared','death_rec_src',COUNT(__d0(__NL(_death__rec__src_))),COUNT(__d0(__NN(_death__rec__src_)))},
    {'Person','FraudgovKEL.fraudgovshared','state_death_id',COUNT(__d0(__NL(_state__death__id_))),COUNT(__d0(__NN(_state__death__id_)))},
    {'Person','FraudgovKEL.fraudgovshared','curr_incar_flag',COUNT(__d0(__NL(_curr__incar__flag_))),COUNT(__d0(__NN(_curr__incar__flag_)))},
    {'Person','FraudgovKEL.fraudgovshared','off_cat_list',COUNT(__d0(__NL(_off__cat__list_))),COUNT(__d0(__NN(_off__cat__list_)))},
    {'Person','FraudgovKEL.fraudgovshared','name_ssn_dob_match',COUNT(__d0(__NL(_name__ssn__dob__match_))),COUNT(__d0(__NN(_name__ssn__dob__match_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.unit_desig',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.p_city_name',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.v_city_name',COUNT(__d0(__NL(Vanity_City_))),COUNT(__d0(__NN(Vanity_City_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.st',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.zip',COUNT(__d0(__NL(Zip_))),COUNT(__d0(__NN(Zip_)))},
    {'Person','FraudgovKEL.fraudgovshared','clean_address.zip4',COUNT(__d0(__NL(Zip4_))),COUNT(__d0(__NN(Zip4_)))},
    {'Person','FraudgovKEL.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Person','FraudgovKEL.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
