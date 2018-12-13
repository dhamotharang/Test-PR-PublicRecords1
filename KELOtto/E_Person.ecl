//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Person := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
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
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nstr _off__cat__list_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),lexid(Lex_Id_:0),dateofbirth(Date_Of_Birth_:DATE),title(Title_),firstname(First_Name_),middlename(Middle_Name_),lastname(Last_Name_),namesuffix(Name_Suffix_),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),hri(Hri_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did)));
  SHARED __d1_KELfiltered := KELOtto.PersonCIID((UNSIGNED)did>0);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did)));
  SHARED __d2_KELfiltered := KELOtto.PersonFraudPoint((UNSIGNED)did>0);
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did)));
  SHARED __d3_Trim := PROJECT(KELOtto.PersonDeceased,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did)));
  SHARED __d4_KELfiltered := KELOtto.PersonCrim((UNSIGNED)did>0);
  SHARED __d4_Trim := PROJECT(__d4_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim + __d4_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)0);
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Person::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Person');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Person');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),did(Lex_Id_:0),dob(Date_Of_Birth_:DATE),cleaned_name.title(Title_),cleaned_name.fname(First_Name_),cleaned_name.mname(Middle_Name_),cleaned_name.lname(Last_Name_),cleaned_name.name_suffix(Name_Suffix_),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'|Date_Of_Birth_Match_Level_:0),hri(Hri_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_fraudgovshared_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),did(Lex_Id_:0),dateofbirth(Date_Of_Birth_:DATE),title(Title_),firstname(First_Name_),middlename(Middle_Name_),lastname(Last_Name_),namesuffix(Name_Suffix_),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),hri(Hri_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d1_Out := RECORD
    RECORDOF(KELOtto.PersonCIID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_PersonCIID_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  SHARED __Mapping2 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),did(Lex_Id_:0),dateofbirth(Date_Of_Birth_:DATE),title(Title_),firstname(First_Name_),middlename(Middle_Name_),lastname(Last_Name_),namesuffix(Name_Suffix_),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),hri(Hri_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d2_Out := RECORD
    RECORDOF(KELOtto.PersonFraudPoint);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_PersonFraudPoint_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2));
  SHARED __Mapping3 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),did(Lex_Id_:0),dateofbirth(Date_Of_Birth_:DATE),title(Title_),firstname(First_Name_),middlename(Middle_Name_),lastname(Last_Name_),namesuffix(Name_Suffix_),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),hri(Hri_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),dod8(Deceased_Date_:DATE),dob8(Deceased_Date_Of_Birth_:DATE),fname(Deceased_First_:\'\'),mname(Deceased_Middle_:\'\'),lname(Deceased_Last_:\'\'),matchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),ssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d3_Out := RECORD
    RECORDOF(KELOtto.PersonDeceased);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(KELOtto.PersonDeceased,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_PersonDeceased_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3));
  SHARED __Mapping4 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),did(Lex_Id_:0),dateofbirth(Date_Of_Birth_:DATE),title(Title_),firstname(First_Name_),middlename(Middle_Name_),lastname(Last_Name_),namesuffix(Name_Suffix_),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),hri(Hri_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d4_Out := RECORD
    RECORDOF(KELOtto.PersonCrim);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d4_UID_Mapped := JOIN(__d4_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d4_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_PersonCrim_Invalid := __d4_UID_Mapped(UID = 0);
  SHARED __d4_Prefiltered := __d4_UID_Mapped(UID <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4;
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
  EXPORT Full_Name_Layout := RECORD
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
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
  EXPORT Offenses_Layout := RECORD
    KEL.typ.nstr _off__cat__list_;
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
    KEL.typ.ndataset(Full_Name_Layout) Full_Name_;
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
    KEL.typ.ndataset(Hri_List_Layout) Hri_List_;
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
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(Offenses_Layout) Offenses_;
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
    SELF.Full_Name_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_},Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_),Full_Name_Layout)(__NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_)));
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
    SELF.Hri_List_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Hri_},Hri_),Hri_List_Layout)(__NN(Hri_)));
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
    SELF._curr__incar__flag_ := KEL.Intake.SingleValue(__recs,_curr__incar__flag_);
    SELF._name__ssn__dob__match_ := KEL.Intake.SingleValue(__recs,_name__ssn__dob__match_);
    SELF.Offenses_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_off__cat__list_},_off__cat__list_),Offenses_Layout)(__NN(_off__cat__list_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.Reported_Date_Of_Birth_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Date_Of_Birth_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Date_Of_Birth_)));
    SELF.Full_Name_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Full_Name_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_)));
    SELF.Hri_List_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hri_List_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Hri_)));
    SELF.Offenses_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Offenses_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_off__cat__list_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Person::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT Lex_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lex_Id_);
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
  EXPORT _curr__incar__flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_curr__incar__flag_);
  EXPORT _name__ssn__dob__match__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_name__ssn__dob__match_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(KELOtto_fraudgovshared_Invalid),COUNT(KELOtto_PersonCIID_Invalid),COUNT(KELOtto_PersonFraudPoint_Invalid),COUNT(KELOtto_PersonDeceased_Invalid),COUNT(KELOtto_PersonCrim_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(Lex_Id__SingleValue_Invalid),COUNT(Deceased_Date__SingleValue_Invalid),COUNT(Deceased_Date_Of_Birth__SingleValue_Invalid),COUNT(Deceased_First__SingleValue_Invalid),COUNT(Deceased_Middle__SingleValue_Invalid),COUNT(Deceased_Last__SingleValue_Invalid),COUNT(Deceased_Match_Code__SingleValue_Invalid),COUNT(_isdeepdive__SingleValue_Invalid),COUNT(_county__death__SingleValue_Invalid),COUNT(Deceased_Ssn__SingleValue_Invalid),COUNT(_state__death__flag__SingleValue_Invalid),COUNT(_death__rec__src__SingleValue_Invalid),COUNT(_state__death__id__SingleValue_Invalid),COUNT(_verfirst__SingleValue_Invalid),COUNT(_verlast__SingleValue_Invalid),COUNT(_veraddr__SingleValue_Invalid),COUNT(_vercity__SingleValue_Invalid),COUNT(_verstate__SingleValue_Invalid),COUNT(_verzip__SingleValue_Invalid),COUNT(_verzip4__SingleValue_Invalid),COUNT(_verssn__SingleValue_Invalid),COUNT(_verdob__SingleValue_Invalid),COUNT(_verhphone__SingleValue_Invalid),COUNT(_verify__addr__SingleValue_Invalid),COUNT(_verify__dob__SingleValue_Invalid),COUNT(_valid__ssn__SingleValue_Invalid),COUNT(_nas__summary__SingleValue_Invalid),COUNT(_nap__summary__SingleValue_Invalid),COUNT(_cvi__SingleValue_Invalid),COUNT(_additional__fname__1__SingleValue_Invalid),COUNT(_additional__lname__1__SingleValue_Invalid),COUNT(_additional__lname__date__last__1__SingleValue_Invalid),COUNT(_additional__fname__2__SingleValue_Invalid),COUNT(_additional__lname__2__SingleValue_Invalid),COUNT(_additional__lname__date__last__2__SingleValue_Invalid),COUNT(_additional__fname__3__SingleValue_Invalid),COUNT(_additional__lname__3__SingleValue_Invalid),COUNT(_additional__lname__date__last__3__SingleValue_Invalid),COUNT(_subjectssncount__SingleValue_Invalid),COUNT(_dobmatchlevel__SingleValue_Invalid),COUNT(_ssnfoundforlexid__SingleValue_Invalid),COUNT(_cvicustomscore__SingleValue_Invalid),COUNT(Subject_Ssn_Count__SingleValue_Invalid),COUNT(Date_Of_Birth_Match_Level__SingleValue_Invalid),COUNT(Stolen_Identity_Index__SingleValue_Invalid),COUNT(Synthetic_Identity_Index__SingleValue_Invalid),COUNT(Manipulated_Identity_Index__SingleValue_Invalid),COUNT(Vulnerable_Victim_Index__SingleValue_Invalid),COUNT(Friendlyfraud_Index__SingleValue_Invalid),COUNT(Suspicious_Activity_Index__SingleValue_Invalid),COUNT(_v2__sourcerisklevel__SingleValue_Invalid),COUNT(_v2__assocsuspicousidentitiescount__SingleValue_Invalid),COUNT(_v2__assoccreditbureauonlycount__SingleValue_Invalid),COUNT(_v2__validationaddrproblems__SingleValue_Invalid),COUNT(_v2__inputaddrageoldest__SingleValue_Invalid),COUNT(_v2__inputaddrdwelltype__SingleValue_Invalid),COUNT(_v2__divssnidentitycountnew__SingleValue_Invalid),COUNT(_curr__incar__flag__SingleValue_Invalid),COUNT(_name__ssn__dob__match__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int KELOtto_fraudgovshared_Invalid,KEL.typ.int KELOtto_PersonCIID_Invalid,KEL.typ.int KELOtto_PersonFraudPoint_Invalid,KEL.typ.int KELOtto_PersonDeceased_Invalid,KEL.typ.int KELOtto_PersonCrim_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int Lex_Id__SingleValue_Invalid,KEL.typ.int Deceased_Date__SingleValue_Invalid,KEL.typ.int Deceased_Date_Of_Birth__SingleValue_Invalid,KEL.typ.int Deceased_First__SingleValue_Invalid,KEL.typ.int Deceased_Middle__SingleValue_Invalid,KEL.typ.int Deceased_Last__SingleValue_Invalid,KEL.typ.int Deceased_Match_Code__SingleValue_Invalid,KEL.typ.int _isdeepdive__SingleValue_Invalid,KEL.typ.int _county__death__SingleValue_Invalid,KEL.typ.int Deceased_Ssn__SingleValue_Invalid,KEL.typ.int _state__death__flag__SingleValue_Invalid,KEL.typ.int _death__rec__src__SingleValue_Invalid,KEL.typ.int _state__death__id__SingleValue_Invalid,KEL.typ.int _verfirst__SingleValue_Invalid,KEL.typ.int _verlast__SingleValue_Invalid,KEL.typ.int _veraddr__SingleValue_Invalid,KEL.typ.int _vercity__SingleValue_Invalid,KEL.typ.int _verstate__SingleValue_Invalid,KEL.typ.int _verzip__SingleValue_Invalid,KEL.typ.int _verzip4__SingleValue_Invalid,KEL.typ.int _verssn__SingleValue_Invalid,KEL.typ.int _verdob__SingleValue_Invalid,KEL.typ.int _verhphone__SingleValue_Invalid,KEL.typ.int _verify__addr__SingleValue_Invalid,KEL.typ.int _verify__dob__SingleValue_Invalid,KEL.typ.int _valid__ssn__SingleValue_Invalid,KEL.typ.int _nas__summary__SingleValue_Invalid,KEL.typ.int _nap__summary__SingleValue_Invalid,KEL.typ.int _cvi__SingleValue_Invalid,KEL.typ.int _additional__fname__1__SingleValue_Invalid,KEL.typ.int _additional__lname__1__SingleValue_Invalid,KEL.typ.int _additional__lname__date__last__1__SingleValue_Invalid,KEL.typ.int _additional__fname__2__SingleValue_Invalid,KEL.typ.int _additional__lname__2__SingleValue_Invalid,KEL.typ.int _additional__lname__date__last__2__SingleValue_Invalid,KEL.typ.int _additional__fname__3__SingleValue_Invalid,KEL.typ.int _additional__lname__3__SingleValue_Invalid,KEL.typ.int _additional__lname__date__last__3__SingleValue_Invalid,KEL.typ.int _subjectssncount__SingleValue_Invalid,KEL.typ.int _dobmatchlevel__SingleValue_Invalid,KEL.typ.int _ssnfoundforlexid__SingleValue_Invalid,KEL.typ.int _cvicustomscore__SingleValue_Invalid,KEL.typ.int Subject_Ssn_Count__SingleValue_Invalid,KEL.typ.int Date_Of_Birth_Match_Level__SingleValue_Invalid,KEL.typ.int Stolen_Identity_Index__SingleValue_Invalid,KEL.typ.int Synthetic_Identity_Index__SingleValue_Invalid,KEL.typ.int Manipulated_Identity_Index__SingleValue_Invalid,KEL.typ.int Vulnerable_Victim_Index__SingleValue_Invalid,KEL.typ.int Friendlyfraud_Index__SingleValue_Invalid,KEL.typ.int Suspicious_Activity_Index__SingleValue_Invalid,KEL.typ.int _v2__sourcerisklevel__SingleValue_Invalid,KEL.typ.int _v2__assocsuspicousidentitiescount__SingleValue_Invalid,KEL.typ.int _v2__assoccreditbureauonlycount__SingleValue_Invalid,KEL.typ.int _v2__validationaddrproblems__SingleValue_Invalid,KEL.typ.int _v2__inputaddrageoldest__SingleValue_Invalid,KEL.typ.int _v2__inputaddrdwelltype__SingleValue_Invalid,KEL.typ.int _v2__divssnidentitycountnew__SingleValue_Invalid,KEL.typ.int _curr__incar__flag__SingleValue_Invalid,KEL.typ.int _name__ssn__dob__match__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Person','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_Invalid),COUNT(__d0)},
    {'Person','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'Person','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'Person','KELOtto.fraudgovshared','did',COUNT(__d0(__NL(Lex_Id_))),COUNT(__d0(__NN(Lex_Id_)))},
    {'Person','KELOtto.fraudgovshared','dob',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Person','KELOtto.fraudgovshared','cleaned_name.title',COUNT(__d0(__NL(Title_))),COUNT(__d0(__NN(Title_)))},
    {'Person','KELOtto.fraudgovshared','cleaned_name.fname',COUNT(__d0(__NL(First_Name_))),COUNT(__d0(__NN(First_Name_)))},
    {'Person','KELOtto.fraudgovshared','cleaned_name.mname',COUNT(__d0(__NL(Middle_Name_))),COUNT(__d0(__NN(Middle_Name_)))},
    {'Person','KELOtto.fraudgovshared','cleaned_name.lname',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'Person','KELOtto.fraudgovshared','cleaned_name.name_suffix',COUNT(__d0(__NL(Name_Suffix_))),COUNT(__d0(__NN(Name_Suffix_)))},
    {'Person','KELOtto.fraudgovshared','verfirst',COUNT(__d0(__NL(_verfirst_))),COUNT(__d0(__NN(_verfirst_)))},
    {'Person','KELOtto.fraudgovshared','verlast',COUNT(__d0(__NL(_verlast_))),COUNT(__d0(__NN(_verlast_)))},
    {'Person','KELOtto.fraudgovshared','veraddr',COUNT(__d0(__NL(_veraddr_))),COUNT(__d0(__NN(_veraddr_)))},
    {'Person','KELOtto.fraudgovshared','vercity',COUNT(__d0(__NL(_vercity_))),COUNT(__d0(__NN(_vercity_)))},
    {'Person','KELOtto.fraudgovshared','verstate',COUNT(__d0(__NL(_verstate_))),COUNT(__d0(__NN(_verstate_)))},
    {'Person','KELOtto.fraudgovshared','verzip',COUNT(__d0(__NL(_verzip_))),COUNT(__d0(__NN(_verzip_)))},
    {'Person','KELOtto.fraudgovshared','verzip4',COUNT(__d0(__NL(_verzip4_))),COUNT(__d0(__NN(_verzip4_)))},
    {'Person','KELOtto.fraudgovshared','verssn',COUNT(__d0(__NL(_verssn_))),COUNT(__d0(__NN(_verssn_)))},
    {'Person','KELOtto.fraudgovshared','verdob',COUNT(__d0(__NL(_verdob_))),COUNT(__d0(__NN(_verdob_)))},
    {'Person','KELOtto.fraudgovshared','verhphone',COUNT(__d0(__NL(_verhphone_))),COUNT(__d0(__NN(_verhphone_)))},
    {'Person','KELOtto.fraudgovshared','verify_addr',COUNT(__d0(__NL(_verify__addr_))),COUNT(__d0(__NN(_verify__addr_)))},
    {'Person','KELOtto.fraudgovshared','verify_dob',COUNT(__d0(__NL(_verify__dob_))),COUNT(__d0(__NN(_verify__dob_)))},
    {'Person','KELOtto.fraudgovshared','valid_ssn',COUNT(__d0(__NL(_valid__ssn_))),COUNT(__d0(__NN(_valid__ssn_)))},
    {'Person','KELOtto.fraudgovshared','nas_summary',COUNT(__d0(__NL(_nas__summary_))),COUNT(__d0(__NN(_nas__summary_)))},
    {'Person','KELOtto.fraudgovshared','nap_summary',COUNT(__d0(__NL(_nap__summary_))),COUNT(__d0(__NN(_nap__summary_)))},
    {'Person','KELOtto.fraudgovshared','cvi',COUNT(__d0(__NL(_cvi_))),COUNT(__d0(__NN(_cvi_)))},
    {'Person','KELOtto.fraudgovshared','additional_fname_1',COUNT(__d0(__NL(_additional__fname__1_))),COUNT(__d0(__NN(_additional__fname__1_)))},
    {'Person','KELOtto.fraudgovshared','additional_lname_1',COUNT(__d0(__NL(_additional__lname__1_))),COUNT(__d0(__NN(_additional__lname__1_)))},
    {'Person','KELOtto.fraudgovshared','additional_lname_date_last_1',COUNT(__d0(__NL(_additional__lname__date__last__1_))),COUNT(__d0(__NN(_additional__lname__date__last__1_)))},
    {'Person','KELOtto.fraudgovshared','additional_fname_2',COUNT(__d0(__NL(_additional__fname__2_))),COUNT(__d0(__NN(_additional__fname__2_)))},
    {'Person','KELOtto.fraudgovshared','additional_lname_2',COUNT(__d0(__NL(_additional__lname__2_))),COUNT(__d0(__NN(_additional__lname__2_)))},
    {'Person','KELOtto.fraudgovshared','additional_lname_date_last_2',COUNT(__d0(__NL(_additional__lname__date__last__2_))),COUNT(__d0(__NN(_additional__lname__date__last__2_)))},
    {'Person','KELOtto.fraudgovshared','additional_fname_3',COUNT(__d0(__NL(_additional__fname__3_))),COUNT(__d0(__NN(_additional__fname__3_)))},
    {'Person','KELOtto.fraudgovshared','additional_lname_3',COUNT(__d0(__NL(_additional__lname__3_))),COUNT(__d0(__NN(_additional__lname__3_)))},
    {'Person','KELOtto.fraudgovshared','additional_lname_date_last_3',COUNT(__d0(__NL(_additional__lname__date__last__3_))),COUNT(__d0(__NN(_additional__lname__date__last__3_)))},
    {'Person','KELOtto.fraudgovshared','subjectssncount',COUNT(__d0(__NL(_subjectssncount_))),COUNT(__d0(__NN(_subjectssncount_)))},
    {'Person','KELOtto.fraudgovshared','dobmatchlevel',COUNT(__d0(__NL(_dobmatchlevel_))),COUNT(__d0(__NN(_dobmatchlevel_)))},
    {'Person','KELOtto.fraudgovshared','Hri',COUNT(__d0(__NL(Hri_))),COUNT(__d0(__NN(Hri_)))},
    {'Person','KELOtto.fraudgovshared','ssnfoundforlexid',COUNT(__d0(__NL(_ssnfoundforlexid_))),COUNT(__d0(__NN(_ssnfoundforlexid_)))},
    {'Person','KELOtto.fraudgovshared','cvicustomscore',COUNT(__d0(__NL(_cvicustomscore_))),COUNT(__d0(__NN(_cvicustomscore_)))},
    {'Person','KELOtto.fraudgovshared','subjectssncount',COUNT(__d0(__NL(Subject_Ssn_Count_))),COUNT(__d0(__NN(Subject_Ssn_Count_)))},
    {'Person','KELOtto.fraudgovshared','dobmatchlevel',COUNT(__d0(__NL(Date_Of_Birth_Match_Level_))),COUNT(__d0(__NN(Date_Of_Birth_Match_Level_)))},
    {'Person','KELOtto.fraudgovshared','StolenIdentityIndex',COUNT(__d0(__NL(Stolen_Identity_Index_))),COUNT(__d0(__NN(Stolen_Identity_Index_)))},
    {'Person','KELOtto.fraudgovshared','SyntheticIdentityIndex',COUNT(__d0(__NL(Synthetic_Identity_Index_))),COUNT(__d0(__NN(Synthetic_Identity_Index_)))},
    {'Person','KELOtto.fraudgovshared','ManipulatedIdentityIndex',COUNT(__d0(__NL(Manipulated_Identity_Index_))),COUNT(__d0(__NN(Manipulated_Identity_Index_)))},
    {'Person','KELOtto.fraudgovshared','VulnerableVictimIndex',COUNT(__d0(__NL(Vulnerable_Victim_Index_))),COUNT(__d0(__NN(Vulnerable_Victim_Index_)))},
    {'Person','KELOtto.fraudgovshared','FriendlyfraudIndex',COUNT(__d0(__NL(Friendlyfraud_Index_))),COUNT(__d0(__NN(Friendlyfraud_Index_)))},
    {'Person','KELOtto.fraudgovshared','SuspiciousActivityIndex',COUNT(__d0(__NL(Suspicious_Activity_Index_))),COUNT(__d0(__NN(Suspicious_Activity_Index_)))},
    {'Person','KELOtto.fraudgovshared','v2_sourcerisklevel',COUNT(__d0(__NL(_v2__sourcerisklevel_))),COUNT(__d0(__NN(_v2__sourcerisklevel_)))},
    {'Person','KELOtto.fraudgovshared','v2_assocsuspicousidentitiescount',COUNT(__d0(__NL(_v2__assocsuspicousidentitiescount_))),COUNT(__d0(__NN(_v2__assocsuspicousidentitiescount_)))},
    {'Person','KELOtto.fraudgovshared','v2_assoccreditbureauonlycount',COUNT(__d0(__NL(_v2__assoccreditbureauonlycount_))),COUNT(__d0(__NN(_v2__assoccreditbureauonlycount_)))},
    {'Person','KELOtto.fraudgovshared','v2_validationaddrproblems',COUNT(__d0(__NL(_v2__validationaddrproblems_))),COUNT(__d0(__NN(_v2__validationaddrproblems_)))},
    {'Person','KELOtto.fraudgovshared','v2_inputaddrageoldest',COUNT(__d0(__NL(_v2__inputaddrageoldest_))),COUNT(__d0(__NN(_v2__inputaddrageoldest_)))},
    {'Person','KELOtto.fraudgovshared','v2_inputaddrdwelltype',COUNT(__d0(__NL(_v2__inputaddrdwelltype_))),COUNT(__d0(__NN(_v2__inputaddrdwelltype_)))},
    {'Person','KELOtto.fraudgovshared','v2_divssnidentitycountnew',COUNT(__d0(__NL(_v2__divssnidentitycountnew_))),COUNT(__d0(__NN(_v2__divssnidentitycountnew_)))},
    {'Person','KELOtto.fraudgovshared','DeceasedDate',COUNT(__d0(__NL(Deceased_Date_))),COUNT(__d0(__NN(Deceased_Date_)))},
    {'Person','KELOtto.fraudgovshared','DeceasedDateOfBirth',COUNT(__d0(__NL(Deceased_Date_Of_Birth_))),COUNT(__d0(__NN(Deceased_Date_Of_Birth_)))},
    {'Person','KELOtto.fraudgovshared','DeceasedFirst',COUNT(__d0(__NL(Deceased_First_))),COUNT(__d0(__NN(Deceased_First_)))},
    {'Person','KELOtto.fraudgovshared','DeceasedMiddle',COUNT(__d0(__NL(Deceased_Middle_))),COUNT(__d0(__NN(Deceased_Middle_)))},
    {'Person','KELOtto.fraudgovshared','DeceasedLast',COUNT(__d0(__NL(Deceased_Last_))),COUNT(__d0(__NN(Deceased_Last_)))},
    {'Person','KELOtto.fraudgovshared','DeceasedMatchCode',COUNT(__d0(__NL(Deceased_Match_Code_))),COUNT(__d0(__NN(Deceased_Match_Code_)))},
    {'Person','KELOtto.fraudgovshared','isdeepdive',COUNT(__d0(__NL(_isdeepdive_))),COUNT(__d0(__NN(_isdeepdive_)))},
    {'Person','KELOtto.fraudgovshared','county_death',COUNT(__d0(__NL(_county__death_))),COUNT(__d0(__NN(_county__death_)))},
    {'Person','KELOtto.fraudgovshared','DeceasedSsn',COUNT(__d0(__NL(Deceased_Ssn_))),COUNT(__d0(__NN(Deceased_Ssn_)))},
    {'Person','KELOtto.fraudgovshared','state_death_flag',COUNT(__d0(__NL(_state__death__flag_))),COUNT(__d0(__NN(_state__death__flag_)))},
    {'Person','KELOtto.fraudgovshared','death_rec_src',COUNT(__d0(__NL(_death__rec__src_))),COUNT(__d0(__NN(_death__rec__src_)))},
    {'Person','KELOtto.fraudgovshared','state_death_id',COUNT(__d0(__NL(_state__death__id_))),COUNT(__d0(__NN(_state__death__id_)))},
    {'Person','KELOtto.fraudgovshared','curr_incar_flag',COUNT(__d0(__NL(_curr__incar__flag_))),COUNT(__d0(__NN(_curr__incar__flag_)))},
    {'Person','KELOtto.fraudgovshared','off_cat_list',COUNT(__d0(__NL(_off__cat__list_))),COUNT(__d0(__NN(_off__cat__list_)))},
    {'Person','KELOtto.fraudgovshared','name_ssn_dob_match',COUNT(__d0(__NL(_name__ssn__dob__match_))),COUNT(__d0(__NN(_name__ssn__dob__match_)))},
    {'Person','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Person','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Person','KELOtto.PersonCIID','UID',COUNT(KELOtto_PersonCIID_Invalid),COUNT(__d1)},
    {'Person','KELOtto.PersonCIID','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'Person','KELOtto.PersonCIID','SourceCustomerFileInfo',COUNT(__d1(__NL(_r_Source_Customer_))),COUNT(__d1(__NN(_r_Source_Customer_)))},
    {'Person','KELOtto.PersonCIID','did',COUNT(__d1(__NL(Lex_Id_))),COUNT(__d1(__NN(Lex_Id_)))},
    {'Person','KELOtto.PersonCIID','DateOfBirth',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'Person','KELOtto.PersonCIID','Title',COUNT(__d1(__NL(Title_))),COUNT(__d1(__NN(Title_)))},
    {'Person','KELOtto.PersonCIID','FirstName',COUNT(__d1(__NL(First_Name_))),COUNT(__d1(__NN(First_Name_)))},
    {'Person','KELOtto.PersonCIID','MiddleName',COUNT(__d1(__NL(Middle_Name_))),COUNT(__d1(__NN(Middle_Name_)))},
    {'Person','KELOtto.PersonCIID','LastName',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'Person','KELOtto.PersonCIID','NameSuffix',COUNT(__d1(__NL(Name_Suffix_))),COUNT(__d1(__NN(Name_Suffix_)))},
    {'Person','KELOtto.PersonCIID','verfirst',COUNT(__d1(__NL(_verfirst_))),COUNT(__d1(__NN(_verfirst_)))},
    {'Person','KELOtto.PersonCIID','verlast',COUNT(__d1(__NL(_verlast_))),COUNT(__d1(__NN(_verlast_)))},
    {'Person','KELOtto.PersonCIID','veraddr',COUNT(__d1(__NL(_veraddr_))),COUNT(__d1(__NN(_veraddr_)))},
    {'Person','KELOtto.PersonCIID','vercity',COUNT(__d1(__NL(_vercity_))),COUNT(__d1(__NN(_vercity_)))},
    {'Person','KELOtto.PersonCIID','verstate',COUNT(__d1(__NL(_verstate_))),COUNT(__d1(__NN(_verstate_)))},
    {'Person','KELOtto.PersonCIID','verzip',COUNT(__d1(__NL(_verzip_))),COUNT(__d1(__NN(_verzip_)))},
    {'Person','KELOtto.PersonCIID','verzip4',COUNT(__d1(__NL(_verzip4_))),COUNT(__d1(__NN(_verzip4_)))},
    {'Person','KELOtto.PersonCIID','verssn',COUNT(__d1(__NL(_verssn_))),COUNT(__d1(__NN(_verssn_)))},
    {'Person','KELOtto.PersonCIID','verdob',COUNT(__d1(__NL(_verdob_))),COUNT(__d1(__NN(_verdob_)))},
    {'Person','KELOtto.PersonCIID','verhphone',COUNT(__d1(__NL(_verhphone_))),COUNT(__d1(__NN(_verhphone_)))},
    {'Person','KELOtto.PersonCIID','verify_addr',COUNT(__d1(__NL(_verify__addr_))),COUNT(__d1(__NN(_verify__addr_)))},
    {'Person','KELOtto.PersonCIID','verify_dob',COUNT(__d1(__NL(_verify__dob_))),COUNT(__d1(__NN(_verify__dob_)))},
    {'Person','KELOtto.PersonCIID','valid_ssn',COUNT(__d1(__NL(_valid__ssn_))),COUNT(__d1(__NN(_valid__ssn_)))},
    {'Person','KELOtto.PersonCIID','nas_summary',COUNT(__d1(__NL(_nas__summary_))),COUNT(__d1(__NN(_nas__summary_)))},
    {'Person','KELOtto.PersonCIID','nap_summary',COUNT(__d1(__NL(_nap__summary_))),COUNT(__d1(__NN(_nap__summary_)))},
    {'Person','KELOtto.PersonCIID','cvi',COUNT(__d1(__NL(_cvi_))),COUNT(__d1(__NN(_cvi_)))},
    {'Person','KELOtto.PersonCIID','additional_fname_1',COUNT(__d1(__NL(_additional__fname__1_))),COUNT(__d1(__NN(_additional__fname__1_)))},
    {'Person','KELOtto.PersonCIID','additional_lname_1',COUNT(__d1(__NL(_additional__lname__1_))),COUNT(__d1(__NN(_additional__lname__1_)))},
    {'Person','KELOtto.PersonCIID','additional_lname_date_last_1',COUNT(__d1(__NL(_additional__lname__date__last__1_))),COUNT(__d1(__NN(_additional__lname__date__last__1_)))},
    {'Person','KELOtto.PersonCIID','additional_fname_2',COUNT(__d1(__NL(_additional__fname__2_))),COUNT(__d1(__NN(_additional__fname__2_)))},
    {'Person','KELOtto.PersonCIID','additional_lname_2',COUNT(__d1(__NL(_additional__lname__2_))),COUNT(__d1(__NN(_additional__lname__2_)))},
    {'Person','KELOtto.PersonCIID','additional_lname_date_last_2',COUNT(__d1(__NL(_additional__lname__date__last__2_))),COUNT(__d1(__NN(_additional__lname__date__last__2_)))},
    {'Person','KELOtto.PersonCIID','additional_fname_3',COUNT(__d1(__NL(_additional__fname__3_))),COUNT(__d1(__NN(_additional__fname__3_)))},
    {'Person','KELOtto.PersonCIID','additional_lname_3',COUNT(__d1(__NL(_additional__lname__3_))),COUNT(__d1(__NN(_additional__lname__3_)))},
    {'Person','KELOtto.PersonCIID','additional_lname_date_last_3',COUNT(__d1(__NL(_additional__lname__date__last__3_))),COUNT(__d1(__NN(_additional__lname__date__last__3_)))},
    {'Person','KELOtto.PersonCIID','subjectssncount',COUNT(__d1(__NL(_subjectssncount_))),COUNT(__d1(__NN(_subjectssncount_)))},
    {'Person','KELOtto.PersonCIID','dobmatchlevel',COUNT(__d1(__NL(_dobmatchlevel_))),COUNT(__d1(__NN(_dobmatchlevel_)))},
    {'Person','KELOtto.PersonCIID','Hri',COUNT(__d1(__NL(Hri_))),COUNT(__d1(__NN(Hri_)))},
    {'Person','KELOtto.PersonCIID','ssnfoundforlexid',COUNT(__d1(__NL(_ssnfoundforlexid_))),COUNT(__d1(__NN(_ssnfoundforlexid_)))},
    {'Person','KELOtto.PersonCIID','cvicustomscore',COUNT(__d1(__NL(_cvicustomscore_))),COUNT(__d1(__NN(_cvicustomscore_)))},
    {'Person','KELOtto.PersonCIID','subjectssncount',COUNT(__d1(__NL(Subject_Ssn_Count_))),COUNT(__d1(__NN(Subject_Ssn_Count_)))},
    {'Person','KELOtto.PersonCIID','DateOfBirthMatchLevel',COUNT(__d1(__NL(Date_Of_Birth_Match_Level_))),COUNT(__d1(__NN(Date_Of_Birth_Match_Level_)))},
    {'Person','KELOtto.PersonCIID','StolenIdentityIndex',COUNT(__d1(__NL(Stolen_Identity_Index_))),COUNT(__d1(__NN(Stolen_Identity_Index_)))},
    {'Person','KELOtto.PersonCIID','SyntheticIdentityIndex',COUNT(__d1(__NL(Synthetic_Identity_Index_))),COUNT(__d1(__NN(Synthetic_Identity_Index_)))},
    {'Person','KELOtto.PersonCIID','ManipulatedIdentityIndex',COUNT(__d1(__NL(Manipulated_Identity_Index_))),COUNT(__d1(__NN(Manipulated_Identity_Index_)))},
    {'Person','KELOtto.PersonCIID','VulnerableVictimIndex',COUNT(__d1(__NL(Vulnerable_Victim_Index_))),COUNT(__d1(__NN(Vulnerable_Victim_Index_)))},
    {'Person','KELOtto.PersonCIID','FriendlyfraudIndex',COUNT(__d1(__NL(Friendlyfraud_Index_))),COUNT(__d1(__NN(Friendlyfraud_Index_)))},
    {'Person','KELOtto.PersonCIID','SuspiciousActivityIndex',COUNT(__d1(__NL(Suspicious_Activity_Index_))),COUNT(__d1(__NN(Suspicious_Activity_Index_)))},
    {'Person','KELOtto.PersonCIID','v2_sourcerisklevel',COUNT(__d1(__NL(_v2__sourcerisklevel_))),COUNT(__d1(__NN(_v2__sourcerisklevel_)))},
    {'Person','KELOtto.PersonCIID','v2_assocsuspicousidentitiescount',COUNT(__d1(__NL(_v2__assocsuspicousidentitiescount_))),COUNT(__d1(__NN(_v2__assocsuspicousidentitiescount_)))},
    {'Person','KELOtto.PersonCIID','v2_assoccreditbureauonlycount',COUNT(__d1(__NL(_v2__assoccreditbureauonlycount_))),COUNT(__d1(__NN(_v2__assoccreditbureauonlycount_)))},
    {'Person','KELOtto.PersonCIID','v2_validationaddrproblems',COUNT(__d1(__NL(_v2__validationaddrproblems_))),COUNT(__d1(__NN(_v2__validationaddrproblems_)))},
    {'Person','KELOtto.PersonCIID','v2_inputaddrageoldest',COUNT(__d1(__NL(_v2__inputaddrageoldest_))),COUNT(__d1(__NN(_v2__inputaddrageoldest_)))},
    {'Person','KELOtto.PersonCIID','v2_inputaddrdwelltype',COUNT(__d1(__NL(_v2__inputaddrdwelltype_))),COUNT(__d1(__NN(_v2__inputaddrdwelltype_)))},
    {'Person','KELOtto.PersonCIID','v2_divssnidentitycountnew',COUNT(__d1(__NL(_v2__divssnidentitycountnew_))),COUNT(__d1(__NN(_v2__divssnidentitycountnew_)))},
    {'Person','KELOtto.PersonCIID','DeceasedDate',COUNT(__d1(__NL(Deceased_Date_))),COUNT(__d1(__NN(Deceased_Date_)))},
    {'Person','KELOtto.PersonCIID','DeceasedDateOfBirth',COUNT(__d1(__NL(Deceased_Date_Of_Birth_))),COUNT(__d1(__NN(Deceased_Date_Of_Birth_)))},
    {'Person','KELOtto.PersonCIID','DeceasedFirst',COUNT(__d1(__NL(Deceased_First_))),COUNT(__d1(__NN(Deceased_First_)))},
    {'Person','KELOtto.PersonCIID','DeceasedMiddle',COUNT(__d1(__NL(Deceased_Middle_))),COUNT(__d1(__NN(Deceased_Middle_)))},
    {'Person','KELOtto.PersonCIID','DeceasedLast',COUNT(__d1(__NL(Deceased_Last_))),COUNT(__d1(__NN(Deceased_Last_)))},
    {'Person','KELOtto.PersonCIID','DeceasedMatchCode',COUNT(__d1(__NL(Deceased_Match_Code_))),COUNT(__d1(__NN(Deceased_Match_Code_)))},
    {'Person','KELOtto.PersonCIID','isdeepdive',COUNT(__d1(__NL(_isdeepdive_))),COUNT(__d1(__NN(_isdeepdive_)))},
    {'Person','KELOtto.PersonCIID','county_death',COUNT(__d1(__NL(_county__death_))),COUNT(__d1(__NN(_county__death_)))},
    {'Person','KELOtto.PersonCIID','DeceasedSsn',COUNT(__d1(__NL(Deceased_Ssn_))),COUNT(__d1(__NN(Deceased_Ssn_)))},
    {'Person','KELOtto.PersonCIID','state_death_flag',COUNT(__d1(__NL(_state__death__flag_))),COUNT(__d1(__NN(_state__death__flag_)))},
    {'Person','KELOtto.PersonCIID','death_rec_src',COUNT(__d1(__NL(_death__rec__src_))),COUNT(__d1(__NN(_death__rec__src_)))},
    {'Person','KELOtto.PersonCIID','state_death_id',COUNT(__d1(__NL(_state__death__id_))),COUNT(__d1(__NN(_state__death__id_)))},
    {'Person','KELOtto.PersonCIID','curr_incar_flag',COUNT(__d1(__NL(_curr__incar__flag_))),COUNT(__d1(__NN(_curr__incar__flag_)))},
    {'Person','KELOtto.PersonCIID','off_cat_list',COUNT(__d1(__NL(_off__cat__list_))),COUNT(__d1(__NN(_off__cat__list_)))},
    {'Person','KELOtto.PersonCIID','name_ssn_dob_match',COUNT(__d1(__NL(_name__ssn__dob__match_))),COUNT(__d1(__NN(_name__ssn__dob__match_)))},
    {'Person','KELOtto.PersonCIID','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Person','KELOtto.PersonCIID','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Person','KELOtto.PersonFraudPoint','UID',COUNT(KELOtto_PersonFraudPoint_Invalid),COUNT(__d2)},
    {'Person','KELOtto.PersonFraudPoint','AssociatedCustomerFileInfo',COUNT(__d2(__NL(_r_Customer_))),COUNT(__d2(__NN(_r_Customer_)))},
    {'Person','KELOtto.PersonFraudPoint','SourceCustomerFileInfo',COUNT(__d2(__NL(_r_Source_Customer_))),COUNT(__d2(__NN(_r_Source_Customer_)))},
    {'Person','KELOtto.PersonFraudPoint','did',COUNT(__d2(__NL(Lex_Id_))),COUNT(__d2(__NN(Lex_Id_)))},
    {'Person','KELOtto.PersonFraudPoint','DateOfBirth',COUNT(__d2(__NL(Date_Of_Birth_))),COUNT(__d2(__NN(Date_Of_Birth_)))},
    {'Person','KELOtto.PersonFraudPoint','Title',COUNT(__d2(__NL(Title_))),COUNT(__d2(__NN(Title_)))},
    {'Person','KELOtto.PersonFraudPoint','FirstName',COUNT(__d2(__NL(First_Name_))),COUNT(__d2(__NN(First_Name_)))},
    {'Person','KELOtto.PersonFraudPoint','MiddleName',COUNT(__d2(__NL(Middle_Name_))),COUNT(__d2(__NN(Middle_Name_)))},
    {'Person','KELOtto.PersonFraudPoint','LastName',COUNT(__d2(__NL(Last_Name_))),COUNT(__d2(__NN(Last_Name_)))},
    {'Person','KELOtto.PersonFraudPoint','NameSuffix',COUNT(__d2(__NL(Name_Suffix_))),COUNT(__d2(__NN(Name_Suffix_)))},
    {'Person','KELOtto.PersonFraudPoint','verfirst',COUNT(__d2(__NL(_verfirst_))),COUNT(__d2(__NN(_verfirst_)))},
    {'Person','KELOtto.PersonFraudPoint','verlast',COUNT(__d2(__NL(_verlast_))),COUNT(__d2(__NN(_verlast_)))},
    {'Person','KELOtto.PersonFraudPoint','veraddr',COUNT(__d2(__NL(_veraddr_))),COUNT(__d2(__NN(_veraddr_)))},
    {'Person','KELOtto.PersonFraudPoint','vercity',COUNT(__d2(__NL(_vercity_))),COUNT(__d2(__NN(_vercity_)))},
    {'Person','KELOtto.PersonFraudPoint','verstate',COUNT(__d2(__NL(_verstate_))),COUNT(__d2(__NN(_verstate_)))},
    {'Person','KELOtto.PersonFraudPoint','verzip',COUNT(__d2(__NL(_verzip_))),COUNT(__d2(__NN(_verzip_)))},
    {'Person','KELOtto.PersonFraudPoint','verzip4',COUNT(__d2(__NL(_verzip4_))),COUNT(__d2(__NN(_verzip4_)))},
    {'Person','KELOtto.PersonFraudPoint','verssn',COUNT(__d2(__NL(_verssn_))),COUNT(__d2(__NN(_verssn_)))},
    {'Person','KELOtto.PersonFraudPoint','verdob',COUNT(__d2(__NL(_verdob_))),COUNT(__d2(__NN(_verdob_)))},
    {'Person','KELOtto.PersonFraudPoint','verhphone',COUNT(__d2(__NL(_verhphone_))),COUNT(__d2(__NN(_verhphone_)))},
    {'Person','KELOtto.PersonFraudPoint','verify_addr',COUNT(__d2(__NL(_verify__addr_))),COUNT(__d2(__NN(_verify__addr_)))},
    {'Person','KELOtto.PersonFraudPoint','verify_dob',COUNT(__d2(__NL(_verify__dob_))),COUNT(__d2(__NN(_verify__dob_)))},
    {'Person','KELOtto.PersonFraudPoint','valid_ssn',COUNT(__d2(__NL(_valid__ssn_))),COUNT(__d2(__NN(_valid__ssn_)))},
    {'Person','KELOtto.PersonFraudPoint','nas_summary',COUNT(__d2(__NL(_nas__summary_))),COUNT(__d2(__NN(_nas__summary_)))},
    {'Person','KELOtto.PersonFraudPoint','nap_summary',COUNT(__d2(__NL(_nap__summary_))),COUNT(__d2(__NN(_nap__summary_)))},
    {'Person','KELOtto.PersonFraudPoint','cvi',COUNT(__d2(__NL(_cvi_))),COUNT(__d2(__NN(_cvi_)))},
    {'Person','KELOtto.PersonFraudPoint','additional_fname_1',COUNT(__d2(__NL(_additional__fname__1_))),COUNT(__d2(__NN(_additional__fname__1_)))},
    {'Person','KELOtto.PersonFraudPoint','additional_lname_1',COUNT(__d2(__NL(_additional__lname__1_))),COUNT(__d2(__NN(_additional__lname__1_)))},
    {'Person','KELOtto.PersonFraudPoint','additional_lname_date_last_1',COUNT(__d2(__NL(_additional__lname__date__last__1_))),COUNT(__d2(__NN(_additional__lname__date__last__1_)))},
    {'Person','KELOtto.PersonFraudPoint','additional_fname_2',COUNT(__d2(__NL(_additional__fname__2_))),COUNT(__d2(__NN(_additional__fname__2_)))},
    {'Person','KELOtto.PersonFraudPoint','additional_lname_2',COUNT(__d2(__NL(_additional__lname__2_))),COUNT(__d2(__NN(_additional__lname__2_)))},
    {'Person','KELOtto.PersonFraudPoint','additional_lname_date_last_2',COUNT(__d2(__NL(_additional__lname__date__last__2_))),COUNT(__d2(__NN(_additional__lname__date__last__2_)))},
    {'Person','KELOtto.PersonFraudPoint','additional_fname_3',COUNT(__d2(__NL(_additional__fname__3_))),COUNT(__d2(__NN(_additional__fname__3_)))},
    {'Person','KELOtto.PersonFraudPoint','additional_lname_3',COUNT(__d2(__NL(_additional__lname__3_))),COUNT(__d2(__NN(_additional__lname__3_)))},
    {'Person','KELOtto.PersonFraudPoint','additional_lname_date_last_3',COUNT(__d2(__NL(_additional__lname__date__last__3_))),COUNT(__d2(__NN(_additional__lname__date__last__3_)))},
    {'Person','KELOtto.PersonFraudPoint','subjectssncount',COUNT(__d2(__NL(_subjectssncount_))),COUNT(__d2(__NN(_subjectssncount_)))},
    {'Person','KELOtto.PersonFraudPoint','dobmatchlevel',COUNT(__d2(__NL(_dobmatchlevel_))),COUNT(__d2(__NN(_dobmatchlevel_)))},
    {'Person','KELOtto.PersonFraudPoint','Hri',COUNT(__d2(__NL(Hri_))),COUNT(__d2(__NN(Hri_)))},
    {'Person','KELOtto.PersonFraudPoint','ssnfoundforlexid',COUNT(__d2(__NL(_ssnfoundforlexid_))),COUNT(__d2(__NN(_ssnfoundforlexid_)))},
    {'Person','KELOtto.PersonFraudPoint','cvicustomscore',COUNT(__d2(__NL(_cvicustomscore_))),COUNT(__d2(__NN(_cvicustomscore_)))},
    {'Person','KELOtto.PersonFraudPoint','SubjectSsnCount',COUNT(__d2(__NL(Subject_Ssn_Count_))),COUNT(__d2(__NN(Subject_Ssn_Count_)))},
    {'Person','KELOtto.PersonFraudPoint','DateOfBirthMatchLevel',COUNT(__d2(__NL(Date_Of_Birth_Match_Level_))),COUNT(__d2(__NN(Date_Of_Birth_Match_Level_)))},
    {'Person','KELOtto.PersonFraudPoint','StolenIdentityIndex',COUNT(__d2(__NL(Stolen_Identity_Index_))),COUNT(__d2(__NN(Stolen_Identity_Index_)))},
    {'Person','KELOtto.PersonFraudPoint','SyntheticIdentityIndex',COUNT(__d2(__NL(Synthetic_Identity_Index_))),COUNT(__d2(__NN(Synthetic_Identity_Index_)))},
    {'Person','KELOtto.PersonFraudPoint','ManipulatedIdentityIndex',COUNT(__d2(__NL(Manipulated_Identity_Index_))),COUNT(__d2(__NN(Manipulated_Identity_Index_)))},
    {'Person','KELOtto.PersonFraudPoint','VulnerableVictimIndex',COUNT(__d2(__NL(Vulnerable_Victim_Index_))),COUNT(__d2(__NN(Vulnerable_Victim_Index_)))},
    {'Person','KELOtto.PersonFraudPoint','FriendlyfraudIndex',COUNT(__d2(__NL(Friendlyfraud_Index_))),COUNT(__d2(__NN(Friendlyfraud_Index_)))},
    {'Person','KELOtto.PersonFraudPoint','SuspiciousActivityIndex',COUNT(__d2(__NL(Suspicious_Activity_Index_))),COUNT(__d2(__NN(Suspicious_Activity_Index_)))},
    {'Person','KELOtto.PersonFraudPoint','v2_sourcerisklevel',COUNT(__d2(__NL(_v2__sourcerisklevel_))),COUNT(__d2(__NN(_v2__sourcerisklevel_)))},
    {'Person','KELOtto.PersonFraudPoint','v2_assocsuspicousidentitiescount',COUNT(__d2(__NL(_v2__assocsuspicousidentitiescount_))),COUNT(__d2(__NN(_v2__assocsuspicousidentitiescount_)))},
    {'Person','KELOtto.PersonFraudPoint','v2_assoccreditbureauonlycount',COUNT(__d2(__NL(_v2__assoccreditbureauonlycount_))),COUNT(__d2(__NN(_v2__assoccreditbureauonlycount_)))},
    {'Person','KELOtto.PersonFraudPoint','v2_validationaddrproblems',COUNT(__d2(__NL(_v2__validationaddrproblems_))),COUNT(__d2(__NN(_v2__validationaddrproblems_)))},
    {'Person','KELOtto.PersonFraudPoint','v2_inputaddrageoldest',COUNT(__d2(__NL(_v2__inputaddrageoldest_))),COUNT(__d2(__NN(_v2__inputaddrageoldest_)))},
    {'Person','KELOtto.PersonFraudPoint','v2_inputaddrdwelltype',COUNT(__d2(__NL(_v2__inputaddrdwelltype_))),COUNT(__d2(__NN(_v2__inputaddrdwelltype_)))},
    {'Person','KELOtto.PersonFraudPoint','v2_divssnidentitycountnew',COUNT(__d2(__NL(_v2__divssnidentitycountnew_))),COUNT(__d2(__NN(_v2__divssnidentitycountnew_)))},
    {'Person','KELOtto.PersonFraudPoint','DeceasedDate',COUNT(__d2(__NL(Deceased_Date_))),COUNT(__d2(__NN(Deceased_Date_)))},
    {'Person','KELOtto.PersonFraudPoint','DeceasedDateOfBirth',COUNT(__d2(__NL(Deceased_Date_Of_Birth_))),COUNT(__d2(__NN(Deceased_Date_Of_Birth_)))},
    {'Person','KELOtto.PersonFraudPoint','DeceasedFirst',COUNT(__d2(__NL(Deceased_First_))),COUNT(__d2(__NN(Deceased_First_)))},
    {'Person','KELOtto.PersonFraudPoint','DeceasedMiddle',COUNT(__d2(__NL(Deceased_Middle_))),COUNT(__d2(__NN(Deceased_Middle_)))},
    {'Person','KELOtto.PersonFraudPoint','DeceasedLast',COUNT(__d2(__NL(Deceased_Last_))),COUNT(__d2(__NN(Deceased_Last_)))},
    {'Person','KELOtto.PersonFraudPoint','DeceasedMatchCode',COUNT(__d2(__NL(Deceased_Match_Code_))),COUNT(__d2(__NN(Deceased_Match_Code_)))},
    {'Person','KELOtto.PersonFraudPoint','isdeepdive',COUNT(__d2(__NL(_isdeepdive_))),COUNT(__d2(__NN(_isdeepdive_)))},
    {'Person','KELOtto.PersonFraudPoint','county_death',COUNT(__d2(__NL(_county__death_))),COUNT(__d2(__NN(_county__death_)))},
    {'Person','KELOtto.PersonFraudPoint','DeceasedSsn',COUNT(__d2(__NL(Deceased_Ssn_))),COUNT(__d2(__NN(Deceased_Ssn_)))},
    {'Person','KELOtto.PersonFraudPoint','state_death_flag',COUNT(__d2(__NL(_state__death__flag_))),COUNT(__d2(__NN(_state__death__flag_)))},
    {'Person','KELOtto.PersonFraudPoint','death_rec_src',COUNT(__d2(__NL(_death__rec__src_))),COUNT(__d2(__NN(_death__rec__src_)))},
    {'Person','KELOtto.PersonFraudPoint','state_death_id',COUNT(__d2(__NL(_state__death__id_))),COUNT(__d2(__NN(_state__death__id_)))},
    {'Person','KELOtto.PersonFraudPoint','curr_incar_flag',COUNT(__d2(__NL(_curr__incar__flag_))),COUNT(__d2(__NN(_curr__incar__flag_)))},
    {'Person','KELOtto.PersonFraudPoint','off_cat_list',COUNT(__d2(__NL(_off__cat__list_))),COUNT(__d2(__NN(_off__cat__list_)))},
    {'Person','KELOtto.PersonFraudPoint','name_ssn_dob_match',COUNT(__d2(__NL(_name__ssn__dob__match_))),COUNT(__d2(__NN(_name__ssn__dob__match_)))},
    {'Person','KELOtto.PersonFraudPoint','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Person','KELOtto.PersonFraudPoint','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Person','KELOtto.PersonDeceased','UID',COUNT(KELOtto_PersonDeceased_Invalid),COUNT(__d3)},
    {'Person','KELOtto.PersonDeceased','AssociatedCustomerFileInfo',COUNT(__d3(__NL(_r_Customer_))),COUNT(__d3(__NN(_r_Customer_)))},
    {'Person','KELOtto.PersonDeceased','SourceCustomerFileInfo',COUNT(__d3(__NL(_r_Source_Customer_))),COUNT(__d3(__NN(_r_Source_Customer_)))},
    {'Person','KELOtto.PersonDeceased','did',COUNT(__d3(__NL(Lex_Id_))),COUNT(__d3(__NN(Lex_Id_)))},
    {'Person','KELOtto.PersonDeceased','DateOfBirth',COUNT(__d3(__NL(Date_Of_Birth_))),COUNT(__d3(__NN(Date_Of_Birth_)))},
    {'Person','KELOtto.PersonDeceased','Title',COUNT(__d3(__NL(Title_))),COUNT(__d3(__NN(Title_)))},
    {'Person','KELOtto.PersonDeceased','FirstName',COUNT(__d3(__NL(First_Name_))),COUNT(__d3(__NN(First_Name_)))},
    {'Person','KELOtto.PersonDeceased','MiddleName',COUNT(__d3(__NL(Middle_Name_))),COUNT(__d3(__NN(Middle_Name_)))},
    {'Person','KELOtto.PersonDeceased','LastName',COUNT(__d3(__NL(Last_Name_))),COUNT(__d3(__NN(Last_Name_)))},
    {'Person','KELOtto.PersonDeceased','NameSuffix',COUNT(__d3(__NL(Name_Suffix_))),COUNT(__d3(__NN(Name_Suffix_)))},
    {'Person','KELOtto.PersonDeceased','verfirst',COUNT(__d3(__NL(_verfirst_))),COUNT(__d3(__NN(_verfirst_)))},
    {'Person','KELOtto.PersonDeceased','verlast',COUNT(__d3(__NL(_verlast_))),COUNT(__d3(__NN(_verlast_)))},
    {'Person','KELOtto.PersonDeceased','veraddr',COUNT(__d3(__NL(_veraddr_))),COUNT(__d3(__NN(_veraddr_)))},
    {'Person','KELOtto.PersonDeceased','vercity',COUNT(__d3(__NL(_vercity_))),COUNT(__d3(__NN(_vercity_)))},
    {'Person','KELOtto.PersonDeceased','verstate',COUNT(__d3(__NL(_verstate_))),COUNT(__d3(__NN(_verstate_)))},
    {'Person','KELOtto.PersonDeceased','verzip',COUNT(__d3(__NL(_verzip_))),COUNT(__d3(__NN(_verzip_)))},
    {'Person','KELOtto.PersonDeceased','verzip4',COUNT(__d3(__NL(_verzip4_))),COUNT(__d3(__NN(_verzip4_)))},
    {'Person','KELOtto.PersonDeceased','verssn',COUNT(__d3(__NL(_verssn_))),COUNT(__d3(__NN(_verssn_)))},
    {'Person','KELOtto.PersonDeceased','verdob',COUNT(__d3(__NL(_verdob_))),COUNT(__d3(__NN(_verdob_)))},
    {'Person','KELOtto.PersonDeceased','verhphone',COUNT(__d3(__NL(_verhphone_))),COUNT(__d3(__NN(_verhphone_)))},
    {'Person','KELOtto.PersonDeceased','verify_addr',COUNT(__d3(__NL(_verify__addr_))),COUNT(__d3(__NN(_verify__addr_)))},
    {'Person','KELOtto.PersonDeceased','verify_dob',COUNT(__d3(__NL(_verify__dob_))),COUNT(__d3(__NN(_verify__dob_)))},
    {'Person','KELOtto.PersonDeceased','valid_ssn',COUNT(__d3(__NL(_valid__ssn_))),COUNT(__d3(__NN(_valid__ssn_)))},
    {'Person','KELOtto.PersonDeceased','nas_summary',COUNT(__d3(__NL(_nas__summary_))),COUNT(__d3(__NN(_nas__summary_)))},
    {'Person','KELOtto.PersonDeceased','nap_summary',COUNT(__d3(__NL(_nap__summary_))),COUNT(__d3(__NN(_nap__summary_)))},
    {'Person','KELOtto.PersonDeceased','cvi',COUNT(__d3(__NL(_cvi_))),COUNT(__d3(__NN(_cvi_)))},
    {'Person','KELOtto.PersonDeceased','additional_fname_1',COUNT(__d3(__NL(_additional__fname__1_))),COUNT(__d3(__NN(_additional__fname__1_)))},
    {'Person','KELOtto.PersonDeceased','additional_lname_1',COUNT(__d3(__NL(_additional__lname__1_))),COUNT(__d3(__NN(_additional__lname__1_)))},
    {'Person','KELOtto.PersonDeceased','additional_lname_date_last_1',COUNT(__d3(__NL(_additional__lname__date__last__1_))),COUNT(__d3(__NN(_additional__lname__date__last__1_)))},
    {'Person','KELOtto.PersonDeceased','additional_fname_2',COUNT(__d3(__NL(_additional__fname__2_))),COUNT(__d3(__NN(_additional__fname__2_)))},
    {'Person','KELOtto.PersonDeceased','additional_lname_2',COUNT(__d3(__NL(_additional__lname__2_))),COUNT(__d3(__NN(_additional__lname__2_)))},
    {'Person','KELOtto.PersonDeceased','additional_lname_date_last_2',COUNT(__d3(__NL(_additional__lname__date__last__2_))),COUNT(__d3(__NN(_additional__lname__date__last__2_)))},
    {'Person','KELOtto.PersonDeceased','additional_fname_3',COUNT(__d3(__NL(_additional__fname__3_))),COUNT(__d3(__NN(_additional__fname__3_)))},
    {'Person','KELOtto.PersonDeceased','additional_lname_3',COUNT(__d3(__NL(_additional__lname__3_))),COUNT(__d3(__NN(_additional__lname__3_)))},
    {'Person','KELOtto.PersonDeceased','additional_lname_date_last_3',COUNT(__d3(__NL(_additional__lname__date__last__3_))),COUNT(__d3(__NN(_additional__lname__date__last__3_)))},
    {'Person','KELOtto.PersonDeceased','subjectssncount',COUNT(__d3(__NL(_subjectssncount_))),COUNT(__d3(__NN(_subjectssncount_)))},
    {'Person','KELOtto.PersonDeceased','dobmatchlevel',COUNT(__d3(__NL(_dobmatchlevel_))),COUNT(__d3(__NN(_dobmatchlevel_)))},
    {'Person','KELOtto.PersonDeceased','Hri',COUNT(__d3(__NL(Hri_))),COUNT(__d3(__NN(Hri_)))},
    {'Person','KELOtto.PersonDeceased','ssnfoundforlexid',COUNT(__d3(__NL(_ssnfoundforlexid_))),COUNT(__d3(__NN(_ssnfoundforlexid_)))},
    {'Person','KELOtto.PersonDeceased','cvicustomscore',COUNT(__d3(__NL(_cvicustomscore_))),COUNT(__d3(__NN(_cvicustomscore_)))},
    {'Person','KELOtto.PersonDeceased','SubjectSsnCount',COUNT(__d3(__NL(Subject_Ssn_Count_))),COUNT(__d3(__NN(Subject_Ssn_Count_)))},
    {'Person','KELOtto.PersonDeceased','DateOfBirthMatchLevel',COUNT(__d3(__NL(Date_Of_Birth_Match_Level_))),COUNT(__d3(__NN(Date_Of_Birth_Match_Level_)))},
    {'Person','KELOtto.PersonDeceased','StolenIdentityIndex',COUNT(__d3(__NL(Stolen_Identity_Index_))),COUNT(__d3(__NN(Stolen_Identity_Index_)))},
    {'Person','KELOtto.PersonDeceased','SyntheticIdentityIndex',COUNT(__d3(__NL(Synthetic_Identity_Index_))),COUNT(__d3(__NN(Synthetic_Identity_Index_)))},
    {'Person','KELOtto.PersonDeceased','ManipulatedIdentityIndex',COUNT(__d3(__NL(Manipulated_Identity_Index_))),COUNT(__d3(__NN(Manipulated_Identity_Index_)))},
    {'Person','KELOtto.PersonDeceased','VulnerableVictimIndex',COUNT(__d3(__NL(Vulnerable_Victim_Index_))),COUNT(__d3(__NN(Vulnerable_Victim_Index_)))},
    {'Person','KELOtto.PersonDeceased','FriendlyfraudIndex',COUNT(__d3(__NL(Friendlyfraud_Index_))),COUNT(__d3(__NN(Friendlyfraud_Index_)))},
    {'Person','KELOtto.PersonDeceased','SuspiciousActivityIndex',COUNT(__d3(__NL(Suspicious_Activity_Index_))),COUNT(__d3(__NN(Suspicious_Activity_Index_)))},
    {'Person','KELOtto.PersonDeceased','v2_sourcerisklevel',COUNT(__d3(__NL(_v2__sourcerisklevel_))),COUNT(__d3(__NN(_v2__sourcerisklevel_)))},
    {'Person','KELOtto.PersonDeceased','v2_assocsuspicousidentitiescount',COUNT(__d3(__NL(_v2__assocsuspicousidentitiescount_))),COUNT(__d3(__NN(_v2__assocsuspicousidentitiescount_)))},
    {'Person','KELOtto.PersonDeceased','v2_assoccreditbureauonlycount',COUNT(__d3(__NL(_v2__assoccreditbureauonlycount_))),COUNT(__d3(__NN(_v2__assoccreditbureauonlycount_)))},
    {'Person','KELOtto.PersonDeceased','v2_validationaddrproblems',COUNT(__d3(__NL(_v2__validationaddrproblems_))),COUNT(__d3(__NN(_v2__validationaddrproblems_)))},
    {'Person','KELOtto.PersonDeceased','v2_inputaddrageoldest',COUNT(__d3(__NL(_v2__inputaddrageoldest_))),COUNT(__d3(__NN(_v2__inputaddrageoldest_)))},
    {'Person','KELOtto.PersonDeceased','v2_inputaddrdwelltype',COUNT(__d3(__NL(_v2__inputaddrdwelltype_))),COUNT(__d3(__NN(_v2__inputaddrdwelltype_)))},
    {'Person','KELOtto.PersonDeceased','v2_divssnidentitycountnew',COUNT(__d3(__NL(_v2__divssnidentitycountnew_))),COUNT(__d3(__NN(_v2__divssnidentitycountnew_)))},
    {'Person','KELOtto.PersonDeceased','dod8',COUNT(__d3(__NL(Deceased_Date_))),COUNT(__d3(__NN(Deceased_Date_)))},
    {'Person','KELOtto.PersonDeceased','dob8',COUNT(__d3(__NL(Deceased_Date_Of_Birth_))),COUNT(__d3(__NN(Deceased_Date_Of_Birth_)))},
    {'Person','KELOtto.PersonDeceased','fname',COUNT(__d3(__NL(Deceased_First_))),COUNT(__d3(__NN(Deceased_First_)))},
    {'Person','KELOtto.PersonDeceased','mname',COUNT(__d3(__NL(Deceased_Middle_))),COUNT(__d3(__NN(Deceased_Middle_)))},
    {'Person','KELOtto.PersonDeceased','lname',COUNT(__d3(__NL(Deceased_Last_))),COUNT(__d3(__NN(Deceased_Last_)))},
    {'Person','KELOtto.PersonDeceased','matchcode',COUNT(__d3(__NL(Deceased_Match_Code_))),COUNT(__d3(__NN(Deceased_Match_Code_)))},
    {'Person','KELOtto.PersonDeceased','isdeepdive',COUNT(__d3(__NL(_isdeepdive_))),COUNT(__d3(__NN(_isdeepdive_)))},
    {'Person','KELOtto.PersonDeceased','county_death',COUNT(__d3(__NL(_county__death_))),COUNT(__d3(__NN(_county__death_)))},
    {'Person','KELOtto.PersonDeceased','ssn',COUNT(__d3(__NL(Deceased_Ssn_))),COUNT(__d3(__NN(Deceased_Ssn_)))},
    {'Person','KELOtto.PersonDeceased','state_death_flag',COUNT(__d3(__NL(_state__death__flag_))),COUNT(__d3(__NN(_state__death__flag_)))},
    {'Person','KELOtto.PersonDeceased','death_rec_src',COUNT(__d3(__NL(_death__rec__src_))),COUNT(__d3(__NN(_death__rec__src_)))},
    {'Person','KELOtto.PersonDeceased','state_death_id',COUNT(__d3(__NL(_state__death__id_))),COUNT(__d3(__NN(_state__death__id_)))},
    {'Person','KELOtto.PersonDeceased','curr_incar_flag',COUNT(__d3(__NL(_curr__incar__flag_))),COUNT(__d3(__NN(_curr__incar__flag_)))},
    {'Person','KELOtto.PersonDeceased','off_cat_list',COUNT(__d3(__NL(_off__cat__list_))),COUNT(__d3(__NN(_off__cat__list_)))},
    {'Person','KELOtto.PersonDeceased','name_ssn_dob_match',COUNT(__d3(__NL(_name__ssn__dob__match_))),COUNT(__d3(__NN(_name__ssn__dob__match_)))},
    {'Person','KELOtto.PersonDeceased','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Person','KELOtto.PersonDeceased','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Person','KELOtto.PersonCrim','UID',COUNT(KELOtto_PersonCrim_Invalid),COUNT(__d4)},
    {'Person','KELOtto.PersonCrim','AssociatedCustomerFileInfo',COUNT(__d4(__NL(_r_Customer_))),COUNT(__d4(__NN(_r_Customer_)))},
    {'Person','KELOtto.PersonCrim','SourceCustomerFileInfo',COUNT(__d4(__NL(_r_Source_Customer_))),COUNT(__d4(__NN(_r_Source_Customer_)))},
    {'Person','KELOtto.PersonCrim','did',COUNT(__d4(__NL(Lex_Id_))),COUNT(__d4(__NN(Lex_Id_)))},
    {'Person','KELOtto.PersonCrim','DateOfBirth',COUNT(__d4(__NL(Date_Of_Birth_))),COUNT(__d4(__NN(Date_Of_Birth_)))},
    {'Person','KELOtto.PersonCrim','Title',COUNT(__d4(__NL(Title_))),COUNT(__d4(__NN(Title_)))},
    {'Person','KELOtto.PersonCrim','FirstName',COUNT(__d4(__NL(First_Name_))),COUNT(__d4(__NN(First_Name_)))},
    {'Person','KELOtto.PersonCrim','MiddleName',COUNT(__d4(__NL(Middle_Name_))),COUNT(__d4(__NN(Middle_Name_)))},
    {'Person','KELOtto.PersonCrim','LastName',COUNT(__d4(__NL(Last_Name_))),COUNT(__d4(__NN(Last_Name_)))},
    {'Person','KELOtto.PersonCrim','NameSuffix',COUNT(__d4(__NL(Name_Suffix_))),COUNT(__d4(__NN(Name_Suffix_)))},
    {'Person','KELOtto.PersonCrim','verfirst',COUNT(__d4(__NL(_verfirst_))),COUNT(__d4(__NN(_verfirst_)))},
    {'Person','KELOtto.PersonCrim','verlast',COUNT(__d4(__NL(_verlast_))),COUNT(__d4(__NN(_verlast_)))},
    {'Person','KELOtto.PersonCrim','veraddr',COUNT(__d4(__NL(_veraddr_))),COUNT(__d4(__NN(_veraddr_)))},
    {'Person','KELOtto.PersonCrim','vercity',COUNT(__d4(__NL(_vercity_))),COUNT(__d4(__NN(_vercity_)))},
    {'Person','KELOtto.PersonCrim','verstate',COUNT(__d4(__NL(_verstate_))),COUNT(__d4(__NN(_verstate_)))},
    {'Person','KELOtto.PersonCrim','verzip',COUNT(__d4(__NL(_verzip_))),COUNT(__d4(__NN(_verzip_)))},
    {'Person','KELOtto.PersonCrim','verzip4',COUNT(__d4(__NL(_verzip4_))),COUNT(__d4(__NN(_verzip4_)))},
    {'Person','KELOtto.PersonCrim','verssn',COUNT(__d4(__NL(_verssn_))),COUNT(__d4(__NN(_verssn_)))},
    {'Person','KELOtto.PersonCrim','verdob',COUNT(__d4(__NL(_verdob_))),COUNT(__d4(__NN(_verdob_)))},
    {'Person','KELOtto.PersonCrim','verhphone',COUNT(__d4(__NL(_verhphone_))),COUNT(__d4(__NN(_verhphone_)))},
    {'Person','KELOtto.PersonCrim','verify_addr',COUNT(__d4(__NL(_verify__addr_))),COUNT(__d4(__NN(_verify__addr_)))},
    {'Person','KELOtto.PersonCrim','verify_dob',COUNT(__d4(__NL(_verify__dob_))),COUNT(__d4(__NN(_verify__dob_)))},
    {'Person','KELOtto.PersonCrim','valid_ssn',COUNT(__d4(__NL(_valid__ssn_))),COUNT(__d4(__NN(_valid__ssn_)))},
    {'Person','KELOtto.PersonCrim','nas_summary',COUNT(__d4(__NL(_nas__summary_))),COUNT(__d4(__NN(_nas__summary_)))},
    {'Person','KELOtto.PersonCrim','nap_summary',COUNT(__d4(__NL(_nap__summary_))),COUNT(__d4(__NN(_nap__summary_)))},
    {'Person','KELOtto.PersonCrim','cvi',COUNT(__d4(__NL(_cvi_))),COUNT(__d4(__NN(_cvi_)))},
    {'Person','KELOtto.PersonCrim','additional_fname_1',COUNT(__d4(__NL(_additional__fname__1_))),COUNT(__d4(__NN(_additional__fname__1_)))},
    {'Person','KELOtto.PersonCrim','additional_lname_1',COUNT(__d4(__NL(_additional__lname__1_))),COUNT(__d4(__NN(_additional__lname__1_)))},
    {'Person','KELOtto.PersonCrim','additional_lname_date_last_1',COUNT(__d4(__NL(_additional__lname__date__last__1_))),COUNT(__d4(__NN(_additional__lname__date__last__1_)))},
    {'Person','KELOtto.PersonCrim','additional_fname_2',COUNT(__d4(__NL(_additional__fname__2_))),COUNT(__d4(__NN(_additional__fname__2_)))},
    {'Person','KELOtto.PersonCrim','additional_lname_2',COUNT(__d4(__NL(_additional__lname__2_))),COUNT(__d4(__NN(_additional__lname__2_)))},
    {'Person','KELOtto.PersonCrim','additional_lname_date_last_2',COUNT(__d4(__NL(_additional__lname__date__last__2_))),COUNT(__d4(__NN(_additional__lname__date__last__2_)))},
    {'Person','KELOtto.PersonCrim','additional_fname_3',COUNT(__d4(__NL(_additional__fname__3_))),COUNT(__d4(__NN(_additional__fname__3_)))},
    {'Person','KELOtto.PersonCrim','additional_lname_3',COUNT(__d4(__NL(_additional__lname__3_))),COUNT(__d4(__NN(_additional__lname__3_)))},
    {'Person','KELOtto.PersonCrim','additional_lname_date_last_3',COUNT(__d4(__NL(_additional__lname__date__last__3_))),COUNT(__d4(__NN(_additional__lname__date__last__3_)))},
    {'Person','KELOtto.PersonCrim','subjectssncount',COUNT(__d4(__NL(_subjectssncount_))),COUNT(__d4(__NN(_subjectssncount_)))},
    {'Person','KELOtto.PersonCrim','dobmatchlevel',COUNT(__d4(__NL(_dobmatchlevel_))),COUNT(__d4(__NN(_dobmatchlevel_)))},
    {'Person','KELOtto.PersonCrim','Hri',COUNT(__d4(__NL(Hri_))),COUNT(__d4(__NN(Hri_)))},
    {'Person','KELOtto.PersonCrim','ssnfoundforlexid',COUNT(__d4(__NL(_ssnfoundforlexid_))),COUNT(__d4(__NN(_ssnfoundforlexid_)))},
    {'Person','KELOtto.PersonCrim','cvicustomscore',COUNT(__d4(__NL(_cvicustomscore_))),COUNT(__d4(__NN(_cvicustomscore_)))},
    {'Person','KELOtto.PersonCrim','SubjectSsnCount',COUNT(__d4(__NL(Subject_Ssn_Count_))),COUNT(__d4(__NN(Subject_Ssn_Count_)))},
    {'Person','KELOtto.PersonCrim','DateOfBirthMatchLevel',COUNT(__d4(__NL(Date_Of_Birth_Match_Level_))),COUNT(__d4(__NN(Date_Of_Birth_Match_Level_)))},
    {'Person','KELOtto.PersonCrim','StolenIdentityIndex',COUNT(__d4(__NL(Stolen_Identity_Index_))),COUNT(__d4(__NN(Stolen_Identity_Index_)))},
    {'Person','KELOtto.PersonCrim','SyntheticIdentityIndex',COUNT(__d4(__NL(Synthetic_Identity_Index_))),COUNT(__d4(__NN(Synthetic_Identity_Index_)))},
    {'Person','KELOtto.PersonCrim','ManipulatedIdentityIndex',COUNT(__d4(__NL(Manipulated_Identity_Index_))),COUNT(__d4(__NN(Manipulated_Identity_Index_)))},
    {'Person','KELOtto.PersonCrim','VulnerableVictimIndex',COUNT(__d4(__NL(Vulnerable_Victim_Index_))),COUNT(__d4(__NN(Vulnerable_Victim_Index_)))},
    {'Person','KELOtto.PersonCrim','FriendlyfraudIndex',COUNT(__d4(__NL(Friendlyfraud_Index_))),COUNT(__d4(__NN(Friendlyfraud_Index_)))},
    {'Person','KELOtto.PersonCrim','SuspiciousActivityIndex',COUNT(__d4(__NL(Suspicious_Activity_Index_))),COUNT(__d4(__NN(Suspicious_Activity_Index_)))},
    {'Person','KELOtto.PersonCrim','v2_sourcerisklevel',COUNT(__d4(__NL(_v2__sourcerisklevel_))),COUNT(__d4(__NN(_v2__sourcerisklevel_)))},
    {'Person','KELOtto.PersonCrim','v2_assocsuspicousidentitiescount',COUNT(__d4(__NL(_v2__assocsuspicousidentitiescount_))),COUNT(__d4(__NN(_v2__assocsuspicousidentitiescount_)))},
    {'Person','KELOtto.PersonCrim','v2_assoccreditbureauonlycount',COUNT(__d4(__NL(_v2__assoccreditbureauonlycount_))),COUNT(__d4(__NN(_v2__assoccreditbureauonlycount_)))},
    {'Person','KELOtto.PersonCrim','v2_validationaddrproblems',COUNT(__d4(__NL(_v2__validationaddrproblems_))),COUNT(__d4(__NN(_v2__validationaddrproblems_)))},
    {'Person','KELOtto.PersonCrim','v2_inputaddrageoldest',COUNT(__d4(__NL(_v2__inputaddrageoldest_))),COUNT(__d4(__NN(_v2__inputaddrageoldest_)))},
    {'Person','KELOtto.PersonCrim','v2_inputaddrdwelltype',COUNT(__d4(__NL(_v2__inputaddrdwelltype_))),COUNT(__d4(__NN(_v2__inputaddrdwelltype_)))},
    {'Person','KELOtto.PersonCrim','v2_divssnidentitycountnew',COUNT(__d4(__NL(_v2__divssnidentitycountnew_))),COUNT(__d4(__NN(_v2__divssnidentitycountnew_)))},
    {'Person','KELOtto.PersonCrim','DeceasedDate',COUNT(__d4(__NL(Deceased_Date_))),COUNT(__d4(__NN(Deceased_Date_)))},
    {'Person','KELOtto.PersonCrim','DeceasedDateOfBirth',COUNT(__d4(__NL(Deceased_Date_Of_Birth_))),COUNT(__d4(__NN(Deceased_Date_Of_Birth_)))},
    {'Person','KELOtto.PersonCrim','DeceasedFirst',COUNT(__d4(__NL(Deceased_First_))),COUNT(__d4(__NN(Deceased_First_)))},
    {'Person','KELOtto.PersonCrim','DeceasedMiddle',COUNT(__d4(__NL(Deceased_Middle_))),COUNT(__d4(__NN(Deceased_Middle_)))},
    {'Person','KELOtto.PersonCrim','DeceasedLast',COUNT(__d4(__NL(Deceased_Last_))),COUNT(__d4(__NN(Deceased_Last_)))},
    {'Person','KELOtto.PersonCrim','DeceasedMatchCode',COUNT(__d4(__NL(Deceased_Match_Code_))),COUNT(__d4(__NN(Deceased_Match_Code_)))},
    {'Person','KELOtto.PersonCrim','isdeepdive',COUNT(__d4(__NL(_isdeepdive_))),COUNT(__d4(__NN(_isdeepdive_)))},
    {'Person','KELOtto.PersonCrim','county_death',COUNT(__d4(__NL(_county__death_))),COUNT(__d4(__NN(_county__death_)))},
    {'Person','KELOtto.PersonCrim','DeceasedSsn',COUNT(__d4(__NL(Deceased_Ssn_))),COUNT(__d4(__NN(Deceased_Ssn_)))},
    {'Person','KELOtto.PersonCrim','state_death_flag',COUNT(__d4(__NL(_state__death__flag_))),COUNT(__d4(__NN(_state__death__flag_)))},
    {'Person','KELOtto.PersonCrim','death_rec_src',COUNT(__d4(__NL(_death__rec__src_))),COUNT(__d4(__NN(_death__rec__src_)))},
    {'Person','KELOtto.PersonCrim','state_death_id',COUNT(__d4(__NL(_state__death__id_))),COUNT(__d4(__NN(_state__death__id_)))},
    {'Person','KELOtto.PersonCrim','curr_incar_flag',COUNT(__d4(__NL(_curr__incar__flag_))),COUNT(__d4(__NN(_curr__incar__flag_)))},
    {'Person','KELOtto.PersonCrim','off_cat_list',COUNT(__d4(__NL(_off__cat__list_))),COUNT(__d4(__NN(_off__cat__list_)))},
    {'Person','KELOtto.PersonCrim','name_ssn_dob_match',COUNT(__d4(__NL(_name__ssn__dob__match_))),COUNT(__d4(__NN(_name__ssn__dob__match_)))},
    {'Person','KELOtto.PersonCrim','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Person','KELOtto.PersonCrim','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
