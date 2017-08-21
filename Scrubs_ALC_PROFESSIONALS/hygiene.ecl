IMPORT ut,SALT32;
EXPORT hygiene(dataset(layout_ALC_PROFESSIONALS) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_company_pcnt := AVE(GROUP,IF(h.company = (TYPEOF(h.company))'',0,100));
    maxlength_company := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company)));
    avelength_company := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company)),h.company<>(typeof(h.company))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_bar_pcnt := AVE(GROUP,IF(h.bar = (TYPEOF(h.bar))'',0,100));
    maxlength_bar := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.bar)));
    avelength_bar := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.bar)),h.bar<>(typeof(h.bar))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_postal_cd_pcnt := AVE(GROUP,IF(h.postal_cd = (TYPEOF(h.postal_cd))'',0,100));
    maxlength_postal_cd := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.postal_cd)));
    avelength_postal_cd := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.postal_cd)),h.postal_cd<>(typeof(h.postal_cd))'');
    populated_dpv_pcnt := AVE(GROUP,IF(h.dpv = (TYPEOF(h.dpv))'',0,100));
    maxlength_dpv := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dpv)));
    avelength_dpv := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dpv)),h.dpv<>(typeof(h.dpv))'');
    populated_addr_type_pcnt := AVE(GROUP,IF(h.addr_type = (TYPEOF(h.addr_type))'',0,100));
    maxlength_addr_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.addr_type)));
    avelength_addr_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.addr_type)),h.addr_type<>(typeof(h.addr_type))'');
    populated_county_cd_pcnt := AVE(GROUP,IF(h.county_cd = (TYPEOF(h.county_cd))'',0,100));
    maxlength_county_cd := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.county_cd)));
    avelength_county_cd := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.county_cd)),h.county_cd<>(typeof(h.county_cd))'');
    populated_license_class_pcnt := AVE(GROUP,IF(h.license_class = (TYPEOF(h.license_class))'',0,100));
    maxlength_license_class := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.license_class)));
    avelength_license_class := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.license_class)),h.license_class<>(typeof(h.license_class))'');
    populated_license_state_pcnt := AVE(GROUP,IF(h.license_state = (TYPEOF(h.license_state))'',0,100));
    maxlength_license_state := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.license_state)));
    avelength_license_state := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.license_state)),h.license_state<>(typeof(h.license_state))'');
    populated_license_type_pcnt := AVE(GROUP,IF(h.license_type = (TYPEOF(h.license_type))'',0,100));
    maxlength_license_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.license_type)));
    avelength_license_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.license_type)),h.license_type<>(typeof(h.license_type))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_nielsen_county_cd_pcnt := AVE(GROUP,IF(h.nielsen_county_cd = (TYPEOF(h.nielsen_county_cd))'',0,100));
    maxlength_nielsen_county_cd := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.nielsen_county_cd)));
    avelength_nielsen_county_cd := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.nielsen_county_cd)),h.nielsen_county_cd<>(typeof(h.nielsen_county_cd))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_list_id_pcnt := AVE(GROUP,IF(h.list_id = (TYPEOF(h.list_id))'',0,100));
    maxlength_list_id := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.list_id)));
    avelength_list_id := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.list_id)),h.list_id<>(typeof(h.list_id))'');
    populated_scno_pcnt := AVE(GROUP,IF(h.scno = (TYPEOF(h.scno))'',0,100));
    maxlength_scno := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.scno)));
    avelength_scno := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.scno)),h.scno<>(typeof(h.scno))'');
    populated_keycode_pcnt := AVE(GROUP,IF(h.keycode = (TYPEOF(h.keycode))'',0,100));
    maxlength_keycode := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.keycode)));
    avelength_keycode := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.keycode)),h.keycode<>(typeof(h.keycode))'');
    populated_custno_pcnt := AVE(GROUP,IF(h.custno = (TYPEOF(h.custno))'',0,100));
    maxlength_custno := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.custno)));
    avelength_custno := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.custno)),h.custno<>(typeof(h.custno))'');
    populated_license_no_pcnt := AVE(GROUP,IF(h.license_no = (TYPEOF(h.license_no))'',0,100));
    maxlength_license_no := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.license_no)));
    avelength_license_no := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.license_no)),h.license_no<>(typeof(h.license_no))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_orig_date_pcnt := AVE(GROUP,IF(h.orig_date = (TYPEOF(h.orig_date))'',0,100));
    maxlength_orig_date := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_date)));
    avelength_orig_date := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_date)),h.orig_date<>(typeof(h.orig_date))'');
    populated_exp_date_pcnt := AVE(GROUP,IF(h.exp_date = (TYPEOF(h.exp_date))'',0,100));
    maxlength_exp_date := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.exp_date)));
    avelength_exp_date := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.exp_date)),h.exp_date<>(typeof(h.exp_date))'');
    populated_degree_pcnt := AVE(GROUP,IF(h.degree = (TYPEOF(h.degree))'',0,100));
    maxlength_degree := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.degree)));
    avelength_degree := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.degree)),h.degree<>(typeof(h.degree))'');
    populated_specialty_pcnt := AVE(GROUP,IF(h.specialty = (TYPEOF(h.specialty))'',0,100));
    maxlength_specialty := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.specialty)));
    avelength_specialty := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.specialty)),h.specialty<>(typeof(h.specialty))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_company_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_bar_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_postal_cd_pcnt *   0.00 / 100 + T.Populated_dpv_pcnt *   0.00 / 100 + T.Populated_addr_type_pcnt *   0.00 / 100 + T.Populated_county_cd_pcnt *   0.00 / 100 + T.Populated_license_class_pcnt *   0.00 / 100 + T.Populated_license_state_pcnt *   0.00 / 100 + T.Populated_license_type_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_nielsen_county_cd_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_list_id_pcnt *   0.00 / 100 + T.Populated_scno_pcnt *   0.00 / 100 + T.Populated_keycode_pcnt *   0.00 / 100 + T.Populated_custno_pcnt *   0.00 / 100 + T.Populated_license_no_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_orig_date_pcnt *   0.00 / 100 + T.Populated_exp_date_pcnt *   0.00 / 100 + T.Populated_degree_pcnt *   0.00 / 100 + T.Populated_specialty_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'fname','lname','title','company','address1','address2','city','state','zip','zip4','cart','bar','gender','country','postal_cd','dpv','addr_type','county_cd','license_class','license_state','license_type','msa','nielsen_county_cd','phone','email','list_id','scno','keycode','custno','license_no','dob','orig_date','exp_date','degree','specialty');
  SELF.populated_pcnt := CHOOSE(C,le.populated_fname_pcnt,le.populated_lname_pcnt,le.populated_title_pcnt,le.populated_company_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_bar_pcnt,le.populated_gender_pcnt,le.populated_country_pcnt,le.populated_postal_cd_pcnt,le.populated_dpv_pcnt,le.populated_addr_type_pcnt,le.populated_county_cd_pcnt,le.populated_license_class_pcnt,le.populated_license_state_pcnt,le.populated_license_type_pcnt,le.populated_msa_pcnt,le.populated_nielsen_county_cd_pcnt,le.populated_phone_pcnt,le.populated_email_pcnt,le.populated_list_id_pcnt,le.populated_scno_pcnt,le.populated_keycode_pcnt,le.populated_custno_pcnt,le.populated_license_no_pcnt,le.populated_dob_pcnt,le.populated_orig_date_pcnt,le.populated_exp_date_pcnt,le.populated_degree_pcnt,le.populated_specialty_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_fname,le.maxlength_lname,le.maxlength_title,le.maxlength_company,le.maxlength_address1,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_bar,le.maxlength_gender,le.maxlength_country,le.maxlength_postal_cd,le.maxlength_dpv,le.maxlength_addr_type,le.maxlength_county_cd,le.maxlength_license_class,le.maxlength_license_state,le.maxlength_license_type,le.maxlength_msa,le.maxlength_nielsen_county_cd,le.maxlength_phone,le.maxlength_email,le.maxlength_list_id,le.maxlength_scno,le.maxlength_keycode,le.maxlength_custno,le.maxlength_license_no,le.maxlength_dob,le.maxlength_orig_date,le.maxlength_exp_date,le.maxlength_degree,le.maxlength_specialty);
  SELF.avelength := CHOOSE(C,le.avelength_fname,le.avelength_lname,le.avelength_title,le.avelength_company,le.avelength_address1,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_bar,le.avelength_gender,le.avelength_country,le.avelength_postal_cd,le.avelength_dpv,le.avelength_addr_type,le.avelength_county_cd,le.avelength_license_class,le.avelength_license_state,le.avelength_license_type,le.avelength_msa,le.avelength_nielsen_county_cd,le.avelength_phone,le.avelength_email,le.avelength_list_id,le.avelength_scno,le.avelength_keycode,le.avelength_custno,le.avelength_license_no,le.avelength_dob,le.avelength_orig_date,le.avelength_exp_date,le.avelength_degree,le.avelength_specialty);
END;
EXPORT invSummary := NORMALIZE(summary0, 35, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.title),TRIM((SALT32.StrType)le.company),TRIM((SALT32.StrType)le.address1),TRIM((SALT32.StrType)le.address2),TRIM((SALT32.StrType)le.city),TRIM((SALT32.StrType)le.state),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.zip4),TRIM((SALT32.StrType)le.cart),TRIM((SALT32.StrType)le.bar),TRIM((SALT32.StrType)le.gender),TRIM((SALT32.StrType)le.country),TRIM((SALT32.StrType)le.postal_cd),TRIM((SALT32.StrType)le.dpv),TRIM((SALT32.StrType)le.addr_type),TRIM((SALT32.StrType)le.county_cd),TRIM((SALT32.StrType)le.license_class),TRIM((SALT32.StrType)le.license_state),TRIM((SALT32.StrType)le.license_type),TRIM((SALT32.StrType)le.msa),TRIM((SALT32.StrType)le.nielsen_county_cd),TRIM((SALT32.StrType)le.phone),TRIM((SALT32.StrType)le.email),TRIM((SALT32.StrType)le.list_id),TRIM((SALT32.StrType)le.scno),TRIM((SALT32.StrType)le.keycode),TRIM((SALT32.StrType)le.custno),TRIM((SALT32.StrType)le.license_no),TRIM((SALT32.StrType)le.dob),TRIM((SALT32.StrType)le.orig_date),TRIM((SALT32.StrType)le.exp_date),TRIM((SALT32.StrType)le.degree),TRIM((SALT32.StrType)le.specialty)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,35,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 35);
  SELF.FldNo2 := 1 + (C % 35);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.title),TRIM((SALT32.StrType)le.company),TRIM((SALT32.StrType)le.address1),TRIM((SALT32.StrType)le.address2),TRIM((SALT32.StrType)le.city),TRIM((SALT32.StrType)le.state),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.zip4),TRIM((SALT32.StrType)le.cart),TRIM((SALT32.StrType)le.bar),TRIM((SALT32.StrType)le.gender),TRIM((SALT32.StrType)le.country),TRIM((SALT32.StrType)le.postal_cd),TRIM((SALT32.StrType)le.dpv),TRIM((SALT32.StrType)le.addr_type),TRIM((SALT32.StrType)le.county_cd),TRIM((SALT32.StrType)le.license_class),TRIM((SALT32.StrType)le.license_state),TRIM((SALT32.StrType)le.license_type),TRIM((SALT32.StrType)le.msa),TRIM((SALT32.StrType)le.nielsen_county_cd),TRIM((SALT32.StrType)le.phone),TRIM((SALT32.StrType)le.email),TRIM((SALT32.StrType)le.list_id),TRIM((SALT32.StrType)le.scno),TRIM((SALT32.StrType)le.keycode),TRIM((SALT32.StrType)le.custno),TRIM((SALT32.StrType)le.license_no),TRIM((SALT32.StrType)le.dob),TRIM((SALT32.StrType)le.orig_date),TRIM((SALT32.StrType)le.exp_date),TRIM((SALT32.StrType)le.degree),TRIM((SALT32.StrType)le.specialty)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.title),TRIM((SALT32.StrType)le.company),TRIM((SALT32.StrType)le.address1),TRIM((SALT32.StrType)le.address2),TRIM((SALT32.StrType)le.city),TRIM((SALT32.StrType)le.state),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.zip4),TRIM((SALT32.StrType)le.cart),TRIM((SALT32.StrType)le.bar),TRIM((SALT32.StrType)le.gender),TRIM((SALT32.StrType)le.country),TRIM((SALT32.StrType)le.postal_cd),TRIM((SALT32.StrType)le.dpv),TRIM((SALT32.StrType)le.addr_type),TRIM((SALT32.StrType)le.county_cd),TRIM((SALT32.StrType)le.license_class),TRIM((SALT32.StrType)le.license_state),TRIM((SALT32.StrType)le.license_type),TRIM((SALT32.StrType)le.msa),TRIM((SALT32.StrType)le.nielsen_county_cd),TRIM((SALT32.StrType)le.phone),TRIM((SALT32.StrType)le.email),TRIM((SALT32.StrType)le.list_id),TRIM((SALT32.StrType)le.scno),TRIM((SALT32.StrType)le.keycode),TRIM((SALT32.StrType)le.custno),TRIM((SALT32.StrType)le.license_no),TRIM((SALT32.StrType)le.dob),TRIM((SALT32.StrType)le.orig_date),TRIM((SALT32.StrType)le.exp_date),TRIM((SALT32.StrType)le.degree),TRIM((SALT32.StrType)le.specialty)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),35*35,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'fname'}
      ,{2,'lname'}
      ,{3,'title'}
      ,{4,'company'}
      ,{5,'address1'}
      ,{6,'address2'}
      ,{7,'city'}
      ,{8,'state'}
      ,{9,'zip'}
      ,{10,'zip4'}
      ,{11,'cart'}
      ,{12,'bar'}
      ,{13,'gender'}
      ,{14,'country'}
      ,{15,'postal_cd'}
      ,{16,'dpv'}
      ,{17,'addr_type'}
      ,{18,'county_cd'}
      ,{19,'license_class'}
      ,{20,'license_state'}
      ,{21,'license_type'}
      ,{22,'msa'}
      ,{23,'nielsen_county_cd'}
      ,{24,'phone'}
      ,{25,'email'}
      ,{26,'list_id'}
      ,{27,'scno'}
      ,{28,'keycode'}
      ,{29,'custno'}
      ,{30,'license_no'}
      ,{31,'dob'}
      ,{32,'orig_date'}
      ,{33,'exp_date'}
      ,{34,'degree'}
      ,{35,'specialty'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_fname((SALT32.StrType)le.fname),
    Fields.InValid_lname((SALT32.StrType)le.lname),
    Fields.InValid_title((SALT32.StrType)le.title),
    Fields.InValid_company((SALT32.StrType)le.company),
    Fields.InValid_address1((SALT32.StrType)le.address1),
    Fields.InValid_address2((SALT32.StrType)le.address2),
    Fields.InValid_city((SALT32.StrType)le.city),
    Fields.InValid_state((SALT32.StrType)le.state),
    Fields.InValid_zip((SALT32.StrType)le.zip),
    Fields.InValid_zip4((SALT32.StrType)le.zip4),
    Fields.InValid_cart((SALT32.StrType)le.cart),
    Fields.InValid_bar((SALT32.StrType)le.bar),
    Fields.InValid_gender((SALT32.StrType)le.gender),
    Fields.InValid_country((SALT32.StrType)le.country),
    Fields.InValid_postal_cd((SALT32.StrType)le.postal_cd),
    Fields.InValid_dpv((SALT32.StrType)le.dpv),
    Fields.InValid_addr_type((SALT32.StrType)le.addr_type),
    Fields.InValid_county_cd((SALT32.StrType)le.county_cd),
    Fields.InValid_license_class((SALT32.StrType)le.license_class),
    Fields.InValid_license_state((SALT32.StrType)le.license_state),
    Fields.InValid_license_type((SALT32.StrType)le.license_type),
    Fields.InValid_msa((SALT32.StrType)le.msa),
    Fields.InValid_nielsen_county_cd((SALT32.StrType)le.nielsen_county_cd),
    Fields.InValid_phone((SALT32.StrType)le.phone),
    Fields.InValid_email((SALT32.StrType)le.email),
    Fields.InValid_list_id((SALT32.StrType)le.list_id),
    Fields.InValid_scno((SALT32.StrType)le.scno),
    Fields.InValid_keycode((SALT32.StrType)le.keycode),
    Fields.InValid_custno((SALT32.StrType)le.custno),
    Fields.InValid_license_no((SALT32.StrType)le.license_no,(SALT32.StrType)le.license_state),
    Fields.InValid_dob((SALT32.StrType)le.dob),
    Fields.InValid_orig_date((SALT32.StrType)le.orig_date),
    Fields.InValid_exp_date((SALT32.StrType)le.exp_date),
    Fields.InValid_degree((SALT32.StrType)le.degree),
    Fields.InValid_specialty((SALT32.StrType)le.specialty),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,35,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_alphaspacequote','invalid_alphaspacequote','invalid_alphaspace','Unknown','Unknown','Unknown','Unknown','invalid_alpha','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_gender','Unknown','Unknown','Unknown','invalid_addr_type','invalid_alphanumeric','invalid_numericpound','invalid_alpha','invalid_alphapound','invalid_numeric','invalid_alphanumeric','invalid_numeric','Unknown','invalid_numeric','invalid_numeric','Unknown','invalid_alphanumeric','invalid_license_number','invalid_slashspace_date','invalid_slashspace_date','invalid_slashspace_date','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_company(TotalErrors.ErrorNum),Fields.InValidMessage_address1(TotalErrors.ErrorNum),Fields.InValidMessage_address2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_bar(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_country(TotalErrors.ErrorNum),Fields.InValidMessage_postal_cd(TotalErrors.ErrorNum),Fields.InValidMessage_dpv(TotalErrors.ErrorNum),Fields.InValidMessage_addr_type(TotalErrors.ErrorNum),Fields.InValidMessage_county_cd(TotalErrors.ErrorNum),Fields.InValidMessage_license_class(TotalErrors.ErrorNum),Fields.InValidMessage_license_state(TotalErrors.ErrorNum),Fields.InValidMessage_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_nielsen_county_cd(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_list_id(TotalErrors.ErrorNum),Fields.InValidMessage_scno(TotalErrors.ErrorNum),Fields.InValidMessage_keycode(TotalErrors.ErrorNum),Fields.InValidMessage_custno(TotalErrors.ErrorNum),Fields.InValidMessage_license_no(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_date(TotalErrors.ErrorNum),Fields.InValidMessage_exp_date(TotalErrors.ErrorNum),Fields.InValidMessage_degree(TotalErrors.ErrorNum),Fields.InValidMessage_specialty(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
