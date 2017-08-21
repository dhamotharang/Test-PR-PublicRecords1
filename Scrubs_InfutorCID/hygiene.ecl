IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_InfutorCidBase) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_orig_phonetype_pcnt := AVE(GROUP,IF(h.orig_phonetype = (TYPEOF(h.orig_phonetype))'',0,100));
    maxlength_orig_phonetype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phonetype)));
    avelength_orig_phonetype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phonetype)),h.orig_phonetype<>(typeof(h.orig_phonetype))'');
    populated_orig_directindial_pcnt := AVE(GROUP,IF(h.orig_directindial = (TYPEOF(h.orig_directindial))'',0,100));
    maxlength_orig_directindial := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_directindial)));
    avelength_orig_directindial := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_directindial)),h.orig_directindial<>(typeof(h.orig_directindial))'');
    populated_orig_recordtype_pcnt := AVE(GROUP,IF(h.orig_recordtype = (TYPEOF(h.orig_recordtype))'',0,100));
    maxlength_orig_recordtype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_recordtype)));
    avelength_orig_recordtype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_recordtype)),h.orig_recordtype<>(typeof(h.orig_recordtype))'');
    populated_orig_firstdate_pcnt := AVE(GROUP,IF(h.orig_firstdate = (TYPEOF(h.orig_firstdate))'',0,100));
    maxlength_orig_firstdate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_firstdate)));
    avelength_orig_firstdate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_firstdate)),h.orig_firstdate<>(typeof(h.orig_firstdate))'');
    populated_orig_lastdate_pcnt := AVE(GROUP,IF(h.orig_lastdate = (TYPEOF(h.orig_lastdate))'',0,100));
    maxlength_orig_lastdate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lastdate)));
    avelength_orig_lastdate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lastdate)),h.orig_lastdate<>(typeof(h.orig_lastdate))'');
    populated_orig_telconame_pcnt := AVE(GROUP,IF(h.orig_telconame = (TYPEOF(h.orig_telconame))'',0,100));
    maxlength_orig_telconame := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_telconame)));
    avelength_orig_telconame := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_telconame)),h.orig_telconame<>(typeof(h.orig_telconame))'');
    populated_orig_businessname_pcnt := AVE(GROUP,IF(h.orig_businessname = (TYPEOF(h.orig_businessname))'',0,100));
    maxlength_orig_businessname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_businessname)));
    avelength_orig_businessname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_businessname)),h.orig_businessname<>(typeof(h.orig_businessname))'');
    populated_orig_firstname_pcnt := AVE(GROUP,IF(h.orig_firstname = (TYPEOF(h.orig_firstname))'',0,100));
    maxlength_orig_firstname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_firstname)));
    avelength_orig_firstname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_firstname)),h.orig_firstname<>(typeof(h.orig_firstname))'');
    populated_orig_mi_pcnt := AVE(GROUP,IF(h.orig_mi = (TYPEOF(h.orig_mi))'',0,100));
    maxlength_orig_mi := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_mi)));
    avelength_orig_mi := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_mi)),h.orig_mi<>(typeof(h.orig_mi))'');
    populated_orig_lastname_pcnt := AVE(GROUP,IF(h.orig_lastname = (TYPEOF(h.orig_lastname))'',0,100));
    maxlength_orig_lastname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lastname)));
    avelength_orig_lastname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lastname)),h.orig_lastname<>(typeof(h.orig_lastname))'');
    populated_orig_primaryhousenumber_pcnt := AVE(GROUP,IF(h.orig_primaryhousenumber = (TYPEOF(h.orig_primaryhousenumber))'',0,100));
    maxlength_orig_primaryhousenumber := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primaryhousenumber)));
    avelength_orig_primaryhousenumber := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primaryhousenumber)),h.orig_primaryhousenumber<>(typeof(h.orig_primaryhousenumber))'');
    populated_orig_primarypredirabbrev_pcnt := AVE(GROUP,IF(h.orig_primarypredirabbrev = (TYPEOF(h.orig_primarypredirabbrev))'',0,100));
    maxlength_orig_primarypredirabbrev := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primarypredirabbrev)));
    avelength_orig_primarypredirabbrev := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primarypredirabbrev)),h.orig_primarypredirabbrev<>(typeof(h.orig_primarypredirabbrev))'');
    populated_orig_primarystreetname_pcnt := AVE(GROUP,IF(h.orig_primarystreetname = (TYPEOF(h.orig_primarystreetname))'',0,100));
    maxlength_orig_primarystreetname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primarystreetname)));
    avelength_orig_primarystreetname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primarystreetname)),h.orig_primarystreetname<>(typeof(h.orig_primarystreetname))'');
    populated_orig_primarystreettype_pcnt := AVE(GROUP,IF(h.orig_primarystreettype = (TYPEOF(h.orig_primarystreettype))'',0,100));
    maxlength_orig_primarystreettype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primarystreettype)));
    avelength_orig_primarystreettype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primarystreettype)),h.orig_primarystreettype<>(typeof(h.orig_primarystreettype))'');
    populated_orig_primarypostdirabbrev_pcnt := AVE(GROUP,IF(h.orig_primarypostdirabbrev = (TYPEOF(h.orig_primarypostdirabbrev))'',0,100));
    maxlength_orig_primarypostdirabbrev := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primarypostdirabbrev)));
    avelength_orig_primarypostdirabbrev := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_primarypostdirabbrev)),h.orig_primarypostdirabbrev<>(typeof(h.orig_primarypostdirabbrev))'');
    populated_orig_secondaryapttype_pcnt := AVE(GROUP,IF(h.orig_secondaryapttype = (TYPEOF(h.orig_secondaryapttype))'',0,100));
    maxlength_orig_secondaryapttype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_secondaryapttype)));
    avelength_orig_secondaryapttype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_secondaryapttype)),h.orig_secondaryapttype<>(typeof(h.orig_secondaryapttype))'');
    populated_orig_secondaryaptnbr_pcnt := AVE(GROUP,IF(h.orig_secondaryaptnbr = (TYPEOF(h.orig_secondaryaptnbr))'',0,100));
    maxlength_orig_secondaryaptnbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_secondaryaptnbr)));
    avelength_orig_secondaryaptnbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_secondaryaptnbr)),h.orig_secondaryaptnbr<>(typeof(h.orig_secondaryaptnbr))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_orig_dpbc_pcnt := AVE(GROUP,IF(h.orig_dpbc = (TYPEOF(h.orig_dpbc))'',0,100));
    maxlength_orig_dpbc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_dpbc)));
    avelength_orig_dpbc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_dpbc)),h.orig_dpbc<>(typeof(h.orig_dpbc))'');
    populated_orig_crte_pcnt := AVE(GROUP,IF(h.orig_crte = (TYPEOF(h.orig_crte))'',0,100));
    maxlength_orig_crte := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_crte)));
    avelength_orig_crte := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_crte)),h.orig_crte<>(typeof(h.orig_crte))'');
    populated_orig_cnty_pcnt := AVE(GROUP,IF(h.orig_cnty = (TYPEOF(h.orig_cnty))'',0,100));
    maxlength_orig_cnty := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_cnty)));
    avelength_orig_cnty := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_cnty)),h.orig_cnty<>(typeof(h.orig_cnty))'');
    populated_orig_z4type_pcnt := AVE(GROUP,IF(h.orig_z4type = (TYPEOF(h.orig_z4type))'',0,100));
    maxlength_orig_z4type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_z4type)));
    avelength_orig_z4type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_z4type)),h.orig_z4type<>(typeof(h.orig_z4type))'');
    populated_orig_dpv_pcnt := AVE(GROUP,IF(h.orig_dpv = (TYPEOF(h.orig_dpv))'',0,100));
    maxlength_orig_dpv := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_dpv)));
    avelength_orig_dpv := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_dpv)),h.orig_dpv<>(typeof(h.orig_dpv))'');
    populated_orig_maildeliverabilitycode_pcnt := AVE(GROUP,IF(h.orig_maildeliverabilitycode = (TYPEOF(h.orig_maildeliverabilitycode))'',0,100));
    maxlength_orig_maildeliverabilitycode := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_maildeliverabilitycode)));
    avelength_orig_maildeliverabilitycode := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_maildeliverabilitycode)),h.orig_maildeliverabilitycode<>(typeof(h.orig_maildeliverabilitycode))'');
    populated_orig_addressvalidationdate_pcnt := AVE(GROUP,IF(h.orig_addressvalidationdate = (TYPEOF(h.orig_addressvalidationdate))'',0,100));
    maxlength_orig_addressvalidationdate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_addressvalidationdate)));
    avelength_orig_addressvalidationdate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_addressvalidationdate)),h.orig_addressvalidationdate<>(typeof(h.orig_addressvalidationdate))'');
    populated_orig_filler1_pcnt := AVE(GROUP,IF(h.orig_filler1 = (TYPEOF(h.orig_filler1))'',0,100));
    maxlength_orig_filler1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_filler1)));
    avelength_orig_filler1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_filler1)),h.orig_filler1<>(typeof(h.orig_filler1))'');
    populated_orig_directoryassistanceflag_pcnt := AVE(GROUP,IF(h.orig_directoryassistanceflag = (TYPEOF(h.orig_directoryassistanceflag))'',0,100));
    maxlength_orig_directoryassistanceflag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_directoryassistanceflag)));
    avelength_orig_directoryassistanceflag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_directoryassistanceflag)),h.orig_directoryassistanceflag<>(typeof(h.orig_directoryassistanceflag))'');
    populated_orig_telephoneconfidencescore_pcnt := AVE(GROUP,IF(h.orig_telephoneconfidencescore = (TYPEOF(h.orig_telephoneconfidencescore))'',0,100));
    maxlength_orig_telephoneconfidencescore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_telephoneconfidencescore)));
    avelength_orig_telephoneconfidencescore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_telephoneconfidencescore)),h.orig_telephoneconfidencescore<>(typeof(h.orig_telephoneconfidencescore))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_orig_phonetype_pcnt *   0.00 / 100 + T.Populated_orig_directindial_pcnt *   0.00 / 100 + T.Populated_orig_recordtype_pcnt *   0.00 / 100 + T.Populated_orig_firstdate_pcnt *   0.00 / 100 + T.Populated_orig_lastdate_pcnt *   0.00 / 100 + T.Populated_orig_telconame_pcnt *   0.00 / 100 + T.Populated_orig_businessname_pcnt *   0.00 / 100 + T.Populated_orig_firstname_pcnt *   0.00 / 100 + T.Populated_orig_mi_pcnt *   0.00 / 100 + T.Populated_orig_lastname_pcnt *   0.00 / 100 + T.Populated_orig_primaryhousenumber_pcnt *   0.00 / 100 + T.Populated_orig_primarypredirabbrev_pcnt *   0.00 / 100 + T.Populated_orig_primarystreetname_pcnt *   0.00 / 100 + T.Populated_orig_primarystreettype_pcnt *   0.00 / 100 + T.Populated_orig_primarypostdirabbrev_pcnt *   0.00 / 100 + T.Populated_orig_secondaryapttype_pcnt *   0.00 / 100 + T.Populated_orig_secondaryaptnbr_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_orig_dpbc_pcnt *   0.00 / 100 + T.Populated_orig_crte_pcnt *   0.00 / 100 + T.Populated_orig_cnty_pcnt *   0.00 / 100 + T.Populated_orig_z4type_pcnt *   0.00 / 100 + T.Populated_orig_dpv_pcnt *   0.00 / 100 + T.Populated_orig_maildeliverabilitycode_pcnt *   0.00 / 100 + T.Populated_orig_addressvalidationdate_pcnt *   0.00 / 100 + T.Populated_orig_filler1_pcnt *   0.00 / 100 + T.Populated_orig_directoryassistanceflag_pcnt *   0.00 / 100 + T.Populated_orig_telephoneconfidencescore_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'orig_phone','orig_phonetype','orig_directindial','orig_recordtype','orig_firstdate','orig_lastdate','orig_telconame','orig_businessname','orig_firstname','orig_mi','orig_lastname','orig_primaryhousenumber','orig_primarypredirabbrev','orig_primarystreetname','orig_primarystreettype','orig_primarypostdirabbrev','orig_secondaryapttype','orig_secondaryaptnbr','orig_city','orig_state','orig_zip','orig_zip4','orig_dpbc','orig_crte','orig_cnty','orig_z4type','orig_dpv','orig_maildeliverabilitycode','orig_addressvalidationdate','orig_filler1','orig_directoryassistanceflag','orig_telephoneconfidencescore');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_phone_pcnt,le.populated_orig_phonetype_pcnt,le.populated_orig_directindial_pcnt,le.populated_orig_recordtype_pcnt,le.populated_orig_firstdate_pcnt,le.populated_orig_lastdate_pcnt,le.populated_orig_telconame_pcnt,le.populated_orig_businessname_pcnt,le.populated_orig_firstname_pcnt,le.populated_orig_mi_pcnt,le.populated_orig_lastname_pcnt,le.populated_orig_primaryhousenumber_pcnt,le.populated_orig_primarypredirabbrev_pcnt,le.populated_orig_primarystreetname_pcnt,le.populated_orig_primarystreettype_pcnt,le.populated_orig_primarypostdirabbrev_pcnt,le.populated_orig_secondaryapttype_pcnt,le.populated_orig_secondaryaptnbr_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_zip4_pcnt,le.populated_orig_dpbc_pcnt,le.populated_orig_crte_pcnt,le.populated_orig_cnty_pcnt,le.populated_orig_z4type_pcnt,le.populated_orig_dpv_pcnt,le.populated_orig_maildeliverabilitycode_pcnt,le.populated_orig_addressvalidationdate_pcnt,le.populated_orig_filler1_pcnt,le.populated_orig_directoryassistanceflag_pcnt,le.populated_orig_telephoneconfidencescore_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_phone,le.maxlength_orig_phonetype,le.maxlength_orig_directindial,le.maxlength_orig_recordtype,le.maxlength_orig_firstdate,le.maxlength_orig_lastdate,le.maxlength_orig_telconame,le.maxlength_orig_businessname,le.maxlength_orig_firstname,le.maxlength_orig_mi,le.maxlength_orig_lastname,le.maxlength_orig_primaryhousenumber,le.maxlength_orig_primarypredirabbrev,le.maxlength_orig_primarystreetname,le.maxlength_orig_primarystreettype,le.maxlength_orig_primarypostdirabbrev,le.maxlength_orig_secondaryapttype,le.maxlength_orig_secondaryaptnbr,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_zip4,le.maxlength_orig_dpbc,le.maxlength_orig_crte,le.maxlength_orig_cnty,le.maxlength_orig_z4type,le.maxlength_orig_dpv,le.maxlength_orig_maildeliverabilitycode,le.maxlength_orig_addressvalidationdate,le.maxlength_orig_filler1,le.maxlength_orig_directoryassistanceflag,le.maxlength_orig_telephoneconfidencescore);
  SELF.avelength := CHOOSE(C,le.avelength_orig_phone,le.avelength_orig_phonetype,le.avelength_orig_directindial,le.avelength_orig_recordtype,le.avelength_orig_firstdate,le.avelength_orig_lastdate,le.avelength_orig_telconame,le.avelength_orig_businessname,le.avelength_orig_firstname,le.avelength_orig_mi,le.avelength_orig_lastname,le.avelength_orig_primaryhousenumber,le.avelength_orig_primarypredirabbrev,le.avelength_orig_primarystreetname,le.avelength_orig_primarystreettype,le.avelength_orig_primarypostdirabbrev,le.avelength_orig_secondaryapttype,le.avelength_orig_secondaryaptnbr,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_zip4,le.avelength_orig_dpbc,le.avelength_orig_crte,le.avelength_orig_cnty,le.avelength_orig_z4type,le.avelength_orig_dpv,le.avelength_orig_maildeliverabilitycode,le.avelength_orig_addressvalidationdate,le.avelength_orig_filler1,le.avelength_orig_directoryassistanceflag,le.avelength_orig_telephoneconfidencescore);
END;
EXPORT invSummary := NORMALIZE(summary0, 32, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.orig_phone),TRIM((SALT30.StrType)le.orig_phonetype),TRIM((SALT30.StrType)le.orig_directindial),TRIM((SALT30.StrType)le.orig_recordtype),TRIM((SALT30.StrType)le.orig_firstdate),TRIM((SALT30.StrType)le.orig_lastdate),TRIM((SALT30.StrType)le.orig_telconame),TRIM((SALT30.StrType)le.orig_businessname),TRIM((SALT30.StrType)le.orig_firstname),TRIM((SALT30.StrType)le.orig_mi),TRIM((SALT30.StrType)le.orig_lastname),TRIM((SALT30.StrType)le.orig_primaryhousenumber),TRIM((SALT30.StrType)le.orig_primarypredirabbrev),TRIM((SALT30.StrType)le.orig_primarystreetname),TRIM((SALT30.StrType)le.orig_primarystreettype),TRIM((SALT30.StrType)le.orig_primarypostdirabbrev),TRIM((SALT30.StrType)le.orig_secondaryapttype),TRIM((SALT30.StrType)le.orig_secondaryaptnbr),TRIM((SALT30.StrType)le.orig_city),TRIM((SALT30.StrType)le.orig_state),TRIM((SALT30.StrType)le.orig_zip),TRIM((SALT30.StrType)le.orig_zip4),TRIM((SALT30.StrType)le.orig_dpbc),TRIM((SALT30.StrType)le.orig_crte),TRIM((SALT30.StrType)le.orig_cnty),TRIM((SALT30.StrType)le.orig_z4type),TRIM((SALT30.StrType)le.orig_dpv),TRIM((SALT30.StrType)le.orig_maildeliverabilitycode),TRIM((SALT30.StrType)le.orig_addressvalidationdate),TRIM((SALT30.StrType)le.orig_filler1),TRIM((SALT30.StrType)le.orig_directoryassistanceflag),TRIM((SALT30.StrType)le.orig_telephoneconfidencescore)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,32,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 32);
  SELF.FldNo2 := 1 + (C % 32);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.orig_phone),TRIM((SALT30.StrType)le.orig_phonetype),TRIM((SALT30.StrType)le.orig_directindial),TRIM((SALT30.StrType)le.orig_recordtype),TRIM((SALT30.StrType)le.orig_firstdate),TRIM((SALT30.StrType)le.orig_lastdate),TRIM((SALT30.StrType)le.orig_telconame),TRIM((SALT30.StrType)le.orig_businessname),TRIM((SALT30.StrType)le.orig_firstname),TRIM((SALT30.StrType)le.orig_mi),TRIM((SALT30.StrType)le.orig_lastname),TRIM((SALT30.StrType)le.orig_primaryhousenumber),TRIM((SALT30.StrType)le.orig_primarypredirabbrev),TRIM((SALT30.StrType)le.orig_primarystreetname),TRIM((SALT30.StrType)le.orig_primarystreettype),TRIM((SALT30.StrType)le.orig_primarypostdirabbrev),TRIM((SALT30.StrType)le.orig_secondaryapttype),TRIM((SALT30.StrType)le.orig_secondaryaptnbr),TRIM((SALT30.StrType)le.orig_city),TRIM((SALT30.StrType)le.orig_state),TRIM((SALT30.StrType)le.orig_zip),TRIM((SALT30.StrType)le.orig_zip4),TRIM((SALT30.StrType)le.orig_dpbc),TRIM((SALT30.StrType)le.orig_crte),TRIM((SALT30.StrType)le.orig_cnty),TRIM((SALT30.StrType)le.orig_z4type),TRIM((SALT30.StrType)le.orig_dpv),TRIM((SALT30.StrType)le.orig_maildeliverabilitycode),TRIM((SALT30.StrType)le.orig_addressvalidationdate),TRIM((SALT30.StrType)le.orig_filler1),TRIM((SALT30.StrType)le.orig_directoryassistanceflag),TRIM((SALT30.StrType)le.orig_telephoneconfidencescore)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.orig_phone),TRIM((SALT30.StrType)le.orig_phonetype),TRIM((SALT30.StrType)le.orig_directindial),TRIM((SALT30.StrType)le.orig_recordtype),TRIM((SALT30.StrType)le.orig_firstdate),TRIM((SALT30.StrType)le.orig_lastdate),TRIM((SALT30.StrType)le.orig_telconame),TRIM((SALT30.StrType)le.orig_businessname),TRIM((SALT30.StrType)le.orig_firstname),TRIM((SALT30.StrType)le.orig_mi),TRIM((SALT30.StrType)le.orig_lastname),TRIM((SALT30.StrType)le.orig_primaryhousenumber),TRIM((SALT30.StrType)le.orig_primarypredirabbrev),TRIM((SALT30.StrType)le.orig_primarystreetname),TRIM((SALT30.StrType)le.orig_primarystreettype),TRIM((SALT30.StrType)le.orig_primarypostdirabbrev),TRIM((SALT30.StrType)le.orig_secondaryapttype),TRIM((SALT30.StrType)le.orig_secondaryaptnbr),TRIM((SALT30.StrType)le.orig_city),TRIM((SALT30.StrType)le.orig_state),TRIM((SALT30.StrType)le.orig_zip),TRIM((SALT30.StrType)le.orig_zip4),TRIM((SALT30.StrType)le.orig_dpbc),TRIM((SALT30.StrType)le.orig_crte),TRIM((SALT30.StrType)le.orig_cnty),TRIM((SALT30.StrType)le.orig_z4type),TRIM((SALT30.StrType)le.orig_dpv),TRIM((SALT30.StrType)le.orig_maildeliverabilitycode),TRIM((SALT30.StrType)le.orig_addressvalidationdate),TRIM((SALT30.StrType)le.orig_filler1),TRIM((SALT30.StrType)le.orig_directoryassistanceflag),TRIM((SALT30.StrType)le.orig_telephoneconfidencescore)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),32*32,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orig_phone'}
      ,{2,'orig_phonetype'}
      ,{3,'orig_directindial'}
      ,{4,'orig_recordtype'}
      ,{5,'orig_firstdate'}
      ,{6,'orig_lastdate'}
      ,{7,'orig_telconame'}
      ,{8,'orig_businessname'}
      ,{9,'orig_firstname'}
      ,{10,'orig_mi'}
      ,{11,'orig_lastname'}
      ,{12,'orig_primaryhousenumber'}
      ,{13,'orig_primarypredirabbrev'}
      ,{14,'orig_primarystreetname'}
      ,{15,'orig_primarystreettype'}
      ,{16,'orig_primarypostdirabbrev'}
      ,{17,'orig_secondaryapttype'}
      ,{18,'orig_secondaryaptnbr'}
      ,{19,'orig_city'}
      ,{20,'orig_state'}
      ,{21,'orig_zip'}
      ,{22,'orig_zip4'}
      ,{23,'orig_dpbc'}
      ,{24,'orig_crte'}
      ,{25,'orig_cnty'}
      ,{26,'orig_z4type'}
      ,{27,'orig_dpv'}
      ,{28,'orig_maildeliverabilitycode'}
      ,{29,'orig_addressvalidationdate'}
      ,{30,'orig_filler1'}
      ,{31,'orig_directoryassistanceflag'}
      ,{32,'orig_telephoneconfidencescore'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_orig_phone((SALT30.StrType)le.orig_phone),
    Fields.InValid_orig_phonetype((SALT30.StrType)le.orig_phonetype),
    Fields.InValid_orig_directindial((SALT30.StrType)le.orig_directindial),
    Fields.InValid_orig_recordtype((SALT30.StrType)le.orig_recordtype),
    Fields.InValid_orig_firstdate((SALT30.StrType)le.orig_firstdate),
    Fields.InValid_orig_lastdate((SALT30.StrType)le.orig_lastdate),
    Fields.InValid_orig_telconame((SALT30.StrType)le.orig_telconame),
    Fields.InValid_orig_businessname((SALT30.StrType)le.orig_businessname),
    Fields.InValid_orig_firstname((SALT30.StrType)le.orig_firstname),
    Fields.InValid_orig_mi((SALT30.StrType)le.orig_mi),
    Fields.InValid_orig_lastname((SALT30.StrType)le.orig_lastname),
    Fields.InValid_orig_primaryhousenumber((SALT30.StrType)le.orig_primaryhousenumber),
    Fields.InValid_orig_primarypredirabbrev((SALT30.StrType)le.orig_primarypredirabbrev),
    Fields.InValid_orig_primarystreetname((SALT30.StrType)le.orig_primarystreetname),
    Fields.InValid_orig_primarystreettype((SALT30.StrType)le.orig_primarystreettype),
    Fields.InValid_orig_primarypostdirabbrev((SALT30.StrType)le.orig_primarypostdirabbrev),
    Fields.InValid_orig_secondaryapttype((SALT30.StrType)le.orig_secondaryapttype),
    Fields.InValid_orig_secondaryaptnbr((SALT30.StrType)le.orig_secondaryaptnbr),
    Fields.InValid_orig_city((SALT30.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT30.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT30.StrType)le.orig_zip),
    Fields.InValid_orig_zip4((SALT30.StrType)le.orig_zip4),
    Fields.InValid_orig_dpbc((SALT30.StrType)le.orig_dpbc),
    Fields.InValid_orig_crte((SALT30.StrType)le.orig_crte),
    Fields.InValid_orig_cnty((SALT30.StrType)le.orig_cnty),
    Fields.InValid_orig_z4type((SALT30.StrType)le.orig_z4type),
    Fields.InValid_orig_dpv((SALT30.StrType)le.orig_dpv),
    Fields.InValid_orig_maildeliverabilitycode((SALT30.StrType)le.orig_maildeliverabilitycode),
    Fields.InValid_orig_addressvalidationdate((SALT30.StrType)le.orig_addressvalidationdate),
    Fields.InValid_orig_filler1((SALT30.StrType)le.orig_filler1),
    Fields.InValid_orig_directoryassistanceflag((SALT30.StrType)le.orig_directoryassistanceflag),
    Fields.InValid_orig_telephoneconfidencescore((SALT30.StrType)le.orig_telephoneconfidencescore),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,32,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_phone','invalid_phonetype','invalid_directindial','invalid_recordtype','invalid_date','invalid_date','invalid_namealpha','invalid_namealpha','invalid_namealpha','invalid_namealpha','invalid_namealpha','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_orig_city','invalid_state','invalid_zip','invalid_zip','invalid_dpbc','Unknown','Unknown','invalid_z4type','invalid_dpv','invalid_maildeliverabilitycode','invalid_date','Unknown','invalid_directoryassistanceflag','invalid_telephoneconfidencescore');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phonetype(TotalErrors.ErrorNum),Fields.InValidMessage_orig_directindial(TotalErrors.ErrorNum),Fields.InValidMessage_orig_recordtype(TotalErrors.ErrorNum),Fields.InValidMessage_orig_firstdate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lastdate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_telconame(TotalErrors.ErrorNum),Fields.InValidMessage_orig_businessname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mi(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_primaryhousenumber(TotalErrors.ErrorNum),Fields.InValidMessage_orig_primarypredirabbrev(TotalErrors.ErrorNum),Fields.InValidMessage_orig_primarystreetname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_primarystreettype(TotalErrors.ErrorNum),Fields.InValidMessage_orig_primarypostdirabbrev(TotalErrors.ErrorNum),Fields.InValidMessage_orig_secondaryapttype(TotalErrors.ErrorNum),Fields.InValidMessage_orig_secondaryaptnbr(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_orig_crte(TotalErrors.ErrorNum),Fields.InValidMessage_orig_cnty(TotalErrors.ErrorNum),Fields.InValidMessage_orig_z4type(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dpv(TotalErrors.ErrorNum),Fields.InValidMessage_orig_maildeliverabilitycode(TotalErrors.ErrorNum),Fields.InValidMessage_orig_addressvalidationdate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_filler1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_directoryassistanceflag(TotalErrors.ErrorNum),Fields.InValidMessage_orig_telephoneconfidencescore(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
