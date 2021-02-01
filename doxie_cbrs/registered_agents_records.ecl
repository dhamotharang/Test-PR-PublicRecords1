IMPORT doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()
EXPORT registered_agents_records(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

rawr := doxie_cbrs.registered_agents_records_raw(bdids);

ragr := PROJECT(rawr,TRANSFORM(doxie_cbrs.layouts.registered_agent_record,
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

EXPORT records := CHOOSEN(SORT(deduped_ragr,corp_ra_name),Max_RegisteredAgents_val);
EXPORT records_count := COUNT(deduped_ragr);

END;
