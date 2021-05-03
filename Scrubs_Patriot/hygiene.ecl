IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Patriot) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.src_key))'', MAX(GROUP,h.src_key));
    NumberOfRecords := COUNT(GROUP);
    populated_pty_key_cnt := COUNT(GROUP,h.pty_key <> (TYPEOF(h.pty_key))'');
    populated_pty_key_pcnt := AVE(GROUP,IF(h.pty_key = (TYPEOF(h.pty_key))'',0,100));
    maxlength_pty_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pty_key)));
    avelength_pty_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pty_key)),h.pty_key<>(typeof(h.pty_key))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_orig_pty_name_cnt := COUNT(GROUP,h.orig_pty_name <> (TYPEOF(h.orig_pty_name))'');
    populated_orig_pty_name_pcnt := AVE(GROUP,IF(h.orig_pty_name = (TYPEOF(h.orig_pty_name))'',0,100));
    maxlength_orig_pty_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pty_name)));
    avelength_orig_pty_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pty_name)),h.orig_pty_name<>(typeof(h.orig_pty_name))'');
    populated_orig_vessel_name_cnt := COUNT(GROUP,h.orig_vessel_name <> (TYPEOF(h.orig_vessel_name))'');
    populated_orig_vessel_name_pcnt := AVE(GROUP,IF(h.orig_vessel_name = (TYPEOF(h.orig_vessel_name))'',0,100));
    maxlength_orig_vessel_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_vessel_name)));
    avelength_orig_vessel_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_vessel_name)),h.orig_vessel_name<>(typeof(h.orig_vessel_name))'');
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_name_type_cnt := COUNT(GROUP,h.name_type <> (TYPEOF(h.name_type))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_addr_1_cnt := COUNT(GROUP,h.addr_1 <> (TYPEOF(h.addr_1))'');
    populated_addr_1_pcnt := AVE(GROUP,IF(h.addr_1 = (TYPEOF(h.addr_1))'',0,100));
    maxlength_addr_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_1)));
    avelength_addr_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_1)),h.addr_1<>(typeof(h.addr_1))'');
    populated_addr_2_cnt := COUNT(GROUP,h.addr_2 <> (TYPEOF(h.addr_2))'');
    populated_addr_2_pcnt := AVE(GROUP,IF(h.addr_2 = (TYPEOF(h.addr_2))'',0,100));
    maxlength_addr_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_2)));
    avelength_addr_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_2)),h.addr_2<>(typeof(h.addr_2))'');
    populated_addr_3_cnt := COUNT(GROUP,h.addr_3 <> (TYPEOF(h.addr_3))'');
    populated_addr_3_pcnt := AVE(GROUP,IF(h.addr_3 = (TYPEOF(h.addr_3))'',0,100));
    maxlength_addr_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_3)));
    avelength_addr_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_3)),h.addr_3<>(typeof(h.addr_3))'');
    populated_addr_4_cnt := COUNT(GROUP,h.addr_4 <> (TYPEOF(h.addr_4))'');
    populated_addr_4_pcnt := AVE(GROUP,IF(h.addr_4 = (TYPEOF(h.addr_4))'',0,100));
    maxlength_addr_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_4)));
    avelength_addr_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_4)),h.addr_4<>(typeof(h.addr_4))'');
    populated_addr_5_cnt := COUNT(GROUP,h.addr_5 <> (TYPEOF(h.addr_5))'');
    populated_addr_5_pcnt := AVE(GROUP,IF(h.addr_5 = (TYPEOF(h.addr_5))'',0,100));
    maxlength_addr_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_5)));
    avelength_addr_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_5)),h.addr_5<>(typeof(h.addr_5))'');
    populated_addr_6_cnt := COUNT(GROUP,h.addr_6 <> (TYPEOF(h.addr_6))'');
    populated_addr_6_pcnt := AVE(GROUP,IF(h.addr_6 = (TYPEOF(h.addr_6))'',0,100));
    maxlength_addr_6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_6)));
    avelength_addr_6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_6)),h.addr_6<>(typeof(h.addr_6))'');
    populated_addr_7_cnt := COUNT(GROUP,h.addr_7 <> (TYPEOF(h.addr_7))'');
    populated_addr_7_pcnt := AVE(GROUP,IF(h.addr_7 = (TYPEOF(h.addr_7))'',0,100));
    maxlength_addr_7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_7)));
    avelength_addr_7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_7)),h.addr_7<>(typeof(h.addr_7))'');
    populated_addr_8_cnt := COUNT(GROUP,h.addr_8 <> (TYPEOF(h.addr_8))'');
    populated_addr_8_pcnt := AVE(GROUP,IF(h.addr_8 = (TYPEOF(h.addr_8))'',0,100));
    maxlength_addr_8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_8)));
    avelength_addr_8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_8)),h.addr_8<>(typeof(h.addr_8))'');
    populated_addr_9_cnt := COUNT(GROUP,h.addr_9 <> (TYPEOF(h.addr_9))'');
    populated_addr_9_pcnt := AVE(GROUP,IF(h.addr_9 = (TYPEOF(h.addr_9))'',0,100));
    maxlength_addr_9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_9)));
    avelength_addr_9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_9)),h.addr_9<>(typeof(h.addr_9))'');
    populated_addr_10_cnt := COUNT(GROUP,h.addr_10 <> (TYPEOF(h.addr_10))'');
    populated_addr_10_pcnt := AVE(GROUP,IF(h.addr_10 = (TYPEOF(h.addr_10))'',0,100));
    maxlength_addr_10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_10)));
    avelength_addr_10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_10)),h.addr_10<>(typeof(h.addr_10))'');
    populated_remarks_1_cnt := COUNT(GROUP,h.remarks_1 <> (TYPEOF(h.remarks_1))'');
    populated_remarks_1_pcnt := AVE(GROUP,IF(h.remarks_1 = (TYPEOF(h.remarks_1))'',0,100));
    maxlength_remarks_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_1)));
    avelength_remarks_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_1)),h.remarks_1<>(typeof(h.remarks_1))'');
    populated_remarks_2_cnt := COUNT(GROUP,h.remarks_2 <> (TYPEOF(h.remarks_2))'');
    populated_remarks_2_pcnt := AVE(GROUP,IF(h.remarks_2 = (TYPEOF(h.remarks_2))'',0,100));
    maxlength_remarks_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_2)));
    avelength_remarks_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_2)),h.remarks_2<>(typeof(h.remarks_2))'');
    populated_remarks_3_cnt := COUNT(GROUP,h.remarks_3 <> (TYPEOF(h.remarks_3))'');
    populated_remarks_3_pcnt := AVE(GROUP,IF(h.remarks_3 = (TYPEOF(h.remarks_3))'',0,100));
    maxlength_remarks_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_3)));
    avelength_remarks_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_3)),h.remarks_3<>(typeof(h.remarks_3))'');
    populated_remarks_4_cnt := COUNT(GROUP,h.remarks_4 <> (TYPEOF(h.remarks_4))'');
    populated_remarks_4_pcnt := AVE(GROUP,IF(h.remarks_4 = (TYPEOF(h.remarks_4))'',0,100));
    maxlength_remarks_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_4)));
    avelength_remarks_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_4)),h.remarks_4<>(typeof(h.remarks_4))'');
    populated_remarks_5_cnt := COUNT(GROUP,h.remarks_5 <> (TYPEOF(h.remarks_5))'');
    populated_remarks_5_pcnt := AVE(GROUP,IF(h.remarks_5 = (TYPEOF(h.remarks_5))'',0,100));
    maxlength_remarks_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_5)));
    avelength_remarks_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_5)),h.remarks_5<>(typeof(h.remarks_5))'');
    populated_remarks_6_cnt := COUNT(GROUP,h.remarks_6 <> (TYPEOF(h.remarks_6))'');
    populated_remarks_6_pcnt := AVE(GROUP,IF(h.remarks_6 = (TYPEOF(h.remarks_6))'',0,100));
    maxlength_remarks_6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_6)));
    avelength_remarks_6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_6)),h.remarks_6<>(typeof(h.remarks_6))'');
    populated_remarks_7_cnt := COUNT(GROUP,h.remarks_7 <> (TYPEOF(h.remarks_7))'');
    populated_remarks_7_pcnt := AVE(GROUP,IF(h.remarks_7 = (TYPEOF(h.remarks_7))'',0,100));
    maxlength_remarks_7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_7)));
    avelength_remarks_7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_7)),h.remarks_7<>(typeof(h.remarks_7))'');
    populated_remarks_8_cnt := COUNT(GROUP,h.remarks_8 <> (TYPEOF(h.remarks_8))'');
    populated_remarks_8_pcnt := AVE(GROUP,IF(h.remarks_8 = (TYPEOF(h.remarks_8))'',0,100));
    maxlength_remarks_8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_8)));
    avelength_remarks_8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_8)),h.remarks_8<>(typeof(h.remarks_8))'');
    populated_remarks_9_cnt := COUNT(GROUP,h.remarks_9 <> (TYPEOF(h.remarks_9))'');
    populated_remarks_9_pcnt := AVE(GROUP,IF(h.remarks_9 = (TYPEOF(h.remarks_9))'',0,100));
    maxlength_remarks_9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_9)));
    avelength_remarks_9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_9)),h.remarks_9<>(typeof(h.remarks_9))'');
    populated_remarks_10_cnt := COUNT(GROUP,h.remarks_10 <> (TYPEOF(h.remarks_10))'');
    populated_remarks_10_pcnt := AVE(GROUP,IF(h.remarks_10 = (TYPEOF(h.remarks_10))'',0,100));
    maxlength_remarks_10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_10)));
    avelength_remarks_10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_10)),h.remarks_10<>(typeof(h.remarks_10))'');
    populated_remarks_11_cnt := COUNT(GROUP,h.remarks_11 <> (TYPEOF(h.remarks_11))'');
    populated_remarks_11_pcnt := AVE(GROUP,IF(h.remarks_11 = (TYPEOF(h.remarks_11))'',0,100));
    maxlength_remarks_11 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_11)));
    avelength_remarks_11 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_11)),h.remarks_11<>(typeof(h.remarks_11))'');
    populated_remarks_12_cnt := COUNT(GROUP,h.remarks_12 <> (TYPEOF(h.remarks_12))'');
    populated_remarks_12_pcnt := AVE(GROUP,IF(h.remarks_12 = (TYPEOF(h.remarks_12))'',0,100));
    maxlength_remarks_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_12)));
    avelength_remarks_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_12)),h.remarks_12<>(typeof(h.remarks_12))'');
    populated_remarks_13_cnt := COUNT(GROUP,h.remarks_13 <> (TYPEOF(h.remarks_13))'');
    populated_remarks_13_pcnt := AVE(GROUP,IF(h.remarks_13 = (TYPEOF(h.remarks_13))'',0,100));
    maxlength_remarks_13 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_13)));
    avelength_remarks_13 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_13)),h.remarks_13<>(typeof(h.remarks_13))'');
    populated_remarks_14_cnt := COUNT(GROUP,h.remarks_14 <> (TYPEOF(h.remarks_14))'');
    populated_remarks_14_pcnt := AVE(GROUP,IF(h.remarks_14 = (TYPEOF(h.remarks_14))'',0,100));
    maxlength_remarks_14 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_14)));
    avelength_remarks_14 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_14)),h.remarks_14<>(typeof(h.remarks_14))'');
    populated_remarks_15_cnt := COUNT(GROUP,h.remarks_15 <> (TYPEOF(h.remarks_15))'');
    populated_remarks_15_pcnt := AVE(GROUP,IF(h.remarks_15 = (TYPEOF(h.remarks_15))'',0,100));
    maxlength_remarks_15 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_15)));
    avelength_remarks_15 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_15)),h.remarks_15<>(typeof(h.remarks_15))'');
    populated_remarks_16_cnt := COUNT(GROUP,h.remarks_16 <> (TYPEOF(h.remarks_16))'');
    populated_remarks_16_pcnt := AVE(GROUP,IF(h.remarks_16 = (TYPEOF(h.remarks_16))'',0,100));
    maxlength_remarks_16 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_16)));
    avelength_remarks_16 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_16)),h.remarks_16<>(typeof(h.remarks_16))'');
    populated_remarks_17_cnt := COUNT(GROUP,h.remarks_17 <> (TYPEOF(h.remarks_17))'');
    populated_remarks_17_pcnt := AVE(GROUP,IF(h.remarks_17 = (TYPEOF(h.remarks_17))'',0,100));
    maxlength_remarks_17 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_17)));
    avelength_remarks_17 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_17)),h.remarks_17<>(typeof(h.remarks_17))'');
    populated_remarks_18_cnt := COUNT(GROUP,h.remarks_18 <> (TYPEOF(h.remarks_18))'');
    populated_remarks_18_pcnt := AVE(GROUP,IF(h.remarks_18 = (TYPEOF(h.remarks_18))'',0,100));
    maxlength_remarks_18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_18)));
    avelength_remarks_18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_18)),h.remarks_18<>(typeof(h.remarks_18))'');
    populated_remarks_19_cnt := COUNT(GROUP,h.remarks_19 <> (TYPEOF(h.remarks_19))'');
    populated_remarks_19_pcnt := AVE(GROUP,IF(h.remarks_19 = (TYPEOF(h.remarks_19))'',0,100));
    maxlength_remarks_19 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_19)));
    avelength_remarks_19 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_19)),h.remarks_19<>(typeof(h.remarks_19))'');
    populated_remarks_20_cnt := COUNT(GROUP,h.remarks_20 <> (TYPEOF(h.remarks_20))'');
    populated_remarks_20_pcnt := AVE(GROUP,IF(h.remarks_20 = (TYPEOF(h.remarks_20))'',0,100));
    maxlength_remarks_20 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_20)));
    avelength_remarks_20 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_20)),h.remarks_20<>(typeof(h.remarks_20))'');
    populated_remarks_21_cnt := COUNT(GROUP,h.remarks_21 <> (TYPEOF(h.remarks_21))'');
    populated_remarks_21_pcnt := AVE(GROUP,IF(h.remarks_21 = (TYPEOF(h.remarks_21))'',0,100));
    maxlength_remarks_21 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_21)));
    avelength_remarks_21 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_21)),h.remarks_21<>(typeof(h.remarks_21))'');
    populated_remarks_22_cnt := COUNT(GROUP,h.remarks_22 <> (TYPEOF(h.remarks_22))'');
    populated_remarks_22_pcnt := AVE(GROUP,IF(h.remarks_22 = (TYPEOF(h.remarks_22))'',0,100));
    maxlength_remarks_22 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_22)));
    avelength_remarks_22 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_22)),h.remarks_22<>(typeof(h.remarks_22))'');
    populated_remarks_23_cnt := COUNT(GROUP,h.remarks_23 <> (TYPEOF(h.remarks_23))'');
    populated_remarks_23_pcnt := AVE(GROUP,IF(h.remarks_23 = (TYPEOF(h.remarks_23))'',0,100));
    maxlength_remarks_23 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_23)));
    avelength_remarks_23 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_23)),h.remarks_23<>(typeof(h.remarks_23))'');
    populated_remarks_24_cnt := COUNT(GROUP,h.remarks_24 <> (TYPEOF(h.remarks_24))'');
    populated_remarks_24_pcnt := AVE(GROUP,IF(h.remarks_24 = (TYPEOF(h.remarks_24))'',0,100));
    maxlength_remarks_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_24)));
    avelength_remarks_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_24)),h.remarks_24<>(typeof(h.remarks_24))'');
    populated_remarks_25_cnt := COUNT(GROUP,h.remarks_25 <> (TYPEOF(h.remarks_25))'');
    populated_remarks_25_pcnt := AVE(GROUP,IF(h.remarks_25 = (TYPEOF(h.remarks_25))'',0,100));
    maxlength_remarks_25 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_25)));
    avelength_remarks_25 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_25)),h.remarks_25<>(typeof(h.remarks_25))'');
    populated_remarks_26_cnt := COUNT(GROUP,h.remarks_26 <> (TYPEOF(h.remarks_26))'');
    populated_remarks_26_pcnt := AVE(GROUP,IF(h.remarks_26 = (TYPEOF(h.remarks_26))'',0,100));
    maxlength_remarks_26 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_26)));
    avelength_remarks_26 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_26)),h.remarks_26<>(typeof(h.remarks_26))'');
    populated_remarks_27_cnt := COUNT(GROUP,h.remarks_27 <> (TYPEOF(h.remarks_27))'');
    populated_remarks_27_pcnt := AVE(GROUP,IF(h.remarks_27 = (TYPEOF(h.remarks_27))'',0,100));
    maxlength_remarks_27 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_27)));
    avelength_remarks_27 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_27)),h.remarks_27<>(typeof(h.remarks_27))'');
    populated_remarks_28_cnt := COUNT(GROUP,h.remarks_28 <> (TYPEOF(h.remarks_28))'');
    populated_remarks_28_pcnt := AVE(GROUP,IF(h.remarks_28 = (TYPEOF(h.remarks_28))'',0,100));
    maxlength_remarks_28 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_28)));
    avelength_remarks_28 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_28)),h.remarks_28<>(typeof(h.remarks_28))'');
    populated_remarks_29_cnt := COUNT(GROUP,h.remarks_29 <> (TYPEOF(h.remarks_29))'');
    populated_remarks_29_pcnt := AVE(GROUP,IF(h.remarks_29 = (TYPEOF(h.remarks_29))'',0,100));
    maxlength_remarks_29 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_29)));
    avelength_remarks_29 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_29)),h.remarks_29<>(typeof(h.remarks_29))'');
    populated_remarks_30_cnt := COUNT(GROUP,h.remarks_30 <> (TYPEOF(h.remarks_30))'');
    populated_remarks_30_pcnt := AVE(GROUP,IF(h.remarks_30 = (TYPEOF(h.remarks_30))'',0,100));
    maxlength_remarks_30 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_30)));
    avelength_remarks_30 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.remarks_30)),h.remarks_30<>(typeof(h.remarks_30))'');
    populated_cname_cnt := COUNT(GROUP,h.cname <> (TYPEOF(h.cname))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
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
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_a_score_cnt := COUNT(GROUP,h.a_score <> (TYPEOF(h.a_score))'');
    populated_a_score_pcnt := AVE(GROUP,IF(h.a_score = (TYPEOF(h.a_score))'',0,100));
    maxlength_a_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.a_score)));
    avelength_a_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.a_score)),h.a_score<>(typeof(h.a_score))'');
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
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
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
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
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
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_aid_prim_range_cnt := COUNT(GROUP,h.aid_prim_range <> (TYPEOF(h.aid_prim_range))'');
    populated_aid_prim_range_pcnt := AVE(GROUP,IF(h.aid_prim_range = (TYPEOF(h.aid_prim_range))'',0,100));
    maxlength_aid_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_prim_range)));
    avelength_aid_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_prim_range)),h.aid_prim_range<>(typeof(h.aid_prim_range))'');
    populated_aid_predir_cnt := COUNT(GROUP,h.aid_predir <> (TYPEOF(h.aid_predir))'');
    populated_aid_predir_pcnt := AVE(GROUP,IF(h.aid_predir = (TYPEOF(h.aid_predir))'',0,100));
    maxlength_aid_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_predir)));
    avelength_aid_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_predir)),h.aid_predir<>(typeof(h.aid_predir))'');
    populated_aid_prim_name_cnt := COUNT(GROUP,h.aid_prim_name <> (TYPEOF(h.aid_prim_name))'');
    populated_aid_prim_name_pcnt := AVE(GROUP,IF(h.aid_prim_name = (TYPEOF(h.aid_prim_name))'',0,100));
    maxlength_aid_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_prim_name)));
    avelength_aid_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_prim_name)),h.aid_prim_name<>(typeof(h.aid_prim_name))'');
    populated_aid_addr_suffix_cnt := COUNT(GROUP,h.aid_addr_suffix <> (TYPEOF(h.aid_addr_suffix))'');
    populated_aid_addr_suffix_pcnt := AVE(GROUP,IF(h.aid_addr_suffix = (TYPEOF(h.aid_addr_suffix))'',0,100));
    maxlength_aid_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_addr_suffix)));
    avelength_aid_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_addr_suffix)),h.aid_addr_suffix<>(typeof(h.aid_addr_suffix))'');
    populated_aid_postdir_cnt := COUNT(GROUP,h.aid_postdir <> (TYPEOF(h.aid_postdir))'');
    populated_aid_postdir_pcnt := AVE(GROUP,IF(h.aid_postdir = (TYPEOF(h.aid_postdir))'',0,100));
    maxlength_aid_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_postdir)));
    avelength_aid_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_postdir)),h.aid_postdir<>(typeof(h.aid_postdir))'');
    populated_aid_unit_desig_cnt := COUNT(GROUP,h.aid_unit_desig <> (TYPEOF(h.aid_unit_desig))'');
    populated_aid_unit_desig_pcnt := AVE(GROUP,IF(h.aid_unit_desig = (TYPEOF(h.aid_unit_desig))'',0,100));
    maxlength_aid_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_unit_desig)));
    avelength_aid_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_unit_desig)),h.aid_unit_desig<>(typeof(h.aid_unit_desig))'');
    populated_aid_sec_range_cnt := COUNT(GROUP,h.aid_sec_range <> (TYPEOF(h.aid_sec_range))'');
    populated_aid_sec_range_pcnt := AVE(GROUP,IF(h.aid_sec_range = (TYPEOF(h.aid_sec_range))'',0,100));
    maxlength_aid_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_sec_range)));
    avelength_aid_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_sec_range)),h.aid_sec_range<>(typeof(h.aid_sec_range))'');
    populated_aid_p_city_name_cnt := COUNT(GROUP,h.aid_p_city_name <> (TYPEOF(h.aid_p_city_name))'');
    populated_aid_p_city_name_pcnt := AVE(GROUP,IF(h.aid_p_city_name = (TYPEOF(h.aid_p_city_name))'',0,100));
    maxlength_aid_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_p_city_name)));
    avelength_aid_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_p_city_name)),h.aid_p_city_name<>(typeof(h.aid_p_city_name))'');
    populated_aid_v_city_name_cnt := COUNT(GROUP,h.aid_v_city_name <> (TYPEOF(h.aid_v_city_name))'');
    populated_aid_v_city_name_pcnt := AVE(GROUP,IF(h.aid_v_city_name = (TYPEOF(h.aid_v_city_name))'',0,100));
    maxlength_aid_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_v_city_name)));
    avelength_aid_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_v_city_name)),h.aid_v_city_name<>(typeof(h.aid_v_city_name))'');
    populated_aid_st_cnt := COUNT(GROUP,h.aid_st <> (TYPEOF(h.aid_st))'');
    populated_aid_st_pcnt := AVE(GROUP,IF(h.aid_st = (TYPEOF(h.aid_st))'',0,100));
    maxlength_aid_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_st)));
    avelength_aid_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_st)),h.aid_st<>(typeof(h.aid_st))'');
    populated_aid_zip_cnt := COUNT(GROUP,h.aid_zip <> (TYPEOF(h.aid_zip))'');
    populated_aid_zip_pcnt := AVE(GROUP,IF(h.aid_zip = (TYPEOF(h.aid_zip))'',0,100));
    maxlength_aid_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_zip)));
    avelength_aid_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_zip)),h.aid_zip<>(typeof(h.aid_zip))'');
    populated_aid_zip4_cnt := COUNT(GROUP,h.aid_zip4 <> (TYPEOF(h.aid_zip4))'');
    populated_aid_zip4_pcnt := AVE(GROUP,IF(h.aid_zip4 = (TYPEOF(h.aid_zip4))'',0,100));
    maxlength_aid_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_zip4)));
    avelength_aid_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_zip4)),h.aid_zip4<>(typeof(h.aid_zip4))'');
    populated_aid_cart_cnt := COUNT(GROUP,h.aid_cart <> (TYPEOF(h.aid_cart))'');
    populated_aid_cart_pcnt := AVE(GROUP,IF(h.aid_cart = (TYPEOF(h.aid_cart))'',0,100));
    maxlength_aid_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_cart)));
    avelength_aid_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_cart)),h.aid_cart<>(typeof(h.aid_cart))'');
    populated_aid_cr_sort_sz_cnt := COUNT(GROUP,h.aid_cr_sort_sz <> (TYPEOF(h.aid_cr_sort_sz))'');
    populated_aid_cr_sort_sz_pcnt := AVE(GROUP,IF(h.aid_cr_sort_sz = (TYPEOF(h.aid_cr_sort_sz))'',0,100));
    maxlength_aid_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_cr_sort_sz)));
    avelength_aid_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_cr_sort_sz)),h.aid_cr_sort_sz<>(typeof(h.aid_cr_sort_sz))'');
    populated_aid_lot_cnt := COUNT(GROUP,h.aid_lot <> (TYPEOF(h.aid_lot))'');
    populated_aid_lot_pcnt := AVE(GROUP,IF(h.aid_lot = (TYPEOF(h.aid_lot))'',0,100));
    maxlength_aid_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_lot)));
    avelength_aid_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_lot)),h.aid_lot<>(typeof(h.aid_lot))'');
    populated_aid_lot_order_cnt := COUNT(GROUP,h.aid_lot_order <> (TYPEOF(h.aid_lot_order))'');
    populated_aid_lot_order_pcnt := AVE(GROUP,IF(h.aid_lot_order = (TYPEOF(h.aid_lot_order))'',0,100));
    maxlength_aid_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_lot_order)));
    avelength_aid_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_lot_order)),h.aid_lot_order<>(typeof(h.aid_lot_order))'');
    populated_aid_dpbc_cnt := COUNT(GROUP,h.aid_dpbc <> (TYPEOF(h.aid_dpbc))'');
    populated_aid_dpbc_pcnt := AVE(GROUP,IF(h.aid_dpbc = (TYPEOF(h.aid_dpbc))'',0,100));
    maxlength_aid_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_dpbc)));
    avelength_aid_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_dpbc)),h.aid_dpbc<>(typeof(h.aid_dpbc))'');
    populated_aid_chk_digit_cnt := COUNT(GROUP,h.aid_chk_digit <> (TYPEOF(h.aid_chk_digit))'');
    populated_aid_chk_digit_pcnt := AVE(GROUP,IF(h.aid_chk_digit = (TYPEOF(h.aid_chk_digit))'',0,100));
    maxlength_aid_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_chk_digit)));
    avelength_aid_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_chk_digit)),h.aid_chk_digit<>(typeof(h.aid_chk_digit))'');
    populated_aid_record_type_cnt := COUNT(GROUP,h.aid_record_type <> (TYPEOF(h.aid_record_type))'');
    populated_aid_record_type_pcnt := AVE(GROUP,IF(h.aid_record_type = (TYPEOF(h.aid_record_type))'',0,100));
    maxlength_aid_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_record_type)));
    avelength_aid_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_record_type)),h.aid_record_type<>(typeof(h.aid_record_type))'');
    populated_aid_fips_st_cnt := COUNT(GROUP,h.aid_fips_st <> (TYPEOF(h.aid_fips_st))'');
    populated_aid_fips_st_pcnt := AVE(GROUP,IF(h.aid_fips_st = (TYPEOF(h.aid_fips_st))'',0,100));
    maxlength_aid_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_fips_st)));
    avelength_aid_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_fips_st)),h.aid_fips_st<>(typeof(h.aid_fips_st))'');
    populated_aid_county_cnt := COUNT(GROUP,h.aid_county <> (TYPEOF(h.aid_county))'');
    populated_aid_county_pcnt := AVE(GROUP,IF(h.aid_county = (TYPEOF(h.aid_county))'',0,100));
    maxlength_aid_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_county)));
    avelength_aid_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_county)),h.aid_county<>(typeof(h.aid_county))'');
    populated_aid_geo_lat_cnt := COUNT(GROUP,h.aid_geo_lat <> (TYPEOF(h.aid_geo_lat))'');
    populated_aid_geo_lat_pcnt := AVE(GROUP,IF(h.aid_geo_lat = (TYPEOF(h.aid_geo_lat))'',0,100));
    maxlength_aid_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_geo_lat)));
    avelength_aid_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_geo_lat)),h.aid_geo_lat<>(typeof(h.aid_geo_lat))'');
    populated_aid_geo_long_cnt := COUNT(GROUP,h.aid_geo_long <> (TYPEOF(h.aid_geo_long))'');
    populated_aid_geo_long_pcnt := AVE(GROUP,IF(h.aid_geo_long = (TYPEOF(h.aid_geo_long))'',0,100));
    maxlength_aid_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_geo_long)));
    avelength_aid_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_geo_long)),h.aid_geo_long<>(typeof(h.aid_geo_long))'');
    populated_aid_msa_cnt := COUNT(GROUP,h.aid_msa <> (TYPEOF(h.aid_msa))'');
    populated_aid_msa_pcnt := AVE(GROUP,IF(h.aid_msa = (TYPEOF(h.aid_msa))'',0,100));
    maxlength_aid_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_msa)));
    avelength_aid_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_msa)),h.aid_msa<>(typeof(h.aid_msa))'');
    populated_aid_geo_blk_cnt := COUNT(GROUP,h.aid_geo_blk <> (TYPEOF(h.aid_geo_blk))'');
    populated_aid_geo_blk_pcnt := AVE(GROUP,IF(h.aid_geo_blk = (TYPEOF(h.aid_geo_blk))'',0,100));
    maxlength_aid_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_geo_blk)));
    avelength_aid_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_geo_blk)),h.aid_geo_blk<>(typeof(h.aid_geo_blk))'');
    populated_aid_geo_match_cnt := COUNT(GROUP,h.aid_geo_match <> (TYPEOF(h.aid_geo_match))'');
    populated_aid_geo_match_pcnt := AVE(GROUP,IF(h.aid_geo_match = (TYPEOF(h.aid_geo_match))'',0,100));
    maxlength_aid_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_geo_match)));
    avelength_aid_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_geo_match)),h.aid_geo_match<>(typeof(h.aid_geo_match))'');
    populated_aid_err_stat_cnt := COUNT(GROUP,h.aid_err_stat <> (TYPEOF(h.aid_err_stat))'');
    populated_aid_err_stat_pcnt := AVE(GROUP,IF(h.aid_err_stat = (TYPEOF(h.aid_err_stat))'',0,100));
    maxlength_aid_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_err_stat)));
    avelength_aid_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_err_stat)),h.aid_err_stat<>(typeof(h.aid_err_stat))'');
    populated_append_rawaid_cnt := COUNT(GROUP,h.append_rawaid <> (TYPEOF(h.append_rawaid))'');
    populated_append_rawaid_pcnt := AVE(GROUP,IF(h.append_rawaid = (TYPEOF(h.append_rawaid))'',0,100));
    maxlength_append_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)));
    avelength_append_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)),h.append_rawaid<>(typeof(h.append_rawaid))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,src_key,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_pty_key_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_orig_pty_name_pcnt *   0.00 / 100 + T.Populated_orig_vessel_name_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_addr_1_pcnt *   0.00 / 100 + T.Populated_addr_2_pcnt *   0.00 / 100 + T.Populated_addr_3_pcnt *   0.00 / 100 + T.Populated_addr_4_pcnt *   0.00 / 100 + T.Populated_addr_5_pcnt *   0.00 / 100 + T.Populated_addr_6_pcnt *   0.00 / 100 + T.Populated_addr_7_pcnt *   0.00 / 100 + T.Populated_addr_8_pcnt *   0.00 / 100 + T.Populated_addr_9_pcnt *   0.00 / 100 + T.Populated_addr_10_pcnt *   0.00 / 100 + T.Populated_remarks_1_pcnt *   0.00 / 100 + T.Populated_remarks_2_pcnt *   0.00 / 100 + T.Populated_remarks_3_pcnt *   0.00 / 100 + T.Populated_remarks_4_pcnt *   0.00 / 100 + T.Populated_remarks_5_pcnt *   0.00 / 100 + T.Populated_remarks_6_pcnt *   0.00 / 100 + T.Populated_remarks_7_pcnt *   0.00 / 100 + T.Populated_remarks_8_pcnt *   0.00 / 100 + T.Populated_remarks_9_pcnt *   0.00 / 100 + T.Populated_remarks_10_pcnt *   0.00 / 100 + T.Populated_remarks_11_pcnt *   0.00 / 100 + T.Populated_remarks_12_pcnt *   0.00 / 100 + T.Populated_remarks_13_pcnt *   0.00 / 100 + T.Populated_remarks_14_pcnt *   0.00 / 100 + T.Populated_remarks_15_pcnt *   0.00 / 100 + T.Populated_remarks_16_pcnt *   0.00 / 100 + T.Populated_remarks_17_pcnt *   0.00 / 100 + T.Populated_remarks_18_pcnt *   0.00 / 100 + T.Populated_remarks_19_pcnt *   0.00 / 100 + T.Populated_remarks_20_pcnt *   0.00 / 100 + T.Populated_remarks_21_pcnt *   0.00 / 100 + T.Populated_remarks_22_pcnt *   0.00 / 100 + T.Populated_remarks_23_pcnt *   0.00 / 100 + T.Populated_remarks_24_pcnt *   0.00 / 100 + T.Populated_remarks_25_pcnt *   0.00 / 100 + T.Populated_remarks_26_pcnt *   0.00 / 100 + T.Populated_remarks_27_pcnt *   0.00 / 100 + T.Populated_remarks_28_pcnt *   0.00 / 100 + T.Populated_remarks_29_pcnt *   0.00 / 100 + T.Populated_remarks_30_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_a_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_aid_prim_range_pcnt *   0.00 / 100 + T.Populated_aid_predir_pcnt *   0.00 / 100 + T.Populated_aid_prim_name_pcnt *   0.00 / 100 + T.Populated_aid_addr_suffix_pcnt *   0.00 / 100 + T.Populated_aid_postdir_pcnt *   0.00 / 100 + T.Populated_aid_unit_desig_pcnt *   0.00 / 100 + T.Populated_aid_sec_range_pcnt *   0.00 / 100 + T.Populated_aid_p_city_name_pcnt *   0.00 / 100 + T.Populated_aid_v_city_name_pcnt *   0.00 / 100 + T.Populated_aid_st_pcnt *   0.00 / 100 + T.Populated_aid_zip_pcnt *   0.00 / 100 + T.Populated_aid_zip4_pcnt *   0.00 / 100 + T.Populated_aid_cart_pcnt *   0.00 / 100 + T.Populated_aid_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_aid_lot_pcnt *   0.00 / 100 + T.Populated_aid_lot_order_pcnt *   0.00 / 100 + T.Populated_aid_dpbc_pcnt *   0.00 / 100 + T.Populated_aid_chk_digit_pcnt *   0.00 / 100 + T.Populated_aid_record_type_pcnt *   0.00 / 100 + T.Populated_aid_fips_st_pcnt *   0.00 / 100 + T.Populated_aid_county_pcnt *   0.00 / 100 + T.Populated_aid_geo_lat_pcnt *   0.00 / 100 + T.Populated_aid_geo_long_pcnt *   0.00 / 100 + T.Populated_aid_msa_pcnt *   0.00 / 100 + T.Populated_aid_geo_blk_pcnt *   0.00 / 100 + T.Populated_aid_geo_match_pcnt *   0.00 / 100 + T.Populated_aid_err_stat_pcnt *   0.00 / 100 + T.Populated_append_rawaid_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING src_key1;
    STRING src_key2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.src_key1 := le.Source;
    SELF.src_key2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_pty_key_pcnt*ri.Populated_pty_key_pcnt *   0.00 / 10000 + le.Populated_source_pcnt*ri.Populated_source_pcnt *   0.00 / 10000 + le.Populated_orig_pty_name_pcnt*ri.Populated_orig_pty_name_pcnt *   0.00 / 10000 + le.Populated_orig_vessel_name_pcnt*ri.Populated_orig_vessel_name_pcnt *   0.00 / 10000 + le.Populated_country_pcnt*ri.Populated_country_pcnt *   0.00 / 10000 + le.Populated_name_type_pcnt*ri.Populated_name_type_pcnt *   0.00 / 10000 + le.Populated_addr_1_pcnt*ri.Populated_addr_1_pcnt *   0.00 / 10000 + le.Populated_addr_2_pcnt*ri.Populated_addr_2_pcnt *   0.00 / 10000 + le.Populated_addr_3_pcnt*ri.Populated_addr_3_pcnt *   0.00 / 10000 + le.Populated_addr_4_pcnt*ri.Populated_addr_4_pcnt *   0.00 / 10000 + le.Populated_addr_5_pcnt*ri.Populated_addr_5_pcnt *   0.00 / 10000 + le.Populated_addr_6_pcnt*ri.Populated_addr_6_pcnt *   0.00 / 10000 + le.Populated_addr_7_pcnt*ri.Populated_addr_7_pcnt *   0.00 / 10000 + le.Populated_addr_8_pcnt*ri.Populated_addr_8_pcnt *   0.00 / 10000 + le.Populated_addr_9_pcnt*ri.Populated_addr_9_pcnt *   0.00 / 10000 + le.Populated_addr_10_pcnt*ri.Populated_addr_10_pcnt *   0.00 / 10000 + le.Populated_remarks_1_pcnt*ri.Populated_remarks_1_pcnt *   0.00 / 10000 + le.Populated_remarks_2_pcnt*ri.Populated_remarks_2_pcnt *   0.00 / 10000 + le.Populated_remarks_3_pcnt*ri.Populated_remarks_3_pcnt *   0.00 / 10000 + le.Populated_remarks_4_pcnt*ri.Populated_remarks_4_pcnt *   0.00 / 10000 + le.Populated_remarks_5_pcnt*ri.Populated_remarks_5_pcnt *   0.00 / 10000 + le.Populated_remarks_6_pcnt*ri.Populated_remarks_6_pcnt *   0.00 / 10000 + le.Populated_remarks_7_pcnt*ri.Populated_remarks_7_pcnt *   0.00 / 10000 + le.Populated_remarks_8_pcnt*ri.Populated_remarks_8_pcnt *   0.00 / 10000 + le.Populated_remarks_9_pcnt*ri.Populated_remarks_9_pcnt *   0.00 / 10000 + le.Populated_remarks_10_pcnt*ri.Populated_remarks_10_pcnt *   0.00 / 10000 + le.Populated_remarks_11_pcnt*ri.Populated_remarks_11_pcnt *   0.00 / 10000 + le.Populated_remarks_12_pcnt*ri.Populated_remarks_12_pcnt *   0.00 / 10000 + le.Populated_remarks_13_pcnt*ri.Populated_remarks_13_pcnt *   0.00 / 10000 + le.Populated_remarks_14_pcnt*ri.Populated_remarks_14_pcnt *   0.00 / 10000 + le.Populated_remarks_15_pcnt*ri.Populated_remarks_15_pcnt *   0.00 / 10000 + le.Populated_remarks_16_pcnt*ri.Populated_remarks_16_pcnt *   0.00 / 10000 + le.Populated_remarks_17_pcnt*ri.Populated_remarks_17_pcnt *   0.00 / 10000 + le.Populated_remarks_18_pcnt*ri.Populated_remarks_18_pcnt *   0.00 / 10000 + le.Populated_remarks_19_pcnt*ri.Populated_remarks_19_pcnt *   0.00 / 10000 + le.Populated_remarks_20_pcnt*ri.Populated_remarks_20_pcnt *   0.00 / 10000 + le.Populated_remarks_21_pcnt*ri.Populated_remarks_21_pcnt *   0.00 / 10000 + le.Populated_remarks_22_pcnt*ri.Populated_remarks_22_pcnt *   0.00 / 10000 + le.Populated_remarks_23_pcnt*ri.Populated_remarks_23_pcnt *   0.00 / 10000 + le.Populated_remarks_24_pcnt*ri.Populated_remarks_24_pcnt *   0.00 / 10000 + le.Populated_remarks_25_pcnt*ri.Populated_remarks_25_pcnt *   0.00 / 10000 + le.Populated_remarks_26_pcnt*ri.Populated_remarks_26_pcnt *   0.00 / 10000 + le.Populated_remarks_27_pcnt*ri.Populated_remarks_27_pcnt *   0.00 / 10000 + le.Populated_remarks_28_pcnt*ri.Populated_remarks_28_pcnt *   0.00 / 10000 + le.Populated_remarks_29_pcnt*ri.Populated_remarks_29_pcnt *   0.00 / 10000 + le.Populated_remarks_30_pcnt*ri.Populated_remarks_30_pcnt *   0.00 / 10000 + le.Populated_cname_pcnt*ri.Populated_cname_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_a_score_pcnt*ri.Populated_a_score_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_ace_fips_st_pcnt*ri.Populated_ace_fips_st_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_global_sid_pcnt*ri.Populated_global_sid_pcnt *   0.00 / 10000 + le.Populated_record_sid_pcnt*ri.Populated_record_sid_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_aid_prim_range_pcnt*ri.Populated_aid_prim_range_pcnt *   0.00 / 10000 + le.Populated_aid_predir_pcnt*ri.Populated_aid_predir_pcnt *   0.00 / 10000 + le.Populated_aid_prim_name_pcnt*ri.Populated_aid_prim_name_pcnt *   0.00 / 10000 + le.Populated_aid_addr_suffix_pcnt*ri.Populated_aid_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_aid_postdir_pcnt*ri.Populated_aid_postdir_pcnt *   0.00 / 10000 + le.Populated_aid_unit_desig_pcnt*ri.Populated_aid_unit_desig_pcnt *   0.00 / 10000 + le.Populated_aid_sec_range_pcnt*ri.Populated_aid_sec_range_pcnt *   0.00 / 10000 + le.Populated_aid_p_city_name_pcnt*ri.Populated_aid_p_city_name_pcnt *   0.00 / 10000 + le.Populated_aid_v_city_name_pcnt*ri.Populated_aid_v_city_name_pcnt *   0.00 / 10000 + le.Populated_aid_st_pcnt*ri.Populated_aid_st_pcnt *   0.00 / 10000 + le.Populated_aid_zip_pcnt*ri.Populated_aid_zip_pcnt *   0.00 / 10000 + le.Populated_aid_zip4_pcnt*ri.Populated_aid_zip4_pcnt *   0.00 / 10000 + le.Populated_aid_cart_pcnt*ri.Populated_aid_cart_pcnt *   0.00 / 10000 + le.Populated_aid_cr_sort_sz_pcnt*ri.Populated_aid_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_aid_lot_pcnt*ri.Populated_aid_lot_pcnt *   0.00 / 10000 + le.Populated_aid_lot_order_pcnt*ri.Populated_aid_lot_order_pcnt *   0.00 / 10000 + le.Populated_aid_dpbc_pcnt*ri.Populated_aid_dpbc_pcnt *   0.00 / 10000 + le.Populated_aid_chk_digit_pcnt*ri.Populated_aid_chk_digit_pcnt *   0.00 / 10000 + le.Populated_aid_record_type_pcnt*ri.Populated_aid_record_type_pcnt *   0.00 / 10000 + le.Populated_aid_fips_st_pcnt*ri.Populated_aid_fips_st_pcnt *   0.00 / 10000 + le.Populated_aid_county_pcnt*ri.Populated_aid_county_pcnt *   0.00 / 10000 + le.Populated_aid_geo_lat_pcnt*ri.Populated_aid_geo_lat_pcnt *   0.00 / 10000 + le.Populated_aid_geo_long_pcnt*ri.Populated_aid_geo_long_pcnt *   0.00 / 10000 + le.Populated_aid_msa_pcnt*ri.Populated_aid_msa_pcnt *   0.00 / 10000 + le.Populated_aid_geo_blk_pcnt*ri.Populated_aid_geo_blk_pcnt *   0.00 / 10000 + le.Populated_aid_geo_match_pcnt*ri.Populated_aid_geo_match_pcnt *   0.00 / 10000 + le.Populated_aid_err_stat_pcnt*ri.Populated_aid_err_stat_pcnt *   0.00 / 10000 + le.Populated_append_rawaid_pcnt*ri.Populated_append_rawaid_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'pty_key','source','orig_pty_name','orig_vessel_name','country','name_type','addr_1','addr_2','addr_3','addr_4','addr_5','addr_6','addr_7','addr_8','addr_9','addr_10','remarks_1','remarks_2','remarks_3','remarks_4','remarks_5','remarks_6','remarks_7','remarks_8','remarks_9','remarks_10','remarks_11','remarks_12','remarks_13','remarks_14','remarks_15','remarks_16','remarks_17','remarks_18','remarks_19','remarks_20','remarks_21','remarks_22','remarks_23','remarks_24','remarks_25','remarks_26','remarks_27','remarks_28','remarks_29','remarks_30','cname','title','fname','mname','lname','suffix','a_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','global_sid','record_sid','did','aid_prim_range','aid_predir','aid_prim_name','aid_addr_suffix','aid_postdir','aid_unit_desig','aid_sec_range','aid_p_city_name','aid_v_city_name','aid_st','aid_zip','aid_zip4','aid_cart','aid_cr_sort_sz','aid_lot','aid_lot_order','aid_dpbc','aid_chk_digit','aid_record_type','aid_fips_st','aid_county','aid_geo_lat','aid_geo_long','aid_msa','aid_geo_blk','aid_geo_match','aid_err_stat','append_rawaid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_pty_key_pcnt,le.populated_source_pcnt,le.populated_orig_pty_name_pcnt,le.populated_orig_vessel_name_pcnt,le.populated_country_pcnt,le.populated_name_type_pcnt,le.populated_addr_1_pcnt,le.populated_addr_2_pcnt,le.populated_addr_3_pcnt,le.populated_addr_4_pcnt,le.populated_addr_5_pcnt,le.populated_addr_6_pcnt,le.populated_addr_7_pcnt,le.populated_addr_8_pcnt,le.populated_addr_9_pcnt,le.populated_addr_10_pcnt,le.populated_remarks_1_pcnt,le.populated_remarks_2_pcnt,le.populated_remarks_3_pcnt,le.populated_remarks_4_pcnt,le.populated_remarks_5_pcnt,le.populated_remarks_6_pcnt,le.populated_remarks_7_pcnt,le.populated_remarks_8_pcnt,le.populated_remarks_9_pcnt,le.populated_remarks_10_pcnt,le.populated_remarks_11_pcnt,le.populated_remarks_12_pcnt,le.populated_remarks_13_pcnt,le.populated_remarks_14_pcnt,le.populated_remarks_15_pcnt,le.populated_remarks_16_pcnt,le.populated_remarks_17_pcnt,le.populated_remarks_18_pcnt,le.populated_remarks_19_pcnt,le.populated_remarks_20_pcnt,le.populated_remarks_21_pcnt,le.populated_remarks_22_pcnt,le.populated_remarks_23_pcnt,le.populated_remarks_24_pcnt,le.populated_remarks_25_pcnt,le.populated_remarks_26_pcnt,le.populated_remarks_27_pcnt,le.populated_remarks_28_pcnt,le.populated_remarks_29_pcnt,le.populated_remarks_30_pcnt,le.populated_cname_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_suffix_pcnt,le.populated_a_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_record_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt,le.populated_did_pcnt,le.populated_aid_prim_range_pcnt,le.populated_aid_predir_pcnt,le.populated_aid_prim_name_pcnt,le.populated_aid_addr_suffix_pcnt,le.populated_aid_postdir_pcnt,le.populated_aid_unit_desig_pcnt,le.populated_aid_sec_range_pcnt,le.populated_aid_p_city_name_pcnt,le.populated_aid_v_city_name_pcnt,le.populated_aid_st_pcnt,le.populated_aid_zip_pcnt,le.populated_aid_zip4_pcnt,le.populated_aid_cart_pcnt,le.populated_aid_cr_sort_sz_pcnt,le.populated_aid_lot_pcnt,le.populated_aid_lot_order_pcnt,le.populated_aid_dpbc_pcnt,le.populated_aid_chk_digit_pcnt,le.populated_aid_record_type_pcnt,le.populated_aid_fips_st_pcnt,le.populated_aid_county_pcnt,le.populated_aid_geo_lat_pcnt,le.populated_aid_geo_long_pcnt,le.populated_aid_msa_pcnt,le.populated_aid_geo_blk_pcnt,le.populated_aid_geo_match_pcnt,le.populated_aid_err_stat_pcnt,le.populated_append_rawaid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_pty_key,le.maxlength_source,le.maxlength_orig_pty_name,le.maxlength_orig_vessel_name,le.maxlength_country,le.maxlength_name_type,le.maxlength_addr_1,le.maxlength_addr_2,le.maxlength_addr_3,le.maxlength_addr_4,le.maxlength_addr_5,le.maxlength_addr_6,le.maxlength_addr_7,le.maxlength_addr_8,le.maxlength_addr_9,le.maxlength_addr_10,le.maxlength_remarks_1,le.maxlength_remarks_2,le.maxlength_remarks_3,le.maxlength_remarks_4,le.maxlength_remarks_5,le.maxlength_remarks_6,le.maxlength_remarks_7,le.maxlength_remarks_8,le.maxlength_remarks_9,le.maxlength_remarks_10,le.maxlength_remarks_11,le.maxlength_remarks_12,le.maxlength_remarks_13,le.maxlength_remarks_14,le.maxlength_remarks_15,le.maxlength_remarks_16,le.maxlength_remarks_17,le.maxlength_remarks_18,le.maxlength_remarks_19,le.maxlength_remarks_20,le.maxlength_remarks_21,le.maxlength_remarks_22,le.maxlength_remarks_23,le.maxlength_remarks_24,le.maxlength_remarks_25,le.maxlength_remarks_26,le.maxlength_remarks_27,le.maxlength_remarks_28,le.maxlength_remarks_29,le.maxlength_remarks_30,le.maxlength_cname,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_suffix,le.maxlength_a_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_record_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_global_sid,le.maxlength_record_sid,le.maxlength_did,le.maxlength_aid_prim_range,le.maxlength_aid_predir,le.maxlength_aid_prim_name,le.maxlength_aid_addr_suffix,le.maxlength_aid_postdir,le.maxlength_aid_unit_desig,le.maxlength_aid_sec_range,le.maxlength_aid_p_city_name,le.maxlength_aid_v_city_name,le.maxlength_aid_st,le.maxlength_aid_zip,le.maxlength_aid_zip4,le.maxlength_aid_cart,le.maxlength_aid_cr_sort_sz,le.maxlength_aid_lot,le.maxlength_aid_lot_order,le.maxlength_aid_dpbc,le.maxlength_aid_chk_digit,le.maxlength_aid_record_type,le.maxlength_aid_fips_st,le.maxlength_aid_county,le.maxlength_aid_geo_lat,le.maxlength_aid_geo_long,le.maxlength_aid_msa,le.maxlength_aid_geo_blk,le.maxlength_aid_geo_match,le.maxlength_aid_err_stat,le.maxlength_append_rawaid);
  SELF.avelength := CHOOSE(C,le.avelength_pty_key,le.avelength_source,le.avelength_orig_pty_name,le.avelength_orig_vessel_name,le.avelength_country,le.avelength_name_type,le.avelength_addr_1,le.avelength_addr_2,le.avelength_addr_3,le.avelength_addr_4,le.avelength_addr_5,le.avelength_addr_6,le.avelength_addr_7,le.avelength_addr_8,le.avelength_addr_9,le.avelength_addr_10,le.avelength_remarks_1,le.avelength_remarks_2,le.avelength_remarks_3,le.avelength_remarks_4,le.avelength_remarks_5,le.avelength_remarks_6,le.avelength_remarks_7,le.avelength_remarks_8,le.avelength_remarks_9,le.avelength_remarks_10,le.avelength_remarks_11,le.avelength_remarks_12,le.avelength_remarks_13,le.avelength_remarks_14,le.avelength_remarks_15,le.avelength_remarks_16,le.avelength_remarks_17,le.avelength_remarks_18,le.avelength_remarks_19,le.avelength_remarks_20,le.avelength_remarks_21,le.avelength_remarks_22,le.avelength_remarks_23,le.avelength_remarks_24,le.avelength_remarks_25,le.avelength_remarks_26,le.avelength_remarks_27,le.avelength_remarks_28,le.avelength_remarks_29,le.avelength_remarks_30,le.avelength_cname,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_suffix,le.avelength_a_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_record_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_global_sid,le.avelength_record_sid,le.avelength_did,le.avelength_aid_prim_range,le.avelength_aid_predir,le.avelength_aid_prim_name,le.avelength_aid_addr_suffix,le.avelength_aid_postdir,le.avelength_aid_unit_desig,le.avelength_aid_sec_range,le.avelength_aid_p_city_name,le.avelength_aid_v_city_name,le.avelength_aid_st,le.avelength_aid_zip,le.avelength_aid_zip4,le.avelength_aid_cart,le.avelength_aid_cr_sort_sz,le.avelength_aid_lot,le.avelength_aid_lot_order,le.avelength_aid_dpbc,le.avelength_aid_chk_digit,le.avelength_aid_record_type,le.avelength_aid_fips_st,le.avelength_aid_county,le.avelength_aid_geo_lat,le.avelength_aid_geo_long,le.avelength_aid_msa,le.avelength_aid_geo_blk,le.avelength_aid_geo_match,le.avelength_aid_err_stat,le.avelength_append_rawaid);
END;
EXPORT invSummary := NORMALIZE(summary0, 111, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.src_key;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.pty_key),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.orig_pty_name),TRIM((SALT311.StrType)le.orig_vessel_name),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.name_type),TRIM((SALT311.StrType)le.addr_1),TRIM((SALT311.StrType)le.addr_2),TRIM((SALT311.StrType)le.addr_3),TRIM((SALT311.StrType)le.addr_4),TRIM((SALT311.StrType)le.addr_5),TRIM((SALT311.StrType)le.addr_6),TRIM((SALT311.StrType)le.addr_7),TRIM((SALT311.StrType)le.addr_8),TRIM((SALT311.StrType)le.addr_9),TRIM((SALT311.StrType)le.addr_10),TRIM((SALT311.StrType)le.remarks_1),TRIM((SALT311.StrType)le.remarks_2),TRIM((SALT311.StrType)le.remarks_3),TRIM((SALT311.StrType)le.remarks_4),TRIM((SALT311.StrType)le.remarks_5),TRIM((SALT311.StrType)le.remarks_6),TRIM((SALT311.StrType)le.remarks_7),TRIM((SALT311.StrType)le.remarks_8),TRIM((SALT311.StrType)le.remarks_9),TRIM((SALT311.StrType)le.remarks_10),TRIM((SALT311.StrType)le.remarks_11),TRIM((SALT311.StrType)le.remarks_12),TRIM((SALT311.StrType)le.remarks_13),TRIM((SALT311.StrType)le.remarks_14),TRIM((SALT311.StrType)le.remarks_15),TRIM((SALT311.StrType)le.remarks_16),TRIM((SALT311.StrType)le.remarks_17),TRIM((SALT311.StrType)le.remarks_18),TRIM((SALT311.StrType)le.remarks_19),TRIM((SALT311.StrType)le.remarks_20),TRIM((SALT311.StrType)le.remarks_21),TRIM((SALT311.StrType)le.remarks_22),TRIM((SALT311.StrType)le.remarks_23),TRIM((SALT311.StrType)le.remarks_24),TRIM((SALT311.StrType)le.remarks_25),TRIM((SALT311.StrType)le.remarks_26),TRIM((SALT311.StrType)le.remarks_27),TRIM((SALT311.StrType)le.remarks_28),TRIM((SALT311.StrType)le.remarks_29),TRIM((SALT311.StrType)le.remarks_30),TRIM((SALT311.StrType)le.cname),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.a_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.aid_prim_range),TRIM((SALT311.StrType)le.aid_predir),TRIM((SALT311.StrType)le.aid_prim_name),TRIM((SALT311.StrType)le.aid_addr_suffix),TRIM((SALT311.StrType)le.aid_postdir),TRIM((SALT311.StrType)le.aid_unit_desig),TRIM((SALT311.StrType)le.aid_sec_range),TRIM((SALT311.StrType)le.aid_p_city_name),TRIM((SALT311.StrType)le.aid_v_city_name),TRIM((SALT311.StrType)le.aid_st),TRIM((SALT311.StrType)le.aid_zip),TRIM((SALT311.StrType)le.aid_zip4),TRIM((SALT311.StrType)le.aid_cart),TRIM((SALT311.StrType)le.aid_cr_sort_sz),TRIM((SALT311.StrType)le.aid_lot),TRIM((SALT311.StrType)le.aid_lot_order),TRIM((SALT311.StrType)le.aid_dpbc),TRIM((SALT311.StrType)le.aid_chk_digit),TRIM((SALT311.StrType)le.aid_record_type),TRIM((SALT311.StrType)le.aid_fips_st),TRIM((SALT311.StrType)le.aid_county),TRIM((SALT311.StrType)le.aid_geo_lat),TRIM((SALT311.StrType)le.aid_geo_long),TRIM((SALT311.StrType)le.aid_msa),TRIM((SALT311.StrType)le.aid_geo_blk),TRIM((SALT311.StrType)le.aid_geo_match),TRIM((SALT311.StrType)le.aid_err_stat),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,111,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 111);
  SELF.FldNo2 := 1 + (C % 111);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.pty_key),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.orig_pty_name),TRIM((SALT311.StrType)le.orig_vessel_name),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.name_type),TRIM((SALT311.StrType)le.addr_1),TRIM((SALT311.StrType)le.addr_2),TRIM((SALT311.StrType)le.addr_3),TRIM((SALT311.StrType)le.addr_4),TRIM((SALT311.StrType)le.addr_5),TRIM((SALT311.StrType)le.addr_6),TRIM((SALT311.StrType)le.addr_7),TRIM((SALT311.StrType)le.addr_8),TRIM((SALT311.StrType)le.addr_9),TRIM((SALT311.StrType)le.addr_10),TRIM((SALT311.StrType)le.remarks_1),TRIM((SALT311.StrType)le.remarks_2),TRIM((SALT311.StrType)le.remarks_3),TRIM((SALT311.StrType)le.remarks_4),TRIM((SALT311.StrType)le.remarks_5),TRIM((SALT311.StrType)le.remarks_6),TRIM((SALT311.StrType)le.remarks_7),TRIM((SALT311.StrType)le.remarks_8),TRIM((SALT311.StrType)le.remarks_9),TRIM((SALT311.StrType)le.remarks_10),TRIM((SALT311.StrType)le.remarks_11),TRIM((SALT311.StrType)le.remarks_12),TRIM((SALT311.StrType)le.remarks_13),TRIM((SALT311.StrType)le.remarks_14),TRIM((SALT311.StrType)le.remarks_15),TRIM((SALT311.StrType)le.remarks_16),TRIM((SALT311.StrType)le.remarks_17),TRIM((SALT311.StrType)le.remarks_18),TRIM((SALT311.StrType)le.remarks_19),TRIM((SALT311.StrType)le.remarks_20),TRIM((SALT311.StrType)le.remarks_21),TRIM((SALT311.StrType)le.remarks_22),TRIM((SALT311.StrType)le.remarks_23),TRIM((SALT311.StrType)le.remarks_24),TRIM((SALT311.StrType)le.remarks_25),TRIM((SALT311.StrType)le.remarks_26),TRIM((SALT311.StrType)le.remarks_27),TRIM((SALT311.StrType)le.remarks_28),TRIM((SALT311.StrType)le.remarks_29),TRIM((SALT311.StrType)le.remarks_30),TRIM((SALT311.StrType)le.cname),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.a_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.aid_prim_range),TRIM((SALT311.StrType)le.aid_predir),TRIM((SALT311.StrType)le.aid_prim_name),TRIM((SALT311.StrType)le.aid_addr_suffix),TRIM((SALT311.StrType)le.aid_postdir),TRIM((SALT311.StrType)le.aid_unit_desig),TRIM((SALT311.StrType)le.aid_sec_range),TRIM((SALT311.StrType)le.aid_p_city_name),TRIM((SALT311.StrType)le.aid_v_city_name),TRIM((SALT311.StrType)le.aid_st),TRIM((SALT311.StrType)le.aid_zip),TRIM((SALT311.StrType)le.aid_zip4),TRIM((SALT311.StrType)le.aid_cart),TRIM((SALT311.StrType)le.aid_cr_sort_sz),TRIM((SALT311.StrType)le.aid_lot),TRIM((SALT311.StrType)le.aid_lot_order),TRIM((SALT311.StrType)le.aid_dpbc),TRIM((SALT311.StrType)le.aid_chk_digit),TRIM((SALT311.StrType)le.aid_record_type),TRIM((SALT311.StrType)le.aid_fips_st),TRIM((SALT311.StrType)le.aid_county),TRIM((SALT311.StrType)le.aid_geo_lat),TRIM((SALT311.StrType)le.aid_geo_long),TRIM((SALT311.StrType)le.aid_msa),TRIM((SALT311.StrType)le.aid_geo_blk),TRIM((SALT311.StrType)le.aid_geo_match),TRIM((SALT311.StrType)le.aid_err_stat),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.pty_key),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.orig_pty_name),TRIM((SALT311.StrType)le.orig_vessel_name),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.name_type),TRIM((SALT311.StrType)le.addr_1),TRIM((SALT311.StrType)le.addr_2),TRIM((SALT311.StrType)le.addr_3),TRIM((SALT311.StrType)le.addr_4),TRIM((SALT311.StrType)le.addr_5),TRIM((SALT311.StrType)le.addr_6),TRIM((SALT311.StrType)le.addr_7),TRIM((SALT311.StrType)le.addr_8),TRIM((SALT311.StrType)le.addr_9),TRIM((SALT311.StrType)le.addr_10),TRIM((SALT311.StrType)le.remarks_1),TRIM((SALT311.StrType)le.remarks_2),TRIM((SALT311.StrType)le.remarks_3),TRIM((SALT311.StrType)le.remarks_4),TRIM((SALT311.StrType)le.remarks_5),TRIM((SALT311.StrType)le.remarks_6),TRIM((SALT311.StrType)le.remarks_7),TRIM((SALT311.StrType)le.remarks_8),TRIM((SALT311.StrType)le.remarks_9),TRIM((SALT311.StrType)le.remarks_10),TRIM((SALT311.StrType)le.remarks_11),TRIM((SALT311.StrType)le.remarks_12),TRIM((SALT311.StrType)le.remarks_13),TRIM((SALT311.StrType)le.remarks_14),TRIM((SALT311.StrType)le.remarks_15),TRIM((SALT311.StrType)le.remarks_16),TRIM((SALT311.StrType)le.remarks_17),TRIM((SALT311.StrType)le.remarks_18),TRIM((SALT311.StrType)le.remarks_19),TRIM((SALT311.StrType)le.remarks_20),TRIM((SALT311.StrType)le.remarks_21),TRIM((SALT311.StrType)le.remarks_22),TRIM((SALT311.StrType)le.remarks_23),TRIM((SALT311.StrType)le.remarks_24),TRIM((SALT311.StrType)le.remarks_25),TRIM((SALT311.StrType)le.remarks_26),TRIM((SALT311.StrType)le.remarks_27),TRIM((SALT311.StrType)le.remarks_28),TRIM((SALT311.StrType)le.remarks_29),TRIM((SALT311.StrType)le.remarks_30),TRIM((SALT311.StrType)le.cname),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.a_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.aid_prim_range),TRIM((SALT311.StrType)le.aid_predir),TRIM((SALT311.StrType)le.aid_prim_name),TRIM((SALT311.StrType)le.aid_addr_suffix),TRIM((SALT311.StrType)le.aid_postdir),TRIM((SALT311.StrType)le.aid_unit_desig),TRIM((SALT311.StrType)le.aid_sec_range),TRIM((SALT311.StrType)le.aid_p_city_name),TRIM((SALT311.StrType)le.aid_v_city_name),TRIM((SALT311.StrType)le.aid_st),TRIM((SALT311.StrType)le.aid_zip),TRIM((SALT311.StrType)le.aid_zip4),TRIM((SALT311.StrType)le.aid_cart),TRIM((SALT311.StrType)le.aid_cr_sort_sz),TRIM((SALT311.StrType)le.aid_lot),TRIM((SALT311.StrType)le.aid_lot_order),TRIM((SALT311.StrType)le.aid_dpbc),TRIM((SALT311.StrType)le.aid_chk_digit),TRIM((SALT311.StrType)le.aid_record_type),TRIM((SALT311.StrType)le.aid_fips_st),TRIM((SALT311.StrType)le.aid_county),TRIM((SALT311.StrType)le.aid_geo_lat),TRIM((SALT311.StrType)le.aid_geo_long),TRIM((SALT311.StrType)le.aid_msa),TRIM((SALT311.StrType)le.aid_geo_blk),TRIM((SALT311.StrType)le.aid_geo_match),TRIM((SALT311.StrType)le.aid_err_stat),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),111*111,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{81,'global_sid'}
      ,{82,'record_sid'}
      ,{83,'did'}
      ,{84,'aid_prim_range'}
      ,{85,'aid_predir'}
      ,{86,'aid_prim_name'}
      ,{87,'aid_addr_suffix'}
      ,{88,'aid_postdir'}
      ,{89,'aid_unit_desig'}
      ,{90,'aid_sec_range'}
      ,{91,'aid_p_city_name'}
      ,{92,'aid_v_city_name'}
      ,{93,'aid_st'}
      ,{94,'aid_zip'}
      ,{95,'aid_zip4'}
      ,{96,'aid_cart'}
      ,{97,'aid_cr_sort_sz'}
      ,{98,'aid_lot'}
      ,{99,'aid_lot_order'}
      ,{100,'aid_dpbc'}
      ,{101,'aid_chk_digit'}
      ,{102,'aid_record_type'}
      ,{103,'aid_fips_st'}
      ,{104,'aid_county'}
      ,{105,'aid_geo_lat'}
      ,{106,'aid_geo_long'}
      ,{107,'aid_msa'}
      ,{108,'aid_geo_blk'}
      ,{109,'aid_geo_match'}
      ,{110,'aid_err_stat'}
      ,{111,'append_rawaid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.src_key) src_key; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_pty_key((SALT311.StrType)le.pty_key),
    Fields.InValid_source((SALT311.StrType)le.source),
    Fields.InValid_orig_pty_name((SALT311.StrType)le.orig_pty_name),
    Fields.InValid_orig_vessel_name((SALT311.StrType)le.orig_vessel_name),
    Fields.InValid_country((SALT311.StrType)le.country),
    Fields.InValid_name_type((SALT311.StrType)le.name_type),
    Fields.InValid_addr_1((SALT311.StrType)le.addr_1),
    Fields.InValid_addr_2((SALT311.StrType)le.addr_2),
    Fields.InValid_addr_3((SALT311.StrType)le.addr_3),
    Fields.InValid_addr_4((SALT311.StrType)le.addr_4),
    Fields.InValid_addr_5((SALT311.StrType)le.addr_5),
    Fields.InValid_addr_6((SALT311.StrType)le.addr_6),
    Fields.InValid_addr_7((SALT311.StrType)le.addr_7),
    Fields.InValid_addr_8((SALT311.StrType)le.addr_8),
    Fields.InValid_addr_9((SALT311.StrType)le.addr_9),
    Fields.InValid_addr_10((SALT311.StrType)le.addr_10),
    Fields.InValid_remarks_1((SALT311.StrType)le.remarks_1),
    Fields.InValid_remarks_2((SALT311.StrType)le.remarks_2),
    Fields.InValid_remarks_3((SALT311.StrType)le.remarks_3),
    Fields.InValid_remarks_4((SALT311.StrType)le.remarks_4),
    Fields.InValid_remarks_5((SALT311.StrType)le.remarks_5),
    Fields.InValid_remarks_6((SALT311.StrType)le.remarks_6),
    Fields.InValid_remarks_7((SALT311.StrType)le.remarks_7),
    Fields.InValid_remarks_8((SALT311.StrType)le.remarks_8),
    Fields.InValid_remarks_9((SALT311.StrType)le.remarks_9),
    Fields.InValid_remarks_10((SALT311.StrType)le.remarks_10),
    Fields.InValid_remarks_11((SALT311.StrType)le.remarks_11),
    Fields.InValid_remarks_12((SALT311.StrType)le.remarks_12),
    Fields.InValid_remarks_13((SALT311.StrType)le.remarks_13),
    Fields.InValid_remarks_14((SALT311.StrType)le.remarks_14),
    Fields.InValid_remarks_15((SALT311.StrType)le.remarks_15),
    Fields.InValid_remarks_16((SALT311.StrType)le.remarks_16),
    Fields.InValid_remarks_17((SALT311.StrType)le.remarks_17),
    Fields.InValid_remarks_18((SALT311.StrType)le.remarks_18),
    Fields.InValid_remarks_19((SALT311.StrType)le.remarks_19),
    Fields.InValid_remarks_20((SALT311.StrType)le.remarks_20),
    Fields.InValid_remarks_21((SALT311.StrType)le.remarks_21),
    Fields.InValid_remarks_22((SALT311.StrType)le.remarks_22),
    Fields.InValid_remarks_23((SALT311.StrType)le.remarks_23),
    Fields.InValid_remarks_24((SALT311.StrType)le.remarks_24),
    Fields.InValid_remarks_25((SALT311.StrType)le.remarks_25),
    Fields.InValid_remarks_26((SALT311.StrType)le.remarks_26),
    Fields.InValid_remarks_27((SALT311.StrType)le.remarks_27),
    Fields.InValid_remarks_28((SALT311.StrType)le.remarks_28),
    Fields.InValid_remarks_29((SALT311.StrType)le.remarks_29),
    Fields.InValid_remarks_30((SALT311.StrType)le.remarks_30),
    Fields.InValid_cname((SALT311.StrType)le.cname),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Fields.InValid_a_score((SALT311.StrType)le.a_score),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_cart((SALT311.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT311.StrType)le.lot),
    Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT311.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_aid_prim_range((SALT311.StrType)le.aid_prim_range),
    Fields.InValid_aid_predir((SALT311.StrType)le.aid_predir),
    Fields.InValid_aid_prim_name((SALT311.StrType)le.aid_prim_name),
    Fields.InValid_aid_addr_suffix((SALT311.StrType)le.aid_addr_suffix),
    Fields.InValid_aid_postdir((SALT311.StrType)le.aid_postdir),
    Fields.InValid_aid_unit_desig((SALT311.StrType)le.aid_unit_desig),
    Fields.InValid_aid_sec_range((SALT311.StrType)le.aid_sec_range),
    Fields.InValid_aid_p_city_name((SALT311.StrType)le.aid_p_city_name),
    Fields.InValid_aid_v_city_name((SALT311.StrType)le.aid_v_city_name),
    Fields.InValid_aid_st((SALT311.StrType)le.aid_st),
    Fields.InValid_aid_zip((SALT311.StrType)le.aid_zip),
    Fields.InValid_aid_zip4((SALT311.StrType)le.aid_zip4),
    Fields.InValid_aid_cart((SALT311.StrType)le.aid_cart),
    Fields.InValid_aid_cr_sort_sz((SALT311.StrType)le.aid_cr_sort_sz),
    Fields.InValid_aid_lot((SALT311.StrType)le.aid_lot),
    Fields.InValid_aid_lot_order((SALT311.StrType)le.aid_lot_order),
    Fields.InValid_aid_dpbc((SALT311.StrType)le.aid_dpbc),
    Fields.InValid_aid_chk_digit((SALT311.StrType)le.aid_chk_digit),
    Fields.InValid_aid_record_type((SALT311.StrType)le.aid_record_type),
    Fields.InValid_aid_fips_st((SALT311.StrType)le.aid_fips_st),
    Fields.InValid_aid_county((SALT311.StrType)le.aid_county),
    Fields.InValid_aid_geo_lat((SALT311.StrType)le.aid_geo_lat),
    Fields.InValid_aid_geo_long((SALT311.StrType)le.aid_geo_long),
    Fields.InValid_aid_msa((SALT311.StrType)le.aid_msa),
    Fields.InValid_aid_geo_blk((SALT311.StrType)le.aid_geo_blk),
    Fields.InValid_aid_geo_match((SALT311.StrType)le.aid_geo_match),
    Fields.InValid_aid_err_stat((SALT311.StrType)le.aid_err_stat),
    Fields.InValid_append_rawaid((SALT311.StrType)le.append_rawaid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.src_key := le.src_key;
END;
Errors := NORMALIZE(h,111,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_source_code','invalid_source','invalid_name','Unknown','invalid_country_name','invalid_name_type','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_name','invalid_suffix','Unknown','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_alpha','invalid_alpha','invalid_zip','invalid_zip4','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_pty_key(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_orig_pty_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_vessel_name(TotalErrors.ErrorNum),Fields.InValidMessage_country(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_addr_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_3(TotalErrors.ErrorNum),Fields.InValidMessage_addr_4(TotalErrors.ErrorNum),Fields.InValidMessage_addr_5(TotalErrors.ErrorNum),Fields.InValidMessage_addr_6(TotalErrors.ErrorNum),Fields.InValidMessage_addr_7(TotalErrors.ErrorNum),Fields.InValidMessage_addr_8(TotalErrors.ErrorNum),Fields.InValidMessage_addr_9(TotalErrors.ErrorNum),Fields.InValidMessage_addr_10(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_1(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_2(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_3(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_4(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_5(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_6(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_7(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_8(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_9(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_10(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_11(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_12(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_13(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_14(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_15(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_16(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_17(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_18(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_19(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_20(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_21(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_22(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_23(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_24(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_25(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_26(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_27(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_28(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_29(TotalErrors.ErrorNum),Fields.InValidMessage_remarks_30(TotalErrors.ErrorNum),Fields.InValidMessage_cname(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_a_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Fields.InValidMessage_record_sid(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_aid_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_aid_predir(TotalErrors.ErrorNum),Fields.InValidMessage_aid_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_aid_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_aid_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_aid_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_aid_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_aid_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_aid_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_aid_st(TotalErrors.ErrorNum),Fields.InValidMessage_aid_zip(TotalErrors.ErrorNum),Fields.InValidMessage_aid_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_aid_cart(TotalErrors.ErrorNum),Fields.InValidMessage_aid_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_aid_lot(TotalErrors.ErrorNum),Fields.InValidMessage_aid_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_aid_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_aid_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_aid_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_aid_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_aid_county(TotalErrors.ErrorNum),Fields.InValidMessage_aid_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_aid_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_aid_msa(TotalErrors.ErrorNum),Fields.InValidMessage_aid_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_aid_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_aid_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_append_rawaid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.src_key=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Patriot, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
