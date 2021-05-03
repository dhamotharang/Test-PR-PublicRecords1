IMPORT SALT311,STD;
EXPORT Input_hygiene(dataset(Input_layout_SAM) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_classification_cnt := COUNT(GROUP,h.classification <> (TYPEOF(h.classification))'');
    populated_classification_pcnt := AVE(GROUP,IF(h.classification = (TYPEOF(h.classification))'',0,100));
    maxlength_classification := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classification)));
    avelength_classification := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classification)),h.classification<>(typeof(h.classification))'');
    populated_name_cnt := COUNT(GROUP,h.name <> (TYPEOF(h.name))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_prefix_cnt := COUNT(GROUP,h.prefix <> (TYPEOF(h.prefix))'');
    populated_prefix_pcnt := AVE(GROUP,IF(h.prefix = (TYPEOF(h.prefix))'',0,100));
    maxlength_prefix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prefix)));
    avelength_prefix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prefix)),h.prefix<>(typeof(h.prefix))'');
    populated_firstname_cnt := COUNT(GROUP,h.firstname <> (TYPEOF(h.firstname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_middlename_cnt := COUNT(GROUP,h.middlename <> (TYPEOF(h.middlename))'');
    populated_middlename_pcnt := AVE(GROUP,IF(h.middlename = (TYPEOF(h.middlename))'',0,100));
    maxlength_middlename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middlename)));
    avelength_middlename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middlename)),h.middlename<>(typeof(h.middlename))'');
    populated_lastname_cnt := COUNT(GROUP,h.lastname <> (TYPEOF(h.lastname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_address_1_cnt := COUNT(GROUP,h.address_1 <> (TYPEOF(h.address_1))'');
    populated_address_1_pcnt := AVE(GROUP,IF(h.address_1 = (TYPEOF(h.address_1))'',0,100));
    maxlength_address_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_1)));
    avelength_address_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_1)),h.address_1<>(typeof(h.address_1))'');
    populated_address_2_cnt := COUNT(GROUP,h.address_2 <> (TYPEOF(h.address_2))'');
    populated_address_2_pcnt := AVE(GROUP,IF(h.address_2 = (TYPEOF(h.address_2))'',0,100));
    maxlength_address_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_2)));
    avelength_address_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_2)),h.address_2<>(typeof(h.address_2))'');
    populated_address_3_cnt := COUNT(GROUP,h.address_3 <> (TYPEOF(h.address_3))'');
    populated_address_3_pcnt := AVE(GROUP,IF(h.address_3 = (TYPEOF(h.address_3))'',0,100));
    maxlength_address_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_3)));
    avelength_address_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_3)),h.address_3<>(typeof(h.address_3))'');
    populated_address_4_cnt := COUNT(GROUP,h.address_4 <> (TYPEOF(h.address_4))'');
    populated_address_4_pcnt := AVE(GROUP,IF(h.address_4 = (TYPEOF(h.address_4))'',0,100));
    maxlength_address_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_4)));
    avelength_address_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_4)),h.address_4<>(typeof(h.address_4))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_zipcode_cnt := COUNT(GROUP,h.zipcode <> (TYPEOF(h.zipcode))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_duns_cnt := COUNT(GROUP,h.duns <> (TYPEOF(h.duns))'');
    populated_duns_pcnt := AVE(GROUP,IF(h.duns = (TYPEOF(h.duns))'',0,100));
    maxlength_duns := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.duns)));
    avelength_duns := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.duns)),h.duns<>(typeof(h.duns))'');
    populated_exclusionprogram_cnt := COUNT(GROUP,h.exclusionprogram <> (TYPEOF(h.exclusionprogram))'');
    populated_exclusionprogram_pcnt := AVE(GROUP,IF(h.exclusionprogram = (TYPEOF(h.exclusionprogram))'',0,100));
    maxlength_exclusionprogram := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exclusionprogram)));
    avelength_exclusionprogram := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exclusionprogram)),h.exclusionprogram<>(typeof(h.exclusionprogram))'');
    populated_excludingagency_cnt := COUNT(GROUP,h.excludingagency <> (TYPEOF(h.excludingagency))'');
    populated_excludingagency_pcnt := AVE(GROUP,IF(h.excludingagency = (TYPEOF(h.excludingagency))'',0,100));
    maxlength_excludingagency := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.excludingagency)));
    avelength_excludingagency := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.excludingagency)),h.excludingagency<>(typeof(h.excludingagency))'');
    populated_ctcode_cnt := COUNT(GROUP,h.ctcode <> (TYPEOF(h.ctcode))'');
    populated_ctcode_pcnt := AVE(GROUP,IF(h.ctcode = (TYPEOF(h.ctcode))'',0,100));
    maxlength_ctcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ctcode)));
    avelength_ctcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ctcode)),h.ctcode<>(typeof(h.ctcode))'');
    populated_exclusiontype_cnt := COUNT(GROUP,h.exclusiontype <> (TYPEOF(h.exclusiontype))'');
    populated_exclusiontype_pcnt := AVE(GROUP,IF(h.exclusiontype = (TYPEOF(h.exclusiontype))'',0,100));
    maxlength_exclusiontype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exclusiontype)));
    avelength_exclusiontype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exclusiontype)),h.exclusiontype<>(typeof(h.exclusiontype))'');
    populated_additionalcomments_cnt := COUNT(GROUP,h.additionalcomments <> (TYPEOF(h.additionalcomments))'');
    populated_additionalcomments_pcnt := AVE(GROUP,IF(h.additionalcomments = (TYPEOF(h.additionalcomments))'',0,100));
    maxlength_additionalcomments := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.additionalcomments)));
    avelength_additionalcomments := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.additionalcomments)),h.additionalcomments<>(typeof(h.additionalcomments))'');
    populated_activedate_cnt := COUNT(GROUP,h.activedate <> (TYPEOF(h.activedate))'');
    populated_activedate_pcnt := AVE(GROUP,IF(h.activedate = (TYPEOF(h.activedate))'',0,100));
    maxlength_activedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activedate)));
    avelength_activedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activedate)),h.activedate<>(typeof(h.activedate))'');
    populated_terminationdate_cnt := COUNT(GROUP,h.terminationdate <> (TYPEOF(h.terminationdate))'');
    populated_terminationdate_pcnt := AVE(GROUP,IF(h.terminationdate = (TYPEOF(h.terminationdate))'',0,100));
    maxlength_terminationdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.terminationdate)));
    avelength_terminationdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.terminationdate)),h.terminationdate<>(typeof(h.terminationdate))'');
    populated_recordstatus_cnt := COUNT(GROUP,h.recordstatus <> (TYPEOF(h.recordstatus))'');
    populated_recordstatus_pcnt := AVE(GROUP,IF(h.recordstatus = (TYPEOF(h.recordstatus))'',0,100));
    maxlength_recordstatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordstatus)));
    avelength_recordstatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordstatus)),h.recordstatus<>(typeof(h.recordstatus))'');
    populated_crossreference_cnt := COUNT(GROUP,h.crossreference <> (TYPEOF(h.crossreference))'');
    populated_crossreference_pcnt := AVE(GROUP,IF(h.crossreference = (TYPEOF(h.crossreference))'',0,100));
    maxlength_crossreference := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crossreference)));
    avelength_crossreference := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crossreference)),h.crossreference<>(typeof(h.crossreference))'');
    populated_samnumber_cnt := COUNT(GROUP,h.samnumber <> (TYPEOF(h.samnumber))'');
    populated_samnumber_pcnt := AVE(GROUP,IF(h.samnumber = (TYPEOF(h.samnumber))'',0,100));
    maxlength_samnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.samnumber)));
    avelength_samnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.samnumber)),h.samnumber<>(typeof(h.samnumber))'');
    populated_cage_cnt := COUNT(GROUP,h.cage <> (TYPEOF(h.cage))'');
    populated_cage_pcnt := AVE(GROUP,IF(h.cage = (TYPEOF(h.cage))'',0,100));
    maxlength_cage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cage)));
    avelength_cage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cage)),h.cage<>(typeof(h.cage))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_classification_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_prefix_pcnt *   0.00 / 100 + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_middlename_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_address_1_pcnt *   0.00 / 100 + T.Populated_address_2_pcnt *   0.00 / 100 + T.Populated_address_3_pcnt *   0.00 / 100 + T.Populated_address_4_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_duns_pcnt *   0.00 / 100 + T.Populated_exclusionprogram_pcnt *   0.00 / 100 + T.Populated_excludingagency_pcnt *   0.00 / 100 + T.Populated_ctcode_pcnt *   0.00 / 100 + T.Populated_exclusiontype_pcnt *   0.00 / 100 + T.Populated_additionalcomments_pcnt *   0.00 / 100 + T.Populated_activedate_pcnt *   0.00 / 100 + T.Populated_terminationdate_pcnt *   0.00 / 100 + T.Populated_recordstatus_pcnt *   0.00 / 100 + T.Populated_crossreference_pcnt *   0.00 / 100 + T.Populated_samnumber_pcnt *   0.00 / 100 + T.Populated_cage_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'classification','name','prefix','firstname','middlename','lastname','suffix','address_1','address_2','address_3','address_4','city','state','country','zipcode','duns','exclusionprogram','excludingagency','ctcode','exclusiontype','additionalcomments','activedate','terminationdate','recordstatus','crossreference','samnumber','cage');
  SELF.populated_pcnt := CHOOSE(C,le.populated_classification_pcnt,le.populated_name_pcnt,le.populated_prefix_pcnt,le.populated_firstname_pcnt,le.populated_middlename_pcnt,le.populated_lastname_pcnt,le.populated_suffix_pcnt,le.populated_address_1_pcnt,le.populated_address_2_pcnt,le.populated_address_3_pcnt,le.populated_address_4_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_country_pcnt,le.populated_zipcode_pcnt,le.populated_duns_pcnt,le.populated_exclusionprogram_pcnt,le.populated_excludingagency_pcnt,le.populated_ctcode_pcnt,le.populated_exclusiontype_pcnt,le.populated_additionalcomments_pcnt,le.populated_activedate_pcnt,le.populated_terminationdate_pcnt,le.populated_recordstatus_pcnt,le.populated_crossreference_pcnt,le.populated_samnumber_pcnt,le.populated_cage_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_classification,le.maxlength_name,le.maxlength_prefix,le.maxlength_firstname,le.maxlength_middlename,le.maxlength_lastname,le.maxlength_suffix,le.maxlength_address_1,le.maxlength_address_2,le.maxlength_address_3,le.maxlength_address_4,le.maxlength_city,le.maxlength_state,le.maxlength_country,le.maxlength_zipcode,le.maxlength_duns,le.maxlength_exclusionprogram,le.maxlength_excludingagency,le.maxlength_ctcode,le.maxlength_exclusiontype,le.maxlength_additionalcomments,le.maxlength_activedate,le.maxlength_terminationdate,le.maxlength_recordstatus,le.maxlength_crossreference,le.maxlength_samnumber,le.maxlength_cage);
  SELF.avelength := CHOOSE(C,le.avelength_classification,le.avelength_name,le.avelength_prefix,le.avelength_firstname,le.avelength_middlename,le.avelength_lastname,le.avelength_suffix,le.avelength_address_1,le.avelength_address_2,le.avelength_address_3,le.avelength_address_4,le.avelength_city,le.avelength_state,le.avelength_country,le.avelength_zipcode,le.avelength_duns,le.avelength_exclusionprogram,le.avelength_excludingagency,le.avelength_ctcode,le.avelength_exclusiontype,le.avelength_additionalcomments,le.avelength_activedate,le.avelength_terminationdate,le.avelength_recordstatus,le.avelength_crossreference,le.avelength_samnumber,le.avelength_cage);
END;
EXPORT invSummary := NORMALIZE(summary0, 27, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.classification),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.prefix),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.address_1),TRIM((SALT311.StrType)le.address_2),TRIM((SALT311.StrType)le.address_3),TRIM((SALT311.StrType)le.address_4),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.duns),TRIM((SALT311.StrType)le.exclusionprogram),TRIM((SALT311.StrType)le.excludingagency),TRIM((SALT311.StrType)le.ctcode),TRIM((SALT311.StrType)le.exclusiontype),TRIM((SALT311.StrType)le.additionalcomments),TRIM((SALT311.StrType)le.activedate),TRIM((SALT311.StrType)le.terminationdate),TRIM((SALT311.StrType)le.recordstatus),TRIM((SALT311.StrType)le.crossreference),TRIM((SALT311.StrType)le.samnumber),TRIM((SALT311.StrType)le.cage)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,27,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 27);
  SELF.FldNo2 := 1 + (C % 27);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.classification),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.prefix),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.address_1),TRIM((SALT311.StrType)le.address_2),TRIM((SALT311.StrType)le.address_3),TRIM((SALT311.StrType)le.address_4),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.duns),TRIM((SALT311.StrType)le.exclusionprogram),TRIM((SALT311.StrType)le.excludingagency),TRIM((SALT311.StrType)le.ctcode),TRIM((SALT311.StrType)le.exclusiontype),TRIM((SALT311.StrType)le.additionalcomments),TRIM((SALT311.StrType)le.activedate),TRIM((SALT311.StrType)le.terminationdate),TRIM((SALT311.StrType)le.recordstatus),TRIM((SALT311.StrType)le.crossreference),TRIM((SALT311.StrType)le.samnumber),TRIM((SALT311.StrType)le.cage)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.classification),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.prefix),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.address_1),TRIM((SALT311.StrType)le.address_2),TRIM((SALT311.StrType)le.address_3),TRIM((SALT311.StrType)le.address_4),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.duns),TRIM((SALT311.StrType)le.exclusionprogram),TRIM((SALT311.StrType)le.excludingagency),TRIM((SALT311.StrType)le.ctcode),TRIM((SALT311.StrType)le.exclusiontype),TRIM((SALT311.StrType)le.additionalcomments),TRIM((SALT311.StrType)le.activedate),TRIM((SALT311.StrType)le.terminationdate),TRIM((SALT311.StrType)le.recordstatus),TRIM((SALT311.StrType)le.crossreference),TRIM((SALT311.StrType)le.samnumber),TRIM((SALT311.StrType)le.cage)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),27*27,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'classification'}
      ,{2,'name'}
      ,{3,'prefix'}
      ,{4,'firstname'}
      ,{5,'middlename'}
      ,{6,'lastname'}
      ,{7,'suffix'}
      ,{8,'address_1'}
      ,{9,'address_2'}
      ,{10,'address_3'}
      ,{11,'address_4'}
      ,{12,'city'}
      ,{13,'state'}
      ,{14,'country'}
      ,{15,'zipcode'}
      ,{16,'duns'}
      ,{17,'exclusionprogram'}
      ,{18,'excludingagency'}
      ,{19,'ctcode'}
      ,{20,'exclusiontype'}
      ,{21,'additionalcomments'}
      ,{22,'activedate'}
      ,{23,'terminationdate'}
      ,{24,'recordstatus'}
      ,{25,'crossreference'}
      ,{26,'samnumber'}
      ,{27,'cage'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_classification((SALT311.StrType)le.classification),
    Input_Fields.InValid_name((SALT311.StrType)le.name,(SALT311.StrType)le.firstname,(SALT311.StrType)le.lastname),
    Input_Fields.InValid_prefix((SALT311.StrType)le.prefix),
    Input_Fields.InValid_firstname((SALT311.StrType)le.firstname,(SALT311.StrType)le.name,(SALT311.StrType)le.lastname),
    Input_Fields.InValid_middlename((SALT311.StrType)le.middlename,(SALT311.StrType)le.name,(SALT311.StrType)le.firstname,(SALT311.StrType)le.lastname),
    Input_Fields.InValid_lastname((SALT311.StrType)le.lastname,(SALT311.StrType)le.name,(SALT311.StrType)le.lastname),
    Input_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Input_Fields.InValid_address_1((SALT311.StrType)le.address_1),
    Input_Fields.InValid_address_2((SALT311.StrType)le.address_2,(SALT311.StrType)le.address_1),
    Input_Fields.InValid_address_3((SALT311.StrType)le.address_3,(SALT311.StrType)le.address_1,(SALT311.StrType)le.address_2),
    Input_Fields.InValid_address_4((SALT311.StrType)le.address_4,(SALT311.StrType)le.address_1,(SALT311.StrType)le.address_2,(SALT311.StrType)le.address_3),
    Input_Fields.InValid_city((SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.country,(SALT311.StrType)le.zipcode),
    Input_Fields.InValid_state((SALT311.StrType)le.state,(SALT311.StrType)le.country),
    Input_Fields.InValid_country((SALT311.StrType)le.country),
    Input_Fields.InValid_zipcode((SALT311.StrType)le.zipcode),
    Input_Fields.InValid_duns((SALT311.StrType)le.duns),
    Input_Fields.InValid_exclusionprogram((SALT311.StrType)le.exclusionprogram),
    Input_Fields.InValid_excludingagency((SALT311.StrType)le.excludingagency),
    Input_Fields.InValid_ctcode((SALT311.StrType)le.ctcode),
    Input_Fields.InValid_exclusiontype((SALT311.StrType)le.exclusiontype),
    Input_Fields.InValid_additionalcomments((SALT311.StrType)le.additionalcomments),
    Input_Fields.InValid_activedate((SALT311.StrType)le.activedate),
    Input_Fields.InValid_terminationdate((SALT311.StrType)le.terminationdate),
    Input_Fields.InValid_recordstatus((SALT311.StrType)le.recordstatus),
    Input_Fields.InValid_crossreference((SALT311.StrType)le.crossreference),
    Input_Fields.InValid_samnumber((SALT311.StrType)le.samnumber),
    Input_Fields.InValid_cage((SALT311.StrType)le.cage),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,27,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_name','Unknown','invalid_firstname','invalid_middlename','invalid_lastname','Unknown','Unknown','invalid_address_2','invalid_address_3','invalid_address_4','invalid_city','invalid_state','invalid_country','invalid_zipcode','Unknown','invalid_exclusionprogram','invalid_mandatory','Unknown','invalid_exclusiontype','Unknown','invalid_activedate','invalid_terminationdate','Unknown','Unknown','invalid_samnumber','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_classification(TotalErrors.ErrorNum),Input_Fields.InValidMessage_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_prefix(TotalErrors.ErrorNum),Input_Fields.InValidMessage_firstname(TotalErrors.ErrorNum),Input_Fields.InValidMessage_middlename(TotalErrors.ErrorNum),Input_Fields.InValidMessage_lastname(TotalErrors.ErrorNum),Input_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address_1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address_2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address_3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address_4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_city(TotalErrors.ErrorNum),Input_Fields.InValidMessage_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_country(TotalErrors.ErrorNum),Input_Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_duns(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exclusionprogram(TotalErrors.ErrorNum),Input_Fields.InValidMessage_excludingagency(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ctcode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exclusiontype(TotalErrors.ErrorNum),Input_Fields.InValidMessage_additionalcomments(TotalErrors.ErrorNum),Input_Fields.InValidMessage_activedate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_terminationdate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_recordstatus(TotalErrors.ErrorNum),Input_Fields.InValidMessage_crossreference(TotalErrors.ErrorNum),Input_Fields.InValidMessage_samnumber(TotalErrors.ErrorNum),Input_Fields.InValidMessage_cage(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SAM, Input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
