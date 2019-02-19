//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Event := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.nstr Event_Type_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr _verfirst_;
    KEL.typ.nstr _verlast_;
    KEL.typ.nstr _veraddr_;
    KEL.typ.nstr _vercity_;
    KEL.typ.nstr _verstate_;
    KEL.typ.nstr _verzip_;
    KEL.typ.nstr _verzip4_;
    KEL.typ.nstr _verssn_;
    KEL.typ.nstr _verdob_;
    KEL.typ.nstr _verhphone_;
    KEL.typ.nstr _verify__addr_;
    KEL.typ.nstr _verify__dob_;
    KEL.typ.nstr _valid__ssn_;
    KEL.typ.nint _nas__summary_;
    KEL.typ.nint _nap__summary_;
    KEL.typ.nstr _cvi_;
    KEL.typ.nstr _additional__fname__1_;
    KEL.typ.nstr _additional__lname__1_;
    KEL.typ.nstr _additional__lname__date__last__1_;
    KEL.typ.nstr _additional__fname__2_;
    KEL.typ.nstr _additional__lname__2_;
    KEL.typ.nstr _additional__lname__date__last__2_;
    KEL.typ.nstr _additional__fname__3_;
    KEL.typ.nstr _additional__lname__3_;
    KEL.typ.nstr _additional__lname__date__last__3_;
    KEL.typ.nint _subjectssncount_;
    KEL.typ.nstr _dobmatchlevel_;
    KEL.typ.nstr Hri_;
    KEL.typ.nbool _ssnfoundforlexid_;
    KEL.typ.nstr _cvicustomscore_;
    KEL.typ.nint Subject_Ssn_Count_;
    KEL.typ.nint Date_Of_Birth_Match_Level_;
    KEL.typ.nint Stolen_Identity_Index_;
    KEL.typ.nint Synthetic_Identity_Index_;
    KEL.typ.nint Manipulated_Identity_Index_;
    KEL.typ.nint Vulnerable_Victim_Index_;
    KEL.typ.nint Friendlyfraud_Index_;
    KEL.typ.nint Suspicious_Activity_Index_;
    KEL.typ.nint _v2__sourcerisklevel_;
    KEL.typ.nint _v2__assocsuspicousidentitiescount_;
    KEL.typ.nint _v2__assoccreditbureauonlycount_;
    KEL.typ.nint _v2__validationaddrproblems_;
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nstr _v2__divssnidentitycountnew_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),record_id(Record_Id_:0),eventdate(Event_Date_:DATE),eventtype(Event_Type_:\'\'),dateofbirth(Date_Of_Birth_:DATE),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),hri(Hri_:\'\'|Hri_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)record_id > 0 and did > 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id)));
  SHARED __d1_KELfiltered := KELOtto.PersonEventTypes((UNSIGNED)record_id > 0);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Event::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Event');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Event');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),record_id(Record_Id_:0),event_date(Event_Date_:DATE),eventtype(Event_Type_:\'\'),dateofbirth(Date_Of_Birth_:DATE),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),hri(Hri_:\'\'|Hri_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d0_Subject__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid Subject_;
  END;
  SHARED __d0_Subject__Mapped := JOIN(__d0_UID_Mapped,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Subject__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_Subject__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT KELOtto_fraudgovshared_Invalid := __d0_Location__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_Location__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),record_id(Record_Id_:0),eventdate(Event_Date_:DATE),event_type(Event_Type_:\'\'),dateofbirth(Date_Of_Birth_:DATE),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),hri(Hri_:\'\'|Hri_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d1_Out := RECORD
    RECORDOF(KELOtto.PersonEventTypes);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d1_Subject__Layout := RECORD
    RECORDOF(__d1_UID_Mapped);
    KEL.typ.uid Subject_;
  END;
  SHARED __d1_Subject__Mapped := JOIN(__d1_UID_Mapped,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.LexId) = RIGHT.KeyVal,TRANSFORM(__d1_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_Subject__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Location__Mapped := JOIN(__d1_Subject__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.Zip) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT KELOtto_PersonEventTypes_Invalid := __d1_Location__Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_Location__Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Source_Customers_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Event_Types_Layout := RECORD
    KEL.typ.nstr Event_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Hri_List_Layout := RECORD
    KEL.typ.nstr Hri_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(Event_Types_Layout) Event_Types_;
    KEL.typ.nkdate Date_Of_Birth_;
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
    KEL.typ.nstr _verfirst_;
    KEL.typ.nstr _verlast_;
    KEL.typ.nstr _veraddr_;
    KEL.typ.nstr _vercity_;
    KEL.typ.nstr _verstate_;
    KEL.typ.nstr _verzip_;
    KEL.typ.nstr _verzip4_;
    KEL.typ.nstr _verssn_;
    KEL.typ.nstr _verdob_;
    KEL.typ.nstr _verhphone_;
    KEL.typ.nstr _verify__addr_;
    KEL.typ.nstr _verify__dob_;
    KEL.typ.nstr _valid__ssn_;
    KEL.typ.nint _nas__summary_;
    KEL.typ.nint _nap__summary_;
    KEL.typ.nstr _cvi_;
    KEL.typ.nstr _additional__fname__1_;
    KEL.typ.nstr _additional__lname__1_;
    KEL.typ.nstr _additional__lname__date__last__1_;
    KEL.typ.nstr _additional__fname__2_;
    KEL.typ.nstr _additional__lname__2_;
    KEL.typ.nstr _additional__lname__date__last__2_;
    KEL.typ.nstr _additional__fname__3_;
    KEL.typ.nstr _additional__lname__3_;
    KEL.typ.nstr _additional__lname__date__last__3_;
    KEL.typ.nint _subjectssncount_;
    KEL.typ.nstr _dobmatchlevel_;
    KEL.typ.nbool _ssnfoundforlexid_;
    KEL.typ.nstr _cvicustomscore_;
    KEL.typ.nint Subject_Ssn_Count_;
    KEL.typ.nint Date_Of_Birth_Match_Level_;
    KEL.typ.nint Stolen_Identity_Index_;
    KEL.typ.nint Synthetic_Identity_Index_;
    KEL.typ.nint Manipulated_Identity_Index_;
    KEL.typ.nint Vulnerable_Victim_Index_;
    KEL.typ.nint Friendlyfraud_Index_;
    KEL.typ.nint Suspicious_Activity_Index_;
    KEL.typ.nint _v2__sourcerisklevel_;
    KEL.typ.nint _v2__assocsuspicousidentitiescount_;
    KEL.typ.nint _v2__assoccreditbureauonlycount_;
    KEL.typ.nint _v2__validationaddrproblems_;
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nstr _v2__divssnidentitycountnew_;
    KEL.typ.ndataset(Hri_List_Layout) Hri_List_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Event_Group := __PostFilter;
  Layout Event__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF.Source_Customers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Source_Customer_},_r_Source_Customer_),Source_Customers_Layout)(__NN(_r_Source_Customer_)));
    SELF.Subject_ := KEL.Intake.SingleValue(__recs,Subject_);
    SELF.Location_ := KEL.Intake.SingleValue(__recs,Location_);
    SELF.Record_Id_ := KEL.Intake.SingleValue(__recs,Record_Id_);
    SELF.Event_Date_ := KEL.Intake.SingleValue(__recs,Event_Date_);
    SELF.Event_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Type_},Event_Type_),Event_Types_Layout)(__NN(Event_Type_)));
    SELF.Date_Of_Birth_ := KEL.Intake.SingleValue(__recs,Date_Of_Birth_);
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
    SELF._verfirst_ := KEL.Intake.SingleValue(__recs,_verfirst_);
    SELF._verlast_ := KEL.Intake.SingleValue(__recs,_verlast_);
    SELF._veraddr_ := KEL.Intake.SingleValue(__recs,_veraddr_);
    SELF._vercity_ := KEL.Intake.SingleValue(__recs,_vercity_);
    SELF._verstate_ := KEL.Intake.SingleValue(__recs,_verstate_);
    SELF._verzip_ := KEL.Intake.SingleValue(__recs,_verzip_);
    SELF._verzip4_ := KEL.Intake.SingleValue(__recs,_verzip4_);
    SELF._verssn_ := KEL.Intake.SingleValue(__recs,_verssn_);
    SELF._verdob_ := KEL.Intake.SingleValue(__recs,_verdob_);
    SELF._verhphone_ := KEL.Intake.SingleValue(__recs,_verhphone_);
    SELF._verify__addr_ := KEL.Intake.SingleValue(__recs,_verify__addr_);
    SELF._verify__dob_ := KEL.Intake.SingleValue(__recs,_verify__dob_);
    SELF._valid__ssn_ := KEL.Intake.SingleValue(__recs,_valid__ssn_);
    SELF._nas__summary_ := KEL.Intake.SingleValue(__recs,_nas__summary_);
    SELF._nap__summary_ := KEL.Intake.SingleValue(__recs,_nap__summary_);
    SELF._cvi_ := KEL.Intake.SingleValue(__recs,_cvi_);
    SELF._additional__fname__1_ := KEL.Intake.SingleValue(__recs,_additional__fname__1_);
    SELF._additional__lname__1_ := KEL.Intake.SingleValue(__recs,_additional__lname__1_);
    SELF._additional__lname__date__last__1_ := KEL.Intake.SingleValue(__recs,_additional__lname__date__last__1_);
    SELF._additional__fname__2_ := KEL.Intake.SingleValue(__recs,_additional__fname__2_);
    SELF._additional__lname__2_ := KEL.Intake.SingleValue(__recs,_additional__lname__2_);
    SELF._additional__lname__date__last__2_ := KEL.Intake.SingleValue(__recs,_additional__lname__date__last__2_);
    SELF._additional__fname__3_ := KEL.Intake.SingleValue(__recs,_additional__fname__3_);
    SELF._additional__lname__3_ := KEL.Intake.SingleValue(__recs,_additional__lname__3_);
    SELF._additional__lname__date__last__3_ := KEL.Intake.SingleValue(__recs,_additional__lname__date__last__3_);
    SELF._subjectssncount_ := KEL.Intake.SingleValue(__recs,_subjectssncount_);
    SELF._dobmatchlevel_ := KEL.Intake.SingleValue(__recs,_dobmatchlevel_);
    SELF._ssnfoundforlexid_ := KEL.Intake.SingleValue(__recs,_ssnfoundforlexid_);
    SELF._cvicustomscore_ := KEL.Intake.SingleValue(__recs,_cvicustomscore_);
    SELF.Subject_Ssn_Count_ := KEL.Intake.SingleValue(__recs,Subject_Ssn_Count_);
    SELF.Date_Of_Birth_Match_Level_ := KEL.Intake.SingleValue(__recs,Date_Of_Birth_Match_Level_);
    SELF.Stolen_Identity_Index_ := KEL.Intake.SingleValue(__recs,Stolen_Identity_Index_);
    SELF.Synthetic_Identity_Index_ := KEL.Intake.SingleValue(__recs,Synthetic_Identity_Index_);
    SELF.Manipulated_Identity_Index_ := KEL.Intake.SingleValue(__recs,Manipulated_Identity_Index_);
    SELF.Vulnerable_Victim_Index_ := KEL.Intake.SingleValue(__recs,Vulnerable_Victim_Index_);
    SELF.Friendlyfraud_Index_ := KEL.Intake.SingleValue(__recs,Friendlyfraud_Index_);
    SELF.Suspicious_Activity_Index_ := KEL.Intake.SingleValue(__recs,Suspicious_Activity_Index_);
    SELF._v2__sourcerisklevel_ := KEL.Intake.SingleValue(__recs,_v2__sourcerisklevel_);
    SELF._v2__assocsuspicousidentitiescount_ := KEL.Intake.SingleValue(__recs,_v2__assocsuspicousidentitiescount_);
    SELF._v2__assoccreditbureauonlycount_ := KEL.Intake.SingleValue(__recs,_v2__assoccreditbureauonlycount_);
    SELF._v2__validationaddrproblems_ := KEL.Intake.SingleValue(__recs,_v2__validationaddrproblems_);
    SELF._v2__inputaddrageoldest_ := KEL.Intake.SingleValue(__recs,_v2__inputaddrageoldest_);
    SELF._v2__inputaddrdwelltype_ := KEL.Intake.SingleValue(__recs,_v2__inputaddrdwelltype_);
    SELF._v2__divssnidentitycountnew_ := KEL.Intake.SingleValue(__recs,_v2__divssnidentitycountnew_);
    SELF.Hri_List_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Hri_},Hri_),Hri_List_Layout)(__NN(Hri_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.Event_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Event_Types_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Type_)));
    SELF.Hri_List_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hri_List_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Hri_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Event::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT Subject__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Subject_);
  EXPORT Location__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Location_);
  EXPORT Record_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Record_Id_);
  EXPORT Event_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Event_Date_);
  EXPORT Date_Of_Birth__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Birth_);
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
  EXPORT _verfirst__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verfirst_);
  EXPORT _verlast__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verlast_);
  EXPORT _veraddr__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_veraddr_);
  EXPORT _vercity__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_vercity_);
  EXPORT _verstate__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verstate_);
  EXPORT _verzip__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verzip_);
  EXPORT _verzip4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verzip4_);
  EXPORT _verssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verssn_);
  EXPORT _verdob__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verdob_);
  EXPORT _verhphone__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verhphone_);
  EXPORT _verify__addr__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verify__addr_);
  EXPORT _verify__dob__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verify__dob_);
  EXPORT _valid__ssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_valid__ssn_);
  EXPORT _nas__summary__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_nas__summary_);
  EXPORT _nap__summary__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_nap__summary_);
  EXPORT _cvi__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cvi_);
  EXPORT _additional__fname__1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__fname__1_);
  EXPORT _additional__lname__1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__1_);
  EXPORT _additional__lname__date__last__1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__date__last__1_);
  EXPORT _additional__fname__2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__fname__2_);
  EXPORT _additional__lname__2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__2_);
  EXPORT _additional__lname__date__last__2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__date__last__2_);
  EXPORT _additional__fname__3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__fname__3_);
  EXPORT _additional__lname__3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__3_);
  EXPORT _additional__lname__date__last__3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__date__last__3_);
  EXPORT _subjectssncount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_subjectssncount_);
  EXPORT _dobmatchlevel__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_dobmatchlevel_);
  EXPORT _ssnfoundforlexid__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ssnfoundforlexid_);
  EXPORT _cvicustomscore__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cvicustomscore_);
  EXPORT Subject_Ssn_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Subject_Ssn_Count_);
  EXPORT Date_Of_Birth_Match_Level__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Birth_Match_Level_);
  EXPORT Stolen_Identity_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Stolen_Identity_Index_);
  EXPORT Synthetic_Identity_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Synthetic_Identity_Index_);
  EXPORT Manipulated_Identity_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Manipulated_Identity_Index_);
  EXPORT Vulnerable_Victim_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vulnerable_Victim_Index_);
  EXPORT Friendlyfraud_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Friendlyfraud_Index_);
  EXPORT Suspicious_Activity_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Suspicious_Activity_Index_);
  EXPORT _v2__sourcerisklevel__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__sourcerisklevel_);
  EXPORT _v2__assocsuspicousidentitiescount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__assocsuspicousidentitiescount_);
  EXPORT _v2__assoccreditbureauonlycount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__assoccreditbureauonlycount_);
  EXPORT _v2__validationaddrproblems__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__validationaddrproblems_);
  EXPORT _v2__inputaddrageoldest__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__inputaddrageoldest_);
  EXPORT _v2__inputaddrdwelltype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__inputaddrdwelltype_);
  EXPORT _v2__divssnidentitycountnew__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__divssnidentitycountnew_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address.__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(Subject__Orphan),COUNT(Location__Orphan),COUNT(KELOtto_fraudgovshared_Invalid),COUNT(KELOtto_PersonEventTypes_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(Subject__SingleValue_Invalid),COUNT(Location__SingleValue_Invalid),COUNT(Record_Id__SingleValue_Invalid),COUNT(Event_Date__SingleValue_Invalid),COUNT(Date_Of_Birth__SingleValue_Invalid),COUNT(Deceased_Date__SingleValue_Invalid),COUNT(Deceased_Date_Of_Birth__SingleValue_Invalid),COUNT(Deceased_First__SingleValue_Invalid),COUNT(Deceased_Middle__SingleValue_Invalid),COUNT(Deceased_Last__SingleValue_Invalid),COUNT(Deceased_Match_Code__SingleValue_Invalid),COUNT(_isdeepdive__SingleValue_Invalid),COUNT(_county__death__SingleValue_Invalid),COUNT(Deceased_Ssn__SingleValue_Invalid),COUNT(_state__death__flag__SingleValue_Invalid),COUNT(_death__rec__src__SingleValue_Invalid),COUNT(_state__death__id__SingleValue_Invalid),COUNT(_verfirst__SingleValue_Invalid),COUNT(_verlast__SingleValue_Invalid),COUNT(_veraddr__SingleValue_Invalid),COUNT(_vercity__SingleValue_Invalid),COUNT(_verstate__SingleValue_Invalid),COUNT(_verzip__SingleValue_Invalid),COUNT(_verzip4__SingleValue_Invalid),COUNT(_verssn__SingleValue_Invalid),COUNT(_verdob__SingleValue_Invalid),COUNT(_verhphone__SingleValue_Invalid),COUNT(_verify__addr__SingleValue_Invalid),COUNT(_verify__dob__SingleValue_Invalid),COUNT(_valid__ssn__SingleValue_Invalid),COUNT(_nas__summary__SingleValue_Invalid),COUNT(_nap__summary__SingleValue_Invalid),COUNT(_cvi__SingleValue_Invalid),COUNT(_additional__fname__1__SingleValue_Invalid),COUNT(_additional__lname__1__SingleValue_Invalid),COUNT(_additional__lname__date__last__1__SingleValue_Invalid),COUNT(_additional__fname__2__SingleValue_Invalid),COUNT(_additional__lname__2__SingleValue_Invalid),COUNT(_additional__lname__date__last__2__SingleValue_Invalid),COUNT(_additional__fname__3__SingleValue_Invalid),COUNT(_additional__lname__3__SingleValue_Invalid),COUNT(_additional__lname__date__last__3__SingleValue_Invalid),COUNT(_subjectssncount__SingleValue_Invalid),COUNT(_dobmatchlevel__SingleValue_Invalid),COUNT(_ssnfoundforlexid__SingleValue_Invalid),COUNT(_cvicustomscore__SingleValue_Invalid),COUNT(Subject_Ssn_Count__SingleValue_Invalid),COUNT(Date_Of_Birth_Match_Level__SingleValue_Invalid),COUNT(Stolen_Identity_Index__SingleValue_Invalid),COUNT(Synthetic_Identity_Index__SingleValue_Invalid),COUNT(Manipulated_Identity_Index__SingleValue_Invalid),COUNT(Vulnerable_Victim_Index__SingleValue_Invalid),COUNT(Friendlyfraud_Index__SingleValue_Invalid),COUNT(Suspicious_Activity_Index__SingleValue_Invalid),COUNT(_v2__sourcerisklevel__SingleValue_Invalid),COUNT(_v2__assocsuspicousidentitiescount__SingleValue_Invalid),COUNT(_v2__assoccreditbureauonlycount__SingleValue_Invalid),COUNT(_v2__validationaddrproblems__SingleValue_Invalid),COUNT(_v2__inputaddrageoldest__SingleValue_Invalid),COUNT(_v2__inputaddrdwelltype__SingleValue_Invalid),COUNT(_v2__divssnidentitycountnew__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int KELOtto_fraudgovshared_Invalid,KEL.typ.int KELOtto_PersonEventTypes_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int Subject__SingleValue_Invalid,KEL.typ.int Location__SingleValue_Invalid,KEL.typ.int Record_Id__SingleValue_Invalid,KEL.typ.int Event_Date__SingleValue_Invalid,KEL.typ.int Date_Of_Birth__SingleValue_Invalid,KEL.typ.int Deceased_Date__SingleValue_Invalid,KEL.typ.int Deceased_Date_Of_Birth__SingleValue_Invalid,KEL.typ.int Deceased_First__SingleValue_Invalid,KEL.typ.int Deceased_Middle__SingleValue_Invalid,KEL.typ.int Deceased_Last__SingleValue_Invalid,KEL.typ.int Deceased_Match_Code__SingleValue_Invalid,KEL.typ.int _isdeepdive__SingleValue_Invalid,KEL.typ.int _county__death__SingleValue_Invalid,KEL.typ.int Deceased_Ssn__SingleValue_Invalid,KEL.typ.int _state__death__flag__SingleValue_Invalid,KEL.typ.int _death__rec__src__SingleValue_Invalid,KEL.typ.int _state__death__id__SingleValue_Invalid,KEL.typ.int _verfirst__SingleValue_Invalid,KEL.typ.int _verlast__SingleValue_Invalid,KEL.typ.int _veraddr__SingleValue_Invalid,KEL.typ.int _vercity__SingleValue_Invalid,KEL.typ.int _verstate__SingleValue_Invalid,KEL.typ.int _verzip__SingleValue_Invalid,KEL.typ.int _verzip4__SingleValue_Invalid,KEL.typ.int _verssn__SingleValue_Invalid,KEL.typ.int _verdob__SingleValue_Invalid,KEL.typ.int _verhphone__SingleValue_Invalid,KEL.typ.int _verify__addr__SingleValue_Invalid,KEL.typ.int _verify__dob__SingleValue_Invalid,KEL.typ.int _valid__ssn__SingleValue_Invalid,KEL.typ.int _nas__summary__SingleValue_Invalid,KEL.typ.int _nap__summary__SingleValue_Invalid,KEL.typ.int _cvi__SingleValue_Invalid,KEL.typ.int _additional__fname__1__SingleValue_Invalid,KEL.typ.int _additional__lname__1__SingleValue_Invalid,KEL.typ.int _additional__lname__date__last__1__SingleValue_Invalid,KEL.typ.int _additional__fname__2__SingleValue_Invalid,KEL.typ.int _additional__lname__2__SingleValue_Invalid,KEL.typ.int _additional__lname__date__last__2__SingleValue_Invalid,KEL.typ.int _additional__fname__3__SingleValue_Invalid,KEL.typ.int _additional__lname__3__SingleValue_Invalid,KEL.typ.int _additional__lname__date__last__3__SingleValue_Invalid,KEL.typ.int _subjectssncount__SingleValue_Invalid,KEL.typ.int _dobmatchlevel__SingleValue_Invalid,KEL.typ.int _ssnfoundforlexid__SingleValue_Invalid,KEL.typ.int _cvicustomscore__SingleValue_Invalid,KEL.typ.int Subject_Ssn_Count__SingleValue_Invalid,KEL.typ.int Date_Of_Birth_Match_Level__SingleValue_Invalid,KEL.typ.int Stolen_Identity_Index__SingleValue_Invalid,KEL.typ.int Synthetic_Identity_Index__SingleValue_Invalid,KEL.typ.int Manipulated_Identity_Index__SingleValue_Invalid,KEL.typ.int Vulnerable_Victim_Index__SingleValue_Invalid,KEL.typ.int Friendlyfraud_Index__SingleValue_Invalid,KEL.typ.int Suspicious_Activity_Index__SingleValue_Invalid,KEL.typ.int _v2__sourcerisklevel__SingleValue_Invalid,KEL.typ.int _v2__assocsuspicousidentitiescount__SingleValue_Invalid,KEL.typ.int _v2__assoccreditbureauonlycount__SingleValue_Invalid,KEL.typ.int _v2__validationaddrproblems__SingleValue_Invalid,KEL.typ.int _v2__inputaddrageoldest__SingleValue_Invalid,KEL.typ.int _v2__inputaddrdwelltype__SingleValue_Invalid,KEL.typ.int _v2__divssnidentitycountnew__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Event','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_Invalid),COUNT(__d0)},
    {'Event','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'Event','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'Event','KELOtto.fraudgovshared','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'Event','KELOtto.fraudgovshared','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'Event','KELOtto.fraudgovshared','record_id',COUNT(__d0(__NL(Record_Id_))),COUNT(__d0(__NN(Record_Id_)))},
    {'Event','KELOtto.fraudgovshared','event_date',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'Event','KELOtto.fraudgovshared','EventType',COUNT(__d0(__NL(Event_Type_))),COUNT(__d0(__NN(Event_Type_)))},
    {'Event','KELOtto.fraudgovshared','DateOfBirth',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Event','KELOtto.fraudgovshared','verfirst',COUNT(__d0(__NL(_verfirst_))),COUNT(__d0(__NN(_verfirst_)))},
    {'Event','KELOtto.fraudgovshared','verlast',COUNT(__d0(__NL(_verlast_))),COUNT(__d0(__NN(_verlast_)))},
    {'Event','KELOtto.fraudgovshared','veraddr',COUNT(__d0(__NL(_veraddr_))),COUNT(__d0(__NN(_veraddr_)))},
    {'Event','KELOtto.fraudgovshared','vercity',COUNT(__d0(__NL(_vercity_))),COUNT(__d0(__NN(_vercity_)))},
    {'Event','KELOtto.fraudgovshared','verstate',COUNT(__d0(__NL(_verstate_))),COUNT(__d0(__NN(_verstate_)))},
    {'Event','KELOtto.fraudgovshared','verzip',COUNT(__d0(__NL(_verzip_))),COUNT(__d0(__NN(_verzip_)))},
    {'Event','KELOtto.fraudgovshared','verzip4',COUNT(__d0(__NL(_verzip4_))),COUNT(__d0(__NN(_verzip4_)))},
    {'Event','KELOtto.fraudgovshared','verssn',COUNT(__d0(__NL(_verssn_))),COUNT(__d0(__NN(_verssn_)))},
    {'Event','KELOtto.fraudgovshared','verdob',COUNT(__d0(__NL(_verdob_))),COUNT(__d0(__NN(_verdob_)))},
    {'Event','KELOtto.fraudgovshared','verhphone',COUNT(__d0(__NL(_verhphone_))),COUNT(__d0(__NN(_verhphone_)))},
    {'Event','KELOtto.fraudgovshared','verify_addr',COUNT(__d0(__NL(_verify__addr_))),COUNT(__d0(__NN(_verify__addr_)))},
    {'Event','KELOtto.fraudgovshared','verify_dob',COUNT(__d0(__NL(_verify__dob_))),COUNT(__d0(__NN(_verify__dob_)))},
    {'Event','KELOtto.fraudgovshared','valid_ssn',COUNT(__d0(__NL(_valid__ssn_))),COUNT(__d0(__NN(_valid__ssn_)))},
    {'Event','KELOtto.fraudgovshared','nas_summary',COUNT(__d0(__NL(_nas__summary_))),COUNT(__d0(__NN(_nas__summary_)))},
    {'Event','KELOtto.fraudgovshared','nap_summary',COUNT(__d0(__NL(_nap__summary_))),COUNT(__d0(__NN(_nap__summary_)))},
    {'Event','KELOtto.fraudgovshared','cvi',COUNT(__d0(__NL(_cvi_))),COUNT(__d0(__NN(_cvi_)))},
    {'Event','KELOtto.fraudgovshared','additional_fname_1',COUNT(__d0(__NL(_additional__fname__1_))),COUNT(__d0(__NN(_additional__fname__1_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_1',COUNT(__d0(__NL(_additional__lname__1_))),COUNT(__d0(__NN(_additional__lname__1_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_date_last_1',COUNT(__d0(__NL(_additional__lname__date__last__1_))),COUNT(__d0(__NN(_additional__lname__date__last__1_)))},
    {'Event','KELOtto.fraudgovshared','additional_fname_2',COUNT(__d0(__NL(_additional__fname__2_))),COUNT(__d0(__NN(_additional__fname__2_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_2',COUNT(__d0(__NL(_additional__lname__2_))),COUNT(__d0(__NN(_additional__lname__2_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_date_last_2',COUNT(__d0(__NL(_additional__lname__date__last__2_))),COUNT(__d0(__NN(_additional__lname__date__last__2_)))},
    {'Event','KELOtto.fraudgovshared','additional_fname_3',COUNT(__d0(__NL(_additional__fname__3_))),COUNT(__d0(__NN(_additional__fname__3_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_3',COUNT(__d0(__NL(_additional__lname__3_))),COUNT(__d0(__NN(_additional__lname__3_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_date_last_3',COUNT(__d0(__NL(_additional__lname__date__last__3_))),COUNT(__d0(__NN(_additional__lname__date__last__3_)))},
    {'Event','KELOtto.fraudgovshared','subjectssncount',COUNT(__d0(__NL(_subjectssncount_))),COUNT(__d0(__NN(_subjectssncount_)))},
    {'Event','KELOtto.fraudgovshared','dobmatchlevel',COUNT(__d0(__NL(_dobmatchlevel_))),COUNT(__d0(__NN(_dobmatchlevel_)))},
    {'Event','KELOtto.fraudgovshared','Hri',COUNT(__d0(__NL(Hri_))),COUNT(__d0(__NN(Hri_)))},
    {'Event','KELOtto.fraudgovshared','ssnfoundforlexid',COUNT(__d0(__NL(_ssnfoundforlexid_))),COUNT(__d0(__NN(_ssnfoundforlexid_)))},
    {'Event','KELOtto.fraudgovshared','cvicustomscore',COUNT(__d0(__NL(_cvicustomscore_))),COUNT(__d0(__NN(_cvicustomscore_)))},
    {'Event','KELOtto.fraudgovshared','SubjectSsnCount',COUNT(__d0(__NL(Subject_Ssn_Count_))),COUNT(__d0(__NN(Subject_Ssn_Count_)))},
    {'Event','KELOtto.fraudgovshared','DateOfBirthMatchLevel',COUNT(__d0(__NL(Date_Of_Birth_Match_Level_))),COUNT(__d0(__NN(Date_Of_Birth_Match_Level_)))},
    {'Event','KELOtto.fraudgovshared','StolenIdentityIndex',COUNT(__d0(__NL(Stolen_Identity_Index_))),COUNT(__d0(__NN(Stolen_Identity_Index_)))},
    {'Event','KELOtto.fraudgovshared','SyntheticIdentityIndex',COUNT(__d0(__NL(Synthetic_Identity_Index_))),COUNT(__d0(__NN(Synthetic_Identity_Index_)))},
    {'Event','KELOtto.fraudgovshared','ManipulatedIdentityIndex',COUNT(__d0(__NL(Manipulated_Identity_Index_))),COUNT(__d0(__NN(Manipulated_Identity_Index_)))},
    {'Event','KELOtto.fraudgovshared','VulnerableVictimIndex',COUNT(__d0(__NL(Vulnerable_Victim_Index_))),COUNT(__d0(__NN(Vulnerable_Victim_Index_)))},
    {'Event','KELOtto.fraudgovshared','FriendlyfraudIndex',COUNT(__d0(__NL(Friendlyfraud_Index_))),COUNT(__d0(__NN(Friendlyfraud_Index_)))},
    {'Event','KELOtto.fraudgovshared','SuspiciousActivityIndex',COUNT(__d0(__NL(Suspicious_Activity_Index_))),COUNT(__d0(__NN(Suspicious_Activity_Index_)))},
    {'Event','KELOtto.fraudgovshared','v2_sourcerisklevel',COUNT(__d0(__NL(_v2__sourcerisklevel_))),COUNT(__d0(__NN(_v2__sourcerisklevel_)))},
    {'Event','KELOtto.fraudgovshared','v2_assocsuspicousidentitiescount',COUNT(__d0(__NL(_v2__assocsuspicousidentitiescount_))),COUNT(__d0(__NN(_v2__assocsuspicousidentitiescount_)))},
    {'Event','KELOtto.fraudgovshared','v2_assoccreditbureauonlycount',COUNT(__d0(__NL(_v2__assoccreditbureauonlycount_))),COUNT(__d0(__NN(_v2__assoccreditbureauonlycount_)))},
    {'Event','KELOtto.fraudgovshared','v2_validationaddrproblems',COUNT(__d0(__NL(_v2__validationaddrproblems_))),COUNT(__d0(__NN(_v2__validationaddrproblems_)))},
    {'Event','KELOtto.fraudgovshared','v2_inputaddrageoldest',COUNT(__d0(__NL(_v2__inputaddrageoldest_))),COUNT(__d0(__NN(_v2__inputaddrageoldest_)))},
    {'Event','KELOtto.fraudgovshared','v2_inputaddrdwelltype',COUNT(__d0(__NL(_v2__inputaddrdwelltype_))),COUNT(__d0(__NN(_v2__inputaddrdwelltype_)))},
    {'Event','KELOtto.fraudgovshared','v2_divssnidentitycountnew',COUNT(__d0(__NL(_v2__divssnidentitycountnew_))),COUNT(__d0(__NN(_v2__divssnidentitycountnew_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedDate',COUNT(__d0(__NL(Deceased_Date_))),COUNT(__d0(__NN(Deceased_Date_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedDateOfBirth',COUNT(__d0(__NL(Deceased_Date_Of_Birth_))),COUNT(__d0(__NN(Deceased_Date_Of_Birth_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedFirst',COUNT(__d0(__NL(Deceased_First_))),COUNT(__d0(__NN(Deceased_First_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedMiddle',COUNT(__d0(__NL(Deceased_Middle_))),COUNT(__d0(__NN(Deceased_Middle_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedLast',COUNT(__d0(__NL(Deceased_Last_))),COUNT(__d0(__NN(Deceased_Last_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedMatchCode',COUNT(__d0(__NL(Deceased_Match_Code_))),COUNT(__d0(__NN(Deceased_Match_Code_)))},
    {'Event','KELOtto.fraudgovshared','isdeepdive',COUNT(__d0(__NL(_isdeepdive_))),COUNT(__d0(__NN(_isdeepdive_)))},
    {'Event','KELOtto.fraudgovshared','county_death',COUNT(__d0(__NL(_county__death_))),COUNT(__d0(__NN(_county__death_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedSsn',COUNT(__d0(__NL(Deceased_Ssn_))),COUNT(__d0(__NN(Deceased_Ssn_)))},
    {'Event','KELOtto.fraudgovshared','state_death_flag',COUNT(__d0(__NL(_state__death__flag_))),COUNT(__d0(__NN(_state__death__flag_)))},
    {'Event','KELOtto.fraudgovshared','death_rec_src',COUNT(__d0(__NL(_death__rec__src_))),COUNT(__d0(__NN(_death__rec__src_)))},
    {'Event','KELOtto.fraudgovshared','state_death_id',COUNT(__d0(__NL(_state__death__id_))),COUNT(__d0(__NN(_state__death__id_)))},
    {'Event','KELOtto.fraudgovshared','Hri',COUNT(__d0(__NL(Hri_))),COUNT(__d0(__NN(Hri_)))},
    {'Event','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Event','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Event','KELOtto.PersonEventTypes','UID',COUNT(KELOtto_PersonEventTypes_Invalid),COUNT(__d1)},
    {'Event','KELOtto.PersonEventTypes','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'Event','KELOtto.PersonEventTypes','SourceCustomerFileInfo',COUNT(__d1(__NL(_r_Source_Customer_))),COUNT(__d1(__NN(_r_Source_Customer_)))},
    {'Event','KELOtto.PersonEventTypes','Subject',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'Event','KELOtto.PersonEventTypes','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'Event','KELOtto.PersonEventTypes','record_id',COUNT(__d1(__NL(Record_Id_))),COUNT(__d1(__NN(Record_Id_)))},
    {'Event','KELOtto.PersonEventTypes','EventDate',COUNT(__d1(__NL(Event_Date_))),COUNT(__d1(__NN(Event_Date_)))},
    {'Event','KELOtto.PersonEventTypes','event_type',COUNT(__d1(__NL(Event_Type_))),COUNT(__d1(__NN(Event_Type_)))},
    {'Event','KELOtto.PersonEventTypes','DateOfBirth',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'Event','KELOtto.PersonEventTypes','verfirst',COUNT(__d1(__NL(_verfirst_))),COUNT(__d1(__NN(_verfirst_)))},
    {'Event','KELOtto.PersonEventTypes','verlast',COUNT(__d1(__NL(_verlast_))),COUNT(__d1(__NN(_verlast_)))},
    {'Event','KELOtto.PersonEventTypes','veraddr',COUNT(__d1(__NL(_veraddr_))),COUNT(__d1(__NN(_veraddr_)))},
    {'Event','KELOtto.PersonEventTypes','vercity',COUNT(__d1(__NL(_vercity_))),COUNT(__d1(__NN(_vercity_)))},
    {'Event','KELOtto.PersonEventTypes','verstate',COUNT(__d1(__NL(_verstate_))),COUNT(__d1(__NN(_verstate_)))},
    {'Event','KELOtto.PersonEventTypes','verzip',COUNT(__d1(__NL(_verzip_))),COUNT(__d1(__NN(_verzip_)))},
    {'Event','KELOtto.PersonEventTypes','verzip4',COUNT(__d1(__NL(_verzip4_))),COUNT(__d1(__NN(_verzip4_)))},
    {'Event','KELOtto.PersonEventTypes','verssn',COUNT(__d1(__NL(_verssn_))),COUNT(__d1(__NN(_verssn_)))},
    {'Event','KELOtto.PersonEventTypes','verdob',COUNT(__d1(__NL(_verdob_))),COUNT(__d1(__NN(_verdob_)))},
    {'Event','KELOtto.PersonEventTypes','verhphone',COUNT(__d1(__NL(_verhphone_))),COUNT(__d1(__NN(_verhphone_)))},
    {'Event','KELOtto.PersonEventTypes','verify_addr',COUNT(__d1(__NL(_verify__addr_))),COUNT(__d1(__NN(_verify__addr_)))},
    {'Event','KELOtto.PersonEventTypes','verify_dob',COUNT(__d1(__NL(_verify__dob_))),COUNT(__d1(__NN(_verify__dob_)))},
    {'Event','KELOtto.PersonEventTypes','valid_ssn',COUNT(__d1(__NL(_valid__ssn_))),COUNT(__d1(__NN(_valid__ssn_)))},
    {'Event','KELOtto.PersonEventTypes','nas_summary',COUNT(__d1(__NL(_nas__summary_))),COUNT(__d1(__NN(_nas__summary_)))},
    {'Event','KELOtto.PersonEventTypes','nap_summary',COUNT(__d1(__NL(_nap__summary_))),COUNT(__d1(__NN(_nap__summary_)))},
    {'Event','KELOtto.PersonEventTypes','cvi',COUNT(__d1(__NL(_cvi_))),COUNT(__d1(__NN(_cvi_)))},
    {'Event','KELOtto.PersonEventTypes','additional_fname_1',COUNT(__d1(__NL(_additional__fname__1_))),COUNT(__d1(__NN(_additional__fname__1_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_1',COUNT(__d1(__NL(_additional__lname__1_))),COUNT(__d1(__NN(_additional__lname__1_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_date_last_1',COUNT(__d1(__NL(_additional__lname__date__last__1_))),COUNT(__d1(__NN(_additional__lname__date__last__1_)))},
    {'Event','KELOtto.PersonEventTypes','additional_fname_2',COUNT(__d1(__NL(_additional__fname__2_))),COUNT(__d1(__NN(_additional__fname__2_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_2',COUNT(__d1(__NL(_additional__lname__2_))),COUNT(__d1(__NN(_additional__lname__2_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_date_last_2',COUNT(__d1(__NL(_additional__lname__date__last__2_))),COUNT(__d1(__NN(_additional__lname__date__last__2_)))},
    {'Event','KELOtto.PersonEventTypes','additional_fname_3',COUNT(__d1(__NL(_additional__fname__3_))),COUNT(__d1(__NN(_additional__fname__3_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_3',COUNT(__d1(__NL(_additional__lname__3_))),COUNT(__d1(__NN(_additional__lname__3_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_date_last_3',COUNT(__d1(__NL(_additional__lname__date__last__3_))),COUNT(__d1(__NN(_additional__lname__date__last__3_)))},
    {'Event','KELOtto.PersonEventTypes','subjectssncount',COUNT(__d1(__NL(_subjectssncount_))),COUNT(__d1(__NN(_subjectssncount_)))},
    {'Event','KELOtto.PersonEventTypes','dobmatchlevel',COUNT(__d1(__NL(_dobmatchlevel_))),COUNT(__d1(__NN(_dobmatchlevel_)))},
    {'Event','KELOtto.PersonEventTypes','Hri',COUNT(__d1(__NL(Hri_))),COUNT(__d1(__NN(Hri_)))},
    {'Event','KELOtto.PersonEventTypes','ssnfoundforlexid',COUNT(__d1(__NL(_ssnfoundforlexid_))),COUNT(__d1(__NN(_ssnfoundforlexid_)))},
    {'Event','KELOtto.PersonEventTypes','cvicustomscore',COUNT(__d1(__NL(_cvicustomscore_))),COUNT(__d1(__NN(_cvicustomscore_)))},
    {'Event','KELOtto.PersonEventTypes','SubjectSsnCount',COUNT(__d1(__NL(Subject_Ssn_Count_))),COUNT(__d1(__NN(Subject_Ssn_Count_)))},
    {'Event','KELOtto.PersonEventTypes','DateOfBirthMatchLevel',COUNT(__d1(__NL(Date_Of_Birth_Match_Level_))),COUNT(__d1(__NN(Date_Of_Birth_Match_Level_)))},
    {'Event','KELOtto.PersonEventTypes','StolenIdentityIndex',COUNT(__d1(__NL(Stolen_Identity_Index_))),COUNT(__d1(__NN(Stolen_Identity_Index_)))},
    {'Event','KELOtto.PersonEventTypes','SyntheticIdentityIndex',COUNT(__d1(__NL(Synthetic_Identity_Index_))),COUNT(__d1(__NN(Synthetic_Identity_Index_)))},
    {'Event','KELOtto.PersonEventTypes','ManipulatedIdentityIndex',COUNT(__d1(__NL(Manipulated_Identity_Index_))),COUNT(__d1(__NN(Manipulated_Identity_Index_)))},
    {'Event','KELOtto.PersonEventTypes','VulnerableVictimIndex',COUNT(__d1(__NL(Vulnerable_Victim_Index_))),COUNT(__d1(__NN(Vulnerable_Victim_Index_)))},
    {'Event','KELOtto.PersonEventTypes','FriendlyfraudIndex',COUNT(__d1(__NL(Friendlyfraud_Index_))),COUNT(__d1(__NN(Friendlyfraud_Index_)))},
    {'Event','KELOtto.PersonEventTypes','SuspiciousActivityIndex',COUNT(__d1(__NL(Suspicious_Activity_Index_))),COUNT(__d1(__NN(Suspicious_Activity_Index_)))},
    {'Event','KELOtto.PersonEventTypes','v2_sourcerisklevel',COUNT(__d1(__NL(_v2__sourcerisklevel_))),COUNT(__d1(__NN(_v2__sourcerisklevel_)))},
    {'Event','KELOtto.PersonEventTypes','v2_assocsuspicousidentitiescount',COUNT(__d1(__NL(_v2__assocsuspicousidentitiescount_))),COUNT(__d1(__NN(_v2__assocsuspicousidentitiescount_)))},
    {'Event','KELOtto.PersonEventTypes','v2_assoccreditbureauonlycount',COUNT(__d1(__NL(_v2__assoccreditbureauonlycount_))),COUNT(__d1(__NN(_v2__assoccreditbureauonlycount_)))},
    {'Event','KELOtto.PersonEventTypes','v2_validationaddrproblems',COUNT(__d1(__NL(_v2__validationaddrproblems_))),COUNT(__d1(__NN(_v2__validationaddrproblems_)))},
    {'Event','KELOtto.PersonEventTypes','v2_inputaddrageoldest',COUNT(__d1(__NL(_v2__inputaddrageoldest_))),COUNT(__d1(__NN(_v2__inputaddrageoldest_)))},
    {'Event','KELOtto.PersonEventTypes','v2_inputaddrdwelltype',COUNT(__d1(__NL(_v2__inputaddrdwelltype_))),COUNT(__d1(__NN(_v2__inputaddrdwelltype_)))},
    {'Event','KELOtto.PersonEventTypes','v2_divssnidentitycountnew',COUNT(__d1(__NL(_v2__divssnidentitycountnew_))),COUNT(__d1(__NN(_v2__divssnidentitycountnew_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedDate',COUNT(__d1(__NL(Deceased_Date_))),COUNT(__d1(__NN(Deceased_Date_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedDateOfBirth',COUNT(__d1(__NL(Deceased_Date_Of_Birth_))),COUNT(__d1(__NN(Deceased_Date_Of_Birth_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedFirst',COUNT(__d1(__NL(Deceased_First_))),COUNT(__d1(__NN(Deceased_First_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedMiddle',COUNT(__d1(__NL(Deceased_Middle_))),COUNT(__d1(__NN(Deceased_Middle_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedLast',COUNT(__d1(__NL(Deceased_Last_))),COUNT(__d1(__NN(Deceased_Last_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedMatchCode',COUNT(__d1(__NL(Deceased_Match_Code_))),COUNT(__d1(__NN(Deceased_Match_Code_)))},
    {'Event','KELOtto.PersonEventTypes','isdeepdive',COUNT(__d1(__NL(_isdeepdive_))),COUNT(__d1(__NN(_isdeepdive_)))},
    {'Event','KELOtto.PersonEventTypes','county_death',COUNT(__d1(__NL(_county__death_))),COUNT(__d1(__NN(_county__death_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedSsn',COUNT(__d1(__NL(Deceased_Ssn_))),COUNT(__d1(__NN(Deceased_Ssn_)))},
    {'Event','KELOtto.PersonEventTypes','state_death_flag',COUNT(__d1(__NL(_state__death__flag_))),COUNT(__d1(__NN(_state__death__flag_)))},
    {'Event','KELOtto.PersonEventTypes','death_rec_src',COUNT(__d1(__NL(_death__rec__src_))),COUNT(__d1(__NN(_death__rec__src_)))},
    {'Event','KELOtto.PersonEventTypes','state_death_id',COUNT(__d1(__NL(_state__death__id_))),COUNT(__d1(__NN(_state__death__id_)))},
    {'Event','KELOtto.PersonEventTypes','Hri',COUNT(__d1(__NL(Hri_))),COUNT(__d1(__NN(Hri_)))},
    {'Event','KELOtto.PersonEventTypes','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Event','KELOtto.PersonEventTypes','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
