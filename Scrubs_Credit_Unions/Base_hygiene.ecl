IMPORT SALT38,STD;
EXPORT Base_hygiene(dataset(Base_layout_Credit_Unions) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_raw_aid_cnt := COUNT(GROUP,h.raw_aid <> (TYPEOF(h.raw_aid))'');
    populated_raw_aid_pcnt := AVE(GROUP,IF(h.raw_aid = (TYPEOF(h.raw_aid))'',0,100));
    maxlength_raw_aid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.raw_aid)));
    avelength_raw_aid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.raw_aid)),h.raw_aid<>(typeof(h.raw_aid))'');
    populated_ace_aid_cnt := COUNT(GROUP,h.ace_aid <> (TYPEOF(h.ace_aid))'');
    populated_ace_aid_pcnt := AVE(GROUP,IF(h.ace_aid = (TYPEOF(h.ace_aid))'',0,100));
    maxlength_ace_aid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_aid)));
    avelength_ace_aid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_aid)),h.ace_aid<>(typeof(h.ace_aid))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_charter_cnt := COUNT(GROUP,h.charter <> (TYPEOF(h.charter))'');
    populated_charter_pcnt := AVE(GROUP,IF(h.charter = (TYPEOF(h.charter))'',0,100));
    maxlength_charter := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.charter)));
    avelength_charter := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.charter)),h.charter<>(typeof(h.charter))'');
    populated_cycle_date_cnt := COUNT(GROUP,h.cycle_date <> (TYPEOF(h.cycle_date))'');
    populated_cycle_date_pcnt := AVE(GROUP,IF(h.cycle_date = (TYPEOF(h.cycle_date))'',0,100));
    maxlength_cycle_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cycle_date)));
    avelength_cycle_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cycle_date)),h.cycle_date<>(typeof(h.cycle_date))'');
    populated_join_number_cnt := COUNT(GROUP,h.join_number <> (TYPEOF(h.join_number))'');
    populated_join_number_pcnt := AVE(GROUP,IF(h.join_number = (TYPEOF(h.join_number))'',0,100));
    maxlength_join_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.join_number)));
    avelength_join_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.join_number)),h.join_number<>(typeof(h.join_number))'');
    populated_siteid_cnt := COUNT(GROUP,h.siteid <> (TYPEOF(h.siteid))'');
    populated_siteid_pcnt := AVE(GROUP,IF(h.siteid = (TYPEOF(h.siteid))'',0,100));
    maxlength_siteid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.siteid)));
    avelength_siteid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.siteid)),h.siteid<>(typeof(h.siteid))'');
    populated_cu_name_cnt := COUNT(GROUP,h.cu_name <> (TYPEOF(h.cu_name))'');
    populated_cu_name_pcnt := AVE(GROUP,IF(h.cu_name = (TYPEOF(h.cu_name))'',0,100));
    maxlength_cu_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cu_name)));
    avelength_cu_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cu_name)),h.cu_name<>(typeof(h.cu_name))'');
    populated_sitename_cnt := COUNT(GROUP,h.sitename <> (TYPEOF(h.sitename))'');
    populated_sitename_pcnt := AVE(GROUP,IF(h.sitename = (TYPEOF(h.sitename))'',0,100));
    maxlength_sitename := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sitename)));
    avelength_sitename := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sitename)),h.sitename<>(typeof(h.sitename))'');
    populated_sitetypename_cnt := COUNT(GROUP,h.sitetypename <> (TYPEOF(h.sitetypename))'');
    populated_sitetypename_pcnt := AVE(GROUP,IF(h.sitetypename = (TYPEOF(h.sitetypename))'',0,100));
    maxlength_sitetypename := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sitetypename)));
    avelength_sitetypename := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sitetypename)),h.sitetypename<>(typeof(h.sitetypename))'');
    populated_mainoffice_cnt := COUNT(GROUP,h.mainoffice <> (TYPEOF(h.mainoffice))'');
    populated_mainoffice_pcnt := AVE(GROUP,IF(h.mainoffice = (TYPEOF(h.mainoffice))'',0,100));
    maxlength_mainoffice := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mainoffice)));
    avelength_mainoffice := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mainoffice)),h.mainoffice<>(typeof(h.mainoffice))'');
    populated_addrtype_cnt := COUNT(GROUP,h.addrtype <> (TYPEOF(h.addrtype))'');
    populated_addrtype_pcnt := AVE(GROUP,IF(h.addrtype = (TYPEOF(h.addrtype))'',0,100));
    maxlength_addrtype := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addrtype)));
    avelength_addrtype := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addrtype)),h.addrtype<>(typeof(h.addrtype))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_statename_cnt := COUNT(GROUP,h.statename <> (TYPEOF(h.statename))'');
    populated_statename_pcnt := AVE(GROUP,IF(h.statename = (TYPEOF(h.statename))'',0,100));
    maxlength_statename := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.statename)));
    avelength_statename := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.statename)),h.statename<>(typeof(h.statename))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_countyname_cnt := COUNT(GROUP,h.countyname <> (TYPEOF(h.countyname))'');
    populated_countyname_pcnt := AVE(GROUP,IF(h.countyname = (TYPEOF(h.countyname))'',0,100));
    maxlength_countyname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.countyname)));
    avelength_countyname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.countyname)),h.countyname<>(typeof(h.countyname))'');
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_contact_name_cnt := COUNT(GROUP,h.contact_name <> (TYPEOF(h.contact_name))'');
    populated_contact_name_pcnt := AVE(GROUP,IF(h.contact_name = (TYPEOF(h.contact_name))'',0,100));
    maxlength_contact_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.contact_name)));
    avelength_contact_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.contact_name)),h.contact_name<>(typeof(h.contact_name))'');
    populated_assets_cnt := COUNT(GROUP,h.assets <> (TYPEOF(h.assets))'');
    populated_assets_pcnt := AVE(GROUP,IF(h.assets = (TYPEOF(h.assets))'',0,100));
    maxlength_assets := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.assets)));
    avelength_assets := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.assets)),h.assets<>(typeof(h.assets))'');
    populated_loans_cnt := COUNT(GROUP,h.loans <> (TYPEOF(h.loans))'');
    populated_loans_pcnt := AVE(GROUP,IF(h.loans = (TYPEOF(h.loans))'',0,100));
    maxlength_loans := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.loans)));
    avelength_loans := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.loans)),h.loans<>(typeof(h.loans))'');
    populated_networthratio_cnt := COUNT(GROUP,h.networthratio <> (TYPEOF(h.networthratio))'');
    populated_networthratio_pcnt := AVE(GROUP,IF(h.networthratio = (TYPEOF(h.networthratio))'',0,100));
    maxlength_networthratio := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.networthratio)));
    avelength_networthratio := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.networthratio)),h.networthratio<>(typeof(h.networthratio))'');
    populated_perc_sharegrowth_cnt := COUNT(GROUP,h.perc_sharegrowth <> (TYPEOF(h.perc_sharegrowth))'');
    populated_perc_sharegrowth_pcnt := AVE(GROUP,IF(h.perc_sharegrowth = (TYPEOF(h.perc_sharegrowth))'',0,100));
    maxlength_perc_sharegrowth := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.perc_sharegrowth)));
    avelength_perc_sharegrowth := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.perc_sharegrowth)),h.perc_sharegrowth<>(typeof(h.perc_sharegrowth))'');
    populated_perc_loangrowth_cnt := COUNT(GROUP,h.perc_loangrowth <> (TYPEOF(h.perc_loangrowth))'');
    populated_perc_loangrowth_pcnt := AVE(GROUP,IF(h.perc_loangrowth = (TYPEOF(h.perc_loangrowth))'',0,100));
    maxlength_perc_loangrowth := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.perc_loangrowth)));
    avelength_perc_loangrowth := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.perc_loangrowth)),h.perc_loangrowth<>(typeof(h.perc_loangrowth))'');
    populated_loantoassetsratio_cnt := COUNT(GROUP,h.loantoassetsratio <> (TYPEOF(h.loantoassetsratio))'');
    populated_loantoassetsratio_pcnt := AVE(GROUP,IF(h.loantoassetsratio = (TYPEOF(h.loantoassetsratio))'',0,100));
    maxlength_loantoassetsratio := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.loantoassetsratio)));
    avelength_loantoassetsratio := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.loantoassetsratio)),h.loantoassetsratio<>(typeof(h.loantoassetsratio))'');
    populated_investassetsratio_cnt := COUNT(GROUP,h.investassetsratio <> (TYPEOF(h.investassetsratio))'');
    populated_investassetsratio_pcnt := AVE(GROUP,IF(h.investassetsratio = (TYPEOF(h.investassetsratio))'',0,100));
    maxlength_investassetsratio := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.investassetsratio)));
    avelength_investassetsratio := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.investassetsratio)),h.investassetsratio<>(typeof(h.investassetsratio))'');
    populated_nummem_cnt := COUNT(GROUP,h.nummem <> (TYPEOF(h.nummem))'');
    populated_nummem_pcnt := AVE(GROUP,IF(h.nummem = (TYPEOF(h.nummem))'',0,100));
    maxlength_nummem := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.nummem)));
    avelength_nummem := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.nummem)),h.nummem<>(typeof(h.nummem))'');
    populated_numfull_cnt := COUNT(GROUP,h.numfull <> (TYPEOF(h.numfull))'');
    populated_numfull_pcnt := AVE(GROUP,IF(h.numfull = (TYPEOF(h.numfull))'',0,100));
    maxlength_numfull := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.numfull)));
    avelength_numfull := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.numfull)),h.numfull<>(typeof(h.numfull))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_state_cnt := COUNT(GROUP,h.fips_state <> (TYPEOF(h.fips_state))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_cnt := COUNT(GROUP,h.prep_addr_line_last <> (TYPEOF(h.prep_addr_line_last))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_charter_pcnt *   0.00 / 100 + T.Populated_cycle_date_pcnt *   0.00 / 100 + T.Populated_join_number_pcnt *   0.00 / 100 + T.Populated_siteid_pcnt *   0.00 / 100 + T.Populated_cu_name_pcnt *   0.00 / 100 + T.Populated_sitename_pcnt *   0.00 / 100 + T.Populated_sitetypename_pcnt *   0.00 / 100 + T.Populated_mainoffice_pcnt *   0.00 / 100 + T.Populated_addrtype_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_statename_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_countyname_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_contact_name_pcnt *   0.00 / 100 + T.Populated_assets_pcnt *   0.00 / 100 + T.Populated_loans_pcnt *   0.00 / 100 + T.Populated_networthratio_pcnt *   0.00 / 100 + T.Populated_perc_sharegrowth_pcnt *   0.00 / 100 + T.Populated_perc_loangrowth_pcnt *   0.00 / 100 + T.Populated_loantoassetsratio_pcnt *   0.00 / 100 + T.Populated_investassetsratio_pcnt *   0.00 / 100 + T.Populated_nummem_pcnt *   0.00 / 100 + T.Populated_numfull_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','source_rec_id','bdid','record_type','raw_aid','ace_aid','dt_vendor_first_reported','dt_vendor_last_reported','charter','cycle_date','join_number','siteid','cu_name','sitename','sitetypename','mainoffice','addrtype','address1','address2','city','state','statename','zip_code','countyname','country','phone','contact_name','assets','loans','networthratio','perc_sharegrowth','perc_loangrowth','loantoassetsratio','investassetsratio','nummem','numfull','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','prep_addr_line1','prep_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_source_rec_id_pcnt,le.populated_bdid_pcnt,le.populated_record_type_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_charter_pcnt,le.populated_cycle_date_pcnt,le.populated_join_number_pcnt,le.populated_siteid_pcnt,le.populated_cu_name_pcnt,le.populated_sitename_pcnt,le.populated_sitetypename_pcnt,le.populated_mainoffice_pcnt,le.populated_addrtype_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_statename_pcnt,le.populated_zip_code_pcnt,le.populated_countyname_pcnt,le.populated_country_pcnt,le.populated_phone_pcnt,le.populated_contact_name_pcnt,le.populated_assets_pcnt,le.populated_loans_pcnt,le.populated_networthratio_pcnt,le.populated_perc_sharegrowth_pcnt,le.populated_perc_loangrowth_pcnt,le.populated_loantoassetsratio_pcnt,le.populated_investassetsratio_pcnt,le.populated_nummem_pcnt,le.populated_numfull_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_source_rec_id,le.maxlength_bdid,le.maxlength_record_type,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_charter,le.maxlength_cycle_date,le.maxlength_join_number,le.maxlength_siteid,le.maxlength_cu_name,le.maxlength_sitename,le.maxlength_sitetypename,le.maxlength_mainoffice,le.maxlength_addrtype,le.maxlength_address1,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_statename,le.maxlength_zip_code,le.maxlength_countyname,le.maxlength_country,le.maxlength_phone,le.maxlength_contact_name,le.maxlength_assets,le.maxlength_loans,le.maxlength_networthratio,le.maxlength_perc_sharegrowth,le.maxlength_perc_loangrowth,le.maxlength_loantoassetsratio,le.maxlength_investassetsratio,le.maxlength_nummem,le.maxlength_numfull,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_source_rec_id,le.avelength_bdid,le.avelength_record_type,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_charter,le.avelength_cycle_date,le.avelength_join_number,le.avelength_siteid,le.avelength_cu_name,le.avelength_sitename,le.avelength_sitetypename,le.avelength_mainoffice,le.avelength_addrtype,le.avelength_address1,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_statename,le.avelength_zip_code,le.avelength_countyname,le.avelength_country,le.avelength_phone,le.avelength_contact_name,le.avelength_assets,le.avelength_loans,le.avelength_networthratio,le.avelength_perc_sharegrowth,le.avelength_perc_loangrowth,le.avelength_loantoassetsratio,le.avelength_investassetsratio,le.avelength_nummem,le.avelength_numfull,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 75, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),TRIM((SALT38.StrType)le.record_type),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.charter),TRIM((SALT38.StrType)le.cycle_date),TRIM((SALT38.StrType)le.join_number),TRIM((SALT38.StrType)le.siteid),TRIM((SALT38.StrType)le.cu_name),TRIM((SALT38.StrType)le.sitename),TRIM((SALT38.StrType)le.sitetypename),TRIM((SALT38.StrType)le.mainoffice),TRIM((SALT38.StrType)le.addrtype),TRIM((SALT38.StrType)le.address1),TRIM((SALT38.StrType)le.address2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.statename),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.countyname),TRIM((SALT38.StrType)le.country),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.contact_name),TRIM((SALT38.StrType)le.assets),TRIM((SALT38.StrType)le.loans),TRIM((SALT38.StrType)le.networthratio),TRIM((SALT38.StrType)le.perc_sharegrowth),TRIM((SALT38.StrType)le.perc_loangrowth),TRIM((SALT38.StrType)le.loantoassetsratio),TRIM((SALT38.StrType)le.investassetsratio),TRIM((SALT38.StrType)le.nummem),TRIM((SALT38.StrType)le.numfull),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,75,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 75);
  SELF.FldNo2 := 1 + (C % 75);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),TRIM((SALT38.StrType)le.record_type),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.charter),TRIM((SALT38.StrType)le.cycle_date),TRIM((SALT38.StrType)le.join_number),TRIM((SALT38.StrType)le.siteid),TRIM((SALT38.StrType)le.cu_name),TRIM((SALT38.StrType)le.sitename),TRIM((SALT38.StrType)le.sitetypename),TRIM((SALT38.StrType)le.mainoffice),TRIM((SALT38.StrType)le.addrtype),TRIM((SALT38.StrType)le.address1),TRIM((SALT38.StrType)le.address2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.statename),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.countyname),TRIM((SALT38.StrType)le.country),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.contact_name),TRIM((SALT38.StrType)le.assets),TRIM((SALT38.StrType)le.loans),TRIM((SALT38.StrType)le.networthratio),TRIM((SALT38.StrType)le.perc_sharegrowth),TRIM((SALT38.StrType)le.perc_loangrowth),TRIM((SALT38.StrType)le.loantoassetsratio),TRIM((SALT38.StrType)le.investassetsratio),TRIM((SALT38.StrType)le.nummem),TRIM((SALT38.StrType)le.numfull),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),TRIM((SALT38.StrType)le.record_type),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.charter),TRIM((SALT38.StrType)le.cycle_date),TRIM((SALT38.StrType)le.join_number),TRIM((SALT38.StrType)le.siteid),TRIM((SALT38.StrType)le.cu_name),TRIM((SALT38.StrType)le.sitename),TRIM((SALT38.StrType)le.sitetypename),TRIM((SALT38.StrType)le.mainoffice),TRIM((SALT38.StrType)le.addrtype),TRIM((SALT38.StrType)le.address1),TRIM((SALT38.StrType)le.address2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.statename),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.countyname),TRIM((SALT38.StrType)le.country),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.contact_name),TRIM((SALT38.StrType)le.assets),TRIM((SALT38.StrType)le.loans),TRIM((SALT38.StrType)le.networthratio),TRIM((SALT38.StrType)le.perc_sharegrowth),TRIM((SALT38.StrType)le.perc_loangrowth),TRIM((SALT38.StrType)le.loantoassetsratio),TRIM((SALT38.StrType)le.investassetsratio),TRIM((SALT38.StrType)le.nummem),TRIM((SALT38.StrType)le.numfull),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),75*75,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'powid'}
      ,{2,'proxid'}
      ,{3,'seleid'}
      ,{4,'orgid'}
      ,{5,'ultid'}
      ,{6,'source_rec_id'}
      ,{7,'bdid'}
      ,{8,'record_type'}
      ,{9,'raw_aid'}
      ,{10,'ace_aid'}
      ,{11,'dt_vendor_first_reported'}
      ,{12,'dt_vendor_last_reported'}
      ,{13,'charter'}
      ,{14,'cycle_date'}
      ,{15,'join_number'}
      ,{16,'siteid'}
      ,{17,'cu_name'}
      ,{18,'sitename'}
      ,{19,'sitetypename'}
      ,{20,'mainoffice'}
      ,{21,'addrtype'}
      ,{22,'address1'}
      ,{23,'address2'}
      ,{24,'city'}
      ,{25,'state'}
      ,{26,'statename'}
      ,{27,'zip_code'}
      ,{28,'countyname'}
      ,{29,'country'}
      ,{30,'phone'}
      ,{31,'contact_name'}
      ,{32,'assets'}
      ,{33,'loans'}
      ,{34,'networthratio'}
      ,{35,'perc_sharegrowth'}
      ,{36,'perc_loangrowth'}
      ,{37,'loantoassetsratio'}
      ,{38,'investassetsratio'}
      ,{39,'nummem'}
      ,{40,'numfull'}
      ,{41,'title'}
      ,{42,'fname'}
      ,{43,'mname'}
      ,{44,'lname'}
      ,{45,'name_suffix'}
      ,{46,'name_score'}
      ,{47,'prim_range'}
      ,{48,'predir'}
      ,{49,'prim_name'}
      ,{50,'addr_suffix'}
      ,{51,'postdir'}
      ,{52,'unit_desig'}
      ,{53,'sec_range'}
      ,{54,'p_city_name'}
      ,{55,'v_city_name'}
      ,{56,'st'}
      ,{57,'zip'}
      ,{58,'zip4'}
      ,{59,'cart'}
      ,{60,'cr_sort_sz'}
      ,{61,'lot'}
      ,{62,'lot_order'}
      ,{63,'dbpc'}
      ,{64,'chk_digit'}
      ,{65,'rec_type'}
      ,{66,'fips_state'}
      ,{67,'fips_county'}
      ,{68,'geo_lat'}
      ,{69,'geo_long'}
      ,{70,'msa'}
      ,{71,'geo_blk'}
      ,{72,'geo_match'}
      ,{73,'err_stat'}
      ,{74,'prep_addr_line1'}
      ,{75,'prep_addr_line_last'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_powid((SALT38.StrType)le.powid),
    Base_Fields.InValid_proxid((SALT38.StrType)le.proxid),
    Base_Fields.InValid_seleid((SALT38.StrType)le.seleid),
    Base_Fields.InValid_orgid((SALT38.StrType)le.orgid),
    Base_Fields.InValid_ultid((SALT38.StrType)le.ultid),
    Base_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id),
    Base_Fields.InValid_bdid((SALT38.StrType)le.bdid),
    Base_Fields.InValid_record_type((SALT38.StrType)le.record_type),
    Base_Fields.InValid_raw_aid((SALT38.StrType)le.raw_aid),
    Base_Fields.InValid_ace_aid((SALT38.StrType)le.ace_aid),
    Base_Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_charter((SALT38.StrType)le.charter),
    Base_Fields.InValid_cycle_date((SALT38.StrType)le.cycle_date),
    Base_Fields.InValid_join_number((SALT38.StrType)le.join_number),
    Base_Fields.InValid_siteid((SALT38.StrType)le.siteid),
    Base_Fields.InValid_cu_name((SALT38.StrType)le.cu_name),
    Base_Fields.InValid_sitename((SALT38.StrType)le.sitename),
    Base_Fields.InValid_sitetypename((SALT38.StrType)le.sitetypename),
    Base_Fields.InValid_mainoffice((SALT38.StrType)le.mainoffice),
    Base_Fields.InValid_addrtype((SALT38.StrType)le.addrtype),
    Base_Fields.InValid_address1((SALT38.StrType)le.address1),
    Base_Fields.InValid_address2((SALT38.StrType)le.address2),
    Base_Fields.InValid_city((SALT38.StrType)le.city),
    Base_Fields.InValid_state((SALT38.StrType)le.state),
    Base_Fields.InValid_statename((SALT38.StrType)le.statename),
    Base_Fields.InValid_zip_code((SALT38.StrType)le.zip_code),
    Base_Fields.InValid_countyname((SALT38.StrType)le.countyname),
    Base_Fields.InValid_country((SALT38.StrType)le.country),
    Base_Fields.InValid_phone((SALT38.StrType)le.phone),
    Base_Fields.InValid_contact_name((SALT38.StrType)le.contact_name),
    Base_Fields.InValid_assets((SALT38.StrType)le.assets),
    Base_Fields.InValid_loans((SALT38.StrType)le.loans),
    Base_Fields.InValid_networthratio((SALT38.StrType)le.networthratio),
    Base_Fields.InValid_perc_sharegrowth((SALT38.StrType)le.perc_sharegrowth),
    Base_Fields.InValid_perc_loangrowth((SALT38.StrType)le.perc_loangrowth),
    Base_Fields.InValid_loantoassetsratio((SALT38.StrType)le.loantoassetsratio),
    Base_Fields.InValid_investassetsratio((SALT38.StrType)le.investassetsratio),
    Base_Fields.InValid_nummem((SALT38.StrType)le.nummem),
    Base_Fields.InValid_numfull((SALT38.StrType)le.numfull),
    Base_Fields.InValid_title((SALT38.StrType)le.title),
    Base_Fields.InValid_fname((SALT38.StrType)le.fname),
    Base_Fields.InValid_mname((SALT38.StrType)le.mname),
    Base_Fields.InValid_lname((SALT38.StrType)le.lname),
    Base_Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    Base_Fields.InValid_name_score((SALT38.StrType)le.name_score),
    Base_Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Base_Fields.InValid_predir((SALT38.StrType)le.predir),
    Base_Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Base_Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix),
    Base_Fields.InValid_postdir((SALT38.StrType)le.postdir),
    Base_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    Base_Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Base_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Base_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name),
    Base_Fields.InValid_st((SALT38.StrType)le.st),
    Base_Fields.InValid_zip((SALT38.StrType)le.zip),
    Base_Fields.InValid_zip4((SALT38.StrType)le.zip4),
    Base_Fields.InValid_cart((SALT38.StrType)le.cart),
    Base_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz),
    Base_Fields.InValid_lot((SALT38.StrType)le.lot),
    Base_Fields.InValid_lot_order((SALT38.StrType)le.lot_order),
    Base_Fields.InValid_dbpc((SALT38.StrType)le.dbpc),
    Base_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit),
    Base_Fields.InValid_rec_type((SALT38.StrType)le.rec_type),
    Base_Fields.InValid_fips_state((SALT38.StrType)le.fips_state),
    Base_Fields.InValid_fips_county((SALT38.StrType)le.fips_county),
    Base_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat),
    Base_Fields.InValid_geo_long((SALT38.StrType)le.geo_long),
    Base_Fields.InValid_msa((SALT38.StrType)le.msa),
    Base_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    Base_Fields.InValid_geo_match((SALT38.StrType)le.geo_match),
    Base_Fields.InValid_err_stat((SALT38.StrType)le.err_stat),
    Base_Fields.InValid_prep_addr_line1((SALT38.StrType)le.prep_addr_line1),
    Base_Fields.InValid_prep_addr_line_last((SALT38.StrType)le.prep_addr_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,75,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_source_rec_id','invalid_bdid','invalid_record_type','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_past_date','invalid_past_date','invalid_charter','invalid_cycle_date','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_mandatory','Unknown','invalid_sitetypename','invalid_mainoffice','invalid_address_type_code','Unknown','Unknown','Unknown','invalid_st_code','invalid_st_name','invalid_zip_code','Unknown','invalid_country','invalid_numeric_or_blank','Unknown','invalid_financial_num','invalid_financial_num','invalid_financial_num','invalid_financial_num','invalid_financial_num','invalid_financial_num','invalid_financial_num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_charter(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cycle_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_join_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_siteid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cu_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sitename(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sitetypename(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mainoffice(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addrtype(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_statename(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_countyname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_country(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_contact_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_assets(TotalErrors.ErrorNum),Base_Fields.InValidMessage_loans(TotalErrors.ErrorNum),Base_Fields.InValidMessage_networthratio(TotalErrors.ErrorNum),Base_Fields.InValidMessage_perc_sharegrowth(TotalErrors.ErrorNum),Base_Fields.InValidMessage_perc_loangrowth(TotalErrors.ErrorNum),Base_Fields.InValidMessage_loantoassetsratio(TotalErrors.ErrorNum),Base_Fields.InValidMessage_investassetsratio(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nummem(TotalErrors.ErrorNum),Base_Fields.InValidMessage_numfull(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Credit_Unions, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
