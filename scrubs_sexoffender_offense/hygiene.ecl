IMPORT ut,SALT33;
EXPORT hygiene(dataset(layout_sexoffender_offense) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.orig_state_code);    NumberOfRecords := COUNT(GROUP);
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_state_code_pcnt := AVE(GROUP,IF(h.orig_state_code = (TYPEOF(h.orig_state_code))'',0,100));
    maxlength_orig_state_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state_code)));
    avelength_orig_state_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state_code)),h.orig_state_code<>(typeof(h.orig_state_code))'');
    populated_vendor_code_pcnt := AVE(GROUP,IF(h.vendor_code = (TYPEOF(h.vendor_code))'',0,100));
    maxlength_vendor_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_code)));
    avelength_vendor_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_code)),h.vendor_code<>(typeof(h.vendor_code))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_seisint_primary_key_pcnt := AVE(GROUP,IF(h.seisint_primary_key = (TYPEOF(h.seisint_primary_key))'',0,100));
    maxlength_seisint_primary_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.seisint_primary_key)));
    avelength_seisint_primary_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.seisint_primary_key)),h.seisint_primary_key<>(typeof(h.seisint_primary_key))'');
    populated_conviction_jurisdiction_pcnt := AVE(GROUP,IF(h.conviction_jurisdiction = (TYPEOF(h.conviction_jurisdiction))'',0,100));
    maxlength_conviction_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_jurisdiction)));
    avelength_conviction_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_jurisdiction)),h.conviction_jurisdiction<>(typeof(h.conviction_jurisdiction))'');
    populated_conviction_date_pcnt := AVE(GROUP,IF(h.conviction_date = (TYPEOF(h.conviction_date))'',0,100));
    maxlength_conviction_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_date)));
    avelength_conviction_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_date)),h.conviction_date<>(typeof(h.conviction_date))'');
    populated_court_pcnt := AVE(GROUP,IF(h.court = (TYPEOF(h.court))'',0,100));
    maxlength_court := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.court)));
    avelength_court := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.court)),h.court<>(typeof(h.court))'');
    populated_court_case_number_pcnt := AVE(GROUP,IF(h.court_case_number = (TYPEOF(h.court_case_number))'',0,100));
    maxlength_court_case_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.court_case_number)));
    avelength_court_case_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.court_case_number)),h.court_case_number<>(typeof(h.court_case_number))'');
    populated_offense_date_pcnt := AVE(GROUP,IF(h.offense_date = (TYPEOF(h.offense_date))'',0,100));
    maxlength_offense_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_date)));
    avelength_offense_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_date)),h.offense_date<>(typeof(h.offense_date))'');
    populated_offense_code_or_statute_pcnt := AVE(GROUP,IF(h.offense_code_or_statute = (TYPEOF(h.offense_code_or_statute))'',0,100));
    maxlength_offense_code_or_statute := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_code_or_statute)));
    avelength_offense_code_or_statute := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_code_or_statute)),h.offense_code_or_statute<>(typeof(h.offense_code_or_statute))'');
    populated_offense_description_pcnt := AVE(GROUP,IF(h.offense_description = (TYPEOF(h.offense_description))'',0,100));
    maxlength_offense_description := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_description)));
    avelength_offense_description := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_description)),h.offense_description<>(typeof(h.offense_description))'');
    populated_offense_description_2_pcnt := AVE(GROUP,IF(h.offense_description_2 = (TYPEOF(h.offense_description_2))'',0,100));
    maxlength_offense_description_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_description_2)));
    avelength_offense_description_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_description_2)),h.offense_description_2<>(typeof(h.offense_description_2))'');
    populated_offense_category_pcnt := AVE(GROUP,IF(h.offense_category = (TYPEOF(h.offense_category))'',0,100));
    maxlength_offense_category := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_category)));
    avelength_offense_category := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_category)),h.offense_category<>(typeof(h.offense_category))'');
    populated_victim_minor_pcnt := AVE(GROUP,IF(h.victim_minor = (TYPEOF(h.victim_minor))'',0,100));
    maxlength_victim_minor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.victim_minor)));
    avelength_victim_minor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.victim_minor)),h.victim_minor<>(typeof(h.victim_minor))'');
    populated_victim_age_pcnt := AVE(GROUP,IF(h.victim_age = (TYPEOF(h.victim_age))'',0,100));
    maxlength_victim_age := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.victim_age)));
    avelength_victim_age := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.victim_age)),h.victim_age<>(typeof(h.victim_age))'');
    populated_victim_gender_pcnt := AVE(GROUP,IF(h.victim_gender = (TYPEOF(h.victim_gender))'',0,100));
    maxlength_victim_gender := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.victim_gender)));
    avelength_victim_gender := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.victim_gender)),h.victim_gender<>(typeof(h.victim_gender))'');
    populated_victim_relationship_pcnt := AVE(GROUP,IF(h.victim_relationship = (TYPEOF(h.victim_relationship))'',0,100));
    maxlength_victim_relationship := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.victim_relationship)));
    avelength_victim_relationship := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.victim_relationship)),h.victim_relationship<>(typeof(h.victim_relationship))'');
    populated_sentence_description_pcnt := AVE(GROUP,IF(h.sentence_description = (TYPEOF(h.sentence_description))'',0,100));
    maxlength_sentence_description := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentence_description)));
    avelength_sentence_description := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentence_description)),h.sentence_description<>(typeof(h.sentence_description))'');
    populated_sentence_description_2_pcnt := AVE(GROUP,IF(h.sentence_description_2 = (TYPEOF(h.sentence_description_2))'',0,100));
    maxlength_sentence_description_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentence_description_2)));
    avelength_sentence_description_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentence_description_2)),h.sentence_description_2<>(typeof(h.sentence_description_2))'');
    populated_arrest_date_pcnt := AVE(GROUP,IF(h.arrest_date = (TYPEOF(h.arrest_date))'',0,100));
    maxlength_arrest_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.arrest_date)));
    avelength_arrest_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.arrest_date)),h.arrest_date<>(typeof(h.arrest_date))'');
    populated_arrest_warrant_pcnt := AVE(GROUP,IF(h.arrest_warrant = (TYPEOF(h.arrest_warrant))'',0,100));
    maxlength_arrest_warrant := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.arrest_warrant)));
    avelength_arrest_warrant := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.arrest_warrant)),h.arrest_warrant<>(typeof(h.arrest_warrant))'');
    populated_fcra_conviction_flag_pcnt := AVE(GROUP,IF(h.fcra_conviction_flag = (TYPEOF(h.fcra_conviction_flag))'',0,100));
    maxlength_fcra_conviction_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_conviction_flag)));
    avelength_fcra_conviction_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_conviction_flag)),h.fcra_conviction_flag<>(typeof(h.fcra_conviction_flag))'');
    populated_fcra_traffic_flag_pcnt := AVE(GROUP,IF(h.fcra_traffic_flag = (TYPEOF(h.fcra_traffic_flag))'',0,100));
    maxlength_fcra_traffic_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_traffic_flag)));
    avelength_fcra_traffic_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_traffic_flag)),h.fcra_traffic_flag<>(typeof(h.fcra_traffic_flag))'');
    populated_fcra_date_pcnt := AVE(GROUP,IF(h.fcra_date = (TYPEOF(h.fcra_date))'',0,100));
    maxlength_fcra_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date)));
    avelength_fcra_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date)),h.fcra_date<>(typeof(h.fcra_date))'');
    populated_fcra_date_type_pcnt := AVE(GROUP,IF(h.fcra_date_type = (TYPEOF(h.fcra_date_type))'',0,100));
    maxlength_fcra_date_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date_type)));
    avelength_fcra_date_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date_type)),h.fcra_date_type<>(typeof(h.fcra_date_type))'');
    populated_conviction_override_date_pcnt := AVE(GROUP,IF(h.conviction_override_date = (TYPEOF(h.conviction_override_date))'',0,100));
    maxlength_conviction_override_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date)));
    avelength_conviction_override_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date)),h.conviction_override_date<>(typeof(h.conviction_override_date))'');
    populated_conviction_override_date_type_pcnt := AVE(GROUP,IF(h.conviction_override_date_type = (TYPEOF(h.conviction_override_date_type))'',0,100));
    maxlength_conviction_override_date_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date_type)));
    avelength_conviction_override_date_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date_type)),h.conviction_override_date_type<>(typeof(h.conviction_override_date_type))'');
    populated_offense_score_pcnt := AVE(GROUP,IF(h.offense_score = (TYPEOF(h.offense_score))'',0,100));
    maxlength_offense_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_score)));
    avelength_offense_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_score)),h.offense_score<>(typeof(h.offense_score))'');
    populated_offense_persistent_id_pcnt := AVE(GROUP,IF(h.offense_persistent_id = (TYPEOF(h.offense_persistent_id))'',0,100));
    maxlength_offense_persistent_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_persistent_id)));
    avelength_offense_persistent_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_persistent_id)),h.offense_persistent_id<>(typeof(h.offense_persistent_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,orig_state_code,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_state_code_pcnt *   0.00 / 100 + T.Populated_vendor_code_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_seisint_primary_key_pcnt *   0.00 / 100 + T.Populated_conviction_jurisdiction_pcnt *   0.00 / 100 + T.Populated_conviction_date_pcnt *   0.00 / 100 + T.Populated_court_pcnt *   0.00 / 100 + T.Populated_court_case_number_pcnt *   0.00 / 100 + T.Populated_offense_date_pcnt *   0.00 / 100 + T.Populated_offense_code_or_statute_pcnt *   0.00 / 100 + T.Populated_offense_description_pcnt *   0.00 / 100 + T.Populated_offense_description_2_pcnt *   0.00 / 100 + T.Populated_offense_category_pcnt *   0.00 / 100 + T.Populated_victim_minor_pcnt *   0.00 / 100 + T.Populated_victim_age_pcnt *   0.00 / 100 + T.Populated_victim_gender_pcnt *   0.00 / 100 + T.Populated_victim_relationship_pcnt *   0.00 / 100 + T.Populated_sentence_description_pcnt *   0.00 / 100 + T.Populated_sentence_description_2_pcnt *   0.00 / 100 + T.Populated_arrest_date_pcnt *   0.00 / 100 + T.Populated_arrest_warrant_pcnt *   0.00 / 100 + T.Populated_fcra_conviction_flag_pcnt *   0.00 / 100 + T.Populated_fcra_traffic_flag_pcnt *   0.00 / 100 + T.Populated_fcra_date_pcnt *   0.00 / 100 + T.Populated_fcra_date_type_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_type_pcnt *   0.00 / 100 + T.Populated_offense_score_pcnt *   0.00 / 100 + T.Populated_offense_persistent_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING orig_state_code1;
    STRING orig_state_code2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.orig_state_code1 := le.Source;
    SELF.orig_state_code2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_orig_state_code_pcnt*ri.Populated_orig_state_code_pcnt *   0.00 / 10000 + le.Populated_vendor_code_pcnt*ri.Populated_vendor_code_pcnt *   0.00 / 10000 + le.Populated_source_file_pcnt*ri.Populated_source_file_pcnt *   0.00 / 10000 + le.Populated_seisint_primary_key_pcnt*ri.Populated_seisint_primary_key_pcnt *   0.00 / 10000 + le.Populated_conviction_jurisdiction_pcnt*ri.Populated_conviction_jurisdiction_pcnt *   0.00 / 10000 + le.Populated_conviction_date_pcnt*ri.Populated_conviction_date_pcnt *   0.00 / 10000 + le.Populated_court_pcnt*ri.Populated_court_pcnt *   0.00 / 10000 + le.Populated_court_case_number_pcnt*ri.Populated_court_case_number_pcnt *   0.00 / 10000 + le.Populated_offense_date_pcnt*ri.Populated_offense_date_pcnt *   0.00 / 10000 + le.Populated_offense_code_or_statute_pcnt*ri.Populated_offense_code_or_statute_pcnt *   0.00 / 10000 + le.Populated_offense_description_pcnt*ri.Populated_offense_description_pcnt *   0.00 / 10000 + le.Populated_offense_description_2_pcnt*ri.Populated_offense_description_2_pcnt *   0.00 / 10000 + le.Populated_offense_category_pcnt*ri.Populated_offense_category_pcnt *   0.00 / 10000 + le.Populated_victim_minor_pcnt*ri.Populated_victim_minor_pcnt *   0.00 / 10000 + le.Populated_victim_age_pcnt*ri.Populated_victim_age_pcnt *   0.00 / 10000 + le.Populated_victim_gender_pcnt*ri.Populated_victim_gender_pcnt *   0.00 / 10000 + le.Populated_victim_relationship_pcnt*ri.Populated_victim_relationship_pcnt *   0.00 / 10000 + le.Populated_sentence_description_pcnt*ri.Populated_sentence_description_pcnt *   0.00 / 10000 + le.Populated_sentence_description_2_pcnt*ri.Populated_sentence_description_2_pcnt *   0.00 / 10000 + le.Populated_arrest_date_pcnt*ri.Populated_arrest_date_pcnt *   0.00 / 10000 + le.Populated_arrest_warrant_pcnt*ri.Populated_arrest_warrant_pcnt *   0.00 / 10000 + le.Populated_fcra_conviction_flag_pcnt*ri.Populated_fcra_conviction_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_traffic_flag_pcnt*ri.Populated_fcra_traffic_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_date_pcnt*ri.Populated_fcra_date_pcnt *   0.00 / 10000 + le.Populated_fcra_date_type_pcnt*ri.Populated_fcra_date_type_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_pcnt*ri.Populated_conviction_override_date_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_type_pcnt*ri.Populated_conviction_override_date_type_pcnt *   0.00 / 10000 + le.Populated_offense_score_pcnt*ri.Populated_offense_score_pcnt *   0.00 / 10000 + le.Populated_offense_persistent_id_pcnt*ri.Populated_offense_persistent_id_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'orig_state','orig_state_code','vendor_code','source_file','seisint_primary_key','conviction_jurisdiction','conviction_date','court','court_case_number','offense_date','offense_code_or_statute','offense_description','offense_description_2','offense_category','victim_minor','victim_age','victim_gender','victim_relationship','sentence_description','sentence_description_2','arrest_date','arrest_warrant','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_state_pcnt,le.populated_orig_state_code_pcnt,le.populated_vendor_code_pcnt,le.populated_source_file_pcnt,le.populated_seisint_primary_key_pcnt,le.populated_conviction_jurisdiction_pcnt,le.populated_conviction_date_pcnt,le.populated_court_pcnt,le.populated_court_case_number_pcnt,le.populated_offense_date_pcnt,le.populated_offense_code_or_statute_pcnt,le.populated_offense_description_pcnt,le.populated_offense_description_2_pcnt,le.populated_offense_category_pcnt,le.populated_victim_minor_pcnt,le.populated_victim_age_pcnt,le.populated_victim_gender_pcnt,le.populated_victim_relationship_pcnt,le.populated_sentence_description_pcnt,le.populated_sentence_description_2_pcnt,le.populated_arrest_date_pcnt,le.populated_arrest_warrant_pcnt,le.populated_fcra_conviction_flag_pcnt,le.populated_fcra_traffic_flag_pcnt,le.populated_fcra_date_pcnt,le.populated_fcra_date_type_pcnt,le.populated_conviction_override_date_pcnt,le.populated_conviction_override_date_type_pcnt,le.populated_offense_score_pcnt,le.populated_offense_persistent_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_state,le.maxlength_orig_state_code,le.maxlength_vendor_code,le.maxlength_source_file,le.maxlength_seisint_primary_key,le.maxlength_conviction_jurisdiction,le.maxlength_conviction_date,le.maxlength_court,le.maxlength_court_case_number,le.maxlength_offense_date,le.maxlength_offense_code_or_statute,le.maxlength_offense_description,le.maxlength_offense_description_2,le.maxlength_offense_category,le.maxlength_victim_minor,le.maxlength_victim_age,le.maxlength_victim_gender,le.maxlength_victim_relationship,le.maxlength_sentence_description,le.maxlength_sentence_description_2,le.maxlength_arrest_date,le.maxlength_arrest_warrant,le.maxlength_fcra_conviction_flag,le.maxlength_fcra_traffic_flag,le.maxlength_fcra_date,le.maxlength_fcra_date_type,le.maxlength_conviction_override_date,le.maxlength_conviction_override_date_type,le.maxlength_offense_score,le.maxlength_offense_persistent_id);
  SELF.avelength := CHOOSE(C,le.avelength_orig_state,le.avelength_orig_state_code,le.avelength_vendor_code,le.avelength_source_file,le.avelength_seisint_primary_key,le.avelength_conviction_jurisdiction,le.avelength_conviction_date,le.avelength_court,le.avelength_court_case_number,le.avelength_offense_date,le.avelength_offense_code_or_statute,le.avelength_offense_description,le.avelength_offense_description_2,le.avelength_offense_category,le.avelength_victim_minor,le.avelength_victim_age,le.avelength_victim_gender,le.avelength_victim_relationship,le.avelength_sentence_description,le.avelength_sentence_description_2,le.avelength_arrest_date,le.avelength_arrest_warrant,le.avelength_fcra_conviction_flag,le.avelength_fcra_traffic_flag,le.avelength_fcra_date,le.avelength_fcra_date_type,le.avelength_conviction_override_date,le.avelength_conviction_override_date_type,le.avelength_offense_score,le.avelength_offense_persistent_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 30, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.orig_state_code;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.orig_state_code),TRIM((SALT33.StrType)le.vendor_code),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.seisint_primary_key),TRIM((SALT33.StrType)le.conviction_jurisdiction),TRIM((SALT33.StrType)le.conviction_date),TRIM((SALT33.StrType)le.court),TRIM((SALT33.StrType)le.court_case_number),TRIM((SALT33.StrType)le.offense_date),TRIM((SALT33.StrType)le.offense_code_or_statute),TRIM((SALT33.StrType)le.offense_description),TRIM((SALT33.StrType)le.offense_description_2),TRIM((SALT33.StrType)le.offense_category),TRIM((SALT33.StrType)le.victim_minor),TRIM((SALT33.StrType)le.victim_age),TRIM((SALT33.StrType)le.victim_gender),TRIM((SALT33.StrType)le.victim_relationship),TRIM((SALT33.StrType)le.sentence_description),TRIM((SALT33.StrType)le.sentence_description_2),TRIM((SALT33.StrType)le.arrest_date),TRIM((SALT33.StrType)le.arrest_warrant),TRIM((SALT33.StrType)le.fcra_conviction_flag),TRIM((SALT33.StrType)le.fcra_traffic_flag),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),TRIM((SALT33.StrType)le.offense_score),IF (le.offense_persistent_id <> 0,TRIM((SALT33.StrType)le.offense_persistent_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,30,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 30);
  SELF.FldNo2 := 1 + (C % 30);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.orig_state_code),TRIM((SALT33.StrType)le.vendor_code),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.seisint_primary_key),TRIM((SALT33.StrType)le.conviction_jurisdiction),TRIM((SALT33.StrType)le.conviction_date),TRIM((SALT33.StrType)le.court),TRIM((SALT33.StrType)le.court_case_number),TRIM((SALT33.StrType)le.offense_date),TRIM((SALT33.StrType)le.offense_code_or_statute),TRIM((SALT33.StrType)le.offense_description),TRIM((SALT33.StrType)le.offense_description_2),TRIM((SALT33.StrType)le.offense_category),TRIM((SALT33.StrType)le.victim_minor),TRIM((SALT33.StrType)le.victim_age),TRIM((SALT33.StrType)le.victim_gender),TRIM((SALT33.StrType)le.victim_relationship),TRIM((SALT33.StrType)le.sentence_description),TRIM((SALT33.StrType)le.sentence_description_2),TRIM((SALT33.StrType)le.arrest_date),TRIM((SALT33.StrType)le.arrest_warrant),TRIM((SALT33.StrType)le.fcra_conviction_flag),TRIM((SALT33.StrType)le.fcra_traffic_flag),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),TRIM((SALT33.StrType)le.offense_score),IF (le.offense_persistent_id <> 0,TRIM((SALT33.StrType)le.offense_persistent_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.orig_state_code),TRIM((SALT33.StrType)le.vendor_code),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.seisint_primary_key),TRIM((SALT33.StrType)le.conviction_jurisdiction),TRIM((SALT33.StrType)le.conviction_date),TRIM((SALT33.StrType)le.court),TRIM((SALT33.StrType)le.court_case_number),TRIM((SALT33.StrType)le.offense_date),TRIM((SALT33.StrType)le.offense_code_or_statute),TRIM((SALT33.StrType)le.offense_description),TRIM((SALT33.StrType)le.offense_description_2),TRIM((SALT33.StrType)le.offense_category),TRIM((SALT33.StrType)le.victim_minor),TRIM((SALT33.StrType)le.victim_age),TRIM((SALT33.StrType)le.victim_gender),TRIM((SALT33.StrType)le.victim_relationship),TRIM((SALT33.StrType)le.sentence_description),TRIM((SALT33.StrType)le.sentence_description_2),TRIM((SALT33.StrType)le.arrest_date),TRIM((SALT33.StrType)le.arrest_warrant),TRIM((SALT33.StrType)le.fcra_conviction_flag),TRIM((SALT33.StrType)le.fcra_traffic_flag),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),TRIM((SALT33.StrType)le.offense_score),IF (le.offense_persistent_id <> 0,TRIM((SALT33.StrType)le.offense_persistent_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),30*30,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orig_state'}
      ,{2,'orig_state_code'}
      ,{3,'vendor_code'}
      ,{4,'source_file'}
      ,{5,'seisint_primary_key'}
      ,{6,'conviction_jurisdiction'}
      ,{7,'conviction_date'}
      ,{8,'court'}
      ,{9,'court_case_number'}
      ,{10,'offense_date'}
      ,{11,'offense_code_or_statute'}
      ,{12,'offense_description'}
      ,{13,'offense_description_2'}
      ,{14,'offense_category'}
      ,{15,'victim_minor'}
      ,{16,'victim_age'}
      ,{17,'victim_gender'}
      ,{18,'victim_relationship'}
      ,{19,'sentence_description'}
      ,{20,'sentence_description_2'}
      ,{21,'arrest_date'}
      ,{22,'arrest_warrant'}
      ,{23,'fcra_conviction_flag'}
      ,{24,'fcra_traffic_flag'}
      ,{25,'fcra_date'}
      ,{26,'fcra_date_type'}
      ,{27,'conviction_override_date'}
      ,{28,'conviction_override_date_type'}
      ,{29,'offense_score'}
      ,{30,'offense_persistent_id'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.orig_state_code) orig_state_code; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_orig_state((SALT33.StrType)le.orig_state),
    Fields.InValid_orig_state_code((SALT33.StrType)le.orig_state_code),
    Fields.InValid_vendor_code((SALT33.StrType)le.vendor_code),
    Fields.InValid_source_file((SALT33.StrType)le.source_file),
    Fields.InValid_seisint_primary_key((SALT33.StrType)le.seisint_primary_key),
    Fields.InValid_conviction_jurisdiction((SALT33.StrType)le.conviction_jurisdiction),
    Fields.InValid_conviction_date((SALT33.StrType)le.conviction_date),
    Fields.InValid_court((SALT33.StrType)le.court),
    Fields.InValid_court_case_number((SALT33.StrType)le.court_case_number),
    Fields.InValid_offense_date((SALT33.StrType)le.offense_date),
    Fields.InValid_offense_code_or_statute((SALT33.StrType)le.offense_code_or_statute),
    Fields.InValid_offense_description((SALT33.StrType)le.offense_description),
    Fields.InValid_offense_description_2((SALT33.StrType)le.offense_description_2),
    Fields.InValid_offense_category((SALT33.StrType)le.offense_category),
    Fields.InValid_victim_minor((SALT33.StrType)le.victim_minor),
    Fields.InValid_victim_age((SALT33.StrType)le.victim_age),
    Fields.InValid_victim_gender((SALT33.StrType)le.victim_gender),
    Fields.InValid_victim_relationship((SALT33.StrType)le.victim_relationship),
    Fields.InValid_sentence_description((SALT33.StrType)le.sentence_description),
    Fields.InValid_sentence_description_2((SALT33.StrType)le.sentence_description_2),
    Fields.InValid_arrest_date((SALT33.StrType)le.arrest_date),
    Fields.InValid_arrest_warrant((SALT33.StrType)le.arrest_warrant),
    Fields.InValid_fcra_conviction_flag((SALT33.StrType)le.fcra_conviction_flag),
    Fields.InValid_fcra_traffic_flag((SALT33.StrType)le.fcra_traffic_flag),
    Fields.InValid_fcra_date((SALT33.StrType)le.fcra_date),
    Fields.InValid_fcra_date_type((SALT33.StrType)le.fcra_date_type),
    Fields.InValid_conviction_override_date((SALT33.StrType)le.conviction_override_date),
    Fields.InValid_conviction_override_date_type((SALT33.StrType)le.conviction_override_date_type),
    Fields.InValid_offense_score((SALT33.StrType)le.offense_score),
    Fields.InValid_offense_persistent_id((SALT33.StrType)le.offense_persistent_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.orig_state_code := le.orig_state_code;
END;
Errors := NORMALIZE(h,30,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.orig_state_code;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,orig_state_code,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.orig_state_code;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_age','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state_code(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_code(TotalErrors.ErrorNum),Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Fields.InValidMessage_seisint_primary_key(TotalErrors.ErrorNum),Fields.InValidMessage_conviction_jurisdiction(TotalErrors.ErrorNum),Fields.InValidMessage_conviction_date(TotalErrors.ErrorNum),Fields.InValidMessage_court(TotalErrors.ErrorNum),Fields.InValidMessage_court_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_offense_date(TotalErrors.ErrorNum),Fields.InValidMessage_offense_code_or_statute(TotalErrors.ErrorNum),Fields.InValidMessage_offense_description(TotalErrors.ErrorNum),Fields.InValidMessage_offense_description_2(TotalErrors.ErrorNum),Fields.InValidMessage_offense_category(TotalErrors.ErrorNum),Fields.InValidMessage_victim_minor(TotalErrors.ErrorNum),Fields.InValidMessage_victim_age(TotalErrors.ErrorNum),Fields.InValidMessage_victim_gender(TotalErrors.ErrorNum),Fields.InValidMessage_victim_relationship(TotalErrors.ErrorNum),Fields.InValidMessage_sentence_description(TotalErrors.ErrorNum),Fields.InValidMessage_sentence_description_2(TotalErrors.ErrorNum),Fields.InValidMessage_arrest_date(TotalErrors.ErrorNum),Fields.InValidMessage_arrest_warrant(TotalErrors.ErrorNum),Fields.InValidMessage_fcra_conviction_flag(TotalErrors.ErrorNum),Fields.InValidMessage_fcra_traffic_flag(TotalErrors.ErrorNum),Fields.InValidMessage_fcra_date(TotalErrors.ErrorNum),Fields.InValidMessage_fcra_date_type(TotalErrors.ErrorNum),Fields.InValidMessage_conviction_override_date(TotalErrors.ErrorNum),Fields.InValidMessage_conviction_override_date_type(TotalErrors.ErrorNum),Fields.InValidMessage_offense_score(TotalErrors.ErrorNum),Fields.InValidMessage_offense_persistent_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.orig_state_code=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
