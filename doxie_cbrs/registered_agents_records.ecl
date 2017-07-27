import address, doxie;
export registered_agents_records(dataset(doxie_cbrs.layout_references) bdids) := 
MODULE

doxie_cbrs.mac_Selection_Declare()
rawr := doxie_cbrs.registered_agents_records_raw(bdids);

reg_agent_parsed_record := RECORD
	rawr.bdid;
	rawr.corp_ra_name;
	rawr.dt_last_seen;
	qstring10 prim_range;
	string2   predir;
	qstring28 prim_name;
	qstring4  addr_suffix;
	string2   postdir;
	qstring5  unit_desig;
	qstring8  sec_range;
	qstring25 city;
	string2   state;
	qstring5  zip;
	qstring4  zip4;
END;

ragr := project(rawr,transform(reg_agent_parsed_record,
	self.prim_range := left.corp_ra_prim_range,
	self.predir := left.corp_ra_predir,
	self.prim_name := left.corp_ra_prim_name,
	self.addr_suffix := left.corp_ra_addr_suffix,
	self.postdir := left.corp_ra_postdir,
	self.unit_desig := left.corp_ra_unit_desig,
	self.sec_range := left.corp_ra_sec_range,
	self.city := left.corp_ra_p_city_name,
	self.state := left.corp_ra_state,
	self.zip := left.corp_ra_zip5,
	self.zip4 := left.corp_ra_zip4,
	self := left));
    
shared deduped_ragr := dedup(ragr,ALL);

doxie_cbrs.mac_Selection_Declare()

export records := choosen(sort(deduped_ragr,corp_ra_name),Max_RegisteredAgents_val);
export records_count := count(deduped_ragr);

END;