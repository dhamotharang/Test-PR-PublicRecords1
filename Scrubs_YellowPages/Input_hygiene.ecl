IMPORT SALT311,STD;
EXPORT Input_hygiene(dataset(Input_layout_YellowPages) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_primary_key_cnt := COUNT(GROUP,h.primary_key <> (TYPEOF(h.primary_key))'');
    populated_primary_key_pcnt := AVE(GROUP,IF(h.primary_key = (TYPEOF(h.primary_key))'',0,100));
    maxlength_primary_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_key)));
    avelength_primary_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_key)),h.primary_key<>(typeof(h.primary_key))'');
    populated_chainid_cnt := COUNT(GROUP,h.chainid <> (TYPEOF(h.chainid))'');
    populated_chainid_pcnt := AVE(GROUP,IF(h.chainid = (TYPEOF(h.chainid))'',0,100));
    maxlength_chainid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chainid)));
    avelength_chainid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chainid)),h.chainid<>(typeof(h.chainid))'');
    populated_filler1_cnt := COUNT(GROUP,h.filler1 <> (TYPEOF(h.filler1))'');
    populated_filler1_pcnt := AVE(GROUP,IF(h.filler1 = (TYPEOF(h.filler1))'',0,100));
    maxlength_filler1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler1)));
    avelength_filler1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler1)),h.filler1<>(typeof(h.filler1))'');
    populated_pub_date_cnt := COUNT(GROUP,h.pub_date <> (TYPEOF(h.pub_date))'');
    populated_pub_date_pcnt := AVE(GROUP,IF(h.pub_date = (TYPEOF(h.pub_date))'',0,100));
    maxlength_pub_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pub_date)));
    avelength_pub_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pub_date)),h.pub_date<>(typeof(h.pub_date))'');
    populated_busshortname_cnt := COUNT(GROUP,h.busshortname <> (TYPEOF(h.busshortname))'');
    populated_busshortname_pcnt := AVE(GROUP,IF(h.busshortname = (TYPEOF(h.busshortname))'',0,100));
    maxlength_busshortname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.busshortname)));
    avelength_busshortname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.busshortname)),h.busshortname<>(typeof(h.busshortname))'');
    populated_business_name_cnt := COUNT(GROUP,h.business_name <> (TYPEOF(h.business_name))'');
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_busdeptname_cnt := COUNT(GROUP,h.busdeptname <> (TYPEOF(h.busdeptname))'');
    populated_busdeptname_pcnt := AVE(GROUP,IF(h.busdeptname = (TYPEOF(h.busdeptname))'',0,100));
    maxlength_busdeptname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.busdeptname)));
    avelength_busdeptname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.busdeptname)),h.busdeptname<>(typeof(h.busdeptname))'');
    populated_house_cnt := COUNT(GROUP,h.house <> (TYPEOF(h.house))'');
    populated_house_pcnt := AVE(GROUP,IF(h.house = (TYPEOF(h.house))'',0,100));
    maxlength_house := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.house)));
    avelength_house := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.house)),h.house<>(typeof(h.house))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_street_cnt := COUNT(GROUP,h.street <> (TYPEOF(h.street))'');
    populated_street_pcnt := AVE(GROUP,IF(h.street = (TYPEOF(h.street))'',0,100));
    maxlength_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)));
    avelength_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)),h.street<>(typeof(h.street))'');
    populated_streettype_cnt := COUNT(GROUP,h.streettype <> (TYPEOF(h.streettype))'');
    populated_streettype_pcnt := AVE(GROUP,IF(h.streettype = (TYPEOF(h.streettype))'',0,100));
    maxlength_streettype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.streettype)));
    avelength_streettype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.streettype)),h.streettype<>(typeof(h.streettype))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_apttype_cnt := COUNT(GROUP,h.apttype <> (TYPEOF(h.apttype))'');
    populated_apttype_pcnt := AVE(GROUP,IF(h.apttype = (TYPEOF(h.apttype))'',0,100));
    maxlength_apttype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apttype)));
    avelength_apttype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apttype)),h.apttype<>(typeof(h.apttype))'');
    populated_aptnbr_cnt := COUNT(GROUP,h.aptnbr <> (TYPEOF(h.aptnbr))'');
    populated_aptnbr_pcnt := AVE(GROUP,IF(h.aptnbr = (TYPEOF(h.aptnbr))'',0,100));
    maxlength_aptnbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aptnbr)));
    avelength_aptnbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aptnbr)),h.aptnbr<>(typeof(h.aptnbr))'');
    populated_boxnbr_cnt := COUNT(GROUP,h.boxnbr <> (TYPEOF(h.boxnbr))'');
    populated_boxnbr_pcnt := AVE(GROUP,IF(h.boxnbr = (TYPEOF(h.boxnbr))'',0,100));
    maxlength_boxnbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.boxnbr)));
    avelength_boxnbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.boxnbr)),h.boxnbr<>(typeof(h.boxnbr))'');
    populated_exppubcity_cnt := COUNT(GROUP,h.exppubcity <> (TYPEOF(h.exppubcity))'');
    populated_exppubcity_pcnt := AVE(GROUP,IF(h.exppubcity = (TYPEOF(h.exppubcity))'',0,100));
    maxlength_exppubcity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exppubcity)));
    avelength_exppubcity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exppubcity)),h.exppubcity<>(typeof(h.exppubcity))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_dpc_cnt := COUNT(GROUP,h.dpc <> (TYPEOF(h.dpc))'');
    populated_dpc_pcnt := AVE(GROUP,IF(h.dpc = (TYPEOF(h.dpc))'',0,100));
    maxlength_dpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpc)));
    avelength_dpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpc)),h.dpc<>(typeof(h.dpc))'');
    populated_carrierroute_cnt := COUNT(GROUP,h.carrierroute <> (TYPEOF(h.carrierroute))'');
    populated_carrierroute_pcnt := AVE(GROUP,IF(h.carrierroute = (TYPEOF(h.carrierroute))'',0,100));
    maxlength_carrierroute := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrierroute)));
    avelength_carrierroute := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrierroute)),h.carrierroute<>(typeof(h.carrierroute))'');
    populated_fips_cnt := COUNT(GROUP,h.fips <> (TYPEOF(h.fips))'');
    populated_fips_pcnt := AVE(GROUP,IF(h.fips = (TYPEOF(h.fips))'',0,100));
    maxlength_fips := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips)));
    avelength_fips := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips)),h.fips<>(typeof(h.fips))'');
    populated_countycode_cnt := COUNT(GROUP,h.countycode <> (TYPEOF(h.countycode))'');
    populated_countycode_pcnt := AVE(GROUP,IF(h.countycode = (TYPEOF(h.countycode))'',0,100));
    maxlength_countycode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.countycode)));
    avelength_countycode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.countycode)),h.countycode<>(typeof(h.countycode))'');
    populated_z4type_cnt := COUNT(GROUP,h.z4type <> (TYPEOF(h.z4type))'');
    populated_z4type_pcnt := AVE(GROUP,IF(h.z4type = (TYPEOF(h.z4type))'',0,100));
    maxlength_z4type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4type)));
    avelength_z4type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4type)),h.z4type<>(typeof(h.z4type))'');
    populated_ctract_cnt := COUNT(GROUP,h.ctract <> (TYPEOF(h.ctract))'');
    populated_ctract_pcnt := AVE(GROUP,IF(h.ctract = (TYPEOF(h.ctract))'',0,100));
    maxlength_ctract := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ctract)));
    avelength_ctract := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ctract)),h.ctract<>(typeof(h.ctract))'');
    populated_cblockgroup_cnt := COUNT(GROUP,h.cblockgroup <> (TYPEOF(h.cblockgroup))'');
    populated_cblockgroup_pcnt := AVE(GROUP,IF(h.cblockgroup = (TYPEOF(h.cblockgroup))'',0,100));
    maxlength_cblockgroup := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cblockgroup)));
    avelength_cblockgroup := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cblockgroup)),h.cblockgroup<>(typeof(h.cblockgroup))'');
    populated_cblockid_cnt := COUNT(GROUP,h.cblockid <> (TYPEOF(h.cblockid))'');
    populated_cblockid_pcnt := AVE(GROUP,IF(h.cblockid = (TYPEOF(h.cblockid))'',0,100));
    maxlength_cblockid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cblockid)));
    avelength_cblockid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cblockid)),h.cblockid<>(typeof(h.cblockid))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_cbsa_cnt := COUNT(GROUP,h.cbsa <> (TYPEOF(h.cbsa))'');
    populated_cbsa_pcnt := AVE(GROUP,IF(h.cbsa = (TYPEOF(h.cbsa))'',0,100));
    maxlength_cbsa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa)));
    avelength_cbsa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa)),h.cbsa<>(typeof(h.cbsa))'');
    populated_mcdcode_cnt := COUNT(GROUP,h.mcdcode <> (TYPEOF(h.mcdcode))'');
    populated_mcdcode_pcnt := AVE(GROUP,IF(h.mcdcode = (TYPEOF(h.mcdcode))'',0,100));
    maxlength_mcdcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcdcode)));
    avelength_mcdcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcdcode)),h.mcdcode<>(typeof(h.mcdcode))'');
    populated_filler2_cnt := COUNT(GROUP,h.filler2 <> (TYPEOF(h.filler2))'');
    populated_filler2_pcnt := AVE(GROUP,IF(h.filler2 = (TYPEOF(h.filler2))'',0,100));
    maxlength_filler2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)));
    avelength_filler2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)),h.filler2<>(typeof(h.filler2))'');
    populated_addrsensitivity_cnt := COUNT(GROUP,h.addrsensitivity <> (TYPEOF(h.addrsensitivity))'');
    populated_addrsensitivity_pcnt := AVE(GROUP,IF(h.addrsensitivity = (TYPEOF(h.addrsensitivity))'',0,100));
    maxlength_addrsensitivity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addrsensitivity)));
    avelength_addrsensitivity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addrsensitivity)),h.addrsensitivity<>(typeof(h.addrsensitivity))'');
    populated_maildeliverabilitycode_cnt := COUNT(GROUP,h.maildeliverabilitycode <> (TYPEOF(h.maildeliverabilitycode))'');
    populated_maildeliverabilitycode_pcnt := AVE(GROUP,IF(h.maildeliverabilitycode = (TYPEOF(h.maildeliverabilitycode))'',0,100));
    maxlength_maildeliverabilitycode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.maildeliverabilitycode)));
    avelength_maildeliverabilitycode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.maildeliverabilitycode)),h.maildeliverabilitycode<>(typeof(h.maildeliverabilitycode))'');
    populated_sic1_4_cnt := COUNT(GROUP,h.sic1_4 <> (TYPEOF(h.sic1_4))'');
    populated_sic1_4_pcnt := AVE(GROUP,IF(h.sic1_4 = (TYPEOF(h.sic1_4))'',0,100));
    maxlength_sic1_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic1_4)));
    avelength_sic1_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic1_4)),h.sic1_4<>(typeof(h.sic1_4))'');
    populated_sic_code_cnt := COUNT(GROUP,h.sic_code <> (TYPEOF(h.sic_code))'');
    populated_sic_code_pcnt := AVE(GROUP,IF(h.sic_code = (TYPEOF(h.sic_code))'',0,100));
    maxlength_sic_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)));
    avelength_sic_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)),h.sic_code<>(typeof(h.sic_code))'');
    populated_sic2_cnt := COUNT(GROUP,h.sic2 <> (TYPEOF(h.sic2))'');
    populated_sic2_pcnt := AVE(GROUP,IF(h.sic2 = (TYPEOF(h.sic2))'',0,100));
    maxlength_sic2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic2)));
    avelength_sic2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic2)),h.sic2<>(typeof(h.sic2))'');
    populated_sic3_cnt := COUNT(GROUP,h.sic3 <> (TYPEOF(h.sic3))'');
    populated_sic3_pcnt := AVE(GROUP,IF(h.sic3 = (TYPEOF(h.sic3))'',0,100));
    maxlength_sic3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic3)));
    avelength_sic3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic3)),h.sic3<>(typeof(h.sic3))'');
    populated_sic4_cnt := COUNT(GROUP,h.sic4 <> (TYPEOF(h.sic4))'');
    populated_sic4_pcnt := AVE(GROUP,IF(h.sic4 = (TYPEOF(h.sic4))'',0,100));
    maxlength_sic4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic4)));
    avelength_sic4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic4)),h.sic4<>(typeof(h.sic4))'');
    populated_indstryclass_cnt := COUNT(GROUP,h.indstryclass <> (TYPEOF(h.indstryclass))'');
    populated_indstryclass_pcnt := AVE(GROUP,IF(h.indstryclass = (TYPEOF(h.indstryclass))'',0,100));
    maxlength_indstryclass := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.indstryclass)));
    avelength_indstryclass := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.indstryclass)),h.indstryclass<>(typeof(h.indstryclass))'');
    populated_naics_code_cnt := COUNT(GROUP,h.naics_code <> (TYPEOF(h.naics_code))'');
    populated_naics_code_pcnt := AVE(GROUP,IF(h.naics_code = (TYPEOF(h.naics_code))'',0,100));
    maxlength_naics_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics_code)));
    avelength_naics_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics_code)),h.naics_code<>(typeof(h.naics_code))'');
    populated_mlsc_cnt := COUNT(GROUP,h.mlsc <> (TYPEOF(h.mlsc))'');
    populated_mlsc_pcnt := AVE(GROUP,IF(h.mlsc = (TYPEOF(h.mlsc))'',0,100));
    maxlength_mlsc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mlsc)));
    avelength_mlsc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mlsc)),h.mlsc<>(typeof(h.mlsc))'');
    populated_filler3_cnt := COUNT(GROUP,h.filler3 <> (TYPEOF(h.filler3))'');
    populated_filler3_pcnt := AVE(GROUP,IF(h.filler3 = (TYPEOF(h.filler3))'',0,100));
    maxlength_filler3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler3)));
    avelength_filler3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler3)),h.filler3<>(typeof(h.filler3))'');
    populated_orig_phone10_cnt := COUNT(GROUP,h.orig_phone10 <> (TYPEOF(h.orig_phone10))'');
    populated_orig_phone10_pcnt := AVE(GROUP,IF(h.orig_phone10 = (TYPEOF(h.orig_phone10))'',0,100));
    maxlength_orig_phone10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_phone10)));
    avelength_orig_phone10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_phone10)),h.orig_phone10<>(typeof(h.orig_phone10))'');
    populated_nosolicitcode_cnt := COUNT(GROUP,h.nosolicitcode <> (TYPEOF(h.nosolicitcode))'');
    populated_nosolicitcode_pcnt := AVE(GROUP,IF(h.nosolicitcode = (TYPEOF(h.nosolicitcode))'',0,100));
    maxlength_nosolicitcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nosolicitcode)));
    avelength_nosolicitcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nosolicitcode)),h.nosolicitcode<>(typeof(h.nosolicitcode))'');
    populated_dso_cnt := COUNT(GROUP,h.dso <> (TYPEOF(h.dso))'');
    populated_dso_pcnt := AVE(GROUP,IF(h.dso = (TYPEOF(h.dso))'',0,100));
    maxlength_dso := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dso)));
    avelength_dso := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dso)),h.dso<>(typeof(h.dso))'');
    populated_timezone_cnt := COUNT(GROUP,h.timezone <> (TYPEOF(h.timezone))'');
    populated_timezone_pcnt := AVE(GROUP,IF(h.timezone = (TYPEOF(h.timezone))'',0,100));
    maxlength_timezone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.timezone)));
    avelength_timezone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.timezone)),h.timezone<>(typeof(h.timezone))'');
    populated_validationflag_cnt := COUNT(GROUP,h.validationflag <> (TYPEOF(h.validationflag))'');
    populated_validationflag_pcnt := AVE(GROUP,IF(h.validationflag = (TYPEOF(h.validationflag))'',0,100));
    maxlength_validationflag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.validationflag)));
    avelength_validationflag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.validationflag)),h.validationflag<>(typeof(h.validationflag))'');
    populated_validationdate_cnt := COUNT(GROUP,h.validationdate <> (TYPEOF(h.validationdate))'');
    populated_validationdate_pcnt := AVE(GROUP,IF(h.validationdate = (TYPEOF(h.validationdate))'',0,100));
    maxlength_validationdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.validationdate)));
    avelength_validationdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.validationdate)),h.validationdate<>(typeof(h.validationdate))'');
    populated_secvalidationcode_cnt := COUNT(GROUP,h.secvalidationcode <> (TYPEOF(h.secvalidationcode))'');
    populated_secvalidationcode_pcnt := AVE(GROUP,IF(h.secvalidationcode = (TYPEOF(h.secvalidationcode))'',0,100));
    maxlength_secvalidationcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.secvalidationcode)));
    avelength_secvalidationcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.secvalidationcode)),h.secvalidationcode<>(typeof(h.secvalidationcode))'');
    populated_singleaddrflag_cnt := COUNT(GROUP,h.singleaddrflag <> (TYPEOF(h.singleaddrflag))'');
    populated_singleaddrflag_pcnt := AVE(GROUP,IF(h.singleaddrflag = (TYPEOF(h.singleaddrflag))'',0,100));
    maxlength_singleaddrflag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.singleaddrflag)));
    avelength_singleaddrflag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.singleaddrflag)),h.singleaddrflag<>(typeof(h.singleaddrflag))'');
    populated_filler4_cnt := COUNT(GROUP,h.filler4 <> (TYPEOF(h.filler4))'');
    populated_filler4_pcnt := AVE(GROUP,IF(h.filler4 = (TYPEOF(h.filler4))'',0,100));
    maxlength_filler4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler4)));
    avelength_filler4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler4)),h.filler4<>(typeof(h.filler4))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_execname_cnt := COUNT(GROUP,h.execname <> (TYPEOF(h.execname))'');
    populated_execname_pcnt := AVE(GROUP,IF(h.execname = (TYPEOF(h.execname))'',0,100));
    maxlength_execname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.execname)));
    avelength_execname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.execname)),h.execname<>(typeof(h.execname))'');
    populated_exectitlecode_cnt := COUNT(GROUP,h.exectitlecode <> (TYPEOF(h.exectitlecode))'');
    populated_exectitlecode_pcnt := AVE(GROUP,IF(h.exectitlecode = (TYPEOF(h.exectitlecode))'',0,100));
    maxlength_exectitlecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exectitlecode)));
    avelength_exectitlecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exectitlecode)),h.exectitlecode<>(typeof(h.exectitlecode))'');
    populated_exectitle_cnt := COUNT(GROUP,h.exectitle <> (TYPEOF(h.exectitle))'');
    populated_exectitle_pcnt := AVE(GROUP,IF(h.exectitle = (TYPEOF(h.exectitle))'',0,100));
    maxlength_exectitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exectitle)));
    avelength_exectitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exectitle)),h.exectitle<>(typeof(h.exectitle))'');
    populated_condtitlecode_cnt := COUNT(GROUP,h.condtitlecode <> (TYPEOF(h.condtitlecode))'');
    populated_condtitlecode_pcnt := AVE(GROUP,IF(h.condtitlecode = (TYPEOF(h.condtitlecode))'',0,100));
    maxlength_condtitlecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.condtitlecode)));
    avelength_condtitlecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.condtitlecode)),h.condtitlecode<>(typeof(h.condtitlecode))'');
    populated_condtitle_cnt := COUNT(GROUP,h.condtitle <> (TYPEOF(h.condtitle))'');
    populated_condtitle_pcnt := AVE(GROUP,IF(h.condtitle = (TYPEOF(h.condtitle))'',0,100));
    maxlength_condtitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.condtitle)));
    avelength_condtitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.condtitle)),h.condtitle<>(typeof(h.condtitle))'');
    populated_contfunctioncode_cnt := COUNT(GROUP,h.contfunctioncode <> (TYPEOF(h.contfunctioncode))'');
    populated_contfunctioncode_pcnt := AVE(GROUP,IF(h.contfunctioncode = (TYPEOF(h.contfunctioncode))'',0,100));
    maxlength_contfunctioncode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfunctioncode)));
    avelength_contfunctioncode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfunctioncode)),h.contfunctioncode<>(typeof(h.contfunctioncode))'');
    populated_contfunction_cnt := COUNT(GROUP,h.contfunction <> (TYPEOF(h.contfunction))'');
    populated_contfunction_pcnt := AVE(GROUP,IF(h.contfunction = (TYPEOF(h.contfunction))'',0,100));
    maxlength_contfunction := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfunction)));
    avelength_contfunction := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfunction)),h.contfunction<>(typeof(h.contfunction))'');
    populated_profession_cnt := COUNT(GROUP,h.profession <> (TYPEOF(h.profession))'');
    populated_profession_pcnt := AVE(GROUP,IF(h.profession = (TYPEOF(h.profession))'',0,100));
    maxlength_profession := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.profession)));
    avelength_profession := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.profession)),h.profession<>(typeof(h.profession))'');
    populated_emplsizecode_cnt := COUNT(GROUP,h.emplsizecode <> (TYPEOF(h.emplsizecode))'');
    populated_emplsizecode_pcnt := AVE(GROUP,IF(h.emplsizecode = (TYPEOF(h.emplsizecode))'',0,100));
    maxlength_emplsizecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.emplsizecode)));
    avelength_emplsizecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.emplsizecode)),h.emplsizecode<>(typeof(h.emplsizecode))'');
    populated_annualsalescode_cnt := COUNT(GROUP,h.annualsalescode <> (TYPEOF(h.annualsalescode))'');
    populated_annualsalescode_pcnt := AVE(GROUP,IF(h.annualsalescode = (TYPEOF(h.annualsalescode))'',0,100));
    maxlength_annualsalescode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.annualsalescode)));
    avelength_annualsalescode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.annualsalescode)),h.annualsalescode<>(typeof(h.annualsalescode))'');
    populated_yrsinbus_cnt := COUNT(GROUP,h.yrsinbus <> (TYPEOF(h.yrsinbus))'');
    populated_yrsinbus_pcnt := AVE(GROUP,IF(h.yrsinbus = (TYPEOF(h.yrsinbus))'',0,100));
    maxlength_yrsinbus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.yrsinbus)));
    avelength_yrsinbus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.yrsinbus)),h.yrsinbus<>(typeof(h.yrsinbus))'');
    populated_ethniccode_cnt := COUNT(GROUP,h.ethniccode <> (TYPEOF(h.ethniccode))'');
    populated_ethniccode_pcnt := AVE(GROUP,IF(h.ethniccode = (TYPEOF(h.ethniccode))'',0,100));
    maxlength_ethniccode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ethniccode)));
    avelength_ethniccode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ethniccode)),h.ethniccode<>(typeof(h.ethniccode))'');
    populated_filler5_cnt := COUNT(GROUP,h.filler5 <> (TYPEOF(h.filler5))'');
    populated_filler5_pcnt := AVE(GROUP,IF(h.filler5 = (TYPEOF(h.filler5))'',0,100));
    maxlength_filler5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler5)));
    avelength_filler5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler5)),h.filler5<>(typeof(h.filler5))'');
    populated_latlongmatchlevel_cnt := COUNT(GROUP,h.latlongmatchlevel <> (TYPEOF(h.latlongmatchlevel))'');
    populated_latlongmatchlevel_pcnt := AVE(GROUP,IF(h.latlongmatchlevel = (TYPEOF(h.latlongmatchlevel))'',0,100));
    maxlength_latlongmatchlevel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.latlongmatchlevel)));
    avelength_latlongmatchlevel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.latlongmatchlevel)),h.latlongmatchlevel<>(typeof(h.latlongmatchlevel))'');
    populated_orig_latitude_cnt := COUNT(GROUP,h.orig_latitude <> (TYPEOF(h.orig_latitude))'');
    populated_orig_latitude_pcnt := AVE(GROUP,IF(h.orig_latitude = (TYPEOF(h.orig_latitude))'',0,100));
    maxlength_orig_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_latitude)));
    avelength_orig_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_latitude)),h.orig_latitude<>(typeof(h.orig_latitude))'');
    populated_orig_longitude_cnt := COUNT(GROUP,h.orig_longitude <> (TYPEOF(h.orig_longitude))'');
    populated_orig_longitude_pcnt := AVE(GROUP,IF(h.orig_longitude = (TYPEOF(h.orig_longitude))'',0,100));
    maxlength_orig_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_longitude)));
    avelength_orig_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_longitude)),h.orig_longitude<>(typeof(h.orig_longitude))'');
    populated_filler6_cnt := COUNT(GROUP,h.filler6 <> (TYPEOF(h.filler6))'');
    populated_filler6_pcnt := AVE(GROUP,IF(h.filler6 = (TYPEOF(h.filler6))'',0,100));
    maxlength_filler6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler6)));
    avelength_filler6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler6)),h.filler6<>(typeof(h.filler6))'');
    populated_heading_string_cnt := COUNT(GROUP,h.heading_string <> (TYPEOF(h.heading_string))'');
    populated_heading_string_pcnt := AVE(GROUP,IF(h.heading_string = (TYPEOF(h.heading_string))'',0,100));
    maxlength_heading_string := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.heading_string)));
    avelength_heading_string := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.heading_string)),h.heading_string<>(typeof(h.heading_string))'');
    populated_ypheading2_cnt := COUNT(GROUP,h.ypheading2 <> (TYPEOF(h.ypheading2))'');
    populated_ypheading2_pcnt := AVE(GROUP,IF(h.ypheading2 = (TYPEOF(h.ypheading2))'',0,100));
    maxlength_ypheading2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading2)));
    avelength_ypheading2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading2)),h.ypheading2<>(typeof(h.ypheading2))'');
    populated_ypheading3_cnt := COUNT(GROUP,h.ypheading3 <> (TYPEOF(h.ypheading3))'');
    populated_ypheading3_pcnt := AVE(GROUP,IF(h.ypheading3 = (TYPEOF(h.ypheading3))'',0,100));
    maxlength_ypheading3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading3)));
    avelength_ypheading3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading3)),h.ypheading3<>(typeof(h.ypheading3))'');
    populated_ypheading4_cnt := COUNT(GROUP,h.ypheading4 <> (TYPEOF(h.ypheading4))'');
    populated_ypheading4_pcnt := AVE(GROUP,IF(h.ypheading4 = (TYPEOF(h.ypheading4))'',0,100));
    maxlength_ypheading4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading4)));
    avelength_ypheading4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading4)),h.ypheading4<>(typeof(h.ypheading4))'');
    populated_ypheading5_cnt := COUNT(GROUP,h.ypheading5 <> (TYPEOF(h.ypheading5))'');
    populated_ypheading5_pcnt := AVE(GROUP,IF(h.ypheading5 = (TYPEOF(h.ypheading5))'',0,100));
    maxlength_ypheading5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading5)));
    avelength_ypheading5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading5)),h.ypheading5<>(typeof(h.ypheading5))'');
    populated_ypheading6_cnt := COUNT(GROUP,h.ypheading6 <> (TYPEOF(h.ypheading6))'');
    populated_ypheading6_pcnt := AVE(GROUP,IF(h.ypheading6 = (TYPEOF(h.ypheading6))'',0,100));
    maxlength_ypheading6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading6)));
    avelength_ypheading6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ypheading6)),h.ypheading6<>(typeof(h.ypheading6))'');
    populated_maxypadsize_cnt := COUNT(GROUP,h.maxypadsize <> (TYPEOF(h.maxypadsize))'');
    populated_maxypadsize_pcnt := AVE(GROUP,IF(h.maxypadsize = (TYPEOF(h.maxypadsize))'',0,100));
    maxlength_maxypadsize := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.maxypadsize)));
    avelength_maxypadsize := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.maxypadsize)),h.maxypadsize<>(typeof(h.maxypadsize))'');
    populated_filler7_cnt := COUNT(GROUP,h.filler7 <> (TYPEOF(h.filler7))'');
    populated_filler7_pcnt := AVE(GROUP,IF(h.filler7 = (TYPEOF(h.filler7))'',0,100));
    maxlength_filler7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler7)));
    avelength_filler7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler7)),h.filler7<>(typeof(h.filler7))'');
    populated_faxac_cnt := COUNT(GROUP,h.faxac <> (TYPEOF(h.faxac))'');
    populated_faxac_pcnt := AVE(GROUP,IF(h.faxac = (TYPEOF(h.faxac))'',0,100));
    maxlength_faxac := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.faxac)));
    avelength_faxac := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.faxac)),h.faxac<>(typeof(h.faxac))'');
    populated_faxexchge_cnt := COUNT(GROUP,h.faxexchge <> (TYPEOF(h.faxexchge))'');
    populated_faxexchge_pcnt := AVE(GROUP,IF(h.faxexchge = (TYPEOF(h.faxexchge))'',0,100));
    maxlength_faxexchge := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.faxexchge)));
    avelength_faxexchge := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.faxexchge)),h.faxexchge<>(typeof(h.faxexchge))'');
    populated_faxphone_cnt := COUNT(GROUP,h.faxphone <> (TYPEOF(h.faxphone))'');
    populated_faxphone_pcnt := AVE(GROUP,IF(h.faxphone = (TYPEOF(h.faxphone))'',0,100));
    maxlength_faxphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.faxphone)));
    avelength_faxphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.faxphone)),h.faxphone<>(typeof(h.faxphone))'');
    populated_altac_cnt := COUNT(GROUP,h.altac <> (TYPEOF(h.altac))'');
    populated_altac_pcnt := AVE(GROUP,IF(h.altac = (TYPEOF(h.altac))'',0,100));
    maxlength_altac := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.altac)));
    avelength_altac := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.altac)),h.altac<>(typeof(h.altac))'');
    populated_altexchge_cnt := COUNT(GROUP,h.altexchge <> (TYPEOF(h.altexchge))'');
    populated_altexchge_pcnt := AVE(GROUP,IF(h.altexchge = (TYPEOF(h.altexchge))'',0,100));
    maxlength_altexchge := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.altexchge)));
    avelength_altexchge := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.altexchge)),h.altexchge<>(typeof(h.altexchge))'');
    populated_altphone_cnt := COUNT(GROUP,h.altphone <> (TYPEOF(h.altphone))'');
    populated_altphone_pcnt := AVE(GROUP,IF(h.altphone = (TYPEOF(h.altphone))'',0,100));
    maxlength_altphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.altphone)));
    avelength_altphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.altphone)),h.altphone<>(typeof(h.altphone))'');
    populated_mobileac_cnt := COUNT(GROUP,h.mobileac <> (TYPEOF(h.mobileac))'');
    populated_mobileac_pcnt := AVE(GROUP,IF(h.mobileac = (TYPEOF(h.mobileac))'',0,100));
    maxlength_mobileac := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mobileac)));
    avelength_mobileac := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mobileac)),h.mobileac<>(typeof(h.mobileac))'');
    populated_mobileexchge_cnt := COUNT(GROUP,h.mobileexchge <> (TYPEOF(h.mobileexchge))'');
    populated_mobileexchge_pcnt := AVE(GROUP,IF(h.mobileexchge = (TYPEOF(h.mobileexchge))'',0,100));
    maxlength_mobileexchge := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mobileexchge)));
    avelength_mobileexchge := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mobileexchge)),h.mobileexchge<>(typeof(h.mobileexchge))'');
    populated_mobilephone_cnt := COUNT(GROUP,h.mobilephone <> (TYPEOF(h.mobilephone))'');
    populated_mobilephone_pcnt := AVE(GROUP,IF(h.mobilephone = (TYPEOF(h.mobilephone))'',0,100));
    maxlength_mobilephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mobilephone)));
    avelength_mobilephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mobilephone)),h.mobilephone<>(typeof(h.mobilephone))'');
    populated_tollfreeac_cnt := COUNT(GROUP,h.tollfreeac <> (TYPEOF(h.tollfreeac))'');
    populated_tollfreeac_pcnt := AVE(GROUP,IF(h.tollfreeac = (TYPEOF(h.tollfreeac))'',0,100));
    maxlength_tollfreeac := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tollfreeac)));
    avelength_tollfreeac := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tollfreeac)),h.tollfreeac<>(typeof(h.tollfreeac))'');
    populated_tollfreeexchge_cnt := COUNT(GROUP,h.tollfreeexchge <> (TYPEOF(h.tollfreeexchge))'');
    populated_tollfreeexchge_pcnt := AVE(GROUP,IF(h.tollfreeexchge = (TYPEOF(h.tollfreeexchge))'',0,100));
    maxlength_tollfreeexchge := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tollfreeexchge)));
    avelength_tollfreeexchge := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tollfreeexchge)),h.tollfreeexchge<>(typeof(h.tollfreeexchge))'');
    populated_tollfreephone_cnt := COUNT(GROUP,h.tollfreephone <> (TYPEOF(h.tollfreephone))'');
    populated_tollfreephone_pcnt := AVE(GROUP,IF(h.tollfreephone = (TYPEOF(h.tollfreephone))'',0,100));
    maxlength_tollfreephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tollfreephone)));
    avelength_tollfreephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tollfreephone)),h.tollfreephone<>(typeof(h.tollfreephone))'');
    populated_creditcards_cnt := COUNT(GROUP,h.creditcards <> (TYPEOF(h.creditcards))'');
    populated_creditcards_pcnt := AVE(GROUP,IF(h.creditcards = (TYPEOF(h.creditcards))'',0,100));
    maxlength_creditcards := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.creditcards)));
    avelength_creditcards := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.creditcards)),h.creditcards<>(typeof(h.creditcards))'');
    populated_brands_cnt := COUNT(GROUP,h.brands <> (TYPEOF(h.brands))'');
    populated_brands_pcnt := AVE(GROUP,IF(h.brands = (TYPEOF(h.brands))'',0,100));
    maxlength_brands := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brands)));
    avelength_brands := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brands)),h.brands<>(typeof(h.brands))'');
    populated_stdhrs_cnt := COUNT(GROUP,h.stdhrs <> (TYPEOF(h.stdhrs))'');
    populated_stdhrs_pcnt := AVE(GROUP,IF(h.stdhrs = (TYPEOF(h.stdhrs))'',0,100));
    maxlength_stdhrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stdhrs)));
    avelength_stdhrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stdhrs)),h.stdhrs<>(typeof(h.stdhrs))'');
    populated_hrsopen_cnt := COUNT(GROUP,h.hrsopen <> (TYPEOF(h.hrsopen))'');
    populated_hrsopen_pcnt := AVE(GROUP,IF(h.hrsopen = (TYPEOF(h.hrsopen))'',0,100));
    maxlength_hrsopen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hrsopen)));
    avelength_hrsopen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hrsopen)),h.hrsopen<>(typeof(h.hrsopen))'');
    populated_web_address_cnt := COUNT(GROUP,h.web_address <> (TYPEOF(h.web_address))'');
    populated_web_address_pcnt := AVE(GROUP,IF(h.web_address = (TYPEOF(h.web_address))'',0,100));
    maxlength_web_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.web_address)));
    avelength_web_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.web_address)),h.web_address<>(typeof(h.web_address))'');
    populated_filler8_cnt := COUNT(GROUP,h.filler8 <> (TYPEOF(h.filler8))'');
    populated_filler8_pcnt := AVE(GROUP,IF(h.filler8 = (TYPEOF(h.filler8))'',0,100));
    maxlength_filler8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler8)));
    avelength_filler8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler8)),h.filler8<>(typeof(h.filler8))'');
    populated_email_address_cnt := COUNT(GROUP,h.email_address <> (TYPEOF(h.email_address))'');
    populated_email_address_pcnt := AVE(GROUP,IF(h.email_address = (TYPEOF(h.email_address))'',0,100));
    maxlength_email_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_address)));
    avelength_email_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_address)),h.email_address<>(typeof(h.email_address))'');
    populated_services_cnt := COUNT(GROUP,h.services <> (TYPEOF(h.services))'');
    populated_services_pcnt := AVE(GROUP,IF(h.services = (TYPEOF(h.services))'',0,100));
    maxlength_services := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.services)));
    avelength_services := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.services)),h.services<>(typeof(h.services))'');
    populated_condheading_cnt := COUNT(GROUP,h.condheading <> (TYPEOF(h.condheading))'');
    populated_condheading_pcnt := AVE(GROUP,IF(h.condheading = (TYPEOF(h.condheading))'',0,100));
    maxlength_condheading := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.condheading)));
    avelength_condheading := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.condheading)),h.condheading<>(typeof(h.condheading))'');
    populated_tagline_cnt := COUNT(GROUP,h.tagline <> (TYPEOF(h.tagline))'');
    populated_tagline_pcnt := AVE(GROUP,IF(h.tagline = (TYPEOF(h.tagline))'',0,100));
    maxlength_tagline := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tagline)));
    avelength_tagline := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tagline)),h.tagline<>(typeof(h.tagline))'');
    populated_filler9_cnt := COUNT(GROUP,h.filler9 <> (TYPEOF(h.filler9))'');
    populated_filler9_pcnt := AVE(GROUP,IF(h.filler9 = (TYPEOF(h.filler9))'',0,100));
    maxlength_filler9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler9)));
    avelength_filler9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler9)),h.filler9<>(typeof(h.filler9))'');
    populated_totaladspend_cnt := COUNT(GROUP,h.totaladspend <> (TYPEOF(h.totaladspend))'');
    populated_totaladspend_pcnt := AVE(GROUP,IF(h.totaladspend = (TYPEOF(h.totaladspend))'',0,100));
    maxlength_totaladspend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.totaladspend)));
    avelength_totaladspend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.totaladspend)),h.totaladspend<>(typeof(h.totaladspend))'');
    populated_filler10_cnt := COUNT(GROUP,h.filler10 <> (TYPEOF(h.filler10))'');
    populated_filler10_pcnt := AVE(GROUP,IF(h.filler10 = (TYPEOF(h.filler10))'',0,100));
    maxlength_filler10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler10)));
    avelength_filler10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler10)),h.filler10<>(typeof(h.filler10))'');
    populated_crlf_cnt := COUNT(GROUP,h.crlf <> (TYPEOF(h.crlf))'');
    populated_crlf_pcnt := AVE(GROUP,IF(h.crlf = (TYPEOF(h.crlf))'',0,100));
    maxlength_crlf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crlf)));
    avelength_crlf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crlf)),h.crlf<>(typeof(h.crlf))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_primary_key_pcnt *   0.00 / 100 + T.Populated_chainid_pcnt *   0.00 / 100 + T.Populated_filler1_pcnt *   0.00 / 100 + T.Populated_pub_date_pcnt *   0.00 / 100 + T.Populated_busshortname_pcnt *   0.00 / 100 + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_busdeptname_pcnt *   0.00 / 100 + T.Populated_house_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_streettype_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_apttype_pcnt *   0.00 / 100 + T.Populated_aptnbr_pcnt *   0.00 / 100 + T.Populated_boxnbr_pcnt *   0.00 / 100 + T.Populated_exppubcity_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_dpc_pcnt *   0.00 / 100 + T.Populated_carrierroute_pcnt *   0.00 / 100 + T.Populated_fips_pcnt *   0.00 / 100 + T.Populated_countycode_pcnt *   0.00 / 100 + T.Populated_z4type_pcnt *   0.00 / 100 + T.Populated_ctract_pcnt *   0.00 / 100 + T.Populated_cblockgroup_pcnt *   0.00 / 100 + T.Populated_cblockid_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_cbsa_pcnt *   0.00 / 100 + T.Populated_mcdcode_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_addrsensitivity_pcnt *   0.00 / 100 + T.Populated_maildeliverabilitycode_pcnt *   0.00 / 100 + T.Populated_sic1_4_pcnt *   0.00 / 100 + T.Populated_sic_code_pcnt *   0.00 / 100 + T.Populated_sic2_pcnt *   0.00 / 100 + T.Populated_sic3_pcnt *   0.00 / 100 + T.Populated_sic4_pcnt *   0.00 / 100 + T.Populated_indstryclass_pcnt *   0.00 / 100 + T.Populated_naics_code_pcnt *   0.00 / 100 + T.Populated_mlsc_pcnt *   0.00 / 100 + T.Populated_filler3_pcnt *   0.00 / 100 + T.Populated_orig_phone10_pcnt *   0.00 / 100 + T.Populated_nosolicitcode_pcnt *   0.00 / 100 + T.Populated_dso_pcnt *   0.00 / 100 + T.Populated_timezone_pcnt *   0.00 / 100 + T.Populated_validationflag_pcnt *   0.00 / 100 + T.Populated_validationdate_pcnt *   0.00 / 100 + T.Populated_secvalidationcode_pcnt *   0.00 / 100 + T.Populated_singleaddrflag_pcnt *   0.00 / 100 + T.Populated_filler4_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_execname_pcnt *   0.00 / 100 + T.Populated_exectitlecode_pcnt *   0.00 / 100 + T.Populated_exectitle_pcnt *   0.00 / 100 + T.Populated_condtitlecode_pcnt *   0.00 / 100 + T.Populated_condtitle_pcnt *   0.00 / 100 + T.Populated_contfunctioncode_pcnt *   0.00 / 100 + T.Populated_contfunction_pcnt *   0.00 / 100 + T.Populated_profession_pcnt *   0.00 / 100 + T.Populated_emplsizecode_pcnt *   0.00 / 100 + T.Populated_annualsalescode_pcnt *   0.00 / 100 + T.Populated_yrsinbus_pcnt *   0.00 / 100 + T.Populated_ethniccode_pcnt *   0.00 / 100 + T.Populated_filler5_pcnt *   0.00 / 100 + T.Populated_latlongmatchlevel_pcnt *   0.00 / 100 + T.Populated_orig_latitude_pcnt *   0.00 / 100 + T.Populated_orig_longitude_pcnt *   0.00 / 100 + T.Populated_filler6_pcnt *   0.00 / 100 + T.Populated_heading_string_pcnt *   0.00 / 100 + T.Populated_ypheading2_pcnt *   0.00 / 100 + T.Populated_ypheading3_pcnt *   0.00 / 100 + T.Populated_ypheading4_pcnt *   0.00 / 100 + T.Populated_ypheading5_pcnt *   0.00 / 100 + T.Populated_ypheading6_pcnt *   0.00 / 100 + T.Populated_maxypadsize_pcnt *   0.00 / 100 + T.Populated_filler7_pcnt *   0.00 / 100 + T.Populated_faxac_pcnt *   0.00 / 100 + T.Populated_faxexchge_pcnt *   0.00 / 100 + T.Populated_faxphone_pcnt *   0.00 / 100 + T.Populated_altac_pcnt *   0.00 / 100 + T.Populated_altexchge_pcnt *   0.00 / 100 + T.Populated_altphone_pcnt *   0.00 / 100 + T.Populated_mobileac_pcnt *   0.00 / 100 + T.Populated_mobileexchge_pcnt *   0.00 / 100 + T.Populated_mobilephone_pcnt *   0.00 / 100 + T.Populated_tollfreeac_pcnt *   0.00 / 100 + T.Populated_tollfreeexchge_pcnt *   0.00 / 100 + T.Populated_tollfreephone_pcnt *   0.00 / 100 + T.Populated_creditcards_pcnt *   0.00 / 100 + T.Populated_brands_pcnt *   0.00 / 100 + T.Populated_stdhrs_pcnt *   0.00 / 100 + T.Populated_hrsopen_pcnt *   0.00 / 100 + T.Populated_web_address_pcnt *   0.00 / 100 + T.Populated_filler8_pcnt *   0.00 / 100 + T.Populated_email_address_pcnt *   0.00 / 100 + T.Populated_services_pcnt *   0.00 / 100 + T.Populated_condheading_pcnt *   0.00 / 100 + T.Populated_tagline_pcnt *   0.00 / 100 + T.Populated_filler9_pcnt *   0.00 / 100 + T.Populated_totaladspend_pcnt *   0.00 / 100 + T.Populated_filler10_pcnt *   0.00 / 100 + T.Populated_crlf_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'primary_key','chainid','filler1','pub_date','busshortname','business_name','busdeptname','house','predir','street','streettype','postdir','apttype','aptnbr','boxnbr','exppubcity','orig_city','orig_state','orig_zip','dpc','carrierroute','fips','countycode','z4type','ctract','cblockgroup','cblockid','msa','cbsa','mcdcode','filler2','addrsensitivity','maildeliverabilitycode','sic1_4','sic_code','sic2','sic3','sic4','indstryclass','naics_code','mlsc','filler3','orig_phone10','nosolicitcode','dso','timezone','validationflag','validationdate','secvalidationcode','singleaddrflag','filler4','gender','execname','exectitlecode','exectitle','condtitlecode','condtitle','contfunctioncode','contfunction','profession','emplsizecode','annualsalescode','yrsinbus','ethniccode','filler5','latlongmatchlevel','orig_latitude','orig_longitude','filler6','heading_string','ypheading2','ypheading3','ypheading4','ypheading5','ypheading6','maxypadsize','filler7','faxac','faxexchge','faxphone','altac','altexchge','altphone','mobileac','mobileexchge','mobilephone','tollfreeac','tollfreeexchge','tollfreephone','creditcards','brands','stdhrs','hrsopen','web_address','filler8','email_address','services','condheading','tagline','filler9','totaladspend','filler10','crlf');
  SELF.populated_pcnt := CHOOSE(C,le.populated_primary_key_pcnt,le.populated_chainid_pcnt,le.populated_filler1_pcnt,le.populated_pub_date_pcnt,le.populated_busshortname_pcnt,le.populated_business_name_pcnt,le.populated_busdeptname_pcnt,le.populated_house_pcnt,le.populated_predir_pcnt,le.populated_street_pcnt,le.populated_streettype_pcnt,le.populated_postdir_pcnt,le.populated_apttype_pcnt,le.populated_aptnbr_pcnt,le.populated_boxnbr_pcnt,le.populated_exppubcity_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_dpc_pcnt,le.populated_carrierroute_pcnt,le.populated_fips_pcnt,le.populated_countycode_pcnt,le.populated_z4type_pcnt,le.populated_ctract_pcnt,le.populated_cblockgroup_pcnt,le.populated_cblockid_pcnt,le.populated_msa_pcnt,le.populated_cbsa_pcnt,le.populated_mcdcode_pcnt,le.populated_filler2_pcnt,le.populated_addrsensitivity_pcnt,le.populated_maildeliverabilitycode_pcnt,le.populated_sic1_4_pcnt,le.populated_sic_code_pcnt,le.populated_sic2_pcnt,le.populated_sic3_pcnt,le.populated_sic4_pcnt,le.populated_indstryclass_pcnt,le.populated_naics_code_pcnt,le.populated_mlsc_pcnt,le.populated_filler3_pcnt,le.populated_orig_phone10_pcnt,le.populated_nosolicitcode_pcnt,le.populated_dso_pcnt,le.populated_timezone_pcnt,le.populated_validationflag_pcnt,le.populated_validationdate_pcnt,le.populated_secvalidationcode_pcnt,le.populated_singleaddrflag_pcnt,le.populated_filler4_pcnt,le.populated_gender_pcnt,le.populated_execname_pcnt,le.populated_exectitlecode_pcnt,le.populated_exectitle_pcnt,le.populated_condtitlecode_pcnt,le.populated_condtitle_pcnt,le.populated_contfunctioncode_pcnt,le.populated_contfunction_pcnt,le.populated_profession_pcnt,le.populated_emplsizecode_pcnt,le.populated_annualsalescode_pcnt,le.populated_yrsinbus_pcnt,le.populated_ethniccode_pcnt,le.populated_filler5_pcnt,le.populated_latlongmatchlevel_pcnt,le.populated_orig_latitude_pcnt,le.populated_orig_longitude_pcnt,le.populated_filler6_pcnt,le.populated_heading_string_pcnt,le.populated_ypheading2_pcnt,le.populated_ypheading3_pcnt,le.populated_ypheading4_pcnt,le.populated_ypheading5_pcnt,le.populated_ypheading6_pcnt,le.populated_maxypadsize_pcnt,le.populated_filler7_pcnt,le.populated_faxac_pcnt,le.populated_faxexchge_pcnt,le.populated_faxphone_pcnt,le.populated_altac_pcnt,le.populated_altexchge_pcnt,le.populated_altphone_pcnt,le.populated_mobileac_pcnt,le.populated_mobileexchge_pcnt,le.populated_mobilephone_pcnt,le.populated_tollfreeac_pcnt,le.populated_tollfreeexchge_pcnt,le.populated_tollfreephone_pcnt,le.populated_creditcards_pcnt,le.populated_brands_pcnt,le.populated_stdhrs_pcnt,le.populated_hrsopen_pcnt,le.populated_web_address_pcnt,le.populated_filler8_pcnt,le.populated_email_address_pcnt,le.populated_services_pcnt,le.populated_condheading_pcnt,le.populated_tagline_pcnt,le.populated_filler9_pcnt,le.populated_totaladspend_pcnt,le.populated_filler10_pcnt,le.populated_crlf_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_primary_key,le.maxlength_chainid,le.maxlength_filler1,le.maxlength_pub_date,le.maxlength_busshortname,le.maxlength_business_name,le.maxlength_busdeptname,le.maxlength_house,le.maxlength_predir,le.maxlength_street,le.maxlength_streettype,le.maxlength_postdir,le.maxlength_apttype,le.maxlength_aptnbr,le.maxlength_boxnbr,le.maxlength_exppubcity,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_dpc,le.maxlength_carrierroute,le.maxlength_fips,le.maxlength_countycode,le.maxlength_z4type,le.maxlength_ctract,le.maxlength_cblockgroup,le.maxlength_cblockid,le.maxlength_msa,le.maxlength_cbsa,le.maxlength_mcdcode,le.maxlength_filler2,le.maxlength_addrsensitivity,le.maxlength_maildeliverabilitycode,le.maxlength_sic1_4,le.maxlength_sic_code,le.maxlength_sic2,le.maxlength_sic3,le.maxlength_sic4,le.maxlength_indstryclass,le.maxlength_naics_code,le.maxlength_mlsc,le.maxlength_filler3,le.maxlength_orig_phone10,le.maxlength_nosolicitcode,le.maxlength_dso,le.maxlength_timezone,le.maxlength_validationflag,le.maxlength_validationdate,le.maxlength_secvalidationcode,le.maxlength_singleaddrflag,le.maxlength_filler4,le.maxlength_gender,le.maxlength_execname,le.maxlength_exectitlecode,le.maxlength_exectitle,le.maxlength_condtitlecode,le.maxlength_condtitle,le.maxlength_contfunctioncode,le.maxlength_contfunction,le.maxlength_profession,le.maxlength_emplsizecode,le.maxlength_annualsalescode,le.maxlength_yrsinbus,le.maxlength_ethniccode,le.maxlength_filler5,le.maxlength_latlongmatchlevel,le.maxlength_orig_latitude,le.maxlength_orig_longitude,le.maxlength_filler6,le.maxlength_heading_string,le.maxlength_ypheading2,le.maxlength_ypheading3,le.maxlength_ypheading4,le.maxlength_ypheading5,le.maxlength_ypheading6,le.maxlength_maxypadsize,le.maxlength_filler7,le.maxlength_faxac,le.maxlength_faxexchge,le.maxlength_faxphone,le.maxlength_altac,le.maxlength_altexchge,le.maxlength_altphone,le.maxlength_mobileac,le.maxlength_mobileexchge,le.maxlength_mobilephone,le.maxlength_tollfreeac,le.maxlength_tollfreeexchge,le.maxlength_tollfreephone,le.maxlength_creditcards,le.maxlength_brands,le.maxlength_stdhrs,le.maxlength_hrsopen,le.maxlength_web_address,le.maxlength_filler8,le.maxlength_email_address,le.maxlength_services,le.maxlength_condheading,le.maxlength_tagline,le.maxlength_filler9,le.maxlength_totaladspend,le.maxlength_filler10,le.maxlength_crlf);
  SELF.avelength := CHOOSE(C,le.avelength_primary_key,le.avelength_chainid,le.avelength_filler1,le.avelength_pub_date,le.avelength_busshortname,le.avelength_business_name,le.avelength_busdeptname,le.avelength_house,le.avelength_predir,le.avelength_street,le.avelength_streettype,le.avelength_postdir,le.avelength_apttype,le.avelength_aptnbr,le.avelength_boxnbr,le.avelength_exppubcity,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_dpc,le.avelength_carrierroute,le.avelength_fips,le.avelength_countycode,le.avelength_z4type,le.avelength_ctract,le.avelength_cblockgroup,le.avelength_cblockid,le.avelength_msa,le.avelength_cbsa,le.avelength_mcdcode,le.avelength_filler2,le.avelength_addrsensitivity,le.avelength_maildeliverabilitycode,le.avelength_sic1_4,le.avelength_sic_code,le.avelength_sic2,le.avelength_sic3,le.avelength_sic4,le.avelength_indstryclass,le.avelength_naics_code,le.avelength_mlsc,le.avelength_filler3,le.avelength_orig_phone10,le.avelength_nosolicitcode,le.avelength_dso,le.avelength_timezone,le.avelength_validationflag,le.avelength_validationdate,le.avelength_secvalidationcode,le.avelength_singleaddrflag,le.avelength_filler4,le.avelength_gender,le.avelength_execname,le.avelength_exectitlecode,le.avelength_exectitle,le.avelength_condtitlecode,le.avelength_condtitle,le.avelength_contfunctioncode,le.avelength_contfunction,le.avelength_profession,le.avelength_emplsizecode,le.avelength_annualsalescode,le.avelength_yrsinbus,le.avelength_ethniccode,le.avelength_filler5,le.avelength_latlongmatchlevel,le.avelength_orig_latitude,le.avelength_orig_longitude,le.avelength_filler6,le.avelength_heading_string,le.avelength_ypheading2,le.avelength_ypheading3,le.avelength_ypheading4,le.avelength_ypheading5,le.avelength_ypheading6,le.avelength_maxypadsize,le.avelength_filler7,le.avelength_faxac,le.avelength_faxexchge,le.avelength_faxphone,le.avelength_altac,le.avelength_altexchge,le.avelength_altphone,le.avelength_mobileac,le.avelength_mobileexchge,le.avelength_mobilephone,le.avelength_tollfreeac,le.avelength_tollfreeexchge,le.avelength_tollfreephone,le.avelength_creditcards,le.avelength_brands,le.avelength_stdhrs,le.avelength_hrsopen,le.avelength_web_address,le.avelength_filler8,le.avelength_email_address,le.avelength_services,le.avelength_condheading,le.avelength_tagline,le.avelength_filler9,le.avelength_totaladspend,le.avelength_filler10,le.avelength_crlf);
END;
EXPORT invSummary := NORMALIZE(summary0, 103, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.primary_key),TRIM((SALT311.StrType)le.chainid),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.pub_date),TRIM((SALT311.StrType)le.busshortname),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.busdeptname),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.streettype),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.apttype),TRIM((SALT311.StrType)le.aptnbr),TRIM((SALT311.StrType)le.boxnbr),TRIM((SALT311.StrType)le.exppubcity),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.carrierroute),TRIM((SALT311.StrType)le.fips),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.z4type),TRIM((SALT311.StrType)le.ctract),TRIM((SALT311.StrType)le.cblockgroup),TRIM((SALT311.StrType)le.cblockid),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.mcdcode),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.addrsensitivity),TRIM((SALT311.StrType)le.maildeliverabilitycode),TRIM((SALT311.StrType)le.sic1_4),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.sic2),TRIM((SALT311.StrType)le.sic3),TRIM((SALT311.StrType)le.sic4),TRIM((SALT311.StrType)le.indstryclass),TRIM((SALT311.StrType)le.naics_code),TRIM((SALT311.StrType)le.mlsc),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.orig_phone10),TRIM((SALT311.StrType)le.nosolicitcode),TRIM((SALT311.StrType)le.dso),TRIM((SALT311.StrType)le.timezone),TRIM((SALT311.StrType)le.validationflag),TRIM((SALT311.StrType)le.validationdate),TRIM((SALT311.StrType)le.secvalidationcode),TRIM((SALT311.StrType)le.singleaddrflag),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.execname),TRIM((SALT311.StrType)le.exectitlecode),TRIM((SALT311.StrType)le.exectitle),TRIM((SALT311.StrType)le.condtitlecode),TRIM((SALT311.StrType)le.condtitle),TRIM((SALT311.StrType)le.contfunctioncode),TRIM((SALT311.StrType)le.contfunction),TRIM((SALT311.StrType)le.profession),TRIM((SALT311.StrType)le.emplsizecode),TRIM((SALT311.StrType)le.annualsalescode),TRIM((SALT311.StrType)le.yrsinbus),TRIM((SALT311.StrType)le.ethniccode),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.latlongmatchlevel),TRIM((SALT311.StrType)le.orig_latitude),TRIM((SALT311.StrType)le.orig_longitude),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.heading_string),TRIM((SALT311.StrType)le.ypheading2),TRIM((SALT311.StrType)le.ypheading3),TRIM((SALT311.StrType)le.ypheading4),TRIM((SALT311.StrType)le.ypheading5),TRIM((SALT311.StrType)le.ypheading6),TRIM((SALT311.StrType)le.maxypadsize),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.faxac),TRIM((SALT311.StrType)le.faxexchge),TRIM((SALT311.StrType)le.faxphone),TRIM((SALT311.StrType)le.altac),TRIM((SALT311.StrType)le.altexchge),TRIM((SALT311.StrType)le.altphone),TRIM((SALT311.StrType)le.mobileac),TRIM((SALT311.StrType)le.mobileexchge),TRIM((SALT311.StrType)le.mobilephone),TRIM((SALT311.StrType)le.tollfreeac),TRIM((SALT311.StrType)le.tollfreeexchge),TRIM((SALT311.StrType)le.tollfreephone),TRIM((SALT311.StrType)le.creditcards),TRIM((SALT311.StrType)le.brands),TRIM((SALT311.StrType)le.stdhrs),TRIM((SALT311.StrType)le.hrsopen),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.filler8),TRIM((SALT311.StrType)le.email_address),TRIM((SALT311.StrType)le.services),TRIM((SALT311.StrType)le.condheading),TRIM((SALT311.StrType)le.tagline),TRIM((SALT311.StrType)le.filler9),TRIM((SALT311.StrType)le.totaladspend),TRIM((SALT311.StrType)le.filler10),TRIM((SALT311.StrType)le.crlf)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,103,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 103);
  SELF.FldNo2 := 1 + (C % 103);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.primary_key),TRIM((SALT311.StrType)le.chainid),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.pub_date),TRIM((SALT311.StrType)le.busshortname),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.busdeptname),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.streettype),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.apttype),TRIM((SALT311.StrType)le.aptnbr),TRIM((SALT311.StrType)le.boxnbr),TRIM((SALT311.StrType)le.exppubcity),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.carrierroute),TRIM((SALT311.StrType)le.fips),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.z4type),TRIM((SALT311.StrType)le.ctract),TRIM((SALT311.StrType)le.cblockgroup),TRIM((SALT311.StrType)le.cblockid),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.mcdcode),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.addrsensitivity),TRIM((SALT311.StrType)le.maildeliverabilitycode),TRIM((SALT311.StrType)le.sic1_4),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.sic2),TRIM((SALT311.StrType)le.sic3),TRIM((SALT311.StrType)le.sic4),TRIM((SALT311.StrType)le.indstryclass),TRIM((SALT311.StrType)le.naics_code),TRIM((SALT311.StrType)le.mlsc),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.orig_phone10),TRIM((SALT311.StrType)le.nosolicitcode),TRIM((SALT311.StrType)le.dso),TRIM((SALT311.StrType)le.timezone),TRIM((SALT311.StrType)le.validationflag),TRIM((SALT311.StrType)le.validationdate),TRIM((SALT311.StrType)le.secvalidationcode),TRIM((SALT311.StrType)le.singleaddrflag),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.execname),TRIM((SALT311.StrType)le.exectitlecode),TRIM((SALT311.StrType)le.exectitle),TRIM((SALT311.StrType)le.condtitlecode),TRIM((SALT311.StrType)le.condtitle),TRIM((SALT311.StrType)le.contfunctioncode),TRIM((SALT311.StrType)le.contfunction),TRIM((SALT311.StrType)le.profession),TRIM((SALT311.StrType)le.emplsizecode),TRIM((SALT311.StrType)le.annualsalescode),TRIM((SALT311.StrType)le.yrsinbus),TRIM((SALT311.StrType)le.ethniccode),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.latlongmatchlevel),TRIM((SALT311.StrType)le.orig_latitude),TRIM((SALT311.StrType)le.orig_longitude),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.heading_string),TRIM((SALT311.StrType)le.ypheading2),TRIM((SALT311.StrType)le.ypheading3),TRIM((SALT311.StrType)le.ypheading4),TRIM((SALT311.StrType)le.ypheading5),TRIM((SALT311.StrType)le.ypheading6),TRIM((SALT311.StrType)le.maxypadsize),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.faxac),TRIM((SALT311.StrType)le.faxexchge),TRIM((SALT311.StrType)le.faxphone),TRIM((SALT311.StrType)le.altac),TRIM((SALT311.StrType)le.altexchge),TRIM((SALT311.StrType)le.altphone),TRIM((SALT311.StrType)le.mobileac),TRIM((SALT311.StrType)le.mobileexchge),TRIM((SALT311.StrType)le.mobilephone),TRIM((SALT311.StrType)le.tollfreeac),TRIM((SALT311.StrType)le.tollfreeexchge),TRIM((SALT311.StrType)le.tollfreephone),TRIM((SALT311.StrType)le.creditcards),TRIM((SALT311.StrType)le.brands),TRIM((SALT311.StrType)le.stdhrs),TRIM((SALT311.StrType)le.hrsopen),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.filler8),TRIM((SALT311.StrType)le.email_address),TRIM((SALT311.StrType)le.services),TRIM((SALT311.StrType)le.condheading),TRIM((SALT311.StrType)le.tagline),TRIM((SALT311.StrType)le.filler9),TRIM((SALT311.StrType)le.totaladspend),TRIM((SALT311.StrType)le.filler10),TRIM((SALT311.StrType)le.crlf)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.primary_key),TRIM((SALT311.StrType)le.chainid),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.pub_date),TRIM((SALT311.StrType)le.busshortname),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.busdeptname),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.streettype),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.apttype),TRIM((SALT311.StrType)le.aptnbr),TRIM((SALT311.StrType)le.boxnbr),TRIM((SALT311.StrType)le.exppubcity),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.carrierroute),TRIM((SALT311.StrType)le.fips),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.z4type),TRIM((SALT311.StrType)le.ctract),TRIM((SALT311.StrType)le.cblockgroup),TRIM((SALT311.StrType)le.cblockid),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.mcdcode),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.addrsensitivity),TRIM((SALT311.StrType)le.maildeliverabilitycode),TRIM((SALT311.StrType)le.sic1_4),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.sic2),TRIM((SALT311.StrType)le.sic3),TRIM((SALT311.StrType)le.sic4),TRIM((SALT311.StrType)le.indstryclass),TRIM((SALT311.StrType)le.naics_code),TRIM((SALT311.StrType)le.mlsc),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.orig_phone10),TRIM((SALT311.StrType)le.nosolicitcode),TRIM((SALT311.StrType)le.dso),TRIM((SALT311.StrType)le.timezone),TRIM((SALT311.StrType)le.validationflag),TRIM((SALT311.StrType)le.validationdate),TRIM((SALT311.StrType)le.secvalidationcode),TRIM((SALT311.StrType)le.singleaddrflag),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.execname),TRIM((SALT311.StrType)le.exectitlecode),TRIM((SALT311.StrType)le.exectitle),TRIM((SALT311.StrType)le.condtitlecode),TRIM((SALT311.StrType)le.condtitle),TRIM((SALT311.StrType)le.contfunctioncode),TRIM((SALT311.StrType)le.contfunction),TRIM((SALT311.StrType)le.profession),TRIM((SALT311.StrType)le.emplsizecode),TRIM((SALT311.StrType)le.annualsalescode),TRIM((SALT311.StrType)le.yrsinbus),TRIM((SALT311.StrType)le.ethniccode),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.latlongmatchlevel),TRIM((SALT311.StrType)le.orig_latitude),TRIM((SALT311.StrType)le.orig_longitude),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.heading_string),TRIM((SALT311.StrType)le.ypheading2),TRIM((SALT311.StrType)le.ypheading3),TRIM((SALT311.StrType)le.ypheading4),TRIM((SALT311.StrType)le.ypheading5),TRIM((SALT311.StrType)le.ypheading6),TRIM((SALT311.StrType)le.maxypadsize),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.faxac),TRIM((SALT311.StrType)le.faxexchge),TRIM((SALT311.StrType)le.faxphone),TRIM((SALT311.StrType)le.altac),TRIM((SALT311.StrType)le.altexchge),TRIM((SALT311.StrType)le.altphone),TRIM((SALT311.StrType)le.mobileac),TRIM((SALT311.StrType)le.mobileexchge),TRIM((SALT311.StrType)le.mobilephone),TRIM((SALT311.StrType)le.tollfreeac),TRIM((SALT311.StrType)le.tollfreeexchge),TRIM((SALT311.StrType)le.tollfreephone),TRIM((SALT311.StrType)le.creditcards),TRIM((SALT311.StrType)le.brands),TRIM((SALT311.StrType)le.stdhrs),TRIM((SALT311.StrType)le.hrsopen),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.filler8),TRIM((SALT311.StrType)le.email_address),TRIM((SALT311.StrType)le.services),TRIM((SALT311.StrType)le.condheading),TRIM((SALT311.StrType)le.tagline),TRIM((SALT311.StrType)le.filler9),TRIM((SALT311.StrType)le.totaladspend),TRIM((SALT311.StrType)le.filler10),TRIM((SALT311.StrType)le.crlf)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),103*103,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'primary_key'}
      ,{2,'chainid'}
      ,{3,'filler1'}
      ,{4,'pub_date'}
      ,{5,'busshortname'}
      ,{6,'business_name'}
      ,{7,'busdeptname'}
      ,{8,'house'}
      ,{9,'predir'}
      ,{10,'street'}
      ,{11,'streettype'}
      ,{12,'postdir'}
      ,{13,'apttype'}
      ,{14,'aptnbr'}
      ,{15,'boxnbr'}
      ,{16,'exppubcity'}
      ,{17,'orig_city'}
      ,{18,'orig_state'}
      ,{19,'orig_zip'}
      ,{20,'dpc'}
      ,{21,'carrierroute'}
      ,{22,'fips'}
      ,{23,'countycode'}
      ,{24,'z4type'}
      ,{25,'ctract'}
      ,{26,'cblockgroup'}
      ,{27,'cblockid'}
      ,{28,'msa'}
      ,{29,'cbsa'}
      ,{30,'mcdcode'}
      ,{31,'filler2'}
      ,{32,'addrsensitivity'}
      ,{33,'maildeliverabilitycode'}
      ,{34,'sic1_4'}
      ,{35,'sic_code'}
      ,{36,'sic2'}
      ,{37,'sic3'}
      ,{38,'sic4'}
      ,{39,'indstryclass'}
      ,{40,'naics_code'}
      ,{41,'mlsc'}
      ,{42,'filler3'}
      ,{43,'orig_phone10'}
      ,{44,'nosolicitcode'}
      ,{45,'dso'}
      ,{46,'timezone'}
      ,{47,'validationflag'}
      ,{48,'validationdate'}
      ,{49,'secvalidationcode'}
      ,{50,'singleaddrflag'}
      ,{51,'filler4'}
      ,{52,'gender'}
      ,{53,'execname'}
      ,{54,'exectitlecode'}
      ,{55,'exectitle'}
      ,{56,'condtitlecode'}
      ,{57,'condtitle'}
      ,{58,'contfunctioncode'}
      ,{59,'contfunction'}
      ,{60,'profession'}
      ,{61,'emplsizecode'}
      ,{62,'annualsalescode'}
      ,{63,'yrsinbus'}
      ,{64,'ethniccode'}
      ,{65,'filler5'}
      ,{66,'latlongmatchlevel'}
      ,{67,'orig_latitude'}
      ,{68,'orig_longitude'}
      ,{69,'filler6'}
      ,{70,'heading_string'}
      ,{71,'ypheading2'}
      ,{72,'ypheading3'}
      ,{73,'ypheading4'}
      ,{74,'ypheading5'}
      ,{75,'ypheading6'}
      ,{76,'maxypadsize'}
      ,{77,'filler7'}
      ,{78,'faxac'}
      ,{79,'faxexchge'}
      ,{80,'faxphone'}
      ,{81,'altac'}
      ,{82,'altexchge'}
      ,{83,'altphone'}
      ,{84,'mobileac'}
      ,{85,'mobileexchge'}
      ,{86,'mobilephone'}
      ,{87,'tollfreeac'}
      ,{88,'tollfreeexchge'}
      ,{89,'tollfreephone'}
      ,{90,'creditcards'}
      ,{91,'brands'}
      ,{92,'stdhrs'}
      ,{93,'hrsopen'}
      ,{94,'web_address'}
      ,{95,'filler8'}
      ,{96,'email_address'}
      ,{97,'services'}
      ,{98,'condheading'}
      ,{99,'tagline'}
      ,{100,'filler9'}
      ,{101,'totaladspend'}
      ,{102,'filler10'}
      ,{103,'crlf'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_primary_key((SALT311.StrType)le.primary_key),
    Input_Fields.InValid_chainid((SALT311.StrType)le.chainid),
    Input_Fields.InValid_filler1((SALT311.StrType)le.filler1),
    Input_Fields.InValid_pub_date((SALT311.StrType)le.pub_date),
    Input_Fields.InValid_busshortname((SALT311.StrType)le.busshortname),
    Input_Fields.InValid_business_name((SALT311.StrType)le.business_name),
    Input_Fields.InValid_busdeptname((SALT311.StrType)le.busdeptname),
    Input_Fields.InValid_house((SALT311.StrType)le.house),
    Input_Fields.InValid_predir((SALT311.StrType)le.predir),
    Input_Fields.InValid_street((SALT311.StrType)le.street),
    Input_Fields.InValid_streettype((SALT311.StrType)le.streettype),
    Input_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Input_Fields.InValid_apttype((SALT311.StrType)le.apttype),
    Input_Fields.InValid_aptnbr((SALT311.StrType)le.aptnbr),
    Input_Fields.InValid_boxnbr((SALT311.StrType)le.boxnbr),
    Input_Fields.InValid_exppubcity((SALT311.StrType)le.exppubcity),
    Input_Fields.InValid_orig_city((SALT311.StrType)le.orig_city,(SALT311.StrType)le.orig_state,(SALT311.StrType)le.orig_zip),
    Input_Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    Input_Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip),
    Input_Fields.InValid_dpc((SALT311.StrType)le.dpc),
    Input_Fields.InValid_carrierroute((SALT311.StrType)le.carrierroute),
    Input_Fields.InValid_fips((SALT311.StrType)le.fips),
    Input_Fields.InValid_countycode((SALT311.StrType)le.countycode),
    Input_Fields.InValid_z4type((SALT311.StrType)le.z4type),
    Input_Fields.InValid_ctract((SALT311.StrType)le.ctract),
    Input_Fields.InValid_cblockgroup((SALT311.StrType)le.cblockgroup),
    Input_Fields.InValid_cblockid((SALT311.StrType)le.cblockid),
    Input_Fields.InValid_msa((SALT311.StrType)le.msa),
    Input_Fields.InValid_cbsa((SALT311.StrType)le.cbsa),
    Input_Fields.InValid_mcdcode((SALT311.StrType)le.mcdcode),
    Input_Fields.InValid_filler2((SALT311.StrType)le.filler2),
    Input_Fields.InValid_addrsensitivity((SALT311.StrType)le.addrsensitivity),
    Input_Fields.InValid_maildeliverabilitycode((SALT311.StrType)le.maildeliverabilitycode),
    Input_Fields.InValid_sic1_4((SALT311.StrType)le.sic1_4),
    Input_Fields.InValid_sic_code((SALT311.StrType)le.sic_code),
    Input_Fields.InValid_sic2((SALT311.StrType)le.sic2),
    Input_Fields.InValid_sic3((SALT311.StrType)le.sic3),
    Input_Fields.InValid_sic4((SALT311.StrType)le.sic4),
    Input_Fields.InValid_indstryclass((SALT311.StrType)le.indstryclass),
    Input_Fields.InValid_naics_code((SALT311.StrType)le.naics_code),
    Input_Fields.InValid_mlsc((SALT311.StrType)le.mlsc),
    Input_Fields.InValid_filler3((SALT311.StrType)le.filler3),
    Input_Fields.InValid_orig_phone10((SALT311.StrType)le.orig_phone10),
    Input_Fields.InValid_nosolicitcode((SALT311.StrType)le.nosolicitcode),
    Input_Fields.InValid_dso((SALT311.StrType)le.dso),
    Input_Fields.InValid_timezone((SALT311.StrType)le.timezone),
    Input_Fields.InValid_validationflag((SALT311.StrType)le.validationflag),
    Input_Fields.InValid_validationdate((SALT311.StrType)le.validationdate),
    Input_Fields.InValid_secvalidationcode((SALT311.StrType)le.secvalidationcode),
    Input_Fields.InValid_singleaddrflag((SALT311.StrType)le.singleaddrflag),
    Input_Fields.InValid_filler4((SALT311.StrType)le.filler4),
    Input_Fields.InValid_gender((SALT311.StrType)le.gender),
    Input_Fields.InValid_execname((SALT311.StrType)le.execname),
    Input_Fields.InValid_exectitlecode((SALT311.StrType)le.exectitlecode),
    Input_Fields.InValid_exectitle((SALT311.StrType)le.exectitle),
    Input_Fields.InValid_condtitlecode((SALT311.StrType)le.condtitlecode),
    Input_Fields.InValid_condtitle((SALT311.StrType)le.condtitle),
    Input_Fields.InValid_contfunctioncode((SALT311.StrType)le.contfunctioncode),
    Input_Fields.InValid_contfunction((SALT311.StrType)le.contfunction),
    Input_Fields.InValid_profession((SALT311.StrType)le.profession),
    Input_Fields.InValid_emplsizecode((SALT311.StrType)le.emplsizecode),
    Input_Fields.InValid_annualsalescode((SALT311.StrType)le.annualsalescode),
    Input_Fields.InValid_yrsinbus((SALT311.StrType)le.yrsinbus),
    Input_Fields.InValid_ethniccode((SALT311.StrType)le.ethniccode),
    Input_Fields.InValid_filler5((SALT311.StrType)le.filler5),
    Input_Fields.InValid_latlongmatchlevel((SALT311.StrType)le.latlongmatchlevel),
    Input_Fields.InValid_orig_latitude((SALT311.StrType)le.orig_latitude),
    Input_Fields.InValid_orig_longitude((SALT311.StrType)le.orig_longitude),
    Input_Fields.InValid_filler6((SALT311.StrType)le.filler6),
    Input_Fields.InValid_heading_string((SALT311.StrType)le.heading_string),
    Input_Fields.InValid_ypheading2((SALT311.StrType)le.ypheading2),
    Input_Fields.InValid_ypheading3((SALT311.StrType)le.ypheading3),
    Input_Fields.InValid_ypheading4((SALT311.StrType)le.ypheading4),
    Input_Fields.InValid_ypheading5((SALT311.StrType)le.ypheading5),
    Input_Fields.InValid_ypheading6((SALT311.StrType)le.ypheading6),
    Input_Fields.InValid_maxypadsize((SALT311.StrType)le.maxypadsize),
    Input_Fields.InValid_filler7((SALT311.StrType)le.filler7),
    Input_Fields.InValid_faxac((SALT311.StrType)le.faxac),
    Input_Fields.InValid_faxexchge((SALT311.StrType)le.faxexchge),
    Input_Fields.InValid_faxphone((SALT311.StrType)le.faxphone),
    Input_Fields.InValid_altac((SALT311.StrType)le.altac),
    Input_Fields.InValid_altexchge((SALT311.StrType)le.altexchge),
    Input_Fields.InValid_altphone((SALT311.StrType)le.altphone),
    Input_Fields.InValid_mobileac((SALT311.StrType)le.mobileac),
    Input_Fields.InValid_mobileexchge((SALT311.StrType)le.mobileexchge),
    Input_Fields.InValid_mobilephone((SALT311.StrType)le.mobilephone),
    Input_Fields.InValid_tollfreeac((SALT311.StrType)le.tollfreeac),
    Input_Fields.InValid_tollfreeexchge((SALT311.StrType)le.tollfreeexchge),
    Input_Fields.InValid_tollfreephone((SALT311.StrType)le.tollfreephone),
    Input_Fields.InValid_creditcards((SALT311.StrType)le.creditcards),
    Input_Fields.InValid_brands((SALT311.StrType)le.brands),
    Input_Fields.InValid_stdhrs((SALT311.StrType)le.stdhrs),
    Input_Fields.InValid_hrsopen((SALT311.StrType)le.hrsopen),
    Input_Fields.InValid_web_address((SALT311.StrType)le.web_address),
    Input_Fields.InValid_filler8((SALT311.StrType)le.filler8),
    Input_Fields.InValid_email_address((SALT311.StrType)le.email_address),
    Input_Fields.InValid_services((SALT311.StrType)le.services),
    Input_Fields.InValid_condheading((SALT311.StrType)le.condheading),
    Input_Fields.InValid_tagline((SALT311.StrType)le.tagline),
    Input_Fields.InValid_filler9((SALT311.StrType)le.filler9),
    Input_Fields.InValid_totaladspend((SALT311.StrType)le.totaladspend),
    Input_Fields.InValid_filler10((SALT311.StrType)le.filler10),
    Input_Fields.InValid_crlf((SALT311.StrType)le.crlf),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,103,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','Unknown','Unknown','invalid_date','Unknown','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_orig_city','invalid_orig_state','invalid_orig_zip','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_sic_code','invalid_sic2','invalid_sic3','invalid_sic4','Unknown','invalid_naics_code','Unknown','Unknown','invalid_orig_phone10','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_primary_key(TotalErrors.ErrorNum),Input_Fields.InValidMessage_chainid(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_pub_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_busshortname(TotalErrors.ErrorNum),Input_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_busdeptname(TotalErrors.ErrorNum),Input_Fields.InValidMessage_house(TotalErrors.ErrorNum),Input_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Input_Fields.InValidMessage_street(TotalErrors.ErrorNum),Input_Fields.InValidMessage_streettype(TotalErrors.ErrorNum),Input_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Input_Fields.InValidMessage_apttype(TotalErrors.ErrorNum),Input_Fields.InValidMessage_aptnbr(TotalErrors.ErrorNum),Input_Fields.InValidMessage_boxnbr(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exppubcity(TotalErrors.ErrorNum),Input_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Input_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dpc(TotalErrors.ErrorNum),Input_Fields.InValidMessage_carrierroute(TotalErrors.ErrorNum),Input_Fields.InValidMessage_fips(TotalErrors.ErrorNum),Input_Fields.InValidMessage_countycode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_z4type(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ctract(TotalErrors.ErrorNum),Input_Fields.InValidMessage_cblockgroup(TotalErrors.ErrorNum),Input_Fields.InValidMessage_cblockid(TotalErrors.ErrorNum),Input_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Input_Fields.InValidMessage_cbsa(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mcdcode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_addrsensitivity(TotalErrors.ErrorNum),Input_Fields.InValidMessage_maildeliverabilitycode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic1_4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_indstryclass(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naics_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mlsc(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_orig_phone10(TotalErrors.ErrorNum),Input_Fields.InValidMessage_nosolicitcode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dso(TotalErrors.ErrorNum),Input_Fields.InValidMessage_timezone(TotalErrors.ErrorNum),Input_Fields.InValidMessage_validationflag(TotalErrors.ErrorNum),Input_Fields.InValidMessage_validationdate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_secvalidationcode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_singleaddrflag(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_gender(TotalErrors.ErrorNum),Input_Fields.InValidMessage_execname(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exectitlecode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exectitle(TotalErrors.ErrorNum),Input_Fields.InValidMessage_condtitlecode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_condtitle(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contfunctioncode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contfunction(TotalErrors.ErrorNum),Input_Fields.InValidMessage_profession(TotalErrors.ErrorNum),Input_Fields.InValidMessage_emplsizecode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_annualsalescode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_yrsinbus(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ethniccode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_latlongmatchlevel(TotalErrors.ErrorNum),Input_Fields.InValidMessage_orig_latitude(TotalErrors.ErrorNum),Input_Fields.InValidMessage_orig_longitude(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_heading_string(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ypheading2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ypheading3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ypheading4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ypheading5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ypheading6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_maxypadsize(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler7(TotalErrors.ErrorNum),Input_Fields.InValidMessage_faxac(TotalErrors.ErrorNum),Input_Fields.InValidMessage_faxexchge(TotalErrors.ErrorNum),Input_Fields.InValidMessage_faxphone(TotalErrors.ErrorNum),Input_Fields.InValidMessage_altac(TotalErrors.ErrorNum),Input_Fields.InValidMessage_altexchge(TotalErrors.ErrorNum),Input_Fields.InValidMessage_altphone(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mobileac(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mobileexchge(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mobilephone(TotalErrors.ErrorNum),Input_Fields.InValidMessage_tollfreeac(TotalErrors.ErrorNum),Input_Fields.InValidMessage_tollfreeexchge(TotalErrors.ErrorNum),Input_Fields.InValidMessage_tollfreephone(TotalErrors.ErrorNum),Input_Fields.InValidMessage_creditcards(TotalErrors.ErrorNum),Input_Fields.InValidMessage_brands(TotalErrors.ErrorNum),Input_Fields.InValidMessage_stdhrs(TotalErrors.ErrorNum),Input_Fields.InValidMessage_hrsopen(TotalErrors.ErrorNum),Input_Fields.InValidMessage_web_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler8(TotalErrors.ErrorNum),Input_Fields.InValidMessage_email_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_services(TotalErrors.ErrorNum),Input_Fields.InValidMessage_condheading(TotalErrors.ErrorNum),Input_Fields.InValidMessage_tagline(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler9(TotalErrors.ErrorNum),Input_Fields.InValidMessage_totaladspend(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filler10(TotalErrors.ErrorNum),Input_Fields.InValidMessage_crlf(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_YellowPages, Input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
