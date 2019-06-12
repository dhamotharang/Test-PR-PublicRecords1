IMPORT SALT37;
EXPORT Input_TX_Harris_hygiene(dataset(Input_TX_Harris_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_name1_pcnt := AVE(GROUP,IF(h.name1 = (TYPEOF(h.name1))'',0,100));
    maxlength_name1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1)));
    avelength_name1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1)),h.name1<>(typeof(h.name1))'');
    populated_name2_pcnt := AVE(GROUP,IF(h.name2 = (TYPEOF(h.name2))'',0,100));
    maxlength_name2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2)));
    avelength_name2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2)),h.name2<>(typeof(h.name2))'');
    populated_date_filed_pcnt := AVE(GROUP,IF(h.date_filed = (TYPEOF(h.date_filed))'',0,100));
    maxlength_date_filed := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_filed)));
    avelength_date_filed := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_filed)),h.date_filed<>(typeof(h.date_filed))'');
    populated_file_number_pcnt := AVE(GROUP,IF(h.file_number = (TYPEOF(h.file_number))'',0,100));
    maxlength_file_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)));
    avelength_file_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)),h.file_number<>(typeof(h.file_number))'');
    populated_prep_addr1_line1_pcnt := AVE(GROUP,IF(h.prep_addr1_line1 = (TYPEOF(h.prep_addr1_line1))'',0,100));
    maxlength_prep_addr1_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr1_line1)));
    avelength_prep_addr1_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr1_line1)),h.prep_addr1_line1<>(typeof(h.prep_addr1_line1))'');
    populated_prep_addr1_line_last_pcnt := AVE(GROUP,IF(h.prep_addr1_line_last = (TYPEOF(h.prep_addr1_line_last))'',0,100));
    maxlength_prep_addr1_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr1_line_last)));
    avelength_prep_addr1_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr1_line_last)),h.prep_addr1_line_last<>(typeof(h.prep_addr1_line_last))'');
    populated_prep_addr2_line1_pcnt := AVE(GROUP,IF(h.prep_addr2_line1 = (TYPEOF(h.prep_addr2_line1))'',0,100));
    maxlength_prep_addr2_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr2_line1)));
    avelength_prep_addr2_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr2_line1)),h.prep_addr2_line1<>(typeof(h.prep_addr2_line1))'');
    populated_prep_addr2_line_last_pcnt := AVE(GROUP,IF(h.prep_addr2_line_last = (TYPEOF(h.prep_addr2_line_last))'',0,100));
    maxlength_prep_addr2_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr2_line_last)));
    avelength_prep_addr2_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr2_line_last)),h.prep_addr2_line_last<>(typeof(h.prep_addr2_line_last))'');
    populated_RECORD_TYPE_pcnt := AVE(GROUP,IF(h.RECORD_TYPE = (TYPEOF(h.RECORD_TYPE))'',0,100));
    maxlength_RECORD_TYPE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_TYPE)));
    avelength_RECORD_TYPE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_TYPE)),h.RECORD_TYPE<>(typeof(h.RECORD_TYPE))'');
    populated_STREET_ADD1_pcnt := AVE(GROUP,IF(h.STREET_ADD1 = (TYPEOF(h.STREET_ADD1))'',0,100));
    maxlength_STREET_ADD1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.STREET_ADD1)));
    avelength_STREET_ADD1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.STREET_ADD1)),h.STREET_ADD1<>(typeof(h.STREET_ADD1))'');
    populated_CITY1_pcnt := AVE(GROUP,IF(h.CITY1 = (TYPEOF(h.CITY1))'',0,100));
    maxlength_CITY1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY1)));
    avelength_CITY1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY1)),h.CITY1<>(typeof(h.CITY1))'');
    populated_STATE1_pcnt := AVE(GROUP,IF(h.STATE1 = (TYPEOF(h.STATE1))'',0,100));
    maxlength_STATE1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.STATE1)));
    avelength_STATE1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.STATE1)),h.STATE1<>(typeof(h.STATE1))'');
    populated_ZIP1_pcnt := AVE(GROUP,IF(h.ZIP1 = (TYPEOF(h.ZIP1))'',0,100));
    maxlength_ZIP1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP1)));
    avelength_ZIP1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP1)),h.ZIP1<>(typeof(h.ZIP1))'');
    populated_TERM_pcnt := AVE(GROUP,IF(h.TERM = (TYPEOF(h.TERM))'',0,100));
    maxlength_TERM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.TERM)));
    avelength_TERM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.TERM)),h.TERM<>(typeof(h.TERM))'');
    populated_STREET_ADD2_pcnt := AVE(GROUP,IF(h.STREET_ADD2 = (TYPEOF(h.STREET_ADD2))'',0,100));
    maxlength_STREET_ADD2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.STREET_ADD2)));
    avelength_STREET_ADD2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.STREET_ADD2)),h.STREET_ADD2<>(typeof(h.STREET_ADD2))'');
    populated_CITY2_pcnt := AVE(GROUP,IF(h.CITY2 = (TYPEOF(h.CITY2))'',0,100));
    maxlength_CITY2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY2)));
    avelength_CITY2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY2)),h.CITY2<>(typeof(h.CITY2))'');
    populated_STATE2_pcnt := AVE(GROUP,IF(h.STATE2 = (TYPEOF(h.STATE2))'',0,100));
    maxlength_STATE2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.STATE2)));
    avelength_STATE2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.STATE2)),h.STATE2<>(typeof(h.STATE2))'');
    populated_ZIP2_pcnt := AVE(GROUP,IF(h.ZIP2 = (TYPEOF(h.ZIP2))'',0,100));
    maxlength_ZIP2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP2)));
    avelength_ZIP2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP2)),h.ZIP2<>(typeof(h.ZIP2))'');
    populated_FILM_CODE_pcnt := AVE(GROUP,IF(h.FILM_CODE = (TYPEOF(h.FILM_CODE))'',0,100));
    maxlength_FILM_CODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FILM_CODE)));
    avelength_FILM_CODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FILM_CODE)),h.FILM_CODE<>(typeof(h.FILM_CODE))'');
    populated_BUS_TYPE_pcnt := AVE(GROUP,IF(h.BUS_TYPE = (TYPEOF(h.BUS_TYPE))'',0,100));
    maxlength_BUS_TYPE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUS_TYPE)));
    avelength_BUS_TYPE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUS_TYPE)),h.BUS_TYPE<>(typeof(h.BUS_TYPE))'');
    populated_ANNEX_CODE_pcnt := AVE(GROUP,IF(h.ANNEX_CODE = (TYPEOF(h.ANNEX_CODE))'',0,100));
    maxlength_ANNEX_CODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ANNEX_CODE)));
    avelength_ANNEX_CODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ANNEX_CODE)),h.ANNEX_CODE<>(typeof(h.ANNEX_CODE))'');
    populated_NUM_PAGES_pcnt := AVE(GROUP,IF(h.NUM_PAGES = (TYPEOF(h.NUM_PAGES))'',0,100));
    maxlength_NUM_PAGES := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.NUM_PAGES)));
    avelength_NUM_PAGES := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.NUM_PAGES)),h.NUM_PAGES<>(typeof(h.NUM_PAGES))'');
    populated_EXPIRED_TERM_pcnt := AVE(GROUP,IF(h.EXPIRED_TERM = (TYPEOF(h.EXPIRED_TERM))'',0,100));
    maxlength_EXPIRED_TERM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EXPIRED_TERM)));
    avelength_EXPIRED_TERM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EXPIRED_TERM)),h.EXPIRED_TERM<>(typeof(h.EXPIRED_TERM))'');
    populated_INCORPORATED_pcnt := AVE(GROUP,IF(h.INCORPORATED = (TYPEOF(h.INCORPORATED))'',0,100));
    maxlength_INCORPORATED := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.INCORPORATED)));
    avelength_INCORPORATED := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.INCORPORATED)),h.INCORPORATED<>(typeof(h.INCORPORATED))'');
    populated_ASSUMED_NAME_pcnt := AVE(GROUP,IF(h.ASSUMED_NAME = (TYPEOF(h.ASSUMED_NAME))'',0,100));
    maxlength_ASSUMED_NAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ASSUMED_NAME)));
    avelength_ASSUMED_NAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ASSUMED_NAME)),h.ASSUMED_NAME<>(typeof(h.ASSUMED_NAME))'');
    populated_name1_title_pcnt := AVE(GROUP,IF(h.name1_title = (TYPEOF(h.name1_title))'',0,100));
    maxlength_name1_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_title)));
    avelength_name1_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_title)),h.name1_title<>(typeof(h.name1_title))'');
    populated_name1_fname_pcnt := AVE(GROUP,IF(h.name1_fname = (TYPEOF(h.name1_fname))'',0,100));
    maxlength_name1_fname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_fname)));
    avelength_name1_fname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_fname)),h.name1_fname<>(typeof(h.name1_fname))'');
    populated_name1_mname_pcnt := AVE(GROUP,IF(h.name1_mname = (TYPEOF(h.name1_mname))'',0,100));
    maxlength_name1_mname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_mname)));
    avelength_name1_mname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_mname)),h.name1_mname<>(typeof(h.name1_mname))'');
    populated_name1_lname_pcnt := AVE(GROUP,IF(h.name1_lname = (TYPEOF(h.name1_lname))'',0,100));
    maxlength_name1_lname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_lname)));
    avelength_name1_lname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_lname)),h.name1_lname<>(typeof(h.name1_lname))'');
    populated_name1_name_suffix_pcnt := AVE(GROUP,IF(h.name1_name_suffix = (TYPEOF(h.name1_name_suffix))'',0,100));
    maxlength_name1_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_name_suffix)));
    avelength_name1_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_name_suffix)),h.name1_name_suffix<>(typeof(h.name1_name_suffix))'');
    populated_name1_name_score_pcnt := AVE(GROUP,IF(h.name1_name_score = (TYPEOF(h.name1_name_score))'',0,100));
    maxlength_name1_name_score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_name_score)));
    avelength_name1_name_score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1_name_score)),h.name1_name_score<>(typeof(h.name1_name_score))'');
    populated_name2_title_pcnt := AVE(GROUP,IF(h.name2_title = (TYPEOF(h.name2_title))'',0,100));
    maxlength_name2_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_title)));
    avelength_name2_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_title)),h.name2_title<>(typeof(h.name2_title))'');
    populated_name2_fname_pcnt := AVE(GROUP,IF(h.name2_fname = (TYPEOF(h.name2_fname))'',0,100));
    maxlength_name2_fname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_fname)));
    avelength_name2_fname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_fname)),h.name2_fname<>(typeof(h.name2_fname))'');
    populated_name2_mname_pcnt := AVE(GROUP,IF(h.name2_mname = (TYPEOF(h.name2_mname))'',0,100));
    maxlength_name2_mname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_mname)));
    avelength_name2_mname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_mname)),h.name2_mname<>(typeof(h.name2_mname))'');
    populated_name2_lname_pcnt := AVE(GROUP,IF(h.name2_lname = (TYPEOF(h.name2_lname))'',0,100));
    maxlength_name2_lname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_lname)));
    avelength_name2_lname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_lname)),h.name2_lname<>(typeof(h.name2_lname))'');
    populated_name2_name_suffix_pcnt := AVE(GROUP,IF(h.name2_name_suffix = (TYPEOF(h.name2_name_suffix))'',0,100));
    maxlength_name2_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_name_suffix)));
    avelength_name2_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_name_suffix)),h.name2_name_suffix<>(typeof(h.name2_name_suffix))'');
    populated_name2_name_score_pcnt := AVE(GROUP,IF(h.name2_name_score = (TYPEOF(h.name2_name_score))'',0,100));
    maxlength_name2_name_score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_name_score)));
    avelength_name2_name_score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2_name_score)),h.name2_name_score<>(typeof(h.name2_name_score))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_name1_pcnt *   0.00 / 100 + T.Populated_name2_pcnt *   0.00 / 100 + T.Populated_date_filed_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_prep_addr1_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr1_line_last_pcnt *   0.00 / 100 + T.Populated_prep_addr2_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr2_line_last_pcnt *   0.00 / 100 + T.Populated_RECORD_TYPE_pcnt *   0.00 / 100 + T.Populated_STREET_ADD1_pcnt *   0.00 / 100 + T.Populated_CITY1_pcnt *   0.00 / 100 + T.Populated_STATE1_pcnt *   0.00 / 100 + T.Populated_ZIP1_pcnt *   0.00 / 100 + T.Populated_TERM_pcnt *   0.00 / 100 + T.Populated_STREET_ADD2_pcnt *   0.00 / 100 + T.Populated_CITY2_pcnt *   0.00 / 100 + T.Populated_STATE2_pcnt *   0.00 / 100 + T.Populated_ZIP2_pcnt *   0.00 / 100 + T.Populated_FILM_CODE_pcnt *   0.00 / 100 + T.Populated_BUS_TYPE_pcnt *   0.00 / 100 + T.Populated_ANNEX_CODE_pcnt *   0.00 / 100 + T.Populated_NUM_PAGES_pcnt *   0.00 / 100 + T.Populated_EXPIRED_TERM_pcnt *   0.00 / 100 + T.Populated_INCORPORATED_pcnt *   0.00 / 100 + T.Populated_ASSUMED_NAME_pcnt *   0.00 / 100 + T.Populated_name1_title_pcnt *   0.00 / 100 + T.Populated_name1_fname_pcnt *   0.00 / 100 + T.Populated_name1_mname_pcnt *   0.00 / 100 + T.Populated_name1_lname_pcnt *   0.00 / 100 + T.Populated_name1_name_suffix_pcnt *   0.00 / 100 + T.Populated_name1_name_score_pcnt *   0.00 / 100 + T.Populated_name2_title_pcnt *   0.00 / 100 + T.Populated_name2_fname_pcnt *   0.00 / 100 + T.Populated_name2_mname_pcnt *   0.00 / 100 + T.Populated_name2_lname_pcnt *   0.00 / 100 + T.Populated_name2_name_suffix_pcnt *   0.00 / 100 + T.Populated_name2_name_score_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'name1','name2','date_filed','file_number','prep_addr1_line1','prep_addr1_line_last','prep_addr2_line1','prep_addr2_line_last','RECORD_TYPE','STREET_ADD1','CITY1','STATE1','ZIP1','TERM','STREET_ADD2','CITY2','STATE2','ZIP2','FILM_CODE','BUS_TYPE','ANNEX_CODE','NUM_PAGES','EXPIRED_TERM','INCORPORATED','ASSUMED_NAME','name1_title','name1_fname','name1_mname','name1_lname','name1_name_suffix','name1_name_score','name2_title','name2_fname','name2_mname','name2_lname','name2_name_suffix','name2_name_score');
  SELF.populated_pcnt := CHOOSE(C,le.populated_name1_pcnt,le.populated_name2_pcnt,le.populated_date_filed_pcnt,le.populated_file_number_pcnt,le.populated_prep_addr1_line1_pcnt,le.populated_prep_addr1_line_last_pcnt,le.populated_prep_addr2_line1_pcnt,le.populated_prep_addr2_line_last_pcnt,le.populated_RECORD_TYPE_pcnt,le.populated_STREET_ADD1_pcnt,le.populated_CITY1_pcnt,le.populated_STATE1_pcnt,le.populated_ZIP1_pcnt,le.populated_TERM_pcnt,le.populated_STREET_ADD2_pcnt,le.populated_CITY2_pcnt,le.populated_STATE2_pcnt,le.populated_ZIP2_pcnt,le.populated_FILM_CODE_pcnt,le.populated_BUS_TYPE_pcnt,le.populated_ANNEX_CODE_pcnt,le.populated_NUM_PAGES_pcnt,le.populated_EXPIRED_TERM_pcnt,le.populated_INCORPORATED_pcnt,le.populated_ASSUMED_NAME_pcnt,le.populated_name1_title_pcnt,le.populated_name1_fname_pcnt,le.populated_name1_mname_pcnt,le.populated_name1_lname_pcnt,le.populated_name1_name_suffix_pcnt,le.populated_name1_name_score_pcnt,le.populated_name2_title_pcnt,le.populated_name2_fname_pcnt,le.populated_name2_mname_pcnt,le.populated_name2_lname_pcnt,le.populated_name2_name_suffix_pcnt,le.populated_name2_name_score_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_name1,le.maxlength_name2,le.maxlength_date_filed,le.maxlength_file_number,le.maxlength_prep_addr1_line1,le.maxlength_prep_addr1_line_last,le.maxlength_prep_addr2_line1,le.maxlength_prep_addr2_line_last,le.maxlength_RECORD_TYPE,le.maxlength_STREET_ADD1,le.maxlength_CITY1,le.maxlength_STATE1,le.maxlength_ZIP1,le.maxlength_TERM,le.maxlength_STREET_ADD2,le.maxlength_CITY2,le.maxlength_STATE2,le.maxlength_ZIP2,le.maxlength_FILM_CODE,le.maxlength_BUS_TYPE,le.maxlength_ANNEX_CODE,le.maxlength_NUM_PAGES,le.maxlength_EXPIRED_TERM,le.maxlength_INCORPORATED,le.maxlength_ASSUMED_NAME,le.maxlength_name1_title,le.maxlength_name1_fname,le.maxlength_name1_mname,le.maxlength_name1_lname,le.maxlength_name1_name_suffix,le.maxlength_name1_name_score,le.maxlength_name2_title,le.maxlength_name2_fname,le.maxlength_name2_mname,le.maxlength_name2_lname,le.maxlength_name2_name_suffix,le.maxlength_name2_name_score);
  SELF.avelength := CHOOSE(C,le.avelength_name1,le.avelength_name2,le.avelength_date_filed,le.avelength_file_number,le.avelength_prep_addr1_line1,le.avelength_prep_addr1_line_last,le.avelength_prep_addr2_line1,le.avelength_prep_addr2_line_last,le.avelength_RECORD_TYPE,le.avelength_STREET_ADD1,le.avelength_CITY1,le.avelength_STATE1,le.avelength_ZIP1,le.avelength_TERM,le.avelength_STREET_ADD2,le.avelength_CITY2,le.avelength_STATE2,le.avelength_ZIP2,le.avelength_FILM_CODE,le.avelength_BUS_TYPE,le.avelength_ANNEX_CODE,le.avelength_NUM_PAGES,le.avelength_EXPIRED_TERM,le.avelength_INCORPORATED,le.avelength_ASSUMED_NAME,le.avelength_name1_title,le.avelength_name1_fname,le.avelength_name1_mname,le.avelength_name1_lname,le.avelength_name1_name_suffix,le.avelength_name1_name_score,le.avelength_name2_title,le.avelength_name2_fname,le.avelength_name2_mname,le.avelength_name2_lname,le.avelength_name2_name_suffix,le.avelength_name2_name_score);
END;
EXPORT invSummary := NORMALIZE(summary0, 37, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.name1),TRIM((SALT37.StrType)le.name2),TRIM((SALT37.StrType)le.date_filed),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prep_addr1_line1),TRIM((SALT37.StrType)le.prep_addr1_line_last),TRIM((SALT37.StrType)le.prep_addr2_line1),TRIM((SALT37.StrType)le.prep_addr2_line_last),TRIM((SALT37.StrType)le.RECORD_TYPE),TRIM((SALT37.StrType)le.STREET_ADD1),TRIM((SALT37.StrType)le.CITY1),TRIM((SALT37.StrType)le.STATE1),TRIM((SALT37.StrType)le.ZIP1),TRIM((SALT37.StrType)le.TERM),TRIM((SALT37.StrType)le.STREET_ADD2),TRIM((SALT37.StrType)le.CITY2),TRIM((SALT37.StrType)le.STATE2),TRIM((SALT37.StrType)le.ZIP2),TRIM((SALT37.StrType)le.FILM_CODE),TRIM((SALT37.StrType)le.BUS_TYPE),TRIM((SALT37.StrType)le.ANNEX_CODE),TRIM((SALT37.StrType)le.NUM_PAGES),TRIM((SALT37.StrType)le.EXPIRED_TERM),TRIM((SALT37.StrType)le.INCORPORATED),TRIM((SALT37.StrType)le.ASSUMED_NAME),TRIM((SALT37.StrType)le.name1_title),TRIM((SALT37.StrType)le.name1_fname),TRIM((SALT37.StrType)le.name1_mname),TRIM((SALT37.StrType)le.name1_lname),TRIM((SALT37.StrType)le.name1_name_suffix),TRIM((SALT37.StrType)le.name1_name_score),TRIM((SALT37.StrType)le.name2_title),TRIM((SALT37.StrType)le.name2_fname),TRIM((SALT37.StrType)le.name2_mname),TRIM((SALT37.StrType)le.name2_lname),TRIM((SALT37.StrType)le.name2_name_suffix),TRIM((SALT37.StrType)le.name2_name_score)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,37,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 37);
  SELF.FldNo2 := 1 + (C % 37);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.name1),TRIM((SALT37.StrType)le.name2),TRIM((SALT37.StrType)le.date_filed),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prep_addr1_line1),TRIM((SALT37.StrType)le.prep_addr1_line_last),TRIM((SALT37.StrType)le.prep_addr2_line1),TRIM((SALT37.StrType)le.prep_addr2_line_last),TRIM((SALT37.StrType)le.RECORD_TYPE),TRIM((SALT37.StrType)le.STREET_ADD1),TRIM((SALT37.StrType)le.CITY1),TRIM((SALT37.StrType)le.STATE1),TRIM((SALT37.StrType)le.ZIP1),TRIM((SALT37.StrType)le.TERM),TRIM((SALT37.StrType)le.STREET_ADD2),TRIM((SALT37.StrType)le.CITY2),TRIM((SALT37.StrType)le.STATE2),TRIM((SALT37.StrType)le.ZIP2),TRIM((SALT37.StrType)le.FILM_CODE),TRIM((SALT37.StrType)le.BUS_TYPE),TRIM((SALT37.StrType)le.ANNEX_CODE),TRIM((SALT37.StrType)le.NUM_PAGES),TRIM((SALT37.StrType)le.EXPIRED_TERM),TRIM((SALT37.StrType)le.INCORPORATED),TRIM((SALT37.StrType)le.ASSUMED_NAME),TRIM((SALT37.StrType)le.name1_title),TRIM((SALT37.StrType)le.name1_fname),TRIM((SALT37.StrType)le.name1_mname),TRIM((SALT37.StrType)le.name1_lname),TRIM((SALT37.StrType)le.name1_name_suffix),TRIM((SALT37.StrType)le.name1_name_score),TRIM((SALT37.StrType)le.name2_title),TRIM((SALT37.StrType)le.name2_fname),TRIM((SALT37.StrType)le.name2_mname),TRIM((SALT37.StrType)le.name2_lname),TRIM((SALT37.StrType)le.name2_name_suffix),TRIM((SALT37.StrType)le.name2_name_score)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.name1),TRIM((SALT37.StrType)le.name2),TRIM((SALT37.StrType)le.date_filed),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prep_addr1_line1),TRIM((SALT37.StrType)le.prep_addr1_line_last),TRIM((SALT37.StrType)le.prep_addr2_line1),TRIM((SALT37.StrType)le.prep_addr2_line_last),TRIM((SALT37.StrType)le.RECORD_TYPE),TRIM((SALT37.StrType)le.STREET_ADD1),TRIM((SALT37.StrType)le.CITY1),TRIM((SALT37.StrType)le.STATE1),TRIM((SALT37.StrType)le.ZIP1),TRIM((SALT37.StrType)le.TERM),TRIM((SALT37.StrType)le.STREET_ADD2),TRIM((SALT37.StrType)le.CITY2),TRIM((SALT37.StrType)le.STATE2),TRIM((SALT37.StrType)le.ZIP2),TRIM((SALT37.StrType)le.FILM_CODE),TRIM((SALT37.StrType)le.BUS_TYPE),TRIM((SALT37.StrType)le.ANNEX_CODE),TRIM((SALT37.StrType)le.NUM_PAGES),TRIM((SALT37.StrType)le.EXPIRED_TERM),TRIM((SALT37.StrType)le.INCORPORATED),TRIM((SALT37.StrType)le.ASSUMED_NAME),TRIM((SALT37.StrType)le.name1_title),TRIM((SALT37.StrType)le.name1_fname),TRIM((SALT37.StrType)le.name1_mname),TRIM((SALT37.StrType)le.name1_lname),TRIM((SALT37.StrType)le.name1_name_suffix),TRIM((SALT37.StrType)le.name1_name_score),TRIM((SALT37.StrType)le.name2_title),TRIM((SALT37.StrType)le.name2_fname),TRIM((SALT37.StrType)le.name2_mname),TRIM((SALT37.StrType)le.name2_lname),TRIM((SALT37.StrType)le.name2_name_suffix),TRIM((SALT37.StrType)le.name2_name_score)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),37*37,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'name1'}
      ,{2,'name2'}
      ,{3,'date_filed'}
      ,{4,'file_number'}
      ,{5,'prep_addr1_line1'}
      ,{6,'prep_addr1_line_last'}
      ,{7,'prep_addr2_line1'}
      ,{8,'prep_addr2_line_last'}
      ,{9,'RECORD_TYPE'}
      ,{10,'STREET_ADD1'}
      ,{11,'CITY1'}
      ,{12,'STATE1'}
      ,{13,'ZIP1'}
      ,{14,'TERM'}
      ,{15,'STREET_ADD2'}
      ,{16,'CITY2'}
      ,{17,'STATE2'}
      ,{18,'ZIP2'}
      ,{19,'FILM_CODE'}
      ,{20,'BUS_TYPE'}
      ,{21,'ANNEX_CODE'}
      ,{22,'NUM_PAGES'}
      ,{23,'EXPIRED_TERM'}
      ,{24,'INCORPORATED'}
      ,{25,'ASSUMED_NAME'}
      ,{26,'name1_title'}
      ,{27,'name1_fname'}
      ,{28,'name1_mname'}
      ,{29,'name1_lname'}
      ,{30,'name1_name_suffix'}
      ,{31,'name1_name_score'}
      ,{32,'name2_title'}
      ,{33,'name2_fname'}
      ,{34,'name2_mname'}
      ,{35,'name2_lname'}
      ,{36,'name2_name_suffix'}
      ,{37,'name2_name_score'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_TX_Harris_Fields.InValid_name1((SALT37.StrType)le.name1),
    Input_TX_Harris_Fields.InValid_name2((SALT37.StrType)le.name2),
    Input_TX_Harris_Fields.InValid_date_filed((SALT37.StrType)le.date_filed),
    Input_TX_Harris_Fields.InValid_file_number((SALT37.StrType)le.file_number),
    Input_TX_Harris_Fields.InValid_prep_addr1_line1((SALT37.StrType)le.prep_addr1_line1),
    Input_TX_Harris_Fields.InValid_prep_addr1_line_last((SALT37.StrType)le.prep_addr1_line_last),
    Input_TX_Harris_Fields.InValid_prep_addr2_line1((SALT37.StrType)le.prep_addr2_line1),
    Input_TX_Harris_Fields.InValid_prep_addr2_line_last((SALT37.StrType)le.prep_addr2_line_last),
    Input_TX_Harris_Fields.InValid_RECORD_TYPE((SALT37.StrType)le.RECORD_TYPE),
    Input_TX_Harris_Fields.InValid_STREET_ADD1((SALT37.StrType)le.STREET_ADD1),
    Input_TX_Harris_Fields.InValid_CITY1((SALT37.StrType)le.CITY1),
    Input_TX_Harris_Fields.InValid_STATE1((SALT37.StrType)le.STATE1),
    Input_TX_Harris_Fields.InValid_ZIP1((SALT37.StrType)le.ZIP1),
    Input_TX_Harris_Fields.InValid_TERM((SALT37.StrType)le.TERM),
    Input_TX_Harris_Fields.InValid_STREET_ADD2((SALT37.StrType)le.STREET_ADD2),
    Input_TX_Harris_Fields.InValid_CITY2((SALT37.StrType)le.CITY2),
    Input_TX_Harris_Fields.InValid_STATE2((SALT37.StrType)le.STATE2),
    Input_TX_Harris_Fields.InValid_ZIP2((SALT37.StrType)le.ZIP2),
    Input_TX_Harris_Fields.InValid_FILM_CODE((SALT37.StrType)le.FILM_CODE),
    Input_TX_Harris_Fields.InValid_BUS_TYPE((SALT37.StrType)le.BUS_TYPE),
    Input_TX_Harris_Fields.InValid_ANNEX_CODE((SALT37.StrType)le.ANNEX_CODE),
    Input_TX_Harris_Fields.InValid_NUM_PAGES((SALT37.StrType)le.NUM_PAGES),
    Input_TX_Harris_Fields.InValid_EXPIRED_TERM((SALT37.StrType)le.EXPIRED_TERM),
    Input_TX_Harris_Fields.InValid_INCORPORATED((SALT37.StrType)le.INCORPORATED),
    Input_TX_Harris_Fields.InValid_ASSUMED_NAME((SALT37.StrType)le.ASSUMED_NAME),
    Input_TX_Harris_Fields.InValid_name1_title((SALT37.StrType)le.name1_title),
    Input_TX_Harris_Fields.InValid_name1_fname((SALT37.StrType)le.name1_fname),
    Input_TX_Harris_Fields.InValid_name1_mname((SALT37.StrType)le.name1_mname),
    Input_TX_Harris_Fields.InValid_name1_lname((SALT37.StrType)le.name1_lname),
    Input_TX_Harris_Fields.InValid_name1_name_suffix((SALT37.StrType)le.name1_name_suffix),
    Input_TX_Harris_Fields.InValid_name1_name_score((SALT37.StrType)le.name1_name_score),
    Input_TX_Harris_Fields.InValid_name2_title((SALT37.StrType)le.name2_title),
    Input_TX_Harris_Fields.InValid_name2_fname((SALT37.StrType)le.name2_fname),
    Input_TX_Harris_Fields.InValid_name2_mname((SALT37.StrType)le.name2_mname),
    Input_TX_Harris_Fields.InValid_name2_lname((SALT37.StrType)le.name2_lname),
    Input_TX_Harris_Fields.InValid_name2_name_suffix((SALT37.StrType)le.name2_name_suffix),
    Input_TX_Harris_Fields.InValid_name2_name_score((SALT37.StrType)le.name2_name_score),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,37,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_TX_Harris_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_TX_Harris_Fields.InValidMessage_name1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name2(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_date_filed(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr1_line1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr1_line_last(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr2_line1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr2_line_last(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_RECORD_TYPE(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_STREET_ADD1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_CITY1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_STATE1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_ZIP1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_TERM(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_STREET_ADD2(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_CITY2(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_STATE2(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_ZIP2(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_FILM_CODE(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_BUS_TYPE(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_ANNEX_CODE(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_NUM_PAGES(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_EXPIRED_TERM(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_INCORPORATED(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_ASSUMED_NAME(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name1_title(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name1_fname(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name1_mname(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name1_lname(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name1_name_suffix(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name1_name_score(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name2_title(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name2_fname(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name2_mname(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name2_lname(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name2_name_suffix(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name2_name_score(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
