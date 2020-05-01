IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_LaborActions_WHD) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dartid_cnt := COUNT(GROUP,h.dartid <> (TYPEOF(h.dartid))'');
    populated_dartid_pcnt := AVE(GROUP,IF(h.dartid = (TYPEOF(h.dartid))'',0,100));
    maxlength_dartid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)));
    avelength_dartid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)),h.dartid<>(typeof(h.dartid))'');
    populated_dateadded_cnt := COUNT(GROUP,h.dateadded <> (TYPEOF(h.dateadded))'');
    populated_dateadded_pcnt := AVE(GROUP,IF(h.dateadded = (TYPEOF(h.dateadded))'',0,100));
    maxlength_dateadded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateadded)));
    avelength_dateadded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateadded)),h.dateadded<>(typeof(h.dateadded))'');
    populated_dateupdated_cnt := COUNT(GROUP,h.dateupdated <> (TYPEOF(h.dateupdated))'');
    populated_dateupdated_pcnt := AVE(GROUP,IF(h.dateupdated = (TYPEOF(h.dateupdated))'',0,100));
    maxlength_dateupdated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateupdated)));
    avelength_dateupdated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateupdated)),h.dateupdated<>(typeof(h.dateupdated))'');
    populated_website_cnt := COUNT(GROUP,h.website <> (TYPEOF(h.website))'');
    populated_website_pcnt := AVE(GROUP,IF(h.website = (TYPEOF(h.website))'',0,100));
    maxlength_website := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)));
    avelength_website := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)),h.website<>(typeof(h.website))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_caseid_cnt := COUNT(GROUP,h.caseid <> (TYPEOF(h.caseid))'');
    populated_caseid_pcnt := AVE(GROUP,IF(h.caseid = (TYPEOF(h.caseid))'',0,100));
    maxlength_caseid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseid)));
    avelength_caseid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseid)),h.caseid<>(typeof(h.caseid))'');
    populated_employername_cnt := COUNT(GROUP,h.employername <> (TYPEOF(h.employername))'');
    populated_employername_pcnt := AVE(GROUP,IF(h.employername = (TYPEOF(h.employername))'',0,100));
    maxlength_employername := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.employername)));
    avelength_employername := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.employername)),h.employername<>(typeof(h.employername))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_employerstate_cnt := COUNT(GROUP,h.employerstate <> (TYPEOF(h.employerstate))'');
    populated_employerstate_pcnt := AVE(GROUP,IF(h.employerstate = (TYPEOF(h.employerstate))'',0,100));
    maxlength_employerstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.employerstate)));
    avelength_employerstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.employerstate)),h.employerstate<>(typeof(h.employerstate))'');
    populated_zipcode_cnt := COUNT(GROUP,h.zipcode <> (TYPEOF(h.zipcode))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_naicscode_cnt := COUNT(GROUP,h.naicscode <> (TYPEOF(h.naicscode))'');
    populated_naicscode_pcnt := AVE(GROUP,IF(h.naicscode = (TYPEOF(h.naicscode))'',0,100));
    maxlength_naicscode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode)));
    avelength_naicscode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode)),h.naicscode<>(typeof(h.naicscode))'');
    populated_totalviolations_cnt := COUNT(GROUP,h.totalviolations <> (TYPEOF(h.totalviolations))'');
    populated_totalviolations_pcnt := AVE(GROUP,IF(h.totalviolations = (TYPEOF(h.totalviolations))'',0,100));
    maxlength_totalviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.totalviolations)));
    avelength_totalviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.totalviolations)),h.totalviolations<>(typeof(h.totalviolations))'');
    populated_bw_totalagreedamount_cnt := COUNT(GROUP,h.bw_totalagreedamount <> (TYPEOF(h.bw_totalagreedamount))'');
    populated_bw_totalagreedamount_pcnt := AVE(GROUP,IF(h.bw_totalagreedamount = (TYPEOF(h.bw_totalagreedamount))'',0,100));
    maxlength_bw_totalagreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bw_totalagreedamount)));
    avelength_bw_totalagreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bw_totalagreedamount)),h.bw_totalagreedamount<>(typeof(h.bw_totalagreedamount))'');
    populated_cmp_totalassessments_cnt := COUNT(GROUP,h.cmp_totalassessments <> (TYPEOF(h.cmp_totalassessments))'');
    populated_cmp_totalassessments_pcnt := AVE(GROUP,IF(h.cmp_totalassessments = (TYPEOF(h.cmp_totalassessments))'',0,100));
    maxlength_cmp_totalassessments := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cmp_totalassessments)));
    avelength_cmp_totalassessments := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cmp_totalassessments)),h.cmp_totalassessments<>(typeof(h.cmp_totalassessments))'');
    populated_ee_totalviolations_cnt := COUNT(GROUP,h.ee_totalviolations <> (TYPEOF(h.ee_totalviolations))'');
    populated_ee_totalviolations_pcnt := AVE(GROUP,IF(h.ee_totalviolations = (TYPEOF(h.ee_totalviolations))'',0,100));
    maxlength_ee_totalviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ee_totalviolations)));
    avelength_ee_totalviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ee_totalviolations)),h.ee_totalviolations<>(typeof(h.ee_totalviolations))'');
    populated_ee_totalagreedcount_cnt := COUNT(GROUP,h.ee_totalagreedcount <> (TYPEOF(h.ee_totalagreedcount))'');
    populated_ee_totalagreedcount_pcnt := AVE(GROUP,IF(h.ee_totalagreedcount = (TYPEOF(h.ee_totalagreedcount))'',0,100));
    maxlength_ee_totalagreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ee_totalagreedcount)));
    avelength_ee_totalagreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ee_totalagreedcount)),h.ee_totalagreedcount<>(typeof(h.ee_totalagreedcount))'');
    populated_ca_countviolations_cnt := COUNT(GROUP,h.ca_countviolations <> (TYPEOF(h.ca_countviolations))'');
    populated_ca_countviolations_pcnt := AVE(GROUP,IF(h.ca_countviolations = (TYPEOF(h.ca_countviolations))'',0,100));
    maxlength_ca_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ca_countviolations)));
    avelength_ca_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ca_countviolations)),h.ca_countviolations<>(typeof(h.ca_countviolations))'');
    populated_ca_bw_agreedamount_cnt := COUNT(GROUP,h.ca_bw_agreedamount <> (TYPEOF(h.ca_bw_agreedamount))'');
    populated_ca_bw_agreedamount_pcnt := AVE(GROUP,IF(h.ca_bw_agreedamount = (TYPEOF(h.ca_bw_agreedamount))'',0,100));
    maxlength_ca_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ca_bw_agreedamount)));
    avelength_ca_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ca_bw_agreedamount)),h.ca_bw_agreedamount<>(typeof(h.ca_bw_agreedamount))'');
    populated_ca_ee_agreedcount_cnt := COUNT(GROUP,h.ca_ee_agreedcount <> (TYPEOF(h.ca_ee_agreedcount))'');
    populated_ca_ee_agreedcount_pcnt := AVE(GROUP,IF(h.ca_ee_agreedcount = (TYPEOF(h.ca_ee_agreedcount))'',0,100));
    maxlength_ca_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ca_ee_agreedcount)));
    avelength_ca_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ca_ee_agreedcount)),h.ca_ee_agreedcount<>(typeof(h.ca_ee_agreedcount))'');
    populated_ccpa_countviolations_cnt := COUNT(GROUP,h.ccpa_countviolations <> (TYPEOF(h.ccpa_countviolations))'');
    populated_ccpa_countviolations_pcnt := AVE(GROUP,IF(h.ccpa_countviolations = (TYPEOF(h.ccpa_countviolations))'',0,100));
    maxlength_ccpa_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccpa_countviolations)));
    avelength_ccpa_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccpa_countviolations)),h.ccpa_countviolations<>(typeof(h.ccpa_countviolations))'');
    populated_ccpa_bw_agreedamount_cnt := COUNT(GROUP,h.ccpa_bw_agreedamount <> (TYPEOF(h.ccpa_bw_agreedamount))'');
    populated_ccpa_bw_agreedamount_pcnt := AVE(GROUP,IF(h.ccpa_bw_agreedamount = (TYPEOF(h.ccpa_bw_agreedamount))'',0,100));
    maxlength_ccpa_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccpa_bw_agreedamount)));
    avelength_ccpa_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccpa_bw_agreedamount)),h.ccpa_bw_agreedamount<>(typeof(h.ccpa_bw_agreedamount))'');
    populated_ccpa_ee_agreedcount_cnt := COUNT(GROUP,h.ccpa_ee_agreedcount <> (TYPEOF(h.ccpa_ee_agreedcount))'');
    populated_ccpa_ee_agreedcount_pcnt := AVE(GROUP,IF(h.ccpa_ee_agreedcount = (TYPEOF(h.ccpa_ee_agreedcount))'',0,100));
    maxlength_ccpa_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccpa_ee_agreedcount)));
    avelength_ccpa_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccpa_ee_agreedcount)),h.ccpa_ee_agreedcount<>(typeof(h.ccpa_ee_agreedcount))'');
    populated_crew_countviolations_cnt := COUNT(GROUP,h.crew_countviolations <> (TYPEOF(h.crew_countviolations))'');
    populated_crew_countviolations_pcnt := AVE(GROUP,IF(h.crew_countviolations = (TYPEOF(h.crew_countviolations))'',0,100));
    maxlength_crew_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crew_countviolations)));
    avelength_crew_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crew_countviolations)),h.crew_countviolations<>(typeof(h.crew_countviolations))'');
    populated_crew_bw_agreedamount_cnt := COUNT(GROUP,h.crew_bw_agreedamount <> (TYPEOF(h.crew_bw_agreedamount))'');
    populated_crew_bw_agreedamount_pcnt := AVE(GROUP,IF(h.crew_bw_agreedamount = (TYPEOF(h.crew_bw_agreedamount))'',0,100));
    maxlength_crew_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crew_bw_agreedamount)));
    avelength_crew_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crew_bw_agreedamount)),h.crew_bw_agreedamount<>(typeof(h.crew_bw_agreedamount))'');
    populated_crew_cmp_assessedamount_cnt := COUNT(GROUP,h.crew_cmp_assessedamount <> (TYPEOF(h.crew_cmp_assessedamount))'');
    populated_crew_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.crew_cmp_assessedamount = (TYPEOF(h.crew_cmp_assessedamount))'',0,100));
    maxlength_crew_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crew_cmp_assessedamount)));
    avelength_crew_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crew_cmp_assessedamount)),h.crew_cmp_assessedamount<>(typeof(h.crew_cmp_assessedamount))'');
    populated_crew_ee_agreedcount_cnt := COUNT(GROUP,h.crew_ee_agreedcount <> (TYPEOF(h.crew_ee_agreedcount))'');
    populated_crew_ee_agreedcount_pcnt := AVE(GROUP,IF(h.crew_ee_agreedcount = (TYPEOF(h.crew_ee_agreedcount))'',0,100));
    maxlength_crew_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crew_ee_agreedcount)));
    avelength_crew_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crew_ee_agreedcount)),h.crew_ee_agreedcount<>(typeof(h.crew_ee_agreedcount))'');
    populated_cwhssa_countviolations_cnt := COUNT(GROUP,h.cwhssa_countviolations <> (TYPEOF(h.cwhssa_countviolations))'');
    populated_cwhssa_countviolations_pcnt := AVE(GROUP,IF(h.cwhssa_countviolations = (TYPEOF(h.cwhssa_countviolations))'',0,100));
    maxlength_cwhssa_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cwhssa_countviolations)));
    avelength_cwhssa_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cwhssa_countviolations)),h.cwhssa_countviolations<>(typeof(h.cwhssa_countviolations))'');
    populated_cwhssa_bw_agreedamount_cnt := COUNT(GROUP,h.cwhssa_bw_agreedamount <> (TYPEOF(h.cwhssa_bw_agreedamount))'');
    populated_cwhssa_bw_agreedamount_pcnt := AVE(GROUP,IF(h.cwhssa_bw_agreedamount = (TYPEOF(h.cwhssa_bw_agreedamount))'',0,100));
    maxlength_cwhssa_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cwhssa_bw_agreedamount)));
    avelength_cwhssa_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cwhssa_bw_agreedamount)),h.cwhssa_bw_agreedamount<>(typeof(h.cwhssa_bw_agreedamount))'');
    populated_cwhssa_ee_agreedcount_cnt := COUNT(GROUP,h.cwhssa_ee_agreedcount <> (TYPEOF(h.cwhssa_ee_agreedcount))'');
    populated_cwhssa_ee_agreedcount_pcnt := AVE(GROUP,IF(h.cwhssa_ee_agreedcount = (TYPEOF(h.cwhssa_ee_agreedcount))'',0,100));
    maxlength_cwhssa_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cwhssa_ee_agreedcount)));
    avelength_cwhssa_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cwhssa_ee_agreedcount)),h.cwhssa_ee_agreedcount<>(typeof(h.cwhssa_ee_agreedcount))'');
    populated_dbra_cl_countviolations_cnt := COUNT(GROUP,h.dbra_cl_countviolations <> (TYPEOF(h.dbra_cl_countviolations))'');
    populated_dbra_cl_countviolations_pcnt := AVE(GROUP,IF(h.dbra_cl_countviolations = (TYPEOF(h.dbra_cl_countviolations))'',0,100));
    maxlength_dbra_cl_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbra_cl_countviolations)));
    avelength_dbra_cl_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbra_cl_countviolations)),h.dbra_cl_countviolations<>(typeof(h.dbra_cl_countviolations))'');
    populated_dbra_bw_agreedamount_cnt := COUNT(GROUP,h.dbra_bw_agreedamount <> (TYPEOF(h.dbra_bw_agreedamount))'');
    populated_dbra_bw_agreedamount_pcnt := AVE(GROUP,IF(h.dbra_bw_agreedamount = (TYPEOF(h.dbra_bw_agreedamount))'',0,100));
    maxlength_dbra_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbra_bw_agreedamount)));
    avelength_dbra_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbra_bw_agreedamount)),h.dbra_bw_agreedamount<>(typeof(h.dbra_bw_agreedamount))'');
    populated_dbra_ee_agreedcount_cnt := COUNT(GROUP,h.dbra_ee_agreedcount <> (TYPEOF(h.dbra_ee_agreedcount))'');
    populated_dbra_ee_agreedcount_pcnt := AVE(GROUP,IF(h.dbra_ee_agreedcount = (TYPEOF(h.dbra_ee_agreedcount))'',0,100));
    maxlength_dbra_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbra_ee_agreedcount)));
    avelength_dbra_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbra_ee_agreedcount)),h.dbra_ee_agreedcount<>(typeof(h.dbra_ee_agreedcount))'');
    populated_eev_countviolations_cnt := COUNT(GROUP,h.eev_countviolations <> (TYPEOF(h.eev_countviolations))'');
    populated_eev_countviolations_pcnt := AVE(GROUP,IF(h.eev_countviolations = (TYPEOF(h.eev_countviolations))'',0,100));
    maxlength_eev_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eev_countviolations)));
    avelength_eev_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eev_countviolations)),h.eev_countviolations<>(typeof(h.eev_countviolations))'');
    populated_eppa_countviolations_cnt := COUNT(GROUP,h.eppa_countviolations <> (TYPEOF(h.eppa_countviolations))'');
    populated_eppa_countviolations_pcnt := AVE(GROUP,IF(h.eppa_countviolations = (TYPEOF(h.eppa_countviolations))'',0,100));
    maxlength_eppa_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eppa_countviolations)));
    avelength_eppa_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eppa_countviolations)),h.eppa_countviolations<>(typeof(h.eppa_countviolations))'');
    populated_eppa_bw_agreedamount_cnt := COUNT(GROUP,h.eppa_bw_agreedamount <> (TYPEOF(h.eppa_bw_agreedamount))'');
    populated_eppa_bw_agreedamount_pcnt := AVE(GROUP,IF(h.eppa_bw_agreedamount = (TYPEOF(h.eppa_bw_agreedamount))'',0,100));
    maxlength_eppa_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eppa_bw_agreedamount)));
    avelength_eppa_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eppa_bw_agreedamount)),h.eppa_bw_agreedamount<>(typeof(h.eppa_bw_agreedamount))'');
    populated_eppa_cmp_assessedamount_cnt := COUNT(GROUP,h.eppa_cmp_assessedamount <> (TYPEOF(h.eppa_cmp_assessedamount))'');
    populated_eppa_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.eppa_cmp_assessedamount = (TYPEOF(h.eppa_cmp_assessedamount))'',0,100));
    maxlength_eppa_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eppa_cmp_assessedamount)));
    avelength_eppa_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eppa_cmp_assessedamount)),h.eppa_cmp_assessedamount<>(typeof(h.eppa_cmp_assessedamount))'');
    populated_eppa_ee_agreedcount_cnt := COUNT(GROUP,h.eppa_ee_agreedcount <> (TYPEOF(h.eppa_ee_agreedcount))'');
    populated_eppa_ee_agreedcount_pcnt := AVE(GROUP,IF(h.eppa_ee_agreedcount = (TYPEOF(h.eppa_ee_agreedcount))'',0,100));
    maxlength_eppa_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eppa_ee_agreedcount)));
    avelength_eppa_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eppa_ee_agreedcount)),h.eppa_ee_agreedcount<>(typeof(h.eppa_ee_agreedcount))'');
    populated_flsa_countviolations_cnt := COUNT(GROUP,h.flsa_countviolations <> (TYPEOF(h.flsa_countviolations))'');
    populated_flsa_countviolations_pcnt := AVE(GROUP,IF(h.flsa_countviolations = (TYPEOF(h.flsa_countviolations))'',0,100));
    maxlength_flsa_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_countviolations)));
    avelength_flsa_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_countviolations)),h.flsa_countviolations<>(typeof(h.flsa_countviolations))'');
    populated_flsa_bw_15a3_agreedamount_cnt := COUNT(GROUP,h.flsa_bw_15a3_agreedamount <> (TYPEOF(h.flsa_bw_15a3_agreedamount))'');
    populated_flsa_bw_15a3_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_bw_15a3_agreedamount = (TYPEOF(h.flsa_bw_15a3_agreedamount))'',0,100));
    maxlength_flsa_bw_15a3_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_bw_15a3_agreedamount)));
    avelength_flsa_bw_15a3_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_bw_15a3_agreedamount)),h.flsa_bw_15a3_agreedamount<>(typeof(h.flsa_bw_15a3_agreedamount))'');
    populated_flsa_bw_agreedamount_cnt := COUNT(GROUP,h.flsa_bw_agreedamount <> (TYPEOF(h.flsa_bw_agreedamount))'');
    populated_flsa_bw_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_bw_agreedamount = (TYPEOF(h.flsa_bw_agreedamount))'',0,100));
    maxlength_flsa_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_bw_agreedamount)));
    avelength_flsa_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_bw_agreedamount)),h.flsa_bw_agreedamount<>(typeof(h.flsa_bw_agreedamount))'');
    populated_flsa_bw_minwage_agreedamount_cnt := COUNT(GROUP,h.flsa_bw_minwage_agreedamount <> (TYPEOF(h.flsa_bw_minwage_agreedamount))'');
    populated_flsa_bw_minwage_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_bw_minwage_agreedamount = (TYPEOF(h.flsa_bw_minwage_agreedamount))'',0,100));
    maxlength_flsa_bw_minwage_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_bw_minwage_agreedamount)));
    avelength_flsa_bw_minwage_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_bw_minwage_agreedamount)),h.flsa_bw_minwage_agreedamount<>(typeof(h.flsa_bw_minwage_agreedamount))'');
    populated_flsa_bw_overtime_agreedamount_cnt := COUNT(GROUP,h.flsa_bw_overtime_agreedamount <> (TYPEOF(h.flsa_bw_overtime_agreedamount))'');
    populated_flsa_bw_overtime_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_bw_overtime_agreedamount = (TYPEOF(h.flsa_bw_overtime_agreedamount))'',0,100));
    maxlength_flsa_bw_overtime_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_bw_overtime_agreedamount)));
    avelength_flsa_bw_overtime_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_bw_overtime_agreedamount)),h.flsa_bw_overtime_agreedamount<>(typeof(h.flsa_bw_overtime_agreedamount))'');
    populated_flsa_cmp_assessedamount_cnt := COUNT(GROUP,h.flsa_cmp_assessedamount <> (TYPEOF(h.flsa_cmp_assessedamount))'');
    populated_flsa_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.flsa_cmp_assessedamount = (TYPEOF(h.flsa_cmp_assessedamount))'',0,100));
    maxlength_flsa_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_cmp_assessedamount)));
    avelength_flsa_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_cmp_assessedamount)),h.flsa_cmp_assessedamount<>(typeof(h.flsa_cmp_assessedamount))'');
    populated_flsa_ee_agreedcount_cnt := COUNT(GROUP,h.flsa_ee_agreedcount <> (TYPEOF(h.flsa_ee_agreedcount))'');
    populated_flsa_ee_agreedcount_pcnt := AVE(GROUP,IF(h.flsa_ee_agreedcount = (TYPEOF(h.flsa_ee_agreedcount))'',0,100));
    maxlength_flsa_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_ee_agreedcount)));
    avelength_flsa_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_ee_agreedcount)),h.flsa_ee_agreedcount<>(typeof(h.flsa_ee_agreedcount))'');
    populated_flsa_cl_countviolations_cnt := COUNT(GROUP,h.flsa_cl_countviolations <> (TYPEOF(h.flsa_cl_countviolations))'');
    populated_flsa_cl_countviolations_pcnt := AVE(GROUP,IF(h.flsa_cl_countviolations = (TYPEOF(h.flsa_cl_countviolations))'',0,100));
    maxlength_flsa_cl_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_cl_countviolations)));
    avelength_flsa_cl_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_cl_countviolations)),h.flsa_cl_countviolations<>(typeof(h.flsa_cl_countviolations))'');
    populated_flsa_cl_countminorsemployed_cnt := COUNT(GROUP,h.flsa_cl_countminorsemployed <> (TYPEOF(h.flsa_cl_countminorsemployed))'');
    populated_flsa_cl_countminorsemployed_pcnt := AVE(GROUP,IF(h.flsa_cl_countminorsemployed = (TYPEOF(h.flsa_cl_countminorsemployed))'',0,100));
    maxlength_flsa_cl_countminorsemployed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_cl_countminorsemployed)));
    avelength_flsa_cl_countminorsemployed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_cl_countminorsemployed)),h.flsa_cl_countminorsemployed<>(typeof(h.flsa_cl_countminorsemployed))'');
    populated_flsa_cl_cmp_assessedamount_cnt := COUNT(GROUP,h.flsa_cl_cmp_assessedamount <> (TYPEOF(h.flsa_cl_cmp_assessedamount))'');
    populated_flsa_cl_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.flsa_cl_cmp_assessedamount = (TYPEOF(h.flsa_cl_cmp_assessedamount))'',0,100));
    maxlength_flsa_cl_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_cl_cmp_assessedamount)));
    avelength_flsa_cl_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_cl_cmp_assessedamount)),h.flsa_cl_cmp_assessedamount<>(typeof(h.flsa_cl_cmp_assessedamount))'');
    populated_flsa_hmwkr_countviolations_cnt := COUNT(GROUP,h.flsa_hmwkr_countviolations <> (TYPEOF(h.flsa_hmwkr_countviolations))'');
    populated_flsa_hmwkr_countviolations_pcnt := AVE(GROUP,IF(h.flsa_hmwkr_countviolations = (TYPEOF(h.flsa_hmwkr_countviolations))'',0,100));
    maxlength_flsa_hmwkr_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_hmwkr_countviolations)));
    avelength_flsa_hmwkr_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_hmwkr_countviolations)),h.flsa_hmwkr_countviolations<>(typeof(h.flsa_hmwkr_countviolations))'');
    populated_flsa_hmwkr_bw_agreedamount_cnt := COUNT(GROUP,h.flsa_hmwkr_bw_agreedamount <> (TYPEOF(h.flsa_hmwkr_bw_agreedamount))'');
    populated_flsa_hmwkr_bw_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_hmwkr_bw_agreedamount = (TYPEOF(h.flsa_hmwkr_bw_agreedamount))'',0,100));
    maxlength_flsa_hmwkr_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_hmwkr_bw_agreedamount)));
    avelength_flsa_hmwkr_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_hmwkr_bw_agreedamount)),h.flsa_hmwkr_bw_agreedamount<>(typeof(h.flsa_hmwkr_bw_agreedamount))'');
    populated_flsa_hmwkr_cmp_assessedamount_cnt := COUNT(GROUP,h.flsa_hmwkr_cmp_assessedamount <> (TYPEOF(h.flsa_hmwkr_cmp_assessedamount))'');
    populated_flsa_hmwkr_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.flsa_hmwkr_cmp_assessedamount = (TYPEOF(h.flsa_hmwkr_cmp_assessedamount))'',0,100));
    maxlength_flsa_hmwkr_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_hmwkr_cmp_assessedamount)));
    avelength_flsa_hmwkr_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_hmwkr_cmp_assessedamount)),h.flsa_hmwkr_cmp_assessedamount<>(typeof(h.flsa_hmwkr_cmp_assessedamount))'');
    populated_flsa_hmwkr_ee_agreedcount_cnt := COUNT(GROUP,h.flsa_hmwkr_ee_agreedcount <> (TYPEOF(h.flsa_hmwkr_ee_agreedcount))'');
    populated_flsa_hmwkr_ee_agreedcount_pcnt := AVE(GROUP,IF(h.flsa_hmwkr_ee_agreedcount = (TYPEOF(h.flsa_hmwkr_ee_agreedcount))'',0,100));
    maxlength_flsa_hmwkr_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_hmwkr_ee_agreedcount)));
    avelength_flsa_hmwkr_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_hmwkr_ee_agreedcount)),h.flsa_hmwkr_ee_agreedcount<>(typeof(h.flsa_hmwkr_ee_agreedcount))'');
    populated_flsa_smw14_bw_agreedamount_cnt := COUNT(GROUP,h.flsa_smw14_bw_agreedamount <> (TYPEOF(h.flsa_smw14_bw_agreedamount))'');
    populated_flsa_smw14_bw_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_smw14_bw_agreedamount = (TYPEOF(h.flsa_smw14_bw_agreedamount))'',0,100));
    maxlength_flsa_smw14_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smw14_bw_agreedamount)));
    avelength_flsa_smw14_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smw14_bw_agreedamount)),h.flsa_smw14_bw_agreedamount<>(typeof(h.flsa_smw14_bw_agreedamount))'');
    populated_flsa_smw14_countviolations_cnt := COUNT(GROUP,h.flsa_smw14_countviolations <> (TYPEOF(h.flsa_smw14_countviolations))'');
    populated_flsa_smw14_countviolations_pcnt := AVE(GROUP,IF(h.flsa_smw14_countviolations = (TYPEOF(h.flsa_smw14_countviolations))'',0,100));
    maxlength_flsa_smw14_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smw14_countviolations)));
    avelength_flsa_smw14_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smw14_countviolations)),h.flsa_smw14_countviolations<>(typeof(h.flsa_smw14_countviolations))'');
    populated_flsa_smw14_ee_agreedcount_cnt := COUNT(GROUP,h.flsa_smw14_ee_agreedcount <> (TYPEOF(h.flsa_smw14_ee_agreedcount))'');
    populated_flsa_smw14_ee_agreedcount_pcnt := AVE(GROUP,IF(h.flsa_smw14_ee_agreedcount = (TYPEOF(h.flsa_smw14_ee_agreedcount))'',0,100));
    maxlength_flsa_smw14_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smw14_ee_agreedcount)));
    avelength_flsa_smw14_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smw14_ee_agreedcount)),h.flsa_smw14_ee_agreedcount<>(typeof(h.flsa_smw14_ee_agreedcount))'');
    populated_flsa_smwap_countviolations_cnt := COUNT(GROUP,h.flsa_smwap_countviolations <> (TYPEOF(h.flsa_smwap_countviolations))'');
    populated_flsa_smwap_countviolations_pcnt := AVE(GROUP,IF(h.flsa_smwap_countviolations = (TYPEOF(h.flsa_smwap_countviolations))'',0,100));
    maxlength_flsa_smwap_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwap_countviolations)));
    avelength_flsa_smwap_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwap_countviolations)),h.flsa_smwap_countviolations<>(typeof(h.flsa_smwap_countviolations))'');
    populated_flsa_smwap_bw_agreedamount_cnt := COUNT(GROUP,h.flsa_smwap_bw_agreedamount <> (TYPEOF(h.flsa_smwap_bw_agreedamount))'');
    populated_flsa_smwap_bw_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_smwap_bw_agreedamount = (TYPEOF(h.flsa_smwap_bw_agreedamount))'',0,100));
    maxlength_flsa_smwap_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwap_bw_agreedamount)));
    avelength_flsa_smwap_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwap_bw_agreedamount)),h.flsa_smwap_bw_agreedamount<>(typeof(h.flsa_smwap_bw_agreedamount))'');
    populated_flsa_smwap_ee_agreedcount_cnt := COUNT(GROUP,h.flsa_smwap_ee_agreedcount <> (TYPEOF(h.flsa_smwap_ee_agreedcount))'');
    populated_flsa_smwap_ee_agreedcount_pcnt := AVE(GROUP,IF(h.flsa_smwap_ee_agreedcount = (TYPEOF(h.flsa_smwap_ee_agreedcount))'',0,100));
    maxlength_flsa_smwap_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwap_ee_agreedcount)));
    avelength_flsa_smwap_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwap_ee_agreedcount)),h.flsa_smwap_ee_agreedcount<>(typeof(h.flsa_smwap_ee_agreedcount))'');
    populated_flsa_smwft_countviolations_cnt := COUNT(GROUP,h.flsa_smwft_countviolations <> (TYPEOF(h.flsa_smwft_countviolations))'');
    populated_flsa_smwft_countviolations_pcnt := AVE(GROUP,IF(h.flsa_smwft_countviolations = (TYPEOF(h.flsa_smwft_countviolations))'',0,100));
    maxlength_flsa_smwft_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwft_countviolations)));
    avelength_flsa_smwft_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwft_countviolations)),h.flsa_smwft_countviolations<>(typeof(h.flsa_smwft_countviolations))'');
    populated_flsa_smwft_bw_agreedamount_cnt := COUNT(GROUP,h.flsa_smwft_bw_agreedamount <> (TYPEOF(h.flsa_smwft_bw_agreedamount))'');
    populated_flsa_smwft_bw_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_smwft_bw_agreedamount = (TYPEOF(h.flsa_smwft_bw_agreedamount))'',0,100));
    maxlength_flsa_smwft_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwft_bw_agreedamount)));
    avelength_flsa_smwft_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwft_bw_agreedamount)),h.flsa_smwft_bw_agreedamount<>(typeof(h.flsa_smwft_bw_agreedamount))'');
    populated_flsa_smwft_ee_agreedcount_cnt := COUNT(GROUP,h.flsa_smwft_ee_agreedcount <> (TYPEOF(h.flsa_smwft_ee_agreedcount))'');
    populated_flsa_smwft_ee_agreedcount_pcnt := AVE(GROUP,IF(h.flsa_smwft_ee_agreedcount = (TYPEOF(h.flsa_smwft_ee_agreedcount))'',0,100));
    maxlength_flsa_smwft_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwft_ee_agreedcount)));
    avelength_flsa_smwft_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwft_ee_agreedcount)),h.flsa_smwft_ee_agreedcount<>(typeof(h.flsa_smwft_ee_agreedcount))'');
    populated_flsa_smwl_countviolations_cnt := COUNT(GROUP,h.flsa_smwl_countviolations <> (TYPEOF(h.flsa_smwl_countviolations))'');
    populated_flsa_smwl_countviolations_pcnt := AVE(GROUP,IF(h.flsa_smwl_countviolations = (TYPEOF(h.flsa_smwl_countviolations))'',0,100));
    maxlength_flsa_smwl_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwl_countviolations)));
    avelength_flsa_smwl_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwl_countviolations)),h.flsa_smwl_countviolations<>(typeof(h.flsa_smwl_countviolations))'');
    populated_flsa_smwl_bw_agreedamount_cnt := COUNT(GROUP,h.flsa_smwl_bw_agreedamount <> (TYPEOF(h.flsa_smwl_bw_agreedamount))'');
    populated_flsa_smwl_bw_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_smwl_bw_agreedamount = (TYPEOF(h.flsa_smwl_bw_agreedamount))'',0,100));
    maxlength_flsa_smwl_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwl_bw_agreedamount)));
    avelength_flsa_smwl_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwl_bw_agreedamount)),h.flsa_smwl_bw_agreedamount<>(typeof(h.flsa_smwl_bw_agreedamount))'');
    populated_flsa_smwl_ee_agreedcount_cnt := COUNT(GROUP,h.flsa_smwl_ee_agreedcount <> (TYPEOF(h.flsa_smwl_ee_agreedcount))'');
    populated_flsa_smwl_ee_agreedcount_pcnt := AVE(GROUP,IF(h.flsa_smwl_ee_agreedcount = (TYPEOF(h.flsa_smwl_ee_agreedcount))'',0,100));
    maxlength_flsa_smwl_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwl_ee_agreedcount)));
    avelength_flsa_smwl_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwl_ee_agreedcount)),h.flsa_smwl_ee_agreedcount<>(typeof(h.flsa_smwl_ee_agreedcount))'');
    populated_flsa_smwmg_countviolations_cnt := COUNT(GROUP,h.flsa_smwmg_countviolations <> (TYPEOF(h.flsa_smwmg_countviolations))'');
    populated_flsa_smwmg_countviolations_pcnt := AVE(GROUP,IF(h.flsa_smwmg_countviolations = (TYPEOF(h.flsa_smwmg_countviolations))'',0,100));
    maxlength_flsa_smwmg_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwmg_countviolations)));
    avelength_flsa_smwmg_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwmg_countviolations)),h.flsa_smwmg_countviolations<>(typeof(h.flsa_smwmg_countviolations))'');
    populated_flsa_smwmg_bw_agreedamount_cnt := COUNT(GROUP,h.flsa_smwmg_bw_agreedamount <> (TYPEOF(h.flsa_smwmg_bw_agreedamount))'');
    populated_flsa_smwmg_bw_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_smwmg_bw_agreedamount = (TYPEOF(h.flsa_smwmg_bw_agreedamount))'',0,100));
    maxlength_flsa_smwmg_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwmg_bw_agreedamount)));
    avelength_flsa_smwmg_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwmg_bw_agreedamount)),h.flsa_smwmg_bw_agreedamount<>(typeof(h.flsa_smwmg_bw_agreedamount))'');
    populated_flsa_smwmg_ee_agreedcount_cnt := COUNT(GROUP,h.flsa_smwmg_ee_agreedcount <> (TYPEOF(h.flsa_smwmg_ee_agreedcount))'');
    populated_flsa_smwmg_ee_agreedcount_pcnt := AVE(GROUP,IF(h.flsa_smwmg_ee_agreedcount = (TYPEOF(h.flsa_smwmg_ee_agreedcount))'',0,100));
    maxlength_flsa_smwmg_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwmg_ee_agreedcount)));
    avelength_flsa_smwmg_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwmg_ee_agreedcount)),h.flsa_smwmg_ee_agreedcount<>(typeof(h.flsa_smwmg_ee_agreedcount))'');
    populated_flsa_smwpw_countviolations_cnt := COUNT(GROUP,h.flsa_smwpw_countviolations <> (TYPEOF(h.flsa_smwpw_countviolations))'');
    populated_flsa_smwpw_countviolations_pcnt := AVE(GROUP,IF(h.flsa_smwpw_countviolations = (TYPEOF(h.flsa_smwpw_countviolations))'',0,100));
    maxlength_flsa_smwpw_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwpw_countviolations)));
    avelength_flsa_smwpw_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwpw_countviolations)),h.flsa_smwpw_countviolations<>(typeof(h.flsa_smwpw_countviolations))'');
    populated_flsa_smwpw_bw_agreedamount_cnt := COUNT(GROUP,h.flsa_smwpw_bw_agreedamount <> (TYPEOF(h.flsa_smwpw_bw_agreedamount))'');
    populated_flsa_smwpw_bw_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_smwpw_bw_agreedamount = (TYPEOF(h.flsa_smwpw_bw_agreedamount))'',0,100));
    maxlength_flsa_smwpw_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwpw_bw_agreedamount)));
    avelength_flsa_smwpw_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwpw_bw_agreedamount)),h.flsa_smwpw_bw_agreedamount<>(typeof(h.flsa_smwpw_bw_agreedamount))'');
    populated_flsa_smwpw_ee_agreedcount_cnt := COUNT(GROUP,h.flsa_smwpw_ee_agreedcount <> (TYPEOF(h.flsa_smwpw_ee_agreedcount))'');
    populated_flsa_smwpw_ee_agreedcount_pcnt := AVE(GROUP,IF(h.flsa_smwpw_ee_agreedcount = (TYPEOF(h.flsa_smwpw_ee_agreedcount))'',0,100));
    maxlength_flsa_smwpw_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwpw_ee_agreedcount)));
    avelength_flsa_smwpw_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwpw_ee_agreedcount)),h.flsa_smwpw_ee_agreedcount<>(typeof(h.flsa_smwpw_ee_agreedcount))'');
    populated_flsa_smwsl_countviolations_cnt := COUNT(GROUP,h.flsa_smwsl_countviolations <> (TYPEOF(h.flsa_smwsl_countviolations))'');
    populated_flsa_smwsl_countviolations_pcnt := AVE(GROUP,IF(h.flsa_smwsl_countviolations = (TYPEOF(h.flsa_smwsl_countviolations))'',0,100));
    maxlength_flsa_smwsl_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwsl_countviolations)));
    avelength_flsa_smwsl_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwsl_countviolations)),h.flsa_smwsl_countviolations<>(typeof(h.flsa_smwsl_countviolations))'');
    populated_flsa_smwsl_bw_agreedamount_cnt := COUNT(GROUP,h.flsa_smwsl_bw_agreedamount <> (TYPEOF(h.flsa_smwsl_bw_agreedamount))'');
    populated_flsa_smwsl_bw_agreedamount_pcnt := AVE(GROUP,IF(h.flsa_smwsl_bw_agreedamount = (TYPEOF(h.flsa_smwsl_bw_agreedamount))'',0,100));
    maxlength_flsa_smwsl_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwsl_bw_agreedamount)));
    avelength_flsa_smwsl_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwsl_bw_agreedamount)),h.flsa_smwsl_bw_agreedamount<>(typeof(h.flsa_smwsl_bw_agreedamount))'');
    populated_flsa_smwsl_ee_agreedcount_cnt := COUNT(GROUP,h.flsa_smwsl_ee_agreedcount <> (TYPEOF(h.flsa_smwsl_ee_agreedcount))'');
    populated_flsa_smwsl_ee_agreedcount_pcnt := AVE(GROUP,IF(h.flsa_smwsl_ee_agreedcount = (TYPEOF(h.flsa_smwsl_ee_agreedcount))'',0,100));
    maxlength_flsa_smwsl_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwsl_ee_agreedcount)));
    avelength_flsa_smwsl_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flsa_smwsl_ee_agreedcount)),h.flsa_smwsl_ee_agreedcount<>(typeof(h.flsa_smwsl_ee_agreedcount))'');
    populated_fmla_countviolations_cnt := COUNT(GROUP,h.fmla_countviolations <> (TYPEOF(h.fmla_countviolations))'');
    populated_fmla_countviolations_pcnt := AVE(GROUP,IF(h.fmla_countviolations = (TYPEOF(h.fmla_countviolations))'',0,100));
    maxlength_fmla_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fmla_countviolations)));
    avelength_fmla_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fmla_countviolations)),h.fmla_countviolations<>(typeof(h.fmla_countviolations))'');
    populated_fmla_bw_agreedamount_cnt := COUNT(GROUP,h.fmla_bw_agreedamount <> (TYPEOF(h.fmla_bw_agreedamount))'');
    populated_fmla_bw_agreedamount_pcnt := AVE(GROUP,IF(h.fmla_bw_agreedamount = (TYPEOF(h.fmla_bw_agreedamount))'',0,100));
    maxlength_fmla_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fmla_bw_agreedamount)));
    avelength_fmla_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fmla_bw_agreedamount)),h.fmla_bw_agreedamount<>(typeof(h.fmla_bw_agreedamount))'');
    populated_fmla_cmp_assessedamount_cnt := COUNT(GROUP,h.fmla_cmp_assessedamount <> (TYPEOF(h.fmla_cmp_assessedamount))'');
    populated_fmla_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.fmla_cmp_assessedamount = (TYPEOF(h.fmla_cmp_assessedamount))'',0,100));
    maxlength_fmla_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fmla_cmp_assessedamount)));
    avelength_fmla_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fmla_cmp_assessedamount)),h.fmla_cmp_assessedamount<>(typeof(h.fmla_cmp_assessedamount))'');
    populated_fmla_ee_agreedcount_cnt := COUNT(GROUP,h.fmla_ee_agreedcount <> (TYPEOF(h.fmla_ee_agreedcount))'');
    populated_fmla_ee_agreedcount_pcnt := AVE(GROUP,IF(h.fmla_ee_agreedcount = (TYPEOF(h.fmla_ee_agreedcount))'',0,100));
    maxlength_fmla_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fmla_ee_agreedcount)));
    avelength_fmla_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fmla_ee_agreedcount)),h.fmla_ee_agreedcount<>(typeof(h.fmla_ee_agreedcount))'');
    populated_h1a_countviolations_cnt := COUNT(GROUP,h.h1a_countviolations <> (TYPEOF(h.h1a_countviolations))'');
    populated_h1a_countviolations_pcnt := AVE(GROUP,IF(h.h1a_countviolations = (TYPEOF(h.h1a_countviolations))'',0,100));
    maxlength_h1a_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1a_countviolations)));
    avelength_h1a_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1a_countviolations)),h.h1a_countviolations<>(typeof(h.h1a_countviolations))'');
    populated_h1a_bw_agreedamount_cnt := COUNT(GROUP,h.h1a_bw_agreedamount <> (TYPEOF(h.h1a_bw_agreedamount))'');
    populated_h1a_bw_agreedamount_pcnt := AVE(GROUP,IF(h.h1a_bw_agreedamount = (TYPEOF(h.h1a_bw_agreedamount))'',0,100));
    maxlength_h1a_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1a_bw_agreedamount)));
    avelength_h1a_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1a_bw_agreedamount)),h.h1a_bw_agreedamount<>(typeof(h.h1a_bw_agreedamount))'');
    populated_h1a_cmp_assessedamount_cnt := COUNT(GROUP,h.h1a_cmp_assessedamount <> (TYPEOF(h.h1a_cmp_assessedamount))'');
    populated_h1a_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.h1a_cmp_assessedamount = (TYPEOF(h.h1a_cmp_assessedamount))'',0,100));
    maxlength_h1a_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1a_cmp_assessedamount)));
    avelength_h1a_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1a_cmp_assessedamount)),h.h1a_cmp_assessedamount<>(typeof(h.h1a_cmp_assessedamount))'');
    populated_h1a_ee_agreedcount_cnt := COUNT(GROUP,h.h1a_ee_agreedcount <> (TYPEOF(h.h1a_ee_agreedcount))'');
    populated_h1a_ee_agreedcount_pcnt := AVE(GROUP,IF(h.h1a_ee_agreedcount = (TYPEOF(h.h1a_ee_agreedcount))'',0,100));
    maxlength_h1a_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1a_ee_agreedcount)));
    avelength_h1a_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1a_ee_agreedcount)),h.h1a_ee_agreedcount<>(typeof(h.h1a_ee_agreedcount))'');
    populated_h1b_countviolations_cnt := COUNT(GROUP,h.h1b_countviolations <> (TYPEOF(h.h1b_countviolations))'');
    populated_h1b_countviolations_pcnt := AVE(GROUP,IF(h.h1b_countviolations = (TYPEOF(h.h1b_countviolations))'',0,100));
    maxlength_h1b_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1b_countviolations)));
    avelength_h1b_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1b_countviolations)),h.h1b_countviolations<>(typeof(h.h1b_countviolations))'');
    populated_h1b_bw_agreedamount_cnt := COUNT(GROUP,h.h1b_bw_agreedamount <> (TYPEOF(h.h1b_bw_agreedamount))'');
    populated_h1b_bw_agreedamount_pcnt := AVE(GROUP,IF(h.h1b_bw_agreedamount = (TYPEOF(h.h1b_bw_agreedamount))'',0,100));
    maxlength_h1b_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1b_bw_agreedamount)));
    avelength_h1b_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1b_bw_agreedamount)),h.h1b_bw_agreedamount<>(typeof(h.h1b_bw_agreedamount))'');
    populated_h1b_cmp_assessedamount_cnt := COUNT(GROUP,h.h1b_cmp_assessedamount <> (TYPEOF(h.h1b_cmp_assessedamount))'');
    populated_h1b_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.h1b_cmp_assessedamount = (TYPEOF(h.h1b_cmp_assessedamount))'',0,100));
    maxlength_h1b_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1b_cmp_assessedamount)));
    avelength_h1b_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1b_cmp_assessedamount)),h.h1b_cmp_assessedamount<>(typeof(h.h1b_cmp_assessedamount))'');
    populated_h1b_ee_agreedcount_cnt := COUNT(GROUP,h.h1b_ee_agreedcount <> (TYPEOF(h.h1b_ee_agreedcount))'');
    populated_h1b_ee_agreedcount_pcnt := AVE(GROUP,IF(h.h1b_ee_agreedcount = (TYPEOF(h.h1b_ee_agreedcount))'',0,100));
    maxlength_h1b_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1b_ee_agreedcount)));
    avelength_h1b_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h1b_ee_agreedcount)),h.h1b_ee_agreedcount<>(typeof(h.h1b_ee_agreedcount))'');
    populated_h2a_countviolations_cnt := COUNT(GROUP,h.h2a_countviolations <> (TYPEOF(h.h2a_countviolations))'');
    populated_h2a_countviolations_pcnt := AVE(GROUP,IF(h.h2a_countviolations = (TYPEOF(h.h2a_countviolations))'',0,100));
    maxlength_h2a_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2a_countviolations)));
    avelength_h2a_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2a_countviolations)),h.h2a_countviolations<>(typeof(h.h2a_countviolations))'');
    populated_h2a_bw_agreedamount_cnt := COUNT(GROUP,h.h2a_bw_agreedamount <> (TYPEOF(h.h2a_bw_agreedamount))'');
    populated_h2a_bw_agreedamount_pcnt := AVE(GROUP,IF(h.h2a_bw_agreedamount = (TYPEOF(h.h2a_bw_agreedamount))'',0,100));
    maxlength_h2a_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2a_bw_agreedamount)));
    avelength_h2a_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2a_bw_agreedamount)),h.h2a_bw_agreedamount<>(typeof(h.h2a_bw_agreedamount))'');
    populated_h2a_cmp_assessedamount_cnt := COUNT(GROUP,h.h2a_cmp_assessedamount <> (TYPEOF(h.h2a_cmp_assessedamount))'');
    populated_h2a_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.h2a_cmp_assessedamount = (TYPEOF(h.h2a_cmp_assessedamount))'',0,100));
    maxlength_h2a_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2a_cmp_assessedamount)));
    avelength_h2a_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2a_cmp_assessedamount)),h.h2a_cmp_assessedamount<>(typeof(h.h2a_cmp_assessedamount))'');
    populated_h2a_ee_agreedcount_cnt := COUNT(GROUP,h.h2a_ee_agreedcount <> (TYPEOF(h.h2a_ee_agreedcount))'');
    populated_h2a_ee_agreedcount_pcnt := AVE(GROUP,IF(h.h2a_ee_agreedcount = (TYPEOF(h.h2a_ee_agreedcount))'',0,100));
    maxlength_h2a_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2a_ee_agreedcount)));
    avelength_h2a_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2a_ee_agreedcount)),h.h2a_ee_agreedcount<>(typeof(h.h2a_ee_agreedcount))'');
    populated_h2b_countviolations_cnt := COUNT(GROUP,h.h2b_countviolations <> (TYPEOF(h.h2b_countviolations))'');
    populated_h2b_countviolations_pcnt := AVE(GROUP,IF(h.h2b_countviolations = (TYPEOF(h.h2b_countviolations))'',0,100));
    maxlength_h2b_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2b_countviolations)));
    avelength_h2b_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2b_countviolations)),h.h2b_countviolations<>(typeof(h.h2b_countviolations))'');
    populated_h2b_bw_agreedamount_cnt := COUNT(GROUP,h.h2b_bw_agreedamount <> (TYPEOF(h.h2b_bw_agreedamount))'');
    populated_h2b_bw_agreedamount_pcnt := AVE(GROUP,IF(h.h2b_bw_agreedamount = (TYPEOF(h.h2b_bw_agreedamount))'',0,100));
    maxlength_h2b_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2b_bw_agreedamount)));
    avelength_h2b_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2b_bw_agreedamount)),h.h2b_bw_agreedamount<>(typeof(h.h2b_bw_agreedamount))'');
    populated_h2b_ee_agreedcount_cnt := COUNT(GROUP,h.h2b_ee_agreedcount <> (TYPEOF(h.h2b_ee_agreedcount))'');
    populated_h2b_ee_agreedcount_pcnt := AVE(GROUP,IF(h.h2b_ee_agreedcount = (TYPEOF(h.h2b_ee_agreedcount))'',0,100));
    maxlength_h2b_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2b_ee_agreedcount)));
    avelength_h2b_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.h2b_ee_agreedcount)),h.h2b_ee_agreedcount<>(typeof(h.h2b_ee_agreedcount))'');
    populated_mpsa_countviolations_cnt := COUNT(GROUP,h.mpsa_countviolations <> (TYPEOF(h.mpsa_countviolations))'');
    populated_mpsa_countviolations_pcnt := AVE(GROUP,IF(h.mpsa_countviolations = (TYPEOF(h.mpsa_countviolations))'',0,100));
    maxlength_mpsa_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mpsa_countviolations)));
    avelength_mpsa_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mpsa_countviolations)),h.mpsa_countviolations<>(typeof(h.mpsa_countviolations))'');
    populated_mpsa_bw_agreedamount_cnt := COUNT(GROUP,h.mpsa_bw_agreedamount <> (TYPEOF(h.mpsa_bw_agreedamount))'');
    populated_mpsa_bw_agreedamount_pcnt := AVE(GROUP,IF(h.mpsa_bw_agreedamount = (TYPEOF(h.mpsa_bw_agreedamount))'',0,100));
    maxlength_mpsa_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mpsa_bw_agreedamount)));
    avelength_mpsa_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mpsa_bw_agreedamount)),h.mpsa_bw_agreedamount<>(typeof(h.mpsa_bw_agreedamount))'');
    populated_mpsa_cmp_assessedamount_cnt := COUNT(GROUP,h.mpsa_cmp_assessedamount <> (TYPEOF(h.mpsa_cmp_assessedamount))'');
    populated_mpsa_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.mpsa_cmp_assessedamount = (TYPEOF(h.mpsa_cmp_assessedamount))'',0,100));
    maxlength_mpsa_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mpsa_cmp_assessedamount)));
    avelength_mpsa_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mpsa_cmp_assessedamount)),h.mpsa_cmp_assessedamount<>(typeof(h.mpsa_cmp_assessedamount))'');
    populated_mpsa_ee_agreedcount_cnt := COUNT(GROUP,h.mpsa_ee_agreedcount <> (TYPEOF(h.mpsa_ee_agreedcount))'');
    populated_mpsa_ee_agreedcount_pcnt := AVE(GROUP,IF(h.mpsa_ee_agreedcount = (TYPEOF(h.mpsa_ee_agreedcount))'',0,100));
    maxlength_mpsa_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mpsa_ee_agreedcount)));
    avelength_mpsa_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mpsa_ee_agreedcount)),h.mpsa_ee_agreedcount<>(typeof(h.mpsa_ee_agreedcount))'');
    populated_osha_countviolations_cnt := COUNT(GROUP,h.osha_countviolations <> (TYPEOF(h.osha_countviolations))'');
    populated_osha_countviolations_pcnt := AVE(GROUP,IF(h.osha_countviolations = (TYPEOF(h.osha_countviolations))'',0,100));
    maxlength_osha_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.osha_countviolations)));
    avelength_osha_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.osha_countviolations)),h.osha_countviolations<>(typeof(h.osha_countviolations))'');
    populated_osha_bw_agreedamount_cnt := COUNT(GROUP,h.osha_bw_agreedamount <> (TYPEOF(h.osha_bw_agreedamount))'');
    populated_osha_bw_agreedamount_pcnt := AVE(GROUP,IF(h.osha_bw_agreedamount = (TYPEOF(h.osha_bw_agreedamount))'',0,100));
    maxlength_osha_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.osha_bw_agreedamount)));
    avelength_osha_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.osha_bw_agreedamount)),h.osha_bw_agreedamount<>(typeof(h.osha_bw_agreedamount))'');
    populated_osha_cmp_assessedamount_cnt := COUNT(GROUP,h.osha_cmp_assessedamount <> (TYPEOF(h.osha_cmp_assessedamount))'');
    populated_osha_cmp_assessedamount_pcnt := AVE(GROUP,IF(h.osha_cmp_assessedamount = (TYPEOF(h.osha_cmp_assessedamount))'',0,100));
    maxlength_osha_cmp_assessedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.osha_cmp_assessedamount)));
    avelength_osha_cmp_assessedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.osha_cmp_assessedamount)),h.osha_cmp_assessedamount<>(typeof(h.osha_cmp_assessedamount))'');
    populated_osha_ee_agreedcount_cnt := COUNT(GROUP,h.osha_ee_agreedcount <> (TYPEOF(h.osha_ee_agreedcount))'');
    populated_osha_ee_agreedcount_pcnt := AVE(GROUP,IF(h.osha_ee_agreedcount = (TYPEOF(h.osha_ee_agreedcount))'',0,100));
    maxlength_osha_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.osha_ee_agreedcount)));
    avelength_osha_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.osha_ee_agreedcount)),h.osha_ee_agreedcount<>(typeof(h.osha_ee_agreedcount))'');
    populated_pca_countviolations_cnt := COUNT(GROUP,h.pca_countviolations <> (TYPEOF(h.pca_countviolations))'');
    populated_pca_countviolations_pcnt := AVE(GROUP,IF(h.pca_countviolations = (TYPEOF(h.pca_countviolations))'',0,100));
    maxlength_pca_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pca_countviolations)));
    avelength_pca_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pca_countviolations)),h.pca_countviolations<>(typeof(h.pca_countviolations))'');
    populated_pca_bw_agreedamount_cnt := COUNT(GROUP,h.pca_bw_agreedamount <> (TYPEOF(h.pca_bw_agreedamount))'');
    populated_pca_bw_agreedamount_pcnt := AVE(GROUP,IF(h.pca_bw_agreedamount = (TYPEOF(h.pca_bw_agreedamount))'',0,100));
    maxlength_pca_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pca_bw_agreedamount)));
    avelength_pca_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pca_bw_agreedamount)),h.pca_bw_agreedamount<>(typeof(h.pca_bw_agreedamount))'');
    populated_pca_ee_agreedcount_cnt := COUNT(GROUP,h.pca_ee_agreedcount <> (TYPEOF(h.pca_ee_agreedcount))'');
    populated_pca_ee_agreedcount_pcnt := AVE(GROUP,IF(h.pca_ee_agreedcount = (TYPEOF(h.pca_ee_agreedcount))'',0,100));
    maxlength_pca_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pca_ee_agreedcount)));
    avelength_pca_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pca_ee_agreedcount)),h.pca_ee_agreedcount<>(typeof(h.pca_ee_agreedcount))'');
    populated_sca_countviolations_cnt := COUNT(GROUP,h.sca_countviolations <> (TYPEOF(h.sca_countviolations))'');
    populated_sca_countviolations_pcnt := AVE(GROUP,IF(h.sca_countviolations = (TYPEOF(h.sca_countviolations))'',0,100));
    maxlength_sca_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sca_countviolations)));
    avelength_sca_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sca_countviolations)),h.sca_countviolations<>(typeof(h.sca_countviolations))'');
    populated_sca_bw_agreedamount_cnt := COUNT(GROUP,h.sca_bw_agreedamount <> (TYPEOF(h.sca_bw_agreedamount))'');
    populated_sca_bw_agreedamount_pcnt := AVE(GROUP,IF(h.sca_bw_agreedamount = (TYPEOF(h.sca_bw_agreedamount))'',0,100));
    maxlength_sca_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sca_bw_agreedamount)));
    avelength_sca_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sca_bw_agreedamount)),h.sca_bw_agreedamount<>(typeof(h.sca_bw_agreedamount))'');
    populated_sca_ee_agreedcount_cnt := COUNT(GROUP,h.sca_ee_agreedcount <> (TYPEOF(h.sca_ee_agreedcount))'');
    populated_sca_ee_agreedcount_pcnt := AVE(GROUP,IF(h.sca_ee_agreedcount = (TYPEOF(h.sca_ee_agreedcount))'',0,100));
    maxlength_sca_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sca_ee_agreedcount)));
    avelength_sca_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sca_ee_agreedcount)),h.sca_ee_agreedcount<>(typeof(h.sca_ee_agreedcount))'');
    populated_sraw_countviolations_cnt := COUNT(GROUP,h.sraw_countviolations <> (TYPEOF(h.sraw_countviolations))'');
    populated_sraw_countviolations_pcnt := AVE(GROUP,IF(h.sraw_countviolations = (TYPEOF(h.sraw_countviolations))'',0,100));
    maxlength_sraw_countviolations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sraw_countviolations)));
    avelength_sraw_countviolations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sraw_countviolations)),h.sraw_countviolations<>(typeof(h.sraw_countviolations))'');
    populated_sraw_bw_agreedamount_cnt := COUNT(GROUP,h.sraw_bw_agreedamount <> (TYPEOF(h.sraw_bw_agreedamount))'');
    populated_sraw_bw_agreedamount_pcnt := AVE(GROUP,IF(h.sraw_bw_agreedamount = (TYPEOF(h.sraw_bw_agreedamount))'',0,100));
    maxlength_sraw_bw_agreedamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sraw_bw_agreedamount)));
    avelength_sraw_bw_agreedamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sraw_bw_agreedamount)),h.sraw_bw_agreedamount<>(typeof(h.sraw_bw_agreedamount))'');
    populated_sraw_ee_agreedcount_cnt := COUNT(GROUP,h.sraw_ee_agreedcount <> (TYPEOF(h.sraw_ee_agreedcount))'');
    populated_sraw_ee_agreedcount_pcnt := AVE(GROUP,IF(h.sraw_ee_agreedcount = (TYPEOF(h.sraw_ee_agreedcount))'',0,100));
    maxlength_sraw_ee_agreedcount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sraw_ee_agreedcount)));
    avelength_sraw_ee_agreedcount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sraw_ee_agreedcount)),h.sraw_ee_agreedcount<>(typeof(h.sraw_ee_agreedcount))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dartid_pcnt *   0.00 / 100 + T.Populated_dateadded_pcnt *   0.00 / 100 + T.Populated_dateupdated_pcnt *   0.00 / 100 + T.Populated_website_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_employername_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_employerstate_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_naicscode_pcnt *   0.00 / 100 + T.Populated_totalviolations_pcnt *   0.00 / 100 + T.Populated_bw_totalagreedamount_pcnt *   0.00 / 100 + T.Populated_cmp_totalassessments_pcnt *   0.00 / 100 + T.Populated_ee_totalviolations_pcnt *   0.00 / 100 + T.Populated_ee_totalagreedcount_pcnt *   0.00 / 100 + T.Populated_ca_countviolations_pcnt *   0.00 / 100 + T.Populated_ca_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_ca_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_ccpa_countviolations_pcnt *   0.00 / 100 + T.Populated_ccpa_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_ccpa_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_crew_countviolations_pcnt *   0.00 / 100 + T.Populated_crew_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_crew_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_crew_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_cwhssa_countviolations_pcnt *   0.00 / 100 + T.Populated_cwhssa_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_cwhssa_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_dbra_cl_countviolations_pcnt *   0.00 / 100 + T.Populated_dbra_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_dbra_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_eev_countviolations_pcnt *   0.00 / 100 + T.Populated_eppa_countviolations_pcnt *   0.00 / 100 + T.Populated_eppa_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_eppa_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_eppa_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_flsa_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_bw_15a3_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_bw_minwage_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_bw_overtime_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_flsa_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_flsa_cl_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_cl_countminorsemployed_pcnt *   0.00 / 100 + T.Populated_flsa_cl_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_flsa_hmwkr_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_hmwkr_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_hmwkr_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_flsa_hmwkr_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_flsa_smw14_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_smw14_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_smw14_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_flsa_smwap_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_smwap_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_smwap_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_flsa_smwft_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_smwft_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_smwft_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_flsa_smwl_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_smwl_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_smwl_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_flsa_smwmg_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_smwmg_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_smwmg_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_flsa_smwpw_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_smwpw_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_smwpw_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_flsa_smwsl_countviolations_pcnt *   0.00 / 100 + T.Populated_flsa_smwsl_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_flsa_smwsl_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_fmla_countviolations_pcnt *   0.00 / 100 + T.Populated_fmla_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_fmla_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_fmla_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_h1a_countviolations_pcnt *   0.00 / 100 + T.Populated_h1a_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_h1a_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_h1a_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_h1b_countviolations_pcnt *   0.00 / 100 + T.Populated_h1b_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_h1b_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_h1b_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_h2a_countviolations_pcnt *   0.00 / 100 + T.Populated_h2a_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_h2a_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_h2a_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_h2b_countviolations_pcnt *   0.00 / 100 + T.Populated_h2b_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_h2b_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_mpsa_countviolations_pcnt *   0.00 / 100 + T.Populated_mpsa_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_mpsa_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_mpsa_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_osha_countviolations_pcnt *   0.00 / 100 + T.Populated_osha_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_osha_cmp_assessedamount_pcnt *   0.00 / 100 + T.Populated_osha_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_pca_countviolations_pcnt *   0.00 / 100 + T.Populated_pca_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_pca_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_sca_countviolations_pcnt *   0.00 / 100 + T.Populated_sca_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_sca_ee_agreedcount_pcnt *   0.00 / 100 + T.Populated_sraw_countviolations_pcnt *   0.00 / 100 + T.Populated_sraw_bw_agreedamount_pcnt *   0.00 / 100 + T.Populated_sraw_ee_agreedcount_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dartid','dateadded','dateupdated','website','state','caseid','employername','address1','city','employerstate','zipcode','naicscode','totalviolations','bw_totalagreedamount','cmp_totalassessments','ee_totalviolations','ee_totalagreedcount','ca_countviolations','ca_bw_agreedamount','ca_ee_agreedcount','ccpa_countviolations','ccpa_bw_agreedamount','ccpa_ee_agreedcount','crew_countviolations','crew_bw_agreedamount','crew_cmp_assessedamount','crew_ee_agreedcount','cwhssa_countviolations','cwhssa_bw_agreedamount','cwhssa_ee_agreedcount','dbra_cl_countviolations','dbra_bw_agreedamount','dbra_ee_agreedcount','eev_countviolations','eppa_countviolations','eppa_bw_agreedamount','eppa_cmp_assessedamount','eppa_ee_agreedcount','flsa_countviolations','flsa_bw_15a3_agreedamount','flsa_bw_agreedamount','flsa_bw_minwage_agreedamount','flsa_bw_overtime_agreedamount','flsa_cmp_assessedamount','flsa_ee_agreedcount','flsa_cl_countviolations','flsa_cl_countminorsemployed','flsa_cl_cmp_assessedamount','flsa_hmwkr_countviolations','flsa_hmwkr_bw_agreedamount','flsa_hmwkr_cmp_assessedamount','flsa_hmwkr_ee_agreedcount','flsa_smw14_bw_agreedamount','flsa_smw14_countviolations','flsa_smw14_ee_agreedcount','flsa_smwap_countviolations','flsa_smwap_bw_agreedamount','flsa_smwap_ee_agreedcount','flsa_smwft_countviolations','flsa_smwft_bw_agreedamount','flsa_smwft_ee_agreedcount','flsa_smwl_countviolations','flsa_smwl_bw_agreedamount','flsa_smwl_ee_agreedcount','flsa_smwmg_countviolations','flsa_smwmg_bw_agreedamount','flsa_smwmg_ee_agreedcount','flsa_smwpw_countviolations','flsa_smwpw_bw_agreedamount','flsa_smwpw_ee_agreedcount','flsa_smwsl_countviolations','flsa_smwsl_bw_agreedamount','flsa_smwsl_ee_agreedcount','fmla_countviolations','fmla_bw_agreedamount','fmla_cmp_assessedamount','fmla_ee_agreedcount','h1a_countviolations','h1a_bw_agreedamount','h1a_cmp_assessedamount','h1a_ee_agreedcount','h1b_countviolations','h1b_bw_agreedamount','h1b_cmp_assessedamount','h1b_ee_agreedcount','h2a_countviolations','h2a_bw_agreedamount','h2a_cmp_assessedamount','h2a_ee_agreedcount','h2b_countviolations','h2b_bw_agreedamount','h2b_ee_agreedcount','mpsa_countviolations','mpsa_bw_agreedamount','mpsa_cmp_assessedamount','mpsa_ee_agreedcount','osha_countviolations','osha_bw_agreedamount','osha_cmp_assessedamount','osha_ee_agreedcount','pca_countviolations','pca_bw_agreedamount','pca_ee_agreedcount','sca_countviolations','sca_bw_agreedamount','sca_ee_agreedcount','sraw_countviolations','sraw_bw_agreedamount','sraw_ee_agreedcount');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dartid_pcnt,le.populated_dateadded_pcnt,le.populated_dateupdated_pcnt,le.populated_website_pcnt,le.populated_state_pcnt,le.populated_caseid_pcnt,le.populated_employername_pcnt,le.populated_address1_pcnt,le.populated_city_pcnt,le.populated_employerstate_pcnt,le.populated_zipcode_pcnt,le.populated_naicscode_pcnt,le.populated_totalviolations_pcnt,le.populated_bw_totalagreedamount_pcnt,le.populated_cmp_totalassessments_pcnt,le.populated_ee_totalviolations_pcnt,le.populated_ee_totalagreedcount_pcnt,le.populated_ca_countviolations_pcnt,le.populated_ca_bw_agreedamount_pcnt,le.populated_ca_ee_agreedcount_pcnt,le.populated_ccpa_countviolations_pcnt,le.populated_ccpa_bw_agreedamount_pcnt,le.populated_ccpa_ee_agreedcount_pcnt,le.populated_crew_countviolations_pcnt,le.populated_crew_bw_agreedamount_pcnt,le.populated_crew_cmp_assessedamount_pcnt,le.populated_crew_ee_agreedcount_pcnt,le.populated_cwhssa_countviolations_pcnt,le.populated_cwhssa_bw_agreedamount_pcnt,le.populated_cwhssa_ee_agreedcount_pcnt,le.populated_dbra_cl_countviolations_pcnt,le.populated_dbra_bw_agreedamount_pcnt,le.populated_dbra_ee_agreedcount_pcnt,le.populated_eev_countviolations_pcnt,le.populated_eppa_countviolations_pcnt,le.populated_eppa_bw_agreedamount_pcnt,le.populated_eppa_cmp_assessedamount_pcnt,le.populated_eppa_ee_agreedcount_pcnt,le.populated_flsa_countviolations_pcnt,le.populated_flsa_bw_15a3_agreedamount_pcnt,le.populated_flsa_bw_agreedamount_pcnt,le.populated_flsa_bw_minwage_agreedamount_pcnt,le.populated_flsa_bw_overtime_agreedamount_pcnt,le.populated_flsa_cmp_assessedamount_pcnt,le.populated_flsa_ee_agreedcount_pcnt,le.populated_flsa_cl_countviolations_pcnt,le.populated_flsa_cl_countminorsemployed_pcnt,le.populated_flsa_cl_cmp_assessedamount_pcnt,le.populated_flsa_hmwkr_countviolations_pcnt,le.populated_flsa_hmwkr_bw_agreedamount_pcnt,le.populated_flsa_hmwkr_cmp_assessedamount_pcnt,le.populated_flsa_hmwkr_ee_agreedcount_pcnt,le.populated_flsa_smw14_bw_agreedamount_pcnt,le.populated_flsa_smw14_countviolations_pcnt,le.populated_flsa_smw14_ee_agreedcount_pcnt,le.populated_flsa_smwap_countviolations_pcnt,le.populated_flsa_smwap_bw_agreedamount_pcnt,le.populated_flsa_smwap_ee_agreedcount_pcnt,le.populated_flsa_smwft_countviolations_pcnt,le.populated_flsa_smwft_bw_agreedamount_pcnt,le.populated_flsa_smwft_ee_agreedcount_pcnt,le.populated_flsa_smwl_countviolations_pcnt,le.populated_flsa_smwl_bw_agreedamount_pcnt,le.populated_flsa_smwl_ee_agreedcount_pcnt,le.populated_flsa_smwmg_countviolations_pcnt,le.populated_flsa_smwmg_bw_agreedamount_pcnt,le.populated_flsa_smwmg_ee_agreedcount_pcnt,le.populated_flsa_smwpw_countviolations_pcnt,le.populated_flsa_smwpw_bw_agreedamount_pcnt,le.populated_flsa_smwpw_ee_agreedcount_pcnt,le.populated_flsa_smwsl_countviolations_pcnt,le.populated_flsa_smwsl_bw_agreedamount_pcnt,le.populated_flsa_smwsl_ee_agreedcount_pcnt,le.populated_fmla_countviolations_pcnt,le.populated_fmla_bw_agreedamount_pcnt,le.populated_fmla_cmp_assessedamount_pcnt,le.populated_fmla_ee_agreedcount_pcnt,le.populated_h1a_countviolations_pcnt,le.populated_h1a_bw_agreedamount_pcnt,le.populated_h1a_cmp_assessedamount_pcnt,le.populated_h1a_ee_agreedcount_pcnt,le.populated_h1b_countviolations_pcnt,le.populated_h1b_bw_agreedamount_pcnt,le.populated_h1b_cmp_assessedamount_pcnt,le.populated_h1b_ee_agreedcount_pcnt,le.populated_h2a_countviolations_pcnt,le.populated_h2a_bw_agreedamount_pcnt,le.populated_h2a_cmp_assessedamount_pcnt,le.populated_h2a_ee_agreedcount_pcnt,le.populated_h2b_countviolations_pcnt,le.populated_h2b_bw_agreedamount_pcnt,le.populated_h2b_ee_agreedcount_pcnt,le.populated_mpsa_countviolations_pcnt,le.populated_mpsa_bw_agreedamount_pcnt,le.populated_mpsa_cmp_assessedamount_pcnt,le.populated_mpsa_ee_agreedcount_pcnt,le.populated_osha_countviolations_pcnt,le.populated_osha_bw_agreedamount_pcnt,le.populated_osha_cmp_assessedamount_pcnt,le.populated_osha_ee_agreedcount_pcnt,le.populated_pca_countviolations_pcnt,le.populated_pca_bw_agreedamount_pcnt,le.populated_pca_ee_agreedcount_pcnt,le.populated_sca_countviolations_pcnt,le.populated_sca_bw_agreedamount_pcnt,le.populated_sca_ee_agreedcount_pcnt,le.populated_sraw_countviolations_pcnt,le.populated_sraw_bw_agreedamount_pcnt,le.populated_sraw_ee_agreedcount_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dartid,le.maxlength_dateadded,le.maxlength_dateupdated,le.maxlength_website,le.maxlength_state,le.maxlength_caseid,le.maxlength_employername,le.maxlength_address1,le.maxlength_city,le.maxlength_employerstate,le.maxlength_zipcode,le.maxlength_naicscode,le.maxlength_totalviolations,le.maxlength_bw_totalagreedamount,le.maxlength_cmp_totalassessments,le.maxlength_ee_totalviolations,le.maxlength_ee_totalagreedcount,le.maxlength_ca_countviolations,le.maxlength_ca_bw_agreedamount,le.maxlength_ca_ee_agreedcount,le.maxlength_ccpa_countviolations,le.maxlength_ccpa_bw_agreedamount,le.maxlength_ccpa_ee_agreedcount,le.maxlength_crew_countviolations,le.maxlength_crew_bw_agreedamount,le.maxlength_crew_cmp_assessedamount,le.maxlength_crew_ee_agreedcount,le.maxlength_cwhssa_countviolations,le.maxlength_cwhssa_bw_agreedamount,le.maxlength_cwhssa_ee_agreedcount,le.maxlength_dbra_cl_countviolations,le.maxlength_dbra_bw_agreedamount,le.maxlength_dbra_ee_agreedcount,le.maxlength_eev_countviolations,le.maxlength_eppa_countviolations,le.maxlength_eppa_bw_agreedamount,le.maxlength_eppa_cmp_assessedamount,le.maxlength_eppa_ee_agreedcount,le.maxlength_flsa_countviolations,le.maxlength_flsa_bw_15a3_agreedamount,le.maxlength_flsa_bw_agreedamount,le.maxlength_flsa_bw_minwage_agreedamount,le.maxlength_flsa_bw_overtime_agreedamount,le.maxlength_flsa_cmp_assessedamount,le.maxlength_flsa_ee_agreedcount,le.maxlength_flsa_cl_countviolations,le.maxlength_flsa_cl_countminorsemployed,le.maxlength_flsa_cl_cmp_assessedamount,le.maxlength_flsa_hmwkr_countviolations,le.maxlength_flsa_hmwkr_bw_agreedamount,le.maxlength_flsa_hmwkr_cmp_assessedamount,le.maxlength_flsa_hmwkr_ee_agreedcount,le.maxlength_flsa_smw14_bw_agreedamount,le.maxlength_flsa_smw14_countviolations,le.maxlength_flsa_smw14_ee_agreedcount,le.maxlength_flsa_smwap_countviolations,le.maxlength_flsa_smwap_bw_agreedamount,le.maxlength_flsa_smwap_ee_agreedcount,le.maxlength_flsa_smwft_countviolations,le.maxlength_flsa_smwft_bw_agreedamount,le.maxlength_flsa_smwft_ee_agreedcount,le.maxlength_flsa_smwl_countviolations,le.maxlength_flsa_smwl_bw_agreedamount,le.maxlength_flsa_smwl_ee_agreedcount,le.maxlength_flsa_smwmg_countviolations,le.maxlength_flsa_smwmg_bw_agreedamount,le.maxlength_flsa_smwmg_ee_agreedcount,le.maxlength_flsa_smwpw_countviolations,le.maxlength_flsa_smwpw_bw_agreedamount,le.maxlength_flsa_smwpw_ee_agreedcount,le.maxlength_flsa_smwsl_countviolations,le.maxlength_flsa_smwsl_bw_agreedamount,le.maxlength_flsa_smwsl_ee_agreedcount,le.maxlength_fmla_countviolations,le.maxlength_fmla_bw_agreedamount,le.maxlength_fmla_cmp_assessedamount,le.maxlength_fmla_ee_agreedcount,le.maxlength_h1a_countviolations,le.maxlength_h1a_bw_agreedamount,le.maxlength_h1a_cmp_assessedamount,le.maxlength_h1a_ee_agreedcount,le.maxlength_h1b_countviolations,le.maxlength_h1b_bw_agreedamount,le.maxlength_h1b_cmp_assessedamount,le.maxlength_h1b_ee_agreedcount,le.maxlength_h2a_countviolations,le.maxlength_h2a_bw_agreedamount,le.maxlength_h2a_cmp_assessedamount,le.maxlength_h2a_ee_agreedcount,le.maxlength_h2b_countviolations,le.maxlength_h2b_bw_agreedamount,le.maxlength_h2b_ee_agreedcount,le.maxlength_mpsa_countviolations,le.maxlength_mpsa_bw_agreedamount,le.maxlength_mpsa_cmp_assessedamount,le.maxlength_mpsa_ee_agreedcount,le.maxlength_osha_countviolations,le.maxlength_osha_bw_agreedamount,le.maxlength_osha_cmp_assessedamount,le.maxlength_osha_ee_agreedcount,le.maxlength_pca_countviolations,le.maxlength_pca_bw_agreedamount,le.maxlength_pca_ee_agreedcount,le.maxlength_sca_countviolations,le.maxlength_sca_bw_agreedamount,le.maxlength_sca_ee_agreedcount,le.maxlength_sraw_countviolations,le.maxlength_sraw_bw_agreedamount,le.maxlength_sraw_ee_agreedcount);
  SELF.avelength := CHOOSE(C,le.avelength_dartid,le.avelength_dateadded,le.avelength_dateupdated,le.avelength_website,le.avelength_state,le.avelength_caseid,le.avelength_employername,le.avelength_address1,le.avelength_city,le.avelength_employerstate,le.avelength_zipcode,le.avelength_naicscode,le.avelength_totalviolations,le.avelength_bw_totalagreedamount,le.avelength_cmp_totalassessments,le.avelength_ee_totalviolations,le.avelength_ee_totalagreedcount,le.avelength_ca_countviolations,le.avelength_ca_bw_agreedamount,le.avelength_ca_ee_agreedcount,le.avelength_ccpa_countviolations,le.avelength_ccpa_bw_agreedamount,le.avelength_ccpa_ee_agreedcount,le.avelength_crew_countviolations,le.avelength_crew_bw_agreedamount,le.avelength_crew_cmp_assessedamount,le.avelength_crew_ee_agreedcount,le.avelength_cwhssa_countviolations,le.avelength_cwhssa_bw_agreedamount,le.avelength_cwhssa_ee_agreedcount,le.avelength_dbra_cl_countviolations,le.avelength_dbra_bw_agreedamount,le.avelength_dbra_ee_agreedcount,le.avelength_eev_countviolations,le.avelength_eppa_countviolations,le.avelength_eppa_bw_agreedamount,le.avelength_eppa_cmp_assessedamount,le.avelength_eppa_ee_agreedcount,le.avelength_flsa_countviolations,le.avelength_flsa_bw_15a3_agreedamount,le.avelength_flsa_bw_agreedamount,le.avelength_flsa_bw_minwage_agreedamount,le.avelength_flsa_bw_overtime_agreedamount,le.avelength_flsa_cmp_assessedamount,le.avelength_flsa_ee_agreedcount,le.avelength_flsa_cl_countviolations,le.avelength_flsa_cl_countminorsemployed,le.avelength_flsa_cl_cmp_assessedamount,le.avelength_flsa_hmwkr_countviolations,le.avelength_flsa_hmwkr_bw_agreedamount,le.avelength_flsa_hmwkr_cmp_assessedamount,le.avelength_flsa_hmwkr_ee_agreedcount,le.avelength_flsa_smw14_bw_agreedamount,le.avelength_flsa_smw14_countviolations,le.avelength_flsa_smw14_ee_agreedcount,le.avelength_flsa_smwap_countviolations,le.avelength_flsa_smwap_bw_agreedamount,le.avelength_flsa_smwap_ee_agreedcount,le.avelength_flsa_smwft_countviolations,le.avelength_flsa_smwft_bw_agreedamount,le.avelength_flsa_smwft_ee_agreedcount,le.avelength_flsa_smwl_countviolations,le.avelength_flsa_smwl_bw_agreedamount,le.avelength_flsa_smwl_ee_agreedcount,le.avelength_flsa_smwmg_countviolations,le.avelength_flsa_smwmg_bw_agreedamount,le.avelength_flsa_smwmg_ee_agreedcount,le.avelength_flsa_smwpw_countviolations,le.avelength_flsa_smwpw_bw_agreedamount,le.avelength_flsa_smwpw_ee_agreedcount,le.avelength_flsa_smwsl_countviolations,le.avelength_flsa_smwsl_bw_agreedamount,le.avelength_flsa_smwsl_ee_agreedcount,le.avelength_fmla_countviolations,le.avelength_fmla_bw_agreedamount,le.avelength_fmla_cmp_assessedamount,le.avelength_fmla_ee_agreedcount,le.avelength_h1a_countviolations,le.avelength_h1a_bw_agreedamount,le.avelength_h1a_cmp_assessedamount,le.avelength_h1a_ee_agreedcount,le.avelength_h1b_countviolations,le.avelength_h1b_bw_agreedamount,le.avelength_h1b_cmp_assessedamount,le.avelength_h1b_ee_agreedcount,le.avelength_h2a_countviolations,le.avelength_h2a_bw_agreedamount,le.avelength_h2a_cmp_assessedamount,le.avelength_h2a_ee_agreedcount,le.avelength_h2b_countviolations,le.avelength_h2b_bw_agreedamount,le.avelength_h2b_ee_agreedcount,le.avelength_mpsa_countviolations,le.avelength_mpsa_bw_agreedamount,le.avelength_mpsa_cmp_assessedamount,le.avelength_mpsa_ee_agreedcount,le.avelength_osha_countviolations,le.avelength_osha_bw_agreedamount,le.avelength_osha_cmp_assessedamount,le.avelength_osha_ee_agreedcount,le.avelength_pca_countviolations,le.avelength_pca_bw_agreedamount,le.avelength_pca_ee_agreedcount,le.avelength_sca_countviolations,le.avelength_sca_bw_agreedamount,le.avelength_sca_ee_agreedcount,le.avelength_sraw_countviolations,le.avelength_sraw_bw_agreedamount,le.avelength_sraw_ee_agreedcount);
END;
EXPORT invSummary := NORMALIZE(summary0, 109, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dartid),IF (le.dateadded <> 0,TRIM((SALT311.StrType)le.dateadded), ''),IF (le.dateupdated <> 0,TRIM((SALT311.StrType)le.dateupdated), ''),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.employername),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.employerstate),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.naicscode),TRIM((SALT311.StrType)le.totalviolations),TRIM((SALT311.StrType)le.bw_totalagreedamount),TRIM((SALT311.StrType)le.cmp_totalassessments),TRIM((SALT311.StrType)le.ee_totalviolations),TRIM((SALT311.StrType)le.ee_totalagreedcount),TRIM((SALT311.StrType)le.ca_countviolations),TRIM((SALT311.StrType)le.ca_bw_agreedamount),TRIM((SALT311.StrType)le.ca_ee_agreedcount),TRIM((SALT311.StrType)le.ccpa_countviolations),TRIM((SALT311.StrType)le.ccpa_bw_agreedamount),TRIM((SALT311.StrType)le.ccpa_ee_agreedcount),TRIM((SALT311.StrType)le.crew_countviolations),TRIM((SALT311.StrType)le.crew_bw_agreedamount),TRIM((SALT311.StrType)le.crew_cmp_assessedamount),TRIM((SALT311.StrType)le.crew_ee_agreedcount),TRIM((SALT311.StrType)le.cwhssa_countviolations),TRIM((SALT311.StrType)le.cwhssa_bw_agreedamount),TRIM((SALT311.StrType)le.cwhssa_ee_agreedcount),TRIM((SALT311.StrType)le.dbra_cl_countviolations),TRIM((SALT311.StrType)le.dbra_bw_agreedamount),TRIM((SALT311.StrType)le.dbra_ee_agreedcount),TRIM((SALT311.StrType)le.eev_countviolations),TRIM((SALT311.StrType)le.eppa_countviolations),TRIM((SALT311.StrType)le.eppa_bw_agreedamount),TRIM((SALT311.StrType)le.eppa_cmp_assessedamount),TRIM((SALT311.StrType)le.eppa_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_countviolations),TRIM((SALT311.StrType)le.flsa_bw_15a3_agreedamount),TRIM((SALT311.StrType)le.flsa_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_bw_minwage_agreedamount),TRIM((SALT311.StrType)le.flsa_bw_overtime_agreedamount),TRIM((SALT311.StrType)le.flsa_cmp_assessedamount),TRIM((SALT311.StrType)le.flsa_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_cl_countviolations),TRIM((SALT311.StrType)le.flsa_cl_countminorsemployed),TRIM((SALT311.StrType)le.flsa_cl_cmp_assessedamount),TRIM((SALT311.StrType)le.flsa_hmwkr_countviolations),TRIM((SALT311.StrType)le.flsa_hmwkr_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_hmwkr_cmp_assessedamount),TRIM((SALT311.StrType)le.flsa_hmwkr_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smw14_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smw14_countviolations),TRIM((SALT311.StrType)le.flsa_smw14_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwap_countviolations),TRIM((SALT311.StrType)le.flsa_smwap_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwap_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwft_countviolations),TRIM((SALT311.StrType)le.flsa_smwft_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwft_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwl_countviolations),TRIM((SALT311.StrType)le.flsa_smwl_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwl_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwmg_countviolations),TRIM((SALT311.StrType)le.flsa_smwmg_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwmg_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwpw_countviolations),TRIM((SALT311.StrType)le.flsa_smwpw_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwpw_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwsl_countviolations),TRIM((SALT311.StrType)le.flsa_smwsl_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwsl_ee_agreedcount),TRIM((SALT311.StrType)le.fmla_countviolations),TRIM((SALT311.StrType)le.fmla_bw_agreedamount),TRIM((SALT311.StrType)le.fmla_cmp_assessedamount),TRIM((SALT311.StrType)le.fmla_ee_agreedcount),TRIM((SALT311.StrType)le.h1a_countviolations),TRIM((SALT311.StrType)le.h1a_bw_agreedamount),TRIM((SALT311.StrType)le.h1a_cmp_assessedamount),TRIM((SALT311.StrType)le.h1a_ee_agreedcount),TRIM((SALT311.StrType)le.h1b_countviolations),TRIM((SALT311.StrType)le.h1b_bw_agreedamount),TRIM((SALT311.StrType)le.h1b_cmp_assessedamount),TRIM((SALT311.StrType)le.h1b_ee_agreedcount),TRIM((SALT311.StrType)le.h2a_countviolations),TRIM((SALT311.StrType)le.h2a_bw_agreedamount),TRIM((SALT311.StrType)le.h2a_cmp_assessedamount),TRIM((SALT311.StrType)le.h2a_ee_agreedcount),TRIM((SALT311.StrType)le.h2b_countviolations),TRIM((SALT311.StrType)le.h2b_bw_agreedamount),TRIM((SALT311.StrType)le.h2b_ee_agreedcount),TRIM((SALT311.StrType)le.mpsa_countviolations),TRIM((SALT311.StrType)le.mpsa_bw_agreedamount),TRIM((SALT311.StrType)le.mpsa_cmp_assessedamount),TRIM((SALT311.StrType)le.mpsa_ee_agreedcount),TRIM((SALT311.StrType)le.osha_countviolations),TRIM((SALT311.StrType)le.osha_bw_agreedamount),TRIM((SALT311.StrType)le.osha_cmp_assessedamount),TRIM((SALT311.StrType)le.osha_ee_agreedcount),TRIM((SALT311.StrType)le.pca_countviolations),TRIM((SALT311.StrType)le.pca_bw_agreedamount),TRIM((SALT311.StrType)le.pca_ee_agreedcount),TRIM((SALT311.StrType)le.sca_countviolations),TRIM((SALT311.StrType)le.sca_bw_agreedamount),TRIM((SALT311.StrType)le.sca_ee_agreedcount),TRIM((SALT311.StrType)le.sraw_countviolations),TRIM((SALT311.StrType)le.sraw_bw_agreedamount),TRIM((SALT311.StrType)le.sraw_ee_agreedcount)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,109,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 109);
  SELF.FldNo2 := 1 + (C % 109);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dartid),IF (le.dateadded <> 0,TRIM((SALT311.StrType)le.dateadded), ''),IF (le.dateupdated <> 0,TRIM((SALT311.StrType)le.dateupdated), ''),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.employername),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.employerstate),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.naicscode),TRIM((SALT311.StrType)le.totalviolations),TRIM((SALT311.StrType)le.bw_totalagreedamount),TRIM((SALT311.StrType)le.cmp_totalassessments),TRIM((SALT311.StrType)le.ee_totalviolations),TRIM((SALT311.StrType)le.ee_totalagreedcount),TRIM((SALT311.StrType)le.ca_countviolations),TRIM((SALT311.StrType)le.ca_bw_agreedamount),TRIM((SALT311.StrType)le.ca_ee_agreedcount),TRIM((SALT311.StrType)le.ccpa_countviolations),TRIM((SALT311.StrType)le.ccpa_bw_agreedamount),TRIM((SALT311.StrType)le.ccpa_ee_agreedcount),TRIM((SALT311.StrType)le.crew_countviolations),TRIM((SALT311.StrType)le.crew_bw_agreedamount),TRIM((SALT311.StrType)le.crew_cmp_assessedamount),TRIM((SALT311.StrType)le.crew_ee_agreedcount),TRIM((SALT311.StrType)le.cwhssa_countviolations),TRIM((SALT311.StrType)le.cwhssa_bw_agreedamount),TRIM((SALT311.StrType)le.cwhssa_ee_agreedcount),TRIM((SALT311.StrType)le.dbra_cl_countviolations),TRIM((SALT311.StrType)le.dbra_bw_agreedamount),TRIM((SALT311.StrType)le.dbra_ee_agreedcount),TRIM((SALT311.StrType)le.eev_countviolations),TRIM((SALT311.StrType)le.eppa_countviolations),TRIM((SALT311.StrType)le.eppa_bw_agreedamount),TRIM((SALT311.StrType)le.eppa_cmp_assessedamount),TRIM((SALT311.StrType)le.eppa_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_countviolations),TRIM((SALT311.StrType)le.flsa_bw_15a3_agreedamount),TRIM((SALT311.StrType)le.flsa_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_bw_minwage_agreedamount),TRIM((SALT311.StrType)le.flsa_bw_overtime_agreedamount),TRIM((SALT311.StrType)le.flsa_cmp_assessedamount),TRIM((SALT311.StrType)le.flsa_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_cl_countviolations),TRIM((SALT311.StrType)le.flsa_cl_countminorsemployed),TRIM((SALT311.StrType)le.flsa_cl_cmp_assessedamount),TRIM((SALT311.StrType)le.flsa_hmwkr_countviolations),TRIM((SALT311.StrType)le.flsa_hmwkr_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_hmwkr_cmp_assessedamount),TRIM((SALT311.StrType)le.flsa_hmwkr_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smw14_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smw14_countviolations),TRIM((SALT311.StrType)le.flsa_smw14_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwap_countviolations),TRIM((SALT311.StrType)le.flsa_smwap_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwap_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwft_countviolations),TRIM((SALT311.StrType)le.flsa_smwft_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwft_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwl_countviolations),TRIM((SALT311.StrType)le.flsa_smwl_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwl_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwmg_countviolations),TRIM((SALT311.StrType)le.flsa_smwmg_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwmg_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwpw_countviolations),TRIM((SALT311.StrType)le.flsa_smwpw_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwpw_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwsl_countviolations),TRIM((SALT311.StrType)le.flsa_smwsl_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwsl_ee_agreedcount),TRIM((SALT311.StrType)le.fmla_countviolations),TRIM((SALT311.StrType)le.fmla_bw_agreedamount),TRIM((SALT311.StrType)le.fmla_cmp_assessedamount),TRIM((SALT311.StrType)le.fmla_ee_agreedcount),TRIM((SALT311.StrType)le.h1a_countviolations),TRIM((SALT311.StrType)le.h1a_bw_agreedamount),TRIM((SALT311.StrType)le.h1a_cmp_assessedamount),TRIM((SALT311.StrType)le.h1a_ee_agreedcount),TRIM((SALT311.StrType)le.h1b_countviolations),TRIM((SALT311.StrType)le.h1b_bw_agreedamount),TRIM((SALT311.StrType)le.h1b_cmp_assessedamount),TRIM((SALT311.StrType)le.h1b_ee_agreedcount),TRIM((SALT311.StrType)le.h2a_countviolations),TRIM((SALT311.StrType)le.h2a_bw_agreedamount),TRIM((SALT311.StrType)le.h2a_cmp_assessedamount),TRIM((SALT311.StrType)le.h2a_ee_agreedcount),TRIM((SALT311.StrType)le.h2b_countviolations),TRIM((SALT311.StrType)le.h2b_bw_agreedamount),TRIM((SALT311.StrType)le.h2b_ee_agreedcount),TRIM((SALT311.StrType)le.mpsa_countviolations),TRIM((SALT311.StrType)le.mpsa_bw_agreedamount),TRIM((SALT311.StrType)le.mpsa_cmp_assessedamount),TRIM((SALT311.StrType)le.mpsa_ee_agreedcount),TRIM((SALT311.StrType)le.osha_countviolations),TRIM((SALT311.StrType)le.osha_bw_agreedamount),TRIM((SALT311.StrType)le.osha_cmp_assessedamount),TRIM((SALT311.StrType)le.osha_ee_agreedcount),TRIM((SALT311.StrType)le.pca_countviolations),TRIM((SALT311.StrType)le.pca_bw_agreedamount),TRIM((SALT311.StrType)le.pca_ee_agreedcount),TRIM((SALT311.StrType)le.sca_countviolations),TRIM((SALT311.StrType)le.sca_bw_agreedamount),TRIM((SALT311.StrType)le.sca_ee_agreedcount),TRIM((SALT311.StrType)le.sraw_countviolations),TRIM((SALT311.StrType)le.sraw_bw_agreedamount),TRIM((SALT311.StrType)le.sraw_ee_agreedcount)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dartid),IF (le.dateadded <> 0,TRIM((SALT311.StrType)le.dateadded), ''),IF (le.dateupdated <> 0,TRIM((SALT311.StrType)le.dateupdated), ''),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.employername),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.employerstate),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.naicscode),TRIM((SALT311.StrType)le.totalviolations),TRIM((SALT311.StrType)le.bw_totalagreedamount),TRIM((SALT311.StrType)le.cmp_totalassessments),TRIM((SALT311.StrType)le.ee_totalviolations),TRIM((SALT311.StrType)le.ee_totalagreedcount),TRIM((SALT311.StrType)le.ca_countviolations),TRIM((SALT311.StrType)le.ca_bw_agreedamount),TRIM((SALT311.StrType)le.ca_ee_agreedcount),TRIM((SALT311.StrType)le.ccpa_countviolations),TRIM((SALT311.StrType)le.ccpa_bw_agreedamount),TRIM((SALT311.StrType)le.ccpa_ee_agreedcount),TRIM((SALT311.StrType)le.crew_countviolations),TRIM((SALT311.StrType)le.crew_bw_agreedamount),TRIM((SALT311.StrType)le.crew_cmp_assessedamount),TRIM((SALT311.StrType)le.crew_ee_agreedcount),TRIM((SALT311.StrType)le.cwhssa_countviolations),TRIM((SALT311.StrType)le.cwhssa_bw_agreedamount),TRIM((SALT311.StrType)le.cwhssa_ee_agreedcount),TRIM((SALT311.StrType)le.dbra_cl_countviolations),TRIM((SALT311.StrType)le.dbra_bw_agreedamount),TRIM((SALT311.StrType)le.dbra_ee_agreedcount),TRIM((SALT311.StrType)le.eev_countviolations),TRIM((SALT311.StrType)le.eppa_countviolations),TRIM((SALT311.StrType)le.eppa_bw_agreedamount),TRIM((SALT311.StrType)le.eppa_cmp_assessedamount),TRIM((SALT311.StrType)le.eppa_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_countviolations),TRIM((SALT311.StrType)le.flsa_bw_15a3_agreedamount),TRIM((SALT311.StrType)le.flsa_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_bw_minwage_agreedamount),TRIM((SALT311.StrType)le.flsa_bw_overtime_agreedamount),TRIM((SALT311.StrType)le.flsa_cmp_assessedamount),TRIM((SALT311.StrType)le.flsa_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_cl_countviolations),TRIM((SALT311.StrType)le.flsa_cl_countminorsemployed),TRIM((SALT311.StrType)le.flsa_cl_cmp_assessedamount),TRIM((SALT311.StrType)le.flsa_hmwkr_countviolations),TRIM((SALT311.StrType)le.flsa_hmwkr_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_hmwkr_cmp_assessedamount),TRIM((SALT311.StrType)le.flsa_hmwkr_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smw14_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smw14_countviolations),TRIM((SALT311.StrType)le.flsa_smw14_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwap_countviolations),TRIM((SALT311.StrType)le.flsa_smwap_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwap_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwft_countviolations),TRIM((SALT311.StrType)le.flsa_smwft_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwft_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwl_countviolations),TRIM((SALT311.StrType)le.flsa_smwl_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwl_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwmg_countviolations),TRIM((SALT311.StrType)le.flsa_smwmg_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwmg_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwpw_countviolations),TRIM((SALT311.StrType)le.flsa_smwpw_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwpw_ee_agreedcount),TRIM((SALT311.StrType)le.flsa_smwsl_countviolations),TRIM((SALT311.StrType)le.flsa_smwsl_bw_agreedamount),TRIM((SALT311.StrType)le.flsa_smwsl_ee_agreedcount),TRIM((SALT311.StrType)le.fmla_countviolations),TRIM((SALT311.StrType)le.fmla_bw_agreedamount),TRIM((SALT311.StrType)le.fmla_cmp_assessedamount),TRIM((SALT311.StrType)le.fmla_ee_agreedcount),TRIM((SALT311.StrType)le.h1a_countviolations),TRIM((SALT311.StrType)le.h1a_bw_agreedamount),TRIM((SALT311.StrType)le.h1a_cmp_assessedamount),TRIM((SALT311.StrType)le.h1a_ee_agreedcount),TRIM((SALT311.StrType)le.h1b_countviolations),TRIM((SALT311.StrType)le.h1b_bw_agreedamount),TRIM((SALT311.StrType)le.h1b_cmp_assessedamount),TRIM((SALT311.StrType)le.h1b_ee_agreedcount),TRIM((SALT311.StrType)le.h2a_countviolations),TRIM((SALT311.StrType)le.h2a_bw_agreedamount),TRIM((SALT311.StrType)le.h2a_cmp_assessedamount),TRIM((SALT311.StrType)le.h2a_ee_agreedcount),TRIM((SALT311.StrType)le.h2b_countviolations),TRIM((SALT311.StrType)le.h2b_bw_agreedamount),TRIM((SALT311.StrType)le.h2b_ee_agreedcount),TRIM((SALT311.StrType)le.mpsa_countviolations),TRIM((SALT311.StrType)le.mpsa_bw_agreedamount),TRIM((SALT311.StrType)le.mpsa_cmp_assessedamount),TRIM((SALT311.StrType)le.mpsa_ee_agreedcount),TRIM((SALT311.StrType)le.osha_countviolations),TRIM((SALT311.StrType)le.osha_bw_agreedamount),TRIM((SALT311.StrType)le.osha_cmp_assessedamount),TRIM((SALT311.StrType)le.osha_ee_agreedcount),TRIM((SALT311.StrType)le.pca_countviolations),TRIM((SALT311.StrType)le.pca_bw_agreedamount),TRIM((SALT311.StrType)le.pca_ee_agreedcount),TRIM((SALT311.StrType)le.sca_countviolations),TRIM((SALT311.StrType)le.sca_bw_agreedamount),TRIM((SALT311.StrType)le.sca_ee_agreedcount),TRIM((SALT311.StrType)le.sraw_countviolations),TRIM((SALT311.StrType)le.sraw_bw_agreedamount),TRIM((SALT311.StrType)le.sraw_ee_agreedcount)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),109*109,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dartid'}
      ,{2,'dateadded'}
      ,{3,'dateupdated'}
      ,{4,'website'}
      ,{5,'state'}
      ,{6,'caseid'}
      ,{7,'employername'}
      ,{8,'address1'}
      ,{9,'city'}
      ,{10,'employerstate'}
      ,{11,'zipcode'}
      ,{12,'naicscode'}
      ,{13,'totalviolations'}
      ,{14,'bw_totalagreedamount'}
      ,{15,'cmp_totalassessments'}
      ,{16,'ee_totalviolations'}
      ,{17,'ee_totalagreedcount'}
      ,{18,'ca_countviolations'}
      ,{19,'ca_bw_agreedamount'}
      ,{20,'ca_ee_agreedcount'}
      ,{21,'ccpa_countviolations'}
      ,{22,'ccpa_bw_agreedamount'}
      ,{23,'ccpa_ee_agreedcount'}
      ,{24,'crew_countviolations'}
      ,{25,'crew_bw_agreedamount'}
      ,{26,'crew_cmp_assessedamount'}
      ,{27,'crew_ee_agreedcount'}
      ,{28,'cwhssa_countviolations'}
      ,{29,'cwhssa_bw_agreedamount'}
      ,{30,'cwhssa_ee_agreedcount'}
      ,{31,'dbra_cl_countviolations'}
      ,{32,'dbra_bw_agreedamount'}
      ,{33,'dbra_ee_agreedcount'}
      ,{34,'eev_countviolations'}
      ,{35,'eppa_countviolations'}
      ,{36,'eppa_bw_agreedamount'}
      ,{37,'eppa_cmp_assessedamount'}
      ,{38,'eppa_ee_agreedcount'}
      ,{39,'flsa_countviolations'}
      ,{40,'flsa_bw_15a3_agreedamount'}
      ,{41,'flsa_bw_agreedamount'}
      ,{42,'flsa_bw_minwage_agreedamount'}
      ,{43,'flsa_bw_overtime_agreedamount'}
      ,{44,'flsa_cmp_assessedamount'}
      ,{45,'flsa_ee_agreedcount'}
      ,{46,'flsa_cl_countviolations'}
      ,{47,'flsa_cl_countminorsemployed'}
      ,{48,'flsa_cl_cmp_assessedamount'}
      ,{49,'flsa_hmwkr_countviolations'}
      ,{50,'flsa_hmwkr_bw_agreedamount'}
      ,{51,'flsa_hmwkr_cmp_assessedamount'}
      ,{52,'flsa_hmwkr_ee_agreedcount'}
      ,{53,'flsa_smw14_bw_agreedamount'}
      ,{54,'flsa_smw14_countviolations'}
      ,{55,'flsa_smw14_ee_agreedcount'}
      ,{56,'flsa_smwap_countviolations'}
      ,{57,'flsa_smwap_bw_agreedamount'}
      ,{58,'flsa_smwap_ee_agreedcount'}
      ,{59,'flsa_smwft_countviolations'}
      ,{60,'flsa_smwft_bw_agreedamount'}
      ,{61,'flsa_smwft_ee_agreedcount'}
      ,{62,'flsa_smwl_countviolations'}
      ,{63,'flsa_smwl_bw_agreedamount'}
      ,{64,'flsa_smwl_ee_agreedcount'}
      ,{65,'flsa_smwmg_countviolations'}
      ,{66,'flsa_smwmg_bw_agreedamount'}
      ,{67,'flsa_smwmg_ee_agreedcount'}
      ,{68,'flsa_smwpw_countviolations'}
      ,{69,'flsa_smwpw_bw_agreedamount'}
      ,{70,'flsa_smwpw_ee_agreedcount'}
      ,{71,'flsa_smwsl_countviolations'}
      ,{72,'flsa_smwsl_bw_agreedamount'}
      ,{73,'flsa_smwsl_ee_agreedcount'}
      ,{74,'fmla_countviolations'}
      ,{75,'fmla_bw_agreedamount'}
      ,{76,'fmla_cmp_assessedamount'}
      ,{77,'fmla_ee_agreedcount'}
      ,{78,'h1a_countviolations'}
      ,{79,'h1a_bw_agreedamount'}
      ,{80,'h1a_cmp_assessedamount'}
      ,{81,'h1a_ee_agreedcount'}
      ,{82,'h1b_countviolations'}
      ,{83,'h1b_bw_agreedamount'}
      ,{84,'h1b_cmp_assessedamount'}
      ,{85,'h1b_ee_agreedcount'}
      ,{86,'h2a_countviolations'}
      ,{87,'h2a_bw_agreedamount'}
      ,{88,'h2a_cmp_assessedamount'}
      ,{89,'h2a_ee_agreedcount'}
      ,{90,'h2b_countviolations'}
      ,{91,'h2b_bw_agreedamount'}
      ,{92,'h2b_ee_agreedcount'}
      ,{93,'mpsa_countviolations'}
      ,{94,'mpsa_bw_agreedamount'}
      ,{95,'mpsa_cmp_assessedamount'}
      ,{96,'mpsa_ee_agreedcount'}
      ,{97,'osha_countviolations'}
      ,{98,'osha_bw_agreedamount'}
      ,{99,'osha_cmp_assessedamount'}
      ,{100,'osha_ee_agreedcount'}
      ,{101,'pca_countviolations'}
      ,{102,'pca_bw_agreedamount'}
      ,{103,'pca_ee_agreedcount'}
      ,{104,'sca_countviolations'}
      ,{105,'sca_bw_agreedamount'}
      ,{106,'sca_ee_agreedcount'}
      ,{107,'sraw_countviolations'}
      ,{108,'sraw_bw_agreedamount'}
      ,{109,'sraw_ee_agreedcount'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dartid((SALT311.StrType)le.dartid),
    Fields.InValid_dateadded((SALT311.StrType)le.dateadded),
    Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated),
    Fields.InValid_website((SALT311.StrType)le.website),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_caseid((SALT311.StrType)le.caseid),
    Fields.InValid_employername((SALT311.StrType)le.employername),
    Fields.InValid_address1((SALT311.StrType)le.address1),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_employerstate((SALT311.StrType)le.employerstate),
    Fields.InValid_zipcode((SALT311.StrType)le.zipcode),
    Fields.InValid_naicscode((SALT311.StrType)le.naicscode),
    Fields.InValid_totalviolations((SALT311.StrType)le.totalviolations),
    Fields.InValid_bw_totalagreedamount((SALT311.StrType)le.bw_totalagreedamount),
    Fields.InValid_cmp_totalassessments((SALT311.StrType)le.cmp_totalassessments),
    Fields.InValid_ee_totalviolations((SALT311.StrType)le.ee_totalviolations),
    Fields.InValid_ee_totalagreedcount((SALT311.StrType)le.ee_totalagreedcount),
    Fields.InValid_ca_countviolations((SALT311.StrType)le.ca_countviolations),
    Fields.InValid_ca_bw_agreedamount((SALT311.StrType)le.ca_bw_agreedamount),
    Fields.InValid_ca_ee_agreedcount((SALT311.StrType)le.ca_ee_agreedcount),
    Fields.InValid_ccpa_countviolations((SALT311.StrType)le.ccpa_countviolations),
    Fields.InValid_ccpa_bw_agreedamount((SALT311.StrType)le.ccpa_bw_agreedamount),
    Fields.InValid_ccpa_ee_agreedcount((SALT311.StrType)le.ccpa_ee_agreedcount),
    Fields.InValid_crew_countviolations((SALT311.StrType)le.crew_countviolations),
    Fields.InValid_crew_bw_agreedamount((SALT311.StrType)le.crew_bw_agreedamount),
    Fields.InValid_crew_cmp_assessedamount((SALT311.StrType)le.crew_cmp_assessedamount),
    Fields.InValid_crew_ee_agreedcount((SALT311.StrType)le.crew_ee_agreedcount),
    Fields.InValid_cwhssa_countviolations((SALT311.StrType)le.cwhssa_countviolations),
    Fields.InValid_cwhssa_bw_agreedamount((SALT311.StrType)le.cwhssa_bw_agreedamount),
    Fields.InValid_cwhssa_ee_agreedcount((SALT311.StrType)le.cwhssa_ee_agreedcount),
    Fields.InValid_dbra_cl_countviolations((SALT311.StrType)le.dbra_cl_countviolations),
    Fields.InValid_dbra_bw_agreedamount((SALT311.StrType)le.dbra_bw_agreedamount),
    Fields.InValid_dbra_ee_agreedcount((SALT311.StrType)le.dbra_ee_agreedcount),
    Fields.InValid_eev_countviolations((SALT311.StrType)le.eev_countviolations),
    Fields.InValid_eppa_countviolations((SALT311.StrType)le.eppa_countviolations),
    Fields.InValid_eppa_bw_agreedamount((SALT311.StrType)le.eppa_bw_agreedamount),
    Fields.InValid_eppa_cmp_assessedamount((SALT311.StrType)le.eppa_cmp_assessedamount),
    Fields.InValid_eppa_ee_agreedcount((SALT311.StrType)le.eppa_ee_agreedcount),
    Fields.InValid_flsa_countviolations((SALT311.StrType)le.flsa_countviolations),
    Fields.InValid_flsa_bw_15a3_agreedamount((SALT311.StrType)le.flsa_bw_15a3_agreedamount),
    Fields.InValid_flsa_bw_agreedamount((SALT311.StrType)le.flsa_bw_agreedamount),
    Fields.InValid_flsa_bw_minwage_agreedamount((SALT311.StrType)le.flsa_bw_minwage_agreedamount),
    Fields.InValid_flsa_bw_overtime_agreedamount((SALT311.StrType)le.flsa_bw_overtime_agreedamount),
    Fields.InValid_flsa_cmp_assessedamount((SALT311.StrType)le.flsa_cmp_assessedamount),
    Fields.InValid_flsa_ee_agreedcount((SALT311.StrType)le.flsa_ee_agreedcount),
    Fields.InValid_flsa_cl_countviolations((SALT311.StrType)le.flsa_cl_countviolations),
    Fields.InValid_flsa_cl_countminorsemployed((SALT311.StrType)le.flsa_cl_countminorsemployed),
    Fields.InValid_flsa_cl_cmp_assessedamount((SALT311.StrType)le.flsa_cl_cmp_assessedamount),
    Fields.InValid_flsa_hmwkr_countviolations((SALT311.StrType)le.flsa_hmwkr_countviolations),
    Fields.InValid_flsa_hmwkr_bw_agreedamount((SALT311.StrType)le.flsa_hmwkr_bw_agreedamount),
    Fields.InValid_flsa_hmwkr_cmp_assessedamount((SALT311.StrType)le.flsa_hmwkr_cmp_assessedamount),
    Fields.InValid_flsa_hmwkr_ee_agreedcount((SALT311.StrType)le.flsa_hmwkr_ee_agreedcount),
    Fields.InValid_flsa_smw14_bw_agreedamount((SALT311.StrType)le.flsa_smw14_bw_agreedamount),
    Fields.InValid_flsa_smw14_countviolations((SALT311.StrType)le.flsa_smw14_countviolations),
    Fields.InValid_flsa_smw14_ee_agreedcount((SALT311.StrType)le.flsa_smw14_ee_agreedcount),
    Fields.InValid_flsa_smwap_countviolations((SALT311.StrType)le.flsa_smwap_countviolations),
    Fields.InValid_flsa_smwap_bw_agreedamount((SALT311.StrType)le.flsa_smwap_bw_agreedamount),
    Fields.InValid_flsa_smwap_ee_agreedcount((SALT311.StrType)le.flsa_smwap_ee_agreedcount),
    Fields.InValid_flsa_smwft_countviolations((SALT311.StrType)le.flsa_smwft_countviolations),
    Fields.InValid_flsa_smwft_bw_agreedamount((SALT311.StrType)le.flsa_smwft_bw_agreedamount),
    Fields.InValid_flsa_smwft_ee_agreedcount((SALT311.StrType)le.flsa_smwft_ee_agreedcount),
    Fields.InValid_flsa_smwl_countviolations((SALT311.StrType)le.flsa_smwl_countviolations),
    Fields.InValid_flsa_smwl_bw_agreedamount((SALT311.StrType)le.flsa_smwl_bw_agreedamount),
    Fields.InValid_flsa_smwl_ee_agreedcount((SALT311.StrType)le.flsa_smwl_ee_agreedcount),
    Fields.InValid_flsa_smwmg_countviolations((SALT311.StrType)le.flsa_smwmg_countviolations),
    Fields.InValid_flsa_smwmg_bw_agreedamount((SALT311.StrType)le.flsa_smwmg_bw_agreedamount),
    Fields.InValid_flsa_smwmg_ee_agreedcount((SALT311.StrType)le.flsa_smwmg_ee_agreedcount),
    Fields.InValid_flsa_smwpw_countviolations((SALT311.StrType)le.flsa_smwpw_countviolations),
    Fields.InValid_flsa_smwpw_bw_agreedamount((SALT311.StrType)le.flsa_smwpw_bw_agreedamount),
    Fields.InValid_flsa_smwpw_ee_agreedcount((SALT311.StrType)le.flsa_smwpw_ee_agreedcount),
    Fields.InValid_flsa_smwsl_countviolations((SALT311.StrType)le.flsa_smwsl_countviolations),
    Fields.InValid_flsa_smwsl_bw_agreedamount((SALT311.StrType)le.flsa_smwsl_bw_agreedamount),
    Fields.InValid_flsa_smwsl_ee_agreedcount((SALT311.StrType)le.flsa_smwsl_ee_agreedcount),
    Fields.InValid_fmla_countviolations((SALT311.StrType)le.fmla_countviolations),
    Fields.InValid_fmla_bw_agreedamount((SALT311.StrType)le.fmla_bw_agreedamount),
    Fields.InValid_fmla_cmp_assessedamount((SALT311.StrType)le.fmla_cmp_assessedamount),
    Fields.InValid_fmla_ee_agreedcount((SALT311.StrType)le.fmla_ee_agreedcount),
    Fields.InValid_h1a_countviolations((SALT311.StrType)le.h1a_countviolations),
    Fields.InValid_h1a_bw_agreedamount((SALT311.StrType)le.h1a_bw_agreedamount),
    Fields.InValid_h1a_cmp_assessedamount((SALT311.StrType)le.h1a_cmp_assessedamount),
    Fields.InValid_h1a_ee_agreedcount((SALT311.StrType)le.h1a_ee_agreedcount),
    Fields.InValid_h1b_countviolations((SALT311.StrType)le.h1b_countviolations),
    Fields.InValid_h1b_bw_agreedamount((SALT311.StrType)le.h1b_bw_agreedamount),
    Fields.InValid_h1b_cmp_assessedamount((SALT311.StrType)le.h1b_cmp_assessedamount),
    Fields.InValid_h1b_ee_agreedcount((SALT311.StrType)le.h1b_ee_agreedcount),
    Fields.InValid_h2a_countviolations((SALT311.StrType)le.h2a_countviolations),
    Fields.InValid_h2a_bw_agreedamount((SALT311.StrType)le.h2a_bw_agreedamount),
    Fields.InValid_h2a_cmp_assessedamount((SALT311.StrType)le.h2a_cmp_assessedamount),
    Fields.InValid_h2a_ee_agreedcount((SALT311.StrType)le.h2a_ee_agreedcount),
    Fields.InValid_h2b_countviolations((SALT311.StrType)le.h2b_countviolations),
    Fields.InValid_h2b_bw_agreedamount((SALT311.StrType)le.h2b_bw_agreedamount),
    Fields.InValid_h2b_ee_agreedcount((SALT311.StrType)le.h2b_ee_agreedcount),
    Fields.InValid_mpsa_countviolations((SALT311.StrType)le.mpsa_countviolations),
    Fields.InValid_mpsa_bw_agreedamount((SALT311.StrType)le.mpsa_bw_agreedamount),
    Fields.InValid_mpsa_cmp_assessedamount((SALT311.StrType)le.mpsa_cmp_assessedamount),
    Fields.InValid_mpsa_ee_agreedcount((SALT311.StrType)le.mpsa_ee_agreedcount),
    Fields.InValid_osha_countviolations((SALT311.StrType)le.osha_countviolations),
    Fields.InValid_osha_bw_agreedamount((SALT311.StrType)le.osha_bw_agreedamount),
    Fields.InValid_osha_cmp_assessedamount((SALT311.StrType)le.osha_cmp_assessedamount),
    Fields.InValid_osha_ee_agreedcount((SALT311.StrType)le.osha_ee_agreedcount),
    Fields.InValid_pca_countviolations((SALT311.StrType)le.pca_countviolations),
    Fields.InValid_pca_bw_agreedamount((SALT311.StrType)le.pca_bw_agreedamount),
    Fields.InValid_pca_ee_agreedcount((SALT311.StrType)le.pca_ee_agreedcount),
    Fields.InValid_sca_countviolations((SALT311.StrType)le.sca_countviolations),
    Fields.InValid_sca_bw_agreedamount((SALT311.StrType)le.sca_bw_agreedamount),
    Fields.InValid_sca_ee_agreedcount((SALT311.StrType)le.sca_ee_agreedcount),
    Fields.InValid_sraw_countviolations((SALT311.StrType)le.sraw_countviolations),
    Fields.InValid_sraw_bw_agreedamount((SALT311.StrType)le.sraw_bw_agreedamount),
    Fields.InValid_sraw_ee_agreedcount((SALT311.StrType)le.sraw_ee_agreedcount),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,109,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_State','Invalid_No','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dartid(TotalErrors.ErrorNum),Fields.InValidMessage_dateadded(TotalErrors.ErrorNum),Fields.InValidMessage_dateupdated(TotalErrors.ErrorNum),Fields.InValidMessage_website(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_caseid(TotalErrors.ErrorNum),Fields.InValidMessage_employername(TotalErrors.ErrorNum),Fields.InValidMessage_address1(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_employerstate(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_naicscode(TotalErrors.ErrorNum),Fields.InValidMessage_totalviolations(TotalErrors.ErrorNum),Fields.InValidMessage_bw_totalagreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_cmp_totalassessments(TotalErrors.ErrorNum),Fields.InValidMessage_ee_totalviolations(TotalErrors.ErrorNum),Fields.InValidMessage_ee_totalagreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_ca_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_ca_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_ca_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_ccpa_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_ccpa_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_ccpa_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_crew_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_crew_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_crew_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_crew_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_cwhssa_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_cwhssa_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_cwhssa_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_dbra_cl_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_dbra_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_dbra_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_eev_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_eppa_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_eppa_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_eppa_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_eppa_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_bw_15a3_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_bw_minwage_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_bw_overtime_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_cl_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_cl_countminorsemployed(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_cl_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_hmwkr_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_hmwkr_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_hmwkr_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_hmwkr_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smw14_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smw14_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smw14_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwap_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwap_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwap_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwft_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwft_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwft_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwl_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwl_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwl_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwmg_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwmg_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwmg_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwpw_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwpw_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwpw_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwsl_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwsl_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_flsa_smwsl_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_fmla_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_fmla_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_fmla_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_fmla_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_h1a_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_h1a_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_h1a_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_h1a_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_h1b_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_h1b_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_h1b_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_h1b_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_h2a_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_h2a_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_h2a_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_h2a_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_h2b_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_h2b_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_h2b_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_mpsa_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_mpsa_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_mpsa_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_mpsa_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_osha_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_osha_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_osha_cmp_assessedamount(TotalErrors.ErrorNum),Fields.InValidMessage_osha_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_pca_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_pca_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_pca_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_sca_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_sca_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_sca_ee_agreedcount(TotalErrors.ErrorNum),Fields.InValidMessage_sraw_countviolations(TotalErrors.ErrorNum),Fields.InValidMessage_sraw_bw_agreedamount(TotalErrors.ErrorNum),Fields.InValidMessage_sraw_ee_agreedcount(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_LaborActions_WHD, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
