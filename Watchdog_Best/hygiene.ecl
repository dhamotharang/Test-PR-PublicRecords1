IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Hdr) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.src))'', MAX(GROUP,h.src));
    NumberOfRecords := COUNT(GROUP);
    populated_pflag1_cnt := COUNT(GROUP,h.pflag1 <> (TYPEOF(h.pflag1))'');
    populated_pflag1_pcnt := AVE(GROUP,IF(h.pflag1 = (TYPEOF(h.pflag1))'',0,100));
    maxlength_pflag1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pflag1)));
    avelength_pflag1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pflag1)),h.pflag1<>(typeof(h.pflag1))'');
    populated_pflag2_cnt := COUNT(GROUP,h.pflag2 <> (TYPEOF(h.pflag2))'');
    populated_pflag2_pcnt := AVE(GROUP,IF(h.pflag2 = (TYPEOF(h.pflag2))'',0,100));
    maxlength_pflag2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pflag2)));
    avelength_pflag2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pflag2)),h.pflag2<>(typeof(h.pflag2))'');
    populated_pflag3_cnt := COUNT(GROUP,h.pflag3 <> (TYPEOF(h.pflag3))'');
    populated_pflag3_pcnt := AVE(GROUP,IF(h.pflag3 = (TYPEOF(h.pflag3))'',0,100));
    maxlength_pflag3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pflag3)));
    avelength_pflag3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pflag3)),h.pflag3<>(typeof(h.pflag3))'');
    populated_src_cnt := COUNT(GROUP,h.src <> (TYPEOF(h.src))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_nonglb_last_seen_cnt := COUNT(GROUP,h.dt_nonglb_last_seen <> (TYPEOF(h.dt_nonglb_last_seen))'');
    populated_dt_nonglb_last_seen_pcnt := AVE(GROUP,IF(h.dt_nonglb_last_seen = (TYPEOF(h.dt_nonglb_last_seen))'',0,100));
    maxlength_dt_nonglb_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_nonglb_last_seen)));
    avelength_dt_nonglb_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_nonglb_last_seen)),h.dt_nonglb_last_seen<>(typeof(h.dt_nonglb_last_seen))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_city_name_cnt := COUNT(GROUP,h.city_name <> (TYPEOF(h.city_name))'');
    populated_city_name_pcnt := AVE(GROUP,IF(h.city_name = (TYPEOF(h.city_name))'',0,100));
    maxlength_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)));
    avelength_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)),h.city_name<>(typeof(h.city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_tnt_cnt := COUNT(GROUP,h.tnt <> (TYPEOF(h.tnt))'');
    populated_tnt_pcnt := AVE(GROUP,IF(h.tnt = (TYPEOF(h.tnt))'',0,100));
    maxlength_tnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tnt)));
    avelength_tnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tnt)),h.tnt<>(typeof(h.tnt))'');
    populated_valid_ssn_cnt := COUNT(GROUP,h.valid_ssn <> (TYPEOF(h.valid_ssn))'');
    populated_valid_ssn_pcnt := AVE(GROUP,IF(h.valid_ssn = (TYPEOF(h.valid_ssn))'',0,100));
    maxlength_valid_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.valid_ssn)));
    avelength_valid_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.valid_ssn)),h.valid_ssn<>(typeof(h.valid_ssn))'');
    populated_jflag1_cnt := COUNT(GROUP,h.jflag1 <> (TYPEOF(h.jflag1))'');
    populated_jflag1_pcnt := AVE(GROUP,IF(h.jflag1 = (TYPEOF(h.jflag1))'',0,100));
    maxlength_jflag1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.jflag1)));
    avelength_jflag1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.jflag1)),h.jflag1<>(typeof(h.jflag1))'');
    populated_jflag2_cnt := COUNT(GROUP,h.jflag2 <> (TYPEOF(h.jflag2))'');
    populated_jflag2_pcnt := AVE(GROUP,IF(h.jflag2 = (TYPEOF(h.jflag2))'',0,100));
    maxlength_jflag2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.jflag2)));
    avelength_jflag2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.jflag2)),h.jflag2<>(typeof(h.jflag2))'');
    populated_jflag3_cnt := COUNT(GROUP,h.jflag3 <> (TYPEOF(h.jflag3))'');
    populated_jflag3_pcnt := AVE(GROUP,IF(h.jflag3 = (TYPEOF(h.jflag3))'',0,100));
    maxlength_jflag3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.jflag3)));
    avelength_jflag3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.jflag3)),h.jflag3<>(typeof(h.jflag3))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_dodgy_tracking_cnt := COUNT(GROUP,h.dodgy_tracking <> (TYPEOF(h.dodgy_tracking))'');
    populated_dodgy_tracking_pcnt := AVE(GROUP,IF(h.dodgy_tracking = (TYPEOF(h.dodgy_tracking))'',0,100));
    maxlength_dodgy_tracking := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dodgy_tracking)));
    avelength_dodgy_tracking := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dodgy_tracking)),h.dodgy_tracking<>(typeof(h.dodgy_tracking))'');
    populated_address_ind_cnt := COUNT(GROUP,h.address_ind <> (TYPEOF(h.address_ind))'');
    populated_address_ind_pcnt := AVE(GROUP,IF(h.address_ind = (TYPEOF(h.address_ind))'',0,100));
    maxlength_address_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_ind)));
    avelength_address_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_ind)),h.address_ind<>(typeof(h.address_ind))'');
    populated_name_ind_cnt := COUNT(GROUP,h.name_ind <> (TYPEOF(h.name_ind))'');
    populated_name_ind_pcnt := AVE(GROUP,IF(h.name_ind = (TYPEOF(h.name_ind))'',0,100));
    maxlength_name_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_ind)));
    avelength_name_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_ind)),h.name_ind<>(typeof(h.name_ind))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,src,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_pflag1_pcnt *  44.00 / 100 + T.Populated_pflag2_pcnt *  43.00 / 100 + T.Populated_pflag3_pcnt *   7.00 / 100 + T.Populated_src_pcnt * 311.00 / 100 + T.Populated_dt_first_seen_pcnt *  61.00 / 100 + T.Populated_dt_last_seen_pcnt *  56.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *  48.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *  50.00 / 100 + T.Populated_dt_nonglb_last_seen_pcnt *  64.00 / 100 + T.Populated_rec_type_pcnt *  12.00 / 100 + T.Populated_phone_pcnt *  17.00 / 100 + T.Populated_ssn_pcnt *  17.00 / 100 + T.Populated_dob_pcnt *  13.00 / 100 + T.Populated_title_pcnt *   1.00 / 100 + T.Populated_fname_pcnt *   1.00 / 100 + T.Populated_mname_pcnt *   1.00 / 100 + T.Populated_lname_pcnt *   1.00 / 100 + T.Populated_name_suffix_pcnt *  70.00 / 100 + T.Populated_prim_range_pcnt * 115.00 / 100 + T.Populated_predir_pcnt *  38.00 / 100 + T.Populated_prim_name_pcnt * 131.00 / 100 + T.Populated_suffix_pcnt *  29.00 / 100 + T.Populated_postdir_pcnt *  61.00 / 100 + T.Populated_unit_desig_pcnt *  29.00 / 100 + T.Populated_sec_range_pcnt * 103.00 / 100 + T.Populated_city_name_pcnt * 109.00 / 100 + T.Populated_st_pcnt *  48.00 / 100 + T.Populated_zip_pcnt * 129.00 / 100 + T.Populated_zip4_pcnt * 116.00 / 100 + T.Populated_tnt_pcnt *  93.00 / 100 + T.Populated_valid_ssn_pcnt *  21.00 / 100 + T.Populated_jflag1_pcnt *  24.00 / 100 + T.Populated_jflag2_pcnt *  37.00 / 100 + T.Populated_jflag3_pcnt *  25.00 / 100 + T.Populated_rawaid_pcnt * 169.00 / 100 + T.Populated_dodgy_tracking_pcnt *  53.00 / 100 + T.Populated_address_ind_pcnt *   1.00 / 100 + T.Populated_name_ind_pcnt *   1.00 / 100 + T.Populated_persistent_record_id_pcnt *   1.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;

EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING src1;
    STRING src2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.src1 := le.Source;
    SELF.src2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_pflag1_pcnt*ri.Populated_pflag1_pcnt *  44.00 / 10000 + le.Populated_pflag2_pcnt*ri.Populated_pflag2_pcnt *  43.00 / 10000 + le.Populated_pflag3_pcnt*ri.Populated_pflag3_pcnt *   7.00 / 10000 + le.Populated_src_pcnt*ri.Populated_src_pcnt * 311.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *  61.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *  56.00 / 10000 + le.Populated_dt_vendor_last_reported_pcnt*ri.Populated_dt_vendor_last_reported_pcnt *  48.00 / 10000 + le.Populated_dt_vendor_first_reported_pcnt*ri.Populated_dt_vendor_first_reported_pcnt *  50.00 / 10000 + le.Populated_dt_nonglb_last_seen_pcnt*ri.Populated_dt_nonglb_last_seen_pcnt *  64.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *  12.00 / 10000 + le.Populated_phone_pcnt*ri.Populated_phone_pcnt *  17.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *  17.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *  13.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   1.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   1.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   1.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   1.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *  70.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt * 115.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *  38.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt * 131.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *  29.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *  61.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *  29.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt * 103.00 / 10000 + le.Populated_city_name_pcnt*ri.Populated_city_name_pcnt * 109.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *  48.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt * 129.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt * 116.00 / 10000 + le.Populated_tnt_pcnt*ri.Populated_tnt_pcnt *  93.00 / 10000 + le.Populated_valid_ssn_pcnt*ri.Populated_valid_ssn_pcnt *  21.00 / 10000 + le.Populated_jflag1_pcnt*ri.Populated_jflag1_pcnt *  24.00 / 10000 + le.Populated_jflag2_pcnt*ri.Populated_jflag2_pcnt *  37.00 / 10000 + le.Populated_jflag3_pcnt*ri.Populated_jflag3_pcnt *  25.00 / 10000 + le.Populated_rawaid_pcnt*ri.Populated_rawaid_pcnt * 169.00 / 10000 + le.Populated_dodgy_tracking_pcnt*ri.Populated_dodgy_tracking_pcnt *  53.00 / 10000 + le.Populated_address_ind_pcnt*ri.Populated_address_ind_pcnt *   1.00 / 10000 + le.Populated_name_ind_pcnt*ri.Populated_name_ind_pcnt *   1.00 / 10000 + le.Populated_persistent_record_id_pcnt*ri.Populated_persistent_record_id_pcnt *   1.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','address_ind','name_ind','persistent_record_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_pflag1_pcnt,le.populated_pflag2_pcnt,le.populated_pflag3_pcnt,le.populated_src_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_nonglb_last_seen_pcnt,le.populated_rec_type_pcnt,le.populated_phone_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_tnt_pcnt,le.populated_valid_ssn_pcnt,le.populated_jflag1_pcnt,le.populated_jflag2_pcnt,le.populated_jflag3_pcnt,le.populated_rawaid_pcnt,le.populated_dodgy_tracking_pcnt,le.populated_address_ind_pcnt,le.populated_name_ind_pcnt,le.populated_persistent_record_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_pflag1,le.maxlength_pflag2,le.maxlength_pflag3,le.maxlength_src,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_nonglb_last_seen,le.maxlength_rec_type,le.maxlength_phone,le.maxlength_ssn,le.maxlength_dob,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_tnt,le.maxlength_valid_ssn,le.maxlength_jflag1,le.maxlength_jflag2,le.maxlength_jflag3,le.maxlength_rawaid,le.maxlength_dodgy_tracking,le.maxlength_address_ind,le.maxlength_name_ind,le.maxlength_persistent_record_id);
  SELF.avelength := CHOOSE(C,le.avelength_pflag1,le.avelength_pflag2,le.avelength_pflag3,le.avelength_src,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_last_reported,le.avelength_dt_vendor_first_reported,le.avelength_dt_nonglb_last_seen,le.avelength_rec_type,le.avelength_phone,le.avelength_ssn,le.avelength_dob,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_tnt,le.avelength_valid_ssn,le.avelength_jflag1,le.avelength_jflag2,le.avelength_jflag3,le.avelength_rawaid,le.avelength_dodgy_tracking,le.avelength_address_ind,le.avelength_name_ind,le.avelength_persistent_record_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 39, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.did;
  SELF.Src := le.src;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.pflag1),TRIM((SALT311.StrType)le.pflag2),TRIM((SALT311.StrType)le.pflag3),TRIM((SALT311.StrType)le.src),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_nonglb_last_seen <> 0,TRIM((SALT311.StrType)le.dt_nonglb_last_seen), ''),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.ssn),IF (le.dob <> 0,TRIM((SALT311.StrType)le.dob), ''),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.tnt),TRIM((SALT311.StrType)le.valid_ssn),TRIM((SALT311.StrType)le.jflag1),TRIM((SALT311.StrType)le.jflag2),TRIM((SALT311.StrType)le.jflag3),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.dodgy_tracking),IF (le.address_ind <> 0,TRIM((SALT311.StrType)le.address_ind), ''),IF (le.name_ind <> 0,TRIM((SALT311.StrType)le.name_ind), ''),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,39,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 39);
  SELF.FldNo2 := 1 + (C % 39);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.pflag1),TRIM((SALT311.StrType)le.pflag2),TRIM((SALT311.StrType)le.pflag3),TRIM((SALT311.StrType)le.src),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_nonglb_last_seen <> 0,TRIM((SALT311.StrType)le.dt_nonglb_last_seen), ''),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.ssn),IF (le.dob <> 0,TRIM((SALT311.StrType)le.dob), ''),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.tnt),TRIM((SALT311.StrType)le.valid_ssn),TRIM((SALT311.StrType)le.jflag1),TRIM((SALT311.StrType)le.jflag2),TRIM((SALT311.StrType)le.jflag3),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.dodgy_tracking),IF (le.address_ind <> 0,TRIM((SALT311.StrType)le.address_ind), ''),IF (le.name_ind <> 0,TRIM((SALT311.StrType)le.name_ind), ''),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.pflag1),TRIM((SALT311.StrType)le.pflag2),TRIM((SALT311.StrType)le.pflag3),TRIM((SALT311.StrType)le.src),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_nonglb_last_seen <> 0,TRIM((SALT311.StrType)le.dt_nonglb_last_seen), ''),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.ssn),IF (le.dob <> 0,TRIM((SALT311.StrType)le.dob), ''),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.tnt),TRIM((SALT311.StrType)le.valid_ssn),TRIM((SALT311.StrType)le.jflag1),TRIM((SALT311.StrType)le.jflag2),TRIM((SALT311.StrType)le.jflag3),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.dodgy_tracking),IF (le.address_ind <> 0,TRIM((SALT311.StrType)le.address_ind), ''),IF (le.name_ind <> 0,TRIM((SALT311.StrType)le.name_ind), ''),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),39*39,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'pflag1'}
      ,{2,'pflag2'}
      ,{3,'pflag3'}
      ,{4,'src'}
      ,{5,'dt_first_seen'}
      ,{6,'dt_last_seen'}
      ,{7,'dt_vendor_last_reported'}
      ,{8,'dt_vendor_first_reported'}
      ,{9,'dt_nonglb_last_seen'}
      ,{10,'rec_type'}
      ,{11,'phone'}
      ,{12,'ssn'}
      ,{13,'dob'}
      ,{14,'title'}
      ,{15,'fname'}
      ,{16,'mname'}
      ,{17,'lname'}
      ,{18,'name_suffix'}
      ,{19,'prim_range'}
      ,{20,'predir'}
      ,{21,'prim_name'}
      ,{22,'suffix'}
      ,{23,'postdir'}
      ,{24,'unit_desig'}
      ,{25,'sec_range'}
      ,{26,'city_name'}
      ,{27,'st'}
      ,{28,'zip'}
      ,{29,'zip4'}
      ,{30,'tnt'}
      ,{31,'valid_ssn'}
      ,{32,'jflag1'}
      ,{33,'jflag2'}
      ,{34,'jflag3'}
      ,{35,'rawaid'}
      ,{36,'dodgy_tracking'}
      ,{37,'address_ind'}
      ,{38,'name_ind'}
      ,{39,'persistent_record_id'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.src) src; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_pflag1((SALT311.StrType)le.pflag1),
    Fields.InValid_pflag2((SALT311.StrType)le.pflag2),
    Fields.InValid_pflag3((SALT311.StrType)le.pflag3),
    Fields.InValid_src((SALT311.StrType)le.src),
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_nonglb_last_seen((SALT311.StrType)le.dt_nonglb_last_seen),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_phone((SALT311.StrType)le.phone),
    Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Fields.InValid_dob((SALT311.StrType)le.dob),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_city_name((SALT311.StrType)le.city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_tnt((SALT311.StrType)le.tnt),
    Fields.InValid_valid_ssn((SALT311.StrType)le.valid_ssn),
    Fields.InValid_jflag1((SALT311.StrType)le.jflag1),
    Fields.InValid_jflag2((SALT311.StrType)le.jflag2),
    Fields.InValid_jflag3((SALT311.StrType)le.jflag3),
    Fields.InValid_rawaid((SALT311.StrType)le.rawaid),
    Fields.InValid_dodgy_tracking((SALT311.StrType)le.dodgy_tracking),
    Fields.InValid_address_ind((SALT311.StrType)le.address_ind),
    Fields.InValid_name_ind((SALT311.StrType)le.name_ind),
    Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id),
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.src := le.src;
END;
Errors := NORMALIZE(h,41,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.src;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,src,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.src;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_pflag1(TotalErrors.ErrorNum),Fields.InValidMessage_pflag2(TotalErrors.ErrorNum),Fields.InValidMessage_pflag3(TotalErrors.ErrorNum),Fields.InValidMessage_src(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_nonglb_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_tnt(TotalErrors.ErrorNum),Fields.InValidMessage_valid_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_jflag1(TotalErrors.ErrorNum),Fields.InValidMessage_jflag2(TotalErrors.ErrorNum),Fields.InValidMessage_jflag3(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_dodgy_tracking(TotalErrors.ErrorNum),Fields.InValidMessage_address_ind(TotalErrors.ErrorNum),Fields.InValidMessage_name_ind(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),'','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.src=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have did specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT311.MOD_ClusterStats.Counts(h,did);
EXPORT ClusterSrc := SALT311.MOD_ClusterStats.Sources(h,did,src);
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Watchdog_best, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));

  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));

  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
