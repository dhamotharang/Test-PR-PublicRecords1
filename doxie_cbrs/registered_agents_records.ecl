IMPORT address, doxie;
EXPORT registered_agents_records(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()
rawr := doxie_cbrs.registered_agents_records_raw(bdids);

reg_agent_parsed_record := RECORD
  rawr.bdid;
  rawr.corp_ra_name;
  rawr.dt_last_seen;
  QSTRING10 prim_range;
  STRING2 predir;
  QSTRING28 prim_name;
  QSTRING4 addr_suffix;
  STRING2 postdir;
  QSTRING5 unit_desig;
  QSTRING8 sec_range;
  QSTRING25 city;
  STRING2 state;
  QSTRING5 zip;
  QSTRING4 zip4;
END;

ragr := PROJECT(rawr,TRANSFORM(reg_agent_parsed_record,
  SELF.prim_range := LEFT.corp_ra_prim_range,
  SELF.predir := LEFT.corp_ra_predir,
  SELF.prim_name := LEFT.corp_ra_prim_name,
  SELF.addr_suffix := LEFT.corp_ra_addr_suffix,
  SELF.postdir := LEFT.corp_ra_postdir,
  SELF.unit_desig := LEFT.corp_ra_unit_desig,
  SELF.sec_range := LEFT.corp_ra_sec_range,
  SELF.city := LEFT.corp_ra_p_city_name,
  SELF.state := LEFT.corp_ra_state,
  SELF.zip := LEFT.corp_ra_zip5,
  SELF.zip4 := LEFT.corp_ra_zip4,
  SELF := LEFT));
    
SHARED deduped_ragr := DEDUP(ragr,ALL);

doxie_cbrs.mac_Selection_Declare()

EXPORT records := CHOOSEN(SORT(deduped_ragr,corp_ra_name),Max_RegisteredAgents_val);
EXPORT records_count := COUNT(deduped_ragr);

END;
