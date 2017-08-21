IMPORT ut,SALT34;
EXPORT hygiene(dataset(layout_GlobalWatchlists) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.src_key);    NumberOfRecords := COUNT(GROUP);
    populated_pty_key_pcnt := AVE(GROUP,IF(h.pty_key = (TYPEOF(h.pty_key))'',0,100));
    maxlength_pty_key := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pty_key)));
    avelength_pty_key := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pty_key)),h.pty_key<>(typeof(h.pty_key))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_orig_pty_name_pcnt := AVE(GROUP,IF(h.orig_pty_name = (TYPEOF(h.orig_pty_name))'',0,100));
    maxlength_orig_pty_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_pty_name)));
    avelength_orig_pty_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_pty_name)),h.orig_pty_name<>(typeof(h.orig_pty_name))'');
    populated_orig_vessel_name_pcnt := AVE(GROUP,IF(h.orig_vessel_name = (TYPEOF(h.orig_vessel_name))'',0,100));
    maxlength_orig_vessel_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_vessel_name)));
    avelength_orig_vessel_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_vessel_name)),h.orig_vessel_name<>(typeof(h.orig_vessel_name))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_addr_1_pcnt := AVE(GROUP,IF(h.addr_1 = (TYPEOF(h.addr_1))'',0,100));
    maxlength_addr_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_1)));
    avelength_addr_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_1)),h.addr_1<>(typeof(h.addr_1))'');
    populated_addr_2_pcnt := AVE(GROUP,IF(h.addr_2 = (TYPEOF(h.addr_2))'',0,100));
    maxlength_addr_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_2)));
    avelength_addr_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_2)),h.addr_2<>(typeof(h.addr_2))'');
    populated_addr_3_pcnt := AVE(GROUP,IF(h.addr_3 = (TYPEOF(h.addr_3))'',0,100));
    maxlength_addr_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_3)));
    avelength_addr_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_3)),h.addr_3<>(typeof(h.addr_3))'');
    populated_addr_4_pcnt := AVE(GROUP,IF(h.addr_4 = (TYPEOF(h.addr_4))'',0,100));
    maxlength_addr_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_4)));
    avelength_addr_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_4)),h.addr_4<>(typeof(h.addr_4))'');
    populated_addr_5_pcnt := AVE(GROUP,IF(h.addr_5 = (TYPEOF(h.addr_5))'',0,100));
    maxlength_addr_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_5)));
    avelength_addr_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_5)),h.addr_5<>(typeof(h.addr_5))'');
    populated_addr_6_pcnt := AVE(GROUP,IF(h.addr_6 = (TYPEOF(h.addr_6))'',0,100));
    maxlength_addr_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_6)));
    avelength_addr_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_6)),h.addr_6<>(typeof(h.addr_6))'');
    populated_addr_7_pcnt := AVE(GROUP,IF(h.addr_7 = (TYPEOF(h.addr_7))'',0,100));
    maxlength_addr_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_7)));
    avelength_addr_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_7)),h.addr_7<>(typeof(h.addr_7))'');
    populated_addr_8_pcnt := AVE(GROUP,IF(h.addr_8 = (TYPEOF(h.addr_8))'',0,100));
    maxlength_addr_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_8)));
    avelength_addr_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_8)),h.addr_8<>(typeof(h.addr_8))'');
    populated_addr_9_pcnt := AVE(GROUP,IF(h.addr_9 = (TYPEOF(h.addr_9))'',0,100));
    maxlength_addr_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_9)));
    avelength_addr_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_9)),h.addr_9<>(typeof(h.addr_9))'');
    populated_addr_10_pcnt := AVE(GROUP,IF(h.addr_10 = (TYPEOF(h.addr_10))'',0,100));
    maxlength_addr_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_10)));
    avelength_addr_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_10)),h.addr_10<>(typeof(h.addr_10))'');
    populated_remarks_1_pcnt := AVE(GROUP,IF(h.remarks_1 = (TYPEOF(h.remarks_1))'',0,100));
    maxlength_remarks_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_1)));
    avelength_remarks_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_1)),h.remarks_1<>(typeof(h.remarks_1))'');
    populated_remarks_2_pcnt := AVE(GROUP,IF(h.remarks_2 = (TYPEOF(h.remarks_2))'',0,100));
    maxlength_remarks_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_2)));
    avelength_remarks_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_2)),h.remarks_2<>(typeof(h.remarks_2))'');
    populated_remarks_3_pcnt := AVE(GROUP,IF(h.remarks_3 = (TYPEOF(h.remarks_3))'',0,100));
    maxlength_remarks_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_3)));
    avelength_remarks_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_3)),h.remarks_3<>(typeof(h.remarks_3))'');
    populated_remarks_4_pcnt := AVE(GROUP,IF(h.remarks_4 = (TYPEOF(h.remarks_4))'',0,100));
    maxlength_remarks_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_4)));
    avelength_remarks_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_4)),h.remarks_4<>(typeof(h.remarks_4))'');
    populated_remarks_5_pcnt := AVE(GROUP,IF(h.remarks_5 = (TYPEOF(h.remarks_5))'',0,100));
    maxlength_remarks_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_5)));
    avelength_remarks_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_5)),h.remarks_5<>(typeof(h.remarks_5))'');
    populated_remarks_6_pcnt := AVE(GROUP,IF(h.remarks_6 = (TYPEOF(h.remarks_6))'',0,100));
    maxlength_remarks_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_6)));
    avelength_remarks_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_6)),h.remarks_6<>(typeof(h.remarks_6))'');
    populated_remarks_7_pcnt := AVE(GROUP,IF(h.remarks_7 = (TYPEOF(h.remarks_7))'',0,100));
    maxlength_remarks_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_7)));
    avelength_remarks_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_7)),h.remarks_7<>(typeof(h.remarks_7))'');
    populated_remarks_8_pcnt := AVE(GROUP,IF(h.remarks_8 = (TYPEOF(h.remarks_8))'',0,100));
    maxlength_remarks_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_8)));
    avelength_remarks_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_8)),h.remarks_8<>(typeof(h.remarks_8))'');
    populated_remarks_9_pcnt := AVE(GROUP,IF(h.remarks_9 = (TYPEOF(h.remarks_9))'',0,100));
    maxlength_remarks_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_9)));
    avelength_remarks_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_9)),h.remarks_9<>(typeof(h.remarks_9))'');
    populated_remarks_10_pcnt := AVE(GROUP,IF(h.remarks_10 = (TYPEOF(h.remarks_10))'',0,100));
    maxlength_remarks_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_10)));
    avelength_remarks_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_10)),h.remarks_10<>(typeof(h.remarks_10))'');
    populated_remarks_11_pcnt := AVE(GROUP,IF(h.remarks_11 = (TYPEOF(h.remarks_11))'',0,100));
    maxlength_remarks_11 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_11)));
    avelength_remarks_11 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_11)),h.remarks_11<>(typeof(h.remarks_11))'');
    populated_remarks_12_pcnt := AVE(GROUP,IF(h.remarks_12 = (TYPEOF(h.remarks_12))'',0,100));
    maxlength_remarks_12 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_12)));
    avelength_remarks_12 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_12)),h.remarks_12<>(typeof(h.remarks_12))'');
    populated_remarks_13_pcnt := AVE(GROUP,IF(h.remarks_13 = (TYPEOF(h.remarks_13))'',0,100));
    maxlength_remarks_13 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_13)));
    avelength_remarks_13 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_13)),h.remarks_13<>(typeof(h.remarks_13))'');
    populated_remarks_14_pcnt := AVE(GROUP,IF(h.remarks_14 = (TYPEOF(h.remarks_14))'',0,100));
    maxlength_remarks_14 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_14)));
    avelength_remarks_14 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_14)),h.remarks_14<>(typeof(h.remarks_14))'');
    populated_remarks_15_pcnt := AVE(GROUP,IF(h.remarks_15 = (TYPEOF(h.remarks_15))'',0,100));
    maxlength_remarks_15 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_15)));
    avelength_remarks_15 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_15)),h.remarks_15<>(typeof(h.remarks_15))'');
    populated_remarks_16_pcnt := AVE(GROUP,IF(h.remarks_16 = (TYPEOF(h.remarks_16))'',0,100));
    maxlength_remarks_16 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_16)));
    avelength_remarks_16 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_16)),h.remarks_16<>(typeof(h.remarks_16))'');
    populated_remarks_17_pcnt := AVE(GROUP,IF(h.remarks_17 = (TYPEOF(h.remarks_17))'',0,100));
    maxlength_remarks_17 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_17)));
    avelength_remarks_17 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_17)),h.remarks_17<>(typeof(h.remarks_17))'');
    populated_remarks_18_pcnt := AVE(GROUP,IF(h.remarks_18 = (TYPEOF(h.remarks_18))'',0,100));
    maxlength_remarks_18 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_18)));
    avelength_remarks_18 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_18)),h.remarks_18<>(typeof(h.remarks_18))'');
    populated_remarks_19_pcnt := AVE(GROUP,IF(h.remarks_19 = (TYPEOF(h.remarks_19))'',0,100));
    maxlength_remarks_19 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_19)));
    avelength_remarks_19 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_19)),h.remarks_19<>(typeof(h.remarks_19))'');
    populated_remarks_20_pcnt := AVE(GROUP,IF(h.remarks_20 = (TYPEOF(h.remarks_20))'',0,100));
    maxlength_remarks_20 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_20)));
    avelength_remarks_20 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_20)),h.remarks_20<>(typeof(h.remarks_20))'');
    populated_remarks_21_pcnt := AVE(GROUP,IF(h.remarks_21 = (TYPEOF(h.remarks_21))'',0,100));
    maxlength_remarks_21 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_21)));
    avelength_remarks_21 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_21)),h.remarks_21<>(typeof(h.remarks_21))'');
    populated_remarks_22_pcnt := AVE(GROUP,IF(h.remarks_22 = (TYPEOF(h.remarks_22))'',0,100));
    maxlength_remarks_22 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_22)));
    avelength_remarks_22 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_22)),h.remarks_22<>(typeof(h.remarks_22))'');
    populated_remarks_23_pcnt := AVE(GROUP,IF(h.remarks_23 = (TYPEOF(h.remarks_23))'',0,100));
    maxlength_remarks_23 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_23)));
    avelength_remarks_23 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_23)),h.remarks_23<>(typeof(h.remarks_23))'');
    populated_remarks_24_pcnt := AVE(GROUP,IF(h.remarks_24 = (TYPEOF(h.remarks_24))'',0,100));
    maxlength_remarks_24 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_24)));
    avelength_remarks_24 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_24)),h.remarks_24<>(typeof(h.remarks_24))'');
    populated_remarks_25_pcnt := AVE(GROUP,IF(h.remarks_25 = (TYPEOF(h.remarks_25))'',0,100));
    maxlength_remarks_25 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_25)));
    avelength_remarks_25 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_25)),h.remarks_25<>(typeof(h.remarks_25))'');
    populated_remarks_26_pcnt := AVE(GROUP,IF(h.remarks_26 = (TYPEOF(h.remarks_26))'',0,100));
    maxlength_remarks_26 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_26)));
    avelength_remarks_26 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_26)),h.remarks_26<>(typeof(h.remarks_26))'');
    populated_remarks_27_pcnt := AVE(GROUP,IF(h.remarks_27 = (TYPEOF(h.remarks_27))'',0,100));
    maxlength_remarks_27 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_27)));
    avelength_remarks_27 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_27)),h.remarks_27<>(typeof(h.remarks_27))'');
    populated_remarks_28_pcnt := AVE(GROUP,IF(h.remarks_28 = (TYPEOF(h.remarks_28))'',0,100));
    maxlength_remarks_28 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_28)));
    avelength_remarks_28 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_28)),h.remarks_28<>(typeof(h.remarks_28))'');
    populated_remarks_29_pcnt := AVE(GROUP,IF(h.remarks_29 = (TYPEOF(h.remarks_29))'',0,100));
    maxlength_remarks_29 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_29)));
    avelength_remarks_29 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_29)),h.remarks_29<>(typeof(h.remarks_29))'');
    populated_remarks_30_pcnt := AVE(GROUP,IF(h.remarks_30 = (TYPEOF(h.remarks_30))'',0,100));
    maxlength_remarks_30 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_30)));
    avelength_remarks_30 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks_30)),h.remarks_30<>(typeof(h.remarks_30))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_a_score_pcnt := AVE(GROUP,IF(h.a_score = (TYPEOF(h.a_score))'',0,100));
    maxlength_a_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.a_score)));
    avelength_a_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.a_score)),h.a_score<>(typeof(h.a_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_entity_id_pcnt := AVE(GROUP,IF(h.entity_id = (TYPEOF(h.entity_id))'',0,100));
    maxlength_entity_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.entity_id)));
    avelength_entity_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.entity_id)),h.entity_id<>(typeof(h.entity_id))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_title_1_pcnt := AVE(GROUP,IF(h.title_1 = (TYPEOF(h.title_1))'',0,100));
    maxlength_title_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_1)));
    avelength_title_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_1)),h.title_1<>(typeof(h.title_1))'');
    populated_title_2_pcnt := AVE(GROUP,IF(h.title_2 = (TYPEOF(h.title_2))'',0,100));
    maxlength_title_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_2)));
    avelength_title_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_2)),h.title_2<>(typeof(h.title_2))'');
    populated_title_3_pcnt := AVE(GROUP,IF(h.title_3 = (TYPEOF(h.title_3))'',0,100));
    maxlength_title_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_3)));
    avelength_title_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_3)),h.title_3<>(typeof(h.title_3))'');
    populated_title_4_pcnt := AVE(GROUP,IF(h.title_4 = (TYPEOF(h.title_4))'',0,100));
    maxlength_title_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_4)));
    avelength_title_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_4)),h.title_4<>(typeof(h.title_4))'');
    populated_title_5_pcnt := AVE(GROUP,IF(h.title_5 = (TYPEOF(h.title_5))'',0,100));
    maxlength_title_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_5)));
    avelength_title_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_5)),h.title_5<>(typeof(h.title_5))'');
    populated_title_6_pcnt := AVE(GROUP,IF(h.title_6 = (TYPEOF(h.title_6))'',0,100));
    maxlength_title_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_6)));
    avelength_title_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_6)),h.title_6<>(typeof(h.title_6))'');
    populated_title_7_pcnt := AVE(GROUP,IF(h.title_7 = (TYPEOF(h.title_7))'',0,100));
    maxlength_title_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_7)));
    avelength_title_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_7)),h.title_7<>(typeof(h.title_7))'');
    populated_title_8_pcnt := AVE(GROUP,IF(h.title_8 = (TYPEOF(h.title_8))'',0,100));
    maxlength_title_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_8)));
    avelength_title_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_8)),h.title_8<>(typeof(h.title_8))'');
    populated_title_9_pcnt := AVE(GROUP,IF(h.title_9 = (TYPEOF(h.title_9))'',0,100));
    maxlength_title_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_9)));
    avelength_title_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_9)),h.title_9<>(typeof(h.title_9))'');
    populated_title_10_pcnt := AVE(GROUP,IF(h.title_10 = (TYPEOF(h.title_10))'',0,100));
    maxlength_title_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_10)));
    avelength_title_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title_10)),h.title_10<>(typeof(h.title_10))'');
    populated_aka_id_pcnt := AVE(GROUP,IF(h.aka_id = (TYPEOF(h.aka_id))'',0,100));
    maxlength_aka_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka_id)));
    avelength_aka_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka_id)),h.aka_id<>(typeof(h.aka_id))'');
    populated_aka_type_pcnt := AVE(GROUP,IF(h.aka_type = (TYPEOF(h.aka_type))'',0,100));
    maxlength_aka_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka_type)));
    avelength_aka_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka_type)),h.aka_type<>(typeof(h.aka_type))'');
    populated_aka_category_pcnt := AVE(GROUP,IF(h.aka_category = (TYPEOF(h.aka_category))'',0,100));
    maxlength_aka_category := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka_category)));
    avelength_aka_category := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka_category)),h.aka_category<>(typeof(h.aka_category))'');
    populated_giv_designator_pcnt := AVE(GROUP,IF(h.giv_designator = (TYPEOF(h.giv_designator))'',0,100));
    maxlength_giv_designator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.giv_designator)));
    avelength_giv_designator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.giv_designator)),h.giv_designator<>(typeof(h.giv_designator))'');
    populated_entity_type_pcnt := AVE(GROUP,IF(h.entity_type = (TYPEOF(h.entity_type))'',0,100));
    maxlength_entity_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.entity_type)));
    avelength_entity_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.entity_type)),h.entity_type<>(typeof(h.entity_type))'');
    populated_address_id_pcnt := AVE(GROUP,IF(h.address_id = (TYPEOF(h.address_id))'',0,100));
    maxlength_address_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_id)));
    avelength_address_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_id)),h.address_id<>(typeof(h.address_id))'');
    populated_address_line_1_pcnt := AVE(GROUP,IF(h.address_line_1 = (TYPEOF(h.address_line_1))'',0,100));
    maxlength_address_line_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_line_1)));
    avelength_address_line_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_line_1)),h.address_line_1<>(typeof(h.address_line_1))'');
    populated_address_line_2_pcnt := AVE(GROUP,IF(h.address_line_2 = (TYPEOF(h.address_line_2))'',0,100));
    maxlength_address_line_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_line_2)));
    avelength_address_line_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_line_2)),h.address_line_2<>(typeof(h.address_line_2))'');
    populated_address_line_3_pcnt := AVE(GROUP,IF(h.address_line_3 = (TYPEOF(h.address_line_3))'',0,100));
    maxlength_address_line_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_line_3)));
    avelength_address_line_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_line_3)),h.address_line_3<>(typeof(h.address_line_3))'');
    populated_address_city_pcnt := AVE(GROUP,IF(h.address_city = (TYPEOF(h.address_city))'',0,100));
    maxlength_address_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_city)));
    avelength_address_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_city)),h.address_city<>(typeof(h.address_city))'');
    populated_address_state_province_pcnt := AVE(GROUP,IF(h.address_state_province = (TYPEOF(h.address_state_province))'',0,100));
    maxlength_address_state_province := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_state_province)));
    avelength_address_state_province := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_state_province)),h.address_state_province<>(typeof(h.address_state_province))'');
    populated_address_postal_code_pcnt := AVE(GROUP,IF(h.address_postal_code = (TYPEOF(h.address_postal_code))'',0,100));
    maxlength_address_postal_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_postal_code)));
    avelength_address_postal_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_postal_code)),h.address_postal_code<>(typeof(h.address_postal_code))'');
    populated_address_country_pcnt := AVE(GROUP,IF(h.address_country = (TYPEOF(h.address_country))'',0,100));
    maxlength_address_country := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_country)));
    avelength_address_country := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_country)),h.address_country<>(typeof(h.address_country))'');
    populated_remarks_pcnt := AVE(GROUP,IF(h.remarks = (TYPEOF(h.remarks))'',0,100));
    maxlength_remarks := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks)));
    avelength_remarks := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.remarks)),h.remarks<>(typeof(h.remarks))'');
    populated_call_sign_pcnt := AVE(GROUP,IF(h.call_sign = (TYPEOF(h.call_sign))'',0,100));
    maxlength_call_sign := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.call_sign)));
    avelength_call_sign := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.call_sign)),h.call_sign<>(typeof(h.call_sign))'');
    populated_vessel_type_pcnt := AVE(GROUP,IF(h.vessel_type = (TYPEOF(h.vessel_type))'',0,100));
    maxlength_vessel_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.vessel_type)));
    avelength_vessel_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.vessel_type)),h.vessel_type<>(typeof(h.vessel_type))'');
    populated_tonnage_pcnt := AVE(GROUP,IF(h.tonnage = (TYPEOF(h.tonnage))'',0,100));
    maxlength_tonnage := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.tonnage)));
    avelength_tonnage := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.tonnage)),h.tonnage<>(typeof(h.tonnage))'');
    populated_gross_registered_tonnage_pcnt := AVE(GROUP,IF(h.gross_registered_tonnage = (TYPEOF(h.gross_registered_tonnage))'',0,100));
    maxlength_gross_registered_tonnage := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.gross_registered_tonnage)));
    avelength_gross_registered_tonnage := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.gross_registered_tonnage)),h.gross_registered_tonnage<>(typeof(h.gross_registered_tonnage))'');
    populated_vessel_flag_pcnt := AVE(GROUP,IF(h.vessel_flag = (TYPEOF(h.vessel_flag))'',0,100));
    maxlength_vessel_flag := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.vessel_flag)));
    avelength_vessel_flag := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.vessel_flag)),h.vessel_flag<>(typeof(h.vessel_flag))'');
    populated_vessel_owner_pcnt := AVE(GROUP,IF(h.vessel_owner = (TYPEOF(h.vessel_owner))'',0,100));
    maxlength_vessel_owner := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.vessel_owner)));
    avelength_vessel_owner := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.vessel_owner)),h.vessel_owner<>(typeof(h.vessel_owner))'');
    populated_sanctions_program_1_pcnt := AVE(GROUP,IF(h.sanctions_program_1 = (TYPEOF(h.sanctions_program_1))'',0,100));
    maxlength_sanctions_program_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_1)));
    avelength_sanctions_program_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_1)),h.sanctions_program_1<>(typeof(h.sanctions_program_1))'');
    populated_sanctions_program_2_pcnt := AVE(GROUP,IF(h.sanctions_program_2 = (TYPEOF(h.sanctions_program_2))'',0,100));
    maxlength_sanctions_program_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_2)));
    avelength_sanctions_program_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_2)),h.sanctions_program_2<>(typeof(h.sanctions_program_2))'');
    populated_sanctions_program_3_pcnt := AVE(GROUP,IF(h.sanctions_program_3 = (TYPEOF(h.sanctions_program_3))'',0,100));
    maxlength_sanctions_program_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_3)));
    avelength_sanctions_program_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_3)),h.sanctions_program_3<>(typeof(h.sanctions_program_3))'');
    populated_sanctions_program_4_pcnt := AVE(GROUP,IF(h.sanctions_program_4 = (TYPEOF(h.sanctions_program_4))'',0,100));
    maxlength_sanctions_program_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_4)));
    avelength_sanctions_program_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_4)),h.sanctions_program_4<>(typeof(h.sanctions_program_4))'');
    populated_sanctions_program_5_pcnt := AVE(GROUP,IF(h.sanctions_program_5 = (TYPEOF(h.sanctions_program_5))'',0,100));
    maxlength_sanctions_program_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_5)));
    avelength_sanctions_program_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_5)),h.sanctions_program_5<>(typeof(h.sanctions_program_5))'');
    populated_sanctions_program_6_pcnt := AVE(GROUP,IF(h.sanctions_program_6 = (TYPEOF(h.sanctions_program_6))'',0,100));
    maxlength_sanctions_program_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_6)));
    avelength_sanctions_program_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_6)),h.sanctions_program_6<>(typeof(h.sanctions_program_6))'');
    populated_sanctions_program_7_pcnt := AVE(GROUP,IF(h.sanctions_program_7 = (TYPEOF(h.sanctions_program_7))'',0,100));
    maxlength_sanctions_program_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_7)));
    avelength_sanctions_program_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_7)),h.sanctions_program_7<>(typeof(h.sanctions_program_7))'');
    populated_sanctions_program_8_pcnt := AVE(GROUP,IF(h.sanctions_program_8 = (TYPEOF(h.sanctions_program_8))'',0,100));
    maxlength_sanctions_program_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_8)));
    avelength_sanctions_program_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_8)),h.sanctions_program_8<>(typeof(h.sanctions_program_8))'');
    populated_sanctions_program_9_pcnt := AVE(GROUP,IF(h.sanctions_program_9 = (TYPEOF(h.sanctions_program_9))'',0,100));
    maxlength_sanctions_program_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_9)));
    avelength_sanctions_program_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_9)),h.sanctions_program_9<>(typeof(h.sanctions_program_9))'');
    populated_sanctions_program_10_pcnt := AVE(GROUP,IF(h.sanctions_program_10 = (TYPEOF(h.sanctions_program_10))'',0,100));
    maxlength_sanctions_program_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_10)));
    avelength_sanctions_program_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sanctions_program_10)),h.sanctions_program_10<>(typeof(h.sanctions_program_10))'');
    populated_passport_details_pcnt := AVE(GROUP,IF(h.passport_details = (TYPEOF(h.passport_details))'',0,100));
    maxlength_passport_details := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.passport_details)));
    avelength_passport_details := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.passport_details)),h.passport_details<>(typeof(h.passport_details))'');
    populated_ni_number_details_pcnt := AVE(GROUP,IF(h.ni_number_details = (TYPEOF(h.ni_number_details))'',0,100));
    maxlength_ni_number_details := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ni_number_details)));
    avelength_ni_number_details := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ni_number_details)),h.ni_number_details<>(typeof(h.ni_number_details))'');
    populated_id_id_1_pcnt := AVE(GROUP,IF(h.id_id_1 = (TYPEOF(h.id_id_1))'',0,100));
    maxlength_id_id_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_1)));
    avelength_id_id_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_1)),h.id_id_1<>(typeof(h.id_id_1))'');
    populated_id_id_2_pcnt := AVE(GROUP,IF(h.id_id_2 = (TYPEOF(h.id_id_2))'',0,100));
    maxlength_id_id_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_2)));
    avelength_id_id_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_2)),h.id_id_2<>(typeof(h.id_id_2))'');
    populated_id_id_3_pcnt := AVE(GROUP,IF(h.id_id_3 = (TYPEOF(h.id_id_3))'',0,100));
    maxlength_id_id_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_3)));
    avelength_id_id_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_3)),h.id_id_3<>(typeof(h.id_id_3))'');
    populated_id_id_4_pcnt := AVE(GROUP,IF(h.id_id_4 = (TYPEOF(h.id_id_4))'',0,100));
    maxlength_id_id_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_4)));
    avelength_id_id_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_4)),h.id_id_4<>(typeof(h.id_id_4))'');
    populated_id_id_5_pcnt := AVE(GROUP,IF(h.id_id_5 = (TYPEOF(h.id_id_5))'',0,100));
    maxlength_id_id_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_5)));
    avelength_id_id_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_5)),h.id_id_5<>(typeof(h.id_id_5))'');
    populated_id_id_6_pcnt := AVE(GROUP,IF(h.id_id_6 = (TYPEOF(h.id_id_6))'',0,100));
    maxlength_id_id_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_6)));
    avelength_id_id_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_6)),h.id_id_6<>(typeof(h.id_id_6))'');
    populated_id_id_7_pcnt := AVE(GROUP,IF(h.id_id_7 = (TYPEOF(h.id_id_7))'',0,100));
    maxlength_id_id_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_7)));
    avelength_id_id_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_7)),h.id_id_7<>(typeof(h.id_id_7))'');
    populated_id_id_8_pcnt := AVE(GROUP,IF(h.id_id_8 = (TYPEOF(h.id_id_8))'',0,100));
    maxlength_id_id_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_8)));
    avelength_id_id_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_8)),h.id_id_8<>(typeof(h.id_id_8))'');
    populated_id_id_9_pcnt := AVE(GROUP,IF(h.id_id_9 = (TYPEOF(h.id_id_9))'',0,100));
    maxlength_id_id_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_9)));
    avelength_id_id_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_9)),h.id_id_9<>(typeof(h.id_id_9))'');
    populated_id_id_10_pcnt := AVE(GROUP,IF(h.id_id_10 = (TYPEOF(h.id_id_10))'',0,100));
    maxlength_id_id_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_10)));
    avelength_id_id_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_id_10)),h.id_id_10<>(typeof(h.id_id_10))'');
    populated_id_type_1_pcnt := AVE(GROUP,IF(h.id_type_1 = (TYPEOF(h.id_type_1))'',0,100));
    maxlength_id_type_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_1)));
    avelength_id_type_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_1)),h.id_type_1<>(typeof(h.id_type_1))'');
    populated_id_type_2_pcnt := AVE(GROUP,IF(h.id_type_2 = (TYPEOF(h.id_type_2))'',0,100));
    maxlength_id_type_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_2)));
    avelength_id_type_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_2)),h.id_type_2<>(typeof(h.id_type_2))'');
    populated_id_type_3_pcnt := AVE(GROUP,IF(h.id_type_3 = (TYPEOF(h.id_type_3))'',0,100));
    maxlength_id_type_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_3)));
    avelength_id_type_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_3)),h.id_type_3<>(typeof(h.id_type_3))'');
    populated_id_type_4_pcnt := AVE(GROUP,IF(h.id_type_4 = (TYPEOF(h.id_type_4))'',0,100));
    maxlength_id_type_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_4)));
    avelength_id_type_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_4)),h.id_type_4<>(typeof(h.id_type_4))'');
    populated_id_type_5_pcnt := AVE(GROUP,IF(h.id_type_5 = (TYPEOF(h.id_type_5))'',0,100));
    maxlength_id_type_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_5)));
    avelength_id_type_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_5)),h.id_type_5<>(typeof(h.id_type_5))'');
    populated_id_type_6_pcnt := AVE(GROUP,IF(h.id_type_6 = (TYPEOF(h.id_type_6))'',0,100));
    maxlength_id_type_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_6)));
    avelength_id_type_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_6)),h.id_type_6<>(typeof(h.id_type_6))'');
    populated_id_type_7_pcnt := AVE(GROUP,IF(h.id_type_7 = (TYPEOF(h.id_type_7))'',0,100));
    maxlength_id_type_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_7)));
    avelength_id_type_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_7)),h.id_type_7<>(typeof(h.id_type_7))'');
    populated_id_type_8_pcnt := AVE(GROUP,IF(h.id_type_8 = (TYPEOF(h.id_type_8))'',0,100));
    maxlength_id_type_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_8)));
    avelength_id_type_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_8)),h.id_type_8<>(typeof(h.id_type_8))'');
    populated_id_type_9_pcnt := AVE(GROUP,IF(h.id_type_9 = (TYPEOF(h.id_type_9))'',0,100));
    maxlength_id_type_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_9)));
    avelength_id_type_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_9)),h.id_type_9<>(typeof(h.id_type_9))'');
    populated_id_type_10_pcnt := AVE(GROUP,IF(h.id_type_10 = (TYPEOF(h.id_type_10))'',0,100));
    maxlength_id_type_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_10)));
    avelength_id_type_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_type_10)),h.id_type_10<>(typeof(h.id_type_10))'');
    populated_id_number_1_pcnt := AVE(GROUP,IF(h.id_number_1 = (TYPEOF(h.id_number_1))'',0,100));
    maxlength_id_number_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_1)));
    avelength_id_number_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_1)),h.id_number_1<>(typeof(h.id_number_1))'');
    populated_id_number_2_pcnt := AVE(GROUP,IF(h.id_number_2 = (TYPEOF(h.id_number_2))'',0,100));
    maxlength_id_number_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_2)));
    avelength_id_number_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_2)),h.id_number_2<>(typeof(h.id_number_2))'');
    populated_id_number_3_pcnt := AVE(GROUP,IF(h.id_number_3 = (TYPEOF(h.id_number_3))'',0,100));
    maxlength_id_number_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_3)));
    avelength_id_number_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_3)),h.id_number_3<>(typeof(h.id_number_3))'');
    populated_id_number_4_pcnt := AVE(GROUP,IF(h.id_number_4 = (TYPEOF(h.id_number_4))'',0,100));
    maxlength_id_number_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_4)));
    avelength_id_number_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_4)),h.id_number_4<>(typeof(h.id_number_4))'');
    populated_id_number_5_pcnt := AVE(GROUP,IF(h.id_number_5 = (TYPEOF(h.id_number_5))'',0,100));
    maxlength_id_number_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_5)));
    avelength_id_number_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_5)),h.id_number_5<>(typeof(h.id_number_5))'');
    populated_id_number_6_pcnt := AVE(GROUP,IF(h.id_number_6 = (TYPEOF(h.id_number_6))'',0,100));
    maxlength_id_number_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_6)));
    avelength_id_number_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_6)),h.id_number_6<>(typeof(h.id_number_6))'');
    populated_id_number_7_pcnt := AVE(GROUP,IF(h.id_number_7 = (TYPEOF(h.id_number_7))'',0,100));
    maxlength_id_number_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_7)));
    avelength_id_number_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_7)),h.id_number_7<>(typeof(h.id_number_7))'');
    populated_id_number_8_pcnt := AVE(GROUP,IF(h.id_number_8 = (TYPEOF(h.id_number_8))'',0,100));
    maxlength_id_number_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_8)));
    avelength_id_number_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_8)),h.id_number_8<>(typeof(h.id_number_8))'');
    populated_id_number_9_pcnt := AVE(GROUP,IF(h.id_number_9 = (TYPEOF(h.id_number_9))'',0,100));
    maxlength_id_number_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_9)));
    avelength_id_number_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_9)),h.id_number_9<>(typeof(h.id_number_9))'');
    populated_id_number_10_pcnt := AVE(GROUP,IF(h.id_number_10 = (TYPEOF(h.id_number_10))'',0,100));
    maxlength_id_number_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_10)));
    avelength_id_number_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_number_10)),h.id_number_10<>(typeof(h.id_number_10))'');
    populated_id_country_1_pcnt := AVE(GROUP,IF(h.id_country_1 = (TYPEOF(h.id_country_1))'',0,100));
    maxlength_id_country_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_1)));
    avelength_id_country_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_1)),h.id_country_1<>(typeof(h.id_country_1))'');
    populated_id_country_2_pcnt := AVE(GROUP,IF(h.id_country_2 = (TYPEOF(h.id_country_2))'',0,100));
    maxlength_id_country_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_2)));
    avelength_id_country_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_2)),h.id_country_2<>(typeof(h.id_country_2))'');
    populated_id_country_3_pcnt := AVE(GROUP,IF(h.id_country_3 = (TYPEOF(h.id_country_3))'',0,100));
    maxlength_id_country_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_3)));
    avelength_id_country_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_3)),h.id_country_3<>(typeof(h.id_country_3))'');
    populated_id_country_4_pcnt := AVE(GROUP,IF(h.id_country_4 = (TYPEOF(h.id_country_4))'',0,100));
    maxlength_id_country_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_4)));
    avelength_id_country_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_4)),h.id_country_4<>(typeof(h.id_country_4))'');
    populated_id_country_5_pcnt := AVE(GROUP,IF(h.id_country_5 = (TYPEOF(h.id_country_5))'',0,100));
    maxlength_id_country_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_5)));
    avelength_id_country_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_5)),h.id_country_5<>(typeof(h.id_country_5))'');
    populated_id_country_6_pcnt := AVE(GROUP,IF(h.id_country_6 = (TYPEOF(h.id_country_6))'',0,100));
    maxlength_id_country_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_6)));
    avelength_id_country_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_6)),h.id_country_6<>(typeof(h.id_country_6))'');
    populated_id_country_7_pcnt := AVE(GROUP,IF(h.id_country_7 = (TYPEOF(h.id_country_7))'',0,100));
    maxlength_id_country_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_7)));
    avelength_id_country_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_7)),h.id_country_7<>(typeof(h.id_country_7))'');
    populated_id_country_8_pcnt := AVE(GROUP,IF(h.id_country_8 = (TYPEOF(h.id_country_8))'',0,100));
    maxlength_id_country_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_8)));
    avelength_id_country_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_8)),h.id_country_8<>(typeof(h.id_country_8))'');
    populated_id_country_9_pcnt := AVE(GROUP,IF(h.id_country_9 = (TYPEOF(h.id_country_9))'',0,100));
    maxlength_id_country_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_9)));
    avelength_id_country_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_9)),h.id_country_9<>(typeof(h.id_country_9))'');
    populated_id_country_10_pcnt := AVE(GROUP,IF(h.id_country_10 = (TYPEOF(h.id_country_10))'',0,100));
    maxlength_id_country_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_10)));
    avelength_id_country_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_country_10)),h.id_country_10<>(typeof(h.id_country_10))'');
    populated_id_issue_date_1_pcnt := AVE(GROUP,IF(h.id_issue_date_1 = (TYPEOF(h.id_issue_date_1))'',0,100));
    maxlength_id_issue_date_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_1)));
    avelength_id_issue_date_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_1)),h.id_issue_date_1<>(typeof(h.id_issue_date_1))'');
    populated_id_issue_date_2_pcnt := AVE(GROUP,IF(h.id_issue_date_2 = (TYPEOF(h.id_issue_date_2))'',0,100));
    maxlength_id_issue_date_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_2)));
    avelength_id_issue_date_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_2)),h.id_issue_date_2<>(typeof(h.id_issue_date_2))'');
    populated_id_issue_date_3_pcnt := AVE(GROUP,IF(h.id_issue_date_3 = (TYPEOF(h.id_issue_date_3))'',0,100));
    maxlength_id_issue_date_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_3)));
    avelength_id_issue_date_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_3)),h.id_issue_date_3<>(typeof(h.id_issue_date_3))'');
    populated_id_issue_date_4_pcnt := AVE(GROUP,IF(h.id_issue_date_4 = (TYPEOF(h.id_issue_date_4))'',0,100));
    maxlength_id_issue_date_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_4)));
    avelength_id_issue_date_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_4)),h.id_issue_date_4<>(typeof(h.id_issue_date_4))'');
    populated_id_issue_date_5_pcnt := AVE(GROUP,IF(h.id_issue_date_5 = (TYPEOF(h.id_issue_date_5))'',0,100));
    maxlength_id_issue_date_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_5)));
    avelength_id_issue_date_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_5)),h.id_issue_date_5<>(typeof(h.id_issue_date_5))'');
    populated_id_issue_date_6_pcnt := AVE(GROUP,IF(h.id_issue_date_6 = (TYPEOF(h.id_issue_date_6))'',0,100));
    maxlength_id_issue_date_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_6)));
    avelength_id_issue_date_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_6)),h.id_issue_date_6<>(typeof(h.id_issue_date_6))'');
    populated_id_issue_date_7_pcnt := AVE(GROUP,IF(h.id_issue_date_7 = (TYPEOF(h.id_issue_date_7))'',0,100));
    maxlength_id_issue_date_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_7)));
    avelength_id_issue_date_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_7)),h.id_issue_date_7<>(typeof(h.id_issue_date_7))'');
    populated_id_issue_date_8_pcnt := AVE(GROUP,IF(h.id_issue_date_8 = (TYPEOF(h.id_issue_date_8))'',0,100));
    maxlength_id_issue_date_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_8)));
    avelength_id_issue_date_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_8)),h.id_issue_date_8<>(typeof(h.id_issue_date_8))'');
    populated_id_issue_date_9_pcnt := AVE(GROUP,IF(h.id_issue_date_9 = (TYPEOF(h.id_issue_date_9))'',0,100));
    maxlength_id_issue_date_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_9)));
    avelength_id_issue_date_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_9)),h.id_issue_date_9<>(typeof(h.id_issue_date_9))'');
    populated_id_issue_date_10_pcnt := AVE(GROUP,IF(h.id_issue_date_10 = (TYPEOF(h.id_issue_date_10))'',0,100));
    maxlength_id_issue_date_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_10)));
    avelength_id_issue_date_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_issue_date_10)),h.id_issue_date_10<>(typeof(h.id_issue_date_10))'');
    populated_id_expiration_date_1_pcnt := AVE(GROUP,IF(h.id_expiration_date_1 = (TYPEOF(h.id_expiration_date_1))'',0,100));
    maxlength_id_expiration_date_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_1)));
    avelength_id_expiration_date_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_1)),h.id_expiration_date_1<>(typeof(h.id_expiration_date_1))'');
    populated_id_expiration_date_2_pcnt := AVE(GROUP,IF(h.id_expiration_date_2 = (TYPEOF(h.id_expiration_date_2))'',0,100));
    maxlength_id_expiration_date_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_2)));
    avelength_id_expiration_date_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_2)),h.id_expiration_date_2<>(typeof(h.id_expiration_date_2))'');
    populated_id_expiration_date_3_pcnt := AVE(GROUP,IF(h.id_expiration_date_3 = (TYPEOF(h.id_expiration_date_3))'',0,100));
    maxlength_id_expiration_date_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_3)));
    avelength_id_expiration_date_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_3)),h.id_expiration_date_3<>(typeof(h.id_expiration_date_3))'');
    populated_id_expiration_date_4_pcnt := AVE(GROUP,IF(h.id_expiration_date_4 = (TYPEOF(h.id_expiration_date_4))'',0,100));
    maxlength_id_expiration_date_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_4)));
    avelength_id_expiration_date_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_4)),h.id_expiration_date_4<>(typeof(h.id_expiration_date_4))'');
    populated_id_expiration_date_5_pcnt := AVE(GROUP,IF(h.id_expiration_date_5 = (TYPEOF(h.id_expiration_date_5))'',0,100));
    maxlength_id_expiration_date_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_5)));
    avelength_id_expiration_date_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_5)),h.id_expiration_date_5<>(typeof(h.id_expiration_date_5))'');
    populated_id_expiration_date_6_pcnt := AVE(GROUP,IF(h.id_expiration_date_6 = (TYPEOF(h.id_expiration_date_6))'',0,100));
    maxlength_id_expiration_date_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_6)));
    avelength_id_expiration_date_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_6)),h.id_expiration_date_6<>(typeof(h.id_expiration_date_6))'');
    populated_id_expiration_date_7_pcnt := AVE(GROUP,IF(h.id_expiration_date_7 = (TYPEOF(h.id_expiration_date_7))'',0,100));
    maxlength_id_expiration_date_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_7)));
    avelength_id_expiration_date_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_7)),h.id_expiration_date_7<>(typeof(h.id_expiration_date_7))'');
    populated_id_expiration_date_8_pcnt := AVE(GROUP,IF(h.id_expiration_date_8 = (TYPEOF(h.id_expiration_date_8))'',0,100));
    maxlength_id_expiration_date_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_8)));
    avelength_id_expiration_date_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_8)),h.id_expiration_date_8<>(typeof(h.id_expiration_date_8))'');
    populated_id_expiration_date_9_pcnt := AVE(GROUP,IF(h.id_expiration_date_9 = (TYPEOF(h.id_expiration_date_9))'',0,100));
    maxlength_id_expiration_date_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_9)));
    avelength_id_expiration_date_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_9)),h.id_expiration_date_9<>(typeof(h.id_expiration_date_9))'');
    populated_id_expiration_date_10_pcnt := AVE(GROUP,IF(h.id_expiration_date_10 = (TYPEOF(h.id_expiration_date_10))'',0,100));
    maxlength_id_expiration_date_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_10)));
    avelength_id_expiration_date_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.id_expiration_date_10)),h.id_expiration_date_10<>(typeof(h.id_expiration_date_10))'');
    populated_nationality_id_1_pcnt := AVE(GROUP,IF(h.nationality_id_1 = (TYPEOF(h.nationality_id_1))'',0,100));
    maxlength_nationality_id_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_1)));
    avelength_nationality_id_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_1)),h.nationality_id_1<>(typeof(h.nationality_id_1))'');
    populated_nationality_id_2_pcnt := AVE(GROUP,IF(h.nationality_id_2 = (TYPEOF(h.nationality_id_2))'',0,100));
    maxlength_nationality_id_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_2)));
    avelength_nationality_id_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_2)),h.nationality_id_2<>(typeof(h.nationality_id_2))'');
    populated_nationality_id_3_pcnt := AVE(GROUP,IF(h.nationality_id_3 = (TYPEOF(h.nationality_id_3))'',0,100));
    maxlength_nationality_id_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_3)));
    avelength_nationality_id_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_3)),h.nationality_id_3<>(typeof(h.nationality_id_3))'');
    populated_nationality_id_4_pcnt := AVE(GROUP,IF(h.nationality_id_4 = (TYPEOF(h.nationality_id_4))'',0,100));
    maxlength_nationality_id_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_4)));
    avelength_nationality_id_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_4)),h.nationality_id_4<>(typeof(h.nationality_id_4))'');
    populated_nationality_id_5_pcnt := AVE(GROUP,IF(h.nationality_id_5 = (TYPEOF(h.nationality_id_5))'',0,100));
    maxlength_nationality_id_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_5)));
    avelength_nationality_id_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_5)),h.nationality_id_5<>(typeof(h.nationality_id_5))'');
    populated_nationality_id_6_pcnt := AVE(GROUP,IF(h.nationality_id_6 = (TYPEOF(h.nationality_id_6))'',0,100));
    maxlength_nationality_id_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_6)));
    avelength_nationality_id_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_6)),h.nationality_id_6<>(typeof(h.nationality_id_6))'');
    populated_nationality_id_7_pcnt := AVE(GROUP,IF(h.nationality_id_7 = (TYPEOF(h.nationality_id_7))'',0,100));
    maxlength_nationality_id_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_7)));
    avelength_nationality_id_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_7)),h.nationality_id_7<>(typeof(h.nationality_id_7))'');
    populated_nationality_id_8_pcnt := AVE(GROUP,IF(h.nationality_id_8 = (TYPEOF(h.nationality_id_8))'',0,100));
    maxlength_nationality_id_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_8)));
    avelength_nationality_id_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_8)),h.nationality_id_8<>(typeof(h.nationality_id_8))'');
    populated_nationality_id_9_pcnt := AVE(GROUP,IF(h.nationality_id_9 = (TYPEOF(h.nationality_id_9))'',0,100));
    maxlength_nationality_id_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_9)));
    avelength_nationality_id_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_9)),h.nationality_id_9<>(typeof(h.nationality_id_9))'');
    populated_nationality_id_10_pcnt := AVE(GROUP,IF(h.nationality_id_10 = (TYPEOF(h.nationality_id_10))'',0,100));
    maxlength_nationality_id_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_10)));
    avelength_nationality_id_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_id_10)),h.nationality_id_10<>(typeof(h.nationality_id_10))'');
    populated_nationality_1_pcnt := AVE(GROUP,IF(h.nationality_1 = (TYPEOF(h.nationality_1))'',0,100));
    maxlength_nationality_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_1)));
    avelength_nationality_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_1)),h.nationality_1<>(typeof(h.nationality_1))'');
    populated_nationality_2_pcnt := AVE(GROUP,IF(h.nationality_2 = (TYPEOF(h.nationality_2))'',0,100));
    maxlength_nationality_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_2)));
    avelength_nationality_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_2)),h.nationality_2<>(typeof(h.nationality_2))'');
    populated_nationality_3_pcnt := AVE(GROUP,IF(h.nationality_3 = (TYPEOF(h.nationality_3))'',0,100));
    maxlength_nationality_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_3)));
    avelength_nationality_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_3)),h.nationality_3<>(typeof(h.nationality_3))'');
    populated_nationality_4_pcnt := AVE(GROUP,IF(h.nationality_4 = (TYPEOF(h.nationality_4))'',0,100));
    maxlength_nationality_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_4)));
    avelength_nationality_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_4)),h.nationality_4<>(typeof(h.nationality_4))'');
    populated_nationality_5_pcnt := AVE(GROUP,IF(h.nationality_5 = (TYPEOF(h.nationality_5))'',0,100));
    maxlength_nationality_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_5)));
    avelength_nationality_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_5)),h.nationality_5<>(typeof(h.nationality_5))'');
    populated_nationality_6_pcnt := AVE(GROUP,IF(h.nationality_6 = (TYPEOF(h.nationality_6))'',0,100));
    maxlength_nationality_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_6)));
    avelength_nationality_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_6)),h.nationality_6<>(typeof(h.nationality_6))'');
    populated_nationality_7_pcnt := AVE(GROUP,IF(h.nationality_7 = (TYPEOF(h.nationality_7))'',0,100));
    maxlength_nationality_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_7)));
    avelength_nationality_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_7)),h.nationality_7<>(typeof(h.nationality_7))'');
    populated_nationality_8_pcnt := AVE(GROUP,IF(h.nationality_8 = (TYPEOF(h.nationality_8))'',0,100));
    maxlength_nationality_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_8)));
    avelength_nationality_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_8)),h.nationality_8<>(typeof(h.nationality_8))'');
    populated_nationality_9_pcnt := AVE(GROUP,IF(h.nationality_9 = (TYPEOF(h.nationality_9))'',0,100));
    maxlength_nationality_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_9)));
    avelength_nationality_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_9)),h.nationality_9<>(typeof(h.nationality_9))'');
    populated_nationality_10_pcnt := AVE(GROUP,IF(h.nationality_10 = (TYPEOF(h.nationality_10))'',0,100));
    maxlength_nationality_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_10)));
    avelength_nationality_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nationality_10)),h.nationality_10<>(typeof(h.nationality_10))'');
    populated_primary_nationality_flag_1_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_1 = (TYPEOF(h.primary_nationality_flag_1))'',0,100));
    maxlength_primary_nationality_flag_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_1)));
    avelength_primary_nationality_flag_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_1)),h.primary_nationality_flag_1<>(typeof(h.primary_nationality_flag_1))'');
    populated_primary_nationality_flag_2_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_2 = (TYPEOF(h.primary_nationality_flag_2))'',0,100));
    maxlength_primary_nationality_flag_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_2)));
    avelength_primary_nationality_flag_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_2)),h.primary_nationality_flag_2<>(typeof(h.primary_nationality_flag_2))'');
    populated_primary_nationality_flag_3_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_3 = (TYPEOF(h.primary_nationality_flag_3))'',0,100));
    maxlength_primary_nationality_flag_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_3)));
    avelength_primary_nationality_flag_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_3)),h.primary_nationality_flag_3<>(typeof(h.primary_nationality_flag_3))'');
    populated_primary_nationality_flag_4_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_4 = (TYPEOF(h.primary_nationality_flag_4))'',0,100));
    maxlength_primary_nationality_flag_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_4)));
    avelength_primary_nationality_flag_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_4)),h.primary_nationality_flag_4<>(typeof(h.primary_nationality_flag_4))'');
    populated_primary_nationality_flag_5_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_5 = (TYPEOF(h.primary_nationality_flag_5))'',0,100));
    maxlength_primary_nationality_flag_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_5)));
    avelength_primary_nationality_flag_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_5)),h.primary_nationality_flag_5<>(typeof(h.primary_nationality_flag_5))'');
    populated_primary_nationality_flag_6_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_6 = (TYPEOF(h.primary_nationality_flag_6))'',0,100));
    maxlength_primary_nationality_flag_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_6)));
    avelength_primary_nationality_flag_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_6)),h.primary_nationality_flag_6<>(typeof(h.primary_nationality_flag_6))'');
    populated_primary_nationality_flag_7_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_7 = (TYPEOF(h.primary_nationality_flag_7))'',0,100));
    maxlength_primary_nationality_flag_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_7)));
    avelength_primary_nationality_flag_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_7)),h.primary_nationality_flag_7<>(typeof(h.primary_nationality_flag_7))'');
    populated_primary_nationality_flag_8_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_8 = (TYPEOF(h.primary_nationality_flag_8))'',0,100));
    maxlength_primary_nationality_flag_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_8)));
    avelength_primary_nationality_flag_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_8)),h.primary_nationality_flag_8<>(typeof(h.primary_nationality_flag_8))'');
    populated_primary_nationality_flag_9_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_9 = (TYPEOF(h.primary_nationality_flag_9))'',0,100));
    maxlength_primary_nationality_flag_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_9)));
    avelength_primary_nationality_flag_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_9)),h.primary_nationality_flag_9<>(typeof(h.primary_nationality_flag_9))'');
    populated_primary_nationality_flag_10_pcnt := AVE(GROUP,IF(h.primary_nationality_flag_10 = (TYPEOF(h.primary_nationality_flag_10))'',0,100));
    maxlength_primary_nationality_flag_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_10)));
    avelength_primary_nationality_flag_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_nationality_flag_10)),h.primary_nationality_flag_10<>(typeof(h.primary_nationality_flag_10))'');
    populated_citizenship_id_1_pcnt := AVE(GROUP,IF(h.citizenship_id_1 = (TYPEOF(h.citizenship_id_1))'',0,100));
    maxlength_citizenship_id_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_1)));
    avelength_citizenship_id_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_1)),h.citizenship_id_1<>(typeof(h.citizenship_id_1))'');
    populated_citizenship_id_2_pcnt := AVE(GROUP,IF(h.citizenship_id_2 = (TYPEOF(h.citizenship_id_2))'',0,100));
    maxlength_citizenship_id_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_2)));
    avelength_citizenship_id_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_2)),h.citizenship_id_2<>(typeof(h.citizenship_id_2))'');
    populated_citizenship_id_3_pcnt := AVE(GROUP,IF(h.citizenship_id_3 = (TYPEOF(h.citizenship_id_3))'',0,100));
    maxlength_citizenship_id_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_3)));
    avelength_citizenship_id_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_3)),h.citizenship_id_3<>(typeof(h.citizenship_id_3))'');
    populated_citizenship_id_4_pcnt := AVE(GROUP,IF(h.citizenship_id_4 = (TYPEOF(h.citizenship_id_4))'',0,100));
    maxlength_citizenship_id_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_4)));
    avelength_citizenship_id_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_4)),h.citizenship_id_4<>(typeof(h.citizenship_id_4))'');
    populated_citizenship_id_5_pcnt := AVE(GROUP,IF(h.citizenship_id_5 = (TYPEOF(h.citizenship_id_5))'',0,100));
    maxlength_citizenship_id_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_5)));
    avelength_citizenship_id_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_5)),h.citizenship_id_5<>(typeof(h.citizenship_id_5))'');
    populated_citizenship_id_6_pcnt := AVE(GROUP,IF(h.citizenship_id_6 = (TYPEOF(h.citizenship_id_6))'',0,100));
    maxlength_citizenship_id_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_6)));
    avelength_citizenship_id_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_6)),h.citizenship_id_6<>(typeof(h.citizenship_id_6))'');
    populated_citizenship_id_7_pcnt := AVE(GROUP,IF(h.citizenship_id_7 = (TYPEOF(h.citizenship_id_7))'',0,100));
    maxlength_citizenship_id_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_7)));
    avelength_citizenship_id_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_7)),h.citizenship_id_7<>(typeof(h.citizenship_id_7))'');
    populated_citizenship_id_8_pcnt := AVE(GROUP,IF(h.citizenship_id_8 = (TYPEOF(h.citizenship_id_8))'',0,100));
    maxlength_citizenship_id_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_8)));
    avelength_citizenship_id_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_8)),h.citizenship_id_8<>(typeof(h.citizenship_id_8))'');
    populated_citizenship_id_9_pcnt := AVE(GROUP,IF(h.citizenship_id_9 = (TYPEOF(h.citizenship_id_9))'',0,100));
    maxlength_citizenship_id_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_9)));
    avelength_citizenship_id_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_9)),h.citizenship_id_9<>(typeof(h.citizenship_id_9))'');
    populated_citizenship_id_10_pcnt := AVE(GROUP,IF(h.citizenship_id_10 = (TYPEOF(h.citizenship_id_10))'',0,100));
    maxlength_citizenship_id_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_10)));
    avelength_citizenship_id_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_id_10)),h.citizenship_id_10<>(typeof(h.citizenship_id_10))'');
    populated_citizenship_1_pcnt := AVE(GROUP,IF(h.citizenship_1 = (TYPEOF(h.citizenship_1))'',0,100));
    maxlength_citizenship_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_1)));
    avelength_citizenship_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_1)),h.citizenship_1<>(typeof(h.citizenship_1))'');
    populated_citizenship_2_pcnt := AVE(GROUP,IF(h.citizenship_2 = (TYPEOF(h.citizenship_2))'',0,100));
    maxlength_citizenship_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_2)));
    avelength_citizenship_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_2)),h.citizenship_2<>(typeof(h.citizenship_2))'');
    populated_citizenship_3_pcnt := AVE(GROUP,IF(h.citizenship_3 = (TYPEOF(h.citizenship_3))'',0,100));
    maxlength_citizenship_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_3)));
    avelength_citizenship_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_3)),h.citizenship_3<>(typeof(h.citizenship_3))'');
    populated_citizenship_4_pcnt := AVE(GROUP,IF(h.citizenship_4 = (TYPEOF(h.citizenship_4))'',0,100));
    maxlength_citizenship_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_4)));
    avelength_citizenship_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_4)),h.citizenship_4<>(typeof(h.citizenship_4))'');
    populated_citizenship_5_pcnt := AVE(GROUP,IF(h.citizenship_5 = (TYPEOF(h.citizenship_5))'',0,100));
    maxlength_citizenship_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_5)));
    avelength_citizenship_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_5)),h.citizenship_5<>(typeof(h.citizenship_5))'');
    populated_citizenship_6_pcnt := AVE(GROUP,IF(h.citizenship_6 = (TYPEOF(h.citizenship_6))'',0,100));
    maxlength_citizenship_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_6)));
    avelength_citizenship_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_6)),h.citizenship_6<>(typeof(h.citizenship_6))'');
    populated_citizenship_7_pcnt := AVE(GROUP,IF(h.citizenship_7 = (TYPEOF(h.citizenship_7))'',0,100));
    maxlength_citizenship_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_7)));
    avelength_citizenship_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_7)),h.citizenship_7<>(typeof(h.citizenship_7))'');
    populated_citizenship_8_pcnt := AVE(GROUP,IF(h.citizenship_8 = (TYPEOF(h.citizenship_8))'',0,100));
    maxlength_citizenship_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_8)));
    avelength_citizenship_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_8)),h.citizenship_8<>(typeof(h.citizenship_8))'');
    populated_citizenship_9_pcnt := AVE(GROUP,IF(h.citizenship_9 = (TYPEOF(h.citizenship_9))'',0,100));
    maxlength_citizenship_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_9)));
    avelength_citizenship_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_9)),h.citizenship_9<>(typeof(h.citizenship_9))'');
    populated_citizenship_10_pcnt := AVE(GROUP,IF(h.citizenship_10 = (TYPEOF(h.citizenship_10))'',0,100));
    maxlength_citizenship_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_10)));
    avelength_citizenship_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citizenship_10)),h.citizenship_10<>(typeof(h.citizenship_10))'');
    populated_primary_citizenship_flag_1_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_1 = (TYPEOF(h.primary_citizenship_flag_1))'',0,100));
    maxlength_primary_citizenship_flag_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_1)));
    avelength_primary_citizenship_flag_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_1)),h.primary_citizenship_flag_1<>(typeof(h.primary_citizenship_flag_1))'');
    populated_primary_citizenship_flag_2_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_2 = (TYPEOF(h.primary_citizenship_flag_2))'',0,100));
    maxlength_primary_citizenship_flag_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_2)));
    avelength_primary_citizenship_flag_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_2)),h.primary_citizenship_flag_2<>(typeof(h.primary_citizenship_flag_2))'');
    populated_primary_citizenship_flag_3_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_3 = (TYPEOF(h.primary_citizenship_flag_3))'',0,100));
    maxlength_primary_citizenship_flag_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_3)));
    avelength_primary_citizenship_flag_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_3)),h.primary_citizenship_flag_3<>(typeof(h.primary_citizenship_flag_3))'');
    populated_primary_citizenship_flag_4_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_4 = (TYPEOF(h.primary_citizenship_flag_4))'',0,100));
    maxlength_primary_citizenship_flag_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_4)));
    avelength_primary_citizenship_flag_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_4)),h.primary_citizenship_flag_4<>(typeof(h.primary_citizenship_flag_4))'');
    populated_primary_citizenship_flag_5_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_5 = (TYPEOF(h.primary_citizenship_flag_5))'',0,100));
    maxlength_primary_citizenship_flag_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_5)));
    avelength_primary_citizenship_flag_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_5)),h.primary_citizenship_flag_5<>(typeof(h.primary_citizenship_flag_5))'');
    populated_primary_citizenship_flag_6_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_6 = (TYPEOF(h.primary_citizenship_flag_6))'',0,100));
    maxlength_primary_citizenship_flag_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_6)));
    avelength_primary_citizenship_flag_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_6)),h.primary_citizenship_flag_6<>(typeof(h.primary_citizenship_flag_6))'');
    populated_primary_citizenship_flag_7_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_7 = (TYPEOF(h.primary_citizenship_flag_7))'',0,100));
    maxlength_primary_citizenship_flag_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_7)));
    avelength_primary_citizenship_flag_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_7)),h.primary_citizenship_flag_7<>(typeof(h.primary_citizenship_flag_7))'');
    populated_primary_citizenship_flag_8_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_8 = (TYPEOF(h.primary_citizenship_flag_8))'',0,100));
    maxlength_primary_citizenship_flag_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_8)));
    avelength_primary_citizenship_flag_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_8)),h.primary_citizenship_flag_8<>(typeof(h.primary_citizenship_flag_8))'');
    populated_primary_citizenship_flag_9_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_9 = (TYPEOF(h.primary_citizenship_flag_9))'',0,100));
    maxlength_primary_citizenship_flag_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_9)));
    avelength_primary_citizenship_flag_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_9)),h.primary_citizenship_flag_9<>(typeof(h.primary_citizenship_flag_9))'');
    populated_primary_citizenship_flag_10_pcnt := AVE(GROUP,IF(h.primary_citizenship_flag_10 = (TYPEOF(h.primary_citizenship_flag_10))'',0,100));
    maxlength_primary_citizenship_flag_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_10)));
    avelength_primary_citizenship_flag_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_citizenship_flag_10)),h.primary_citizenship_flag_10<>(typeof(h.primary_citizenship_flag_10))'');
    populated_dob_id_1_pcnt := AVE(GROUP,IF(h.dob_id_1 = (TYPEOF(h.dob_id_1))'',0,100));
    maxlength_dob_id_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_1)));
    avelength_dob_id_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_1)),h.dob_id_1<>(typeof(h.dob_id_1))'');
    populated_dob_id_2_pcnt := AVE(GROUP,IF(h.dob_id_2 = (TYPEOF(h.dob_id_2))'',0,100));
    maxlength_dob_id_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_2)));
    avelength_dob_id_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_2)),h.dob_id_2<>(typeof(h.dob_id_2))'');
    populated_dob_id_3_pcnt := AVE(GROUP,IF(h.dob_id_3 = (TYPEOF(h.dob_id_3))'',0,100));
    maxlength_dob_id_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_3)));
    avelength_dob_id_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_3)),h.dob_id_3<>(typeof(h.dob_id_3))'');
    populated_dob_id_4_pcnt := AVE(GROUP,IF(h.dob_id_4 = (TYPEOF(h.dob_id_4))'',0,100));
    maxlength_dob_id_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_4)));
    avelength_dob_id_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_4)),h.dob_id_4<>(typeof(h.dob_id_4))'');
    populated_dob_id_5_pcnt := AVE(GROUP,IF(h.dob_id_5 = (TYPEOF(h.dob_id_5))'',0,100));
    maxlength_dob_id_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_5)));
    avelength_dob_id_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_5)),h.dob_id_5<>(typeof(h.dob_id_5))'');
    populated_dob_id_6_pcnt := AVE(GROUP,IF(h.dob_id_6 = (TYPEOF(h.dob_id_6))'',0,100));
    maxlength_dob_id_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_6)));
    avelength_dob_id_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_6)),h.dob_id_6<>(typeof(h.dob_id_6))'');
    populated_dob_id_7_pcnt := AVE(GROUP,IF(h.dob_id_7 = (TYPEOF(h.dob_id_7))'',0,100));
    maxlength_dob_id_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_7)));
    avelength_dob_id_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_7)),h.dob_id_7<>(typeof(h.dob_id_7))'');
    populated_dob_id_8_pcnt := AVE(GROUP,IF(h.dob_id_8 = (TYPEOF(h.dob_id_8))'',0,100));
    maxlength_dob_id_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_8)));
    avelength_dob_id_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_8)),h.dob_id_8<>(typeof(h.dob_id_8))'');
    populated_dob_id_9_pcnt := AVE(GROUP,IF(h.dob_id_9 = (TYPEOF(h.dob_id_9))'',0,100));
    maxlength_dob_id_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_9)));
    avelength_dob_id_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_9)),h.dob_id_9<>(typeof(h.dob_id_9))'');
    populated_dob_id_10_pcnt := AVE(GROUP,IF(h.dob_id_10 = (TYPEOF(h.dob_id_10))'',0,100));
    maxlength_dob_id_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_10)));
    avelength_dob_id_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_id_10)),h.dob_id_10<>(typeof(h.dob_id_10))'');
    populated_dob_1_pcnt := AVE(GROUP,IF(h.dob_1 = (TYPEOF(h.dob_1))'',0,100));
    maxlength_dob_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_1)));
    avelength_dob_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_1)),h.dob_1<>(typeof(h.dob_1))'');
    populated_dob_2_pcnt := AVE(GROUP,IF(h.dob_2 = (TYPEOF(h.dob_2))'',0,100));
    maxlength_dob_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_2)));
    avelength_dob_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_2)),h.dob_2<>(typeof(h.dob_2))'');
    populated_dob_3_pcnt := AVE(GROUP,IF(h.dob_3 = (TYPEOF(h.dob_3))'',0,100));
    maxlength_dob_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_3)));
    avelength_dob_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_3)),h.dob_3<>(typeof(h.dob_3))'');
    populated_dob_4_pcnt := AVE(GROUP,IF(h.dob_4 = (TYPEOF(h.dob_4))'',0,100));
    maxlength_dob_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_4)));
    avelength_dob_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_4)),h.dob_4<>(typeof(h.dob_4))'');
    populated_dob_5_pcnt := AVE(GROUP,IF(h.dob_5 = (TYPEOF(h.dob_5))'',0,100));
    maxlength_dob_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_5)));
    avelength_dob_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_5)),h.dob_5<>(typeof(h.dob_5))'');
    populated_dob_6_pcnt := AVE(GROUP,IF(h.dob_6 = (TYPEOF(h.dob_6))'',0,100));
    maxlength_dob_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_6)));
    avelength_dob_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_6)),h.dob_6<>(typeof(h.dob_6))'');
    populated_dob_7_pcnt := AVE(GROUP,IF(h.dob_7 = (TYPEOF(h.dob_7))'',0,100));
    maxlength_dob_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_7)));
    avelength_dob_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_7)),h.dob_7<>(typeof(h.dob_7))'');
    populated_dob_8_pcnt := AVE(GROUP,IF(h.dob_8 = (TYPEOF(h.dob_8))'',0,100));
    maxlength_dob_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_8)));
    avelength_dob_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_8)),h.dob_8<>(typeof(h.dob_8))'');
    populated_dob_9_pcnt := AVE(GROUP,IF(h.dob_9 = (TYPEOF(h.dob_9))'',0,100));
    maxlength_dob_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_9)));
    avelength_dob_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_9)),h.dob_9<>(typeof(h.dob_9))'');
    populated_dob_10_pcnt := AVE(GROUP,IF(h.dob_10 = (TYPEOF(h.dob_10))'',0,100));
    maxlength_dob_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_10)));
    avelength_dob_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_10)),h.dob_10<>(typeof(h.dob_10))'');
    populated_primary_dob_flag_1_pcnt := AVE(GROUP,IF(h.primary_dob_flag_1 = (TYPEOF(h.primary_dob_flag_1))'',0,100));
    maxlength_primary_dob_flag_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_1)));
    avelength_primary_dob_flag_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_1)),h.primary_dob_flag_1<>(typeof(h.primary_dob_flag_1))'');
    populated_primary_dob_flag_2_pcnt := AVE(GROUP,IF(h.primary_dob_flag_2 = (TYPEOF(h.primary_dob_flag_2))'',0,100));
    maxlength_primary_dob_flag_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_2)));
    avelength_primary_dob_flag_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_2)),h.primary_dob_flag_2<>(typeof(h.primary_dob_flag_2))'');
    populated_primary_dob_flag_3_pcnt := AVE(GROUP,IF(h.primary_dob_flag_3 = (TYPEOF(h.primary_dob_flag_3))'',0,100));
    maxlength_primary_dob_flag_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_3)));
    avelength_primary_dob_flag_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_3)),h.primary_dob_flag_3<>(typeof(h.primary_dob_flag_3))'');
    populated_primary_dob_flag_4_pcnt := AVE(GROUP,IF(h.primary_dob_flag_4 = (TYPEOF(h.primary_dob_flag_4))'',0,100));
    maxlength_primary_dob_flag_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_4)));
    avelength_primary_dob_flag_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_4)),h.primary_dob_flag_4<>(typeof(h.primary_dob_flag_4))'');
    populated_primary_dob_flag_5_pcnt := AVE(GROUP,IF(h.primary_dob_flag_5 = (TYPEOF(h.primary_dob_flag_5))'',0,100));
    maxlength_primary_dob_flag_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_5)));
    avelength_primary_dob_flag_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_5)),h.primary_dob_flag_5<>(typeof(h.primary_dob_flag_5))'');
    populated_primary_dob_flag_6_pcnt := AVE(GROUP,IF(h.primary_dob_flag_6 = (TYPEOF(h.primary_dob_flag_6))'',0,100));
    maxlength_primary_dob_flag_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_6)));
    avelength_primary_dob_flag_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_6)),h.primary_dob_flag_6<>(typeof(h.primary_dob_flag_6))'');
    populated_primary_dob_flag_7_pcnt := AVE(GROUP,IF(h.primary_dob_flag_7 = (TYPEOF(h.primary_dob_flag_7))'',0,100));
    maxlength_primary_dob_flag_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_7)));
    avelength_primary_dob_flag_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_7)),h.primary_dob_flag_7<>(typeof(h.primary_dob_flag_7))'');
    populated_primary_dob_flag_8_pcnt := AVE(GROUP,IF(h.primary_dob_flag_8 = (TYPEOF(h.primary_dob_flag_8))'',0,100));
    maxlength_primary_dob_flag_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_8)));
    avelength_primary_dob_flag_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_8)),h.primary_dob_flag_8<>(typeof(h.primary_dob_flag_8))'');
    populated_primary_dob_flag_9_pcnt := AVE(GROUP,IF(h.primary_dob_flag_9 = (TYPEOF(h.primary_dob_flag_9))'',0,100));
    maxlength_primary_dob_flag_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_9)));
    avelength_primary_dob_flag_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_9)),h.primary_dob_flag_9<>(typeof(h.primary_dob_flag_9))'');
    populated_primary_dob_flag_10_pcnt := AVE(GROUP,IF(h.primary_dob_flag_10 = (TYPEOF(h.primary_dob_flag_10))'',0,100));
    maxlength_primary_dob_flag_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_10)));
    avelength_primary_dob_flag_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_dob_flag_10)),h.primary_dob_flag_10<>(typeof(h.primary_dob_flag_10))'');
    populated_pob_id_1_pcnt := AVE(GROUP,IF(h.pob_id_1 = (TYPEOF(h.pob_id_1))'',0,100));
    maxlength_pob_id_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_1)));
    avelength_pob_id_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_1)),h.pob_id_1<>(typeof(h.pob_id_1))'');
    populated_pob_id_2_pcnt := AVE(GROUP,IF(h.pob_id_2 = (TYPEOF(h.pob_id_2))'',0,100));
    maxlength_pob_id_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_2)));
    avelength_pob_id_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_2)),h.pob_id_2<>(typeof(h.pob_id_2))'');
    populated_pob_id_3_pcnt := AVE(GROUP,IF(h.pob_id_3 = (TYPEOF(h.pob_id_3))'',0,100));
    maxlength_pob_id_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_3)));
    avelength_pob_id_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_3)),h.pob_id_3<>(typeof(h.pob_id_3))'');
    populated_pob_id_4_pcnt := AVE(GROUP,IF(h.pob_id_4 = (TYPEOF(h.pob_id_4))'',0,100));
    maxlength_pob_id_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_4)));
    avelength_pob_id_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_4)),h.pob_id_4<>(typeof(h.pob_id_4))'');
    populated_pob_id_5_pcnt := AVE(GROUP,IF(h.pob_id_5 = (TYPEOF(h.pob_id_5))'',0,100));
    maxlength_pob_id_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_5)));
    avelength_pob_id_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_5)),h.pob_id_5<>(typeof(h.pob_id_5))'');
    populated_pob_id_6_pcnt := AVE(GROUP,IF(h.pob_id_6 = (TYPEOF(h.pob_id_6))'',0,100));
    maxlength_pob_id_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_6)));
    avelength_pob_id_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_6)),h.pob_id_6<>(typeof(h.pob_id_6))'');
    populated_pob_id_7_pcnt := AVE(GROUP,IF(h.pob_id_7 = (TYPEOF(h.pob_id_7))'',0,100));
    maxlength_pob_id_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_7)));
    avelength_pob_id_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_7)),h.pob_id_7<>(typeof(h.pob_id_7))'');
    populated_pob_id_8_pcnt := AVE(GROUP,IF(h.pob_id_8 = (TYPEOF(h.pob_id_8))'',0,100));
    maxlength_pob_id_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_8)));
    avelength_pob_id_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_8)),h.pob_id_8<>(typeof(h.pob_id_8))'');
    populated_pob_id_9_pcnt := AVE(GROUP,IF(h.pob_id_9 = (TYPEOF(h.pob_id_9))'',0,100));
    maxlength_pob_id_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_9)));
    avelength_pob_id_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_9)),h.pob_id_9<>(typeof(h.pob_id_9))'');
    populated_pob_id_10_pcnt := AVE(GROUP,IF(h.pob_id_10 = (TYPEOF(h.pob_id_10))'',0,100));
    maxlength_pob_id_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_10)));
    avelength_pob_id_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_id_10)),h.pob_id_10<>(typeof(h.pob_id_10))'');
    populated_pob_1_pcnt := AVE(GROUP,IF(h.pob_1 = (TYPEOF(h.pob_1))'',0,100));
    maxlength_pob_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_1)));
    avelength_pob_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_1)),h.pob_1<>(typeof(h.pob_1))'');
    populated_pob_2_pcnt := AVE(GROUP,IF(h.pob_2 = (TYPEOF(h.pob_2))'',0,100));
    maxlength_pob_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_2)));
    avelength_pob_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_2)),h.pob_2<>(typeof(h.pob_2))'');
    populated_pob_3_pcnt := AVE(GROUP,IF(h.pob_3 = (TYPEOF(h.pob_3))'',0,100));
    maxlength_pob_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_3)));
    avelength_pob_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_3)),h.pob_3<>(typeof(h.pob_3))'');
    populated_pob_4_pcnt := AVE(GROUP,IF(h.pob_4 = (TYPEOF(h.pob_4))'',0,100));
    maxlength_pob_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_4)));
    avelength_pob_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_4)),h.pob_4<>(typeof(h.pob_4))'');
    populated_pob_5_pcnt := AVE(GROUP,IF(h.pob_5 = (TYPEOF(h.pob_5))'',0,100));
    maxlength_pob_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_5)));
    avelength_pob_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_5)),h.pob_5<>(typeof(h.pob_5))'');
    populated_pob_6_pcnt := AVE(GROUP,IF(h.pob_6 = (TYPEOF(h.pob_6))'',0,100));
    maxlength_pob_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_6)));
    avelength_pob_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_6)),h.pob_6<>(typeof(h.pob_6))'');
    populated_pob_7_pcnt := AVE(GROUP,IF(h.pob_7 = (TYPEOF(h.pob_7))'',0,100));
    maxlength_pob_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_7)));
    avelength_pob_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_7)),h.pob_7<>(typeof(h.pob_7))'');
    populated_pob_8_pcnt := AVE(GROUP,IF(h.pob_8 = (TYPEOF(h.pob_8))'',0,100));
    maxlength_pob_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_8)));
    avelength_pob_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_8)),h.pob_8<>(typeof(h.pob_8))'');
    populated_pob_9_pcnt := AVE(GROUP,IF(h.pob_9 = (TYPEOF(h.pob_9))'',0,100));
    maxlength_pob_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_9)));
    avelength_pob_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_9)),h.pob_9<>(typeof(h.pob_9))'');
    populated_pob_10_pcnt := AVE(GROUP,IF(h.pob_10 = (TYPEOF(h.pob_10))'',0,100));
    maxlength_pob_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_10)));
    avelength_pob_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pob_10)),h.pob_10<>(typeof(h.pob_10))'');
    populated_country_of_birth_1_pcnt := AVE(GROUP,IF(h.country_of_birth_1 = (TYPEOF(h.country_of_birth_1))'',0,100));
    maxlength_country_of_birth_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_1)));
    avelength_country_of_birth_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_1)),h.country_of_birth_1<>(typeof(h.country_of_birth_1))'');
    populated_country_of_birth_2_pcnt := AVE(GROUP,IF(h.country_of_birth_2 = (TYPEOF(h.country_of_birth_2))'',0,100));
    maxlength_country_of_birth_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_2)));
    avelength_country_of_birth_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_2)),h.country_of_birth_2<>(typeof(h.country_of_birth_2))'');
    populated_country_of_birth_3_pcnt := AVE(GROUP,IF(h.country_of_birth_3 = (TYPEOF(h.country_of_birth_3))'',0,100));
    maxlength_country_of_birth_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_3)));
    avelength_country_of_birth_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_3)),h.country_of_birth_3<>(typeof(h.country_of_birth_3))'');
    populated_country_of_birth_4_pcnt := AVE(GROUP,IF(h.country_of_birth_4 = (TYPEOF(h.country_of_birth_4))'',0,100));
    maxlength_country_of_birth_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_4)));
    avelength_country_of_birth_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_4)),h.country_of_birth_4<>(typeof(h.country_of_birth_4))'');
    populated_country_of_birth_5_pcnt := AVE(GROUP,IF(h.country_of_birth_5 = (TYPEOF(h.country_of_birth_5))'',0,100));
    maxlength_country_of_birth_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_5)));
    avelength_country_of_birth_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_5)),h.country_of_birth_5<>(typeof(h.country_of_birth_5))'');
    populated_country_of_birth_6_pcnt := AVE(GROUP,IF(h.country_of_birth_6 = (TYPEOF(h.country_of_birth_6))'',0,100));
    maxlength_country_of_birth_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_6)));
    avelength_country_of_birth_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_6)),h.country_of_birth_6<>(typeof(h.country_of_birth_6))'');
    populated_country_of_birth_7_pcnt := AVE(GROUP,IF(h.country_of_birth_7 = (TYPEOF(h.country_of_birth_7))'',0,100));
    maxlength_country_of_birth_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_7)));
    avelength_country_of_birth_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_7)),h.country_of_birth_7<>(typeof(h.country_of_birth_7))'');
    populated_country_of_birth_8_pcnt := AVE(GROUP,IF(h.country_of_birth_8 = (TYPEOF(h.country_of_birth_8))'',0,100));
    maxlength_country_of_birth_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_8)));
    avelength_country_of_birth_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_8)),h.country_of_birth_8<>(typeof(h.country_of_birth_8))'');
    populated_country_of_birth_9_pcnt := AVE(GROUP,IF(h.country_of_birth_9 = (TYPEOF(h.country_of_birth_9))'',0,100));
    maxlength_country_of_birth_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_9)));
    avelength_country_of_birth_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_9)),h.country_of_birth_9<>(typeof(h.country_of_birth_9))'');
    populated_country_of_birth_10_pcnt := AVE(GROUP,IF(h.country_of_birth_10 = (TYPEOF(h.country_of_birth_10))'',0,100));
    maxlength_country_of_birth_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_10)));
    avelength_country_of_birth_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.country_of_birth_10)),h.country_of_birth_10<>(typeof(h.country_of_birth_10))'');
    populated_primary_pob_flag_1_pcnt := AVE(GROUP,IF(h.primary_pob_flag_1 = (TYPEOF(h.primary_pob_flag_1))'',0,100));
    maxlength_primary_pob_flag_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_1)));
    avelength_primary_pob_flag_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_1)),h.primary_pob_flag_1<>(typeof(h.primary_pob_flag_1))'');
    populated_primary_pob_flag_2_pcnt := AVE(GROUP,IF(h.primary_pob_flag_2 = (TYPEOF(h.primary_pob_flag_2))'',0,100));
    maxlength_primary_pob_flag_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_2)));
    avelength_primary_pob_flag_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_2)),h.primary_pob_flag_2<>(typeof(h.primary_pob_flag_2))'');
    populated_primary_pob_flag_3_pcnt := AVE(GROUP,IF(h.primary_pob_flag_3 = (TYPEOF(h.primary_pob_flag_3))'',0,100));
    maxlength_primary_pob_flag_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_3)));
    avelength_primary_pob_flag_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_3)),h.primary_pob_flag_3<>(typeof(h.primary_pob_flag_3))'');
    populated_primary_pob_flag_4_pcnt := AVE(GROUP,IF(h.primary_pob_flag_4 = (TYPEOF(h.primary_pob_flag_4))'',0,100));
    maxlength_primary_pob_flag_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_4)));
    avelength_primary_pob_flag_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_4)),h.primary_pob_flag_4<>(typeof(h.primary_pob_flag_4))'');
    populated_primary_pob_flag_5_pcnt := AVE(GROUP,IF(h.primary_pob_flag_5 = (TYPEOF(h.primary_pob_flag_5))'',0,100));
    maxlength_primary_pob_flag_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_5)));
    avelength_primary_pob_flag_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_5)),h.primary_pob_flag_5<>(typeof(h.primary_pob_flag_5))'');
    populated_primary_pob_flag_6_pcnt := AVE(GROUP,IF(h.primary_pob_flag_6 = (TYPEOF(h.primary_pob_flag_6))'',0,100));
    maxlength_primary_pob_flag_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_6)));
    avelength_primary_pob_flag_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_6)),h.primary_pob_flag_6<>(typeof(h.primary_pob_flag_6))'');
    populated_primary_pob_flag_7_pcnt := AVE(GROUP,IF(h.primary_pob_flag_7 = (TYPEOF(h.primary_pob_flag_7))'',0,100));
    maxlength_primary_pob_flag_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_7)));
    avelength_primary_pob_flag_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_7)),h.primary_pob_flag_7<>(typeof(h.primary_pob_flag_7))'');
    populated_primary_pob_flag_8_pcnt := AVE(GROUP,IF(h.primary_pob_flag_8 = (TYPEOF(h.primary_pob_flag_8))'',0,100));
    maxlength_primary_pob_flag_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_8)));
    avelength_primary_pob_flag_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_8)),h.primary_pob_flag_8<>(typeof(h.primary_pob_flag_8))'');
    populated_primary_pob_flag_9_pcnt := AVE(GROUP,IF(h.primary_pob_flag_9 = (TYPEOF(h.primary_pob_flag_9))'',0,100));
    maxlength_primary_pob_flag_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_9)));
    avelength_primary_pob_flag_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_9)),h.primary_pob_flag_9<>(typeof(h.primary_pob_flag_9))'');
    populated_primary_pob_flag_10_pcnt := AVE(GROUP,IF(h.primary_pob_flag_10 = (TYPEOF(h.primary_pob_flag_10))'',0,100));
    maxlength_primary_pob_flag_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_10)));
    avelength_primary_pob_flag_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.primary_pob_flag_10)),h.primary_pob_flag_10<>(typeof(h.primary_pob_flag_10))'');
    populated_language_1_pcnt := AVE(GROUP,IF(h.language_1 = (TYPEOF(h.language_1))'',0,100));
    maxlength_language_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_1)));
    avelength_language_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_1)),h.language_1<>(typeof(h.language_1))'');
    populated_language_2_pcnt := AVE(GROUP,IF(h.language_2 = (TYPEOF(h.language_2))'',0,100));
    maxlength_language_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_2)));
    avelength_language_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_2)),h.language_2<>(typeof(h.language_2))'');
    populated_language_3_pcnt := AVE(GROUP,IF(h.language_3 = (TYPEOF(h.language_3))'',0,100));
    maxlength_language_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_3)));
    avelength_language_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_3)),h.language_3<>(typeof(h.language_3))'');
    populated_language_4_pcnt := AVE(GROUP,IF(h.language_4 = (TYPEOF(h.language_4))'',0,100));
    maxlength_language_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_4)));
    avelength_language_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_4)),h.language_4<>(typeof(h.language_4))'');
    populated_language_5_pcnt := AVE(GROUP,IF(h.language_5 = (TYPEOF(h.language_5))'',0,100));
    maxlength_language_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_5)));
    avelength_language_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_5)),h.language_5<>(typeof(h.language_5))'');
    populated_language_6_pcnt := AVE(GROUP,IF(h.language_6 = (TYPEOF(h.language_6))'',0,100));
    maxlength_language_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_6)));
    avelength_language_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_6)),h.language_6<>(typeof(h.language_6))'');
    populated_language_7_pcnt := AVE(GROUP,IF(h.language_7 = (TYPEOF(h.language_7))'',0,100));
    maxlength_language_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_7)));
    avelength_language_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_7)),h.language_7<>(typeof(h.language_7))'');
    populated_language_8_pcnt := AVE(GROUP,IF(h.language_8 = (TYPEOF(h.language_8))'',0,100));
    maxlength_language_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_8)));
    avelength_language_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_8)),h.language_8<>(typeof(h.language_8))'');
    populated_language_9_pcnt := AVE(GROUP,IF(h.language_9 = (TYPEOF(h.language_9))'',0,100));
    maxlength_language_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_9)));
    avelength_language_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_9)),h.language_9<>(typeof(h.language_9))'');
    populated_language_10_pcnt := AVE(GROUP,IF(h.language_10 = (TYPEOF(h.language_10))'',0,100));
    maxlength_language_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_10)));
    avelength_language_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.language_10)),h.language_10<>(typeof(h.language_10))'');
    populated_membership_1_pcnt := AVE(GROUP,IF(h.membership_1 = (TYPEOF(h.membership_1))'',0,100));
    maxlength_membership_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_1)));
    avelength_membership_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_1)),h.membership_1<>(typeof(h.membership_1))'');
    populated_membership_2_pcnt := AVE(GROUP,IF(h.membership_2 = (TYPEOF(h.membership_2))'',0,100));
    maxlength_membership_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_2)));
    avelength_membership_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_2)),h.membership_2<>(typeof(h.membership_2))'');
    populated_membership_3_pcnt := AVE(GROUP,IF(h.membership_3 = (TYPEOF(h.membership_3))'',0,100));
    maxlength_membership_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_3)));
    avelength_membership_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_3)),h.membership_3<>(typeof(h.membership_3))'');
    populated_membership_4_pcnt := AVE(GROUP,IF(h.membership_4 = (TYPEOF(h.membership_4))'',0,100));
    maxlength_membership_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_4)));
    avelength_membership_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_4)),h.membership_4<>(typeof(h.membership_4))'');
    populated_membership_5_pcnt := AVE(GROUP,IF(h.membership_5 = (TYPEOF(h.membership_5))'',0,100));
    maxlength_membership_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_5)));
    avelength_membership_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_5)),h.membership_5<>(typeof(h.membership_5))'');
    populated_membership_6_pcnt := AVE(GROUP,IF(h.membership_6 = (TYPEOF(h.membership_6))'',0,100));
    maxlength_membership_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_6)));
    avelength_membership_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_6)),h.membership_6<>(typeof(h.membership_6))'');
    populated_membership_7_pcnt := AVE(GROUP,IF(h.membership_7 = (TYPEOF(h.membership_7))'',0,100));
    maxlength_membership_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_7)));
    avelength_membership_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_7)),h.membership_7<>(typeof(h.membership_7))'');
    populated_membership_8_pcnt := AVE(GROUP,IF(h.membership_8 = (TYPEOF(h.membership_8))'',0,100));
    maxlength_membership_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_8)));
    avelength_membership_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_8)),h.membership_8<>(typeof(h.membership_8))'');
    populated_membership_9_pcnt := AVE(GROUP,IF(h.membership_9 = (TYPEOF(h.membership_9))'',0,100));
    maxlength_membership_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_9)));
    avelength_membership_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_9)),h.membership_9<>(typeof(h.membership_9))'');
    populated_membership_10_pcnt := AVE(GROUP,IF(h.membership_10 = (TYPEOF(h.membership_10))'',0,100));
    maxlength_membership_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_10)));
    avelength_membership_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.membership_10)),h.membership_10<>(typeof(h.membership_10))'');
    populated_position_1_pcnt := AVE(GROUP,IF(h.position_1 = (TYPEOF(h.position_1))'',0,100));
    maxlength_position_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_1)));
    avelength_position_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_1)),h.position_1<>(typeof(h.position_1))'');
    populated_position_2_pcnt := AVE(GROUP,IF(h.position_2 = (TYPEOF(h.position_2))'',0,100));
    maxlength_position_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_2)));
    avelength_position_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_2)),h.position_2<>(typeof(h.position_2))'');
    populated_position_3_pcnt := AVE(GROUP,IF(h.position_3 = (TYPEOF(h.position_3))'',0,100));
    maxlength_position_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_3)));
    avelength_position_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_3)),h.position_3<>(typeof(h.position_3))'');
    populated_position_4_pcnt := AVE(GROUP,IF(h.position_4 = (TYPEOF(h.position_4))'',0,100));
    maxlength_position_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_4)));
    avelength_position_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_4)),h.position_4<>(typeof(h.position_4))'');
    populated_position_5_pcnt := AVE(GROUP,IF(h.position_5 = (TYPEOF(h.position_5))'',0,100));
    maxlength_position_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_5)));
    avelength_position_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_5)),h.position_5<>(typeof(h.position_5))'');
    populated_position_6_pcnt := AVE(GROUP,IF(h.position_6 = (TYPEOF(h.position_6))'',0,100));
    maxlength_position_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_6)));
    avelength_position_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_6)),h.position_6<>(typeof(h.position_6))'');
    populated_position_7_pcnt := AVE(GROUP,IF(h.position_7 = (TYPEOF(h.position_7))'',0,100));
    maxlength_position_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_7)));
    avelength_position_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_7)),h.position_7<>(typeof(h.position_7))'');
    populated_position_8_pcnt := AVE(GROUP,IF(h.position_8 = (TYPEOF(h.position_8))'',0,100));
    maxlength_position_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_8)));
    avelength_position_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_8)),h.position_8<>(typeof(h.position_8))'');
    populated_position_9_pcnt := AVE(GROUP,IF(h.position_9 = (TYPEOF(h.position_9))'',0,100));
    maxlength_position_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_9)));
    avelength_position_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_9)),h.position_9<>(typeof(h.position_9))'');
    populated_position_10_pcnt := AVE(GROUP,IF(h.position_10 = (TYPEOF(h.position_10))'',0,100));
    maxlength_position_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_10)));
    avelength_position_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.position_10)),h.position_10<>(typeof(h.position_10))'');
    populated_occupation_1_pcnt := AVE(GROUP,IF(h.occupation_1 = (TYPEOF(h.occupation_1))'',0,100));
    maxlength_occupation_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_1)));
    avelength_occupation_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_1)),h.occupation_1<>(typeof(h.occupation_1))'');
    populated_occupation_2_pcnt := AVE(GROUP,IF(h.occupation_2 = (TYPEOF(h.occupation_2))'',0,100));
    maxlength_occupation_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_2)));
    avelength_occupation_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_2)),h.occupation_2<>(typeof(h.occupation_2))'');
    populated_occupation_3_pcnt := AVE(GROUP,IF(h.occupation_3 = (TYPEOF(h.occupation_3))'',0,100));
    maxlength_occupation_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_3)));
    avelength_occupation_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_3)),h.occupation_3<>(typeof(h.occupation_3))'');
    populated_occupation_4_pcnt := AVE(GROUP,IF(h.occupation_4 = (TYPEOF(h.occupation_4))'',0,100));
    maxlength_occupation_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_4)));
    avelength_occupation_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_4)),h.occupation_4<>(typeof(h.occupation_4))'');
    populated_occupation_5_pcnt := AVE(GROUP,IF(h.occupation_5 = (TYPEOF(h.occupation_5))'',0,100));
    maxlength_occupation_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_5)));
    avelength_occupation_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_5)),h.occupation_5<>(typeof(h.occupation_5))'');
    populated_occupation_6_pcnt := AVE(GROUP,IF(h.occupation_6 = (TYPEOF(h.occupation_6))'',0,100));
    maxlength_occupation_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_6)));
    avelength_occupation_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_6)),h.occupation_6<>(typeof(h.occupation_6))'');
    populated_occupation_7_pcnt := AVE(GROUP,IF(h.occupation_7 = (TYPEOF(h.occupation_7))'',0,100));
    maxlength_occupation_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_7)));
    avelength_occupation_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_7)),h.occupation_7<>(typeof(h.occupation_7))'');
    populated_occupation_8_pcnt := AVE(GROUP,IF(h.occupation_8 = (TYPEOF(h.occupation_8))'',0,100));
    maxlength_occupation_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_8)));
    avelength_occupation_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_8)),h.occupation_8<>(typeof(h.occupation_8))'');
    populated_occupation_9_pcnt := AVE(GROUP,IF(h.occupation_9 = (TYPEOF(h.occupation_9))'',0,100));
    maxlength_occupation_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_9)));
    avelength_occupation_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_9)),h.occupation_9<>(typeof(h.occupation_9))'');
    populated_occupation_10_pcnt := AVE(GROUP,IF(h.occupation_10 = (TYPEOF(h.occupation_10))'',0,100));
    maxlength_occupation_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_10)));
    avelength_occupation_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.occupation_10)),h.occupation_10<>(typeof(h.occupation_10))'');
    populated_date_added_to_list_pcnt := AVE(GROUP,IF(h.date_added_to_list = (TYPEOF(h.date_added_to_list))'',0,100));
    maxlength_date_added_to_list := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_added_to_list)));
    avelength_date_added_to_list := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_added_to_list)),h.date_added_to_list<>(typeof(h.date_added_to_list))'');
    populated_date_last_updated_pcnt := AVE(GROUP,IF(h.date_last_updated = (TYPEOF(h.date_last_updated))'',0,100));
    maxlength_date_last_updated := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_last_updated)));
    avelength_date_last_updated := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_last_updated)),h.date_last_updated<>(typeof(h.date_last_updated))'');
    populated_effective_date_pcnt := AVE(GROUP,IF(h.effective_date = (TYPEOF(h.effective_date))'',0,100));
    maxlength_effective_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.effective_date)));
    avelength_effective_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.effective_date)),h.effective_date<>(typeof(h.effective_date))'');
    populated_expiration_date_pcnt := AVE(GROUP,IF(h.expiration_date = (TYPEOF(h.expiration_date))'',0,100));
    maxlength_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.expiration_date)));
    avelength_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.expiration_date)),h.expiration_date<>(typeof(h.expiration_date))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_grounds_pcnt := AVE(GROUP,IF(h.grounds = (TYPEOF(h.grounds))'',0,100));
    maxlength_grounds := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.grounds)));
    avelength_grounds := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.grounds)),h.grounds<>(typeof(h.grounds))'');
    populated_subj_to_common_pos_2001_931_cfsp_fl_pcnt := AVE(GROUP,IF(h.subj_to_common_pos_2001_931_cfsp_fl = (TYPEOF(h.subj_to_common_pos_2001_931_cfsp_fl))'',0,100));
    maxlength_subj_to_common_pos_2001_931_cfsp_fl := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.subj_to_common_pos_2001_931_cfsp_fl)));
    avelength_subj_to_common_pos_2001_931_cfsp_fl := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.subj_to_common_pos_2001_931_cfsp_fl)),h.subj_to_common_pos_2001_931_cfsp_fl<>(typeof(h.subj_to_common_pos_2001_931_cfsp_fl))'');
    populated_federal_register_citation_1_pcnt := AVE(GROUP,IF(h.federal_register_citation_1 = (TYPEOF(h.federal_register_citation_1))'',0,100));
    maxlength_federal_register_citation_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_1)));
    avelength_federal_register_citation_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_1)),h.federal_register_citation_1<>(typeof(h.federal_register_citation_1))'');
    populated_federal_register_citation_2_pcnt := AVE(GROUP,IF(h.federal_register_citation_2 = (TYPEOF(h.federal_register_citation_2))'',0,100));
    maxlength_federal_register_citation_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_2)));
    avelength_federal_register_citation_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_2)),h.federal_register_citation_2<>(typeof(h.federal_register_citation_2))'');
    populated_federal_register_citation_3_pcnt := AVE(GROUP,IF(h.federal_register_citation_3 = (TYPEOF(h.federal_register_citation_3))'',0,100));
    maxlength_federal_register_citation_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_3)));
    avelength_federal_register_citation_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_3)),h.federal_register_citation_3<>(typeof(h.federal_register_citation_3))'');
    populated_federal_register_citation_4_pcnt := AVE(GROUP,IF(h.federal_register_citation_4 = (TYPEOF(h.federal_register_citation_4))'',0,100));
    maxlength_federal_register_citation_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_4)));
    avelength_federal_register_citation_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_4)),h.federal_register_citation_4<>(typeof(h.federal_register_citation_4))'');
    populated_federal_register_citation_5_pcnt := AVE(GROUP,IF(h.federal_register_citation_5 = (TYPEOF(h.federal_register_citation_5))'',0,100));
    maxlength_federal_register_citation_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_5)));
    avelength_federal_register_citation_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_5)),h.federal_register_citation_5<>(typeof(h.federal_register_citation_5))'');
    populated_federal_register_citation_6_pcnt := AVE(GROUP,IF(h.federal_register_citation_6 = (TYPEOF(h.federal_register_citation_6))'',0,100));
    maxlength_federal_register_citation_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_6)));
    avelength_federal_register_citation_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_6)),h.federal_register_citation_6<>(typeof(h.federal_register_citation_6))'');
    populated_federal_register_citation_7_pcnt := AVE(GROUP,IF(h.federal_register_citation_7 = (TYPEOF(h.federal_register_citation_7))'',0,100));
    maxlength_federal_register_citation_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_7)));
    avelength_federal_register_citation_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_7)),h.federal_register_citation_7<>(typeof(h.federal_register_citation_7))'');
    populated_federal_register_citation_8_pcnt := AVE(GROUP,IF(h.federal_register_citation_8 = (TYPEOF(h.federal_register_citation_8))'',0,100));
    maxlength_federal_register_citation_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_8)));
    avelength_federal_register_citation_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_8)),h.federal_register_citation_8<>(typeof(h.federal_register_citation_8))'');
    populated_federal_register_citation_9_pcnt := AVE(GROUP,IF(h.federal_register_citation_9 = (TYPEOF(h.federal_register_citation_9))'',0,100));
    maxlength_federal_register_citation_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_9)));
    avelength_federal_register_citation_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_9)),h.federal_register_citation_9<>(typeof(h.federal_register_citation_9))'');
    populated_federal_register_citation_10_pcnt := AVE(GROUP,IF(h.federal_register_citation_10 = (TYPEOF(h.federal_register_citation_10))'',0,100));
    maxlength_federal_register_citation_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_10)));
    avelength_federal_register_citation_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_10)),h.federal_register_citation_10<>(typeof(h.federal_register_citation_10))'');
    populated_federal_register_citation_date_1_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_1 = (TYPEOF(h.federal_register_citation_date_1))'',0,100));
    maxlength_federal_register_citation_date_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_1)));
    avelength_federal_register_citation_date_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_1)),h.federal_register_citation_date_1<>(typeof(h.federal_register_citation_date_1))'');
    populated_federal_register_citation_date_2_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_2 = (TYPEOF(h.federal_register_citation_date_2))'',0,100));
    maxlength_federal_register_citation_date_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_2)));
    avelength_federal_register_citation_date_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_2)),h.federal_register_citation_date_2<>(typeof(h.federal_register_citation_date_2))'');
    populated_federal_register_citation_date_3_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_3 = (TYPEOF(h.federal_register_citation_date_3))'',0,100));
    maxlength_federal_register_citation_date_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_3)));
    avelength_federal_register_citation_date_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_3)),h.federal_register_citation_date_3<>(typeof(h.federal_register_citation_date_3))'');
    populated_federal_register_citation_date_4_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_4 = (TYPEOF(h.federal_register_citation_date_4))'',0,100));
    maxlength_federal_register_citation_date_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_4)));
    avelength_federal_register_citation_date_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_4)),h.federal_register_citation_date_4<>(typeof(h.federal_register_citation_date_4))'');
    populated_federal_register_citation_date_5_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_5 = (TYPEOF(h.federal_register_citation_date_5))'',0,100));
    maxlength_federal_register_citation_date_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_5)));
    avelength_federal_register_citation_date_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_5)),h.federal_register_citation_date_5<>(typeof(h.federal_register_citation_date_5))'');
    populated_federal_register_citation_date_6_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_6 = (TYPEOF(h.federal_register_citation_date_6))'',0,100));
    maxlength_federal_register_citation_date_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_6)));
    avelength_federal_register_citation_date_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_6)),h.federal_register_citation_date_6<>(typeof(h.federal_register_citation_date_6))'');
    populated_federal_register_citation_date_7_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_7 = (TYPEOF(h.federal_register_citation_date_7))'',0,100));
    maxlength_federal_register_citation_date_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_7)));
    avelength_federal_register_citation_date_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_7)),h.federal_register_citation_date_7<>(typeof(h.federal_register_citation_date_7))'');
    populated_federal_register_citation_date_8_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_8 = (TYPEOF(h.federal_register_citation_date_8))'',0,100));
    maxlength_federal_register_citation_date_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_8)));
    avelength_federal_register_citation_date_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_8)),h.federal_register_citation_date_8<>(typeof(h.federal_register_citation_date_8))'');
    populated_federal_register_citation_date_9_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_9 = (TYPEOF(h.federal_register_citation_date_9))'',0,100));
    maxlength_federal_register_citation_date_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_9)));
    avelength_federal_register_citation_date_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_9)),h.federal_register_citation_date_9<>(typeof(h.federal_register_citation_date_9))'');
    populated_federal_register_citation_date_10_pcnt := AVE(GROUP,IF(h.federal_register_citation_date_10 = (TYPEOF(h.federal_register_citation_date_10))'',0,100));
    maxlength_federal_register_citation_date_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_10)));
    avelength_federal_register_citation_date_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.federal_register_citation_date_10)),h.federal_register_citation_date_10<>(typeof(h.federal_register_citation_date_10))'');
    populated_license_requirement_pcnt := AVE(GROUP,IF(h.license_requirement = (TYPEOF(h.license_requirement))'',0,100));
    maxlength_license_requirement := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.license_requirement)));
    avelength_license_requirement := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.license_requirement)),h.license_requirement<>(typeof(h.license_requirement))'');
    populated_license_review_policy_pcnt := AVE(GROUP,IF(h.license_review_policy = (TYPEOF(h.license_review_policy))'',0,100));
    maxlength_license_review_policy := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.license_review_policy)));
    avelength_license_review_policy := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.license_review_policy)),h.license_review_policy<>(typeof(h.license_review_policy))'');
    populated_subordinate_status_pcnt := AVE(GROUP,IF(h.subordinate_status = (TYPEOF(h.subordinate_status))'',0,100));
    maxlength_subordinate_status := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.subordinate_status)));
    avelength_subordinate_status := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.subordinate_status)),h.subordinate_status<>(typeof(h.subordinate_status))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_weight_pcnt := AVE(GROUP,IF(h.weight = (TYPEOF(h.weight))'',0,100));
    maxlength_weight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.weight)));
    avelength_weight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.weight)),h.weight<>(typeof(h.weight))'');
    populated_physique_pcnt := AVE(GROUP,IF(h.physique = (TYPEOF(h.physique))'',0,100));
    maxlength_physique := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physique)));
    avelength_physique := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physique)),h.physique<>(typeof(h.physique))'');
    populated_hair_color_pcnt := AVE(GROUP,IF(h.hair_color = (TYPEOF(h.hair_color))'',0,100));
    maxlength_hair_color := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hair_color)));
    avelength_hair_color := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hair_color)),h.hair_color<>(typeof(h.hair_color))'');
    populated_eyes_pcnt := AVE(GROUP,IF(h.eyes = (TYPEOF(h.eyes))'',0,100));
    maxlength_eyes := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.eyes)));
    avelength_eyes := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.eyes)),h.eyes<>(typeof(h.eyes))'');
    populated_complexion_pcnt := AVE(GROUP,IF(h.complexion = (TYPEOF(h.complexion))'',0,100));
    maxlength_complexion := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.complexion)));
    avelength_complexion := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.complexion)),h.complexion<>(typeof(h.complexion))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_scars_marks_pcnt := AVE(GROUP,IF(h.scars_marks = (TYPEOF(h.scars_marks))'',0,100));
    maxlength_scars_marks := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.scars_marks)));
    avelength_scars_marks := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.scars_marks)),h.scars_marks<>(typeof(h.scars_marks))'');
    populated_photo_file_pcnt := AVE(GROUP,IF(h.photo_file = (TYPEOF(h.photo_file))'',0,100));
    maxlength_photo_file := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.photo_file)));
    avelength_photo_file := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.photo_file)),h.photo_file<>(typeof(h.photo_file))'');
    populated_offenses_pcnt := AVE(GROUP,IF(h.offenses = (TYPEOF(h.offenses))'',0,100));
    maxlength_offenses := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.offenses)));
    avelength_offenses := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.offenses)),h.offenses<>(typeof(h.offenses))'');
    populated_ncic_pcnt := AVE(GROUP,IF(h.ncic = (TYPEOF(h.ncic))'',0,100));
    maxlength_ncic := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ncic)));
    avelength_ncic := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ncic)),h.ncic<>(typeof(h.ncic))'');
    populated_warrant_by_pcnt := AVE(GROUP,IF(h.warrant_by = (TYPEOF(h.warrant_by))'',0,100));
    maxlength_warrant_by := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.warrant_by)));
    avelength_warrant_by := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.warrant_by)),h.warrant_by<>(typeof(h.warrant_by))'');
    populated_caution_pcnt := AVE(GROUP,IF(h.caution = (TYPEOF(h.caution))'',0,100));
    maxlength_caution := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.caution)));
    avelength_caution := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.caution)),h.caution<>(typeof(h.caution))'');
    populated_reward_pcnt := AVE(GROUP,IF(h.reward = (TYPEOF(h.reward))'',0,100));
    maxlength_reward := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.reward)));
    avelength_reward := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.reward)),h.reward<>(typeof(h.reward))'');
    populated_type_of_denial_pcnt := AVE(GROUP,IF(h.type_of_denial = (TYPEOF(h.type_of_denial))'',0,100));
    maxlength_type_of_denial := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.type_of_denial)));
    avelength_type_of_denial := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.type_of_denial)),h.type_of_denial<>(typeof(h.type_of_denial))'');
    populated_linked_with_1_pcnt := AVE(GROUP,IF(h.linked_with_1 = (TYPEOF(h.linked_with_1))'',0,100));
    maxlength_linked_with_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_1)));
    avelength_linked_with_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_1)),h.linked_with_1<>(typeof(h.linked_with_1))'');
    populated_linked_with_2_pcnt := AVE(GROUP,IF(h.linked_with_2 = (TYPEOF(h.linked_with_2))'',0,100));
    maxlength_linked_with_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_2)));
    avelength_linked_with_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_2)),h.linked_with_2<>(typeof(h.linked_with_2))'');
    populated_linked_with_3_pcnt := AVE(GROUP,IF(h.linked_with_3 = (TYPEOF(h.linked_with_3))'',0,100));
    maxlength_linked_with_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_3)));
    avelength_linked_with_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_3)),h.linked_with_3<>(typeof(h.linked_with_3))'');
    populated_linked_with_4_pcnt := AVE(GROUP,IF(h.linked_with_4 = (TYPEOF(h.linked_with_4))'',0,100));
    maxlength_linked_with_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_4)));
    avelength_linked_with_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_4)),h.linked_with_4<>(typeof(h.linked_with_4))'');
    populated_linked_with_5_pcnt := AVE(GROUP,IF(h.linked_with_5 = (TYPEOF(h.linked_with_5))'',0,100));
    maxlength_linked_with_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_5)));
    avelength_linked_with_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_5)),h.linked_with_5<>(typeof(h.linked_with_5))'');
    populated_linked_with_6_pcnt := AVE(GROUP,IF(h.linked_with_6 = (TYPEOF(h.linked_with_6))'',0,100));
    maxlength_linked_with_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_6)));
    avelength_linked_with_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_6)),h.linked_with_6<>(typeof(h.linked_with_6))'');
    populated_linked_with_7_pcnt := AVE(GROUP,IF(h.linked_with_7 = (TYPEOF(h.linked_with_7))'',0,100));
    maxlength_linked_with_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_7)));
    avelength_linked_with_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_7)),h.linked_with_7<>(typeof(h.linked_with_7))'');
    populated_linked_with_8_pcnt := AVE(GROUP,IF(h.linked_with_8 = (TYPEOF(h.linked_with_8))'',0,100));
    maxlength_linked_with_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_8)));
    avelength_linked_with_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_8)),h.linked_with_8<>(typeof(h.linked_with_8))'');
    populated_linked_with_9_pcnt := AVE(GROUP,IF(h.linked_with_9 = (TYPEOF(h.linked_with_9))'',0,100));
    maxlength_linked_with_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_9)));
    avelength_linked_with_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_9)),h.linked_with_9<>(typeof(h.linked_with_9))'');
    populated_linked_with_10_pcnt := AVE(GROUP,IF(h.linked_with_10 = (TYPEOF(h.linked_with_10))'',0,100));
    maxlength_linked_with_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_10)));
    avelength_linked_with_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_10)),h.linked_with_10<>(typeof(h.linked_with_10))'');
    populated_linked_with_id_1_pcnt := AVE(GROUP,IF(h.linked_with_id_1 = (TYPEOF(h.linked_with_id_1))'',0,100));
    maxlength_linked_with_id_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_1)));
    avelength_linked_with_id_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_1)),h.linked_with_id_1<>(typeof(h.linked_with_id_1))'');
    populated_linked_with_id_2_pcnt := AVE(GROUP,IF(h.linked_with_id_2 = (TYPEOF(h.linked_with_id_2))'',0,100));
    maxlength_linked_with_id_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_2)));
    avelength_linked_with_id_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_2)),h.linked_with_id_2<>(typeof(h.linked_with_id_2))'');
    populated_linked_with_id_3_pcnt := AVE(GROUP,IF(h.linked_with_id_3 = (TYPEOF(h.linked_with_id_3))'',0,100));
    maxlength_linked_with_id_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_3)));
    avelength_linked_with_id_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_3)),h.linked_with_id_3<>(typeof(h.linked_with_id_3))'');
    populated_linked_with_id_4_pcnt := AVE(GROUP,IF(h.linked_with_id_4 = (TYPEOF(h.linked_with_id_4))'',0,100));
    maxlength_linked_with_id_4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_4)));
    avelength_linked_with_id_4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_4)),h.linked_with_id_4<>(typeof(h.linked_with_id_4))'');
    populated_linked_with_id_5_pcnt := AVE(GROUP,IF(h.linked_with_id_5 = (TYPEOF(h.linked_with_id_5))'',0,100));
    maxlength_linked_with_id_5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_5)));
    avelength_linked_with_id_5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_5)),h.linked_with_id_5<>(typeof(h.linked_with_id_5))'');
    populated_linked_with_id_6_pcnt := AVE(GROUP,IF(h.linked_with_id_6 = (TYPEOF(h.linked_with_id_6))'',0,100));
    maxlength_linked_with_id_6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_6)));
    avelength_linked_with_id_6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_6)),h.linked_with_id_6<>(typeof(h.linked_with_id_6))'');
    populated_linked_with_id_7_pcnt := AVE(GROUP,IF(h.linked_with_id_7 = (TYPEOF(h.linked_with_id_7))'',0,100));
    maxlength_linked_with_id_7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_7)));
    avelength_linked_with_id_7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_7)),h.linked_with_id_7<>(typeof(h.linked_with_id_7))'');
    populated_linked_with_id_8_pcnt := AVE(GROUP,IF(h.linked_with_id_8 = (TYPEOF(h.linked_with_id_8))'',0,100));
    maxlength_linked_with_id_8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_8)));
    avelength_linked_with_id_8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_8)),h.linked_with_id_8<>(typeof(h.linked_with_id_8))'');
    populated_linked_with_id_9_pcnt := AVE(GROUP,IF(h.linked_with_id_9 = (TYPEOF(h.linked_with_id_9))'',0,100));
    maxlength_linked_with_id_9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_9)));
    avelength_linked_with_id_9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_9)),h.linked_with_id_9<>(typeof(h.linked_with_id_9))'');
    populated_linked_with_id_10_pcnt := AVE(GROUP,IF(h.linked_with_id_10 = (TYPEOF(h.linked_with_id_10))'',0,100));
    maxlength_linked_with_id_10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_10)));
    avelength_linked_with_id_10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.linked_with_id_10)),h.linked_with_id_10<>(typeof(h.linked_with_id_10))'');
    populated_listing_information_pcnt := AVE(GROUP,IF(h.listing_information = (TYPEOF(h.listing_information))'',0,100));
    maxlength_listing_information := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.listing_information)));
    avelength_listing_information := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.listing_information)),h.listing_information<>(typeof(h.listing_information))'');
    populated_foreign_principal_pcnt := AVE(GROUP,IF(h.foreign_principal = (TYPEOF(h.foreign_principal))'',0,100));
    maxlength_foreign_principal := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.foreign_principal)));
    avelength_foreign_principal := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.foreign_principal)),h.foreign_principal<>(typeof(h.foreign_principal))'');
    populated_nature_of_service_pcnt := AVE(GROUP,IF(h.nature_of_service = (TYPEOF(h.nature_of_service))'',0,100));
    maxlength_nature_of_service := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nature_of_service)));
    avelength_nature_of_service := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nature_of_service)),h.nature_of_service<>(typeof(h.nature_of_service))'');
    populated_activities_pcnt := AVE(GROUP,IF(h.activities = (TYPEOF(h.activities))'',0,100));
    maxlength_activities := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.activities)));
    avelength_activities := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.activities)),h.activities<>(typeof(h.activities))'');
    populated_finances_pcnt := AVE(GROUP,IF(h.finances = (TYPEOF(h.finances))'',0,100));
    maxlength_finances := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.finances)));
    avelength_finances := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.finances)),h.finances<>(typeof(h.finances))'');
    populated_registrant_terminated_flag_pcnt := AVE(GROUP,IF(h.registrant_terminated_flag = (TYPEOF(h.registrant_terminated_flag))'',0,100));
    maxlength_registrant_terminated_flag := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.registrant_terminated_flag)));
    avelength_registrant_terminated_flag := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.registrant_terminated_flag)),h.registrant_terminated_flag<>(typeof(h.registrant_terminated_flag))'');
    populated_foreign_principal_terminated_flag_pcnt := AVE(GROUP,IF(h.foreign_principal_terminated_flag = (TYPEOF(h.foreign_principal_terminated_flag))'',0,100));
    maxlength_foreign_principal_terminated_flag := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.foreign_principal_terminated_flag)));
    avelength_foreign_principal_terminated_flag := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.foreign_principal_terminated_flag)),h.foreign_principal_terminated_flag<>(typeof(h.foreign_principal_terminated_flag))'');
    populated_short_form_terminated_flag_pcnt := AVE(GROUP,IF(h.short_form_terminated_flag = (TYPEOF(h.short_form_terminated_flag))'',0,100));
    maxlength_short_form_terminated_flag := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.short_form_terminated_flag)));
    avelength_short_form_terminated_flag := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.short_form_terminated_flag)),h.short_form_terminated_flag<>(typeof(h.short_form_terminated_flag))'');
    populated_src_key_pcnt := AVE(GROUP,IF(h.src_key = (TYPEOF(h.src_key))'',0,100));
    maxlength_src_key := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.src_key)));
    avelength_src_key := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.src_key)),h.src_key<>(typeof(h.src_key))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,src_key,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_pty_key_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_orig_pty_name_pcnt *   0.00 / 100 + T.Populated_orig_vessel_name_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_addr_1_pcnt *   0.00 / 100 + T.Populated_addr_2_pcnt *   0.00 / 100 + T.Populated_addr_3_pcnt *   0.00 / 100 + T.Populated_addr_4_pcnt *   0.00 / 100 + T.Populated_addr_5_pcnt *   0.00 / 100 + T.Populated_addr_6_pcnt *   0.00 / 100 + T.Populated_addr_7_pcnt *   0.00 / 100 + T.Populated_addr_8_pcnt *   0.00 / 100 + T.Populated_addr_9_pcnt *   0.00 / 100 + T.Populated_addr_10_pcnt *   0.00 / 100 + T.Populated_remarks_1_pcnt *   0.00 / 100 + T.Populated_remarks_2_pcnt *   0.00 / 100 + T.Populated_remarks_3_pcnt *   0.00 / 100 + T.Populated_remarks_4_pcnt *   0.00 / 100 + T.Populated_remarks_5_pcnt *   0.00 / 100 + T.Populated_remarks_6_pcnt *   0.00 / 100 + T.Populated_remarks_7_pcnt *   0.00 / 100 + T.Populated_remarks_8_pcnt *   0.00 / 100 + T.Populated_remarks_9_pcnt *   0.00 / 100 + T.Populated_remarks_10_pcnt *   0.00 / 100 + T.Populated_remarks_11_pcnt *   0.00 / 100 + T.Populated_remarks_12_pcnt *   0.00 / 100 + T.Populated_remarks_13_pcnt *   0.00 / 100 + T.Populated_remarks_14_pcnt *   0.00 / 100 + T.Populated_remarks_15_pcnt *   0.00 / 100 + T.Populated_remarks_16_pcnt *   0.00 / 100 + T.Populated_remarks_17_pcnt *   0.00 / 100 + T.Populated_remarks_18_pcnt *   0.00 / 100 + T.Populated_remarks_19_pcnt *   0.00 / 100 + T.Populated_remarks_20_pcnt *   0.00 / 100 + T.Populated_remarks_21_pcnt *   0.00 / 100 + T.Populated_remarks_22_pcnt *   0.00 / 100 + T.Populated_remarks_23_pcnt *   0.00 / 100 + T.Populated_remarks_24_pcnt *   0.00 / 100 + T.Populated_remarks_25_pcnt *   0.00 / 100 + T.Populated_remarks_26_pcnt *   0.00 / 100 + T.Populated_remarks_27_pcnt *   0.00 / 100 + T.Populated_remarks_28_pcnt *   0.00 / 100 + T.Populated_remarks_29_pcnt *   0.00 / 100 + T.Populated_remarks_30_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_a_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_entity_id_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_title_1_pcnt *   0.00 / 100 + T.Populated_title_2_pcnt *   0.00 / 100 + T.Populated_title_3_pcnt *   0.00 / 100 + T.Populated_title_4_pcnt *   0.00 / 100 + T.Populated_title_5_pcnt *   0.00 / 100 + T.Populated_title_6_pcnt *   0.00 / 100 + T.Populated_title_7_pcnt *   0.00 / 100 + T.Populated_title_8_pcnt *   0.00 / 100 + T.Populated_title_9_pcnt *   0.00 / 100 + T.Populated_title_10_pcnt *   0.00 / 100 + T.Populated_aka_id_pcnt *   0.00 / 100 + T.Populated_aka_type_pcnt *   0.00 / 100 + T.Populated_aka_category_pcnt *   0.00 / 100 + T.Populated_giv_designator_pcnt *   0.00 / 100 + T.Populated_entity_type_pcnt *   0.00 / 100 + T.Populated_address_id_pcnt *   0.00 / 100 + T.Populated_address_line_1_pcnt *   0.00 / 100 + T.Populated_address_line_2_pcnt *   0.00 / 100 + T.Populated_address_line_3_pcnt *   0.00 / 100 + T.Populated_address_city_pcnt *   0.00 / 100 + T.Populated_address_state_province_pcnt *   0.00 / 100 + T.Populated_address_postal_code_pcnt *   0.00 / 100 + T.Populated_address_country_pcnt *   0.00 / 100 + T.Populated_remarks_pcnt *   0.00 / 100 + T.Populated_call_sign_pcnt *   0.00 / 100 + T.Populated_vessel_type_pcnt *   0.00 / 100 + T.Populated_tonnage_pcnt *   0.00 / 100 + T.Populated_gross_registered_tonnage_pcnt *   0.00 / 100 + T.Populated_vessel_flag_pcnt *   0.00 / 100 + T.Populated_vessel_owner_pcnt *   0.00 / 100 + T.Populated_sanctions_program_1_pcnt *   0.00 / 100 + T.Populated_sanctions_program_2_pcnt *   0.00 / 100 + T.Populated_sanctions_program_3_pcnt *   0.00 / 100 + T.Populated_sanctions_program_4_pcnt *   0.00 / 100 + T.Populated_sanctions_program_5_pcnt *   0.00 / 100 + T.Populated_sanctions_program_6_pcnt *   0.00 / 100 + T.Populated_sanctions_program_7_pcnt *   0.00 / 100 + T.Populated_sanctions_program_8_pcnt *   0.00 / 100 + T.Populated_sanctions_program_9_pcnt *   0.00 / 100 + T.Populated_sanctions_program_10_pcnt *   0.00 / 100 + T.Populated_passport_details_pcnt *   0.00 / 100 + T.Populated_ni_number_details_pcnt *   0.00 / 100 + T.Populated_id_id_1_pcnt *   0.00 / 100 + T.Populated_id_id_2_pcnt *   0.00 / 100 + T.Populated_id_id_3_pcnt *   0.00 / 100 + T.Populated_id_id_4_pcnt *   0.00 / 100 + T.Populated_id_id_5_pcnt *   0.00 / 100 + T.Populated_id_id_6_pcnt *   0.00 / 100 + T.Populated_id_id_7_pcnt *   0.00 / 100 + T.Populated_id_id_8_pcnt *   0.00 / 100 + T.Populated_id_id_9_pcnt *   0.00 / 100 + T.Populated_id_id_10_pcnt *   0.00 / 100 + T.Populated_id_type_1_pcnt *   0.00 / 100 + T.Populated_id_type_2_pcnt *   0.00 / 100 + T.Populated_id_type_3_pcnt *   0.00 / 100 + T.Populated_id_type_4_pcnt *   0.00 / 100 + T.Populated_id_type_5_pcnt *   0.00 / 100 + T.Populated_id_type_6_pcnt *   0.00 / 100 + T.Populated_id_type_7_pcnt *   0.00 / 100 + T.Populated_id_type_8_pcnt *   0.00 / 100 + T.Populated_id_type_9_pcnt *   0.00 / 100 + T.Populated_id_type_10_pcnt *   0.00 / 100 + T.Populated_id_number_1_pcnt *   0.00 / 100 + T.Populated_id_number_2_pcnt *   0.00 / 100 + T.Populated_id_number_3_pcnt *   0.00 / 100 + T.Populated_id_number_4_pcnt *   0.00 / 100 + T.Populated_id_number_5_pcnt *   0.00 / 100 + T.Populated_id_number_6_pcnt *   0.00 / 100 + T.Populated_id_number_7_pcnt *   0.00 / 100 + T.Populated_id_number_8_pcnt *   0.00 / 100 + T.Populated_id_number_9_pcnt *   0.00 / 100 + T.Populated_id_number_10_pcnt *   0.00 / 100 + T.Populated_id_country_1_pcnt *   0.00 / 100 + T.Populated_id_country_2_pcnt *   0.00 / 100 + T.Populated_id_country_3_pcnt *   0.00 / 100 + T.Populated_id_country_4_pcnt *   0.00 / 100 + T.Populated_id_country_5_pcnt *   0.00 / 100 + T.Populated_id_country_6_pcnt *   0.00 / 100 + T.Populated_id_country_7_pcnt *   0.00 / 100 + T.Populated_id_country_8_pcnt *   0.00 / 100 + T.Populated_id_country_9_pcnt *   0.00 / 100 + T.Populated_id_country_10_pcnt *   0.00 / 100 + T.Populated_id_issue_date_1_pcnt *   0.00 / 100 + T.Populated_id_issue_date_2_pcnt *   0.00 / 100 + T.Populated_id_issue_date_3_pcnt *   0.00 / 100 + T.Populated_id_issue_date_4_pcnt *   0.00 / 100 + T.Populated_id_issue_date_5_pcnt *   0.00 / 100 + T.Populated_id_issue_date_6_pcnt *   0.00 / 100 + T.Populated_id_issue_date_7_pcnt *   0.00 / 100 + T.Populated_id_issue_date_8_pcnt *   0.00 / 100 + T.Populated_id_issue_date_9_pcnt *   0.00 / 100 + T.Populated_id_issue_date_10_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_1_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_2_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_3_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_4_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_5_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_6_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_7_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_8_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_9_pcnt *   0.00 / 100 + T.Populated_id_expiration_date_10_pcnt *   0.00 / 100 + T.Populated_nationality_id_1_pcnt *   0.00 / 100 + T.Populated_nationality_id_2_pcnt *   0.00 / 100 + T.Populated_nationality_id_3_pcnt *   0.00 / 100 + T.Populated_nationality_id_4_pcnt *   0.00 / 100 + T.Populated_nationality_id_5_pcnt *   0.00 / 100 + T.Populated_nationality_id_6_pcnt *   0.00 / 100 + T.Populated_nationality_id_7_pcnt *   0.00 / 100 + T.Populated_nationality_id_8_pcnt *   0.00 / 100 + T.Populated_nationality_id_9_pcnt *   0.00 / 100 + T.Populated_nationality_id_10_pcnt *   0.00 / 100 + T.Populated_nationality_1_pcnt *   0.00 / 100 + T.Populated_nationality_2_pcnt *   0.00 / 100 + T.Populated_nationality_3_pcnt *   0.00 / 100 + T.Populated_nationality_4_pcnt *   0.00 / 100 + T.Populated_nationality_5_pcnt *   0.00 / 100 + T.Populated_nationality_6_pcnt *   0.00 / 100 + T.Populated_nationality_7_pcnt *   0.00 / 100 + T.Populated_nationality_8_pcnt *   0.00 / 100 + T.Populated_nationality_9_pcnt *   0.00 / 100 + T.Populated_nationality_10_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_1_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_2_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_3_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_4_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_5_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_6_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_7_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_8_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_9_pcnt *   0.00 / 100 + T.Populated_primary_nationality_flag_10_pcnt *   0.00 / 100 + T.Populated_citizenship_id_1_pcnt *   0.00 / 100 + T.Populated_citizenship_id_2_pcnt *   0.00 / 100 + T.Populated_citizenship_id_3_pcnt *   0.00 / 100 + T.Populated_citizenship_id_4_pcnt *   0.00 / 100 + T.Populated_citizenship_id_5_pcnt *   0.00 / 100 + T.Populated_citizenship_id_6_pcnt *   0.00 / 100 + T.Populated_citizenship_id_7_pcnt *   0.00 / 100 + T.Populated_citizenship_id_8_pcnt *   0.00 / 100 + T.Populated_citizenship_id_9_pcnt *   0.00 / 100 + T.Populated_citizenship_id_10_pcnt *   0.00 / 100 + T.Populated_citizenship_1_pcnt *   0.00 / 100 + T.Populated_citizenship_2_pcnt *   0.00 / 100 + T.Populated_citizenship_3_pcnt *   0.00 / 100 + T.Populated_citizenship_4_pcnt *   0.00 / 100 + T.Populated_citizenship_5_pcnt *   0.00 / 100 + T.Populated_citizenship_6_pcnt *   0.00 / 100 + T.Populated_citizenship_7_pcnt *   0.00 / 100 + T.Populated_citizenship_8_pcnt *   0.00 / 100 + T.Populated_citizenship_9_pcnt *   0.00 / 100 + T.Populated_citizenship_10_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_1_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_2_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_3_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_4_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_5_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_6_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_7_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_8_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_9_pcnt *   0.00 / 100 + T.Populated_primary_citizenship_flag_10_pcnt *   0.00 / 100 + T.Populated_dob_id_1_pcnt *   0.00 / 100 + T.Populated_dob_id_2_pcnt *   0.00 / 100 + T.Populated_dob_id_3_pcnt *   0.00 / 100 + T.Populated_dob_id_4_pcnt *   0.00 / 100 + T.Populated_dob_id_5_pcnt *   0.00 / 100 + T.Populated_dob_id_6_pcnt *   0.00 / 100 + T.Populated_dob_id_7_pcnt *   0.00 / 100 + T.Populated_dob_id_8_pcnt *   0.00 / 100 + T.Populated_dob_id_9_pcnt *   0.00 / 100 + T.Populated_dob_id_10_pcnt *   0.00 / 100 + T.Populated_dob_1_pcnt *   0.00 / 100 + T.Populated_dob_2_pcnt *   0.00 / 100 + T.Populated_dob_3_pcnt *   0.00 / 100 + T.Populated_dob_4_pcnt *   0.00 / 100 + T.Populated_dob_5_pcnt *   0.00 / 100 + T.Populated_dob_6_pcnt *   0.00 / 100 + T.Populated_dob_7_pcnt *   0.00 / 100 + T.Populated_dob_8_pcnt *   0.00 / 100 + T.Populated_dob_9_pcnt *   0.00 / 100 + T.Populated_dob_10_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_1_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_2_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_3_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_4_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_5_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_6_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_7_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_8_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_9_pcnt *   0.00 / 100 + T.Populated_primary_dob_flag_10_pcnt *   0.00 / 100 + T.Populated_pob_id_1_pcnt *   0.00 / 100 + T.Populated_pob_id_2_pcnt *   0.00 / 100 + T.Populated_pob_id_3_pcnt *   0.00 / 100 + T.Populated_pob_id_4_pcnt *   0.00 / 100 + T.Populated_pob_id_5_pcnt *   0.00 / 100 + T.Populated_pob_id_6_pcnt *   0.00 / 100 + T.Populated_pob_id_7_pcnt *   0.00 / 100 + T.Populated_pob_id_8_pcnt *   0.00 / 100 + T.Populated_pob_id_9_pcnt *   0.00 / 100 + T.Populated_pob_id_10_pcnt *   0.00 / 100 + T.Populated_pob_1_pcnt *   0.00 / 100 + T.Populated_pob_2_pcnt *   0.00 / 100 + T.Populated_pob_3_pcnt *   0.00 / 100 + T.Populated_pob_4_pcnt *   0.00 / 100 + T.Populated_pob_5_pcnt *   0.00 / 100 + T.Populated_pob_6_pcnt *   0.00 / 100 + T.Populated_pob_7_pcnt *   0.00 / 100 + T.Populated_pob_8_pcnt *   0.00 / 100 + T.Populated_pob_9_pcnt *   0.00 / 100 + T.Populated_pob_10_pcnt *   0.00 / 100 + T.Populated_country_of_birth_1_pcnt *   0.00 / 100 + T.Populated_country_of_birth_2_pcnt *   0.00 / 100 + T.Populated_country_of_birth_3_pcnt *   0.00 / 100 + T.Populated_country_of_birth_4_pcnt *   0.00 / 100 + T.Populated_country_of_birth_5_pcnt *   0.00 / 100 + T.Populated_country_of_birth_6_pcnt *   0.00 / 100 + T.Populated_country_of_birth_7_pcnt *   0.00 / 100 + T.Populated_country_of_birth_8_pcnt *   0.00 / 100 + T.Populated_country_of_birth_9_pcnt *   0.00 / 100 + T.Populated_country_of_birth_10_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_1_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_2_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_3_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_4_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_5_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_6_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_7_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_8_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_9_pcnt *   0.00 / 100 + T.Populated_primary_pob_flag_10_pcnt *   0.00 / 100 + T.Populated_language_1_pcnt *   0.00 / 100 + T.Populated_language_2_pcnt *   0.00 / 100 + T.Populated_language_3_pcnt *   0.00 / 100 + T.Populated_language_4_pcnt *   0.00 / 100 + T.Populated_language_5_pcnt *   0.00 / 100 + T.Populated_language_6_pcnt *   0.00 / 100 + T.Populated_language_7_pcnt *   0.00 / 100 + T.Populated_language_8_pcnt *   0.00 / 100 + T.Populated_language_9_pcnt *   0.00 / 100 + T.Populated_language_10_pcnt *   0.00 / 100 + T.Populated_membership_1_pcnt *   0.00 / 100 + T.Populated_membership_2_pcnt *   0.00 / 100 + T.Populated_membership_3_pcnt *   0.00 / 100 + T.Populated_membership_4_pcnt *   0.00 / 100 + T.Populated_membership_5_pcnt *   0.00 / 100 + T.Populated_membership_6_pcnt *   0.00 / 100 + T.Populated_membership_7_pcnt *   0.00 / 100 + T.Populated_membership_8_pcnt *   0.00 / 100 + T.Populated_membership_9_pcnt *   0.00 / 100 + T.Populated_membership_10_pcnt *   0.00 / 100 + T.Populated_position_1_pcnt *   0.00 / 100 + T.Populated_position_2_pcnt *   0.00 / 100 + T.Populated_position_3_pcnt *   0.00 / 100 + T.Populated_position_4_pcnt *   0.00 / 100 + T.Populated_position_5_pcnt *   0.00 / 100 + T.Populated_position_6_pcnt *   0.00 / 100 + T.Populated_position_7_pcnt *   0.00 / 100 + T.Populated_position_8_pcnt *   0.00 / 100 + T.Populated_position_9_pcnt *   0.00 / 100 + T.Populated_position_10_pcnt *   0.00 / 100 + T.Populated_occupation_1_pcnt *   0.00 / 100 + T.Populated_occupation_2_pcnt *   0.00 / 100 + T.Populated_occupation_3_pcnt *   0.00 / 100 + T.Populated_occupation_4_pcnt *   0.00 / 100 + T.Populated_occupation_5_pcnt *   0.00 / 100 + T.Populated_occupation_6_pcnt *   0.00 / 100 + T.Populated_occupation_7_pcnt *   0.00 / 100 + T.Populated_occupation_8_pcnt *   0.00 / 100 + T.Populated_occupation_9_pcnt *   0.00 / 100 + T.Populated_occupation_10_pcnt *   0.00 / 100 + T.Populated_date_added_to_list_pcnt *   0.00 / 100 + T.Populated_date_last_updated_pcnt *   0.00 / 100 + T.Populated_effective_date_pcnt *   0.00 / 100 + T.Populated_expiration_date_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_grounds_pcnt *   0.00 / 100 + T.Populated_subj_to_common_pos_2001_931_cfsp_fl_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_1_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_2_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_3_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_4_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_5_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_6_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_7_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_8_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_9_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_10_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_1_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_2_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_3_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_4_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_5_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_6_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_7_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_8_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_9_pcnt *   0.00 / 100 + T.Populated_federal_register_citation_date_10_pcnt *   0.00 / 100 + T.Populated_license_requirement_pcnt *   0.00 / 100 + T.Populated_license_review_policy_pcnt *   0.00 / 100 + T.Populated_subordinate_status_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_weight_pcnt *   0.00 / 100 + T.Populated_physique_pcnt *   0.00 / 100 + T.Populated_hair_color_pcnt *   0.00 / 100 + T.Populated_eyes_pcnt *   0.00 / 100 + T.Populated_complexion_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_scars_marks_pcnt *   0.00 / 100 + T.Populated_photo_file_pcnt *   0.00 / 100 + T.Populated_offenses_pcnt *   0.00 / 100 + T.Populated_ncic_pcnt *   0.00 / 100 + T.Populated_warrant_by_pcnt *   0.00 / 100 + T.Populated_caution_pcnt *   0.00 / 100 + T.Populated_reward_pcnt *   0.00 / 100 + T.Populated_type_of_denial_pcnt *   0.00 / 100 + T.Populated_linked_with_1_pcnt *   0.00 / 100 + T.Populated_linked_with_2_pcnt *   0.00 / 100 + T.Populated_linked_with_3_pcnt *   0.00 / 100 + T.Populated_linked_with_4_pcnt *   0.00 / 100 + T.Populated_linked_with_5_pcnt *   0.00 / 100 + T.Populated_linked_with_6_pcnt *   0.00 / 100 + T.Populated_linked_with_7_pcnt *   0.00 / 100 + T.Populated_linked_with_8_pcnt *   0.00 / 100 + T.Populated_linked_with_9_pcnt *   0.00 / 100 + T.Populated_linked_with_10_pcnt *   0.00 / 100 + T.Populated_linked_with_id_1_pcnt *   0.00 / 100 + T.Populated_linked_with_id_2_pcnt *   0.00 / 100 + T.Populated_linked_with_id_3_pcnt *   0.00 / 100 + T.Populated_linked_with_id_4_pcnt *   0.00 / 100 + T.Populated_linked_with_id_5_pcnt *   0.00 / 100 + T.Populated_linked_with_id_6_pcnt *   0.00 / 100 + T.Populated_linked_with_id_7_pcnt *   0.00 / 100 + T.Populated_linked_with_id_8_pcnt *   0.00 / 100 + T.Populated_linked_with_id_9_pcnt *   0.00 / 100 + T.Populated_linked_with_id_10_pcnt *   0.00 / 100 + T.Populated_listing_information_pcnt *   0.00 / 100 + T.Populated_foreign_principal_pcnt *   0.00 / 100 + T.Populated_nature_of_service_pcnt *   0.00 / 100 + T.Populated_activities_pcnt *   0.00 / 100 + T.Populated_finances_pcnt *   0.00 / 100 + T.Populated_registrant_terminated_flag_pcnt *   0.00 / 100 + T.Populated_foreign_principal_terminated_flag_pcnt *   0.00 / 100 + T.Populated_short_form_terminated_flag_pcnt *   0.00 / 100 + T.Populated_src_key_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING src_key1;
    STRING src_key2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.src_key1 := le.Source;
    SELF.src_key2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_pty_key_pcnt*ri.Populated_pty_key_pcnt *   0.00 / 10000 + le.Populated_source_pcnt*ri.Populated_source_pcnt *   0.00 / 10000 + le.Populated_orig_pty_name_pcnt*ri.Populated_orig_pty_name_pcnt *   0.00 / 10000 + le.Populated_orig_vessel_name_pcnt*ri.Populated_orig_vessel_name_pcnt *   0.00 / 10000 + le.Populated_country_pcnt*ri.Populated_country_pcnt *   0.00 / 10000 + le.Populated_name_type_pcnt*ri.Populated_name_type_pcnt *   0.00 / 10000 + le.Populated_addr_1_pcnt*ri.Populated_addr_1_pcnt *   0.00 / 10000 + le.Populated_addr_2_pcnt*ri.Populated_addr_2_pcnt *   0.00 / 10000 + le.Populated_addr_3_pcnt*ri.Populated_addr_3_pcnt *   0.00 / 10000 + le.Populated_addr_4_pcnt*ri.Populated_addr_4_pcnt *   0.00 / 10000 + le.Populated_addr_5_pcnt*ri.Populated_addr_5_pcnt *   0.00 / 10000 + le.Populated_addr_6_pcnt*ri.Populated_addr_6_pcnt *   0.00 / 10000 + le.Populated_addr_7_pcnt*ri.Populated_addr_7_pcnt *   0.00 / 10000 + le.Populated_addr_8_pcnt*ri.Populated_addr_8_pcnt *   0.00 / 10000 + le.Populated_addr_9_pcnt*ri.Populated_addr_9_pcnt *   0.00 / 10000 + le.Populated_addr_10_pcnt*ri.Populated_addr_10_pcnt *   0.00 / 10000 + le.Populated_remarks_1_pcnt*ri.Populated_remarks_1_pcnt *   0.00 / 10000 + le.Populated_remarks_2_pcnt*ri.Populated_remarks_2_pcnt *   0.00 / 10000 + le.Populated_remarks_3_pcnt*ri.Populated_remarks_3_pcnt *   0.00 / 10000 + le.Populated_remarks_4_pcnt*ri.Populated_remarks_4_pcnt *   0.00 / 10000 + le.Populated_remarks_5_pcnt*ri.Populated_remarks_5_pcnt *   0.00 / 10000 + le.Populated_remarks_6_pcnt*ri.Populated_remarks_6_pcnt *   0.00 / 10000 + le.Populated_remarks_7_pcnt*ri.Populated_remarks_7_pcnt *   0.00 / 10000 + le.Populated_remarks_8_pcnt*ri.Populated_remarks_8_pcnt *   0.00 / 10000 + le.Populated_remarks_9_pcnt*ri.Populated_remarks_9_pcnt *   0.00 / 10000 + le.Populated_remarks_10_pcnt*ri.Populated_remarks_10_pcnt *   0.00 / 10000 + le.Populated_remarks_11_pcnt*ri.Populated_remarks_11_pcnt *   0.00 / 10000 + le.Populated_remarks_12_pcnt*ri.Populated_remarks_12_pcnt *   0.00 / 10000 + le.Populated_remarks_13_pcnt*ri.Populated_remarks_13_pcnt *   0.00 / 10000 + le.Populated_remarks_14_pcnt*ri.Populated_remarks_14_pcnt *   0.00 / 10000 + le.Populated_remarks_15_pcnt*ri.Populated_remarks_15_pcnt *   0.00 / 10000 + le.Populated_remarks_16_pcnt*ri.Populated_remarks_16_pcnt *   0.00 / 10000 + le.Populated_remarks_17_pcnt*ri.Populated_remarks_17_pcnt *   0.00 / 10000 + le.Populated_remarks_18_pcnt*ri.Populated_remarks_18_pcnt *   0.00 / 10000 + le.Populated_remarks_19_pcnt*ri.Populated_remarks_19_pcnt *   0.00 / 10000 + le.Populated_remarks_20_pcnt*ri.Populated_remarks_20_pcnt *   0.00 / 10000 + le.Populated_remarks_21_pcnt*ri.Populated_remarks_21_pcnt *   0.00 / 10000 + le.Populated_remarks_22_pcnt*ri.Populated_remarks_22_pcnt *   0.00 / 10000 + le.Populated_remarks_23_pcnt*ri.Populated_remarks_23_pcnt *   0.00 / 10000 + le.Populated_remarks_24_pcnt*ri.Populated_remarks_24_pcnt *   0.00 / 10000 + le.Populated_remarks_25_pcnt*ri.Populated_remarks_25_pcnt *   0.00 / 10000 + le.Populated_remarks_26_pcnt*ri.Populated_remarks_26_pcnt *   0.00 / 10000 + le.Populated_remarks_27_pcnt*ri.Populated_remarks_27_pcnt *   0.00 / 10000 + le.Populated_remarks_28_pcnt*ri.Populated_remarks_28_pcnt *   0.00 / 10000 + le.Populated_remarks_29_pcnt*ri.Populated_remarks_29_pcnt *   0.00 / 10000 + le.Populated_remarks_30_pcnt*ri.Populated_remarks_30_pcnt *   0.00 / 10000 + le.Populated_cname_pcnt*ri.Populated_cname_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_a_score_pcnt*ri.Populated_a_score_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_ace_fips_st_pcnt*ri.Populated_ace_fips_st_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_date_first_seen_pcnt*ri.Populated_date_first_seen_pcnt *   0.00 / 10000 + le.Populated_date_last_seen_pcnt*ri.Populated_date_last_seen_pcnt *   0.00 / 10000 + le.Populated_date_vendor_first_reported_pcnt*ri.Populated_date_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_date_vendor_last_reported_pcnt*ri.Populated_date_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_entity_id_pcnt*ri.Populated_entity_id_pcnt *   0.00 / 10000 + le.Populated_first_name_pcnt*ri.Populated_first_name_pcnt *   0.00 / 10000 + le.Populated_last_name_pcnt*ri.Populated_last_name_pcnt *   0.00 / 10000 + le.Populated_title_1_pcnt*ri.Populated_title_1_pcnt *   0.00 / 10000 + le.Populated_title_2_pcnt*ri.Populated_title_2_pcnt *   0.00 / 10000 + le.Populated_title_3_pcnt*ri.Populated_title_3_pcnt *   0.00 / 10000 + le.Populated_title_4_pcnt*ri.Populated_title_4_pcnt *   0.00 / 10000 + le.Populated_title_5_pcnt*ri.Populated_title_5_pcnt *   0.00 / 10000 + le.Populated_title_6_pcnt*ri.Populated_title_6_pcnt *   0.00 / 10000 + le.Populated_title_7_pcnt*ri.Populated_title_7_pcnt *   0.00 / 10000 + le.Populated_title_8_pcnt*ri.Populated_title_8_pcnt *   0.00 / 10000 + le.Populated_title_9_pcnt*ri.Populated_title_9_pcnt *   0.00 / 10000 + le.Populated_title_10_pcnt*ri.Populated_title_10_pcnt *   0.00 / 10000 + le.Populated_aka_id_pcnt*ri.Populated_aka_id_pcnt *   0.00 / 10000 + le.Populated_aka_type_pcnt*ri.Populated_aka_type_pcnt *   0.00 / 10000 + le.Populated_aka_category_pcnt*ri.Populated_aka_category_pcnt *   0.00 / 10000 + le.Populated_giv_designator_pcnt*ri.Populated_giv_designator_pcnt *   0.00 / 10000 + le.Populated_entity_type_pcnt*ri.Populated_entity_type_pcnt *   0.00 / 10000 + le.Populated_address_id_pcnt*ri.Populated_address_id_pcnt *   0.00 / 10000 + le.Populated_address_line_1_pcnt*ri.Populated_address_line_1_pcnt *   0.00 / 10000 + le.Populated_address_line_2_pcnt*ri.Populated_address_line_2_pcnt *   0.00 / 10000 + le.Populated_address_line_3_pcnt*ri.Populated_address_line_3_pcnt *   0.00 / 10000 + le.Populated_address_city_pcnt*ri.Populated_address_city_pcnt *   0.00 / 10000 + le.Populated_address_state_province_pcnt*ri.Populated_address_state_province_pcnt *   0.00 / 10000 + le.Populated_address_postal_code_pcnt*ri.Populated_address_postal_code_pcnt *   0.00 / 10000 + le.Populated_address_country_pcnt*ri.Populated_address_country_pcnt *   0.00 / 10000 + le.Populated_remarks_pcnt*ri.Populated_remarks_pcnt *   0.00 / 10000 + le.Populated_call_sign_pcnt*ri.Populated_call_sign_pcnt *   0.00 / 10000 + le.Populated_vessel_type_pcnt*ri.Populated_vessel_type_pcnt *   0.00 / 10000 + le.Populated_tonnage_pcnt*ri.Populated_tonnage_pcnt *   0.00 / 10000 + le.Populated_gross_registered_tonnage_pcnt*ri.Populated_gross_registered_tonnage_pcnt *   0.00 / 10000 + le.Populated_vessel_flag_pcnt*ri.Populated_vessel_flag_pcnt *   0.00 / 10000 + le.Populated_vessel_owner_pcnt*ri.Populated_vessel_owner_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_1_pcnt*ri.Populated_sanctions_program_1_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_2_pcnt*ri.Populated_sanctions_program_2_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_3_pcnt*ri.Populated_sanctions_program_3_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_4_pcnt*ri.Populated_sanctions_program_4_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_5_pcnt*ri.Populated_sanctions_program_5_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_6_pcnt*ri.Populated_sanctions_program_6_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_7_pcnt*ri.Populated_sanctions_program_7_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_8_pcnt*ri.Populated_sanctions_program_8_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_9_pcnt*ri.Populated_sanctions_program_9_pcnt *   0.00 / 10000 + le.Populated_sanctions_program_10_pcnt*ri.Populated_sanctions_program_10_pcnt *   0.00 / 10000 + le.Populated_passport_details_pcnt*ri.Populated_passport_details_pcnt *   0.00 / 10000 + le.Populated_ni_number_details_pcnt*ri.Populated_ni_number_details_pcnt *   0.00 / 10000 + le.Populated_id_id_1_pcnt*ri.Populated_id_id_1_pcnt *   0.00 / 10000 + le.Populated_id_id_2_pcnt*ri.Populated_id_id_2_pcnt *   0.00 / 10000 + le.Populated_id_id_3_pcnt*ri.Populated_id_id_3_pcnt *   0.00 / 10000 + le.Populated_id_id_4_pcnt*ri.Populated_id_id_4_pcnt *   0.00 / 10000 + le.Populated_id_id_5_pcnt*ri.Populated_id_id_5_pcnt *   0.00 / 10000 + le.Populated_id_id_6_pcnt*ri.Populated_id_id_6_pcnt *   0.00 / 10000 + le.Populated_id_id_7_pcnt*ri.Populated_id_id_7_pcnt *   0.00 / 10000 + le.Populated_id_id_8_pcnt*ri.Populated_id_id_8_pcnt *   0.00 / 10000 + le.Populated_id_id_9_pcnt*ri.Populated_id_id_9_pcnt *   0.00 / 10000 + le.Populated_id_id_10_pcnt*ri.Populated_id_id_10_pcnt *   0.00 / 10000 + le.Populated_id_type_1_pcnt*ri.Populated_id_type_1_pcnt *   0.00 / 10000 + le.Populated_id_type_2_pcnt*ri.Populated_id_type_2_pcnt *   0.00 / 10000 + le.Populated_id_type_3_pcnt*ri.Populated_id_type_3_pcnt *   0.00 / 10000 + le.Populated_id_type_4_pcnt*ri.Populated_id_type_4_pcnt *   0.00 / 10000 + le.Populated_id_type_5_pcnt*ri.Populated_id_type_5_pcnt *   0.00 / 10000 + le.Populated_id_type_6_pcnt*ri.Populated_id_type_6_pcnt *   0.00 / 10000 + le.Populated_id_type_7_pcnt*ri.Populated_id_type_7_pcnt *   0.00 / 10000 + le.Populated_id_type_8_pcnt*ri.Populated_id_type_8_pcnt *   0.00 / 10000 + le.Populated_id_type_9_pcnt*ri.Populated_id_type_9_pcnt *   0.00 / 10000 + le.Populated_id_type_10_pcnt*ri.Populated_id_type_10_pcnt *   0.00 / 10000 + le.Populated_id_number_1_pcnt*ri.Populated_id_number_1_pcnt *   0.00 / 10000 + le.Populated_id_number_2_pcnt*ri.Populated_id_number_2_pcnt *   0.00 / 10000 + le.Populated_id_number_3_pcnt*ri.Populated_id_number_3_pcnt *   0.00 / 10000 + le.Populated_id_number_4_pcnt*ri.Populated_id_number_4_pcnt *   0.00 / 10000 + le.Populated_id_number_5_pcnt*ri.Populated_id_number_5_pcnt *   0.00 / 10000 + le.Populated_id_number_6_pcnt*ri.Populated_id_number_6_pcnt *   0.00 / 10000 + le.Populated_id_number_7_pcnt*ri.Populated_id_number_7_pcnt *   0.00 / 10000 + le.Populated_id_number_8_pcnt*ri.Populated_id_number_8_pcnt *   0.00 / 10000 + le.Populated_id_number_9_pcnt*ri.Populated_id_number_9_pcnt *   0.00 / 10000 + le.Populated_id_number_10_pcnt*ri.Populated_id_number_10_pcnt *   0.00 / 10000 + le.Populated_id_country_1_pcnt*ri.Populated_id_country_1_pcnt *   0.00 / 10000 + le.Populated_id_country_2_pcnt*ri.Populated_id_country_2_pcnt *   0.00 / 10000 + le.Populated_id_country_3_pcnt*ri.Populated_id_country_3_pcnt *   0.00 / 10000 + le.Populated_id_country_4_pcnt*ri.Populated_id_country_4_pcnt *   0.00 / 10000 + le.Populated_id_country_5_pcnt*ri.Populated_id_country_5_pcnt *   0.00 / 10000 + le.Populated_id_country_6_pcnt*ri.Populated_id_country_6_pcnt *   0.00 / 10000 + le.Populated_id_country_7_pcnt*ri.Populated_id_country_7_pcnt *   0.00 / 10000 + le.Populated_id_country_8_pcnt*ri.Populated_id_country_8_pcnt *   0.00 / 10000 + le.Populated_id_country_9_pcnt*ri.Populated_id_country_9_pcnt *   0.00 / 10000 + le.Populated_id_country_10_pcnt*ri.Populated_id_country_10_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_1_pcnt*ri.Populated_id_issue_date_1_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_2_pcnt*ri.Populated_id_issue_date_2_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_3_pcnt*ri.Populated_id_issue_date_3_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_4_pcnt*ri.Populated_id_issue_date_4_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_5_pcnt*ri.Populated_id_issue_date_5_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_6_pcnt*ri.Populated_id_issue_date_6_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_7_pcnt*ri.Populated_id_issue_date_7_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_8_pcnt*ri.Populated_id_issue_date_8_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_9_pcnt*ri.Populated_id_issue_date_9_pcnt *   0.00 / 10000 + le.Populated_id_issue_date_10_pcnt*ri.Populated_id_issue_date_10_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_1_pcnt*ri.Populated_id_expiration_date_1_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_2_pcnt*ri.Populated_id_expiration_date_2_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_3_pcnt*ri.Populated_id_expiration_date_3_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_4_pcnt*ri.Populated_id_expiration_date_4_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_5_pcnt*ri.Populated_id_expiration_date_5_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_6_pcnt*ri.Populated_id_expiration_date_6_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_7_pcnt*ri.Populated_id_expiration_date_7_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_8_pcnt*ri.Populated_id_expiration_date_8_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_9_pcnt*ri.Populated_id_expiration_date_9_pcnt *   0.00 / 10000 + le.Populated_id_expiration_date_10_pcnt*ri.Populated_id_expiration_date_10_pcnt *   0.00 / 10000 + le.Populated_nationality_id_1_pcnt*ri.Populated_nationality_id_1_pcnt *   0.00 / 10000 + le.Populated_nationality_id_2_pcnt*ri.Populated_nationality_id_2_pcnt *   0.00 / 10000 + le.Populated_nationality_id_3_pcnt*ri.Populated_nationality_id_3_pcnt *   0.00 / 10000 + le.Populated_nationality_id_4_pcnt*ri.Populated_nationality_id_4_pcnt *   0.00 / 10000 + le.Populated_nationality_id_5_pcnt*ri.Populated_nationality_id_5_pcnt *   0.00 / 10000 + le.Populated_nationality_id_6_pcnt*ri.Populated_nationality_id_6_pcnt *   0.00 / 10000 + le.Populated_nationality_id_7_pcnt*ri.Populated_nationality_id_7_pcnt *   0.00 / 10000 + le.Populated_nationality_id_8_pcnt*ri.Populated_nationality_id_8_pcnt *   0.00 / 10000 + le.Populated_nationality_id_9_pcnt*ri.Populated_nationality_id_9_pcnt *   0.00 / 10000 + le.Populated_nationality_id_10_pcnt*ri.Populated_nationality_id_10_pcnt *   0.00 / 10000 + le.Populated_nationality_1_pcnt*ri.Populated_nationality_1_pcnt *   0.00 / 10000 + le.Populated_nationality_2_pcnt*ri.Populated_nationality_2_pcnt *   0.00 / 10000 + le.Populated_nationality_3_pcnt*ri.Populated_nationality_3_pcnt *   0.00 / 10000 + le.Populated_nationality_4_pcnt*ri.Populated_nationality_4_pcnt *   0.00 / 10000 + le.Populated_nationality_5_pcnt*ri.Populated_nationality_5_pcnt *   0.00 / 10000 + le.Populated_nationality_6_pcnt*ri.Populated_nationality_6_pcnt *   0.00 / 10000 + le.Populated_nationality_7_pcnt*ri.Populated_nationality_7_pcnt *   0.00 / 10000 + le.Populated_nationality_8_pcnt*ri.Populated_nationality_8_pcnt *   0.00 / 10000 + le.Populated_nationality_9_pcnt*ri.Populated_nationality_9_pcnt *   0.00 / 10000 + le.Populated_nationality_10_pcnt*ri.Populated_nationality_10_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_1_pcnt*ri.Populated_primary_nationality_flag_1_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_2_pcnt*ri.Populated_primary_nationality_flag_2_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_3_pcnt*ri.Populated_primary_nationality_flag_3_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_4_pcnt*ri.Populated_primary_nationality_flag_4_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_5_pcnt*ri.Populated_primary_nationality_flag_5_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_6_pcnt*ri.Populated_primary_nationality_flag_6_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_7_pcnt*ri.Populated_primary_nationality_flag_7_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_8_pcnt*ri.Populated_primary_nationality_flag_8_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_9_pcnt*ri.Populated_primary_nationality_flag_9_pcnt *   0.00 / 10000 + le.Populated_primary_nationality_flag_10_pcnt*ri.Populated_primary_nationality_flag_10_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_1_pcnt*ri.Populated_citizenship_id_1_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_2_pcnt*ri.Populated_citizenship_id_2_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_3_pcnt*ri.Populated_citizenship_id_3_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_4_pcnt*ri.Populated_citizenship_id_4_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_5_pcnt*ri.Populated_citizenship_id_5_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_6_pcnt*ri.Populated_citizenship_id_6_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_7_pcnt*ri.Populated_citizenship_id_7_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_8_pcnt*ri.Populated_citizenship_id_8_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_9_pcnt*ri.Populated_citizenship_id_9_pcnt *   0.00 / 10000 + le.Populated_citizenship_id_10_pcnt*ri.Populated_citizenship_id_10_pcnt *   0.00 / 10000 + le.Populated_citizenship_1_pcnt*ri.Populated_citizenship_1_pcnt *   0.00 / 10000 + le.Populated_citizenship_2_pcnt*ri.Populated_citizenship_2_pcnt *   0.00 / 10000 + le.Populated_citizenship_3_pcnt*ri.Populated_citizenship_3_pcnt *   0.00 / 10000 + le.Populated_citizenship_4_pcnt*ri.Populated_citizenship_4_pcnt *   0.00 / 10000 + le.Populated_citizenship_5_pcnt*ri.Populated_citizenship_5_pcnt *   0.00 / 10000 + le.Populated_citizenship_6_pcnt*ri.Populated_citizenship_6_pcnt *   0.00 / 10000 + le.Populated_citizenship_7_pcnt*ri.Populated_citizenship_7_pcnt *   0.00 / 10000 + le.Populated_citizenship_8_pcnt*ri.Populated_citizenship_8_pcnt *   0.00 / 10000 + le.Populated_citizenship_9_pcnt*ri.Populated_citizenship_9_pcnt *   0.00 / 10000 + le.Populated_citizenship_10_pcnt*ri.Populated_citizenship_10_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_1_pcnt*ri.Populated_primary_citizenship_flag_1_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_2_pcnt*ri.Populated_primary_citizenship_flag_2_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_3_pcnt*ri.Populated_primary_citizenship_flag_3_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_4_pcnt*ri.Populated_primary_citizenship_flag_4_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_5_pcnt*ri.Populated_primary_citizenship_flag_5_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_6_pcnt*ri.Populated_primary_citizenship_flag_6_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_7_pcnt*ri.Populated_primary_citizenship_flag_7_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_8_pcnt*ri.Populated_primary_citizenship_flag_8_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_9_pcnt*ri.Populated_primary_citizenship_flag_9_pcnt *   0.00 / 10000 + le.Populated_primary_citizenship_flag_10_pcnt*ri.Populated_primary_citizenship_flag_10_pcnt *   0.00 / 10000 + le.Populated_dob_id_1_pcnt*ri.Populated_dob_id_1_pcnt *   0.00 / 10000 + le.Populated_dob_id_2_pcnt*ri.Populated_dob_id_2_pcnt *   0.00 / 10000 + le.Populated_dob_id_3_pcnt*ri.Populated_dob_id_3_pcnt *   0.00 / 10000 + le.Populated_dob_id_4_pcnt*ri.Populated_dob_id_4_pcnt *   0.00 / 10000 + le.Populated_dob_id_5_pcnt*ri.Populated_dob_id_5_pcnt *   0.00 / 10000 + le.Populated_dob_id_6_pcnt*ri.Populated_dob_id_6_pcnt *   0.00 / 10000 + le.Populated_dob_id_7_pcnt*ri.Populated_dob_id_7_pcnt *   0.00 / 10000 + le.Populated_dob_id_8_pcnt*ri.Populated_dob_id_8_pcnt *   0.00 / 10000 + le.Populated_dob_id_9_pcnt*ri.Populated_dob_id_9_pcnt *   0.00 / 10000 + le.Populated_dob_id_10_pcnt*ri.Populated_dob_id_10_pcnt *   0.00 / 10000 + le.Populated_dob_1_pcnt*ri.Populated_dob_1_pcnt *   0.00 / 10000 + le.Populated_dob_2_pcnt*ri.Populated_dob_2_pcnt *   0.00 / 10000 + le.Populated_dob_3_pcnt*ri.Populated_dob_3_pcnt *   0.00 / 10000 + le.Populated_dob_4_pcnt*ri.Populated_dob_4_pcnt *   0.00 / 10000 + le.Populated_dob_5_pcnt*ri.Populated_dob_5_pcnt *   0.00 / 10000 + le.Populated_dob_6_pcnt*ri.Populated_dob_6_pcnt *   0.00 / 10000 + le.Populated_dob_7_pcnt*ri.Populated_dob_7_pcnt *   0.00 / 10000 + le.Populated_dob_8_pcnt*ri.Populated_dob_8_pcnt *   0.00 / 10000 + le.Populated_dob_9_pcnt*ri.Populated_dob_9_pcnt *   0.00 / 10000 + le.Populated_dob_10_pcnt*ri.Populated_dob_10_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_1_pcnt*ri.Populated_primary_dob_flag_1_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_2_pcnt*ri.Populated_primary_dob_flag_2_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_3_pcnt*ri.Populated_primary_dob_flag_3_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_4_pcnt*ri.Populated_primary_dob_flag_4_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_5_pcnt*ri.Populated_primary_dob_flag_5_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_6_pcnt*ri.Populated_primary_dob_flag_6_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_7_pcnt*ri.Populated_primary_dob_flag_7_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_8_pcnt*ri.Populated_primary_dob_flag_8_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_9_pcnt*ri.Populated_primary_dob_flag_9_pcnt *   0.00 / 10000 + le.Populated_primary_dob_flag_10_pcnt*ri.Populated_primary_dob_flag_10_pcnt *   0.00 / 10000 + le.Populated_pob_id_1_pcnt*ri.Populated_pob_id_1_pcnt *   0.00 / 10000 + le.Populated_pob_id_2_pcnt*ri.Populated_pob_id_2_pcnt *   0.00 / 10000 + le.Populated_pob_id_3_pcnt*ri.Populated_pob_id_3_pcnt *   0.00 / 10000 + le.Populated_pob_id_4_pcnt*ri.Populated_pob_id_4_pcnt *   0.00 / 10000 + le.Populated_pob_id_5_pcnt*ri.Populated_pob_id_5_pcnt *   0.00 / 10000 + le.Populated_pob_id_6_pcnt*ri.Populated_pob_id_6_pcnt *   0.00 / 10000 + le.Populated_pob_id_7_pcnt*ri.Populated_pob_id_7_pcnt *   0.00 / 10000 + le.Populated_pob_id_8_pcnt*ri.Populated_pob_id_8_pcnt *   0.00 / 10000 + le.Populated_pob_id_9_pcnt*ri.Populated_pob_id_9_pcnt *   0.00 / 10000 + le.Populated_pob_id_10_pcnt*ri.Populated_pob_id_10_pcnt *   0.00 / 10000 + le.Populated_pob_1_pcnt*ri.Populated_pob_1_pcnt *   0.00 / 10000 + le.Populated_pob_2_pcnt*ri.Populated_pob_2_pcnt *   0.00 / 10000 + le.Populated_pob_3_pcnt*ri.Populated_pob_3_pcnt *   0.00 / 10000 + le.Populated_pob_4_pcnt*ri.Populated_pob_4_pcnt *   0.00 / 10000 + le.Populated_pob_5_pcnt*ri.Populated_pob_5_pcnt *   0.00 / 10000 + le.Populated_pob_6_pcnt*ri.Populated_pob_6_pcnt *   0.00 / 10000 + le.Populated_pob_7_pcnt*ri.Populated_pob_7_pcnt *   0.00 / 10000 + le.Populated_pob_8_pcnt*ri.Populated_pob_8_pcnt *   0.00 / 10000 + le.Populated_pob_9_pcnt*ri.Populated_pob_9_pcnt *   0.00 / 10000 + le.Populated_pob_10_pcnt*ri.Populated_pob_10_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_1_pcnt*ri.Populated_country_of_birth_1_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_2_pcnt*ri.Populated_country_of_birth_2_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_3_pcnt*ri.Populated_country_of_birth_3_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_4_pcnt*ri.Populated_country_of_birth_4_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_5_pcnt*ri.Populated_country_of_birth_5_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_6_pcnt*ri.Populated_country_of_birth_6_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_7_pcnt*ri.Populated_country_of_birth_7_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_8_pcnt*ri.Populated_country_of_birth_8_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_9_pcnt*ri.Populated_country_of_birth_9_pcnt *   0.00 / 10000 + le.Populated_country_of_birth_10_pcnt*ri.Populated_country_of_birth_10_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_1_pcnt*ri.Populated_primary_pob_flag_1_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_2_pcnt*ri.Populated_primary_pob_flag_2_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_3_pcnt*ri.Populated_primary_pob_flag_3_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_4_pcnt*ri.Populated_primary_pob_flag_4_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_5_pcnt*ri.Populated_primary_pob_flag_5_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_6_pcnt*ri.Populated_primary_pob_flag_6_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_7_pcnt*ri.Populated_primary_pob_flag_7_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_8_pcnt*ri.Populated_primary_pob_flag_8_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_9_pcnt*ri.Populated_primary_pob_flag_9_pcnt *   0.00 / 10000 + le.Populated_primary_pob_flag_10_pcnt*ri.Populated_primary_pob_flag_10_pcnt *   0.00 / 10000 + le.Populated_language_1_pcnt*ri.Populated_language_1_pcnt *   0.00 / 10000 + le.Populated_language_2_pcnt*ri.Populated_language_2_pcnt *   0.00 / 10000 + le.Populated_language_3_pcnt*ri.Populated_language_3_pcnt *   0.00 / 10000 + le.Populated_language_4_pcnt*ri.Populated_language_4_pcnt *   0.00 / 10000 + le.Populated_language_5_pcnt*ri.Populated_language_5_pcnt *   0.00 / 10000 + le.Populated_language_6_pcnt*ri.Populated_language_6_pcnt *   0.00 / 10000 + le.Populated_language_7_pcnt*ri.Populated_language_7_pcnt *   0.00 / 10000 + le.Populated_language_8_pcnt*ri.Populated_language_8_pcnt *   0.00 / 10000 + le.Populated_language_9_pcnt*ri.Populated_language_9_pcnt *   0.00 / 10000 + le.Populated_language_10_pcnt*ri.Populated_language_10_pcnt *   0.00 / 10000 + le.Populated_membership_1_pcnt*ri.Populated_membership_1_pcnt *   0.00 / 10000 + le.Populated_membership_2_pcnt*ri.Populated_membership_2_pcnt *   0.00 / 10000 + le.Populated_membership_3_pcnt*ri.Populated_membership_3_pcnt *   0.00 / 10000 + le.Populated_membership_4_pcnt*ri.Populated_membership_4_pcnt *   0.00 / 10000 + le.Populated_membership_5_pcnt*ri.Populated_membership_5_pcnt *   0.00 / 10000 + le.Populated_membership_6_pcnt*ri.Populated_membership_6_pcnt *   0.00 / 10000 + le.Populated_membership_7_pcnt*ri.Populated_membership_7_pcnt *   0.00 / 10000 + le.Populated_membership_8_pcnt*ri.Populated_membership_8_pcnt *   0.00 / 10000 + le.Populated_membership_9_pcnt*ri.Populated_membership_9_pcnt *   0.00 / 10000 + le.Populated_membership_10_pcnt*ri.Populated_membership_10_pcnt *   0.00 / 10000 + le.Populated_position_1_pcnt*ri.Populated_position_1_pcnt *   0.00 / 10000 + le.Populated_position_2_pcnt*ri.Populated_position_2_pcnt *   0.00 / 10000 + le.Populated_position_3_pcnt*ri.Populated_position_3_pcnt *   0.00 / 10000 + le.Populated_position_4_pcnt*ri.Populated_position_4_pcnt *   0.00 / 10000 + le.Populated_position_5_pcnt*ri.Populated_position_5_pcnt *   0.00 / 10000 + le.Populated_position_6_pcnt*ri.Populated_position_6_pcnt *   0.00 / 10000 + le.Populated_position_7_pcnt*ri.Populated_position_7_pcnt *   0.00 / 10000 + le.Populated_position_8_pcnt*ri.Populated_position_8_pcnt *   0.00 / 10000 + le.Populated_position_9_pcnt*ri.Populated_position_9_pcnt *   0.00 / 10000 + le.Populated_position_10_pcnt*ri.Populated_position_10_pcnt *   0.00 / 10000 + le.Populated_occupation_1_pcnt*ri.Populated_occupation_1_pcnt *   0.00 / 10000 + le.Populated_occupation_2_pcnt*ri.Populated_occupation_2_pcnt *   0.00 / 10000 + le.Populated_occupation_3_pcnt*ri.Populated_occupation_3_pcnt *   0.00 / 10000 + le.Populated_occupation_4_pcnt*ri.Populated_occupation_4_pcnt *   0.00 / 10000 + le.Populated_occupation_5_pcnt*ri.Populated_occupation_5_pcnt *   0.00 / 10000 + le.Populated_occupation_6_pcnt*ri.Populated_occupation_6_pcnt *   0.00 / 10000 + le.Populated_occupation_7_pcnt*ri.Populated_occupation_7_pcnt *   0.00 / 10000 + le.Populated_occupation_8_pcnt*ri.Populated_occupation_8_pcnt *   0.00 / 10000 + le.Populated_occupation_9_pcnt*ri.Populated_occupation_9_pcnt *   0.00 / 10000 + le.Populated_occupation_10_pcnt*ri.Populated_occupation_10_pcnt *   0.00 / 10000 + le.Populated_date_added_to_list_pcnt*ri.Populated_date_added_to_list_pcnt *   0.00 / 10000 + le.Populated_date_last_updated_pcnt*ri.Populated_date_last_updated_pcnt *   0.00 / 10000 + le.Populated_effective_date_pcnt*ri.Populated_effective_date_pcnt *   0.00 / 10000 + le.Populated_expiration_date_pcnt*ri.Populated_expiration_date_pcnt *   0.00 / 10000 + le.Populated_gender_pcnt*ri.Populated_gender_pcnt *   0.00 / 10000 + le.Populated_grounds_pcnt*ri.Populated_grounds_pcnt *   0.00 / 10000 + le.Populated_subj_to_common_pos_2001_931_cfsp_fl_pcnt*ri.Populated_subj_to_common_pos_2001_931_cfsp_fl_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_1_pcnt*ri.Populated_federal_register_citation_1_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_2_pcnt*ri.Populated_federal_register_citation_2_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_3_pcnt*ri.Populated_federal_register_citation_3_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_4_pcnt*ri.Populated_federal_register_citation_4_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_5_pcnt*ri.Populated_federal_register_citation_5_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_6_pcnt*ri.Populated_federal_register_citation_6_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_7_pcnt*ri.Populated_federal_register_citation_7_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_8_pcnt*ri.Populated_federal_register_citation_8_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_9_pcnt*ri.Populated_federal_register_citation_9_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_10_pcnt*ri.Populated_federal_register_citation_10_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_1_pcnt*ri.Populated_federal_register_citation_date_1_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_2_pcnt*ri.Populated_federal_register_citation_date_2_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_3_pcnt*ri.Populated_federal_register_citation_date_3_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_4_pcnt*ri.Populated_federal_register_citation_date_4_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_5_pcnt*ri.Populated_federal_register_citation_date_5_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_6_pcnt*ri.Populated_federal_register_citation_date_6_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_7_pcnt*ri.Populated_federal_register_citation_date_7_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_8_pcnt*ri.Populated_federal_register_citation_date_8_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_9_pcnt*ri.Populated_federal_register_citation_date_9_pcnt *   0.00 / 10000 + le.Populated_federal_register_citation_date_10_pcnt*ri.Populated_federal_register_citation_date_10_pcnt *   0.00 / 10000 + le.Populated_license_requirement_pcnt*ri.Populated_license_requirement_pcnt *   0.00 / 10000 + le.Populated_license_review_policy_pcnt*ri.Populated_license_review_policy_pcnt *   0.00 / 10000 + le.Populated_subordinate_status_pcnt*ri.Populated_subordinate_status_pcnt *   0.00 / 10000 + le.Populated_height_pcnt*ri.Populated_height_pcnt *   0.00 / 10000 + le.Populated_weight_pcnt*ri.Populated_weight_pcnt *   0.00 / 10000 + le.Populated_physique_pcnt*ri.Populated_physique_pcnt *   0.00 / 10000 + le.Populated_hair_color_pcnt*ri.Populated_hair_color_pcnt *   0.00 / 10000 + le.Populated_eyes_pcnt*ri.Populated_eyes_pcnt *   0.00 / 10000 + le.Populated_complexion_pcnt*ri.Populated_complexion_pcnt *   0.00 / 10000 + le.Populated_race_pcnt*ri.Populated_race_pcnt *   0.00 / 10000 + le.Populated_scars_marks_pcnt*ri.Populated_scars_marks_pcnt *   0.00 / 10000 + le.Populated_photo_file_pcnt*ri.Populated_photo_file_pcnt *   0.00 / 10000 + le.Populated_offenses_pcnt*ri.Populated_offenses_pcnt *   0.00 / 10000 + le.Populated_ncic_pcnt*ri.Populated_ncic_pcnt *   0.00 / 10000 + le.Populated_warrant_by_pcnt*ri.Populated_warrant_by_pcnt *   0.00 / 10000 + le.Populated_caution_pcnt*ri.Populated_caution_pcnt *   0.00 / 10000 + le.Populated_reward_pcnt*ri.Populated_reward_pcnt *   0.00 / 10000 + le.Populated_type_of_denial_pcnt*ri.Populated_type_of_denial_pcnt *   0.00 / 10000 + le.Populated_linked_with_1_pcnt*ri.Populated_linked_with_1_pcnt *   0.00 / 10000 + le.Populated_linked_with_2_pcnt*ri.Populated_linked_with_2_pcnt *   0.00 / 10000 + le.Populated_linked_with_3_pcnt*ri.Populated_linked_with_3_pcnt *   0.00 / 10000 + le.Populated_linked_with_4_pcnt*ri.Populated_linked_with_4_pcnt *   0.00 / 10000 + le.Populated_linked_with_5_pcnt*ri.Populated_linked_with_5_pcnt *   0.00 / 10000 + le.Populated_linked_with_6_pcnt*ri.Populated_linked_with_6_pcnt *   0.00 / 10000 + le.Populated_linked_with_7_pcnt*ri.Populated_linked_with_7_pcnt *   0.00 / 10000 + le.Populated_linked_with_8_pcnt*ri.Populated_linked_with_8_pcnt *   0.00 / 10000 + le.Populated_linked_with_9_pcnt*ri.Populated_linked_with_9_pcnt *   0.00 / 10000 + le.Populated_linked_with_10_pcnt*ri.Populated_linked_with_10_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_1_pcnt*ri.Populated_linked_with_id_1_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_2_pcnt*ri.Populated_linked_with_id_2_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_3_pcnt*ri.Populated_linked_with_id_3_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_4_pcnt*ri.Populated_linked_with_id_4_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_5_pcnt*ri.Populated_linked_with_id_5_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_6_pcnt*ri.Populated_linked_with_id_6_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_7_pcnt*ri.Populated_linked_with_id_7_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_8_pcnt*ri.Populated_linked_with_id_8_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_9_pcnt*ri.Populated_linked_with_id_9_pcnt *   0.00 / 10000 + le.Populated_linked_with_id_10_pcnt*ri.Populated_linked_with_id_10_pcnt *   0.00 / 10000 + le.Populated_listing_information_pcnt*ri.Populated_listing_information_pcnt *   0.00 / 10000 + le.Populated_foreign_principal_pcnt*ri.Populated_foreign_principal_pcnt *   0.00 / 10000 + le.Populated_nature_of_service_pcnt*ri.Populated_nature_of_service_pcnt *   0.00 / 10000 + le.Populated_activities_pcnt*ri.Populated_activities_pcnt *   0.00 / 10000 + le.Populated_finances_pcnt*ri.Populated_finances_pcnt *   0.00 / 10000 + le.Populated_registrant_terminated_flag_pcnt*ri.Populated_registrant_terminated_flag_pcnt *   0.00 / 10000 + le.Populated_foreign_principal_terminated_flag_pcnt*ri.Populated_foreign_principal_terminated_flag_pcnt *   0.00 / 10000 + le.Populated_short_form_terminated_flag_pcnt*ri.Populated_short_form_terminated_flag_pcnt *   0.00 / 10000 + le.Populated_src_key_pcnt*ri.Populated_src_key_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'pty_key','source','orig_pty_name','orig_vessel_name','country','name_type','addr_1','addr_2','addr_3','addr_4','addr_5','addr_6','addr_7','addr_8','addr_9','addr_10','remarks_1','remarks_2','remarks_3','remarks_4','remarks_5','remarks_6','remarks_7','remarks_8','remarks_9','remarks_10','remarks_11','remarks_12','remarks_13','remarks_14','remarks_15','remarks_16','remarks_17','remarks_18','remarks_19','remarks_20','remarks_21','remarks_22','remarks_23','remarks_24','remarks_25','remarks_26','remarks_27','remarks_28','remarks_29','remarks_30','cname','title','fname','mname','lname','suffix','a_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','entity_id','first_name','last_name','title_1','title_2','title_3','title_4','title_5','title_6','title_7','title_8','title_9','title_10','aka_id','aka_type','aka_category','giv_designator','entity_type','address_id','address_line_1','address_line_2','address_line_3','address_city','address_state_province','address_postal_code','address_country','remarks','call_sign','vessel_type','tonnage','gross_registered_tonnage','vessel_flag','vessel_owner','sanctions_program_1','sanctions_program_2','sanctions_program_3','sanctions_program_4','sanctions_program_5','sanctions_program_6','sanctions_program_7','sanctions_program_8','sanctions_program_9','sanctions_program_10','passport_details','ni_number_details','id_id_1','id_id_2','id_id_3','id_id_4','id_id_5','id_id_6','id_id_7','id_id_8','id_id_9','id_id_10','id_type_1','id_type_2','id_type_3','id_type_4','id_type_5','id_type_6','id_type_7','id_type_8','id_type_9','id_type_10','id_number_1','id_number_2','id_number_3','id_number_4','id_number_5','id_number_6','id_number_7','id_number_8','id_number_9','id_number_10','id_country_1','id_country_2','id_country_3','id_country_4','id_country_5','id_country_6','id_country_7','id_country_8','id_country_9','id_country_10','id_issue_date_1','id_issue_date_2','id_issue_date_3','id_issue_date_4','id_issue_date_5','id_issue_date_6','id_issue_date_7','id_issue_date_8','id_issue_date_9','id_issue_date_10','id_expiration_date_1','id_expiration_date_2','id_expiration_date_3','id_expiration_date_4','id_expiration_date_5','id_expiration_date_6','id_expiration_date_7','id_expiration_date_8','id_expiration_date_9','id_expiration_date_10','nationality_id_1','nationality_id_2','nationality_id_3','nationality_id_4','nationality_id_5','nationality_id_6','nationality_id_7','nationality_id_8','nationality_id_9','nationality_id_10','nationality_1','nationality_2','nationality_3','nationality_4','nationality_5','nationality_6','nationality_7','nationality_8','nationality_9','nationality_10','primary_nationality_flag_1','primary_nationality_flag_2','primary_nationality_flag_3','primary_nationality_flag_4','primary_nationality_flag_5','primary_nationality_flag_6','primary_nationality_flag_7','primary_nationality_flag_8','primary_nationality_flag_9','primary_nationality_flag_10','citizenship_id_1','citizenship_id_2','citizenship_id_3','citizenship_id_4','citizenship_id_5','citizenship_id_6','citizenship_id_7','citizenship_id_8','citizenship_id_9','citizenship_id_10','citizenship_1','citizenship_2','citizenship_3','citizenship_4','citizenship_5','citizenship_6','citizenship_7','citizenship_8','citizenship_9','citizenship_10','primary_citizenship_flag_1','primary_citizenship_flag_2','primary_citizenship_flag_3','primary_citizenship_flag_4','primary_citizenship_flag_5','primary_citizenship_flag_6','primary_citizenship_flag_7','primary_citizenship_flag_8','primary_citizenship_flag_9','primary_citizenship_flag_10','dob_id_1','dob_id_2','dob_id_3','dob_id_4','dob_id_5','dob_id_6','dob_id_7','dob_id_8','dob_id_9','dob_id_10','dob_1','dob_2','dob_3','dob_4','dob_5','dob_6','dob_7','dob_8','dob_9','dob_10','primary_dob_flag_1','primary_dob_flag_2','primary_dob_flag_3','primary_dob_flag_4','primary_dob_flag_5','primary_dob_flag_6','primary_dob_flag_7','primary_dob_flag_8','primary_dob_flag_9','primary_dob_flag_10','pob_id_1','pob_id_2','pob_id_3','pob_id_4','pob_id_5','pob_id_6','pob_id_7','pob_id_8','pob_id_9','pob_id_10','pob_1','pob_2','pob_3','pob_4','pob_5','pob_6','pob_7','pob_8','pob_9','pob_10','country_of_birth_1','country_of_birth_2','country_of_birth_3','country_of_birth_4','country_of_birth_5','country_of_birth_6','country_of_birth_7','country_of_birth_8','country_of_birth_9','country_of_birth_10','primary_pob_flag_1','primary_pob_flag_2','primary_pob_flag_3','primary_pob_flag_4','primary_pob_flag_5','primary_pob_flag_6','primary_pob_flag_7','primary_pob_flag_8','primary_pob_flag_9','primary_pob_flag_10','language_1','language_2','language_3','language_4','language_5','language_6','language_7','language_8','language_9','language_10','membership_1','membership_2','membership_3','membership_4','membership_5','membership_6','membership_7','membership_8','membership_9','membership_10','position_1','position_2','position_3','position_4','position_5','position_6','position_7','position_8','position_9','position_10','occupation_1','occupation_2','occupation_3','occupation_4','occupation_5','occupation_6','occupation_7','occupation_8','occupation_9','occupation_10','date_added_to_list','date_last_updated','effective_date','expiration_date','gender','grounds','subj_to_common_pos_2001_931_cfsp_fl','federal_register_citation_1','federal_register_citation_2','federal_register_citation_3','federal_register_citation_4','federal_register_citation_5','federal_register_citation_6','federal_register_citation_7','federal_register_citation_8','federal_register_citation_9','federal_register_citation_10','federal_register_citation_date_1','federal_register_citation_date_2','federal_register_citation_date_3','federal_register_citation_date_4','federal_register_citation_date_5','federal_register_citation_date_6','federal_register_citation_date_7','federal_register_citation_date_8','federal_register_citation_date_9','federal_register_citation_date_10','license_requirement','license_review_policy','subordinate_status','height','weight','physique','hair_color','eyes','complexion','race','scars_marks','photo_file','offenses','ncic','warrant_by','caution','reward','type_of_denial','linked_with_1','linked_with_2','linked_with_3','linked_with_4','linked_with_5','linked_with_6','linked_with_7','linked_with_8','linked_with_9','linked_with_10','linked_with_id_1','linked_with_id_2','linked_with_id_3','linked_with_id_4','linked_with_id_5','linked_with_id_6','linked_with_id_7','linked_with_id_8','linked_with_id_9','linked_with_id_10','listing_information','foreign_principal','nature_of_service','activities','finances','registrant_terminated_flag','foreign_principal_terminated_flag','short_form_terminated_flag','src_key');
  SELF.populated_pcnt := CHOOSE(C,le.populated_pty_key_pcnt,le.populated_source_pcnt,le.populated_orig_pty_name_pcnt,le.populated_orig_vessel_name_pcnt,le.populated_country_pcnt,le.populated_name_type_pcnt,le.populated_addr_1_pcnt,le.populated_addr_2_pcnt,le.populated_addr_3_pcnt,le.populated_addr_4_pcnt,le.populated_addr_5_pcnt,le.populated_addr_6_pcnt,le.populated_addr_7_pcnt,le.populated_addr_8_pcnt,le.populated_addr_9_pcnt,le.populated_addr_10_pcnt,le.populated_remarks_1_pcnt,le.populated_remarks_2_pcnt,le.populated_remarks_3_pcnt,le.populated_remarks_4_pcnt,le.populated_remarks_5_pcnt,le.populated_remarks_6_pcnt,le.populated_remarks_7_pcnt,le.populated_remarks_8_pcnt,le.populated_remarks_9_pcnt,le.populated_remarks_10_pcnt,le.populated_remarks_11_pcnt,le.populated_remarks_12_pcnt,le.populated_remarks_13_pcnt,le.populated_remarks_14_pcnt,le.populated_remarks_15_pcnt,le.populated_remarks_16_pcnt,le.populated_remarks_17_pcnt,le.populated_remarks_18_pcnt,le.populated_remarks_19_pcnt,le.populated_remarks_20_pcnt,le.populated_remarks_21_pcnt,le.populated_remarks_22_pcnt,le.populated_remarks_23_pcnt,le.populated_remarks_24_pcnt,le.populated_remarks_25_pcnt,le.populated_remarks_26_pcnt,le.populated_remarks_27_pcnt,le.populated_remarks_28_pcnt,le.populated_remarks_29_pcnt,le.populated_remarks_30_pcnt,le.populated_cname_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_suffix_pcnt,le.populated_a_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_record_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_entity_id_pcnt,le.populated_first_name_pcnt,le.populated_last_name_pcnt,le.populated_title_1_pcnt,le.populated_title_2_pcnt,le.populated_title_3_pcnt,le.populated_title_4_pcnt,le.populated_title_5_pcnt,le.populated_title_6_pcnt,le.populated_title_7_pcnt,le.populated_title_8_pcnt,le.populated_title_9_pcnt,le.populated_title_10_pcnt,le.populated_aka_id_pcnt,le.populated_aka_type_pcnt,le.populated_aka_category_pcnt,le.populated_giv_designator_pcnt,le.populated_entity_type_pcnt,le.populated_address_id_pcnt,le.populated_address_line_1_pcnt,le.populated_address_line_2_pcnt,le.populated_address_line_3_pcnt,le.populated_address_city_pcnt,le.populated_address_state_province_pcnt,le.populated_address_postal_code_pcnt,le.populated_address_country_pcnt,le.populated_remarks_pcnt,le.populated_call_sign_pcnt,le.populated_vessel_type_pcnt,le.populated_tonnage_pcnt,le.populated_gross_registered_tonnage_pcnt,le.populated_vessel_flag_pcnt,le.populated_vessel_owner_pcnt,le.populated_sanctions_program_1_pcnt,le.populated_sanctions_program_2_pcnt,le.populated_sanctions_program_3_pcnt,le.populated_sanctions_program_4_pcnt,le.populated_sanctions_program_5_pcnt,le.populated_sanctions_program_6_pcnt,le.populated_sanctions_program_7_pcnt,le.populated_sanctions_program_8_pcnt,le.populated_sanctions_program_9_pcnt,le.populated_sanctions_program_10_pcnt,le.populated_passport_details_pcnt,le.populated_ni_number_details_pcnt,le.populated_id_id_1_pcnt,le.populated_id_id_2_pcnt,le.populated_id_id_3_pcnt,le.populated_id_id_4_pcnt,le.populated_id_id_5_pcnt,le.populated_id_id_6_pcnt,le.populated_id_id_7_pcnt,le.populated_id_id_8_pcnt,le.populated_id_id_9_pcnt,le.populated_id_id_10_pcnt,le.populated_id_type_1_pcnt,le.populated_id_type_2_pcnt,le.populated_id_type_3_pcnt,le.populated_id_type_4_pcnt,le.populated_id_type_5_pcnt,le.populated_id_type_6_pcnt,le.populated_id_type_7_pcnt,le.populated_id_type_8_pcnt,le.populated_id_type_9_pcnt,le.populated_id_type_10_pcnt,le.populated_id_number_1_pcnt,le.populated_id_number_2_pcnt,le.populated_id_number_3_pcnt,le.populated_id_number_4_pcnt,le.populated_id_number_5_pcnt,le.populated_id_number_6_pcnt,le.populated_id_number_7_pcnt,le.populated_id_number_8_pcnt,le.populated_id_number_9_pcnt,le.populated_id_number_10_pcnt,le.populated_id_country_1_pcnt,le.populated_id_country_2_pcnt,le.populated_id_country_3_pcnt,le.populated_id_country_4_pcnt,le.populated_id_country_5_pcnt,le.populated_id_country_6_pcnt,le.populated_id_country_7_pcnt,le.populated_id_country_8_pcnt,le.populated_id_country_9_pcnt,le.populated_id_country_10_pcnt,le.populated_id_issue_date_1_pcnt,le.populated_id_issue_date_2_pcnt,le.populated_id_issue_date_3_pcnt,le.populated_id_issue_date_4_pcnt,le.populated_id_issue_date_5_pcnt,le.populated_id_issue_date_6_pcnt,le.populated_id_issue_date_7_pcnt,le.populated_id_issue_date_8_pcnt,le.populated_id_issue_date_9_pcnt,le.populated_id_issue_date_10_pcnt,le.populated_id_expiration_date_1_pcnt,le.populated_id_expiration_date_2_pcnt,le.populated_id_expiration_date_3_pcnt,le.populated_id_expiration_date_4_pcnt,le.populated_id_expiration_date_5_pcnt,le.populated_id_expiration_date_6_pcnt,le.populated_id_expiration_date_7_pcnt,le.populated_id_expiration_date_8_pcnt,le.populated_id_expiration_date_9_pcnt,le.populated_id_expiration_date_10_pcnt,le.populated_nationality_id_1_pcnt,le.populated_nationality_id_2_pcnt,le.populated_nationality_id_3_pcnt,le.populated_nationality_id_4_pcnt,le.populated_nationality_id_5_pcnt,le.populated_nationality_id_6_pcnt,le.populated_nationality_id_7_pcnt,le.populated_nationality_id_8_pcnt,le.populated_nationality_id_9_pcnt,le.populated_nationality_id_10_pcnt,le.populated_nationality_1_pcnt,le.populated_nationality_2_pcnt,le.populated_nationality_3_pcnt,le.populated_nationality_4_pcnt,le.populated_nationality_5_pcnt,le.populated_nationality_6_pcnt,le.populated_nationality_7_pcnt,le.populated_nationality_8_pcnt,le.populated_nationality_9_pcnt,le.populated_nationality_10_pcnt,le.populated_primary_nationality_flag_1_pcnt,le.populated_primary_nationality_flag_2_pcnt,le.populated_primary_nationality_flag_3_pcnt,le.populated_primary_nationality_flag_4_pcnt,le.populated_primary_nationality_flag_5_pcnt,le.populated_primary_nationality_flag_6_pcnt,le.populated_primary_nationality_flag_7_pcnt,le.populated_primary_nationality_flag_8_pcnt,le.populated_primary_nationality_flag_9_pcnt,le.populated_primary_nationality_flag_10_pcnt,le.populated_citizenship_id_1_pcnt,le.populated_citizenship_id_2_pcnt,le.populated_citizenship_id_3_pcnt,le.populated_citizenship_id_4_pcnt,le.populated_citizenship_id_5_pcnt,le.populated_citizenship_id_6_pcnt,le.populated_citizenship_id_7_pcnt,le.populated_citizenship_id_8_pcnt,le.populated_citizenship_id_9_pcnt,le.populated_citizenship_id_10_pcnt,le.populated_citizenship_1_pcnt,le.populated_citizenship_2_pcnt,le.populated_citizenship_3_pcnt,le.populated_citizenship_4_pcnt,le.populated_citizenship_5_pcnt,le.populated_citizenship_6_pcnt,le.populated_citizenship_7_pcnt,le.populated_citizenship_8_pcnt,le.populated_citizenship_9_pcnt,le.populated_citizenship_10_pcnt,le.populated_primary_citizenship_flag_1_pcnt,le.populated_primary_citizenship_flag_2_pcnt,le.populated_primary_citizenship_flag_3_pcnt,le.populated_primary_citizenship_flag_4_pcnt,le.populated_primary_citizenship_flag_5_pcnt,le.populated_primary_citizenship_flag_6_pcnt,le.populated_primary_citizenship_flag_7_pcnt,le.populated_primary_citizenship_flag_8_pcnt,le.populated_primary_citizenship_flag_9_pcnt,le.populated_primary_citizenship_flag_10_pcnt,le.populated_dob_id_1_pcnt,le.populated_dob_id_2_pcnt,le.populated_dob_id_3_pcnt,le.populated_dob_id_4_pcnt,le.populated_dob_id_5_pcnt,le.populated_dob_id_6_pcnt,le.populated_dob_id_7_pcnt,le.populated_dob_id_8_pcnt,le.populated_dob_id_9_pcnt,le.populated_dob_id_10_pcnt,le.populated_dob_1_pcnt,le.populated_dob_2_pcnt,le.populated_dob_3_pcnt,le.populated_dob_4_pcnt,le.populated_dob_5_pcnt,le.populated_dob_6_pcnt,le.populated_dob_7_pcnt,le.populated_dob_8_pcnt,le.populated_dob_9_pcnt,le.populated_dob_10_pcnt,le.populated_primary_dob_flag_1_pcnt,le.populated_primary_dob_flag_2_pcnt,le.populated_primary_dob_flag_3_pcnt,le.populated_primary_dob_flag_4_pcnt,le.populated_primary_dob_flag_5_pcnt,le.populated_primary_dob_flag_6_pcnt,le.populated_primary_dob_flag_7_pcnt,le.populated_primary_dob_flag_8_pcnt,le.populated_primary_dob_flag_9_pcnt,le.populated_primary_dob_flag_10_pcnt,le.populated_pob_id_1_pcnt,le.populated_pob_id_2_pcnt,le.populated_pob_id_3_pcnt,le.populated_pob_id_4_pcnt,le.populated_pob_id_5_pcnt,le.populated_pob_id_6_pcnt,le.populated_pob_id_7_pcnt,le.populated_pob_id_8_pcnt,le.populated_pob_id_9_pcnt,le.populated_pob_id_10_pcnt,le.populated_pob_1_pcnt,le.populated_pob_2_pcnt,le.populated_pob_3_pcnt,le.populated_pob_4_pcnt,le.populated_pob_5_pcnt,le.populated_pob_6_pcnt,le.populated_pob_7_pcnt,le.populated_pob_8_pcnt,le.populated_pob_9_pcnt,le.populated_pob_10_pcnt,le.populated_country_of_birth_1_pcnt,le.populated_country_of_birth_2_pcnt,le.populated_country_of_birth_3_pcnt,le.populated_country_of_birth_4_pcnt,le.populated_country_of_birth_5_pcnt,le.populated_country_of_birth_6_pcnt,le.populated_country_of_birth_7_pcnt,le.populated_country_of_birth_8_pcnt,le.populated_country_of_birth_9_pcnt,le.populated_country_of_birth_10_pcnt,le.populated_primary_pob_flag_1_pcnt,le.populated_primary_pob_flag_2_pcnt,le.populated_primary_pob_flag_3_pcnt,le.populated_primary_pob_flag_4_pcnt,le.populated_primary_pob_flag_5_pcnt,le.populated_primary_pob_flag_6_pcnt,le.populated_primary_pob_flag_7_pcnt,le.populated_primary_pob_flag_8_pcnt,le.populated_primary_pob_flag_9_pcnt,le.populated_primary_pob_flag_10_pcnt,le.populated_language_1_pcnt,le.populated_language_2_pcnt,le.populated_language_3_pcnt,le.populated_language_4_pcnt,le.populated_language_5_pcnt,le.populated_language_6_pcnt,le.populated_language_7_pcnt,le.populated_language_8_pcnt,le.populated_language_9_pcnt,le.populated_language_10_pcnt,le.populated_membership_1_pcnt,le.populated_membership_2_pcnt,le.populated_membership_3_pcnt,le.populated_membership_4_pcnt,le.populated_membership_5_pcnt,le.populated_membership_6_pcnt,le.populated_membership_7_pcnt,le.populated_membership_8_pcnt,le.populated_membership_9_pcnt,le.populated_membership_10_pcnt,le.populated_position_1_pcnt,le.populated_position_2_pcnt,le.populated_position_3_pcnt,le.populated_position_4_pcnt,le.populated_position_5_pcnt,le.populated_position_6_pcnt,le.populated_position_7_pcnt,le.populated_position_8_pcnt,le.populated_position_9_pcnt,le.populated_position_10_pcnt,le.populated_occupation_1_pcnt,le.populated_occupation_2_pcnt,le.populated_occupation_3_pcnt,le.populated_occupation_4_pcnt,le.populated_occupation_5_pcnt,le.populated_occupation_6_pcnt,le.populated_occupation_7_pcnt,le.populated_occupation_8_pcnt,le.populated_occupation_9_pcnt,le.populated_occupation_10_pcnt,le.populated_date_added_to_list_pcnt,le.populated_date_last_updated_pcnt,le.populated_effective_date_pcnt,le.populated_expiration_date_pcnt,le.populated_gender_pcnt,le.populated_grounds_pcnt,le.populated_subj_to_common_pos_2001_931_cfsp_fl_pcnt,le.populated_federal_register_citation_1_pcnt,le.populated_federal_register_citation_2_pcnt,le.populated_federal_register_citation_3_pcnt,le.populated_federal_register_citation_4_pcnt,le.populated_federal_register_citation_5_pcnt,le.populated_federal_register_citation_6_pcnt,le.populated_federal_register_citation_7_pcnt,le.populated_federal_register_citation_8_pcnt,le.populated_federal_register_citation_9_pcnt,le.populated_federal_register_citation_10_pcnt,le.populated_federal_register_citation_date_1_pcnt,le.populated_federal_register_citation_date_2_pcnt,le.populated_federal_register_citation_date_3_pcnt,le.populated_federal_register_citation_date_4_pcnt,le.populated_federal_register_citation_date_5_pcnt,le.populated_federal_register_citation_date_6_pcnt,le.populated_federal_register_citation_date_7_pcnt,le.populated_federal_register_citation_date_8_pcnt,le.populated_federal_register_citation_date_9_pcnt,le.populated_federal_register_citation_date_10_pcnt,le.populated_license_requirement_pcnt,le.populated_license_review_policy_pcnt,le.populated_subordinate_status_pcnt,le.populated_height_pcnt,le.populated_weight_pcnt,le.populated_physique_pcnt,le.populated_hair_color_pcnt,le.populated_eyes_pcnt,le.populated_complexion_pcnt,le.populated_race_pcnt,le.populated_scars_marks_pcnt,le.populated_photo_file_pcnt,le.populated_offenses_pcnt,le.populated_ncic_pcnt,le.populated_warrant_by_pcnt,le.populated_caution_pcnt,le.populated_reward_pcnt,le.populated_type_of_denial_pcnt,le.populated_linked_with_1_pcnt,le.populated_linked_with_2_pcnt,le.populated_linked_with_3_pcnt,le.populated_linked_with_4_pcnt,le.populated_linked_with_5_pcnt,le.populated_linked_with_6_pcnt,le.populated_linked_with_7_pcnt,le.populated_linked_with_8_pcnt,le.populated_linked_with_9_pcnt,le.populated_linked_with_10_pcnt,le.populated_linked_with_id_1_pcnt,le.populated_linked_with_id_2_pcnt,le.populated_linked_with_id_3_pcnt,le.populated_linked_with_id_4_pcnt,le.populated_linked_with_id_5_pcnt,le.populated_linked_with_id_6_pcnt,le.populated_linked_with_id_7_pcnt,le.populated_linked_with_id_8_pcnt,le.populated_linked_with_id_9_pcnt,le.populated_linked_with_id_10_pcnt,le.populated_listing_information_pcnt,le.populated_foreign_principal_pcnt,le.populated_nature_of_service_pcnt,le.populated_activities_pcnt,le.populated_finances_pcnt,le.populated_registrant_terminated_flag_pcnt,le.populated_foreign_principal_terminated_flag_pcnt,le.populated_short_form_terminated_flag_pcnt,le.populated_src_key_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_pty_key,le.maxlength_source,le.maxlength_orig_pty_name,le.maxlength_orig_vessel_name,le.maxlength_country,le.maxlength_name_type,le.maxlength_addr_1,le.maxlength_addr_2,le.maxlength_addr_3,le.maxlength_addr_4,le.maxlength_addr_5,le.maxlength_addr_6,le.maxlength_addr_7,le.maxlength_addr_8,le.maxlength_addr_9,le.maxlength_addr_10,le.maxlength_remarks_1,le.maxlength_remarks_2,le.maxlength_remarks_3,le.maxlength_remarks_4,le.maxlength_remarks_5,le.maxlength_remarks_6,le.maxlength_remarks_7,le.maxlength_remarks_8,le.maxlength_remarks_9,le.maxlength_remarks_10,le.maxlength_remarks_11,le.maxlength_remarks_12,le.maxlength_remarks_13,le.maxlength_remarks_14,le.maxlength_remarks_15,le.maxlength_remarks_16,le.maxlength_remarks_17,le.maxlength_remarks_18,le.maxlength_remarks_19,le.maxlength_remarks_20,le.maxlength_remarks_21,le.maxlength_remarks_22,le.maxlength_remarks_23,le.maxlength_remarks_24,le.maxlength_remarks_25,le.maxlength_remarks_26,le.maxlength_remarks_27,le.maxlength_remarks_28,le.maxlength_remarks_29,le.maxlength_remarks_30,le.maxlength_cname,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_suffix,le.maxlength_a_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_record_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_entity_id,le.maxlength_first_name,le.maxlength_last_name,le.maxlength_title_1,le.maxlength_title_2,le.maxlength_title_3,le.maxlength_title_4,le.maxlength_title_5,le.maxlength_title_6,le.maxlength_title_7,le.maxlength_title_8,le.maxlength_title_9,le.maxlength_title_10,le.maxlength_aka_id,le.maxlength_aka_type,le.maxlength_aka_category,le.maxlength_giv_designator,le.maxlength_entity_type,le.maxlength_address_id,le.maxlength_address_line_1,le.maxlength_address_line_2,le.maxlength_address_line_3,le.maxlength_address_city,le.maxlength_address_state_province,le.maxlength_address_postal_code,le.maxlength_address_country,le.maxlength_remarks,le.maxlength_call_sign,le.maxlength_vessel_type,le.maxlength_tonnage,le.maxlength_gross_registered_tonnage,le.maxlength_vessel_flag,le.maxlength_vessel_owner,le.maxlength_sanctions_program_1,le.maxlength_sanctions_program_2,le.maxlength_sanctions_program_3,le.maxlength_sanctions_program_4,le.maxlength_sanctions_program_5,le.maxlength_sanctions_program_6,le.maxlength_sanctions_program_7,le.maxlength_sanctions_program_8,le.maxlength_sanctions_program_9,le.maxlength_sanctions_program_10,le.maxlength_passport_details,le.maxlength_ni_number_details,le.maxlength_id_id_1,le.maxlength_id_id_2,le.maxlength_id_id_3,le.maxlength_id_id_4,le.maxlength_id_id_5,le.maxlength_id_id_6,le.maxlength_id_id_7,le.maxlength_id_id_8,le.maxlength_id_id_9,le.maxlength_id_id_10,le.maxlength_id_type_1,le.maxlength_id_type_2,le.maxlength_id_type_3,le.maxlength_id_type_4,le.maxlength_id_type_5,le.maxlength_id_type_6,le.maxlength_id_type_7,le.maxlength_id_type_8,le.maxlength_id_type_9,le.maxlength_id_type_10,le.maxlength_id_number_1,le.maxlength_id_number_2,le.maxlength_id_number_3,le.maxlength_id_number_4,le.maxlength_id_number_5,le.maxlength_id_number_6,le.maxlength_id_number_7,le.maxlength_id_number_8,le.maxlength_id_number_9,le.maxlength_id_number_10,le.maxlength_id_country_1,le.maxlength_id_country_2,le.maxlength_id_country_3,le.maxlength_id_country_4,le.maxlength_id_country_5,le.maxlength_id_country_6,le.maxlength_id_country_7,le.maxlength_id_country_8,le.maxlength_id_country_9,le.maxlength_id_country_10,le.maxlength_id_issue_date_1,le.maxlength_id_issue_date_2,le.maxlength_id_issue_date_3,le.maxlength_id_issue_date_4,le.maxlength_id_issue_date_5,le.maxlength_id_issue_date_6,le.maxlength_id_issue_date_7,le.maxlength_id_issue_date_8,le.maxlength_id_issue_date_9,le.maxlength_id_issue_date_10,le.maxlength_id_expiration_date_1,le.maxlength_id_expiration_date_2,le.maxlength_id_expiration_date_3,le.maxlength_id_expiration_date_4,le.maxlength_id_expiration_date_5,le.maxlength_id_expiration_date_6,le.maxlength_id_expiration_date_7,le.maxlength_id_expiration_date_8,le.maxlength_id_expiration_date_9,le.maxlength_id_expiration_date_10,le.maxlength_nationality_id_1,le.maxlength_nationality_id_2,le.maxlength_nationality_id_3,le.maxlength_nationality_id_4,le.maxlength_nationality_id_5,le.maxlength_nationality_id_6,le.maxlength_nationality_id_7,le.maxlength_nationality_id_8,le.maxlength_nationality_id_9,le.maxlength_nationality_id_10,le.maxlength_nationality_1,le.maxlength_nationality_2,le.maxlength_nationality_3,le.maxlength_nationality_4,le.maxlength_nationality_5,le.maxlength_nationality_6,le.maxlength_nationality_7,le.maxlength_nationality_8,le.maxlength_nationality_9,le.maxlength_nationality_10,le.maxlength_primary_nationality_flag_1,le.maxlength_primary_nationality_flag_2,le.maxlength_primary_nationality_flag_3,le.maxlength_primary_nationality_flag_4,le.maxlength_primary_nationality_flag_5,le.maxlength_primary_nationality_flag_6,le.maxlength_primary_nationality_flag_7,le.maxlength_primary_nationality_flag_8,le.maxlength_primary_nationality_flag_9,le.maxlength_primary_nationality_flag_10,le.maxlength_citizenship_id_1,le.maxlength_citizenship_id_2,le.maxlength_citizenship_id_3,le.maxlength_citizenship_id_4,le.maxlength_citizenship_id_5,le.maxlength_citizenship_id_6,le.maxlength_citizenship_id_7,le.maxlength_citizenship_id_8,le.maxlength_citizenship_id_9,le.maxlength_citizenship_id_10,le.maxlength_citizenship_1,le.maxlength_citizenship_2,le.maxlength_citizenship_3,le.maxlength_citizenship_4,le.maxlength_citizenship_5,le.maxlength_citizenship_6,le.maxlength_citizenship_7,le.maxlength_citizenship_8,le.maxlength_citizenship_9,le.maxlength_citizenship_10,le.maxlength_primary_citizenship_flag_1,le.maxlength_primary_citizenship_flag_2,le.maxlength_primary_citizenship_flag_3,le.maxlength_primary_citizenship_flag_4,le.maxlength_primary_citizenship_flag_5,le.maxlength_primary_citizenship_flag_6,le.maxlength_primary_citizenship_flag_7,le.maxlength_primary_citizenship_flag_8,le.maxlength_primary_citizenship_flag_9,le.maxlength_primary_citizenship_flag_10,le.maxlength_dob_id_1,le.maxlength_dob_id_2,le.maxlength_dob_id_3,le.maxlength_dob_id_4,le.maxlength_dob_id_5,le.maxlength_dob_id_6,le.maxlength_dob_id_7,le.maxlength_dob_id_8,le.maxlength_dob_id_9,le.maxlength_dob_id_10,le.maxlength_dob_1,le.maxlength_dob_2,le.maxlength_dob_3,le.maxlength_dob_4,le.maxlength_dob_5,le.maxlength_dob_6,le.maxlength_dob_7,le.maxlength_dob_8,le.maxlength_dob_9,le.maxlength_dob_10,le.maxlength_primary_dob_flag_1,le.maxlength_primary_dob_flag_2,le.maxlength_primary_dob_flag_3,le.maxlength_primary_dob_flag_4,le.maxlength_primary_dob_flag_5,le.maxlength_primary_dob_flag_6,le.maxlength_primary_dob_flag_7,le.maxlength_primary_dob_flag_8,le.maxlength_primary_dob_flag_9,le.maxlength_primary_dob_flag_10,le.maxlength_pob_id_1,le.maxlength_pob_id_2,le.maxlength_pob_id_3,le.maxlength_pob_id_4,le.maxlength_pob_id_5,le.maxlength_pob_id_6,le.maxlength_pob_id_7,le.maxlength_pob_id_8,le.maxlength_pob_id_9,le.maxlength_pob_id_10,le.maxlength_pob_1,le.maxlength_pob_2,le.maxlength_pob_3,le.maxlength_pob_4,le.maxlength_pob_5,le.maxlength_pob_6,le.maxlength_pob_7,le.maxlength_pob_8,le.maxlength_pob_9,le.maxlength_pob_10,le.maxlength_country_of_birth_1,le.maxlength_country_of_birth_2,le.maxlength_country_of_birth_3,le.maxlength_country_of_birth_4,le.maxlength_country_of_birth_5,le.maxlength_country_of_birth_6,le.maxlength_country_of_birth_7,le.maxlength_country_of_birth_8,le.maxlength_country_of_birth_9,le.maxlength_country_of_birth_10,le.maxlength_primary_pob_flag_1,le.maxlength_primary_pob_flag_2,le.maxlength_primary_pob_flag_3,le.maxlength_primary_pob_flag_4,le.maxlength_primary_pob_flag_5,le.maxlength_primary_pob_flag_6,le.maxlength_primary_pob_flag_7,le.maxlength_primary_pob_flag_8,le.maxlength_primary_pob_flag_9,le.maxlength_primary_pob_flag_10,le.maxlength_language_1,le.maxlength_language_2,le.maxlength_language_3,le.maxlength_language_4,le.maxlength_language_5,le.maxlength_language_6,le.maxlength_language_7,le.maxlength_language_8,le.maxlength_language_9,le.maxlength_language_10,le.maxlength_membership_1,le.maxlength_membership_2,le.maxlength_membership_3,le.maxlength_membership_4,le.maxlength_membership_5,le.maxlength_membership_6,le.maxlength_membership_7,le.maxlength_membership_8,le.maxlength_membership_9,le.maxlength_membership_10,le.maxlength_position_1,le.maxlength_position_2,le.maxlength_position_3,le.maxlength_position_4,le.maxlength_position_5,le.maxlength_position_6,le.maxlength_position_7,le.maxlength_position_8,le.maxlength_position_9,le.maxlength_position_10,le.maxlength_occupation_1,le.maxlength_occupation_2,le.maxlength_occupation_3,le.maxlength_occupation_4,le.maxlength_occupation_5,le.maxlength_occupation_6,le.maxlength_occupation_7,le.maxlength_occupation_8,le.maxlength_occupation_9,le.maxlength_occupation_10,le.maxlength_date_added_to_list,le.maxlength_date_last_updated,le.maxlength_effective_date,le.maxlength_expiration_date,le.maxlength_gender,le.maxlength_grounds,le.maxlength_subj_to_common_pos_2001_931_cfsp_fl,le.maxlength_federal_register_citation_1,le.maxlength_federal_register_citation_2,le.maxlength_federal_register_citation_3,le.maxlength_federal_register_citation_4,le.maxlength_federal_register_citation_5,le.maxlength_federal_register_citation_6,le.maxlength_federal_register_citation_7,le.maxlength_federal_register_citation_8,le.maxlength_federal_register_citation_9,le.maxlength_federal_register_citation_10,le.maxlength_federal_register_citation_date_1,le.maxlength_federal_register_citation_date_2,le.maxlength_federal_register_citation_date_3,le.maxlength_federal_register_citation_date_4,le.maxlength_federal_register_citation_date_5,le.maxlength_federal_register_citation_date_6,le.maxlength_federal_register_citation_date_7,le.maxlength_federal_register_citation_date_8,le.maxlength_federal_register_citation_date_9,le.maxlength_federal_register_citation_date_10,le.maxlength_license_requirement,le.maxlength_license_review_policy,le.maxlength_subordinate_status,le.maxlength_height,le.maxlength_weight,le.maxlength_physique,le.maxlength_hair_color,le.maxlength_eyes,le.maxlength_complexion,le.maxlength_race,le.maxlength_scars_marks,le.maxlength_photo_file,le.maxlength_offenses,le.maxlength_ncic,le.maxlength_warrant_by,le.maxlength_caution,le.maxlength_reward,le.maxlength_type_of_denial,le.maxlength_linked_with_1,le.maxlength_linked_with_2,le.maxlength_linked_with_3,le.maxlength_linked_with_4,le.maxlength_linked_with_5,le.maxlength_linked_with_6,le.maxlength_linked_with_7,le.maxlength_linked_with_8,le.maxlength_linked_with_9,le.maxlength_linked_with_10,le.maxlength_linked_with_id_1,le.maxlength_linked_with_id_2,le.maxlength_linked_with_id_3,le.maxlength_linked_with_id_4,le.maxlength_linked_with_id_5,le.maxlength_linked_with_id_6,le.maxlength_linked_with_id_7,le.maxlength_linked_with_id_8,le.maxlength_linked_with_id_9,le.maxlength_linked_with_id_10,le.maxlength_listing_information,le.maxlength_foreign_principal,le.maxlength_nature_of_service,le.maxlength_activities,le.maxlength_finances,le.maxlength_registrant_terminated_flag,le.maxlength_foreign_principal_terminated_flag,le.maxlength_short_form_terminated_flag,le.maxlength_src_key);
  SELF.avelength := CHOOSE(C,le.avelength_pty_key,le.avelength_source,le.avelength_orig_pty_name,le.avelength_orig_vessel_name,le.avelength_country,le.avelength_name_type,le.avelength_addr_1,le.avelength_addr_2,le.avelength_addr_3,le.avelength_addr_4,le.avelength_addr_5,le.avelength_addr_6,le.avelength_addr_7,le.avelength_addr_8,le.avelength_addr_9,le.avelength_addr_10,le.avelength_remarks_1,le.avelength_remarks_2,le.avelength_remarks_3,le.avelength_remarks_4,le.avelength_remarks_5,le.avelength_remarks_6,le.avelength_remarks_7,le.avelength_remarks_8,le.avelength_remarks_9,le.avelength_remarks_10,le.avelength_remarks_11,le.avelength_remarks_12,le.avelength_remarks_13,le.avelength_remarks_14,le.avelength_remarks_15,le.avelength_remarks_16,le.avelength_remarks_17,le.avelength_remarks_18,le.avelength_remarks_19,le.avelength_remarks_20,le.avelength_remarks_21,le.avelength_remarks_22,le.avelength_remarks_23,le.avelength_remarks_24,le.avelength_remarks_25,le.avelength_remarks_26,le.avelength_remarks_27,le.avelength_remarks_28,le.avelength_remarks_29,le.avelength_remarks_30,le.avelength_cname,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_suffix,le.avelength_a_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_record_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_entity_id,le.avelength_first_name,le.avelength_last_name,le.avelength_title_1,le.avelength_title_2,le.avelength_title_3,le.avelength_title_4,le.avelength_title_5,le.avelength_title_6,le.avelength_title_7,le.avelength_title_8,le.avelength_title_9,le.avelength_title_10,le.avelength_aka_id,le.avelength_aka_type,le.avelength_aka_category,le.avelength_giv_designator,le.avelength_entity_type,le.avelength_address_id,le.avelength_address_line_1,le.avelength_address_line_2,le.avelength_address_line_3,le.avelength_address_city,le.avelength_address_state_province,le.avelength_address_postal_code,le.avelength_address_country,le.avelength_remarks,le.avelength_call_sign,le.avelength_vessel_type,le.avelength_tonnage,le.avelength_gross_registered_tonnage,le.avelength_vessel_flag,le.avelength_vessel_owner,le.avelength_sanctions_program_1,le.avelength_sanctions_program_2,le.avelength_sanctions_program_3,le.avelength_sanctions_program_4,le.avelength_sanctions_program_5,le.avelength_sanctions_program_6,le.avelength_sanctions_program_7,le.avelength_sanctions_program_8,le.avelength_sanctions_program_9,le.avelength_sanctions_program_10,le.avelength_passport_details,le.avelength_ni_number_details,le.avelength_id_id_1,le.avelength_id_id_2,le.avelength_id_id_3,le.avelength_id_id_4,le.avelength_id_id_5,le.avelength_id_id_6,le.avelength_id_id_7,le.avelength_id_id_8,le.avelength_id_id_9,le.avelength_id_id_10,le.avelength_id_type_1,le.avelength_id_type_2,le.avelength_id_type_3,le.avelength_id_type_4,le.avelength_id_type_5,le.avelength_id_type_6,le.avelength_id_type_7,le.avelength_id_type_8,le.avelength_id_type_9,le.avelength_id_type_10,le.avelength_id_number_1,le.avelength_id_number_2,le.avelength_id_number_3,le.avelength_id_number_4,le.avelength_id_number_5,le.avelength_id_number_6,le.avelength_id_number_7,le.avelength_id_number_8,le.avelength_id_number_9,le.avelength_id_number_10,le.avelength_id_country_1,le.avelength_id_country_2,le.avelength_id_country_3,le.avelength_id_country_4,le.avelength_id_country_5,le.avelength_id_country_6,le.avelength_id_country_7,le.avelength_id_country_8,le.avelength_id_country_9,le.avelength_id_country_10,le.avelength_id_issue_date_1,le.avelength_id_issue_date_2,le.avelength_id_issue_date_3,le.avelength_id_issue_date_4,le.avelength_id_issue_date_5,le.avelength_id_issue_date_6,le.avelength_id_issue_date_7,le.avelength_id_issue_date_8,le.avelength_id_issue_date_9,le.avelength_id_issue_date_10,le.avelength_id_expiration_date_1,le.avelength_id_expiration_date_2,le.avelength_id_expiration_date_3,le.avelength_id_expiration_date_4,le.avelength_id_expiration_date_5,le.avelength_id_expiration_date_6,le.avelength_id_expiration_date_7,le.avelength_id_expiration_date_8,le.avelength_id_expiration_date_9,le.avelength_id_expiration_date_10,le.avelength_nationality_id_1,le.avelength_nationality_id_2,le.avelength_nationality_id_3,le.avelength_nationality_id_4,le.avelength_nationality_id_5,le.avelength_nationality_id_6,le.avelength_nationality_id_7,le.avelength_nationality_id_8,le.avelength_nationality_id_9,le.avelength_nationality_id_10,le.avelength_nationality_1,le.avelength_nationality_2,le.avelength_nationality_3,le.avelength_nationality_4,le.avelength_nationality_5,le.avelength_nationality_6,le.avelength_nationality_7,le.avelength_nationality_8,le.avelength_nationality_9,le.avelength_nationality_10,le.avelength_primary_nationality_flag_1,le.avelength_primary_nationality_flag_2,le.avelength_primary_nationality_flag_3,le.avelength_primary_nationality_flag_4,le.avelength_primary_nationality_flag_5,le.avelength_primary_nationality_flag_6,le.avelength_primary_nationality_flag_7,le.avelength_primary_nationality_flag_8,le.avelength_primary_nationality_flag_9,le.avelength_primary_nationality_flag_10,le.avelength_citizenship_id_1,le.avelength_citizenship_id_2,le.avelength_citizenship_id_3,le.avelength_citizenship_id_4,le.avelength_citizenship_id_5,le.avelength_citizenship_id_6,le.avelength_citizenship_id_7,le.avelength_citizenship_id_8,le.avelength_citizenship_id_9,le.avelength_citizenship_id_10,le.avelength_citizenship_1,le.avelength_citizenship_2,le.avelength_citizenship_3,le.avelength_citizenship_4,le.avelength_citizenship_5,le.avelength_citizenship_6,le.avelength_citizenship_7,le.avelength_citizenship_8,le.avelength_citizenship_9,le.avelength_citizenship_10,le.avelength_primary_citizenship_flag_1,le.avelength_primary_citizenship_flag_2,le.avelength_primary_citizenship_flag_3,le.avelength_primary_citizenship_flag_4,le.avelength_primary_citizenship_flag_5,le.avelength_primary_citizenship_flag_6,le.avelength_primary_citizenship_flag_7,le.avelength_primary_citizenship_flag_8,le.avelength_primary_citizenship_flag_9,le.avelength_primary_citizenship_flag_10,le.avelength_dob_id_1,le.avelength_dob_id_2,le.avelength_dob_id_3,le.avelength_dob_id_4,le.avelength_dob_id_5,le.avelength_dob_id_6,le.avelength_dob_id_7,le.avelength_dob_id_8,le.avelength_dob_id_9,le.avelength_dob_id_10,le.avelength_dob_1,le.avelength_dob_2,le.avelength_dob_3,le.avelength_dob_4,le.avelength_dob_5,le.avelength_dob_6,le.avelength_dob_7,le.avelength_dob_8,le.avelength_dob_9,le.avelength_dob_10,le.avelength_primary_dob_flag_1,le.avelength_primary_dob_flag_2,le.avelength_primary_dob_flag_3,le.avelength_primary_dob_flag_4,le.avelength_primary_dob_flag_5,le.avelength_primary_dob_flag_6,le.avelength_primary_dob_flag_7,le.avelength_primary_dob_flag_8,le.avelength_primary_dob_flag_9,le.avelength_primary_dob_flag_10,le.avelength_pob_id_1,le.avelength_pob_id_2,le.avelength_pob_id_3,le.avelength_pob_id_4,le.avelength_pob_id_5,le.avelength_pob_id_6,le.avelength_pob_id_7,le.avelength_pob_id_8,le.avelength_pob_id_9,le.avelength_pob_id_10,le.avelength_pob_1,le.avelength_pob_2,le.avelength_pob_3,le.avelength_pob_4,le.avelength_pob_5,le.avelength_pob_6,le.avelength_pob_7,le.avelength_pob_8,le.avelength_pob_9,le.avelength_pob_10,le.avelength_country_of_birth_1,le.avelength_country_of_birth_2,le.avelength_country_of_birth_3,le.avelength_country_of_birth_4,le.avelength_country_of_birth_5,le.avelength_country_of_birth_6,le.avelength_country_of_birth_7,le.avelength_country_of_birth_8,le.avelength_country_of_birth_9,le.avelength_country_of_birth_10,le.avelength_primary_pob_flag_1,le.avelength_primary_pob_flag_2,le.avelength_primary_pob_flag_3,le.avelength_primary_pob_flag_4,le.avelength_primary_pob_flag_5,le.avelength_primary_pob_flag_6,le.avelength_primary_pob_flag_7,le.avelength_primary_pob_flag_8,le.avelength_primary_pob_flag_9,le.avelength_primary_pob_flag_10,le.avelength_language_1,le.avelength_language_2,le.avelength_language_3,le.avelength_language_4,le.avelength_language_5,le.avelength_language_6,le.avelength_language_7,le.avelength_language_8,le.avelength_language_9,le.avelength_language_10,le.avelength_membership_1,le.avelength_membership_2,le.avelength_membership_3,le.avelength_membership_4,le.avelength_membership_5,le.avelength_membership_6,le.avelength_membership_7,le.avelength_membership_8,le.avelength_membership_9,le.avelength_membership_10,le.avelength_position_1,le.avelength_position_2,le.avelength_position_3,le.avelength_position_4,le.avelength_position_5,le.avelength_position_6,le.avelength_position_7,le.avelength_position_8,le.avelength_position_9,le.avelength_position_10,le.avelength_occupation_1,le.avelength_occupation_2,le.avelength_occupation_3,le.avelength_occupation_4,le.avelength_occupation_5,le.avelength_occupation_6,le.avelength_occupation_7,le.avelength_occupation_8,le.avelength_occupation_9,le.avelength_occupation_10,le.avelength_date_added_to_list,le.avelength_date_last_updated,le.avelength_effective_date,le.avelength_expiration_date,le.avelength_gender,le.avelength_grounds,le.avelength_subj_to_common_pos_2001_931_cfsp_fl,le.avelength_federal_register_citation_1,le.avelength_federal_register_citation_2,le.avelength_federal_register_citation_3,le.avelength_federal_register_citation_4,le.avelength_federal_register_citation_5,le.avelength_federal_register_citation_6,le.avelength_federal_register_citation_7,le.avelength_federal_register_citation_8,le.avelength_federal_register_citation_9,le.avelength_federal_register_citation_10,le.avelength_federal_register_citation_date_1,le.avelength_federal_register_citation_date_2,le.avelength_federal_register_citation_date_3,le.avelength_federal_register_citation_date_4,le.avelength_federal_register_citation_date_5,le.avelength_federal_register_citation_date_6,le.avelength_federal_register_citation_date_7,le.avelength_federal_register_citation_date_8,le.avelength_federal_register_citation_date_9,le.avelength_federal_register_citation_date_10,le.avelength_license_requirement,le.avelength_license_review_policy,le.avelength_subordinate_status,le.avelength_height,le.avelength_weight,le.avelength_physique,le.avelength_hair_color,le.avelength_eyes,le.avelength_complexion,le.avelength_race,le.avelength_scars_marks,le.avelength_photo_file,le.avelength_offenses,le.avelength_ncic,le.avelength_warrant_by,le.avelength_caution,le.avelength_reward,le.avelength_type_of_denial,le.avelength_linked_with_1,le.avelength_linked_with_2,le.avelength_linked_with_3,le.avelength_linked_with_4,le.avelength_linked_with_5,le.avelength_linked_with_6,le.avelength_linked_with_7,le.avelength_linked_with_8,le.avelength_linked_with_9,le.avelength_linked_with_10,le.avelength_linked_with_id_1,le.avelength_linked_with_id_2,le.avelength_linked_with_id_3,le.avelength_linked_with_id_4,le.avelength_linked_with_id_5,le.avelength_linked_with_id_6,le.avelength_linked_with_id_7,le.avelength_linked_with_id_8,le.avelength_linked_with_id_9,le.avelength_linked_with_id_10,le.avelength_listing_information,le.avelength_foreign_principal,le.avelength_nature_of_service,le.avelength_activities,le.avelength_finances,le.avelength_registrant_terminated_flag,le.avelength_foreign_principal_terminated_flag,le.avelength_short_form_terminated_flag,le.avelength_src_key);
END;
EXPORT invSummary := NORMALIZE(summary0, 433, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.src_key;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT34.StrType)le.pty_key),TRIM((SALT34.StrType)le.source),TRIM((SALT34.StrType)le.orig_pty_name),TRIM((SALT34.StrType)le.orig_vessel_name),TRIM((SALT34.StrType)le.country),TRIM((SALT34.StrType)le.name_type),TRIM((SALT34.StrType)le.addr_1),TRIM((SALT34.StrType)le.addr_2),TRIM((SALT34.StrType)le.addr_3),TRIM((SALT34.StrType)le.addr_4),TRIM((SALT34.StrType)le.addr_5),TRIM((SALT34.StrType)le.addr_6),TRIM((SALT34.StrType)le.addr_7),TRIM((SALT34.StrType)le.addr_8),TRIM((SALT34.StrType)le.addr_9),TRIM((SALT34.StrType)le.addr_10),TRIM((SALT34.StrType)le.remarks_1),TRIM((SALT34.StrType)le.remarks_2),TRIM((SALT34.StrType)le.remarks_3),TRIM((SALT34.StrType)le.remarks_4),TRIM((SALT34.StrType)le.remarks_5),TRIM((SALT34.StrType)le.remarks_6),TRIM((SALT34.StrType)le.remarks_7),TRIM((SALT34.StrType)le.remarks_8),TRIM((SALT34.StrType)le.remarks_9),TRIM((SALT34.StrType)le.remarks_10),TRIM((SALT34.StrType)le.remarks_11),TRIM((SALT34.StrType)le.remarks_12),TRIM((SALT34.StrType)le.remarks_13),TRIM((SALT34.StrType)le.remarks_14),TRIM((SALT34.StrType)le.remarks_15),TRIM((SALT34.StrType)le.remarks_16),TRIM((SALT34.StrType)le.remarks_17),TRIM((SALT34.StrType)le.remarks_18),TRIM((SALT34.StrType)le.remarks_19),TRIM((SALT34.StrType)le.remarks_20),TRIM((SALT34.StrType)le.remarks_21),TRIM((SALT34.StrType)le.remarks_22),TRIM((SALT34.StrType)le.remarks_23),TRIM((SALT34.StrType)le.remarks_24),TRIM((SALT34.StrType)le.remarks_25),TRIM((SALT34.StrType)le.remarks_26),TRIM((SALT34.StrType)le.remarks_27),TRIM((SALT34.StrType)le.remarks_28),TRIM((SALT34.StrType)le.remarks_29),TRIM((SALT34.StrType)le.remarks_30),TRIM((SALT34.StrType)le.cname),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.suffix),TRIM((SALT34.StrType)le.a_score),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.addr_suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dpbc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.ace_fips_st),TRIM((SALT34.StrType)le.county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat),TRIM((SALT34.StrType)le.date_first_seen),TRIM((SALT34.StrType)le.date_last_seen),TRIM((SALT34.StrType)le.date_vendor_first_reported),TRIM((SALT34.StrType)le.date_vendor_last_reported),TRIM((SALT34.StrType)le.entity_id),TRIM((SALT34.StrType)le.first_name),TRIM((SALT34.StrType)le.last_name),TRIM((SALT34.StrType)le.title_1),TRIM((SALT34.StrType)le.title_2),TRIM((SALT34.StrType)le.title_3),TRIM((SALT34.StrType)le.title_4),TRIM((SALT34.StrType)le.title_5),TRIM((SALT34.StrType)le.title_6),TRIM((SALT34.StrType)le.title_7),TRIM((SALT34.StrType)le.title_8),TRIM((SALT34.StrType)le.title_9),TRIM((SALT34.StrType)le.title_10),TRIM((SALT34.StrType)le.aka_id),TRIM((SALT34.StrType)le.aka_type),TRIM((SALT34.StrType)le.aka_category),TRIM((SALT34.StrType)le.giv_designator),TRIM((SALT34.StrType)le.entity_type),TRIM((SALT34.StrType)le.address_id),TRIM((SALT34.StrType)le.address_line_1),TRIM((SALT34.StrType)le.address_line_2),TRIM((SALT34.StrType)le.address_line_3),TRIM((SALT34.StrType)le.address_city),TRIM((SALT34.StrType)le.address_state_province),TRIM((SALT34.StrType)le.address_postal_code),TRIM((SALT34.StrType)le.address_country),TRIM((SALT34.StrType)le.remarks),TRIM((SALT34.StrType)le.call_sign),TRIM((SALT34.StrType)le.vessel_type),TRIM((SALT34.StrType)le.tonnage),TRIM((SALT34.StrType)le.gross_registered_tonnage),TRIM((SALT34.StrType)le.vessel_flag),TRIM((SALT34.StrType)le.vessel_owner),TRIM((SALT34.StrType)le.sanctions_program_1),TRIM((SALT34.StrType)le.sanctions_program_2),TRIM((SALT34.StrType)le.sanctions_program_3),TRIM((SALT34.StrType)le.sanctions_program_4),TRIM((SALT34.StrType)le.sanctions_program_5),TRIM((SALT34.StrType)le.sanctions_program_6),TRIM((SALT34.StrType)le.sanctions_program_7),TRIM((SALT34.StrType)le.sanctions_program_8),TRIM((SALT34.StrType)le.sanctions_program_9),TRIM((SALT34.StrType)le.sanctions_program_10),TRIM((SALT34.StrType)le.passport_details),TRIM((SALT34.StrType)le.ni_number_details),TRIM((SALT34.StrType)le.id_id_1),TRIM((SALT34.StrType)le.id_id_2),TRIM((SALT34.StrType)le.id_id_3),TRIM((SALT34.StrType)le.id_id_4),TRIM((SALT34.StrType)le.id_id_5),TRIM((SALT34.StrType)le.id_id_6),TRIM((SALT34.StrType)le.id_id_7),TRIM((SALT34.StrType)le.id_id_8),TRIM((SALT34.StrType)le.id_id_9),TRIM((SALT34.StrType)le.id_id_10),TRIM((SALT34.StrType)le.id_type_1),TRIM((SALT34.StrType)le.id_type_2),TRIM((SALT34.StrType)le.id_type_3),TRIM((SALT34.StrType)le.id_type_4),TRIM((SALT34.StrType)le.id_type_5),TRIM((SALT34.StrType)le.id_type_6),TRIM((SALT34.StrType)le.id_type_7),TRIM((SALT34.StrType)le.id_type_8),TRIM((SALT34.StrType)le.id_type_9),TRIM((SALT34.StrType)le.id_type_10),TRIM((SALT34.StrType)le.id_number_1),TRIM((SALT34.StrType)le.id_number_2),TRIM((SALT34.StrType)le.id_number_3),TRIM((SALT34.StrType)le.id_number_4),TRIM((SALT34.StrType)le.id_number_5),TRIM((SALT34.StrType)le.id_number_6),TRIM((SALT34.StrType)le.id_number_7),TRIM((SALT34.StrType)le.id_number_8),TRIM((SALT34.StrType)le.id_number_9),TRIM((SALT34.StrType)le.id_number_10),TRIM((SALT34.StrType)le.id_country_1),TRIM((SALT34.StrType)le.id_country_2),TRIM((SALT34.StrType)le.id_country_3),TRIM((SALT34.StrType)le.id_country_4),TRIM((SALT34.StrType)le.id_country_5),TRIM((SALT34.StrType)le.id_country_6),TRIM((SALT34.StrType)le.id_country_7),TRIM((SALT34.StrType)le.id_country_8),TRIM((SALT34.StrType)le.id_country_9),TRIM((SALT34.StrType)le.id_country_10),TRIM((SALT34.StrType)le.id_issue_date_1),TRIM((SALT34.StrType)le.id_issue_date_2),TRIM((SALT34.StrType)le.id_issue_date_3),TRIM((SALT34.StrType)le.id_issue_date_4),TRIM((SALT34.StrType)le.id_issue_date_5),TRIM((SALT34.StrType)le.id_issue_date_6),TRIM((SALT34.StrType)le.id_issue_date_7),TRIM((SALT34.StrType)le.id_issue_date_8),TRIM((SALT34.StrType)le.id_issue_date_9),TRIM((SALT34.StrType)le.id_issue_date_10),TRIM((SALT34.StrType)le.id_expiration_date_1),TRIM((SALT34.StrType)le.id_expiration_date_2),TRIM((SALT34.StrType)le.id_expiration_date_3),TRIM((SALT34.StrType)le.id_expiration_date_4),TRIM((SALT34.StrType)le.id_expiration_date_5),TRIM((SALT34.StrType)le.id_expiration_date_6),TRIM((SALT34.StrType)le.id_expiration_date_7),TRIM((SALT34.StrType)le.id_expiration_date_8),TRIM((SALT34.StrType)le.id_expiration_date_9),TRIM((SALT34.StrType)le.id_expiration_date_10),TRIM((SALT34.StrType)le.nationality_id_1),TRIM((SALT34.StrType)le.nationality_id_2),TRIM((SALT34.StrType)le.nationality_id_3),TRIM((SALT34.StrType)le.nationality_id_4),TRIM((SALT34.StrType)le.nationality_id_5),TRIM((SALT34.StrType)le.nationality_id_6),TRIM((SALT34.StrType)le.nationality_id_7),TRIM((SALT34.StrType)le.nationality_id_8),TRIM((SALT34.StrType)le.nationality_id_9),TRIM((SALT34.StrType)le.nationality_id_10),TRIM((SALT34.StrType)le.nationality_1),TRIM((SALT34.StrType)le.nationality_2),TRIM((SALT34.StrType)le.nationality_3),TRIM((SALT34.StrType)le.nationality_4),TRIM((SALT34.StrType)le.nationality_5),TRIM((SALT34.StrType)le.nationality_6),TRIM((SALT34.StrType)le.nationality_7),TRIM((SALT34.StrType)le.nationality_8),TRIM((SALT34.StrType)le.nationality_9),TRIM((SALT34.StrType)le.nationality_10),TRIM((SALT34.StrType)le.primary_nationality_flag_1),TRIM((SALT34.StrType)le.primary_nationality_flag_2),TRIM((SALT34.StrType)le.primary_nationality_flag_3),TRIM((SALT34.StrType)le.primary_nationality_flag_4),TRIM((SALT34.StrType)le.primary_nationality_flag_5),TRIM((SALT34.StrType)le.primary_nationality_flag_6),TRIM((SALT34.StrType)le.primary_nationality_flag_7),TRIM((SALT34.StrType)le.primary_nationality_flag_8),TRIM((SALT34.StrType)le.primary_nationality_flag_9),TRIM((SALT34.StrType)le.primary_nationality_flag_10),TRIM((SALT34.StrType)le.citizenship_id_1),TRIM((SALT34.StrType)le.citizenship_id_2),TRIM((SALT34.StrType)le.citizenship_id_3),TRIM((SALT34.StrType)le.citizenship_id_4),TRIM((SALT34.StrType)le.citizenship_id_5),TRIM((SALT34.StrType)le.citizenship_id_6),TRIM((SALT34.StrType)le.citizenship_id_7),TRIM((SALT34.StrType)le.citizenship_id_8),TRIM((SALT34.StrType)le.citizenship_id_9),TRIM((SALT34.StrType)le.citizenship_id_10),TRIM((SALT34.StrType)le.citizenship_1),TRIM((SALT34.StrType)le.citizenship_2),TRIM((SALT34.StrType)le.citizenship_3),TRIM((SALT34.StrType)le.citizenship_4),TRIM((SALT34.StrType)le.citizenship_5),TRIM((SALT34.StrType)le.citizenship_6),TRIM((SALT34.StrType)le.citizenship_7),TRIM((SALT34.StrType)le.citizenship_8),TRIM((SALT34.StrType)le.citizenship_9),TRIM((SALT34.StrType)le.citizenship_10),TRIM((SALT34.StrType)le.primary_citizenship_flag_1),TRIM((SALT34.StrType)le.primary_citizenship_flag_2),TRIM((SALT34.StrType)le.primary_citizenship_flag_3),TRIM((SALT34.StrType)le.primary_citizenship_flag_4),TRIM((SALT34.StrType)le.primary_citizenship_flag_5),TRIM((SALT34.StrType)le.primary_citizenship_flag_6),TRIM((SALT34.StrType)le.primary_citizenship_flag_7),TRIM((SALT34.StrType)le.primary_citizenship_flag_8),TRIM((SALT34.StrType)le.primary_citizenship_flag_9),TRIM((SALT34.StrType)le.primary_citizenship_flag_10),TRIM((SALT34.StrType)le.dob_id_1),TRIM((SALT34.StrType)le.dob_id_2),TRIM((SALT34.StrType)le.dob_id_3),TRIM((SALT34.StrType)le.dob_id_4),TRIM((SALT34.StrType)le.dob_id_5),TRIM((SALT34.StrType)le.dob_id_6),TRIM((SALT34.StrType)le.dob_id_7),TRIM((SALT34.StrType)le.dob_id_8),TRIM((SALT34.StrType)le.dob_id_9),TRIM((SALT34.StrType)le.dob_id_10),TRIM((SALT34.StrType)le.dob_1),TRIM((SALT34.StrType)le.dob_2),TRIM((SALT34.StrType)le.dob_3),TRIM((SALT34.StrType)le.dob_4),TRIM((SALT34.StrType)le.dob_5),TRIM((SALT34.StrType)le.dob_6),TRIM((SALT34.StrType)le.dob_7),TRIM((SALT34.StrType)le.dob_8),TRIM((SALT34.StrType)le.dob_9),TRIM((SALT34.StrType)le.dob_10),TRIM((SALT34.StrType)le.primary_dob_flag_1),TRIM((SALT34.StrType)le.primary_dob_flag_2),TRIM((SALT34.StrType)le.primary_dob_flag_3),TRIM((SALT34.StrType)le.primary_dob_flag_4),TRIM((SALT34.StrType)le.primary_dob_flag_5),TRIM((SALT34.StrType)le.primary_dob_flag_6),TRIM((SALT34.StrType)le.primary_dob_flag_7),TRIM((SALT34.StrType)le.primary_dob_flag_8),TRIM((SALT34.StrType)le.primary_dob_flag_9),TRIM((SALT34.StrType)le.primary_dob_flag_10),TRIM((SALT34.StrType)le.pob_id_1),TRIM((SALT34.StrType)le.pob_id_2),TRIM((SALT34.StrType)le.pob_id_3),TRIM((SALT34.StrType)le.pob_id_4),TRIM((SALT34.StrType)le.pob_id_5),TRIM((SALT34.StrType)le.pob_id_6),TRIM((SALT34.StrType)le.pob_id_7),TRIM((SALT34.StrType)le.pob_id_8),TRIM((SALT34.StrType)le.pob_id_9),TRIM((SALT34.StrType)le.pob_id_10),TRIM((SALT34.StrType)le.pob_1),TRIM((SALT34.StrType)le.pob_2),TRIM((SALT34.StrType)le.pob_3),TRIM((SALT34.StrType)le.pob_4),TRIM((SALT34.StrType)le.pob_5),TRIM((SALT34.StrType)le.pob_6),TRIM((SALT34.StrType)le.pob_7),TRIM((SALT34.StrType)le.pob_8),TRIM((SALT34.StrType)le.pob_9),TRIM((SALT34.StrType)le.pob_10),TRIM((SALT34.StrType)le.country_of_birth_1),TRIM((SALT34.StrType)le.country_of_birth_2),TRIM((SALT34.StrType)le.country_of_birth_3),TRIM((SALT34.StrType)le.country_of_birth_4),TRIM((SALT34.StrType)le.country_of_birth_5),TRIM((SALT34.StrType)le.country_of_birth_6),TRIM((SALT34.StrType)le.country_of_birth_7),TRIM((SALT34.StrType)le.country_of_birth_8),TRIM((SALT34.StrType)le.country_of_birth_9),TRIM((SALT34.StrType)le.country_of_birth_10),TRIM((SALT34.StrType)le.primary_pob_flag_1),TRIM((SALT34.StrType)le.primary_pob_flag_2),TRIM((SALT34.StrType)le.primary_pob_flag_3),TRIM((SALT34.StrType)le.primary_pob_flag_4),TRIM((SALT34.StrType)le.primary_pob_flag_5),TRIM((SALT34.StrType)le.primary_pob_flag_6),TRIM((SALT34.StrType)le.primary_pob_flag_7),TRIM((SALT34.StrType)le.primary_pob_flag_8),TRIM((SALT34.StrType)le.primary_pob_flag_9),TRIM((SALT34.StrType)le.primary_pob_flag_10),TRIM((SALT34.StrType)le.language_1),TRIM((SALT34.StrType)le.language_2),TRIM((SALT34.StrType)le.language_3),TRIM((SALT34.StrType)le.language_4),TRIM((SALT34.StrType)le.language_5),TRIM((SALT34.StrType)le.language_6),TRIM((SALT34.StrType)le.language_7),TRIM((SALT34.StrType)le.language_8),TRIM((SALT34.StrType)le.language_9),TRIM((SALT34.StrType)le.language_10),TRIM((SALT34.StrType)le.membership_1),TRIM((SALT34.StrType)le.membership_2),TRIM((SALT34.StrType)le.membership_3),TRIM((SALT34.StrType)le.membership_4),TRIM((SALT34.StrType)le.membership_5),TRIM((SALT34.StrType)le.membership_6),TRIM((SALT34.StrType)le.membership_7),TRIM((SALT34.StrType)le.membership_8),TRIM((SALT34.StrType)le.membership_9),TRIM((SALT34.StrType)le.membership_10),TRIM((SALT34.StrType)le.position_1),TRIM((SALT34.StrType)le.position_2),TRIM((SALT34.StrType)le.position_3),TRIM((SALT34.StrType)le.position_4),TRIM((SALT34.StrType)le.position_5),TRIM((SALT34.StrType)le.position_6),TRIM((SALT34.StrType)le.position_7),TRIM((SALT34.StrType)le.position_8),TRIM((SALT34.StrType)le.position_9),TRIM((SALT34.StrType)le.position_10),TRIM((SALT34.StrType)le.occupation_1),TRIM((SALT34.StrType)le.occupation_2),TRIM((SALT34.StrType)le.occupation_3),TRIM((SALT34.StrType)le.occupation_4),TRIM((SALT34.StrType)le.occupation_5),TRIM((SALT34.StrType)le.occupation_6),TRIM((SALT34.StrType)le.occupation_7),TRIM((SALT34.StrType)le.occupation_8),TRIM((SALT34.StrType)le.occupation_9),TRIM((SALT34.StrType)le.occupation_10),TRIM((SALT34.StrType)le.date_added_to_list),TRIM((SALT34.StrType)le.date_last_updated),TRIM((SALT34.StrType)le.effective_date),TRIM((SALT34.StrType)le.expiration_date),TRIM((SALT34.StrType)le.gender),TRIM((SALT34.StrType)le.grounds),TRIM((SALT34.StrType)le.subj_to_common_pos_2001_931_cfsp_fl),TRIM((SALT34.StrType)le.federal_register_citation_1),TRIM((SALT34.StrType)le.federal_register_citation_2),TRIM((SALT34.StrType)le.federal_register_citation_3),TRIM((SALT34.StrType)le.federal_register_citation_4),TRIM((SALT34.StrType)le.federal_register_citation_5),TRIM((SALT34.StrType)le.federal_register_citation_6),TRIM((SALT34.StrType)le.federal_register_citation_7),TRIM((SALT34.StrType)le.federal_register_citation_8),TRIM((SALT34.StrType)le.federal_register_citation_9),TRIM((SALT34.StrType)le.federal_register_citation_10),TRIM((SALT34.StrType)le.federal_register_citation_date_1),TRIM((SALT34.StrType)le.federal_register_citation_date_2),TRIM((SALT34.StrType)le.federal_register_citation_date_3),TRIM((SALT34.StrType)le.federal_register_citation_date_4),TRIM((SALT34.StrType)le.federal_register_citation_date_5),TRIM((SALT34.StrType)le.federal_register_citation_date_6),TRIM((SALT34.StrType)le.federal_register_citation_date_7),TRIM((SALT34.StrType)le.federal_register_citation_date_8),TRIM((SALT34.StrType)le.federal_register_citation_date_9),TRIM((SALT34.StrType)le.federal_register_citation_date_10),TRIM((SALT34.StrType)le.license_requirement),TRIM((SALT34.StrType)le.license_review_policy),TRIM((SALT34.StrType)le.subordinate_status),TRIM((SALT34.StrType)le.height),TRIM((SALT34.StrType)le.weight),TRIM((SALT34.StrType)le.physique),TRIM((SALT34.StrType)le.hair_color),TRIM((SALT34.StrType)le.eyes),TRIM((SALT34.StrType)le.complexion),TRIM((SALT34.StrType)le.race),TRIM((SALT34.StrType)le.scars_marks),TRIM((SALT34.StrType)le.photo_file),TRIM((SALT34.StrType)le.offenses),TRIM((SALT34.StrType)le.ncic),TRIM((SALT34.StrType)le.warrant_by),TRIM((SALT34.StrType)le.caution),TRIM((SALT34.StrType)le.reward),TRIM((SALT34.StrType)le.type_of_denial),TRIM((SALT34.StrType)le.linked_with_1),TRIM((SALT34.StrType)le.linked_with_2),TRIM((SALT34.StrType)le.linked_with_3),TRIM((SALT34.StrType)le.linked_with_4),TRIM((SALT34.StrType)le.linked_with_5),TRIM((SALT34.StrType)le.linked_with_6),TRIM((SALT34.StrType)le.linked_with_7),TRIM((SALT34.StrType)le.linked_with_8),TRIM((SALT34.StrType)le.linked_with_9),TRIM((SALT34.StrType)le.linked_with_10),TRIM((SALT34.StrType)le.linked_with_id_1),TRIM((SALT34.StrType)le.linked_with_id_2),TRIM((SALT34.StrType)le.linked_with_id_3),TRIM((SALT34.StrType)le.linked_with_id_4),TRIM((SALT34.StrType)le.linked_with_id_5),TRIM((SALT34.StrType)le.linked_with_id_6),TRIM((SALT34.StrType)le.linked_with_id_7),TRIM((SALT34.StrType)le.linked_with_id_8),TRIM((SALT34.StrType)le.linked_with_id_9),TRIM((SALT34.StrType)le.linked_with_id_10),TRIM((SALT34.StrType)le.listing_information),TRIM((SALT34.StrType)le.foreign_principal),TRIM((SALT34.StrType)le.nature_of_service),TRIM((SALT34.StrType)le.activities),TRIM((SALT34.StrType)le.finances),TRIM((SALT34.StrType)le.registrant_terminated_flag),TRIM((SALT34.StrType)le.foreign_principal_terminated_flag),TRIM((SALT34.StrType)le.short_form_terminated_flag),TRIM((SALT34.StrType)le.src_key)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,433,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 433);
  SELF.FldNo2 := 1 + (C % 433);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT34.StrType)le.pty_key),TRIM((SALT34.StrType)le.source),TRIM((SALT34.StrType)le.orig_pty_name),TRIM((SALT34.StrType)le.orig_vessel_name),TRIM((SALT34.StrType)le.country),TRIM((SALT34.StrType)le.name_type),TRIM((SALT34.StrType)le.addr_1),TRIM((SALT34.StrType)le.addr_2),TRIM((SALT34.StrType)le.addr_3),TRIM((SALT34.StrType)le.addr_4),TRIM((SALT34.StrType)le.addr_5),TRIM((SALT34.StrType)le.addr_6),TRIM((SALT34.StrType)le.addr_7),TRIM((SALT34.StrType)le.addr_8),TRIM((SALT34.StrType)le.addr_9),TRIM((SALT34.StrType)le.addr_10),TRIM((SALT34.StrType)le.remarks_1),TRIM((SALT34.StrType)le.remarks_2),TRIM((SALT34.StrType)le.remarks_3),TRIM((SALT34.StrType)le.remarks_4),TRIM((SALT34.StrType)le.remarks_5),TRIM((SALT34.StrType)le.remarks_6),TRIM((SALT34.StrType)le.remarks_7),TRIM((SALT34.StrType)le.remarks_8),TRIM((SALT34.StrType)le.remarks_9),TRIM((SALT34.StrType)le.remarks_10),TRIM((SALT34.StrType)le.remarks_11),TRIM((SALT34.StrType)le.remarks_12),TRIM((SALT34.StrType)le.remarks_13),TRIM((SALT34.StrType)le.remarks_14),TRIM((SALT34.StrType)le.remarks_15),TRIM((SALT34.StrType)le.remarks_16),TRIM((SALT34.StrType)le.remarks_17),TRIM((SALT34.StrType)le.remarks_18),TRIM((SALT34.StrType)le.remarks_19),TRIM((SALT34.StrType)le.remarks_20),TRIM((SALT34.StrType)le.remarks_21),TRIM((SALT34.StrType)le.remarks_22),TRIM((SALT34.StrType)le.remarks_23),TRIM((SALT34.StrType)le.remarks_24),TRIM((SALT34.StrType)le.remarks_25),TRIM((SALT34.StrType)le.remarks_26),TRIM((SALT34.StrType)le.remarks_27),TRIM((SALT34.StrType)le.remarks_28),TRIM((SALT34.StrType)le.remarks_29),TRIM((SALT34.StrType)le.remarks_30),TRIM((SALT34.StrType)le.cname),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.suffix),TRIM((SALT34.StrType)le.a_score),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.addr_suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dpbc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.ace_fips_st),TRIM((SALT34.StrType)le.county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat),TRIM((SALT34.StrType)le.date_first_seen),TRIM((SALT34.StrType)le.date_last_seen),TRIM((SALT34.StrType)le.date_vendor_first_reported),TRIM((SALT34.StrType)le.date_vendor_last_reported),TRIM((SALT34.StrType)le.entity_id),TRIM((SALT34.StrType)le.first_name),TRIM((SALT34.StrType)le.last_name),TRIM((SALT34.StrType)le.title_1),TRIM((SALT34.StrType)le.title_2),TRIM((SALT34.StrType)le.title_3),TRIM((SALT34.StrType)le.title_4),TRIM((SALT34.StrType)le.title_5),TRIM((SALT34.StrType)le.title_6),TRIM((SALT34.StrType)le.title_7),TRIM((SALT34.StrType)le.title_8),TRIM((SALT34.StrType)le.title_9),TRIM((SALT34.StrType)le.title_10),TRIM((SALT34.StrType)le.aka_id),TRIM((SALT34.StrType)le.aka_type),TRIM((SALT34.StrType)le.aka_category),TRIM((SALT34.StrType)le.giv_designator),TRIM((SALT34.StrType)le.entity_type),TRIM((SALT34.StrType)le.address_id),TRIM((SALT34.StrType)le.address_line_1),TRIM((SALT34.StrType)le.address_line_2),TRIM((SALT34.StrType)le.address_line_3),TRIM((SALT34.StrType)le.address_city),TRIM((SALT34.StrType)le.address_state_province),TRIM((SALT34.StrType)le.address_postal_code),TRIM((SALT34.StrType)le.address_country),TRIM((SALT34.StrType)le.remarks),TRIM((SALT34.StrType)le.call_sign),TRIM((SALT34.StrType)le.vessel_type),TRIM((SALT34.StrType)le.tonnage),TRIM((SALT34.StrType)le.gross_registered_tonnage),TRIM((SALT34.StrType)le.vessel_flag),TRIM((SALT34.StrType)le.vessel_owner),TRIM((SALT34.StrType)le.sanctions_program_1),TRIM((SALT34.StrType)le.sanctions_program_2),TRIM((SALT34.StrType)le.sanctions_program_3),TRIM((SALT34.StrType)le.sanctions_program_4),TRIM((SALT34.StrType)le.sanctions_program_5),TRIM((SALT34.StrType)le.sanctions_program_6),TRIM((SALT34.StrType)le.sanctions_program_7),TRIM((SALT34.StrType)le.sanctions_program_8),TRIM((SALT34.StrType)le.sanctions_program_9),TRIM((SALT34.StrType)le.sanctions_program_10),TRIM((SALT34.StrType)le.passport_details),TRIM((SALT34.StrType)le.ni_number_details),TRIM((SALT34.StrType)le.id_id_1),TRIM((SALT34.StrType)le.id_id_2),TRIM((SALT34.StrType)le.id_id_3),TRIM((SALT34.StrType)le.id_id_4),TRIM((SALT34.StrType)le.id_id_5),TRIM((SALT34.StrType)le.id_id_6),TRIM((SALT34.StrType)le.id_id_7),TRIM((SALT34.StrType)le.id_id_8),TRIM((SALT34.StrType)le.id_id_9),TRIM((SALT34.StrType)le.id_id_10),TRIM((SALT34.StrType)le.id_type_1),TRIM((SALT34.StrType)le.id_type_2),TRIM((SALT34.StrType)le.id_type_3),TRIM((SALT34.StrType)le.id_type_4),TRIM((SALT34.StrType)le.id_type_5),TRIM((SALT34.StrType)le.id_type_6),TRIM((SALT34.StrType)le.id_type_7),TRIM((SALT34.StrType)le.id_type_8),TRIM((SALT34.StrType)le.id_type_9),TRIM((SALT34.StrType)le.id_type_10),TRIM((SALT34.StrType)le.id_number_1),TRIM((SALT34.StrType)le.id_number_2),TRIM((SALT34.StrType)le.id_number_3),TRIM((SALT34.StrType)le.id_number_4),TRIM((SALT34.StrType)le.id_number_5),TRIM((SALT34.StrType)le.id_number_6),TRIM((SALT34.StrType)le.id_number_7),TRIM((SALT34.StrType)le.id_number_8),TRIM((SALT34.StrType)le.id_number_9),TRIM((SALT34.StrType)le.id_number_10),TRIM((SALT34.StrType)le.id_country_1),TRIM((SALT34.StrType)le.id_country_2),TRIM((SALT34.StrType)le.id_country_3),TRIM((SALT34.StrType)le.id_country_4),TRIM((SALT34.StrType)le.id_country_5),TRIM((SALT34.StrType)le.id_country_6),TRIM((SALT34.StrType)le.id_country_7),TRIM((SALT34.StrType)le.id_country_8),TRIM((SALT34.StrType)le.id_country_9),TRIM((SALT34.StrType)le.id_country_10),TRIM((SALT34.StrType)le.id_issue_date_1),TRIM((SALT34.StrType)le.id_issue_date_2),TRIM((SALT34.StrType)le.id_issue_date_3),TRIM((SALT34.StrType)le.id_issue_date_4),TRIM((SALT34.StrType)le.id_issue_date_5),TRIM((SALT34.StrType)le.id_issue_date_6),TRIM((SALT34.StrType)le.id_issue_date_7),TRIM((SALT34.StrType)le.id_issue_date_8),TRIM((SALT34.StrType)le.id_issue_date_9),TRIM((SALT34.StrType)le.id_issue_date_10),TRIM((SALT34.StrType)le.id_expiration_date_1),TRIM((SALT34.StrType)le.id_expiration_date_2),TRIM((SALT34.StrType)le.id_expiration_date_3),TRIM((SALT34.StrType)le.id_expiration_date_4),TRIM((SALT34.StrType)le.id_expiration_date_5),TRIM((SALT34.StrType)le.id_expiration_date_6),TRIM((SALT34.StrType)le.id_expiration_date_7),TRIM((SALT34.StrType)le.id_expiration_date_8),TRIM((SALT34.StrType)le.id_expiration_date_9),TRIM((SALT34.StrType)le.id_expiration_date_10),TRIM((SALT34.StrType)le.nationality_id_1),TRIM((SALT34.StrType)le.nationality_id_2),TRIM((SALT34.StrType)le.nationality_id_3),TRIM((SALT34.StrType)le.nationality_id_4),TRIM((SALT34.StrType)le.nationality_id_5),TRIM((SALT34.StrType)le.nationality_id_6),TRIM((SALT34.StrType)le.nationality_id_7),TRIM((SALT34.StrType)le.nationality_id_8),TRIM((SALT34.StrType)le.nationality_id_9),TRIM((SALT34.StrType)le.nationality_id_10),TRIM((SALT34.StrType)le.nationality_1),TRIM((SALT34.StrType)le.nationality_2),TRIM((SALT34.StrType)le.nationality_3),TRIM((SALT34.StrType)le.nationality_4),TRIM((SALT34.StrType)le.nationality_5),TRIM((SALT34.StrType)le.nationality_6),TRIM((SALT34.StrType)le.nationality_7),TRIM((SALT34.StrType)le.nationality_8),TRIM((SALT34.StrType)le.nationality_9),TRIM((SALT34.StrType)le.nationality_10),TRIM((SALT34.StrType)le.primary_nationality_flag_1),TRIM((SALT34.StrType)le.primary_nationality_flag_2),TRIM((SALT34.StrType)le.primary_nationality_flag_3),TRIM((SALT34.StrType)le.primary_nationality_flag_4),TRIM((SALT34.StrType)le.primary_nationality_flag_5),TRIM((SALT34.StrType)le.primary_nationality_flag_6),TRIM((SALT34.StrType)le.primary_nationality_flag_7),TRIM((SALT34.StrType)le.primary_nationality_flag_8),TRIM((SALT34.StrType)le.primary_nationality_flag_9),TRIM((SALT34.StrType)le.primary_nationality_flag_10),TRIM((SALT34.StrType)le.citizenship_id_1),TRIM((SALT34.StrType)le.citizenship_id_2),TRIM((SALT34.StrType)le.citizenship_id_3),TRIM((SALT34.StrType)le.citizenship_id_4),TRIM((SALT34.StrType)le.citizenship_id_5),TRIM((SALT34.StrType)le.citizenship_id_6),TRIM((SALT34.StrType)le.citizenship_id_7),TRIM((SALT34.StrType)le.citizenship_id_8),TRIM((SALT34.StrType)le.citizenship_id_9),TRIM((SALT34.StrType)le.citizenship_id_10),TRIM((SALT34.StrType)le.citizenship_1),TRIM((SALT34.StrType)le.citizenship_2),TRIM((SALT34.StrType)le.citizenship_3),TRIM((SALT34.StrType)le.citizenship_4),TRIM((SALT34.StrType)le.citizenship_5),TRIM((SALT34.StrType)le.citizenship_6),TRIM((SALT34.StrType)le.citizenship_7),TRIM((SALT34.StrType)le.citizenship_8),TRIM((SALT34.StrType)le.citizenship_9),TRIM((SALT34.StrType)le.citizenship_10),TRIM((SALT34.StrType)le.primary_citizenship_flag_1),TRIM((SALT34.StrType)le.primary_citizenship_flag_2),TRIM((SALT34.StrType)le.primary_citizenship_flag_3),TRIM((SALT34.StrType)le.primary_citizenship_flag_4),TRIM((SALT34.StrType)le.primary_citizenship_flag_5),TRIM((SALT34.StrType)le.primary_citizenship_flag_6),TRIM((SALT34.StrType)le.primary_citizenship_flag_7),TRIM((SALT34.StrType)le.primary_citizenship_flag_8),TRIM((SALT34.StrType)le.primary_citizenship_flag_9),TRIM((SALT34.StrType)le.primary_citizenship_flag_10),TRIM((SALT34.StrType)le.dob_id_1),TRIM((SALT34.StrType)le.dob_id_2),TRIM((SALT34.StrType)le.dob_id_3),TRIM((SALT34.StrType)le.dob_id_4),TRIM((SALT34.StrType)le.dob_id_5),TRIM((SALT34.StrType)le.dob_id_6),TRIM((SALT34.StrType)le.dob_id_7),TRIM((SALT34.StrType)le.dob_id_8),TRIM((SALT34.StrType)le.dob_id_9),TRIM((SALT34.StrType)le.dob_id_10),TRIM((SALT34.StrType)le.dob_1),TRIM((SALT34.StrType)le.dob_2),TRIM((SALT34.StrType)le.dob_3),TRIM((SALT34.StrType)le.dob_4),TRIM((SALT34.StrType)le.dob_5),TRIM((SALT34.StrType)le.dob_6),TRIM((SALT34.StrType)le.dob_7),TRIM((SALT34.StrType)le.dob_8),TRIM((SALT34.StrType)le.dob_9),TRIM((SALT34.StrType)le.dob_10),TRIM((SALT34.StrType)le.primary_dob_flag_1),TRIM((SALT34.StrType)le.primary_dob_flag_2),TRIM((SALT34.StrType)le.primary_dob_flag_3),TRIM((SALT34.StrType)le.primary_dob_flag_4),TRIM((SALT34.StrType)le.primary_dob_flag_5),TRIM((SALT34.StrType)le.primary_dob_flag_6),TRIM((SALT34.StrType)le.primary_dob_flag_7),TRIM((SALT34.StrType)le.primary_dob_flag_8),TRIM((SALT34.StrType)le.primary_dob_flag_9),TRIM((SALT34.StrType)le.primary_dob_flag_10),TRIM((SALT34.StrType)le.pob_id_1),TRIM((SALT34.StrType)le.pob_id_2),TRIM((SALT34.StrType)le.pob_id_3),TRIM((SALT34.StrType)le.pob_id_4),TRIM((SALT34.StrType)le.pob_id_5),TRIM((SALT34.StrType)le.pob_id_6),TRIM((SALT34.StrType)le.pob_id_7),TRIM((SALT34.StrType)le.pob_id_8),TRIM((SALT34.StrType)le.pob_id_9),TRIM((SALT34.StrType)le.pob_id_10),TRIM((SALT34.StrType)le.pob_1),TRIM((SALT34.StrType)le.pob_2),TRIM((SALT34.StrType)le.pob_3),TRIM((SALT34.StrType)le.pob_4),TRIM((SALT34.StrType)le.pob_5),TRIM((SALT34.StrType)le.pob_6),TRIM((SALT34.StrType)le.pob_7),TRIM((SALT34.StrType)le.pob_8),TRIM((SALT34.StrType)le.pob_9),TRIM((SALT34.StrType)le.pob_10),TRIM((SALT34.StrType)le.country_of_birth_1),TRIM((SALT34.StrType)le.country_of_birth_2),TRIM((SALT34.StrType)le.country_of_birth_3),TRIM((SALT34.StrType)le.country_of_birth_4),TRIM((SALT34.StrType)le.country_of_birth_5),TRIM((SALT34.StrType)le.country_of_birth_6),TRIM((SALT34.StrType)le.country_of_birth_7),TRIM((SALT34.StrType)le.country_of_birth_8),TRIM((SALT34.StrType)le.country_of_birth_9),TRIM((SALT34.StrType)le.country_of_birth_10),TRIM((SALT34.StrType)le.primary_pob_flag_1),TRIM((SALT34.StrType)le.primary_pob_flag_2),TRIM((SALT34.StrType)le.primary_pob_flag_3),TRIM((SALT34.StrType)le.primary_pob_flag_4),TRIM((SALT34.StrType)le.primary_pob_flag_5),TRIM((SALT34.StrType)le.primary_pob_flag_6),TRIM((SALT34.StrType)le.primary_pob_flag_7),TRIM((SALT34.StrType)le.primary_pob_flag_8),TRIM((SALT34.StrType)le.primary_pob_flag_9),TRIM((SALT34.StrType)le.primary_pob_flag_10),TRIM((SALT34.StrType)le.language_1),TRIM((SALT34.StrType)le.language_2),TRIM((SALT34.StrType)le.language_3),TRIM((SALT34.StrType)le.language_4),TRIM((SALT34.StrType)le.language_5),TRIM((SALT34.StrType)le.language_6),TRIM((SALT34.StrType)le.language_7),TRIM((SALT34.StrType)le.language_8),TRIM((SALT34.StrType)le.language_9),TRIM((SALT34.StrType)le.language_10),TRIM((SALT34.StrType)le.membership_1),TRIM((SALT34.StrType)le.membership_2),TRIM((SALT34.StrType)le.membership_3),TRIM((SALT34.StrType)le.membership_4),TRIM((SALT34.StrType)le.membership_5),TRIM((SALT34.StrType)le.membership_6),TRIM((SALT34.StrType)le.membership_7),TRIM((SALT34.StrType)le.membership_8),TRIM((SALT34.StrType)le.membership_9),TRIM((SALT34.StrType)le.membership_10),TRIM((SALT34.StrType)le.position_1),TRIM((SALT34.StrType)le.position_2),TRIM((SALT34.StrType)le.position_3),TRIM((SALT34.StrType)le.position_4),TRIM((SALT34.StrType)le.position_5),TRIM((SALT34.StrType)le.position_6),TRIM((SALT34.StrType)le.position_7),TRIM((SALT34.StrType)le.position_8),TRIM((SALT34.StrType)le.position_9),TRIM((SALT34.StrType)le.position_10),TRIM((SALT34.StrType)le.occupation_1),TRIM((SALT34.StrType)le.occupation_2),TRIM((SALT34.StrType)le.occupation_3),TRIM((SALT34.StrType)le.occupation_4),TRIM((SALT34.StrType)le.occupation_5),TRIM((SALT34.StrType)le.occupation_6),TRIM((SALT34.StrType)le.occupation_7),TRIM((SALT34.StrType)le.occupation_8),TRIM((SALT34.StrType)le.occupation_9),TRIM((SALT34.StrType)le.occupation_10),TRIM((SALT34.StrType)le.date_added_to_list),TRIM((SALT34.StrType)le.date_last_updated),TRIM((SALT34.StrType)le.effective_date),TRIM((SALT34.StrType)le.expiration_date),TRIM((SALT34.StrType)le.gender),TRIM((SALT34.StrType)le.grounds),TRIM((SALT34.StrType)le.subj_to_common_pos_2001_931_cfsp_fl),TRIM((SALT34.StrType)le.federal_register_citation_1),TRIM((SALT34.StrType)le.federal_register_citation_2),TRIM((SALT34.StrType)le.federal_register_citation_3),TRIM((SALT34.StrType)le.federal_register_citation_4),TRIM((SALT34.StrType)le.federal_register_citation_5),TRIM((SALT34.StrType)le.federal_register_citation_6),TRIM((SALT34.StrType)le.federal_register_citation_7),TRIM((SALT34.StrType)le.federal_register_citation_8),TRIM((SALT34.StrType)le.federal_register_citation_9),TRIM((SALT34.StrType)le.federal_register_citation_10),TRIM((SALT34.StrType)le.federal_register_citation_date_1),TRIM((SALT34.StrType)le.federal_register_citation_date_2),TRIM((SALT34.StrType)le.federal_register_citation_date_3),TRIM((SALT34.StrType)le.federal_register_citation_date_4),TRIM((SALT34.StrType)le.federal_register_citation_date_5),TRIM((SALT34.StrType)le.federal_register_citation_date_6),TRIM((SALT34.StrType)le.federal_register_citation_date_7),TRIM((SALT34.StrType)le.federal_register_citation_date_8),TRIM((SALT34.StrType)le.federal_register_citation_date_9),TRIM((SALT34.StrType)le.federal_register_citation_date_10),TRIM((SALT34.StrType)le.license_requirement),TRIM((SALT34.StrType)le.license_review_policy),TRIM((SALT34.StrType)le.subordinate_status),TRIM((SALT34.StrType)le.height),TRIM((SALT34.StrType)le.weight),TRIM((SALT34.StrType)le.physique),TRIM((SALT34.StrType)le.hair_color),TRIM((SALT34.StrType)le.eyes),TRIM((SALT34.StrType)le.complexion),TRIM((SALT34.StrType)le.race),TRIM((SALT34.StrType)le.scars_marks),TRIM((SALT34.StrType)le.photo_file),TRIM((SALT34.StrType)le.offenses),TRIM((SALT34.StrType)le.ncic),TRIM((SALT34.StrType)le.warrant_by),TRIM((SALT34.StrType)le.caution),TRIM((SALT34.StrType)le.reward),TRIM((SALT34.StrType)le.type_of_denial),TRIM((SALT34.StrType)le.linked_with_1),TRIM((SALT34.StrType)le.linked_with_2),TRIM((SALT34.StrType)le.linked_with_3),TRIM((SALT34.StrType)le.linked_with_4),TRIM((SALT34.StrType)le.linked_with_5),TRIM((SALT34.StrType)le.linked_with_6),TRIM((SALT34.StrType)le.linked_with_7),TRIM((SALT34.StrType)le.linked_with_8),TRIM((SALT34.StrType)le.linked_with_9),TRIM((SALT34.StrType)le.linked_with_10),TRIM((SALT34.StrType)le.linked_with_id_1),TRIM((SALT34.StrType)le.linked_with_id_2),TRIM((SALT34.StrType)le.linked_with_id_3),TRIM((SALT34.StrType)le.linked_with_id_4),TRIM((SALT34.StrType)le.linked_with_id_5),TRIM((SALT34.StrType)le.linked_with_id_6),TRIM((SALT34.StrType)le.linked_with_id_7),TRIM((SALT34.StrType)le.linked_with_id_8),TRIM((SALT34.StrType)le.linked_with_id_9),TRIM((SALT34.StrType)le.linked_with_id_10),TRIM((SALT34.StrType)le.listing_information),TRIM((SALT34.StrType)le.foreign_principal),TRIM((SALT34.StrType)le.nature_of_service),TRIM((SALT34.StrType)le.activities),TRIM((SALT34.StrType)le.finances),TRIM((SALT34.StrType)le.registrant_terminated_flag),TRIM((SALT34.StrType)le.foreign_principal_terminated_flag),TRIM((SALT34.StrType)le.short_form_terminated_flag),TRIM((SALT34.StrType)le.src_key)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT34.StrType)le.pty_key),TRIM((SALT34.StrType)le.source),TRIM((SALT34.StrType)le.orig_pty_name),TRIM((SALT34.StrType)le.orig_vessel_name),TRIM((SALT34.StrType)le.country),TRIM((SALT34.StrType)le.name_type),TRIM((SALT34.StrType)le.addr_1),TRIM((SALT34.StrType)le.addr_2),TRIM((SALT34.StrType)le.addr_3),TRIM((SALT34.StrType)le.addr_4),TRIM((SALT34.StrType)le.addr_5),TRIM((SALT34.StrType)le.addr_6),TRIM((SALT34.StrType)le.addr_7),TRIM((SALT34.StrType)le.addr_8),TRIM((SALT34.StrType)le.addr_9),TRIM((SALT34.StrType)le.addr_10),TRIM((SALT34.StrType)le.remarks_1),TRIM((SALT34.StrType)le.remarks_2),TRIM((SALT34.StrType)le.remarks_3),TRIM((SALT34.StrType)le.remarks_4),TRIM((SALT34.StrType)le.remarks_5),TRIM((SALT34.StrType)le.remarks_6),TRIM((SALT34.StrType)le.remarks_7),TRIM((SALT34.StrType)le.remarks_8),TRIM((SALT34.StrType)le.remarks_9),TRIM((SALT34.StrType)le.remarks_10),TRIM((SALT34.StrType)le.remarks_11),TRIM((SALT34.StrType)le.remarks_12),TRIM((SALT34.StrType)le.remarks_13),TRIM((SALT34.StrType)le.remarks_14),TRIM((SALT34.StrType)le.remarks_15),TRIM((SALT34.StrType)le.remarks_16),TRIM((SALT34.StrType)le.remarks_17),TRIM((SALT34.StrType)le.remarks_18),TRIM((SALT34.StrType)le.remarks_19),TRIM((SALT34.StrType)le.remarks_20),TRIM((SALT34.StrType)le.remarks_21),TRIM((SALT34.StrType)le.remarks_22),TRIM((SALT34.StrType)le.remarks_23),TRIM((SALT34.StrType)le.remarks_24),TRIM((SALT34.StrType)le.remarks_25),TRIM((SALT34.StrType)le.remarks_26),TRIM((SALT34.StrType)le.remarks_27),TRIM((SALT34.StrType)le.remarks_28),TRIM((SALT34.StrType)le.remarks_29),TRIM((SALT34.StrType)le.remarks_30),TRIM((SALT34.StrType)le.cname),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.suffix),TRIM((SALT34.StrType)le.a_score),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.addr_suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dpbc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.ace_fips_st),TRIM((SALT34.StrType)le.county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat),TRIM((SALT34.StrType)le.date_first_seen),TRIM((SALT34.StrType)le.date_last_seen),TRIM((SALT34.StrType)le.date_vendor_first_reported),TRIM((SALT34.StrType)le.date_vendor_last_reported),TRIM((SALT34.StrType)le.entity_id),TRIM((SALT34.StrType)le.first_name),TRIM((SALT34.StrType)le.last_name),TRIM((SALT34.StrType)le.title_1),TRIM((SALT34.StrType)le.title_2),TRIM((SALT34.StrType)le.title_3),TRIM((SALT34.StrType)le.title_4),TRIM((SALT34.StrType)le.title_5),TRIM((SALT34.StrType)le.title_6),TRIM((SALT34.StrType)le.title_7),TRIM((SALT34.StrType)le.title_8),TRIM((SALT34.StrType)le.title_9),TRIM((SALT34.StrType)le.title_10),TRIM((SALT34.StrType)le.aka_id),TRIM((SALT34.StrType)le.aka_type),TRIM((SALT34.StrType)le.aka_category),TRIM((SALT34.StrType)le.giv_designator),TRIM((SALT34.StrType)le.entity_type),TRIM((SALT34.StrType)le.address_id),TRIM((SALT34.StrType)le.address_line_1),TRIM((SALT34.StrType)le.address_line_2),TRIM((SALT34.StrType)le.address_line_3),TRIM((SALT34.StrType)le.address_city),TRIM((SALT34.StrType)le.address_state_province),TRIM((SALT34.StrType)le.address_postal_code),TRIM((SALT34.StrType)le.address_country),TRIM((SALT34.StrType)le.remarks),TRIM((SALT34.StrType)le.call_sign),TRIM((SALT34.StrType)le.vessel_type),TRIM((SALT34.StrType)le.tonnage),TRIM((SALT34.StrType)le.gross_registered_tonnage),TRIM((SALT34.StrType)le.vessel_flag),TRIM((SALT34.StrType)le.vessel_owner),TRIM((SALT34.StrType)le.sanctions_program_1),TRIM((SALT34.StrType)le.sanctions_program_2),TRIM((SALT34.StrType)le.sanctions_program_3),TRIM((SALT34.StrType)le.sanctions_program_4),TRIM((SALT34.StrType)le.sanctions_program_5),TRIM((SALT34.StrType)le.sanctions_program_6),TRIM((SALT34.StrType)le.sanctions_program_7),TRIM((SALT34.StrType)le.sanctions_program_8),TRIM((SALT34.StrType)le.sanctions_program_9),TRIM((SALT34.StrType)le.sanctions_program_10),TRIM((SALT34.StrType)le.passport_details),TRIM((SALT34.StrType)le.ni_number_details),TRIM((SALT34.StrType)le.id_id_1),TRIM((SALT34.StrType)le.id_id_2),TRIM((SALT34.StrType)le.id_id_3),TRIM((SALT34.StrType)le.id_id_4),TRIM((SALT34.StrType)le.id_id_5),TRIM((SALT34.StrType)le.id_id_6),TRIM((SALT34.StrType)le.id_id_7),TRIM((SALT34.StrType)le.id_id_8),TRIM((SALT34.StrType)le.id_id_9),TRIM((SALT34.StrType)le.id_id_10),TRIM((SALT34.StrType)le.id_type_1),TRIM((SALT34.StrType)le.id_type_2),TRIM((SALT34.StrType)le.id_type_3),TRIM((SALT34.StrType)le.id_type_4),TRIM((SALT34.StrType)le.id_type_5),TRIM((SALT34.StrType)le.id_type_6),TRIM((SALT34.StrType)le.id_type_7),TRIM((SALT34.StrType)le.id_type_8),TRIM((SALT34.StrType)le.id_type_9),TRIM((SALT34.StrType)le.id_type_10),TRIM((SALT34.StrType)le.id_number_1),TRIM((SALT34.StrType)le.id_number_2),TRIM((SALT34.StrType)le.id_number_3),TRIM((SALT34.StrType)le.id_number_4),TRIM((SALT34.StrType)le.id_number_5),TRIM((SALT34.StrType)le.id_number_6),TRIM((SALT34.StrType)le.id_number_7),TRIM((SALT34.StrType)le.id_number_8),TRIM((SALT34.StrType)le.id_number_9),TRIM((SALT34.StrType)le.id_number_10),TRIM((SALT34.StrType)le.id_country_1),TRIM((SALT34.StrType)le.id_country_2),TRIM((SALT34.StrType)le.id_country_3),TRIM((SALT34.StrType)le.id_country_4),TRIM((SALT34.StrType)le.id_country_5),TRIM((SALT34.StrType)le.id_country_6),TRIM((SALT34.StrType)le.id_country_7),TRIM((SALT34.StrType)le.id_country_8),TRIM((SALT34.StrType)le.id_country_9),TRIM((SALT34.StrType)le.id_country_10),TRIM((SALT34.StrType)le.id_issue_date_1),TRIM((SALT34.StrType)le.id_issue_date_2),TRIM((SALT34.StrType)le.id_issue_date_3),TRIM((SALT34.StrType)le.id_issue_date_4),TRIM((SALT34.StrType)le.id_issue_date_5),TRIM((SALT34.StrType)le.id_issue_date_6),TRIM((SALT34.StrType)le.id_issue_date_7),TRIM((SALT34.StrType)le.id_issue_date_8),TRIM((SALT34.StrType)le.id_issue_date_9),TRIM((SALT34.StrType)le.id_issue_date_10),TRIM((SALT34.StrType)le.id_expiration_date_1),TRIM((SALT34.StrType)le.id_expiration_date_2),TRIM((SALT34.StrType)le.id_expiration_date_3),TRIM((SALT34.StrType)le.id_expiration_date_4),TRIM((SALT34.StrType)le.id_expiration_date_5),TRIM((SALT34.StrType)le.id_expiration_date_6),TRIM((SALT34.StrType)le.id_expiration_date_7),TRIM((SALT34.StrType)le.id_expiration_date_8),TRIM((SALT34.StrType)le.id_expiration_date_9),TRIM((SALT34.StrType)le.id_expiration_date_10),TRIM((SALT34.StrType)le.nationality_id_1),TRIM((SALT34.StrType)le.nationality_id_2),TRIM((SALT34.StrType)le.nationality_id_3),TRIM((SALT34.StrType)le.nationality_id_4),TRIM((SALT34.StrType)le.nationality_id_5),TRIM((SALT34.StrType)le.nationality_id_6),TRIM((SALT34.StrType)le.nationality_id_7),TRIM((SALT34.StrType)le.nationality_id_8),TRIM((SALT34.StrType)le.nationality_id_9),TRIM((SALT34.StrType)le.nationality_id_10),TRIM((SALT34.StrType)le.nationality_1),TRIM((SALT34.StrType)le.nationality_2),TRIM((SALT34.StrType)le.nationality_3),TRIM((SALT34.StrType)le.nationality_4),TRIM((SALT34.StrType)le.nationality_5),TRIM((SALT34.StrType)le.nationality_6),TRIM((SALT34.StrType)le.nationality_7),TRIM((SALT34.StrType)le.nationality_8),TRIM((SALT34.StrType)le.nationality_9),TRIM((SALT34.StrType)le.nationality_10),TRIM((SALT34.StrType)le.primary_nationality_flag_1),TRIM((SALT34.StrType)le.primary_nationality_flag_2),TRIM((SALT34.StrType)le.primary_nationality_flag_3),TRIM((SALT34.StrType)le.primary_nationality_flag_4),TRIM((SALT34.StrType)le.primary_nationality_flag_5),TRIM((SALT34.StrType)le.primary_nationality_flag_6),TRIM((SALT34.StrType)le.primary_nationality_flag_7),TRIM((SALT34.StrType)le.primary_nationality_flag_8),TRIM((SALT34.StrType)le.primary_nationality_flag_9),TRIM((SALT34.StrType)le.primary_nationality_flag_10),TRIM((SALT34.StrType)le.citizenship_id_1),TRIM((SALT34.StrType)le.citizenship_id_2),TRIM((SALT34.StrType)le.citizenship_id_3),TRIM((SALT34.StrType)le.citizenship_id_4),TRIM((SALT34.StrType)le.citizenship_id_5),TRIM((SALT34.StrType)le.citizenship_id_6),TRIM((SALT34.StrType)le.citizenship_id_7),TRIM((SALT34.StrType)le.citizenship_id_8),TRIM((SALT34.StrType)le.citizenship_id_9),TRIM((SALT34.StrType)le.citizenship_id_10),TRIM((SALT34.StrType)le.citizenship_1),TRIM((SALT34.StrType)le.citizenship_2),TRIM((SALT34.StrType)le.citizenship_3),TRIM((SALT34.StrType)le.citizenship_4),TRIM((SALT34.StrType)le.citizenship_5),TRIM((SALT34.StrType)le.citizenship_6),TRIM((SALT34.StrType)le.citizenship_7),TRIM((SALT34.StrType)le.citizenship_8),TRIM((SALT34.StrType)le.citizenship_9),TRIM((SALT34.StrType)le.citizenship_10),TRIM((SALT34.StrType)le.primary_citizenship_flag_1),TRIM((SALT34.StrType)le.primary_citizenship_flag_2),TRIM((SALT34.StrType)le.primary_citizenship_flag_3),TRIM((SALT34.StrType)le.primary_citizenship_flag_4),TRIM((SALT34.StrType)le.primary_citizenship_flag_5),TRIM((SALT34.StrType)le.primary_citizenship_flag_6),TRIM((SALT34.StrType)le.primary_citizenship_flag_7),TRIM((SALT34.StrType)le.primary_citizenship_flag_8),TRIM((SALT34.StrType)le.primary_citizenship_flag_9),TRIM((SALT34.StrType)le.primary_citizenship_flag_10),TRIM((SALT34.StrType)le.dob_id_1),TRIM((SALT34.StrType)le.dob_id_2),TRIM((SALT34.StrType)le.dob_id_3),TRIM((SALT34.StrType)le.dob_id_4),TRIM((SALT34.StrType)le.dob_id_5),TRIM((SALT34.StrType)le.dob_id_6),TRIM((SALT34.StrType)le.dob_id_7),TRIM((SALT34.StrType)le.dob_id_8),TRIM((SALT34.StrType)le.dob_id_9),TRIM((SALT34.StrType)le.dob_id_10),TRIM((SALT34.StrType)le.dob_1),TRIM((SALT34.StrType)le.dob_2),TRIM((SALT34.StrType)le.dob_3),TRIM((SALT34.StrType)le.dob_4),TRIM((SALT34.StrType)le.dob_5),TRIM((SALT34.StrType)le.dob_6),TRIM((SALT34.StrType)le.dob_7),TRIM((SALT34.StrType)le.dob_8),TRIM((SALT34.StrType)le.dob_9),TRIM((SALT34.StrType)le.dob_10),TRIM((SALT34.StrType)le.primary_dob_flag_1),TRIM((SALT34.StrType)le.primary_dob_flag_2),TRIM((SALT34.StrType)le.primary_dob_flag_3),TRIM((SALT34.StrType)le.primary_dob_flag_4),TRIM((SALT34.StrType)le.primary_dob_flag_5),TRIM((SALT34.StrType)le.primary_dob_flag_6),TRIM((SALT34.StrType)le.primary_dob_flag_7),TRIM((SALT34.StrType)le.primary_dob_flag_8),TRIM((SALT34.StrType)le.primary_dob_flag_9),TRIM((SALT34.StrType)le.primary_dob_flag_10),TRIM((SALT34.StrType)le.pob_id_1),TRIM((SALT34.StrType)le.pob_id_2),TRIM((SALT34.StrType)le.pob_id_3),TRIM((SALT34.StrType)le.pob_id_4),TRIM((SALT34.StrType)le.pob_id_5),TRIM((SALT34.StrType)le.pob_id_6),TRIM((SALT34.StrType)le.pob_id_7),TRIM((SALT34.StrType)le.pob_id_8),TRIM((SALT34.StrType)le.pob_id_9),TRIM((SALT34.StrType)le.pob_id_10),TRIM((SALT34.StrType)le.pob_1),TRIM((SALT34.StrType)le.pob_2),TRIM((SALT34.StrType)le.pob_3),TRIM((SALT34.StrType)le.pob_4),TRIM((SALT34.StrType)le.pob_5),TRIM((SALT34.StrType)le.pob_6),TRIM((SALT34.StrType)le.pob_7),TRIM((SALT34.StrType)le.pob_8),TRIM((SALT34.StrType)le.pob_9),TRIM((SALT34.StrType)le.pob_10),TRIM((SALT34.StrType)le.country_of_birth_1),TRIM((SALT34.StrType)le.country_of_birth_2),TRIM((SALT34.StrType)le.country_of_birth_3),TRIM((SALT34.StrType)le.country_of_birth_4),TRIM((SALT34.StrType)le.country_of_birth_5),TRIM((SALT34.StrType)le.country_of_birth_6),TRIM((SALT34.StrType)le.country_of_birth_7),TRIM((SALT34.StrType)le.country_of_birth_8),TRIM((SALT34.StrType)le.country_of_birth_9),TRIM((SALT34.StrType)le.country_of_birth_10),TRIM((SALT34.StrType)le.primary_pob_flag_1),TRIM((SALT34.StrType)le.primary_pob_flag_2),TRIM((SALT34.StrType)le.primary_pob_flag_3),TRIM((SALT34.StrType)le.primary_pob_flag_4),TRIM((SALT34.StrType)le.primary_pob_flag_5),TRIM((SALT34.StrType)le.primary_pob_flag_6),TRIM((SALT34.StrType)le.primary_pob_flag_7),TRIM((SALT34.StrType)le.primary_pob_flag_8),TRIM((SALT34.StrType)le.primary_pob_flag_9),TRIM((SALT34.StrType)le.primary_pob_flag_10),TRIM((SALT34.StrType)le.language_1),TRIM((SALT34.StrType)le.language_2),TRIM((SALT34.StrType)le.language_3),TRIM((SALT34.StrType)le.language_4),TRIM((SALT34.StrType)le.language_5),TRIM((SALT34.StrType)le.language_6),TRIM((SALT34.StrType)le.language_7),TRIM((SALT34.StrType)le.language_8),TRIM((SALT34.StrType)le.language_9),TRIM((SALT34.StrType)le.language_10),TRIM((SALT34.StrType)le.membership_1),TRIM((SALT34.StrType)le.membership_2),TRIM((SALT34.StrType)le.membership_3),TRIM((SALT34.StrType)le.membership_4),TRIM((SALT34.StrType)le.membership_5),TRIM((SALT34.StrType)le.membership_6),TRIM((SALT34.StrType)le.membership_7),TRIM((SALT34.StrType)le.membership_8),TRIM((SALT34.StrType)le.membership_9),TRIM((SALT34.StrType)le.membership_10),TRIM((SALT34.StrType)le.position_1),TRIM((SALT34.StrType)le.position_2),TRIM((SALT34.StrType)le.position_3),TRIM((SALT34.StrType)le.position_4),TRIM((SALT34.StrType)le.position_5),TRIM((SALT34.StrType)le.position_6),TRIM((SALT34.StrType)le.position_7),TRIM((SALT34.StrType)le.position_8),TRIM((SALT34.StrType)le.position_9),TRIM((SALT34.StrType)le.position_10),TRIM((SALT34.StrType)le.occupation_1),TRIM((SALT34.StrType)le.occupation_2),TRIM((SALT34.StrType)le.occupation_3),TRIM((SALT34.StrType)le.occupation_4),TRIM((SALT34.StrType)le.occupation_5),TRIM((SALT34.StrType)le.occupation_6),TRIM((SALT34.StrType)le.occupation_7),TRIM((SALT34.StrType)le.occupation_8),TRIM((SALT34.StrType)le.occupation_9),TRIM((SALT34.StrType)le.occupation_10),TRIM((SALT34.StrType)le.date_added_to_list),TRIM((SALT34.StrType)le.date_last_updated),TRIM((SALT34.StrType)le.effective_date),TRIM((SALT34.StrType)le.expiration_date),TRIM((SALT34.StrType)le.gender),TRIM((SALT34.StrType)le.grounds),TRIM((SALT34.StrType)le.subj_to_common_pos_2001_931_cfsp_fl),TRIM((SALT34.StrType)le.federal_register_citation_1),TRIM((SALT34.StrType)le.federal_register_citation_2),TRIM((SALT34.StrType)le.federal_register_citation_3),TRIM((SALT34.StrType)le.federal_register_citation_4),TRIM((SALT34.StrType)le.federal_register_citation_5),TRIM((SALT34.StrType)le.federal_register_citation_6),TRIM((SALT34.StrType)le.federal_register_citation_7),TRIM((SALT34.StrType)le.federal_register_citation_8),TRIM((SALT34.StrType)le.federal_register_citation_9),TRIM((SALT34.StrType)le.federal_register_citation_10),TRIM((SALT34.StrType)le.federal_register_citation_date_1),TRIM((SALT34.StrType)le.federal_register_citation_date_2),TRIM((SALT34.StrType)le.federal_register_citation_date_3),TRIM((SALT34.StrType)le.federal_register_citation_date_4),TRIM((SALT34.StrType)le.federal_register_citation_date_5),TRIM((SALT34.StrType)le.federal_register_citation_date_6),TRIM((SALT34.StrType)le.federal_register_citation_date_7),TRIM((SALT34.StrType)le.federal_register_citation_date_8),TRIM((SALT34.StrType)le.federal_register_citation_date_9),TRIM((SALT34.StrType)le.federal_register_citation_date_10),TRIM((SALT34.StrType)le.license_requirement),TRIM((SALT34.StrType)le.license_review_policy),TRIM((SALT34.StrType)le.subordinate_status),TRIM((SALT34.StrType)le.height),TRIM((SALT34.StrType)le.weight),TRIM((SALT34.StrType)le.physique),TRIM((SALT34.StrType)le.hair_color),TRIM((SALT34.StrType)le.eyes),TRIM((SALT34.StrType)le.complexion),TRIM((SALT34.StrType)le.race),TRIM((SALT34.StrType)le.scars_marks),TRIM((SALT34.StrType)le.photo_file),TRIM((SALT34.StrType)le.offenses),TRIM((SALT34.StrType)le.ncic),TRIM((SALT34.StrType)le.warrant_by),TRIM((SALT34.StrType)le.caution),TRIM((SALT34.StrType)le.reward),TRIM((SALT34.StrType)le.type_of_denial),TRIM((SALT34.StrType)le.linked_with_1),TRIM((SALT34.StrType)le.linked_with_2),TRIM((SALT34.StrType)le.linked_with_3),TRIM((SALT34.StrType)le.linked_with_4),TRIM((SALT34.StrType)le.linked_with_5),TRIM((SALT34.StrType)le.linked_with_6),TRIM((SALT34.StrType)le.linked_with_7),TRIM((SALT34.StrType)le.linked_with_8),TRIM((SALT34.StrType)le.linked_with_9),TRIM((SALT34.StrType)le.linked_with_10),TRIM((SALT34.StrType)le.linked_with_id_1),TRIM((SALT34.StrType)le.linked_with_id_2),TRIM((SALT34.StrType)le.linked_with_id_3),TRIM((SALT34.StrType)le.linked_with_id_4),TRIM((SALT34.StrType)le.linked_with_id_5),TRIM((SALT34.StrType)le.linked_with_id_6),TRIM((SALT34.StrType)le.linked_with_id_7),TRIM((SALT34.StrType)le.linked_with_id_8),TRIM((SALT34.StrType)le.linked_with_id_9),TRIM((SALT34.StrType)le.linked_with_id_10),TRIM((SALT34.StrType)le.listing_information),TRIM((SALT34.StrType)le.foreign_principal),TRIM((SALT34.StrType)le.nature_of_service),TRIM((SALT34.StrType)le.activities),TRIM((SALT34.StrType)le.finances),TRIM((SALT34.StrType)le.registrant_terminated_flag),TRIM((SALT34.StrType)le.foreign_principal_terminated_flag),TRIM((SALT34.StrType)le.short_form_terminated_flag),TRIM((SALT34.StrType)le.src_key)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),433*433,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'pty_key'}
      ,{2,'source'}
      ,{3,'orig_pty_name'}
      ,{4,'orig_vessel_name'}
      ,{5,'country'}
      ,{6,'name_type'}
      ,{7,'addr_1'}
      ,{8,'addr_2'}
      ,{9,'addr_3'}
      ,{10,'addr_4'}
      ,{11,'addr_5'}
      ,{12,'addr_6'}
      ,{13,'addr_7'}
      ,{14,'addr_8'}
      ,{15,'addr_9'}
      ,{16,'addr_10'}
      ,{17,'remarks_1'}
      ,{18,'remarks_2'}
      ,{19,'remarks_3'}
      ,{20,'remarks_4'}
      ,{21,'remarks_5'}
      ,{22,'remarks_6'}
      ,{23,'remarks_7'}
      ,{24,'remarks_8'}
      ,{25,'remarks_9'}
      ,{26,'remarks_10'}
      ,{27,'remarks_11'}
      ,{28,'remarks_12'}
      ,{29,'remarks_13'}
      ,{30,'remarks_14'}
      ,{31,'remarks_15'}
      ,{32,'remarks_16'}
      ,{33,'remarks_17'}
      ,{34,'remarks_18'}
      ,{35,'remarks_19'}
      ,{36,'remarks_20'}
      ,{37,'remarks_21'}
      ,{38,'remarks_22'}
      ,{39,'remarks_23'}
      ,{40,'remarks_24'}
      ,{41,'remarks_25'}
      ,{42,'remarks_26'}
      ,{43,'remarks_27'}
      ,{44,'remarks_28'}
      ,{45,'remarks_29'}
      ,{46,'remarks_30'}
      ,{47,'cname'}
      ,{48,'title'}
      ,{49,'fname'}
      ,{50,'mname'}
      ,{51,'lname'}
      ,{52,'suffix'}
      ,{53,'a_score'}
      ,{54,'prim_range'}
      ,{55,'predir'}
      ,{56,'prim_name'}
      ,{57,'addr_suffix'}
      ,{58,'postdir'}
      ,{59,'unit_desig'}
      ,{60,'sec_range'}
      ,{61,'p_city_name'}
      ,{62,'v_city_name'}
      ,{63,'st'}
      ,{64,'zip'}
      ,{65,'zip4'}
      ,{66,'cart'}
      ,{67,'cr_sort_sz'}
      ,{68,'lot'}
      ,{69,'lot_order'}
      ,{70,'dpbc'}
      ,{71,'chk_digit'}
      ,{72,'record_type'}
      ,{73,'ace_fips_st'}
      ,{74,'county'}
      ,{75,'geo_lat'}
      ,{76,'geo_long'}
      ,{77,'msa'}
      ,{78,'geo_blk'}
      ,{79,'geo_match'}
      ,{80,'err_stat'}
      ,{81,'date_first_seen'}
      ,{82,'date_last_seen'}
      ,{83,'date_vendor_first_reported'}
      ,{84,'date_vendor_last_reported'}
      ,{85,'entity_id'}
      ,{86,'first_name'}
      ,{87,'last_name'}
      ,{88,'title_1'}
      ,{89,'title_2'}
      ,{90,'title_3'}
      ,{91,'title_4'}
      ,{92,'title_5'}
      ,{93,'title_6'}
      ,{94,'title_7'}
      ,{95,'title_8'}
      ,{96,'title_9'}
      ,{97,'title_10'}
      ,{98,'aka_id'}
      ,{99,'aka_type'}
      ,{100,'aka_category'}
      ,{101,'giv_designator'}
      ,{102,'entity_type'}
      ,{103,'address_id'}
      ,{104,'address_line_1'}
      ,{105,'address_line_2'}
      ,{106,'address_line_3'}
      ,{107,'address_city'}
      ,{108,'address_state_province'}
      ,{109,'address_postal_code'}
      ,{110,'address_country'}
      ,{111,'remarks'}
      ,{112,'call_sign'}
      ,{113,'vessel_type'}
      ,{114,'tonnage'}
      ,{115,'gross_registered_tonnage'}
      ,{116,'vessel_flag'}
      ,{117,'vessel_owner'}
      ,{118,'sanctions_program_1'}
      ,{119,'sanctions_program_2'}
      ,{120,'sanctions_program_3'}
      ,{121,'sanctions_program_4'}
      ,{122,'sanctions_program_5'}
      ,{123,'sanctions_program_6'}
      ,{124,'sanctions_program_7'}
      ,{125,'sanctions_program_8'}
      ,{126,'sanctions_program_9'}
      ,{127,'sanctions_program_10'}
      ,{128,'passport_details'}
      ,{129,'ni_number_details'}
      ,{130,'id_id_1'}
      ,{131,'id_id_2'}
      ,{132,'id_id_3'}
      ,{133,'id_id_4'}
      ,{134,'id_id_5'}
      ,{135,'id_id_6'}
      ,{136,'id_id_7'}
      ,{137,'id_id_8'}
      ,{138,'id_id_9'}
      ,{139,'id_id_10'}
      ,{140,'id_type_1'}
      ,{141,'id_type_2'}
      ,{142,'id_type_3'}
      ,{143,'id_type_4'}
      ,{144,'id_type_5'}
      ,{145,'id_type_6'}
      ,{146,'id_type_7'}
      ,{147,'id_type_8'}
      ,{148,'id_type_9'}
      ,{149,'id_type_10'}
      ,{150,'id_number_1'}
      ,{151,'id_number_2'}
      ,{152,'id_number_3'}
      ,{153,'id_number_4'}
      ,{154,'id_number_5'}
      ,{155,'id_number_6'}
      ,{156,'id_number_7'}
      ,{157,'id_number_8'}
      ,{158,'id_number_9'}
      ,{159,'id_number_10'}
      ,{160,'id_country_1'}
      ,{161,'id_country_2'}
      ,{162,'id_country_3'}
      ,{163,'id_country_4'}
      ,{164,'id_country_5'}
      ,{165,'id_country_6'}
      ,{166,'id_country_7'}
      ,{167,'id_country_8'}
      ,{168,'id_country_9'}
      ,{169,'id_country_10'}
      ,{170,'id_issue_date_1'}
      ,{171,'id_issue_date_2'}
      ,{172,'id_issue_date_3'}
      ,{173,'id_issue_date_4'}
      ,{174,'id_issue_date_5'}
      ,{175,'id_issue_date_6'}
      ,{176,'id_issue_date_7'}
      ,{177,'id_issue_date_8'}
      ,{178,'id_issue_date_9'}
      ,{179,'id_issue_date_10'}
      ,{180,'id_expiration_date_1'}
      ,{181,'id_expiration_date_2'}
      ,{182,'id_expiration_date_3'}
      ,{183,'id_expiration_date_4'}
      ,{184,'id_expiration_date_5'}
      ,{185,'id_expiration_date_6'}
      ,{186,'id_expiration_date_7'}
      ,{187,'id_expiration_date_8'}
      ,{188,'id_expiration_date_9'}
      ,{189,'id_expiration_date_10'}
      ,{190,'nationality_id_1'}
      ,{191,'nationality_id_2'}
      ,{192,'nationality_id_3'}
      ,{193,'nationality_id_4'}
      ,{194,'nationality_id_5'}
      ,{195,'nationality_id_6'}
      ,{196,'nationality_id_7'}
      ,{197,'nationality_id_8'}
      ,{198,'nationality_id_9'}
      ,{199,'nationality_id_10'}
      ,{200,'nationality_1'}
      ,{201,'nationality_2'}
      ,{202,'nationality_3'}
      ,{203,'nationality_4'}
      ,{204,'nationality_5'}
      ,{205,'nationality_6'}
      ,{206,'nationality_7'}
      ,{207,'nationality_8'}
      ,{208,'nationality_9'}
      ,{209,'nationality_10'}
      ,{210,'primary_nationality_flag_1'}
      ,{211,'primary_nationality_flag_2'}
      ,{212,'primary_nationality_flag_3'}
      ,{213,'primary_nationality_flag_4'}
      ,{214,'primary_nationality_flag_5'}
      ,{215,'primary_nationality_flag_6'}
      ,{216,'primary_nationality_flag_7'}
      ,{217,'primary_nationality_flag_8'}
      ,{218,'primary_nationality_flag_9'}
      ,{219,'primary_nationality_flag_10'}
      ,{220,'citizenship_id_1'}
      ,{221,'citizenship_id_2'}
      ,{222,'citizenship_id_3'}
      ,{223,'citizenship_id_4'}
      ,{224,'citizenship_id_5'}
      ,{225,'citizenship_id_6'}
      ,{226,'citizenship_id_7'}
      ,{227,'citizenship_id_8'}
      ,{228,'citizenship_id_9'}
      ,{229,'citizenship_id_10'}
      ,{230,'citizenship_1'}
      ,{231,'citizenship_2'}
      ,{232,'citizenship_3'}
      ,{233,'citizenship_4'}
      ,{234,'citizenship_5'}
      ,{235,'citizenship_6'}
      ,{236,'citizenship_7'}
      ,{237,'citizenship_8'}
      ,{238,'citizenship_9'}
      ,{239,'citizenship_10'}
      ,{240,'primary_citizenship_flag_1'}
      ,{241,'primary_citizenship_flag_2'}
      ,{242,'primary_citizenship_flag_3'}
      ,{243,'primary_citizenship_flag_4'}
      ,{244,'primary_citizenship_flag_5'}
      ,{245,'primary_citizenship_flag_6'}
      ,{246,'primary_citizenship_flag_7'}
      ,{247,'primary_citizenship_flag_8'}
      ,{248,'primary_citizenship_flag_9'}
      ,{249,'primary_citizenship_flag_10'}
      ,{250,'dob_id_1'}
      ,{251,'dob_id_2'}
      ,{252,'dob_id_3'}
      ,{253,'dob_id_4'}
      ,{254,'dob_id_5'}
      ,{255,'dob_id_6'}
      ,{256,'dob_id_7'}
      ,{257,'dob_id_8'}
      ,{258,'dob_id_9'}
      ,{259,'dob_id_10'}
      ,{260,'dob_1'}
      ,{261,'dob_2'}
      ,{262,'dob_3'}
      ,{263,'dob_4'}
      ,{264,'dob_5'}
      ,{265,'dob_6'}
      ,{266,'dob_7'}
      ,{267,'dob_8'}
      ,{268,'dob_9'}
      ,{269,'dob_10'}
      ,{270,'primary_dob_flag_1'}
      ,{271,'primary_dob_flag_2'}
      ,{272,'primary_dob_flag_3'}
      ,{273,'primary_dob_flag_4'}
      ,{274,'primary_dob_flag_5'}
      ,{275,'primary_dob_flag_6'}
      ,{276,'primary_dob_flag_7'}
      ,{277,'primary_dob_flag_8'}
      ,{278,'primary_dob_flag_9'}
      ,{279,'primary_dob_flag_10'}
      ,{280,'pob_id_1'}
      ,{281,'pob_id_2'}
      ,{282,'pob_id_3'}
      ,{283,'pob_id_4'}
      ,{284,'pob_id_5'}
      ,{285,'pob_id_6'}
      ,{286,'pob_id_7'}
      ,{287,'pob_id_8'}
      ,{288,'pob_id_9'}
      ,{289,'pob_id_10'}
      ,{290,'pob_1'}
      ,{291,'pob_2'}
      ,{292,'pob_3'}
      ,{293,'pob_4'}
      ,{294,'pob_5'}
      ,{295,'pob_6'}
      ,{296,'pob_7'}
      ,{297,'pob_8'}
      ,{298,'pob_9'}
      ,{299,'pob_10'}
      ,{300,'country_of_birth_1'}
      ,{301,'country_of_birth_2'}
      ,{302,'country_of_birth_3'}
      ,{303,'country_of_birth_4'}
      ,{304,'country_of_birth_5'}
      ,{305,'country_of_birth_6'}
      ,{306,'country_of_birth_7'}
      ,{307,'country_of_birth_8'}
      ,{308,'country_of_birth_9'}
      ,{309,'country_of_birth_10'}
      ,{310,'primary_pob_flag_1'}
      ,{311,'primary_pob_flag_2'}
      ,{312,'primary_pob_flag_3'}
      ,{313,'primary_pob_flag_4'}
      ,{314,'primary_pob_flag_5'}
      ,{315,'primary_pob_flag_6'}
      ,{316,'primary_pob_flag_7'}
      ,{317,'primary_pob_flag_8'}
      ,{318,'primary_pob_flag_9'}
      ,{319,'primary_pob_flag_10'}
      ,{320,'language_1'}
      ,{321,'language_2'}
      ,{322,'language_3'}
      ,{323,'language_4'}
      ,{324,'language_5'}
      ,{325,'language_6'}
      ,{326,'language_7'}
      ,{327,'language_8'}
      ,{328,'language_9'}
      ,{329,'language_10'}
      ,{330,'membership_1'}
      ,{331,'membership_2'}
      ,{332,'membership_3'}
      ,{333,'membership_4'}
      ,{334,'membership_5'}
      ,{335,'membership_6'}
      ,{336,'membership_7'}
      ,{337,'membership_8'}
      ,{338,'membership_9'}
      ,{339,'membership_10'}
      ,{340,'position_1'}
      ,{341,'position_2'}
      ,{342,'position_3'}
      ,{343,'position_4'}
      ,{344,'position_5'}
      ,{345,'position_6'}
      ,{346,'position_7'}
      ,{347,'position_8'}
      ,{348,'position_9'}
      ,{349,'position_10'}
      ,{350,'occupation_1'}
      ,{351,'occupation_2'}
      ,{352,'occupation_3'}
      ,{353,'occupation_4'}
      ,{354,'occupation_5'}
      ,{355,'occupation_6'}
      ,{356,'occupation_7'}
      ,{357,'occupation_8'}
      ,{358,'occupation_9'}
      ,{359,'occupation_10'}
      ,{360,'date_added_to_list'}
      ,{361,'date_last_updated'}
      ,{362,'effective_date'}
      ,{363,'expiration_date'}
      ,{364,'gender'}
      ,{365,'grounds'}
      ,{366,'subj_to_common_pos_2001_931_cfsp_fl'}
      ,{367,'federal_register_citation_1'}
      ,{368,'federal_register_citation_2'}
      ,{369,'federal_register_citation_3'}
      ,{370,'federal_register_citation_4'}
      ,{371,'federal_register_citation_5'}
      ,{372,'federal_register_citation_6'}
      ,{373,'federal_register_citation_7'}
      ,{374,'federal_register_citation_8'}
      ,{375,'federal_register_citation_9'}
      ,{376,'federal_register_citation_10'}
      ,{377,'federal_register_citation_date_1'}
      ,{378,'federal_register_citation_date_2'}
      ,{379,'federal_register_citation_date_3'}
      ,{380,'federal_register_citation_date_4'}
      ,{381,'federal_register_citation_date_5'}
      ,{382,'federal_register_citation_date_6'}
      ,{383,'federal_register_citation_date_7'}
      ,{384,'federal_register_citation_date_8'}
      ,{385,'federal_register_citation_date_9'}
      ,{386,'federal_register_citation_date_10'}
      ,{387,'license_requirement'}
      ,{388,'license_review_policy'}
      ,{389,'subordinate_status'}
      ,{390,'height'}
      ,{391,'weight'}
      ,{392,'physique'}
      ,{393,'hair_color'}
      ,{394,'eyes'}
      ,{395,'complexion'}
      ,{396,'race'}
      ,{397,'scars_marks'}
      ,{398,'photo_file'}
      ,{399,'offenses'}
      ,{400,'ncic'}
      ,{401,'warrant_by'}
      ,{402,'caution'}
      ,{403,'reward'}
      ,{404,'type_of_denial'}
      ,{405,'linked_with_1'}
      ,{406,'linked_with_2'}
      ,{407,'linked_with_3'}
      ,{408,'linked_with_4'}
      ,{409,'linked_with_5'}
      ,{410,'linked_with_6'}
      ,{411,'linked_with_7'}
      ,{412,'linked_with_8'}
      ,{413,'linked_with_9'}
      ,{414,'linked_with_10'}
      ,{415,'linked_with_id_1'}
      ,{416,'linked_with_id_2'}
      ,{417,'linked_with_id_3'}
      ,{418,'linked_with_id_4'}
      ,{419,'linked_with_id_5'}
      ,{420,'linked_with_id_6'}
      ,{421,'linked_with_id_7'}
      ,{422,'linked_with_id_8'}
      ,{423,'linked_with_id_9'}
      ,{424,'linked_with_id_10'}
      ,{425,'listing_information'}
      ,{426,'foreign_principal'}
      ,{427,'nature_of_service'}
      ,{428,'activities'}
      ,{429,'finances'}
      ,{430,'registrant_terminated_flag'}
      ,{431,'foreign_principal_terminated_flag'}
      ,{432,'short_form_terminated_flag'}
      ,{433,'src_key'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.src_key) src_key; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_pty_key((SALT34.StrType)le.pty_key),
    Fields.InValid_source((SALT34.StrType)le.source),
    Fields.InValid_orig_pty_name((SALT34.StrType)le.orig_pty_name),
    Fields.InValid_orig_vessel_name((SALT34.StrType)le.orig_vessel_name),
    Fields.InValid_country((SALT34.StrType)le.country),
    Fields.InValid_name_type((SALT34.StrType)le.name_type),
    Fields.InValid_addr_1((SALT34.StrType)le.addr_1),
    Fields.InValid_addr_2((SALT34.StrType)le.addr_2),
    Fields.InValid_addr_3((SALT34.StrType)le.addr_3),
    Fields.InValid_addr_4((SALT34.StrType)le.addr_4),
    Fields.InValid_addr_5((SALT34.StrType)le.addr_5),
    Fields.InValid_addr_6((SALT34.StrType)le.addr_6),
    Fields.InValid_addr_7((SALT34.StrType)le.addr_7),
    Fields.InValid_addr_8((SALT34.StrType)le.addr_8),
    Fields.InValid_addr_9((SALT34.StrType)le.addr_9),
    Fields.InValid_addr_10((SALT34.StrType)le.addr_10),
    Fields.InValid_remarks_1((SALT34.StrType)le.remarks_1),
    Fields.InValid_remarks_2((SALT34.StrType)le.remarks_2),
    Fields.InValid_remarks_3((SALT34.StrType)le.remarks_3),
    Fields.InValid_remarks_4((SALT34.StrType)le.remarks_4),
    Fields.InValid_remarks_5((SALT34.StrType)le.remarks_5),
    Fields.InValid_remarks_6((SALT34.StrType)le.remarks_6),
    Fields.InValid_remarks_7((SALT34.StrType)le.remarks_7),
    Fields.InValid_remarks_8((SALT34.StrType)le.remarks_8),
    Fields.InValid_remarks_9((SALT34.StrType)le.remarks_9),
    Fields.InValid_remarks_10((SALT34.StrType)le.remarks_10),
    Fields.InValid_remarks_11((SALT34.StrType)le.remarks_11),
    Fields.InValid_remarks_12((SALT34.StrType)le.remarks_12),
    Fields.InValid_remarks_13((SALT34.StrType)le.remarks_13),
    Fields.InValid_remarks_14((SALT34.StrType)le.remarks_14),
    Fields.InValid_remarks_15((SALT34.StrType)le.remarks_15),
    Fields.InValid_remarks_16((SALT34.StrType)le.remarks_16),
    Fields.InValid_remarks_17((SALT34.StrType)le.remarks_17),
    Fields.InValid_remarks_18((SALT34.StrType)le.remarks_18),
    Fields.InValid_remarks_19((SALT34.StrType)le.remarks_19),
    Fields.InValid_remarks_20((SALT34.StrType)le.remarks_20),
    Fields.InValid_remarks_21((SALT34.StrType)le.remarks_21),
    Fields.InValid_remarks_22((SALT34.StrType)le.remarks_22),
    Fields.InValid_remarks_23((SALT34.StrType)le.remarks_23),
    Fields.InValid_remarks_24((SALT34.StrType)le.remarks_24),
    Fields.InValid_remarks_25((SALT34.StrType)le.remarks_25),
    Fields.InValid_remarks_26((SALT34.StrType)le.remarks_26),
    Fields.InValid_remarks_27((SALT34.StrType)le.remarks_27),
    Fields.InValid_remarks_28((SALT34.StrType)le.remarks_28),
    Fields.InValid_remarks_29((SALT34.StrType)le.remarks_29),
    Fields.InValid_remarks_30((SALT34.StrType)le.remarks_30),
    Fields.InValid_cname((SALT34.StrType)le.cname),
    Fields.InValid_title((SALT34.StrType)le.title),
    Fields.InValid_fname((SALT34.StrType)le.fname),
    Fields.InValid_mname((SALT34.StrType)le.mname),
    Fields.InValid_lname((SALT34.StrType)le.lname),
    Fields.InValid_suffix((SALT34.StrType)le.suffix),
    Fields.InValid_a_score((SALT34.StrType)le.a_score),
    Fields.InValid_prim_range((SALT34.StrType)le.prim_range),
    Fields.InValid_predir((SALT34.StrType)le.predir),
    Fields.InValid_prim_name((SALT34.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT34.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT34.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT34.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT34.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT34.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT34.StrType)le.v_city_name),
    Fields.InValid_st((SALT34.StrType)le.st),
    Fields.InValid_zip((SALT34.StrType)le.zip),
    Fields.InValid_zip4((SALT34.StrType)le.zip4),
    Fields.InValid_cart((SALT34.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT34.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT34.StrType)le.lot),
    Fields.InValid_lot_order((SALT34.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT34.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT34.StrType)le.chk_digit),
    Fields.InValid_record_type((SALT34.StrType)le.record_type),
    Fields.InValid_ace_fips_st((SALT34.StrType)le.ace_fips_st),
    Fields.InValid_county((SALT34.StrType)le.county),
    Fields.InValid_geo_lat((SALT34.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT34.StrType)le.geo_long),
    Fields.InValid_msa((SALT34.StrType)le.msa),
    Fields.InValid_geo_blk((SALT34.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT34.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT34.StrType)le.err_stat),
    Fields.InValid_date_first_seen((SALT34.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT34.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT34.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT34.StrType)le.date_vendor_last_reported),
    Fields.InValid_entity_id((SALT34.StrType)le.entity_id),
    Fields.InValid_first_name((SALT34.StrType)le.first_name),
    Fields.InValid_last_name((SALT34.StrType)le.last_name),
    Fields.InValid_title_1((SALT34.StrType)le.title_1),
    Fields.InValid_title_2((SALT34.StrType)le.title_2),
    Fields.InValid_title_3((SALT34.StrType)le.title_3),
    Fields.InValid_title_4((SALT34.StrType)le.title_4),
    Fields.InValid_title_5((SALT34.StrType)le.title_5),
    Fields.InValid_title_6((SALT34.StrType)le.title_6),
    Fields.InValid_title_7((SALT34.StrType)le.title_7),
    Fields.InValid_title_8((SALT34.StrType)le.title_8),
    Fields.InValid_title_9((SALT34.StrType)le.title_9),
    Fields.InValid_title_10((SALT34.StrType)le.title_10),
    Fields.InValid_aka_id((SALT34.StrType)le.aka_id),
    Fields.InValid_aka_type((SALT34.StrType)le.aka_type),
    Fields.InValid_aka_category((SALT34.StrType)le.aka_category),
    Fields.InValid_giv_designator((SALT34.StrType)le.giv_designator),
    Fields.InValid_entity_type((SALT34.StrType)le.entity_type),
    Fields.InValid_address_id((SALT34.StrType)le.address_id),
    Fields.InValid_address_line_1((SALT34.StrType)le.address_line_1),
    Fields.InValid_address_line_2((SALT34.StrType)le.address_line_2),
    Fields.InValid_address_line_3((SALT34.StrType)le.address_line_3),
    Fields.InValid_address_city((SALT34.StrType)le.address_city),
    Fields.InValid_address_state_province((SALT34.StrType)le.address_state_province),
    Fields.InValid_address_postal_code((SALT34.StrType)le.address_postal_code),
    Fields.InValid_address_country((SALT34.StrType)le.address_country),
    Fields.InValid_remarks((SALT34.StrType)le.remarks),
    Fields.InValid_call_sign((SALT34.StrType)le.call_sign),
    Fields.InValid_vessel_type((SALT34.StrType)le.vessel_type),
    Fields.InValid_tonnage((SALT34.StrType)le.tonnage),
    Fields.InValid_gross_registered_tonnage((SALT34.StrType)le.gross_registered_tonnage),
    Fields.InValid_vessel_flag((SALT34.StrType)le.vessel_flag),
    Fields.InValid_vessel_owner((SALT34.StrType)le.vessel_owner),
    Fields.InValid_sanctions_program_1((SALT34.StrType)le.sanctions_program_1),
    Fields.InValid_sanctions_program_2((SALT34.StrType)le.sanctions_program_2),
    Fields.InValid_sanctions_program_3((SALT34.StrType)le.sanctions_program_3),
    Fields.InValid_sanctions_program_4((SALT34.StrType)le.sanctions_program_4),
    Fields.InValid_sanctions_program_5((SALT34.StrType)le.sanctions_program_5),
    Fields.InValid_sanctions_program_6((SALT34.StrType)le.sanctions_program_6),
    Fields.InValid_sanctions_program_7((SALT34.StrType)le.sanctions_program_7),
    Fields.InValid_sanctions_program_8((SALT34.StrType)le.sanctions_program_8),
    Fields.InValid_sanctions_program_9((SALT34.StrType)le.sanctions_program_9),
    Fields.InValid_sanctions_program_10((SALT34.StrType)le.sanctions_program_10),
    Fields.InValid_passport_details((SALT34.StrType)le.passport_details),
    Fields.InValid_ni_number_details((SALT34.StrType)le.ni_number_details),
    Fields.InValid_id_id_1((SALT34.StrType)le.id_id_1),
    Fields.InValid_id_id_2((SALT34.StrType)le.id_id_2),
    Fields.InValid_id_id_3((SALT34.StrType)le.id_id_3),
    Fields.InValid_id_id_4((SALT34.StrType)le.id_id_4),
    Fields.InValid_id_id_5((SALT34.StrType)le.id_id_5),
    Fields.InValid_id_id_6((SALT34.StrType)le.id_id_6),
    Fields.InValid_id_id_7((SALT34.StrType)le.id_id_7),
    Fields.InValid_id_id_8((SALT34.StrType)le.id_id_8),
    Fields.InValid_id_id_9((SALT34.StrType)le.id_id_9),
    Fields.InValid_id_id_10((SALT34.StrType)le.id_id_10),
    Fields.InValid_id_type_1((SALT34.StrType)le.id_type_1),
    Fields.InValid_id_type_2((SALT34.StrType)le.id_type_2),
    Fields.InValid_id_type_3((SALT34.StrType)le.id_type_3),
    Fields.InValid_id_type_4((SALT34.StrType)le.id_type_4),
    Fields.InValid_id_type_5((SALT34.StrType)le.id_type_5),
    Fields.InValid_id_type_6((SALT34.StrType)le.id_type_6),
    Fields.InValid_id_type_7((SALT34.StrType)le.id_type_7),
    Fields.InValid_id_type_8((SALT34.StrType)le.id_type_8),
    Fields.InValid_id_type_9((SALT34.StrType)le.id_type_9),
    Fields.InValid_id_type_10((SALT34.StrType)le.id_type_10),
    Fields.InValid_id_number_1((SALT34.StrType)le.id_number_1),
    Fields.InValid_id_number_2((SALT34.StrType)le.id_number_2),
    Fields.InValid_id_number_3((SALT34.StrType)le.id_number_3),
    Fields.InValid_id_number_4((SALT34.StrType)le.id_number_4),
    Fields.InValid_id_number_5((SALT34.StrType)le.id_number_5),
    Fields.InValid_id_number_6((SALT34.StrType)le.id_number_6),
    Fields.InValid_id_number_7((SALT34.StrType)le.id_number_7),
    Fields.InValid_id_number_8((SALT34.StrType)le.id_number_8),
    Fields.InValid_id_number_9((SALT34.StrType)le.id_number_9),
    Fields.InValid_id_number_10((SALT34.StrType)le.id_number_10),
    Fields.InValid_id_country_1((SALT34.StrType)le.id_country_1),
    Fields.InValid_id_country_2((SALT34.StrType)le.id_country_2),
    Fields.InValid_id_country_3((SALT34.StrType)le.id_country_3),
    Fields.InValid_id_country_4((SALT34.StrType)le.id_country_4),
    Fields.InValid_id_country_5((SALT34.StrType)le.id_country_5),
    Fields.InValid_id_country_6((SALT34.StrType)le.id_country_6),
    Fields.InValid_id_country_7((SALT34.StrType)le.id_country_7),
    Fields.InValid_id_country_8((SALT34.StrType)le.id_country_8),
    Fields.InValid_id_country_9((SALT34.StrType)le.id_country_9),
    Fields.InValid_id_country_10((SALT34.StrType)le.id_country_10),
    Fields.InValid_id_issue_date_1((SALT34.StrType)le.id_issue_date_1),
    Fields.InValid_id_issue_date_2((SALT34.StrType)le.id_issue_date_2),
    Fields.InValid_id_issue_date_3((SALT34.StrType)le.id_issue_date_3),
    Fields.InValid_id_issue_date_4((SALT34.StrType)le.id_issue_date_4),
    Fields.InValid_id_issue_date_5((SALT34.StrType)le.id_issue_date_5),
    Fields.InValid_id_issue_date_6((SALT34.StrType)le.id_issue_date_6),
    Fields.InValid_id_issue_date_7((SALT34.StrType)le.id_issue_date_7),
    Fields.InValid_id_issue_date_8((SALT34.StrType)le.id_issue_date_8),
    Fields.InValid_id_issue_date_9((SALT34.StrType)le.id_issue_date_9),
    Fields.InValid_id_issue_date_10((SALT34.StrType)le.id_issue_date_10),
    Fields.InValid_id_expiration_date_1((SALT34.StrType)le.id_expiration_date_1),
    Fields.InValid_id_expiration_date_2((SALT34.StrType)le.id_expiration_date_2),
    Fields.InValid_id_expiration_date_3((SALT34.StrType)le.id_expiration_date_3),
    Fields.InValid_id_expiration_date_4((SALT34.StrType)le.id_expiration_date_4),
    Fields.InValid_id_expiration_date_5((SALT34.StrType)le.id_expiration_date_5),
    Fields.InValid_id_expiration_date_6((SALT34.StrType)le.id_expiration_date_6),
    Fields.InValid_id_expiration_date_7((SALT34.StrType)le.id_expiration_date_7),
    Fields.InValid_id_expiration_date_8((SALT34.StrType)le.id_expiration_date_8),
    Fields.InValid_id_expiration_date_9((SALT34.StrType)le.id_expiration_date_9),
    Fields.InValid_id_expiration_date_10((SALT34.StrType)le.id_expiration_date_10),
    Fields.InValid_nationality_id_1((SALT34.StrType)le.nationality_id_1),
    Fields.InValid_nationality_id_2((SALT34.StrType)le.nationality_id_2),
    Fields.InValid_nationality_id_3((SALT34.StrType)le.nationality_id_3),
    Fields.InValid_nationality_id_4((SALT34.StrType)le.nationality_id_4),
    Fields.InValid_nationality_id_5((SALT34.StrType)le.nationality_id_5),
    Fields.InValid_nationality_id_6((SALT34.StrType)le.nationality_id_6),
    Fields.InValid_nationality_id_7((SALT34.StrType)le.nationality_id_7),
    Fields.InValid_nationality_id_8((SALT34.StrType)le.nationality_id_8),
    Fields.InValid_nationality_id_9((SALT34.StrType)le.nationality_id_9),
    Fields.InValid_nationality_id_10((SALT34.StrType)le.nationality_id_10),
    Fields.InValid_nationality_1((SALT34.StrType)le.nationality_1),
    Fields.InValid_nationality_2((SALT34.StrType)le.nationality_2),
    Fields.InValid_nationality_3((SALT34.StrType)le.nationality_3),
    Fields.InValid_nationality_4((SALT34.StrType)le.nationality_4),
    Fields.InValid_nationality_5((SALT34.StrType)le.nationality_5),
    Fields.InValid_nationality_6((SALT34.StrType)le.nationality_6),
    Fields.InValid_nationality_7((SALT34.StrType)le.nationality_7),
    Fields.InValid_nationality_8((SALT34.StrType)le.nationality_8),
    Fields.InValid_nationality_9((SALT34.StrType)le.nationality_9),
    Fields.InValid_nationality_10((SALT34.StrType)le.nationality_10),
    Fields.InValid_primary_nationality_flag_1((SALT34.StrType)le.primary_nationality_flag_1),
    Fields.InValid_primary_nationality_flag_2((SALT34.StrType)le.primary_nationality_flag_2),
    Fields.InValid_primary_nationality_flag_3((SALT34.StrType)le.primary_nationality_flag_3),
    Fields.InValid_primary_nationality_flag_4((SALT34.StrType)le.primary_nationality_flag_4),
    Fields.InValid_primary_nationality_flag_5((SALT34.StrType)le.primary_nationality_flag_5),
    Fields.InValid_primary_nationality_flag_6((SALT34.StrType)le.primary_nationality_flag_6),
    Fields.InValid_primary_nationality_flag_7((SALT34.StrType)le.primary_nationality_flag_7),
    Fields.InValid_primary_nationality_flag_8((SALT34.StrType)le.primary_nationality_flag_8),
    Fields.InValid_primary_nationality_flag_9((SALT34.StrType)le.primary_nationality_flag_9),
    Fields.InValid_primary_nationality_flag_10((SALT34.StrType)le.primary_nationality_flag_10),
    Fields.InValid_citizenship_id_1((SALT34.StrType)le.citizenship_id_1),
    Fields.InValid_citizenship_id_2((SALT34.StrType)le.citizenship_id_2),
    Fields.InValid_citizenship_id_3((SALT34.StrType)le.citizenship_id_3),
    Fields.InValid_citizenship_id_4((SALT34.StrType)le.citizenship_id_4),
    Fields.InValid_citizenship_id_5((SALT34.StrType)le.citizenship_id_5),
    Fields.InValid_citizenship_id_6((SALT34.StrType)le.citizenship_id_6),
    Fields.InValid_citizenship_id_7((SALT34.StrType)le.citizenship_id_7),
    Fields.InValid_citizenship_id_8((SALT34.StrType)le.citizenship_id_8),
    Fields.InValid_citizenship_id_9((SALT34.StrType)le.citizenship_id_9),
    Fields.InValid_citizenship_id_10((SALT34.StrType)le.citizenship_id_10),
    Fields.InValid_citizenship_1((SALT34.StrType)le.citizenship_1),
    Fields.InValid_citizenship_2((SALT34.StrType)le.citizenship_2),
    Fields.InValid_citizenship_3((SALT34.StrType)le.citizenship_3),
    Fields.InValid_citizenship_4((SALT34.StrType)le.citizenship_4),
    Fields.InValid_citizenship_5((SALT34.StrType)le.citizenship_5),
    Fields.InValid_citizenship_6((SALT34.StrType)le.citizenship_6),
    Fields.InValid_citizenship_7((SALT34.StrType)le.citizenship_7),
    Fields.InValid_citizenship_8((SALT34.StrType)le.citizenship_8),
    Fields.InValid_citizenship_9((SALT34.StrType)le.citizenship_9),
    Fields.InValid_citizenship_10((SALT34.StrType)le.citizenship_10),
    Fields.InValid_primary_citizenship_flag_1((SALT34.StrType)le.primary_citizenship_flag_1),
    Fields.InValid_primary_citizenship_flag_2((SALT34.StrType)le.primary_citizenship_flag_2),
    Fields.InValid_primary_citizenship_flag_3((SALT34.StrType)le.primary_citizenship_flag_3),
    Fields.InValid_primary_citizenship_flag_4((SALT34.StrType)le.primary_citizenship_flag_4),
    Fields.InValid_primary_citizenship_flag_5((SALT34.StrType)le.primary_citizenship_flag_5),
    Fields.InValid_primary_citizenship_flag_6((SALT34.StrType)le.primary_citizenship_flag_6),
    Fields.InValid_primary_citizenship_flag_7((SALT34.StrType)le.primary_citizenship_flag_7),
    Fields.InValid_primary_citizenship_flag_8((SALT34.StrType)le.primary_citizenship_flag_8),
    Fields.InValid_primary_citizenship_flag_9((SALT34.StrType)le.primary_citizenship_flag_9),
    Fields.InValid_primary_citizenship_flag_10((SALT34.StrType)le.primary_citizenship_flag_10),
    Fields.InValid_dob_id_1((SALT34.StrType)le.dob_id_1),
    Fields.InValid_dob_id_2((SALT34.StrType)le.dob_id_2),
    Fields.InValid_dob_id_3((SALT34.StrType)le.dob_id_3),
    Fields.InValid_dob_id_4((SALT34.StrType)le.dob_id_4),
    Fields.InValid_dob_id_5((SALT34.StrType)le.dob_id_5),
    Fields.InValid_dob_id_6((SALT34.StrType)le.dob_id_6),
    Fields.InValid_dob_id_7((SALT34.StrType)le.dob_id_7),
    Fields.InValid_dob_id_8((SALT34.StrType)le.dob_id_8),
    Fields.InValid_dob_id_9((SALT34.StrType)le.dob_id_9),
    Fields.InValid_dob_id_10((SALT34.StrType)le.dob_id_10),
    Fields.InValid_dob_1((SALT34.StrType)le.dob_1),
    Fields.InValid_dob_2((SALT34.StrType)le.dob_2),
    Fields.InValid_dob_3((SALT34.StrType)le.dob_3),
    Fields.InValid_dob_4((SALT34.StrType)le.dob_4),
    Fields.InValid_dob_5((SALT34.StrType)le.dob_5),
    Fields.InValid_dob_6((SALT34.StrType)le.dob_6),
    Fields.InValid_dob_7((SALT34.StrType)le.dob_7),
    Fields.InValid_dob_8((SALT34.StrType)le.dob_8),
    Fields.InValid_dob_9((SALT34.StrType)le.dob_9),
    Fields.InValid_dob_10((SALT34.StrType)le.dob_10),
    Fields.InValid_primary_dob_flag_1((SALT34.StrType)le.primary_dob_flag_1),
    Fields.InValid_primary_dob_flag_2((SALT34.StrType)le.primary_dob_flag_2),
    Fields.InValid_primary_dob_flag_3((SALT34.StrType)le.primary_dob_flag_3),
    Fields.InValid_primary_dob_flag_4((SALT34.StrType)le.primary_dob_flag_4),
    Fields.InValid_primary_dob_flag_5((SALT34.StrType)le.primary_dob_flag_5),
    Fields.InValid_primary_dob_flag_6((SALT34.StrType)le.primary_dob_flag_6),
    Fields.InValid_primary_dob_flag_7((SALT34.StrType)le.primary_dob_flag_7),
    Fields.InValid_primary_dob_flag_8((SALT34.StrType)le.primary_dob_flag_8),
    Fields.InValid_primary_dob_flag_9((SALT34.StrType)le.primary_dob_flag_9),
    Fields.InValid_primary_dob_flag_10((SALT34.StrType)le.primary_dob_flag_10),
    Fields.InValid_pob_id_1((SALT34.StrType)le.pob_id_1),
    Fields.InValid_pob_id_2((SALT34.StrType)le.pob_id_2),
    Fields.InValid_pob_id_3((SALT34.StrType)le.pob_id_3),
    Fields.InValid_pob_id_4((SALT34.StrType)le.pob_id_4),
    Fields.InValid_pob_id_5((SALT34.StrType)le.pob_id_5),
    Fields.InValid_pob_id_6((SALT34.StrType)le.pob_id_6),
    Fields.InValid_pob_id_7((SALT34.StrType)le.pob_id_7),
    Fields.InValid_pob_id_8((SALT34.StrType)le.pob_id_8),
    Fields.InValid_pob_id_9((SALT34.StrType)le.pob_id_9),
    Fields.InValid_pob_id_10((SALT34.StrType)le.pob_id_10),
    Fields.InValid_pob_1((SALT34.StrType)le.pob_1),
    Fields.InValid_pob_2((SALT34.StrType)le.pob_2),
    Fields.InValid_pob_3((SALT34.StrType)le.pob_3),
    Fields.InValid_pob_4((SALT34.StrType)le.pob_4),
    Fields.InValid_pob_5((SALT34.StrType)le.pob_5),
    Fields.InValid_pob_6((SALT34.StrType)le.pob_6),
    Fields.InValid_pob_7((SALT34.StrType)le.pob_7),
    Fields.InValid_pob_8((SALT34.StrType)le.pob_8),
    Fields.InValid_pob_9((SALT34.StrType)le.pob_9),
    Fields.InValid_pob_10((SALT34.StrType)le.pob_10),
    Fields.InValid_country_of_birth_1((SALT34.StrType)le.country_of_birth_1),
    Fields.InValid_country_of_birth_2((SALT34.StrType)le.country_of_birth_2),
    Fields.InValid_country_of_birth_3((SALT34.StrType)le.country_of_birth_3),
    Fields.InValid_country_of_birth_4((SALT34.StrType)le.country_of_birth_4),
    Fields.InValid_country_of_birth_5((SALT34.StrType)le.country_of_birth_5),
    Fields.InValid_country_of_birth_6((SALT34.StrType)le.country_of_birth_6),
    Fields.InValid_country_of_birth_7((SALT34.StrType)le.country_of_birth_7),
    Fields.InValid_country_of_birth_8((SALT34.StrType)le.country_of_birth_8),
    Fields.InValid_country_of_birth_9((SALT34.StrType)le.country_of_birth_9),
    Fields.InValid_country_of_birth_10((SALT34.StrType)le.country_of_birth_10),
    Fields.InValid_primary_pob_flag_1((SALT34.StrType)le.primary_pob_flag_1),
    Fields.InValid_primary_pob_flag_2((SALT34.StrType)le.primary_pob_flag_2),
    Fields.InValid_primary_pob_flag_3((SALT34.StrType)le.primary_pob_flag_3),
    Fields.InValid_primary_pob_flag_4((SALT34.StrType)le.primary_pob_flag_4),
    Fields.InValid_primary_pob_flag_5((SALT34.StrType)le.primary_pob_flag_5),
    Fields.InValid_primary_pob_flag_6((SALT34.StrType)le.primary_pob_flag_6),
    Fields.InValid_primary_pob_flag_7((SALT34.StrType)le.primary_pob_flag_7),
    Fields.InValid_primary_pob_flag_8((SALT34.StrType)le.primary_pob_flag_8),
    Fields.InValid_primary_pob_flag_9((SALT34.StrType)le.primary_pob_flag_9),
    Fields.InValid_primary_pob_flag_10((SALT34.StrType)le.primary_pob_flag_10),
    Fields.InValid_language_1((SALT34.StrType)le.language_1),
    Fields.InValid_language_2((SALT34.StrType)le.language_2),
    Fields.InValid_language_3((SALT34.StrType)le.language_3),
    Fields.InValid_language_4((SALT34.StrType)le.language_4),
    Fields.InValid_language_5((SALT34.StrType)le.language_5),
    Fields.InValid_language_6((SALT34.StrType)le.language_6),
    Fields.InValid_language_7((SALT34.StrType)le.language_7),
    Fields.InValid_language_8((SALT34.StrType)le.language_8),
    Fields.InValid_language_9((SALT34.StrType)le.language_9),
    Fields.InValid_language_10((SALT34.StrType)le.language_10),
    Fields.InValid_membership_1((SALT34.StrType)le.membership_1),
    Fields.InValid_membership_2((SALT34.StrType)le.membership_2),
    Fields.InValid_membership_3((SALT34.StrType)le.membership_3),
    Fields.InValid_membership_4((SALT34.StrType)le.membership_4),
    Fields.InValid_membership_5((SALT34.StrType)le.membership_5),
    Fields.InValid_membership_6((SALT34.StrType)le.membership_6),
    Fields.InValid_membership_7((SALT34.StrType)le.membership_7),
    Fields.InValid_membership_8((SALT34.StrType)le.membership_8),
    Fields.InValid_membership_9((SALT34.StrType)le.membership_9),
    Fields.InValid_membership_10((SALT34.StrType)le.membership_10),
    Fields.InValid_position_1((SALT34.StrType)le.position_1),
    Fields.InValid_position_2((SALT34.StrType)le.position_2),
    Fields.InValid_position_3((SALT34.StrType)le.position_3),
    Fields.InValid_position_4((SALT34.StrType)le.position_4),
    Fields.InValid_position_5((SALT34.StrType)le.position_5),
    Fields.InValid_position_6((SALT34.StrType)le.position_6),
    Fields.InValid_position_7((SALT34.StrType)le.position_7),
    Fields.InValid_position_8((SALT34.StrType)le.position_8),
    Fields.InValid_position_9((SALT34.StrType)le.position_9),
    Fields.InValid_position_10((SALT34.StrType)le.position_10),
    Fields.InValid_occupation_1((SALT34.StrType)le.occupation_1),
    Fields.InValid_occupation_2((SALT34.StrType)le.occupation_2),
    Fields.InValid_occupation_3((SALT34.StrType)le.occupation_3),
    Fields.InValid_occupation_4((SALT34.StrType)le.occupation_4),
    Fields.InValid_occupation_5((SALT34.StrType)le.occupation_5),
    Fields.InValid_occupation_6((SALT34.StrType)le.occupation_6),
    Fields.InValid_occupation_7((SALT34.StrType)le.occupation_7),
    Fields.InValid_occupation_8((SALT34.StrType)le.occupation_8),
    Fields.InValid_occupation_9((SALT34.StrType)le.occupation_9),
    Fields.InValid_occupation_10((SALT34.StrType)le.occupation_10),
    Fields.InValid_date_added_to_list((SALT34.StrType)le.date_added_to_list),
    Fields.InValid_date_last_updated((SALT34.StrType)le.date_last_updated),
    Fields.InValid_effective_date((SALT34.StrType)le.effective_date),
    Fields.InValid_expiration_date((SALT34.StrType)le.expiration_date),
    Fields.InValid_gender((SALT34.StrType)le.gender),
    Fields.InValid_grounds((SALT34.StrType)le.grounds),
    Fields.InValid_subj_to_common_pos_2001_931_cfsp_fl((SALT34.StrType)le.subj_to_common_pos_2001_931_cfsp_fl),
    Fields.InValid_federal_register_citation_1((SALT34.StrType)le.federal_register_citation_1),
    Fields.InValid_federal_register_citation_2((SALT34.StrType)le.federal_register_citation_2),
    Fields.InValid_federal_register_citation_3((SALT34.StrType)le.federal_register_citation_3),
    Fields.InValid_federal_register_citation_4((SALT34.StrType)le.federal_register_citation_4),
    Fields.InValid_federal_register_citation_5((SALT34.StrType)le.federal_register_citation_5),
    Fields.InValid_federal_register_citation_6((SALT34.StrType)le.federal_register_citation_6),
    Fields.InValid_federal_register_citation_7((SALT34.StrType)le.federal_register_citation_7),
    Fields.InValid_federal_register_citation_8((SALT34.StrType)le.federal_register_citation_8),
    Fields.InValid_federal_register_citation_9((SALT34.StrType)le.federal_register_citation_9),
    Fields.InValid_federal_register_citation_10((SALT34.StrType)le.federal_register_citation_10),
    Fields.InValid_federal_register_citation_date_1((SALT34.StrType)le.federal_register_citation_date_1),
    Fields.InValid_federal_register_citation_date_2((SALT34.StrType)le.federal_register_citation_date_2),
    Fields.InValid_federal_register_citation_date_3((SALT34.StrType)le.federal_register_citation_date_3),
    Fields.InValid_federal_register_citation_date_4((SALT34.StrType)le.federal_register_citation_date_4),
    Fields.InValid_federal_register_citation_date_5((SALT34.StrType)le.federal_register_citation_date_5),
    Fields.InValid_federal_register_citation_date_6((SALT34.StrType)le.federal_register_citation_date_6),
    Fields.InValid_federal_register_citation_date_7((SALT34.StrType)le.federal_register_citation_date_7),
    Fields.InValid_federal_register_citation_date_8((SALT34.StrType)le.federal_register_citation_date_8),
    Fields.InValid_federal_register_citation_date_9((SALT34.StrType)le.federal_register_citation_date_9),
    Fields.InValid_federal_register_citation_date_10((SALT34.StrType)le.federal_register_citation_date_10),
    Fields.InValid_license_requirement((SALT34.StrType)le.license_requirement),
    Fields.InValid_license_review_policy((SALT34.StrType)le.license_review_policy),
    Fields.InValid_subordinate_status((SALT34.StrType)le.subordinate_status),
    Fields.InValid_height((SALT34.StrType)le.height),
    Fields.InValid_weight((SALT34.StrType)le.weight),
    Fields.InValid_physique((SALT34.StrType)le.physique),
    Fields.InValid_hair_color((SALT34.StrType)le.hair_color),
    Fields.InValid_eyes((SALT34.StrType)le.eyes),
    Fields.InValid_complexion((SALT34.StrType)le.complexion),
    Fields.InValid_race((SALT34.StrType)le.race),
    Fields.InValid_scars_marks((SALT34.StrType)le.scars_marks),
    Fields.InValid_photo_file((SALT34.StrType)le.photo_file),
    Fields.InValid_offenses((SALT34.StrType)le.offenses),
    Fields.InValid_ncic((SALT34.StrType)le.ncic),
    Fields.InValid_warrant_by((SALT34.StrType)le.warrant_by),
    Fields.InValid_caution((SALT34.StrType)le.caution),
    Fields.InValid_reward((SALT34.StrType)le.reward),
    Fields.InValid_type_of_denial((SALT34.StrType)le.type_of_denial),
    Fields.InValid_linked_with_1((SALT34.StrType)le.linked_with_1),
    Fields.InValid_linked_with_2((SALT34.StrType)le.linked_with_2),
    Fields.InValid_linked_with_3((SALT34.StrType)le.linked_with_3),
    Fields.InValid_linked_with_4((SALT34.StrType)le.linked_with_4),
    Fields.InValid_linked_with_5((SALT34.StrType)le.linked_with_5),
    Fields.InValid_linked_with_6((SALT34.StrType)le.linked_with_6),
    Fields.InValid_linked_with_7((SALT34.StrType)le.linked_with_7),
    Fields.InValid_linked_with_8((SALT34.StrType)le.linked_with_8),
    Fields.InValid_linked_with_9((SALT34.StrType)le.linked_with_9),
    Fields.InValid_linked_with_10((SALT34.StrType)le.linked_with_10),
    Fields.InValid_linked_with_id_1((SALT34.StrType)le.linked_with_id_1),
    Fields.InValid_linked_with_id_2((SALT34.StrType)le.linked_with_id_2),
    Fields.InValid_linked_with_id_3((SALT34.StrType)le.linked_with_id_3),
    Fields.InValid_linked_with_id_4((SALT34.StrType)le.linked_with_id_4),
    Fields.InValid_linked_with_id_5((SALT34.StrType)le.linked_with_id_5),
    Fields.InValid_linked_with_id_6((SALT34.StrType)le.linked_with_id_6),
    Fields.InValid_linked_with_id_7((SALT34.StrType)le.linked_with_id_7),
    Fields.InValid_linked_with_id_8((SALT34.StrType)le.linked_with_id_8),
    Fields.InValid_linked_with_id_9((SALT34.StrType)le.linked_with_id_9),
    Fields.InValid_linked_with_id_10((SALT34.StrType)le.linked_with_id_10),
    Fields.InValid_listing_information((SALT34.StrType)le.listing_information),
    Fields.InValid_foreign_principal((SALT34.StrType)le.foreign_principal),
    Fields.InValid_nature_of_service((SALT34.StrType)le.nature_of_service),
    Fields.InValid_activities((SALT34.StrType)le.activities),
    Fields.InValid_finances((SALT34.StrType)le.finances),
    Fields.InValid_registrant_terminated_flag((SALT34.StrType)le.registrant_terminated_flag),
    Fields.InValid_foreign_principal_terminated_flag((SALT34.StrType)le.foreign_principal_terminated_flag),
    Fields.InValid_short_form_terminated_flag((SALT34.StrType)le.short_form_terminated_flag),
    Fields.InValid_src_key((SALT34.StrType)le.src_key),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.src_key := le.src_key;
END;
Errors := NORMALIZE(h,433,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.src_key;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,src_key,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.src_key;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_source_code','invalid_source','invalid_name','invalid_alphanum','invalid_country_name','invalid_name_type','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_name','invalid_suffix','Unknown','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_alpha','invalid_state_abbr','invalid_zip','invalid_zip4','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date','invalid_date','Unknown','invalid_name','invalid_name','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_aka_type','invalid_aka_category','invalid_giv_designator','invalid_entity_type','Unknown','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_alphanum','invalid_zipcode','invalid_country_name','Unknown','Unknown','invalid_vessel_type','Unknown','Unknown','invalid_vessel_flag','invalid_alpha','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date','invalid_expire_dte','invalid_gender','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','Unknown','Unknown','Unknown','invalid_wgt_hgt','invalid_wgt_hgt','invalid_physique','invalid_hair_color','invalid_hair_color','invalid_complexion','invalid_race','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_denial','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_flag','invalid_flag','invalid_flag','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_pty_key(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_orig_pty_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_vessel_name(TotalErrors.ErrorNum),Fields.InValidMessage_country(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_addr_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_3(TotalErrors.ErrorNum),Fields.InValidMessage_addr_4(TotalErrors.ErrorNum),Fields.InValidMessage_addr_5(TotalErrors.ErrorNum),Fields.InValidMessage_addr_6(TotalErrors.ErrorNum),Fields.InValidMessage_addr_7(TotalErrors.ErrorNum),Fields.InValidMessage_addr_8(TotalErrors.ErrorNum),Fields.InValidMessage_addr_9(TotalErrors.ErrorNum),Fields.InValidMessage_addr_10(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_1(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_2(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_3(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_4(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_5(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_6(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_7(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_8(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_9(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_10(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_11(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_12(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_13(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_14(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_15(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_16(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_17(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_18(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_19(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_20(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_21(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_22(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_23(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_24(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_25(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_26(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_27(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_28(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_29(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_30(TotalErrors.ErrorNum),Fields.InValidMessage_cname(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_a_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_entity_id(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_title_1(TotalErrors.ErrorNum),Fields.InValidMessage_title_2(TotalErrors.ErrorNum),Fields.InValidMessage_title_3(TotalErrors.ErrorNum),Fields.InValidMessage_title_4(TotalErrors.ErrorNum),Fields.InValidMessage_title_5(TotalErrors.ErrorNum),Fields.InValidMessage_title_6(TotalErrors.ErrorNum),Fields.InValidMessage_title_7(TotalErrors.ErrorNum),Fields.InValidMessage_title_8(TotalErrors.ErrorNum),Fields.InValidMessage_title_9(TotalErrors.ErrorNum),Fields.InValidMessage_title_10(TotalErrors.ErrorNum),Fields.InValidMessage_aka_id(TotalErrors.ErrorNum),Fields.InValidMessage_aka_type(TotalErrors.ErrorNum),Fields.InValidMessage_aka_category(TotalErrors.ErrorNum),Fields.InValidMessage_giv_designator(TotalErrors.ErrorNum),Fields.InValidMessage_entity_type(TotalErrors.ErrorNum),Fields.InValidMessage_address_id(TotalErrors.ErrorNum),Fields.InValidMessage_address_line_1(TotalErrors.ErrorNum),Fields.InValidMessage_address_line_2(TotalErrors.ErrorNum),Fields.InValidMessage_address_line_3(TotalErrors.ErrorNum),Fields.InValidMessage_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_address_state_province(TotalErrors.ErrorNum),Fields.InValidMessage_address_postal_code(TotalErrors.ErrorNum),Fields.InValidMessage_address_country(TotalErrors.ErrorNum),Fields.InValidMessage_remarks(TotalErrors.ErrorNum),Fields.InValidMessage_call_sign(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_type(TotalErrors.ErrorNum),Fields.InValidMessage_tonnage(TotalErrors.ErrorNum),Fields.InValidMessage_gross_registered_tonnage(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_flag(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_owner(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_1(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_2(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_3(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_4(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_5(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_6(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_7(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_8(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_9(TotalErrors.ErrorNum),Fields.InValidMessage_sanctions_program_10(TotalErrors.ErrorNum),Fields.InValidMessage_passport_details(TotalErrors.ErrorNum),Fields.InValidMessage_ni_number_details(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_1(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_2(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_3(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_4(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_5(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_6(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_7(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_8(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_9(TotalErrors.ErrorNum),Fields.InValidMessage_id_id_10(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_1(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_2(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_3(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_4(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_5(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_6(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_7(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_8(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_9(TotalErrors.ErrorNum),Fields.InValidMessage_id_type_10(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_1(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_2(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_3(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_4(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_5(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_6(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_7(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_8(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_9(TotalErrors.ErrorNum),Fields.InValidMessage_id_number_10(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_1(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_2(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_3(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_4(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_5(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_6(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_7(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_8(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_9(TotalErrors.ErrorNum),Fields.InValidMessage_id_country_10(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_1(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_2(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_3(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_4(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_5(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_6(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_7(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_8(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_9(TotalErrors.ErrorNum),Fields.InValidMessage_id_issue_date_10(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_1(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_2(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_3(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_4(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_5(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_6(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_7(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_8(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_9(TotalErrors.ErrorNum),Fields.InValidMessage_id_expiration_date_10(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_1(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_2(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_3(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_4(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_5(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_6(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_7(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_8(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_9(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_id_10(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_1(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_2(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_3(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_4(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_5(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_6(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_7(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_8(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_9(TotalErrors.ErrorNum),Fields.InValidMessage_nationality_10(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_1(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_2(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_3(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_4(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_5(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_6(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_7(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_8(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_9(TotalErrors.ErrorNum),Fields.InValidMessage_primary_nationality_flag_10(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_1(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_2(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_3(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_4(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_5(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_6(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_7(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_8(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_9(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_id_10(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_1(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_2(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_3(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_4(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_5(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_6(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_7(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_8(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_9(TotalErrors.ErrorNum),Fields.InValidMessage_citizenship_10(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_1(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_2(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_3(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_4(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_5(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_6(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_7(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_8(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_9(TotalErrors.ErrorNum),Fields.InValidMessage_primary_citizenship_flag_10(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_1(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_2(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_3(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_4(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_5(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_6(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_7(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_8(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_9(TotalErrors.ErrorNum),Fields.InValidMessage_dob_id_10(TotalErrors.ErrorNum),Fields.InValidMessage_dob_1(TotalErrors.ErrorNum),Fields.InValidMessage_dob_2(TotalErrors.ErrorNum),Fields.InValidMessage_dob_3(TotalErrors.ErrorNum),Fields.InValidMessage_dob_4(TotalErrors.ErrorNum),Fields.InValidMessage_dob_5(TotalErrors.ErrorNum),Fields.InValidMessage_dob_6(TotalErrors.ErrorNum),Fields.InValidMessage_dob_7(TotalErrors.ErrorNum),Fields.InValidMessage_dob_8(TotalErrors.ErrorNum),Fields.InValidMessage_dob_9(TotalErrors.ErrorNum),Fields.InValidMessage_dob_10(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_1(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_2(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_3(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_4(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_5(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_6(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_7(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_8(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_9(TotalErrors.ErrorNum),Fields.InValidMessage_primary_dob_flag_10(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_1(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_2(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_3(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_4(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_5(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_6(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_7(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_8(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_9(TotalErrors.ErrorNum),Fields.InValidMessage_pob_id_10(TotalErrors.ErrorNum),Fields.InValidMessage_pob_1(TotalErrors.ErrorNum),Fields.InValidMessage_pob_2(TotalErrors.ErrorNum),Fields.InValidMessage_pob_3(TotalErrors.ErrorNum),Fields.InValidMessage_pob_4(TotalErrors.ErrorNum),Fields.InValidMessage_pob_5(TotalErrors.ErrorNum),Fields.InValidMessage_pob_6(TotalErrors.ErrorNum),Fields.InValidMessage_pob_7(TotalErrors.ErrorNum),Fields.InValidMessage_pob_8(TotalErrors.ErrorNum),Fields.InValidMessage_pob_9(TotalErrors.ErrorNum),Fields.InValidMessage_pob_10(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_1(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_2(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_3(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_4(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_5(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_6(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_7(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_8(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_9(TotalErrors.ErrorNum),Fields.InValidMessage_country_of_birth_10(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_1(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_2(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_3(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_4(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_5(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_6(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_7(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_8(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_9(TotalErrors.ErrorNum),Fields.InValidMessage_primary_pob_flag_10(TotalErrors.ErrorNum),Fields.InValidMessage_language_1(TotalErrors.ErrorNum),Fields.InValidMessage_language_2(TotalErrors.ErrorNum),Fields.InValidMessage_language_3(TotalErrors.ErrorNum),Fields.InValidMessage_language_4(TotalErrors.ErrorNum),Fields.InValidMessage_language_5(TotalErrors.ErrorNum),Fields.InValidMessage_language_6(TotalErrors.ErrorNum),Fields.InValidMessage_language_7(TotalErrors.ErrorNum),Fields.InValidMessage_language_8(TotalErrors.ErrorNum),Fields.InValidMessage_language_9(TotalErrors.ErrorNum),Fields.InValidMessage_language_10(TotalErrors.ErrorNum),Fields.InValidMessage_membership_1(TotalErrors.ErrorNum),Fields.InValidMessage_membership_2(TotalErrors.ErrorNum),Fields.InValidMessage_membership_3(TotalErrors.ErrorNum),Fields.InValidMessage_membership_4(TotalErrors.ErrorNum),Fields.InValidMessage_membership_5(TotalErrors.ErrorNum),Fields.InValidMessage_membership_6(TotalErrors.ErrorNum),Fields.InValidMessage_membership_7(TotalErrors.ErrorNum),Fields.InValidMessage_membership_8(TotalErrors.ErrorNum),Fields.InValidMessage_membership_9(TotalErrors.ErrorNum),Fields.InValidMessage_membership_10(TotalErrors.ErrorNum),Fields.InValidMessage_position_1(TotalErrors.ErrorNum),Fields.InValidMessage_position_2(TotalErrors.ErrorNum),Fields.InValidMessage_position_3(TotalErrors.ErrorNum),Fields.InValidMessage_position_4(TotalErrors.ErrorNum),Fields.InValidMessage_position_5(TotalErrors.ErrorNum),Fields.InValidMessage_position_6(TotalErrors.ErrorNum),Fields.InValidMessage_position_7(TotalErrors.ErrorNum),Fields.InValidMessage_position_8(TotalErrors.ErrorNum),Fields.InValidMessage_position_9(TotalErrors.ErrorNum),Fields.InValidMessage_position_10(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_1(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_2(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_3(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_4(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_5(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_6(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_7(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_8(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_9(TotalErrors.ErrorNum),Fields.InValidMessage_occupation_10(TotalErrors.ErrorNum),Fields.InValidMessage_date_added_to_list(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_updated(TotalErrors.ErrorNum),Fields.InValidMessage_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_grounds(TotalErrors.ErrorNum),Fields.InValidMessage_subj_to_common_pos_2001_931_cfsp_fl(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_1(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_2(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_3(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_4(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_5(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_6(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_7(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_8(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_9(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_10(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_1(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_2(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_3(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_4(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_5(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_6(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_7(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_8(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_9(TotalErrors.ErrorNum),Fields.InValidMessage_federal_register_citation_date_10(TotalErrors.ErrorNum),Fields.InValidMessage_license_requirement(TotalErrors.ErrorNum),Fields.InValidMessage_license_review_policy(TotalErrors.ErrorNum),Fields.InValidMessage_subordinate_status(TotalErrors.ErrorNum),Fields.InValidMessage_height(TotalErrors.ErrorNum),Fields.InValidMessage_weight(TotalErrors.ErrorNum),Fields.InValidMessage_physique(TotalErrors.ErrorNum),Fields.InValidMessage_hair_color(TotalErrors.ErrorNum),Fields.InValidMessage_eyes(TotalErrors.ErrorNum),Fields.InValidMessage_complexion(TotalErrors.ErrorNum),Fields.InValidMessage_race(TotalErrors.ErrorNum),Fields.InValidMessage_scars_marks(TotalErrors.ErrorNum),Fields.InValidMessage_photo_file(TotalErrors.ErrorNum),Fields.InValidMessage_offenses(TotalErrors.ErrorNum),Fields.InValidMessage_ncic(TotalErrors.ErrorNum),Fields.InValidMessage_warrant_by(TotalErrors.ErrorNum),Fields.InValidMessage_caution(TotalErrors.ErrorNum),Fields.InValidMessage_reward(TotalErrors.ErrorNum),Fields.InValidMessage_type_of_denial(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_1(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_2(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_3(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_4(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_5(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_6(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_7(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_8(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_9(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_10(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_1(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_2(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_3(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_4(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_5(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_6(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_7(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_8(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_9(TotalErrors.ErrorNum),Fields.InValidMessage_linked_with_id_10(TotalErrors.ErrorNum),Fields.InValidMessage_listing_information(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_principal(TotalErrors.ErrorNum),Fields.InValidMessage_nature_of_service(TotalErrors.ErrorNum),Fields.InValidMessage_activities(TotalErrors.ErrorNum),Fields.InValidMessage_finances(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_terminated_flag(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_principal_terminated_flag(TotalErrors.ErrorNum),Fields.InValidMessage_short_form_terminated_flag(TotalErrors.ErrorNum),Fields.InValidMessage_src_key(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.src_key=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
