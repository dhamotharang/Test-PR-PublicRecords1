IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Dunndata_Consumer) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dtmatch_cnt := COUNT(GROUP,h.dtmatch <> (TYPEOF(h.dtmatch))'');
    populated_dtmatch_pcnt := AVE(GROUP,IF(h.dtmatch = (TYPEOF(h.dtmatch))'',0,100));
    maxlength_dtmatch := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dtmatch)));
    avelength_dtmatch := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dtmatch)),h.dtmatch<>(typeof(h.dtmatch))'');
    populated_msname_cnt := COUNT(GROUP,h.msname <> (TYPEOF(h.msname))'');
    populated_msname_pcnt := AVE(GROUP,IF(h.msname = (TYPEOF(h.msname))'',0,100));
    maxlength_msname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msname)));
    avelength_msname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msname)),h.msname<>(typeof(h.msname))'');
    populated_msaddr1_cnt := COUNT(GROUP,h.msaddr1 <> (TYPEOF(h.msaddr1))'');
    populated_msaddr1_pcnt := AVE(GROUP,IF(h.msaddr1 = (TYPEOF(h.msaddr1))'',0,100));
    maxlength_msaddr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msaddr1)));
    avelength_msaddr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msaddr1)),h.msaddr1<>(typeof(h.msaddr1))'');
    populated_msaddr2_cnt := COUNT(GROUP,h.msaddr2 <> (TYPEOF(h.msaddr2))'');
    populated_msaddr2_pcnt := AVE(GROUP,IF(h.msaddr2 = (TYPEOF(h.msaddr2))'',0,100));
    maxlength_msaddr2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msaddr2)));
    avelength_msaddr2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msaddr2)),h.msaddr2<>(typeof(h.msaddr2))'');
    populated_mscity_cnt := COUNT(GROUP,h.mscity <> (TYPEOF(h.mscity))'');
    populated_mscity_pcnt := AVE(GROUP,IF(h.mscity = (TYPEOF(h.mscity))'',0,100));
    maxlength_mscity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mscity)));
    avelength_mscity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mscity)),h.mscity<>(typeof(h.mscity))'');
    populated_msstate_cnt := COUNT(GROUP,h.msstate <> (TYPEOF(h.msstate))'');
    populated_msstate_pcnt := AVE(GROUP,IF(h.msstate = (TYPEOF(h.msstate))'',0,100));
    maxlength_msstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msstate)));
    avelength_msstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msstate)),h.msstate<>(typeof(h.msstate))'');
    populated_mszip5_cnt := COUNT(GROUP,h.mszip5 <> (TYPEOF(h.mszip5))'');
    populated_mszip5_pcnt := AVE(GROUP,IF(h.mszip5 = (TYPEOF(h.mszip5))'',0,100));
    maxlength_mszip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mszip5)));
    avelength_mszip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mszip5)),h.mszip5<>(typeof(h.mszip5))'');
    populated_mszip4_cnt := COUNT(GROUP,h.mszip4 <> (TYPEOF(h.mszip4))'');
    populated_mszip4_pcnt := AVE(GROUP,IF(h.mszip4 = (TYPEOF(h.mszip4))'',0,100));
    maxlength_mszip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mszip4)));
    avelength_mszip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mszip4)),h.mszip4<>(typeof(h.mszip4))'');
    populated_dthh_cnt := COUNT(GROUP,h.dthh <> (TYPEOF(h.dthh))'');
    populated_dthh_pcnt := AVE(GROUP,IF(h.dthh = (TYPEOF(h.dthh))'',0,100));
    maxlength_dthh := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dthh)));
    avelength_dthh := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dthh)),h.dthh<>(typeof(h.dthh))'');
    populated_mscrrt_cnt := COUNT(GROUP,h.mscrrt <> (TYPEOF(h.mscrrt))'');
    populated_mscrrt_pcnt := AVE(GROUP,IF(h.mscrrt = (TYPEOF(h.mscrrt))'',0,100));
    maxlength_mscrrt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mscrrt)));
    avelength_mscrrt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mscrrt)),h.mscrrt<>(typeof(h.mscrrt))'');
    populated_msdpbc_cnt := COUNT(GROUP,h.msdpbc <> (TYPEOF(h.msdpbc))'');
    populated_msdpbc_pcnt := AVE(GROUP,IF(h.msdpbc = (TYPEOF(h.msdpbc))'',0,100));
    maxlength_msdpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msdpbc)));
    avelength_msdpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msdpbc)),h.msdpbc<>(typeof(h.msdpbc))'');
    populated_msdpv_cnt := COUNT(GROUP,h.msdpv <> (TYPEOF(h.msdpv))'');
    populated_msdpv_pcnt := AVE(GROUP,IF(h.msdpv = (TYPEOF(h.msdpv))'',0,100));
    maxlength_msdpv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msdpv)));
    avelength_msdpv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msdpv)),h.msdpv<>(typeof(h.msdpv))'');
    populated_ms_addrtype_cnt := COUNT(GROUP,h.ms_addrtype <> (TYPEOF(h.ms_addrtype))'');
    populated_ms_addrtype_pcnt := AVE(GROUP,IF(h.ms_addrtype = (TYPEOF(h.ms_addrtype))'',0,100));
    maxlength_ms_addrtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_addrtype)));
    avelength_ms_addrtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_addrtype)),h.ms_addrtype<>(typeof(h.ms_addrtype))'');
    populated_ctysize_cnt := COUNT(GROUP,h.ctysize <> (TYPEOF(h.ctysize))'');
    populated_ctysize_pcnt := AVE(GROUP,IF(h.ctysize = (TYPEOF(h.ctysize))'',0,100));
    maxlength_ctysize := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ctysize)));
    avelength_ctysize := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ctysize)),h.ctysize<>(typeof(h.ctysize))'');
    populated_lmos_cnt := COUNT(GROUP,h.lmos <> (TYPEOF(h.lmos))'');
    populated_lmos_pcnt := AVE(GROUP,IF(h.lmos = (TYPEOF(h.lmos))'',0,100));
    maxlength_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lmos)));
    avelength_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lmos)),h.lmos<>(typeof(h.lmos))'');
    populated_omos_cnt := COUNT(GROUP,h.omos <> (TYPEOF(h.omos))'');
    populated_omos_pcnt := AVE(GROUP,IF(h.omos = (TYPEOF(h.omos))'',0,100));
    maxlength_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.omos)));
    avelength_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.omos)),h.omos<>(typeof(h.omos))'');
    populated_pmos_cnt := COUNT(GROUP,h.pmos <> (TYPEOF(h.pmos))'');
    populated_pmos_pcnt := AVE(GROUP,IF(h.pmos = (TYPEOF(h.pmos))'',0,100));
    maxlength_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pmos)));
    avelength_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pmos)),h.pmos<>(typeof(h.pmos))'');
    populated_gen_cnt := COUNT(GROUP,h.gen <> (TYPEOF(h.gen))'');
    populated_gen_pcnt := AVE(GROUP,IF(h.gen = (TYPEOF(h.gen))'',0,100));
    maxlength_gen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gen)));
    avelength_gen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gen)),h.gen<>(typeof(h.gen))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_age_cnt := COUNT(GROUP,h.age <> (TYPEOF(h.age))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_inc_cnt := COUNT(GROUP,h.inc <> (TYPEOF(h.inc))'');
    populated_inc_pcnt := AVE(GROUP,IF(h.inc = (TYPEOF(h.inc))'',0,100));
    maxlength_inc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.inc)));
    avelength_inc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.inc)),h.inc<>(typeof(h.inc))'');
    populated_marital_status_cnt := COUNT(GROUP,h.marital_status <> (TYPEOF(h.marital_status))'');
    populated_marital_status_pcnt := AVE(GROUP,IF(h.marital_status = (TYPEOF(h.marital_status))'',0,100));
    maxlength_marital_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marital_status)));
    avelength_marital_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marital_status)),h.marital_status<>(typeof(h.marital_status))'');
    populated_poc_cnt := COUNT(GROUP,h.poc <> (TYPEOF(h.poc))'');
    populated_poc_pcnt := AVE(GROUP,IF(h.poc = (TYPEOF(h.poc))'',0,100));
    maxlength_poc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.poc)));
    avelength_poc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.poc)),h.poc<>(typeof(h.poc))'');
    populated_noc_cnt := COUNT(GROUP,h.noc <> (TYPEOF(h.noc))'');
    populated_noc_pcnt := AVE(GROUP,IF(h.noc = (TYPEOF(h.noc))'',0,100));
    maxlength_noc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.noc)));
    avelength_noc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.noc)),h.noc<>(typeof(h.noc))'');
    populated_ocp_cnt := COUNT(GROUP,h.ocp <> (TYPEOF(h.ocp))'');
    populated_ocp_pcnt := AVE(GROUP,IF(h.ocp = (TYPEOF(h.ocp))'',0,100));
    maxlength_ocp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocp)));
    avelength_ocp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocp)),h.ocp<>(typeof(h.ocp))'');
    populated_edu_cnt := COUNT(GROUP,h.edu <> (TYPEOF(h.edu))'');
    populated_edu_pcnt := AVE(GROUP,IF(h.edu = (TYPEOF(h.edu))'',0,100));
    maxlength_edu := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.edu)));
    avelength_edu := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.edu)),h.edu<>(typeof(h.edu))'');
    populated_lang_cnt := COUNT(GROUP,h.lang <> (TYPEOF(h.lang))'');
    populated_lang_pcnt := AVE(GROUP,IF(h.lang = (TYPEOF(h.lang))'',0,100));
    maxlength_lang := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lang)));
    avelength_lang := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lang)),h.lang<>(typeof(h.lang))'');
    populated_relig_cnt := COUNT(GROUP,h.relig <> (TYPEOF(h.relig))'');
    populated_relig_pcnt := AVE(GROUP,IF(h.relig = (TYPEOF(h.relig))'',0,100));
    maxlength_relig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relig)));
    avelength_relig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relig)),h.relig<>(typeof(h.relig))'');
    populated_dwell_cnt := COUNT(GROUP,h.dwell <> (TYPEOF(h.dwell))'');
    populated_dwell_pcnt := AVE(GROUP,IF(h.dwell = (TYPEOF(h.dwell))'',0,100));
    maxlength_dwell := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dwell)));
    avelength_dwell := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dwell)),h.dwell<>(typeof(h.dwell))'');
    populated_ownr_cnt := COUNT(GROUP,h.ownr <> (TYPEOF(h.ownr))'');
    populated_ownr_pcnt := AVE(GROUP,IF(h.ownr = (TYPEOF(h.ownr))'',0,100));
    maxlength_ownr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownr)));
    avelength_ownr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownr)),h.ownr<>(typeof(h.ownr))'');
    populated_eth1_cnt := COUNT(GROUP,h.eth1 <> (TYPEOF(h.eth1))'');
    populated_eth1_pcnt := AVE(GROUP,IF(h.eth1 = (TYPEOF(h.eth1))'',0,100));
    maxlength_eth1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eth1)));
    avelength_eth1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eth1)),h.eth1<>(typeof(h.eth1))'');
    populated_eth2_cnt := COUNT(GROUP,h.eth2 <> (TYPEOF(h.eth2))'');
    populated_eth2_pcnt := AVE(GROUP,IF(h.eth2 = (TYPEOF(h.eth2))'',0,100));
    maxlength_eth2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eth2)));
    avelength_eth2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eth2)),h.eth2<>(typeof(h.eth2))'');
    populated_lor_cnt := COUNT(GROUP,h.lor <> (TYPEOF(h.lor))'');
    populated_lor_pcnt := AVE(GROUP,IF(h.lor = (TYPEOF(h.lor))'',0,100));
    maxlength_lor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lor)));
    avelength_lor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lor)),h.lor<>(typeof(h.lor))'');
    populated_pool_cnt := COUNT(GROUP,h.pool <> (TYPEOF(h.pool))'');
    populated_pool_pcnt := AVE(GROUP,IF(h.pool = (TYPEOF(h.pool))'',0,100));
    maxlength_pool := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pool)));
    avelength_pool := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pool)),h.pool<>(typeof(h.pool))'');
    populated_speak_span_cnt := COUNT(GROUP,h.speak_span <> (TYPEOF(h.speak_span))'');
    populated_speak_span_pcnt := AVE(GROUP,IF(h.speak_span = (TYPEOF(h.speak_span))'',0,100));
    maxlength_speak_span := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.speak_span)));
    avelength_speak_span := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.speak_span)),h.speak_span<>(typeof(h.speak_span))'');
    populated_soho_cnt := COUNT(GROUP,h.soho <> (TYPEOF(h.soho))'');
    populated_soho_pcnt := AVE(GROUP,IF(h.soho = (TYPEOF(h.soho))'',0,100));
    maxlength_soho := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.soho)));
    avelength_soho := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.soho)),h.soho<>(typeof(h.soho))'');
    populated_vet_in_hh_cnt := COUNT(GROUP,h.vet_in_hh <> (TYPEOF(h.vet_in_hh))'');
    populated_vet_in_hh_pcnt := AVE(GROUP,IF(h.vet_in_hh = (TYPEOF(h.vet_in_hh))'',0,100));
    maxlength_vet_in_hh := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vet_in_hh)));
    avelength_vet_in_hh := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vet_in_hh)),h.vet_in_hh<>(typeof(h.vet_in_hh))'');
    populated_ms_mags_cnt := COUNT(GROUP,h.ms_mags <> (TYPEOF(h.ms_mags))'');
    populated_ms_mags_pcnt := AVE(GROUP,IF(h.ms_mags = (TYPEOF(h.ms_mags))'',0,100));
    maxlength_ms_mags := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_mags)));
    avelength_ms_mags := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_mags)),h.ms_mags<>(typeof(h.ms_mags))'');
    populated_ms_books_cnt := COUNT(GROUP,h.ms_books <> (TYPEOF(h.ms_books))'');
    populated_ms_books_pcnt := AVE(GROUP,IF(h.ms_books = (TYPEOF(h.ms_books))'',0,100));
    maxlength_ms_books := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_books)));
    avelength_ms_books := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_books)),h.ms_books<>(typeof(h.ms_books))'');
    populated_ms_publish_cnt := COUNT(GROUP,h.ms_publish <> (TYPEOF(h.ms_publish))'');
    populated_ms_publish_pcnt := AVE(GROUP,IF(h.ms_publish = (TYPEOF(h.ms_publish))'',0,100));
    maxlength_ms_publish := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_publish)));
    avelength_ms_publish := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_publish)),h.ms_publish<>(typeof(h.ms_publish))'');
    populated_ms_pub_status_active_cnt := COUNT(GROUP,h.ms_pub_status_active <> (TYPEOF(h.ms_pub_status_active))'');
    populated_ms_pub_status_active_pcnt := AVE(GROUP,IF(h.ms_pub_status_active = (TYPEOF(h.ms_pub_status_active))'',0,100));
    maxlength_ms_pub_status_active := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_status_active)));
    avelength_ms_pub_status_active := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_status_active)),h.ms_pub_status_active<>(typeof(h.ms_pub_status_active))'');
    populated_ms_pub_status_expire_cnt := COUNT(GROUP,h.ms_pub_status_expire <> (TYPEOF(h.ms_pub_status_expire))'');
    populated_ms_pub_status_expire_pcnt := AVE(GROUP,IF(h.ms_pub_status_expire = (TYPEOF(h.ms_pub_status_expire))'',0,100));
    maxlength_ms_pub_status_expire := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_status_expire)));
    avelength_ms_pub_status_expire := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_status_expire)),h.ms_pub_status_expire<>(typeof(h.ms_pub_status_expire))'');
    populated_ms_pub_premsold_cnt := COUNT(GROUP,h.ms_pub_premsold <> (TYPEOF(h.ms_pub_premsold))'');
    populated_ms_pub_premsold_pcnt := AVE(GROUP,IF(h.ms_pub_premsold = (TYPEOF(h.ms_pub_premsold))'',0,100));
    maxlength_ms_pub_premsold := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_premsold)));
    avelength_ms_pub_premsold := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_premsold)),h.ms_pub_premsold<>(typeof(h.ms_pub_premsold))'');
    populated_ms_pub_autornwl_cnt := COUNT(GROUP,h.ms_pub_autornwl <> (TYPEOF(h.ms_pub_autornwl))'');
    populated_ms_pub_autornwl_pcnt := AVE(GROUP,IF(h.ms_pub_autornwl = (TYPEOF(h.ms_pub_autornwl))'',0,100));
    maxlength_ms_pub_autornwl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_autornwl)));
    avelength_ms_pub_autornwl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_autornwl)),h.ms_pub_autornwl<>(typeof(h.ms_pub_autornwl))'');
    populated_ms_pub_avgterm_cnt := COUNT(GROUP,h.ms_pub_avgterm <> (TYPEOF(h.ms_pub_avgterm))'');
    populated_ms_pub_avgterm_pcnt := AVE(GROUP,IF(h.ms_pub_avgterm = (TYPEOF(h.ms_pub_avgterm))'',0,100));
    maxlength_ms_pub_avgterm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_avgterm)));
    avelength_ms_pub_avgterm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_avgterm)),h.ms_pub_avgterm<>(typeof(h.ms_pub_avgterm))'');
    populated_ms_pub_lmos_cnt := COUNT(GROUP,h.ms_pub_lmos <> (TYPEOF(h.ms_pub_lmos))'');
    populated_ms_pub_lmos_pcnt := AVE(GROUP,IF(h.ms_pub_lmos = (TYPEOF(h.ms_pub_lmos))'',0,100));
    maxlength_ms_pub_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lmos)));
    avelength_ms_pub_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lmos)),h.ms_pub_lmos<>(typeof(h.ms_pub_lmos))'');
    populated_ms_pub_omos_cnt := COUNT(GROUP,h.ms_pub_omos <> (TYPEOF(h.ms_pub_omos))'');
    populated_ms_pub_omos_pcnt := AVE(GROUP,IF(h.ms_pub_omos = (TYPEOF(h.ms_pub_omos))'',0,100));
    maxlength_ms_pub_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_omos)));
    avelength_ms_pub_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_omos)),h.ms_pub_omos<>(typeof(h.ms_pub_omos))'');
    populated_ms_pub_pmos_cnt := COUNT(GROUP,h.ms_pub_pmos <> (TYPEOF(h.ms_pub_pmos))'');
    populated_ms_pub_pmos_pcnt := AVE(GROUP,IF(h.ms_pub_pmos = (TYPEOF(h.ms_pub_pmos))'',0,100));
    maxlength_ms_pub_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_pmos)));
    avelength_ms_pub_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_pmos)),h.ms_pub_pmos<>(typeof(h.ms_pub_pmos))'');
    populated_ms_pub_cemos_cnt := COUNT(GROUP,h.ms_pub_cemos <> (TYPEOF(h.ms_pub_cemos))'');
    populated_ms_pub_cemos_pcnt := AVE(GROUP,IF(h.ms_pub_cemos = (TYPEOF(h.ms_pub_cemos))'',0,100));
    maxlength_ms_pub_cemos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_cemos)));
    avelength_ms_pub_cemos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_cemos)),h.ms_pub_cemos<>(typeof(h.ms_pub_cemos))'');
    populated_ms_pub_femos_cnt := COUNT(GROUP,h.ms_pub_femos <> (TYPEOF(h.ms_pub_femos))'');
    populated_ms_pub_femos_pcnt := AVE(GROUP,IF(h.ms_pub_femos = (TYPEOF(h.ms_pub_femos))'',0,100));
    maxlength_ms_pub_femos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_femos)));
    avelength_ms_pub_femos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_femos)),h.ms_pub_femos<>(typeof(h.ms_pub_femos))'');
    populated_ms_pub_totords_cnt := COUNT(GROUP,h.ms_pub_totords <> (TYPEOF(h.ms_pub_totords))'');
    populated_ms_pub_totords_pcnt := AVE(GROUP,IF(h.ms_pub_totords = (TYPEOF(h.ms_pub_totords))'',0,100));
    maxlength_ms_pub_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_totords)));
    avelength_ms_pub_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_totords)),h.ms_pub_totords<>(typeof(h.ms_pub_totords))'');
    populated_ms_pub_totdlrs_cnt := COUNT(GROUP,h.ms_pub_totdlrs <> (TYPEOF(h.ms_pub_totdlrs))'');
    populated_ms_pub_totdlrs_pcnt := AVE(GROUP,IF(h.ms_pub_totdlrs = (TYPEOF(h.ms_pub_totdlrs))'',0,100));
    maxlength_ms_pub_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_totdlrs)));
    avelength_ms_pub_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_totdlrs)),h.ms_pub_totdlrs<>(typeof(h.ms_pub_totdlrs))'');
    populated_ms_pub_avgdlrs_cnt := COUNT(GROUP,h.ms_pub_avgdlrs <> (TYPEOF(h.ms_pub_avgdlrs))'');
    populated_ms_pub_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_pub_avgdlrs = (TYPEOF(h.ms_pub_avgdlrs))'',0,100));
    maxlength_ms_pub_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_avgdlrs)));
    avelength_ms_pub_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_avgdlrs)),h.ms_pub_avgdlrs<>(typeof(h.ms_pub_avgdlrs))'');
    populated_ms_pub_lastdlrs_cnt := COUNT(GROUP,h.ms_pub_lastdlrs <> (TYPEOF(h.ms_pub_lastdlrs))'');
    populated_ms_pub_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_pub_lastdlrs = (TYPEOF(h.ms_pub_lastdlrs))'',0,100));
    maxlength_ms_pub_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lastdlrs)));
    avelength_ms_pub_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lastdlrs)),h.ms_pub_lastdlrs<>(typeof(h.ms_pub_lastdlrs))'');
    populated_ms_pub_paystat_paid_cnt := COUNT(GROUP,h.ms_pub_paystat_paid <> (TYPEOF(h.ms_pub_paystat_paid))'');
    populated_ms_pub_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_pub_paystat_paid = (TYPEOF(h.ms_pub_paystat_paid))'',0,100));
    maxlength_ms_pub_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_paystat_paid)));
    avelength_ms_pub_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_paystat_paid)),h.ms_pub_paystat_paid<>(typeof(h.ms_pub_paystat_paid))'');
    populated_ms_pub_paystat_ub_cnt := COUNT(GROUP,h.ms_pub_paystat_ub <> (TYPEOF(h.ms_pub_paystat_ub))'');
    populated_ms_pub_paystat_ub_pcnt := AVE(GROUP,IF(h.ms_pub_paystat_ub = (TYPEOF(h.ms_pub_paystat_ub))'',0,100));
    maxlength_ms_pub_paystat_ub := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_paystat_ub)));
    avelength_ms_pub_paystat_ub := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_paystat_ub)),h.ms_pub_paystat_ub<>(typeof(h.ms_pub_paystat_ub))'');
    populated_ms_pub_paymeth_cc_cnt := COUNT(GROUP,h.ms_pub_paymeth_cc <> (TYPEOF(h.ms_pub_paymeth_cc))'');
    populated_ms_pub_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_pub_paymeth_cc = (TYPEOF(h.ms_pub_paymeth_cc))'',0,100));
    maxlength_ms_pub_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_paymeth_cc)));
    avelength_ms_pub_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_paymeth_cc)),h.ms_pub_paymeth_cc<>(typeof(h.ms_pub_paymeth_cc))'');
    populated_ms_pub_paymeth_cash_cnt := COUNT(GROUP,h.ms_pub_paymeth_cash <> (TYPEOF(h.ms_pub_paymeth_cash))'');
    populated_ms_pub_paymeth_cash_pcnt := AVE(GROUP,IF(h.ms_pub_paymeth_cash = (TYPEOF(h.ms_pub_paymeth_cash))'',0,100));
    maxlength_ms_pub_paymeth_cash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_paymeth_cash)));
    avelength_ms_pub_paymeth_cash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_paymeth_cash)),h.ms_pub_paymeth_cash<>(typeof(h.ms_pub_paymeth_cash))'');
    populated_ms_pub_payspeed_cnt := COUNT(GROUP,h.ms_pub_payspeed <> (TYPEOF(h.ms_pub_payspeed))'');
    populated_ms_pub_payspeed_pcnt := AVE(GROUP,IF(h.ms_pub_payspeed = (TYPEOF(h.ms_pub_payspeed))'',0,100));
    maxlength_ms_pub_payspeed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_payspeed)));
    avelength_ms_pub_payspeed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_payspeed)),h.ms_pub_payspeed<>(typeof(h.ms_pub_payspeed))'');
    populated_ms_pub_osrc_dm_cnt := COUNT(GROUP,h.ms_pub_osrc_dm <> (TYPEOF(h.ms_pub_osrc_dm))'');
    populated_ms_pub_osrc_dm_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_dm = (TYPEOF(h.ms_pub_osrc_dm))'',0,100));
    maxlength_ms_pub_osrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_dm)));
    avelength_ms_pub_osrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_dm)),h.ms_pub_osrc_dm<>(typeof(h.ms_pub_osrc_dm))'');
    populated_ms_pub_lsrc_dm_cnt := COUNT(GROUP,h.ms_pub_lsrc_dm <> (TYPEOF(h.ms_pub_lsrc_dm))'');
    populated_ms_pub_lsrc_dm_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_dm = (TYPEOF(h.ms_pub_lsrc_dm))'',0,100));
    maxlength_ms_pub_lsrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_dm)));
    avelength_ms_pub_lsrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_dm)),h.ms_pub_lsrc_dm<>(typeof(h.ms_pub_lsrc_dm))'');
    populated_ms_pub_osrc_agt_cashf_cnt := COUNT(GROUP,h.ms_pub_osrc_agt_cashf <> (TYPEOF(h.ms_pub_osrc_agt_cashf))'');
    populated_ms_pub_osrc_agt_cashf_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_agt_cashf = (TYPEOF(h.ms_pub_osrc_agt_cashf))'',0,100));
    maxlength_ms_pub_osrc_agt_cashf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_cashf)));
    avelength_ms_pub_osrc_agt_cashf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_cashf)),h.ms_pub_osrc_agt_cashf<>(typeof(h.ms_pub_osrc_agt_cashf))'');
    populated_ms_pub_lsrc_agt_cashf_cnt := COUNT(GROUP,h.ms_pub_lsrc_agt_cashf <> (TYPEOF(h.ms_pub_lsrc_agt_cashf))'');
    populated_ms_pub_lsrc_agt_cashf_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_agt_cashf = (TYPEOF(h.ms_pub_lsrc_agt_cashf))'',0,100));
    maxlength_ms_pub_lsrc_agt_cashf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_cashf)));
    avelength_ms_pub_lsrc_agt_cashf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_cashf)),h.ms_pub_lsrc_agt_cashf<>(typeof(h.ms_pub_lsrc_agt_cashf))'');
    populated_ms_pub_osrc_agt_pds_cnt := COUNT(GROUP,h.ms_pub_osrc_agt_pds <> (TYPEOF(h.ms_pub_osrc_agt_pds))'');
    populated_ms_pub_osrc_agt_pds_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_agt_pds = (TYPEOF(h.ms_pub_osrc_agt_pds))'',0,100));
    maxlength_ms_pub_osrc_agt_pds := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_pds)));
    avelength_ms_pub_osrc_agt_pds := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_pds)),h.ms_pub_osrc_agt_pds<>(typeof(h.ms_pub_osrc_agt_pds))'');
    populated_ms_pub_lsrc_agt_pds_cnt := COUNT(GROUP,h.ms_pub_lsrc_agt_pds <> (TYPEOF(h.ms_pub_lsrc_agt_pds))'');
    populated_ms_pub_lsrc_agt_pds_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_agt_pds = (TYPEOF(h.ms_pub_lsrc_agt_pds))'',0,100));
    maxlength_ms_pub_lsrc_agt_pds := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_pds)));
    avelength_ms_pub_lsrc_agt_pds := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_pds)),h.ms_pub_lsrc_agt_pds<>(typeof(h.ms_pub_lsrc_agt_pds))'');
    populated_ms_pub_osrc_agt_schplan_cnt := COUNT(GROUP,h.ms_pub_osrc_agt_schplan <> (TYPEOF(h.ms_pub_osrc_agt_schplan))'');
    populated_ms_pub_osrc_agt_schplan_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_agt_schplan = (TYPEOF(h.ms_pub_osrc_agt_schplan))'',0,100));
    maxlength_ms_pub_osrc_agt_schplan := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_schplan)));
    avelength_ms_pub_osrc_agt_schplan := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_schplan)),h.ms_pub_osrc_agt_schplan<>(typeof(h.ms_pub_osrc_agt_schplan))'');
    populated_ms_pub_lsrc_agt_schplan_cnt := COUNT(GROUP,h.ms_pub_lsrc_agt_schplan <> (TYPEOF(h.ms_pub_lsrc_agt_schplan))'');
    populated_ms_pub_lsrc_agt_schplan_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_agt_schplan = (TYPEOF(h.ms_pub_lsrc_agt_schplan))'',0,100));
    maxlength_ms_pub_lsrc_agt_schplan := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_schplan)));
    avelength_ms_pub_lsrc_agt_schplan := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_schplan)),h.ms_pub_lsrc_agt_schplan<>(typeof(h.ms_pub_lsrc_agt_schplan))'');
    populated_ms_pub_osrc_agt_sponsor_cnt := COUNT(GROUP,h.ms_pub_osrc_agt_sponsor <> (TYPEOF(h.ms_pub_osrc_agt_sponsor))'');
    populated_ms_pub_osrc_agt_sponsor_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_agt_sponsor = (TYPEOF(h.ms_pub_osrc_agt_sponsor))'',0,100));
    maxlength_ms_pub_osrc_agt_sponsor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_sponsor)));
    avelength_ms_pub_osrc_agt_sponsor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_sponsor)),h.ms_pub_osrc_agt_sponsor<>(typeof(h.ms_pub_osrc_agt_sponsor))'');
    populated_ms_pub_lsrc_agt_sponsor_cnt := COUNT(GROUP,h.ms_pub_lsrc_agt_sponsor <> (TYPEOF(h.ms_pub_lsrc_agt_sponsor))'');
    populated_ms_pub_lsrc_agt_sponsor_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_agt_sponsor = (TYPEOF(h.ms_pub_lsrc_agt_sponsor))'',0,100));
    maxlength_ms_pub_lsrc_agt_sponsor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_sponsor)));
    avelength_ms_pub_lsrc_agt_sponsor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_sponsor)),h.ms_pub_lsrc_agt_sponsor<>(typeof(h.ms_pub_lsrc_agt_sponsor))'');
    populated_ms_pub_osrc_agt_tm_cnt := COUNT(GROUP,h.ms_pub_osrc_agt_tm <> (TYPEOF(h.ms_pub_osrc_agt_tm))'');
    populated_ms_pub_osrc_agt_tm_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_agt_tm = (TYPEOF(h.ms_pub_osrc_agt_tm))'',0,100));
    maxlength_ms_pub_osrc_agt_tm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_tm)));
    avelength_ms_pub_osrc_agt_tm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt_tm)),h.ms_pub_osrc_agt_tm<>(typeof(h.ms_pub_osrc_agt_tm))'');
    populated_ms_pub_lsrc_agt_tm_cnt := COUNT(GROUP,h.ms_pub_lsrc_agt_tm <> (TYPEOF(h.ms_pub_lsrc_agt_tm))'');
    populated_ms_pub_lsrc_agt_tm_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_agt_tm = (TYPEOF(h.ms_pub_lsrc_agt_tm))'',0,100));
    maxlength_ms_pub_lsrc_agt_tm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_tm)));
    avelength_ms_pub_lsrc_agt_tm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt_tm)),h.ms_pub_lsrc_agt_tm<>(typeof(h.ms_pub_lsrc_agt_tm))'');
    populated_ms_pub_osrc_agt_cnt := COUNT(GROUP,h.ms_pub_osrc_agt <> (TYPEOF(h.ms_pub_osrc_agt))'');
    populated_ms_pub_osrc_agt_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_agt = (TYPEOF(h.ms_pub_osrc_agt))'',0,100));
    maxlength_ms_pub_osrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt)));
    avelength_ms_pub_osrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_agt)),h.ms_pub_osrc_agt<>(typeof(h.ms_pub_osrc_agt))'');
    populated_ms_pub_lsrc_agt_cnt := COUNT(GROUP,h.ms_pub_lsrc_agt <> (TYPEOF(h.ms_pub_lsrc_agt))'');
    populated_ms_pub_lsrc_agt_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_agt = (TYPEOF(h.ms_pub_lsrc_agt))'',0,100));
    maxlength_ms_pub_lsrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt)));
    avelength_ms_pub_lsrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_agt)),h.ms_pub_lsrc_agt<>(typeof(h.ms_pub_lsrc_agt))'');
    populated_ms_pub_osrc_tm_cnt := COUNT(GROUP,h.ms_pub_osrc_tm <> (TYPEOF(h.ms_pub_osrc_tm))'');
    populated_ms_pub_osrc_tm_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_tm = (TYPEOF(h.ms_pub_osrc_tm))'',0,100));
    maxlength_ms_pub_osrc_tm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_tm)));
    avelength_ms_pub_osrc_tm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_tm)),h.ms_pub_osrc_tm<>(typeof(h.ms_pub_osrc_tm))'');
    populated_ms_pub_lsrc_tm_cnt := COUNT(GROUP,h.ms_pub_lsrc_tm <> (TYPEOF(h.ms_pub_lsrc_tm))'');
    populated_ms_pub_lsrc_tm_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_tm = (TYPEOF(h.ms_pub_lsrc_tm))'',0,100));
    maxlength_ms_pub_lsrc_tm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_tm)));
    avelength_ms_pub_lsrc_tm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_tm)),h.ms_pub_lsrc_tm<>(typeof(h.ms_pub_lsrc_tm))'');
    populated_ms_pub_osrc_ins_cnt := COUNT(GROUP,h.ms_pub_osrc_ins <> (TYPEOF(h.ms_pub_osrc_ins))'');
    populated_ms_pub_osrc_ins_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_ins = (TYPEOF(h.ms_pub_osrc_ins))'',0,100));
    maxlength_ms_pub_osrc_ins := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_ins)));
    avelength_ms_pub_osrc_ins := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_ins)),h.ms_pub_osrc_ins<>(typeof(h.ms_pub_osrc_ins))'');
    populated_ms_pub_lsrc_ins_cnt := COUNT(GROUP,h.ms_pub_lsrc_ins <> (TYPEOF(h.ms_pub_lsrc_ins))'');
    populated_ms_pub_lsrc_ins_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_ins = (TYPEOF(h.ms_pub_lsrc_ins))'',0,100));
    maxlength_ms_pub_lsrc_ins := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_ins)));
    avelength_ms_pub_lsrc_ins := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_ins)),h.ms_pub_lsrc_ins<>(typeof(h.ms_pub_lsrc_ins))'');
    populated_ms_pub_osrc_net_cnt := COUNT(GROUP,h.ms_pub_osrc_net <> (TYPEOF(h.ms_pub_osrc_net))'');
    populated_ms_pub_osrc_net_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_net = (TYPEOF(h.ms_pub_osrc_net))'',0,100));
    maxlength_ms_pub_osrc_net := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_net)));
    avelength_ms_pub_osrc_net := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_net)),h.ms_pub_osrc_net<>(typeof(h.ms_pub_osrc_net))'');
    populated_ms_pub_lsrc_net_cnt := COUNT(GROUP,h.ms_pub_lsrc_net <> (TYPEOF(h.ms_pub_lsrc_net))'');
    populated_ms_pub_lsrc_net_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_net = (TYPEOF(h.ms_pub_lsrc_net))'',0,100));
    maxlength_ms_pub_lsrc_net := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_net)));
    avelength_ms_pub_lsrc_net := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_net)),h.ms_pub_lsrc_net<>(typeof(h.ms_pub_lsrc_net))'');
    populated_ms_pub_osrc_print_cnt := COUNT(GROUP,h.ms_pub_osrc_print <> (TYPEOF(h.ms_pub_osrc_print))'');
    populated_ms_pub_osrc_print_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_print = (TYPEOF(h.ms_pub_osrc_print))'',0,100));
    maxlength_ms_pub_osrc_print := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_print)));
    avelength_ms_pub_osrc_print := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_print)),h.ms_pub_osrc_print<>(typeof(h.ms_pub_osrc_print))'');
    populated_ms_pub_lsrc_print_cnt := COUNT(GROUP,h.ms_pub_lsrc_print <> (TYPEOF(h.ms_pub_lsrc_print))'');
    populated_ms_pub_lsrc_print_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_print = (TYPEOF(h.ms_pub_lsrc_print))'',0,100));
    maxlength_ms_pub_lsrc_print := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_print)));
    avelength_ms_pub_lsrc_print := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_print)),h.ms_pub_lsrc_print<>(typeof(h.ms_pub_lsrc_print))'');
    populated_ms_pub_osrc_trans_cnt := COUNT(GROUP,h.ms_pub_osrc_trans <> (TYPEOF(h.ms_pub_osrc_trans))'');
    populated_ms_pub_osrc_trans_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_trans = (TYPEOF(h.ms_pub_osrc_trans))'',0,100));
    maxlength_ms_pub_osrc_trans := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_trans)));
    avelength_ms_pub_osrc_trans := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_trans)),h.ms_pub_osrc_trans<>(typeof(h.ms_pub_osrc_trans))'');
    populated_ms_pub_lsrc_trans_cnt := COUNT(GROUP,h.ms_pub_lsrc_trans <> (TYPEOF(h.ms_pub_lsrc_trans))'');
    populated_ms_pub_lsrc_trans_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_trans = (TYPEOF(h.ms_pub_lsrc_trans))'',0,100));
    maxlength_ms_pub_lsrc_trans := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_trans)));
    avelength_ms_pub_lsrc_trans := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_trans)),h.ms_pub_lsrc_trans<>(typeof(h.ms_pub_lsrc_trans))'');
    populated_ms_pub_osrc_tv_cnt := COUNT(GROUP,h.ms_pub_osrc_tv <> (TYPEOF(h.ms_pub_osrc_tv))'');
    populated_ms_pub_osrc_tv_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_tv = (TYPEOF(h.ms_pub_osrc_tv))'',0,100));
    maxlength_ms_pub_osrc_tv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_tv)));
    avelength_ms_pub_osrc_tv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_tv)),h.ms_pub_osrc_tv<>(typeof(h.ms_pub_osrc_tv))'');
    populated_ms_pub_lsrc_tv_cnt := COUNT(GROUP,h.ms_pub_lsrc_tv <> (TYPEOF(h.ms_pub_lsrc_tv))'');
    populated_ms_pub_lsrc_tv_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_tv = (TYPEOF(h.ms_pub_lsrc_tv))'',0,100));
    maxlength_ms_pub_lsrc_tv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_tv)));
    avelength_ms_pub_lsrc_tv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_tv)),h.ms_pub_lsrc_tv<>(typeof(h.ms_pub_lsrc_tv))'');
    populated_ms_pub_osrc_dtp_cnt := COUNT(GROUP,h.ms_pub_osrc_dtp <> (TYPEOF(h.ms_pub_osrc_dtp))'');
    populated_ms_pub_osrc_dtp_pcnt := AVE(GROUP,IF(h.ms_pub_osrc_dtp = (TYPEOF(h.ms_pub_osrc_dtp))'',0,100));
    maxlength_ms_pub_osrc_dtp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_dtp)));
    avelength_ms_pub_osrc_dtp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_osrc_dtp)),h.ms_pub_osrc_dtp<>(typeof(h.ms_pub_osrc_dtp))'');
    populated_ms_pub_lsrc_dtp_cnt := COUNT(GROUP,h.ms_pub_lsrc_dtp <> (TYPEOF(h.ms_pub_lsrc_dtp))'');
    populated_ms_pub_lsrc_dtp_pcnt := AVE(GROUP,IF(h.ms_pub_lsrc_dtp = (TYPEOF(h.ms_pub_lsrc_dtp))'',0,100));
    maxlength_ms_pub_lsrc_dtp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_dtp)));
    avelength_ms_pub_lsrc_dtp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_lsrc_dtp)),h.ms_pub_lsrc_dtp<>(typeof(h.ms_pub_lsrc_dtp))'');
    populated_ms_pub_giftgivr_cnt := COUNT(GROUP,h.ms_pub_giftgivr <> (TYPEOF(h.ms_pub_giftgivr))'');
    populated_ms_pub_giftgivr_pcnt := AVE(GROUP,IF(h.ms_pub_giftgivr = (TYPEOF(h.ms_pub_giftgivr))'',0,100));
    maxlength_ms_pub_giftgivr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_giftgivr)));
    avelength_ms_pub_giftgivr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_giftgivr)),h.ms_pub_giftgivr<>(typeof(h.ms_pub_giftgivr))'');
    populated_ms_pub_giftee_cnt := COUNT(GROUP,h.ms_pub_giftee <> (TYPEOF(h.ms_pub_giftee))'');
    populated_ms_pub_giftee_pcnt := AVE(GROUP,IF(h.ms_pub_giftee = (TYPEOF(h.ms_pub_giftee))'',0,100));
    maxlength_ms_pub_giftee := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_giftee)));
    avelength_ms_pub_giftee := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_giftee)),h.ms_pub_giftee<>(typeof(h.ms_pub_giftee))'');
    populated_ms_catalog_cnt := COUNT(GROUP,h.ms_catalog <> (TYPEOF(h.ms_catalog))'');
    populated_ms_catalog_pcnt := AVE(GROUP,IF(h.ms_catalog = (TYPEOF(h.ms_catalog))'',0,100));
    maxlength_ms_catalog := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_catalog)));
    avelength_ms_catalog := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_catalog)),h.ms_catalog<>(typeof(h.ms_catalog))'');
    populated_ms_cat_lmos_cnt := COUNT(GROUP,h.ms_cat_lmos <> (TYPEOF(h.ms_cat_lmos))'');
    populated_ms_cat_lmos_pcnt := AVE(GROUP,IF(h.ms_cat_lmos = (TYPEOF(h.ms_cat_lmos))'',0,100));
    maxlength_ms_cat_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_lmos)));
    avelength_ms_cat_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_lmos)),h.ms_cat_lmos<>(typeof(h.ms_cat_lmos))'');
    populated_ms_cat_omos_cnt := COUNT(GROUP,h.ms_cat_omos <> (TYPEOF(h.ms_cat_omos))'');
    populated_ms_cat_omos_pcnt := AVE(GROUP,IF(h.ms_cat_omos = (TYPEOF(h.ms_cat_omos))'',0,100));
    maxlength_ms_cat_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_omos)));
    avelength_ms_cat_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_omos)),h.ms_cat_omos<>(typeof(h.ms_cat_omos))'');
    populated_ms_cat_pmos_cnt := COUNT(GROUP,h.ms_cat_pmos <> (TYPEOF(h.ms_cat_pmos))'');
    populated_ms_cat_pmos_pcnt := AVE(GROUP,IF(h.ms_cat_pmos = (TYPEOF(h.ms_cat_pmos))'',0,100));
    maxlength_ms_cat_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_pmos)));
    avelength_ms_cat_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_pmos)),h.ms_cat_pmos<>(typeof(h.ms_cat_pmos))'');
    populated_ms_cat_totords_cnt := COUNT(GROUP,h.ms_cat_totords <> (TYPEOF(h.ms_cat_totords))'');
    populated_ms_cat_totords_pcnt := AVE(GROUP,IF(h.ms_cat_totords = (TYPEOF(h.ms_cat_totords))'',0,100));
    maxlength_ms_cat_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_totords)));
    avelength_ms_cat_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_totords)),h.ms_cat_totords<>(typeof(h.ms_cat_totords))'');
    populated_ms_cat_totitems_cnt := COUNT(GROUP,h.ms_cat_totitems <> (TYPEOF(h.ms_cat_totitems))'');
    populated_ms_cat_totitems_pcnt := AVE(GROUP,IF(h.ms_cat_totitems = (TYPEOF(h.ms_cat_totitems))'',0,100));
    maxlength_ms_cat_totitems := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_totitems)));
    avelength_ms_cat_totitems := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_totitems)),h.ms_cat_totitems<>(typeof(h.ms_cat_totitems))'');
    populated_ms_cat_totdlrs_cnt := COUNT(GROUP,h.ms_cat_totdlrs <> (TYPEOF(h.ms_cat_totdlrs))'');
    populated_ms_cat_totdlrs_pcnt := AVE(GROUP,IF(h.ms_cat_totdlrs = (TYPEOF(h.ms_cat_totdlrs))'',0,100));
    maxlength_ms_cat_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_totdlrs)));
    avelength_ms_cat_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_totdlrs)),h.ms_cat_totdlrs<>(typeof(h.ms_cat_totdlrs))'');
    populated_ms_cat_avgdlrs_cnt := COUNT(GROUP,h.ms_cat_avgdlrs <> (TYPEOF(h.ms_cat_avgdlrs))'');
    populated_ms_cat_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_cat_avgdlrs = (TYPEOF(h.ms_cat_avgdlrs))'',0,100));
    maxlength_ms_cat_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_avgdlrs)));
    avelength_ms_cat_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_avgdlrs)),h.ms_cat_avgdlrs<>(typeof(h.ms_cat_avgdlrs))'');
    populated_ms_cat_lastdlrs_cnt := COUNT(GROUP,h.ms_cat_lastdlrs <> (TYPEOF(h.ms_cat_lastdlrs))'');
    populated_ms_cat_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_cat_lastdlrs = (TYPEOF(h.ms_cat_lastdlrs))'',0,100));
    maxlength_ms_cat_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_lastdlrs)));
    avelength_ms_cat_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_lastdlrs)),h.ms_cat_lastdlrs<>(typeof(h.ms_cat_lastdlrs))'');
    populated_ms_cat_paystat_paid_cnt := COUNT(GROUP,h.ms_cat_paystat_paid <> (TYPEOF(h.ms_cat_paystat_paid))'');
    populated_ms_cat_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_cat_paystat_paid = (TYPEOF(h.ms_cat_paystat_paid))'',0,100));
    maxlength_ms_cat_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_paystat_paid)));
    avelength_ms_cat_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_paystat_paid)),h.ms_cat_paystat_paid<>(typeof(h.ms_cat_paystat_paid))'');
    populated_ms_cat_paymeth_cc_cnt := COUNT(GROUP,h.ms_cat_paymeth_cc <> (TYPEOF(h.ms_cat_paymeth_cc))'');
    populated_ms_cat_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_cat_paymeth_cc = (TYPEOF(h.ms_cat_paymeth_cc))'',0,100));
    maxlength_ms_cat_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_paymeth_cc)));
    avelength_ms_cat_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_paymeth_cc)),h.ms_cat_paymeth_cc<>(typeof(h.ms_cat_paymeth_cc))'');
    populated_ms_cat_paymeth_cash_cnt := COUNT(GROUP,h.ms_cat_paymeth_cash <> (TYPEOF(h.ms_cat_paymeth_cash))'');
    populated_ms_cat_paymeth_cash_pcnt := AVE(GROUP,IF(h.ms_cat_paymeth_cash = (TYPEOF(h.ms_cat_paymeth_cash))'',0,100));
    maxlength_ms_cat_paymeth_cash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_paymeth_cash)));
    avelength_ms_cat_paymeth_cash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_paymeth_cash)),h.ms_cat_paymeth_cash<>(typeof(h.ms_cat_paymeth_cash))'');
    populated_ms_cat_osrc_dm_cnt := COUNT(GROUP,h.ms_cat_osrc_dm <> (TYPEOF(h.ms_cat_osrc_dm))'');
    populated_ms_cat_osrc_dm_pcnt := AVE(GROUP,IF(h.ms_cat_osrc_dm = (TYPEOF(h.ms_cat_osrc_dm))'',0,100));
    maxlength_ms_cat_osrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_osrc_dm)));
    avelength_ms_cat_osrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_osrc_dm)),h.ms_cat_osrc_dm<>(typeof(h.ms_cat_osrc_dm))'');
    populated_ms_cat_lsrc_dm_cnt := COUNT(GROUP,h.ms_cat_lsrc_dm <> (TYPEOF(h.ms_cat_lsrc_dm))'');
    populated_ms_cat_lsrc_dm_pcnt := AVE(GROUP,IF(h.ms_cat_lsrc_dm = (TYPEOF(h.ms_cat_lsrc_dm))'',0,100));
    maxlength_ms_cat_lsrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_lsrc_dm)));
    avelength_ms_cat_lsrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_lsrc_dm)),h.ms_cat_lsrc_dm<>(typeof(h.ms_cat_lsrc_dm))'');
    populated_ms_cat_osrc_net_cnt := COUNT(GROUP,h.ms_cat_osrc_net <> (TYPEOF(h.ms_cat_osrc_net))'');
    populated_ms_cat_osrc_net_pcnt := AVE(GROUP,IF(h.ms_cat_osrc_net = (TYPEOF(h.ms_cat_osrc_net))'',0,100));
    maxlength_ms_cat_osrc_net := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_osrc_net)));
    avelength_ms_cat_osrc_net := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_osrc_net)),h.ms_cat_osrc_net<>(typeof(h.ms_cat_osrc_net))'');
    populated_ms_cat_lsrc_net_cnt := COUNT(GROUP,h.ms_cat_lsrc_net <> (TYPEOF(h.ms_cat_lsrc_net))'');
    populated_ms_cat_lsrc_net_pcnt := AVE(GROUP,IF(h.ms_cat_lsrc_net = (TYPEOF(h.ms_cat_lsrc_net))'',0,100));
    maxlength_ms_cat_lsrc_net := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_lsrc_net)));
    avelength_ms_cat_lsrc_net := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_lsrc_net)),h.ms_cat_lsrc_net<>(typeof(h.ms_cat_lsrc_net))'');
    populated_ms_cat_giftgivr_cnt := COUNT(GROUP,h.ms_cat_giftgivr <> (TYPEOF(h.ms_cat_giftgivr))'');
    populated_ms_cat_giftgivr_pcnt := AVE(GROUP,IF(h.ms_cat_giftgivr = (TYPEOF(h.ms_cat_giftgivr))'',0,100));
    maxlength_ms_cat_giftgivr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_giftgivr)));
    avelength_ms_cat_giftgivr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_giftgivr)),h.ms_cat_giftgivr<>(typeof(h.ms_cat_giftgivr))'');
    populated_pkpubs_corrected_cnt := COUNT(GROUP,h.pkpubs_corrected <> (TYPEOF(h.pkpubs_corrected))'');
    populated_pkpubs_corrected_pcnt := AVE(GROUP,IF(h.pkpubs_corrected = (TYPEOF(h.pkpubs_corrected))'',0,100));
    maxlength_pkpubs_corrected := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpubs_corrected)));
    avelength_pkpubs_corrected := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpubs_corrected)),h.pkpubs_corrected<>(typeof(h.pkpubs_corrected))'');
    populated_pkcatg_corrected_cnt := COUNT(GROUP,h.pkcatg_corrected <> (TYPEOF(h.pkcatg_corrected))'');
    populated_pkcatg_corrected_pcnt := AVE(GROUP,IF(h.pkcatg_corrected = (TYPEOF(h.pkcatg_corrected))'',0,100));
    maxlength_pkcatg_corrected := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkcatg_corrected)));
    avelength_pkcatg_corrected := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkcatg_corrected)),h.pkcatg_corrected<>(typeof(h.pkcatg_corrected))'');
    populated_ms_fundraising_cnt := COUNT(GROUP,h.ms_fundraising <> (TYPEOF(h.ms_fundraising))'');
    populated_ms_fundraising_pcnt := AVE(GROUP,IF(h.ms_fundraising = (TYPEOF(h.ms_fundraising))'',0,100));
    maxlength_ms_fundraising := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fundraising)));
    avelength_ms_fundraising := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fundraising)),h.ms_fundraising<>(typeof(h.ms_fundraising))'');
    populated_ms_fund_lmos_cnt := COUNT(GROUP,h.ms_fund_lmos <> (TYPEOF(h.ms_fund_lmos))'');
    populated_ms_fund_lmos_pcnt := AVE(GROUP,IF(h.ms_fund_lmos = (TYPEOF(h.ms_fund_lmos))'',0,100));
    maxlength_ms_fund_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_lmos)));
    avelength_ms_fund_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_lmos)),h.ms_fund_lmos<>(typeof(h.ms_fund_lmos))'');
    populated_ms_fund_omos_cnt := COUNT(GROUP,h.ms_fund_omos <> (TYPEOF(h.ms_fund_omos))'');
    populated_ms_fund_omos_pcnt := AVE(GROUP,IF(h.ms_fund_omos = (TYPEOF(h.ms_fund_omos))'',0,100));
    maxlength_ms_fund_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_omos)));
    avelength_ms_fund_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_omos)),h.ms_fund_omos<>(typeof(h.ms_fund_omos))'');
    populated_ms_fund_pmos_cnt := COUNT(GROUP,h.ms_fund_pmos <> (TYPEOF(h.ms_fund_pmos))'');
    populated_ms_fund_pmos_pcnt := AVE(GROUP,IF(h.ms_fund_pmos = (TYPEOF(h.ms_fund_pmos))'',0,100));
    maxlength_ms_fund_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_pmos)));
    avelength_ms_fund_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_pmos)),h.ms_fund_pmos<>(typeof(h.ms_fund_pmos))'');
    populated_ms_fund_totords_cnt := COUNT(GROUP,h.ms_fund_totords <> (TYPEOF(h.ms_fund_totords))'');
    populated_ms_fund_totords_pcnt := AVE(GROUP,IF(h.ms_fund_totords = (TYPEOF(h.ms_fund_totords))'',0,100));
    maxlength_ms_fund_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_totords)));
    avelength_ms_fund_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_totords)),h.ms_fund_totords<>(typeof(h.ms_fund_totords))'');
    populated_ms_fund_totdlrs_cnt := COUNT(GROUP,h.ms_fund_totdlrs <> (TYPEOF(h.ms_fund_totdlrs))'');
    populated_ms_fund_totdlrs_pcnt := AVE(GROUP,IF(h.ms_fund_totdlrs = (TYPEOF(h.ms_fund_totdlrs))'',0,100));
    maxlength_ms_fund_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_totdlrs)));
    avelength_ms_fund_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_totdlrs)),h.ms_fund_totdlrs<>(typeof(h.ms_fund_totdlrs))'');
    populated_ms_fund_avgdlrs_cnt := COUNT(GROUP,h.ms_fund_avgdlrs <> (TYPEOF(h.ms_fund_avgdlrs))'');
    populated_ms_fund_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_fund_avgdlrs = (TYPEOF(h.ms_fund_avgdlrs))'',0,100));
    maxlength_ms_fund_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_avgdlrs)));
    avelength_ms_fund_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_avgdlrs)),h.ms_fund_avgdlrs<>(typeof(h.ms_fund_avgdlrs))'');
    populated_ms_fund_lastdlrs_cnt := COUNT(GROUP,h.ms_fund_lastdlrs <> (TYPEOF(h.ms_fund_lastdlrs))'');
    populated_ms_fund_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_fund_lastdlrs = (TYPEOF(h.ms_fund_lastdlrs))'',0,100));
    maxlength_ms_fund_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_lastdlrs)));
    avelength_ms_fund_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_lastdlrs)),h.ms_fund_lastdlrs<>(typeof(h.ms_fund_lastdlrs))'');
    populated_ms_fund_paystat_paid_cnt := COUNT(GROUP,h.ms_fund_paystat_paid <> (TYPEOF(h.ms_fund_paystat_paid))'');
    populated_ms_fund_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_fund_paystat_paid = (TYPEOF(h.ms_fund_paystat_paid))'',0,100));
    maxlength_ms_fund_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_paystat_paid)));
    avelength_ms_fund_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fund_paystat_paid)),h.ms_fund_paystat_paid<>(typeof(h.ms_fund_paystat_paid))'');
    populated_ms_other_cnt := COUNT(GROUP,h.ms_other <> (TYPEOF(h.ms_other))'');
    populated_ms_other_pcnt := AVE(GROUP,IF(h.ms_other = (TYPEOF(h.ms_other))'',0,100));
    maxlength_ms_other := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_other)));
    avelength_ms_other := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_other)),h.ms_other<>(typeof(h.ms_other))'');
    populated_ms_continuity_cnt := COUNT(GROUP,h.ms_continuity <> (TYPEOF(h.ms_continuity))'');
    populated_ms_continuity_pcnt := AVE(GROUP,IF(h.ms_continuity = (TYPEOF(h.ms_continuity))'',0,100));
    maxlength_ms_continuity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_continuity)));
    avelength_ms_continuity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_continuity)),h.ms_continuity<>(typeof(h.ms_continuity))'');
    populated_ms_cont_status_active_cnt := COUNT(GROUP,h.ms_cont_status_active <> (TYPEOF(h.ms_cont_status_active))'');
    populated_ms_cont_status_active_pcnt := AVE(GROUP,IF(h.ms_cont_status_active = (TYPEOF(h.ms_cont_status_active))'',0,100));
    maxlength_ms_cont_status_active := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_status_active)));
    avelength_ms_cont_status_active := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_status_active)),h.ms_cont_status_active<>(typeof(h.ms_cont_status_active))'');
    populated_ms_cont_status_cancel_cnt := COUNT(GROUP,h.ms_cont_status_cancel <> (TYPEOF(h.ms_cont_status_cancel))'');
    populated_ms_cont_status_cancel_pcnt := AVE(GROUP,IF(h.ms_cont_status_cancel = (TYPEOF(h.ms_cont_status_cancel))'',0,100));
    maxlength_ms_cont_status_cancel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_status_cancel)));
    avelength_ms_cont_status_cancel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_status_cancel)),h.ms_cont_status_cancel<>(typeof(h.ms_cont_status_cancel))'');
    populated_ms_cont_omos_cnt := COUNT(GROUP,h.ms_cont_omos <> (TYPEOF(h.ms_cont_omos))'');
    populated_ms_cont_omos_pcnt := AVE(GROUP,IF(h.ms_cont_omos = (TYPEOF(h.ms_cont_omos))'',0,100));
    maxlength_ms_cont_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_omos)));
    avelength_ms_cont_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_omos)),h.ms_cont_omos<>(typeof(h.ms_cont_omos))'');
    populated_ms_cont_lmos_cnt := COUNT(GROUP,h.ms_cont_lmos <> (TYPEOF(h.ms_cont_lmos))'');
    populated_ms_cont_lmos_pcnt := AVE(GROUP,IF(h.ms_cont_lmos = (TYPEOF(h.ms_cont_lmos))'',0,100));
    maxlength_ms_cont_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_lmos)));
    avelength_ms_cont_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_lmos)),h.ms_cont_lmos<>(typeof(h.ms_cont_lmos))'');
    populated_ms_cont_pmos_cnt := COUNT(GROUP,h.ms_cont_pmos <> (TYPEOF(h.ms_cont_pmos))'');
    populated_ms_cont_pmos_pcnt := AVE(GROUP,IF(h.ms_cont_pmos = (TYPEOF(h.ms_cont_pmos))'',0,100));
    maxlength_ms_cont_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_pmos)));
    avelength_ms_cont_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_pmos)),h.ms_cont_pmos<>(typeof(h.ms_cont_pmos))'');
    populated_ms_cont_totords_cnt := COUNT(GROUP,h.ms_cont_totords <> (TYPEOF(h.ms_cont_totords))'');
    populated_ms_cont_totords_pcnt := AVE(GROUP,IF(h.ms_cont_totords = (TYPEOF(h.ms_cont_totords))'',0,100));
    maxlength_ms_cont_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_totords)));
    avelength_ms_cont_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_totords)),h.ms_cont_totords<>(typeof(h.ms_cont_totords))'');
    populated_ms_cont_totdlrs_cnt := COUNT(GROUP,h.ms_cont_totdlrs <> (TYPEOF(h.ms_cont_totdlrs))'');
    populated_ms_cont_totdlrs_pcnt := AVE(GROUP,IF(h.ms_cont_totdlrs = (TYPEOF(h.ms_cont_totdlrs))'',0,100));
    maxlength_ms_cont_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_totdlrs)));
    avelength_ms_cont_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_totdlrs)),h.ms_cont_totdlrs<>(typeof(h.ms_cont_totdlrs))'');
    populated_ms_cont_avgdlrs_cnt := COUNT(GROUP,h.ms_cont_avgdlrs <> (TYPEOF(h.ms_cont_avgdlrs))'');
    populated_ms_cont_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_cont_avgdlrs = (TYPEOF(h.ms_cont_avgdlrs))'',0,100));
    maxlength_ms_cont_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_avgdlrs)));
    avelength_ms_cont_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_avgdlrs)),h.ms_cont_avgdlrs<>(typeof(h.ms_cont_avgdlrs))'');
    populated_ms_cont_lastdlrs_cnt := COUNT(GROUP,h.ms_cont_lastdlrs <> (TYPEOF(h.ms_cont_lastdlrs))'');
    populated_ms_cont_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_cont_lastdlrs = (TYPEOF(h.ms_cont_lastdlrs))'',0,100));
    maxlength_ms_cont_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_lastdlrs)));
    avelength_ms_cont_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_lastdlrs)),h.ms_cont_lastdlrs<>(typeof(h.ms_cont_lastdlrs))'');
    populated_ms_cont_paystat_paid_cnt := COUNT(GROUP,h.ms_cont_paystat_paid <> (TYPEOF(h.ms_cont_paystat_paid))'');
    populated_ms_cont_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_cont_paystat_paid = (TYPEOF(h.ms_cont_paystat_paid))'',0,100));
    maxlength_ms_cont_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_paystat_paid)));
    avelength_ms_cont_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_paystat_paid)),h.ms_cont_paystat_paid<>(typeof(h.ms_cont_paystat_paid))'');
    populated_ms_cont_paymeth_cc_cnt := COUNT(GROUP,h.ms_cont_paymeth_cc <> (TYPEOF(h.ms_cont_paymeth_cc))'');
    populated_ms_cont_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_cont_paymeth_cc = (TYPEOF(h.ms_cont_paymeth_cc))'',0,100));
    maxlength_ms_cont_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_paymeth_cc)));
    avelength_ms_cont_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_paymeth_cc)),h.ms_cont_paymeth_cc<>(typeof(h.ms_cont_paymeth_cc))'');
    populated_ms_cont_paymeth_cash_cnt := COUNT(GROUP,h.ms_cont_paymeth_cash <> (TYPEOF(h.ms_cont_paymeth_cash))'');
    populated_ms_cont_paymeth_cash_pcnt := AVE(GROUP,IF(h.ms_cont_paymeth_cash = (TYPEOF(h.ms_cont_paymeth_cash))'',0,100));
    maxlength_ms_cont_paymeth_cash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_paymeth_cash)));
    avelength_ms_cont_paymeth_cash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cont_paymeth_cash)),h.ms_cont_paymeth_cash<>(typeof(h.ms_cont_paymeth_cash))'');
    populated_ms_totords_cnt := COUNT(GROUP,h.ms_totords <> (TYPEOF(h.ms_totords))'');
    populated_ms_totords_pcnt := AVE(GROUP,IF(h.ms_totords = (TYPEOF(h.ms_totords))'',0,100));
    maxlength_ms_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_totords)));
    avelength_ms_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_totords)),h.ms_totords<>(typeof(h.ms_totords))'');
    populated_ms_totitems_cnt := COUNT(GROUP,h.ms_totitems <> (TYPEOF(h.ms_totitems))'');
    populated_ms_totitems_pcnt := AVE(GROUP,IF(h.ms_totitems = (TYPEOF(h.ms_totitems))'',0,100));
    maxlength_ms_totitems := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_totitems)));
    avelength_ms_totitems := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_totitems)),h.ms_totitems<>(typeof(h.ms_totitems))'');
    populated_ms_totdlrs_cnt := COUNT(GROUP,h.ms_totdlrs <> (TYPEOF(h.ms_totdlrs))'');
    populated_ms_totdlrs_pcnt := AVE(GROUP,IF(h.ms_totdlrs = (TYPEOF(h.ms_totdlrs))'',0,100));
    maxlength_ms_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_totdlrs)));
    avelength_ms_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_totdlrs)),h.ms_totdlrs<>(typeof(h.ms_totdlrs))'');
    populated_ms_avgdlrs_cnt := COUNT(GROUP,h.ms_avgdlrs <> (TYPEOF(h.ms_avgdlrs))'');
    populated_ms_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_avgdlrs = (TYPEOF(h.ms_avgdlrs))'',0,100));
    maxlength_ms_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_avgdlrs)));
    avelength_ms_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_avgdlrs)),h.ms_avgdlrs<>(typeof(h.ms_avgdlrs))'');
    populated_ms_lastdlrs_cnt := COUNT(GROUP,h.ms_lastdlrs <> (TYPEOF(h.ms_lastdlrs))'');
    populated_ms_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_lastdlrs = (TYPEOF(h.ms_lastdlrs))'',0,100));
    maxlength_ms_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lastdlrs)));
    avelength_ms_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lastdlrs)),h.ms_lastdlrs<>(typeof(h.ms_lastdlrs))'');
    populated_ms_paystat_paid_cnt := COUNT(GROUP,h.ms_paystat_paid <> (TYPEOF(h.ms_paystat_paid))'');
    populated_ms_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_paystat_paid = (TYPEOF(h.ms_paystat_paid))'',0,100));
    maxlength_ms_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_paystat_paid)));
    avelength_ms_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_paystat_paid)),h.ms_paystat_paid<>(typeof(h.ms_paystat_paid))'');
    populated_ms_paymeth_cc_cnt := COUNT(GROUP,h.ms_paymeth_cc <> (TYPEOF(h.ms_paymeth_cc))'');
    populated_ms_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_paymeth_cc = (TYPEOF(h.ms_paymeth_cc))'',0,100));
    maxlength_ms_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_paymeth_cc)));
    avelength_ms_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_paymeth_cc)),h.ms_paymeth_cc<>(typeof(h.ms_paymeth_cc))'');
    populated_ms_paymeth_cash_cnt := COUNT(GROUP,h.ms_paymeth_cash <> (TYPEOF(h.ms_paymeth_cash))'');
    populated_ms_paymeth_cash_pcnt := AVE(GROUP,IF(h.ms_paymeth_cash = (TYPEOF(h.ms_paymeth_cash))'',0,100));
    maxlength_ms_paymeth_cash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_paymeth_cash)));
    avelength_ms_paymeth_cash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_paymeth_cash)),h.ms_paymeth_cash<>(typeof(h.ms_paymeth_cash))'');
    populated_ms_osrc_dm_cnt := COUNT(GROUP,h.ms_osrc_dm <> (TYPEOF(h.ms_osrc_dm))'');
    populated_ms_osrc_dm_pcnt := AVE(GROUP,IF(h.ms_osrc_dm = (TYPEOF(h.ms_osrc_dm))'',0,100));
    maxlength_ms_osrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_dm)));
    avelength_ms_osrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_dm)),h.ms_osrc_dm<>(typeof(h.ms_osrc_dm))'');
    populated_ms_lsrc_dm_cnt := COUNT(GROUP,h.ms_lsrc_dm <> (TYPEOF(h.ms_lsrc_dm))'');
    populated_ms_lsrc_dm_pcnt := AVE(GROUP,IF(h.ms_lsrc_dm = (TYPEOF(h.ms_lsrc_dm))'',0,100));
    maxlength_ms_lsrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_dm)));
    avelength_ms_lsrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_dm)),h.ms_lsrc_dm<>(typeof(h.ms_lsrc_dm))'');
    populated_ms_osrc_tm_cnt := COUNT(GROUP,h.ms_osrc_tm <> (TYPEOF(h.ms_osrc_tm))'');
    populated_ms_osrc_tm_pcnt := AVE(GROUP,IF(h.ms_osrc_tm = (TYPEOF(h.ms_osrc_tm))'',0,100));
    maxlength_ms_osrc_tm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_tm)));
    avelength_ms_osrc_tm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_tm)),h.ms_osrc_tm<>(typeof(h.ms_osrc_tm))'');
    populated_ms_lsrc_tm_cnt := COUNT(GROUP,h.ms_lsrc_tm <> (TYPEOF(h.ms_lsrc_tm))'');
    populated_ms_lsrc_tm_pcnt := AVE(GROUP,IF(h.ms_lsrc_tm = (TYPEOF(h.ms_lsrc_tm))'',0,100));
    maxlength_ms_lsrc_tm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_tm)));
    avelength_ms_lsrc_tm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_tm)),h.ms_lsrc_tm<>(typeof(h.ms_lsrc_tm))'');
    populated_ms_osrc_ins_cnt := COUNT(GROUP,h.ms_osrc_ins <> (TYPEOF(h.ms_osrc_ins))'');
    populated_ms_osrc_ins_pcnt := AVE(GROUP,IF(h.ms_osrc_ins = (TYPEOF(h.ms_osrc_ins))'',0,100));
    maxlength_ms_osrc_ins := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_ins)));
    avelength_ms_osrc_ins := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_ins)),h.ms_osrc_ins<>(typeof(h.ms_osrc_ins))'');
    populated_ms_lsrc_ins_cnt := COUNT(GROUP,h.ms_lsrc_ins <> (TYPEOF(h.ms_lsrc_ins))'');
    populated_ms_lsrc_ins_pcnt := AVE(GROUP,IF(h.ms_lsrc_ins = (TYPEOF(h.ms_lsrc_ins))'',0,100));
    maxlength_ms_lsrc_ins := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_ins)));
    avelength_ms_lsrc_ins := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_ins)),h.ms_lsrc_ins<>(typeof(h.ms_lsrc_ins))'');
    populated_ms_osrc_net_cnt := COUNT(GROUP,h.ms_osrc_net <> (TYPEOF(h.ms_osrc_net))'');
    populated_ms_osrc_net_pcnt := AVE(GROUP,IF(h.ms_osrc_net = (TYPEOF(h.ms_osrc_net))'',0,100));
    maxlength_ms_osrc_net := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_net)));
    avelength_ms_osrc_net := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_net)),h.ms_osrc_net<>(typeof(h.ms_osrc_net))'');
    populated_ms_lsrc_net_cnt := COUNT(GROUP,h.ms_lsrc_net <> (TYPEOF(h.ms_lsrc_net))'');
    populated_ms_lsrc_net_pcnt := AVE(GROUP,IF(h.ms_lsrc_net = (TYPEOF(h.ms_lsrc_net))'',0,100));
    maxlength_ms_lsrc_net := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_net)));
    avelength_ms_lsrc_net := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_net)),h.ms_lsrc_net<>(typeof(h.ms_lsrc_net))'');
    populated_ms_osrc_tv_cnt := COUNT(GROUP,h.ms_osrc_tv <> (TYPEOF(h.ms_osrc_tv))'');
    populated_ms_osrc_tv_pcnt := AVE(GROUP,IF(h.ms_osrc_tv = (TYPEOF(h.ms_osrc_tv))'',0,100));
    maxlength_ms_osrc_tv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_tv)));
    avelength_ms_osrc_tv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_tv)),h.ms_osrc_tv<>(typeof(h.ms_osrc_tv))'');
    populated_ms_lsrc_tv_cnt := COUNT(GROUP,h.ms_lsrc_tv <> (TYPEOF(h.ms_lsrc_tv))'');
    populated_ms_lsrc_tv_pcnt := AVE(GROUP,IF(h.ms_lsrc_tv = (TYPEOF(h.ms_lsrc_tv))'',0,100));
    maxlength_ms_lsrc_tv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_tv)));
    avelength_ms_lsrc_tv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_tv)),h.ms_lsrc_tv<>(typeof(h.ms_lsrc_tv))'');
    populated_ms_osrc_retail_cnt := COUNT(GROUP,h.ms_osrc_retail <> (TYPEOF(h.ms_osrc_retail))'');
    populated_ms_osrc_retail_pcnt := AVE(GROUP,IF(h.ms_osrc_retail = (TYPEOF(h.ms_osrc_retail))'',0,100));
    maxlength_ms_osrc_retail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_retail)));
    avelength_ms_osrc_retail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_osrc_retail)),h.ms_osrc_retail<>(typeof(h.ms_osrc_retail))'');
    populated_ms_lsrc_retail_cnt := COUNT(GROUP,h.ms_lsrc_retail <> (TYPEOF(h.ms_lsrc_retail))'');
    populated_ms_lsrc_retail_pcnt := AVE(GROUP,IF(h.ms_lsrc_retail = (TYPEOF(h.ms_lsrc_retail))'',0,100));
    maxlength_ms_lsrc_retail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_retail)));
    avelength_ms_lsrc_retail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_lsrc_retail)),h.ms_lsrc_retail<>(typeof(h.ms_lsrc_retail))'');
    populated_ms_giftgivr_cnt := COUNT(GROUP,h.ms_giftgivr <> (TYPEOF(h.ms_giftgivr))'');
    populated_ms_giftgivr_pcnt := AVE(GROUP,IF(h.ms_giftgivr = (TYPEOF(h.ms_giftgivr))'',0,100));
    maxlength_ms_giftgivr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_giftgivr)));
    avelength_ms_giftgivr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_giftgivr)),h.ms_giftgivr<>(typeof(h.ms_giftgivr))'');
    populated_ms_giftee_cnt := COUNT(GROUP,h.ms_giftee <> (TYPEOF(h.ms_giftee))'');
    populated_ms_giftee_pcnt := AVE(GROUP,IF(h.ms_giftee = (TYPEOF(h.ms_giftee))'',0,100));
    maxlength_ms_giftee := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_giftee)));
    avelength_ms_giftee := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_giftee)),h.ms_giftee<>(typeof(h.ms_giftee))'');
    populated_ms_adult_cnt := COUNT(GROUP,h.ms_adult <> (TYPEOF(h.ms_adult))'');
    populated_ms_adult_pcnt := AVE(GROUP,IF(h.ms_adult = (TYPEOF(h.ms_adult))'',0,100));
    maxlength_ms_adult := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_adult)));
    avelength_ms_adult := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_adult)),h.ms_adult<>(typeof(h.ms_adult))'');
    populated_ms_womapp_cnt := COUNT(GROUP,h.ms_womapp <> (TYPEOF(h.ms_womapp))'');
    populated_ms_womapp_pcnt := AVE(GROUP,IF(h.ms_womapp = (TYPEOF(h.ms_womapp))'',0,100));
    maxlength_ms_womapp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_womapp)));
    avelength_ms_womapp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_womapp)),h.ms_womapp<>(typeof(h.ms_womapp))'');
    populated_ms_menapp_cnt := COUNT(GROUP,h.ms_menapp <> (TYPEOF(h.ms_menapp))'');
    populated_ms_menapp_pcnt := AVE(GROUP,IF(h.ms_menapp = (TYPEOF(h.ms_menapp))'',0,100));
    maxlength_ms_menapp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_menapp)));
    avelength_ms_menapp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_menapp)),h.ms_menapp<>(typeof(h.ms_menapp))'');
    populated_ms_kidapp_cnt := COUNT(GROUP,h.ms_kidapp <> (TYPEOF(h.ms_kidapp))'');
    populated_ms_kidapp_pcnt := AVE(GROUP,IF(h.ms_kidapp = (TYPEOF(h.ms_kidapp))'',0,100));
    maxlength_ms_kidapp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_kidapp)));
    avelength_ms_kidapp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_kidapp)),h.ms_kidapp<>(typeof(h.ms_kidapp))'');
    populated_ms_accessory_cnt := COUNT(GROUP,h.ms_accessory <> (TYPEOF(h.ms_accessory))'');
    populated_ms_accessory_pcnt := AVE(GROUP,IF(h.ms_accessory = (TYPEOF(h.ms_accessory))'',0,100));
    maxlength_ms_accessory := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_accessory)));
    avelength_ms_accessory := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_accessory)),h.ms_accessory<>(typeof(h.ms_accessory))'');
    populated_ms_apparel_cnt := COUNT(GROUP,h.ms_apparel <> (TYPEOF(h.ms_apparel))'');
    populated_ms_apparel_pcnt := AVE(GROUP,IF(h.ms_apparel = (TYPEOF(h.ms_apparel))'',0,100));
    maxlength_ms_apparel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_apparel)));
    avelength_ms_apparel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_apparel)),h.ms_apparel<>(typeof(h.ms_apparel))'');
    populated_ms_app_lmos_cnt := COUNT(GROUP,h.ms_app_lmos <> (TYPEOF(h.ms_app_lmos))'');
    populated_ms_app_lmos_pcnt := AVE(GROUP,IF(h.ms_app_lmos = (TYPEOF(h.ms_app_lmos))'',0,100));
    maxlength_ms_app_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_lmos)));
    avelength_ms_app_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_lmos)),h.ms_app_lmos<>(typeof(h.ms_app_lmos))'');
    populated_ms_app_omos_cnt := COUNT(GROUP,h.ms_app_omos <> (TYPEOF(h.ms_app_omos))'');
    populated_ms_app_omos_pcnt := AVE(GROUP,IF(h.ms_app_omos = (TYPEOF(h.ms_app_omos))'',0,100));
    maxlength_ms_app_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_omos)));
    avelength_ms_app_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_omos)),h.ms_app_omos<>(typeof(h.ms_app_omos))'');
    populated_ms_app_pmos_cnt := COUNT(GROUP,h.ms_app_pmos <> (TYPEOF(h.ms_app_pmos))'');
    populated_ms_app_pmos_pcnt := AVE(GROUP,IF(h.ms_app_pmos = (TYPEOF(h.ms_app_pmos))'',0,100));
    maxlength_ms_app_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_pmos)));
    avelength_ms_app_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_pmos)),h.ms_app_pmos<>(typeof(h.ms_app_pmos))'');
    populated_ms_app_totords_cnt := COUNT(GROUP,h.ms_app_totords <> (TYPEOF(h.ms_app_totords))'');
    populated_ms_app_totords_pcnt := AVE(GROUP,IF(h.ms_app_totords = (TYPEOF(h.ms_app_totords))'',0,100));
    maxlength_ms_app_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_totords)));
    avelength_ms_app_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_totords)),h.ms_app_totords<>(typeof(h.ms_app_totords))'');
    populated_ms_app_totitems_cnt := COUNT(GROUP,h.ms_app_totitems <> (TYPEOF(h.ms_app_totitems))'');
    populated_ms_app_totitems_pcnt := AVE(GROUP,IF(h.ms_app_totitems = (TYPEOF(h.ms_app_totitems))'',0,100));
    maxlength_ms_app_totitems := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_totitems)));
    avelength_ms_app_totitems := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_totitems)),h.ms_app_totitems<>(typeof(h.ms_app_totitems))'');
    populated_ms_app_totdlrs_cnt := COUNT(GROUP,h.ms_app_totdlrs <> (TYPEOF(h.ms_app_totdlrs))'');
    populated_ms_app_totdlrs_pcnt := AVE(GROUP,IF(h.ms_app_totdlrs = (TYPEOF(h.ms_app_totdlrs))'',0,100));
    maxlength_ms_app_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_totdlrs)));
    avelength_ms_app_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_totdlrs)),h.ms_app_totdlrs<>(typeof(h.ms_app_totdlrs))'');
    populated_ms_app_avgdlrs_cnt := COUNT(GROUP,h.ms_app_avgdlrs <> (TYPEOF(h.ms_app_avgdlrs))'');
    populated_ms_app_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_app_avgdlrs = (TYPEOF(h.ms_app_avgdlrs))'',0,100));
    maxlength_ms_app_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_avgdlrs)));
    avelength_ms_app_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_avgdlrs)),h.ms_app_avgdlrs<>(typeof(h.ms_app_avgdlrs))'');
    populated_ms_app_lastdlrs_cnt := COUNT(GROUP,h.ms_app_lastdlrs <> (TYPEOF(h.ms_app_lastdlrs))'');
    populated_ms_app_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_app_lastdlrs = (TYPEOF(h.ms_app_lastdlrs))'',0,100));
    maxlength_ms_app_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_lastdlrs)));
    avelength_ms_app_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_lastdlrs)),h.ms_app_lastdlrs<>(typeof(h.ms_app_lastdlrs))'');
    populated_ms_app_paystat_paid_cnt := COUNT(GROUP,h.ms_app_paystat_paid <> (TYPEOF(h.ms_app_paystat_paid))'');
    populated_ms_app_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_app_paystat_paid = (TYPEOF(h.ms_app_paystat_paid))'',0,100));
    maxlength_ms_app_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_paystat_paid)));
    avelength_ms_app_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_paystat_paid)),h.ms_app_paystat_paid<>(typeof(h.ms_app_paystat_paid))'');
    populated_ms_app_paymeth_cc_cnt := COUNT(GROUP,h.ms_app_paymeth_cc <> (TYPEOF(h.ms_app_paymeth_cc))'');
    populated_ms_app_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_app_paymeth_cc = (TYPEOF(h.ms_app_paymeth_cc))'',0,100));
    maxlength_ms_app_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_paymeth_cc)));
    avelength_ms_app_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_paymeth_cc)),h.ms_app_paymeth_cc<>(typeof(h.ms_app_paymeth_cc))'');
    populated_ms_app_paymeth_cash_cnt := COUNT(GROUP,h.ms_app_paymeth_cash <> (TYPEOF(h.ms_app_paymeth_cash))'');
    populated_ms_app_paymeth_cash_pcnt := AVE(GROUP,IF(h.ms_app_paymeth_cash = (TYPEOF(h.ms_app_paymeth_cash))'',0,100));
    maxlength_ms_app_paymeth_cash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_paymeth_cash)));
    avelength_ms_app_paymeth_cash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_app_paymeth_cash)),h.ms_app_paymeth_cash<>(typeof(h.ms_app_paymeth_cash))'');
    populated_ms_menfash_cnt := COUNT(GROUP,h.ms_menfash <> (TYPEOF(h.ms_menfash))'');
    populated_ms_menfash_pcnt := AVE(GROUP,IF(h.ms_menfash = (TYPEOF(h.ms_menfash))'',0,100));
    maxlength_ms_menfash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_menfash)));
    avelength_ms_menfash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_menfash)),h.ms_menfash<>(typeof(h.ms_menfash))'');
    populated_ms_womfash_cnt := COUNT(GROUP,h.ms_womfash <> (TYPEOF(h.ms_womfash))'');
    populated_ms_womfash_pcnt := AVE(GROUP,IF(h.ms_womfash = (TYPEOF(h.ms_womfash))'',0,100));
    maxlength_ms_womfash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_womfash)));
    avelength_ms_womfash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_womfash)),h.ms_womfash<>(typeof(h.ms_womfash))'');
    populated_ms_wfsh_lmos_cnt := COUNT(GROUP,h.ms_wfsh_lmos <> (TYPEOF(h.ms_wfsh_lmos))'');
    populated_ms_wfsh_lmos_pcnt := AVE(GROUP,IF(h.ms_wfsh_lmos = (TYPEOF(h.ms_wfsh_lmos))'',0,100));
    maxlength_ms_wfsh_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_lmos)));
    avelength_ms_wfsh_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_lmos)),h.ms_wfsh_lmos<>(typeof(h.ms_wfsh_lmos))'');
    populated_ms_wfsh_omos_cnt := COUNT(GROUP,h.ms_wfsh_omos <> (TYPEOF(h.ms_wfsh_omos))'');
    populated_ms_wfsh_omos_pcnt := AVE(GROUP,IF(h.ms_wfsh_omos = (TYPEOF(h.ms_wfsh_omos))'',0,100));
    maxlength_ms_wfsh_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_omos)));
    avelength_ms_wfsh_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_omos)),h.ms_wfsh_omos<>(typeof(h.ms_wfsh_omos))'');
    populated_ms_wfsh_pmos_cnt := COUNT(GROUP,h.ms_wfsh_pmos <> (TYPEOF(h.ms_wfsh_pmos))'');
    populated_ms_wfsh_pmos_pcnt := AVE(GROUP,IF(h.ms_wfsh_pmos = (TYPEOF(h.ms_wfsh_pmos))'',0,100));
    maxlength_ms_wfsh_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_pmos)));
    avelength_ms_wfsh_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_pmos)),h.ms_wfsh_pmos<>(typeof(h.ms_wfsh_pmos))'');
    populated_ms_wfsh_totords_cnt := COUNT(GROUP,h.ms_wfsh_totords <> (TYPEOF(h.ms_wfsh_totords))'');
    populated_ms_wfsh_totords_pcnt := AVE(GROUP,IF(h.ms_wfsh_totords = (TYPEOF(h.ms_wfsh_totords))'',0,100));
    maxlength_ms_wfsh_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_totords)));
    avelength_ms_wfsh_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_totords)),h.ms_wfsh_totords<>(typeof(h.ms_wfsh_totords))'');
    populated_ms_wfsh_totdlrs_cnt := COUNT(GROUP,h.ms_wfsh_totdlrs <> (TYPEOF(h.ms_wfsh_totdlrs))'');
    populated_ms_wfsh_totdlrs_pcnt := AVE(GROUP,IF(h.ms_wfsh_totdlrs = (TYPEOF(h.ms_wfsh_totdlrs))'',0,100));
    maxlength_ms_wfsh_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_totdlrs)));
    avelength_ms_wfsh_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_totdlrs)),h.ms_wfsh_totdlrs<>(typeof(h.ms_wfsh_totdlrs))'');
    populated_ms_wfsh_avgdlrs_cnt := COUNT(GROUP,h.ms_wfsh_avgdlrs <> (TYPEOF(h.ms_wfsh_avgdlrs))'');
    populated_ms_wfsh_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_wfsh_avgdlrs = (TYPEOF(h.ms_wfsh_avgdlrs))'',0,100));
    maxlength_ms_wfsh_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_avgdlrs)));
    avelength_ms_wfsh_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_avgdlrs)),h.ms_wfsh_avgdlrs<>(typeof(h.ms_wfsh_avgdlrs))'');
    populated_ms_wfsh_lastdlrs_cnt := COUNT(GROUP,h.ms_wfsh_lastdlrs <> (TYPEOF(h.ms_wfsh_lastdlrs))'');
    populated_ms_wfsh_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_wfsh_lastdlrs = (TYPEOF(h.ms_wfsh_lastdlrs))'',0,100));
    maxlength_ms_wfsh_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_lastdlrs)));
    avelength_ms_wfsh_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_lastdlrs)),h.ms_wfsh_lastdlrs<>(typeof(h.ms_wfsh_lastdlrs))'');
    populated_ms_wfsh_paystat_paid_cnt := COUNT(GROUP,h.ms_wfsh_paystat_paid <> (TYPEOF(h.ms_wfsh_paystat_paid))'');
    populated_ms_wfsh_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_wfsh_paystat_paid = (TYPEOF(h.ms_wfsh_paystat_paid))'',0,100));
    maxlength_ms_wfsh_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_paystat_paid)));
    avelength_ms_wfsh_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_paystat_paid)),h.ms_wfsh_paystat_paid<>(typeof(h.ms_wfsh_paystat_paid))'');
    populated_ms_wfsh_osrc_dm_cnt := COUNT(GROUP,h.ms_wfsh_osrc_dm <> (TYPEOF(h.ms_wfsh_osrc_dm))'');
    populated_ms_wfsh_osrc_dm_pcnt := AVE(GROUP,IF(h.ms_wfsh_osrc_dm = (TYPEOF(h.ms_wfsh_osrc_dm))'',0,100));
    maxlength_ms_wfsh_osrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_osrc_dm)));
    avelength_ms_wfsh_osrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_osrc_dm)),h.ms_wfsh_osrc_dm<>(typeof(h.ms_wfsh_osrc_dm))'');
    populated_ms_wfsh_lsrc_dm_cnt := COUNT(GROUP,h.ms_wfsh_lsrc_dm <> (TYPEOF(h.ms_wfsh_lsrc_dm))'');
    populated_ms_wfsh_lsrc_dm_pcnt := AVE(GROUP,IF(h.ms_wfsh_lsrc_dm = (TYPEOF(h.ms_wfsh_lsrc_dm))'',0,100));
    maxlength_ms_wfsh_lsrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_lsrc_dm)));
    avelength_ms_wfsh_lsrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_lsrc_dm)),h.ms_wfsh_lsrc_dm<>(typeof(h.ms_wfsh_lsrc_dm))'');
    populated_ms_wfsh_osrc_agt_cnt := COUNT(GROUP,h.ms_wfsh_osrc_agt <> (TYPEOF(h.ms_wfsh_osrc_agt))'');
    populated_ms_wfsh_osrc_agt_pcnt := AVE(GROUP,IF(h.ms_wfsh_osrc_agt = (TYPEOF(h.ms_wfsh_osrc_agt))'',0,100));
    maxlength_ms_wfsh_osrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_osrc_agt)));
    avelength_ms_wfsh_osrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_osrc_agt)),h.ms_wfsh_osrc_agt<>(typeof(h.ms_wfsh_osrc_agt))'');
    populated_ms_wfsh_lsrc_agt_cnt := COUNT(GROUP,h.ms_wfsh_lsrc_agt <> (TYPEOF(h.ms_wfsh_lsrc_agt))'');
    populated_ms_wfsh_lsrc_agt_pcnt := AVE(GROUP,IF(h.ms_wfsh_lsrc_agt = (TYPEOF(h.ms_wfsh_lsrc_agt))'',0,100));
    maxlength_ms_wfsh_lsrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_lsrc_agt)));
    avelength_ms_wfsh_lsrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wfsh_lsrc_agt)),h.ms_wfsh_lsrc_agt<>(typeof(h.ms_wfsh_lsrc_agt))'');
    populated_ms_audio_cnt := COUNT(GROUP,h.ms_audio <> (TYPEOF(h.ms_audio))'');
    populated_ms_audio_pcnt := AVE(GROUP,IF(h.ms_audio = (TYPEOF(h.ms_audio))'',0,100));
    maxlength_ms_audio := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_audio)));
    avelength_ms_audio := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_audio)),h.ms_audio<>(typeof(h.ms_audio))'');
    populated_ms_auto_cnt := COUNT(GROUP,h.ms_auto <> (TYPEOF(h.ms_auto))'');
    populated_ms_auto_pcnt := AVE(GROUP,IF(h.ms_auto = (TYPEOF(h.ms_auto))'',0,100));
    maxlength_ms_auto := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_auto)));
    avelength_ms_auto := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_auto)),h.ms_auto<>(typeof(h.ms_auto))'');
    populated_ms_aviation_cnt := COUNT(GROUP,h.ms_aviation <> (TYPEOF(h.ms_aviation))'');
    populated_ms_aviation_pcnt := AVE(GROUP,IF(h.ms_aviation = (TYPEOF(h.ms_aviation))'',0,100));
    maxlength_ms_aviation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_aviation)));
    avelength_ms_aviation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_aviation)),h.ms_aviation<>(typeof(h.ms_aviation))'');
    populated_ms_bargains_cnt := COUNT(GROUP,h.ms_bargains <> (TYPEOF(h.ms_bargains))'');
    populated_ms_bargains_pcnt := AVE(GROUP,IF(h.ms_bargains = (TYPEOF(h.ms_bargains))'',0,100));
    maxlength_ms_bargains := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bargains)));
    avelength_ms_bargains := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bargains)),h.ms_bargains<>(typeof(h.ms_bargains))'');
    populated_ms_beauty_cnt := COUNT(GROUP,h.ms_beauty <> (TYPEOF(h.ms_beauty))'');
    populated_ms_beauty_pcnt := AVE(GROUP,IF(h.ms_beauty = (TYPEOF(h.ms_beauty))'',0,100));
    maxlength_ms_beauty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_beauty)));
    avelength_ms_beauty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_beauty)),h.ms_beauty<>(typeof(h.ms_beauty))'');
    populated_ms_bible_cnt := COUNT(GROUP,h.ms_bible <> (TYPEOF(h.ms_bible))'');
    populated_ms_bible_pcnt := AVE(GROUP,IF(h.ms_bible = (TYPEOF(h.ms_bible))'',0,100));
    maxlength_ms_bible := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible)));
    avelength_ms_bible := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible)),h.ms_bible<>(typeof(h.ms_bible))'');
    populated_ms_bible_lmos_cnt := COUNT(GROUP,h.ms_bible_lmos <> (TYPEOF(h.ms_bible_lmos))'');
    populated_ms_bible_lmos_pcnt := AVE(GROUP,IF(h.ms_bible_lmos = (TYPEOF(h.ms_bible_lmos))'',0,100));
    maxlength_ms_bible_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_lmos)));
    avelength_ms_bible_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_lmos)),h.ms_bible_lmos<>(typeof(h.ms_bible_lmos))'');
    populated_ms_bible_omos_cnt := COUNT(GROUP,h.ms_bible_omos <> (TYPEOF(h.ms_bible_omos))'');
    populated_ms_bible_omos_pcnt := AVE(GROUP,IF(h.ms_bible_omos = (TYPEOF(h.ms_bible_omos))'',0,100));
    maxlength_ms_bible_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_omos)));
    avelength_ms_bible_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_omos)),h.ms_bible_omos<>(typeof(h.ms_bible_omos))'');
    populated_ms_bible_pmos_cnt := COUNT(GROUP,h.ms_bible_pmos <> (TYPEOF(h.ms_bible_pmos))'');
    populated_ms_bible_pmos_pcnt := AVE(GROUP,IF(h.ms_bible_pmos = (TYPEOF(h.ms_bible_pmos))'',0,100));
    maxlength_ms_bible_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_pmos)));
    avelength_ms_bible_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_pmos)),h.ms_bible_pmos<>(typeof(h.ms_bible_pmos))'');
    populated_ms_bible_totords_cnt := COUNT(GROUP,h.ms_bible_totords <> (TYPEOF(h.ms_bible_totords))'');
    populated_ms_bible_totords_pcnt := AVE(GROUP,IF(h.ms_bible_totords = (TYPEOF(h.ms_bible_totords))'',0,100));
    maxlength_ms_bible_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_totords)));
    avelength_ms_bible_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_totords)),h.ms_bible_totords<>(typeof(h.ms_bible_totords))'');
    populated_ms_bible_totitems_cnt := COUNT(GROUP,h.ms_bible_totitems <> (TYPEOF(h.ms_bible_totitems))'');
    populated_ms_bible_totitems_pcnt := AVE(GROUP,IF(h.ms_bible_totitems = (TYPEOF(h.ms_bible_totitems))'',0,100));
    maxlength_ms_bible_totitems := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_totitems)));
    avelength_ms_bible_totitems := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_totitems)),h.ms_bible_totitems<>(typeof(h.ms_bible_totitems))'');
    populated_ms_bible_totdlrs_cnt := COUNT(GROUP,h.ms_bible_totdlrs <> (TYPEOF(h.ms_bible_totdlrs))'');
    populated_ms_bible_totdlrs_pcnt := AVE(GROUP,IF(h.ms_bible_totdlrs = (TYPEOF(h.ms_bible_totdlrs))'',0,100));
    maxlength_ms_bible_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_totdlrs)));
    avelength_ms_bible_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_totdlrs)),h.ms_bible_totdlrs<>(typeof(h.ms_bible_totdlrs))'');
    populated_ms_bible_avgdlrs_cnt := COUNT(GROUP,h.ms_bible_avgdlrs <> (TYPEOF(h.ms_bible_avgdlrs))'');
    populated_ms_bible_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_bible_avgdlrs = (TYPEOF(h.ms_bible_avgdlrs))'',0,100));
    maxlength_ms_bible_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_avgdlrs)));
    avelength_ms_bible_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_avgdlrs)),h.ms_bible_avgdlrs<>(typeof(h.ms_bible_avgdlrs))'');
    populated_ms_bible_lastdlrs_cnt := COUNT(GROUP,h.ms_bible_lastdlrs <> (TYPEOF(h.ms_bible_lastdlrs))'');
    populated_ms_bible_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_bible_lastdlrs = (TYPEOF(h.ms_bible_lastdlrs))'',0,100));
    maxlength_ms_bible_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_lastdlrs)));
    avelength_ms_bible_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_lastdlrs)),h.ms_bible_lastdlrs<>(typeof(h.ms_bible_lastdlrs))'');
    populated_ms_bible_paystat_paid_cnt := COUNT(GROUP,h.ms_bible_paystat_paid <> (TYPEOF(h.ms_bible_paystat_paid))'');
    populated_ms_bible_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_bible_paystat_paid = (TYPEOF(h.ms_bible_paystat_paid))'',0,100));
    maxlength_ms_bible_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_paystat_paid)));
    avelength_ms_bible_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_paystat_paid)),h.ms_bible_paystat_paid<>(typeof(h.ms_bible_paystat_paid))'');
    populated_ms_bible_paymeth_cc_cnt := COUNT(GROUP,h.ms_bible_paymeth_cc <> (TYPEOF(h.ms_bible_paymeth_cc))'');
    populated_ms_bible_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_bible_paymeth_cc = (TYPEOF(h.ms_bible_paymeth_cc))'',0,100));
    maxlength_ms_bible_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_paymeth_cc)));
    avelength_ms_bible_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_paymeth_cc)),h.ms_bible_paymeth_cc<>(typeof(h.ms_bible_paymeth_cc))'');
    populated_ms_bible_paymeth_cash_cnt := COUNT(GROUP,h.ms_bible_paymeth_cash <> (TYPEOF(h.ms_bible_paymeth_cash))'');
    populated_ms_bible_paymeth_cash_pcnt := AVE(GROUP,IF(h.ms_bible_paymeth_cash = (TYPEOF(h.ms_bible_paymeth_cash))'',0,100));
    maxlength_ms_bible_paymeth_cash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_paymeth_cash)));
    avelength_ms_bible_paymeth_cash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_bible_paymeth_cash)),h.ms_bible_paymeth_cash<>(typeof(h.ms_bible_paymeth_cash))'');
    populated_ms_business_cnt := COUNT(GROUP,h.ms_business <> (TYPEOF(h.ms_business))'');
    populated_ms_business_pcnt := AVE(GROUP,IF(h.ms_business = (TYPEOF(h.ms_business))'',0,100));
    maxlength_ms_business := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_business)));
    avelength_ms_business := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_business)),h.ms_business<>(typeof(h.ms_business))'');
    populated_ms_collectibles_cnt := COUNT(GROUP,h.ms_collectibles <> (TYPEOF(h.ms_collectibles))'');
    populated_ms_collectibles_pcnt := AVE(GROUP,IF(h.ms_collectibles = (TYPEOF(h.ms_collectibles))'',0,100));
    maxlength_ms_collectibles := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_collectibles)));
    avelength_ms_collectibles := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_collectibles)),h.ms_collectibles<>(typeof(h.ms_collectibles))'');
    populated_ms_computers_cnt := COUNT(GROUP,h.ms_computers <> (TYPEOF(h.ms_computers))'');
    populated_ms_computers_pcnt := AVE(GROUP,IF(h.ms_computers = (TYPEOF(h.ms_computers))'',0,100));
    maxlength_ms_computers := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_computers)));
    avelength_ms_computers := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_computers)),h.ms_computers<>(typeof(h.ms_computers))'');
    populated_ms_crafts_cnt := COUNT(GROUP,h.ms_crafts <> (TYPEOF(h.ms_crafts))'');
    populated_ms_crafts_pcnt := AVE(GROUP,IF(h.ms_crafts = (TYPEOF(h.ms_crafts))'',0,100));
    maxlength_ms_crafts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_crafts)));
    avelength_ms_crafts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_crafts)),h.ms_crafts<>(typeof(h.ms_crafts))'');
    populated_ms_culturearts_cnt := COUNT(GROUP,h.ms_culturearts <> (TYPEOF(h.ms_culturearts))'');
    populated_ms_culturearts_pcnt := AVE(GROUP,IF(h.ms_culturearts = (TYPEOF(h.ms_culturearts))'',0,100));
    maxlength_ms_culturearts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_culturearts)));
    avelength_ms_culturearts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_culturearts)),h.ms_culturearts<>(typeof(h.ms_culturearts))'');
    populated_ms_currevent_cnt := COUNT(GROUP,h.ms_currevent <> (TYPEOF(h.ms_currevent))'');
    populated_ms_currevent_pcnt := AVE(GROUP,IF(h.ms_currevent = (TYPEOF(h.ms_currevent))'',0,100));
    maxlength_ms_currevent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_currevent)));
    avelength_ms_currevent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_currevent)),h.ms_currevent<>(typeof(h.ms_currevent))'');
    populated_ms_diy_cnt := COUNT(GROUP,h.ms_diy <> (TYPEOF(h.ms_diy))'');
    populated_ms_diy_pcnt := AVE(GROUP,IF(h.ms_diy = (TYPEOF(h.ms_diy))'',0,100));
    maxlength_ms_diy := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_diy)));
    avelength_ms_diy := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_diy)),h.ms_diy<>(typeof(h.ms_diy))'');
    populated_ms_electronics_cnt := COUNT(GROUP,h.ms_electronics <> (TYPEOF(h.ms_electronics))'');
    populated_ms_electronics_pcnt := AVE(GROUP,IF(h.ms_electronics = (TYPEOF(h.ms_electronics))'',0,100));
    maxlength_ms_electronics := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_electronics)));
    avelength_ms_electronics := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_electronics)),h.ms_electronics<>(typeof(h.ms_electronics))'');
    populated_ms_equestrian_cnt := COUNT(GROUP,h.ms_equestrian <> (TYPEOF(h.ms_equestrian))'');
    populated_ms_equestrian_pcnt := AVE(GROUP,IF(h.ms_equestrian = (TYPEOF(h.ms_equestrian))'',0,100));
    maxlength_ms_equestrian := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_equestrian)));
    avelength_ms_equestrian := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_equestrian)),h.ms_equestrian<>(typeof(h.ms_equestrian))'');
    populated_ms_pub_family_cnt := COUNT(GROUP,h.ms_pub_family <> (TYPEOF(h.ms_pub_family))'');
    populated_ms_pub_family_pcnt := AVE(GROUP,IF(h.ms_pub_family = (TYPEOF(h.ms_pub_family))'',0,100));
    maxlength_ms_pub_family := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_family)));
    avelength_ms_pub_family := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_family)),h.ms_pub_family<>(typeof(h.ms_pub_family))'');
    populated_ms_cat_family_cnt := COUNT(GROUP,h.ms_cat_family <> (TYPEOF(h.ms_cat_family))'');
    populated_ms_cat_family_pcnt := AVE(GROUP,IF(h.ms_cat_family = (TYPEOF(h.ms_cat_family))'',0,100));
    maxlength_ms_cat_family := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_family)));
    avelength_ms_cat_family := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_family)),h.ms_cat_family<>(typeof(h.ms_cat_family))'');
    populated_ms_family_cnt := COUNT(GROUP,h.ms_family <> (TYPEOF(h.ms_family))'');
    populated_ms_family_pcnt := AVE(GROUP,IF(h.ms_family = (TYPEOF(h.ms_family))'',0,100));
    maxlength_ms_family := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family)));
    avelength_ms_family := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family)),h.ms_family<>(typeof(h.ms_family))'');
    populated_ms_family_lmos_cnt := COUNT(GROUP,h.ms_family_lmos <> (TYPEOF(h.ms_family_lmos))'');
    populated_ms_family_lmos_pcnt := AVE(GROUP,IF(h.ms_family_lmos = (TYPEOF(h.ms_family_lmos))'',0,100));
    maxlength_ms_family_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_lmos)));
    avelength_ms_family_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_lmos)),h.ms_family_lmos<>(typeof(h.ms_family_lmos))'');
    populated_ms_family_omos_cnt := COUNT(GROUP,h.ms_family_omos <> (TYPEOF(h.ms_family_omos))'');
    populated_ms_family_omos_pcnt := AVE(GROUP,IF(h.ms_family_omos = (TYPEOF(h.ms_family_omos))'',0,100));
    maxlength_ms_family_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_omos)));
    avelength_ms_family_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_omos)),h.ms_family_omos<>(typeof(h.ms_family_omos))'');
    populated_ms_family_pmos_cnt := COUNT(GROUP,h.ms_family_pmos <> (TYPEOF(h.ms_family_pmos))'');
    populated_ms_family_pmos_pcnt := AVE(GROUP,IF(h.ms_family_pmos = (TYPEOF(h.ms_family_pmos))'',0,100));
    maxlength_ms_family_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_pmos)));
    avelength_ms_family_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_pmos)),h.ms_family_pmos<>(typeof(h.ms_family_pmos))'');
    populated_ms_family_totords_cnt := COUNT(GROUP,h.ms_family_totords <> (TYPEOF(h.ms_family_totords))'');
    populated_ms_family_totords_pcnt := AVE(GROUP,IF(h.ms_family_totords = (TYPEOF(h.ms_family_totords))'',0,100));
    maxlength_ms_family_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_totords)));
    avelength_ms_family_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_totords)),h.ms_family_totords<>(typeof(h.ms_family_totords))'');
    populated_ms_family_totitems_cnt := COUNT(GROUP,h.ms_family_totitems <> (TYPEOF(h.ms_family_totitems))'');
    populated_ms_family_totitems_pcnt := AVE(GROUP,IF(h.ms_family_totitems = (TYPEOF(h.ms_family_totitems))'',0,100));
    maxlength_ms_family_totitems := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_totitems)));
    avelength_ms_family_totitems := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_totitems)),h.ms_family_totitems<>(typeof(h.ms_family_totitems))'');
    populated_ms_family_totdlrs_cnt := COUNT(GROUP,h.ms_family_totdlrs <> (TYPEOF(h.ms_family_totdlrs))'');
    populated_ms_family_totdlrs_pcnt := AVE(GROUP,IF(h.ms_family_totdlrs = (TYPEOF(h.ms_family_totdlrs))'',0,100));
    maxlength_ms_family_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_totdlrs)));
    avelength_ms_family_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_totdlrs)),h.ms_family_totdlrs<>(typeof(h.ms_family_totdlrs))'');
    populated_ms_family_avgdlrs_cnt := COUNT(GROUP,h.ms_family_avgdlrs <> (TYPEOF(h.ms_family_avgdlrs))'');
    populated_ms_family_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_family_avgdlrs = (TYPEOF(h.ms_family_avgdlrs))'',0,100));
    maxlength_ms_family_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_avgdlrs)));
    avelength_ms_family_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_avgdlrs)),h.ms_family_avgdlrs<>(typeof(h.ms_family_avgdlrs))'');
    populated_ms_family_lastdlrs_cnt := COUNT(GROUP,h.ms_family_lastdlrs <> (TYPEOF(h.ms_family_lastdlrs))'');
    populated_ms_family_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_family_lastdlrs = (TYPEOF(h.ms_family_lastdlrs))'',0,100));
    maxlength_ms_family_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_lastdlrs)));
    avelength_ms_family_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_lastdlrs)),h.ms_family_lastdlrs<>(typeof(h.ms_family_lastdlrs))'');
    populated_ms_family_paystat_paid_cnt := COUNT(GROUP,h.ms_family_paystat_paid <> (TYPEOF(h.ms_family_paystat_paid))'');
    populated_ms_family_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_family_paystat_paid = (TYPEOF(h.ms_family_paystat_paid))'',0,100));
    maxlength_ms_family_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_paystat_paid)));
    avelength_ms_family_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_paystat_paid)),h.ms_family_paystat_paid<>(typeof(h.ms_family_paystat_paid))'');
    populated_ms_family_paymeth_cc_cnt := COUNT(GROUP,h.ms_family_paymeth_cc <> (TYPEOF(h.ms_family_paymeth_cc))'');
    populated_ms_family_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_family_paymeth_cc = (TYPEOF(h.ms_family_paymeth_cc))'',0,100));
    maxlength_ms_family_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_paymeth_cc)));
    avelength_ms_family_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_paymeth_cc)),h.ms_family_paymeth_cc<>(typeof(h.ms_family_paymeth_cc))'');
    populated_ms_family_paymeth_cash_cnt := COUNT(GROUP,h.ms_family_paymeth_cash <> (TYPEOF(h.ms_family_paymeth_cash))'');
    populated_ms_family_paymeth_cash_pcnt := AVE(GROUP,IF(h.ms_family_paymeth_cash = (TYPEOF(h.ms_family_paymeth_cash))'',0,100));
    maxlength_ms_family_paymeth_cash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_paymeth_cash)));
    avelength_ms_family_paymeth_cash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_paymeth_cash)),h.ms_family_paymeth_cash<>(typeof(h.ms_family_paymeth_cash))'');
    populated_ms_family_osrc_dm_cnt := COUNT(GROUP,h.ms_family_osrc_dm <> (TYPEOF(h.ms_family_osrc_dm))'');
    populated_ms_family_osrc_dm_pcnt := AVE(GROUP,IF(h.ms_family_osrc_dm = (TYPEOF(h.ms_family_osrc_dm))'',0,100));
    maxlength_ms_family_osrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_osrc_dm)));
    avelength_ms_family_osrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_osrc_dm)),h.ms_family_osrc_dm<>(typeof(h.ms_family_osrc_dm))'');
    populated_ms_family_lsrc_dm_cnt := COUNT(GROUP,h.ms_family_lsrc_dm <> (TYPEOF(h.ms_family_lsrc_dm))'');
    populated_ms_family_lsrc_dm_pcnt := AVE(GROUP,IF(h.ms_family_lsrc_dm = (TYPEOF(h.ms_family_lsrc_dm))'',0,100));
    maxlength_ms_family_lsrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_lsrc_dm)));
    avelength_ms_family_lsrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_family_lsrc_dm)),h.ms_family_lsrc_dm<>(typeof(h.ms_family_lsrc_dm))'');
    populated_ms_fiction_cnt := COUNT(GROUP,h.ms_fiction <> (TYPEOF(h.ms_fiction))'');
    populated_ms_fiction_pcnt := AVE(GROUP,IF(h.ms_fiction = (TYPEOF(h.ms_fiction))'',0,100));
    maxlength_ms_fiction := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fiction)));
    avelength_ms_fiction := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fiction)),h.ms_fiction<>(typeof(h.ms_fiction))'');
    populated_ms_food_cnt := COUNT(GROUP,h.ms_food <> (TYPEOF(h.ms_food))'');
    populated_ms_food_pcnt := AVE(GROUP,IF(h.ms_food = (TYPEOF(h.ms_food))'',0,100));
    maxlength_ms_food := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_food)));
    avelength_ms_food := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_food)),h.ms_food<>(typeof(h.ms_food))'');
    populated_ms_games_cnt := COUNT(GROUP,h.ms_games <> (TYPEOF(h.ms_games))'');
    populated_ms_games_pcnt := AVE(GROUP,IF(h.ms_games = (TYPEOF(h.ms_games))'',0,100));
    maxlength_ms_games := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_games)));
    avelength_ms_games := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_games)),h.ms_games<>(typeof(h.ms_games))'');
    populated_ms_gifts_cnt := COUNT(GROUP,h.ms_gifts <> (TYPEOF(h.ms_gifts))'');
    populated_ms_gifts_pcnt := AVE(GROUP,IF(h.ms_gifts = (TYPEOF(h.ms_gifts))'',0,100));
    maxlength_ms_gifts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_gifts)));
    avelength_ms_gifts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_gifts)),h.ms_gifts<>(typeof(h.ms_gifts))'');
    populated_ms_gourmet_cnt := COUNT(GROUP,h.ms_gourmet <> (TYPEOF(h.ms_gourmet))'');
    populated_ms_gourmet_pcnt := AVE(GROUP,IF(h.ms_gourmet = (TYPEOF(h.ms_gourmet))'',0,100));
    maxlength_ms_gourmet := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_gourmet)));
    avelength_ms_gourmet := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_gourmet)),h.ms_gourmet<>(typeof(h.ms_gourmet))'');
    populated_ms_fitness_cnt := COUNT(GROUP,h.ms_fitness <> (TYPEOF(h.ms_fitness))'');
    populated_ms_fitness_pcnt := AVE(GROUP,IF(h.ms_fitness = (TYPEOF(h.ms_fitness))'',0,100));
    maxlength_ms_fitness := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fitness)));
    avelength_ms_fitness := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fitness)),h.ms_fitness<>(typeof(h.ms_fitness))'');
    populated_ms_health_cnt := COUNT(GROUP,h.ms_health <> (TYPEOF(h.ms_health))'');
    populated_ms_health_pcnt := AVE(GROUP,IF(h.ms_health = (TYPEOF(h.ms_health))'',0,100));
    maxlength_ms_health := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_health)));
    avelength_ms_health := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_health)),h.ms_health<>(typeof(h.ms_health))'');
    populated_ms_hlth_lmos_cnt := COUNT(GROUP,h.ms_hlth_lmos <> (TYPEOF(h.ms_hlth_lmos))'');
    populated_ms_hlth_lmos_pcnt := AVE(GROUP,IF(h.ms_hlth_lmos = (TYPEOF(h.ms_hlth_lmos))'',0,100));
    maxlength_ms_hlth_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lmos)));
    avelength_ms_hlth_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lmos)),h.ms_hlth_lmos<>(typeof(h.ms_hlth_lmos))'');
    populated_ms_hlth_omos_cnt := COUNT(GROUP,h.ms_hlth_omos <> (TYPEOF(h.ms_hlth_omos))'');
    populated_ms_hlth_omos_pcnt := AVE(GROUP,IF(h.ms_hlth_omos = (TYPEOF(h.ms_hlth_omos))'',0,100));
    maxlength_ms_hlth_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_omos)));
    avelength_ms_hlth_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_omos)),h.ms_hlth_omos<>(typeof(h.ms_hlth_omos))'');
    populated_ms_hlth_pmos_cnt := COUNT(GROUP,h.ms_hlth_pmos <> (TYPEOF(h.ms_hlth_pmos))'');
    populated_ms_hlth_pmos_pcnt := AVE(GROUP,IF(h.ms_hlth_pmos = (TYPEOF(h.ms_hlth_pmos))'',0,100));
    maxlength_ms_hlth_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_pmos)));
    avelength_ms_hlth_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_pmos)),h.ms_hlth_pmos<>(typeof(h.ms_hlth_pmos))'');
    populated_ms_hlth_totords_cnt := COUNT(GROUP,h.ms_hlth_totords <> (TYPEOF(h.ms_hlth_totords))'');
    populated_ms_hlth_totords_pcnt := AVE(GROUP,IF(h.ms_hlth_totords = (TYPEOF(h.ms_hlth_totords))'',0,100));
    maxlength_ms_hlth_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_totords)));
    avelength_ms_hlth_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_totords)),h.ms_hlth_totords<>(typeof(h.ms_hlth_totords))'');
    populated_ms_hlth_totdlrs_cnt := COUNT(GROUP,h.ms_hlth_totdlrs <> (TYPEOF(h.ms_hlth_totdlrs))'');
    populated_ms_hlth_totdlrs_pcnt := AVE(GROUP,IF(h.ms_hlth_totdlrs = (TYPEOF(h.ms_hlth_totdlrs))'',0,100));
    maxlength_ms_hlth_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_totdlrs)));
    avelength_ms_hlth_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_totdlrs)),h.ms_hlth_totdlrs<>(typeof(h.ms_hlth_totdlrs))'');
    populated_ms_hlth_avgdlrs_cnt := COUNT(GROUP,h.ms_hlth_avgdlrs <> (TYPEOF(h.ms_hlth_avgdlrs))'');
    populated_ms_hlth_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_hlth_avgdlrs = (TYPEOF(h.ms_hlth_avgdlrs))'',0,100));
    maxlength_ms_hlth_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_avgdlrs)));
    avelength_ms_hlth_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_avgdlrs)),h.ms_hlth_avgdlrs<>(typeof(h.ms_hlth_avgdlrs))'');
    populated_ms_hlth_lastdlrs_cnt := COUNT(GROUP,h.ms_hlth_lastdlrs <> (TYPEOF(h.ms_hlth_lastdlrs))'');
    populated_ms_hlth_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_hlth_lastdlrs = (TYPEOF(h.ms_hlth_lastdlrs))'',0,100));
    maxlength_ms_hlth_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lastdlrs)));
    avelength_ms_hlth_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lastdlrs)),h.ms_hlth_lastdlrs<>(typeof(h.ms_hlth_lastdlrs))'');
    populated_ms_hlth_paystat_paid_cnt := COUNT(GROUP,h.ms_hlth_paystat_paid <> (TYPEOF(h.ms_hlth_paystat_paid))'');
    populated_ms_hlth_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_hlth_paystat_paid = (TYPEOF(h.ms_hlth_paystat_paid))'',0,100));
    maxlength_ms_hlth_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_paystat_paid)));
    avelength_ms_hlth_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_paystat_paid)),h.ms_hlth_paystat_paid<>(typeof(h.ms_hlth_paystat_paid))'');
    populated_ms_hlth_paymeth_cc_cnt := COUNT(GROUP,h.ms_hlth_paymeth_cc <> (TYPEOF(h.ms_hlth_paymeth_cc))'');
    populated_ms_hlth_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_hlth_paymeth_cc = (TYPEOF(h.ms_hlth_paymeth_cc))'',0,100));
    maxlength_ms_hlth_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_paymeth_cc)));
    avelength_ms_hlth_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_paymeth_cc)),h.ms_hlth_paymeth_cc<>(typeof(h.ms_hlth_paymeth_cc))'');
    populated_ms_hlth_osrc_dm_cnt := COUNT(GROUP,h.ms_hlth_osrc_dm <> (TYPEOF(h.ms_hlth_osrc_dm))'');
    populated_ms_hlth_osrc_dm_pcnt := AVE(GROUP,IF(h.ms_hlth_osrc_dm = (TYPEOF(h.ms_hlth_osrc_dm))'',0,100));
    maxlength_ms_hlth_osrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_osrc_dm)));
    avelength_ms_hlth_osrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_osrc_dm)),h.ms_hlth_osrc_dm<>(typeof(h.ms_hlth_osrc_dm))'');
    populated_ms_hlth_lsrc_dm_cnt := COUNT(GROUP,h.ms_hlth_lsrc_dm <> (TYPEOF(h.ms_hlth_lsrc_dm))'');
    populated_ms_hlth_lsrc_dm_pcnt := AVE(GROUP,IF(h.ms_hlth_lsrc_dm = (TYPEOF(h.ms_hlth_lsrc_dm))'',0,100));
    maxlength_ms_hlth_lsrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lsrc_dm)));
    avelength_ms_hlth_lsrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lsrc_dm)),h.ms_hlth_lsrc_dm<>(typeof(h.ms_hlth_lsrc_dm))'');
    populated_ms_hlth_osrc_agt_cnt := COUNT(GROUP,h.ms_hlth_osrc_agt <> (TYPEOF(h.ms_hlth_osrc_agt))'');
    populated_ms_hlth_osrc_agt_pcnt := AVE(GROUP,IF(h.ms_hlth_osrc_agt = (TYPEOF(h.ms_hlth_osrc_agt))'',0,100));
    maxlength_ms_hlth_osrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_osrc_agt)));
    avelength_ms_hlth_osrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_osrc_agt)),h.ms_hlth_osrc_agt<>(typeof(h.ms_hlth_osrc_agt))'');
    populated_ms_hlth_lsrc_agt_cnt := COUNT(GROUP,h.ms_hlth_lsrc_agt <> (TYPEOF(h.ms_hlth_lsrc_agt))'');
    populated_ms_hlth_lsrc_agt_pcnt := AVE(GROUP,IF(h.ms_hlth_lsrc_agt = (TYPEOF(h.ms_hlth_lsrc_agt))'',0,100));
    maxlength_ms_hlth_lsrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lsrc_agt)));
    avelength_ms_hlth_lsrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lsrc_agt)),h.ms_hlth_lsrc_agt<>(typeof(h.ms_hlth_lsrc_agt))'');
    populated_ms_hlth_osrc_tv_cnt := COUNT(GROUP,h.ms_hlth_osrc_tv <> (TYPEOF(h.ms_hlth_osrc_tv))'');
    populated_ms_hlth_osrc_tv_pcnt := AVE(GROUP,IF(h.ms_hlth_osrc_tv = (TYPEOF(h.ms_hlth_osrc_tv))'',0,100));
    maxlength_ms_hlth_osrc_tv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_osrc_tv)));
    avelength_ms_hlth_osrc_tv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_osrc_tv)),h.ms_hlth_osrc_tv<>(typeof(h.ms_hlth_osrc_tv))'');
    populated_ms_hlth_lsrc_tv_cnt := COUNT(GROUP,h.ms_hlth_lsrc_tv <> (TYPEOF(h.ms_hlth_lsrc_tv))'');
    populated_ms_hlth_lsrc_tv_pcnt := AVE(GROUP,IF(h.ms_hlth_lsrc_tv = (TYPEOF(h.ms_hlth_lsrc_tv))'',0,100));
    maxlength_ms_hlth_lsrc_tv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lsrc_tv)));
    avelength_ms_hlth_lsrc_tv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hlth_lsrc_tv)),h.ms_hlth_lsrc_tv<>(typeof(h.ms_hlth_lsrc_tv))'');
    populated_ms_holiday_cnt := COUNT(GROUP,h.ms_holiday <> (TYPEOF(h.ms_holiday))'');
    populated_ms_holiday_pcnt := AVE(GROUP,IF(h.ms_holiday = (TYPEOF(h.ms_holiday))'',0,100));
    maxlength_ms_holiday := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_holiday)));
    avelength_ms_holiday := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_holiday)),h.ms_holiday<>(typeof(h.ms_holiday))'');
    populated_ms_history_cnt := COUNT(GROUP,h.ms_history <> (TYPEOF(h.ms_history))'');
    populated_ms_history_pcnt := AVE(GROUP,IF(h.ms_history = (TYPEOF(h.ms_history))'',0,100));
    maxlength_ms_history := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_history)));
    avelength_ms_history := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_history)),h.ms_history<>(typeof(h.ms_history))'');
    populated_ms_pub_cooking_cnt := COUNT(GROUP,h.ms_pub_cooking <> (TYPEOF(h.ms_pub_cooking))'');
    populated_ms_pub_cooking_pcnt := AVE(GROUP,IF(h.ms_pub_cooking = (TYPEOF(h.ms_pub_cooking))'',0,100));
    maxlength_ms_pub_cooking := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_cooking)));
    avelength_ms_pub_cooking := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_cooking)),h.ms_pub_cooking<>(typeof(h.ms_pub_cooking))'');
    populated_ms_cooking_cnt := COUNT(GROUP,h.ms_cooking <> (TYPEOF(h.ms_cooking))'');
    populated_ms_cooking_pcnt := AVE(GROUP,IF(h.ms_cooking = (TYPEOF(h.ms_cooking))'',0,100));
    maxlength_ms_cooking := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cooking)));
    avelength_ms_cooking := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cooking)),h.ms_cooking<>(typeof(h.ms_cooking))'');
    populated_ms_pub_homedecr_cnt := COUNT(GROUP,h.ms_pub_homedecr <> (TYPEOF(h.ms_pub_homedecr))'');
    populated_ms_pub_homedecr_pcnt := AVE(GROUP,IF(h.ms_pub_homedecr = (TYPEOF(h.ms_pub_homedecr))'',0,100));
    maxlength_ms_pub_homedecr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_homedecr)));
    avelength_ms_pub_homedecr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_homedecr)),h.ms_pub_homedecr<>(typeof(h.ms_pub_homedecr))'');
    populated_ms_cat_homedecr_cnt := COUNT(GROUP,h.ms_cat_homedecr <> (TYPEOF(h.ms_cat_homedecr))'');
    populated_ms_cat_homedecr_pcnt := AVE(GROUP,IF(h.ms_cat_homedecr = (TYPEOF(h.ms_cat_homedecr))'',0,100));
    maxlength_ms_cat_homedecr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_homedecr)));
    avelength_ms_cat_homedecr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_homedecr)),h.ms_cat_homedecr<>(typeof(h.ms_cat_homedecr))'');
    populated_ms_homedecr_cnt := COUNT(GROUP,h.ms_homedecr <> (TYPEOF(h.ms_homedecr))'');
    populated_ms_homedecr_pcnt := AVE(GROUP,IF(h.ms_homedecr = (TYPEOF(h.ms_homedecr))'',0,100));
    maxlength_ms_homedecr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_homedecr)));
    avelength_ms_homedecr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_homedecr)),h.ms_homedecr<>(typeof(h.ms_homedecr))'');
    populated_ms_housewares_cnt := COUNT(GROUP,h.ms_housewares <> (TYPEOF(h.ms_housewares))'');
    populated_ms_housewares_pcnt := AVE(GROUP,IF(h.ms_housewares = (TYPEOF(h.ms_housewares))'',0,100));
    maxlength_ms_housewares := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_housewares)));
    avelength_ms_housewares := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_housewares)),h.ms_housewares<>(typeof(h.ms_housewares))'');
    populated_ms_pub_garden_cnt := COUNT(GROUP,h.ms_pub_garden <> (TYPEOF(h.ms_pub_garden))'');
    populated_ms_pub_garden_pcnt := AVE(GROUP,IF(h.ms_pub_garden = (TYPEOF(h.ms_pub_garden))'',0,100));
    maxlength_ms_pub_garden := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_garden)));
    avelength_ms_pub_garden := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_garden)),h.ms_pub_garden<>(typeof(h.ms_pub_garden))'');
    populated_ms_cat_garden_cnt := COUNT(GROUP,h.ms_cat_garden <> (TYPEOF(h.ms_cat_garden))'');
    populated_ms_cat_garden_pcnt := AVE(GROUP,IF(h.ms_cat_garden = (TYPEOF(h.ms_cat_garden))'',0,100));
    maxlength_ms_cat_garden := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_garden)));
    avelength_ms_cat_garden := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_garden)),h.ms_cat_garden<>(typeof(h.ms_cat_garden))'');
    populated_ms_garden_cnt := COUNT(GROUP,h.ms_garden <> (TYPEOF(h.ms_garden))'');
    populated_ms_garden_pcnt := AVE(GROUP,IF(h.ms_garden = (TYPEOF(h.ms_garden))'',0,100));
    maxlength_ms_garden := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_garden)));
    avelength_ms_garden := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_garden)),h.ms_garden<>(typeof(h.ms_garden))'');
    populated_ms_pub_homeliv_cnt := COUNT(GROUP,h.ms_pub_homeliv <> (TYPEOF(h.ms_pub_homeliv))'');
    populated_ms_pub_homeliv_pcnt := AVE(GROUP,IF(h.ms_pub_homeliv = (TYPEOF(h.ms_pub_homeliv))'',0,100));
    maxlength_ms_pub_homeliv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_homeliv)));
    avelength_ms_pub_homeliv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_homeliv)),h.ms_pub_homeliv<>(typeof(h.ms_pub_homeliv))'');
    populated_ms_cat_homeliv_cnt := COUNT(GROUP,h.ms_cat_homeliv <> (TYPEOF(h.ms_cat_homeliv))'');
    populated_ms_cat_homeliv_pcnt := AVE(GROUP,IF(h.ms_cat_homeliv = (TYPEOF(h.ms_cat_homeliv))'',0,100));
    maxlength_ms_cat_homeliv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_homeliv)));
    avelength_ms_cat_homeliv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_homeliv)),h.ms_cat_homeliv<>(typeof(h.ms_cat_homeliv))'');
    populated_ms_homeliv_cnt := COUNT(GROUP,h.ms_homeliv <> (TYPEOF(h.ms_homeliv))'');
    populated_ms_homeliv_pcnt := AVE(GROUP,IF(h.ms_homeliv = (TYPEOF(h.ms_homeliv))'',0,100));
    maxlength_ms_homeliv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_homeliv)));
    avelength_ms_homeliv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_homeliv)),h.ms_homeliv<>(typeof(h.ms_homeliv))'');
    populated_ms_pub_home_status_active_cnt := COUNT(GROUP,h.ms_pub_home_status_active <> (TYPEOF(h.ms_pub_home_status_active))'');
    populated_ms_pub_home_status_active_pcnt := AVE(GROUP,IF(h.ms_pub_home_status_active = (TYPEOF(h.ms_pub_home_status_active))'',0,100));
    maxlength_ms_pub_home_status_active := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_home_status_active)));
    avelength_ms_pub_home_status_active := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_home_status_active)),h.ms_pub_home_status_active<>(typeof(h.ms_pub_home_status_active))'');
    populated_ms_home_lmos_cnt := COUNT(GROUP,h.ms_home_lmos <> (TYPEOF(h.ms_home_lmos))'');
    populated_ms_home_lmos_pcnt := AVE(GROUP,IF(h.ms_home_lmos = (TYPEOF(h.ms_home_lmos))'',0,100));
    maxlength_ms_home_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lmos)));
    avelength_ms_home_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lmos)),h.ms_home_lmos<>(typeof(h.ms_home_lmos))'');
    populated_ms_home_omos_cnt := COUNT(GROUP,h.ms_home_omos <> (TYPEOF(h.ms_home_omos))'');
    populated_ms_home_omos_pcnt := AVE(GROUP,IF(h.ms_home_omos = (TYPEOF(h.ms_home_omos))'',0,100));
    maxlength_ms_home_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_omos)));
    avelength_ms_home_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_omos)),h.ms_home_omos<>(typeof(h.ms_home_omos))'');
    populated_ms_home_pmos_cnt := COUNT(GROUP,h.ms_home_pmos <> (TYPEOF(h.ms_home_pmos))'');
    populated_ms_home_pmos_pcnt := AVE(GROUP,IF(h.ms_home_pmos = (TYPEOF(h.ms_home_pmos))'',0,100));
    maxlength_ms_home_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_pmos)));
    avelength_ms_home_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_pmos)),h.ms_home_pmos<>(typeof(h.ms_home_pmos))'');
    populated_ms_home_totords_cnt := COUNT(GROUP,h.ms_home_totords <> (TYPEOF(h.ms_home_totords))'');
    populated_ms_home_totords_pcnt := AVE(GROUP,IF(h.ms_home_totords = (TYPEOF(h.ms_home_totords))'',0,100));
    maxlength_ms_home_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_totords)));
    avelength_ms_home_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_totords)),h.ms_home_totords<>(typeof(h.ms_home_totords))'');
    populated_ms_home_totitems_cnt := COUNT(GROUP,h.ms_home_totitems <> (TYPEOF(h.ms_home_totitems))'');
    populated_ms_home_totitems_pcnt := AVE(GROUP,IF(h.ms_home_totitems = (TYPEOF(h.ms_home_totitems))'',0,100));
    maxlength_ms_home_totitems := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_totitems)));
    avelength_ms_home_totitems := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_totitems)),h.ms_home_totitems<>(typeof(h.ms_home_totitems))'');
    populated_ms_home_totdlrs_cnt := COUNT(GROUP,h.ms_home_totdlrs <> (TYPEOF(h.ms_home_totdlrs))'');
    populated_ms_home_totdlrs_pcnt := AVE(GROUP,IF(h.ms_home_totdlrs = (TYPEOF(h.ms_home_totdlrs))'',0,100));
    maxlength_ms_home_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_totdlrs)));
    avelength_ms_home_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_totdlrs)),h.ms_home_totdlrs<>(typeof(h.ms_home_totdlrs))'');
    populated_ms_home_avgdlrs_cnt := COUNT(GROUP,h.ms_home_avgdlrs <> (TYPEOF(h.ms_home_avgdlrs))'');
    populated_ms_home_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_home_avgdlrs = (TYPEOF(h.ms_home_avgdlrs))'',0,100));
    maxlength_ms_home_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_avgdlrs)));
    avelength_ms_home_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_avgdlrs)),h.ms_home_avgdlrs<>(typeof(h.ms_home_avgdlrs))'');
    populated_ms_home_lastdlrs_cnt := COUNT(GROUP,h.ms_home_lastdlrs <> (TYPEOF(h.ms_home_lastdlrs))'');
    populated_ms_home_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_home_lastdlrs = (TYPEOF(h.ms_home_lastdlrs))'',0,100));
    maxlength_ms_home_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lastdlrs)));
    avelength_ms_home_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lastdlrs)),h.ms_home_lastdlrs<>(typeof(h.ms_home_lastdlrs))'');
    populated_ms_home_paystat_paid_cnt := COUNT(GROUP,h.ms_home_paystat_paid <> (TYPEOF(h.ms_home_paystat_paid))'');
    populated_ms_home_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_home_paystat_paid = (TYPEOF(h.ms_home_paystat_paid))'',0,100));
    maxlength_ms_home_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_paystat_paid)));
    avelength_ms_home_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_paystat_paid)),h.ms_home_paystat_paid<>(typeof(h.ms_home_paystat_paid))'');
    populated_ms_home_paymeth_cc_cnt := COUNT(GROUP,h.ms_home_paymeth_cc <> (TYPEOF(h.ms_home_paymeth_cc))'');
    populated_ms_home_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_home_paymeth_cc = (TYPEOF(h.ms_home_paymeth_cc))'',0,100));
    maxlength_ms_home_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_paymeth_cc)));
    avelength_ms_home_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_paymeth_cc)),h.ms_home_paymeth_cc<>(typeof(h.ms_home_paymeth_cc))'');
    populated_ms_home_paymeth_cash_cnt := COUNT(GROUP,h.ms_home_paymeth_cash <> (TYPEOF(h.ms_home_paymeth_cash))'');
    populated_ms_home_paymeth_cash_pcnt := AVE(GROUP,IF(h.ms_home_paymeth_cash = (TYPEOF(h.ms_home_paymeth_cash))'',0,100));
    maxlength_ms_home_paymeth_cash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_paymeth_cash)));
    avelength_ms_home_paymeth_cash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_paymeth_cash)),h.ms_home_paymeth_cash<>(typeof(h.ms_home_paymeth_cash))'');
    populated_ms_home_osrc_dm_cnt := COUNT(GROUP,h.ms_home_osrc_dm <> (TYPEOF(h.ms_home_osrc_dm))'');
    populated_ms_home_osrc_dm_pcnt := AVE(GROUP,IF(h.ms_home_osrc_dm = (TYPEOF(h.ms_home_osrc_dm))'',0,100));
    maxlength_ms_home_osrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_osrc_dm)));
    avelength_ms_home_osrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_osrc_dm)),h.ms_home_osrc_dm<>(typeof(h.ms_home_osrc_dm))'');
    populated_ms_home_lsrc_dm_cnt := COUNT(GROUP,h.ms_home_lsrc_dm <> (TYPEOF(h.ms_home_lsrc_dm))'');
    populated_ms_home_lsrc_dm_pcnt := AVE(GROUP,IF(h.ms_home_lsrc_dm = (TYPEOF(h.ms_home_lsrc_dm))'',0,100));
    maxlength_ms_home_lsrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lsrc_dm)));
    avelength_ms_home_lsrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lsrc_dm)),h.ms_home_lsrc_dm<>(typeof(h.ms_home_lsrc_dm))'');
    populated_ms_home_osrc_agt_cnt := COUNT(GROUP,h.ms_home_osrc_agt <> (TYPEOF(h.ms_home_osrc_agt))'');
    populated_ms_home_osrc_agt_pcnt := AVE(GROUP,IF(h.ms_home_osrc_agt = (TYPEOF(h.ms_home_osrc_agt))'',0,100));
    maxlength_ms_home_osrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_osrc_agt)));
    avelength_ms_home_osrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_osrc_agt)),h.ms_home_osrc_agt<>(typeof(h.ms_home_osrc_agt))'');
    populated_ms_home_lsrc_agt_cnt := COUNT(GROUP,h.ms_home_lsrc_agt <> (TYPEOF(h.ms_home_lsrc_agt))'');
    populated_ms_home_lsrc_agt_pcnt := AVE(GROUP,IF(h.ms_home_lsrc_agt = (TYPEOF(h.ms_home_lsrc_agt))'',0,100));
    maxlength_ms_home_lsrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lsrc_agt)));
    avelength_ms_home_lsrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lsrc_agt)),h.ms_home_lsrc_agt<>(typeof(h.ms_home_lsrc_agt))'');
    populated_ms_home_osrc_net_cnt := COUNT(GROUP,h.ms_home_osrc_net <> (TYPEOF(h.ms_home_osrc_net))'');
    populated_ms_home_osrc_net_pcnt := AVE(GROUP,IF(h.ms_home_osrc_net = (TYPEOF(h.ms_home_osrc_net))'',0,100));
    maxlength_ms_home_osrc_net := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_osrc_net)));
    avelength_ms_home_osrc_net := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_osrc_net)),h.ms_home_osrc_net<>(typeof(h.ms_home_osrc_net))'');
    populated_ms_home_lsrc_net_cnt := COUNT(GROUP,h.ms_home_lsrc_net <> (TYPEOF(h.ms_home_lsrc_net))'');
    populated_ms_home_lsrc_net_pcnt := AVE(GROUP,IF(h.ms_home_lsrc_net = (TYPEOF(h.ms_home_lsrc_net))'',0,100));
    maxlength_ms_home_lsrc_net := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lsrc_net)));
    avelength_ms_home_lsrc_net := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lsrc_net)),h.ms_home_lsrc_net<>(typeof(h.ms_home_lsrc_net))'');
    populated_ms_home_osrc_tv_cnt := COUNT(GROUP,h.ms_home_osrc_tv <> (TYPEOF(h.ms_home_osrc_tv))'');
    populated_ms_home_osrc_tv_pcnt := AVE(GROUP,IF(h.ms_home_osrc_tv = (TYPEOF(h.ms_home_osrc_tv))'',0,100));
    maxlength_ms_home_osrc_tv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_osrc_tv)));
    avelength_ms_home_osrc_tv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_osrc_tv)),h.ms_home_osrc_tv<>(typeof(h.ms_home_osrc_tv))'');
    populated_ms_home_lsrc_tv_cnt := COUNT(GROUP,h.ms_home_lsrc_tv <> (TYPEOF(h.ms_home_lsrc_tv))'');
    populated_ms_home_lsrc_tv_pcnt := AVE(GROUP,IF(h.ms_home_lsrc_tv = (TYPEOF(h.ms_home_lsrc_tv))'',0,100));
    maxlength_ms_home_lsrc_tv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lsrc_tv)));
    avelength_ms_home_lsrc_tv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_home_lsrc_tv)),h.ms_home_lsrc_tv<>(typeof(h.ms_home_lsrc_tv))'');
    populated_ms_humor_cnt := COUNT(GROUP,h.ms_humor <> (TYPEOF(h.ms_humor))'');
    populated_ms_humor_pcnt := AVE(GROUP,IF(h.ms_humor = (TYPEOF(h.ms_humor))'',0,100));
    maxlength_ms_humor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_humor)));
    avelength_ms_humor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_humor)),h.ms_humor<>(typeof(h.ms_humor))'');
    populated_ms_inspiration_cnt := COUNT(GROUP,h.ms_inspiration <> (TYPEOF(h.ms_inspiration))'');
    populated_ms_inspiration_pcnt := AVE(GROUP,IF(h.ms_inspiration = (TYPEOF(h.ms_inspiration))'',0,100));
    maxlength_ms_inspiration := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_inspiration)));
    avelength_ms_inspiration := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_inspiration)),h.ms_inspiration<>(typeof(h.ms_inspiration))'');
    populated_ms_merchandise_cnt := COUNT(GROUP,h.ms_merchandise <> (TYPEOF(h.ms_merchandise))'');
    populated_ms_merchandise_pcnt := AVE(GROUP,IF(h.ms_merchandise = (TYPEOF(h.ms_merchandise))'',0,100));
    maxlength_ms_merchandise := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_merchandise)));
    avelength_ms_merchandise := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_merchandise)),h.ms_merchandise<>(typeof(h.ms_merchandise))'');
    populated_ms_moneymaking_cnt := COUNT(GROUP,h.ms_moneymaking <> (TYPEOF(h.ms_moneymaking))'');
    populated_ms_moneymaking_pcnt := AVE(GROUP,IF(h.ms_moneymaking = (TYPEOF(h.ms_moneymaking))'',0,100));
    maxlength_ms_moneymaking := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_moneymaking)));
    avelength_ms_moneymaking := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_moneymaking)),h.ms_moneymaking<>(typeof(h.ms_moneymaking))'');
    populated_ms_moneymaking_lmos_cnt := COUNT(GROUP,h.ms_moneymaking_lmos <> (TYPEOF(h.ms_moneymaking_lmos))'');
    populated_ms_moneymaking_lmos_pcnt := AVE(GROUP,IF(h.ms_moneymaking_lmos = (TYPEOF(h.ms_moneymaking_lmos))'',0,100));
    maxlength_ms_moneymaking_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_moneymaking_lmos)));
    avelength_ms_moneymaking_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_moneymaking_lmos)),h.ms_moneymaking_lmos<>(typeof(h.ms_moneymaking_lmos))'');
    populated_ms_motorcycles_cnt := COUNT(GROUP,h.ms_motorcycles <> (TYPEOF(h.ms_motorcycles))'');
    populated_ms_motorcycles_pcnt := AVE(GROUP,IF(h.ms_motorcycles = (TYPEOF(h.ms_motorcycles))'',0,100));
    maxlength_ms_motorcycles := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_motorcycles)));
    avelength_ms_motorcycles := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_motorcycles)),h.ms_motorcycles<>(typeof(h.ms_motorcycles))'');
    populated_ms_music_cnt := COUNT(GROUP,h.ms_music <> (TYPEOF(h.ms_music))'');
    populated_ms_music_pcnt := AVE(GROUP,IF(h.ms_music = (TYPEOF(h.ms_music))'',0,100));
    maxlength_ms_music := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_music)));
    avelength_ms_music := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_music)),h.ms_music<>(typeof(h.ms_music))'');
    populated_ms_fishing_cnt := COUNT(GROUP,h.ms_fishing <> (TYPEOF(h.ms_fishing))'');
    populated_ms_fishing_pcnt := AVE(GROUP,IF(h.ms_fishing = (TYPEOF(h.ms_fishing))'',0,100));
    maxlength_ms_fishing := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fishing)));
    avelength_ms_fishing := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_fishing)),h.ms_fishing<>(typeof(h.ms_fishing))'');
    populated_ms_hunting_cnt := COUNT(GROUP,h.ms_hunting <> (TYPEOF(h.ms_hunting))'');
    populated_ms_hunting_pcnt := AVE(GROUP,IF(h.ms_hunting = (TYPEOF(h.ms_hunting))'',0,100));
    maxlength_ms_hunting := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hunting)));
    avelength_ms_hunting := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_hunting)),h.ms_hunting<>(typeof(h.ms_hunting))'');
    populated_ms_boatsail_cnt := COUNT(GROUP,h.ms_boatsail <> (TYPEOF(h.ms_boatsail))'');
    populated_ms_boatsail_pcnt := AVE(GROUP,IF(h.ms_boatsail = (TYPEOF(h.ms_boatsail))'',0,100));
    maxlength_ms_boatsail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_boatsail)));
    avelength_ms_boatsail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_boatsail)),h.ms_boatsail<>(typeof(h.ms_boatsail))'');
    populated_ms_camp_cnt := COUNT(GROUP,h.ms_camp <> (TYPEOF(h.ms_camp))'');
    populated_ms_camp_pcnt := AVE(GROUP,IF(h.ms_camp = (TYPEOF(h.ms_camp))'',0,100));
    maxlength_ms_camp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_camp)));
    avelength_ms_camp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_camp)),h.ms_camp<>(typeof(h.ms_camp))'');
    populated_ms_pub_outdoors_cnt := COUNT(GROUP,h.ms_pub_outdoors <> (TYPEOF(h.ms_pub_outdoors))'');
    populated_ms_pub_outdoors_pcnt := AVE(GROUP,IF(h.ms_pub_outdoors = (TYPEOF(h.ms_pub_outdoors))'',0,100));
    maxlength_ms_pub_outdoors := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_outdoors)));
    avelength_ms_pub_outdoors := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_outdoors)),h.ms_pub_outdoors<>(typeof(h.ms_pub_outdoors))'');
    populated_ms_cat_outdoors_cnt := COUNT(GROUP,h.ms_cat_outdoors <> (TYPEOF(h.ms_cat_outdoors))'');
    populated_ms_cat_outdoors_pcnt := AVE(GROUP,IF(h.ms_cat_outdoors = (TYPEOF(h.ms_cat_outdoors))'',0,100));
    maxlength_ms_cat_outdoors := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_outdoors)));
    avelength_ms_cat_outdoors := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_cat_outdoors)),h.ms_cat_outdoors<>(typeof(h.ms_cat_outdoors))'');
    populated_ms_outdoors_cnt := COUNT(GROUP,h.ms_outdoors <> (TYPEOF(h.ms_outdoors))'');
    populated_ms_outdoors_pcnt := AVE(GROUP,IF(h.ms_outdoors = (TYPEOF(h.ms_outdoors))'',0,100));
    maxlength_ms_outdoors := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_outdoors)));
    avelength_ms_outdoors := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_outdoors)),h.ms_outdoors<>(typeof(h.ms_outdoors))'');
    populated_ms_pub_out_status_active_cnt := COUNT(GROUP,h.ms_pub_out_status_active <> (TYPEOF(h.ms_pub_out_status_active))'');
    populated_ms_pub_out_status_active_pcnt := AVE(GROUP,IF(h.ms_pub_out_status_active = (TYPEOF(h.ms_pub_out_status_active))'',0,100));
    maxlength_ms_pub_out_status_active := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_out_status_active)));
    avelength_ms_pub_out_status_active := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pub_out_status_active)),h.ms_pub_out_status_active<>(typeof(h.ms_pub_out_status_active))'');
    populated_ms_out_lmos_cnt := COUNT(GROUP,h.ms_out_lmos <> (TYPEOF(h.ms_out_lmos))'');
    populated_ms_out_lmos_pcnt := AVE(GROUP,IF(h.ms_out_lmos = (TYPEOF(h.ms_out_lmos))'',0,100));
    maxlength_ms_out_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_lmos)));
    avelength_ms_out_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_lmos)),h.ms_out_lmos<>(typeof(h.ms_out_lmos))'');
    populated_ms_out_omos_cnt := COUNT(GROUP,h.ms_out_omos <> (TYPEOF(h.ms_out_omos))'');
    populated_ms_out_omos_pcnt := AVE(GROUP,IF(h.ms_out_omos = (TYPEOF(h.ms_out_omos))'',0,100));
    maxlength_ms_out_omos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_omos)));
    avelength_ms_out_omos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_omos)),h.ms_out_omos<>(typeof(h.ms_out_omos))'');
    populated_ms_out_pmos_cnt := COUNT(GROUP,h.ms_out_pmos <> (TYPEOF(h.ms_out_pmos))'');
    populated_ms_out_pmos_pcnt := AVE(GROUP,IF(h.ms_out_pmos = (TYPEOF(h.ms_out_pmos))'',0,100));
    maxlength_ms_out_pmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_pmos)));
    avelength_ms_out_pmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_pmos)),h.ms_out_pmos<>(typeof(h.ms_out_pmos))'');
    populated_ms_out_totords_cnt := COUNT(GROUP,h.ms_out_totords <> (TYPEOF(h.ms_out_totords))'');
    populated_ms_out_totords_pcnt := AVE(GROUP,IF(h.ms_out_totords = (TYPEOF(h.ms_out_totords))'',0,100));
    maxlength_ms_out_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_totords)));
    avelength_ms_out_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_totords)),h.ms_out_totords<>(typeof(h.ms_out_totords))'');
    populated_ms_out_totitems_cnt := COUNT(GROUP,h.ms_out_totitems <> (TYPEOF(h.ms_out_totitems))'');
    populated_ms_out_totitems_pcnt := AVE(GROUP,IF(h.ms_out_totitems = (TYPEOF(h.ms_out_totitems))'',0,100));
    maxlength_ms_out_totitems := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_totitems)));
    avelength_ms_out_totitems := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_totitems)),h.ms_out_totitems<>(typeof(h.ms_out_totitems))'');
    populated_ms_out_totdlrs_cnt := COUNT(GROUP,h.ms_out_totdlrs <> (TYPEOF(h.ms_out_totdlrs))'');
    populated_ms_out_totdlrs_pcnt := AVE(GROUP,IF(h.ms_out_totdlrs = (TYPEOF(h.ms_out_totdlrs))'',0,100));
    maxlength_ms_out_totdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_totdlrs)));
    avelength_ms_out_totdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_totdlrs)),h.ms_out_totdlrs<>(typeof(h.ms_out_totdlrs))'');
    populated_ms_out_avgdlrs_cnt := COUNT(GROUP,h.ms_out_avgdlrs <> (TYPEOF(h.ms_out_avgdlrs))'');
    populated_ms_out_avgdlrs_pcnt := AVE(GROUP,IF(h.ms_out_avgdlrs = (TYPEOF(h.ms_out_avgdlrs))'',0,100));
    maxlength_ms_out_avgdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_avgdlrs)));
    avelength_ms_out_avgdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_avgdlrs)),h.ms_out_avgdlrs<>(typeof(h.ms_out_avgdlrs))'');
    populated_ms_out_lastdlrs_cnt := COUNT(GROUP,h.ms_out_lastdlrs <> (TYPEOF(h.ms_out_lastdlrs))'');
    populated_ms_out_lastdlrs_pcnt := AVE(GROUP,IF(h.ms_out_lastdlrs = (TYPEOF(h.ms_out_lastdlrs))'',0,100));
    maxlength_ms_out_lastdlrs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_lastdlrs)));
    avelength_ms_out_lastdlrs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_lastdlrs)),h.ms_out_lastdlrs<>(typeof(h.ms_out_lastdlrs))'');
    populated_ms_out_paystat_paid_cnt := COUNT(GROUP,h.ms_out_paystat_paid <> (TYPEOF(h.ms_out_paystat_paid))'');
    populated_ms_out_paystat_paid_pcnt := AVE(GROUP,IF(h.ms_out_paystat_paid = (TYPEOF(h.ms_out_paystat_paid))'',0,100));
    maxlength_ms_out_paystat_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_paystat_paid)));
    avelength_ms_out_paystat_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_paystat_paid)),h.ms_out_paystat_paid<>(typeof(h.ms_out_paystat_paid))'');
    populated_ms_out_paymeth_cc_cnt := COUNT(GROUP,h.ms_out_paymeth_cc <> (TYPEOF(h.ms_out_paymeth_cc))'');
    populated_ms_out_paymeth_cc_pcnt := AVE(GROUP,IF(h.ms_out_paymeth_cc = (TYPEOF(h.ms_out_paymeth_cc))'',0,100));
    maxlength_ms_out_paymeth_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_paymeth_cc)));
    avelength_ms_out_paymeth_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_paymeth_cc)),h.ms_out_paymeth_cc<>(typeof(h.ms_out_paymeth_cc))'');
    populated_ms_out_paymeth_cash_cnt := COUNT(GROUP,h.ms_out_paymeth_cash <> (TYPEOF(h.ms_out_paymeth_cash))'');
    populated_ms_out_paymeth_cash_pcnt := AVE(GROUP,IF(h.ms_out_paymeth_cash = (TYPEOF(h.ms_out_paymeth_cash))'',0,100));
    maxlength_ms_out_paymeth_cash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_paymeth_cash)));
    avelength_ms_out_paymeth_cash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_paymeth_cash)),h.ms_out_paymeth_cash<>(typeof(h.ms_out_paymeth_cash))'');
    populated_ms_out_osrc_dm_cnt := COUNT(GROUP,h.ms_out_osrc_dm <> (TYPEOF(h.ms_out_osrc_dm))'');
    populated_ms_out_osrc_dm_pcnt := AVE(GROUP,IF(h.ms_out_osrc_dm = (TYPEOF(h.ms_out_osrc_dm))'',0,100));
    maxlength_ms_out_osrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_osrc_dm)));
    avelength_ms_out_osrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_osrc_dm)),h.ms_out_osrc_dm<>(typeof(h.ms_out_osrc_dm))'');
    populated_ms_out_lsrc_dm_cnt := COUNT(GROUP,h.ms_out_lsrc_dm <> (TYPEOF(h.ms_out_lsrc_dm))'');
    populated_ms_out_lsrc_dm_pcnt := AVE(GROUP,IF(h.ms_out_lsrc_dm = (TYPEOF(h.ms_out_lsrc_dm))'',0,100));
    maxlength_ms_out_lsrc_dm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_lsrc_dm)));
    avelength_ms_out_lsrc_dm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_lsrc_dm)),h.ms_out_lsrc_dm<>(typeof(h.ms_out_lsrc_dm))'');
    populated_ms_out_osrc_agt_cnt := COUNT(GROUP,h.ms_out_osrc_agt <> (TYPEOF(h.ms_out_osrc_agt))'');
    populated_ms_out_osrc_agt_pcnt := AVE(GROUP,IF(h.ms_out_osrc_agt = (TYPEOF(h.ms_out_osrc_agt))'',0,100));
    maxlength_ms_out_osrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_osrc_agt)));
    avelength_ms_out_osrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_osrc_agt)),h.ms_out_osrc_agt<>(typeof(h.ms_out_osrc_agt))'');
    populated_ms_out_lsrc_agt_cnt := COUNT(GROUP,h.ms_out_lsrc_agt <> (TYPEOF(h.ms_out_lsrc_agt))'');
    populated_ms_out_lsrc_agt_pcnt := AVE(GROUP,IF(h.ms_out_lsrc_agt = (TYPEOF(h.ms_out_lsrc_agt))'',0,100));
    maxlength_ms_out_lsrc_agt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_lsrc_agt)));
    avelength_ms_out_lsrc_agt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_out_lsrc_agt)),h.ms_out_lsrc_agt<>(typeof(h.ms_out_lsrc_agt))'');
    populated_ms_pets_cnt := COUNT(GROUP,h.ms_pets <> (TYPEOF(h.ms_pets))'');
    populated_ms_pets_pcnt := AVE(GROUP,IF(h.ms_pets = (TYPEOF(h.ms_pets))'',0,100));
    maxlength_ms_pets := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pets)));
    avelength_ms_pets := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pets)),h.ms_pets<>(typeof(h.ms_pets))'');
    populated_ms_pfin_cnt := COUNT(GROUP,h.ms_pfin <> (TYPEOF(h.ms_pfin))'');
    populated_ms_pfin_pcnt := AVE(GROUP,IF(h.ms_pfin = (TYPEOF(h.ms_pfin))'',0,100));
    maxlength_ms_pfin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pfin)));
    avelength_ms_pfin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_pfin)),h.ms_pfin<>(typeof(h.ms_pfin))'');
    populated_ms_photo_cnt := COUNT(GROUP,h.ms_photo <> (TYPEOF(h.ms_photo))'');
    populated_ms_photo_pcnt := AVE(GROUP,IF(h.ms_photo = (TYPEOF(h.ms_photo))'',0,100));
    maxlength_ms_photo := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_photo)));
    avelength_ms_photo := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_photo)),h.ms_photo<>(typeof(h.ms_photo))'');
    populated_ms_photoproc_cnt := COUNT(GROUP,h.ms_photoproc <> (TYPEOF(h.ms_photoproc))'');
    populated_ms_photoproc_pcnt := AVE(GROUP,IF(h.ms_photoproc = (TYPEOF(h.ms_photoproc))'',0,100));
    maxlength_ms_photoproc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_photoproc)));
    avelength_ms_photoproc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_photoproc)),h.ms_photoproc<>(typeof(h.ms_photoproc))'');
    populated_ms_rural_cnt := COUNT(GROUP,h.ms_rural <> (TYPEOF(h.ms_rural))'');
    populated_ms_rural_pcnt := AVE(GROUP,IF(h.ms_rural = (TYPEOF(h.ms_rural))'',0,100));
    maxlength_ms_rural := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_rural)));
    avelength_ms_rural := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_rural)),h.ms_rural<>(typeof(h.ms_rural))'');
    populated_ms_science_cnt := COUNT(GROUP,h.ms_science <> (TYPEOF(h.ms_science))'');
    populated_ms_science_pcnt := AVE(GROUP,IF(h.ms_science = (TYPEOF(h.ms_science))'',0,100));
    maxlength_ms_science := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_science)));
    avelength_ms_science := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_science)),h.ms_science<>(typeof(h.ms_science))'');
    populated_ms_sports_cnt := COUNT(GROUP,h.ms_sports <> (TYPEOF(h.ms_sports))'');
    populated_ms_sports_pcnt := AVE(GROUP,IF(h.ms_sports = (TYPEOF(h.ms_sports))'',0,100));
    maxlength_ms_sports := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_sports)));
    avelength_ms_sports := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_sports)),h.ms_sports<>(typeof(h.ms_sports))'');
    populated_ms_sports_lmos_cnt := COUNT(GROUP,h.ms_sports_lmos <> (TYPEOF(h.ms_sports_lmos))'');
    populated_ms_sports_lmos_pcnt := AVE(GROUP,IF(h.ms_sports_lmos = (TYPEOF(h.ms_sports_lmos))'',0,100));
    maxlength_ms_sports_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_sports_lmos)));
    avelength_ms_sports_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_sports_lmos)),h.ms_sports_lmos<>(typeof(h.ms_sports_lmos))'');
    populated_ms_travel_cnt := COUNT(GROUP,h.ms_travel <> (TYPEOF(h.ms_travel))'');
    populated_ms_travel_pcnt := AVE(GROUP,IF(h.ms_travel = (TYPEOF(h.ms_travel))'',0,100));
    maxlength_ms_travel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_travel)));
    avelength_ms_travel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_travel)),h.ms_travel<>(typeof(h.ms_travel))'');
    populated_ms_tvmovies_cnt := COUNT(GROUP,h.ms_tvmovies <> (TYPEOF(h.ms_tvmovies))'');
    populated_ms_tvmovies_pcnt := AVE(GROUP,IF(h.ms_tvmovies = (TYPEOF(h.ms_tvmovies))'',0,100));
    maxlength_ms_tvmovies := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_tvmovies)));
    avelength_ms_tvmovies := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_tvmovies)),h.ms_tvmovies<>(typeof(h.ms_tvmovies))'');
    populated_ms_wildlife_cnt := COUNT(GROUP,h.ms_wildlife <> (TYPEOF(h.ms_wildlife))'');
    populated_ms_wildlife_pcnt := AVE(GROUP,IF(h.ms_wildlife = (TYPEOF(h.ms_wildlife))'',0,100));
    maxlength_ms_wildlife := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wildlife)));
    avelength_ms_wildlife := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_wildlife)),h.ms_wildlife<>(typeof(h.ms_wildlife))'');
    populated_ms_woman_cnt := COUNT(GROUP,h.ms_woman <> (TYPEOF(h.ms_woman))'');
    populated_ms_woman_pcnt := AVE(GROUP,IF(h.ms_woman = (TYPEOF(h.ms_woman))'',0,100));
    maxlength_ms_woman := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_woman)));
    avelength_ms_woman := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_woman)),h.ms_woman<>(typeof(h.ms_woman))'');
    populated_ms_woman_lmos_cnt := COUNT(GROUP,h.ms_woman_lmos <> (TYPEOF(h.ms_woman_lmos))'');
    populated_ms_woman_lmos_pcnt := AVE(GROUP,IF(h.ms_woman_lmos = (TYPEOF(h.ms_woman_lmos))'',0,100));
    maxlength_ms_woman_lmos := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_woman_lmos)));
    avelength_ms_woman_lmos := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_woman_lmos)),h.ms_woman_lmos<>(typeof(h.ms_woman_lmos))'');
    populated_ms_ringtones_apps_cnt := COUNT(GROUP,h.ms_ringtones_apps <> (TYPEOF(h.ms_ringtones_apps))'');
    populated_ms_ringtones_apps_pcnt := AVE(GROUP,IF(h.ms_ringtones_apps = (TYPEOF(h.ms_ringtones_apps))'',0,100));
    maxlength_ms_ringtones_apps := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_ringtones_apps)));
    avelength_ms_ringtones_apps := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ms_ringtones_apps)),h.ms_ringtones_apps<>(typeof(h.ms_ringtones_apps))'');
    populated_cpi_mobile_apps_index_cnt := COUNT(GROUP,h.cpi_mobile_apps_index <> (TYPEOF(h.cpi_mobile_apps_index))'');
    populated_cpi_mobile_apps_index_pcnt := AVE(GROUP,IF(h.cpi_mobile_apps_index = (TYPEOF(h.cpi_mobile_apps_index))'',0,100));
    maxlength_cpi_mobile_apps_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_mobile_apps_index)));
    avelength_cpi_mobile_apps_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_mobile_apps_index)),h.cpi_mobile_apps_index<>(typeof(h.cpi_mobile_apps_index))'');
    populated_cpi_credit_repair_index_cnt := COUNT(GROUP,h.cpi_credit_repair_index <> (TYPEOF(h.cpi_credit_repair_index))'');
    populated_cpi_credit_repair_index_pcnt := AVE(GROUP,IF(h.cpi_credit_repair_index = (TYPEOF(h.cpi_credit_repair_index))'',0,100));
    maxlength_cpi_credit_repair_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_credit_repair_index)));
    avelength_cpi_credit_repair_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_credit_repair_index)),h.cpi_credit_repair_index<>(typeof(h.cpi_credit_repair_index))'');
    populated_cpi_credit_report_index_cnt := COUNT(GROUP,h.cpi_credit_report_index <> (TYPEOF(h.cpi_credit_report_index))'');
    populated_cpi_credit_report_index_pcnt := AVE(GROUP,IF(h.cpi_credit_report_index = (TYPEOF(h.cpi_credit_report_index))'',0,100));
    maxlength_cpi_credit_report_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_credit_report_index)));
    avelength_cpi_credit_report_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_credit_report_index)),h.cpi_credit_report_index<>(typeof(h.cpi_credit_report_index))'');
    populated_cpi_education_seekers_index_cnt := COUNT(GROUP,h.cpi_education_seekers_index <> (TYPEOF(h.cpi_education_seekers_index))'');
    populated_cpi_education_seekers_index_pcnt := AVE(GROUP,IF(h.cpi_education_seekers_index = (TYPEOF(h.cpi_education_seekers_index))'',0,100));
    maxlength_cpi_education_seekers_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_education_seekers_index)));
    avelength_cpi_education_seekers_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_education_seekers_index)),h.cpi_education_seekers_index<>(typeof(h.cpi_education_seekers_index))'');
    populated_cpi_insurance_index_cnt := COUNT(GROUP,h.cpi_insurance_index <> (TYPEOF(h.cpi_insurance_index))'');
    populated_cpi_insurance_index_pcnt := AVE(GROUP,IF(h.cpi_insurance_index = (TYPEOF(h.cpi_insurance_index))'',0,100));
    maxlength_cpi_insurance_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_insurance_index)));
    avelength_cpi_insurance_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_insurance_index)),h.cpi_insurance_index<>(typeof(h.cpi_insurance_index))'');
    populated_cpi_insurance_health_index_cnt := COUNT(GROUP,h.cpi_insurance_health_index <> (TYPEOF(h.cpi_insurance_health_index))'');
    populated_cpi_insurance_health_index_pcnt := AVE(GROUP,IF(h.cpi_insurance_health_index = (TYPEOF(h.cpi_insurance_health_index))'',0,100));
    maxlength_cpi_insurance_health_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_insurance_health_index)));
    avelength_cpi_insurance_health_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_insurance_health_index)),h.cpi_insurance_health_index<>(typeof(h.cpi_insurance_health_index))'');
    populated_cpi_insurance_auto_index_cnt := COUNT(GROUP,h.cpi_insurance_auto_index <> (TYPEOF(h.cpi_insurance_auto_index))'');
    populated_cpi_insurance_auto_index_pcnt := AVE(GROUP,IF(h.cpi_insurance_auto_index = (TYPEOF(h.cpi_insurance_auto_index))'',0,100));
    maxlength_cpi_insurance_auto_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_insurance_auto_index)));
    avelength_cpi_insurance_auto_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_insurance_auto_index)),h.cpi_insurance_auto_index<>(typeof(h.cpi_insurance_auto_index))'');
    populated_cpi_job_seekers_index_cnt := COUNT(GROUP,h.cpi_job_seekers_index <> (TYPEOF(h.cpi_job_seekers_index))'');
    populated_cpi_job_seekers_index_pcnt := AVE(GROUP,IF(h.cpi_job_seekers_index = (TYPEOF(h.cpi_job_seekers_index))'',0,100));
    maxlength_cpi_job_seekers_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_job_seekers_index)));
    avelength_cpi_job_seekers_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_job_seekers_index)),h.cpi_job_seekers_index<>(typeof(h.cpi_job_seekers_index))'');
    populated_cpi_social_networking_index_cnt := COUNT(GROUP,h.cpi_social_networking_index <> (TYPEOF(h.cpi_social_networking_index))'');
    populated_cpi_social_networking_index_pcnt := AVE(GROUP,IF(h.cpi_social_networking_index = (TYPEOF(h.cpi_social_networking_index))'',0,100));
    maxlength_cpi_social_networking_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_social_networking_index)));
    avelength_cpi_social_networking_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_social_networking_index)),h.cpi_social_networking_index<>(typeof(h.cpi_social_networking_index))'');
    populated_cpi_adult_index_cnt := COUNT(GROUP,h.cpi_adult_index <> (TYPEOF(h.cpi_adult_index))'');
    populated_cpi_adult_index_pcnt := AVE(GROUP,IF(h.cpi_adult_index = (TYPEOF(h.cpi_adult_index))'',0,100));
    maxlength_cpi_adult_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_adult_index)));
    avelength_cpi_adult_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_adult_index)),h.cpi_adult_index<>(typeof(h.cpi_adult_index))'');
    populated_cpi_africanamerican_index_cnt := COUNT(GROUP,h.cpi_africanamerican_index <> (TYPEOF(h.cpi_africanamerican_index))'');
    populated_cpi_africanamerican_index_pcnt := AVE(GROUP,IF(h.cpi_africanamerican_index = (TYPEOF(h.cpi_africanamerican_index))'',0,100));
    maxlength_cpi_africanamerican_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_africanamerican_index)));
    avelength_cpi_africanamerican_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_africanamerican_index)),h.cpi_africanamerican_index<>(typeof(h.cpi_africanamerican_index))'');
    populated_cpi_apparel_index_cnt := COUNT(GROUP,h.cpi_apparel_index <> (TYPEOF(h.cpi_apparel_index))'');
    populated_cpi_apparel_index_pcnt := AVE(GROUP,IF(h.cpi_apparel_index = (TYPEOF(h.cpi_apparel_index))'',0,100));
    maxlength_cpi_apparel_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_index)));
    avelength_cpi_apparel_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_index)),h.cpi_apparel_index<>(typeof(h.cpi_apparel_index))'');
    populated_cpi_apparel_accessory_index_cnt := COUNT(GROUP,h.cpi_apparel_accessory_index <> (TYPEOF(h.cpi_apparel_accessory_index))'');
    populated_cpi_apparel_accessory_index_pcnt := AVE(GROUP,IF(h.cpi_apparel_accessory_index = (TYPEOF(h.cpi_apparel_accessory_index))'',0,100));
    maxlength_cpi_apparel_accessory_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_accessory_index)));
    avelength_cpi_apparel_accessory_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_accessory_index)),h.cpi_apparel_accessory_index<>(typeof(h.cpi_apparel_accessory_index))'');
    populated_cpi_apparel_kids_index_cnt := COUNT(GROUP,h.cpi_apparel_kids_index <> (TYPEOF(h.cpi_apparel_kids_index))'');
    populated_cpi_apparel_kids_index_pcnt := AVE(GROUP,IF(h.cpi_apparel_kids_index = (TYPEOF(h.cpi_apparel_kids_index))'',0,100));
    maxlength_cpi_apparel_kids_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_kids_index)));
    avelength_cpi_apparel_kids_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_kids_index)),h.cpi_apparel_kids_index<>(typeof(h.cpi_apparel_kids_index))'');
    populated_cpi_apparel_men_index_cnt := COUNT(GROUP,h.cpi_apparel_men_index <> (TYPEOF(h.cpi_apparel_men_index))'');
    populated_cpi_apparel_men_index_pcnt := AVE(GROUP,IF(h.cpi_apparel_men_index = (TYPEOF(h.cpi_apparel_men_index))'',0,100));
    maxlength_cpi_apparel_men_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_men_index)));
    avelength_cpi_apparel_men_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_men_index)),h.cpi_apparel_men_index<>(typeof(h.cpi_apparel_men_index))'');
    populated_cpi_apparel_menfash_index_cnt := COUNT(GROUP,h.cpi_apparel_menfash_index <> (TYPEOF(h.cpi_apparel_menfash_index))'');
    populated_cpi_apparel_menfash_index_pcnt := AVE(GROUP,IF(h.cpi_apparel_menfash_index = (TYPEOF(h.cpi_apparel_menfash_index))'',0,100));
    maxlength_cpi_apparel_menfash_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_menfash_index)));
    avelength_cpi_apparel_menfash_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_menfash_index)),h.cpi_apparel_menfash_index<>(typeof(h.cpi_apparel_menfash_index))'');
    populated_cpi_apparel_women_index_cnt := COUNT(GROUP,h.cpi_apparel_women_index <> (TYPEOF(h.cpi_apparel_women_index))'');
    populated_cpi_apparel_women_index_pcnt := AVE(GROUP,IF(h.cpi_apparel_women_index = (TYPEOF(h.cpi_apparel_women_index))'',0,100));
    maxlength_cpi_apparel_women_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_women_index)));
    avelength_cpi_apparel_women_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_women_index)),h.cpi_apparel_women_index<>(typeof(h.cpi_apparel_women_index))'');
    populated_cpi_apparel_womfash_index_cnt := COUNT(GROUP,h.cpi_apparel_womfash_index <> (TYPEOF(h.cpi_apparel_womfash_index))'');
    populated_cpi_apparel_womfash_index_pcnt := AVE(GROUP,IF(h.cpi_apparel_womfash_index = (TYPEOF(h.cpi_apparel_womfash_index))'',0,100));
    maxlength_cpi_apparel_womfash_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_womfash_index)));
    avelength_cpi_apparel_womfash_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_apparel_womfash_index)),h.cpi_apparel_womfash_index<>(typeof(h.cpi_apparel_womfash_index))'');
    populated_cpi_asian_index_cnt := COUNT(GROUP,h.cpi_asian_index <> (TYPEOF(h.cpi_asian_index))'');
    populated_cpi_asian_index_pcnt := AVE(GROUP,IF(h.cpi_asian_index = (TYPEOF(h.cpi_asian_index))'',0,100));
    maxlength_cpi_asian_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_asian_index)));
    avelength_cpi_asian_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_asian_index)),h.cpi_asian_index<>(typeof(h.cpi_asian_index))'');
    populated_cpi_auto_index_cnt := COUNT(GROUP,h.cpi_auto_index <> (TYPEOF(h.cpi_auto_index))'');
    populated_cpi_auto_index_pcnt := AVE(GROUP,IF(h.cpi_auto_index = (TYPEOF(h.cpi_auto_index))'',0,100));
    maxlength_cpi_auto_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_auto_index)));
    avelength_cpi_auto_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_auto_index)),h.cpi_auto_index<>(typeof(h.cpi_auto_index))'');
    populated_cpi_auto_racing_index_cnt := COUNT(GROUP,h.cpi_auto_racing_index <> (TYPEOF(h.cpi_auto_racing_index))'');
    populated_cpi_auto_racing_index_pcnt := AVE(GROUP,IF(h.cpi_auto_racing_index = (TYPEOF(h.cpi_auto_racing_index))'',0,100));
    maxlength_cpi_auto_racing_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_auto_racing_index)));
    avelength_cpi_auto_racing_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_auto_racing_index)),h.cpi_auto_racing_index<>(typeof(h.cpi_auto_racing_index))'');
    populated_cpi_auto_trucks_index_cnt := COUNT(GROUP,h.cpi_auto_trucks_index <> (TYPEOF(h.cpi_auto_trucks_index))'');
    populated_cpi_auto_trucks_index_pcnt := AVE(GROUP,IF(h.cpi_auto_trucks_index = (TYPEOF(h.cpi_auto_trucks_index))'',0,100));
    maxlength_cpi_auto_trucks_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_auto_trucks_index)));
    avelength_cpi_auto_trucks_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_auto_trucks_index)),h.cpi_auto_trucks_index<>(typeof(h.cpi_auto_trucks_index))'');
    populated_cpi_aviation_index_cnt := COUNT(GROUP,h.cpi_aviation_index <> (TYPEOF(h.cpi_aviation_index))'');
    populated_cpi_aviation_index_pcnt := AVE(GROUP,IF(h.cpi_aviation_index = (TYPEOF(h.cpi_aviation_index))'',0,100));
    maxlength_cpi_aviation_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_aviation_index)));
    avelength_cpi_aviation_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_aviation_index)),h.cpi_aviation_index<>(typeof(h.cpi_aviation_index))'');
    populated_cpi_bargains_index_cnt := COUNT(GROUP,h.cpi_bargains_index <> (TYPEOF(h.cpi_bargains_index))'');
    populated_cpi_bargains_index_pcnt := AVE(GROUP,IF(h.cpi_bargains_index = (TYPEOF(h.cpi_bargains_index))'',0,100));
    maxlength_cpi_bargains_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_bargains_index)));
    avelength_cpi_bargains_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_bargains_index)),h.cpi_bargains_index<>(typeof(h.cpi_bargains_index))'');
    populated_cpi_beauty_index_cnt := COUNT(GROUP,h.cpi_beauty_index <> (TYPEOF(h.cpi_beauty_index))'');
    populated_cpi_beauty_index_pcnt := AVE(GROUP,IF(h.cpi_beauty_index = (TYPEOF(h.cpi_beauty_index))'',0,100));
    maxlength_cpi_beauty_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_beauty_index)));
    avelength_cpi_beauty_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_beauty_index)),h.cpi_beauty_index<>(typeof(h.cpi_beauty_index))'');
    populated_cpi_bible_index_cnt := COUNT(GROUP,h.cpi_bible_index <> (TYPEOF(h.cpi_bible_index))'');
    populated_cpi_bible_index_pcnt := AVE(GROUP,IF(h.cpi_bible_index = (TYPEOF(h.cpi_bible_index))'',0,100));
    maxlength_cpi_bible_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_bible_index)));
    avelength_cpi_bible_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_bible_index)),h.cpi_bible_index<>(typeof(h.cpi_bible_index))'');
    populated_cpi_birds_index_cnt := COUNT(GROUP,h.cpi_birds_index <> (TYPEOF(h.cpi_birds_index))'');
    populated_cpi_birds_index_pcnt := AVE(GROUP,IF(h.cpi_birds_index = (TYPEOF(h.cpi_birds_index))'',0,100));
    maxlength_cpi_birds_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_birds_index)));
    avelength_cpi_birds_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_birds_index)),h.cpi_birds_index<>(typeof(h.cpi_birds_index))'');
    populated_cpi_business_index_cnt := COUNT(GROUP,h.cpi_business_index <> (TYPEOF(h.cpi_business_index))'');
    populated_cpi_business_index_pcnt := AVE(GROUP,IF(h.cpi_business_index = (TYPEOF(h.cpi_business_index))'',0,100));
    maxlength_cpi_business_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_business_index)));
    avelength_cpi_business_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_business_index)),h.cpi_business_index<>(typeof(h.cpi_business_index))'');
    populated_cpi_business_homeoffice_index_cnt := COUNT(GROUP,h.cpi_business_homeoffice_index <> (TYPEOF(h.cpi_business_homeoffice_index))'');
    populated_cpi_business_homeoffice_index_pcnt := AVE(GROUP,IF(h.cpi_business_homeoffice_index = (TYPEOF(h.cpi_business_homeoffice_index))'',0,100));
    maxlength_cpi_business_homeoffice_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_business_homeoffice_index)));
    avelength_cpi_business_homeoffice_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_business_homeoffice_index)),h.cpi_business_homeoffice_index<>(typeof(h.cpi_business_homeoffice_index))'');
    populated_cpi_catalog_index_cnt := COUNT(GROUP,h.cpi_catalog_index <> (TYPEOF(h.cpi_catalog_index))'');
    populated_cpi_catalog_index_pcnt := AVE(GROUP,IF(h.cpi_catalog_index = (TYPEOF(h.cpi_catalog_index))'',0,100));
    maxlength_cpi_catalog_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_catalog_index)));
    avelength_cpi_catalog_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_catalog_index)),h.cpi_catalog_index<>(typeof(h.cpi_catalog_index))'');
    populated_cpi_cc_index_cnt := COUNT(GROUP,h.cpi_cc_index <> (TYPEOF(h.cpi_cc_index))'');
    populated_cpi_cc_index_pcnt := AVE(GROUP,IF(h.cpi_cc_index = (TYPEOF(h.cpi_cc_index))'',0,100));
    maxlength_cpi_cc_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_cc_index)));
    avelength_cpi_cc_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_cc_index)),h.cpi_cc_index<>(typeof(h.cpi_cc_index))'');
    populated_cpi_collectibles_index_cnt := COUNT(GROUP,h.cpi_collectibles_index <> (TYPEOF(h.cpi_collectibles_index))'');
    populated_cpi_collectibles_index_pcnt := AVE(GROUP,IF(h.cpi_collectibles_index = (TYPEOF(h.cpi_collectibles_index))'',0,100));
    maxlength_cpi_collectibles_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_collectibles_index)));
    avelength_cpi_collectibles_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_collectibles_index)),h.cpi_collectibles_index<>(typeof(h.cpi_collectibles_index))'');
    populated_cpi_college_index_cnt := COUNT(GROUP,h.cpi_college_index <> (TYPEOF(h.cpi_college_index))'');
    populated_cpi_college_index_pcnt := AVE(GROUP,IF(h.cpi_college_index = (TYPEOF(h.cpi_college_index))'',0,100));
    maxlength_cpi_college_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_college_index)));
    avelength_cpi_college_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_college_index)),h.cpi_college_index<>(typeof(h.cpi_college_index))'');
    populated_cpi_computers_index_cnt := COUNT(GROUP,h.cpi_computers_index <> (TYPEOF(h.cpi_computers_index))'');
    populated_cpi_computers_index_pcnt := AVE(GROUP,IF(h.cpi_computers_index = (TYPEOF(h.cpi_computers_index))'',0,100));
    maxlength_cpi_computers_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_computers_index)));
    avelength_cpi_computers_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_computers_index)),h.cpi_computers_index<>(typeof(h.cpi_computers_index))'');
    populated_cpi_conservative_index_cnt := COUNT(GROUP,h.cpi_conservative_index <> (TYPEOF(h.cpi_conservative_index))'');
    populated_cpi_conservative_index_pcnt := AVE(GROUP,IF(h.cpi_conservative_index = (TYPEOF(h.cpi_conservative_index))'',0,100));
    maxlength_cpi_conservative_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_conservative_index)));
    avelength_cpi_conservative_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_conservative_index)),h.cpi_conservative_index<>(typeof(h.cpi_conservative_index))'');
    populated_cpi_continuity_index_cnt := COUNT(GROUP,h.cpi_continuity_index <> (TYPEOF(h.cpi_continuity_index))'');
    populated_cpi_continuity_index_pcnt := AVE(GROUP,IF(h.cpi_continuity_index = (TYPEOF(h.cpi_continuity_index))'',0,100));
    maxlength_cpi_continuity_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_continuity_index)));
    avelength_cpi_continuity_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_continuity_index)),h.cpi_continuity_index<>(typeof(h.cpi_continuity_index))'');
    populated_cpi_cooking_index_cnt := COUNT(GROUP,h.cpi_cooking_index <> (TYPEOF(h.cpi_cooking_index))'');
    populated_cpi_cooking_index_pcnt := AVE(GROUP,IF(h.cpi_cooking_index = (TYPEOF(h.cpi_cooking_index))'',0,100));
    maxlength_cpi_cooking_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_cooking_index)));
    avelength_cpi_cooking_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_cooking_index)),h.cpi_cooking_index<>(typeof(h.cpi_cooking_index))'');
    populated_cpi_crafts_index_cnt := COUNT(GROUP,h.cpi_crafts_index <> (TYPEOF(h.cpi_crafts_index))'');
    populated_cpi_crafts_index_pcnt := AVE(GROUP,IF(h.cpi_crafts_index = (TYPEOF(h.cpi_crafts_index))'',0,100));
    maxlength_cpi_crafts_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_index)));
    avelength_cpi_crafts_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_index)),h.cpi_crafts_index<>(typeof(h.cpi_crafts_index))'');
    populated_cpi_crafts_crochet_index_cnt := COUNT(GROUP,h.cpi_crafts_crochet_index <> (TYPEOF(h.cpi_crafts_crochet_index))'');
    populated_cpi_crafts_crochet_index_pcnt := AVE(GROUP,IF(h.cpi_crafts_crochet_index = (TYPEOF(h.cpi_crafts_crochet_index))'',0,100));
    maxlength_cpi_crafts_crochet_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_crochet_index)));
    avelength_cpi_crafts_crochet_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_crochet_index)),h.cpi_crafts_crochet_index<>(typeof(h.cpi_crafts_crochet_index))'');
    populated_cpi_crafts_knit_index_cnt := COUNT(GROUP,h.cpi_crafts_knit_index <> (TYPEOF(h.cpi_crafts_knit_index))'');
    populated_cpi_crafts_knit_index_pcnt := AVE(GROUP,IF(h.cpi_crafts_knit_index = (TYPEOF(h.cpi_crafts_knit_index))'',0,100));
    maxlength_cpi_crafts_knit_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_knit_index)));
    avelength_cpi_crafts_knit_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_knit_index)),h.cpi_crafts_knit_index<>(typeof(h.cpi_crafts_knit_index))'');
    populated_cpi_crafts_needlepoint_index_cnt := COUNT(GROUP,h.cpi_crafts_needlepoint_index <> (TYPEOF(h.cpi_crafts_needlepoint_index))'');
    populated_cpi_crafts_needlepoint_index_pcnt := AVE(GROUP,IF(h.cpi_crafts_needlepoint_index = (TYPEOF(h.cpi_crafts_needlepoint_index))'',0,100));
    maxlength_cpi_crafts_needlepoint_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_needlepoint_index)));
    avelength_cpi_crafts_needlepoint_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_needlepoint_index)),h.cpi_crafts_needlepoint_index<>(typeof(h.cpi_crafts_needlepoint_index))'');
    populated_cpi_crafts_quilt_index_cnt := COUNT(GROUP,h.cpi_crafts_quilt_index <> (TYPEOF(h.cpi_crafts_quilt_index))'');
    populated_cpi_crafts_quilt_index_pcnt := AVE(GROUP,IF(h.cpi_crafts_quilt_index = (TYPEOF(h.cpi_crafts_quilt_index))'',0,100));
    maxlength_cpi_crafts_quilt_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_quilt_index)));
    avelength_cpi_crafts_quilt_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_quilt_index)),h.cpi_crafts_quilt_index<>(typeof(h.cpi_crafts_quilt_index))'');
    populated_cpi_crafts_sew_index_cnt := COUNT(GROUP,h.cpi_crafts_sew_index <> (TYPEOF(h.cpi_crafts_sew_index))'');
    populated_cpi_crafts_sew_index_pcnt := AVE(GROUP,IF(h.cpi_crafts_sew_index = (TYPEOF(h.cpi_crafts_sew_index))'',0,100));
    maxlength_cpi_crafts_sew_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_sew_index)));
    avelength_cpi_crafts_sew_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_crafts_sew_index)),h.cpi_crafts_sew_index<>(typeof(h.cpi_crafts_sew_index))'');
    populated_cpi_culturearts_index_cnt := COUNT(GROUP,h.cpi_culturearts_index <> (TYPEOF(h.cpi_culturearts_index))'');
    populated_cpi_culturearts_index_pcnt := AVE(GROUP,IF(h.cpi_culturearts_index = (TYPEOF(h.cpi_culturearts_index))'',0,100));
    maxlength_cpi_culturearts_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_culturearts_index)));
    avelength_cpi_culturearts_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_culturearts_index)),h.cpi_culturearts_index<>(typeof(h.cpi_culturearts_index))'');
    populated_cpi_currevent_index_cnt := COUNT(GROUP,h.cpi_currevent_index <> (TYPEOF(h.cpi_currevent_index))'');
    populated_cpi_currevent_index_pcnt := AVE(GROUP,IF(h.cpi_currevent_index = (TYPEOF(h.cpi_currevent_index))'',0,100));
    maxlength_cpi_currevent_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_currevent_index)));
    avelength_cpi_currevent_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_currevent_index)),h.cpi_currevent_index<>(typeof(h.cpi_currevent_index))'');
    populated_cpi_diy_index_cnt := COUNT(GROUP,h.cpi_diy_index <> (TYPEOF(h.cpi_diy_index))'');
    populated_cpi_diy_index_pcnt := AVE(GROUP,IF(h.cpi_diy_index = (TYPEOF(h.cpi_diy_index))'',0,100));
    maxlength_cpi_diy_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_diy_index)));
    avelength_cpi_diy_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_diy_index)),h.cpi_diy_index<>(typeof(h.cpi_diy_index))'');
    populated_cpi_donor_index_cnt := COUNT(GROUP,h.cpi_donor_index <> (TYPEOF(h.cpi_donor_index))'');
    populated_cpi_donor_index_pcnt := AVE(GROUP,IF(h.cpi_donor_index = (TYPEOF(h.cpi_donor_index))'',0,100));
    maxlength_cpi_donor_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_donor_index)));
    avelength_cpi_donor_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_donor_index)),h.cpi_donor_index<>(typeof(h.cpi_donor_index))'');
    populated_cpi_ego_index_cnt := COUNT(GROUP,h.cpi_ego_index <> (TYPEOF(h.cpi_ego_index))'');
    populated_cpi_ego_index_pcnt := AVE(GROUP,IF(h.cpi_ego_index = (TYPEOF(h.cpi_ego_index))'',0,100));
    maxlength_cpi_ego_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_ego_index)));
    avelength_cpi_ego_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_ego_index)),h.cpi_ego_index<>(typeof(h.cpi_ego_index))'');
    populated_cpi_electronics_index_cnt := COUNT(GROUP,h.cpi_electronics_index <> (TYPEOF(h.cpi_electronics_index))'');
    populated_cpi_electronics_index_pcnt := AVE(GROUP,IF(h.cpi_electronics_index = (TYPEOF(h.cpi_electronics_index))'',0,100));
    maxlength_cpi_electronics_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_electronics_index)));
    avelength_cpi_electronics_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_electronics_index)),h.cpi_electronics_index<>(typeof(h.cpi_electronics_index))'');
    populated_cpi_equestrian_index_cnt := COUNT(GROUP,h.cpi_equestrian_index <> (TYPEOF(h.cpi_equestrian_index))'');
    populated_cpi_equestrian_index_pcnt := AVE(GROUP,IF(h.cpi_equestrian_index = (TYPEOF(h.cpi_equestrian_index))'',0,100));
    maxlength_cpi_equestrian_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_equestrian_index)));
    avelength_cpi_equestrian_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_equestrian_index)),h.cpi_equestrian_index<>(typeof(h.cpi_equestrian_index))'');
    populated_cpi_family_index_cnt := COUNT(GROUP,h.cpi_family_index <> (TYPEOF(h.cpi_family_index))'');
    populated_cpi_family_index_pcnt := AVE(GROUP,IF(h.cpi_family_index = (TYPEOF(h.cpi_family_index))'',0,100));
    maxlength_cpi_family_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_family_index)));
    avelength_cpi_family_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_family_index)),h.cpi_family_index<>(typeof(h.cpi_family_index))'');
    populated_cpi_family_teen_index_cnt := COUNT(GROUP,h.cpi_family_teen_index <> (TYPEOF(h.cpi_family_teen_index))'');
    populated_cpi_family_teen_index_pcnt := AVE(GROUP,IF(h.cpi_family_teen_index = (TYPEOF(h.cpi_family_teen_index))'',0,100));
    maxlength_cpi_family_teen_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_family_teen_index)));
    avelength_cpi_family_teen_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_family_teen_index)),h.cpi_family_teen_index<>(typeof(h.cpi_family_teen_index))'');
    populated_cpi_family_young_index_cnt := COUNT(GROUP,h.cpi_family_young_index <> (TYPEOF(h.cpi_family_young_index))'');
    populated_cpi_family_young_index_pcnt := AVE(GROUP,IF(h.cpi_family_young_index = (TYPEOF(h.cpi_family_young_index))'',0,100));
    maxlength_cpi_family_young_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_family_young_index)));
    avelength_cpi_family_young_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_family_young_index)),h.cpi_family_young_index<>(typeof(h.cpi_family_young_index))'');
    populated_cpi_fiction_index_cnt := COUNT(GROUP,h.cpi_fiction_index <> (TYPEOF(h.cpi_fiction_index))'');
    populated_cpi_fiction_index_pcnt := AVE(GROUP,IF(h.cpi_fiction_index = (TYPEOF(h.cpi_fiction_index))'',0,100));
    maxlength_cpi_fiction_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_fiction_index)));
    avelength_cpi_fiction_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_fiction_index)),h.cpi_fiction_index<>(typeof(h.cpi_fiction_index))'');
    populated_cpi_gambling_index_cnt := COUNT(GROUP,h.cpi_gambling_index <> (TYPEOF(h.cpi_gambling_index))'');
    populated_cpi_gambling_index_pcnt := AVE(GROUP,IF(h.cpi_gambling_index = (TYPEOF(h.cpi_gambling_index))'',0,100));
    maxlength_cpi_gambling_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_gambling_index)));
    avelength_cpi_gambling_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_gambling_index)),h.cpi_gambling_index<>(typeof(h.cpi_gambling_index))'');
    populated_cpi_games_index_cnt := COUNT(GROUP,h.cpi_games_index <> (TYPEOF(h.cpi_games_index))'');
    populated_cpi_games_index_pcnt := AVE(GROUP,IF(h.cpi_games_index = (TYPEOF(h.cpi_games_index))'',0,100));
    maxlength_cpi_games_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_games_index)));
    avelength_cpi_games_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_games_index)),h.cpi_games_index<>(typeof(h.cpi_games_index))'');
    populated_cpi_gardening_index_cnt := COUNT(GROUP,h.cpi_gardening_index <> (TYPEOF(h.cpi_gardening_index))'');
    populated_cpi_gardening_index_pcnt := AVE(GROUP,IF(h.cpi_gardening_index = (TYPEOF(h.cpi_gardening_index))'',0,100));
    maxlength_cpi_gardening_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_gardening_index)));
    avelength_cpi_gardening_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_gardening_index)),h.cpi_gardening_index<>(typeof(h.cpi_gardening_index))'');
    populated_cpi_gay_index_cnt := COUNT(GROUP,h.cpi_gay_index <> (TYPEOF(h.cpi_gay_index))'');
    populated_cpi_gay_index_pcnt := AVE(GROUP,IF(h.cpi_gay_index = (TYPEOF(h.cpi_gay_index))'',0,100));
    maxlength_cpi_gay_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_gay_index)));
    avelength_cpi_gay_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_gay_index)),h.cpi_gay_index<>(typeof(h.cpi_gay_index))'');
    populated_cpi_giftgivr_index_cnt := COUNT(GROUP,h.cpi_giftgivr_index <> (TYPEOF(h.cpi_giftgivr_index))'');
    populated_cpi_giftgivr_index_pcnt := AVE(GROUP,IF(h.cpi_giftgivr_index = (TYPEOF(h.cpi_giftgivr_index))'',0,100));
    maxlength_cpi_giftgivr_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_giftgivr_index)));
    avelength_cpi_giftgivr_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_giftgivr_index)),h.cpi_giftgivr_index<>(typeof(h.cpi_giftgivr_index))'');
    populated_cpi_gourmet_index_cnt := COUNT(GROUP,h.cpi_gourmet_index <> (TYPEOF(h.cpi_gourmet_index))'');
    populated_cpi_gourmet_index_pcnt := AVE(GROUP,IF(h.cpi_gourmet_index = (TYPEOF(h.cpi_gourmet_index))'',0,100));
    maxlength_cpi_gourmet_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_gourmet_index)));
    avelength_cpi_gourmet_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_gourmet_index)),h.cpi_gourmet_index<>(typeof(h.cpi_gourmet_index))'');
    populated_cpi_grandparents_index_cnt := COUNT(GROUP,h.cpi_grandparents_index <> (TYPEOF(h.cpi_grandparents_index))'');
    populated_cpi_grandparents_index_pcnt := AVE(GROUP,IF(h.cpi_grandparents_index = (TYPEOF(h.cpi_grandparents_index))'',0,100));
    maxlength_cpi_grandparents_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_grandparents_index)));
    avelength_cpi_grandparents_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_grandparents_index)),h.cpi_grandparents_index<>(typeof(h.cpi_grandparents_index))'');
    populated_cpi_health_index_cnt := COUNT(GROUP,h.cpi_health_index <> (TYPEOF(h.cpi_health_index))'');
    populated_cpi_health_index_pcnt := AVE(GROUP,IF(h.cpi_health_index = (TYPEOF(h.cpi_health_index))'',0,100));
    maxlength_cpi_health_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_health_index)));
    avelength_cpi_health_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_health_index)),h.cpi_health_index<>(typeof(h.cpi_health_index))'');
    populated_cpi_health_diet_index_cnt := COUNT(GROUP,h.cpi_health_diet_index <> (TYPEOF(h.cpi_health_diet_index))'');
    populated_cpi_health_diet_index_pcnt := AVE(GROUP,IF(h.cpi_health_diet_index = (TYPEOF(h.cpi_health_diet_index))'',0,100));
    maxlength_cpi_health_diet_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_health_diet_index)));
    avelength_cpi_health_diet_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_health_diet_index)),h.cpi_health_diet_index<>(typeof(h.cpi_health_diet_index))'');
    populated_cpi_health_fitness_index_cnt := COUNT(GROUP,h.cpi_health_fitness_index <> (TYPEOF(h.cpi_health_fitness_index))'');
    populated_cpi_health_fitness_index_pcnt := AVE(GROUP,IF(h.cpi_health_fitness_index = (TYPEOF(h.cpi_health_fitness_index))'',0,100));
    maxlength_cpi_health_fitness_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_health_fitness_index)));
    avelength_cpi_health_fitness_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_health_fitness_index)),h.cpi_health_fitness_index<>(typeof(h.cpi_health_fitness_index))'');
    populated_cpi_hightech_index_cnt := COUNT(GROUP,h.cpi_hightech_index <> (TYPEOF(h.cpi_hightech_index))'');
    populated_cpi_hightech_index_pcnt := AVE(GROUP,IF(h.cpi_hightech_index = (TYPEOF(h.cpi_hightech_index))'',0,100));
    maxlength_cpi_hightech_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_hightech_index)));
    avelength_cpi_hightech_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_hightech_index)),h.cpi_hightech_index<>(typeof(h.cpi_hightech_index))'');
    populated_cpi_hispanic_index_cnt := COUNT(GROUP,h.cpi_hispanic_index <> (TYPEOF(h.cpi_hispanic_index))'');
    populated_cpi_hispanic_index_pcnt := AVE(GROUP,IF(h.cpi_hispanic_index = (TYPEOF(h.cpi_hispanic_index))'',0,100));
    maxlength_cpi_hispanic_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_hispanic_index)));
    avelength_cpi_hispanic_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_hispanic_index)),h.cpi_hispanic_index<>(typeof(h.cpi_hispanic_index))'');
    populated_cpi_history_index_cnt := COUNT(GROUP,h.cpi_history_index <> (TYPEOF(h.cpi_history_index))'');
    populated_cpi_history_index_pcnt := AVE(GROUP,IF(h.cpi_history_index = (TYPEOF(h.cpi_history_index))'',0,100));
    maxlength_cpi_history_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_history_index)));
    avelength_cpi_history_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_history_index)),h.cpi_history_index<>(typeof(h.cpi_history_index))'');
    populated_cpi_history_american_index_cnt := COUNT(GROUP,h.cpi_history_american_index <> (TYPEOF(h.cpi_history_american_index))'');
    populated_cpi_history_american_index_pcnt := AVE(GROUP,IF(h.cpi_history_american_index = (TYPEOF(h.cpi_history_american_index))'',0,100));
    maxlength_cpi_history_american_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_history_american_index)));
    avelength_cpi_history_american_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_history_american_index)),h.cpi_history_american_index<>(typeof(h.cpi_history_american_index))'');
    populated_cpi_hobbies_index_cnt := COUNT(GROUP,h.cpi_hobbies_index <> (TYPEOF(h.cpi_hobbies_index))'');
    populated_cpi_hobbies_index_pcnt := AVE(GROUP,IF(h.cpi_hobbies_index = (TYPEOF(h.cpi_hobbies_index))'',0,100));
    maxlength_cpi_hobbies_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_hobbies_index)));
    avelength_cpi_hobbies_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_hobbies_index)),h.cpi_hobbies_index<>(typeof(h.cpi_hobbies_index))'');
    populated_cpi_homedecr_index_cnt := COUNT(GROUP,h.cpi_homedecr_index <> (TYPEOF(h.cpi_homedecr_index))'');
    populated_cpi_homedecr_index_pcnt := AVE(GROUP,IF(h.cpi_homedecr_index = (TYPEOF(h.cpi_homedecr_index))'',0,100));
    maxlength_cpi_homedecr_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_homedecr_index)));
    avelength_cpi_homedecr_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_homedecr_index)),h.cpi_homedecr_index<>(typeof(h.cpi_homedecr_index))'');
    populated_cpi_homeliv_index_cnt := COUNT(GROUP,h.cpi_homeliv_index <> (TYPEOF(h.cpi_homeliv_index))'');
    populated_cpi_homeliv_index_pcnt := AVE(GROUP,IF(h.cpi_homeliv_index = (TYPEOF(h.cpi_homeliv_index))'',0,100));
    maxlength_cpi_homeliv_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_homeliv_index)));
    avelength_cpi_homeliv_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_homeliv_index)),h.cpi_homeliv_index<>(typeof(h.cpi_homeliv_index))'');
    populated_cpi_humor_index_cnt := COUNT(GROUP,h.cpi_humor_index <> (TYPEOF(h.cpi_humor_index))'');
    populated_cpi_humor_index_pcnt := AVE(GROUP,IF(h.cpi_humor_index = (TYPEOF(h.cpi_humor_index))'',0,100));
    maxlength_cpi_humor_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_humor_index)));
    avelength_cpi_humor_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_humor_index)),h.cpi_humor_index<>(typeof(h.cpi_humor_index))'');
    populated_cpi_inspiration_index_cnt := COUNT(GROUP,h.cpi_inspiration_index <> (TYPEOF(h.cpi_inspiration_index))'');
    populated_cpi_inspiration_index_pcnt := AVE(GROUP,IF(h.cpi_inspiration_index = (TYPEOF(h.cpi_inspiration_index))'',0,100));
    maxlength_cpi_inspiration_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_inspiration_index)));
    avelength_cpi_inspiration_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_inspiration_index)),h.cpi_inspiration_index<>(typeof(h.cpi_inspiration_index))'');
    populated_cpi_internet_index_cnt := COUNT(GROUP,h.cpi_internet_index <> (TYPEOF(h.cpi_internet_index))'');
    populated_cpi_internet_index_pcnt := AVE(GROUP,IF(h.cpi_internet_index = (TYPEOF(h.cpi_internet_index))'',0,100));
    maxlength_cpi_internet_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_internet_index)));
    avelength_cpi_internet_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_internet_index)),h.cpi_internet_index<>(typeof(h.cpi_internet_index))'');
    populated_cpi_internet_access_index_cnt := COUNT(GROUP,h.cpi_internet_access_index <> (TYPEOF(h.cpi_internet_access_index))'');
    populated_cpi_internet_access_index_pcnt := AVE(GROUP,IF(h.cpi_internet_access_index = (TYPEOF(h.cpi_internet_access_index))'',0,100));
    maxlength_cpi_internet_access_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_internet_access_index)));
    avelength_cpi_internet_access_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_internet_access_index)),h.cpi_internet_access_index<>(typeof(h.cpi_internet_access_index))'');
    populated_cpi_internet_buy_index_cnt := COUNT(GROUP,h.cpi_internet_buy_index <> (TYPEOF(h.cpi_internet_buy_index))'');
    populated_cpi_internet_buy_index_pcnt := AVE(GROUP,IF(h.cpi_internet_buy_index = (TYPEOF(h.cpi_internet_buy_index))'',0,100));
    maxlength_cpi_internet_buy_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_internet_buy_index)));
    avelength_cpi_internet_buy_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_internet_buy_index)),h.cpi_internet_buy_index<>(typeof(h.cpi_internet_buy_index))'');
    populated_cpi_liberal_index_cnt := COUNT(GROUP,h.cpi_liberal_index <> (TYPEOF(h.cpi_liberal_index))'');
    populated_cpi_liberal_index_pcnt := AVE(GROUP,IF(h.cpi_liberal_index = (TYPEOF(h.cpi_liberal_index))'',0,100));
    maxlength_cpi_liberal_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_liberal_index)));
    avelength_cpi_liberal_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_liberal_index)),h.cpi_liberal_index<>(typeof(h.cpi_liberal_index))'');
    populated_cpi_moneymaking_index_cnt := COUNT(GROUP,h.cpi_moneymaking_index <> (TYPEOF(h.cpi_moneymaking_index))'');
    populated_cpi_moneymaking_index_pcnt := AVE(GROUP,IF(h.cpi_moneymaking_index = (TYPEOF(h.cpi_moneymaking_index))'',0,100));
    maxlength_cpi_moneymaking_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_moneymaking_index)));
    avelength_cpi_moneymaking_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_moneymaking_index)),h.cpi_moneymaking_index<>(typeof(h.cpi_moneymaking_index))'');
    populated_cpi_motorcycles_index_cnt := COUNT(GROUP,h.cpi_motorcycles_index <> (TYPEOF(h.cpi_motorcycles_index))'');
    populated_cpi_motorcycles_index_pcnt := AVE(GROUP,IF(h.cpi_motorcycles_index = (TYPEOF(h.cpi_motorcycles_index))'',0,100));
    maxlength_cpi_motorcycles_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_motorcycles_index)));
    avelength_cpi_motorcycles_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_motorcycles_index)),h.cpi_motorcycles_index<>(typeof(h.cpi_motorcycles_index))'');
    populated_cpi_music_index_cnt := COUNT(GROUP,h.cpi_music_index <> (TYPEOF(h.cpi_music_index))'');
    populated_cpi_music_index_pcnt := AVE(GROUP,IF(h.cpi_music_index = (TYPEOF(h.cpi_music_index))'',0,100));
    maxlength_cpi_music_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_music_index)));
    avelength_cpi_music_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_music_index)),h.cpi_music_index<>(typeof(h.cpi_music_index))'');
    populated_cpi_nonfiction_index_cnt := COUNT(GROUP,h.cpi_nonfiction_index <> (TYPEOF(h.cpi_nonfiction_index))'');
    populated_cpi_nonfiction_index_pcnt := AVE(GROUP,IF(h.cpi_nonfiction_index = (TYPEOF(h.cpi_nonfiction_index))'',0,100));
    maxlength_cpi_nonfiction_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_nonfiction_index)));
    avelength_cpi_nonfiction_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_nonfiction_index)),h.cpi_nonfiction_index<>(typeof(h.cpi_nonfiction_index))'');
    populated_cpi_ocean_index_cnt := COUNT(GROUP,h.cpi_ocean_index <> (TYPEOF(h.cpi_ocean_index))'');
    populated_cpi_ocean_index_pcnt := AVE(GROUP,IF(h.cpi_ocean_index = (TYPEOF(h.cpi_ocean_index))'',0,100));
    maxlength_cpi_ocean_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_ocean_index)));
    avelength_cpi_ocean_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_ocean_index)),h.cpi_ocean_index<>(typeof(h.cpi_ocean_index))'');
    populated_cpi_outdoors_index_cnt := COUNT(GROUP,h.cpi_outdoors_index <> (TYPEOF(h.cpi_outdoors_index))'');
    populated_cpi_outdoors_index_pcnt := AVE(GROUP,IF(h.cpi_outdoors_index = (TYPEOF(h.cpi_outdoors_index))'',0,100));
    maxlength_cpi_outdoors_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_index)));
    avelength_cpi_outdoors_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_index)),h.cpi_outdoors_index<>(typeof(h.cpi_outdoors_index))'');
    populated_cpi_outdoors_boatsail_index_cnt := COUNT(GROUP,h.cpi_outdoors_boatsail_index <> (TYPEOF(h.cpi_outdoors_boatsail_index))'');
    populated_cpi_outdoors_boatsail_index_pcnt := AVE(GROUP,IF(h.cpi_outdoors_boatsail_index = (TYPEOF(h.cpi_outdoors_boatsail_index))'',0,100));
    maxlength_cpi_outdoors_boatsail_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_boatsail_index)));
    avelength_cpi_outdoors_boatsail_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_boatsail_index)),h.cpi_outdoors_boatsail_index<>(typeof(h.cpi_outdoors_boatsail_index))'');
    populated_cpi_outdoors_camp_index_cnt := COUNT(GROUP,h.cpi_outdoors_camp_index <> (TYPEOF(h.cpi_outdoors_camp_index))'');
    populated_cpi_outdoors_camp_index_pcnt := AVE(GROUP,IF(h.cpi_outdoors_camp_index = (TYPEOF(h.cpi_outdoors_camp_index))'',0,100));
    maxlength_cpi_outdoors_camp_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_camp_index)));
    avelength_cpi_outdoors_camp_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_camp_index)),h.cpi_outdoors_camp_index<>(typeof(h.cpi_outdoors_camp_index))'');
    populated_cpi_outdoors_fishing_index_cnt := COUNT(GROUP,h.cpi_outdoors_fishing_index <> (TYPEOF(h.cpi_outdoors_fishing_index))'');
    populated_cpi_outdoors_fishing_index_pcnt := AVE(GROUP,IF(h.cpi_outdoors_fishing_index = (TYPEOF(h.cpi_outdoors_fishing_index))'',0,100));
    maxlength_cpi_outdoors_fishing_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_fishing_index)));
    avelength_cpi_outdoors_fishing_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_fishing_index)),h.cpi_outdoors_fishing_index<>(typeof(h.cpi_outdoors_fishing_index))'');
    populated_cpi_outdoors_huntfish_index_cnt := COUNT(GROUP,h.cpi_outdoors_huntfish_index <> (TYPEOF(h.cpi_outdoors_huntfish_index))'');
    populated_cpi_outdoors_huntfish_index_pcnt := AVE(GROUP,IF(h.cpi_outdoors_huntfish_index = (TYPEOF(h.cpi_outdoors_huntfish_index))'',0,100));
    maxlength_cpi_outdoors_huntfish_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_huntfish_index)));
    avelength_cpi_outdoors_huntfish_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_huntfish_index)),h.cpi_outdoors_huntfish_index<>(typeof(h.cpi_outdoors_huntfish_index))'');
    populated_cpi_outdoors_hunting_index_cnt := COUNT(GROUP,h.cpi_outdoors_hunting_index <> (TYPEOF(h.cpi_outdoors_hunting_index))'');
    populated_cpi_outdoors_hunting_index_pcnt := AVE(GROUP,IF(h.cpi_outdoors_hunting_index = (TYPEOF(h.cpi_outdoors_hunting_index))'',0,100));
    maxlength_cpi_outdoors_hunting_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_hunting_index)));
    avelength_cpi_outdoors_hunting_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_outdoors_hunting_index)),h.cpi_outdoors_hunting_index<>(typeof(h.cpi_outdoors_hunting_index))'');
    populated_cpi_pets_index_cnt := COUNT(GROUP,h.cpi_pets_index <> (TYPEOF(h.cpi_pets_index))'');
    populated_cpi_pets_index_pcnt := AVE(GROUP,IF(h.cpi_pets_index = (TYPEOF(h.cpi_pets_index))'',0,100));
    maxlength_cpi_pets_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_pets_index)));
    avelength_cpi_pets_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_pets_index)),h.cpi_pets_index<>(typeof(h.cpi_pets_index))'');
    populated_cpi_pets_cats_index_cnt := COUNT(GROUP,h.cpi_pets_cats_index <> (TYPEOF(h.cpi_pets_cats_index))'');
    populated_cpi_pets_cats_index_pcnt := AVE(GROUP,IF(h.cpi_pets_cats_index = (TYPEOF(h.cpi_pets_cats_index))'',0,100));
    maxlength_cpi_pets_cats_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_pets_cats_index)));
    avelength_cpi_pets_cats_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_pets_cats_index)),h.cpi_pets_cats_index<>(typeof(h.cpi_pets_cats_index))'');
    populated_cpi_pets_dogs_index_cnt := COUNT(GROUP,h.cpi_pets_dogs_index <> (TYPEOF(h.cpi_pets_dogs_index))'');
    populated_cpi_pets_dogs_index_pcnt := AVE(GROUP,IF(h.cpi_pets_dogs_index = (TYPEOF(h.cpi_pets_dogs_index))'',0,100));
    maxlength_cpi_pets_dogs_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_pets_dogs_index)));
    avelength_cpi_pets_dogs_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_pets_dogs_index)),h.cpi_pets_dogs_index<>(typeof(h.cpi_pets_dogs_index))'');
    populated_cpi_pfin_index_cnt := COUNT(GROUP,h.cpi_pfin_index <> (TYPEOF(h.cpi_pfin_index))'');
    populated_cpi_pfin_index_pcnt := AVE(GROUP,IF(h.cpi_pfin_index = (TYPEOF(h.cpi_pfin_index))'',0,100));
    maxlength_cpi_pfin_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_pfin_index)));
    avelength_cpi_pfin_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_pfin_index)),h.cpi_pfin_index<>(typeof(h.cpi_pfin_index))'');
    populated_cpi_photog_index_cnt := COUNT(GROUP,h.cpi_photog_index <> (TYPEOF(h.cpi_photog_index))'');
    populated_cpi_photog_index_pcnt := AVE(GROUP,IF(h.cpi_photog_index = (TYPEOF(h.cpi_photog_index))'',0,100));
    maxlength_cpi_photog_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_photog_index)));
    avelength_cpi_photog_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_photog_index)),h.cpi_photog_index<>(typeof(h.cpi_photog_index))'');
    populated_cpi_photoproc_index_cnt := COUNT(GROUP,h.cpi_photoproc_index <> (TYPEOF(h.cpi_photoproc_index))'');
    populated_cpi_photoproc_index_pcnt := AVE(GROUP,IF(h.cpi_photoproc_index = (TYPEOF(h.cpi_photoproc_index))'',0,100));
    maxlength_cpi_photoproc_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_photoproc_index)));
    avelength_cpi_photoproc_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_photoproc_index)),h.cpi_photoproc_index<>(typeof(h.cpi_photoproc_index))'');
    populated_cpi_publish_index_cnt := COUNT(GROUP,h.cpi_publish_index <> (TYPEOF(h.cpi_publish_index))'');
    populated_cpi_publish_index_pcnt := AVE(GROUP,IF(h.cpi_publish_index = (TYPEOF(h.cpi_publish_index))'',0,100));
    maxlength_cpi_publish_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_publish_index)));
    avelength_cpi_publish_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_publish_index)),h.cpi_publish_index<>(typeof(h.cpi_publish_index))'');
    populated_cpi_publish_books_index_cnt := COUNT(GROUP,h.cpi_publish_books_index <> (TYPEOF(h.cpi_publish_books_index))'');
    populated_cpi_publish_books_index_pcnt := AVE(GROUP,IF(h.cpi_publish_books_index = (TYPEOF(h.cpi_publish_books_index))'',0,100));
    maxlength_cpi_publish_books_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_publish_books_index)));
    avelength_cpi_publish_books_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_publish_books_index)),h.cpi_publish_books_index<>(typeof(h.cpi_publish_books_index))'');
    populated_cpi_publish_mags_index_cnt := COUNT(GROUP,h.cpi_publish_mags_index <> (TYPEOF(h.cpi_publish_mags_index))'');
    populated_cpi_publish_mags_index_pcnt := AVE(GROUP,IF(h.cpi_publish_mags_index = (TYPEOF(h.cpi_publish_mags_index))'',0,100));
    maxlength_cpi_publish_mags_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_publish_mags_index)));
    avelength_cpi_publish_mags_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_publish_mags_index)),h.cpi_publish_mags_index<>(typeof(h.cpi_publish_mags_index))'');
    populated_cpi_rural_index_cnt := COUNT(GROUP,h.cpi_rural_index <> (TYPEOF(h.cpi_rural_index))'');
    populated_cpi_rural_index_pcnt := AVE(GROUP,IF(h.cpi_rural_index = (TYPEOF(h.cpi_rural_index))'',0,100));
    maxlength_cpi_rural_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_rural_index)));
    avelength_cpi_rural_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_rural_index)),h.cpi_rural_index<>(typeof(h.cpi_rural_index))'');
    populated_cpi_science_index_cnt := COUNT(GROUP,h.cpi_science_index <> (TYPEOF(h.cpi_science_index))'');
    populated_cpi_science_index_pcnt := AVE(GROUP,IF(h.cpi_science_index = (TYPEOF(h.cpi_science_index))'',0,100));
    maxlength_cpi_science_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_science_index)));
    avelength_cpi_science_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_science_index)),h.cpi_science_index<>(typeof(h.cpi_science_index))'');
    populated_cpi_scifi_index_cnt := COUNT(GROUP,h.cpi_scifi_index <> (TYPEOF(h.cpi_scifi_index))'');
    populated_cpi_scifi_index_pcnt := AVE(GROUP,IF(h.cpi_scifi_index = (TYPEOF(h.cpi_scifi_index))'',0,100));
    maxlength_cpi_scifi_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_scifi_index)));
    avelength_cpi_scifi_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_scifi_index)),h.cpi_scifi_index<>(typeof(h.cpi_scifi_index))'');
    populated_cpi_seniors_index_cnt := COUNT(GROUP,h.cpi_seniors_index <> (TYPEOF(h.cpi_seniors_index))'');
    populated_cpi_seniors_index_pcnt := AVE(GROUP,IF(h.cpi_seniors_index = (TYPEOF(h.cpi_seniors_index))'',0,100));
    maxlength_cpi_seniors_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_seniors_index)));
    avelength_cpi_seniors_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_seniors_index)),h.cpi_seniors_index<>(typeof(h.cpi_seniors_index))'');
    populated_cpi_sports_index_cnt := COUNT(GROUP,h.cpi_sports_index <> (TYPEOF(h.cpi_sports_index))'');
    populated_cpi_sports_index_pcnt := AVE(GROUP,IF(h.cpi_sports_index = (TYPEOF(h.cpi_sports_index))'',0,100));
    maxlength_cpi_sports_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_index)));
    avelength_cpi_sports_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_index)),h.cpi_sports_index<>(typeof(h.cpi_sports_index))'');
    populated_cpi_sports_baseball_index_cnt := COUNT(GROUP,h.cpi_sports_baseball_index <> (TYPEOF(h.cpi_sports_baseball_index))'');
    populated_cpi_sports_baseball_index_pcnt := AVE(GROUP,IF(h.cpi_sports_baseball_index = (TYPEOF(h.cpi_sports_baseball_index))'',0,100));
    maxlength_cpi_sports_baseball_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_baseball_index)));
    avelength_cpi_sports_baseball_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_baseball_index)),h.cpi_sports_baseball_index<>(typeof(h.cpi_sports_baseball_index))'');
    populated_cpi_sports_basketball_index_cnt := COUNT(GROUP,h.cpi_sports_basketball_index <> (TYPEOF(h.cpi_sports_basketball_index))'');
    populated_cpi_sports_basketball_index_pcnt := AVE(GROUP,IF(h.cpi_sports_basketball_index = (TYPEOF(h.cpi_sports_basketball_index))'',0,100));
    maxlength_cpi_sports_basketball_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_basketball_index)));
    avelength_cpi_sports_basketball_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_basketball_index)),h.cpi_sports_basketball_index<>(typeof(h.cpi_sports_basketball_index))'');
    populated_cpi_sports_biking_index_cnt := COUNT(GROUP,h.cpi_sports_biking_index <> (TYPEOF(h.cpi_sports_biking_index))'');
    populated_cpi_sports_biking_index_pcnt := AVE(GROUP,IF(h.cpi_sports_biking_index = (TYPEOF(h.cpi_sports_biking_index))'',0,100));
    maxlength_cpi_sports_biking_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_biking_index)));
    avelength_cpi_sports_biking_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_biking_index)),h.cpi_sports_biking_index<>(typeof(h.cpi_sports_biking_index))'');
    populated_cpi_sports_football_index_cnt := COUNT(GROUP,h.cpi_sports_football_index <> (TYPEOF(h.cpi_sports_football_index))'');
    populated_cpi_sports_football_index_pcnt := AVE(GROUP,IF(h.cpi_sports_football_index = (TYPEOF(h.cpi_sports_football_index))'',0,100));
    maxlength_cpi_sports_football_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_football_index)));
    avelength_cpi_sports_football_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_football_index)),h.cpi_sports_football_index<>(typeof(h.cpi_sports_football_index))'');
    populated_cpi_sports_golf_index_cnt := COUNT(GROUP,h.cpi_sports_golf_index <> (TYPEOF(h.cpi_sports_golf_index))'');
    populated_cpi_sports_golf_index_pcnt := AVE(GROUP,IF(h.cpi_sports_golf_index = (TYPEOF(h.cpi_sports_golf_index))'',0,100));
    maxlength_cpi_sports_golf_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_golf_index)));
    avelength_cpi_sports_golf_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_golf_index)),h.cpi_sports_golf_index<>(typeof(h.cpi_sports_golf_index))'');
    populated_cpi_sports_hockey_index_cnt := COUNT(GROUP,h.cpi_sports_hockey_index <> (TYPEOF(h.cpi_sports_hockey_index))'');
    populated_cpi_sports_hockey_index_pcnt := AVE(GROUP,IF(h.cpi_sports_hockey_index = (TYPEOF(h.cpi_sports_hockey_index))'',0,100));
    maxlength_cpi_sports_hockey_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_hockey_index)));
    avelength_cpi_sports_hockey_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_hockey_index)),h.cpi_sports_hockey_index<>(typeof(h.cpi_sports_hockey_index))'');
    populated_cpi_sports_running_index_cnt := COUNT(GROUP,h.cpi_sports_running_index <> (TYPEOF(h.cpi_sports_running_index))'');
    populated_cpi_sports_running_index_pcnt := AVE(GROUP,IF(h.cpi_sports_running_index = (TYPEOF(h.cpi_sports_running_index))'',0,100));
    maxlength_cpi_sports_running_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_running_index)));
    avelength_cpi_sports_running_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_running_index)),h.cpi_sports_running_index<>(typeof(h.cpi_sports_running_index))'');
    populated_cpi_sports_ski_index_cnt := COUNT(GROUP,h.cpi_sports_ski_index <> (TYPEOF(h.cpi_sports_ski_index))'');
    populated_cpi_sports_ski_index_pcnt := AVE(GROUP,IF(h.cpi_sports_ski_index = (TYPEOF(h.cpi_sports_ski_index))'',0,100));
    maxlength_cpi_sports_ski_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_ski_index)));
    avelength_cpi_sports_ski_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_ski_index)),h.cpi_sports_ski_index<>(typeof(h.cpi_sports_ski_index))'');
    populated_cpi_sports_soccer_index_cnt := COUNT(GROUP,h.cpi_sports_soccer_index <> (TYPEOF(h.cpi_sports_soccer_index))'');
    populated_cpi_sports_soccer_index_pcnt := AVE(GROUP,IF(h.cpi_sports_soccer_index = (TYPEOF(h.cpi_sports_soccer_index))'',0,100));
    maxlength_cpi_sports_soccer_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_soccer_index)));
    avelength_cpi_sports_soccer_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_soccer_index)),h.cpi_sports_soccer_index<>(typeof(h.cpi_sports_soccer_index))'');
    populated_cpi_sports_swimming_index_cnt := COUNT(GROUP,h.cpi_sports_swimming_index <> (TYPEOF(h.cpi_sports_swimming_index))'');
    populated_cpi_sports_swimming_index_pcnt := AVE(GROUP,IF(h.cpi_sports_swimming_index = (TYPEOF(h.cpi_sports_swimming_index))'',0,100));
    maxlength_cpi_sports_swimming_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_swimming_index)));
    avelength_cpi_sports_swimming_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_swimming_index)),h.cpi_sports_swimming_index<>(typeof(h.cpi_sports_swimming_index))'');
    populated_cpi_sports_tennis_index_cnt := COUNT(GROUP,h.cpi_sports_tennis_index <> (TYPEOF(h.cpi_sports_tennis_index))'');
    populated_cpi_sports_tennis_index_pcnt := AVE(GROUP,IF(h.cpi_sports_tennis_index = (TYPEOF(h.cpi_sports_tennis_index))'',0,100));
    maxlength_cpi_sports_tennis_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_tennis_index)));
    avelength_cpi_sports_tennis_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sports_tennis_index)),h.cpi_sports_tennis_index<>(typeof(h.cpi_sports_tennis_index))'');
    populated_cpi_stationery_index_cnt := COUNT(GROUP,h.cpi_stationery_index <> (TYPEOF(h.cpi_stationery_index))'');
    populated_cpi_stationery_index_pcnt := AVE(GROUP,IF(h.cpi_stationery_index = (TYPEOF(h.cpi_stationery_index))'',0,100));
    maxlength_cpi_stationery_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_stationery_index)));
    avelength_cpi_stationery_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_stationery_index)),h.cpi_stationery_index<>(typeof(h.cpi_stationery_index))'');
    populated_cpi_sweeps_index_cnt := COUNT(GROUP,h.cpi_sweeps_index <> (TYPEOF(h.cpi_sweeps_index))'');
    populated_cpi_sweeps_index_pcnt := AVE(GROUP,IF(h.cpi_sweeps_index = (TYPEOF(h.cpi_sweeps_index))'',0,100));
    maxlength_cpi_sweeps_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sweeps_index)));
    avelength_cpi_sweeps_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_sweeps_index)),h.cpi_sweeps_index<>(typeof(h.cpi_sweeps_index))'');
    populated_cpi_tobacco_index_cnt := COUNT(GROUP,h.cpi_tobacco_index <> (TYPEOF(h.cpi_tobacco_index))'');
    populated_cpi_tobacco_index_pcnt := AVE(GROUP,IF(h.cpi_tobacco_index = (TYPEOF(h.cpi_tobacco_index))'',0,100));
    maxlength_cpi_tobacco_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_tobacco_index)));
    avelength_cpi_tobacco_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_tobacco_index)),h.cpi_tobacco_index<>(typeof(h.cpi_tobacco_index))'');
    populated_cpi_travel_index_cnt := COUNT(GROUP,h.cpi_travel_index <> (TYPEOF(h.cpi_travel_index))'');
    populated_cpi_travel_index_pcnt := AVE(GROUP,IF(h.cpi_travel_index = (TYPEOF(h.cpi_travel_index))'',0,100));
    maxlength_cpi_travel_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_travel_index)));
    avelength_cpi_travel_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_travel_index)),h.cpi_travel_index<>(typeof(h.cpi_travel_index))'');
    populated_cpi_travel_cruise_index_cnt := COUNT(GROUP,h.cpi_travel_cruise_index <> (TYPEOF(h.cpi_travel_cruise_index))'');
    populated_cpi_travel_cruise_index_pcnt := AVE(GROUP,IF(h.cpi_travel_cruise_index = (TYPEOF(h.cpi_travel_cruise_index))'',0,100));
    maxlength_cpi_travel_cruise_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_travel_cruise_index)));
    avelength_cpi_travel_cruise_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_travel_cruise_index)),h.cpi_travel_cruise_index<>(typeof(h.cpi_travel_cruise_index))'');
    populated_cpi_travel_rv_index_cnt := COUNT(GROUP,h.cpi_travel_rv_index <> (TYPEOF(h.cpi_travel_rv_index))'');
    populated_cpi_travel_rv_index_pcnt := AVE(GROUP,IF(h.cpi_travel_rv_index = (TYPEOF(h.cpi_travel_rv_index))'',0,100));
    maxlength_cpi_travel_rv_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_travel_rv_index)));
    avelength_cpi_travel_rv_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_travel_rv_index)),h.cpi_travel_rv_index<>(typeof(h.cpi_travel_rv_index))'');
    populated_cpi_travel_us_index_cnt := COUNT(GROUP,h.cpi_travel_us_index <> (TYPEOF(h.cpi_travel_us_index))'');
    populated_cpi_travel_us_index_pcnt := AVE(GROUP,IF(h.cpi_travel_us_index = (TYPEOF(h.cpi_travel_us_index))'',0,100));
    maxlength_cpi_travel_us_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_travel_us_index)));
    avelength_cpi_travel_us_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_travel_us_index)),h.cpi_travel_us_index<>(typeof(h.cpi_travel_us_index))'');
    populated_cpi_tvmovies_index_cnt := COUNT(GROUP,h.cpi_tvmovies_index <> (TYPEOF(h.cpi_tvmovies_index))'');
    populated_cpi_tvmovies_index_pcnt := AVE(GROUP,IF(h.cpi_tvmovies_index = (TYPEOF(h.cpi_tvmovies_index))'',0,100));
    maxlength_cpi_tvmovies_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_tvmovies_index)));
    avelength_cpi_tvmovies_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_tvmovies_index)),h.cpi_tvmovies_index<>(typeof(h.cpi_tvmovies_index))'');
    populated_cpi_wildlife_index_cnt := COUNT(GROUP,h.cpi_wildlife_index <> (TYPEOF(h.cpi_wildlife_index))'');
    populated_cpi_wildlife_index_pcnt := AVE(GROUP,IF(h.cpi_wildlife_index = (TYPEOF(h.cpi_wildlife_index))'',0,100));
    maxlength_cpi_wildlife_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_wildlife_index)));
    avelength_cpi_wildlife_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_wildlife_index)),h.cpi_wildlife_index<>(typeof(h.cpi_wildlife_index))'');
    populated_cpi_woman_index_cnt := COUNT(GROUP,h.cpi_woman_index <> (TYPEOF(h.cpi_woman_index))'');
    populated_cpi_woman_index_pcnt := AVE(GROUP,IF(h.cpi_woman_index = (TYPEOF(h.cpi_woman_index))'',0,100));
    maxlength_cpi_woman_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_woman_index)));
    avelength_cpi_woman_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_woman_index)),h.cpi_woman_index<>(typeof(h.cpi_woman_index))'');
    populated_totdlr_index_cnt := COUNT(GROUP,h.totdlr_index <> (TYPEOF(h.totdlr_index))'');
    populated_totdlr_index_pcnt := AVE(GROUP,IF(h.totdlr_index = (TYPEOF(h.totdlr_index))'',0,100));
    maxlength_totdlr_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.totdlr_index)));
    avelength_totdlr_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.totdlr_index)),h.totdlr_index<>(typeof(h.totdlr_index))'');
    populated_cpi_totdlr_cnt := COUNT(GROUP,h.cpi_totdlr <> (TYPEOF(h.cpi_totdlr))'');
    populated_cpi_totdlr_pcnt := AVE(GROUP,IF(h.cpi_totdlr = (TYPEOF(h.cpi_totdlr))'',0,100));
    maxlength_cpi_totdlr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_totdlr)));
    avelength_cpi_totdlr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_totdlr)),h.cpi_totdlr<>(typeof(h.cpi_totdlr))'');
    populated_cpi_totords_cnt := COUNT(GROUP,h.cpi_totords <> (TYPEOF(h.cpi_totords))'');
    populated_cpi_totords_pcnt := AVE(GROUP,IF(h.cpi_totords = (TYPEOF(h.cpi_totords))'',0,100));
    maxlength_cpi_totords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_totords)));
    avelength_cpi_totords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_totords)),h.cpi_totords<>(typeof(h.cpi_totords))'');
    populated_cpi_lastdlr_cnt := COUNT(GROUP,h.cpi_lastdlr <> (TYPEOF(h.cpi_lastdlr))'');
    populated_cpi_lastdlr_pcnt := AVE(GROUP,IF(h.cpi_lastdlr = (TYPEOF(h.cpi_lastdlr))'',0,100));
    maxlength_cpi_lastdlr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_lastdlr)));
    avelength_cpi_lastdlr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpi_lastdlr)),h.cpi_lastdlr<>(typeof(h.cpi_lastdlr))'');
    populated_pkcatg_cnt := COUNT(GROUP,h.pkcatg <> (TYPEOF(h.pkcatg))'');
    populated_pkcatg_pcnt := AVE(GROUP,IF(h.pkcatg = (TYPEOF(h.pkcatg))'',0,100));
    maxlength_pkcatg := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkcatg)));
    avelength_pkcatg := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkcatg)),h.pkcatg<>(typeof(h.pkcatg))'');
    populated_pkpubs_cnt := COUNT(GROUP,h.pkpubs <> (TYPEOF(h.pkpubs))'');
    populated_pkpubs_pcnt := AVE(GROUP,IF(h.pkpubs = (TYPEOF(h.pkpubs))'',0,100));
    maxlength_pkpubs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpubs)));
    avelength_pkpubs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpubs)),h.pkpubs<>(typeof(h.pkpubs))'');
    populated_pkcont_cnt := COUNT(GROUP,h.pkcont <> (TYPEOF(h.pkcont))'');
    populated_pkcont_pcnt := AVE(GROUP,IF(h.pkcont = (TYPEOF(h.pkcont))'',0,100));
    maxlength_pkcont := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkcont)));
    avelength_pkcont := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkcont)),h.pkcont<>(typeof(h.pkcont))'');
    populated_pkca01_cnt := COUNT(GROUP,h.pkca01 <> (TYPEOF(h.pkca01))'');
    populated_pkca01_pcnt := AVE(GROUP,IF(h.pkca01 = (TYPEOF(h.pkca01))'',0,100));
    maxlength_pkca01 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca01)));
    avelength_pkca01 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca01)),h.pkca01<>(typeof(h.pkca01))'');
    populated_pkca03_cnt := COUNT(GROUP,h.pkca03 <> (TYPEOF(h.pkca03))'');
    populated_pkca03_pcnt := AVE(GROUP,IF(h.pkca03 = (TYPEOF(h.pkca03))'',0,100));
    maxlength_pkca03 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca03)));
    avelength_pkca03 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca03)),h.pkca03<>(typeof(h.pkca03))'');
    populated_pkca04_cnt := COUNT(GROUP,h.pkca04 <> (TYPEOF(h.pkca04))'');
    populated_pkca04_pcnt := AVE(GROUP,IF(h.pkca04 = (TYPEOF(h.pkca04))'',0,100));
    maxlength_pkca04 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca04)));
    avelength_pkca04 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca04)),h.pkca04<>(typeof(h.pkca04))'');
    populated_pkca05_cnt := COUNT(GROUP,h.pkca05 <> (TYPEOF(h.pkca05))'');
    populated_pkca05_pcnt := AVE(GROUP,IF(h.pkca05 = (TYPEOF(h.pkca05))'',0,100));
    maxlength_pkca05 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca05)));
    avelength_pkca05 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca05)),h.pkca05<>(typeof(h.pkca05))'');
    populated_pkca06_cnt := COUNT(GROUP,h.pkca06 <> (TYPEOF(h.pkca06))'');
    populated_pkca06_pcnt := AVE(GROUP,IF(h.pkca06 = (TYPEOF(h.pkca06))'',0,100));
    maxlength_pkca06 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca06)));
    avelength_pkca06 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca06)),h.pkca06<>(typeof(h.pkca06))'');
    populated_pkca07_cnt := COUNT(GROUP,h.pkca07 <> (TYPEOF(h.pkca07))'');
    populated_pkca07_pcnt := AVE(GROUP,IF(h.pkca07 = (TYPEOF(h.pkca07))'',0,100));
    maxlength_pkca07 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca07)));
    avelength_pkca07 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca07)),h.pkca07<>(typeof(h.pkca07))'');
    populated_pkca08_cnt := COUNT(GROUP,h.pkca08 <> (TYPEOF(h.pkca08))'');
    populated_pkca08_pcnt := AVE(GROUP,IF(h.pkca08 = (TYPEOF(h.pkca08))'',0,100));
    maxlength_pkca08 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca08)));
    avelength_pkca08 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca08)),h.pkca08<>(typeof(h.pkca08))'');
    populated_pkca09_cnt := COUNT(GROUP,h.pkca09 <> (TYPEOF(h.pkca09))'');
    populated_pkca09_pcnt := AVE(GROUP,IF(h.pkca09 = (TYPEOF(h.pkca09))'',0,100));
    maxlength_pkca09 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca09)));
    avelength_pkca09 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca09)),h.pkca09<>(typeof(h.pkca09))'');
    populated_pkca10_cnt := COUNT(GROUP,h.pkca10 <> (TYPEOF(h.pkca10))'');
    populated_pkca10_pcnt := AVE(GROUP,IF(h.pkca10 = (TYPEOF(h.pkca10))'',0,100));
    maxlength_pkca10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca10)));
    avelength_pkca10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca10)),h.pkca10<>(typeof(h.pkca10))'');
    populated_pkca11_cnt := COUNT(GROUP,h.pkca11 <> (TYPEOF(h.pkca11))'');
    populated_pkca11_pcnt := AVE(GROUP,IF(h.pkca11 = (TYPEOF(h.pkca11))'',0,100));
    maxlength_pkca11 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca11)));
    avelength_pkca11 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca11)),h.pkca11<>(typeof(h.pkca11))'');
    populated_pkca12_cnt := COUNT(GROUP,h.pkca12 <> (TYPEOF(h.pkca12))'');
    populated_pkca12_pcnt := AVE(GROUP,IF(h.pkca12 = (TYPEOF(h.pkca12))'',0,100));
    maxlength_pkca12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca12)));
    avelength_pkca12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca12)),h.pkca12<>(typeof(h.pkca12))'');
    populated_pkca13_cnt := COUNT(GROUP,h.pkca13 <> (TYPEOF(h.pkca13))'');
    populated_pkca13_pcnt := AVE(GROUP,IF(h.pkca13 = (TYPEOF(h.pkca13))'',0,100));
    maxlength_pkca13 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca13)));
    avelength_pkca13 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca13)),h.pkca13<>(typeof(h.pkca13))'');
    populated_pkca14_cnt := COUNT(GROUP,h.pkca14 <> (TYPEOF(h.pkca14))'');
    populated_pkca14_pcnt := AVE(GROUP,IF(h.pkca14 = (TYPEOF(h.pkca14))'',0,100));
    maxlength_pkca14 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca14)));
    avelength_pkca14 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca14)),h.pkca14<>(typeof(h.pkca14))'');
    populated_pkca15_cnt := COUNT(GROUP,h.pkca15 <> (TYPEOF(h.pkca15))'');
    populated_pkca15_pcnt := AVE(GROUP,IF(h.pkca15 = (TYPEOF(h.pkca15))'',0,100));
    maxlength_pkca15 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca15)));
    avelength_pkca15 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca15)),h.pkca15<>(typeof(h.pkca15))'');
    populated_pkca16_cnt := COUNT(GROUP,h.pkca16 <> (TYPEOF(h.pkca16))'');
    populated_pkca16_pcnt := AVE(GROUP,IF(h.pkca16 = (TYPEOF(h.pkca16))'',0,100));
    maxlength_pkca16 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca16)));
    avelength_pkca16 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca16)),h.pkca16<>(typeof(h.pkca16))'');
    populated_pkca17_cnt := COUNT(GROUP,h.pkca17 <> (TYPEOF(h.pkca17))'');
    populated_pkca17_pcnt := AVE(GROUP,IF(h.pkca17 = (TYPEOF(h.pkca17))'',0,100));
    maxlength_pkca17 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca17)));
    avelength_pkca17 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca17)),h.pkca17<>(typeof(h.pkca17))'');
    populated_pkca18_cnt := COUNT(GROUP,h.pkca18 <> (TYPEOF(h.pkca18))'');
    populated_pkca18_pcnt := AVE(GROUP,IF(h.pkca18 = (TYPEOF(h.pkca18))'',0,100));
    maxlength_pkca18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca18)));
    avelength_pkca18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca18)),h.pkca18<>(typeof(h.pkca18))'');
    populated_pkca20_cnt := COUNT(GROUP,h.pkca20 <> (TYPEOF(h.pkca20))'');
    populated_pkca20_pcnt := AVE(GROUP,IF(h.pkca20 = (TYPEOF(h.pkca20))'',0,100));
    maxlength_pkca20 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca20)));
    avelength_pkca20 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca20)),h.pkca20<>(typeof(h.pkca20))'');
    populated_pkca21_cnt := COUNT(GROUP,h.pkca21 <> (TYPEOF(h.pkca21))'');
    populated_pkca21_pcnt := AVE(GROUP,IF(h.pkca21 = (TYPEOF(h.pkca21))'',0,100));
    maxlength_pkca21 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca21)));
    avelength_pkca21 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca21)),h.pkca21<>(typeof(h.pkca21))'');
    populated_pkca22_cnt := COUNT(GROUP,h.pkca22 <> (TYPEOF(h.pkca22))'');
    populated_pkca22_pcnt := AVE(GROUP,IF(h.pkca22 = (TYPEOF(h.pkca22))'',0,100));
    maxlength_pkca22 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca22)));
    avelength_pkca22 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca22)),h.pkca22<>(typeof(h.pkca22))'');
    populated_pkca23_cnt := COUNT(GROUP,h.pkca23 <> (TYPEOF(h.pkca23))'');
    populated_pkca23_pcnt := AVE(GROUP,IF(h.pkca23 = (TYPEOF(h.pkca23))'',0,100));
    maxlength_pkca23 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca23)));
    avelength_pkca23 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca23)),h.pkca23<>(typeof(h.pkca23))'');
    populated_pkca24_cnt := COUNT(GROUP,h.pkca24 <> (TYPEOF(h.pkca24))'');
    populated_pkca24_pcnt := AVE(GROUP,IF(h.pkca24 = (TYPEOF(h.pkca24))'',0,100));
    maxlength_pkca24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca24)));
    avelength_pkca24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca24)),h.pkca24<>(typeof(h.pkca24))'');
    populated_pkca25_cnt := COUNT(GROUP,h.pkca25 <> (TYPEOF(h.pkca25))'');
    populated_pkca25_pcnt := AVE(GROUP,IF(h.pkca25 = (TYPEOF(h.pkca25))'',0,100));
    maxlength_pkca25 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca25)));
    avelength_pkca25 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca25)),h.pkca25<>(typeof(h.pkca25))'');
    populated_pkca26_cnt := COUNT(GROUP,h.pkca26 <> (TYPEOF(h.pkca26))'');
    populated_pkca26_pcnt := AVE(GROUP,IF(h.pkca26 = (TYPEOF(h.pkca26))'',0,100));
    maxlength_pkca26 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca26)));
    avelength_pkca26 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca26)),h.pkca26<>(typeof(h.pkca26))'');
    populated_pkca28_cnt := COUNT(GROUP,h.pkca28 <> (TYPEOF(h.pkca28))'');
    populated_pkca28_pcnt := AVE(GROUP,IF(h.pkca28 = (TYPEOF(h.pkca28))'',0,100));
    maxlength_pkca28 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca28)));
    avelength_pkca28 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca28)),h.pkca28<>(typeof(h.pkca28))'');
    populated_pkca29_cnt := COUNT(GROUP,h.pkca29 <> (TYPEOF(h.pkca29))'');
    populated_pkca29_pcnt := AVE(GROUP,IF(h.pkca29 = (TYPEOF(h.pkca29))'',0,100));
    maxlength_pkca29 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca29)));
    avelength_pkca29 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca29)),h.pkca29<>(typeof(h.pkca29))'');
    populated_pkca30_cnt := COUNT(GROUP,h.pkca30 <> (TYPEOF(h.pkca30))'');
    populated_pkca30_pcnt := AVE(GROUP,IF(h.pkca30 = (TYPEOF(h.pkca30))'',0,100));
    maxlength_pkca30 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca30)));
    avelength_pkca30 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca30)),h.pkca30<>(typeof(h.pkca30))'');
    populated_pkca31_cnt := COUNT(GROUP,h.pkca31 <> (TYPEOF(h.pkca31))'');
    populated_pkca31_pcnt := AVE(GROUP,IF(h.pkca31 = (TYPEOF(h.pkca31))'',0,100));
    maxlength_pkca31 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca31)));
    avelength_pkca31 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca31)),h.pkca31<>(typeof(h.pkca31))'');
    populated_pkca32_cnt := COUNT(GROUP,h.pkca32 <> (TYPEOF(h.pkca32))'');
    populated_pkca32_pcnt := AVE(GROUP,IF(h.pkca32 = (TYPEOF(h.pkca32))'',0,100));
    maxlength_pkca32 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca32)));
    avelength_pkca32 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca32)),h.pkca32<>(typeof(h.pkca32))'');
    populated_pkca33_cnt := COUNT(GROUP,h.pkca33 <> (TYPEOF(h.pkca33))'');
    populated_pkca33_pcnt := AVE(GROUP,IF(h.pkca33 = (TYPEOF(h.pkca33))'',0,100));
    maxlength_pkca33 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca33)));
    avelength_pkca33 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca33)),h.pkca33<>(typeof(h.pkca33))'');
    populated_pkca34_cnt := COUNT(GROUP,h.pkca34 <> (TYPEOF(h.pkca34))'');
    populated_pkca34_pcnt := AVE(GROUP,IF(h.pkca34 = (TYPEOF(h.pkca34))'',0,100));
    maxlength_pkca34 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca34)));
    avelength_pkca34 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca34)),h.pkca34<>(typeof(h.pkca34))'');
    populated_pkca35_cnt := COUNT(GROUP,h.pkca35 <> (TYPEOF(h.pkca35))'');
    populated_pkca35_pcnt := AVE(GROUP,IF(h.pkca35 = (TYPEOF(h.pkca35))'',0,100));
    maxlength_pkca35 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca35)));
    avelength_pkca35 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca35)),h.pkca35<>(typeof(h.pkca35))'');
    populated_pkca36_cnt := COUNT(GROUP,h.pkca36 <> (TYPEOF(h.pkca36))'');
    populated_pkca36_pcnt := AVE(GROUP,IF(h.pkca36 = (TYPEOF(h.pkca36))'',0,100));
    maxlength_pkca36 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca36)));
    avelength_pkca36 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca36)),h.pkca36<>(typeof(h.pkca36))'');
    populated_pkca37_cnt := COUNT(GROUP,h.pkca37 <> (TYPEOF(h.pkca37))'');
    populated_pkca37_pcnt := AVE(GROUP,IF(h.pkca37 = (TYPEOF(h.pkca37))'',0,100));
    maxlength_pkca37 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca37)));
    avelength_pkca37 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca37)),h.pkca37<>(typeof(h.pkca37))'');
    populated_pkca39_cnt := COUNT(GROUP,h.pkca39 <> (TYPEOF(h.pkca39))'');
    populated_pkca39_pcnt := AVE(GROUP,IF(h.pkca39 = (TYPEOF(h.pkca39))'',0,100));
    maxlength_pkca39 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca39)));
    avelength_pkca39 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca39)),h.pkca39<>(typeof(h.pkca39))'');
    populated_pkca40_cnt := COUNT(GROUP,h.pkca40 <> (TYPEOF(h.pkca40))'');
    populated_pkca40_pcnt := AVE(GROUP,IF(h.pkca40 = (TYPEOF(h.pkca40))'',0,100));
    maxlength_pkca40 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca40)));
    avelength_pkca40 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca40)),h.pkca40<>(typeof(h.pkca40))'');
    populated_pkca41_cnt := COUNT(GROUP,h.pkca41 <> (TYPEOF(h.pkca41))'');
    populated_pkca41_pcnt := AVE(GROUP,IF(h.pkca41 = (TYPEOF(h.pkca41))'',0,100));
    maxlength_pkca41 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca41)));
    avelength_pkca41 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca41)),h.pkca41<>(typeof(h.pkca41))'');
    populated_pkca42_cnt := COUNT(GROUP,h.pkca42 <> (TYPEOF(h.pkca42))'');
    populated_pkca42_pcnt := AVE(GROUP,IF(h.pkca42 = (TYPEOF(h.pkca42))'',0,100));
    maxlength_pkca42 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca42)));
    avelength_pkca42 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca42)),h.pkca42<>(typeof(h.pkca42))'');
    populated_pkca54_cnt := COUNT(GROUP,h.pkca54 <> (TYPEOF(h.pkca54))'');
    populated_pkca54_pcnt := AVE(GROUP,IF(h.pkca54 = (TYPEOF(h.pkca54))'',0,100));
    maxlength_pkca54 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca54)));
    avelength_pkca54 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca54)),h.pkca54<>(typeof(h.pkca54))'');
    populated_pkca61_cnt := COUNT(GROUP,h.pkca61 <> (TYPEOF(h.pkca61))'');
    populated_pkca61_pcnt := AVE(GROUP,IF(h.pkca61 = (TYPEOF(h.pkca61))'',0,100));
    maxlength_pkca61 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca61)));
    avelength_pkca61 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca61)),h.pkca61<>(typeof(h.pkca61))'');
    populated_pkca62_cnt := COUNT(GROUP,h.pkca62 <> (TYPEOF(h.pkca62))'');
    populated_pkca62_pcnt := AVE(GROUP,IF(h.pkca62 = (TYPEOF(h.pkca62))'',0,100));
    maxlength_pkca62 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca62)));
    avelength_pkca62 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca62)),h.pkca62<>(typeof(h.pkca62))'');
    populated_pkca64_cnt := COUNT(GROUP,h.pkca64 <> (TYPEOF(h.pkca64))'');
    populated_pkca64_pcnt := AVE(GROUP,IF(h.pkca64 = (TYPEOF(h.pkca64))'',0,100));
    maxlength_pkca64 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca64)));
    avelength_pkca64 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkca64)),h.pkca64<>(typeof(h.pkca64))'');
    populated_pkpu01_cnt := COUNT(GROUP,h.pkpu01 <> (TYPEOF(h.pkpu01))'');
    populated_pkpu01_pcnt := AVE(GROUP,IF(h.pkpu01 = (TYPEOF(h.pkpu01))'',0,100));
    maxlength_pkpu01 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu01)));
    avelength_pkpu01 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu01)),h.pkpu01<>(typeof(h.pkpu01))'');
    populated_pkpu02_cnt := COUNT(GROUP,h.pkpu02 <> (TYPEOF(h.pkpu02))'');
    populated_pkpu02_pcnt := AVE(GROUP,IF(h.pkpu02 = (TYPEOF(h.pkpu02))'',0,100));
    maxlength_pkpu02 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu02)));
    avelength_pkpu02 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu02)),h.pkpu02<>(typeof(h.pkpu02))'');
    populated_pkpu03_cnt := COUNT(GROUP,h.pkpu03 <> (TYPEOF(h.pkpu03))'');
    populated_pkpu03_pcnt := AVE(GROUP,IF(h.pkpu03 = (TYPEOF(h.pkpu03))'',0,100));
    maxlength_pkpu03 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu03)));
    avelength_pkpu03 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu03)),h.pkpu03<>(typeof(h.pkpu03))'');
    populated_pkpu04_cnt := COUNT(GROUP,h.pkpu04 <> (TYPEOF(h.pkpu04))'');
    populated_pkpu04_pcnt := AVE(GROUP,IF(h.pkpu04 = (TYPEOF(h.pkpu04))'',0,100));
    maxlength_pkpu04 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu04)));
    avelength_pkpu04 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu04)),h.pkpu04<>(typeof(h.pkpu04))'');
    populated_pkpu05_cnt := COUNT(GROUP,h.pkpu05 <> (TYPEOF(h.pkpu05))'');
    populated_pkpu05_pcnt := AVE(GROUP,IF(h.pkpu05 = (TYPEOF(h.pkpu05))'',0,100));
    maxlength_pkpu05 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu05)));
    avelength_pkpu05 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu05)),h.pkpu05<>(typeof(h.pkpu05))'');
    populated_pkpu06_cnt := COUNT(GROUP,h.pkpu06 <> (TYPEOF(h.pkpu06))'');
    populated_pkpu06_pcnt := AVE(GROUP,IF(h.pkpu06 = (TYPEOF(h.pkpu06))'',0,100));
    maxlength_pkpu06 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu06)));
    avelength_pkpu06 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu06)),h.pkpu06<>(typeof(h.pkpu06))'');
    populated_pkpu07_cnt := COUNT(GROUP,h.pkpu07 <> (TYPEOF(h.pkpu07))'');
    populated_pkpu07_pcnt := AVE(GROUP,IF(h.pkpu07 = (TYPEOF(h.pkpu07))'',0,100));
    maxlength_pkpu07 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu07)));
    avelength_pkpu07 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu07)),h.pkpu07<>(typeof(h.pkpu07))'');
    populated_pkpu08_cnt := COUNT(GROUP,h.pkpu08 <> (TYPEOF(h.pkpu08))'');
    populated_pkpu08_pcnt := AVE(GROUP,IF(h.pkpu08 = (TYPEOF(h.pkpu08))'',0,100));
    maxlength_pkpu08 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu08)));
    avelength_pkpu08 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu08)),h.pkpu08<>(typeof(h.pkpu08))'');
    populated_pkpu09_cnt := COUNT(GROUP,h.pkpu09 <> (TYPEOF(h.pkpu09))'');
    populated_pkpu09_pcnt := AVE(GROUP,IF(h.pkpu09 = (TYPEOF(h.pkpu09))'',0,100));
    maxlength_pkpu09 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu09)));
    avelength_pkpu09 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu09)),h.pkpu09<>(typeof(h.pkpu09))'');
    populated_pkpu10_cnt := COUNT(GROUP,h.pkpu10 <> (TYPEOF(h.pkpu10))'');
    populated_pkpu10_pcnt := AVE(GROUP,IF(h.pkpu10 = (TYPEOF(h.pkpu10))'',0,100));
    maxlength_pkpu10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu10)));
    avelength_pkpu10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu10)),h.pkpu10<>(typeof(h.pkpu10))'');
    populated_pkpu11_cnt := COUNT(GROUP,h.pkpu11 <> (TYPEOF(h.pkpu11))'');
    populated_pkpu11_pcnt := AVE(GROUP,IF(h.pkpu11 = (TYPEOF(h.pkpu11))'',0,100));
    maxlength_pkpu11 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu11)));
    avelength_pkpu11 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu11)),h.pkpu11<>(typeof(h.pkpu11))'');
    populated_pkpu12_cnt := COUNT(GROUP,h.pkpu12 <> (TYPEOF(h.pkpu12))'');
    populated_pkpu12_pcnt := AVE(GROUP,IF(h.pkpu12 = (TYPEOF(h.pkpu12))'',0,100));
    maxlength_pkpu12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu12)));
    avelength_pkpu12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu12)),h.pkpu12<>(typeof(h.pkpu12))'');
    populated_pkpu13_cnt := COUNT(GROUP,h.pkpu13 <> (TYPEOF(h.pkpu13))'');
    populated_pkpu13_pcnt := AVE(GROUP,IF(h.pkpu13 = (TYPEOF(h.pkpu13))'',0,100));
    maxlength_pkpu13 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu13)));
    avelength_pkpu13 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu13)),h.pkpu13<>(typeof(h.pkpu13))'');
    populated_pkpu14_cnt := COUNT(GROUP,h.pkpu14 <> (TYPEOF(h.pkpu14))'');
    populated_pkpu14_pcnt := AVE(GROUP,IF(h.pkpu14 = (TYPEOF(h.pkpu14))'',0,100));
    maxlength_pkpu14 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu14)));
    avelength_pkpu14 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu14)),h.pkpu14<>(typeof(h.pkpu14))'');
    populated_pkpu15_cnt := COUNT(GROUP,h.pkpu15 <> (TYPEOF(h.pkpu15))'');
    populated_pkpu15_pcnt := AVE(GROUP,IF(h.pkpu15 = (TYPEOF(h.pkpu15))'',0,100));
    maxlength_pkpu15 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu15)));
    avelength_pkpu15 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu15)),h.pkpu15<>(typeof(h.pkpu15))'');
    populated_pkpu16_cnt := COUNT(GROUP,h.pkpu16 <> (TYPEOF(h.pkpu16))'');
    populated_pkpu16_pcnt := AVE(GROUP,IF(h.pkpu16 = (TYPEOF(h.pkpu16))'',0,100));
    maxlength_pkpu16 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu16)));
    avelength_pkpu16 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu16)),h.pkpu16<>(typeof(h.pkpu16))'');
    populated_pkpu17_cnt := COUNT(GROUP,h.pkpu17 <> (TYPEOF(h.pkpu17))'');
    populated_pkpu17_pcnt := AVE(GROUP,IF(h.pkpu17 = (TYPEOF(h.pkpu17))'',0,100));
    maxlength_pkpu17 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu17)));
    avelength_pkpu17 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu17)),h.pkpu17<>(typeof(h.pkpu17))'');
    populated_pkpu18_cnt := COUNT(GROUP,h.pkpu18 <> (TYPEOF(h.pkpu18))'');
    populated_pkpu18_pcnt := AVE(GROUP,IF(h.pkpu18 = (TYPEOF(h.pkpu18))'',0,100));
    maxlength_pkpu18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu18)));
    avelength_pkpu18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu18)),h.pkpu18<>(typeof(h.pkpu18))'');
    populated_pkpu19_cnt := COUNT(GROUP,h.pkpu19 <> (TYPEOF(h.pkpu19))'');
    populated_pkpu19_pcnt := AVE(GROUP,IF(h.pkpu19 = (TYPEOF(h.pkpu19))'',0,100));
    maxlength_pkpu19 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu19)));
    avelength_pkpu19 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu19)),h.pkpu19<>(typeof(h.pkpu19))'');
    populated_pkpu20_cnt := COUNT(GROUP,h.pkpu20 <> (TYPEOF(h.pkpu20))'');
    populated_pkpu20_pcnt := AVE(GROUP,IF(h.pkpu20 = (TYPEOF(h.pkpu20))'',0,100));
    maxlength_pkpu20 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu20)));
    avelength_pkpu20 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu20)),h.pkpu20<>(typeof(h.pkpu20))'');
    populated_pkpu23_cnt := COUNT(GROUP,h.pkpu23 <> (TYPEOF(h.pkpu23))'');
    populated_pkpu23_pcnt := AVE(GROUP,IF(h.pkpu23 = (TYPEOF(h.pkpu23))'',0,100));
    maxlength_pkpu23 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu23)));
    avelength_pkpu23 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu23)),h.pkpu23<>(typeof(h.pkpu23))'');
    populated_pkpu25_cnt := COUNT(GROUP,h.pkpu25 <> (TYPEOF(h.pkpu25))'');
    populated_pkpu25_pcnt := AVE(GROUP,IF(h.pkpu25 = (TYPEOF(h.pkpu25))'',0,100));
    maxlength_pkpu25 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu25)));
    avelength_pkpu25 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu25)),h.pkpu25<>(typeof(h.pkpu25))'');
    populated_pkpu27_cnt := COUNT(GROUP,h.pkpu27 <> (TYPEOF(h.pkpu27))'');
    populated_pkpu27_pcnt := AVE(GROUP,IF(h.pkpu27 = (TYPEOF(h.pkpu27))'',0,100));
    maxlength_pkpu27 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu27)));
    avelength_pkpu27 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu27)),h.pkpu27<>(typeof(h.pkpu27))'');
    populated_pkpu28_cnt := COUNT(GROUP,h.pkpu28 <> (TYPEOF(h.pkpu28))'');
    populated_pkpu28_pcnt := AVE(GROUP,IF(h.pkpu28 = (TYPEOF(h.pkpu28))'',0,100));
    maxlength_pkpu28 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu28)));
    avelength_pkpu28 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu28)),h.pkpu28<>(typeof(h.pkpu28))'');
    populated_pkpu29_cnt := COUNT(GROUP,h.pkpu29 <> (TYPEOF(h.pkpu29))'');
    populated_pkpu29_pcnt := AVE(GROUP,IF(h.pkpu29 = (TYPEOF(h.pkpu29))'',0,100));
    maxlength_pkpu29 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu29)));
    avelength_pkpu29 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu29)),h.pkpu29<>(typeof(h.pkpu29))'');
    populated_pkpu30_cnt := COUNT(GROUP,h.pkpu30 <> (TYPEOF(h.pkpu30))'');
    populated_pkpu30_pcnt := AVE(GROUP,IF(h.pkpu30 = (TYPEOF(h.pkpu30))'',0,100));
    maxlength_pkpu30 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu30)));
    avelength_pkpu30 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu30)),h.pkpu30<>(typeof(h.pkpu30))'');
    populated_pkpu31_cnt := COUNT(GROUP,h.pkpu31 <> (TYPEOF(h.pkpu31))'');
    populated_pkpu31_pcnt := AVE(GROUP,IF(h.pkpu31 = (TYPEOF(h.pkpu31))'',0,100));
    maxlength_pkpu31 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu31)));
    avelength_pkpu31 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu31)),h.pkpu31<>(typeof(h.pkpu31))'');
    populated_pkpu32_cnt := COUNT(GROUP,h.pkpu32 <> (TYPEOF(h.pkpu32))'');
    populated_pkpu32_pcnt := AVE(GROUP,IF(h.pkpu32 = (TYPEOF(h.pkpu32))'',0,100));
    maxlength_pkpu32 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu32)));
    avelength_pkpu32 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu32)),h.pkpu32<>(typeof(h.pkpu32))'');
    populated_pkpu33_cnt := COUNT(GROUP,h.pkpu33 <> (TYPEOF(h.pkpu33))'');
    populated_pkpu33_pcnt := AVE(GROUP,IF(h.pkpu33 = (TYPEOF(h.pkpu33))'',0,100));
    maxlength_pkpu33 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu33)));
    avelength_pkpu33 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu33)),h.pkpu33<>(typeof(h.pkpu33))'');
    populated_pkpu34_cnt := COUNT(GROUP,h.pkpu34 <> (TYPEOF(h.pkpu34))'');
    populated_pkpu34_pcnt := AVE(GROUP,IF(h.pkpu34 = (TYPEOF(h.pkpu34))'',0,100));
    maxlength_pkpu34 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu34)));
    avelength_pkpu34 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu34)),h.pkpu34<>(typeof(h.pkpu34))'');
    populated_pkpu35_cnt := COUNT(GROUP,h.pkpu35 <> (TYPEOF(h.pkpu35))'');
    populated_pkpu35_pcnt := AVE(GROUP,IF(h.pkpu35 = (TYPEOF(h.pkpu35))'',0,100));
    maxlength_pkpu35 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu35)));
    avelength_pkpu35 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu35)),h.pkpu35<>(typeof(h.pkpu35))'');
    populated_pkpu38_cnt := COUNT(GROUP,h.pkpu38 <> (TYPEOF(h.pkpu38))'');
    populated_pkpu38_pcnt := AVE(GROUP,IF(h.pkpu38 = (TYPEOF(h.pkpu38))'',0,100));
    maxlength_pkpu38 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu38)));
    avelength_pkpu38 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu38)),h.pkpu38<>(typeof(h.pkpu38))'');
    populated_pkpu41_cnt := COUNT(GROUP,h.pkpu41 <> (TYPEOF(h.pkpu41))'');
    populated_pkpu41_pcnt := AVE(GROUP,IF(h.pkpu41 = (TYPEOF(h.pkpu41))'',0,100));
    maxlength_pkpu41 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu41)));
    avelength_pkpu41 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu41)),h.pkpu41<>(typeof(h.pkpu41))'');
    populated_pkpu42_cnt := COUNT(GROUP,h.pkpu42 <> (TYPEOF(h.pkpu42))'');
    populated_pkpu42_pcnt := AVE(GROUP,IF(h.pkpu42 = (TYPEOF(h.pkpu42))'',0,100));
    maxlength_pkpu42 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu42)));
    avelength_pkpu42 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu42)),h.pkpu42<>(typeof(h.pkpu42))'');
    populated_pkpu45_cnt := COUNT(GROUP,h.pkpu45 <> (TYPEOF(h.pkpu45))'');
    populated_pkpu45_pcnt := AVE(GROUP,IF(h.pkpu45 = (TYPEOF(h.pkpu45))'',0,100));
    maxlength_pkpu45 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu45)));
    avelength_pkpu45 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu45)),h.pkpu45<>(typeof(h.pkpu45))'');
    populated_pkpu46_cnt := COUNT(GROUP,h.pkpu46 <> (TYPEOF(h.pkpu46))'');
    populated_pkpu46_pcnt := AVE(GROUP,IF(h.pkpu46 = (TYPEOF(h.pkpu46))'',0,100));
    maxlength_pkpu46 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu46)));
    avelength_pkpu46 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu46)),h.pkpu46<>(typeof(h.pkpu46))'');
    populated_pkpu47_cnt := COUNT(GROUP,h.pkpu47 <> (TYPEOF(h.pkpu47))'');
    populated_pkpu47_pcnt := AVE(GROUP,IF(h.pkpu47 = (TYPEOF(h.pkpu47))'',0,100));
    maxlength_pkpu47 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu47)));
    avelength_pkpu47 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu47)),h.pkpu47<>(typeof(h.pkpu47))'');
    populated_pkpu48_cnt := COUNT(GROUP,h.pkpu48 <> (TYPEOF(h.pkpu48))'');
    populated_pkpu48_pcnt := AVE(GROUP,IF(h.pkpu48 = (TYPEOF(h.pkpu48))'',0,100));
    maxlength_pkpu48 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu48)));
    avelength_pkpu48 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu48)),h.pkpu48<>(typeof(h.pkpu48))'');
    populated_pkpu49_cnt := COUNT(GROUP,h.pkpu49 <> (TYPEOF(h.pkpu49))'');
    populated_pkpu49_pcnt := AVE(GROUP,IF(h.pkpu49 = (TYPEOF(h.pkpu49))'',0,100));
    maxlength_pkpu49 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu49)));
    avelength_pkpu49 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu49)),h.pkpu49<>(typeof(h.pkpu49))'');
    populated_pkpu50_cnt := COUNT(GROUP,h.pkpu50 <> (TYPEOF(h.pkpu50))'');
    populated_pkpu50_pcnt := AVE(GROUP,IF(h.pkpu50 = (TYPEOF(h.pkpu50))'',0,100));
    maxlength_pkpu50 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu50)));
    avelength_pkpu50 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu50)),h.pkpu50<>(typeof(h.pkpu50))'');
    populated_pkpu51_cnt := COUNT(GROUP,h.pkpu51 <> (TYPEOF(h.pkpu51))'');
    populated_pkpu51_pcnt := AVE(GROUP,IF(h.pkpu51 = (TYPEOF(h.pkpu51))'',0,100));
    maxlength_pkpu51 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu51)));
    avelength_pkpu51 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu51)),h.pkpu51<>(typeof(h.pkpu51))'');
    populated_pkpu52_cnt := COUNT(GROUP,h.pkpu52 <> (TYPEOF(h.pkpu52))'');
    populated_pkpu52_pcnt := AVE(GROUP,IF(h.pkpu52 = (TYPEOF(h.pkpu52))'',0,100));
    maxlength_pkpu52 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu52)));
    avelength_pkpu52 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu52)),h.pkpu52<>(typeof(h.pkpu52))'');
    populated_pkpu53_cnt := COUNT(GROUP,h.pkpu53 <> (TYPEOF(h.pkpu53))'');
    populated_pkpu53_pcnt := AVE(GROUP,IF(h.pkpu53 = (TYPEOF(h.pkpu53))'',0,100));
    maxlength_pkpu53 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu53)));
    avelength_pkpu53 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu53)),h.pkpu53<>(typeof(h.pkpu53))'');
    populated_pkpu54_cnt := COUNT(GROUP,h.pkpu54 <> (TYPEOF(h.pkpu54))'');
    populated_pkpu54_pcnt := AVE(GROUP,IF(h.pkpu54 = (TYPEOF(h.pkpu54))'',0,100));
    maxlength_pkpu54 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu54)));
    avelength_pkpu54 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu54)),h.pkpu54<>(typeof(h.pkpu54))'');
    populated_pkpu55_cnt := COUNT(GROUP,h.pkpu55 <> (TYPEOF(h.pkpu55))'');
    populated_pkpu55_pcnt := AVE(GROUP,IF(h.pkpu55 = (TYPEOF(h.pkpu55))'',0,100));
    maxlength_pkpu55 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu55)));
    avelength_pkpu55 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu55)),h.pkpu55<>(typeof(h.pkpu55))'');
    populated_pkpu56_cnt := COUNT(GROUP,h.pkpu56 <> (TYPEOF(h.pkpu56))'');
    populated_pkpu56_pcnt := AVE(GROUP,IF(h.pkpu56 = (TYPEOF(h.pkpu56))'',0,100));
    maxlength_pkpu56 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu56)));
    avelength_pkpu56 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu56)),h.pkpu56<>(typeof(h.pkpu56))'');
    populated_pkpu57_cnt := COUNT(GROUP,h.pkpu57 <> (TYPEOF(h.pkpu57))'');
    populated_pkpu57_pcnt := AVE(GROUP,IF(h.pkpu57 = (TYPEOF(h.pkpu57))'',0,100));
    maxlength_pkpu57 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu57)));
    avelength_pkpu57 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu57)),h.pkpu57<>(typeof(h.pkpu57))'');
    populated_pkpu60_cnt := COUNT(GROUP,h.pkpu60 <> (TYPEOF(h.pkpu60))'');
    populated_pkpu60_pcnt := AVE(GROUP,IF(h.pkpu60 = (TYPEOF(h.pkpu60))'',0,100));
    maxlength_pkpu60 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu60)));
    avelength_pkpu60 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu60)),h.pkpu60<>(typeof(h.pkpu60))'');
    populated_pkpu61_cnt := COUNT(GROUP,h.pkpu61 <> (TYPEOF(h.pkpu61))'');
    populated_pkpu61_pcnt := AVE(GROUP,IF(h.pkpu61 = (TYPEOF(h.pkpu61))'',0,100));
    maxlength_pkpu61 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu61)));
    avelength_pkpu61 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu61)),h.pkpu61<>(typeof(h.pkpu61))'');
    populated_pkpu62_cnt := COUNT(GROUP,h.pkpu62 <> (TYPEOF(h.pkpu62))'');
    populated_pkpu62_pcnt := AVE(GROUP,IF(h.pkpu62 = (TYPEOF(h.pkpu62))'',0,100));
    maxlength_pkpu62 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu62)));
    avelength_pkpu62 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu62)),h.pkpu62<>(typeof(h.pkpu62))'');
    populated_pkpu63_cnt := COUNT(GROUP,h.pkpu63 <> (TYPEOF(h.pkpu63))'');
    populated_pkpu63_pcnt := AVE(GROUP,IF(h.pkpu63 = (TYPEOF(h.pkpu63))'',0,100));
    maxlength_pkpu63 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu63)));
    avelength_pkpu63 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu63)),h.pkpu63<>(typeof(h.pkpu63))'');
    populated_pkpu64_cnt := COUNT(GROUP,h.pkpu64 <> (TYPEOF(h.pkpu64))'');
    populated_pkpu64_pcnt := AVE(GROUP,IF(h.pkpu64 = (TYPEOF(h.pkpu64))'',0,100));
    maxlength_pkpu64 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu64)));
    avelength_pkpu64 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu64)),h.pkpu64<>(typeof(h.pkpu64))'');
    populated_pkpu65_cnt := COUNT(GROUP,h.pkpu65 <> (TYPEOF(h.pkpu65))'');
    populated_pkpu65_pcnt := AVE(GROUP,IF(h.pkpu65 = (TYPEOF(h.pkpu65))'',0,100));
    maxlength_pkpu65 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu65)));
    avelength_pkpu65 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu65)),h.pkpu65<>(typeof(h.pkpu65))'');
    populated_pkpu66_cnt := COUNT(GROUP,h.pkpu66 <> (TYPEOF(h.pkpu66))'');
    populated_pkpu66_pcnt := AVE(GROUP,IF(h.pkpu66 = (TYPEOF(h.pkpu66))'',0,100));
    maxlength_pkpu66 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu66)));
    avelength_pkpu66 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu66)),h.pkpu66<>(typeof(h.pkpu66))'');
    populated_pkpu67_cnt := COUNT(GROUP,h.pkpu67 <> (TYPEOF(h.pkpu67))'');
    populated_pkpu67_pcnt := AVE(GROUP,IF(h.pkpu67 = (TYPEOF(h.pkpu67))'',0,100));
    maxlength_pkpu67 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu67)));
    avelength_pkpu67 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu67)),h.pkpu67<>(typeof(h.pkpu67))'');
    populated_pkpu68_cnt := COUNT(GROUP,h.pkpu68 <> (TYPEOF(h.pkpu68))'');
    populated_pkpu68_pcnt := AVE(GROUP,IF(h.pkpu68 = (TYPEOF(h.pkpu68))'',0,100));
    maxlength_pkpu68 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu68)));
    avelength_pkpu68 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu68)),h.pkpu68<>(typeof(h.pkpu68))'');
    populated_pkpu69_cnt := COUNT(GROUP,h.pkpu69 <> (TYPEOF(h.pkpu69))'');
    populated_pkpu69_pcnt := AVE(GROUP,IF(h.pkpu69 = (TYPEOF(h.pkpu69))'',0,100));
    maxlength_pkpu69 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu69)));
    avelength_pkpu69 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu69)),h.pkpu69<>(typeof(h.pkpu69))'');
    populated_pkpu70_cnt := COUNT(GROUP,h.pkpu70 <> (TYPEOF(h.pkpu70))'');
    populated_pkpu70_pcnt := AVE(GROUP,IF(h.pkpu70 = (TYPEOF(h.pkpu70))'',0,100));
    maxlength_pkpu70 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu70)));
    avelength_pkpu70 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pkpu70)),h.pkpu70<>(typeof(h.pkpu70))'');
    populated_censpct_water_cnt := COUNT(GROUP,h.censpct_water <> (TYPEOF(h.censpct_water))'');
    populated_censpct_water_pcnt := AVE(GROUP,IF(h.censpct_water = (TYPEOF(h.censpct_water))'',0,100));
    maxlength_censpct_water := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_water)));
    avelength_censpct_water := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_water)),h.censpct_water<>(typeof(h.censpct_water))'');
    populated_cens_pop_density_cnt := COUNT(GROUP,h.cens_pop_density <> (TYPEOF(h.cens_pop_density))'');
    populated_cens_pop_density_pcnt := AVE(GROUP,IF(h.cens_pop_density = (TYPEOF(h.cens_pop_density))'',0,100));
    maxlength_cens_pop_density := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cens_pop_density)));
    avelength_cens_pop_density := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cens_pop_density)),h.cens_pop_density<>(typeof(h.cens_pop_density))'');
    populated_cens_hu_density_cnt := COUNT(GROUP,h.cens_hu_density <> (TYPEOF(h.cens_hu_density))'');
    populated_cens_hu_density_pcnt := AVE(GROUP,IF(h.cens_hu_density = (TYPEOF(h.cens_hu_density))'',0,100));
    maxlength_cens_hu_density := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cens_hu_density)));
    avelength_cens_hu_density := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cens_hu_density)),h.cens_hu_density<>(typeof(h.cens_hu_density))'');
    populated_censpct_pop_white_cnt := COUNT(GROUP,h.censpct_pop_white <> (TYPEOF(h.censpct_pop_white))'');
    populated_censpct_pop_white_pcnt := AVE(GROUP,IF(h.censpct_pop_white = (TYPEOF(h.censpct_pop_white))'',0,100));
    maxlength_censpct_pop_white := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_white)));
    avelength_censpct_pop_white := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_white)),h.censpct_pop_white<>(typeof(h.censpct_pop_white))'');
    populated_censpct_pop_black_cnt := COUNT(GROUP,h.censpct_pop_black <> (TYPEOF(h.censpct_pop_black))'');
    populated_censpct_pop_black_pcnt := AVE(GROUP,IF(h.censpct_pop_black = (TYPEOF(h.censpct_pop_black))'',0,100));
    maxlength_censpct_pop_black := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_black)));
    avelength_censpct_pop_black := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_black)),h.censpct_pop_black<>(typeof(h.censpct_pop_black))'');
    populated_censpct_pop_amerind_cnt := COUNT(GROUP,h.censpct_pop_amerind <> (TYPEOF(h.censpct_pop_amerind))'');
    populated_censpct_pop_amerind_pcnt := AVE(GROUP,IF(h.censpct_pop_amerind = (TYPEOF(h.censpct_pop_amerind))'',0,100));
    maxlength_censpct_pop_amerind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_amerind)));
    avelength_censpct_pop_amerind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_amerind)),h.censpct_pop_amerind<>(typeof(h.censpct_pop_amerind))'');
    populated_censpct_pop_asian_cnt := COUNT(GROUP,h.censpct_pop_asian <> (TYPEOF(h.censpct_pop_asian))'');
    populated_censpct_pop_asian_pcnt := AVE(GROUP,IF(h.censpct_pop_asian = (TYPEOF(h.censpct_pop_asian))'',0,100));
    maxlength_censpct_pop_asian := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_asian)));
    avelength_censpct_pop_asian := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_asian)),h.censpct_pop_asian<>(typeof(h.censpct_pop_asian))'');
    populated_censpct_pop_pacisl_cnt := COUNT(GROUP,h.censpct_pop_pacisl <> (TYPEOF(h.censpct_pop_pacisl))'');
    populated_censpct_pop_pacisl_pcnt := AVE(GROUP,IF(h.censpct_pop_pacisl = (TYPEOF(h.censpct_pop_pacisl))'',0,100));
    maxlength_censpct_pop_pacisl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_pacisl)));
    avelength_censpct_pop_pacisl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_pacisl)),h.censpct_pop_pacisl<>(typeof(h.censpct_pop_pacisl))'');
    populated_censpct_pop_othrace_cnt := COUNT(GROUP,h.censpct_pop_othrace <> (TYPEOF(h.censpct_pop_othrace))'');
    populated_censpct_pop_othrace_pcnt := AVE(GROUP,IF(h.censpct_pop_othrace = (TYPEOF(h.censpct_pop_othrace))'',0,100));
    maxlength_censpct_pop_othrace := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_othrace)));
    avelength_censpct_pop_othrace := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_othrace)),h.censpct_pop_othrace<>(typeof(h.censpct_pop_othrace))'');
    populated_censpct_pop_multirace_cnt := COUNT(GROUP,h.censpct_pop_multirace <> (TYPEOF(h.censpct_pop_multirace))'');
    populated_censpct_pop_multirace_pcnt := AVE(GROUP,IF(h.censpct_pop_multirace = (TYPEOF(h.censpct_pop_multirace))'',0,100));
    maxlength_censpct_pop_multirace := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_multirace)));
    avelength_censpct_pop_multirace := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_multirace)),h.censpct_pop_multirace<>(typeof(h.censpct_pop_multirace))'');
    populated_censpct_pop_hispanic_cnt := COUNT(GROUP,h.censpct_pop_hispanic <> (TYPEOF(h.censpct_pop_hispanic))'');
    populated_censpct_pop_hispanic_pcnt := AVE(GROUP,IF(h.censpct_pop_hispanic = (TYPEOF(h.censpct_pop_hispanic))'',0,100));
    maxlength_censpct_pop_hispanic := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_hispanic)));
    avelength_censpct_pop_hispanic := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_hispanic)),h.censpct_pop_hispanic<>(typeof(h.censpct_pop_hispanic))'');
    populated_censpct_pop_agelt18_cnt := COUNT(GROUP,h.censpct_pop_agelt18 <> (TYPEOF(h.censpct_pop_agelt18))'');
    populated_censpct_pop_agelt18_pcnt := AVE(GROUP,IF(h.censpct_pop_agelt18 = (TYPEOF(h.censpct_pop_agelt18))'',0,100));
    maxlength_censpct_pop_agelt18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_agelt18)));
    avelength_censpct_pop_agelt18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_agelt18)),h.censpct_pop_agelt18<>(typeof(h.censpct_pop_agelt18))'');
    populated_censpct_pop_males_cnt := COUNT(GROUP,h.censpct_pop_males <> (TYPEOF(h.censpct_pop_males))'');
    populated_censpct_pop_males_pcnt := AVE(GROUP,IF(h.censpct_pop_males = (TYPEOF(h.censpct_pop_males))'',0,100));
    maxlength_censpct_pop_males := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_males)));
    avelength_censpct_pop_males := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_pop_males)),h.censpct_pop_males<>(typeof(h.censpct_pop_males))'');
    populated_censpct_adult_age1824_cnt := COUNT(GROUP,h.censpct_adult_age1824 <> (TYPEOF(h.censpct_adult_age1824))'');
    populated_censpct_adult_age1824_pcnt := AVE(GROUP,IF(h.censpct_adult_age1824 = (TYPEOF(h.censpct_adult_age1824))'',0,100));
    maxlength_censpct_adult_age1824 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age1824)));
    avelength_censpct_adult_age1824 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age1824)),h.censpct_adult_age1824<>(typeof(h.censpct_adult_age1824))'');
    populated_censpct_adult_age2534_cnt := COUNT(GROUP,h.censpct_adult_age2534 <> (TYPEOF(h.censpct_adult_age2534))'');
    populated_censpct_adult_age2534_pcnt := AVE(GROUP,IF(h.censpct_adult_age2534 = (TYPEOF(h.censpct_adult_age2534))'',0,100));
    maxlength_censpct_adult_age2534 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age2534)));
    avelength_censpct_adult_age2534 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age2534)),h.censpct_adult_age2534<>(typeof(h.censpct_adult_age2534))'');
    populated_censpct_adult_age3544_cnt := COUNT(GROUP,h.censpct_adult_age3544 <> (TYPEOF(h.censpct_adult_age3544))'');
    populated_censpct_adult_age3544_pcnt := AVE(GROUP,IF(h.censpct_adult_age3544 = (TYPEOF(h.censpct_adult_age3544))'',0,100));
    maxlength_censpct_adult_age3544 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age3544)));
    avelength_censpct_adult_age3544 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age3544)),h.censpct_adult_age3544<>(typeof(h.censpct_adult_age3544))'');
    populated_censpct_adult_age4554_cnt := COUNT(GROUP,h.censpct_adult_age4554 <> (TYPEOF(h.censpct_adult_age4554))'');
    populated_censpct_adult_age4554_pcnt := AVE(GROUP,IF(h.censpct_adult_age4554 = (TYPEOF(h.censpct_adult_age4554))'',0,100));
    maxlength_censpct_adult_age4554 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age4554)));
    avelength_censpct_adult_age4554 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age4554)),h.censpct_adult_age4554<>(typeof(h.censpct_adult_age4554))'');
    populated_censpct_adult_age5564_cnt := COUNT(GROUP,h.censpct_adult_age5564 <> (TYPEOF(h.censpct_adult_age5564))'');
    populated_censpct_adult_age5564_pcnt := AVE(GROUP,IF(h.censpct_adult_age5564 = (TYPEOF(h.censpct_adult_age5564))'',0,100));
    maxlength_censpct_adult_age5564 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age5564)));
    avelength_censpct_adult_age5564 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_age5564)),h.censpct_adult_age5564<>(typeof(h.censpct_adult_age5564))'');
    populated_censpct_adult_agege65_cnt := COUNT(GROUP,h.censpct_adult_agege65 <> (TYPEOF(h.censpct_adult_agege65))'');
    populated_censpct_adult_agege65_pcnt := AVE(GROUP,IF(h.censpct_adult_agege65 = (TYPEOF(h.censpct_adult_agege65))'',0,100));
    maxlength_censpct_adult_agege65 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_agege65)));
    avelength_censpct_adult_agege65 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_adult_agege65)),h.censpct_adult_agege65<>(typeof(h.censpct_adult_agege65))'');
    populated_cens_pop_medage_cnt := COUNT(GROUP,h.cens_pop_medage <> (TYPEOF(h.cens_pop_medage))'');
    populated_cens_pop_medage_pcnt := AVE(GROUP,IF(h.cens_pop_medage = (TYPEOF(h.cens_pop_medage))'',0,100));
    maxlength_cens_pop_medage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cens_pop_medage)));
    avelength_cens_pop_medage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cens_pop_medage)),h.cens_pop_medage<>(typeof(h.cens_pop_medage))'');
    populated_cens_hh_avgsize_cnt := COUNT(GROUP,h.cens_hh_avgsize <> (TYPEOF(h.cens_hh_avgsize))'');
    populated_cens_hh_avgsize_pcnt := AVE(GROUP,IF(h.cens_hh_avgsize = (TYPEOF(h.cens_hh_avgsize))'',0,100));
    maxlength_cens_hh_avgsize := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cens_hh_avgsize)));
    avelength_cens_hh_avgsize := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cens_hh_avgsize)),h.cens_hh_avgsize<>(typeof(h.cens_hh_avgsize))'');
    populated_censpct_hh_family_cnt := COUNT(GROUP,h.censpct_hh_family <> (TYPEOF(h.censpct_hh_family))'');
    populated_censpct_hh_family_pcnt := AVE(GROUP,IF(h.censpct_hh_family = (TYPEOF(h.censpct_hh_family))'',0,100));
    maxlength_censpct_hh_family := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hh_family)));
    avelength_censpct_hh_family := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hh_family)),h.censpct_hh_family<>(typeof(h.censpct_hh_family))'');
    populated_censpct_hh_family_husbwife_cnt := COUNT(GROUP,h.censpct_hh_family_husbwife <> (TYPEOF(h.censpct_hh_family_husbwife))'');
    populated_censpct_hh_family_husbwife_pcnt := AVE(GROUP,IF(h.censpct_hh_family_husbwife = (TYPEOF(h.censpct_hh_family_husbwife))'',0,100));
    maxlength_censpct_hh_family_husbwife := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hh_family_husbwife)));
    avelength_censpct_hh_family_husbwife := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hh_family_husbwife)),h.censpct_hh_family_husbwife<>(typeof(h.censpct_hh_family_husbwife))'');
    populated_censpct_hu_occupied_cnt := COUNT(GROUP,h.censpct_hu_occupied <> (TYPEOF(h.censpct_hu_occupied))'');
    populated_censpct_hu_occupied_pcnt := AVE(GROUP,IF(h.censpct_hu_occupied = (TYPEOF(h.censpct_hu_occupied))'',0,100));
    maxlength_censpct_hu_occupied := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hu_occupied)));
    avelength_censpct_hu_occupied := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hu_occupied)),h.censpct_hu_occupied<>(typeof(h.censpct_hu_occupied))'');
    populated_censpct_hu_owned_cnt := COUNT(GROUP,h.censpct_hu_owned <> (TYPEOF(h.censpct_hu_owned))'');
    populated_censpct_hu_owned_pcnt := AVE(GROUP,IF(h.censpct_hu_owned = (TYPEOF(h.censpct_hu_owned))'',0,100));
    maxlength_censpct_hu_owned := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hu_owned)));
    avelength_censpct_hu_owned := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hu_owned)),h.censpct_hu_owned<>(typeof(h.censpct_hu_owned))'');
    populated_censpct_hu_rented_cnt := COUNT(GROUP,h.censpct_hu_rented <> (TYPEOF(h.censpct_hu_rented))'');
    populated_censpct_hu_rented_pcnt := AVE(GROUP,IF(h.censpct_hu_rented = (TYPEOF(h.censpct_hu_rented))'',0,100));
    maxlength_censpct_hu_rented := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hu_rented)));
    avelength_censpct_hu_rented := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hu_rented)),h.censpct_hu_rented<>(typeof(h.censpct_hu_rented))'');
    populated_censpct_hu_vacantseasonal_cnt := COUNT(GROUP,h.censpct_hu_vacantseasonal <> (TYPEOF(h.censpct_hu_vacantseasonal))'');
    populated_censpct_hu_vacantseasonal_pcnt := AVE(GROUP,IF(h.censpct_hu_vacantseasonal = (TYPEOF(h.censpct_hu_vacantseasonal))'',0,100));
    maxlength_censpct_hu_vacantseasonal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hu_vacantseasonal)));
    avelength_censpct_hu_vacantseasonal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censpct_hu_vacantseasonal)),h.censpct_hu_vacantseasonal<>(typeof(h.censpct_hu_vacantseasonal))'');
    populated_zip_medinc_cnt := COUNT(GROUP,h.zip_medinc <> (TYPEOF(h.zip_medinc))'');
    populated_zip_medinc_pcnt := AVE(GROUP,IF(h.zip_medinc = (TYPEOF(h.zip_medinc))'',0,100));
    maxlength_zip_medinc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_medinc)));
    avelength_zip_medinc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_medinc)),h.zip_medinc<>(typeof(h.zip_medinc))'');
    populated_zip_apparel_cnt := COUNT(GROUP,h.zip_apparel <> (TYPEOF(h.zip_apparel))'');
    populated_zip_apparel_pcnt := AVE(GROUP,IF(h.zip_apparel = (TYPEOF(h.zip_apparel))'',0,100));
    maxlength_zip_apparel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_apparel)));
    avelength_zip_apparel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_apparel)),h.zip_apparel<>(typeof(h.zip_apparel))'');
    populated_zip_apparel_women_cnt := COUNT(GROUP,h.zip_apparel_women <> (TYPEOF(h.zip_apparel_women))'');
    populated_zip_apparel_women_pcnt := AVE(GROUP,IF(h.zip_apparel_women = (TYPEOF(h.zip_apparel_women))'',0,100));
    maxlength_zip_apparel_women := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_apparel_women)));
    avelength_zip_apparel_women := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_apparel_women)),h.zip_apparel_women<>(typeof(h.zip_apparel_women))'');
    populated_zip_apparel_womfash_cnt := COUNT(GROUP,h.zip_apparel_womfash <> (TYPEOF(h.zip_apparel_womfash))'');
    populated_zip_apparel_womfash_pcnt := AVE(GROUP,IF(h.zip_apparel_womfash = (TYPEOF(h.zip_apparel_womfash))'',0,100));
    maxlength_zip_apparel_womfash := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_apparel_womfash)));
    avelength_zip_apparel_womfash := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_apparel_womfash)),h.zip_apparel_womfash<>(typeof(h.zip_apparel_womfash))'');
    populated_zip_auto_cnt := COUNT(GROUP,h.zip_auto <> (TYPEOF(h.zip_auto))'');
    populated_zip_auto_pcnt := AVE(GROUP,IF(h.zip_auto = (TYPEOF(h.zip_auto))'',0,100));
    maxlength_zip_auto := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_auto)));
    avelength_zip_auto := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_auto)),h.zip_auto<>(typeof(h.zip_auto))'');
    populated_zip_beauty_cnt := COUNT(GROUP,h.zip_beauty <> (TYPEOF(h.zip_beauty))'');
    populated_zip_beauty_pcnt := AVE(GROUP,IF(h.zip_beauty = (TYPEOF(h.zip_beauty))'',0,100));
    maxlength_zip_beauty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_beauty)));
    avelength_zip_beauty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_beauty)),h.zip_beauty<>(typeof(h.zip_beauty))'');
    populated_zip_booksmusicmovies_cnt := COUNT(GROUP,h.zip_booksmusicmovies <> (TYPEOF(h.zip_booksmusicmovies))'');
    populated_zip_booksmusicmovies_pcnt := AVE(GROUP,IF(h.zip_booksmusicmovies = (TYPEOF(h.zip_booksmusicmovies))'',0,100));
    maxlength_zip_booksmusicmovies := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_booksmusicmovies)));
    avelength_zip_booksmusicmovies := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_booksmusicmovies)),h.zip_booksmusicmovies<>(typeof(h.zip_booksmusicmovies))'');
    populated_zip_business_cnt := COUNT(GROUP,h.zip_business <> (TYPEOF(h.zip_business))'');
    populated_zip_business_pcnt := AVE(GROUP,IF(h.zip_business = (TYPEOF(h.zip_business))'',0,100));
    maxlength_zip_business := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_business)));
    avelength_zip_business := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_business)),h.zip_business<>(typeof(h.zip_business))'');
    populated_zip_catalog_cnt := COUNT(GROUP,h.zip_catalog <> (TYPEOF(h.zip_catalog))'');
    populated_zip_catalog_pcnt := AVE(GROUP,IF(h.zip_catalog = (TYPEOF(h.zip_catalog))'',0,100));
    maxlength_zip_catalog := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_catalog)));
    avelength_zip_catalog := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_catalog)),h.zip_catalog<>(typeof(h.zip_catalog))'');
    populated_zip_cc_cnt := COUNT(GROUP,h.zip_cc <> (TYPEOF(h.zip_cc))'');
    populated_zip_cc_pcnt := AVE(GROUP,IF(h.zip_cc = (TYPEOF(h.zip_cc))'',0,100));
    maxlength_zip_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_cc)));
    avelength_zip_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_cc)),h.zip_cc<>(typeof(h.zip_cc))'');
    populated_zip_collectibles_cnt := COUNT(GROUP,h.zip_collectibles <> (TYPEOF(h.zip_collectibles))'');
    populated_zip_collectibles_pcnt := AVE(GROUP,IF(h.zip_collectibles = (TYPEOF(h.zip_collectibles))'',0,100));
    maxlength_zip_collectibles := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_collectibles)));
    avelength_zip_collectibles := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_collectibles)),h.zip_collectibles<>(typeof(h.zip_collectibles))'');
    populated_zip_computers_cnt := COUNT(GROUP,h.zip_computers <> (TYPEOF(h.zip_computers))'');
    populated_zip_computers_pcnt := AVE(GROUP,IF(h.zip_computers = (TYPEOF(h.zip_computers))'',0,100));
    maxlength_zip_computers := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_computers)));
    avelength_zip_computers := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_computers)),h.zip_computers<>(typeof(h.zip_computers))'');
    populated_zip_continuity_cnt := COUNT(GROUP,h.zip_continuity <> (TYPEOF(h.zip_continuity))'');
    populated_zip_continuity_pcnt := AVE(GROUP,IF(h.zip_continuity = (TYPEOF(h.zip_continuity))'',0,100));
    maxlength_zip_continuity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_continuity)));
    avelength_zip_continuity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_continuity)),h.zip_continuity<>(typeof(h.zip_continuity))'');
    populated_zip_cooking_cnt := COUNT(GROUP,h.zip_cooking <> (TYPEOF(h.zip_cooking))'');
    populated_zip_cooking_pcnt := AVE(GROUP,IF(h.zip_cooking = (TYPEOF(h.zip_cooking))'',0,100));
    maxlength_zip_cooking := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_cooking)));
    avelength_zip_cooking := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_cooking)),h.zip_cooking<>(typeof(h.zip_cooking))'');
    populated_zip_crafts_cnt := COUNT(GROUP,h.zip_crafts <> (TYPEOF(h.zip_crafts))'');
    populated_zip_crafts_pcnt := AVE(GROUP,IF(h.zip_crafts = (TYPEOF(h.zip_crafts))'',0,100));
    maxlength_zip_crafts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_crafts)));
    avelength_zip_crafts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_crafts)),h.zip_crafts<>(typeof(h.zip_crafts))'');
    populated_zip_culturearts_cnt := COUNT(GROUP,h.zip_culturearts <> (TYPEOF(h.zip_culturearts))'');
    populated_zip_culturearts_pcnt := AVE(GROUP,IF(h.zip_culturearts = (TYPEOF(h.zip_culturearts))'',0,100));
    maxlength_zip_culturearts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_culturearts)));
    avelength_zip_culturearts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_culturearts)),h.zip_culturearts<>(typeof(h.zip_culturearts))'');
    populated_zip_dm_sold_cnt := COUNT(GROUP,h.zip_dm_sold <> (TYPEOF(h.zip_dm_sold))'');
    populated_zip_dm_sold_pcnt := AVE(GROUP,IF(h.zip_dm_sold = (TYPEOF(h.zip_dm_sold))'',0,100));
    maxlength_zip_dm_sold := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_dm_sold)));
    avelength_zip_dm_sold := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_dm_sold)),h.zip_dm_sold<>(typeof(h.zip_dm_sold))'');
    populated_zip_donor_cnt := COUNT(GROUP,h.zip_donor <> (TYPEOF(h.zip_donor))'');
    populated_zip_donor_pcnt := AVE(GROUP,IF(h.zip_donor = (TYPEOF(h.zip_donor))'',0,100));
    maxlength_zip_donor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_donor)));
    avelength_zip_donor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_donor)),h.zip_donor<>(typeof(h.zip_donor))'');
    populated_zip_family_cnt := COUNT(GROUP,h.zip_family <> (TYPEOF(h.zip_family))'');
    populated_zip_family_pcnt := AVE(GROUP,IF(h.zip_family = (TYPEOF(h.zip_family))'',0,100));
    maxlength_zip_family := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_family)));
    avelength_zip_family := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_family)),h.zip_family<>(typeof(h.zip_family))'');
    populated_zip_gardening_cnt := COUNT(GROUP,h.zip_gardening <> (TYPEOF(h.zip_gardening))'');
    populated_zip_gardening_pcnt := AVE(GROUP,IF(h.zip_gardening = (TYPEOF(h.zip_gardening))'',0,100));
    maxlength_zip_gardening := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_gardening)));
    avelength_zip_gardening := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_gardening)),h.zip_gardening<>(typeof(h.zip_gardening))'');
    populated_zip_giftgivr_cnt := COUNT(GROUP,h.zip_giftgivr <> (TYPEOF(h.zip_giftgivr))'');
    populated_zip_giftgivr_pcnt := AVE(GROUP,IF(h.zip_giftgivr = (TYPEOF(h.zip_giftgivr))'',0,100));
    maxlength_zip_giftgivr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_giftgivr)));
    avelength_zip_giftgivr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_giftgivr)),h.zip_giftgivr<>(typeof(h.zip_giftgivr))'');
    populated_zip_gourmet_cnt := COUNT(GROUP,h.zip_gourmet <> (TYPEOF(h.zip_gourmet))'');
    populated_zip_gourmet_pcnt := AVE(GROUP,IF(h.zip_gourmet = (TYPEOF(h.zip_gourmet))'',0,100));
    maxlength_zip_gourmet := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_gourmet)));
    avelength_zip_gourmet := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_gourmet)),h.zip_gourmet<>(typeof(h.zip_gourmet))'');
    populated_zip_health_cnt := COUNT(GROUP,h.zip_health <> (TYPEOF(h.zip_health))'');
    populated_zip_health_pcnt := AVE(GROUP,IF(h.zip_health = (TYPEOF(h.zip_health))'',0,100));
    maxlength_zip_health := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_health)));
    avelength_zip_health := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_health)),h.zip_health<>(typeof(h.zip_health))'');
    populated_zip_health_diet_cnt := COUNT(GROUP,h.zip_health_diet <> (TYPEOF(h.zip_health_diet))'');
    populated_zip_health_diet_pcnt := AVE(GROUP,IF(h.zip_health_diet = (TYPEOF(h.zip_health_diet))'',0,100));
    maxlength_zip_health_diet := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_health_diet)));
    avelength_zip_health_diet := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_health_diet)),h.zip_health_diet<>(typeof(h.zip_health_diet))'');
    populated_zip_health_fitness_cnt := COUNT(GROUP,h.zip_health_fitness <> (TYPEOF(h.zip_health_fitness))'');
    populated_zip_health_fitness_pcnt := AVE(GROUP,IF(h.zip_health_fitness = (TYPEOF(h.zip_health_fitness))'',0,100));
    maxlength_zip_health_fitness := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_health_fitness)));
    avelength_zip_health_fitness := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_health_fitness)),h.zip_health_fitness<>(typeof(h.zip_health_fitness))'');
    populated_zip_hobbies_cnt := COUNT(GROUP,h.zip_hobbies <> (TYPEOF(h.zip_hobbies))'');
    populated_zip_hobbies_pcnt := AVE(GROUP,IF(h.zip_hobbies = (TYPEOF(h.zip_hobbies))'',0,100));
    maxlength_zip_hobbies := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_hobbies)));
    avelength_zip_hobbies := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_hobbies)),h.zip_hobbies<>(typeof(h.zip_hobbies))'');
    populated_zip_homedecr_cnt := COUNT(GROUP,h.zip_homedecr <> (TYPEOF(h.zip_homedecr))'');
    populated_zip_homedecr_pcnt := AVE(GROUP,IF(h.zip_homedecr = (TYPEOF(h.zip_homedecr))'',0,100));
    maxlength_zip_homedecr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_homedecr)));
    avelength_zip_homedecr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_homedecr)),h.zip_homedecr<>(typeof(h.zip_homedecr))'');
    populated_zip_homeliv_cnt := COUNT(GROUP,h.zip_homeliv <> (TYPEOF(h.zip_homeliv))'');
    populated_zip_homeliv_pcnt := AVE(GROUP,IF(h.zip_homeliv = (TYPEOF(h.zip_homeliv))'',0,100));
    maxlength_zip_homeliv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_homeliv)));
    avelength_zip_homeliv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_homeliv)),h.zip_homeliv<>(typeof(h.zip_homeliv))'');
    populated_zip_internet_cnt := COUNT(GROUP,h.zip_internet <> (TYPEOF(h.zip_internet))'');
    populated_zip_internet_pcnt := AVE(GROUP,IF(h.zip_internet = (TYPEOF(h.zip_internet))'',0,100));
    maxlength_zip_internet := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_internet)));
    avelength_zip_internet := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_internet)),h.zip_internet<>(typeof(h.zip_internet))'');
    populated_zip_internet_access_cnt := COUNT(GROUP,h.zip_internet_access <> (TYPEOF(h.zip_internet_access))'');
    populated_zip_internet_access_pcnt := AVE(GROUP,IF(h.zip_internet_access = (TYPEOF(h.zip_internet_access))'',0,100));
    maxlength_zip_internet_access := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_internet_access)));
    avelength_zip_internet_access := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_internet_access)),h.zip_internet_access<>(typeof(h.zip_internet_access))'');
    populated_zip_internet_buy_cnt := COUNT(GROUP,h.zip_internet_buy <> (TYPEOF(h.zip_internet_buy))'');
    populated_zip_internet_buy_pcnt := AVE(GROUP,IF(h.zip_internet_buy = (TYPEOF(h.zip_internet_buy))'',0,100));
    maxlength_zip_internet_buy := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_internet_buy)));
    avelength_zip_internet_buy := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_internet_buy)),h.zip_internet_buy<>(typeof(h.zip_internet_buy))'');
    populated_zip_music_cnt := COUNT(GROUP,h.zip_music <> (TYPEOF(h.zip_music))'');
    populated_zip_music_pcnt := AVE(GROUP,IF(h.zip_music = (TYPEOF(h.zip_music))'',0,100));
    maxlength_zip_music := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_music)));
    avelength_zip_music := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_music)),h.zip_music<>(typeof(h.zip_music))'');
    populated_zip_outdoors_cnt := COUNT(GROUP,h.zip_outdoors <> (TYPEOF(h.zip_outdoors))'');
    populated_zip_outdoors_pcnt := AVE(GROUP,IF(h.zip_outdoors = (TYPEOF(h.zip_outdoors))'',0,100));
    maxlength_zip_outdoors := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_outdoors)));
    avelength_zip_outdoors := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_outdoors)),h.zip_outdoors<>(typeof(h.zip_outdoors))'');
    populated_zip_pets_cnt := COUNT(GROUP,h.zip_pets <> (TYPEOF(h.zip_pets))'');
    populated_zip_pets_pcnt := AVE(GROUP,IF(h.zip_pets = (TYPEOF(h.zip_pets))'',0,100));
    maxlength_zip_pets := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_pets)));
    avelength_zip_pets := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_pets)),h.zip_pets<>(typeof(h.zip_pets))'');
    populated_zip_pfin_cnt := COUNT(GROUP,h.zip_pfin <> (TYPEOF(h.zip_pfin))'');
    populated_zip_pfin_pcnt := AVE(GROUP,IF(h.zip_pfin = (TYPEOF(h.zip_pfin))'',0,100));
    maxlength_zip_pfin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_pfin)));
    avelength_zip_pfin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_pfin)),h.zip_pfin<>(typeof(h.zip_pfin))'');
    populated_zip_publish_cnt := COUNT(GROUP,h.zip_publish <> (TYPEOF(h.zip_publish))'');
    populated_zip_publish_pcnt := AVE(GROUP,IF(h.zip_publish = (TYPEOF(h.zip_publish))'',0,100));
    maxlength_zip_publish := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_publish)));
    avelength_zip_publish := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_publish)),h.zip_publish<>(typeof(h.zip_publish))'');
    populated_zip_publish_books_cnt := COUNT(GROUP,h.zip_publish_books <> (TYPEOF(h.zip_publish_books))'');
    populated_zip_publish_books_pcnt := AVE(GROUP,IF(h.zip_publish_books = (TYPEOF(h.zip_publish_books))'',0,100));
    maxlength_zip_publish_books := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_publish_books)));
    avelength_zip_publish_books := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_publish_books)),h.zip_publish_books<>(typeof(h.zip_publish_books))'');
    populated_zip_publish_mags_cnt := COUNT(GROUP,h.zip_publish_mags <> (TYPEOF(h.zip_publish_mags))'');
    populated_zip_publish_mags_pcnt := AVE(GROUP,IF(h.zip_publish_mags = (TYPEOF(h.zip_publish_mags))'',0,100));
    maxlength_zip_publish_mags := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_publish_mags)));
    avelength_zip_publish_mags := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_publish_mags)),h.zip_publish_mags<>(typeof(h.zip_publish_mags))'');
    populated_zip_sports_cnt := COUNT(GROUP,h.zip_sports <> (TYPEOF(h.zip_sports))'');
    populated_zip_sports_pcnt := AVE(GROUP,IF(h.zip_sports = (TYPEOF(h.zip_sports))'',0,100));
    maxlength_zip_sports := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_sports)));
    avelength_zip_sports := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_sports)),h.zip_sports<>(typeof(h.zip_sports))'');
    populated_zip_sports_biking_cnt := COUNT(GROUP,h.zip_sports_biking <> (TYPEOF(h.zip_sports_biking))'');
    populated_zip_sports_biking_pcnt := AVE(GROUP,IF(h.zip_sports_biking = (TYPEOF(h.zip_sports_biking))'',0,100));
    maxlength_zip_sports_biking := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_sports_biking)));
    avelength_zip_sports_biking := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_sports_biking)),h.zip_sports_biking<>(typeof(h.zip_sports_biking))'');
    populated_zip_sports_golf_cnt := COUNT(GROUP,h.zip_sports_golf <> (TYPEOF(h.zip_sports_golf))'');
    populated_zip_sports_golf_pcnt := AVE(GROUP,IF(h.zip_sports_golf = (TYPEOF(h.zip_sports_golf))'',0,100));
    maxlength_zip_sports_golf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_sports_golf)));
    avelength_zip_sports_golf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_sports_golf)),h.zip_sports_golf<>(typeof(h.zip_sports_golf))'');
    populated_zip_travel_cnt := COUNT(GROUP,h.zip_travel <> (TYPEOF(h.zip_travel))'');
    populated_zip_travel_pcnt := AVE(GROUP,IF(h.zip_travel = (TYPEOF(h.zip_travel))'',0,100));
    maxlength_zip_travel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_travel)));
    avelength_zip_travel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_travel)),h.zip_travel<>(typeof(h.zip_travel))'');
    populated_zip_travel_us_cnt := COUNT(GROUP,h.zip_travel_us <> (TYPEOF(h.zip_travel_us))'');
    populated_zip_travel_us_pcnt := AVE(GROUP,IF(h.zip_travel_us = (TYPEOF(h.zip_travel_us))'',0,100));
    maxlength_zip_travel_us := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_travel_us)));
    avelength_zip_travel_us := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_travel_us)),h.zip_travel_us<>(typeof(h.zip_travel_us))'');
    populated_zip_tvmovies_cnt := COUNT(GROUP,h.zip_tvmovies <> (TYPEOF(h.zip_tvmovies))'');
    populated_zip_tvmovies_pcnt := AVE(GROUP,IF(h.zip_tvmovies = (TYPEOF(h.zip_tvmovies))'',0,100));
    maxlength_zip_tvmovies := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_tvmovies)));
    avelength_zip_tvmovies := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_tvmovies)),h.zip_tvmovies<>(typeof(h.zip_tvmovies))'');
    populated_zip_woman_cnt := COUNT(GROUP,h.zip_woman <> (TYPEOF(h.zip_woman))'');
    populated_zip_woman_pcnt := AVE(GROUP,IF(h.zip_woman = (TYPEOF(h.zip_woman))'',0,100));
    maxlength_zip_woman := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_woman)));
    avelength_zip_woman := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_woman)),h.zip_woman<>(typeof(h.zip_woman))'');
    populated_zip_proftech_cnt := COUNT(GROUP,h.zip_proftech <> (TYPEOF(h.zip_proftech))'');
    populated_zip_proftech_pcnt := AVE(GROUP,IF(h.zip_proftech = (TYPEOF(h.zip_proftech))'',0,100));
    maxlength_zip_proftech := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_proftech)));
    avelength_zip_proftech := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_proftech)),h.zip_proftech<>(typeof(h.zip_proftech))'');
    populated_zip_retired_cnt := COUNT(GROUP,h.zip_retired <> (TYPEOF(h.zip_retired))'');
    populated_zip_retired_pcnt := AVE(GROUP,IF(h.zip_retired = (TYPEOF(h.zip_retired))'',0,100));
    maxlength_zip_retired := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_retired)));
    avelength_zip_retired := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_retired)),h.zip_retired<>(typeof(h.zip_retired))'');
    populated_zip_inc100_cnt := COUNT(GROUP,h.zip_inc100 <> (TYPEOF(h.zip_inc100))'');
    populated_zip_inc100_pcnt := AVE(GROUP,IF(h.zip_inc100 = (TYPEOF(h.zip_inc100))'',0,100));
    maxlength_zip_inc100 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_inc100)));
    avelength_zip_inc100 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_inc100)),h.zip_inc100<>(typeof(h.zip_inc100))'');
    populated_zip_inc75_cnt := COUNT(GROUP,h.zip_inc75 <> (TYPEOF(h.zip_inc75))'');
    populated_zip_inc75_pcnt := AVE(GROUP,IF(h.zip_inc75 = (TYPEOF(h.zip_inc75))'',0,100));
    maxlength_zip_inc75 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_inc75)));
    avelength_zip_inc75 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_inc75)),h.zip_inc75<>(typeof(h.zip_inc75))'');
    populated_zip_inc50_cnt := COUNT(GROUP,h.zip_inc50 <> (TYPEOF(h.zip_inc50))'');
    populated_zip_inc50_pcnt := AVE(GROUP,IF(h.zip_inc50 = (TYPEOF(h.zip_inc50))'',0,100));
    maxlength_zip_inc50 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_inc50)));
    avelength_zip_inc50 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_inc50)),h.zip_inc50<>(typeof(h.zip_inc50))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dtmatch_pcnt *   0.00 / 100 + T.Populated_msname_pcnt *   0.00 / 100 + T.Populated_msaddr1_pcnt *   0.00 / 100 + T.Populated_msaddr2_pcnt *   0.00 / 100 + T.Populated_mscity_pcnt *   0.00 / 100 + T.Populated_msstate_pcnt *   0.00 / 100 + T.Populated_mszip5_pcnt *   0.00 / 100 + T.Populated_mszip4_pcnt *   0.00 / 100 + T.Populated_dthh_pcnt *   0.00 / 100 + T.Populated_mscrrt_pcnt *   0.00 / 100 + T.Populated_msdpbc_pcnt *   0.00 / 100 + T.Populated_msdpv_pcnt *   0.00 / 100 + T.Populated_ms_addrtype_pcnt *   0.00 / 100 + T.Populated_ctysize_pcnt *   0.00 / 100 + T.Populated_lmos_pcnt *   0.00 / 100 + T.Populated_omos_pcnt *   0.00 / 100 + T.Populated_pmos_pcnt *   0.00 / 100 + T.Populated_gen_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_inc_pcnt *   0.00 / 100 + T.Populated_marital_status_pcnt *   0.00 / 100 + T.Populated_poc_pcnt *   0.00 / 100 + T.Populated_noc_pcnt *   0.00 / 100 + T.Populated_ocp_pcnt *   0.00 / 100 + T.Populated_edu_pcnt *   0.00 / 100 + T.Populated_lang_pcnt *   0.00 / 100 + T.Populated_relig_pcnt *   0.00 / 100 + T.Populated_dwell_pcnt *   0.00 / 100 + T.Populated_ownr_pcnt *   0.00 / 100 + T.Populated_eth1_pcnt *   0.00 / 100 + T.Populated_eth2_pcnt *   0.00 / 100 + T.Populated_lor_pcnt *   0.00 / 100 + T.Populated_pool_pcnt *   0.00 / 100 + T.Populated_speak_span_pcnt *   0.00 / 100 + T.Populated_soho_pcnt *   0.00 / 100 + T.Populated_vet_in_hh_pcnt *   0.00 / 100 + T.Populated_ms_mags_pcnt *   0.00 / 100 + T.Populated_ms_books_pcnt *   0.00 / 100 + T.Populated_ms_publish_pcnt *   0.00 / 100 + T.Populated_ms_pub_status_active_pcnt *   0.00 / 100 + T.Populated_ms_pub_status_expire_pcnt *   0.00 / 100 + T.Populated_ms_pub_premsold_pcnt *   0.00 / 100 + T.Populated_ms_pub_autornwl_pcnt *   0.00 / 100 + T.Populated_ms_pub_avgterm_pcnt *   0.00 / 100 + T.Populated_ms_pub_lmos_pcnt *   0.00 / 100 + T.Populated_ms_pub_omos_pcnt *   0.00 / 100 + T.Populated_ms_pub_pmos_pcnt *   0.00 / 100 + T.Populated_ms_pub_cemos_pcnt *   0.00 / 100 + T.Populated_ms_pub_femos_pcnt *   0.00 / 100 + T.Populated_ms_pub_totords_pcnt *   0.00 / 100 + T.Populated_ms_pub_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_pub_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_pub_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_pub_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_pub_paystat_ub_pcnt *   0.00 / 100 + T.Populated_ms_pub_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_pub_paymeth_cash_pcnt *   0.00 / 100 + T.Populated_ms_pub_payspeed_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_agt_cashf_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_agt_cashf_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_agt_pds_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_agt_pds_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_agt_schplan_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_agt_schplan_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_agt_sponsor_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_agt_sponsor_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_agt_tm_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_agt_tm_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_tm_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_tm_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_ins_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_ins_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_net_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_net_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_print_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_print_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_trans_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_trans_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_tv_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_tv_pcnt *   0.00 / 100 + T.Populated_ms_pub_osrc_dtp_pcnt *   0.00 / 100 + T.Populated_ms_pub_lsrc_dtp_pcnt *   0.00 / 100 + T.Populated_ms_pub_giftgivr_pcnt *   0.00 / 100 + T.Populated_ms_pub_giftee_pcnt *   0.00 / 100 + T.Populated_ms_catalog_pcnt *   0.00 / 100 + T.Populated_ms_cat_lmos_pcnt *   0.00 / 100 + T.Populated_ms_cat_omos_pcnt *   0.00 / 100 + T.Populated_ms_cat_pmos_pcnt *   0.00 / 100 + T.Populated_ms_cat_totords_pcnt *   0.00 / 100 + T.Populated_ms_cat_totitems_pcnt *   0.00 / 100 + T.Populated_ms_cat_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_cat_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_cat_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_cat_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_cat_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_cat_paymeth_cash_pcnt *   0.00 / 100 + T.Populated_ms_cat_osrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_cat_lsrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_cat_osrc_net_pcnt *   0.00 / 100 + T.Populated_ms_cat_lsrc_net_pcnt *   0.00 / 100 + T.Populated_ms_cat_giftgivr_pcnt *   0.00 / 100 + T.Populated_pkpubs_corrected_pcnt *   0.00 / 100 + T.Populated_pkcatg_corrected_pcnt *   0.00 / 100 + T.Populated_ms_fundraising_pcnt *   0.00 / 100 + T.Populated_ms_fund_lmos_pcnt *   0.00 / 100 + T.Populated_ms_fund_omos_pcnt *   0.00 / 100 + T.Populated_ms_fund_pmos_pcnt *   0.00 / 100 + T.Populated_ms_fund_totords_pcnt *   0.00 / 100 + T.Populated_ms_fund_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_fund_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_fund_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_fund_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_other_pcnt *   0.00 / 100 + T.Populated_ms_continuity_pcnt *   0.00 / 100 + T.Populated_ms_cont_status_active_pcnt *   0.00 / 100 + T.Populated_ms_cont_status_cancel_pcnt *   0.00 / 100 + T.Populated_ms_cont_omos_pcnt *   0.00 / 100 + T.Populated_ms_cont_lmos_pcnt *   0.00 / 100 + T.Populated_ms_cont_pmos_pcnt *   0.00 / 100 + T.Populated_ms_cont_totords_pcnt *   0.00 / 100 + T.Populated_ms_cont_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_cont_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_cont_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_cont_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_cont_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_cont_paymeth_cash_pcnt *   0.00 / 100 + T.Populated_ms_totords_pcnt *   0.00 / 100 + T.Populated_ms_totitems_pcnt *   0.00 / 100 + T.Populated_ms_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_paymeth_cash_pcnt *   0.00 / 100 + T.Populated_ms_osrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_lsrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_osrc_tm_pcnt *   0.00 / 100 + T.Populated_ms_lsrc_tm_pcnt *   0.00 / 100 + T.Populated_ms_osrc_ins_pcnt *   0.00 / 100 + T.Populated_ms_lsrc_ins_pcnt *   0.00 / 100 + T.Populated_ms_osrc_net_pcnt *   0.00 / 100 + T.Populated_ms_lsrc_net_pcnt *   0.00 / 100 + T.Populated_ms_osrc_tv_pcnt *   0.00 / 100 + T.Populated_ms_lsrc_tv_pcnt *   0.00 / 100 + T.Populated_ms_osrc_retail_pcnt *   0.00 / 100 + T.Populated_ms_lsrc_retail_pcnt *   0.00 / 100 + T.Populated_ms_giftgivr_pcnt *   0.00 / 100 + T.Populated_ms_giftee_pcnt *   0.00 / 100 + T.Populated_ms_adult_pcnt *   0.00 / 100 + T.Populated_ms_womapp_pcnt *   0.00 / 100 + T.Populated_ms_menapp_pcnt *   0.00 / 100 + T.Populated_ms_kidapp_pcnt *   0.00 / 100 + T.Populated_ms_accessory_pcnt *   0.00 / 100 + T.Populated_ms_apparel_pcnt *   0.00 / 100 + T.Populated_ms_app_lmos_pcnt *   0.00 / 100 + T.Populated_ms_app_omos_pcnt *   0.00 / 100 + T.Populated_ms_app_pmos_pcnt *   0.00 / 100 + T.Populated_ms_app_totords_pcnt *   0.00 / 100 + T.Populated_ms_app_totitems_pcnt *   0.00 / 100 + T.Populated_ms_app_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_app_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_app_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_app_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_app_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_app_paymeth_cash_pcnt *   0.00 / 100 + T.Populated_ms_menfash_pcnt *   0.00 / 100 + T.Populated_ms_womfash_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_lmos_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_omos_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_pmos_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_totords_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_osrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_lsrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_osrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_wfsh_lsrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_audio_pcnt *   0.00 / 100 + T.Populated_ms_auto_pcnt *   0.00 / 100 + T.Populated_ms_aviation_pcnt *   0.00 / 100 + T.Populated_ms_bargains_pcnt *   0.00 / 100 + T.Populated_ms_beauty_pcnt *   0.00 / 100 + T.Populated_ms_bible_pcnt *   0.00 / 100 + T.Populated_ms_bible_lmos_pcnt *   0.00 / 100 + T.Populated_ms_bible_omos_pcnt *   0.00 / 100 + T.Populated_ms_bible_pmos_pcnt *   0.00 / 100 + T.Populated_ms_bible_totords_pcnt *   0.00 / 100 + T.Populated_ms_bible_totitems_pcnt *   0.00 / 100 + T.Populated_ms_bible_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_bible_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_bible_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_bible_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_bible_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_bible_paymeth_cash_pcnt *   0.00 / 100 + T.Populated_ms_business_pcnt *   0.00 / 100 + T.Populated_ms_collectibles_pcnt *   0.00 / 100 + T.Populated_ms_computers_pcnt *   0.00 / 100 + T.Populated_ms_crafts_pcnt *   0.00 / 100 + T.Populated_ms_culturearts_pcnt *   0.00 / 100 + T.Populated_ms_currevent_pcnt *   0.00 / 100 + T.Populated_ms_diy_pcnt *   0.00 / 100 + T.Populated_ms_electronics_pcnt *   0.00 / 100 + T.Populated_ms_equestrian_pcnt *   0.00 / 100 + T.Populated_ms_pub_family_pcnt *   0.00 / 100 + T.Populated_ms_cat_family_pcnt *   0.00 / 100 + T.Populated_ms_family_pcnt *   0.00 / 100 + T.Populated_ms_family_lmos_pcnt *   0.00 / 100 + T.Populated_ms_family_omos_pcnt *   0.00 / 100 + T.Populated_ms_family_pmos_pcnt *   0.00 / 100 + T.Populated_ms_family_totords_pcnt *   0.00 / 100 + T.Populated_ms_family_totitems_pcnt *   0.00 / 100 + T.Populated_ms_family_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_family_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_family_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_family_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_family_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_family_paymeth_cash_pcnt *   0.00 / 100 + T.Populated_ms_family_osrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_family_lsrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_fiction_pcnt *   0.00 / 100 + T.Populated_ms_food_pcnt *   0.00 / 100 + T.Populated_ms_games_pcnt *   0.00 / 100 + T.Populated_ms_gifts_pcnt *   0.00 / 100 + T.Populated_ms_gourmet_pcnt *   0.00 / 100 + T.Populated_ms_fitness_pcnt *   0.00 / 100 + T.Populated_ms_health_pcnt *   0.00 / 100 + T.Populated_ms_hlth_lmos_pcnt *   0.00 / 100 + T.Populated_ms_hlth_omos_pcnt *   0.00 / 100 + T.Populated_ms_hlth_pmos_pcnt *   0.00 / 100 + T.Populated_ms_hlth_totords_pcnt *   0.00 / 100 + T.Populated_ms_hlth_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_hlth_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_hlth_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_hlth_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_hlth_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_hlth_osrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_hlth_lsrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_hlth_osrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_hlth_lsrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_hlth_osrc_tv_pcnt *   0.00 / 100 + T.Populated_ms_hlth_lsrc_tv_pcnt *   0.00 / 100 + T.Populated_ms_holiday_pcnt *   0.00 / 100 + T.Populated_ms_history_pcnt *   0.00 / 100 + T.Populated_ms_pub_cooking_pcnt *   0.00 / 100 + T.Populated_ms_cooking_pcnt *   0.00 / 100 + T.Populated_ms_pub_homedecr_pcnt *   0.00 / 100 + T.Populated_ms_cat_homedecr_pcnt *   0.00 / 100 + T.Populated_ms_homedecr_pcnt *   0.00 / 100 + T.Populated_ms_housewares_pcnt *   0.00 / 100 + T.Populated_ms_pub_garden_pcnt *   0.00 / 100 + T.Populated_ms_cat_garden_pcnt *   0.00 / 100 + T.Populated_ms_garden_pcnt *   0.00 / 100 + T.Populated_ms_pub_homeliv_pcnt *   0.00 / 100 + T.Populated_ms_cat_homeliv_pcnt *   0.00 / 100 + T.Populated_ms_homeliv_pcnt *   0.00 / 100 + T.Populated_ms_pub_home_status_active_pcnt *   0.00 / 100 + T.Populated_ms_home_lmos_pcnt *   0.00 / 100 + T.Populated_ms_home_omos_pcnt *   0.00 / 100 + T.Populated_ms_home_pmos_pcnt *   0.00 / 100 + T.Populated_ms_home_totords_pcnt *   0.00 / 100 + T.Populated_ms_home_totitems_pcnt *   0.00 / 100 + T.Populated_ms_home_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_home_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_home_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_home_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_home_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_home_paymeth_cash_pcnt *   0.00 / 100 + T.Populated_ms_home_osrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_home_lsrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_home_osrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_home_lsrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_home_osrc_net_pcnt *   0.00 / 100 + T.Populated_ms_home_lsrc_net_pcnt *   0.00 / 100 + T.Populated_ms_home_osrc_tv_pcnt *   0.00 / 100 + T.Populated_ms_home_lsrc_tv_pcnt *   0.00 / 100 + T.Populated_ms_humor_pcnt *   0.00 / 100 + T.Populated_ms_inspiration_pcnt *   0.00 / 100 + T.Populated_ms_merchandise_pcnt *   0.00 / 100 + T.Populated_ms_moneymaking_pcnt *   0.00 / 100 + T.Populated_ms_moneymaking_lmos_pcnt *   0.00 / 100 + T.Populated_ms_motorcycles_pcnt *   0.00 / 100 + T.Populated_ms_music_pcnt *   0.00 / 100 + T.Populated_ms_fishing_pcnt *   0.00 / 100 + T.Populated_ms_hunting_pcnt *   0.00 / 100 + T.Populated_ms_boatsail_pcnt *   0.00 / 100 + T.Populated_ms_camp_pcnt *   0.00 / 100 + T.Populated_ms_pub_outdoors_pcnt *   0.00 / 100 + T.Populated_ms_cat_outdoors_pcnt *   0.00 / 100 + T.Populated_ms_outdoors_pcnt *   0.00 / 100 + T.Populated_ms_pub_out_status_active_pcnt *   0.00 / 100 + T.Populated_ms_out_lmos_pcnt *   0.00 / 100 + T.Populated_ms_out_omos_pcnt *   0.00 / 100 + T.Populated_ms_out_pmos_pcnt *   0.00 / 100 + T.Populated_ms_out_totords_pcnt *   0.00 / 100 + T.Populated_ms_out_totitems_pcnt *   0.00 / 100 + T.Populated_ms_out_totdlrs_pcnt *   0.00 / 100 + T.Populated_ms_out_avgdlrs_pcnt *   0.00 / 100 + T.Populated_ms_out_lastdlrs_pcnt *   0.00 / 100 + T.Populated_ms_out_paystat_paid_pcnt *   0.00 / 100 + T.Populated_ms_out_paymeth_cc_pcnt *   0.00 / 100 + T.Populated_ms_out_paymeth_cash_pcnt *   0.00 / 100 + T.Populated_ms_out_osrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_out_lsrc_dm_pcnt *   0.00 / 100 + T.Populated_ms_out_osrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_out_lsrc_agt_pcnt *   0.00 / 100 + T.Populated_ms_pets_pcnt *   0.00 / 100 + T.Populated_ms_pfin_pcnt *   0.00 / 100 + T.Populated_ms_photo_pcnt *   0.00 / 100 + T.Populated_ms_photoproc_pcnt *   0.00 / 100 + T.Populated_ms_rural_pcnt *   0.00 / 100 + T.Populated_ms_science_pcnt *   0.00 / 100 + T.Populated_ms_sports_pcnt *   0.00 / 100 + T.Populated_ms_sports_lmos_pcnt *   0.00 / 100 + T.Populated_ms_travel_pcnt *   0.00 / 100 + T.Populated_ms_tvmovies_pcnt *   0.00 / 100 + T.Populated_ms_wildlife_pcnt *   0.00 / 100 + T.Populated_ms_woman_pcnt *   0.00 / 100 + T.Populated_ms_woman_lmos_pcnt *   0.00 / 100 + T.Populated_ms_ringtones_apps_pcnt *   0.00 / 100 + T.Populated_cpi_mobile_apps_index_pcnt *   0.00 / 100 + T.Populated_cpi_credit_repair_index_pcnt *   0.00 / 100 + T.Populated_cpi_credit_report_index_pcnt *   0.00 / 100 + T.Populated_cpi_education_seekers_index_pcnt *   0.00 / 100 + T.Populated_cpi_insurance_index_pcnt *   0.00 / 100 + T.Populated_cpi_insurance_health_index_pcnt *   0.00 / 100 + T.Populated_cpi_insurance_auto_index_pcnt *   0.00 / 100 + T.Populated_cpi_job_seekers_index_pcnt *   0.00 / 100 + T.Populated_cpi_social_networking_index_pcnt *   0.00 / 100 + T.Populated_cpi_adult_index_pcnt *   0.00 / 100 + T.Populated_cpi_africanamerican_index_pcnt *   0.00 / 100 + T.Populated_cpi_apparel_index_pcnt *   0.00 / 100 + T.Populated_cpi_apparel_accessory_index_pcnt *   0.00 / 100 + T.Populated_cpi_apparel_kids_index_pcnt *   0.00 / 100 + T.Populated_cpi_apparel_men_index_pcnt *   0.00 / 100 + T.Populated_cpi_apparel_menfash_index_pcnt *   0.00 / 100 + T.Populated_cpi_apparel_women_index_pcnt *   0.00 / 100 + T.Populated_cpi_apparel_womfash_index_pcnt *   0.00 / 100 + T.Populated_cpi_asian_index_pcnt *   0.00 / 100 + T.Populated_cpi_auto_index_pcnt *   0.00 / 100 + T.Populated_cpi_auto_racing_index_pcnt *   0.00 / 100 + T.Populated_cpi_auto_trucks_index_pcnt *   0.00 / 100 + T.Populated_cpi_aviation_index_pcnt *   0.00 / 100 + T.Populated_cpi_bargains_index_pcnt *   0.00 / 100 + T.Populated_cpi_beauty_index_pcnt *   0.00 / 100 + T.Populated_cpi_bible_index_pcnt *   0.00 / 100 + T.Populated_cpi_birds_index_pcnt *   0.00 / 100 + T.Populated_cpi_business_index_pcnt *   0.00 / 100 + T.Populated_cpi_business_homeoffice_index_pcnt *   0.00 / 100 + T.Populated_cpi_catalog_index_pcnt *   0.00 / 100 + T.Populated_cpi_cc_index_pcnt *   0.00 / 100 + T.Populated_cpi_collectibles_index_pcnt *   0.00 / 100 + T.Populated_cpi_college_index_pcnt *   0.00 / 100 + T.Populated_cpi_computers_index_pcnt *   0.00 / 100 + T.Populated_cpi_conservative_index_pcnt *   0.00 / 100 + T.Populated_cpi_continuity_index_pcnt *   0.00 / 100 + T.Populated_cpi_cooking_index_pcnt *   0.00 / 100 + T.Populated_cpi_crafts_index_pcnt *   0.00 / 100 + T.Populated_cpi_crafts_crochet_index_pcnt *   0.00 / 100 + T.Populated_cpi_crafts_knit_index_pcnt *   0.00 / 100 + T.Populated_cpi_crafts_needlepoint_index_pcnt *   0.00 / 100 + T.Populated_cpi_crafts_quilt_index_pcnt *   0.00 / 100 + T.Populated_cpi_crafts_sew_index_pcnt *   0.00 / 100 + T.Populated_cpi_culturearts_index_pcnt *   0.00 / 100 + T.Populated_cpi_currevent_index_pcnt *   0.00 / 100 + T.Populated_cpi_diy_index_pcnt *   0.00 / 100 + T.Populated_cpi_donor_index_pcnt *   0.00 / 100 + T.Populated_cpi_ego_index_pcnt *   0.00 / 100 + T.Populated_cpi_electronics_index_pcnt *   0.00 / 100 + T.Populated_cpi_equestrian_index_pcnt *   0.00 / 100 + T.Populated_cpi_family_index_pcnt *   0.00 / 100 + T.Populated_cpi_family_teen_index_pcnt *   0.00 / 100 + T.Populated_cpi_family_young_index_pcnt *   0.00 / 100 + T.Populated_cpi_fiction_index_pcnt *   0.00 / 100 + T.Populated_cpi_gambling_index_pcnt *   0.00 / 100 + T.Populated_cpi_games_index_pcnt *   0.00 / 100 + T.Populated_cpi_gardening_index_pcnt *   0.00 / 100 + T.Populated_cpi_gay_index_pcnt *   0.00 / 100 + T.Populated_cpi_giftgivr_index_pcnt *   0.00 / 100 + T.Populated_cpi_gourmet_index_pcnt *   0.00 / 100 + T.Populated_cpi_grandparents_index_pcnt *   0.00 / 100 + T.Populated_cpi_health_index_pcnt *   0.00 / 100 + T.Populated_cpi_health_diet_index_pcnt *   0.00 / 100 + T.Populated_cpi_health_fitness_index_pcnt *   0.00 / 100 + T.Populated_cpi_hightech_index_pcnt *   0.00 / 100 + T.Populated_cpi_hispanic_index_pcnt *   0.00 / 100 + T.Populated_cpi_history_index_pcnt *   0.00 / 100 + T.Populated_cpi_history_american_index_pcnt *   0.00 / 100 + T.Populated_cpi_hobbies_index_pcnt *   0.00 / 100 + T.Populated_cpi_homedecr_index_pcnt *   0.00 / 100 + T.Populated_cpi_homeliv_index_pcnt *   0.00 / 100 + T.Populated_cpi_humor_index_pcnt *   0.00 / 100 + T.Populated_cpi_inspiration_index_pcnt *   0.00 / 100 + T.Populated_cpi_internet_index_pcnt *   0.00 / 100 + T.Populated_cpi_internet_access_index_pcnt *   0.00 / 100 + T.Populated_cpi_internet_buy_index_pcnt *   0.00 / 100 + T.Populated_cpi_liberal_index_pcnt *   0.00 / 100 + T.Populated_cpi_moneymaking_index_pcnt *   0.00 / 100 + T.Populated_cpi_motorcycles_index_pcnt *   0.00 / 100 + T.Populated_cpi_music_index_pcnt *   0.00 / 100 + T.Populated_cpi_nonfiction_index_pcnt *   0.00 / 100 + T.Populated_cpi_ocean_index_pcnt *   0.00 / 100 + T.Populated_cpi_outdoors_index_pcnt *   0.00 / 100 + T.Populated_cpi_outdoors_boatsail_index_pcnt *   0.00 / 100 + T.Populated_cpi_outdoors_camp_index_pcnt *   0.00 / 100 + T.Populated_cpi_outdoors_fishing_index_pcnt *   0.00 / 100 + T.Populated_cpi_outdoors_huntfish_index_pcnt *   0.00 / 100 + T.Populated_cpi_outdoors_hunting_index_pcnt *   0.00 / 100 + T.Populated_cpi_pets_index_pcnt *   0.00 / 100 + T.Populated_cpi_pets_cats_index_pcnt *   0.00 / 100 + T.Populated_cpi_pets_dogs_index_pcnt *   0.00 / 100 + T.Populated_cpi_pfin_index_pcnt *   0.00 / 100 + T.Populated_cpi_photog_index_pcnt *   0.00 / 100 + T.Populated_cpi_photoproc_index_pcnt *   0.00 / 100 + T.Populated_cpi_publish_index_pcnt *   0.00 / 100 + T.Populated_cpi_publish_books_index_pcnt *   0.00 / 100 + T.Populated_cpi_publish_mags_index_pcnt *   0.00 / 100 + T.Populated_cpi_rural_index_pcnt *   0.00 / 100 + T.Populated_cpi_science_index_pcnt *   0.00 / 100 + T.Populated_cpi_scifi_index_pcnt *   0.00 / 100 + T.Populated_cpi_seniors_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_baseball_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_basketball_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_biking_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_football_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_golf_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_hockey_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_running_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_ski_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_soccer_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_swimming_index_pcnt *   0.00 / 100 + T.Populated_cpi_sports_tennis_index_pcnt *   0.00 / 100 + T.Populated_cpi_stationery_index_pcnt *   0.00 / 100 + T.Populated_cpi_sweeps_index_pcnt *   0.00 / 100 + T.Populated_cpi_tobacco_index_pcnt *   0.00 / 100 + T.Populated_cpi_travel_index_pcnt *   0.00 / 100 + T.Populated_cpi_travel_cruise_index_pcnt *   0.00 / 100 + T.Populated_cpi_travel_rv_index_pcnt *   0.00 / 100 + T.Populated_cpi_travel_us_index_pcnt *   0.00 / 100 + T.Populated_cpi_tvmovies_index_pcnt *   0.00 / 100 + T.Populated_cpi_wildlife_index_pcnt *   0.00 / 100 + T.Populated_cpi_woman_index_pcnt *   0.00 / 100 + T.Populated_totdlr_index_pcnt *   0.00 / 100 + T.Populated_cpi_totdlr_pcnt *   0.00 / 100 + T.Populated_cpi_totords_pcnt *   0.00 / 100 + T.Populated_cpi_lastdlr_pcnt *   0.00 / 100 + T.Populated_pkcatg_pcnt *   0.00 / 100 + T.Populated_pkpubs_pcnt *   0.00 / 100 + T.Populated_pkcont_pcnt *   0.00 / 100 + T.Populated_pkca01_pcnt *   0.00 / 100 + T.Populated_pkca03_pcnt *   0.00 / 100 + T.Populated_pkca04_pcnt *   0.00 / 100 + T.Populated_pkca05_pcnt *   0.00 / 100 + T.Populated_pkca06_pcnt *   0.00 / 100 + T.Populated_pkca07_pcnt *   0.00 / 100 + T.Populated_pkca08_pcnt *   0.00 / 100 + T.Populated_pkca09_pcnt *   0.00 / 100 + T.Populated_pkca10_pcnt *   0.00 / 100 + T.Populated_pkca11_pcnt *   0.00 / 100 + T.Populated_pkca12_pcnt *   0.00 / 100 + T.Populated_pkca13_pcnt *   0.00 / 100 + T.Populated_pkca14_pcnt *   0.00 / 100 + T.Populated_pkca15_pcnt *   0.00 / 100 + T.Populated_pkca16_pcnt *   0.00 / 100 + T.Populated_pkca17_pcnt *   0.00 / 100 + T.Populated_pkca18_pcnt *   0.00 / 100 + T.Populated_pkca20_pcnt *   0.00 / 100 + T.Populated_pkca21_pcnt *   0.00 / 100 + T.Populated_pkca22_pcnt *   0.00 / 100 + T.Populated_pkca23_pcnt *   0.00 / 100 + T.Populated_pkca24_pcnt *   0.00 / 100 + T.Populated_pkca25_pcnt *   0.00 / 100 + T.Populated_pkca26_pcnt *   0.00 / 100 + T.Populated_pkca28_pcnt *   0.00 / 100 + T.Populated_pkca29_pcnt *   0.00 / 100 + T.Populated_pkca30_pcnt *   0.00 / 100 + T.Populated_pkca31_pcnt *   0.00 / 100 + T.Populated_pkca32_pcnt *   0.00 / 100 + T.Populated_pkca33_pcnt *   0.00 / 100 + T.Populated_pkca34_pcnt *   0.00 / 100 + T.Populated_pkca35_pcnt *   0.00 / 100 + T.Populated_pkca36_pcnt *   0.00 / 100 + T.Populated_pkca37_pcnt *   0.00 / 100 + T.Populated_pkca39_pcnt *   0.00 / 100 + T.Populated_pkca40_pcnt *   0.00 / 100 + T.Populated_pkca41_pcnt *   0.00 / 100 + T.Populated_pkca42_pcnt *   0.00 / 100 + T.Populated_pkca54_pcnt *   0.00 / 100 + T.Populated_pkca61_pcnt *   0.00 / 100 + T.Populated_pkca62_pcnt *   0.00 / 100 + T.Populated_pkca64_pcnt *   0.00 / 100 + T.Populated_pkpu01_pcnt *   0.00 / 100 + T.Populated_pkpu02_pcnt *   0.00 / 100 + T.Populated_pkpu03_pcnt *   0.00 / 100 + T.Populated_pkpu04_pcnt *   0.00 / 100 + T.Populated_pkpu05_pcnt *   0.00 / 100 + T.Populated_pkpu06_pcnt *   0.00 / 100 + T.Populated_pkpu07_pcnt *   0.00 / 100 + T.Populated_pkpu08_pcnt *   0.00 / 100 + T.Populated_pkpu09_pcnt *   0.00 / 100 + T.Populated_pkpu10_pcnt *   0.00 / 100 + T.Populated_pkpu11_pcnt *   0.00 / 100 + T.Populated_pkpu12_pcnt *   0.00 / 100 + T.Populated_pkpu13_pcnt *   0.00 / 100 + T.Populated_pkpu14_pcnt *   0.00 / 100 + T.Populated_pkpu15_pcnt *   0.00 / 100 + T.Populated_pkpu16_pcnt *   0.00 / 100 + T.Populated_pkpu17_pcnt *   0.00 / 100 + T.Populated_pkpu18_pcnt *   0.00 / 100 + T.Populated_pkpu19_pcnt *   0.00 / 100 + T.Populated_pkpu20_pcnt *   0.00 / 100 + T.Populated_pkpu23_pcnt *   0.00 / 100 + T.Populated_pkpu25_pcnt *   0.00 / 100 + T.Populated_pkpu27_pcnt *   0.00 / 100 + T.Populated_pkpu28_pcnt *   0.00 / 100 + T.Populated_pkpu29_pcnt *   0.00 / 100 + T.Populated_pkpu30_pcnt *   0.00 / 100 + T.Populated_pkpu31_pcnt *   0.00 / 100 + T.Populated_pkpu32_pcnt *   0.00 / 100 + T.Populated_pkpu33_pcnt *   0.00 / 100 + T.Populated_pkpu34_pcnt *   0.00 / 100 + T.Populated_pkpu35_pcnt *   0.00 / 100 + T.Populated_pkpu38_pcnt *   0.00 / 100 + T.Populated_pkpu41_pcnt *   0.00 / 100 + T.Populated_pkpu42_pcnt *   0.00 / 100 + T.Populated_pkpu45_pcnt *   0.00 / 100 + T.Populated_pkpu46_pcnt *   0.00 / 100 + T.Populated_pkpu47_pcnt *   0.00 / 100 + T.Populated_pkpu48_pcnt *   0.00 / 100 + T.Populated_pkpu49_pcnt *   0.00 / 100 + T.Populated_pkpu50_pcnt *   0.00 / 100 + T.Populated_pkpu51_pcnt *   0.00 / 100 + T.Populated_pkpu52_pcnt *   0.00 / 100 + T.Populated_pkpu53_pcnt *   0.00 / 100 + T.Populated_pkpu54_pcnt *   0.00 / 100 + T.Populated_pkpu55_pcnt *   0.00 / 100 + T.Populated_pkpu56_pcnt *   0.00 / 100 + T.Populated_pkpu57_pcnt *   0.00 / 100 + T.Populated_pkpu60_pcnt *   0.00 / 100 + T.Populated_pkpu61_pcnt *   0.00 / 100 + T.Populated_pkpu62_pcnt *   0.00 / 100 + T.Populated_pkpu63_pcnt *   0.00 / 100 + T.Populated_pkpu64_pcnt *   0.00 / 100 + T.Populated_pkpu65_pcnt *   0.00 / 100 + T.Populated_pkpu66_pcnt *   0.00 / 100 + T.Populated_pkpu67_pcnt *   0.00 / 100 + T.Populated_pkpu68_pcnt *   0.00 / 100 + T.Populated_pkpu69_pcnt *   0.00 / 100 + T.Populated_pkpu70_pcnt *   0.00 / 100 + T.Populated_censpct_water_pcnt *   0.00 / 100 + T.Populated_cens_pop_density_pcnt *   0.00 / 100 + T.Populated_cens_hu_density_pcnt *   0.00 / 100 + T.Populated_censpct_pop_white_pcnt *   0.00 / 100 + T.Populated_censpct_pop_black_pcnt *   0.00 / 100 + T.Populated_censpct_pop_amerind_pcnt *   0.00 / 100 + T.Populated_censpct_pop_asian_pcnt *   0.00 / 100 + T.Populated_censpct_pop_pacisl_pcnt *   0.00 / 100 + T.Populated_censpct_pop_othrace_pcnt *   0.00 / 100 + T.Populated_censpct_pop_multirace_pcnt *   0.00 / 100 + T.Populated_censpct_pop_hispanic_pcnt *   0.00 / 100 + T.Populated_censpct_pop_agelt18_pcnt *   0.00 / 100 + T.Populated_censpct_pop_males_pcnt *   0.00 / 100 + T.Populated_censpct_adult_age1824_pcnt *   0.00 / 100 + T.Populated_censpct_adult_age2534_pcnt *   0.00 / 100 + T.Populated_censpct_adult_age3544_pcnt *   0.00 / 100 + T.Populated_censpct_adult_age4554_pcnt *   0.00 / 100 + T.Populated_censpct_adult_age5564_pcnt *   0.00 / 100 + T.Populated_censpct_adult_agege65_pcnt *   0.00 / 100 + T.Populated_cens_pop_medage_pcnt *   0.00 / 100 + T.Populated_cens_hh_avgsize_pcnt *   0.00 / 100 + T.Populated_censpct_hh_family_pcnt *   0.00 / 100 + T.Populated_censpct_hh_family_husbwife_pcnt *   0.00 / 100 + T.Populated_censpct_hu_occupied_pcnt *   0.00 / 100 + T.Populated_censpct_hu_owned_pcnt *   0.00 / 100 + T.Populated_censpct_hu_rented_pcnt *   0.00 / 100 + T.Populated_censpct_hu_vacantseasonal_pcnt *   0.00 / 100 + T.Populated_zip_medinc_pcnt *   0.00 / 100 + T.Populated_zip_apparel_pcnt *   0.00 / 100 + T.Populated_zip_apparel_women_pcnt *   0.00 / 100 + T.Populated_zip_apparel_womfash_pcnt *   0.00 / 100 + T.Populated_zip_auto_pcnt *   0.00 / 100 + T.Populated_zip_beauty_pcnt *   0.00 / 100 + T.Populated_zip_booksmusicmovies_pcnt *   0.00 / 100 + T.Populated_zip_business_pcnt *   0.00 / 100 + T.Populated_zip_catalog_pcnt *   0.00 / 100 + T.Populated_zip_cc_pcnt *   0.00 / 100 + T.Populated_zip_collectibles_pcnt *   0.00 / 100 + T.Populated_zip_computers_pcnt *   0.00 / 100 + T.Populated_zip_continuity_pcnt *   0.00 / 100 + T.Populated_zip_cooking_pcnt *   0.00 / 100 + T.Populated_zip_crafts_pcnt *   0.00 / 100 + T.Populated_zip_culturearts_pcnt *   0.00 / 100 + T.Populated_zip_dm_sold_pcnt *   0.00 / 100 + T.Populated_zip_donor_pcnt *   0.00 / 100 + T.Populated_zip_family_pcnt *   0.00 / 100 + T.Populated_zip_gardening_pcnt *   0.00 / 100 + T.Populated_zip_giftgivr_pcnt *   0.00 / 100 + T.Populated_zip_gourmet_pcnt *   0.00 / 100 + T.Populated_zip_health_pcnt *   0.00 / 100 + T.Populated_zip_health_diet_pcnt *   0.00 / 100 + T.Populated_zip_health_fitness_pcnt *   0.00 / 100 + T.Populated_zip_hobbies_pcnt *   0.00 / 100 + T.Populated_zip_homedecr_pcnt *   0.00 / 100 + T.Populated_zip_homeliv_pcnt *   0.00 / 100 + T.Populated_zip_internet_pcnt *   0.00 / 100 + T.Populated_zip_internet_access_pcnt *   0.00 / 100 + T.Populated_zip_internet_buy_pcnt *   0.00 / 100 + T.Populated_zip_music_pcnt *   0.00 / 100 + T.Populated_zip_outdoors_pcnt *   0.00 / 100 + T.Populated_zip_pets_pcnt *   0.00 / 100 + T.Populated_zip_pfin_pcnt *   0.00 / 100 + T.Populated_zip_publish_pcnt *   0.00 / 100 + T.Populated_zip_publish_books_pcnt *   0.00 / 100 + T.Populated_zip_publish_mags_pcnt *   0.00 / 100 + T.Populated_zip_sports_pcnt *   0.00 / 100 + T.Populated_zip_sports_biking_pcnt *   0.00 / 100 + T.Populated_zip_sports_golf_pcnt *   0.00 / 100 + T.Populated_zip_travel_pcnt *   0.00 / 100 + T.Populated_zip_travel_us_pcnt *   0.00 / 100 + T.Populated_zip_tvmovies_pcnt *   0.00 / 100 + T.Populated_zip_woman_pcnt *   0.00 / 100 + T.Populated_zip_proftech_pcnt *   0.00 / 100 + T.Populated_zip_retired_pcnt *   0.00 / 100 + T.Populated_zip_inc100_pcnt *   0.00 / 100 + T.Populated_zip_inc75_pcnt *   0.00 / 100 + T.Populated_zip_inc50_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dtmatch','msname','msaddr1','msaddr2','mscity','msstate','mszip5','mszip4','dthh','mscrrt','msdpbc','msdpv','ms_addrtype','ctysize','lmos','omos','pmos','gen','dob','age','inc','marital_status','poc','noc','ocp','edu','lang','relig','dwell','ownr','eth1','eth2','lor','pool','speak_span','soho','vet_in_hh','ms_mags','ms_books','ms_publish','ms_pub_status_active','ms_pub_status_expire','ms_pub_premsold','ms_pub_autornwl','ms_pub_avgterm','ms_pub_lmos','ms_pub_omos','ms_pub_pmos','ms_pub_cemos','ms_pub_femos','ms_pub_totords','ms_pub_totdlrs','ms_pub_avgdlrs','ms_pub_lastdlrs','ms_pub_paystat_paid','ms_pub_paystat_ub','ms_pub_paymeth_cc','ms_pub_paymeth_cash','ms_pub_payspeed','ms_pub_osrc_dm','ms_pub_lsrc_dm','ms_pub_osrc_agt_cashf','ms_pub_lsrc_agt_cashf','ms_pub_osrc_agt_pds','ms_pub_lsrc_agt_pds','ms_pub_osrc_agt_schplan','ms_pub_lsrc_agt_schplan','ms_pub_osrc_agt_sponsor','ms_pub_lsrc_agt_sponsor','ms_pub_osrc_agt_tm','ms_pub_lsrc_agt_tm','ms_pub_osrc_agt','ms_pub_lsrc_agt','ms_pub_osrc_tm','ms_pub_lsrc_tm','ms_pub_osrc_ins','ms_pub_lsrc_ins','ms_pub_osrc_net','ms_pub_lsrc_net','ms_pub_osrc_print','ms_pub_lsrc_print','ms_pub_osrc_trans','ms_pub_lsrc_trans','ms_pub_osrc_tv','ms_pub_lsrc_tv','ms_pub_osrc_dtp','ms_pub_lsrc_dtp','ms_pub_giftgivr','ms_pub_giftee','ms_catalog','ms_cat_lmos','ms_cat_omos','ms_cat_pmos','ms_cat_totords','ms_cat_totitems','ms_cat_totdlrs','ms_cat_avgdlrs','ms_cat_lastdlrs','ms_cat_paystat_paid','ms_cat_paymeth_cc','ms_cat_paymeth_cash','ms_cat_osrc_dm','ms_cat_lsrc_dm','ms_cat_osrc_net','ms_cat_lsrc_net','ms_cat_giftgivr','pkpubs_corrected','pkcatg_corrected','ms_fundraising','ms_fund_lmos','ms_fund_omos','ms_fund_pmos','ms_fund_totords','ms_fund_totdlrs','ms_fund_avgdlrs','ms_fund_lastdlrs','ms_fund_paystat_paid','ms_other','ms_continuity','ms_cont_status_active','ms_cont_status_cancel','ms_cont_omos','ms_cont_lmos','ms_cont_pmos','ms_cont_totords','ms_cont_totdlrs','ms_cont_avgdlrs','ms_cont_lastdlrs','ms_cont_paystat_paid','ms_cont_paymeth_cc','ms_cont_paymeth_cash','ms_totords','ms_totitems','ms_totdlrs','ms_avgdlrs','ms_lastdlrs','ms_paystat_paid','ms_paymeth_cc','ms_paymeth_cash','ms_osrc_dm','ms_lsrc_dm','ms_osrc_tm','ms_lsrc_tm','ms_osrc_ins','ms_lsrc_ins','ms_osrc_net','ms_lsrc_net','ms_osrc_tv','ms_lsrc_tv','ms_osrc_retail','ms_lsrc_retail','ms_giftgivr','ms_giftee','ms_adult','ms_womapp','ms_menapp','ms_kidapp','ms_accessory','ms_apparel','ms_app_lmos','ms_app_omos','ms_app_pmos','ms_app_totords','ms_app_totitems','ms_app_totdlrs','ms_app_avgdlrs','ms_app_lastdlrs','ms_app_paystat_paid','ms_app_paymeth_cc','ms_app_paymeth_cash','ms_menfash','ms_womfash','ms_wfsh_lmos','ms_wfsh_omos','ms_wfsh_pmos','ms_wfsh_totords','ms_wfsh_totdlrs','ms_wfsh_avgdlrs','ms_wfsh_lastdlrs','ms_wfsh_paystat_paid','ms_wfsh_osrc_dm','ms_wfsh_lsrc_dm','ms_wfsh_osrc_agt','ms_wfsh_lsrc_agt','ms_audio','ms_auto','ms_aviation','ms_bargains','ms_beauty','ms_bible','ms_bible_lmos','ms_bible_omos','ms_bible_pmos','ms_bible_totords','ms_bible_totitems','ms_bible_totdlrs','ms_bible_avgdlrs','ms_bible_lastdlrs','ms_bible_paystat_paid','ms_bible_paymeth_cc','ms_bible_paymeth_cash','ms_business','ms_collectibles','ms_computers','ms_crafts','ms_culturearts','ms_currevent','ms_diy','ms_electronics','ms_equestrian','ms_pub_family','ms_cat_family','ms_family','ms_family_lmos','ms_family_omos','ms_family_pmos','ms_family_totords','ms_family_totitems','ms_family_totdlrs','ms_family_avgdlrs','ms_family_lastdlrs','ms_family_paystat_paid','ms_family_paymeth_cc','ms_family_paymeth_cash','ms_family_osrc_dm','ms_family_lsrc_dm','ms_fiction','ms_food','ms_games','ms_gifts','ms_gourmet','ms_fitness','ms_health','ms_hlth_lmos','ms_hlth_omos','ms_hlth_pmos','ms_hlth_totords','ms_hlth_totdlrs','ms_hlth_avgdlrs','ms_hlth_lastdlrs','ms_hlth_paystat_paid','ms_hlth_paymeth_cc','ms_hlth_osrc_dm','ms_hlth_lsrc_dm','ms_hlth_osrc_agt','ms_hlth_lsrc_agt','ms_hlth_osrc_tv','ms_hlth_lsrc_tv','ms_holiday','ms_history','ms_pub_cooking','ms_cooking','ms_pub_homedecr','ms_cat_homedecr','ms_homedecr','ms_housewares','ms_pub_garden','ms_cat_garden','ms_garden','ms_pub_homeliv','ms_cat_homeliv','ms_homeliv','ms_pub_home_status_active','ms_home_lmos','ms_home_omos','ms_home_pmos','ms_home_totords','ms_home_totitems','ms_home_totdlrs','ms_home_avgdlrs','ms_home_lastdlrs','ms_home_paystat_paid','ms_home_paymeth_cc','ms_home_paymeth_cash','ms_home_osrc_dm','ms_home_lsrc_dm','ms_home_osrc_agt','ms_home_lsrc_agt','ms_home_osrc_net','ms_home_lsrc_net','ms_home_osrc_tv','ms_home_lsrc_tv','ms_humor','ms_inspiration','ms_merchandise','ms_moneymaking','ms_moneymaking_lmos','ms_motorcycles','ms_music','ms_fishing','ms_hunting','ms_boatsail','ms_camp','ms_pub_outdoors','ms_cat_outdoors','ms_outdoors','ms_pub_out_status_active','ms_out_lmos','ms_out_omos','ms_out_pmos','ms_out_totords','ms_out_totitems','ms_out_totdlrs','ms_out_avgdlrs','ms_out_lastdlrs','ms_out_paystat_paid','ms_out_paymeth_cc','ms_out_paymeth_cash','ms_out_osrc_dm','ms_out_lsrc_dm','ms_out_osrc_agt','ms_out_lsrc_agt','ms_pets','ms_pfin','ms_photo','ms_photoproc','ms_rural','ms_science','ms_sports','ms_sports_lmos','ms_travel','ms_tvmovies','ms_wildlife','ms_woman','ms_woman_lmos','ms_ringtones_apps','cpi_mobile_apps_index','cpi_credit_repair_index','cpi_credit_report_index','cpi_education_seekers_index','cpi_insurance_index','cpi_insurance_health_index','cpi_insurance_auto_index','cpi_job_seekers_index','cpi_social_networking_index','cpi_adult_index','cpi_africanamerican_index','cpi_apparel_index','cpi_apparel_accessory_index','cpi_apparel_kids_index','cpi_apparel_men_index','cpi_apparel_menfash_index','cpi_apparel_women_index','cpi_apparel_womfash_index','cpi_asian_index','cpi_auto_index','cpi_auto_racing_index','cpi_auto_trucks_index','cpi_aviation_index','cpi_bargains_index','cpi_beauty_index','cpi_bible_index','cpi_birds_index','cpi_business_index','cpi_business_homeoffice_index','cpi_catalog_index','cpi_cc_index','cpi_collectibles_index','cpi_college_index','cpi_computers_index','cpi_conservative_index','cpi_continuity_index','cpi_cooking_index','cpi_crafts_index','cpi_crafts_crochet_index','cpi_crafts_knit_index','cpi_crafts_needlepoint_index','cpi_crafts_quilt_index','cpi_crafts_sew_index','cpi_culturearts_index','cpi_currevent_index','cpi_diy_index','cpi_donor_index','cpi_ego_index','cpi_electronics_index','cpi_equestrian_index','cpi_family_index','cpi_family_teen_index','cpi_family_young_index','cpi_fiction_index','cpi_gambling_index','cpi_games_index','cpi_gardening_index','cpi_gay_index','cpi_giftgivr_index','cpi_gourmet_index','cpi_grandparents_index','cpi_health_index','cpi_health_diet_index','cpi_health_fitness_index','cpi_hightech_index','cpi_hispanic_index','cpi_history_index','cpi_history_american_index','cpi_hobbies_index','cpi_homedecr_index','cpi_homeliv_index','cpi_humor_index','cpi_inspiration_index','cpi_internet_index','cpi_internet_access_index','cpi_internet_buy_index','cpi_liberal_index','cpi_moneymaking_index','cpi_motorcycles_index','cpi_music_index','cpi_nonfiction_index','cpi_ocean_index','cpi_outdoors_index','cpi_outdoors_boatsail_index','cpi_outdoors_camp_index','cpi_outdoors_fishing_index','cpi_outdoors_huntfish_index','cpi_outdoors_hunting_index','cpi_pets_index','cpi_pets_cats_index','cpi_pets_dogs_index','cpi_pfin_index','cpi_photog_index','cpi_photoproc_index','cpi_publish_index','cpi_publish_books_index','cpi_publish_mags_index','cpi_rural_index','cpi_science_index','cpi_scifi_index','cpi_seniors_index','cpi_sports_index','cpi_sports_baseball_index','cpi_sports_basketball_index','cpi_sports_biking_index','cpi_sports_football_index','cpi_sports_golf_index','cpi_sports_hockey_index','cpi_sports_running_index','cpi_sports_ski_index','cpi_sports_soccer_index','cpi_sports_swimming_index','cpi_sports_tennis_index','cpi_stationery_index','cpi_sweeps_index','cpi_tobacco_index','cpi_travel_index','cpi_travel_cruise_index','cpi_travel_rv_index','cpi_travel_us_index','cpi_tvmovies_index','cpi_wildlife_index','cpi_woman_index','totdlr_index','cpi_totdlr','cpi_totords','cpi_lastdlr','pkcatg','pkpubs','pkcont','pkca01','pkca03','pkca04','pkca05','pkca06','pkca07','pkca08','pkca09','pkca10','pkca11','pkca12','pkca13','pkca14','pkca15','pkca16','pkca17','pkca18','pkca20','pkca21','pkca22','pkca23','pkca24','pkca25','pkca26','pkca28','pkca29','pkca30','pkca31','pkca32','pkca33','pkca34','pkca35','pkca36','pkca37','pkca39','pkca40','pkca41','pkca42','pkca54','pkca61','pkca62','pkca64','pkpu01','pkpu02','pkpu03','pkpu04','pkpu05','pkpu06','pkpu07','pkpu08','pkpu09','pkpu10','pkpu11','pkpu12','pkpu13','pkpu14','pkpu15','pkpu16','pkpu17','pkpu18','pkpu19','pkpu20','pkpu23','pkpu25','pkpu27','pkpu28','pkpu29','pkpu30','pkpu31','pkpu32','pkpu33','pkpu34','pkpu35','pkpu38','pkpu41','pkpu42','pkpu45','pkpu46','pkpu47','pkpu48','pkpu49','pkpu50','pkpu51','pkpu52','pkpu53','pkpu54','pkpu55','pkpu56','pkpu57','pkpu60','pkpu61','pkpu62','pkpu63','pkpu64','pkpu65','pkpu66','pkpu67','pkpu68','pkpu69','pkpu70','censpct_water','cens_pop_density','cens_hu_density','censpct_pop_white','censpct_pop_black','censpct_pop_amerind','censpct_pop_asian','censpct_pop_pacisl','censpct_pop_othrace','censpct_pop_multirace','censpct_pop_hispanic','censpct_pop_agelt18','censpct_pop_males','censpct_adult_age1824','censpct_adult_age2534','censpct_adult_age3544','censpct_adult_age4554','censpct_adult_age5564','censpct_adult_agege65','cens_pop_medage','cens_hh_avgsize','censpct_hh_family','censpct_hh_family_husbwife','censpct_hu_occupied','censpct_hu_owned','censpct_hu_rented','censpct_hu_vacantseasonal','zip_medinc','zip_apparel','zip_apparel_women','zip_apparel_womfash','zip_auto','zip_beauty','zip_booksmusicmovies','zip_business','zip_catalog','zip_cc','zip_collectibles','zip_computers','zip_continuity','zip_cooking','zip_crafts','zip_culturearts','zip_dm_sold','zip_donor','zip_family','zip_gardening','zip_giftgivr','zip_gourmet','zip_health','zip_health_diet','zip_health_fitness','zip_hobbies','zip_homedecr','zip_homeliv','zip_internet','zip_internet_access','zip_internet_buy','zip_music','zip_outdoors','zip_pets','zip_pfin','zip_publish','zip_publish_books','zip_publish_mags','zip_sports','zip_sports_biking','zip_sports_golf','zip_travel','zip_travel_us','zip_tvmovies','zip_woman','zip_proftech','zip_retired','zip_inc100','zip_inc75','zip_inc50');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dtmatch_pcnt,le.populated_msname_pcnt,le.populated_msaddr1_pcnt,le.populated_msaddr2_pcnt,le.populated_mscity_pcnt,le.populated_msstate_pcnt,le.populated_mszip5_pcnt,le.populated_mszip4_pcnt,le.populated_dthh_pcnt,le.populated_mscrrt_pcnt,le.populated_msdpbc_pcnt,le.populated_msdpv_pcnt,le.populated_ms_addrtype_pcnt,le.populated_ctysize_pcnt,le.populated_lmos_pcnt,le.populated_omos_pcnt,le.populated_pmos_pcnt,le.populated_gen_pcnt,le.populated_dob_pcnt,le.populated_age_pcnt,le.populated_inc_pcnt,le.populated_marital_status_pcnt,le.populated_poc_pcnt,le.populated_noc_pcnt,le.populated_ocp_pcnt,le.populated_edu_pcnt,le.populated_lang_pcnt,le.populated_relig_pcnt,le.populated_dwell_pcnt,le.populated_ownr_pcnt,le.populated_eth1_pcnt,le.populated_eth2_pcnt,le.populated_lor_pcnt,le.populated_pool_pcnt,le.populated_speak_span_pcnt,le.populated_soho_pcnt,le.populated_vet_in_hh_pcnt,le.populated_ms_mags_pcnt,le.populated_ms_books_pcnt,le.populated_ms_publish_pcnt,le.populated_ms_pub_status_active_pcnt,le.populated_ms_pub_status_expire_pcnt,le.populated_ms_pub_premsold_pcnt,le.populated_ms_pub_autornwl_pcnt,le.populated_ms_pub_avgterm_pcnt,le.populated_ms_pub_lmos_pcnt,le.populated_ms_pub_omos_pcnt,le.populated_ms_pub_pmos_pcnt,le.populated_ms_pub_cemos_pcnt,le.populated_ms_pub_femos_pcnt,le.populated_ms_pub_totords_pcnt,le.populated_ms_pub_totdlrs_pcnt,le.populated_ms_pub_avgdlrs_pcnt,le.populated_ms_pub_lastdlrs_pcnt,le.populated_ms_pub_paystat_paid_pcnt,le.populated_ms_pub_paystat_ub_pcnt,le.populated_ms_pub_paymeth_cc_pcnt,le.populated_ms_pub_paymeth_cash_pcnt,le.populated_ms_pub_payspeed_pcnt,le.populated_ms_pub_osrc_dm_pcnt,le.populated_ms_pub_lsrc_dm_pcnt,le.populated_ms_pub_osrc_agt_cashf_pcnt,le.populated_ms_pub_lsrc_agt_cashf_pcnt,le.populated_ms_pub_osrc_agt_pds_pcnt,le.populated_ms_pub_lsrc_agt_pds_pcnt,le.populated_ms_pub_osrc_agt_schplan_pcnt,le.populated_ms_pub_lsrc_agt_schplan_pcnt,le.populated_ms_pub_osrc_agt_sponsor_pcnt,le.populated_ms_pub_lsrc_agt_sponsor_pcnt,le.populated_ms_pub_osrc_agt_tm_pcnt,le.populated_ms_pub_lsrc_agt_tm_pcnt,le.populated_ms_pub_osrc_agt_pcnt,le.populated_ms_pub_lsrc_agt_pcnt,le.populated_ms_pub_osrc_tm_pcnt,le.populated_ms_pub_lsrc_tm_pcnt,le.populated_ms_pub_osrc_ins_pcnt,le.populated_ms_pub_lsrc_ins_pcnt,le.populated_ms_pub_osrc_net_pcnt,le.populated_ms_pub_lsrc_net_pcnt,le.populated_ms_pub_osrc_print_pcnt,le.populated_ms_pub_lsrc_print_pcnt,le.populated_ms_pub_osrc_trans_pcnt,le.populated_ms_pub_lsrc_trans_pcnt,le.populated_ms_pub_osrc_tv_pcnt,le.populated_ms_pub_lsrc_tv_pcnt,le.populated_ms_pub_osrc_dtp_pcnt,le.populated_ms_pub_lsrc_dtp_pcnt,le.populated_ms_pub_giftgivr_pcnt,le.populated_ms_pub_giftee_pcnt,le.populated_ms_catalog_pcnt,le.populated_ms_cat_lmos_pcnt,le.populated_ms_cat_omos_pcnt,le.populated_ms_cat_pmos_pcnt,le.populated_ms_cat_totords_pcnt,le.populated_ms_cat_totitems_pcnt,le.populated_ms_cat_totdlrs_pcnt,le.populated_ms_cat_avgdlrs_pcnt,le.populated_ms_cat_lastdlrs_pcnt,le.populated_ms_cat_paystat_paid_pcnt,le.populated_ms_cat_paymeth_cc_pcnt,le.populated_ms_cat_paymeth_cash_pcnt,le.populated_ms_cat_osrc_dm_pcnt,le.populated_ms_cat_lsrc_dm_pcnt,le.populated_ms_cat_osrc_net_pcnt,le.populated_ms_cat_lsrc_net_pcnt,le.populated_ms_cat_giftgivr_pcnt,le.populated_pkpubs_corrected_pcnt,le.populated_pkcatg_corrected_pcnt,le.populated_ms_fundraising_pcnt,le.populated_ms_fund_lmos_pcnt,le.populated_ms_fund_omos_pcnt,le.populated_ms_fund_pmos_pcnt,le.populated_ms_fund_totords_pcnt,le.populated_ms_fund_totdlrs_pcnt,le.populated_ms_fund_avgdlrs_pcnt,le.populated_ms_fund_lastdlrs_pcnt,le.populated_ms_fund_paystat_paid_pcnt,le.populated_ms_other_pcnt,le.populated_ms_continuity_pcnt,le.populated_ms_cont_status_active_pcnt,le.populated_ms_cont_status_cancel_pcnt,le.populated_ms_cont_omos_pcnt,le.populated_ms_cont_lmos_pcnt,le.populated_ms_cont_pmos_pcnt,le.populated_ms_cont_totords_pcnt,le.populated_ms_cont_totdlrs_pcnt,le.populated_ms_cont_avgdlrs_pcnt,le.populated_ms_cont_lastdlrs_pcnt,le.populated_ms_cont_paystat_paid_pcnt,le.populated_ms_cont_paymeth_cc_pcnt,le.populated_ms_cont_paymeth_cash_pcnt,le.populated_ms_totords_pcnt,le.populated_ms_totitems_pcnt,le.populated_ms_totdlrs_pcnt,le.populated_ms_avgdlrs_pcnt,le.populated_ms_lastdlrs_pcnt,le.populated_ms_paystat_paid_pcnt,le.populated_ms_paymeth_cc_pcnt,le.populated_ms_paymeth_cash_pcnt,le.populated_ms_osrc_dm_pcnt,le.populated_ms_lsrc_dm_pcnt,le.populated_ms_osrc_tm_pcnt,le.populated_ms_lsrc_tm_pcnt,le.populated_ms_osrc_ins_pcnt,le.populated_ms_lsrc_ins_pcnt,le.populated_ms_osrc_net_pcnt,le.populated_ms_lsrc_net_pcnt,le.populated_ms_osrc_tv_pcnt,le.populated_ms_lsrc_tv_pcnt,le.populated_ms_osrc_retail_pcnt,le.populated_ms_lsrc_retail_pcnt,le.populated_ms_giftgivr_pcnt,le.populated_ms_giftee_pcnt,le.populated_ms_adult_pcnt,le.populated_ms_womapp_pcnt,le.populated_ms_menapp_pcnt,le.populated_ms_kidapp_pcnt,le.populated_ms_accessory_pcnt,le.populated_ms_apparel_pcnt,le.populated_ms_app_lmos_pcnt,le.populated_ms_app_omos_pcnt,le.populated_ms_app_pmos_pcnt,le.populated_ms_app_totords_pcnt,le.populated_ms_app_totitems_pcnt,le.populated_ms_app_totdlrs_pcnt,le.populated_ms_app_avgdlrs_pcnt,le.populated_ms_app_lastdlrs_pcnt,le.populated_ms_app_paystat_paid_pcnt,le.populated_ms_app_paymeth_cc_pcnt,le.populated_ms_app_paymeth_cash_pcnt,le.populated_ms_menfash_pcnt,le.populated_ms_womfash_pcnt,le.populated_ms_wfsh_lmos_pcnt,le.populated_ms_wfsh_omos_pcnt,le.populated_ms_wfsh_pmos_pcnt,le.populated_ms_wfsh_totords_pcnt,le.populated_ms_wfsh_totdlrs_pcnt,le.populated_ms_wfsh_avgdlrs_pcnt,le.populated_ms_wfsh_lastdlrs_pcnt,le.populated_ms_wfsh_paystat_paid_pcnt,le.populated_ms_wfsh_osrc_dm_pcnt,le.populated_ms_wfsh_lsrc_dm_pcnt,le.populated_ms_wfsh_osrc_agt_pcnt,le.populated_ms_wfsh_lsrc_agt_pcnt,le.populated_ms_audio_pcnt,le.populated_ms_auto_pcnt,le.populated_ms_aviation_pcnt,le.populated_ms_bargains_pcnt,le.populated_ms_beauty_pcnt,le.populated_ms_bible_pcnt,le.populated_ms_bible_lmos_pcnt,le.populated_ms_bible_omos_pcnt,le.populated_ms_bible_pmos_pcnt,le.populated_ms_bible_totords_pcnt,le.populated_ms_bible_totitems_pcnt,le.populated_ms_bible_totdlrs_pcnt,le.populated_ms_bible_avgdlrs_pcnt,le.populated_ms_bible_lastdlrs_pcnt,le.populated_ms_bible_paystat_paid_pcnt,le.populated_ms_bible_paymeth_cc_pcnt,le.populated_ms_bible_paymeth_cash_pcnt,le.populated_ms_business_pcnt,le.populated_ms_collectibles_pcnt,le.populated_ms_computers_pcnt,le.populated_ms_crafts_pcnt,le.populated_ms_culturearts_pcnt,le.populated_ms_currevent_pcnt,le.populated_ms_diy_pcnt,le.populated_ms_electronics_pcnt,le.populated_ms_equestrian_pcnt,le.populated_ms_pub_family_pcnt,le.populated_ms_cat_family_pcnt,le.populated_ms_family_pcnt,le.populated_ms_family_lmos_pcnt,le.populated_ms_family_omos_pcnt,le.populated_ms_family_pmos_pcnt,le.populated_ms_family_totords_pcnt,le.populated_ms_family_totitems_pcnt,le.populated_ms_family_totdlrs_pcnt,le.populated_ms_family_avgdlrs_pcnt,le.populated_ms_family_lastdlrs_pcnt,le.populated_ms_family_paystat_paid_pcnt,le.populated_ms_family_paymeth_cc_pcnt,le.populated_ms_family_paymeth_cash_pcnt,le.populated_ms_family_osrc_dm_pcnt,le.populated_ms_family_lsrc_dm_pcnt,le.populated_ms_fiction_pcnt,le.populated_ms_food_pcnt,le.populated_ms_games_pcnt,le.populated_ms_gifts_pcnt,le.populated_ms_gourmet_pcnt,le.populated_ms_fitness_pcnt,le.populated_ms_health_pcnt,le.populated_ms_hlth_lmos_pcnt,le.populated_ms_hlth_omos_pcnt,le.populated_ms_hlth_pmos_pcnt,le.populated_ms_hlth_totords_pcnt,le.populated_ms_hlth_totdlrs_pcnt,le.populated_ms_hlth_avgdlrs_pcnt,le.populated_ms_hlth_lastdlrs_pcnt,le.populated_ms_hlth_paystat_paid_pcnt,le.populated_ms_hlth_paymeth_cc_pcnt,le.populated_ms_hlth_osrc_dm_pcnt,le.populated_ms_hlth_lsrc_dm_pcnt,le.populated_ms_hlth_osrc_agt_pcnt,le.populated_ms_hlth_lsrc_agt_pcnt,le.populated_ms_hlth_osrc_tv_pcnt,le.populated_ms_hlth_lsrc_tv_pcnt,le.populated_ms_holiday_pcnt,le.populated_ms_history_pcnt,le.populated_ms_pub_cooking_pcnt,le.populated_ms_cooking_pcnt,le.populated_ms_pub_homedecr_pcnt,le.populated_ms_cat_homedecr_pcnt,le.populated_ms_homedecr_pcnt,le.populated_ms_housewares_pcnt,le.populated_ms_pub_garden_pcnt,le.populated_ms_cat_garden_pcnt,le.populated_ms_garden_pcnt,le.populated_ms_pub_homeliv_pcnt,le.populated_ms_cat_homeliv_pcnt,le.populated_ms_homeliv_pcnt,le.populated_ms_pub_home_status_active_pcnt,le.populated_ms_home_lmos_pcnt,le.populated_ms_home_omos_pcnt,le.populated_ms_home_pmos_pcnt,le.populated_ms_home_totords_pcnt,le.populated_ms_home_totitems_pcnt,le.populated_ms_home_totdlrs_pcnt,le.populated_ms_home_avgdlrs_pcnt,le.populated_ms_home_lastdlrs_pcnt,le.populated_ms_home_paystat_paid_pcnt,le.populated_ms_home_paymeth_cc_pcnt,le.populated_ms_home_paymeth_cash_pcnt,le.populated_ms_home_osrc_dm_pcnt,le.populated_ms_home_lsrc_dm_pcnt,le.populated_ms_home_osrc_agt_pcnt,le.populated_ms_home_lsrc_agt_pcnt,le.populated_ms_home_osrc_net_pcnt,le.populated_ms_home_lsrc_net_pcnt,le.populated_ms_home_osrc_tv_pcnt,le.populated_ms_home_lsrc_tv_pcnt,le.populated_ms_humor_pcnt,le.populated_ms_inspiration_pcnt,le.populated_ms_merchandise_pcnt,le.populated_ms_moneymaking_pcnt,le.populated_ms_moneymaking_lmos_pcnt,le.populated_ms_motorcycles_pcnt,le.populated_ms_music_pcnt,le.populated_ms_fishing_pcnt,le.populated_ms_hunting_pcnt,le.populated_ms_boatsail_pcnt,le.populated_ms_camp_pcnt,le.populated_ms_pub_outdoors_pcnt,le.populated_ms_cat_outdoors_pcnt,le.populated_ms_outdoors_pcnt,le.populated_ms_pub_out_status_active_pcnt,le.populated_ms_out_lmos_pcnt,le.populated_ms_out_omos_pcnt,le.populated_ms_out_pmos_pcnt,le.populated_ms_out_totords_pcnt,le.populated_ms_out_totitems_pcnt,le.populated_ms_out_totdlrs_pcnt,le.populated_ms_out_avgdlrs_pcnt,le.populated_ms_out_lastdlrs_pcnt,le.populated_ms_out_paystat_paid_pcnt,le.populated_ms_out_paymeth_cc_pcnt,le.populated_ms_out_paymeth_cash_pcnt,le.populated_ms_out_osrc_dm_pcnt,le.populated_ms_out_lsrc_dm_pcnt,le.populated_ms_out_osrc_agt_pcnt,le.populated_ms_out_lsrc_agt_pcnt,le.populated_ms_pets_pcnt,le.populated_ms_pfin_pcnt,le.populated_ms_photo_pcnt,le.populated_ms_photoproc_pcnt,le.populated_ms_rural_pcnt,le.populated_ms_science_pcnt,le.populated_ms_sports_pcnt,le.populated_ms_sports_lmos_pcnt,le.populated_ms_travel_pcnt,le.populated_ms_tvmovies_pcnt,le.populated_ms_wildlife_pcnt,le.populated_ms_woman_pcnt,le.populated_ms_woman_lmos_pcnt,le.populated_ms_ringtones_apps_pcnt,le.populated_cpi_mobile_apps_index_pcnt,le.populated_cpi_credit_repair_index_pcnt,le.populated_cpi_credit_report_index_pcnt,le.populated_cpi_education_seekers_index_pcnt,le.populated_cpi_insurance_index_pcnt,le.populated_cpi_insurance_health_index_pcnt,le.populated_cpi_insurance_auto_index_pcnt,le.populated_cpi_job_seekers_index_pcnt,le.populated_cpi_social_networking_index_pcnt,le.populated_cpi_adult_index_pcnt,le.populated_cpi_africanamerican_index_pcnt,le.populated_cpi_apparel_index_pcnt,le.populated_cpi_apparel_accessory_index_pcnt,le.populated_cpi_apparel_kids_index_pcnt,le.populated_cpi_apparel_men_index_pcnt,le.populated_cpi_apparel_menfash_index_pcnt,le.populated_cpi_apparel_women_index_pcnt,le.populated_cpi_apparel_womfash_index_pcnt,le.populated_cpi_asian_index_pcnt,le.populated_cpi_auto_index_pcnt,le.populated_cpi_auto_racing_index_pcnt,le.populated_cpi_auto_trucks_index_pcnt,le.populated_cpi_aviation_index_pcnt,le.populated_cpi_bargains_index_pcnt,le.populated_cpi_beauty_index_pcnt,le.populated_cpi_bible_index_pcnt,le.populated_cpi_birds_index_pcnt,le.populated_cpi_business_index_pcnt,le.populated_cpi_business_homeoffice_index_pcnt,le.populated_cpi_catalog_index_pcnt,le.populated_cpi_cc_index_pcnt,le.populated_cpi_collectibles_index_pcnt,le.populated_cpi_college_index_pcnt,le.populated_cpi_computers_index_pcnt,le.populated_cpi_conservative_index_pcnt,le.populated_cpi_continuity_index_pcnt,le.populated_cpi_cooking_index_pcnt,le.populated_cpi_crafts_index_pcnt,le.populated_cpi_crafts_crochet_index_pcnt,le.populated_cpi_crafts_knit_index_pcnt,le.populated_cpi_crafts_needlepoint_index_pcnt,le.populated_cpi_crafts_quilt_index_pcnt,le.populated_cpi_crafts_sew_index_pcnt,le.populated_cpi_culturearts_index_pcnt,le.populated_cpi_currevent_index_pcnt,le.populated_cpi_diy_index_pcnt,le.populated_cpi_donor_index_pcnt,le.populated_cpi_ego_index_pcnt,le.populated_cpi_electronics_index_pcnt,le.populated_cpi_equestrian_index_pcnt,le.populated_cpi_family_index_pcnt,le.populated_cpi_family_teen_index_pcnt,le.populated_cpi_family_young_index_pcnt,le.populated_cpi_fiction_index_pcnt,le.populated_cpi_gambling_index_pcnt,le.populated_cpi_games_index_pcnt,le.populated_cpi_gardening_index_pcnt,le.populated_cpi_gay_index_pcnt,le.populated_cpi_giftgivr_index_pcnt,le.populated_cpi_gourmet_index_pcnt,le.populated_cpi_grandparents_index_pcnt,le.populated_cpi_health_index_pcnt,le.populated_cpi_health_diet_index_pcnt,le.populated_cpi_health_fitness_index_pcnt,le.populated_cpi_hightech_index_pcnt,le.populated_cpi_hispanic_index_pcnt,le.populated_cpi_history_index_pcnt,le.populated_cpi_history_american_index_pcnt,le.populated_cpi_hobbies_index_pcnt,le.populated_cpi_homedecr_index_pcnt,le.populated_cpi_homeliv_index_pcnt,le.populated_cpi_humor_index_pcnt,le.populated_cpi_inspiration_index_pcnt,le.populated_cpi_internet_index_pcnt,le.populated_cpi_internet_access_index_pcnt,le.populated_cpi_internet_buy_index_pcnt,le.populated_cpi_liberal_index_pcnt,le.populated_cpi_moneymaking_index_pcnt,le.populated_cpi_motorcycles_index_pcnt,le.populated_cpi_music_index_pcnt,le.populated_cpi_nonfiction_index_pcnt,le.populated_cpi_ocean_index_pcnt,le.populated_cpi_outdoors_index_pcnt,le.populated_cpi_outdoors_boatsail_index_pcnt,le.populated_cpi_outdoors_camp_index_pcnt,le.populated_cpi_outdoors_fishing_index_pcnt,le.populated_cpi_outdoors_huntfish_index_pcnt,le.populated_cpi_outdoors_hunting_index_pcnt,le.populated_cpi_pets_index_pcnt,le.populated_cpi_pets_cats_index_pcnt,le.populated_cpi_pets_dogs_index_pcnt,le.populated_cpi_pfin_index_pcnt,le.populated_cpi_photog_index_pcnt,le.populated_cpi_photoproc_index_pcnt,le.populated_cpi_publish_index_pcnt,le.populated_cpi_publish_books_index_pcnt,le.populated_cpi_publish_mags_index_pcnt,le.populated_cpi_rural_index_pcnt,le.populated_cpi_science_index_pcnt,le.populated_cpi_scifi_index_pcnt,le.populated_cpi_seniors_index_pcnt,le.populated_cpi_sports_index_pcnt,le.populated_cpi_sports_baseball_index_pcnt,le.populated_cpi_sports_basketball_index_pcnt,le.populated_cpi_sports_biking_index_pcnt,le.populated_cpi_sports_football_index_pcnt,le.populated_cpi_sports_golf_index_pcnt,le.populated_cpi_sports_hockey_index_pcnt,le.populated_cpi_sports_running_index_pcnt,le.populated_cpi_sports_ski_index_pcnt,le.populated_cpi_sports_soccer_index_pcnt,le.populated_cpi_sports_swimming_index_pcnt,le.populated_cpi_sports_tennis_index_pcnt,le.populated_cpi_stationery_index_pcnt,le.populated_cpi_sweeps_index_pcnt,le.populated_cpi_tobacco_index_pcnt,le.populated_cpi_travel_index_pcnt,le.populated_cpi_travel_cruise_index_pcnt,le.populated_cpi_travel_rv_index_pcnt,le.populated_cpi_travel_us_index_pcnt,le.populated_cpi_tvmovies_index_pcnt,le.populated_cpi_wildlife_index_pcnt,le.populated_cpi_woman_index_pcnt,le.populated_totdlr_index_pcnt,le.populated_cpi_totdlr_pcnt,le.populated_cpi_totords_pcnt,le.populated_cpi_lastdlr_pcnt,le.populated_pkcatg_pcnt,le.populated_pkpubs_pcnt,le.populated_pkcont_pcnt,le.populated_pkca01_pcnt,le.populated_pkca03_pcnt,le.populated_pkca04_pcnt,le.populated_pkca05_pcnt,le.populated_pkca06_pcnt,le.populated_pkca07_pcnt,le.populated_pkca08_pcnt,le.populated_pkca09_pcnt,le.populated_pkca10_pcnt,le.populated_pkca11_pcnt,le.populated_pkca12_pcnt,le.populated_pkca13_pcnt,le.populated_pkca14_pcnt,le.populated_pkca15_pcnt,le.populated_pkca16_pcnt,le.populated_pkca17_pcnt,le.populated_pkca18_pcnt,le.populated_pkca20_pcnt,le.populated_pkca21_pcnt,le.populated_pkca22_pcnt,le.populated_pkca23_pcnt,le.populated_pkca24_pcnt,le.populated_pkca25_pcnt,le.populated_pkca26_pcnt,le.populated_pkca28_pcnt,le.populated_pkca29_pcnt,le.populated_pkca30_pcnt,le.populated_pkca31_pcnt,le.populated_pkca32_pcnt,le.populated_pkca33_pcnt,le.populated_pkca34_pcnt,le.populated_pkca35_pcnt,le.populated_pkca36_pcnt,le.populated_pkca37_pcnt,le.populated_pkca39_pcnt,le.populated_pkca40_pcnt,le.populated_pkca41_pcnt,le.populated_pkca42_pcnt,le.populated_pkca54_pcnt,le.populated_pkca61_pcnt,le.populated_pkca62_pcnt,le.populated_pkca64_pcnt,le.populated_pkpu01_pcnt,le.populated_pkpu02_pcnt,le.populated_pkpu03_pcnt,le.populated_pkpu04_pcnt,le.populated_pkpu05_pcnt,le.populated_pkpu06_pcnt,le.populated_pkpu07_pcnt,le.populated_pkpu08_pcnt,le.populated_pkpu09_pcnt,le.populated_pkpu10_pcnt,le.populated_pkpu11_pcnt,le.populated_pkpu12_pcnt,le.populated_pkpu13_pcnt,le.populated_pkpu14_pcnt,le.populated_pkpu15_pcnt,le.populated_pkpu16_pcnt,le.populated_pkpu17_pcnt,le.populated_pkpu18_pcnt,le.populated_pkpu19_pcnt,le.populated_pkpu20_pcnt,le.populated_pkpu23_pcnt,le.populated_pkpu25_pcnt,le.populated_pkpu27_pcnt,le.populated_pkpu28_pcnt,le.populated_pkpu29_pcnt,le.populated_pkpu30_pcnt,le.populated_pkpu31_pcnt,le.populated_pkpu32_pcnt,le.populated_pkpu33_pcnt,le.populated_pkpu34_pcnt,le.populated_pkpu35_pcnt,le.populated_pkpu38_pcnt,le.populated_pkpu41_pcnt,le.populated_pkpu42_pcnt,le.populated_pkpu45_pcnt,le.populated_pkpu46_pcnt,le.populated_pkpu47_pcnt,le.populated_pkpu48_pcnt,le.populated_pkpu49_pcnt,le.populated_pkpu50_pcnt,le.populated_pkpu51_pcnt,le.populated_pkpu52_pcnt,le.populated_pkpu53_pcnt,le.populated_pkpu54_pcnt,le.populated_pkpu55_pcnt,le.populated_pkpu56_pcnt,le.populated_pkpu57_pcnt,le.populated_pkpu60_pcnt,le.populated_pkpu61_pcnt,le.populated_pkpu62_pcnt,le.populated_pkpu63_pcnt,le.populated_pkpu64_pcnt,le.populated_pkpu65_pcnt,le.populated_pkpu66_pcnt,le.populated_pkpu67_pcnt,le.populated_pkpu68_pcnt,le.populated_pkpu69_pcnt,le.populated_pkpu70_pcnt,le.populated_censpct_water_pcnt,le.populated_cens_pop_density_pcnt,le.populated_cens_hu_density_pcnt,le.populated_censpct_pop_white_pcnt,le.populated_censpct_pop_black_pcnt,le.populated_censpct_pop_amerind_pcnt,le.populated_censpct_pop_asian_pcnt,le.populated_censpct_pop_pacisl_pcnt,le.populated_censpct_pop_othrace_pcnt,le.populated_censpct_pop_multirace_pcnt,le.populated_censpct_pop_hispanic_pcnt,le.populated_censpct_pop_agelt18_pcnt,le.populated_censpct_pop_males_pcnt,le.populated_censpct_adult_age1824_pcnt,le.populated_censpct_adult_age2534_pcnt,le.populated_censpct_adult_age3544_pcnt,le.populated_censpct_adult_age4554_pcnt,le.populated_censpct_adult_age5564_pcnt,le.populated_censpct_adult_agege65_pcnt,le.populated_cens_pop_medage_pcnt,le.populated_cens_hh_avgsize_pcnt,le.populated_censpct_hh_family_pcnt,le.populated_censpct_hh_family_husbwife_pcnt,le.populated_censpct_hu_occupied_pcnt,le.populated_censpct_hu_owned_pcnt,le.populated_censpct_hu_rented_pcnt,le.populated_censpct_hu_vacantseasonal_pcnt,le.populated_zip_medinc_pcnt,le.populated_zip_apparel_pcnt,le.populated_zip_apparel_women_pcnt,le.populated_zip_apparel_womfash_pcnt,le.populated_zip_auto_pcnt,le.populated_zip_beauty_pcnt,le.populated_zip_booksmusicmovies_pcnt,le.populated_zip_business_pcnt,le.populated_zip_catalog_pcnt,le.populated_zip_cc_pcnt,le.populated_zip_collectibles_pcnt,le.populated_zip_computers_pcnt,le.populated_zip_continuity_pcnt,le.populated_zip_cooking_pcnt,le.populated_zip_crafts_pcnt,le.populated_zip_culturearts_pcnt,le.populated_zip_dm_sold_pcnt,le.populated_zip_donor_pcnt,le.populated_zip_family_pcnt,le.populated_zip_gardening_pcnt,le.populated_zip_giftgivr_pcnt,le.populated_zip_gourmet_pcnt,le.populated_zip_health_pcnt,le.populated_zip_health_diet_pcnt,le.populated_zip_health_fitness_pcnt,le.populated_zip_hobbies_pcnt,le.populated_zip_homedecr_pcnt,le.populated_zip_homeliv_pcnt,le.populated_zip_internet_pcnt,le.populated_zip_internet_access_pcnt,le.populated_zip_internet_buy_pcnt,le.populated_zip_music_pcnt,le.populated_zip_outdoors_pcnt,le.populated_zip_pets_pcnt,le.populated_zip_pfin_pcnt,le.populated_zip_publish_pcnt,le.populated_zip_publish_books_pcnt,le.populated_zip_publish_mags_pcnt,le.populated_zip_sports_pcnt,le.populated_zip_sports_biking_pcnt,le.populated_zip_sports_golf_pcnt,le.populated_zip_travel_pcnt,le.populated_zip_travel_us_pcnt,le.populated_zip_tvmovies_pcnt,le.populated_zip_woman_pcnt,le.populated_zip_proftech_pcnt,le.populated_zip_retired_pcnt,le.populated_zip_inc100_pcnt,le.populated_zip_inc75_pcnt,le.populated_zip_inc50_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dtmatch,le.maxlength_msname,le.maxlength_msaddr1,le.maxlength_msaddr2,le.maxlength_mscity,le.maxlength_msstate,le.maxlength_mszip5,le.maxlength_mszip4,le.maxlength_dthh,le.maxlength_mscrrt,le.maxlength_msdpbc,le.maxlength_msdpv,le.maxlength_ms_addrtype,le.maxlength_ctysize,le.maxlength_lmos,le.maxlength_omos,le.maxlength_pmos,le.maxlength_gen,le.maxlength_dob,le.maxlength_age,le.maxlength_inc,le.maxlength_marital_status,le.maxlength_poc,le.maxlength_noc,le.maxlength_ocp,le.maxlength_edu,le.maxlength_lang,le.maxlength_relig,le.maxlength_dwell,le.maxlength_ownr,le.maxlength_eth1,le.maxlength_eth2,le.maxlength_lor,le.maxlength_pool,le.maxlength_speak_span,le.maxlength_soho,le.maxlength_vet_in_hh,le.maxlength_ms_mags,le.maxlength_ms_books,le.maxlength_ms_publish,le.maxlength_ms_pub_status_active,le.maxlength_ms_pub_status_expire,le.maxlength_ms_pub_premsold,le.maxlength_ms_pub_autornwl,le.maxlength_ms_pub_avgterm,le.maxlength_ms_pub_lmos,le.maxlength_ms_pub_omos,le.maxlength_ms_pub_pmos,le.maxlength_ms_pub_cemos,le.maxlength_ms_pub_femos,le.maxlength_ms_pub_totords,le.maxlength_ms_pub_totdlrs,le.maxlength_ms_pub_avgdlrs,le.maxlength_ms_pub_lastdlrs,le.maxlength_ms_pub_paystat_paid,le.maxlength_ms_pub_paystat_ub,le.maxlength_ms_pub_paymeth_cc,le.maxlength_ms_pub_paymeth_cash,le.maxlength_ms_pub_payspeed,le.maxlength_ms_pub_osrc_dm,le.maxlength_ms_pub_lsrc_dm,le.maxlength_ms_pub_osrc_agt_cashf,le.maxlength_ms_pub_lsrc_agt_cashf,le.maxlength_ms_pub_osrc_agt_pds,le.maxlength_ms_pub_lsrc_agt_pds,le.maxlength_ms_pub_osrc_agt_schplan,le.maxlength_ms_pub_lsrc_agt_schplan,le.maxlength_ms_pub_osrc_agt_sponsor,le.maxlength_ms_pub_lsrc_agt_sponsor,le.maxlength_ms_pub_osrc_agt_tm,le.maxlength_ms_pub_lsrc_agt_tm,le.maxlength_ms_pub_osrc_agt,le.maxlength_ms_pub_lsrc_agt,le.maxlength_ms_pub_osrc_tm,le.maxlength_ms_pub_lsrc_tm,le.maxlength_ms_pub_osrc_ins,le.maxlength_ms_pub_lsrc_ins,le.maxlength_ms_pub_osrc_net,le.maxlength_ms_pub_lsrc_net,le.maxlength_ms_pub_osrc_print,le.maxlength_ms_pub_lsrc_print,le.maxlength_ms_pub_osrc_trans,le.maxlength_ms_pub_lsrc_trans,le.maxlength_ms_pub_osrc_tv,le.maxlength_ms_pub_lsrc_tv,le.maxlength_ms_pub_osrc_dtp,le.maxlength_ms_pub_lsrc_dtp,le.maxlength_ms_pub_giftgivr,le.maxlength_ms_pub_giftee,le.maxlength_ms_catalog,le.maxlength_ms_cat_lmos,le.maxlength_ms_cat_omos,le.maxlength_ms_cat_pmos,le.maxlength_ms_cat_totords,le.maxlength_ms_cat_totitems,le.maxlength_ms_cat_totdlrs,le.maxlength_ms_cat_avgdlrs,le.maxlength_ms_cat_lastdlrs,le.maxlength_ms_cat_paystat_paid,le.maxlength_ms_cat_paymeth_cc,le.maxlength_ms_cat_paymeth_cash,le.maxlength_ms_cat_osrc_dm,le.maxlength_ms_cat_lsrc_dm,le.maxlength_ms_cat_osrc_net,le.maxlength_ms_cat_lsrc_net,le.maxlength_ms_cat_giftgivr,le.maxlength_pkpubs_corrected,le.maxlength_pkcatg_corrected,le.maxlength_ms_fundraising,le.maxlength_ms_fund_lmos,le.maxlength_ms_fund_omos,le.maxlength_ms_fund_pmos,le.maxlength_ms_fund_totords,le.maxlength_ms_fund_totdlrs,le.maxlength_ms_fund_avgdlrs,le.maxlength_ms_fund_lastdlrs,le.maxlength_ms_fund_paystat_paid,le.maxlength_ms_other,le.maxlength_ms_continuity,le.maxlength_ms_cont_status_active,le.maxlength_ms_cont_status_cancel,le.maxlength_ms_cont_omos,le.maxlength_ms_cont_lmos,le.maxlength_ms_cont_pmos,le.maxlength_ms_cont_totords,le.maxlength_ms_cont_totdlrs,le.maxlength_ms_cont_avgdlrs,le.maxlength_ms_cont_lastdlrs,le.maxlength_ms_cont_paystat_paid,le.maxlength_ms_cont_paymeth_cc,le.maxlength_ms_cont_paymeth_cash,le.maxlength_ms_totords,le.maxlength_ms_totitems,le.maxlength_ms_totdlrs,le.maxlength_ms_avgdlrs,le.maxlength_ms_lastdlrs,le.maxlength_ms_paystat_paid,le.maxlength_ms_paymeth_cc,le.maxlength_ms_paymeth_cash,le.maxlength_ms_osrc_dm,le.maxlength_ms_lsrc_dm,le.maxlength_ms_osrc_tm,le.maxlength_ms_lsrc_tm,le.maxlength_ms_osrc_ins,le.maxlength_ms_lsrc_ins,le.maxlength_ms_osrc_net,le.maxlength_ms_lsrc_net,le.maxlength_ms_osrc_tv,le.maxlength_ms_lsrc_tv,le.maxlength_ms_osrc_retail,le.maxlength_ms_lsrc_retail,le.maxlength_ms_giftgivr,le.maxlength_ms_giftee,le.maxlength_ms_adult,le.maxlength_ms_womapp,le.maxlength_ms_menapp,le.maxlength_ms_kidapp,le.maxlength_ms_accessory,le.maxlength_ms_apparel,le.maxlength_ms_app_lmos,le.maxlength_ms_app_omos,le.maxlength_ms_app_pmos,le.maxlength_ms_app_totords,le.maxlength_ms_app_totitems,le.maxlength_ms_app_totdlrs,le.maxlength_ms_app_avgdlrs,le.maxlength_ms_app_lastdlrs,le.maxlength_ms_app_paystat_paid,le.maxlength_ms_app_paymeth_cc,le.maxlength_ms_app_paymeth_cash,le.maxlength_ms_menfash,le.maxlength_ms_womfash,le.maxlength_ms_wfsh_lmos,le.maxlength_ms_wfsh_omos,le.maxlength_ms_wfsh_pmos,le.maxlength_ms_wfsh_totords,le.maxlength_ms_wfsh_totdlrs,le.maxlength_ms_wfsh_avgdlrs,le.maxlength_ms_wfsh_lastdlrs,le.maxlength_ms_wfsh_paystat_paid,le.maxlength_ms_wfsh_osrc_dm,le.maxlength_ms_wfsh_lsrc_dm,le.maxlength_ms_wfsh_osrc_agt,le.maxlength_ms_wfsh_lsrc_agt,le.maxlength_ms_audio,le.maxlength_ms_auto,le.maxlength_ms_aviation,le.maxlength_ms_bargains,le.maxlength_ms_beauty,le.maxlength_ms_bible,le.maxlength_ms_bible_lmos,le.maxlength_ms_bible_omos,le.maxlength_ms_bible_pmos,le.maxlength_ms_bible_totords,le.maxlength_ms_bible_totitems,le.maxlength_ms_bible_totdlrs,le.maxlength_ms_bible_avgdlrs,le.maxlength_ms_bible_lastdlrs,le.maxlength_ms_bible_paystat_paid,le.maxlength_ms_bible_paymeth_cc,le.maxlength_ms_bible_paymeth_cash,le.maxlength_ms_business,le.maxlength_ms_collectibles,le.maxlength_ms_computers,le.maxlength_ms_crafts,le.maxlength_ms_culturearts,le.maxlength_ms_currevent,le.maxlength_ms_diy,le.maxlength_ms_electronics,le.maxlength_ms_equestrian,le.maxlength_ms_pub_family,le.maxlength_ms_cat_family,le.maxlength_ms_family,le.maxlength_ms_family_lmos,le.maxlength_ms_family_omos,le.maxlength_ms_family_pmos,le.maxlength_ms_family_totords,le.maxlength_ms_family_totitems,le.maxlength_ms_family_totdlrs,le.maxlength_ms_family_avgdlrs,le.maxlength_ms_family_lastdlrs,le.maxlength_ms_family_paystat_paid,le.maxlength_ms_family_paymeth_cc,le.maxlength_ms_family_paymeth_cash,le.maxlength_ms_family_osrc_dm,le.maxlength_ms_family_lsrc_dm,le.maxlength_ms_fiction,le.maxlength_ms_food,le.maxlength_ms_games,le.maxlength_ms_gifts,le.maxlength_ms_gourmet,le.maxlength_ms_fitness,le.maxlength_ms_health,le.maxlength_ms_hlth_lmos,le.maxlength_ms_hlth_omos,le.maxlength_ms_hlth_pmos,le.maxlength_ms_hlth_totords,le.maxlength_ms_hlth_totdlrs,le.maxlength_ms_hlth_avgdlrs,le.maxlength_ms_hlth_lastdlrs,le.maxlength_ms_hlth_paystat_paid,le.maxlength_ms_hlth_paymeth_cc,le.maxlength_ms_hlth_osrc_dm,le.maxlength_ms_hlth_lsrc_dm,le.maxlength_ms_hlth_osrc_agt,le.maxlength_ms_hlth_lsrc_agt,le.maxlength_ms_hlth_osrc_tv,le.maxlength_ms_hlth_lsrc_tv,le.maxlength_ms_holiday,le.maxlength_ms_history,le.maxlength_ms_pub_cooking,le.maxlength_ms_cooking,le.maxlength_ms_pub_homedecr,le.maxlength_ms_cat_homedecr,le.maxlength_ms_homedecr,le.maxlength_ms_housewares,le.maxlength_ms_pub_garden,le.maxlength_ms_cat_garden,le.maxlength_ms_garden,le.maxlength_ms_pub_homeliv,le.maxlength_ms_cat_homeliv,le.maxlength_ms_homeliv,le.maxlength_ms_pub_home_status_active,le.maxlength_ms_home_lmos,le.maxlength_ms_home_omos,le.maxlength_ms_home_pmos,le.maxlength_ms_home_totords,le.maxlength_ms_home_totitems,le.maxlength_ms_home_totdlrs,le.maxlength_ms_home_avgdlrs,le.maxlength_ms_home_lastdlrs,le.maxlength_ms_home_paystat_paid,le.maxlength_ms_home_paymeth_cc,le.maxlength_ms_home_paymeth_cash,le.maxlength_ms_home_osrc_dm,le.maxlength_ms_home_lsrc_dm,le.maxlength_ms_home_osrc_agt,le.maxlength_ms_home_lsrc_agt,le.maxlength_ms_home_osrc_net,le.maxlength_ms_home_lsrc_net,le.maxlength_ms_home_osrc_tv,le.maxlength_ms_home_lsrc_tv,le.maxlength_ms_humor,le.maxlength_ms_inspiration,le.maxlength_ms_merchandise,le.maxlength_ms_moneymaking,le.maxlength_ms_moneymaking_lmos,le.maxlength_ms_motorcycles,le.maxlength_ms_music,le.maxlength_ms_fishing,le.maxlength_ms_hunting,le.maxlength_ms_boatsail,le.maxlength_ms_camp,le.maxlength_ms_pub_outdoors,le.maxlength_ms_cat_outdoors,le.maxlength_ms_outdoors,le.maxlength_ms_pub_out_status_active,le.maxlength_ms_out_lmos,le.maxlength_ms_out_omos,le.maxlength_ms_out_pmos,le.maxlength_ms_out_totords,le.maxlength_ms_out_totitems,le.maxlength_ms_out_totdlrs,le.maxlength_ms_out_avgdlrs,le.maxlength_ms_out_lastdlrs,le.maxlength_ms_out_paystat_paid,le.maxlength_ms_out_paymeth_cc,le.maxlength_ms_out_paymeth_cash,le.maxlength_ms_out_osrc_dm,le.maxlength_ms_out_lsrc_dm,le.maxlength_ms_out_osrc_agt,le.maxlength_ms_out_lsrc_agt,le.maxlength_ms_pets,le.maxlength_ms_pfin,le.maxlength_ms_photo,le.maxlength_ms_photoproc,le.maxlength_ms_rural,le.maxlength_ms_science,le.maxlength_ms_sports,le.maxlength_ms_sports_lmos,le.maxlength_ms_travel,le.maxlength_ms_tvmovies,le.maxlength_ms_wildlife,le.maxlength_ms_woman,le.maxlength_ms_woman_lmos,le.maxlength_ms_ringtones_apps,le.maxlength_cpi_mobile_apps_index,le.maxlength_cpi_credit_repair_index,le.maxlength_cpi_credit_report_index,le.maxlength_cpi_education_seekers_index,le.maxlength_cpi_insurance_index,le.maxlength_cpi_insurance_health_index,le.maxlength_cpi_insurance_auto_index,le.maxlength_cpi_job_seekers_index,le.maxlength_cpi_social_networking_index,le.maxlength_cpi_adult_index,le.maxlength_cpi_africanamerican_index,le.maxlength_cpi_apparel_index,le.maxlength_cpi_apparel_accessory_index,le.maxlength_cpi_apparel_kids_index,le.maxlength_cpi_apparel_men_index,le.maxlength_cpi_apparel_menfash_index,le.maxlength_cpi_apparel_women_index,le.maxlength_cpi_apparel_womfash_index,le.maxlength_cpi_asian_index,le.maxlength_cpi_auto_index,le.maxlength_cpi_auto_racing_index,le.maxlength_cpi_auto_trucks_index,le.maxlength_cpi_aviation_index,le.maxlength_cpi_bargains_index,le.maxlength_cpi_beauty_index,le.maxlength_cpi_bible_index,le.maxlength_cpi_birds_index,le.maxlength_cpi_business_index,le.maxlength_cpi_business_homeoffice_index,le.maxlength_cpi_catalog_index,le.maxlength_cpi_cc_index,le.maxlength_cpi_collectibles_index,le.maxlength_cpi_college_index,le.maxlength_cpi_computers_index,le.maxlength_cpi_conservative_index,le.maxlength_cpi_continuity_index,le.maxlength_cpi_cooking_index,le.maxlength_cpi_crafts_index,le.maxlength_cpi_crafts_crochet_index,le.maxlength_cpi_crafts_knit_index,le.maxlength_cpi_crafts_needlepoint_index,le.maxlength_cpi_crafts_quilt_index,le.maxlength_cpi_crafts_sew_index,le.maxlength_cpi_culturearts_index,le.maxlength_cpi_currevent_index,le.maxlength_cpi_diy_index,le.maxlength_cpi_donor_index,le.maxlength_cpi_ego_index,le.maxlength_cpi_electronics_index,le.maxlength_cpi_equestrian_index,le.maxlength_cpi_family_index,le.maxlength_cpi_family_teen_index,le.maxlength_cpi_family_young_index,le.maxlength_cpi_fiction_index,le.maxlength_cpi_gambling_index,le.maxlength_cpi_games_index,le.maxlength_cpi_gardening_index,le.maxlength_cpi_gay_index,le.maxlength_cpi_giftgivr_index,le.maxlength_cpi_gourmet_index,le.maxlength_cpi_grandparents_index,le.maxlength_cpi_health_index,le.maxlength_cpi_health_diet_index,le.maxlength_cpi_health_fitness_index,le.maxlength_cpi_hightech_index,le.maxlength_cpi_hispanic_index,le.maxlength_cpi_history_index,le.maxlength_cpi_history_american_index,le.maxlength_cpi_hobbies_index,le.maxlength_cpi_homedecr_index,le.maxlength_cpi_homeliv_index,le.maxlength_cpi_humor_index,le.maxlength_cpi_inspiration_index,le.maxlength_cpi_internet_index,le.maxlength_cpi_internet_access_index,le.maxlength_cpi_internet_buy_index,le.maxlength_cpi_liberal_index,le.maxlength_cpi_moneymaking_index,le.maxlength_cpi_motorcycles_index,le.maxlength_cpi_music_index,le.maxlength_cpi_nonfiction_index,le.maxlength_cpi_ocean_index,le.maxlength_cpi_outdoors_index,le.maxlength_cpi_outdoors_boatsail_index,le.maxlength_cpi_outdoors_camp_index,le.maxlength_cpi_outdoors_fishing_index,le.maxlength_cpi_outdoors_huntfish_index,le.maxlength_cpi_outdoors_hunting_index,le.maxlength_cpi_pets_index,le.maxlength_cpi_pets_cats_index,le.maxlength_cpi_pets_dogs_index,le.maxlength_cpi_pfin_index,le.maxlength_cpi_photog_index,le.maxlength_cpi_photoproc_index,le.maxlength_cpi_publish_index,le.maxlength_cpi_publish_books_index,le.maxlength_cpi_publish_mags_index,le.maxlength_cpi_rural_index,le.maxlength_cpi_science_index,le.maxlength_cpi_scifi_index,le.maxlength_cpi_seniors_index,le.maxlength_cpi_sports_index,le.maxlength_cpi_sports_baseball_index,le.maxlength_cpi_sports_basketball_index,le.maxlength_cpi_sports_biking_index,le.maxlength_cpi_sports_football_index,le.maxlength_cpi_sports_golf_index,le.maxlength_cpi_sports_hockey_index,le.maxlength_cpi_sports_running_index,le.maxlength_cpi_sports_ski_index,le.maxlength_cpi_sports_soccer_index,le.maxlength_cpi_sports_swimming_index,le.maxlength_cpi_sports_tennis_index,le.maxlength_cpi_stationery_index,le.maxlength_cpi_sweeps_index,le.maxlength_cpi_tobacco_index,le.maxlength_cpi_travel_index,le.maxlength_cpi_travel_cruise_index,le.maxlength_cpi_travel_rv_index,le.maxlength_cpi_travel_us_index,le.maxlength_cpi_tvmovies_index,le.maxlength_cpi_wildlife_index,le.maxlength_cpi_woman_index,le.maxlength_totdlr_index,le.maxlength_cpi_totdlr,le.maxlength_cpi_totords,le.maxlength_cpi_lastdlr,le.maxlength_pkcatg,le.maxlength_pkpubs,le.maxlength_pkcont,le.maxlength_pkca01,le.maxlength_pkca03,le.maxlength_pkca04,le.maxlength_pkca05,le.maxlength_pkca06,le.maxlength_pkca07,le.maxlength_pkca08,le.maxlength_pkca09,le.maxlength_pkca10,le.maxlength_pkca11,le.maxlength_pkca12,le.maxlength_pkca13,le.maxlength_pkca14,le.maxlength_pkca15,le.maxlength_pkca16,le.maxlength_pkca17,le.maxlength_pkca18,le.maxlength_pkca20,le.maxlength_pkca21,le.maxlength_pkca22,le.maxlength_pkca23,le.maxlength_pkca24,le.maxlength_pkca25,le.maxlength_pkca26,le.maxlength_pkca28,le.maxlength_pkca29,le.maxlength_pkca30,le.maxlength_pkca31,le.maxlength_pkca32,le.maxlength_pkca33,le.maxlength_pkca34,le.maxlength_pkca35,le.maxlength_pkca36,le.maxlength_pkca37,le.maxlength_pkca39,le.maxlength_pkca40,le.maxlength_pkca41,le.maxlength_pkca42,le.maxlength_pkca54,le.maxlength_pkca61,le.maxlength_pkca62,le.maxlength_pkca64,le.maxlength_pkpu01,le.maxlength_pkpu02,le.maxlength_pkpu03,le.maxlength_pkpu04,le.maxlength_pkpu05,le.maxlength_pkpu06,le.maxlength_pkpu07,le.maxlength_pkpu08,le.maxlength_pkpu09,le.maxlength_pkpu10,le.maxlength_pkpu11,le.maxlength_pkpu12,le.maxlength_pkpu13,le.maxlength_pkpu14,le.maxlength_pkpu15,le.maxlength_pkpu16,le.maxlength_pkpu17,le.maxlength_pkpu18,le.maxlength_pkpu19,le.maxlength_pkpu20,le.maxlength_pkpu23,le.maxlength_pkpu25,le.maxlength_pkpu27,le.maxlength_pkpu28,le.maxlength_pkpu29,le.maxlength_pkpu30,le.maxlength_pkpu31,le.maxlength_pkpu32,le.maxlength_pkpu33,le.maxlength_pkpu34,le.maxlength_pkpu35,le.maxlength_pkpu38,le.maxlength_pkpu41,le.maxlength_pkpu42,le.maxlength_pkpu45,le.maxlength_pkpu46,le.maxlength_pkpu47,le.maxlength_pkpu48,le.maxlength_pkpu49,le.maxlength_pkpu50,le.maxlength_pkpu51,le.maxlength_pkpu52,le.maxlength_pkpu53,le.maxlength_pkpu54,le.maxlength_pkpu55,le.maxlength_pkpu56,le.maxlength_pkpu57,le.maxlength_pkpu60,le.maxlength_pkpu61,le.maxlength_pkpu62,le.maxlength_pkpu63,le.maxlength_pkpu64,le.maxlength_pkpu65,le.maxlength_pkpu66,le.maxlength_pkpu67,le.maxlength_pkpu68,le.maxlength_pkpu69,le.maxlength_pkpu70,le.maxlength_censpct_water,le.maxlength_cens_pop_density,le.maxlength_cens_hu_density,le.maxlength_censpct_pop_white,le.maxlength_censpct_pop_black,le.maxlength_censpct_pop_amerind,le.maxlength_censpct_pop_asian,le.maxlength_censpct_pop_pacisl,le.maxlength_censpct_pop_othrace,le.maxlength_censpct_pop_multirace,le.maxlength_censpct_pop_hispanic,le.maxlength_censpct_pop_agelt18,le.maxlength_censpct_pop_males,le.maxlength_censpct_adult_age1824,le.maxlength_censpct_adult_age2534,le.maxlength_censpct_adult_age3544,le.maxlength_censpct_adult_age4554,le.maxlength_censpct_adult_age5564,le.maxlength_censpct_adult_agege65,le.maxlength_cens_pop_medage,le.maxlength_cens_hh_avgsize,le.maxlength_censpct_hh_family,le.maxlength_censpct_hh_family_husbwife,le.maxlength_censpct_hu_occupied,le.maxlength_censpct_hu_owned,le.maxlength_censpct_hu_rented,le.maxlength_censpct_hu_vacantseasonal,le.maxlength_zip_medinc,le.maxlength_zip_apparel,le.maxlength_zip_apparel_women,le.maxlength_zip_apparel_womfash,le.maxlength_zip_auto,le.maxlength_zip_beauty,le.maxlength_zip_booksmusicmovies,le.maxlength_zip_business,le.maxlength_zip_catalog,le.maxlength_zip_cc,le.maxlength_zip_collectibles,le.maxlength_zip_computers,le.maxlength_zip_continuity,le.maxlength_zip_cooking,le.maxlength_zip_crafts,le.maxlength_zip_culturearts,le.maxlength_zip_dm_sold,le.maxlength_zip_donor,le.maxlength_zip_family,le.maxlength_zip_gardening,le.maxlength_zip_giftgivr,le.maxlength_zip_gourmet,le.maxlength_zip_health,le.maxlength_zip_health_diet,le.maxlength_zip_health_fitness,le.maxlength_zip_hobbies,le.maxlength_zip_homedecr,le.maxlength_zip_homeliv,le.maxlength_zip_internet,le.maxlength_zip_internet_access,le.maxlength_zip_internet_buy,le.maxlength_zip_music,le.maxlength_zip_outdoors,le.maxlength_zip_pets,le.maxlength_zip_pfin,le.maxlength_zip_publish,le.maxlength_zip_publish_books,le.maxlength_zip_publish_mags,le.maxlength_zip_sports,le.maxlength_zip_sports_biking,le.maxlength_zip_sports_golf,le.maxlength_zip_travel,le.maxlength_zip_travel_us,le.maxlength_zip_tvmovies,le.maxlength_zip_woman,le.maxlength_zip_proftech,le.maxlength_zip_retired,le.maxlength_zip_inc100,le.maxlength_zip_inc75,le.maxlength_zip_inc50);
  SELF.avelength := CHOOSE(C,le.avelength_dtmatch,le.avelength_msname,le.avelength_msaddr1,le.avelength_msaddr2,le.avelength_mscity,le.avelength_msstate,le.avelength_mszip5,le.avelength_mszip4,le.avelength_dthh,le.avelength_mscrrt,le.avelength_msdpbc,le.avelength_msdpv,le.avelength_ms_addrtype,le.avelength_ctysize,le.avelength_lmos,le.avelength_omos,le.avelength_pmos,le.avelength_gen,le.avelength_dob,le.avelength_age,le.avelength_inc,le.avelength_marital_status,le.avelength_poc,le.avelength_noc,le.avelength_ocp,le.avelength_edu,le.avelength_lang,le.avelength_relig,le.avelength_dwell,le.avelength_ownr,le.avelength_eth1,le.avelength_eth2,le.avelength_lor,le.avelength_pool,le.avelength_speak_span,le.avelength_soho,le.avelength_vet_in_hh,le.avelength_ms_mags,le.avelength_ms_books,le.avelength_ms_publish,le.avelength_ms_pub_status_active,le.avelength_ms_pub_status_expire,le.avelength_ms_pub_premsold,le.avelength_ms_pub_autornwl,le.avelength_ms_pub_avgterm,le.avelength_ms_pub_lmos,le.avelength_ms_pub_omos,le.avelength_ms_pub_pmos,le.avelength_ms_pub_cemos,le.avelength_ms_pub_femos,le.avelength_ms_pub_totords,le.avelength_ms_pub_totdlrs,le.avelength_ms_pub_avgdlrs,le.avelength_ms_pub_lastdlrs,le.avelength_ms_pub_paystat_paid,le.avelength_ms_pub_paystat_ub,le.avelength_ms_pub_paymeth_cc,le.avelength_ms_pub_paymeth_cash,le.avelength_ms_pub_payspeed,le.avelength_ms_pub_osrc_dm,le.avelength_ms_pub_lsrc_dm,le.avelength_ms_pub_osrc_agt_cashf,le.avelength_ms_pub_lsrc_agt_cashf,le.avelength_ms_pub_osrc_agt_pds,le.avelength_ms_pub_lsrc_agt_pds,le.avelength_ms_pub_osrc_agt_schplan,le.avelength_ms_pub_lsrc_agt_schplan,le.avelength_ms_pub_osrc_agt_sponsor,le.avelength_ms_pub_lsrc_agt_sponsor,le.avelength_ms_pub_osrc_agt_tm,le.avelength_ms_pub_lsrc_agt_tm,le.avelength_ms_pub_osrc_agt,le.avelength_ms_pub_lsrc_agt,le.avelength_ms_pub_osrc_tm,le.avelength_ms_pub_lsrc_tm,le.avelength_ms_pub_osrc_ins,le.avelength_ms_pub_lsrc_ins,le.avelength_ms_pub_osrc_net,le.avelength_ms_pub_lsrc_net,le.avelength_ms_pub_osrc_print,le.avelength_ms_pub_lsrc_print,le.avelength_ms_pub_osrc_trans,le.avelength_ms_pub_lsrc_trans,le.avelength_ms_pub_osrc_tv,le.avelength_ms_pub_lsrc_tv,le.avelength_ms_pub_osrc_dtp,le.avelength_ms_pub_lsrc_dtp,le.avelength_ms_pub_giftgivr,le.avelength_ms_pub_giftee,le.avelength_ms_catalog,le.avelength_ms_cat_lmos,le.avelength_ms_cat_omos,le.avelength_ms_cat_pmos,le.avelength_ms_cat_totords,le.avelength_ms_cat_totitems,le.avelength_ms_cat_totdlrs,le.avelength_ms_cat_avgdlrs,le.avelength_ms_cat_lastdlrs,le.avelength_ms_cat_paystat_paid,le.avelength_ms_cat_paymeth_cc,le.avelength_ms_cat_paymeth_cash,le.avelength_ms_cat_osrc_dm,le.avelength_ms_cat_lsrc_dm,le.avelength_ms_cat_osrc_net,le.avelength_ms_cat_lsrc_net,le.avelength_ms_cat_giftgivr,le.avelength_pkpubs_corrected,le.avelength_pkcatg_corrected,le.avelength_ms_fundraising,le.avelength_ms_fund_lmos,le.avelength_ms_fund_omos,le.avelength_ms_fund_pmos,le.avelength_ms_fund_totords,le.avelength_ms_fund_totdlrs,le.avelength_ms_fund_avgdlrs,le.avelength_ms_fund_lastdlrs,le.avelength_ms_fund_paystat_paid,le.avelength_ms_other,le.avelength_ms_continuity,le.avelength_ms_cont_status_active,le.avelength_ms_cont_status_cancel,le.avelength_ms_cont_omos,le.avelength_ms_cont_lmos,le.avelength_ms_cont_pmos,le.avelength_ms_cont_totords,le.avelength_ms_cont_totdlrs,le.avelength_ms_cont_avgdlrs,le.avelength_ms_cont_lastdlrs,le.avelength_ms_cont_paystat_paid,le.avelength_ms_cont_paymeth_cc,le.avelength_ms_cont_paymeth_cash,le.avelength_ms_totords,le.avelength_ms_totitems,le.avelength_ms_totdlrs,le.avelength_ms_avgdlrs,le.avelength_ms_lastdlrs,le.avelength_ms_paystat_paid,le.avelength_ms_paymeth_cc,le.avelength_ms_paymeth_cash,le.avelength_ms_osrc_dm,le.avelength_ms_lsrc_dm,le.avelength_ms_osrc_tm,le.avelength_ms_lsrc_tm,le.avelength_ms_osrc_ins,le.avelength_ms_lsrc_ins,le.avelength_ms_osrc_net,le.avelength_ms_lsrc_net,le.avelength_ms_osrc_tv,le.avelength_ms_lsrc_tv,le.avelength_ms_osrc_retail,le.avelength_ms_lsrc_retail,le.avelength_ms_giftgivr,le.avelength_ms_giftee,le.avelength_ms_adult,le.avelength_ms_womapp,le.avelength_ms_menapp,le.avelength_ms_kidapp,le.avelength_ms_accessory,le.avelength_ms_apparel,le.avelength_ms_app_lmos,le.avelength_ms_app_omos,le.avelength_ms_app_pmos,le.avelength_ms_app_totords,le.avelength_ms_app_totitems,le.avelength_ms_app_totdlrs,le.avelength_ms_app_avgdlrs,le.avelength_ms_app_lastdlrs,le.avelength_ms_app_paystat_paid,le.avelength_ms_app_paymeth_cc,le.avelength_ms_app_paymeth_cash,le.avelength_ms_menfash,le.avelength_ms_womfash,le.avelength_ms_wfsh_lmos,le.avelength_ms_wfsh_omos,le.avelength_ms_wfsh_pmos,le.avelength_ms_wfsh_totords,le.avelength_ms_wfsh_totdlrs,le.avelength_ms_wfsh_avgdlrs,le.avelength_ms_wfsh_lastdlrs,le.avelength_ms_wfsh_paystat_paid,le.avelength_ms_wfsh_osrc_dm,le.avelength_ms_wfsh_lsrc_dm,le.avelength_ms_wfsh_osrc_agt,le.avelength_ms_wfsh_lsrc_agt,le.avelength_ms_audio,le.avelength_ms_auto,le.avelength_ms_aviation,le.avelength_ms_bargains,le.avelength_ms_beauty,le.avelength_ms_bible,le.avelength_ms_bible_lmos,le.avelength_ms_bible_omos,le.avelength_ms_bible_pmos,le.avelength_ms_bible_totords,le.avelength_ms_bible_totitems,le.avelength_ms_bible_totdlrs,le.avelength_ms_bible_avgdlrs,le.avelength_ms_bible_lastdlrs,le.avelength_ms_bible_paystat_paid,le.avelength_ms_bible_paymeth_cc,le.avelength_ms_bible_paymeth_cash,le.avelength_ms_business,le.avelength_ms_collectibles,le.avelength_ms_computers,le.avelength_ms_crafts,le.avelength_ms_culturearts,le.avelength_ms_currevent,le.avelength_ms_diy,le.avelength_ms_electronics,le.avelength_ms_equestrian,le.avelength_ms_pub_family,le.avelength_ms_cat_family,le.avelength_ms_family,le.avelength_ms_family_lmos,le.avelength_ms_family_omos,le.avelength_ms_family_pmos,le.avelength_ms_family_totords,le.avelength_ms_family_totitems,le.avelength_ms_family_totdlrs,le.avelength_ms_family_avgdlrs,le.avelength_ms_family_lastdlrs,le.avelength_ms_family_paystat_paid,le.avelength_ms_family_paymeth_cc,le.avelength_ms_family_paymeth_cash,le.avelength_ms_family_osrc_dm,le.avelength_ms_family_lsrc_dm,le.avelength_ms_fiction,le.avelength_ms_food,le.avelength_ms_games,le.avelength_ms_gifts,le.avelength_ms_gourmet,le.avelength_ms_fitness,le.avelength_ms_health,le.avelength_ms_hlth_lmos,le.avelength_ms_hlth_omos,le.avelength_ms_hlth_pmos,le.avelength_ms_hlth_totords,le.avelength_ms_hlth_totdlrs,le.avelength_ms_hlth_avgdlrs,le.avelength_ms_hlth_lastdlrs,le.avelength_ms_hlth_paystat_paid,le.avelength_ms_hlth_paymeth_cc,le.avelength_ms_hlth_osrc_dm,le.avelength_ms_hlth_lsrc_dm,le.avelength_ms_hlth_osrc_agt,le.avelength_ms_hlth_lsrc_agt,le.avelength_ms_hlth_osrc_tv,le.avelength_ms_hlth_lsrc_tv,le.avelength_ms_holiday,le.avelength_ms_history,le.avelength_ms_pub_cooking,le.avelength_ms_cooking,le.avelength_ms_pub_homedecr,le.avelength_ms_cat_homedecr,le.avelength_ms_homedecr,le.avelength_ms_housewares,le.avelength_ms_pub_garden,le.avelength_ms_cat_garden,le.avelength_ms_garden,le.avelength_ms_pub_homeliv,le.avelength_ms_cat_homeliv,le.avelength_ms_homeliv,le.avelength_ms_pub_home_status_active,le.avelength_ms_home_lmos,le.avelength_ms_home_omos,le.avelength_ms_home_pmos,le.avelength_ms_home_totords,le.avelength_ms_home_totitems,le.avelength_ms_home_totdlrs,le.avelength_ms_home_avgdlrs,le.avelength_ms_home_lastdlrs,le.avelength_ms_home_paystat_paid,le.avelength_ms_home_paymeth_cc,le.avelength_ms_home_paymeth_cash,le.avelength_ms_home_osrc_dm,le.avelength_ms_home_lsrc_dm,le.avelength_ms_home_osrc_agt,le.avelength_ms_home_lsrc_agt,le.avelength_ms_home_osrc_net,le.avelength_ms_home_lsrc_net,le.avelength_ms_home_osrc_tv,le.avelength_ms_home_lsrc_tv,le.avelength_ms_humor,le.avelength_ms_inspiration,le.avelength_ms_merchandise,le.avelength_ms_moneymaking,le.avelength_ms_moneymaking_lmos,le.avelength_ms_motorcycles,le.avelength_ms_music,le.avelength_ms_fishing,le.avelength_ms_hunting,le.avelength_ms_boatsail,le.avelength_ms_camp,le.avelength_ms_pub_outdoors,le.avelength_ms_cat_outdoors,le.avelength_ms_outdoors,le.avelength_ms_pub_out_status_active,le.avelength_ms_out_lmos,le.avelength_ms_out_omos,le.avelength_ms_out_pmos,le.avelength_ms_out_totords,le.avelength_ms_out_totitems,le.avelength_ms_out_totdlrs,le.avelength_ms_out_avgdlrs,le.avelength_ms_out_lastdlrs,le.avelength_ms_out_paystat_paid,le.avelength_ms_out_paymeth_cc,le.avelength_ms_out_paymeth_cash,le.avelength_ms_out_osrc_dm,le.avelength_ms_out_lsrc_dm,le.avelength_ms_out_osrc_agt,le.avelength_ms_out_lsrc_agt,le.avelength_ms_pets,le.avelength_ms_pfin,le.avelength_ms_photo,le.avelength_ms_photoproc,le.avelength_ms_rural,le.avelength_ms_science,le.avelength_ms_sports,le.avelength_ms_sports_lmos,le.avelength_ms_travel,le.avelength_ms_tvmovies,le.avelength_ms_wildlife,le.avelength_ms_woman,le.avelength_ms_woman_lmos,le.avelength_ms_ringtones_apps,le.avelength_cpi_mobile_apps_index,le.avelength_cpi_credit_repair_index,le.avelength_cpi_credit_report_index,le.avelength_cpi_education_seekers_index,le.avelength_cpi_insurance_index,le.avelength_cpi_insurance_health_index,le.avelength_cpi_insurance_auto_index,le.avelength_cpi_job_seekers_index,le.avelength_cpi_social_networking_index,le.avelength_cpi_adult_index,le.avelength_cpi_africanamerican_index,le.avelength_cpi_apparel_index,le.avelength_cpi_apparel_accessory_index,le.avelength_cpi_apparel_kids_index,le.avelength_cpi_apparel_men_index,le.avelength_cpi_apparel_menfash_index,le.avelength_cpi_apparel_women_index,le.avelength_cpi_apparel_womfash_index,le.avelength_cpi_asian_index,le.avelength_cpi_auto_index,le.avelength_cpi_auto_racing_index,le.avelength_cpi_auto_trucks_index,le.avelength_cpi_aviation_index,le.avelength_cpi_bargains_index,le.avelength_cpi_beauty_index,le.avelength_cpi_bible_index,le.avelength_cpi_birds_index,le.avelength_cpi_business_index,le.avelength_cpi_business_homeoffice_index,le.avelength_cpi_catalog_index,le.avelength_cpi_cc_index,le.avelength_cpi_collectibles_index,le.avelength_cpi_college_index,le.avelength_cpi_computers_index,le.avelength_cpi_conservative_index,le.avelength_cpi_continuity_index,le.avelength_cpi_cooking_index,le.avelength_cpi_crafts_index,le.avelength_cpi_crafts_crochet_index,le.avelength_cpi_crafts_knit_index,le.avelength_cpi_crafts_needlepoint_index,le.avelength_cpi_crafts_quilt_index,le.avelength_cpi_crafts_sew_index,le.avelength_cpi_culturearts_index,le.avelength_cpi_currevent_index,le.avelength_cpi_diy_index,le.avelength_cpi_donor_index,le.avelength_cpi_ego_index,le.avelength_cpi_electronics_index,le.avelength_cpi_equestrian_index,le.avelength_cpi_family_index,le.avelength_cpi_family_teen_index,le.avelength_cpi_family_young_index,le.avelength_cpi_fiction_index,le.avelength_cpi_gambling_index,le.avelength_cpi_games_index,le.avelength_cpi_gardening_index,le.avelength_cpi_gay_index,le.avelength_cpi_giftgivr_index,le.avelength_cpi_gourmet_index,le.avelength_cpi_grandparents_index,le.avelength_cpi_health_index,le.avelength_cpi_health_diet_index,le.avelength_cpi_health_fitness_index,le.avelength_cpi_hightech_index,le.avelength_cpi_hispanic_index,le.avelength_cpi_history_index,le.avelength_cpi_history_american_index,le.avelength_cpi_hobbies_index,le.avelength_cpi_homedecr_index,le.avelength_cpi_homeliv_index,le.avelength_cpi_humor_index,le.avelength_cpi_inspiration_index,le.avelength_cpi_internet_index,le.avelength_cpi_internet_access_index,le.avelength_cpi_internet_buy_index,le.avelength_cpi_liberal_index,le.avelength_cpi_moneymaking_index,le.avelength_cpi_motorcycles_index,le.avelength_cpi_music_index,le.avelength_cpi_nonfiction_index,le.avelength_cpi_ocean_index,le.avelength_cpi_outdoors_index,le.avelength_cpi_outdoors_boatsail_index,le.avelength_cpi_outdoors_camp_index,le.avelength_cpi_outdoors_fishing_index,le.avelength_cpi_outdoors_huntfish_index,le.avelength_cpi_outdoors_hunting_index,le.avelength_cpi_pets_index,le.avelength_cpi_pets_cats_index,le.avelength_cpi_pets_dogs_index,le.avelength_cpi_pfin_index,le.avelength_cpi_photog_index,le.avelength_cpi_photoproc_index,le.avelength_cpi_publish_index,le.avelength_cpi_publish_books_index,le.avelength_cpi_publish_mags_index,le.avelength_cpi_rural_index,le.avelength_cpi_science_index,le.avelength_cpi_scifi_index,le.avelength_cpi_seniors_index,le.avelength_cpi_sports_index,le.avelength_cpi_sports_baseball_index,le.avelength_cpi_sports_basketball_index,le.avelength_cpi_sports_biking_index,le.avelength_cpi_sports_football_index,le.avelength_cpi_sports_golf_index,le.avelength_cpi_sports_hockey_index,le.avelength_cpi_sports_running_index,le.avelength_cpi_sports_ski_index,le.avelength_cpi_sports_soccer_index,le.avelength_cpi_sports_swimming_index,le.avelength_cpi_sports_tennis_index,le.avelength_cpi_stationery_index,le.avelength_cpi_sweeps_index,le.avelength_cpi_tobacco_index,le.avelength_cpi_travel_index,le.avelength_cpi_travel_cruise_index,le.avelength_cpi_travel_rv_index,le.avelength_cpi_travel_us_index,le.avelength_cpi_tvmovies_index,le.avelength_cpi_wildlife_index,le.avelength_cpi_woman_index,le.avelength_totdlr_index,le.avelength_cpi_totdlr,le.avelength_cpi_totords,le.avelength_cpi_lastdlr,le.avelength_pkcatg,le.avelength_pkpubs,le.avelength_pkcont,le.avelength_pkca01,le.avelength_pkca03,le.avelength_pkca04,le.avelength_pkca05,le.avelength_pkca06,le.avelength_pkca07,le.avelength_pkca08,le.avelength_pkca09,le.avelength_pkca10,le.avelength_pkca11,le.avelength_pkca12,le.avelength_pkca13,le.avelength_pkca14,le.avelength_pkca15,le.avelength_pkca16,le.avelength_pkca17,le.avelength_pkca18,le.avelength_pkca20,le.avelength_pkca21,le.avelength_pkca22,le.avelength_pkca23,le.avelength_pkca24,le.avelength_pkca25,le.avelength_pkca26,le.avelength_pkca28,le.avelength_pkca29,le.avelength_pkca30,le.avelength_pkca31,le.avelength_pkca32,le.avelength_pkca33,le.avelength_pkca34,le.avelength_pkca35,le.avelength_pkca36,le.avelength_pkca37,le.avelength_pkca39,le.avelength_pkca40,le.avelength_pkca41,le.avelength_pkca42,le.avelength_pkca54,le.avelength_pkca61,le.avelength_pkca62,le.avelength_pkca64,le.avelength_pkpu01,le.avelength_pkpu02,le.avelength_pkpu03,le.avelength_pkpu04,le.avelength_pkpu05,le.avelength_pkpu06,le.avelength_pkpu07,le.avelength_pkpu08,le.avelength_pkpu09,le.avelength_pkpu10,le.avelength_pkpu11,le.avelength_pkpu12,le.avelength_pkpu13,le.avelength_pkpu14,le.avelength_pkpu15,le.avelength_pkpu16,le.avelength_pkpu17,le.avelength_pkpu18,le.avelength_pkpu19,le.avelength_pkpu20,le.avelength_pkpu23,le.avelength_pkpu25,le.avelength_pkpu27,le.avelength_pkpu28,le.avelength_pkpu29,le.avelength_pkpu30,le.avelength_pkpu31,le.avelength_pkpu32,le.avelength_pkpu33,le.avelength_pkpu34,le.avelength_pkpu35,le.avelength_pkpu38,le.avelength_pkpu41,le.avelength_pkpu42,le.avelength_pkpu45,le.avelength_pkpu46,le.avelength_pkpu47,le.avelength_pkpu48,le.avelength_pkpu49,le.avelength_pkpu50,le.avelength_pkpu51,le.avelength_pkpu52,le.avelength_pkpu53,le.avelength_pkpu54,le.avelength_pkpu55,le.avelength_pkpu56,le.avelength_pkpu57,le.avelength_pkpu60,le.avelength_pkpu61,le.avelength_pkpu62,le.avelength_pkpu63,le.avelength_pkpu64,le.avelength_pkpu65,le.avelength_pkpu66,le.avelength_pkpu67,le.avelength_pkpu68,le.avelength_pkpu69,le.avelength_pkpu70,le.avelength_censpct_water,le.avelength_cens_pop_density,le.avelength_cens_hu_density,le.avelength_censpct_pop_white,le.avelength_censpct_pop_black,le.avelength_censpct_pop_amerind,le.avelength_censpct_pop_asian,le.avelength_censpct_pop_pacisl,le.avelength_censpct_pop_othrace,le.avelength_censpct_pop_multirace,le.avelength_censpct_pop_hispanic,le.avelength_censpct_pop_agelt18,le.avelength_censpct_pop_males,le.avelength_censpct_adult_age1824,le.avelength_censpct_adult_age2534,le.avelength_censpct_adult_age3544,le.avelength_censpct_adult_age4554,le.avelength_censpct_adult_age5564,le.avelength_censpct_adult_agege65,le.avelength_cens_pop_medage,le.avelength_cens_hh_avgsize,le.avelength_censpct_hh_family,le.avelength_censpct_hh_family_husbwife,le.avelength_censpct_hu_occupied,le.avelength_censpct_hu_owned,le.avelength_censpct_hu_rented,le.avelength_censpct_hu_vacantseasonal,le.avelength_zip_medinc,le.avelength_zip_apparel,le.avelength_zip_apparel_women,le.avelength_zip_apparel_womfash,le.avelength_zip_auto,le.avelength_zip_beauty,le.avelength_zip_booksmusicmovies,le.avelength_zip_business,le.avelength_zip_catalog,le.avelength_zip_cc,le.avelength_zip_collectibles,le.avelength_zip_computers,le.avelength_zip_continuity,le.avelength_zip_cooking,le.avelength_zip_crafts,le.avelength_zip_culturearts,le.avelength_zip_dm_sold,le.avelength_zip_donor,le.avelength_zip_family,le.avelength_zip_gardening,le.avelength_zip_giftgivr,le.avelength_zip_gourmet,le.avelength_zip_health,le.avelength_zip_health_diet,le.avelength_zip_health_fitness,le.avelength_zip_hobbies,le.avelength_zip_homedecr,le.avelength_zip_homeliv,le.avelength_zip_internet,le.avelength_zip_internet_access,le.avelength_zip_internet_buy,le.avelength_zip_music,le.avelength_zip_outdoors,le.avelength_zip_pets,le.avelength_zip_pfin,le.avelength_zip_publish,le.avelength_zip_publish_books,le.avelength_zip_publish_mags,le.avelength_zip_sports,le.avelength_zip_sports_biking,le.avelength_zip_sports_golf,le.avelength_zip_travel,le.avelength_zip_travel_us,le.avelength_zip_tvmovies,le.avelength_zip_woman,le.avelength_zip_proftech,le.avelength_zip_retired,le.avelength_zip_inc100,le.avelength_zip_inc75,le.avelength_zip_inc50);
END;
EXPORT invSummary := NORMALIZE(summary0, 633, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dtmatch),TRIM((SALT311.StrType)le.msname),TRIM((SALT311.StrType)le.msaddr1),TRIM((SALT311.StrType)le.msaddr2),TRIM((SALT311.StrType)le.mscity),TRIM((SALT311.StrType)le.msstate),TRIM((SALT311.StrType)le.mszip5),TRIM((SALT311.StrType)le.mszip4),TRIM((SALT311.StrType)le.dthh),TRIM((SALT311.StrType)le.mscrrt),TRIM((SALT311.StrType)le.msdpbc),TRIM((SALT311.StrType)le.msdpv),TRIM((SALT311.StrType)le.ms_addrtype),TRIM((SALT311.StrType)le.ctysize),IF (le.lmos <> 0,TRIM((SALT311.StrType)le.lmos), ''),IF (le.omos <> 0,TRIM((SALT311.StrType)le.omos), ''),IF (le.pmos <> 0,TRIM((SALT311.StrType)le.pmos), ''),TRIM((SALT311.StrType)le.gen),TRIM((SALT311.StrType)le.dob),IF (le.age <> 0,TRIM((SALT311.StrType)le.age), ''),TRIM((SALT311.StrType)le.inc),TRIM((SALT311.StrType)le.marital_status),TRIM((SALT311.StrType)le.poc),TRIM((SALT311.StrType)le.noc),TRIM((SALT311.StrType)le.ocp),TRIM((SALT311.StrType)le.edu),TRIM((SALT311.StrType)le.lang),TRIM((SALT311.StrType)le.relig),TRIM((SALT311.StrType)le.dwell),TRIM((SALT311.StrType)le.ownr),TRIM((SALT311.StrType)le.eth1),TRIM((SALT311.StrType)le.eth2),TRIM((SALT311.StrType)le.lor),TRIM((SALT311.StrType)le.pool),TRIM((SALT311.StrType)le.speak_span),TRIM((SALT311.StrType)le.soho),TRIM((SALT311.StrType)le.vet_in_hh),IF (le.ms_mags <> 0,TRIM((SALT311.StrType)le.ms_mags), ''),IF (le.ms_books <> 0,TRIM((SALT311.StrType)le.ms_books), ''),IF (le.ms_publish <> 0,TRIM((SALT311.StrType)le.ms_publish), ''),IF (le.ms_pub_status_active <> 0,TRIM((SALT311.StrType)le.ms_pub_status_active), ''),IF (le.ms_pub_status_expire <> 0,TRIM((SALT311.StrType)le.ms_pub_status_expire), ''),IF (le.ms_pub_premsold <> 0,TRIM((SALT311.StrType)le.ms_pub_premsold), ''),IF (le.ms_pub_autornwl <> 0,TRIM((SALT311.StrType)le.ms_pub_autornwl), ''),IF (le.ms_pub_avgterm <> 0,TRIM((SALT311.StrType)le.ms_pub_avgterm), ''),IF (le.ms_pub_lmos <> 0,TRIM((SALT311.StrType)le.ms_pub_lmos), ''),IF (le.ms_pub_omos <> 0,TRIM((SALT311.StrType)le.ms_pub_omos), ''),IF (le.ms_pub_pmos <> 0,TRIM((SALT311.StrType)le.ms_pub_pmos), ''),IF (le.ms_pub_cemos <> 0,TRIM((SALT311.StrType)le.ms_pub_cemos), ''),IF (le.ms_pub_femos <> 0,TRIM((SALT311.StrType)le.ms_pub_femos), ''),IF (le.ms_pub_totords <> 0,TRIM((SALT311.StrType)le.ms_pub_totords), ''),IF (le.ms_pub_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_pub_totdlrs), ''),IF (le.ms_pub_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_pub_avgdlrs), ''),IF (le.ms_pub_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_pub_lastdlrs), ''),IF (le.ms_pub_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_pub_paystat_paid), ''),IF (le.ms_pub_paystat_ub <> 0,TRIM((SALT311.StrType)le.ms_pub_paystat_ub), ''),IF (le.ms_pub_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_pub_paymeth_cc), ''),IF (le.ms_pub_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_pub_paymeth_cash), ''),IF (le.ms_pub_payspeed <> 0,TRIM((SALT311.StrType)le.ms_pub_payspeed), ''),IF (le.ms_pub_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_dm), ''),IF (le.ms_pub_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_dm), ''),IF (le.ms_pub_osrc_agt_cashf <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_cashf), ''),IF (le.ms_pub_lsrc_agt_cashf <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_cashf), ''),IF (le.ms_pub_osrc_agt_pds <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_pds), ''),IF (le.ms_pub_lsrc_agt_pds <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_pds), ''),IF (le.ms_pub_osrc_agt_schplan <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_schplan), ''),IF (le.ms_pub_lsrc_agt_schplan <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_schplan), ''),IF (le.ms_pub_osrc_agt_sponsor <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_sponsor), ''),IF (le.ms_pub_lsrc_agt_sponsor <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_sponsor), ''),IF (le.ms_pub_osrc_agt_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_tm), ''),IF (le.ms_pub_lsrc_agt_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_tm), ''),IF (le.ms_pub_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt), ''),IF (le.ms_pub_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt), ''),IF (le.ms_pub_osrc_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_tm), ''),IF (le.ms_pub_lsrc_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_tm), ''),IF (le.ms_pub_osrc_ins <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_ins), ''),IF (le.ms_pub_lsrc_ins <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_ins), ''),IF (le.ms_pub_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_net), ''),IF (le.ms_pub_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_net), ''),IF (le.ms_pub_osrc_print <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_print), ''),IF (le.ms_pub_lsrc_print <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_print), ''),IF (le.ms_pub_osrc_trans <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_trans), ''),IF (le.ms_pub_lsrc_trans <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_trans), ''),IF (le.ms_pub_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_tv), ''),IF (le.ms_pub_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_tv), ''),IF (le.ms_pub_osrc_dtp <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_dtp), ''),IF (le.ms_pub_lsrc_dtp <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_dtp), ''),IF (le.ms_pub_giftgivr <> 0,TRIM((SALT311.StrType)le.ms_pub_giftgivr), ''),IF (le.ms_pub_giftee <> 0,TRIM((SALT311.StrType)le.ms_pub_giftee), ''),IF (le.ms_catalog <> 0,TRIM((SALT311.StrType)le.ms_catalog), ''),IF (le.ms_cat_lmos <> 0,TRIM((SALT311.StrType)le.ms_cat_lmos), ''),IF (le.ms_cat_omos <> 0,TRIM((SALT311.StrType)le.ms_cat_omos), ''),IF (le.ms_cat_pmos <> 0,TRIM((SALT311.StrType)le.ms_cat_pmos), ''),IF (le.ms_cat_totords <> 0,TRIM((SALT311.StrType)le.ms_cat_totords), ''),IF (le.ms_cat_totitems <> 0,TRIM((SALT311.StrType)le.ms_cat_totitems), ''),IF (le.ms_cat_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_cat_totdlrs), ''),IF (le.ms_cat_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_cat_avgdlrs), ''),IF (le.ms_cat_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_cat_lastdlrs), ''),IF (le.ms_cat_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_cat_paystat_paid), ''),IF (le.ms_cat_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_cat_paymeth_cc), ''),IF (le.ms_cat_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_cat_paymeth_cash), ''),IF (le.ms_cat_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_cat_osrc_dm), ''),IF (le.ms_cat_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_cat_lsrc_dm), ''),IF (le.ms_cat_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_cat_osrc_net), ''),IF (le.ms_cat_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_cat_lsrc_net), ''),IF (le.ms_cat_giftgivr <> 0,TRIM((SALT311.StrType)le.ms_cat_giftgivr), ''),IF (le.pkpubs_corrected <> 0,TRIM((SALT311.StrType)le.pkpubs_corrected), ''),IF (le.pkcatg_corrected <> 0,TRIM((SALT311.StrType)le.pkcatg_corrected), ''),IF (le.ms_fundraising <> 0,TRIM((SALT311.StrType)le.ms_fundraising), ''),IF (le.ms_fund_lmos <> 0,TRIM((SALT311.StrType)le.ms_fund_lmos), ''),IF (le.ms_fund_omos <> 0,TRIM((SALT311.StrType)le.ms_fund_omos), ''),IF (le.ms_fund_pmos <> 0,TRIM((SALT311.StrType)le.ms_fund_pmos), ''),IF (le.ms_fund_totords <> 0,TRIM((SALT311.StrType)le.ms_fund_totords), ''),IF (le.ms_fund_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_fund_totdlrs), ''),IF (le.ms_fund_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_fund_avgdlrs), ''),IF (le.ms_fund_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_fund_lastdlrs), ''),IF (le.ms_fund_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_fund_paystat_paid), ''),IF (le.ms_other <> 0,TRIM((SALT311.StrType)le.ms_other), ''),IF (le.ms_continuity <> 0,TRIM((SALT311.StrType)le.ms_continuity), ''),IF (le.ms_cont_status_active <> 0,TRIM((SALT311.StrType)le.ms_cont_status_active), ''),IF (le.ms_cont_status_cancel <> 0,TRIM((SALT311.StrType)le.ms_cont_status_cancel), ''),IF (le.ms_cont_omos <> 0,TRIM((SALT311.StrType)le.ms_cont_omos), ''),IF (le.ms_cont_lmos <> 0,TRIM((SALT311.StrType)le.ms_cont_lmos), ''),IF (le.ms_cont_pmos <> 0,TRIM((SALT311.StrType)le.ms_cont_pmos), ''),IF (le.ms_cont_totords <> 0,TRIM((SALT311.StrType)le.ms_cont_totords), ''),IF (le.ms_cont_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_cont_totdlrs), ''),IF (le.ms_cont_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_cont_avgdlrs), ''),IF (le.ms_cont_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_cont_lastdlrs), ''),IF (le.ms_cont_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_cont_paystat_paid), ''),IF (le.ms_cont_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_cont_paymeth_cc), ''),IF (le.ms_cont_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_cont_paymeth_cash), ''),IF (le.ms_totords <> 0,TRIM((SALT311.StrType)le.ms_totords), ''),IF (le.ms_totitems <> 0,TRIM((SALT311.StrType)le.ms_totitems), ''),IF (le.ms_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_totdlrs), ''),IF (le.ms_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_avgdlrs), ''),IF (le.ms_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_lastdlrs), ''),IF (le.ms_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_paystat_paid), ''),IF (le.ms_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_paymeth_cc), ''),IF (le.ms_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_paymeth_cash), ''),IF (le.ms_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_osrc_dm), ''),IF (le.ms_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_lsrc_dm), ''),IF (le.ms_osrc_tm <> 0,TRIM((SALT311.StrType)le.ms_osrc_tm), ''),IF (le.ms_lsrc_tm <> 0,TRIM((SALT311.StrType)le.ms_lsrc_tm), ''),IF (le.ms_osrc_ins <> 0,TRIM((SALT311.StrType)le.ms_osrc_ins), ''),IF (le.ms_lsrc_ins <> 0,TRIM((SALT311.StrType)le.ms_lsrc_ins), ''),IF (le.ms_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_osrc_net), ''),IF (le.ms_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_lsrc_net), ''),IF (le.ms_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_osrc_tv), ''),IF (le.ms_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_lsrc_tv), ''),IF (le.ms_osrc_retail <> 0,TRIM((SALT311.StrType)le.ms_osrc_retail), ''),IF (le.ms_lsrc_retail <> 0,TRIM((SALT311.StrType)le.ms_lsrc_retail), ''),IF (le.ms_giftgivr <> 0,TRIM((SALT311.StrType)le.ms_giftgivr), ''),IF (le.ms_giftee <> 0,TRIM((SALT311.StrType)le.ms_giftee), ''),IF (le.ms_adult <> 0,TRIM((SALT311.StrType)le.ms_adult), ''),IF (le.ms_womapp <> 0,TRIM((SALT311.StrType)le.ms_womapp), ''),IF (le.ms_menapp <> 0,TRIM((SALT311.StrType)le.ms_menapp), ''),IF (le.ms_kidapp <> 0,TRIM((SALT311.StrType)le.ms_kidapp), ''),IF (le.ms_accessory <> 0,TRIM((SALT311.StrType)le.ms_accessory), ''),IF (le.ms_apparel <> 0,TRIM((SALT311.StrType)le.ms_apparel), ''),IF (le.ms_app_lmos <> 0,TRIM((SALT311.StrType)le.ms_app_lmos), ''),IF (le.ms_app_omos <> 0,TRIM((SALT311.StrType)le.ms_app_omos), ''),IF (le.ms_app_pmos <> 0,TRIM((SALT311.StrType)le.ms_app_pmos), ''),IF (le.ms_app_totords <> 0,TRIM((SALT311.StrType)le.ms_app_totords), ''),IF (le.ms_app_totitems <> 0,TRIM((SALT311.StrType)le.ms_app_totitems), ''),IF (le.ms_app_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_app_totdlrs), ''),IF (le.ms_app_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_app_avgdlrs), ''),IF (le.ms_app_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_app_lastdlrs), ''),IF (le.ms_app_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_app_paystat_paid), ''),IF (le.ms_app_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_app_paymeth_cc), ''),IF (le.ms_app_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_app_paymeth_cash), ''),IF (le.ms_menfash <> 0,TRIM((SALT311.StrType)le.ms_menfash), ''),IF (le.ms_womfash <> 0,TRIM((SALT311.StrType)le.ms_womfash), ''),IF (le.ms_wfsh_lmos <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lmos), ''),IF (le.ms_wfsh_omos <> 0,TRIM((SALT311.StrType)le.ms_wfsh_omos), ''),IF (le.ms_wfsh_pmos <> 0,TRIM((SALT311.StrType)le.ms_wfsh_pmos), ''),IF (le.ms_wfsh_totords <> 0,TRIM((SALT311.StrType)le.ms_wfsh_totords), ''),IF (le.ms_wfsh_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_wfsh_totdlrs), ''),IF (le.ms_wfsh_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_wfsh_avgdlrs), ''),IF (le.ms_wfsh_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lastdlrs), ''),IF (le.ms_wfsh_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_wfsh_paystat_paid), ''),IF (le.ms_wfsh_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_wfsh_osrc_dm), ''),IF (le.ms_wfsh_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lsrc_dm), ''),IF (le.ms_wfsh_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_wfsh_osrc_agt), ''),IF (le.ms_wfsh_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lsrc_agt), ''),IF (le.ms_audio <> 0,TRIM((SALT311.StrType)le.ms_audio), ''),IF (le.ms_auto <> 0,TRIM((SALT311.StrType)le.ms_auto), ''),IF (le.ms_aviation <> 0,TRIM((SALT311.StrType)le.ms_aviation), ''),IF (le.ms_bargains <> 0,TRIM((SALT311.StrType)le.ms_bargains), ''),IF (le.ms_beauty <> 0,TRIM((SALT311.StrType)le.ms_beauty), ''),IF (le.ms_bible <> 0,TRIM((SALT311.StrType)le.ms_bible), ''),IF (le.ms_bible_lmos <> 0,TRIM((SALT311.StrType)le.ms_bible_lmos), ''),IF (le.ms_bible_omos <> 0,TRIM((SALT311.StrType)le.ms_bible_omos), ''),IF (le.ms_bible_pmos <> 0,TRIM((SALT311.StrType)le.ms_bible_pmos), ''),IF (le.ms_bible_totords <> 0,TRIM((SALT311.StrType)le.ms_bible_totords), ''),IF (le.ms_bible_totitems <> 0,TRIM((SALT311.StrType)le.ms_bible_totitems), ''),IF (le.ms_bible_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_bible_totdlrs), ''),IF (le.ms_bible_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_bible_avgdlrs), ''),IF (le.ms_bible_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_bible_lastdlrs), ''),IF (le.ms_bible_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_bible_paystat_paid), ''),IF (le.ms_bible_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_bible_paymeth_cc), ''),IF (le.ms_bible_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_bible_paymeth_cash), ''),IF (le.ms_business <> 0,TRIM((SALT311.StrType)le.ms_business), ''),IF (le.ms_collectibles <> 0,TRIM((SALT311.StrType)le.ms_collectibles), ''),IF (le.ms_computers <> 0,TRIM((SALT311.StrType)le.ms_computers), ''),IF (le.ms_crafts <> 0,TRIM((SALT311.StrType)le.ms_crafts), ''),IF (le.ms_culturearts <> 0,TRIM((SALT311.StrType)le.ms_culturearts), ''),IF (le.ms_currevent <> 0,TRIM((SALT311.StrType)le.ms_currevent), ''),IF (le.ms_diy <> 0,TRIM((SALT311.StrType)le.ms_diy), ''),IF (le.ms_electronics <> 0,TRIM((SALT311.StrType)le.ms_electronics), ''),IF (le.ms_equestrian <> 0,TRIM((SALT311.StrType)le.ms_equestrian), ''),IF (le.ms_pub_family <> 0,TRIM((SALT311.StrType)le.ms_pub_family), ''),IF (le.ms_cat_family <> 0,TRIM((SALT311.StrType)le.ms_cat_family), ''),IF (le.ms_family <> 0,TRIM((SALT311.StrType)le.ms_family), ''),IF (le.ms_family_lmos <> 0,TRIM((SALT311.StrType)le.ms_family_lmos), ''),IF (le.ms_family_omos <> 0,TRIM((SALT311.StrType)le.ms_family_omos), ''),IF (le.ms_family_pmos <> 0,TRIM((SALT311.StrType)le.ms_family_pmos), ''),IF (le.ms_family_totords <> 0,TRIM((SALT311.StrType)le.ms_family_totords), ''),IF (le.ms_family_totitems <> 0,TRIM((SALT311.StrType)le.ms_family_totitems), ''),IF (le.ms_family_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_family_totdlrs), ''),IF (le.ms_family_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_family_avgdlrs), ''),IF (le.ms_family_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_family_lastdlrs), ''),IF (le.ms_family_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_family_paystat_paid), ''),IF (le.ms_family_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_family_paymeth_cc), ''),IF (le.ms_family_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_family_paymeth_cash), ''),IF (le.ms_family_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_family_osrc_dm), ''),IF (le.ms_family_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_family_lsrc_dm), ''),IF (le.ms_fiction <> 0,TRIM((SALT311.StrType)le.ms_fiction), ''),IF (le.ms_food <> 0,TRIM((SALT311.StrType)le.ms_food), ''),IF (le.ms_games <> 0,TRIM((SALT311.StrType)le.ms_games), ''),IF (le.ms_gifts <> 0,TRIM((SALT311.StrType)le.ms_gifts), ''),IF (le.ms_gourmet <> 0,TRIM((SALT311.StrType)le.ms_gourmet), ''),IF (le.ms_fitness <> 0,TRIM((SALT311.StrType)le.ms_fitness), ''),IF (le.ms_health <> 0,TRIM((SALT311.StrType)le.ms_health), ''),IF (le.ms_hlth_lmos <> 0,TRIM((SALT311.StrType)le.ms_hlth_lmos), ''),IF (le.ms_hlth_omos <> 0,TRIM((SALT311.StrType)le.ms_hlth_omos), ''),IF (le.ms_hlth_pmos <> 0,TRIM((SALT311.StrType)le.ms_hlth_pmos), ''),IF (le.ms_hlth_totords <> 0,TRIM((SALT311.StrType)le.ms_hlth_totords), ''),IF (le.ms_hlth_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_hlth_totdlrs), ''),IF (le.ms_hlth_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_hlth_avgdlrs), ''),IF (le.ms_hlth_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_hlth_lastdlrs), ''),IF (le.ms_hlth_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_hlth_paystat_paid), ''),IF (le.ms_hlth_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_hlth_paymeth_cc), ''),IF (le.ms_hlth_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_hlth_osrc_dm), ''),IF (le.ms_hlth_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_hlth_lsrc_dm), ''),IF (le.ms_hlth_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_hlth_osrc_agt), ''),IF (le.ms_hlth_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_hlth_lsrc_agt), ''),IF (le.ms_hlth_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_hlth_osrc_tv), ''),IF (le.ms_hlth_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_hlth_lsrc_tv), ''),IF (le.ms_holiday <> 0,TRIM((SALT311.StrType)le.ms_holiday), ''),IF (le.ms_history <> 0,TRIM((SALT311.StrType)le.ms_history), ''),IF (le.ms_pub_cooking <> 0,TRIM((SALT311.StrType)le.ms_pub_cooking), ''),IF (le.ms_cooking <> 0,TRIM((SALT311.StrType)le.ms_cooking), ''),IF (le.ms_pub_homedecr <> 0,TRIM((SALT311.StrType)le.ms_pub_homedecr), ''),IF (le.ms_cat_homedecr <> 0,TRIM((SALT311.StrType)le.ms_cat_homedecr), ''),IF (le.ms_homedecr <> 0,TRIM((SALT311.StrType)le.ms_homedecr), ''),IF (le.ms_housewares <> 0,TRIM((SALT311.StrType)le.ms_housewares), ''),IF (le.ms_pub_garden <> 0,TRIM((SALT311.StrType)le.ms_pub_garden), ''),IF (le.ms_cat_garden <> 0,TRIM((SALT311.StrType)le.ms_cat_garden), ''),IF (le.ms_garden <> 0,TRIM((SALT311.StrType)le.ms_garden), ''),IF (le.ms_pub_homeliv <> 0,TRIM((SALT311.StrType)le.ms_pub_homeliv), ''),IF (le.ms_cat_homeliv <> 0,TRIM((SALT311.StrType)le.ms_cat_homeliv), ''),IF (le.ms_homeliv <> 0,TRIM((SALT311.StrType)le.ms_homeliv), ''),IF (le.ms_pub_home_status_active <> 0,TRIM((SALT311.StrType)le.ms_pub_home_status_active), ''),IF (le.ms_home_lmos <> 0,TRIM((SALT311.StrType)le.ms_home_lmos), ''),IF (le.ms_home_omos <> 0,TRIM((SALT311.StrType)le.ms_home_omos), ''),IF (le.ms_home_pmos <> 0,TRIM((SALT311.StrType)le.ms_home_pmos), ''),IF (le.ms_home_totords <> 0,TRIM((SALT311.StrType)le.ms_home_totords), ''),IF (le.ms_home_totitems <> 0,TRIM((SALT311.StrType)le.ms_home_totitems), ''),IF (le.ms_home_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_home_totdlrs), ''),IF (le.ms_home_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_home_avgdlrs), ''),IF (le.ms_home_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_home_lastdlrs), ''),IF (le.ms_home_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_home_paystat_paid), ''),IF (le.ms_home_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_home_paymeth_cc), ''),IF (le.ms_home_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_home_paymeth_cash), ''),IF (le.ms_home_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_dm), ''),IF (le.ms_home_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_dm), ''),IF (le.ms_home_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_agt), ''),IF (le.ms_home_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_agt), ''),IF (le.ms_home_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_net), ''),IF (le.ms_home_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_net), ''),IF (le.ms_home_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_tv), ''),IF (le.ms_home_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_tv), ''),IF (le.ms_humor <> 0,TRIM((SALT311.StrType)le.ms_humor), ''),IF (le.ms_inspiration <> 0,TRIM((SALT311.StrType)le.ms_inspiration), ''),IF (le.ms_merchandise <> 0,TRIM((SALT311.StrType)le.ms_merchandise), ''),IF (le.ms_moneymaking <> 0,TRIM((SALT311.StrType)le.ms_moneymaking), ''),IF (le.ms_moneymaking_lmos <> 0,TRIM((SALT311.StrType)le.ms_moneymaking_lmos), ''),IF (le.ms_motorcycles <> 0,TRIM((SALT311.StrType)le.ms_motorcycles), ''),IF (le.ms_music <> 0,TRIM((SALT311.StrType)le.ms_music), ''),IF (le.ms_fishing <> 0,TRIM((SALT311.StrType)le.ms_fishing), ''),IF (le.ms_hunting <> 0,TRIM((SALT311.StrType)le.ms_hunting), ''),IF (le.ms_boatsail <> 0,TRIM((SALT311.StrType)le.ms_boatsail), ''),IF (le.ms_camp <> 0,TRIM((SALT311.StrType)le.ms_camp), ''),IF (le.ms_pub_outdoors <> 0,TRIM((SALT311.StrType)le.ms_pub_outdoors), ''),IF (le.ms_cat_outdoors <> 0,TRIM((SALT311.StrType)le.ms_cat_outdoors), ''),IF (le.ms_outdoors <> 0,TRIM((SALT311.StrType)le.ms_outdoors), ''),IF (le.ms_pub_out_status_active <> 0,TRIM((SALT311.StrType)le.ms_pub_out_status_active), ''),IF (le.ms_out_lmos <> 0,TRIM((SALT311.StrType)le.ms_out_lmos), ''),IF (le.ms_out_omos <> 0,TRIM((SALT311.StrType)le.ms_out_omos), ''),IF (le.ms_out_pmos <> 0,TRIM((SALT311.StrType)le.ms_out_pmos), ''),IF (le.ms_out_totords <> 0,TRIM((SALT311.StrType)le.ms_out_totords), ''),IF (le.ms_out_totitems <> 0,TRIM((SALT311.StrType)le.ms_out_totitems), ''),IF (le.ms_out_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_out_totdlrs), ''),IF (le.ms_out_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_out_avgdlrs), ''),IF (le.ms_out_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_out_lastdlrs), ''),IF (le.ms_out_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_out_paystat_paid), ''),IF (le.ms_out_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_out_paymeth_cc), ''),IF (le.ms_out_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_out_paymeth_cash), ''),IF (le.ms_out_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_out_osrc_dm), ''),IF (le.ms_out_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_out_lsrc_dm), ''),IF (le.ms_out_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_out_osrc_agt), ''),IF (le.ms_out_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_out_lsrc_agt), ''),IF (le.ms_pets <> 0,TRIM((SALT311.StrType)le.ms_pets), ''),IF (le.ms_pfin <> 0,TRIM((SALT311.StrType)le.ms_pfin), ''),IF (le.ms_photo <> 0,TRIM((SALT311.StrType)le.ms_photo), ''),IF (le.ms_photoproc <> 0,TRIM((SALT311.StrType)le.ms_photoproc), ''),IF (le.ms_rural <> 0,TRIM((SALT311.StrType)le.ms_rural), ''),IF (le.ms_science <> 0,TRIM((SALT311.StrType)le.ms_science), ''),IF (le.ms_sports <> 0,TRIM((SALT311.StrType)le.ms_sports), ''),IF (le.ms_sports_lmos <> 0,TRIM((SALT311.StrType)le.ms_sports_lmos), ''),IF (le.ms_travel <> 0,TRIM((SALT311.StrType)le.ms_travel), ''),IF (le.ms_tvmovies <> 0,TRIM((SALT311.StrType)le.ms_tvmovies), ''),IF (le.ms_wildlife <> 0,TRIM((SALT311.StrType)le.ms_wildlife), ''),IF (le.ms_woman <> 0,TRIM((SALT311.StrType)le.ms_woman), ''),IF (le.ms_woman_lmos <> 0,TRIM((SALT311.StrType)le.ms_woman_lmos), ''),IF (le.ms_ringtones_apps <> 0,TRIM((SALT311.StrType)le.ms_ringtones_apps), ''),IF (le.cpi_mobile_apps_index <> 0,TRIM((SALT311.StrType)le.cpi_mobile_apps_index), ''),IF (le.cpi_credit_repair_index <> 0,TRIM((SALT311.StrType)le.cpi_credit_repair_index), ''),IF (le.cpi_credit_report_index <> 0,TRIM((SALT311.StrType)le.cpi_credit_report_index), ''),IF (le.cpi_education_seekers_index <> 0,TRIM((SALT311.StrType)le.cpi_education_seekers_index), ''),IF (le.cpi_insurance_index <> 0,TRIM((SALT311.StrType)le.cpi_insurance_index), ''),IF (le.cpi_insurance_health_index <> 0,TRIM((SALT311.StrType)le.cpi_insurance_health_index), ''),IF (le.cpi_insurance_auto_index <> 0,TRIM((SALT311.StrType)le.cpi_insurance_auto_index), ''),IF (le.cpi_job_seekers_index <> 0,TRIM((SALT311.StrType)le.cpi_job_seekers_index), ''),IF (le.cpi_social_networking_index <> 0,TRIM((SALT311.StrType)le.cpi_social_networking_index), ''),IF (le.cpi_adult_index <> 0,TRIM((SALT311.StrType)le.cpi_adult_index), ''),IF (le.cpi_africanamerican_index <> 0,TRIM((SALT311.StrType)le.cpi_africanamerican_index), ''),IF (le.cpi_apparel_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_index), ''),IF (le.cpi_apparel_accessory_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_accessory_index), ''),IF (le.cpi_apparel_kids_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_kids_index), ''),IF (le.cpi_apparel_men_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_men_index), ''),IF (le.cpi_apparel_menfash_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_menfash_index), ''),IF (le.cpi_apparel_women_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_women_index), ''),IF (le.cpi_apparel_womfash_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_womfash_index), ''),IF (le.cpi_asian_index <> 0,TRIM((SALT311.StrType)le.cpi_asian_index), ''),IF (le.cpi_auto_index <> 0,TRIM((SALT311.StrType)le.cpi_auto_index), ''),IF (le.cpi_auto_racing_index <> 0,TRIM((SALT311.StrType)le.cpi_auto_racing_index), ''),IF (le.cpi_auto_trucks_index <> 0,TRIM((SALT311.StrType)le.cpi_auto_trucks_index), ''),IF (le.cpi_aviation_index <> 0,TRIM((SALT311.StrType)le.cpi_aviation_index), ''),IF (le.cpi_bargains_index <> 0,TRIM((SALT311.StrType)le.cpi_bargains_index), ''),IF (le.cpi_beauty_index <> 0,TRIM((SALT311.StrType)le.cpi_beauty_index), ''),IF (le.cpi_bible_index <> 0,TRIM((SALT311.StrType)le.cpi_bible_index), ''),IF (le.cpi_birds_index <> 0,TRIM((SALT311.StrType)le.cpi_birds_index), ''),IF (le.cpi_business_index <> 0,TRIM((SALT311.StrType)le.cpi_business_index), ''),IF (le.cpi_business_homeoffice_index <> 0,TRIM((SALT311.StrType)le.cpi_business_homeoffice_index), ''),IF (le.cpi_catalog_index <> 0,TRIM((SALT311.StrType)le.cpi_catalog_index), ''),IF (le.cpi_cc_index <> 0,TRIM((SALT311.StrType)le.cpi_cc_index), ''),IF (le.cpi_collectibles_index <> 0,TRIM((SALT311.StrType)le.cpi_collectibles_index), ''),IF (le.cpi_college_index <> 0,TRIM((SALT311.StrType)le.cpi_college_index), ''),IF (le.cpi_computers_index <> 0,TRIM((SALT311.StrType)le.cpi_computers_index), ''),IF (le.cpi_conservative_index <> 0,TRIM((SALT311.StrType)le.cpi_conservative_index), ''),IF (le.cpi_continuity_index <> 0,TRIM((SALT311.StrType)le.cpi_continuity_index), ''),IF (le.cpi_cooking_index <> 0,TRIM((SALT311.StrType)le.cpi_cooking_index), ''),IF (le.cpi_crafts_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_index), ''),IF (le.cpi_crafts_crochet_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_crochet_index), ''),IF (le.cpi_crafts_knit_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_knit_index), ''),IF (le.cpi_crafts_needlepoint_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_needlepoint_index), ''),IF (le.cpi_crafts_quilt_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_quilt_index), ''),IF (le.cpi_crafts_sew_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_sew_index), ''),IF (le.cpi_culturearts_index <> 0,TRIM((SALT311.StrType)le.cpi_culturearts_index), ''),IF (le.cpi_currevent_index <> 0,TRIM((SALT311.StrType)le.cpi_currevent_index), ''),IF (le.cpi_diy_index <> 0,TRIM((SALT311.StrType)le.cpi_diy_index), ''),IF (le.cpi_donor_index <> 0,TRIM((SALT311.StrType)le.cpi_donor_index), ''),IF (le.cpi_ego_index <> 0,TRIM((SALT311.StrType)le.cpi_ego_index), ''),IF (le.cpi_electronics_index <> 0,TRIM((SALT311.StrType)le.cpi_electronics_index), ''),IF (le.cpi_equestrian_index <> 0,TRIM((SALT311.StrType)le.cpi_equestrian_index), ''),IF (le.cpi_family_index <> 0,TRIM((SALT311.StrType)le.cpi_family_index), ''),IF (le.cpi_family_teen_index <> 0,TRIM((SALT311.StrType)le.cpi_family_teen_index), ''),IF (le.cpi_family_young_index <> 0,TRIM((SALT311.StrType)le.cpi_family_young_index), ''),IF (le.cpi_fiction_index <> 0,TRIM((SALT311.StrType)le.cpi_fiction_index), ''),IF (le.cpi_gambling_index <> 0,TRIM((SALT311.StrType)le.cpi_gambling_index), ''),IF (le.cpi_games_index <> 0,TRIM((SALT311.StrType)le.cpi_games_index), ''),IF (le.cpi_gardening_index <> 0,TRIM((SALT311.StrType)le.cpi_gardening_index), ''),IF (le.cpi_gay_index <> 0,TRIM((SALT311.StrType)le.cpi_gay_index), ''),IF (le.cpi_giftgivr_index <> 0,TRIM((SALT311.StrType)le.cpi_giftgivr_index), ''),IF (le.cpi_gourmet_index <> 0,TRIM((SALT311.StrType)le.cpi_gourmet_index), ''),IF (le.cpi_grandparents_index <> 0,TRIM((SALT311.StrType)le.cpi_grandparents_index), ''),IF (le.cpi_health_index <> 0,TRIM((SALT311.StrType)le.cpi_health_index), ''),IF (le.cpi_health_diet_index <> 0,TRIM((SALT311.StrType)le.cpi_health_diet_index), ''),IF (le.cpi_health_fitness_index <> 0,TRIM((SALT311.StrType)le.cpi_health_fitness_index), ''),IF (le.cpi_hightech_index <> 0,TRIM((SALT311.StrType)le.cpi_hightech_index), ''),IF (le.cpi_hispanic_index <> 0,TRIM((SALT311.StrType)le.cpi_hispanic_index), ''),IF (le.cpi_history_index <> 0,TRIM((SALT311.StrType)le.cpi_history_index), ''),IF (le.cpi_history_american_index <> 0,TRIM((SALT311.StrType)le.cpi_history_american_index), ''),IF (le.cpi_hobbies_index <> 0,TRIM((SALT311.StrType)le.cpi_hobbies_index), ''),IF (le.cpi_homedecr_index <> 0,TRIM((SALT311.StrType)le.cpi_homedecr_index), ''),IF (le.cpi_homeliv_index <> 0,TRIM((SALT311.StrType)le.cpi_homeliv_index), ''),IF (le.cpi_humor_index <> 0,TRIM((SALT311.StrType)le.cpi_humor_index), ''),IF (le.cpi_inspiration_index <> 0,TRIM((SALT311.StrType)le.cpi_inspiration_index), ''),IF (le.cpi_internet_index <> 0,TRIM((SALT311.StrType)le.cpi_internet_index), ''),IF (le.cpi_internet_access_index <> 0,TRIM((SALT311.StrType)le.cpi_internet_access_index), ''),IF (le.cpi_internet_buy_index <> 0,TRIM((SALT311.StrType)le.cpi_internet_buy_index), ''),IF (le.cpi_liberal_index <> 0,TRIM((SALT311.StrType)le.cpi_liberal_index), ''),IF (le.cpi_moneymaking_index <> 0,TRIM((SALT311.StrType)le.cpi_moneymaking_index), ''),IF (le.cpi_motorcycles_index <> 0,TRIM((SALT311.StrType)le.cpi_motorcycles_index), ''),IF (le.cpi_music_index <> 0,TRIM((SALT311.StrType)le.cpi_music_index), ''),IF (le.cpi_nonfiction_index <> 0,TRIM((SALT311.StrType)le.cpi_nonfiction_index), ''),IF (le.cpi_ocean_index <> 0,TRIM((SALT311.StrType)le.cpi_ocean_index), ''),IF (le.cpi_outdoors_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_index), ''),IF (le.cpi_outdoors_boatsail_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_boatsail_index), ''),IF (le.cpi_outdoors_camp_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_camp_index), ''),IF (le.cpi_outdoors_fishing_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_fishing_index), ''),IF (le.cpi_outdoors_huntfish_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_huntfish_index), ''),IF (le.cpi_outdoors_hunting_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_hunting_index), ''),IF (le.cpi_pets_index <> 0,TRIM((SALT311.StrType)le.cpi_pets_index), ''),IF (le.cpi_pets_cats_index <> 0,TRIM((SALT311.StrType)le.cpi_pets_cats_index), ''),IF (le.cpi_pets_dogs_index <> 0,TRIM((SALT311.StrType)le.cpi_pets_dogs_index), ''),IF (le.cpi_pfin_index <> 0,TRIM((SALT311.StrType)le.cpi_pfin_index), ''),IF (le.cpi_photog_index <> 0,TRIM((SALT311.StrType)le.cpi_photog_index), ''),IF (le.cpi_photoproc_index <> 0,TRIM((SALT311.StrType)le.cpi_photoproc_index), ''),IF (le.cpi_publish_index <> 0,TRIM((SALT311.StrType)le.cpi_publish_index), ''),IF (le.cpi_publish_books_index <> 0,TRIM((SALT311.StrType)le.cpi_publish_books_index), ''),IF (le.cpi_publish_mags_index <> 0,TRIM((SALT311.StrType)le.cpi_publish_mags_index), ''),IF (le.cpi_rural_index <> 0,TRIM((SALT311.StrType)le.cpi_rural_index), ''),IF (le.cpi_science_index <> 0,TRIM((SALT311.StrType)le.cpi_science_index), ''),IF (le.cpi_scifi_index <> 0,TRIM((SALT311.StrType)le.cpi_scifi_index), ''),IF (le.cpi_seniors_index <> 0,TRIM((SALT311.StrType)le.cpi_seniors_index), ''),IF (le.cpi_sports_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_index), ''),IF (le.cpi_sports_baseball_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_baseball_index), ''),IF (le.cpi_sports_basketball_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_basketball_index), ''),IF (le.cpi_sports_biking_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_biking_index), ''),IF (le.cpi_sports_football_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_football_index), ''),IF (le.cpi_sports_golf_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_golf_index), ''),IF (le.cpi_sports_hockey_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_hockey_index), ''),IF (le.cpi_sports_running_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_running_index), ''),IF (le.cpi_sports_ski_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_ski_index), ''),IF (le.cpi_sports_soccer_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_soccer_index), ''),IF (le.cpi_sports_swimming_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_swimming_index), ''),IF (le.cpi_sports_tennis_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_tennis_index), ''),IF (le.cpi_stationery_index <> 0,TRIM((SALT311.StrType)le.cpi_stationery_index), ''),IF (le.cpi_sweeps_index <> 0,TRIM((SALT311.StrType)le.cpi_sweeps_index), ''),IF (le.cpi_tobacco_index <> 0,TRIM((SALT311.StrType)le.cpi_tobacco_index), ''),IF (le.cpi_travel_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_index), ''),IF (le.cpi_travel_cruise_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_cruise_index), ''),IF (le.cpi_travel_rv_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_rv_index), ''),IF (le.cpi_travel_us_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_us_index), ''),IF (le.cpi_tvmovies_index <> 0,TRIM((SALT311.StrType)le.cpi_tvmovies_index), ''),IF (le.cpi_wildlife_index <> 0,TRIM((SALT311.StrType)le.cpi_wildlife_index), ''),IF (le.cpi_woman_index <> 0,TRIM((SALT311.StrType)le.cpi_woman_index), ''),IF (le.totdlr_index <> 0,TRIM((SALT311.StrType)le.totdlr_index), ''),IF (le.cpi_totdlr <> 0,TRIM((SALT311.StrType)le.cpi_totdlr), ''),IF (le.cpi_totords <> 0,TRIM((SALT311.StrType)le.cpi_totords), ''),IF (le.cpi_lastdlr <> 0,TRIM((SALT311.StrType)le.cpi_lastdlr), ''),IF (le.pkcatg <> 0,TRIM((SALT311.StrType)le.pkcatg), ''),IF (le.pkpubs <> 0,TRIM((SALT311.StrType)le.pkpubs), ''),IF (le.pkcont <> 0,TRIM((SALT311.StrType)le.pkcont), ''),IF (le.pkca01 <> 0,TRIM((SALT311.StrType)le.pkca01), ''),IF (le.pkca03 <> 0,TRIM((SALT311.StrType)le.pkca03), ''),IF (le.pkca04 <> 0,TRIM((SALT311.StrType)le.pkca04), ''),IF (le.pkca05 <> 0,TRIM((SALT311.StrType)le.pkca05), ''),IF (le.pkca06 <> 0,TRIM((SALT311.StrType)le.pkca06), ''),IF (le.pkca07 <> 0,TRIM((SALT311.StrType)le.pkca07), ''),IF (le.pkca08 <> 0,TRIM((SALT311.StrType)le.pkca08), ''),IF (le.pkca09 <> 0,TRIM((SALT311.StrType)le.pkca09), ''),IF (le.pkca10 <> 0,TRIM((SALT311.StrType)le.pkca10), ''),IF (le.pkca11 <> 0,TRIM((SALT311.StrType)le.pkca11), ''),IF (le.pkca12 <> 0,TRIM((SALT311.StrType)le.pkca12), ''),IF (le.pkca13 <> 0,TRIM((SALT311.StrType)le.pkca13), ''),IF (le.pkca14 <> 0,TRIM((SALT311.StrType)le.pkca14), ''),IF (le.pkca15 <> 0,TRIM((SALT311.StrType)le.pkca15), ''),IF (le.pkca16 <> 0,TRIM((SALT311.StrType)le.pkca16), ''),IF (le.pkca17 <> 0,TRIM((SALT311.StrType)le.pkca17), ''),IF (le.pkca18 <> 0,TRIM((SALT311.StrType)le.pkca18), ''),IF (le.pkca20 <> 0,TRIM((SALT311.StrType)le.pkca20), ''),IF (le.pkca21 <> 0,TRIM((SALT311.StrType)le.pkca21), ''),IF (le.pkca22 <> 0,TRIM((SALT311.StrType)le.pkca22), ''),IF (le.pkca23 <> 0,TRIM((SALT311.StrType)le.pkca23), ''),IF (le.pkca24 <> 0,TRIM((SALT311.StrType)le.pkca24), ''),IF (le.pkca25 <> 0,TRIM((SALT311.StrType)le.pkca25), ''),IF (le.pkca26 <> 0,TRIM((SALT311.StrType)le.pkca26), ''),IF (le.pkca28 <> 0,TRIM((SALT311.StrType)le.pkca28), ''),IF (le.pkca29 <> 0,TRIM((SALT311.StrType)le.pkca29), ''),IF (le.pkca30 <> 0,TRIM((SALT311.StrType)le.pkca30), ''),IF (le.pkca31 <> 0,TRIM((SALT311.StrType)le.pkca31), ''),IF (le.pkca32 <> 0,TRIM((SALT311.StrType)le.pkca32), ''),IF (le.pkca33 <> 0,TRIM((SALT311.StrType)le.pkca33), ''),IF (le.pkca34 <> 0,TRIM((SALT311.StrType)le.pkca34), ''),IF (le.pkca35 <> 0,TRIM((SALT311.StrType)le.pkca35), ''),IF (le.pkca36 <> 0,TRIM((SALT311.StrType)le.pkca36), ''),IF (le.pkca37 <> 0,TRIM((SALT311.StrType)le.pkca37), ''),IF (le.pkca39 <> 0,TRIM((SALT311.StrType)le.pkca39), ''),IF (le.pkca40 <> 0,TRIM((SALT311.StrType)le.pkca40), ''),IF (le.pkca41 <> 0,TRIM((SALT311.StrType)le.pkca41), ''),IF (le.pkca42 <> 0,TRIM((SALT311.StrType)le.pkca42), ''),IF (le.pkca54 <> 0,TRIM((SALT311.StrType)le.pkca54), ''),IF (le.pkca61 <> 0,TRIM((SALT311.StrType)le.pkca61), ''),IF (le.pkca62 <> 0,TRIM((SALT311.StrType)le.pkca62), ''),IF (le.pkca64 <> 0,TRIM((SALT311.StrType)le.pkca64), ''),IF (le.pkpu01 <> 0,TRIM((SALT311.StrType)le.pkpu01), ''),IF (le.pkpu02 <> 0,TRIM((SALT311.StrType)le.pkpu02), ''),IF (le.pkpu03 <> 0,TRIM((SALT311.StrType)le.pkpu03), ''),IF (le.pkpu04 <> 0,TRIM((SALT311.StrType)le.pkpu04), ''),IF (le.pkpu05 <> 0,TRIM((SALT311.StrType)le.pkpu05), ''),IF (le.pkpu06 <> 0,TRIM((SALT311.StrType)le.pkpu06), ''),IF (le.pkpu07 <> 0,TRIM((SALT311.StrType)le.pkpu07), ''),IF (le.pkpu08 <> 0,TRIM((SALT311.StrType)le.pkpu08), ''),IF (le.pkpu09 <> 0,TRIM((SALT311.StrType)le.pkpu09), ''),IF (le.pkpu10 <> 0,TRIM((SALT311.StrType)le.pkpu10), ''),IF (le.pkpu11 <> 0,TRIM((SALT311.StrType)le.pkpu11), ''),IF (le.pkpu12 <> 0,TRIM((SALT311.StrType)le.pkpu12), ''),IF (le.pkpu13 <> 0,TRIM((SALT311.StrType)le.pkpu13), ''),IF (le.pkpu14 <> 0,TRIM((SALT311.StrType)le.pkpu14), ''),IF (le.pkpu15 <> 0,TRIM((SALT311.StrType)le.pkpu15), ''),IF (le.pkpu16 <> 0,TRIM((SALT311.StrType)le.pkpu16), ''),IF (le.pkpu17 <> 0,TRIM((SALT311.StrType)le.pkpu17), ''),IF (le.pkpu18 <> 0,TRIM((SALT311.StrType)le.pkpu18), ''),IF (le.pkpu19 <> 0,TRIM((SALT311.StrType)le.pkpu19), ''),IF (le.pkpu20 <> 0,TRIM((SALT311.StrType)le.pkpu20), ''),IF (le.pkpu23 <> 0,TRIM((SALT311.StrType)le.pkpu23), ''),IF (le.pkpu25 <> 0,TRIM((SALT311.StrType)le.pkpu25), ''),IF (le.pkpu27 <> 0,TRIM((SALT311.StrType)le.pkpu27), ''),IF (le.pkpu28 <> 0,TRIM((SALT311.StrType)le.pkpu28), ''),IF (le.pkpu29 <> 0,TRIM((SALT311.StrType)le.pkpu29), ''),IF (le.pkpu30 <> 0,TRIM((SALT311.StrType)le.pkpu30), ''),IF (le.pkpu31 <> 0,TRIM((SALT311.StrType)le.pkpu31), ''),IF (le.pkpu32 <> 0,TRIM((SALT311.StrType)le.pkpu32), ''),IF (le.pkpu33 <> 0,TRIM((SALT311.StrType)le.pkpu33), ''),IF (le.pkpu34 <> 0,TRIM((SALT311.StrType)le.pkpu34), ''),IF (le.pkpu35 <> 0,TRIM((SALT311.StrType)le.pkpu35), ''),IF (le.pkpu38 <> 0,TRIM((SALT311.StrType)le.pkpu38), ''),IF (le.pkpu41 <> 0,TRIM((SALT311.StrType)le.pkpu41), ''),IF (le.pkpu42 <> 0,TRIM((SALT311.StrType)le.pkpu42), ''),IF (le.pkpu45 <> 0,TRIM((SALT311.StrType)le.pkpu45), ''),IF (le.pkpu46 <> 0,TRIM((SALT311.StrType)le.pkpu46), ''),IF (le.pkpu47 <> 0,TRIM((SALT311.StrType)le.pkpu47), ''),IF (le.pkpu48 <> 0,TRIM((SALT311.StrType)le.pkpu48), ''),IF (le.pkpu49 <> 0,TRIM((SALT311.StrType)le.pkpu49), ''),IF (le.pkpu50 <> 0,TRIM((SALT311.StrType)le.pkpu50), ''),IF (le.pkpu51 <> 0,TRIM((SALT311.StrType)le.pkpu51), ''),IF (le.pkpu52 <> 0,TRIM((SALT311.StrType)le.pkpu52), ''),IF (le.pkpu53 <> 0,TRIM((SALT311.StrType)le.pkpu53), ''),IF (le.pkpu54 <> 0,TRIM((SALT311.StrType)le.pkpu54), ''),IF (le.pkpu55 <> 0,TRIM((SALT311.StrType)le.pkpu55), ''),IF (le.pkpu56 <> 0,TRIM((SALT311.StrType)le.pkpu56), ''),IF (le.pkpu57 <> 0,TRIM((SALT311.StrType)le.pkpu57), ''),IF (le.pkpu60 <> 0,TRIM((SALT311.StrType)le.pkpu60), ''),IF (le.pkpu61 <> 0,TRIM((SALT311.StrType)le.pkpu61), ''),IF (le.pkpu62 <> 0,TRIM((SALT311.StrType)le.pkpu62), ''),IF (le.pkpu63 <> 0,TRIM((SALT311.StrType)le.pkpu63), ''),IF (le.pkpu64 <> 0,TRIM((SALT311.StrType)le.pkpu64), ''),IF (le.pkpu65 <> 0,TRIM((SALT311.StrType)le.pkpu65), ''),IF (le.pkpu66 <> 0,TRIM((SALT311.StrType)le.pkpu66), ''),IF (le.pkpu67 <> 0,TRIM((SALT311.StrType)le.pkpu67), ''),IF (le.pkpu68 <> 0,TRIM((SALT311.StrType)le.pkpu68), ''),IF (le.pkpu69 <> 0,TRIM((SALT311.StrType)le.pkpu69), ''),IF (le.pkpu70 <> 0,TRIM((SALT311.StrType)le.pkpu70), ''),IF (le.censpct_water <> 0,TRIM((SALT311.StrType)le.censpct_water), ''),IF (le.cens_pop_density <> 0,TRIM((SALT311.StrType)le.cens_pop_density), ''),IF (le.cens_hu_density <> 0,TRIM((SALT311.StrType)le.cens_hu_density), ''),IF (le.censpct_pop_white <> 0,TRIM((SALT311.StrType)le.censpct_pop_white), ''),IF (le.censpct_pop_black <> 0,TRIM((SALT311.StrType)le.censpct_pop_black), ''),IF (le.censpct_pop_amerind <> 0,TRIM((SALT311.StrType)le.censpct_pop_amerind), ''),IF (le.censpct_pop_asian <> 0,TRIM((SALT311.StrType)le.censpct_pop_asian), ''),IF (le.censpct_pop_pacisl <> 0,TRIM((SALT311.StrType)le.censpct_pop_pacisl), ''),IF (le.censpct_pop_othrace <> 0,TRIM((SALT311.StrType)le.censpct_pop_othrace), ''),IF (le.censpct_pop_multirace <> 0,TRIM((SALT311.StrType)le.censpct_pop_multirace), ''),IF (le.censpct_pop_hispanic <> 0,TRIM((SALT311.StrType)le.censpct_pop_hispanic), ''),IF (le.censpct_pop_agelt18 <> 0,TRIM((SALT311.StrType)le.censpct_pop_agelt18), ''),IF (le.censpct_pop_males <> 0,TRIM((SALT311.StrType)le.censpct_pop_males), ''),IF (le.censpct_adult_age1824 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age1824), ''),IF (le.censpct_adult_age2534 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age2534), ''),IF (le.censpct_adult_age3544 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age3544), ''),IF (le.censpct_adult_age4554 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age4554), ''),IF (le.censpct_adult_age5564 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age5564), ''),IF (le.censpct_adult_agege65 <> 0,TRIM((SALT311.StrType)le.censpct_adult_agege65), ''),IF (le.cens_pop_medage <> 0,TRIM((SALT311.StrType)le.cens_pop_medage), ''),IF (le.cens_hh_avgsize <> 0,TRIM((SALT311.StrType)le.cens_hh_avgsize), ''),IF (le.censpct_hh_family <> 0,TRIM((SALT311.StrType)le.censpct_hh_family), ''),IF (le.censpct_hh_family_husbwife <> 0,TRIM((SALT311.StrType)le.censpct_hh_family_husbwife), ''),IF (le.censpct_hu_occupied <> 0,TRIM((SALT311.StrType)le.censpct_hu_occupied), ''),IF (le.censpct_hu_owned <> 0,TRIM((SALT311.StrType)le.censpct_hu_owned), ''),IF (le.censpct_hu_rented <> 0,TRIM((SALT311.StrType)le.censpct_hu_rented), ''),IF (le.censpct_hu_vacantseasonal <> 0,TRIM((SALT311.StrType)le.censpct_hu_vacantseasonal), ''),IF (le.zip_medinc <> 0,TRIM((SALT311.StrType)le.zip_medinc), ''),IF (le.zip_apparel <> 0,TRIM((SALT311.StrType)le.zip_apparel), ''),IF (le.zip_apparel_women <> 0,TRIM((SALT311.StrType)le.zip_apparel_women), ''),IF (le.zip_apparel_womfash <> 0,TRIM((SALT311.StrType)le.zip_apparel_womfash), ''),IF (le.zip_auto <> 0,TRIM((SALT311.StrType)le.zip_auto), ''),IF (le.zip_beauty <> 0,TRIM((SALT311.StrType)le.zip_beauty), ''),IF (le.zip_booksmusicmovies <> 0,TRIM((SALT311.StrType)le.zip_booksmusicmovies), ''),IF (le.zip_business <> 0,TRIM((SALT311.StrType)le.zip_business), ''),IF (le.zip_catalog <> 0,TRIM((SALT311.StrType)le.zip_catalog), ''),IF (le.zip_cc <> 0,TRIM((SALT311.StrType)le.zip_cc), ''),IF (le.zip_collectibles <> 0,TRIM((SALT311.StrType)le.zip_collectibles), ''),IF (le.zip_computers <> 0,TRIM((SALT311.StrType)le.zip_computers), ''),IF (le.zip_continuity <> 0,TRIM((SALT311.StrType)le.zip_continuity), ''),IF (le.zip_cooking <> 0,TRIM((SALT311.StrType)le.zip_cooking), ''),IF (le.zip_crafts <> 0,TRIM((SALT311.StrType)le.zip_crafts), ''),IF (le.zip_culturearts <> 0,TRIM((SALT311.StrType)le.zip_culturearts), ''),IF (le.zip_dm_sold <> 0,TRIM((SALT311.StrType)le.zip_dm_sold), ''),IF (le.zip_donor <> 0,TRIM((SALT311.StrType)le.zip_donor), ''),IF (le.zip_family <> 0,TRIM((SALT311.StrType)le.zip_family), ''),IF (le.zip_gardening <> 0,TRIM((SALT311.StrType)le.zip_gardening), ''),IF (le.zip_giftgivr <> 0,TRIM((SALT311.StrType)le.zip_giftgivr), ''),IF (le.zip_gourmet <> 0,TRIM((SALT311.StrType)le.zip_gourmet), ''),IF (le.zip_health <> 0,TRIM((SALT311.StrType)le.zip_health), ''),IF (le.zip_health_diet <> 0,TRIM((SALT311.StrType)le.zip_health_diet), ''),IF (le.zip_health_fitness <> 0,TRIM((SALT311.StrType)le.zip_health_fitness), ''),IF (le.zip_hobbies <> 0,TRIM((SALT311.StrType)le.zip_hobbies), ''),IF (le.zip_homedecr <> 0,TRIM((SALT311.StrType)le.zip_homedecr), ''),IF (le.zip_homeliv <> 0,TRIM((SALT311.StrType)le.zip_homeliv), ''),IF (le.zip_internet <> 0,TRIM((SALT311.StrType)le.zip_internet), ''),IF (le.zip_internet_access <> 0,TRIM((SALT311.StrType)le.zip_internet_access), ''),IF (le.zip_internet_buy <> 0,TRIM((SALT311.StrType)le.zip_internet_buy), ''),IF (le.zip_music <> 0,TRIM((SALT311.StrType)le.zip_music), ''),IF (le.zip_outdoors <> 0,TRIM((SALT311.StrType)le.zip_outdoors), ''),IF (le.zip_pets <> 0,TRIM((SALT311.StrType)le.zip_pets), ''),IF (le.zip_pfin <> 0,TRIM((SALT311.StrType)le.zip_pfin), ''),IF (le.zip_publish <> 0,TRIM((SALT311.StrType)le.zip_publish), ''),IF (le.zip_publish_books <> 0,TRIM((SALT311.StrType)le.zip_publish_books), ''),IF (le.zip_publish_mags <> 0,TRIM((SALT311.StrType)le.zip_publish_mags), ''),IF (le.zip_sports <> 0,TRIM((SALT311.StrType)le.zip_sports), ''),IF (le.zip_sports_biking <> 0,TRIM((SALT311.StrType)le.zip_sports_biking), ''),IF (le.zip_sports_golf <> 0,TRIM((SALT311.StrType)le.zip_sports_golf), ''),IF (le.zip_travel <> 0,TRIM((SALT311.StrType)le.zip_travel), ''),IF (le.zip_travel_us <> 0,TRIM((SALT311.StrType)le.zip_travel_us), ''),IF (le.zip_tvmovies <> 0,TRIM((SALT311.StrType)le.zip_tvmovies), ''),IF (le.zip_woman <> 0,TRIM((SALT311.StrType)le.zip_woman), ''),IF (le.zip_proftech <> 0,TRIM((SALT311.StrType)le.zip_proftech), ''),IF (le.zip_retired <> 0,TRIM((SALT311.StrType)le.zip_retired), ''),IF (le.zip_inc100 <> 0,TRIM((SALT311.StrType)le.zip_inc100), ''),IF (le.zip_inc75 <> 0,TRIM((SALT311.StrType)le.zip_inc75), ''),IF (le.zip_inc50 <> 0,TRIM((SALT311.StrType)le.zip_inc50), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,633,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 633);
  SELF.FldNo2 := 1 + (C % 633);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dtmatch),TRIM((SALT311.StrType)le.msname),TRIM((SALT311.StrType)le.msaddr1),TRIM((SALT311.StrType)le.msaddr2),TRIM((SALT311.StrType)le.mscity),TRIM((SALT311.StrType)le.msstate),TRIM((SALT311.StrType)le.mszip5),TRIM((SALT311.StrType)le.mszip4),TRIM((SALT311.StrType)le.dthh),TRIM((SALT311.StrType)le.mscrrt),TRIM((SALT311.StrType)le.msdpbc),TRIM((SALT311.StrType)le.msdpv),TRIM((SALT311.StrType)le.ms_addrtype),TRIM((SALT311.StrType)le.ctysize),IF (le.lmos <> 0,TRIM((SALT311.StrType)le.lmos), ''),IF (le.omos <> 0,TRIM((SALT311.StrType)le.omos), ''),IF (le.pmos <> 0,TRIM((SALT311.StrType)le.pmos), ''),TRIM((SALT311.StrType)le.gen),TRIM((SALT311.StrType)le.dob),IF (le.age <> 0,TRIM((SALT311.StrType)le.age), ''),TRIM((SALT311.StrType)le.inc),TRIM((SALT311.StrType)le.marital_status),TRIM((SALT311.StrType)le.poc),TRIM((SALT311.StrType)le.noc),TRIM((SALT311.StrType)le.ocp),TRIM((SALT311.StrType)le.edu),TRIM((SALT311.StrType)le.lang),TRIM((SALT311.StrType)le.relig),TRIM((SALT311.StrType)le.dwell),TRIM((SALT311.StrType)le.ownr),TRIM((SALT311.StrType)le.eth1),TRIM((SALT311.StrType)le.eth2),TRIM((SALT311.StrType)le.lor),TRIM((SALT311.StrType)le.pool),TRIM((SALT311.StrType)le.speak_span),TRIM((SALT311.StrType)le.soho),TRIM((SALT311.StrType)le.vet_in_hh),IF (le.ms_mags <> 0,TRIM((SALT311.StrType)le.ms_mags), ''),IF (le.ms_books <> 0,TRIM((SALT311.StrType)le.ms_books), ''),IF (le.ms_publish <> 0,TRIM((SALT311.StrType)le.ms_publish), ''),IF (le.ms_pub_status_active <> 0,TRIM((SALT311.StrType)le.ms_pub_status_active), ''),IF (le.ms_pub_status_expire <> 0,TRIM((SALT311.StrType)le.ms_pub_status_expire), ''),IF (le.ms_pub_premsold <> 0,TRIM((SALT311.StrType)le.ms_pub_premsold), ''),IF (le.ms_pub_autornwl <> 0,TRIM((SALT311.StrType)le.ms_pub_autornwl), ''),IF (le.ms_pub_avgterm <> 0,TRIM((SALT311.StrType)le.ms_pub_avgterm), ''),IF (le.ms_pub_lmos <> 0,TRIM((SALT311.StrType)le.ms_pub_lmos), ''),IF (le.ms_pub_omos <> 0,TRIM((SALT311.StrType)le.ms_pub_omos), ''),IF (le.ms_pub_pmos <> 0,TRIM((SALT311.StrType)le.ms_pub_pmos), ''),IF (le.ms_pub_cemos <> 0,TRIM((SALT311.StrType)le.ms_pub_cemos), ''),IF (le.ms_pub_femos <> 0,TRIM((SALT311.StrType)le.ms_pub_femos), ''),IF (le.ms_pub_totords <> 0,TRIM((SALT311.StrType)le.ms_pub_totords), ''),IF (le.ms_pub_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_pub_totdlrs), ''),IF (le.ms_pub_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_pub_avgdlrs), ''),IF (le.ms_pub_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_pub_lastdlrs), ''),IF (le.ms_pub_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_pub_paystat_paid), ''),IF (le.ms_pub_paystat_ub <> 0,TRIM((SALT311.StrType)le.ms_pub_paystat_ub), ''),IF (le.ms_pub_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_pub_paymeth_cc), ''),IF (le.ms_pub_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_pub_paymeth_cash), ''),IF (le.ms_pub_payspeed <> 0,TRIM((SALT311.StrType)le.ms_pub_payspeed), ''),IF (le.ms_pub_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_dm), ''),IF (le.ms_pub_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_dm), ''),IF (le.ms_pub_osrc_agt_cashf <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_cashf), ''),IF (le.ms_pub_lsrc_agt_cashf <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_cashf), ''),IF (le.ms_pub_osrc_agt_pds <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_pds), ''),IF (le.ms_pub_lsrc_agt_pds <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_pds), ''),IF (le.ms_pub_osrc_agt_schplan <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_schplan), ''),IF (le.ms_pub_lsrc_agt_schplan <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_schplan), ''),IF (le.ms_pub_osrc_agt_sponsor <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_sponsor), ''),IF (le.ms_pub_lsrc_agt_sponsor <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_sponsor), ''),IF (le.ms_pub_osrc_agt_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_tm), ''),IF (le.ms_pub_lsrc_agt_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_tm), ''),IF (le.ms_pub_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt), ''),IF (le.ms_pub_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt), ''),IF (le.ms_pub_osrc_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_tm), ''),IF (le.ms_pub_lsrc_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_tm), ''),IF (le.ms_pub_osrc_ins <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_ins), ''),IF (le.ms_pub_lsrc_ins <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_ins), ''),IF (le.ms_pub_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_net), ''),IF (le.ms_pub_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_net), ''),IF (le.ms_pub_osrc_print <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_print), ''),IF (le.ms_pub_lsrc_print <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_print), ''),IF (le.ms_pub_osrc_trans <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_trans), ''),IF (le.ms_pub_lsrc_trans <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_trans), ''),IF (le.ms_pub_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_tv), ''),IF (le.ms_pub_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_tv), ''),IF (le.ms_pub_osrc_dtp <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_dtp), ''),IF (le.ms_pub_lsrc_dtp <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_dtp), ''),IF (le.ms_pub_giftgivr <> 0,TRIM((SALT311.StrType)le.ms_pub_giftgivr), ''),IF (le.ms_pub_giftee <> 0,TRIM((SALT311.StrType)le.ms_pub_giftee), ''),IF (le.ms_catalog <> 0,TRIM((SALT311.StrType)le.ms_catalog), ''),IF (le.ms_cat_lmos <> 0,TRIM((SALT311.StrType)le.ms_cat_lmos), ''),IF (le.ms_cat_omos <> 0,TRIM((SALT311.StrType)le.ms_cat_omos), ''),IF (le.ms_cat_pmos <> 0,TRIM((SALT311.StrType)le.ms_cat_pmos), ''),IF (le.ms_cat_totords <> 0,TRIM((SALT311.StrType)le.ms_cat_totords), ''),IF (le.ms_cat_totitems <> 0,TRIM((SALT311.StrType)le.ms_cat_totitems), ''),IF (le.ms_cat_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_cat_totdlrs), ''),IF (le.ms_cat_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_cat_avgdlrs), ''),IF (le.ms_cat_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_cat_lastdlrs), ''),IF (le.ms_cat_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_cat_paystat_paid), ''),IF (le.ms_cat_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_cat_paymeth_cc), ''),IF (le.ms_cat_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_cat_paymeth_cash), ''),IF (le.ms_cat_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_cat_osrc_dm), ''),IF (le.ms_cat_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_cat_lsrc_dm), ''),IF (le.ms_cat_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_cat_osrc_net), ''),IF (le.ms_cat_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_cat_lsrc_net), ''),IF (le.ms_cat_giftgivr <> 0,TRIM((SALT311.StrType)le.ms_cat_giftgivr), ''),IF (le.pkpubs_corrected <> 0,TRIM((SALT311.StrType)le.pkpubs_corrected), ''),IF (le.pkcatg_corrected <> 0,TRIM((SALT311.StrType)le.pkcatg_corrected), ''),IF (le.ms_fundraising <> 0,TRIM((SALT311.StrType)le.ms_fundraising), ''),IF (le.ms_fund_lmos <> 0,TRIM((SALT311.StrType)le.ms_fund_lmos), ''),IF (le.ms_fund_omos <> 0,TRIM((SALT311.StrType)le.ms_fund_omos), ''),IF (le.ms_fund_pmos <> 0,TRIM((SALT311.StrType)le.ms_fund_pmos), ''),IF (le.ms_fund_totords <> 0,TRIM((SALT311.StrType)le.ms_fund_totords), ''),IF (le.ms_fund_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_fund_totdlrs), ''),IF (le.ms_fund_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_fund_avgdlrs), ''),IF (le.ms_fund_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_fund_lastdlrs), ''),IF (le.ms_fund_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_fund_paystat_paid), ''),IF (le.ms_other <> 0,TRIM((SALT311.StrType)le.ms_other), ''),IF (le.ms_continuity <> 0,TRIM((SALT311.StrType)le.ms_continuity), ''),IF (le.ms_cont_status_active <> 0,TRIM((SALT311.StrType)le.ms_cont_status_active), ''),IF (le.ms_cont_status_cancel <> 0,TRIM((SALT311.StrType)le.ms_cont_status_cancel), ''),IF (le.ms_cont_omos <> 0,TRIM((SALT311.StrType)le.ms_cont_omos), ''),IF (le.ms_cont_lmos <> 0,TRIM((SALT311.StrType)le.ms_cont_lmos), ''),IF (le.ms_cont_pmos <> 0,TRIM((SALT311.StrType)le.ms_cont_pmos), ''),IF (le.ms_cont_totords <> 0,TRIM((SALT311.StrType)le.ms_cont_totords), ''),IF (le.ms_cont_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_cont_totdlrs), ''),IF (le.ms_cont_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_cont_avgdlrs), ''),IF (le.ms_cont_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_cont_lastdlrs), ''),IF (le.ms_cont_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_cont_paystat_paid), ''),IF (le.ms_cont_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_cont_paymeth_cc), ''),IF (le.ms_cont_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_cont_paymeth_cash), ''),IF (le.ms_totords <> 0,TRIM((SALT311.StrType)le.ms_totords), ''),IF (le.ms_totitems <> 0,TRIM((SALT311.StrType)le.ms_totitems), ''),IF (le.ms_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_totdlrs), ''),IF (le.ms_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_avgdlrs), ''),IF (le.ms_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_lastdlrs), ''),IF (le.ms_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_paystat_paid), ''),IF (le.ms_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_paymeth_cc), ''),IF (le.ms_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_paymeth_cash), ''),IF (le.ms_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_osrc_dm), ''),IF (le.ms_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_lsrc_dm), ''),IF (le.ms_osrc_tm <> 0,TRIM((SALT311.StrType)le.ms_osrc_tm), ''),IF (le.ms_lsrc_tm <> 0,TRIM((SALT311.StrType)le.ms_lsrc_tm), ''),IF (le.ms_osrc_ins <> 0,TRIM((SALT311.StrType)le.ms_osrc_ins), ''),IF (le.ms_lsrc_ins <> 0,TRIM((SALT311.StrType)le.ms_lsrc_ins), ''),IF (le.ms_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_osrc_net), ''),IF (le.ms_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_lsrc_net), ''),IF (le.ms_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_osrc_tv), ''),IF (le.ms_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_lsrc_tv), ''),IF (le.ms_osrc_retail <> 0,TRIM((SALT311.StrType)le.ms_osrc_retail), ''),IF (le.ms_lsrc_retail <> 0,TRIM((SALT311.StrType)le.ms_lsrc_retail), ''),IF (le.ms_giftgivr <> 0,TRIM((SALT311.StrType)le.ms_giftgivr), ''),IF (le.ms_giftee <> 0,TRIM((SALT311.StrType)le.ms_giftee), ''),IF (le.ms_adult <> 0,TRIM((SALT311.StrType)le.ms_adult), ''),IF (le.ms_womapp <> 0,TRIM((SALT311.StrType)le.ms_womapp), ''),IF (le.ms_menapp <> 0,TRIM((SALT311.StrType)le.ms_menapp), ''),IF (le.ms_kidapp <> 0,TRIM((SALT311.StrType)le.ms_kidapp), ''),IF (le.ms_accessory <> 0,TRIM((SALT311.StrType)le.ms_accessory), ''),IF (le.ms_apparel <> 0,TRIM((SALT311.StrType)le.ms_apparel), ''),IF (le.ms_app_lmos <> 0,TRIM((SALT311.StrType)le.ms_app_lmos), ''),IF (le.ms_app_omos <> 0,TRIM((SALT311.StrType)le.ms_app_omos), ''),IF (le.ms_app_pmos <> 0,TRIM((SALT311.StrType)le.ms_app_pmos), ''),IF (le.ms_app_totords <> 0,TRIM((SALT311.StrType)le.ms_app_totords), ''),IF (le.ms_app_totitems <> 0,TRIM((SALT311.StrType)le.ms_app_totitems), ''),IF (le.ms_app_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_app_totdlrs), ''),IF (le.ms_app_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_app_avgdlrs), ''),IF (le.ms_app_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_app_lastdlrs), ''),IF (le.ms_app_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_app_paystat_paid), ''),IF (le.ms_app_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_app_paymeth_cc), ''),IF (le.ms_app_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_app_paymeth_cash), ''),IF (le.ms_menfash <> 0,TRIM((SALT311.StrType)le.ms_menfash), ''),IF (le.ms_womfash <> 0,TRIM((SALT311.StrType)le.ms_womfash), ''),IF (le.ms_wfsh_lmos <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lmos), ''),IF (le.ms_wfsh_omos <> 0,TRIM((SALT311.StrType)le.ms_wfsh_omos), ''),IF (le.ms_wfsh_pmos <> 0,TRIM((SALT311.StrType)le.ms_wfsh_pmos), ''),IF (le.ms_wfsh_totords <> 0,TRIM((SALT311.StrType)le.ms_wfsh_totords), ''),IF (le.ms_wfsh_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_wfsh_totdlrs), ''),IF (le.ms_wfsh_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_wfsh_avgdlrs), ''),IF (le.ms_wfsh_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lastdlrs), ''),IF (le.ms_wfsh_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_wfsh_paystat_paid), ''),IF (le.ms_wfsh_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_wfsh_osrc_dm), ''),IF (le.ms_wfsh_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lsrc_dm), ''),IF (le.ms_wfsh_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_wfsh_osrc_agt), ''),IF (le.ms_wfsh_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lsrc_agt), ''),IF (le.ms_audio <> 0,TRIM((SALT311.StrType)le.ms_audio), ''),IF (le.ms_auto <> 0,TRIM((SALT311.StrType)le.ms_auto), ''),IF (le.ms_aviation <> 0,TRIM((SALT311.StrType)le.ms_aviation), ''),IF (le.ms_bargains <> 0,TRIM((SALT311.StrType)le.ms_bargains), ''),IF (le.ms_beauty <> 0,TRIM((SALT311.StrType)le.ms_beauty), ''),IF (le.ms_bible <> 0,TRIM((SALT311.StrType)le.ms_bible), ''),IF (le.ms_bible_lmos <> 0,TRIM((SALT311.StrType)le.ms_bible_lmos), ''),IF (le.ms_bible_omos <> 0,TRIM((SALT311.StrType)le.ms_bible_omos), ''),IF (le.ms_bible_pmos <> 0,TRIM((SALT311.StrType)le.ms_bible_pmos), ''),IF (le.ms_bible_totords <> 0,TRIM((SALT311.StrType)le.ms_bible_totords), ''),IF (le.ms_bible_totitems <> 0,TRIM((SALT311.StrType)le.ms_bible_totitems), ''),IF (le.ms_bible_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_bible_totdlrs), ''),IF (le.ms_bible_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_bible_avgdlrs), ''),IF (le.ms_bible_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_bible_lastdlrs), ''),IF (le.ms_bible_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_bible_paystat_paid), ''),IF (le.ms_bible_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_bible_paymeth_cc), ''),IF (le.ms_bible_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_bible_paymeth_cash), ''),IF (le.ms_business <> 0,TRIM((SALT311.StrType)le.ms_business), ''),IF (le.ms_collectibles <> 0,TRIM((SALT311.StrType)le.ms_collectibles), ''),IF (le.ms_computers <> 0,TRIM((SALT311.StrType)le.ms_computers), ''),IF (le.ms_crafts <> 0,TRIM((SALT311.StrType)le.ms_crafts), ''),IF (le.ms_culturearts <> 0,TRIM((SALT311.StrType)le.ms_culturearts), ''),IF (le.ms_currevent <> 0,TRIM((SALT311.StrType)le.ms_currevent), ''),IF (le.ms_diy <> 0,TRIM((SALT311.StrType)le.ms_diy), ''),IF (le.ms_electronics <> 0,TRIM((SALT311.StrType)le.ms_electronics), ''),IF (le.ms_equestrian <> 0,TRIM((SALT311.StrType)le.ms_equestrian), ''),IF (le.ms_pub_family <> 0,TRIM((SALT311.StrType)le.ms_pub_family), ''),IF (le.ms_cat_family <> 0,TRIM((SALT311.StrType)le.ms_cat_family), ''),IF (le.ms_family <> 0,TRIM((SALT311.StrType)le.ms_family), ''),IF (le.ms_family_lmos <> 0,TRIM((SALT311.StrType)le.ms_family_lmos), ''),IF (le.ms_family_omos <> 0,TRIM((SALT311.StrType)le.ms_family_omos), ''),IF (le.ms_family_pmos <> 0,TRIM((SALT311.StrType)le.ms_family_pmos), ''),IF (le.ms_family_totords <> 0,TRIM((SALT311.StrType)le.ms_family_totords), ''),IF (le.ms_family_totitems <> 0,TRIM((SALT311.StrType)le.ms_family_totitems), ''),IF (le.ms_family_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_family_totdlrs), ''),IF (le.ms_family_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_family_avgdlrs), ''),IF (le.ms_family_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_family_lastdlrs), ''),IF (le.ms_family_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_family_paystat_paid), ''),IF (le.ms_family_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_family_paymeth_cc), ''),IF (le.ms_family_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_family_paymeth_cash), ''),IF (le.ms_family_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_family_osrc_dm), ''),IF (le.ms_family_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_family_lsrc_dm), ''),IF (le.ms_fiction <> 0,TRIM((SALT311.StrType)le.ms_fiction), ''),IF (le.ms_food <> 0,TRIM((SALT311.StrType)le.ms_food), ''),IF (le.ms_games <> 0,TRIM((SALT311.StrType)le.ms_games), ''),IF (le.ms_gifts <> 0,TRIM((SALT311.StrType)le.ms_gifts), ''),IF (le.ms_gourmet <> 0,TRIM((SALT311.StrType)le.ms_gourmet), ''),IF (le.ms_fitness <> 0,TRIM((SALT311.StrType)le.ms_fitness), ''),IF (le.ms_health <> 0,TRIM((SALT311.StrType)le.ms_health), ''),IF (le.ms_hlth_lmos <> 0,TRIM((SALT311.StrType)le.ms_hlth_lmos), ''),IF (le.ms_hlth_omos <> 0,TRIM((SALT311.StrType)le.ms_hlth_omos), ''),IF (le.ms_hlth_pmos <> 0,TRIM((SALT311.StrType)le.ms_hlth_pmos), ''),IF (le.ms_hlth_totords <> 0,TRIM((SALT311.StrType)le.ms_hlth_totords), ''),IF (le.ms_hlth_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_hlth_totdlrs), ''),IF (le.ms_hlth_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_hlth_avgdlrs), ''),IF (le.ms_hlth_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_hlth_lastdlrs), ''),IF (le.ms_hlth_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_hlth_paystat_paid), ''),IF (le.ms_hlth_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_hlth_paymeth_cc), ''),IF (le.ms_hlth_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_hlth_osrc_dm), ''),IF (le.ms_hlth_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_hlth_lsrc_dm), ''),IF (le.ms_hlth_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_hlth_osrc_agt), ''),IF (le.ms_hlth_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_hlth_lsrc_agt), ''),IF (le.ms_hlth_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_hlth_osrc_tv), ''),IF (le.ms_hlth_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_hlth_lsrc_tv), ''),IF (le.ms_holiday <> 0,TRIM((SALT311.StrType)le.ms_holiday), ''),IF (le.ms_history <> 0,TRIM((SALT311.StrType)le.ms_history), ''),IF (le.ms_pub_cooking <> 0,TRIM((SALT311.StrType)le.ms_pub_cooking), ''),IF (le.ms_cooking <> 0,TRIM((SALT311.StrType)le.ms_cooking), ''),IF (le.ms_pub_homedecr <> 0,TRIM((SALT311.StrType)le.ms_pub_homedecr), ''),IF (le.ms_cat_homedecr <> 0,TRIM((SALT311.StrType)le.ms_cat_homedecr), ''),IF (le.ms_homedecr <> 0,TRIM((SALT311.StrType)le.ms_homedecr), ''),IF (le.ms_housewares <> 0,TRIM((SALT311.StrType)le.ms_housewares), ''),IF (le.ms_pub_garden <> 0,TRIM((SALT311.StrType)le.ms_pub_garden), ''),IF (le.ms_cat_garden <> 0,TRIM((SALT311.StrType)le.ms_cat_garden), ''),IF (le.ms_garden <> 0,TRIM((SALT311.StrType)le.ms_garden), ''),IF (le.ms_pub_homeliv <> 0,TRIM((SALT311.StrType)le.ms_pub_homeliv), ''),IF (le.ms_cat_homeliv <> 0,TRIM((SALT311.StrType)le.ms_cat_homeliv), ''),IF (le.ms_homeliv <> 0,TRIM((SALT311.StrType)le.ms_homeliv), ''),IF (le.ms_pub_home_status_active <> 0,TRIM((SALT311.StrType)le.ms_pub_home_status_active), ''),IF (le.ms_home_lmos <> 0,TRIM((SALT311.StrType)le.ms_home_lmos), ''),IF (le.ms_home_omos <> 0,TRIM((SALT311.StrType)le.ms_home_omos), ''),IF (le.ms_home_pmos <> 0,TRIM((SALT311.StrType)le.ms_home_pmos), ''),IF (le.ms_home_totords <> 0,TRIM((SALT311.StrType)le.ms_home_totords), ''),IF (le.ms_home_totitems <> 0,TRIM((SALT311.StrType)le.ms_home_totitems), ''),IF (le.ms_home_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_home_totdlrs), ''),IF (le.ms_home_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_home_avgdlrs), ''),IF (le.ms_home_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_home_lastdlrs), ''),IF (le.ms_home_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_home_paystat_paid), ''),IF (le.ms_home_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_home_paymeth_cc), ''),IF (le.ms_home_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_home_paymeth_cash), ''),IF (le.ms_home_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_dm), ''),IF (le.ms_home_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_dm), ''),IF (le.ms_home_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_agt), ''),IF (le.ms_home_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_agt), ''),IF (le.ms_home_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_net), ''),IF (le.ms_home_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_net), ''),IF (le.ms_home_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_tv), ''),IF (le.ms_home_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_tv), ''),IF (le.ms_humor <> 0,TRIM((SALT311.StrType)le.ms_humor), ''),IF (le.ms_inspiration <> 0,TRIM((SALT311.StrType)le.ms_inspiration), ''),IF (le.ms_merchandise <> 0,TRIM((SALT311.StrType)le.ms_merchandise), ''),IF (le.ms_moneymaking <> 0,TRIM((SALT311.StrType)le.ms_moneymaking), ''),IF (le.ms_moneymaking_lmos <> 0,TRIM((SALT311.StrType)le.ms_moneymaking_lmos), ''),IF (le.ms_motorcycles <> 0,TRIM((SALT311.StrType)le.ms_motorcycles), ''),IF (le.ms_music <> 0,TRIM((SALT311.StrType)le.ms_music), ''),IF (le.ms_fishing <> 0,TRIM((SALT311.StrType)le.ms_fishing), ''),IF (le.ms_hunting <> 0,TRIM((SALT311.StrType)le.ms_hunting), ''),IF (le.ms_boatsail <> 0,TRIM((SALT311.StrType)le.ms_boatsail), ''),IF (le.ms_camp <> 0,TRIM((SALT311.StrType)le.ms_camp), ''),IF (le.ms_pub_outdoors <> 0,TRIM((SALT311.StrType)le.ms_pub_outdoors), ''),IF (le.ms_cat_outdoors <> 0,TRIM((SALT311.StrType)le.ms_cat_outdoors), ''),IF (le.ms_outdoors <> 0,TRIM((SALT311.StrType)le.ms_outdoors), ''),IF (le.ms_pub_out_status_active <> 0,TRIM((SALT311.StrType)le.ms_pub_out_status_active), ''),IF (le.ms_out_lmos <> 0,TRIM((SALT311.StrType)le.ms_out_lmos), ''),IF (le.ms_out_omos <> 0,TRIM((SALT311.StrType)le.ms_out_omos), ''),IF (le.ms_out_pmos <> 0,TRIM((SALT311.StrType)le.ms_out_pmos), ''),IF (le.ms_out_totords <> 0,TRIM((SALT311.StrType)le.ms_out_totords), ''),IF (le.ms_out_totitems <> 0,TRIM((SALT311.StrType)le.ms_out_totitems), ''),IF (le.ms_out_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_out_totdlrs), ''),IF (le.ms_out_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_out_avgdlrs), ''),IF (le.ms_out_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_out_lastdlrs), ''),IF (le.ms_out_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_out_paystat_paid), ''),IF (le.ms_out_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_out_paymeth_cc), ''),IF (le.ms_out_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_out_paymeth_cash), ''),IF (le.ms_out_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_out_osrc_dm), ''),IF (le.ms_out_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_out_lsrc_dm), ''),IF (le.ms_out_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_out_osrc_agt), ''),IF (le.ms_out_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_out_lsrc_agt), ''),IF (le.ms_pets <> 0,TRIM((SALT311.StrType)le.ms_pets), ''),IF (le.ms_pfin <> 0,TRIM((SALT311.StrType)le.ms_pfin), ''),IF (le.ms_photo <> 0,TRIM((SALT311.StrType)le.ms_photo), ''),IF (le.ms_photoproc <> 0,TRIM((SALT311.StrType)le.ms_photoproc), ''),IF (le.ms_rural <> 0,TRIM((SALT311.StrType)le.ms_rural), ''),IF (le.ms_science <> 0,TRIM((SALT311.StrType)le.ms_science), ''),IF (le.ms_sports <> 0,TRIM((SALT311.StrType)le.ms_sports), ''),IF (le.ms_sports_lmos <> 0,TRIM((SALT311.StrType)le.ms_sports_lmos), ''),IF (le.ms_travel <> 0,TRIM((SALT311.StrType)le.ms_travel), ''),IF (le.ms_tvmovies <> 0,TRIM((SALT311.StrType)le.ms_tvmovies), ''),IF (le.ms_wildlife <> 0,TRIM((SALT311.StrType)le.ms_wildlife), ''),IF (le.ms_woman <> 0,TRIM((SALT311.StrType)le.ms_woman), ''),IF (le.ms_woman_lmos <> 0,TRIM((SALT311.StrType)le.ms_woman_lmos), ''),IF (le.ms_ringtones_apps <> 0,TRIM((SALT311.StrType)le.ms_ringtones_apps), ''),IF (le.cpi_mobile_apps_index <> 0,TRIM((SALT311.StrType)le.cpi_mobile_apps_index), ''),IF (le.cpi_credit_repair_index <> 0,TRIM((SALT311.StrType)le.cpi_credit_repair_index), ''),IF (le.cpi_credit_report_index <> 0,TRIM((SALT311.StrType)le.cpi_credit_report_index), ''),IF (le.cpi_education_seekers_index <> 0,TRIM((SALT311.StrType)le.cpi_education_seekers_index), ''),IF (le.cpi_insurance_index <> 0,TRIM((SALT311.StrType)le.cpi_insurance_index), ''),IF (le.cpi_insurance_health_index <> 0,TRIM((SALT311.StrType)le.cpi_insurance_health_index), ''),IF (le.cpi_insurance_auto_index <> 0,TRIM((SALT311.StrType)le.cpi_insurance_auto_index), ''),IF (le.cpi_job_seekers_index <> 0,TRIM((SALT311.StrType)le.cpi_job_seekers_index), ''),IF (le.cpi_social_networking_index <> 0,TRIM((SALT311.StrType)le.cpi_social_networking_index), ''),IF (le.cpi_adult_index <> 0,TRIM((SALT311.StrType)le.cpi_adult_index), ''),IF (le.cpi_africanamerican_index <> 0,TRIM((SALT311.StrType)le.cpi_africanamerican_index), ''),IF (le.cpi_apparel_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_index), ''),IF (le.cpi_apparel_accessory_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_accessory_index), ''),IF (le.cpi_apparel_kids_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_kids_index), ''),IF (le.cpi_apparel_men_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_men_index), ''),IF (le.cpi_apparel_menfash_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_menfash_index), ''),IF (le.cpi_apparel_women_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_women_index), ''),IF (le.cpi_apparel_womfash_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_womfash_index), ''),IF (le.cpi_asian_index <> 0,TRIM((SALT311.StrType)le.cpi_asian_index), ''),IF (le.cpi_auto_index <> 0,TRIM((SALT311.StrType)le.cpi_auto_index), ''),IF (le.cpi_auto_racing_index <> 0,TRIM((SALT311.StrType)le.cpi_auto_racing_index), ''),IF (le.cpi_auto_trucks_index <> 0,TRIM((SALT311.StrType)le.cpi_auto_trucks_index), ''),IF (le.cpi_aviation_index <> 0,TRIM((SALT311.StrType)le.cpi_aviation_index), ''),IF (le.cpi_bargains_index <> 0,TRIM((SALT311.StrType)le.cpi_bargains_index), ''),IF (le.cpi_beauty_index <> 0,TRIM((SALT311.StrType)le.cpi_beauty_index), ''),IF (le.cpi_bible_index <> 0,TRIM((SALT311.StrType)le.cpi_bible_index), ''),IF (le.cpi_birds_index <> 0,TRIM((SALT311.StrType)le.cpi_birds_index), ''),IF (le.cpi_business_index <> 0,TRIM((SALT311.StrType)le.cpi_business_index), ''),IF (le.cpi_business_homeoffice_index <> 0,TRIM((SALT311.StrType)le.cpi_business_homeoffice_index), ''),IF (le.cpi_catalog_index <> 0,TRIM((SALT311.StrType)le.cpi_catalog_index), ''),IF (le.cpi_cc_index <> 0,TRIM((SALT311.StrType)le.cpi_cc_index), ''),IF (le.cpi_collectibles_index <> 0,TRIM((SALT311.StrType)le.cpi_collectibles_index), ''),IF (le.cpi_college_index <> 0,TRIM((SALT311.StrType)le.cpi_college_index), ''),IF (le.cpi_computers_index <> 0,TRIM((SALT311.StrType)le.cpi_computers_index), ''),IF (le.cpi_conservative_index <> 0,TRIM((SALT311.StrType)le.cpi_conservative_index), ''),IF (le.cpi_continuity_index <> 0,TRIM((SALT311.StrType)le.cpi_continuity_index), ''),IF (le.cpi_cooking_index <> 0,TRIM((SALT311.StrType)le.cpi_cooking_index), ''),IF (le.cpi_crafts_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_index), ''),IF (le.cpi_crafts_crochet_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_crochet_index), ''),IF (le.cpi_crafts_knit_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_knit_index), ''),IF (le.cpi_crafts_needlepoint_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_needlepoint_index), ''),IF (le.cpi_crafts_quilt_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_quilt_index), ''),IF (le.cpi_crafts_sew_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_sew_index), ''),IF (le.cpi_culturearts_index <> 0,TRIM((SALT311.StrType)le.cpi_culturearts_index), ''),IF (le.cpi_currevent_index <> 0,TRIM((SALT311.StrType)le.cpi_currevent_index), ''),IF (le.cpi_diy_index <> 0,TRIM((SALT311.StrType)le.cpi_diy_index), ''),IF (le.cpi_donor_index <> 0,TRIM((SALT311.StrType)le.cpi_donor_index), ''),IF (le.cpi_ego_index <> 0,TRIM((SALT311.StrType)le.cpi_ego_index), ''),IF (le.cpi_electronics_index <> 0,TRIM((SALT311.StrType)le.cpi_electronics_index), ''),IF (le.cpi_equestrian_index <> 0,TRIM((SALT311.StrType)le.cpi_equestrian_index), ''),IF (le.cpi_family_index <> 0,TRIM((SALT311.StrType)le.cpi_family_index), ''),IF (le.cpi_family_teen_index <> 0,TRIM((SALT311.StrType)le.cpi_family_teen_index), ''),IF (le.cpi_family_young_index <> 0,TRIM((SALT311.StrType)le.cpi_family_young_index), ''),IF (le.cpi_fiction_index <> 0,TRIM((SALT311.StrType)le.cpi_fiction_index), ''),IF (le.cpi_gambling_index <> 0,TRIM((SALT311.StrType)le.cpi_gambling_index), ''),IF (le.cpi_games_index <> 0,TRIM((SALT311.StrType)le.cpi_games_index), ''),IF (le.cpi_gardening_index <> 0,TRIM((SALT311.StrType)le.cpi_gardening_index), ''),IF (le.cpi_gay_index <> 0,TRIM((SALT311.StrType)le.cpi_gay_index), ''),IF (le.cpi_giftgivr_index <> 0,TRIM((SALT311.StrType)le.cpi_giftgivr_index), ''),IF (le.cpi_gourmet_index <> 0,TRIM((SALT311.StrType)le.cpi_gourmet_index), ''),IF (le.cpi_grandparents_index <> 0,TRIM((SALT311.StrType)le.cpi_grandparents_index), ''),IF (le.cpi_health_index <> 0,TRIM((SALT311.StrType)le.cpi_health_index), ''),IF (le.cpi_health_diet_index <> 0,TRIM((SALT311.StrType)le.cpi_health_diet_index), ''),IF (le.cpi_health_fitness_index <> 0,TRIM((SALT311.StrType)le.cpi_health_fitness_index), ''),IF (le.cpi_hightech_index <> 0,TRIM((SALT311.StrType)le.cpi_hightech_index), ''),IF (le.cpi_hispanic_index <> 0,TRIM((SALT311.StrType)le.cpi_hispanic_index), ''),IF (le.cpi_history_index <> 0,TRIM((SALT311.StrType)le.cpi_history_index), ''),IF (le.cpi_history_american_index <> 0,TRIM((SALT311.StrType)le.cpi_history_american_index), ''),IF (le.cpi_hobbies_index <> 0,TRIM((SALT311.StrType)le.cpi_hobbies_index), ''),IF (le.cpi_homedecr_index <> 0,TRIM((SALT311.StrType)le.cpi_homedecr_index), ''),IF (le.cpi_homeliv_index <> 0,TRIM((SALT311.StrType)le.cpi_homeliv_index), ''),IF (le.cpi_humor_index <> 0,TRIM((SALT311.StrType)le.cpi_humor_index), ''),IF (le.cpi_inspiration_index <> 0,TRIM((SALT311.StrType)le.cpi_inspiration_index), ''),IF (le.cpi_internet_index <> 0,TRIM((SALT311.StrType)le.cpi_internet_index), ''),IF (le.cpi_internet_access_index <> 0,TRIM((SALT311.StrType)le.cpi_internet_access_index), ''),IF (le.cpi_internet_buy_index <> 0,TRIM((SALT311.StrType)le.cpi_internet_buy_index), ''),IF (le.cpi_liberal_index <> 0,TRIM((SALT311.StrType)le.cpi_liberal_index), ''),IF (le.cpi_moneymaking_index <> 0,TRIM((SALT311.StrType)le.cpi_moneymaking_index), ''),IF (le.cpi_motorcycles_index <> 0,TRIM((SALT311.StrType)le.cpi_motorcycles_index), ''),IF (le.cpi_music_index <> 0,TRIM((SALT311.StrType)le.cpi_music_index), ''),IF (le.cpi_nonfiction_index <> 0,TRIM((SALT311.StrType)le.cpi_nonfiction_index), ''),IF (le.cpi_ocean_index <> 0,TRIM((SALT311.StrType)le.cpi_ocean_index), ''),IF (le.cpi_outdoors_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_index), ''),IF (le.cpi_outdoors_boatsail_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_boatsail_index), ''),IF (le.cpi_outdoors_camp_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_camp_index), ''),IF (le.cpi_outdoors_fishing_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_fishing_index), ''),IF (le.cpi_outdoors_huntfish_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_huntfish_index), ''),IF (le.cpi_outdoors_hunting_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_hunting_index), ''),IF (le.cpi_pets_index <> 0,TRIM((SALT311.StrType)le.cpi_pets_index), ''),IF (le.cpi_pets_cats_index <> 0,TRIM((SALT311.StrType)le.cpi_pets_cats_index), ''),IF (le.cpi_pets_dogs_index <> 0,TRIM((SALT311.StrType)le.cpi_pets_dogs_index), ''),IF (le.cpi_pfin_index <> 0,TRIM((SALT311.StrType)le.cpi_pfin_index), ''),IF (le.cpi_photog_index <> 0,TRIM((SALT311.StrType)le.cpi_photog_index), ''),IF (le.cpi_photoproc_index <> 0,TRIM((SALT311.StrType)le.cpi_photoproc_index), ''),IF (le.cpi_publish_index <> 0,TRIM((SALT311.StrType)le.cpi_publish_index), ''),IF (le.cpi_publish_books_index <> 0,TRIM((SALT311.StrType)le.cpi_publish_books_index), ''),IF (le.cpi_publish_mags_index <> 0,TRIM((SALT311.StrType)le.cpi_publish_mags_index), ''),IF (le.cpi_rural_index <> 0,TRIM((SALT311.StrType)le.cpi_rural_index), ''),IF (le.cpi_science_index <> 0,TRIM((SALT311.StrType)le.cpi_science_index), ''),IF (le.cpi_scifi_index <> 0,TRIM((SALT311.StrType)le.cpi_scifi_index), ''),IF (le.cpi_seniors_index <> 0,TRIM((SALT311.StrType)le.cpi_seniors_index), ''),IF (le.cpi_sports_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_index), ''),IF (le.cpi_sports_baseball_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_baseball_index), ''),IF (le.cpi_sports_basketball_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_basketball_index), ''),IF (le.cpi_sports_biking_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_biking_index), ''),IF (le.cpi_sports_football_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_football_index), ''),IF (le.cpi_sports_golf_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_golf_index), ''),IF (le.cpi_sports_hockey_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_hockey_index), ''),IF (le.cpi_sports_running_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_running_index), ''),IF (le.cpi_sports_ski_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_ski_index), ''),IF (le.cpi_sports_soccer_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_soccer_index), ''),IF (le.cpi_sports_swimming_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_swimming_index), ''),IF (le.cpi_sports_tennis_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_tennis_index), ''),IF (le.cpi_stationery_index <> 0,TRIM((SALT311.StrType)le.cpi_stationery_index), ''),IF (le.cpi_sweeps_index <> 0,TRIM((SALT311.StrType)le.cpi_sweeps_index), ''),IF (le.cpi_tobacco_index <> 0,TRIM((SALT311.StrType)le.cpi_tobacco_index), ''),IF (le.cpi_travel_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_index), ''),IF (le.cpi_travel_cruise_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_cruise_index), ''),IF (le.cpi_travel_rv_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_rv_index), ''),IF (le.cpi_travel_us_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_us_index), ''),IF (le.cpi_tvmovies_index <> 0,TRIM((SALT311.StrType)le.cpi_tvmovies_index), ''),IF (le.cpi_wildlife_index <> 0,TRIM((SALT311.StrType)le.cpi_wildlife_index), ''),IF (le.cpi_woman_index <> 0,TRIM((SALT311.StrType)le.cpi_woman_index), ''),IF (le.totdlr_index <> 0,TRIM((SALT311.StrType)le.totdlr_index), ''),IF (le.cpi_totdlr <> 0,TRIM((SALT311.StrType)le.cpi_totdlr), ''),IF (le.cpi_totords <> 0,TRIM((SALT311.StrType)le.cpi_totords), ''),IF (le.cpi_lastdlr <> 0,TRIM((SALT311.StrType)le.cpi_lastdlr), ''),IF (le.pkcatg <> 0,TRIM((SALT311.StrType)le.pkcatg), ''),IF (le.pkpubs <> 0,TRIM((SALT311.StrType)le.pkpubs), ''),IF (le.pkcont <> 0,TRIM((SALT311.StrType)le.pkcont), ''),IF (le.pkca01 <> 0,TRIM((SALT311.StrType)le.pkca01), ''),IF (le.pkca03 <> 0,TRIM((SALT311.StrType)le.pkca03), ''),IF (le.pkca04 <> 0,TRIM((SALT311.StrType)le.pkca04), ''),IF (le.pkca05 <> 0,TRIM((SALT311.StrType)le.pkca05), ''),IF (le.pkca06 <> 0,TRIM((SALT311.StrType)le.pkca06), ''),IF (le.pkca07 <> 0,TRIM((SALT311.StrType)le.pkca07), ''),IF (le.pkca08 <> 0,TRIM((SALT311.StrType)le.pkca08), ''),IF (le.pkca09 <> 0,TRIM((SALT311.StrType)le.pkca09), ''),IF (le.pkca10 <> 0,TRIM((SALT311.StrType)le.pkca10), ''),IF (le.pkca11 <> 0,TRIM((SALT311.StrType)le.pkca11), ''),IF (le.pkca12 <> 0,TRIM((SALT311.StrType)le.pkca12), ''),IF (le.pkca13 <> 0,TRIM((SALT311.StrType)le.pkca13), ''),IF (le.pkca14 <> 0,TRIM((SALT311.StrType)le.pkca14), ''),IF (le.pkca15 <> 0,TRIM((SALT311.StrType)le.pkca15), ''),IF (le.pkca16 <> 0,TRIM((SALT311.StrType)le.pkca16), ''),IF (le.pkca17 <> 0,TRIM((SALT311.StrType)le.pkca17), ''),IF (le.pkca18 <> 0,TRIM((SALT311.StrType)le.pkca18), ''),IF (le.pkca20 <> 0,TRIM((SALT311.StrType)le.pkca20), ''),IF (le.pkca21 <> 0,TRIM((SALT311.StrType)le.pkca21), ''),IF (le.pkca22 <> 0,TRIM((SALT311.StrType)le.pkca22), ''),IF (le.pkca23 <> 0,TRIM((SALT311.StrType)le.pkca23), ''),IF (le.pkca24 <> 0,TRIM((SALT311.StrType)le.pkca24), ''),IF (le.pkca25 <> 0,TRIM((SALT311.StrType)le.pkca25), ''),IF (le.pkca26 <> 0,TRIM((SALT311.StrType)le.pkca26), ''),IF (le.pkca28 <> 0,TRIM((SALT311.StrType)le.pkca28), ''),IF (le.pkca29 <> 0,TRIM((SALT311.StrType)le.pkca29), ''),IF (le.pkca30 <> 0,TRIM((SALT311.StrType)le.pkca30), ''),IF (le.pkca31 <> 0,TRIM((SALT311.StrType)le.pkca31), ''),IF (le.pkca32 <> 0,TRIM((SALT311.StrType)le.pkca32), ''),IF (le.pkca33 <> 0,TRIM((SALT311.StrType)le.pkca33), ''),IF (le.pkca34 <> 0,TRIM((SALT311.StrType)le.pkca34), ''),IF (le.pkca35 <> 0,TRIM((SALT311.StrType)le.pkca35), ''),IF (le.pkca36 <> 0,TRIM((SALT311.StrType)le.pkca36), ''),IF (le.pkca37 <> 0,TRIM((SALT311.StrType)le.pkca37), ''),IF (le.pkca39 <> 0,TRIM((SALT311.StrType)le.pkca39), ''),IF (le.pkca40 <> 0,TRIM((SALT311.StrType)le.pkca40), ''),IF (le.pkca41 <> 0,TRIM((SALT311.StrType)le.pkca41), ''),IF (le.pkca42 <> 0,TRIM((SALT311.StrType)le.pkca42), ''),IF (le.pkca54 <> 0,TRIM((SALT311.StrType)le.pkca54), ''),IF (le.pkca61 <> 0,TRIM((SALT311.StrType)le.pkca61), ''),IF (le.pkca62 <> 0,TRIM((SALT311.StrType)le.pkca62), ''),IF (le.pkca64 <> 0,TRIM((SALT311.StrType)le.pkca64), ''),IF (le.pkpu01 <> 0,TRIM((SALT311.StrType)le.pkpu01), ''),IF (le.pkpu02 <> 0,TRIM((SALT311.StrType)le.pkpu02), ''),IF (le.pkpu03 <> 0,TRIM((SALT311.StrType)le.pkpu03), ''),IF (le.pkpu04 <> 0,TRIM((SALT311.StrType)le.pkpu04), ''),IF (le.pkpu05 <> 0,TRIM((SALT311.StrType)le.pkpu05), ''),IF (le.pkpu06 <> 0,TRIM((SALT311.StrType)le.pkpu06), ''),IF (le.pkpu07 <> 0,TRIM((SALT311.StrType)le.pkpu07), ''),IF (le.pkpu08 <> 0,TRIM((SALT311.StrType)le.pkpu08), ''),IF (le.pkpu09 <> 0,TRIM((SALT311.StrType)le.pkpu09), ''),IF (le.pkpu10 <> 0,TRIM((SALT311.StrType)le.pkpu10), ''),IF (le.pkpu11 <> 0,TRIM((SALT311.StrType)le.pkpu11), ''),IF (le.pkpu12 <> 0,TRIM((SALT311.StrType)le.pkpu12), ''),IF (le.pkpu13 <> 0,TRIM((SALT311.StrType)le.pkpu13), ''),IF (le.pkpu14 <> 0,TRIM((SALT311.StrType)le.pkpu14), ''),IF (le.pkpu15 <> 0,TRIM((SALT311.StrType)le.pkpu15), ''),IF (le.pkpu16 <> 0,TRIM((SALT311.StrType)le.pkpu16), ''),IF (le.pkpu17 <> 0,TRIM((SALT311.StrType)le.pkpu17), ''),IF (le.pkpu18 <> 0,TRIM((SALT311.StrType)le.pkpu18), ''),IF (le.pkpu19 <> 0,TRIM((SALT311.StrType)le.pkpu19), ''),IF (le.pkpu20 <> 0,TRIM((SALT311.StrType)le.pkpu20), ''),IF (le.pkpu23 <> 0,TRIM((SALT311.StrType)le.pkpu23), ''),IF (le.pkpu25 <> 0,TRIM((SALT311.StrType)le.pkpu25), ''),IF (le.pkpu27 <> 0,TRIM((SALT311.StrType)le.pkpu27), ''),IF (le.pkpu28 <> 0,TRIM((SALT311.StrType)le.pkpu28), ''),IF (le.pkpu29 <> 0,TRIM((SALT311.StrType)le.pkpu29), ''),IF (le.pkpu30 <> 0,TRIM((SALT311.StrType)le.pkpu30), ''),IF (le.pkpu31 <> 0,TRIM((SALT311.StrType)le.pkpu31), ''),IF (le.pkpu32 <> 0,TRIM((SALT311.StrType)le.pkpu32), ''),IF (le.pkpu33 <> 0,TRIM((SALT311.StrType)le.pkpu33), ''),IF (le.pkpu34 <> 0,TRIM((SALT311.StrType)le.pkpu34), ''),IF (le.pkpu35 <> 0,TRIM((SALT311.StrType)le.pkpu35), ''),IF (le.pkpu38 <> 0,TRIM((SALT311.StrType)le.pkpu38), ''),IF (le.pkpu41 <> 0,TRIM((SALT311.StrType)le.pkpu41), ''),IF (le.pkpu42 <> 0,TRIM((SALT311.StrType)le.pkpu42), ''),IF (le.pkpu45 <> 0,TRIM((SALT311.StrType)le.pkpu45), ''),IF (le.pkpu46 <> 0,TRIM((SALT311.StrType)le.pkpu46), ''),IF (le.pkpu47 <> 0,TRIM((SALT311.StrType)le.pkpu47), ''),IF (le.pkpu48 <> 0,TRIM((SALT311.StrType)le.pkpu48), ''),IF (le.pkpu49 <> 0,TRIM((SALT311.StrType)le.pkpu49), ''),IF (le.pkpu50 <> 0,TRIM((SALT311.StrType)le.pkpu50), ''),IF (le.pkpu51 <> 0,TRIM((SALT311.StrType)le.pkpu51), ''),IF (le.pkpu52 <> 0,TRIM((SALT311.StrType)le.pkpu52), ''),IF (le.pkpu53 <> 0,TRIM((SALT311.StrType)le.pkpu53), ''),IF (le.pkpu54 <> 0,TRIM((SALT311.StrType)le.pkpu54), ''),IF (le.pkpu55 <> 0,TRIM((SALT311.StrType)le.pkpu55), ''),IF (le.pkpu56 <> 0,TRIM((SALT311.StrType)le.pkpu56), ''),IF (le.pkpu57 <> 0,TRIM((SALT311.StrType)le.pkpu57), ''),IF (le.pkpu60 <> 0,TRIM((SALT311.StrType)le.pkpu60), ''),IF (le.pkpu61 <> 0,TRIM((SALT311.StrType)le.pkpu61), ''),IF (le.pkpu62 <> 0,TRIM((SALT311.StrType)le.pkpu62), ''),IF (le.pkpu63 <> 0,TRIM((SALT311.StrType)le.pkpu63), ''),IF (le.pkpu64 <> 0,TRIM((SALT311.StrType)le.pkpu64), ''),IF (le.pkpu65 <> 0,TRIM((SALT311.StrType)le.pkpu65), ''),IF (le.pkpu66 <> 0,TRIM((SALT311.StrType)le.pkpu66), ''),IF (le.pkpu67 <> 0,TRIM((SALT311.StrType)le.pkpu67), ''),IF (le.pkpu68 <> 0,TRIM((SALT311.StrType)le.pkpu68), ''),IF (le.pkpu69 <> 0,TRIM((SALT311.StrType)le.pkpu69), ''),IF (le.pkpu70 <> 0,TRIM((SALT311.StrType)le.pkpu70), ''),IF (le.censpct_water <> 0,TRIM((SALT311.StrType)le.censpct_water), ''),IF (le.cens_pop_density <> 0,TRIM((SALT311.StrType)le.cens_pop_density), ''),IF (le.cens_hu_density <> 0,TRIM((SALT311.StrType)le.cens_hu_density), ''),IF (le.censpct_pop_white <> 0,TRIM((SALT311.StrType)le.censpct_pop_white), ''),IF (le.censpct_pop_black <> 0,TRIM((SALT311.StrType)le.censpct_pop_black), ''),IF (le.censpct_pop_amerind <> 0,TRIM((SALT311.StrType)le.censpct_pop_amerind), ''),IF (le.censpct_pop_asian <> 0,TRIM((SALT311.StrType)le.censpct_pop_asian), ''),IF (le.censpct_pop_pacisl <> 0,TRIM((SALT311.StrType)le.censpct_pop_pacisl), ''),IF (le.censpct_pop_othrace <> 0,TRIM((SALT311.StrType)le.censpct_pop_othrace), ''),IF (le.censpct_pop_multirace <> 0,TRIM((SALT311.StrType)le.censpct_pop_multirace), ''),IF (le.censpct_pop_hispanic <> 0,TRIM((SALT311.StrType)le.censpct_pop_hispanic), ''),IF (le.censpct_pop_agelt18 <> 0,TRIM((SALT311.StrType)le.censpct_pop_agelt18), ''),IF (le.censpct_pop_males <> 0,TRIM((SALT311.StrType)le.censpct_pop_males), ''),IF (le.censpct_adult_age1824 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age1824), ''),IF (le.censpct_adult_age2534 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age2534), ''),IF (le.censpct_adult_age3544 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age3544), ''),IF (le.censpct_adult_age4554 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age4554), ''),IF (le.censpct_adult_age5564 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age5564), ''),IF (le.censpct_adult_agege65 <> 0,TRIM((SALT311.StrType)le.censpct_adult_agege65), ''),IF (le.cens_pop_medage <> 0,TRIM((SALT311.StrType)le.cens_pop_medage), ''),IF (le.cens_hh_avgsize <> 0,TRIM((SALT311.StrType)le.cens_hh_avgsize), ''),IF (le.censpct_hh_family <> 0,TRIM((SALT311.StrType)le.censpct_hh_family), ''),IF (le.censpct_hh_family_husbwife <> 0,TRIM((SALT311.StrType)le.censpct_hh_family_husbwife), ''),IF (le.censpct_hu_occupied <> 0,TRIM((SALT311.StrType)le.censpct_hu_occupied), ''),IF (le.censpct_hu_owned <> 0,TRIM((SALT311.StrType)le.censpct_hu_owned), ''),IF (le.censpct_hu_rented <> 0,TRIM((SALT311.StrType)le.censpct_hu_rented), ''),IF (le.censpct_hu_vacantseasonal <> 0,TRIM((SALT311.StrType)le.censpct_hu_vacantseasonal), ''),IF (le.zip_medinc <> 0,TRIM((SALT311.StrType)le.zip_medinc), ''),IF (le.zip_apparel <> 0,TRIM((SALT311.StrType)le.zip_apparel), ''),IF (le.zip_apparel_women <> 0,TRIM((SALT311.StrType)le.zip_apparel_women), ''),IF (le.zip_apparel_womfash <> 0,TRIM((SALT311.StrType)le.zip_apparel_womfash), ''),IF (le.zip_auto <> 0,TRIM((SALT311.StrType)le.zip_auto), ''),IF (le.zip_beauty <> 0,TRIM((SALT311.StrType)le.zip_beauty), ''),IF (le.zip_booksmusicmovies <> 0,TRIM((SALT311.StrType)le.zip_booksmusicmovies), ''),IF (le.zip_business <> 0,TRIM((SALT311.StrType)le.zip_business), ''),IF (le.zip_catalog <> 0,TRIM((SALT311.StrType)le.zip_catalog), ''),IF (le.zip_cc <> 0,TRIM((SALT311.StrType)le.zip_cc), ''),IF (le.zip_collectibles <> 0,TRIM((SALT311.StrType)le.zip_collectibles), ''),IF (le.zip_computers <> 0,TRIM((SALT311.StrType)le.zip_computers), ''),IF (le.zip_continuity <> 0,TRIM((SALT311.StrType)le.zip_continuity), ''),IF (le.zip_cooking <> 0,TRIM((SALT311.StrType)le.zip_cooking), ''),IF (le.zip_crafts <> 0,TRIM((SALT311.StrType)le.zip_crafts), ''),IF (le.zip_culturearts <> 0,TRIM((SALT311.StrType)le.zip_culturearts), ''),IF (le.zip_dm_sold <> 0,TRIM((SALT311.StrType)le.zip_dm_sold), ''),IF (le.zip_donor <> 0,TRIM((SALT311.StrType)le.zip_donor), ''),IF (le.zip_family <> 0,TRIM((SALT311.StrType)le.zip_family), ''),IF (le.zip_gardening <> 0,TRIM((SALT311.StrType)le.zip_gardening), ''),IF (le.zip_giftgivr <> 0,TRIM((SALT311.StrType)le.zip_giftgivr), ''),IF (le.zip_gourmet <> 0,TRIM((SALT311.StrType)le.zip_gourmet), ''),IF (le.zip_health <> 0,TRIM((SALT311.StrType)le.zip_health), ''),IF (le.zip_health_diet <> 0,TRIM((SALT311.StrType)le.zip_health_diet), ''),IF (le.zip_health_fitness <> 0,TRIM((SALT311.StrType)le.zip_health_fitness), ''),IF (le.zip_hobbies <> 0,TRIM((SALT311.StrType)le.zip_hobbies), ''),IF (le.zip_homedecr <> 0,TRIM((SALT311.StrType)le.zip_homedecr), ''),IF (le.zip_homeliv <> 0,TRIM((SALT311.StrType)le.zip_homeliv), ''),IF (le.zip_internet <> 0,TRIM((SALT311.StrType)le.zip_internet), ''),IF (le.zip_internet_access <> 0,TRIM((SALT311.StrType)le.zip_internet_access), ''),IF (le.zip_internet_buy <> 0,TRIM((SALT311.StrType)le.zip_internet_buy), ''),IF (le.zip_music <> 0,TRIM((SALT311.StrType)le.zip_music), ''),IF (le.zip_outdoors <> 0,TRIM((SALT311.StrType)le.zip_outdoors), ''),IF (le.zip_pets <> 0,TRIM((SALT311.StrType)le.zip_pets), ''),IF (le.zip_pfin <> 0,TRIM((SALT311.StrType)le.zip_pfin), ''),IF (le.zip_publish <> 0,TRIM((SALT311.StrType)le.zip_publish), ''),IF (le.zip_publish_books <> 0,TRIM((SALT311.StrType)le.zip_publish_books), ''),IF (le.zip_publish_mags <> 0,TRIM((SALT311.StrType)le.zip_publish_mags), ''),IF (le.zip_sports <> 0,TRIM((SALT311.StrType)le.zip_sports), ''),IF (le.zip_sports_biking <> 0,TRIM((SALT311.StrType)le.zip_sports_biking), ''),IF (le.zip_sports_golf <> 0,TRIM((SALT311.StrType)le.zip_sports_golf), ''),IF (le.zip_travel <> 0,TRIM((SALT311.StrType)le.zip_travel), ''),IF (le.zip_travel_us <> 0,TRIM((SALT311.StrType)le.zip_travel_us), ''),IF (le.zip_tvmovies <> 0,TRIM((SALT311.StrType)le.zip_tvmovies), ''),IF (le.zip_woman <> 0,TRIM((SALT311.StrType)le.zip_woman), ''),IF (le.zip_proftech <> 0,TRIM((SALT311.StrType)le.zip_proftech), ''),IF (le.zip_retired <> 0,TRIM((SALT311.StrType)le.zip_retired), ''),IF (le.zip_inc100 <> 0,TRIM((SALT311.StrType)le.zip_inc100), ''),IF (le.zip_inc75 <> 0,TRIM((SALT311.StrType)le.zip_inc75), ''),IF (le.zip_inc50 <> 0,TRIM((SALT311.StrType)le.zip_inc50), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dtmatch),TRIM((SALT311.StrType)le.msname),TRIM((SALT311.StrType)le.msaddr1),TRIM((SALT311.StrType)le.msaddr2),TRIM((SALT311.StrType)le.mscity),TRIM((SALT311.StrType)le.msstate),TRIM((SALT311.StrType)le.mszip5),TRIM((SALT311.StrType)le.mszip4),TRIM((SALT311.StrType)le.dthh),TRIM((SALT311.StrType)le.mscrrt),TRIM((SALT311.StrType)le.msdpbc),TRIM((SALT311.StrType)le.msdpv),TRIM((SALT311.StrType)le.ms_addrtype),TRIM((SALT311.StrType)le.ctysize),IF (le.lmos <> 0,TRIM((SALT311.StrType)le.lmos), ''),IF (le.omos <> 0,TRIM((SALT311.StrType)le.omos), ''),IF (le.pmos <> 0,TRIM((SALT311.StrType)le.pmos), ''),TRIM((SALT311.StrType)le.gen),TRIM((SALT311.StrType)le.dob),IF (le.age <> 0,TRIM((SALT311.StrType)le.age), ''),TRIM((SALT311.StrType)le.inc),TRIM((SALT311.StrType)le.marital_status),TRIM((SALT311.StrType)le.poc),TRIM((SALT311.StrType)le.noc),TRIM((SALT311.StrType)le.ocp),TRIM((SALT311.StrType)le.edu),TRIM((SALT311.StrType)le.lang),TRIM((SALT311.StrType)le.relig),TRIM((SALT311.StrType)le.dwell),TRIM((SALT311.StrType)le.ownr),TRIM((SALT311.StrType)le.eth1),TRIM((SALT311.StrType)le.eth2),TRIM((SALT311.StrType)le.lor),TRIM((SALT311.StrType)le.pool),TRIM((SALT311.StrType)le.speak_span),TRIM((SALT311.StrType)le.soho),TRIM((SALT311.StrType)le.vet_in_hh),IF (le.ms_mags <> 0,TRIM((SALT311.StrType)le.ms_mags), ''),IF (le.ms_books <> 0,TRIM((SALT311.StrType)le.ms_books), ''),IF (le.ms_publish <> 0,TRIM((SALT311.StrType)le.ms_publish), ''),IF (le.ms_pub_status_active <> 0,TRIM((SALT311.StrType)le.ms_pub_status_active), ''),IF (le.ms_pub_status_expire <> 0,TRIM((SALT311.StrType)le.ms_pub_status_expire), ''),IF (le.ms_pub_premsold <> 0,TRIM((SALT311.StrType)le.ms_pub_premsold), ''),IF (le.ms_pub_autornwl <> 0,TRIM((SALT311.StrType)le.ms_pub_autornwl), ''),IF (le.ms_pub_avgterm <> 0,TRIM((SALT311.StrType)le.ms_pub_avgterm), ''),IF (le.ms_pub_lmos <> 0,TRIM((SALT311.StrType)le.ms_pub_lmos), ''),IF (le.ms_pub_omos <> 0,TRIM((SALT311.StrType)le.ms_pub_omos), ''),IF (le.ms_pub_pmos <> 0,TRIM((SALT311.StrType)le.ms_pub_pmos), ''),IF (le.ms_pub_cemos <> 0,TRIM((SALT311.StrType)le.ms_pub_cemos), ''),IF (le.ms_pub_femos <> 0,TRIM((SALT311.StrType)le.ms_pub_femos), ''),IF (le.ms_pub_totords <> 0,TRIM((SALT311.StrType)le.ms_pub_totords), ''),IF (le.ms_pub_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_pub_totdlrs), ''),IF (le.ms_pub_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_pub_avgdlrs), ''),IF (le.ms_pub_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_pub_lastdlrs), ''),IF (le.ms_pub_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_pub_paystat_paid), ''),IF (le.ms_pub_paystat_ub <> 0,TRIM((SALT311.StrType)le.ms_pub_paystat_ub), ''),IF (le.ms_pub_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_pub_paymeth_cc), ''),IF (le.ms_pub_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_pub_paymeth_cash), ''),IF (le.ms_pub_payspeed <> 0,TRIM((SALT311.StrType)le.ms_pub_payspeed), ''),IF (le.ms_pub_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_dm), ''),IF (le.ms_pub_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_dm), ''),IF (le.ms_pub_osrc_agt_cashf <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_cashf), ''),IF (le.ms_pub_lsrc_agt_cashf <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_cashf), ''),IF (le.ms_pub_osrc_agt_pds <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_pds), ''),IF (le.ms_pub_lsrc_agt_pds <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_pds), ''),IF (le.ms_pub_osrc_agt_schplan <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_schplan), ''),IF (le.ms_pub_lsrc_agt_schplan <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_schplan), ''),IF (le.ms_pub_osrc_agt_sponsor <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_sponsor), ''),IF (le.ms_pub_lsrc_agt_sponsor <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_sponsor), ''),IF (le.ms_pub_osrc_agt_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt_tm), ''),IF (le.ms_pub_lsrc_agt_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt_tm), ''),IF (le.ms_pub_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_agt), ''),IF (le.ms_pub_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_agt), ''),IF (le.ms_pub_osrc_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_tm), ''),IF (le.ms_pub_lsrc_tm <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_tm), ''),IF (le.ms_pub_osrc_ins <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_ins), ''),IF (le.ms_pub_lsrc_ins <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_ins), ''),IF (le.ms_pub_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_net), ''),IF (le.ms_pub_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_net), ''),IF (le.ms_pub_osrc_print <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_print), ''),IF (le.ms_pub_lsrc_print <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_print), ''),IF (le.ms_pub_osrc_trans <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_trans), ''),IF (le.ms_pub_lsrc_trans <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_trans), ''),IF (le.ms_pub_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_tv), ''),IF (le.ms_pub_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_tv), ''),IF (le.ms_pub_osrc_dtp <> 0,TRIM((SALT311.StrType)le.ms_pub_osrc_dtp), ''),IF (le.ms_pub_lsrc_dtp <> 0,TRIM((SALT311.StrType)le.ms_pub_lsrc_dtp), ''),IF (le.ms_pub_giftgivr <> 0,TRIM((SALT311.StrType)le.ms_pub_giftgivr), ''),IF (le.ms_pub_giftee <> 0,TRIM((SALT311.StrType)le.ms_pub_giftee), ''),IF (le.ms_catalog <> 0,TRIM((SALT311.StrType)le.ms_catalog), ''),IF (le.ms_cat_lmos <> 0,TRIM((SALT311.StrType)le.ms_cat_lmos), ''),IF (le.ms_cat_omos <> 0,TRIM((SALT311.StrType)le.ms_cat_omos), ''),IF (le.ms_cat_pmos <> 0,TRIM((SALT311.StrType)le.ms_cat_pmos), ''),IF (le.ms_cat_totords <> 0,TRIM((SALT311.StrType)le.ms_cat_totords), ''),IF (le.ms_cat_totitems <> 0,TRIM((SALT311.StrType)le.ms_cat_totitems), ''),IF (le.ms_cat_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_cat_totdlrs), ''),IF (le.ms_cat_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_cat_avgdlrs), ''),IF (le.ms_cat_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_cat_lastdlrs), ''),IF (le.ms_cat_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_cat_paystat_paid), ''),IF (le.ms_cat_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_cat_paymeth_cc), ''),IF (le.ms_cat_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_cat_paymeth_cash), ''),IF (le.ms_cat_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_cat_osrc_dm), ''),IF (le.ms_cat_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_cat_lsrc_dm), ''),IF (le.ms_cat_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_cat_osrc_net), ''),IF (le.ms_cat_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_cat_lsrc_net), ''),IF (le.ms_cat_giftgivr <> 0,TRIM((SALT311.StrType)le.ms_cat_giftgivr), ''),IF (le.pkpubs_corrected <> 0,TRIM((SALT311.StrType)le.pkpubs_corrected), ''),IF (le.pkcatg_corrected <> 0,TRIM((SALT311.StrType)le.pkcatg_corrected), ''),IF (le.ms_fundraising <> 0,TRIM((SALT311.StrType)le.ms_fundraising), ''),IF (le.ms_fund_lmos <> 0,TRIM((SALT311.StrType)le.ms_fund_lmos), ''),IF (le.ms_fund_omos <> 0,TRIM((SALT311.StrType)le.ms_fund_omos), ''),IF (le.ms_fund_pmos <> 0,TRIM((SALT311.StrType)le.ms_fund_pmos), ''),IF (le.ms_fund_totords <> 0,TRIM((SALT311.StrType)le.ms_fund_totords), ''),IF (le.ms_fund_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_fund_totdlrs), ''),IF (le.ms_fund_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_fund_avgdlrs), ''),IF (le.ms_fund_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_fund_lastdlrs), ''),IF (le.ms_fund_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_fund_paystat_paid), ''),IF (le.ms_other <> 0,TRIM((SALT311.StrType)le.ms_other), ''),IF (le.ms_continuity <> 0,TRIM((SALT311.StrType)le.ms_continuity), ''),IF (le.ms_cont_status_active <> 0,TRIM((SALT311.StrType)le.ms_cont_status_active), ''),IF (le.ms_cont_status_cancel <> 0,TRIM((SALT311.StrType)le.ms_cont_status_cancel), ''),IF (le.ms_cont_omos <> 0,TRIM((SALT311.StrType)le.ms_cont_omos), ''),IF (le.ms_cont_lmos <> 0,TRIM((SALT311.StrType)le.ms_cont_lmos), ''),IF (le.ms_cont_pmos <> 0,TRIM((SALT311.StrType)le.ms_cont_pmos), ''),IF (le.ms_cont_totords <> 0,TRIM((SALT311.StrType)le.ms_cont_totords), ''),IF (le.ms_cont_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_cont_totdlrs), ''),IF (le.ms_cont_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_cont_avgdlrs), ''),IF (le.ms_cont_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_cont_lastdlrs), ''),IF (le.ms_cont_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_cont_paystat_paid), ''),IF (le.ms_cont_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_cont_paymeth_cc), ''),IF (le.ms_cont_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_cont_paymeth_cash), ''),IF (le.ms_totords <> 0,TRIM((SALT311.StrType)le.ms_totords), ''),IF (le.ms_totitems <> 0,TRIM((SALT311.StrType)le.ms_totitems), ''),IF (le.ms_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_totdlrs), ''),IF (le.ms_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_avgdlrs), ''),IF (le.ms_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_lastdlrs), ''),IF (le.ms_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_paystat_paid), ''),IF (le.ms_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_paymeth_cc), ''),IF (le.ms_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_paymeth_cash), ''),IF (le.ms_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_osrc_dm), ''),IF (le.ms_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_lsrc_dm), ''),IF (le.ms_osrc_tm <> 0,TRIM((SALT311.StrType)le.ms_osrc_tm), ''),IF (le.ms_lsrc_tm <> 0,TRIM((SALT311.StrType)le.ms_lsrc_tm), ''),IF (le.ms_osrc_ins <> 0,TRIM((SALT311.StrType)le.ms_osrc_ins), ''),IF (le.ms_lsrc_ins <> 0,TRIM((SALT311.StrType)le.ms_lsrc_ins), ''),IF (le.ms_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_osrc_net), ''),IF (le.ms_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_lsrc_net), ''),IF (le.ms_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_osrc_tv), ''),IF (le.ms_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_lsrc_tv), ''),IF (le.ms_osrc_retail <> 0,TRIM((SALT311.StrType)le.ms_osrc_retail), ''),IF (le.ms_lsrc_retail <> 0,TRIM((SALT311.StrType)le.ms_lsrc_retail), ''),IF (le.ms_giftgivr <> 0,TRIM((SALT311.StrType)le.ms_giftgivr), ''),IF (le.ms_giftee <> 0,TRIM((SALT311.StrType)le.ms_giftee), ''),IF (le.ms_adult <> 0,TRIM((SALT311.StrType)le.ms_adult), ''),IF (le.ms_womapp <> 0,TRIM((SALT311.StrType)le.ms_womapp), ''),IF (le.ms_menapp <> 0,TRIM((SALT311.StrType)le.ms_menapp), ''),IF (le.ms_kidapp <> 0,TRIM((SALT311.StrType)le.ms_kidapp), ''),IF (le.ms_accessory <> 0,TRIM((SALT311.StrType)le.ms_accessory), ''),IF (le.ms_apparel <> 0,TRIM((SALT311.StrType)le.ms_apparel), ''),IF (le.ms_app_lmos <> 0,TRIM((SALT311.StrType)le.ms_app_lmos), ''),IF (le.ms_app_omos <> 0,TRIM((SALT311.StrType)le.ms_app_omos), ''),IF (le.ms_app_pmos <> 0,TRIM((SALT311.StrType)le.ms_app_pmos), ''),IF (le.ms_app_totords <> 0,TRIM((SALT311.StrType)le.ms_app_totords), ''),IF (le.ms_app_totitems <> 0,TRIM((SALT311.StrType)le.ms_app_totitems), ''),IF (le.ms_app_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_app_totdlrs), ''),IF (le.ms_app_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_app_avgdlrs), ''),IF (le.ms_app_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_app_lastdlrs), ''),IF (le.ms_app_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_app_paystat_paid), ''),IF (le.ms_app_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_app_paymeth_cc), ''),IF (le.ms_app_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_app_paymeth_cash), ''),IF (le.ms_menfash <> 0,TRIM((SALT311.StrType)le.ms_menfash), ''),IF (le.ms_womfash <> 0,TRIM((SALT311.StrType)le.ms_womfash), ''),IF (le.ms_wfsh_lmos <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lmos), ''),IF (le.ms_wfsh_omos <> 0,TRIM((SALT311.StrType)le.ms_wfsh_omos), ''),IF (le.ms_wfsh_pmos <> 0,TRIM((SALT311.StrType)le.ms_wfsh_pmos), ''),IF (le.ms_wfsh_totords <> 0,TRIM((SALT311.StrType)le.ms_wfsh_totords), ''),IF (le.ms_wfsh_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_wfsh_totdlrs), ''),IF (le.ms_wfsh_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_wfsh_avgdlrs), ''),IF (le.ms_wfsh_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lastdlrs), ''),IF (le.ms_wfsh_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_wfsh_paystat_paid), ''),IF (le.ms_wfsh_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_wfsh_osrc_dm), ''),IF (le.ms_wfsh_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lsrc_dm), ''),IF (le.ms_wfsh_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_wfsh_osrc_agt), ''),IF (le.ms_wfsh_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_wfsh_lsrc_agt), ''),IF (le.ms_audio <> 0,TRIM((SALT311.StrType)le.ms_audio), ''),IF (le.ms_auto <> 0,TRIM((SALT311.StrType)le.ms_auto), ''),IF (le.ms_aviation <> 0,TRIM((SALT311.StrType)le.ms_aviation), ''),IF (le.ms_bargains <> 0,TRIM((SALT311.StrType)le.ms_bargains), ''),IF (le.ms_beauty <> 0,TRIM((SALT311.StrType)le.ms_beauty), ''),IF (le.ms_bible <> 0,TRIM((SALT311.StrType)le.ms_bible), ''),IF (le.ms_bible_lmos <> 0,TRIM((SALT311.StrType)le.ms_bible_lmos), ''),IF (le.ms_bible_omos <> 0,TRIM((SALT311.StrType)le.ms_bible_omos), ''),IF (le.ms_bible_pmos <> 0,TRIM((SALT311.StrType)le.ms_bible_pmos), ''),IF (le.ms_bible_totords <> 0,TRIM((SALT311.StrType)le.ms_bible_totords), ''),IF (le.ms_bible_totitems <> 0,TRIM((SALT311.StrType)le.ms_bible_totitems), ''),IF (le.ms_bible_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_bible_totdlrs), ''),IF (le.ms_bible_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_bible_avgdlrs), ''),IF (le.ms_bible_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_bible_lastdlrs), ''),IF (le.ms_bible_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_bible_paystat_paid), ''),IF (le.ms_bible_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_bible_paymeth_cc), ''),IF (le.ms_bible_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_bible_paymeth_cash), ''),IF (le.ms_business <> 0,TRIM((SALT311.StrType)le.ms_business), ''),IF (le.ms_collectibles <> 0,TRIM((SALT311.StrType)le.ms_collectibles), ''),IF (le.ms_computers <> 0,TRIM((SALT311.StrType)le.ms_computers), ''),IF (le.ms_crafts <> 0,TRIM((SALT311.StrType)le.ms_crafts), ''),IF (le.ms_culturearts <> 0,TRIM((SALT311.StrType)le.ms_culturearts), ''),IF (le.ms_currevent <> 0,TRIM((SALT311.StrType)le.ms_currevent), ''),IF (le.ms_diy <> 0,TRIM((SALT311.StrType)le.ms_diy), ''),IF (le.ms_electronics <> 0,TRIM((SALT311.StrType)le.ms_electronics), ''),IF (le.ms_equestrian <> 0,TRIM((SALT311.StrType)le.ms_equestrian), ''),IF (le.ms_pub_family <> 0,TRIM((SALT311.StrType)le.ms_pub_family), ''),IF (le.ms_cat_family <> 0,TRIM((SALT311.StrType)le.ms_cat_family), ''),IF (le.ms_family <> 0,TRIM((SALT311.StrType)le.ms_family), ''),IF (le.ms_family_lmos <> 0,TRIM((SALT311.StrType)le.ms_family_lmos), ''),IF (le.ms_family_omos <> 0,TRIM((SALT311.StrType)le.ms_family_omos), ''),IF (le.ms_family_pmos <> 0,TRIM((SALT311.StrType)le.ms_family_pmos), ''),IF (le.ms_family_totords <> 0,TRIM((SALT311.StrType)le.ms_family_totords), ''),IF (le.ms_family_totitems <> 0,TRIM((SALT311.StrType)le.ms_family_totitems), ''),IF (le.ms_family_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_family_totdlrs), ''),IF (le.ms_family_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_family_avgdlrs), ''),IF (le.ms_family_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_family_lastdlrs), ''),IF (le.ms_family_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_family_paystat_paid), ''),IF (le.ms_family_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_family_paymeth_cc), ''),IF (le.ms_family_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_family_paymeth_cash), ''),IF (le.ms_family_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_family_osrc_dm), ''),IF (le.ms_family_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_family_lsrc_dm), ''),IF (le.ms_fiction <> 0,TRIM((SALT311.StrType)le.ms_fiction), ''),IF (le.ms_food <> 0,TRIM((SALT311.StrType)le.ms_food), ''),IF (le.ms_games <> 0,TRIM((SALT311.StrType)le.ms_games), ''),IF (le.ms_gifts <> 0,TRIM((SALT311.StrType)le.ms_gifts), ''),IF (le.ms_gourmet <> 0,TRIM((SALT311.StrType)le.ms_gourmet), ''),IF (le.ms_fitness <> 0,TRIM((SALT311.StrType)le.ms_fitness), ''),IF (le.ms_health <> 0,TRIM((SALT311.StrType)le.ms_health), ''),IF (le.ms_hlth_lmos <> 0,TRIM((SALT311.StrType)le.ms_hlth_lmos), ''),IF (le.ms_hlth_omos <> 0,TRIM((SALT311.StrType)le.ms_hlth_omos), ''),IF (le.ms_hlth_pmos <> 0,TRIM((SALT311.StrType)le.ms_hlth_pmos), ''),IF (le.ms_hlth_totords <> 0,TRIM((SALT311.StrType)le.ms_hlth_totords), ''),IF (le.ms_hlth_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_hlth_totdlrs), ''),IF (le.ms_hlth_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_hlth_avgdlrs), ''),IF (le.ms_hlth_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_hlth_lastdlrs), ''),IF (le.ms_hlth_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_hlth_paystat_paid), ''),IF (le.ms_hlth_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_hlth_paymeth_cc), ''),IF (le.ms_hlth_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_hlth_osrc_dm), ''),IF (le.ms_hlth_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_hlth_lsrc_dm), ''),IF (le.ms_hlth_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_hlth_osrc_agt), ''),IF (le.ms_hlth_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_hlth_lsrc_agt), ''),IF (le.ms_hlth_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_hlth_osrc_tv), ''),IF (le.ms_hlth_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_hlth_lsrc_tv), ''),IF (le.ms_holiday <> 0,TRIM((SALT311.StrType)le.ms_holiday), ''),IF (le.ms_history <> 0,TRIM((SALT311.StrType)le.ms_history), ''),IF (le.ms_pub_cooking <> 0,TRIM((SALT311.StrType)le.ms_pub_cooking), ''),IF (le.ms_cooking <> 0,TRIM((SALT311.StrType)le.ms_cooking), ''),IF (le.ms_pub_homedecr <> 0,TRIM((SALT311.StrType)le.ms_pub_homedecr), ''),IF (le.ms_cat_homedecr <> 0,TRIM((SALT311.StrType)le.ms_cat_homedecr), ''),IF (le.ms_homedecr <> 0,TRIM((SALT311.StrType)le.ms_homedecr), ''),IF (le.ms_housewares <> 0,TRIM((SALT311.StrType)le.ms_housewares), ''),IF (le.ms_pub_garden <> 0,TRIM((SALT311.StrType)le.ms_pub_garden), ''),IF (le.ms_cat_garden <> 0,TRIM((SALT311.StrType)le.ms_cat_garden), ''),IF (le.ms_garden <> 0,TRIM((SALT311.StrType)le.ms_garden), ''),IF (le.ms_pub_homeliv <> 0,TRIM((SALT311.StrType)le.ms_pub_homeliv), ''),IF (le.ms_cat_homeliv <> 0,TRIM((SALT311.StrType)le.ms_cat_homeliv), ''),IF (le.ms_homeliv <> 0,TRIM((SALT311.StrType)le.ms_homeliv), ''),IF (le.ms_pub_home_status_active <> 0,TRIM((SALT311.StrType)le.ms_pub_home_status_active), ''),IF (le.ms_home_lmos <> 0,TRIM((SALT311.StrType)le.ms_home_lmos), ''),IF (le.ms_home_omos <> 0,TRIM((SALT311.StrType)le.ms_home_omos), ''),IF (le.ms_home_pmos <> 0,TRIM((SALT311.StrType)le.ms_home_pmos), ''),IF (le.ms_home_totords <> 0,TRIM((SALT311.StrType)le.ms_home_totords), ''),IF (le.ms_home_totitems <> 0,TRIM((SALT311.StrType)le.ms_home_totitems), ''),IF (le.ms_home_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_home_totdlrs), ''),IF (le.ms_home_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_home_avgdlrs), ''),IF (le.ms_home_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_home_lastdlrs), ''),IF (le.ms_home_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_home_paystat_paid), ''),IF (le.ms_home_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_home_paymeth_cc), ''),IF (le.ms_home_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_home_paymeth_cash), ''),IF (le.ms_home_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_dm), ''),IF (le.ms_home_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_dm), ''),IF (le.ms_home_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_agt), ''),IF (le.ms_home_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_agt), ''),IF (le.ms_home_osrc_net <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_net), ''),IF (le.ms_home_lsrc_net <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_net), ''),IF (le.ms_home_osrc_tv <> 0,TRIM((SALT311.StrType)le.ms_home_osrc_tv), ''),IF (le.ms_home_lsrc_tv <> 0,TRIM((SALT311.StrType)le.ms_home_lsrc_tv), ''),IF (le.ms_humor <> 0,TRIM((SALT311.StrType)le.ms_humor), ''),IF (le.ms_inspiration <> 0,TRIM((SALT311.StrType)le.ms_inspiration), ''),IF (le.ms_merchandise <> 0,TRIM((SALT311.StrType)le.ms_merchandise), ''),IF (le.ms_moneymaking <> 0,TRIM((SALT311.StrType)le.ms_moneymaking), ''),IF (le.ms_moneymaking_lmos <> 0,TRIM((SALT311.StrType)le.ms_moneymaking_lmos), ''),IF (le.ms_motorcycles <> 0,TRIM((SALT311.StrType)le.ms_motorcycles), ''),IF (le.ms_music <> 0,TRIM((SALT311.StrType)le.ms_music), ''),IF (le.ms_fishing <> 0,TRIM((SALT311.StrType)le.ms_fishing), ''),IF (le.ms_hunting <> 0,TRIM((SALT311.StrType)le.ms_hunting), ''),IF (le.ms_boatsail <> 0,TRIM((SALT311.StrType)le.ms_boatsail), ''),IF (le.ms_camp <> 0,TRIM((SALT311.StrType)le.ms_camp), ''),IF (le.ms_pub_outdoors <> 0,TRIM((SALT311.StrType)le.ms_pub_outdoors), ''),IF (le.ms_cat_outdoors <> 0,TRIM((SALT311.StrType)le.ms_cat_outdoors), ''),IF (le.ms_outdoors <> 0,TRIM((SALT311.StrType)le.ms_outdoors), ''),IF (le.ms_pub_out_status_active <> 0,TRIM((SALT311.StrType)le.ms_pub_out_status_active), ''),IF (le.ms_out_lmos <> 0,TRIM((SALT311.StrType)le.ms_out_lmos), ''),IF (le.ms_out_omos <> 0,TRIM((SALT311.StrType)le.ms_out_omos), ''),IF (le.ms_out_pmos <> 0,TRIM((SALT311.StrType)le.ms_out_pmos), ''),IF (le.ms_out_totords <> 0,TRIM((SALT311.StrType)le.ms_out_totords), ''),IF (le.ms_out_totitems <> 0,TRIM((SALT311.StrType)le.ms_out_totitems), ''),IF (le.ms_out_totdlrs <> 0,TRIM((SALT311.StrType)le.ms_out_totdlrs), ''),IF (le.ms_out_avgdlrs <> 0,TRIM((SALT311.StrType)le.ms_out_avgdlrs), ''),IF (le.ms_out_lastdlrs <> 0,TRIM((SALT311.StrType)le.ms_out_lastdlrs), ''),IF (le.ms_out_paystat_paid <> 0,TRIM((SALT311.StrType)le.ms_out_paystat_paid), ''),IF (le.ms_out_paymeth_cc <> 0,TRIM((SALT311.StrType)le.ms_out_paymeth_cc), ''),IF (le.ms_out_paymeth_cash <> 0,TRIM((SALT311.StrType)le.ms_out_paymeth_cash), ''),IF (le.ms_out_osrc_dm <> 0,TRIM((SALT311.StrType)le.ms_out_osrc_dm), ''),IF (le.ms_out_lsrc_dm <> 0,TRIM((SALT311.StrType)le.ms_out_lsrc_dm), ''),IF (le.ms_out_osrc_agt <> 0,TRIM((SALT311.StrType)le.ms_out_osrc_agt), ''),IF (le.ms_out_lsrc_agt <> 0,TRIM((SALT311.StrType)le.ms_out_lsrc_agt), ''),IF (le.ms_pets <> 0,TRIM((SALT311.StrType)le.ms_pets), ''),IF (le.ms_pfin <> 0,TRIM((SALT311.StrType)le.ms_pfin), ''),IF (le.ms_photo <> 0,TRIM((SALT311.StrType)le.ms_photo), ''),IF (le.ms_photoproc <> 0,TRIM((SALT311.StrType)le.ms_photoproc), ''),IF (le.ms_rural <> 0,TRIM((SALT311.StrType)le.ms_rural), ''),IF (le.ms_science <> 0,TRIM((SALT311.StrType)le.ms_science), ''),IF (le.ms_sports <> 0,TRIM((SALT311.StrType)le.ms_sports), ''),IF (le.ms_sports_lmos <> 0,TRIM((SALT311.StrType)le.ms_sports_lmos), ''),IF (le.ms_travel <> 0,TRIM((SALT311.StrType)le.ms_travel), ''),IF (le.ms_tvmovies <> 0,TRIM((SALT311.StrType)le.ms_tvmovies), ''),IF (le.ms_wildlife <> 0,TRIM((SALT311.StrType)le.ms_wildlife), ''),IF (le.ms_woman <> 0,TRIM((SALT311.StrType)le.ms_woman), ''),IF (le.ms_woman_lmos <> 0,TRIM((SALT311.StrType)le.ms_woman_lmos), ''),IF (le.ms_ringtones_apps <> 0,TRIM((SALT311.StrType)le.ms_ringtones_apps), ''),IF (le.cpi_mobile_apps_index <> 0,TRIM((SALT311.StrType)le.cpi_mobile_apps_index), ''),IF (le.cpi_credit_repair_index <> 0,TRIM((SALT311.StrType)le.cpi_credit_repair_index), ''),IF (le.cpi_credit_report_index <> 0,TRIM((SALT311.StrType)le.cpi_credit_report_index), ''),IF (le.cpi_education_seekers_index <> 0,TRIM((SALT311.StrType)le.cpi_education_seekers_index), ''),IF (le.cpi_insurance_index <> 0,TRIM((SALT311.StrType)le.cpi_insurance_index), ''),IF (le.cpi_insurance_health_index <> 0,TRIM((SALT311.StrType)le.cpi_insurance_health_index), ''),IF (le.cpi_insurance_auto_index <> 0,TRIM((SALT311.StrType)le.cpi_insurance_auto_index), ''),IF (le.cpi_job_seekers_index <> 0,TRIM((SALT311.StrType)le.cpi_job_seekers_index), ''),IF (le.cpi_social_networking_index <> 0,TRIM((SALT311.StrType)le.cpi_social_networking_index), ''),IF (le.cpi_adult_index <> 0,TRIM((SALT311.StrType)le.cpi_adult_index), ''),IF (le.cpi_africanamerican_index <> 0,TRIM((SALT311.StrType)le.cpi_africanamerican_index), ''),IF (le.cpi_apparel_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_index), ''),IF (le.cpi_apparel_accessory_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_accessory_index), ''),IF (le.cpi_apparel_kids_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_kids_index), ''),IF (le.cpi_apparel_men_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_men_index), ''),IF (le.cpi_apparel_menfash_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_menfash_index), ''),IF (le.cpi_apparel_women_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_women_index), ''),IF (le.cpi_apparel_womfash_index <> 0,TRIM((SALT311.StrType)le.cpi_apparel_womfash_index), ''),IF (le.cpi_asian_index <> 0,TRIM((SALT311.StrType)le.cpi_asian_index), ''),IF (le.cpi_auto_index <> 0,TRIM((SALT311.StrType)le.cpi_auto_index), ''),IF (le.cpi_auto_racing_index <> 0,TRIM((SALT311.StrType)le.cpi_auto_racing_index), ''),IF (le.cpi_auto_trucks_index <> 0,TRIM((SALT311.StrType)le.cpi_auto_trucks_index), ''),IF (le.cpi_aviation_index <> 0,TRIM((SALT311.StrType)le.cpi_aviation_index), ''),IF (le.cpi_bargains_index <> 0,TRIM((SALT311.StrType)le.cpi_bargains_index), ''),IF (le.cpi_beauty_index <> 0,TRIM((SALT311.StrType)le.cpi_beauty_index), ''),IF (le.cpi_bible_index <> 0,TRIM((SALT311.StrType)le.cpi_bible_index), ''),IF (le.cpi_birds_index <> 0,TRIM((SALT311.StrType)le.cpi_birds_index), ''),IF (le.cpi_business_index <> 0,TRIM((SALT311.StrType)le.cpi_business_index), ''),IF (le.cpi_business_homeoffice_index <> 0,TRIM((SALT311.StrType)le.cpi_business_homeoffice_index), ''),IF (le.cpi_catalog_index <> 0,TRIM((SALT311.StrType)le.cpi_catalog_index), ''),IF (le.cpi_cc_index <> 0,TRIM((SALT311.StrType)le.cpi_cc_index), ''),IF (le.cpi_collectibles_index <> 0,TRIM((SALT311.StrType)le.cpi_collectibles_index), ''),IF (le.cpi_college_index <> 0,TRIM((SALT311.StrType)le.cpi_college_index), ''),IF (le.cpi_computers_index <> 0,TRIM((SALT311.StrType)le.cpi_computers_index), ''),IF (le.cpi_conservative_index <> 0,TRIM((SALT311.StrType)le.cpi_conservative_index), ''),IF (le.cpi_continuity_index <> 0,TRIM((SALT311.StrType)le.cpi_continuity_index), ''),IF (le.cpi_cooking_index <> 0,TRIM((SALT311.StrType)le.cpi_cooking_index), ''),IF (le.cpi_crafts_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_index), ''),IF (le.cpi_crafts_crochet_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_crochet_index), ''),IF (le.cpi_crafts_knit_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_knit_index), ''),IF (le.cpi_crafts_needlepoint_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_needlepoint_index), ''),IF (le.cpi_crafts_quilt_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_quilt_index), ''),IF (le.cpi_crafts_sew_index <> 0,TRIM((SALT311.StrType)le.cpi_crafts_sew_index), ''),IF (le.cpi_culturearts_index <> 0,TRIM((SALT311.StrType)le.cpi_culturearts_index), ''),IF (le.cpi_currevent_index <> 0,TRIM((SALT311.StrType)le.cpi_currevent_index), ''),IF (le.cpi_diy_index <> 0,TRIM((SALT311.StrType)le.cpi_diy_index), ''),IF (le.cpi_donor_index <> 0,TRIM((SALT311.StrType)le.cpi_donor_index), ''),IF (le.cpi_ego_index <> 0,TRIM((SALT311.StrType)le.cpi_ego_index), ''),IF (le.cpi_electronics_index <> 0,TRIM((SALT311.StrType)le.cpi_electronics_index), ''),IF (le.cpi_equestrian_index <> 0,TRIM((SALT311.StrType)le.cpi_equestrian_index), ''),IF (le.cpi_family_index <> 0,TRIM((SALT311.StrType)le.cpi_family_index), ''),IF (le.cpi_family_teen_index <> 0,TRIM((SALT311.StrType)le.cpi_family_teen_index), ''),IF (le.cpi_family_young_index <> 0,TRIM((SALT311.StrType)le.cpi_family_young_index), ''),IF (le.cpi_fiction_index <> 0,TRIM((SALT311.StrType)le.cpi_fiction_index), ''),IF (le.cpi_gambling_index <> 0,TRIM((SALT311.StrType)le.cpi_gambling_index), ''),IF (le.cpi_games_index <> 0,TRIM((SALT311.StrType)le.cpi_games_index), ''),IF (le.cpi_gardening_index <> 0,TRIM((SALT311.StrType)le.cpi_gardening_index), ''),IF (le.cpi_gay_index <> 0,TRIM((SALT311.StrType)le.cpi_gay_index), ''),IF (le.cpi_giftgivr_index <> 0,TRIM((SALT311.StrType)le.cpi_giftgivr_index), ''),IF (le.cpi_gourmet_index <> 0,TRIM((SALT311.StrType)le.cpi_gourmet_index), ''),IF (le.cpi_grandparents_index <> 0,TRIM((SALT311.StrType)le.cpi_grandparents_index), ''),IF (le.cpi_health_index <> 0,TRIM((SALT311.StrType)le.cpi_health_index), ''),IF (le.cpi_health_diet_index <> 0,TRIM((SALT311.StrType)le.cpi_health_diet_index), ''),IF (le.cpi_health_fitness_index <> 0,TRIM((SALT311.StrType)le.cpi_health_fitness_index), ''),IF (le.cpi_hightech_index <> 0,TRIM((SALT311.StrType)le.cpi_hightech_index), ''),IF (le.cpi_hispanic_index <> 0,TRIM((SALT311.StrType)le.cpi_hispanic_index), ''),IF (le.cpi_history_index <> 0,TRIM((SALT311.StrType)le.cpi_history_index), ''),IF (le.cpi_history_american_index <> 0,TRIM((SALT311.StrType)le.cpi_history_american_index), ''),IF (le.cpi_hobbies_index <> 0,TRIM((SALT311.StrType)le.cpi_hobbies_index), ''),IF (le.cpi_homedecr_index <> 0,TRIM((SALT311.StrType)le.cpi_homedecr_index), ''),IF (le.cpi_homeliv_index <> 0,TRIM((SALT311.StrType)le.cpi_homeliv_index), ''),IF (le.cpi_humor_index <> 0,TRIM((SALT311.StrType)le.cpi_humor_index), ''),IF (le.cpi_inspiration_index <> 0,TRIM((SALT311.StrType)le.cpi_inspiration_index), ''),IF (le.cpi_internet_index <> 0,TRIM((SALT311.StrType)le.cpi_internet_index), ''),IF (le.cpi_internet_access_index <> 0,TRIM((SALT311.StrType)le.cpi_internet_access_index), ''),IF (le.cpi_internet_buy_index <> 0,TRIM((SALT311.StrType)le.cpi_internet_buy_index), ''),IF (le.cpi_liberal_index <> 0,TRIM((SALT311.StrType)le.cpi_liberal_index), ''),IF (le.cpi_moneymaking_index <> 0,TRIM((SALT311.StrType)le.cpi_moneymaking_index), ''),IF (le.cpi_motorcycles_index <> 0,TRIM((SALT311.StrType)le.cpi_motorcycles_index), ''),IF (le.cpi_music_index <> 0,TRIM((SALT311.StrType)le.cpi_music_index), ''),IF (le.cpi_nonfiction_index <> 0,TRIM((SALT311.StrType)le.cpi_nonfiction_index), ''),IF (le.cpi_ocean_index <> 0,TRIM((SALT311.StrType)le.cpi_ocean_index), ''),IF (le.cpi_outdoors_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_index), ''),IF (le.cpi_outdoors_boatsail_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_boatsail_index), ''),IF (le.cpi_outdoors_camp_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_camp_index), ''),IF (le.cpi_outdoors_fishing_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_fishing_index), ''),IF (le.cpi_outdoors_huntfish_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_huntfish_index), ''),IF (le.cpi_outdoors_hunting_index <> 0,TRIM((SALT311.StrType)le.cpi_outdoors_hunting_index), ''),IF (le.cpi_pets_index <> 0,TRIM((SALT311.StrType)le.cpi_pets_index), ''),IF (le.cpi_pets_cats_index <> 0,TRIM((SALT311.StrType)le.cpi_pets_cats_index), ''),IF (le.cpi_pets_dogs_index <> 0,TRIM((SALT311.StrType)le.cpi_pets_dogs_index), ''),IF (le.cpi_pfin_index <> 0,TRIM((SALT311.StrType)le.cpi_pfin_index), ''),IF (le.cpi_photog_index <> 0,TRIM((SALT311.StrType)le.cpi_photog_index), ''),IF (le.cpi_photoproc_index <> 0,TRIM((SALT311.StrType)le.cpi_photoproc_index), ''),IF (le.cpi_publish_index <> 0,TRIM((SALT311.StrType)le.cpi_publish_index), ''),IF (le.cpi_publish_books_index <> 0,TRIM((SALT311.StrType)le.cpi_publish_books_index), ''),IF (le.cpi_publish_mags_index <> 0,TRIM((SALT311.StrType)le.cpi_publish_mags_index), ''),IF (le.cpi_rural_index <> 0,TRIM((SALT311.StrType)le.cpi_rural_index), ''),IF (le.cpi_science_index <> 0,TRIM((SALT311.StrType)le.cpi_science_index), ''),IF (le.cpi_scifi_index <> 0,TRIM((SALT311.StrType)le.cpi_scifi_index), ''),IF (le.cpi_seniors_index <> 0,TRIM((SALT311.StrType)le.cpi_seniors_index), ''),IF (le.cpi_sports_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_index), ''),IF (le.cpi_sports_baseball_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_baseball_index), ''),IF (le.cpi_sports_basketball_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_basketball_index), ''),IF (le.cpi_sports_biking_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_biking_index), ''),IF (le.cpi_sports_football_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_football_index), ''),IF (le.cpi_sports_golf_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_golf_index), ''),IF (le.cpi_sports_hockey_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_hockey_index), ''),IF (le.cpi_sports_running_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_running_index), ''),IF (le.cpi_sports_ski_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_ski_index), ''),IF (le.cpi_sports_soccer_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_soccer_index), ''),IF (le.cpi_sports_swimming_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_swimming_index), ''),IF (le.cpi_sports_tennis_index <> 0,TRIM((SALT311.StrType)le.cpi_sports_tennis_index), ''),IF (le.cpi_stationery_index <> 0,TRIM((SALT311.StrType)le.cpi_stationery_index), ''),IF (le.cpi_sweeps_index <> 0,TRIM((SALT311.StrType)le.cpi_sweeps_index), ''),IF (le.cpi_tobacco_index <> 0,TRIM((SALT311.StrType)le.cpi_tobacco_index), ''),IF (le.cpi_travel_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_index), ''),IF (le.cpi_travel_cruise_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_cruise_index), ''),IF (le.cpi_travel_rv_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_rv_index), ''),IF (le.cpi_travel_us_index <> 0,TRIM((SALT311.StrType)le.cpi_travel_us_index), ''),IF (le.cpi_tvmovies_index <> 0,TRIM((SALT311.StrType)le.cpi_tvmovies_index), ''),IF (le.cpi_wildlife_index <> 0,TRIM((SALT311.StrType)le.cpi_wildlife_index), ''),IF (le.cpi_woman_index <> 0,TRIM((SALT311.StrType)le.cpi_woman_index), ''),IF (le.totdlr_index <> 0,TRIM((SALT311.StrType)le.totdlr_index), ''),IF (le.cpi_totdlr <> 0,TRIM((SALT311.StrType)le.cpi_totdlr), ''),IF (le.cpi_totords <> 0,TRIM((SALT311.StrType)le.cpi_totords), ''),IF (le.cpi_lastdlr <> 0,TRIM((SALT311.StrType)le.cpi_lastdlr), ''),IF (le.pkcatg <> 0,TRIM((SALT311.StrType)le.pkcatg), ''),IF (le.pkpubs <> 0,TRIM((SALT311.StrType)le.pkpubs), ''),IF (le.pkcont <> 0,TRIM((SALT311.StrType)le.pkcont), ''),IF (le.pkca01 <> 0,TRIM((SALT311.StrType)le.pkca01), ''),IF (le.pkca03 <> 0,TRIM((SALT311.StrType)le.pkca03), ''),IF (le.pkca04 <> 0,TRIM((SALT311.StrType)le.pkca04), ''),IF (le.pkca05 <> 0,TRIM((SALT311.StrType)le.pkca05), ''),IF (le.pkca06 <> 0,TRIM((SALT311.StrType)le.pkca06), ''),IF (le.pkca07 <> 0,TRIM((SALT311.StrType)le.pkca07), ''),IF (le.pkca08 <> 0,TRIM((SALT311.StrType)le.pkca08), ''),IF (le.pkca09 <> 0,TRIM((SALT311.StrType)le.pkca09), ''),IF (le.pkca10 <> 0,TRIM((SALT311.StrType)le.pkca10), ''),IF (le.pkca11 <> 0,TRIM((SALT311.StrType)le.pkca11), ''),IF (le.pkca12 <> 0,TRIM((SALT311.StrType)le.pkca12), ''),IF (le.pkca13 <> 0,TRIM((SALT311.StrType)le.pkca13), ''),IF (le.pkca14 <> 0,TRIM((SALT311.StrType)le.pkca14), ''),IF (le.pkca15 <> 0,TRIM((SALT311.StrType)le.pkca15), ''),IF (le.pkca16 <> 0,TRIM((SALT311.StrType)le.pkca16), ''),IF (le.pkca17 <> 0,TRIM((SALT311.StrType)le.pkca17), ''),IF (le.pkca18 <> 0,TRIM((SALT311.StrType)le.pkca18), ''),IF (le.pkca20 <> 0,TRIM((SALT311.StrType)le.pkca20), ''),IF (le.pkca21 <> 0,TRIM((SALT311.StrType)le.pkca21), ''),IF (le.pkca22 <> 0,TRIM((SALT311.StrType)le.pkca22), ''),IF (le.pkca23 <> 0,TRIM((SALT311.StrType)le.pkca23), ''),IF (le.pkca24 <> 0,TRIM((SALT311.StrType)le.pkca24), ''),IF (le.pkca25 <> 0,TRIM((SALT311.StrType)le.pkca25), ''),IF (le.pkca26 <> 0,TRIM((SALT311.StrType)le.pkca26), ''),IF (le.pkca28 <> 0,TRIM((SALT311.StrType)le.pkca28), ''),IF (le.pkca29 <> 0,TRIM((SALT311.StrType)le.pkca29), ''),IF (le.pkca30 <> 0,TRIM((SALT311.StrType)le.pkca30), ''),IF (le.pkca31 <> 0,TRIM((SALT311.StrType)le.pkca31), ''),IF (le.pkca32 <> 0,TRIM((SALT311.StrType)le.pkca32), ''),IF (le.pkca33 <> 0,TRIM((SALT311.StrType)le.pkca33), ''),IF (le.pkca34 <> 0,TRIM((SALT311.StrType)le.pkca34), ''),IF (le.pkca35 <> 0,TRIM((SALT311.StrType)le.pkca35), ''),IF (le.pkca36 <> 0,TRIM((SALT311.StrType)le.pkca36), ''),IF (le.pkca37 <> 0,TRIM((SALT311.StrType)le.pkca37), ''),IF (le.pkca39 <> 0,TRIM((SALT311.StrType)le.pkca39), ''),IF (le.pkca40 <> 0,TRIM((SALT311.StrType)le.pkca40), ''),IF (le.pkca41 <> 0,TRIM((SALT311.StrType)le.pkca41), ''),IF (le.pkca42 <> 0,TRIM((SALT311.StrType)le.pkca42), ''),IF (le.pkca54 <> 0,TRIM((SALT311.StrType)le.pkca54), ''),IF (le.pkca61 <> 0,TRIM((SALT311.StrType)le.pkca61), ''),IF (le.pkca62 <> 0,TRIM((SALT311.StrType)le.pkca62), ''),IF (le.pkca64 <> 0,TRIM((SALT311.StrType)le.pkca64), ''),IF (le.pkpu01 <> 0,TRIM((SALT311.StrType)le.pkpu01), ''),IF (le.pkpu02 <> 0,TRIM((SALT311.StrType)le.pkpu02), ''),IF (le.pkpu03 <> 0,TRIM((SALT311.StrType)le.pkpu03), ''),IF (le.pkpu04 <> 0,TRIM((SALT311.StrType)le.pkpu04), ''),IF (le.pkpu05 <> 0,TRIM((SALT311.StrType)le.pkpu05), ''),IF (le.pkpu06 <> 0,TRIM((SALT311.StrType)le.pkpu06), ''),IF (le.pkpu07 <> 0,TRIM((SALT311.StrType)le.pkpu07), ''),IF (le.pkpu08 <> 0,TRIM((SALT311.StrType)le.pkpu08), ''),IF (le.pkpu09 <> 0,TRIM((SALT311.StrType)le.pkpu09), ''),IF (le.pkpu10 <> 0,TRIM((SALT311.StrType)le.pkpu10), ''),IF (le.pkpu11 <> 0,TRIM((SALT311.StrType)le.pkpu11), ''),IF (le.pkpu12 <> 0,TRIM((SALT311.StrType)le.pkpu12), ''),IF (le.pkpu13 <> 0,TRIM((SALT311.StrType)le.pkpu13), ''),IF (le.pkpu14 <> 0,TRIM((SALT311.StrType)le.pkpu14), ''),IF (le.pkpu15 <> 0,TRIM((SALT311.StrType)le.pkpu15), ''),IF (le.pkpu16 <> 0,TRIM((SALT311.StrType)le.pkpu16), ''),IF (le.pkpu17 <> 0,TRIM((SALT311.StrType)le.pkpu17), ''),IF (le.pkpu18 <> 0,TRIM((SALT311.StrType)le.pkpu18), ''),IF (le.pkpu19 <> 0,TRIM((SALT311.StrType)le.pkpu19), ''),IF (le.pkpu20 <> 0,TRIM((SALT311.StrType)le.pkpu20), ''),IF (le.pkpu23 <> 0,TRIM((SALT311.StrType)le.pkpu23), ''),IF (le.pkpu25 <> 0,TRIM((SALT311.StrType)le.pkpu25), ''),IF (le.pkpu27 <> 0,TRIM((SALT311.StrType)le.pkpu27), ''),IF (le.pkpu28 <> 0,TRIM((SALT311.StrType)le.pkpu28), ''),IF (le.pkpu29 <> 0,TRIM((SALT311.StrType)le.pkpu29), ''),IF (le.pkpu30 <> 0,TRIM((SALT311.StrType)le.pkpu30), ''),IF (le.pkpu31 <> 0,TRIM((SALT311.StrType)le.pkpu31), ''),IF (le.pkpu32 <> 0,TRIM((SALT311.StrType)le.pkpu32), ''),IF (le.pkpu33 <> 0,TRIM((SALT311.StrType)le.pkpu33), ''),IF (le.pkpu34 <> 0,TRIM((SALT311.StrType)le.pkpu34), ''),IF (le.pkpu35 <> 0,TRIM((SALT311.StrType)le.pkpu35), ''),IF (le.pkpu38 <> 0,TRIM((SALT311.StrType)le.pkpu38), ''),IF (le.pkpu41 <> 0,TRIM((SALT311.StrType)le.pkpu41), ''),IF (le.pkpu42 <> 0,TRIM((SALT311.StrType)le.pkpu42), ''),IF (le.pkpu45 <> 0,TRIM((SALT311.StrType)le.pkpu45), ''),IF (le.pkpu46 <> 0,TRIM((SALT311.StrType)le.pkpu46), ''),IF (le.pkpu47 <> 0,TRIM((SALT311.StrType)le.pkpu47), ''),IF (le.pkpu48 <> 0,TRIM((SALT311.StrType)le.pkpu48), ''),IF (le.pkpu49 <> 0,TRIM((SALT311.StrType)le.pkpu49), ''),IF (le.pkpu50 <> 0,TRIM((SALT311.StrType)le.pkpu50), ''),IF (le.pkpu51 <> 0,TRIM((SALT311.StrType)le.pkpu51), ''),IF (le.pkpu52 <> 0,TRIM((SALT311.StrType)le.pkpu52), ''),IF (le.pkpu53 <> 0,TRIM((SALT311.StrType)le.pkpu53), ''),IF (le.pkpu54 <> 0,TRIM((SALT311.StrType)le.pkpu54), ''),IF (le.pkpu55 <> 0,TRIM((SALT311.StrType)le.pkpu55), ''),IF (le.pkpu56 <> 0,TRIM((SALT311.StrType)le.pkpu56), ''),IF (le.pkpu57 <> 0,TRIM((SALT311.StrType)le.pkpu57), ''),IF (le.pkpu60 <> 0,TRIM((SALT311.StrType)le.pkpu60), ''),IF (le.pkpu61 <> 0,TRIM((SALT311.StrType)le.pkpu61), ''),IF (le.pkpu62 <> 0,TRIM((SALT311.StrType)le.pkpu62), ''),IF (le.pkpu63 <> 0,TRIM((SALT311.StrType)le.pkpu63), ''),IF (le.pkpu64 <> 0,TRIM((SALT311.StrType)le.pkpu64), ''),IF (le.pkpu65 <> 0,TRIM((SALT311.StrType)le.pkpu65), ''),IF (le.pkpu66 <> 0,TRIM((SALT311.StrType)le.pkpu66), ''),IF (le.pkpu67 <> 0,TRIM((SALT311.StrType)le.pkpu67), ''),IF (le.pkpu68 <> 0,TRIM((SALT311.StrType)le.pkpu68), ''),IF (le.pkpu69 <> 0,TRIM((SALT311.StrType)le.pkpu69), ''),IF (le.pkpu70 <> 0,TRIM((SALT311.StrType)le.pkpu70), ''),IF (le.censpct_water <> 0,TRIM((SALT311.StrType)le.censpct_water), ''),IF (le.cens_pop_density <> 0,TRIM((SALT311.StrType)le.cens_pop_density), ''),IF (le.cens_hu_density <> 0,TRIM((SALT311.StrType)le.cens_hu_density), ''),IF (le.censpct_pop_white <> 0,TRIM((SALT311.StrType)le.censpct_pop_white), ''),IF (le.censpct_pop_black <> 0,TRIM((SALT311.StrType)le.censpct_pop_black), ''),IF (le.censpct_pop_amerind <> 0,TRIM((SALT311.StrType)le.censpct_pop_amerind), ''),IF (le.censpct_pop_asian <> 0,TRIM((SALT311.StrType)le.censpct_pop_asian), ''),IF (le.censpct_pop_pacisl <> 0,TRIM((SALT311.StrType)le.censpct_pop_pacisl), ''),IF (le.censpct_pop_othrace <> 0,TRIM((SALT311.StrType)le.censpct_pop_othrace), ''),IF (le.censpct_pop_multirace <> 0,TRIM((SALT311.StrType)le.censpct_pop_multirace), ''),IF (le.censpct_pop_hispanic <> 0,TRIM((SALT311.StrType)le.censpct_pop_hispanic), ''),IF (le.censpct_pop_agelt18 <> 0,TRIM((SALT311.StrType)le.censpct_pop_agelt18), ''),IF (le.censpct_pop_males <> 0,TRIM((SALT311.StrType)le.censpct_pop_males), ''),IF (le.censpct_adult_age1824 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age1824), ''),IF (le.censpct_adult_age2534 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age2534), ''),IF (le.censpct_adult_age3544 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age3544), ''),IF (le.censpct_adult_age4554 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age4554), ''),IF (le.censpct_adult_age5564 <> 0,TRIM((SALT311.StrType)le.censpct_adult_age5564), ''),IF (le.censpct_adult_agege65 <> 0,TRIM((SALT311.StrType)le.censpct_adult_agege65), ''),IF (le.cens_pop_medage <> 0,TRIM((SALT311.StrType)le.cens_pop_medage), ''),IF (le.cens_hh_avgsize <> 0,TRIM((SALT311.StrType)le.cens_hh_avgsize), ''),IF (le.censpct_hh_family <> 0,TRIM((SALT311.StrType)le.censpct_hh_family), ''),IF (le.censpct_hh_family_husbwife <> 0,TRIM((SALT311.StrType)le.censpct_hh_family_husbwife), ''),IF (le.censpct_hu_occupied <> 0,TRIM((SALT311.StrType)le.censpct_hu_occupied), ''),IF (le.censpct_hu_owned <> 0,TRIM((SALT311.StrType)le.censpct_hu_owned), ''),IF (le.censpct_hu_rented <> 0,TRIM((SALT311.StrType)le.censpct_hu_rented), ''),IF (le.censpct_hu_vacantseasonal <> 0,TRIM((SALT311.StrType)le.censpct_hu_vacantseasonal), ''),IF (le.zip_medinc <> 0,TRIM((SALT311.StrType)le.zip_medinc), ''),IF (le.zip_apparel <> 0,TRIM((SALT311.StrType)le.zip_apparel), ''),IF (le.zip_apparel_women <> 0,TRIM((SALT311.StrType)le.zip_apparel_women), ''),IF (le.zip_apparel_womfash <> 0,TRIM((SALT311.StrType)le.zip_apparel_womfash), ''),IF (le.zip_auto <> 0,TRIM((SALT311.StrType)le.zip_auto), ''),IF (le.zip_beauty <> 0,TRIM((SALT311.StrType)le.zip_beauty), ''),IF (le.zip_booksmusicmovies <> 0,TRIM((SALT311.StrType)le.zip_booksmusicmovies), ''),IF (le.zip_business <> 0,TRIM((SALT311.StrType)le.zip_business), ''),IF (le.zip_catalog <> 0,TRIM((SALT311.StrType)le.zip_catalog), ''),IF (le.zip_cc <> 0,TRIM((SALT311.StrType)le.zip_cc), ''),IF (le.zip_collectibles <> 0,TRIM((SALT311.StrType)le.zip_collectibles), ''),IF (le.zip_computers <> 0,TRIM((SALT311.StrType)le.zip_computers), ''),IF (le.zip_continuity <> 0,TRIM((SALT311.StrType)le.zip_continuity), ''),IF (le.zip_cooking <> 0,TRIM((SALT311.StrType)le.zip_cooking), ''),IF (le.zip_crafts <> 0,TRIM((SALT311.StrType)le.zip_crafts), ''),IF (le.zip_culturearts <> 0,TRIM((SALT311.StrType)le.zip_culturearts), ''),IF (le.zip_dm_sold <> 0,TRIM((SALT311.StrType)le.zip_dm_sold), ''),IF (le.zip_donor <> 0,TRIM((SALT311.StrType)le.zip_donor), ''),IF (le.zip_family <> 0,TRIM((SALT311.StrType)le.zip_family), ''),IF (le.zip_gardening <> 0,TRIM((SALT311.StrType)le.zip_gardening), ''),IF (le.zip_giftgivr <> 0,TRIM((SALT311.StrType)le.zip_giftgivr), ''),IF (le.zip_gourmet <> 0,TRIM((SALT311.StrType)le.zip_gourmet), ''),IF (le.zip_health <> 0,TRIM((SALT311.StrType)le.zip_health), ''),IF (le.zip_health_diet <> 0,TRIM((SALT311.StrType)le.zip_health_diet), ''),IF (le.zip_health_fitness <> 0,TRIM((SALT311.StrType)le.zip_health_fitness), ''),IF (le.zip_hobbies <> 0,TRIM((SALT311.StrType)le.zip_hobbies), ''),IF (le.zip_homedecr <> 0,TRIM((SALT311.StrType)le.zip_homedecr), ''),IF (le.zip_homeliv <> 0,TRIM((SALT311.StrType)le.zip_homeliv), ''),IF (le.zip_internet <> 0,TRIM((SALT311.StrType)le.zip_internet), ''),IF (le.zip_internet_access <> 0,TRIM((SALT311.StrType)le.zip_internet_access), ''),IF (le.zip_internet_buy <> 0,TRIM((SALT311.StrType)le.zip_internet_buy), ''),IF (le.zip_music <> 0,TRIM((SALT311.StrType)le.zip_music), ''),IF (le.zip_outdoors <> 0,TRIM((SALT311.StrType)le.zip_outdoors), ''),IF (le.zip_pets <> 0,TRIM((SALT311.StrType)le.zip_pets), ''),IF (le.zip_pfin <> 0,TRIM((SALT311.StrType)le.zip_pfin), ''),IF (le.zip_publish <> 0,TRIM((SALT311.StrType)le.zip_publish), ''),IF (le.zip_publish_books <> 0,TRIM((SALT311.StrType)le.zip_publish_books), ''),IF (le.zip_publish_mags <> 0,TRIM((SALT311.StrType)le.zip_publish_mags), ''),IF (le.zip_sports <> 0,TRIM((SALT311.StrType)le.zip_sports), ''),IF (le.zip_sports_biking <> 0,TRIM((SALT311.StrType)le.zip_sports_biking), ''),IF (le.zip_sports_golf <> 0,TRIM((SALT311.StrType)le.zip_sports_golf), ''),IF (le.zip_travel <> 0,TRIM((SALT311.StrType)le.zip_travel), ''),IF (le.zip_travel_us <> 0,TRIM((SALT311.StrType)le.zip_travel_us), ''),IF (le.zip_tvmovies <> 0,TRIM((SALT311.StrType)le.zip_tvmovies), ''),IF (le.zip_woman <> 0,TRIM((SALT311.StrType)le.zip_woman), ''),IF (le.zip_proftech <> 0,TRIM((SALT311.StrType)le.zip_proftech), ''),IF (le.zip_retired <> 0,TRIM((SALT311.StrType)le.zip_retired), ''),IF (le.zip_inc100 <> 0,TRIM((SALT311.StrType)le.zip_inc100), ''),IF (le.zip_inc75 <> 0,TRIM((SALT311.StrType)le.zip_inc75), ''),IF (le.zip_inc50 <> 0,TRIM((SALT311.StrType)le.zip_inc50), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),633*633,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dtmatch'}
      ,{2,'msname'}
      ,{3,'msaddr1'}
      ,{4,'msaddr2'}
      ,{5,'mscity'}
      ,{6,'msstate'}
      ,{7,'mszip5'}
      ,{8,'mszip4'}
      ,{9,'dthh'}
      ,{10,'mscrrt'}
      ,{11,'msdpbc'}
      ,{12,'msdpv'}
      ,{13,'ms_addrtype'}
      ,{14,'ctysize'}
      ,{15,'lmos'}
      ,{16,'omos'}
      ,{17,'pmos'}
      ,{18,'gen'}
      ,{19,'dob'}
      ,{20,'age'}
      ,{21,'inc'}
      ,{22,'marital_status'}
      ,{23,'poc'}
      ,{24,'noc'}
      ,{25,'ocp'}
      ,{26,'edu'}
      ,{27,'lang'}
      ,{28,'relig'}
      ,{29,'dwell'}
      ,{30,'ownr'}
      ,{31,'eth1'}
      ,{32,'eth2'}
      ,{33,'lor'}
      ,{34,'pool'}
      ,{35,'speak_span'}
      ,{36,'soho'}
      ,{37,'vet_in_hh'}
      ,{38,'ms_mags'}
      ,{39,'ms_books'}
      ,{40,'ms_publish'}
      ,{41,'ms_pub_status_active'}
      ,{42,'ms_pub_status_expire'}
      ,{43,'ms_pub_premsold'}
      ,{44,'ms_pub_autornwl'}
      ,{45,'ms_pub_avgterm'}
      ,{46,'ms_pub_lmos'}
      ,{47,'ms_pub_omos'}
      ,{48,'ms_pub_pmos'}
      ,{49,'ms_pub_cemos'}
      ,{50,'ms_pub_femos'}
      ,{51,'ms_pub_totords'}
      ,{52,'ms_pub_totdlrs'}
      ,{53,'ms_pub_avgdlrs'}
      ,{54,'ms_pub_lastdlrs'}
      ,{55,'ms_pub_paystat_paid'}
      ,{56,'ms_pub_paystat_ub'}
      ,{57,'ms_pub_paymeth_cc'}
      ,{58,'ms_pub_paymeth_cash'}
      ,{59,'ms_pub_payspeed'}
      ,{60,'ms_pub_osrc_dm'}
      ,{61,'ms_pub_lsrc_dm'}
      ,{62,'ms_pub_osrc_agt_cashf'}
      ,{63,'ms_pub_lsrc_agt_cashf'}
      ,{64,'ms_pub_osrc_agt_pds'}
      ,{65,'ms_pub_lsrc_agt_pds'}
      ,{66,'ms_pub_osrc_agt_schplan'}
      ,{67,'ms_pub_lsrc_agt_schplan'}
      ,{68,'ms_pub_osrc_agt_sponsor'}
      ,{69,'ms_pub_lsrc_agt_sponsor'}
      ,{70,'ms_pub_osrc_agt_tm'}
      ,{71,'ms_pub_lsrc_agt_tm'}
      ,{72,'ms_pub_osrc_agt'}
      ,{73,'ms_pub_lsrc_agt'}
      ,{74,'ms_pub_osrc_tm'}
      ,{75,'ms_pub_lsrc_tm'}
      ,{76,'ms_pub_osrc_ins'}
      ,{77,'ms_pub_lsrc_ins'}
      ,{78,'ms_pub_osrc_net'}
      ,{79,'ms_pub_lsrc_net'}
      ,{80,'ms_pub_osrc_print'}
      ,{81,'ms_pub_lsrc_print'}
      ,{82,'ms_pub_osrc_trans'}
      ,{83,'ms_pub_lsrc_trans'}
      ,{84,'ms_pub_osrc_tv'}
      ,{85,'ms_pub_lsrc_tv'}
      ,{86,'ms_pub_osrc_dtp'}
      ,{87,'ms_pub_lsrc_dtp'}
      ,{88,'ms_pub_giftgivr'}
      ,{89,'ms_pub_giftee'}
      ,{90,'ms_catalog'}
      ,{91,'ms_cat_lmos'}
      ,{92,'ms_cat_omos'}
      ,{93,'ms_cat_pmos'}
      ,{94,'ms_cat_totords'}
      ,{95,'ms_cat_totitems'}
      ,{96,'ms_cat_totdlrs'}
      ,{97,'ms_cat_avgdlrs'}
      ,{98,'ms_cat_lastdlrs'}
      ,{99,'ms_cat_paystat_paid'}
      ,{100,'ms_cat_paymeth_cc'}
      ,{101,'ms_cat_paymeth_cash'}
      ,{102,'ms_cat_osrc_dm'}
      ,{103,'ms_cat_lsrc_dm'}
      ,{104,'ms_cat_osrc_net'}
      ,{105,'ms_cat_lsrc_net'}
      ,{106,'ms_cat_giftgivr'}
      ,{107,'pkpubs_corrected'}
      ,{108,'pkcatg_corrected'}
      ,{109,'ms_fundraising'}
      ,{110,'ms_fund_lmos'}
      ,{111,'ms_fund_omos'}
      ,{112,'ms_fund_pmos'}
      ,{113,'ms_fund_totords'}
      ,{114,'ms_fund_totdlrs'}
      ,{115,'ms_fund_avgdlrs'}
      ,{116,'ms_fund_lastdlrs'}
      ,{117,'ms_fund_paystat_paid'}
      ,{118,'ms_other'}
      ,{119,'ms_continuity'}
      ,{120,'ms_cont_status_active'}
      ,{121,'ms_cont_status_cancel'}
      ,{122,'ms_cont_omos'}
      ,{123,'ms_cont_lmos'}
      ,{124,'ms_cont_pmos'}
      ,{125,'ms_cont_totords'}
      ,{126,'ms_cont_totdlrs'}
      ,{127,'ms_cont_avgdlrs'}
      ,{128,'ms_cont_lastdlrs'}
      ,{129,'ms_cont_paystat_paid'}
      ,{130,'ms_cont_paymeth_cc'}
      ,{131,'ms_cont_paymeth_cash'}
      ,{132,'ms_totords'}
      ,{133,'ms_totitems'}
      ,{134,'ms_totdlrs'}
      ,{135,'ms_avgdlrs'}
      ,{136,'ms_lastdlrs'}
      ,{137,'ms_paystat_paid'}
      ,{138,'ms_paymeth_cc'}
      ,{139,'ms_paymeth_cash'}
      ,{140,'ms_osrc_dm'}
      ,{141,'ms_lsrc_dm'}
      ,{142,'ms_osrc_tm'}
      ,{143,'ms_lsrc_tm'}
      ,{144,'ms_osrc_ins'}
      ,{145,'ms_lsrc_ins'}
      ,{146,'ms_osrc_net'}
      ,{147,'ms_lsrc_net'}
      ,{148,'ms_osrc_tv'}
      ,{149,'ms_lsrc_tv'}
      ,{150,'ms_osrc_retail'}
      ,{151,'ms_lsrc_retail'}
      ,{152,'ms_giftgivr'}
      ,{153,'ms_giftee'}
      ,{154,'ms_adult'}
      ,{155,'ms_womapp'}
      ,{156,'ms_menapp'}
      ,{157,'ms_kidapp'}
      ,{158,'ms_accessory'}
      ,{159,'ms_apparel'}
      ,{160,'ms_app_lmos'}
      ,{161,'ms_app_omos'}
      ,{162,'ms_app_pmos'}
      ,{163,'ms_app_totords'}
      ,{164,'ms_app_totitems'}
      ,{165,'ms_app_totdlrs'}
      ,{166,'ms_app_avgdlrs'}
      ,{167,'ms_app_lastdlrs'}
      ,{168,'ms_app_paystat_paid'}
      ,{169,'ms_app_paymeth_cc'}
      ,{170,'ms_app_paymeth_cash'}
      ,{171,'ms_menfash'}
      ,{172,'ms_womfash'}
      ,{173,'ms_wfsh_lmos'}
      ,{174,'ms_wfsh_omos'}
      ,{175,'ms_wfsh_pmos'}
      ,{176,'ms_wfsh_totords'}
      ,{177,'ms_wfsh_totdlrs'}
      ,{178,'ms_wfsh_avgdlrs'}
      ,{179,'ms_wfsh_lastdlrs'}
      ,{180,'ms_wfsh_paystat_paid'}
      ,{181,'ms_wfsh_osrc_dm'}
      ,{182,'ms_wfsh_lsrc_dm'}
      ,{183,'ms_wfsh_osrc_agt'}
      ,{184,'ms_wfsh_lsrc_agt'}
      ,{185,'ms_audio'}
      ,{186,'ms_auto'}
      ,{187,'ms_aviation'}
      ,{188,'ms_bargains'}
      ,{189,'ms_beauty'}
      ,{190,'ms_bible'}
      ,{191,'ms_bible_lmos'}
      ,{192,'ms_bible_omos'}
      ,{193,'ms_bible_pmos'}
      ,{194,'ms_bible_totords'}
      ,{195,'ms_bible_totitems'}
      ,{196,'ms_bible_totdlrs'}
      ,{197,'ms_bible_avgdlrs'}
      ,{198,'ms_bible_lastdlrs'}
      ,{199,'ms_bible_paystat_paid'}
      ,{200,'ms_bible_paymeth_cc'}
      ,{201,'ms_bible_paymeth_cash'}
      ,{202,'ms_business'}
      ,{203,'ms_collectibles'}
      ,{204,'ms_computers'}
      ,{205,'ms_crafts'}
      ,{206,'ms_culturearts'}
      ,{207,'ms_currevent'}
      ,{208,'ms_diy'}
      ,{209,'ms_electronics'}
      ,{210,'ms_equestrian'}
      ,{211,'ms_pub_family'}
      ,{212,'ms_cat_family'}
      ,{213,'ms_family'}
      ,{214,'ms_family_lmos'}
      ,{215,'ms_family_omos'}
      ,{216,'ms_family_pmos'}
      ,{217,'ms_family_totords'}
      ,{218,'ms_family_totitems'}
      ,{219,'ms_family_totdlrs'}
      ,{220,'ms_family_avgdlrs'}
      ,{221,'ms_family_lastdlrs'}
      ,{222,'ms_family_paystat_paid'}
      ,{223,'ms_family_paymeth_cc'}
      ,{224,'ms_family_paymeth_cash'}
      ,{225,'ms_family_osrc_dm'}
      ,{226,'ms_family_lsrc_dm'}
      ,{227,'ms_fiction'}
      ,{228,'ms_food'}
      ,{229,'ms_games'}
      ,{230,'ms_gifts'}
      ,{231,'ms_gourmet'}
      ,{232,'ms_fitness'}
      ,{233,'ms_health'}
      ,{234,'ms_hlth_lmos'}
      ,{235,'ms_hlth_omos'}
      ,{236,'ms_hlth_pmos'}
      ,{237,'ms_hlth_totords'}
      ,{238,'ms_hlth_totdlrs'}
      ,{239,'ms_hlth_avgdlrs'}
      ,{240,'ms_hlth_lastdlrs'}
      ,{241,'ms_hlth_paystat_paid'}
      ,{242,'ms_hlth_paymeth_cc'}
      ,{243,'ms_hlth_osrc_dm'}
      ,{244,'ms_hlth_lsrc_dm'}
      ,{245,'ms_hlth_osrc_agt'}
      ,{246,'ms_hlth_lsrc_agt'}
      ,{247,'ms_hlth_osrc_tv'}
      ,{248,'ms_hlth_lsrc_tv'}
      ,{249,'ms_holiday'}
      ,{250,'ms_history'}
      ,{251,'ms_pub_cooking'}
      ,{252,'ms_cooking'}
      ,{253,'ms_pub_homedecr'}
      ,{254,'ms_cat_homedecr'}
      ,{255,'ms_homedecr'}
      ,{256,'ms_housewares'}
      ,{257,'ms_pub_garden'}
      ,{258,'ms_cat_garden'}
      ,{259,'ms_garden'}
      ,{260,'ms_pub_homeliv'}
      ,{261,'ms_cat_homeliv'}
      ,{262,'ms_homeliv'}
      ,{263,'ms_pub_home_status_active'}
      ,{264,'ms_home_lmos'}
      ,{265,'ms_home_omos'}
      ,{266,'ms_home_pmos'}
      ,{267,'ms_home_totords'}
      ,{268,'ms_home_totitems'}
      ,{269,'ms_home_totdlrs'}
      ,{270,'ms_home_avgdlrs'}
      ,{271,'ms_home_lastdlrs'}
      ,{272,'ms_home_paystat_paid'}
      ,{273,'ms_home_paymeth_cc'}
      ,{274,'ms_home_paymeth_cash'}
      ,{275,'ms_home_osrc_dm'}
      ,{276,'ms_home_lsrc_dm'}
      ,{277,'ms_home_osrc_agt'}
      ,{278,'ms_home_lsrc_agt'}
      ,{279,'ms_home_osrc_net'}
      ,{280,'ms_home_lsrc_net'}
      ,{281,'ms_home_osrc_tv'}
      ,{282,'ms_home_lsrc_tv'}
      ,{283,'ms_humor'}
      ,{284,'ms_inspiration'}
      ,{285,'ms_merchandise'}
      ,{286,'ms_moneymaking'}
      ,{287,'ms_moneymaking_lmos'}
      ,{288,'ms_motorcycles'}
      ,{289,'ms_music'}
      ,{290,'ms_fishing'}
      ,{291,'ms_hunting'}
      ,{292,'ms_boatsail'}
      ,{293,'ms_camp'}
      ,{294,'ms_pub_outdoors'}
      ,{295,'ms_cat_outdoors'}
      ,{296,'ms_outdoors'}
      ,{297,'ms_pub_out_status_active'}
      ,{298,'ms_out_lmos'}
      ,{299,'ms_out_omos'}
      ,{300,'ms_out_pmos'}
      ,{301,'ms_out_totords'}
      ,{302,'ms_out_totitems'}
      ,{303,'ms_out_totdlrs'}
      ,{304,'ms_out_avgdlrs'}
      ,{305,'ms_out_lastdlrs'}
      ,{306,'ms_out_paystat_paid'}
      ,{307,'ms_out_paymeth_cc'}
      ,{308,'ms_out_paymeth_cash'}
      ,{309,'ms_out_osrc_dm'}
      ,{310,'ms_out_lsrc_dm'}
      ,{311,'ms_out_osrc_agt'}
      ,{312,'ms_out_lsrc_agt'}
      ,{313,'ms_pets'}
      ,{314,'ms_pfin'}
      ,{315,'ms_photo'}
      ,{316,'ms_photoproc'}
      ,{317,'ms_rural'}
      ,{318,'ms_science'}
      ,{319,'ms_sports'}
      ,{320,'ms_sports_lmos'}
      ,{321,'ms_travel'}
      ,{322,'ms_tvmovies'}
      ,{323,'ms_wildlife'}
      ,{324,'ms_woman'}
      ,{325,'ms_woman_lmos'}
      ,{326,'ms_ringtones_apps'}
      ,{327,'cpi_mobile_apps_index'}
      ,{328,'cpi_credit_repair_index'}
      ,{329,'cpi_credit_report_index'}
      ,{330,'cpi_education_seekers_index'}
      ,{331,'cpi_insurance_index'}
      ,{332,'cpi_insurance_health_index'}
      ,{333,'cpi_insurance_auto_index'}
      ,{334,'cpi_job_seekers_index'}
      ,{335,'cpi_social_networking_index'}
      ,{336,'cpi_adult_index'}
      ,{337,'cpi_africanamerican_index'}
      ,{338,'cpi_apparel_index'}
      ,{339,'cpi_apparel_accessory_index'}
      ,{340,'cpi_apparel_kids_index'}
      ,{341,'cpi_apparel_men_index'}
      ,{342,'cpi_apparel_menfash_index'}
      ,{343,'cpi_apparel_women_index'}
      ,{344,'cpi_apparel_womfash_index'}
      ,{345,'cpi_asian_index'}
      ,{346,'cpi_auto_index'}
      ,{347,'cpi_auto_racing_index'}
      ,{348,'cpi_auto_trucks_index'}
      ,{349,'cpi_aviation_index'}
      ,{350,'cpi_bargains_index'}
      ,{351,'cpi_beauty_index'}
      ,{352,'cpi_bible_index'}
      ,{353,'cpi_birds_index'}
      ,{354,'cpi_business_index'}
      ,{355,'cpi_business_homeoffice_index'}
      ,{356,'cpi_catalog_index'}
      ,{357,'cpi_cc_index'}
      ,{358,'cpi_collectibles_index'}
      ,{359,'cpi_college_index'}
      ,{360,'cpi_computers_index'}
      ,{361,'cpi_conservative_index'}
      ,{362,'cpi_continuity_index'}
      ,{363,'cpi_cooking_index'}
      ,{364,'cpi_crafts_index'}
      ,{365,'cpi_crafts_crochet_index'}
      ,{366,'cpi_crafts_knit_index'}
      ,{367,'cpi_crafts_needlepoint_index'}
      ,{368,'cpi_crafts_quilt_index'}
      ,{369,'cpi_crafts_sew_index'}
      ,{370,'cpi_culturearts_index'}
      ,{371,'cpi_currevent_index'}
      ,{372,'cpi_diy_index'}
      ,{373,'cpi_donor_index'}
      ,{374,'cpi_ego_index'}
      ,{375,'cpi_electronics_index'}
      ,{376,'cpi_equestrian_index'}
      ,{377,'cpi_family_index'}
      ,{378,'cpi_family_teen_index'}
      ,{379,'cpi_family_young_index'}
      ,{380,'cpi_fiction_index'}
      ,{381,'cpi_gambling_index'}
      ,{382,'cpi_games_index'}
      ,{383,'cpi_gardening_index'}
      ,{384,'cpi_gay_index'}
      ,{385,'cpi_giftgivr_index'}
      ,{386,'cpi_gourmet_index'}
      ,{387,'cpi_grandparents_index'}
      ,{388,'cpi_health_index'}
      ,{389,'cpi_health_diet_index'}
      ,{390,'cpi_health_fitness_index'}
      ,{391,'cpi_hightech_index'}
      ,{392,'cpi_hispanic_index'}
      ,{393,'cpi_history_index'}
      ,{394,'cpi_history_american_index'}
      ,{395,'cpi_hobbies_index'}
      ,{396,'cpi_homedecr_index'}
      ,{397,'cpi_homeliv_index'}
      ,{398,'cpi_humor_index'}
      ,{399,'cpi_inspiration_index'}
      ,{400,'cpi_internet_index'}
      ,{401,'cpi_internet_access_index'}
      ,{402,'cpi_internet_buy_index'}
      ,{403,'cpi_liberal_index'}
      ,{404,'cpi_moneymaking_index'}
      ,{405,'cpi_motorcycles_index'}
      ,{406,'cpi_music_index'}
      ,{407,'cpi_nonfiction_index'}
      ,{408,'cpi_ocean_index'}
      ,{409,'cpi_outdoors_index'}
      ,{410,'cpi_outdoors_boatsail_index'}
      ,{411,'cpi_outdoors_camp_index'}
      ,{412,'cpi_outdoors_fishing_index'}
      ,{413,'cpi_outdoors_huntfish_index'}
      ,{414,'cpi_outdoors_hunting_index'}
      ,{415,'cpi_pets_index'}
      ,{416,'cpi_pets_cats_index'}
      ,{417,'cpi_pets_dogs_index'}
      ,{418,'cpi_pfin_index'}
      ,{419,'cpi_photog_index'}
      ,{420,'cpi_photoproc_index'}
      ,{421,'cpi_publish_index'}
      ,{422,'cpi_publish_books_index'}
      ,{423,'cpi_publish_mags_index'}
      ,{424,'cpi_rural_index'}
      ,{425,'cpi_science_index'}
      ,{426,'cpi_scifi_index'}
      ,{427,'cpi_seniors_index'}
      ,{428,'cpi_sports_index'}
      ,{429,'cpi_sports_baseball_index'}
      ,{430,'cpi_sports_basketball_index'}
      ,{431,'cpi_sports_biking_index'}
      ,{432,'cpi_sports_football_index'}
      ,{433,'cpi_sports_golf_index'}
      ,{434,'cpi_sports_hockey_index'}
      ,{435,'cpi_sports_running_index'}
      ,{436,'cpi_sports_ski_index'}
      ,{437,'cpi_sports_soccer_index'}
      ,{438,'cpi_sports_swimming_index'}
      ,{439,'cpi_sports_tennis_index'}
      ,{440,'cpi_stationery_index'}
      ,{441,'cpi_sweeps_index'}
      ,{442,'cpi_tobacco_index'}
      ,{443,'cpi_travel_index'}
      ,{444,'cpi_travel_cruise_index'}
      ,{445,'cpi_travel_rv_index'}
      ,{446,'cpi_travel_us_index'}
      ,{447,'cpi_tvmovies_index'}
      ,{448,'cpi_wildlife_index'}
      ,{449,'cpi_woman_index'}
      ,{450,'totdlr_index'}
      ,{451,'cpi_totdlr'}
      ,{452,'cpi_totords'}
      ,{453,'cpi_lastdlr'}
      ,{454,'pkcatg'}
      ,{455,'pkpubs'}
      ,{456,'pkcont'}
      ,{457,'pkca01'}
      ,{458,'pkca03'}
      ,{459,'pkca04'}
      ,{460,'pkca05'}
      ,{461,'pkca06'}
      ,{462,'pkca07'}
      ,{463,'pkca08'}
      ,{464,'pkca09'}
      ,{465,'pkca10'}
      ,{466,'pkca11'}
      ,{467,'pkca12'}
      ,{468,'pkca13'}
      ,{469,'pkca14'}
      ,{470,'pkca15'}
      ,{471,'pkca16'}
      ,{472,'pkca17'}
      ,{473,'pkca18'}
      ,{474,'pkca20'}
      ,{475,'pkca21'}
      ,{476,'pkca22'}
      ,{477,'pkca23'}
      ,{478,'pkca24'}
      ,{479,'pkca25'}
      ,{480,'pkca26'}
      ,{481,'pkca28'}
      ,{482,'pkca29'}
      ,{483,'pkca30'}
      ,{484,'pkca31'}
      ,{485,'pkca32'}
      ,{486,'pkca33'}
      ,{487,'pkca34'}
      ,{488,'pkca35'}
      ,{489,'pkca36'}
      ,{490,'pkca37'}
      ,{491,'pkca39'}
      ,{492,'pkca40'}
      ,{493,'pkca41'}
      ,{494,'pkca42'}
      ,{495,'pkca54'}
      ,{496,'pkca61'}
      ,{497,'pkca62'}
      ,{498,'pkca64'}
      ,{499,'pkpu01'}
      ,{500,'pkpu02'}
      ,{501,'pkpu03'}
      ,{502,'pkpu04'}
      ,{503,'pkpu05'}
      ,{504,'pkpu06'}
      ,{505,'pkpu07'}
      ,{506,'pkpu08'}
      ,{507,'pkpu09'}
      ,{508,'pkpu10'}
      ,{509,'pkpu11'}
      ,{510,'pkpu12'}
      ,{511,'pkpu13'}
      ,{512,'pkpu14'}
      ,{513,'pkpu15'}
      ,{514,'pkpu16'}
      ,{515,'pkpu17'}
      ,{516,'pkpu18'}
      ,{517,'pkpu19'}
      ,{518,'pkpu20'}
      ,{519,'pkpu23'}
      ,{520,'pkpu25'}
      ,{521,'pkpu27'}
      ,{522,'pkpu28'}
      ,{523,'pkpu29'}
      ,{524,'pkpu30'}
      ,{525,'pkpu31'}
      ,{526,'pkpu32'}
      ,{527,'pkpu33'}
      ,{528,'pkpu34'}
      ,{529,'pkpu35'}
      ,{530,'pkpu38'}
      ,{531,'pkpu41'}
      ,{532,'pkpu42'}
      ,{533,'pkpu45'}
      ,{534,'pkpu46'}
      ,{535,'pkpu47'}
      ,{536,'pkpu48'}
      ,{537,'pkpu49'}
      ,{538,'pkpu50'}
      ,{539,'pkpu51'}
      ,{540,'pkpu52'}
      ,{541,'pkpu53'}
      ,{542,'pkpu54'}
      ,{543,'pkpu55'}
      ,{544,'pkpu56'}
      ,{545,'pkpu57'}
      ,{546,'pkpu60'}
      ,{547,'pkpu61'}
      ,{548,'pkpu62'}
      ,{549,'pkpu63'}
      ,{550,'pkpu64'}
      ,{551,'pkpu65'}
      ,{552,'pkpu66'}
      ,{553,'pkpu67'}
      ,{554,'pkpu68'}
      ,{555,'pkpu69'}
      ,{556,'pkpu70'}
      ,{557,'censpct_water'}
      ,{558,'cens_pop_density'}
      ,{559,'cens_hu_density'}
      ,{560,'censpct_pop_white'}
      ,{561,'censpct_pop_black'}
      ,{562,'censpct_pop_amerind'}
      ,{563,'censpct_pop_asian'}
      ,{564,'censpct_pop_pacisl'}
      ,{565,'censpct_pop_othrace'}
      ,{566,'censpct_pop_multirace'}
      ,{567,'censpct_pop_hispanic'}
      ,{568,'censpct_pop_agelt18'}
      ,{569,'censpct_pop_males'}
      ,{570,'censpct_adult_age1824'}
      ,{571,'censpct_adult_age2534'}
      ,{572,'censpct_adult_age3544'}
      ,{573,'censpct_adult_age4554'}
      ,{574,'censpct_adult_age5564'}
      ,{575,'censpct_adult_agege65'}
      ,{576,'cens_pop_medage'}
      ,{577,'cens_hh_avgsize'}
      ,{578,'censpct_hh_family'}
      ,{579,'censpct_hh_family_husbwife'}
      ,{580,'censpct_hu_occupied'}
      ,{581,'censpct_hu_owned'}
      ,{582,'censpct_hu_rented'}
      ,{583,'censpct_hu_vacantseasonal'}
      ,{584,'zip_medinc'}
      ,{585,'zip_apparel'}
      ,{586,'zip_apparel_women'}
      ,{587,'zip_apparel_womfash'}
      ,{588,'zip_auto'}
      ,{589,'zip_beauty'}
      ,{590,'zip_booksmusicmovies'}
      ,{591,'zip_business'}
      ,{592,'zip_catalog'}
      ,{593,'zip_cc'}
      ,{594,'zip_collectibles'}
      ,{595,'zip_computers'}
      ,{596,'zip_continuity'}
      ,{597,'zip_cooking'}
      ,{598,'zip_crafts'}
      ,{599,'zip_culturearts'}
      ,{600,'zip_dm_sold'}
      ,{601,'zip_donor'}
      ,{602,'zip_family'}
      ,{603,'zip_gardening'}
      ,{604,'zip_giftgivr'}
      ,{605,'zip_gourmet'}
      ,{606,'zip_health'}
      ,{607,'zip_health_diet'}
      ,{608,'zip_health_fitness'}
      ,{609,'zip_hobbies'}
      ,{610,'zip_homedecr'}
      ,{611,'zip_homeliv'}
      ,{612,'zip_internet'}
      ,{613,'zip_internet_access'}
      ,{614,'zip_internet_buy'}
      ,{615,'zip_music'}
      ,{616,'zip_outdoors'}
      ,{617,'zip_pets'}
      ,{618,'zip_pfin'}
      ,{619,'zip_publish'}
      ,{620,'zip_publish_books'}
      ,{621,'zip_publish_mags'}
      ,{622,'zip_sports'}
      ,{623,'zip_sports_biking'}
      ,{624,'zip_sports_golf'}
      ,{625,'zip_travel'}
      ,{626,'zip_travel_us'}
      ,{627,'zip_tvmovies'}
      ,{628,'zip_woman'}
      ,{629,'zip_proftech'}
      ,{630,'zip_retired'}
      ,{631,'zip_inc100'}
      ,{632,'zip_inc75'}
      ,{633,'zip_inc50'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dtmatch((SALT311.StrType)le.dtmatch),
    Fields.InValid_msname((SALT311.StrType)le.msname),
    Fields.InValid_msaddr1((SALT311.StrType)le.msaddr1),
    Fields.InValid_msaddr2((SALT311.StrType)le.msaddr2),
    Fields.InValid_mscity((SALT311.StrType)le.mscity),
    Fields.InValid_msstate((SALT311.StrType)le.msstate),
    Fields.InValid_mszip5((SALT311.StrType)le.mszip5),
    Fields.InValid_mszip4((SALT311.StrType)le.mszip4),
    Fields.InValid_dthh((SALT311.StrType)le.dthh),
    Fields.InValid_mscrrt((SALT311.StrType)le.mscrrt),
    Fields.InValid_msdpbc((SALT311.StrType)le.msdpbc),
    Fields.InValid_msdpv((SALT311.StrType)le.msdpv),
    Fields.InValid_ms_addrtype((SALT311.StrType)le.ms_addrtype),
    Fields.InValid_ctysize((SALT311.StrType)le.ctysize),
    Fields.InValid_lmos((SALT311.StrType)le.lmos),
    Fields.InValid_omos((SALT311.StrType)le.omos),
    Fields.InValid_pmos((SALT311.StrType)le.pmos),
    Fields.InValid_gen((SALT311.StrType)le.gen),
    Fields.InValid_dob((SALT311.StrType)le.dob),
    Fields.InValid_age((SALT311.StrType)le.age),
    Fields.InValid_inc((SALT311.StrType)le.inc),
    Fields.InValid_marital_status((SALT311.StrType)le.marital_status),
    Fields.InValid_poc((SALT311.StrType)le.poc),
    Fields.InValid_noc((SALT311.StrType)le.noc),
    Fields.InValid_ocp((SALT311.StrType)le.ocp),
    Fields.InValid_edu((SALT311.StrType)le.edu),
    Fields.InValid_lang((SALT311.StrType)le.lang),
    Fields.InValid_relig((SALT311.StrType)le.relig),
    Fields.InValid_dwell((SALT311.StrType)le.dwell),
    Fields.InValid_ownr((SALT311.StrType)le.ownr),
    Fields.InValid_eth1((SALT311.StrType)le.eth1),
    Fields.InValid_eth2((SALT311.StrType)le.eth2),
    Fields.InValid_lor((SALT311.StrType)le.lor),
    Fields.InValid_pool((SALT311.StrType)le.pool),
    Fields.InValid_speak_span((SALT311.StrType)le.speak_span),
    Fields.InValid_soho((SALT311.StrType)le.soho),
    Fields.InValid_vet_in_hh((SALT311.StrType)le.vet_in_hh),
    Fields.InValid_ms_mags((SALT311.StrType)le.ms_mags),
    Fields.InValid_ms_books((SALT311.StrType)le.ms_books),
    Fields.InValid_ms_publish((SALT311.StrType)le.ms_publish),
    Fields.InValid_ms_pub_status_active((SALT311.StrType)le.ms_pub_status_active),
    Fields.InValid_ms_pub_status_expire((SALT311.StrType)le.ms_pub_status_expire),
    Fields.InValid_ms_pub_premsold((SALT311.StrType)le.ms_pub_premsold),
    Fields.InValid_ms_pub_autornwl((SALT311.StrType)le.ms_pub_autornwl),
    Fields.InValid_ms_pub_avgterm((SALT311.StrType)le.ms_pub_avgterm),
    Fields.InValid_ms_pub_lmos((SALT311.StrType)le.ms_pub_lmos),
    Fields.InValid_ms_pub_omos((SALT311.StrType)le.ms_pub_omos),
    Fields.InValid_ms_pub_pmos((SALT311.StrType)le.ms_pub_pmos),
    Fields.InValid_ms_pub_cemos((SALT311.StrType)le.ms_pub_cemos),
    Fields.InValid_ms_pub_femos((SALT311.StrType)le.ms_pub_femos),
    Fields.InValid_ms_pub_totords((SALT311.StrType)le.ms_pub_totords),
    Fields.InValid_ms_pub_totdlrs((SALT311.StrType)le.ms_pub_totdlrs),
    Fields.InValid_ms_pub_avgdlrs((SALT311.StrType)le.ms_pub_avgdlrs),
    Fields.InValid_ms_pub_lastdlrs((SALT311.StrType)le.ms_pub_lastdlrs),
    Fields.InValid_ms_pub_paystat_paid((SALT311.StrType)le.ms_pub_paystat_paid),
    Fields.InValid_ms_pub_paystat_ub((SALT311.StrType)le.ms_pub_paystat_ub),
    Fields.InValid_ms_pub_paymeth_cc((SALT311.StrType)le.ms_pub_paymeth_cc),
    Fields.InValid_ms_pub_paymeth_cash((SALT311.StrType)le.ms_pub_paymeth_cash),
    Fields.InValid_ms_pub_payspeed((SALT311.StrType)le.ms_pub_payspeed),
    Fields.InValid_ms_pub_osrc_dm((SALT311.StrType)le.ms_pub_osrc_dm),
    Fields.InValid_ms_pub_lsrc_dm((SALT311.StrType)le.ms_pub_lsrc_dm),
    Fields.InValid_ms_pub_osrc_agt_cashf((SALT311.StrType)le.ms_pub_osrc_agt_cashf),
    Fields.InValid_ms_pub_lsrc_agt_cashf((SALT311.StrType)le.ms_pub_lsrc_agt_cashf),
    Fields.InValid_ms_pub_osrc_agt_pds((SALT311.StrType)le.ms_pub_osrc_agt_pds),
    Fields.InValid_ms_pub_lsrc_agt_pds((SALT311.StrType)le.ms_pub_lsrc_agt_pds),
    Fields.InValid_ms_pub_osrc_agt_schplan((SALT311.StrType)le.ms_pub_osrc_agt_schplan),
    Fields.InValid_ms_pub_lsrc_agt_schplan((SALT311.StrType)le.ms_pub_lsrc_agt_schplan),
    Fields.InValid_ms_pub_osrc_agt_sponsor((SALT311.StrType)le.ms_pub_osrc_agt_sponsor),
    Fields.InValid_ms_pub_lsrc_agt_sponsor((SALT311.StrType)le.ms_pub_lsrc_agt_sponsor),
    Fields.InValid_ms_pub_osrc_agt_tm((SALT311.StrType)le.ms_pub_osrc_agt_tm),
    Fields.InValid_ms_pub_lsrc_agt_tm((SALT311.StrType)le.ms_pub_lsrc_agt_tm),
    Fields.InValid_ms_pub_osrc_agt((SALT311.StrType)le.ms_pub_osrc_agt),
    Fields.InValid_ms_pub_lsrc_agt((SALT311.StrType)le.ms_pub_lsrc_agt),
    Fields.InValid_ms_pub_osrc_tm((SALT311.StrType)le.ms_pub_osrc_tm),
    Fields.InValid_ms_pub_lsrc_tm((SALT311.StrType)le.ms_pub_lsrc_tm),
    Fields.InValid_ms_pub_osrc_ins((SALT311.StrType)le.ms_pub_osrc_ins),
    Fields.InValid_ms_pub_lsrc_ins((SALT311.StrType)le.ms_pub_lsrc_ins),
    Fields.InValid_ms_pub_osrc_net((SALT311.StrType)le.ms_pub_osrc_net),
    Fields.InValid_ms_pub_lsrc_net((SALT311.StrType)le.ms_pub_lsrc_net),
    Fields.InValid_ms_pub_osrc_print((SALT311.StrType)le.ms_pub_osrc_print),
    Fields.InValid_ms_pub_lsrc_print((SALT311.StrType)le.ms_pub_lsrc_print),
    Fields.InValid_ms_pub_osrc_trans((SALT311.StrType)le.ms_pub_osrc_trans),
    Fields.InValid_ms_pub_lsrc_trans((SALT311.StrType)le.ms_pub_lsrc_trans),
    Fields.InValid_ms_pub_osrc_tv((SALT311.StrType)le.ms_pub_osrc_tv),
    Fields.InValid_ms_pub_lsrc_tv((SALT311.StrType)le.ms_pub_lsrc_tv),
    Fields.InValid_ms_pub_osrc_dtp((SALT311.StrType)le.ms_pub_osrc_dtp),
    Fields.InValid_ms_pub_lsrc_dtp((SALT311.StrType)le.ms_pub_lsrc_dtp),
    Fields.InValid_ms_pub_giftgivr((SALT311.StrType)le.ms_pub_giftgivr),
    Fields.InValid_ms_pub_giftee((SALT311.StrType)le.ms_pub_giftee),
    Fields.InValid_ms_catalog((SALT311.StrType)le.ms_catalog),
    Fields.InValid_ms_cat_lmos((SALT311.StrType)le.ms_cat_lmos),
    Fields.InValid_ms_cat_omos((SALT311.StrType)le.ms_cat_omos),
    Fields.InValid_ms_cat_pmos((SALT311.StrType)le.ms_cat_pmos),
    Fields.InValid_ms_cat_totords((SALT311.StrType)le.ms_cat_totords),
    Fields.InValid_ms_cat_totitems((SALT311.StrType)le.ms_cat_totitems),
    Fields.InValid_ms_cat_totdlrs((SALT311.StrType)le.ms_cat_totdlrs),
    Fields.InValid_ms_cat_avgdlrs((SALT311.StrType)le.ms_cat_avgdlrs),
    Fields.InValid_ms_cat_lastdlrs((SALT311.StrType)le.ms_cat_lastdlrs),
    Fields.InValid_ms_cat_paystat_paid((SALT311.StrType)le.ms_cat_paystat_paid),
    Fields.InValid_ms_cat_paymeth_cc((SALT311.StrType)le.ms_cat_paymeth_cc),
    Fields.InValid_ms_cat_paymeth_cash((SALT311.StrType)le.ms_cat_paymeth_cash),
    Fields.InValid_ms_cat_osrc_dm((SALT311.StrType)le.ms_cat_osrc_dm),
    Fields.InValid_ms_cat_lsrc_dm((SALT311.StrType)le.ms_cat_lsrc_dm),
    Fields.InValid_ms_cat_osrc_net((SALT311.StrType)le.ms_cat_osrc_net),
    Fields.InValid_ms_cat_lsrc_net((SALT311.StrType)le.ms_cat_lsrc_net),
    Fields.InValid_ms_cat_giftgivr((SALT311.StrType)le.ms_cat_giftgivr),
    Fields.InValid_pkpubs_corrected((SALT311.StrType)le.pkpubs_corrected),
    Fields.InValid_pkcatg_corrected((SALT311.StrType)le.pkcatg_corrected),
    Fields.InValid_ms_fundraising((SALT311.StrType)le.ms_fundraising),
    Fields.InValid_ms_fund_lmos((SALT311.StrType)le.ms_fund_lmos),
    Fields.InValid_ms_fund_omos((SALT311.StrType)le.ms_fund_omos),
    Fields.InValid_ms_fund_pmos((SALT311.StrType)le.ms_fund_pmos),
    Fields.InValid_ms_fund_totords((SALT311.StrType)le.ms_fund_totords),
    Fields.InValid_ms_fund_totdlrs((SALT311.StrType)le.ms_fund_totdlrs),
    Fields.InValid_ms_fund_avgdlrs((SALT311.StrType)le.ms_fund_avgdlrs),
    Fields.InValid_ms_fund_lastdlrs((SALT311.StrType)le.ms_fund_lastdlrs),
    Fields.InValid_ms_fund_paystat_paid((SALT311.StrType)le.ms_fund_paystat_paid),
    Fields.InValid_ms_other((SALT311.StrType)le.ms_other),
    Fields.InValid_ms_continuity((SALT311.StrType)le.ms_continuity),
    Fields.InValid_ms_cont_status_active((SALT311.StrType)le.ms_cont_status_active),
    Fields.InValid_ms_cont_status_cancel((SALT311.StrType)le.ms_cont_status_cancel),
    Fields.InValid_ms_cont_omos((SALT311.StrType)le.ms_cont_omos),
    Fields.InValid_ms_cont_lmos((SALT311.StrType)le.ms_cont_lmos),
    Fields.InValid_ms_cont_pmos((SALT311.StrType)le.ms_cont_pmos),
    Fields.InValid_ms_cont_totords((SALT311.StrType)le.ms_cont_totords),
    Fields.InValid_ms_cont_totdlrs((SALT311.StrType)le.ms_cont_totdlrs),
    Fields.InValid_ms_cont_avgdlrs((SALT311.StrType)le.ms_cont_avgdlrs),
    Fields.InValid_ms_cont_lastdlrs((SALT311.StrType)le.ms_cont_lastdlrs),
    Fields.InValid_ms_cont_paystat_paid((SALT311.StrType)le.ms_cont_paystat_paid),
    Fields.InValid_ms_cont_paymeth_cc((SALT311.StrType)le.ms_cont_paymeth_cc),
    Fields.InValid_ms_cont_paymeth_cash((SALT311.StrType)le.ms_cont_paymeth_cash),
    Fields.InValid_ms_totords((SALT311.StrType)le.ms_totords),
    Fields.InValid_ms_totitems((SALT311.StrType)le.ms_totitems),
    Fields.InValid_ms_totdlrs((SALT311.StrType)le.ms_totdlrs),
    Fields.InValid_ms_avgdlrs((SALT311.StrType)le.ms_avgdlrs),
    Fields.InValid_ms_lastdlrs((SALT311.StrType)le.ms_lastdlrs),
    Fields.InValid_ms_paystat_paid((SALT311.StrType)le.ms_paystat_paid),
    Fields.InValid_ms_paymeth_cc((SALT311.StrType)le.ms_paymeth_cc),
    Fields.InValid_ms_paymeth_cash((SALT311.StrType)le.ms_paymeth_cash),
    Fields.InValid_ms_osrc_dm((SALT311.StrType)le.ms_osrc_dm),
    Fields.InValid_ms_lsrc_dm((SALT311.StrType)le.ms_lsrc_dm),
    Fields.InValid_ms_osrc_tm((SALT311.StrType)le.ms_osrc_tm),
    Fields.InValid_ms_lsrc_tm((SALT311.StrType)le.ms_lsrc_tm),
    Fields.InValid_ms_osrc_ins((SALT311.StrType)le.ms_osrc_ins),
    Fields.InValid_ms_lsrc_ins((SALT311.StrType)le.ms_lsrc_ins),
    Fields.InValid_ms_osrc_net((SALT311.StrType)le.ms_osrc_net),
    Fields.InValid_ms_lsrc_net((SALT311.StrType)le.ms_lsrc_net),
    Fields.InValid_ms_osrc_tv((SALT311.StrType)le.ms_osrc_tv),
    Fields.InValid_ms_lsrc_tv((SALT311.StrType)le.ms_lsrc_tv),
    Fields.InValid_ms_osrc_retail((SALT311.StrType)le.ms_osrc_retail),
    Fields.InValid_ms_lsrc_retail((SALT311.StrType)le.ms_lsrc_retail),
    Fields.InValid_ms_giftgivr((SALT311.StrType)le.ms_giftgivr),
    Fields.InValid_ms_giftee((SALT311.StrType)le.ms_giftee),
    Fields.InValid_ms_adult((SALT311.StrType)le.ms_adult),
    Fields.InValid_ms_womapp((SALT311.StrType)le.ms_womapp),
    Fields.InValid_ms_menapp((SALT311.StrType)le.ms_menapp),
    Fields.InValid_ms_kidapp((SALT311.StrType)le.ms_kidapp),
    Fields.InValid_ms_accessory((SALT311.StrType)le.ms_accessory),
    Fields.InValid_ms_apparel((SALT311.StrType)le.ms_apparel),
    Fields.InValid_ms_app_lmos((SALT311.StrType)le.ms_app_lmos),
    Fields.InValid_ms_app_omos((SALT311.StrType)le.ms_app_omos),
    Fields.InValid_ms_app_pmos((SALT311.StrType)le.ms_app_pmos),
    Fields.InValid_ms_app_totords((SALT311.StrType)le.ms_app_totords),
    Fields.InValid_ms_app_totitems((SALT311.StrType)le.ms_app_totitems),
    Fields.InValid_ms_app_totdlrs((SALT311.StrType)le.ms_app_totdlrs),
    Fields.InValid_ms_app_avgdlrs((SALT311.StrType)le.ms_app_avgdlrs),
    Fields.InValid_ms_app_lastdlrs((SALT311.StrType)le.ms_app_lastdlrs),
    Fields.InValid_ms_app_paystat_paid((SALT311.StrType)le.ms_app_paystat_paid),
    Fields.InValid_ms_app_paymeth_cc((SALT311.StrType)le.ms_app_paymeth_cc),
    Fields.InValid_ms_app_paymeth_cash((SALT311.StrType)le.ms_app_paymeth_cash),
    Fields.InValid_ms_menfash((SALT311.StrType)le.ms_menfash),
    Fields.InValid_ms_womfash((SALT311.StrType)le.ms_womfash),
    Fields.InValid_ms_wfsh_lmos((SALT311.StrType)le.ms_wfsh_lmos),
    Fields.InValid_ms_wfsh_omos((SALT311.StrType)le.ms_wfsh_omos),
    Fields.InValid_ms_wfsh_pmos((SALT311.StrType)le.ms_wfsh_pmos),
    Fields.InValid_ms_wfsh_totords((SALT311.StrType)le.ms_wfsh_totords),
    Fields.InValid_ms_wfsh_totdlrs((SALT311.StrType)le.ms_wfsh_totdlrs),
    Fields.InValid_ms_wfsh_avgdlrs((SALT311.StrType)le.ms_wfsh_avgdlrs),
    Fields.InValid_ms_wfsh_lastdlrs((SALT311.StrType)le.ms_wfsh_lastdlrs),
    Fields.InValid_ms_wfsh_paystat_paid((SALT311.StrType)le.ms_wfsh_paystat_paid),
    Fields.InValid_ms_wfsh_osrc_dm((SALT311.StrType)le.ms_wfsh_osrc_dm),
    Fields.InValid_ms_wfsh_lsrc_dm((SALT311.StrType)le.ms_wfsh_lsrc_dm),
    Fields.InValid_ms_wfsh_osrc_agt((SALT311.StrType)le.ms_wfsh_osrc_agt),
    Fields.InValid_ms_wfsh_lsrc_agt((SALT311.StrType)le.ms_wfsh_lsrc_agt),
    Fields.InValid_ms_audio((SALT311.StrType)le.ms_audio),
    Fields.InValid_ms_auto((SALT311.StrType)le.ms_auto),
    Fields.InValid_ms_aviation((SALT311.StrType)le.ms_aviation),
    Fields.InValid_ms_bargains((SALT311.StrType)le.ms_bargains),
    Fields.InValid_ms_beauty((SALT311.StrType)le.ms_beauty),
    Fields.InValid_ms_bible((SALT311.StrType)le.ms_bible),
    Fields.InValid_ms_bible_lmos((SALT311.StrType)le.ms_bible_lmos),
    Fields.InValid_ms_bible_omos((SALT311.StrType)le.ms_bible_omos),
    Fields.InValid_ms_bible_pmos((SALT311.StrType)le.ms_bible_pmos),
    Fields.InValid_ms_bible_totords((SALT311.StrType)le.ms_bible_totords),
    Fields.InValid_ms_bible_totitems((SALT311.StrType)le.ms_bible_totitems),
    Fields.InValid_ms_bible_totdlrs((SALT311.StrType)le.ms_bible_totdlrs),
    Fields.InValid_ms_bible_avgdlrs((SALT311.StrType)le.ms_bible_avgdlrs),
    Fields.InValid_ms_bible_lastdlrs((SALT311.StrType)le.ms_bible_lastdlrs),
    Fields.InValid_ms_bible_paystat_paid((SALT311.StrType)le.ms_bible_paystat_paid),
    Fields.InValid_ms_bible_paymeth_cc((SALT311.StrType)le.ms_bible_paymeth_cc),
    Fields.InValid_ms_bible_paymeth_cash((SALT311.StrType)le.ms_bible_paymeth_cash),
    Fields.InValid_ms_business((SALT311.StrType)le.ms_business),
    Fields.InValid_ms_collectibles((SALT311.StrType)le.ms_collectibles),
    Fields.InValid_ms_computers((SALT311.StrType)le.ms_computers),
    Fields.InValid_ms_crafts((SALT311.StrType)le.ms_crafts),
    Fields.InValid_ms_culturearts((SALT311.StrType)le.ms_culturearts),
    Fields.InValid_ms_currevent((SALT311.StrType)le.ms_currevent),
    Fields.InValid_ms_diy((SALT311.StrType)le.ms_diy),
    Fields.InValid_ms_electronics((SALT311.StrType)le.ms_electronics),
    Fields.InValid_ms_equestrian((SALT311.StrType)le.ms_equestrian),
    Fields.InValid_ms_pub_family((SALT311.StrType)le.ms_pub_family),
    Fields.InValid_ms_cat_family((SALT311.StrType)le.ms_cat_family),
    Fields.InValid_ms_family((SALT311.StrType)le.ms_family),
    Fields.InValid_ms_family_lmos((SALT311.StrType)le.ms_family_lmos),
    Fields.InValid_ms_family_omos((SALT311.StrType)le.ms_family_omos),
    Fields.InValid_ms_family_pmos((SALT311.StrType)le.ms_family_pmos),
    Fields.InValid_ms_family_totords((SALT311.StrType)le.ms_family_totords),
    Fields.InValid_ms_family_totitems((SALT311.StrType)le.ms_family_totitems),
    Fields.InValid_ms_family_totdlrs((SALT311.StrType)le.ms_family_totdlrs),
    Fields.InValid_ms_family_avgdlrs((SALT311.StrType)le.ms_family_avgdlrs),
    Fields.InValid_ms_family_lastdlrs((SALT311.StrType)le.ms_family_lastdlrs),
    Fields.InValid_ms_family_paystat_paid((SALT311.StrType)le.ms_family_paystat_paid),
    Fields.InValid_ms_family_paymeth_cc((SALT311.StrType)le.ms_family_paymeth_cc),
    Fields.InValid_ms_family_paymeth_cash((SALT311.StrType)le.ms_family_paymeth_cash),
    Fields.InValid_ms_family_osrc_dm((SALT311.StrType)le.ms_family_osrc_dm),
    Fields.InValid_ms_family_lsrc_dm((SALT311.StrType)le.ms_family_lsrc_dm),
    Fields.InValid_ms_fiction((SALT311.StrType)le.ms_fiction),
    Fields.InValid_ms_food((SALT311.StrType)le.ms_food),
    Fields.InValid_ms_games((SALT311.StrType)le.ms_games),
    Fields.InValid_ms_gifts((SALT311.StrType)le.ms_gifts),
    Fields.InValid_ms_gourmet((SALT311.StrType)le.ms_gourmet),
    Fields.InValid_ms_fitness((SALT311.StrType)le.ms_fitness),
    Fields.InValid_ms_health((SALT311.StrType)le.ms_health),
    Fields.InValid_ms_hlth_lmos((SALT311.StrType)le.ms_hlth_lmos),
    Fields.InValid_ms_hlth_omos((SALT311.StrType)le.ms_hlth_omos),
    Fields.InValid_ms_hlth_pmos((SALT311.StrType)le.ms_hlth_pmos),
    Fields.InValid_ms_hlth_totords((SALT311.StrType)le.ms_hlth_totords),
    Fields.InValid_ms_hlth_totdlrs((SALT311.StrType)le.ms_hlth_totdlrs),
    Fields.InValid_ms_hlth_avgdlrs((SALT311.StrType)le.ms_hlth_avgdlrs),
    Fields.InValid_ms_hlth_lastdlrs((SALT311.StrType)le.ms_hlth_lastdlrs),
    Fields.InValid_ms_hlth_paystat_paid((SALT311.StrType)le.ms_hlth_paystat_paid),
    Fields.InValid_ms_hlth_paymeth_cc((SALT311.StrType)le.ms_hlth_paymeth_cc),
    Fields.InValid_ms_hlth_osrc_dm((SALT311.StrType)le.ms_hlth_osrc_dm),
    Fields.InValid_ms_hlth_lsrc_dm((SALT311.StrType)le.ms_hlth_lsrc_dm),
    Fields.InValid_ms_hlth_osrc_agt((SALT311.StrType)le.ms_hlth_osrc_agt),
    Fields.InValid_ms_hlth_lsrc_agt((SALT311.StrType)le.ms_hlth_lsrc_agt),
    Fields.InValid_ms_hlth_osrc_tv((SALT311.StrType)le.ms_hlth_osrc_tv),
    Fields.InValid_ms_hlth_lsrc_tv((SALT311.StrType)le.ms_hlth_lsrc_tv),
    Fields.InValid_ms_holiday((SALT311.StrType)le.ms_holiday),
    Fields.InValid_ms_history((SALT311.StrType)le.ms_history),
    Fields.InValid_ms_pub_cooking((SALT311.StrType)le.ms_pub_cooking),
    Fields.InValid_ms_cooking((SALT311.StrType)le.ms_cooking),
    Fields.InValid_ms_pub_homedecr((SALT311.StrType)le.ms_pub_homedecr),
    Fields.InValid_ms_cat_homedecr((SALT311.StrType)le.ms_cat_homedecr),
    Fields.InValid_ms_homedecr((SALT311.StrType)le.ms_homedecr),
    Fields.InValid_ms_housewares((SALT311.StrType)le.ms_housewares),
    Fields.InValid_ms_pub_garden((SALT311.StrType)le.ms_pub_garden),
    Fields.InValid_ms_cat_garden((SALT311.StrType)le.ms_cat_garden),
    Fields.InValid_ms_garden((SALT311.StrType)le.ms_garden),
    Fields.InValid_ms_pub_homeliv((SALT311.StrType)le.ms_pub_homeliv),
    Fields.InValid_ms_cat_homeliv((SALT311.StrType)le.ms_cat_homeliv),
    Fields.InValid_ms_homeliv((SALT311.StrType)le.ms_homeliv),
    Fields.InValid_ms_pub_home_status_active((SALT311.StrType)le.ms_pub_home_status_active),
    Fields.InValid_ms_home_lmos((SALT311.StrType)le.ms_home_lmos),
    Fields.InValid_ms_home_omos((SALT311.StrType)le.ms_home_omos),
    Fields.InValid_ms_home_pmos((SALT311.StrType)le.ms_home_pmos),
    Fields.InValid_ms_home_totords((SALT311.StrType)le.ms_home_totords),
    Fields.InValid_ms_home_totitems((SALT311.StrType)le.ms_home_totitems),
    Fields.InValid_ms_home_totdlrs((SALT311.StrType)le.ms_home_totdlrs),
    Fields.InValid_ms_home_avgdlrs((SALT311.StrType)le.ms_home_avgdlrs),
    Fields.InValid_ms_home_lastdlrs((SALT311.StrType)le.ms_home_lastdlrs),
    Fields.InValid_ms_home_paystat_paid((SALT311.StrType)le.ms_home_paystat_paid),
    Fields.InValid_ms_home_paymeth_cc((SALT311.StrType)le.ms_home_paymeth_cc),
    Fields.InValid_ms_home_paymeth_cash((SALT311.StrType)le.ms_home_paymeth_cash),
    Fields.InValid_ms_home_osrc_dm((SALT311.StrType)le.ms_home_osrc_dm),
    Fields.InValid_ms_home_lsrc_dm((SALT311.StrType)le.ms_home_lsrc_dm),
    Fields.InValid_ms_home_osrc_agt((SALT311.StrType)le.ms_home_osrc_agt),
    Fields.InValid_ms_home_lsrc_agt((SALT311.StrType)le.ms_home_lsrc_agt),
    Fields.InValid_ms_home_osrc_net((SALT311.StrType)le.ms_home_osrc_net),
    Fields.InValid_ms_home_lsrc_net((SALT311.StrType)le.ms_home_lsrc_net),
    Fields.InValid_ms_home_osrc_tv((SALT311.StrType)le.ms_home_osrc_tv),
    Fields.InValid_ms_home_lsrc_tv((SALT311.StrType)le.ms_home_lsrc_tv),
    Fields.InValid_ms_humor((SALT311.StrType)le.ms_humor),
    Fields.InValid_ms_inspiration((SALT311.StrType)le.ms_inspiration),
    Fields.InValid_ms_merchandise((SALT311.StrType)le.ms_merchandise),
    Fields.InValid_ms_moneymaking((SALT311.StrType)le.ms_moneymaking),
    Fields.InValid_ms_moneymaking_lmos((SALT311.StrType)le.ms_moneymaking_lmos),
    Fields.InValid_ms_motorcycles((SALT311.StrType)le.ms_motorcycles),
    Fields.InValid_ms_music((SALT311.StrType)le.ms_music),
    Fields.InValid_ms_fishing((SALT311.StrType)le.ms_fishing),
    Fields.InValid_ms_hunting((SALT311.StrType)le.ms_hunting),
    Fields.InValid_ms_boatsail((SALT311.StrType)le.ms_boatsail),
    Fields.InValid_ms_camp((SALT311.StrType)le.ms_camp),
    Fields.InValid_ms_pub_outdoors((SALT311.StrType)le.ms_pub_outdoors),
    Fields.InValid_ms_cat_outdoors((SALT311.StrType)le.ms_cat_outdoors),
    Fields.InValid_ms_outdoors((SALT311.StrType)le.ms_outdoors),
    Fields.InValid_ms_pub_out_status_active((SALT311.StrType)le.ms_pub_out_status_active),
    Fields.InValid_ms_out_lmos((SALT311.StrType)le.ms_out_lmos),
    Fields.InValid_ms_out_omos((SALT311.StrType)le.ms_out_omos),
    Fields.InValid_ms_out_pmos((SALT311.StrType)le.ms_out_pmos),
    Fields.InValid_ms_out_totords((SALT311.StrType)le.ms_out_totords),
    Fields.InValid_ms_out_totitems((SALT311.StrType)le.ms_out_totitems),
    Fields.InValid_ms_out_totdlrs((SALT311.StrType)le.ms_out_totdlrs),
    Fields.InValid_ms_out_avgdlrs((SALT311.StrType)le.ms_out_avgdlrs),
    Fields.InValid_ms_out_lastdlrs((SALT311.StrType)le.ms_out_lastdlrs),
    Fields.InValid_ms_out_paystat_paid((SALT311.StrType)le.ms_out_paystat_paid),
    Fields.InValid_ms_out_paymeth_cc((SALT311.StrType)le.ms_out_paymeth_cc),
    Fields.InValid_ms_out_paymeth_cash((SALT311.StrType)le.ms_out_paymeth_cash),
    Fields.InValid_ms_out_osrc_dm((SALT311.StrType)le.ms_out_osrc_dm),
    Fields.InValid_ms_out_lsrc_dm((SALT311.StrType)le.ms_out_lsrc_dm),
    Fields.InValid_ms_out_osrc_agt((SALT311.StrType)le.ms_out_osrc_agt),
    Fields.InValid_ms_out_lsrc_agt((SALT311.StrType)le.ms_out_lsrc_agt),
    Fields.InValid_ms_pets((SALT311.StrType)le.ms_pets),
    Fields.InValid_ms_pfin((SALT311.StrType)le.ms_pfin),
    Fields.InValid_ms_photo((SALT311.StrType)le.ms_photo),
    Fields.InValid_ms_photoproc((SALT311.StrType)le.ms_photoproc),
    Fields.InValid_ms_rural((SALT311.StrType)le.ms_rural),
    Fields.InValid_ms_science((SALT311.StrType)le.ms_science),
    Fields.InValid_ms_sports((SALT311.StrType)le.ms_sports),
    Fields.InValid_ms_sports_lmos((SALT311.StrType)le.ms_sports_lmos),
    Fields.InValid_ms_travel((SALT311.StrType)le.ms_travel),
    Fields.InValid_ms_tvmovies((SALT311.StrType)le.ms_tvmovies),
    Fields.InValid_ms_wildlife((SALT311.StrType)le.ms_wildlife),
    Fields.InValid_ms_woman((SALT311.StrType)le.ms_woman),
    Fields.InValid_ms_woman_lmos((SALT311.StrType)le.ms_woman_lmos),
    Fields.InValid_ms_ringtones_apps((SALT311.StrType)le.ms_ringtones_apps),
    Fields.InValid_cpi_mobile_apps_index((SALT311.StrType)le.cpi_mobile_apps_index),
    Fields.InValid_cpi_credit_repair_index((SALT311.StrType)le.cpi_credit_repair_index),
    Fields.InValid_cpi_credit_report_index((SALT311.StrType)le.cpi_credit_report_index),
    Fields.InValid_cpi_education_seekers_index((SALT311.StrType)le.cpi_education_seekers_index),
    Fields.InValid_cpi_insurance_index((SALT311.StrType)le.cpi_insurance_index),
    Fields.InValid_cpi_insurance_health_index((SALT311.StrType)le.cpi_insurance_health_index),
    Fields.InValid_cpi_insurance_auto_index((SALT311.StrType)le.cpi_insurance_auto_index),
    Fields.InValid_cpi_job_seekers_index((SALT311.StrType)le.cpi_job_seekers_index),
    Fields.InValid_cpi_social_networking_index((SALT311.StrType)le.cpi_social_networking_index),
    Fields.InValid_cpi_adult_index((SALT311.StrType)le.cpi_adult_index),
    Fields.InValid_cpi_africanamerican_index((SALT311.StrType)le.cpi_africanamerican_index),
    Fields.InValid_cpi_apparel_index((SALT311.StrType)le.cpi_apparel_index),
    Fields.InValid_cpi_apparel_accessory_index((SALT311.StrType)le.cpi_apparel_accessory_index),
    Fields.InValid_cpi_apparel_kids_index((SALT311.StrType)le.cpi_apparel_kids_index),
    Fields.InValid_cpi_apparel_men_index((SALT311.StrType)le.cpi_apparel_men_index),
    Fields.InValid_cpi_apparel_menfash_index((SALT311.StrType)le.cpi_apparel_menfash_index),
    Fields.InValid_cpi_apparel_women_index((SALT311.StrType)le.cpi_apparel_women_index),
    Fields.InValid_cpi_apparel_womfash_index((SALT311.StrType)le.cpi_apparel_womfash_index),
    Fields.InValid_cpi_asian_index((SALT311.StrType)le.cpi_asian_index),
    Fields.InValid_cpi_auto_index((SALT311.StrType)le.cpi_auto_index),
    Fields.InValid_cpi_auto_racing_index((SALT311.StrType)le.cpi_auto_racing_index),
    Fields.InValid_cpi_auto_trucks_index((SALT311.StrType)le.cpi_auto_trucks_index),
    Fields.InValid_cpi_aviation_index((SALT311.StrType)le.cpi_aviation_index),
    Fields.InValid_cpi_bargains_index((SALT311.StrType)le.cpi_bargains_index),
    Fields.InValid_cpi_beauty_index((SALT311.StrType)le.cpi_beauty_index),
    Fields.InValid_cpi_bible_index((SALT311.StrType)le.cpi_bible_index),
    Fields.InValid_cpi_birds_index((SALT311.StrType)le.cpi_birds_index),
    Fields.InValid_cpi_business_index((SALT311.StrType)le.cpi_business_index),
    Fields.InValid_cpi_business_homeoffice_index((SALT311.StrType)le.cpi_business_homeoffice_index),
    Fields.InValid_cpi_catalog_index((SALT311.StrType)le.cpi_catalog_index),
    Fields.InValid_cpi_cc_index((SALT311.StrType)le.cpi_cc_index),
    Fields.InValid_cpi_collectibles_index((SALT311.StrType)le.cpi_collectibles_index),
    Fields.InValid_cpi_college_index((SALT311.StrType)le.cpi_college_index),
    Fields.InValid_cpi_computers_index((SALT311.StrType)le.cpi_computers_index),
    Fields.InValid_cpi_conservative_index((SALT311.StrType)le.cpi_conservative_index),
    Fields.InValid_cpi_continuity_index((SALT311.StrType)le.cpi_continuity_index),
    Fields.InValid_cpi_cooking_index((SALT311.StrType)le.cpi_cooking_index),
    Fields.InValid_cpi_crafts_index((SALT311.StrType)le.cpi_crafts_index),
    Fields.InValid_cpi_crafts_crochet_index((SALT311.StrType)le.cpi_crafts_crochet_index),
    Fields.InValid_cpi_crafts_knit_index((SALT311.StrType)le.cpi_crafts_knit_index),
    Fields.InValid_cpi_crafts_needlepoint_index((SALT311.StrType)le.cpi_crafts_needlepoint_index),
    Fields.InValid_cpi_crafts_quilt_index((SALT311.StrType)le.cpi_crafts_quilt_index),
    Fields.InValid_cpi_crafts_sew_index((SALT311.StrType)le.cpi_crafts_sew_index),
    Fields.InValid_cpi_culturearts_index((SALT311.StrType)le.cpi_culturearts_index),
    Fields.InValid_cpi_currevent_index((SALT311.StrType)le.cpi_currevent_index),
    Fields.InValid_cpi_diy_index((SALT311.StrType)le.cpi_diy_index),
    Fields.InValid_cpi_donor_index((SALT311.StrType)le.cpi_donor_index),
    Fields.InValid_cpi_ego_index((SALT311.StrType)le.cpi_ego_index),
    Fields.InValid_cpi_electronics_index((SALT311.StrType)le.cpi_electronics_index),
    Fields.InValid_cpi_equestrian_index((SALT311.StrType)le.cpi_equestrian_index),
    Fields.InValid_cpi_family_index((SALT311.StrType)le.cpi_family_index),
    Fields.InValid_cpi_family_teen_index((SALT311.StrType)le.cpi_family_teen_index),
    Fields.InValid_cpi_family_young_index((SALT311.StrType)le.cpi_family_young_index),
    Fields.InValid_cpi_fiction_index((SALT311.StrType)le.cpi_fiction_index),
    Fields.InValid_cpi_gambling_index((SALT311.StrType)le.cpi_gambling_index),
    Fields.InValid_cpi_games_index((SALT311.StrType)le.cpi_games_index),
    Fields.InValid_cpi_gardening_index((SALT311.StrType)le.cpi_gardening_index),
    Fields.InValid_cpi_gay_index((SALT311.StrType)le.cpi_gay_index),
    Fields.InValid_cpi_giftgivr_index((SALT311.StrType)le.cpi_giftgivr_index),
    Fields.InValid_cpi_gourmet_index((SALT311.StrType)le.cpi_gourmet_index),
    Fields.InValid_cpi_grandparents_index((SALT311.StrType)le.cpi_grandparents_index),
    Fields.InValid_cpi_health_index((SALT311.StrType)le.cpi_health_index),
    Fields.InValid_cpi_health_diet_index((SALT311.StrType)le.cpi_health_diet_index),
    Fields.InValid_cpi_health_fitness_index((SALT311.StrType)le.cpi_health_fitness_index),
    Fields.InValid_cpi_hightech_index((SALT311.StrType)le.cpi_hightech_index),
    Fields.InValid_cpi_hispanic_index((SALT311.StrType)le.cpi_hispanic_index),
    Fields.InValid_cpi_history_index((SALT311.StrType)le.cpi_history_index),
    Fields.InValid_cpi_history_american_index((SALT311.StrType)le.cpi_history_american_index),
    Fields.InValid_cpi_hobbies_index((SALT311.StrType)le.cpi_hobbies_index),
    Fields.InValid_cpi_homedecr_index((SALT311.StrType)le.cpi_homedecr_index),
    Fields.InValid_cpi_homeliv_index((SALT311.StrType)le.cpi_homeliv_index),
    Fields.InValid_cpi_humor_index((SALT311.StrType)le.cpi_humor_index),
    Fields.InValid_cpi_inspiration_index((SALT311.StrType)le.cpi_inspiration_index),
    Fields.InValid_cpi_internet_index((SALT311.StrType)le.cpi_internet_index),
    Fields.InValid_cpi_internet_access_index((SALT311.StrType)le.cpi_internet_access_index),
    Fields.InValid_cpi_internet_buy_index((SALT311.StrType)le.cpi_internet_buy_index),
    Fields.InValid_cpi_liberal_index((SALT311.StrType)le.cpi_liberal_index),
    Fields.InValid_cpi_moneymaking_index((SALT311.StrType)le.cpi_moneymaking_index),
    Fields.InValid_cpi_motorcycles_index((SALT311.StrType)le.cpi_motorcycles_index),
    Fields.InValid_cpi_music_index((SALT311.StrType)le.cpi_music_index),
    Fields.InValid_cpi_nonfiction_index((SALT311.StrType)le.cpi_nonfiction_index),
    Fields.InValid_cpi_ocean_index((SALT311.StrType)le.cpi_ocean_index),
    Fields.InValid_cpi_outdoors_index((SALT311.StrType)le.cpi_outdoors_index),
    Fields.InValid_cpi_outdoors_boatsail_index((SALT311.StrType)le.cpi_outdoors_boatsail_index),
    Fields.InValid_cpi_outdoors_camp_index((SALT311.StrType)le.cpi_outdoors_camp_index),
    Fields.InValid_cpi_outdoors_fishing_index((SALT311.StrType)le.cpi_outdoors_fishing_index),
    Fields.InValid_cpi_outdoors_huntfish_index((SALT311.StrType)le.cpi_outdoors_huntfish_index),
    Fields.InValid_cpi_outdoors_hunting_index((SALT311.StrType)le.cpi_outdoors_hunting_index),
    Fields.InValid_cpi_pets_index((SALT311.StrType)le.cpi_pets_index),
    Fields.InValid_cpi_pets_cats_index((SALT311.StrType)le.cpi_pets_cats_index),
    Fields.InValid_cpi_pets_dogs_index((SALT311.StrType)le.cpi_pets_dogs_index),
    Fields.InValid_cpi_pfin_index((SALT311.StrType)le.cpi_pfin_index),
    Fields.InValid_cpi_photog_index((SALT311.StrType)le.cpi_photog_index),
    Fields.InValid_cpi_photoproc_index((SALT311.StrType)le.cpi_photoproc_index),
    Fields.InValid_cpi_publish_index((SALT311.StrType)le.cpi_publish_index),
    Fields.InValid_cpi_publish_books_index((SALT311.StrType)le.cpi_publish_books_index),
    Fields.InValid_cpi_publish_mags_index((SALT311.StrType)le.cpi_publish_mags_index),
    Fields.InValid_cpi_rural_index((SALT311.StrType)le.cpi_rural_index),
    Fields.InValid_cpi_science_index((SALT311.StrType)le.cpi_science_index),
    Fields.InValid_cpi_scifi_index((SALT311.StrType)le.cpi_scifi_index),
    Fields.InValid_cpi_seniors_index((SALT311.StrType)le.cpi_seniors_index),
    Fields.InValid_cpi_sports_index((SALT311.StrType)le.cpi_sports_index),
    Fields.InValid_cpi_sports_baseball_index((SALT311.StrType)le.cpi_sports_baseball_index),
    Fields.InValid_cpi_sports_basketball_index((SALT311.StrType)le.cpi_sports_basketball_index),
    Fields.InValid_cpi_sports_biking_index((SALT311.StrType)le.cpi_sports_biking_index),
    Fields.InValid_cpi_sports_football_index((SALT311.StrType)le.cpi_sports_football_index),
    Fields.InValid_cpi_sports_golf_index((SALT311.StrType)le.cpi_sports_golf_index),
    Fields.InValid_cpi_sports_hockey_index((SALT311.StrType)le.cpi_sports_hockey_index),
    Fields.InValid_cpi_sports_running_index((SALT311.StrType)le.cpi_sports_running_index),
    Fields.InValid_cpi_sports_ski_index((SALT311.StrType)le.cpi_sports_ski_index),
    Fields.InValid_cpi_sports_soccer_index((SALT311.StrType)le.cpi_sports_soccer_index),
    Fields.InValid_cpi_sports_swimming_index((SALT311.StrType)le.cpi_sports_swimming_index),
    Fields.InValid_cpi_sports_tennis_index((SALT311.StrType)le.cpi_sports_tennis_index),
    Fields.InValid_cpi_stationery_index((SALT311.StrType)le.cpi_stationery_index),
    Fields.InValid_cpi_sweeps_index((SALT311.StrType)le.cpi_sweeps_index),
    Fields.InValid_cpi_tobacco_index((SALT311.StrType)le.cpi_tobacco_index),
    Fields.InValid_cpi_travel_index((SALT311.StrType)le.cpi_travel_index),
    Fields.InValid_cpi_travel_cruise_index((SALT311.StrType)le.cpi_travel_cruise_index),
    Fields.InValid_cpi_travel_rv_index((SALT311.StrType)le.cpi_travel_rv_index),
    Fields.InValid_cpi_travel_us_index((SALT311.StrType)le.cpi_travel_us_index),
    Fields.InValid_cpi_tvmovies_index((SALT311.StrType)le.cpi_tvmovies_index),
    Fields.InValid_cpi_wildlife_index((SALT311.StrType)le.cpi_wildlife_index),
    Fields.InValid_cpi_woman_index((SALT311.StrType)le.cpi_woman_index),
    Fields.InValid_totdlr_index((SALT311.StrType)le.totdlr_index),
    Fields.InValid_cpi_totdlr((SALT311.StrType)le.cpi_totdlr),
    Fields.InValid_cpi_totords((SALT311.StrType)le.cpi_totords),
    Fields.InValid_cpi_lastdlr((SALT311.StrType)le.cpi_lastdlr),
    Fields.InValid_pkcatg((SALT311.StrType)le.pkcatg),
    Fields.InValid_pkpubs((SALT311.StrType)le.pkpubs),
    Fields.InValid_pkcont((SALT311.StrType)le.pkcont),
    Fields.InValid_pkca01((SALT311.StrType)le.pkca01),
    Fields.InValid_pkca03((SALT311.StrType)le.pkca03),
    Fields.InValid_pkca04((SALT311.StrType)le.pkca04),
    Fields.InValid_pkca05((SALT311.StrType)le.pkca05),
    Fields.InValid_pkca06((SALT311.StrType)le.pkca06),
    Fields.InValid_pkca07((SALT311.StrType)le.pkca07),
    Fields.InValid_pkca08((SALT311.StrType)le.pkca08),
    Fields.InValid_pkca09((SALT311.StrType)le.pkca09),
    Fields.InValid_pkca10((SALT311.StrType)le.pkca10),
    Fields.InValid_pkca11((SALT311.StrType)le.pkca11),
    Fields.InValid_pkca12((SALT311.StrType)le.pkca12),
    Fields.InValid_pkca13((SALT311.StrType)le.pkca13),
    Fields.InValid_pkca14((SALT311.StrType)le.pkca14),
    Fields.InValid_pkca15((SALT311.StrType)le.pkca15),
    Fields.InValid_pkca16((SALT311.StrType)le.pkca16),
    Fields.InValid_pkca17((SALT311.StrType)le.pkca17),
    Fields.InValid_pkca18((SALT311.StrType)le.pkca18),
    Fields.InValid_pkca20((SALT311.StrType)le.pkca20),
    Fields.InValid_pkca21((SALT311.StrType)le.pkca21),
    Fields.InValid_pkca22((SALT311.StrType)le.pkca22),
    Fields.InValid_pkca23((SALT311.StrType)le.pkca23),
    Fields.InValid_pkca24((SALT311.StrType)le.pkca24),
    Fields.InValid_pkca25((SALT311.StrType)le.pkca25),
    Fields.InValid_pkca26((SALT311.StrType)le.pkca26),
    Fields.InValid_pkca28((SALT311.StrType)le.pkca28),
    Fields.InValid_pkca29((SALT311.StrType)le.pkca29),
    Fields.InValid_pkca30((SALT311.StrType)le.pkca30),
    Fields.InValid_pkca31((SALT311.StrType)le.pkca31),
    Fields.InValid_pkca32((SALT311.StrType)le.pkca32),
    Fields.InValid_pkca33((SALT311.StrType)le.pkca33),
    Fields.InValid_pkca34((SALT311.StrType)le.pkca34),
    Fields.InValid_pkca35((SALT311.StrType)le.pkca35),
    Fields.InValid_pkca36((SALT311.StrType)le.pkca36),
    Fields.InValid_pkca37((SALT311.StrType)le.pkca37),
    Fields.InValid_pkca39((SALT311.StrType)le.pkca39),
    Fields.InValid_pkca40((SALT311.StrType)le.pkca40),
    Fields.InValid_pkca41((SALT311.StrType)le.pkca41),
    Fields.InValid_pkca42((SALT311.StrType)le.pkca42),
    Fields.InValid_pkca54((SALT311.StrType)le.pkca54),
    Fields.InValid_pkca61((SALT311.StrType)le.pkca61),
    Fields.InValid_pkca62((SALT311.StrType)le.pkca62),
    Fields.InValid_pkca64((SALT311.StrType)le.pkca64),
    Fields.InValid_pkpu01((SALT311.StrType)le.pkpu01),
    Fields.InValid_pkpu02((SALT311.StrType)le.pkpu02),
    Fields.InValid_pkpu03((SALT311.StrType)le.pkpu03),
    Fields.InValid_pkpu04((SALT311.StrType)le.pkpu04),
    Fields.InValid_pkpu05((SALT311.StrType)le.pkpu05),
    Fields.InValid_pkpu06((SALT311.StrType)le.pkpu06),
    Fields.InValid_pkpu07((SALT311.StrType)le.pkpu07),
    Fields.InValid_pkpu08((SALT311.StrType)le.pkpu08),
    Fields.InValid_pkpu09((SALT311.StrType)le.pkpu09),
    Fields.InValid_pkpu10((SALT311.StrType)le.pkpu10),
    Fields.InValid_pkpu11((SALT311.StrType)le.pkpu11),
    Fields.InValid_pkpu12((SALT311.StrType)le.pkpu12),
    Fields.InValid_pkpu13((SALT311.StrType)le.pkpu13),
    Fields.InValid_pkpu14((SALT311.StrType)le.pkpu14),
    Fields.InValid_pkpu15((SALT311.StrType)le.pkpu15),
    Fields.InValid_pkpu16((SALT311.StrType)le.pkpu16),
    Fields.InValid_pkpu17((SALT311.StrType)le.pkpu17),
    Fields.InValid_pkpu18((SALT311.StrType)le.pkpu18),
    Fields.InValid_pkpu19((SALT311.StrType)le.pkpu19),
    Fields.InValid_pkpu20((SALT311.StrType)le.pkpu20),
    Fields.InValid_pkpu23((SALT311.StrType)le.pkpu23),
    Fields.InValid_pkpu25((SALT311.StrType)le.pkpu25),
    Fields.InValid_pkpu27((SALT311.StrType)le.pkpu27),
    Fields.InValid_pkpu28((SALT311.StrType)le.pkpu28),
    Fields.InValid_pkpu29((SALT311.StrType)le.pkpu29),
    Fields.InValid_pkpu30((SALT311.StrType)le.pkpu30),
    Fields.InValid_pkpu31((SALT311.StrType)le.pkpu31),
    Fields.InValid_pkpu32((SALT311.StrType)le.pkpu32),
    Fields.InValid_pkpu33((SALT311.StrType)le.pkpu33),
    Fields.InValid_pkpu34((SALT311.StrType)le.pkpu34),
    Fields.InValid_pkpu35((SALT311.StrType)le.pkpu35),
    Fields.InValid_pkpu38((SALT311.StrType)le.pkpu38),
    Fields.InValid_pkpu41((SALT311.StrType)le.pkpu41),
    Fields.InValid_pkpu42((SALT311.StrType)le.pkpu42),
    Fields.InValid_pkpu45((SALT311.StrType)le.pkpu45),
    Fields.InValid_pkpu46((SALT311.StrType)le.pkpu46),
    Fields.InValid_pkpu47((SALT311.StrType)le.pkpu47),
    Fields.InValid_pkpu48((SALT311.StrType)le.pkpu48),
    Fields.InValid_pkpu49((SALT311.StrType)le.pkpu49),
    Fields.InValid_pkpu50((SALT311.StrType)le.pkpu50),
    Fields.InValid_pkpu51((SALT311.StrType)le.pkpu51),
    Fields.InValid_pkpu52((SALT311.StrType)le.pkpu52),
    Fields.InValid_pkpu53((SALT311.StrType)le.pkpu53),
    Fields.InValid_pkpu54((SALT311.StrType)le.pkpu54),
    Fields.InValid_pkpu55((SALT311.StrType)le.pkpu55),
    Fields.InValid_pkpu56((SALT311.StrType)le.pkpu56),
    Fields.InValid_pkpu57((SALT311.StrType)le.pkpu57),
    Fields.InValid_pkpu60((SALT311.StrType)le.pkpu60),
    Fields.InValid_pkpu61((SALT311.StrType)le.pkpu61),
    Fields.InValid_pkpu62((SALT311.StrType)le.pkpu62),
    Fields.InValid_pkpu63((SALT311.StrType)le.pkpu63),
    Fields.InValid_pkpu64((SALT311.StrType)le.pkpu64),
    Fields.InValid_pkpu65((SALT311.StrType)le.pkpu65),
    Fields.InValid_pkpu66((SALT311.StrType)le.pkpu66),
    Fields.InValid_pkpu67((SALT311.StrType)le.pkpu67),
    Fields.InValid_pkpu68((SALT311.StrType)le.pkpu68),
    Fields.InValid_pkpu69((SALT311.StrType)le.pkpu69),
    Fields.InValid_pkpu70((SALT311.StrType)le.pkpu70),
    Fields.InValid_censpct_water((SALT311.StrType)le.censpct_water),
    Fields.InValid_cens_pop_density((SALT311.StrType)le.cens_pop_density),
    Fields.InValid_cens_hu_density((SALT311.StrType)le.cens_hu_density),
    Fields.InValid_censpct_pop_white((SALT311.StrType)le.censpct_pop_white),
    Fields.InValid_censpct_pop_black((SALT311.StrType)le.censpct_pop_black),
    Fields.InValid_censpct_pop_amerind((SALT311.StrType)le.censpct_pop_amerind),
    Fields.InValid_censpct_pop_asian((SALT311.StrType)le.censpct_pop_asian),
    Fields.InValid_censpct_pop_pacisl((SALT311.StrType)le.censpct_pop_pacisl),
    Fields.InValid_censpct_pop_othrace((SALT311.StrType)le.censpct_pop_othrace),
    Fields.InValid_censpct_pop_multirace((SALT311.StrType)le.censpct_pop_multirace),
    Fields.InValid_censpct_pop_hispanic((SALT311.StrType)le.censpct_pop_hispanic),
    Fields.InValid_censpct_pop_agelt18((SALT311.StrType)le.censpct_pop_agelt18),
    Fields.InValid_censpct_pop_males((SALT311.StrType)le.censpct_pop_males),
    Fields.InValid_censpct_adult_age1824((SALT311.StrType)le.censpct_adult_age1824),
    Fields.InValid_censpct_adult_age2534((SALT311.StrType)le.censpct_adult_age2534),
    Fields.InValid_censpct_adult_age3544((SALT311.StrType)le.censpct_adult_age3544),
    Fields.InValid_censpct_adult_age4554((SALT311.StrType)le.censpct_adult_age4554),
    Fields.InValid_censpct_adult_age5564((SALT311.StrType)le.censpct_adult_age5564),
    Fields.InValid_censpct_adult_agege65((SALT311.StrType)le.censpct_adult_agege65),
    Fields.InValid_cens_pop_medage((SALT311.StrType)le.cens_pop_medage),
    Fields.InValid_cens_hh_avgsize((SALT311.StrType)le.cens_hh_avgsize),
    Fields.InValid_censpct_hh_family((SALT311.StrType)le.censpct_hh_family),
    Fields.InValid_censpct_hh_family_husbwife((SALT311.StrType)le.censpct_hh_family_husbwife),
    Fields.InValid_censpct_hu_occupied((SALT311.StrType)le.censpct_hu_occupied),
    Fields.InValid_censpct_hu_owned((SALT311.StrType)le.censpct_hu_owned),
    Fields.InValid_censpct_hu_rented((SALT311.StrType)le.censpct_hu_rented),
    Fields.InValid_censpct_hu_vacantseasonal((SALT311.StrType)le.censpct_hu_vacantseasonal),
    Fields.InValid_zip_medinc((SALT311.StrType)le.zip_medinc),
    Fields.InValid_zip_apparel((SALT311.StrType)le.zip_apparel),
    Fields.InValid_zip_apparel_women((SALT311.StrType)le.zip_apparel_women),
    Fields.InValid_zip_apparel_womfash((SALT311.StrType)le.zip_apparel_womfash),
    Fields.InValid_zip_auto((SALT311.StrType)le.zip_auto),
    Fields.InValid_zip_beauty((SALT311.StrType)le.zip_beauty),
    Fields.InValid_zip_booksmusicmovies((SALT311.StrType)le.zip_booksmusicmovies),
    Fields.InValid_zip_business((SALT311.StrType)le.zip_business),
    Fields.InValid_zip_catalog((SALT311.StrType)le.zip_catalog),
    Fields.InValid_zip_cc((SALT311.StrType)le.zip_cc),
    Fields.InValid_zip_collectibles((SALT311.StrType)le.zip_collectibles),
    Fields.InValid_zip_computers((SALT311.StrType)le.zip_computers),
    Fields.InValid_zip_continuity((SALT311.StrType)le.zip_continuity),
    Fields.InValid_zip_cooking((SALT311.StrType)le.zip_cooking),
    Fields.InValid_zip_crafts((SALT311.StrType)le.zip_crafts),
    Fields.InValid_zip_culturearts((SALT311.StrType)le.zip_culturearts),
    Fields.InValid_zip_dm_sold((SALT311.StrType)le.zip_dm_sold),
    Fields.InValid_zip_donor((SALT311.StrType)le.zip_donor),
    Fields.InValid_zip_family((SALT311.StrType)le.zip_family),
    Fields.InValid_zip_gardening((SALT311.StrType)le.zip_gardening),
    Fields.InValid_zip_giftgivr((SALT311.StrType)le.zip_giftgivr),
    Fields.InValid_zip_gourmet((SALT311.StrType)le.zip_gourmet),
    Fields.InValid_zip_health((SALT311.StrType)le.zip_health),
    Fields.InValid_zip_health_diet((SALT311.StrType)le.zip_health_diet),
    Fields.InValid_zip_health_fitness((SALT311.StrType)le.zip_health_fitness),
    Fields.InValid_zip_hobbies((SALT311.StrType)le.zip_hobbies),
    Fields.InValid_zip_homedecr((SALT311.StrType)le.zip_homedecr),
    Fields.InValid_zip_homeliv((SALT311.StrType)le.zip_homeliv),
    Fields.InValid_zip_internet((SALT311.StrType)le.zip_internet),
    Fields.InValid_zip_internet_access((SALT311.StrType)le.zip_internet_access),
    Fields.InValid_zip_internet_buy((SALT311.StrType)le.zip_internet_buy),
    Fields.InValid_zip_music((SALT311.StrType)le.zip_music),
    Fields.InValid_zip_outdoors((SALT311.StrType)le.zip_outdoors),
    Fields.InValid_zip_pets((SALT311.StrType)le.zip_pets),
    Fields.InValid_zip_pfin((SALT311.StrType)le.zip_pfin),
    Fields.InValid_zip_publish((SALT311.StrType)le.zip_publish),
    Fields.InValid_zip_publish_books((SALT311.StrType)le.zip_publish_books),
    Fields.InValid_zip_publish_mags((SALT311.StrType)le.zip_publish_mags),
    Fields.InValid_zip_sports((SALT311.StrType)le.zip_sports),
    Fields.InValid_zip_sports_biking((SALT311.StrType)le.zip_sports_biking),
    Fields.InValid_zip_sports_golf((SALT311.StrType)le.zip_sports_golf),
    Fields.InValid_zip_travel((SALT311.StrType)le.zip_travel),
    Fields.InValid_zip_travel_us((SALT311.StrType)le.zip_travel_us),
    Fields.InValid_zip_tvmovies((SALT311.StrType)le.zip_tvmovies),
    Fields.InValid_zip_woman((SALT311.StrType)le.zip_woman),
    Fields.InValid_zip_proftech((SALT311.StrType)le.zip_proftech),
    Fields.InValid_zip_retired((SALT311.StrType)le.zip_retired),
    Fields.InValid_zip_inc100((SALT311.StrType)le.zip_inc100),
    Fields.InValid_zip_inc75((SALT311.StrType)le.zip_inc75),
    Fields.InValid_zip_inc50((SALT311.StrType)le.zip_inc50),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,633,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'ALPHANUMERIC','FULLNAME','FULL_ADDRESS','FULL_ADDRESS','CITY','ST','ZIP5','HASZIP4','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','NUMBER','NUMBER','NUMBER','GENDER_CODE','invalid_date','NUMBER','INC_CODE','ALPHA','ALPHA','ALPHANUMERIC','OPC_CODE','EDU_CODE','GENERAL_CODE','RELIG_CODE','DWELL_CODE','ALPHA','GENERAL_CODE','GENERAL_CODE','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dtmatch(TotalErrors.ErrorNum),Fields.InValidMessage_msname(TotalErrors.ErrorNum),Fields.InValidMessage_msaddr1(TotalErrors.ErrorNum),Fields.InValidMessage_msaddr2(TotalErrors.ErrorNum),Fields.InValidMessage_mscity(TotalErrors.ErrorNum),Fields.InValidMessage_msstate(TotalErrors.ErrorNum),Fields.InValidMessage_mszip5(TotalErrors.ErrorNum),Fields.InValidMessage_mszip4(TotalErrors.ErrorNum),Fields.InValidMessage_dthh(TotalErrors.ErrorNum),Fields.InValidMessage_mscrrt(TotalErrors.ErrorNum),Fields.InValidMessage_msdpbc(TotalErrors.ErrorNum),Fields.InValidMessage_msdpv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_addrtype(TotalErrors.ErrorNum),Fields.InValidMessage_ctysize(TotalErrors.ErrorNum),Fields.InValidMessage_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_omos(TotalErrors.ErrorNum),Fields.InValidMessage_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_gen(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_age(TotalErrors.ErrorNum),Fields.InValidMessage_inc(TotalErrors.ErrorNum),Fields.InValidMessage_marital_status(TotalErrors.ErrorNum),Fields.InValidMessage_poc(TotalErrors.ErrorNum),Fields.InValidMessage_noc(TotalErrors.ErrorNum),Fields.InValidMessage_ocp(TotalErrors.ErrorNum),Fields.InValidMessage_edu(TotalErrors.ErrorNum),Fields.InValidMessage_lang(TotalErrors.ErrorNum),Fields.InValidMessage_relig(TotalErrors.ErrorNum),Fields.InValidMessage_dwell(TotalErrors.ErrorNum),Fields.InValidMessage_ownr(TotalErrors.ErrorNum),Fields.InValidMessage_eth1(TotalErrors.ErrorNum),Fields.InValidMessage_eth2(TotalErrors.ErrorNum),Fields.InValidMessage_lor(TotalErrors.ErrorNum),Fields.InValidMessage_pool(TotalErrors.ErrorNum),Fields.InValidMessage_speak_span(TotalErrors.ErrorNum),Fields.InValidMessage_soho(TotalErrors.ErrorNum),Fields.InValidMessage_vet_in_hh(TotalErrors.ErrorNum),Fields.InValidMessage_ms_mags(TotalErrors.ErrorNum),Fields.InValidMessage_ms_books(TotalErrors.ErrorNum),Fields.InValidMessage_ms_publish(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_status_active(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_status_expire(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_premsold(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_autornwl(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_avgterm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_cemos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_femos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_paystat_ub(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_paymeth_cash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_payspeed(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_agt_cashf(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_agt_cashf(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_agt_pds(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_agt_pds(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_agt_schplan(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_agt_schplan(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_agt_sponsor(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_agt_sponsor(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_agt_tm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_agt_tm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_tm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_tm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_ins(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_ins(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_net(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_net(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_print(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_print(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_trans(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_trans(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_tv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_tv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_osrc_dtp(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_lsrc_dtp(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_giftgivr(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_giftee(TotalErrors.ErrorNum),Fields.InValidMessage_ms_catalog(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_totitems(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_paymeth_cash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_osrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_lsrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_osrc_net(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_lsrc_net(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_giftgivr(TotalErrors.ErrorNum),Fields.InValidMessage_pkpubs_corrected(TotalErrors.ErrorNum),Fields.InValidMessage_pkcatg_corrected(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fundraising(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fund_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fund_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fund_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fund_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fund_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fund_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fund_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fund_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_other(TotalErrors.ErrorNum),Fields.InValidMessage_ms_continuity(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_status_active(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_status_cancel(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cont_paymeth_cash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_totitems(TotalErrors.ErrorNum),Fields.InValidMessage_ms_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_paymeth_cash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_osrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_lsrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_osrc_tm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_lsrc_tm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_osrc_ins(TotalErrors.ErrorNum),Fields.InValidMessage_ms_lsrc_ins(TotalErrors.ErrorNum),Fields.InValidMessage_ms_osrc_net(TotalErrors.ErrorNum),Fields.InValidMessage_ms_lsrc_net(TotalErrors.ErrorNum),Fields.InValidMessage_ms_osrc_tv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_lsrc_tv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_osrc_retail(TotalErrors.ErrorNum),Fields.InValidMessage_ms_lsrc_retail(TotalErrors.ErrorNum),Fields.InValidMessage_ms_giftgivr(TotalErrors.ErrorNum),Fields.InValidMessage_ms_giftee(TotalErrors.ErrorNum),Fields.InValidMessage_ms_adult(TotalErrors.ErrorNum),Fields.InValidMessage_ms_womapp(TotalErrors.ErrorNum),Fields.InValidMessage_ms_menapp(TotalErrors.ErrorNum),Fields.InValidMessage_ms_kidapp(TotalErrors.ErrorNum),Fields.InValidMessage_ms_accessory(TotalErrors.ErrorNum),Fields.InValidMessage_ms_apparel(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_totitems(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_app_paymeth_cash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_menfash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_womfash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_osrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_lsrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_osrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wfsh_lsrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_audio(TotalErrors.ErrorNum),Fields.InValidMessage_ms_auto(TotalErrors.ErrorNum),Fields.InValidMessage_ms_aviation(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bargains(TotalErrors.ErrorNum),Fields.InValidMessage_ms_beauty(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_totitems(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_bible_paymeth_cash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_business(TotalErrors.ErrorNum),Fields.InValidMessage_ms_collectibles(TotalErrors.ErrorNum),Fields.InValidMessage_ms_computers(TotalErrors.ErrorNum),Fields.InValidMessage_ms_crafts(TotalErrors.ErrorNum),Fields.InValidMessage_ms_culturearts(TotalErrors.ErrorNum),Fields.InValidMessage_ms_currevent(TotalErrors.ErrorNum),Fields.InValidMessage_ms_diy(TotalErrors.ErrorNum),Fields.InValidMessage_ms_electronics(TotalErrors.ErrorNum),Fields.InValidMessage_ms_equestrian(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_family(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_family(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_totitems(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_paymeth_cash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_osrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_family_lsrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fiction(TotalErrors.ErrorNum),Fields.InValidMessage_ms_food(TotalErrors.ErrorNum),Fields.InValidMessage_ms_games(TotalErrors.ErrorNum),Fields.InValidMessage_ms_gifts(TotalErrors.ErrorNum),Fields.InValidMessage_ms_gourmet(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fitness(TotalErrors.ErrorNum),Fields.InValidMessage_ms_health(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_osrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_lsrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_osrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_lsrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_osrc_tv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hlth_lsrc_tv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_holiday(TotalErrors.ErrorNum),Fields.InValidMessage_ms_history(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_cooking(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cooking(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_homedecr(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_homedecr(TotalErrors.ErrorNum),Fields.InValidMessage_ms_homedecr(TotalErrors.ErrorNum),Fields.InValidMessage_ms_housewares(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_garden(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_garden(TotalErrors.ErrorNum),Fields.InValidMessage_ms_garden(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_homeliv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_homeliv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_homeliv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_home_status_active(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_totitems(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_paymeth_cash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_osrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_lsrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_osrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_lsrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_osrc_net(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_lsrc_net(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_osrc_tv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_home_lsrc_tv(TotalErrors.ErrorNum),Fields.InValidMessage_ms_humor(TotalErrors.ErrorNum),Fields.InValidMessage_ms_inspiration(TotalErrors.ErrorNum),Fields.InValidMessage_ms_merchandise(TotalErrors.ErrorNum),Fields.InValidMessage_ms_moneymaking(TotalErrors.ErrorNum),Fields.InValidMessage_ms_moneymaking_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_motorcycles(TotalErrors.ErrorNum),Fields.InValidMessage_ms_music(TotalErrors.ErrorNum),Fields.InValidMessage_ms_fishing(TotalErrors.ErrorNum),Fields.InValidMessage_ms_hunting(TotalErrors.ErrorNum),Fields.InValidMessage_ms_boatsail(TotalErrors.ErrorNum),Fields.InValidMessage_ms_camp(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_outdoors(TotalErrors.ErrorNum),Fields.InValidMessage_ms_cat_outdoors(TotalErrors.ErrorNum),Fields.InValidMessage_ms_outdoors(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pub_out_status_active(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_omos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_pmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_totords(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_totitems(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_totdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_avgdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_lastdlrs(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_paystat_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_paymeth_cc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_paymeth_cash(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_osrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_lsrc_dm(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_osrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_out_lsrc_agt(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pets(TotalErrors.ErrorNum),Fields.InValidMessage_ms_pfin(TotalErrors.ErrorNum),Fields.InValidMessage_ms_photo(TotalErrors.ErrorNum),Fields.InValidMessage_ms_photoproc(TotalErrors.ErrorNum),Fields.InValidMessage_ms_rural(TotalErrors.ErrorNum),Fields.InValidMessage_ms_science(TotalErrors.ErrorNum),Fields.InValidMessage_ms_sports(TotalErrors.ErrorNum),Fields.InValidMessage_ms_sports_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_travel(TotalErrors.ErrorNum),Fields.InValidMessage_ms_tvmovies(TotalErrors.ErrorNum),Fields.InValidMessage_ms_wildlife(TotalErrors.ErrorNum),Fields.InValidMessage_ms_woman(TotalErrors.ErrorNum),Fields.InValidMessage_ms_woman_lmos(TotalErrors.ErrorNum),Fields.InValidMessage_ms_ringtones_apps(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_mobile_apps_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_credit_repair_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_credit_report_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_education_seekers_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_insurance_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_insurance_health_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_insurance_auto_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_job_seekers_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_social_networking_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_adult_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_africanamerican_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_apparel_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_apparel_accessory_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_apparel_kids_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_apparel_men_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_apparel_menfash_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_apparel_women_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_apparel_womfash_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_asian_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_auto_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_auto_racing_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_auto_trucks_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_aviation_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_bargains_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_beauty_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_bible_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_birds_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_business_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_business_homeoffice_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_catalog_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_cc_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_collectibles_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_college_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_computers_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_conservative_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_continuity_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_cooking_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_crafts_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_crafts_crochet_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_crafts_knit_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_crafts_needlepoint_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_crafts_quilt_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_crafts_sew_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_culturearts_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_currevent_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_diy_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_donor_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_ego_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_electronics_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_equestrian_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_family_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_family_teen_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_family_young_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_fiction_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_gambling_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_games_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_gardening_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_gay_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_giftgivr_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_gourmet_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_grandparents_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_health_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_health_diet_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_health_fitness_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_hightech_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_hispanic_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_history_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_history_american_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_hobbies_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_homedecr_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_homeliv_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_humor_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_inspiration_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_internet_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_internet_access_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_internet_buy_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_liberal_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_moneymaking_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_motorcycles_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_music_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_nonfiction_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_ocean_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_outdoors_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_outdoors_boatsail_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_outdoors_camp_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_outdoors_fishing_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_outdoors_huntfish_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_outdoors_hunting_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_pets_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_pets_cats_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_pets_dogs_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_pfin_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_photog_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_photoproc_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_publish_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_publish_books_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_publish_mags_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_rural_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_science_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_scifi_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_seniors_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_baseball_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_basketball_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_biking_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_football_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_golf_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_hockey_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_running_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_ski_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_soccer_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_swimming_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sports_tennis_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_stationery_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_sweeps_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_tobacco_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_travel_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_travel_cruise_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_travel_rv_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_travel_us_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_tvmovies_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_wildlife_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_woman_index(TotalErrors.ErrorNum),Fields.InValidMessage_totdlr_index(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_totdlr(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_totords(TotalErrors.ErrorNum),Fields.InValidMessage_cpi_lastdlr(TotalErrors.ErrorNum),Fields.InValidMessage_pkcatg(TotalErrors.ErrorNum),Fields.InValidMessage_pkpubs(TotalErrors.ErrorNum),Fields.InValidMessage_pkcont(TotalErrors.ErrorNum),Fields.InValidMessage_pkca01(TotalErrors.ErrorNum),Fields.InValidMessage_pkca03(TotalErrors.ErrorNum),Fields.InValidMessage_pkca04(TotalErrors.ErrorNum),Fields.InValidMessage_pkca05(TotalErrors.ErrorNum),Fields.InValidMessage_pkca06(TotalErrors.ErrorNum),Fields.InValidMessage_pkca07(TotalErrors.ErrorNum),Fields.InValidMessage_pkca08(TotalErrors.ErrorNum),Fields.InValidMessage_pkca09(TotalErrors.ErrorNum),Fields.InValidMessage_pkca10(TotalErrors.ErrorNum),Fields.InValidMessage_pkca11(TotalErrors.ErrorNum),Fields.InValidMessage_pkca12(TotalErrors.ErrorNum),Fields.InValidMessage_pkca13(TotalErrors.ErrorNum),Fields.InValidMessage_pkca14(TotalErrors.ErrorNum),Fields.InValidMessage_pkca15(TotalErrors.ErrorNum),Fields.InValidMessage_pkca16(TotalErrors.ErrorNum),Fields.InValidMessage_pkca17(TotalErrors.ErrorNum),Fields.InValidMessage_pkca18(TotalErrors.ErrorNum),Fields.InValidMessage_pkca20(TotalErrors.ErrorNum),Fields.InValidMessage_pkca21(TotalErrors.ErrorNum),Fields.InValidMessage_pkca22(TotalErrors.ErrorNum),Fields.InValidMessage_pkca23(TotalErrors.ErrorNum),Fields.InValidMessage_pkca24(TotalErrors.ErrorNum),Fields.InValidMessage_pkca25(TotalErrors.ErrorNum),Fields.InValidMessage_pkca26(TotalErrors.ErrorNum),Fields.InValidMessage_pkca28(TotalErrors.ErrorNum),Fields.InValidMessage_pkca29(TotalErrors.ErrorNum),Fields.InValidMessage_pkca30(TotalErrors.ErrorNum),Fields.InValidMessage_pkca31(TotalErrors.ErrorNum),Fields.InValidMessage_pkca32(TotalErrors.ErrorNum),Fields.InValidMessage_pkca33(TotalErrors.ErrorNum),Fields.InValidMessage_pkca34(TotalErrors.ErrorNum),Fields.InValidMessage_pkca35(TotalErrors.ErrorNum),Fields.InValidMessage_pkca36(TotalErrors.ErrorNum),Fields.InValidMessage_pkca37(TotalErrors.ErrorNum),Fields.InValidMessage_pkca39(TotalErrors.ErrorNum),Fields.InValidMessage_pkca40(TotalErrors.ErrorNum),Fields.InValidMessage_pkca41(TotalErrors.ErrorNum),Fields.InValidMessage_pkca42(TotalErrors.ErrorNum),Fields.InValidMessage_pkca54(TotalErrors.ErrorNum),Fields.InValidMessage_pkca61(TotalErrors.ErrorNum),Fields.InValidMessage_pkca62(TotalErrors.ErrorNum),Fields.InValidMessage_pkca64(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu01(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu02(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu03(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu04(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu05(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu06(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu07(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu08(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu09(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu10(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu11(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu12(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu13(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu14(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu15(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu16(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu17(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu18(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu19(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu20(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu23(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu25(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu27(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu28(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu29(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu30(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu31(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu32(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu33(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu34(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu35(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu38(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu41(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu42(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu45(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu46(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu47(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu48(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu49(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu50(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu51(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu52(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu53(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu54(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu55(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu56(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu57(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu60(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu61(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu62(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu63(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu64(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu65(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu66(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu67(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu68(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu69(TotalErrors.ErrorNum),Fields.InValidMessage_pkpu70(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_water(TotalErrors.ErrorNum),Fields.InValidMessage_cens_pop_density(TotalErrors.ErrorNum),Fields.InValidMessage_cens_hu_density(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_white(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_black(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_amerind(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_asian(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_pacisl(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_othrace(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_multirace(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_hispanic(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_agelt18(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_pop_males(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_adult_age1824(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_adult_age2534(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_adult_age3544(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_adult_age4554(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_adult_age5564(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_adult_agege65(TotalErrors.ErrorNum),Fields.InValidMessage_cens_pop_medage(TotalErrors.ErrorNum),Fields.InValidMessage_cens_hh_avgsize(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_hh_family(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_hh_family_husbwife(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_hu_occupied(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_hu_owned(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_hu_rented(TotalErrors.ErrorNum),Fields.InValidMessage_censpct_hu_vacantseasonal(TotalErrors.ErrorNum),Fields.InValidMessage_zip_medinc(TotalErrors.ErrorNum),Fields.InValidMessage_zip_apparel(TotalErrors.ErrorNum),Fields.InValidMessage_zip_apparel_women(TotalErrors.ErrorNum),Fields.InValidMessage_zip_apparel_womfash(TotalErrors.ErrorNum),Fields.InValidMessage_zip_auto(TotalErrors.ErrorNum),Fields.InValidMessage_zip_beauty(TotalErrors.ErrorNum),Fields.InValidMessage_zip_booksmusicmovies(TotalErrors.ErrorNum),Fields.InValidMessage_zip_business(TotalErrors.ErrorNum),Fields.InValidMessage_zip_catalog(TotalErrors.ErrorNum),Fields.InValidMessage_zip_cc(TotalErrors.ErrorNum),Fields.InValidMessage_zip_collectibles(TotalErrors.ErrorNum),Fields.InValidMessage_zip_computers(TotalErrors.ErrorNum),Fields.InValidMessage_zip_continuity(TotalErrors.ErrorNum),Fields.InValidMessage_zip_cooking(TotalErrors.ErrorNum),Fields.InValidMessage_zip_crafts(TotalErrors.ErrorNum),Fields.InValidMessage_zip_culturearts(TotalErrors.ErrorNum),Fields.InValidMessage_zip_dm_sold(TotalErrors.ErrorNum),Fields.InValidMessage_zip_donor(TotalErrors.ErrorNum),Fields.InValidMessage_zip_family(TotalErrors.ErrorNum),Fields.InValidMessage_zip_gardening(TotalErrors.ErrorNum),Fields.InValidMessage_zip_giftgivr(TotalErrors.ErrorNum),Fields.InValidMessage_zip_gourmet(TotalErrors.ErrorNum),Fields.InValidMessage_zip_health(TotalErrors.ErrorNum),Fields.InValidMessage_zip_health_diet(TotalErrors.ErrorNum),Fields.InValidMessage_zip_health_fitness(TotalErrors.ErrorNum),Fields.InValidMessage_zip_hobbies(TotalErrors.ErrorNum),Fields.InValidMessage_zip_homedecr(TotalErrors.ErrorNum),Fields.InValidMessage_zip_homeliv(TotalErrors.ErrorNum),Fields.InValidMessage_zip_internet(TotalErrors.ErrorNum),Fields.InValidMessage_zip_internet_access(TotalErrors.ErrorNum),Fields.InValidMessage_zip_internet_buy(TotalErrors.ErrorNum),Fields.InValidMessage_zip_music(TotalErrors.ErrorNum),Fields.InValidMessage_zip_outdoors(TotalErrors.ErrorNum),Fields.InValidMessage_zip_pets(TotalErrors.ErrorNum),Fields.InValidMessage_zip_pfin(TotalErrors.ErrorNum),Fields.InValidMessage_zip_publish(TotalErrors.ErrorNum),Fields.InValidMessage_zip_publish_books(TotalErrors.ErrorNum),Fields.InValidMessage_zip_publish_mags(TotalErrors.ErrorNum),Fields.InValidMessage_zip_sports(TotalErrors.ErrorNum),Fields.InValidMessage_zip_sports_biking(TotalErrors.ErrorNum),Fields.InValidMessage_zip_sports_golf(TotalErrors.ErrorNum),Fields.InValidMessage_zip_travel(TotalErrors.ErrorNum),Fields.InValidMessage_zip_travel_us(TotalErrors.ErrorNum),Fields.InValidMessage_zip_tvmovies(TotalErrors.ErrorNum),Fields.InValidMessage_zip_woman(TotalErrors.ErrorNum),Fields.InValidMessage_zip_proftech(TotalErrors.ErrorNum),Fields.InValidMessage_zip_retired(TotalErrors.ErrorNum),Fields.InValidMessage_zip_inc100(TotalErrors.ErrorNum),Fields.InValidMessage_zip_inc75(TotalErrors.ErrorNum),Fields.InValidMessage_zip_inc50(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Dunndata_Consumer, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
