IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Orbit) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_item_id_cnt := COUNT(GROUP,h.item_id <> (TYPEOF(h.item_id))'');
    populated_item_id_pcnt := AVE(GROUP,IF(h.item_id = (TYPEOF(h.item_id))'',0,100));
    maxlength_item_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_id)));
    avelength_item_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_id)),h.item_id<>(typeof(h.item_id))'');
    populated_item_name_cnt := COUNT(GROUP,h.item_name <> (TYPEOF(h.item_name))'');
    populated_item_name_pcnt := AVE(GROUP,IF(h.item_name = (TYPEOF(h.item_name))'',0,100));
    maxlength_item_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_name)));
    avelength_item_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_name)),h.item_name<>(typeof(h.item_name))'');
    populated_item_description_cnt := COUNT(GROUP,h.item_description <> (TYPEOF(h.item_description))'');
    populated_item_description_pcnt := AVE(GROUP,IF(h.item_description = (TYPEOF(h.item_description))'',0,100));
    maxlength_item_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_description)));
    avelength_item_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_description)),h.item_description<>(typeof(h.item_description))'');
    populated_status_name_cnt := COUNT(GROUP,h.status_name <> (TYPEOF(h.status_name))'');
    populated_status_name_pcnt := AVE(GROUP,IF(h.status_name = (TYPEOF(h.status_name))'',0,100));
    maxlength_status_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.status_name)));
    avelength_status_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.status_name)),h.status_name<>(typeof(h.status_name))'');
    populated_item_source_code_cnt := COUNT(GROUP,h.item_source_code <> (TYPEOF(h.item_source_code))'');
    populated_item_source_code_pcnt := AVE(GROUP,IF(h.item_source_code = (TYPEOF(h.item_source_code))'',0,100));
    maxlength_item_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_source_code)));
    avelength_item_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_source_code)),h.item_source_code<>(typeof(h.item_source_code))'');
    populated_source_id_cnt := COUNT(GROUP,h.source_id <> (TYPEOF(h.source_id))'');
    populated_source_id_pcnt := AVE(GROUP,IF(h.source_id = (TYPEOF(h.source_id))'',0,100));
    maxlength_source_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_id)));
    avelength_source_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_id)),h.source_id<>(typeof(h.source_id))'');
    populated_source_name_cnt := COUNT(GROUP,h.source_name <> (TYPEOF(h.source_name))'');
    populated_source_name_pcnt := AVE(GROUP,IF(h.source_name = (TYPEOF(h.source_name))'',0,100));
    maxlength_source_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_name)));
    avelength_source_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_name)),h.source_name<>(typeof(h.source_name))'');
    populated_source_address1_cnt := COUNT(GROUP,h.source_address1 <> (TYPEOF(h.source_address1))'');
    populated_source_address1_pcnt := AVE(GROUP,IF(h.source_address1 = (TYPEOF(h.source_address1))'',0,100));
    maxlength_source_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_address1)));
    avelength_source_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_address1)),h.source_address1<>(typeof(h.source_address1))'');
    populated_source_address2_cnt := COUNT(GROUP,h.source_address2 <> (TYPEOF(h.source_address2))'');
    populated_source_address2_pcnt := AVE(GROUP,IF(h.source_address2 = (TYPEOF(h.source_address2))'',0,100));
    maxlength_source_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_address2)));
    avelength_source_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_address2)),h.source_address2<>(typeof(h.source_address2))'');
    populated_source_city_cnt := COUNT(GROUP,h.source_city <> (TYPEOF(h.source_city))'');
    populated_source_city_pcnt := AVE(GROUP,IF(h.source_city = (TYPEOF(h.source_city))'',0,100));
    maxlength_source_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_city)));
    avelength_source_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_city)),h.source_city<>(typeof(h.source_city))'');
    populated_source_state_cnt := COUNT(GROUP,h.source_state <> (TYPEOF(h.source_state))'');
    populated_source_state_pcnt := AVE(GROUP,IF(h.source_state = (TYPEOF(h.source_state))'',0,100));
    maxlength_source_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_state)));
    avelength_source_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_state)),h.source_state<>(typeof(h.source_state))'');
    populated_source_zip_cnt := COUNT(GROUP,h.source_zip <> (TYPEOF(h.source_zip))'');
    populated_source_zip_pcnt := AVE(GROUP,IF(h.source_zip = (TYPEOF(h.source_zip))'',0,100));
    maxlength_source_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_zip)));
    avelength_source_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_zip)),h.source_zip<>(typeof(h.source_zip))'');
    populated_source_phone_cnt := COUNT(GROUP,h.source_phone <> (TYPEOF(h.source_phone))'');
    populated_source_phone_pcnt := AVE(GROUP,IF(h.source_phone = (TYPEOF(h.source_phone))'',0,100));
    maxlength_source_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_phone)));
    avelength_source_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_phone)),h.source_phone<>(typeof(h.source_phone))'');
    populated_source_website_cnt := COUNT(GROUP,h.source_website <> (TYPEOF(h.source_website))'');
    populated_source_website_pcnt := AVE(GROUP,IF(h.source_website = (TYPEOF(h.source_website))'',0,100));
    maxlength_source_website := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_website)));
    avelength_source_website := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_website)),h.source_website<>(typeof(h.source_website))'');
    populated_unused_source_sourcecodes_cnt := COUNT(GROUP,h.unused_source_sourcecodes <> (TYPEOF(h.unused_source_sourcecodes))'');
    populated_unused_source_sourcecodes_pcnt := AVE(GROUP,IF(h.unused_source_sourcecodes = (TYPEOF(h.unused_source_sourcecodes))'',0,100));
    maxlength_unused_source_sourcecodes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_source_sourcecodes)));
    avelength_unused_source_sourcecodes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_source_sourcecodes)),h.unused_source_sourcecodes<>(typeof(h.unused_source_sourcecodes))'');
    populated_unused_fcra_cnt := COUNT(GROUP,h.unused_fcra <> (TYPEOF(h.unused_fcra))'');
    populated_unused_fcra_pcnt := AVE(GROUP,IF(h.unused_fcra = (TYPEOF(h.unused_fcra))'',0,100));
    maxlength_unused_fcra := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_fcra)));
    avelength_unused_fcra := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_fcra)),h.unused_fcra<>(typeof(h.unused_fcra))'');
    populated_unused_fcra_comments_cnt := COUNT(GROUP,h.unused_fcra_comments <> (TYPEOF(h.unused_fcra_comments))'');
    populated_unused_fcra_comments_pcnt := AVE(GROUP,IF(h.unused_fcra_comments = (TYPEOF(h.unused_fcra_comments))'',0,100));
    maxlength_unused_fcra_comments := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_fcra_comments)));
    avelength_unused_fcra_comments := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_fcra_comments)),h.unused_fcra_comments<>(typeof(h.unused_fcra_comments))'');
    populated_market_restrict_flag_cnt := COUNT(GROUP,h.market_restrict_flag <> (TYPEOF(h.market_restrict_flag))'');
    populated_market_restrict_flag_pcnt := AVE(GROUP,IF(h.market_restrict_flag = (TYPEOF(h.market_restrict_flag))'',0,100));
    maxlength_market_restrict_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_restrict_flag)));
    avelength_market_restrict_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_restrict_flag)),h.market_restrict_flag<>(typeof(h.market_restrict_flag))'');
    populated_unused_market_comments_cnt := COUNT(GROUP,h.unused_market_comments <> (TYPEOF(h.unused_market_comments))'');
    populated_unused_market_comments_pcnt := AVE(GROUP,IF(h.unused_market_comments = (TYPEOF(h.unused_market_comments))'',0,100));
    maxlength_unused_market_comments := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_market_comments)));
    avelength_unused_market_comments := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_market_comments)),h.unused_market_comments<>(typeof(h.unused_market_comments))'');
    populated_unused_contact_category_name_cnt := COUNT(GROUP,h.unused_contact_category_name <> (TYPEOF(h.unused_contact_category_name))'');
    populated_unused_contact_category_name_pcnt := AVE(GROUP,IF(h.unused_contact_category_name = (TYPEOF(h.unused_contact_category_name))'',0,100));
    maxlength_unused_contact_category_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_contact_category_name)));
    avelength_unused_contact_category_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_contact_category_name)),h.unused_contact_category_name<>(typeof(h.unused_contact_category_name))'');
    populated_unused_contact_name_cnt := COUNT(GROUP,h.unused_contact_name <> (TYPEOF(h.unused_contact_name))'');
    populated_unused_contact_name_pcnt := AVE(GROUP,IF(h.unused_contact_name = (TYPEOF(h.unused_contact_name))'',0,100));
    maxlength_unused_contact_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_contact_name)));
    avelength_unused_contact_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_contact_name)),h.unused_contact_name<>(typeof(h.unused_contact_name))'');
    populated_unused_contact_phone_cnt := COUNT(GROUP,h.unused_contact_phone <> (TYPEOF(h.unused_contact_phone))'');
    populated_unused_contact_phone_pcnt := AVE(GROUP,IF(h.unused_contact_phone = (TYPEOF(h.unused_contact_phone))'',0,100));
    maxlength_unused_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_contact_phone)));
    avelength_unused_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_contact_phone)),h.unused_contact_phone<>(typeof(h.unused_contact_phone))'');
    populated_unused_contact_email_cnt := COUNT(GROUP,h.unused_contact_email <> (TYPEOF(h.unused_contact_email))'');
    populated_unused_contact_email_pcnt := AVE(GROUP,IF(h.unused_contact_email = (TYPEOF(h.unused_contact_email))'',0,100));
    maxlength_unused_contact_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_contact_email)));
    avelength_unused_contact_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unused_contact_email)),h.unused_contact_email<>(typeof(h.unused_contact_email))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_item_id_pcnt *   0.00 / 100 + T.Populated_item_name_pcnt *   0.00 / 100 + T.Populated_item_description_pcnt *   0.00 / 100 + T.Populated_status_name_pcnt *   0.00 / 100 + T.Populated_item_source_code_pcnt *   0.00 / 100 + T.Populated_source_id_pcnt *   0.00 / 100 + T.Populated_source_name_pcnt *   0.00 / 100 + T.Populated_source_address1_pcnt *   0.00 / 100 + T.Populated_source_address2_pcnt *   0.00 / 100 + T.Populated_source_city_pcnt *   0.00 / 100 + T.Populated_source_state_pcnt *   0.00 / 100 + T.Populated_source_zip_pcnt *   0.00 / 100 + T.Populated_source_phone_pcnt *   0.00 / 100 + T.Populated_source_website_pcnt *   0.00 / 100 + T.Populated_unused_source_sourcecodes_pcnt *   0.00 / 100 + T.Populated_unused_fcra_pcnt *   0.00 / 100 + T.Populated_unused_fcra_comments_pcnt *   0.00 / 100 + T.Populated_market_restrict_flag_pcnt *   0.00 / 100 + T.Populated_unused_market_comments_pcnt *   0.00 / 100 + T.Populated_unused_contact_category_name_pcnt *   0.00 / 100 + T.Populated_unused_contact_name_pcnt *   0.00 / 100 + T.Populated_unused_contact_phone_pcnt *   0.00 / 100 + T.Populated_unused_contact_email_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'item_id','item_name','item_description','status_name','item_source_code','source_id','source_name','source_address1','source_address2','source_city','source_state','source_zip','source_phone','source_website','unused_source_sourcecodes','unused_fcra','unused_fcra_comments','market_restrict_flag','unused_market_comments','unused_contact_category_name','unused_contact_name','unused_contact_phone','unused_contact_email');
  SELF.populated_pcnt := CHOOSE(C,le.populated_item_id_pcnt,le.populated_item_name_pcnt,le.populated_item_description_pcnt,le.populated_status_name_pcnt,le.populated_item_source_code_pcnt,le.populated_source_id_pcnt,le.populated_source_name_pcnt,le.populated_source_address1_pcnt,le.populated_source_address2_pcnt,le.populated_source_city_pcnt,le.populated_source_state_pcnt,le.populated_source_zip_pcnt,le.populated_source_phone_pcnt,le.populated_source_website_pcnt,le.populated_unused_source_sourcecodes_pcnt,le.populated_unused_fcra_pcnt,le.populated_unused_fcra_comments_pcnt,le.populated_market_restrict_flag_pcnt,le.populated_unused_market_comments_pcnt,le.populated_unused_contact_category_name_pcnt,le.populated_unused_contact_name_pcnt,le.populated_unused_contact_phone_pcnt,le.populated_unused_contact_email_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_item_id,le.maxlength_item_name,le.maxlength_item_description,le.maxlength_status_name,le.maxlength_item_source_code,le.maxlength_source_id,le.maxlength_source_name,le.maxlength_source_address1,le.maxlength_source_address2,le.maxlength_source_city,le.maxlength_source_state,le.maxlength_source_zip,le.maxlength_source_phone,le.maxlength_source_website,le.maxlength_unused_source_sourcecodes,le.maxlength_unused_fcra,le.maxlength_unused_fcra_comments,le.maxlength_market_restrict_flag,le.maxlength_unused_market_comments,le.maxlength_unused_contact_category_name,le.maxlength_unused_contact_name,le.maxlength_unused_contact_phone,le.maxlength_unused_contact_email);
  SELF.avelength := CHOOSE(C,le.avelength_item_id,le.avelength_item_name,le.avelength_item_description,le.avelength_status_name,le.avelength_item_source_code,le.avelength_source_id,le.avelength_source_name,le.avelength_source_address1,le.avelength_source_address2,le.avelength_source_city,le.avelength_source_state,le.avelength_source_zip,le.avelength_source_phone,le.avelength_source_website,le.avelength_unused_source_sourcecodes,le.avelength_unused_fcra,le.avelength_unused_fcra_comments,le.avelength_market_restrict_flag,le.avelength_unused_market_comments,le.avelength_unused_contact_category_name,le.avelength_unused_contact_name,le.avelength_unused_contact_phone,le.avelength_unused_contact_email);
END;
EXPORT invSummary := NORMALIZE(summary0, 23, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.item_id),TRIM((SALT311.StrType)le.item_name),TRIM((SALT311.StrType)le.item_description),TRIM((SALT311.StrType)le.status_name),TRIM((SALT311.StrType)le.item_source_code),TRIM((SALT311.StrType)le.source_id),TRIM((SALT311.StrType)le.source_name),TRIM((SALT311.StrType)le.source_address1),TRIM((SALT311.StrType)le.source_address2),TRIM((SALT311.StrType)le.source_city),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_zip),TRIM((SALT311.StrType)le.source_phone),TRIM((SALT311.StrType)le.source_website),TRIM((SALT311.StrType)le.unused_source_sourcecodes),TRIM((SALT311.StrType)le.unused_fcra),TRIM((SALT311.StrType)le.unused_fcra_comments),TRIM((SALT311.StrType)le.market_restrict_flag),TRIM((SALT311.StrType)le.unused_market_comments),TRIM((SALT311.StrType)le.unused_contact_category_name),TRIM((SALT311.StrType)le.unused_contact_name),TRIM((SALT311.StrType)le.unused_contact_phone),TRIM((SALT311.StrType)le.unused_contact_email)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,23,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 23);
  SELF.FldNo2 := 1 + (C % 23);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.item_id),TRIM((SALT311.StrType)le.item_name),TRIM((SALT311.StrType)le.item_description),TRIM((SALT311.StrType)le.status_name),TRIM((SALT311.StrType)le.item_source_code),TRIM((SALT311.StrType)le.source_id),TRIM((SALT311.StrType)le.source_name),TRIM((SALT311.StrType)le.source_address1),TRIM((SALT311.StrType)le.source_address2),TRIM((SALT311.StrType)le.source_city),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_zip),TRIM((SALT311.StrType)le.source_phone),TRIM((SALT311.StrType)le.source_website),TRIM((SALT311.StrType)le.unused_source_sourcecodes),TRIM((SALT311.StrType)le.unused_fcra),TRIM((SALT311.StrType)le.unused_fcra_comments),TRIM((SALT311.StrType)le.market_restrict_flag),TRIM((SALT311.StrType)le.unused_market_comments),TRIM((SALT311.StrType)le.unused_contact_category_name),TRIM((SALT311.StrType)le.unused_contact_name),TRIM((SALT311.StrType)le.unused_contact_phone),TRIM((SALT311.StrType)le.unused_contact_email)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.item_id),TRIM((SALT311.StrType)le.item_name),TRIM((SALT311.StrType)le.item_description),TRIM((SALT311.StrType)le.status_name),TRIM((SALT311.StrType)le.item_source_code),TRIM((SALT311.StrType)le.source_id),TRIM((SALT311.StrType)le.source_name),TRIM((SALT311.StrType)le.source_address1),TRIM((SALT311.StrType)le.source_address2),TRIM((SALT311.StrType)le.source_city),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_zip),TRIM((SALT311.StrType)le.source_phone),TRIM((SALT311.StrType)le.source_website),TRIM((SALT311.StrType)le.unused_source_sourcecodes),TRIM((SALT311.StrType)le.unused_fcra),TRIM((SALT311.StrType)le.unused_fcra_comments),TRIM((SALT311.StrType)le.market_restrict_flag),TRIM((SALT311.StrType)le.unused_market_comments),TRIM((SALT311.StrType)le.unused_contact_category_name),TRIM((SALT311.StrType)le.unused_contact_name),TRIM((SALT311.StrType)le.unused_contact_phone),TRIM((SALT311.StrType)le.unused_contact_email)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),23*23,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'item_id'}
      ,{2,'item_name'}
      ,{3,'item_description'}
      ,{4,'status_name'}
      ,{5,'item_source_code'}
      ,{6,'source_id'}
      ,{7,'source_name'}
      ,{8,'source_address1'}
      ,{9,'source_address2'}
      ,{10,'source_city'}
      ,{11,'source_state'}
      ,{12,'source_zip'}
      ,{13,'source_phone'}
      ,{14,'source_website'}
      ,{15,'unused_source_sourcecodes'}
      ,{16,'unused_fcra'}
      ,{17,'unused_fcra_comments'}
      ,{18,'market_restrict_flag'}
      ,{19,'unused_market_comments'}
      ,{20,'unused_contact_category_name'}
      ,{21,'unused_contact_name'}
      ,{22,'unused_contact_phone'}
      ,{23,'unused_contact_email'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_item_id((SALT311.StrType)le.item_id),
    Fields.InValid_item_name((SALT311.StrType)le.item_name),
    Fields.InValid_item_description((SALT311.StrType)le.item_description),
    Fields.InValid_status_name((SALT311.StrType)le.status_name),
    Fields.InValid_item_source_code((SALT311.StrType)le.item_source_code),
    Fields.InValid_source_id((SALT311.StrType)le.source_id),
    Fields.InValid_source_name((SALT311.StrType)le.source_name),
    Fields.InValid_source_address1((SALT311.StrType)le.source_address1),
    Fields.InValid_source_address2((SALT311.StrType)le.source_address2),
    Fields.InValid_source_city((SALT311.StrType)le.source_city),
    Fields.InValid_source_state((SALT311.StrType)le.source_state),
    Fields.InValid_source_zip((SALT311.StrType)le.source_zip),
    Fields.InValid_source_phone((SALT311.StrType)le.source_phone),
    Fields.InValid_source_website((SALT311.StrType)le.source_website),
    Fields.InValid_unused_source_sourcecodes((SALT311.StrType)le.unused_source_sourcecodes),
    Fields.InValid_unused_fcra((SALT311.StrType)le.unused_fcra),
    Fields.InValid_unused_fcra_comments((SALT311.StrType)le.unused_fcra_comments),
    Fields.InValid_market_restrict_flag((SALT311.StrType)le.market_restrict_flag),
    Fields.InValid_unused_market_comments((SALT311.StrType)le.unused_market_comments),
    Fields.InValid_unused_contact_category_name((SALT311.StrType)le.unused_contact_category_name),
    Fields.InValid_unused_contact_name((SALT311.StrType)le.unused_contact_name),
    Fields.InValid_unused_contact_phone((SALT311.StrType)le.unused_contact_phone),
    Fields.InValid_unused_contact_email((SALT311.StrType)le.unused_contact_email),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,23,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_item_id(TotalErrors.ErrorNum),Fields.InValidMessage_item_name(TotalErrors.ErrorNum),Fields.InValidMessage_item_description(TotalErrors.ErrorNum),Fields.InValidMessage_status_name(TotalErrors.ErrorNum),Fields.InValidMessage_item_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_source_id(TotalErrors.ErrorNum),Fields.InValidMessage_source_name(TotalErrors.ErrorNum),Fields.InValidMessage_source_address1(TotalErrors.ErrorNum),Fields.InValidMessage_source_address2(TotalErrors.ErrorNum),Fields.InValidMessage_source_city(TotalErrors.ErrorNum),Fields.InValidMessage_source_state(TotalErrors.ErrorNum),Fields.InValidMessage_source_zip(TotalErrors.ErrorNum),Fields.InValidMessage_source_phone(TotalErrors.ErrorNum),Fields.InValidMessage_source_website(TotalErrors.ErrorNum),Fields.InValidMessage_unused_source_sourcecodes(TotalErrors.ErrorNum),Fields.InValidMessage_unused_fcra(TotalErrors.ErrorNum),Fields.InValidMessage_unused_fcra_comments(TotalErrors.ErrorNum),Fields.InValidMessage_market_restrict_flag(TotalErrors.ErrorNum),Fields.InValidMessage_unused_market_comments(TotalErrors.ErrorNum),Fields.InValidMessage_unused_contact_category_name(TotalErrors.ErrorNum),Fields.InValidMessage_unused_contact_name(TotalErrors.ErrorNum),Fields.InValidMessage_unused_contact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_unused_contact_email(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(_Scrubs_VendorSrc_Orbit, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
