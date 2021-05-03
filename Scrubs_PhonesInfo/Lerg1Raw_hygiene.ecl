IMPORT SALT311,STD;
EXPORT Lerg1Raw_hygiene(dataset(Lerg1Raw_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ocn_cnt := COUNT(GROUP,h.ocn <> (TYPEOF(h.ocn))'');
    populated_ocn_pcnt := AVE(GROUP,IF(h.ocn = (TYPEOF(h.ocn))'',0,100));
    maxlength_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)));
    avelength_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)),h.ocn<>(typeof(h.ocn))'');
    populated_ocn_name_cnt := COUNT(GROUP,h.ocn_name <> (TYPEOF(h.ocn_name))'');
    populated_ocn_name_pcnt := AVE(GROUP,IF(h.ocn_name = (TYPEOF(h.ocn_name))'',0,100));
    maxlength_ocn_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_name)));
    avelength_ocn_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_name)),h.ocn_name<>(typeof(h.ocn_name))'');
    populated_ocn_abbr_name_cnt := COUNT(GROUP,h.ocn_abbr_name <> (TYPEOF(h.ocn_abbr_name))'');
    populated_ocn_abbr_name_pcnt := AVE(GROUP,IF(h.ocn_abbr_name = (TYPEOF(h.ocn_abbr_name))'',0,100));
    maxlength_ocn_abbr_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_abbr_name)));
    avelength_ocn_abbr_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_abbr_name)),h.ocn_abbr_name<>(typeof(h.ocn_abbr_name))'');
    populated_ocn_state_cnt := COUNT(GROUP,h.ocn_state <> (TYPEOF(h.ocn_state))'');
    populated_ocn_state_pcnt := AVE(GROUP,IF(h.ocn_state = (TYPEOF(h.ocn_state))'',0,100));
    maxlength_ocn_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_state)));
    avelength_ocn_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_state)),h.ocn_state<>(typeof(h.ocn_state))'');
    populated_category_cnt := COUNT(GROUP,h.category <> (TYPEOF(h.category))'');
    populated_category_pcnt := AVE(GROUP,IF(h.category = (TYPEOF(h.category))'',0,100));
    maxlength_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.category)));
    avelength_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.category)),h.category<>(typeof(h.category))'');
    populated_overall_ocn_cnt := COUNT(GROUP,h.overall_ocn <> (TYPEOF(h.overall_ocn))'');
    populated_overall_ocn_pcnt := AVE(GROUP,IF(h.overall_ocn = (TYPEOF(h.overall_ocn))'',0,100));
    maxlength_overall_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_ocn)));
    avelength_overall_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_ocn)),h.overall_ocn<>(typeof(h.overall_ocn))'');
    populated_filler1_cnt := COUNT(GROUP,h.filler1 <> (TYPEOF(h.filler1))'');
    populated_filler1_pcnt := AVE(GROUP,IF(h.filler1 = (TYPEOF(h.filler1))'',0,100));
    maxlength_filler1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler1)));
    avelength_filler1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler1)),h.filler1<>(typeof(h.filler1))'');
    populated_filler2_cnt := COUNT(GROUP,h.filler2 <> (TYPEOF(h.filler2))'');
    populated_filler2_pcnt := AVE(GROUP,IF(h.filler2 = (TYPEOF(h.filler2))'',0,100));
    maxlength_filler2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)));
    avelength_filler2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)),h.filler2<>(typeof(h.filler2))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_initial_cnt := COUNT(GROUP,h.middle_initial <> (TYPEOF(h.middle_initial))'');
    populated_middle_initial_pcnt := AVE(GROUP,IF(h.middle_initial = (TYPEOF(h.middle_initial))'',0,100));
    maxlength_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_initial)));
    avelength_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_initial)),h.middle_initial<>(typeof(h.middle_initial))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_floor_cnt := COUNT(GROUP,h.floor <> (TYPEOF(h.floor))'');
    populated_floor_pcnt := AVE(GROUP,IF(h.floor = (TYPEOF(h.floor))'',0,100));
    maxlength_floor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.floor)));
    avelength_floor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.floor)),h.floor<>(typeof(h.floor))'');
    populated_room_cnt := COUNT(GROUP,h.room <> (TYPEOF(h.room))'');
    populated_room_pcnt := AVE(GROUP,IF(h.room = (TYPEOF(h.room))'',0,100));
    maxlength_room := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.room)));
    avelength_room := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.room)),h.room<>(typeof(h.room))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_postal_code_cnt := COUNT(GROUP,h.postal_code <> (TYPEOF(h.postal_code))'');
    populated_postal_code_pcnt := AVE(GROUP,IF(h.postal_code = (TYPEOF(h.postal_code))'',0,100));
    maxlength_postal_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postal_code)));
    avelength_postal_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postal_code)),h.postal_code<>(typeof(h.postal_code))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_target_ocn_cnt := COUNT(GROUP,h.target_ocn <> (TYPEOF(h.target_ocn))'');
    populated_target_ocn_pcnt := AVE(GROUP,IF(h.target_ocn = (TYPEOF(h.target_ocn))'',0,100));
    maxlength_target_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.target_ocn)));
    avelength_target_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.target_ocn)),h.target_ocn<>(typeof(h.target_ocn))'');
    populated_overall_target_ocn_cnt := COUNT(GROUP,h.overall_target_ocn <> (TYPEOF(h.overall_target_ocn))'');
    populated_overall_target_ocn_pcnt := AVE(GROUP,IF(h.overall_target_ocn = (TYPEOF(h.overall_target_ocn))'',0,100));
    maxlength_overall_target_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_target_ocn)));
    avelength_overall_target_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_target_ocn)),h.overall_target_ocn<>(typeof(h.overall_target_ocn))'');
    populated_rural_lec_indicator_cnt := COUNT(GROUP,h.rural_lec_indicator <> (TYPEOF(h.rural_lec_indicator))'');
    populated_rural_lec_indicator_pcnt := AVE(GROUP,IF(h.rural_lec_indicator = (TYPEOF(h.rural_lec_indicator))'',0,100));
    maxlength_rural_lec_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rural_lec_indicator)));
    avelength_rural_lec_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rural_lec_indicator)),h.rural_lec_indicator<>(typeof(h.rural_lec_indicator))'');
    populated_small_ilec_indicator_cnt := COUNT(GROUP,h.small_ilec_indicator <> (TYPEOF(h.small_ilec_indicator))'');
    populated_small_ilec_indicator_pcnt := AVE(GROUP,IF(h.small_ilec_indicator = (TYPEOF(h.small_ilec_indicator))'',0,100));
    maxlength_small_ilec_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.small_ilec_indicator)));
    avelength_small_ilec_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.small_ilec_indicator)),h.small_ilec_indicator<>(typeof(h.small_ilec_indicator))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ocn_pcnt *   0.00 / 100 + T.Populated_ocn_name_pcnt *   0.00 / 100 + T.Populated_ocn_abbr_name_pcnt *   0.00 / 100 + T.Populated_ocn_state_pcnt *   0.00 / 100 + T.Populated_category_pcnt *   0.00 / 100 + T.Populated_overall_ocn_pcnt *   0.00 / 100 + T.Populated_filler1_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_initial_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_floor_pcnt *   0.00 / 100 + T.Populated_room_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_postal_code_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_target_ocn_pcnt *   0.00 / 100 + T.Populated_overall_target_ocn_pcnt *   0.00 / 100 + T.Populated_rural_lec_indicator_pcnt *   0.00 / 100 + T.Populated_small_ilec_indicator_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'ocn','ocn_name','ocn_abbr_name','ocn_state','category','overall_ocn','filler1','filler2','last_name','first_name','middle_initial','company_name','title','address1','address2','floor','room','city','state','postal_code','phone','target_ocn','overall_target_ocn','rural_lec_indicator','small_ilec_indicator','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ocn_pcnt,le.populated_ocn_name_pcnt,le.populated_ocn_abbr_name_pcnt,le.populated_ocn_state_pcnt,le.populated_category_pcnt,le.populated_overall_ocn_pcnt,le.populated_filler1_pcnt,le.populated_filler2_pcnt,le.populated_last_name_pcnt,le.populated_first_name_pcnt,le.populated_middle_initial_pcnt,le.populated_company_name_pcnt,le.populated_title_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_floor_pcnt,le.populated_room_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_postal_code_pcnt,le.populated_phone_pcnt,le.populated_target_ocn_pcnt,le.populated_overall_target_ocn_pcnt,le.populated_rural_lec_indicator_pcnt,le.populated_small_ilec_indicator_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ocn,le.maxlength_ocn_name,le.maxlength_ocn_abbr_name,le.maxlength_ocn_state,le.maxlength_category,le.maxlength_overall_ocn,le.maxlength_filler1,le.maxlength_filler2,le.maxlength_last_name,le.maxlength_first_name,le.maxlength_middle_initial,le.maxlength_company_name,le.maxlength_title,le.maxlength_address1,le.maxlength_address2,le.maxlength_floor,le.maxlength_room,le.maxlength_city,le.maxlength_state,le.maxlength_postal_code,le.maxlength_phone,le.maxlength_target_ocn,le.maxlength_overall_target_ocn,le.maxlength_rural_lec_indicator,le.maxlength_small_ilec_indicator,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_ocn,le.avelength_ocn_name,le.avelength_ocn_abbr_name,le.avelength_ocn_state,le.avelength_category,le.avelength_overall_ocn,le.avelength_filler1,le.avelength_filler2,le.avelength_last_name,le.avelength_first_name,le.avelength_middle_initial,le.avelength_company_name,le.avelength_title,le.avelength_address1,le.avelength_address2,le.avelength_floor,le.avelength_room,le.avelength_city,le.avelength_state,le.avelength_postal_code,le.avelength_phone,le.avelength_target_ocn,le.avelength_overall_target_ocn,le.avelength_rural_lec_indicator,le.avelength_small_ilec_indicator,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 26, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.ocn_name),TRIM((SALT311.StrType)le.ocn_abbr_name),TRIM((SALT311.StrType)le.ocn_state),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.overall_ocn),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_initial),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.floor),TRIM((SALT311.StrType)le.room),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.postal_code),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.target_ocn),TRIM((SALT311.StrType)le.overall_target_ocn),TRIM((SALT311.StrType)le.rural_lec_indicator),TRIM((SALT311.StrType)le.small_ilec_indicator),TRIM((SALT311.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,26,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 26);
  SELF.FldNo2 := 1 + (C % 26);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.ocn_name),TRIM((SALT311.StrType)le.ocn_abbr_name),TRIM((SALT311.StrType)le.ocn_state),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.overall_ocn),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_initial),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.floor),TRIM((SALT311.StrType)le.room),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.postal_code),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.target_ocn),TRIM((SALT311.StrType)le.overall_target_ocn),TRIM((SALT311.StrType)le.rural_lec_indicator),TRIM((SALT311.StrType)le.small_ilec_indicator),TRIM((SALT311.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.ocn_name),TRIM((SALT311.StrType)le.ocn_abbr_name),TRIM((SALT311.StrType)le.ocn_state),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.overall_ocn),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_initial),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.floor),TRIM((SALT311.StrType)le.room),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.postal_code),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.target_ocn),TRIM((SALT311.StrType)le.overall_target_ocn),TRIM((SALT311.StrType)le.rural_lec_indicator),TRIM((SALT311.StrType)le.small_ilec_indicator),TRIM((SALT311.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),26*26,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ocn'}
      ,{2,'ocn_name'}
      ,{3,'ocn_abbr_name'}
      ,{4,'ocn_state'}
      ,{5,'category'}
      ,{6,'overall_ocn'}
      ,{7,'filler1'}
      ,{8,'filler2'}
      ,{9,'last_name'}
      ,{10,'first_name'}
      ,{11,'middle_initial'}
      ,{12,'company_name'}
      ,{13,'title'}
      ,{14,'address1'}
      ,{15,'address2'}
      ,{16,'floor'}
      ,{17,'room'}
      ,{18,'city'}
      ,{19,'state'}
      ,{20,'postal_code'}
      ,{21,'phone'}
      ,{22,'target_ocn'}
      ,{23,'overall_target_ocn'}
      ,{24,'rural_lec_indicator'}
      ,{25,'small_ilec_indicator'}
      ,{26,'filename'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Lerg1Raw_Fields.InValid_ocn((SALT311.StrType)le.ocn),
    Lerg1Raw_Fields.InValid_ocn_name((SALT311.StrType)le.ocn_name),
    Lerg1Raw_Fields.InValid_ocn_abbr_name((SALT311.StrType)le.ocn_abbr_name),
    Lerg1Raw_Fields.InValid_ocn_state((SALT311.StrType)le.ocn_state),
    Lerg1Raw_Fields.InValid_category((SALT311.StrType)le.category),
    Lerg1Raw_Fields.InValid_overall_ocn((SALT311.StrType)le.overall_ocn),
    Lerg1Raw_Fields.InValid_filler1((SALT311.StrType)le.filler1),
    Lerg1Raw_Fields.InValid_filler2((SALT311.StrType)le.filler2),
    Lerg1Raw_Fields.InValid_last_name((SALT311.StrType)le.last_name),
    Lerg1Raw_Fields.InValid_first_name((SALT311.StrType)le.first_name),
    Lerg1Raw_Fields.InValid_middle_initial((SALT311.StrType)le.middle_initial),
    Lerg1Raw_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Lerg1Raw_Fields.InValid_title((SALT311.StrType)le.title),
    Lerg1Raw_Fields.InValid_address1((SALT311.StrType)le.address1),
    Lerg1Raw_Fields.InValid_address2((SALT311.StrType)le.address2),
    Lerg1Raw_Fields.InValid_floor((SALT311.StrType)le.floor),
    Lerg1Raw_Fields.InValid_room((SALT311.StrType)le.room),
    Lerg1Raw_Fields.InValid_city((SALT311.StrType)le.city),
    Lerg1Raw_Fields.InValid_state((SALT311.StrType)le.state),
    Lerg1Raw_Fields.InValid_postal_code((SALT311.StrType)le.postal_code),
    Lerg1Raw_Fields.InValid_phone((SALT311.StrType)le.phone),
    Lerg1Raw_Fields.InValid_target_ocn((SALT311.StrType)le.target_ocn),
    Lerg1Raw_Fields.InValid_overall_target_ocn((SALT311.StrType)le.overall_target_ocn),
    Lerg1Raw_Fields.InValid_rural_lec_indicator((SALT311.StrType)le.rural_lec_indicator),
    Lerg1Raw_Fields.InValid_small_ilec_indicator((SALT311.StrType)le.small_ilec_indicator),
    Lerg1Raw_Fields.InValid_filename((SALT311.StrType)le.filename),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,26,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Lerg1Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Ocn','Invalid_NotBlank','Invalid_NotBlank','Invalid_Ocn_State','Invalid_Category','Invalid_AlphaNum','Unknown','Unknown','Invalid_NotBlank','Invalid_NotBlank','Invalid_Alpha','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Char','Invalid_Alpha','Invalid_AlphaNum','Invalid_Phone','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Indicator','Unknown','Invalid_Filename');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Lerg1Raw_Fields.InValidMessage_ocn(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_ocn_name(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_ocn_abbr_name(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_ocn_state(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_category(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_overall_ocn(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_filler1(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_filler2(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_middle_initial(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_title(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_address1(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_floor(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_room(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_city(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_state(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_postal_code(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_target_ocn(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_overall_target_ocn(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_rural_lec_indicator(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_small_ilec_indicator(TotalErrors.ErrorNum),Lerg1Raw_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, Lerg1Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
