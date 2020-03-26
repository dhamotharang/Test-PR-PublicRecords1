import ut, doxie, data_services;

baseCID := distribute(InfutorCID.File_InfutorCID_Base(did > 0 or did_instantID > 0), hash(did));


slim_layout := RECORD
  string34  persistent_record_id;
  unsigned6 did := 0;
  
/* Standard Cleaned Name Fields */
  string10  phone := '';
  string20	fname := '';
  string20	lname := '';
  
/* Standard Cleaned Address Fields */
  string10	prim_range	:='';	
  string2	predir		:='';
  string28	prim_name	:='';
  string4	addr_suffix	:='';	
  string2	postdir		:='';
  string10	unit_desig	:='';
  string8	sec_range	:='';
  string25	p_city_name	:='';
  string25	v_city_name	:='';	
  string2	st			:='';
  string5	zip			:='';
  string4	zip4		:='';
  string2	rec_type	:='';
  string5	county		:='';
  string10	geo_lat		:='';
  string11	geo_long	:='';
  string7	geo_blk		:='';
	
	/* Standard Additional Base Fields */
	unsigned6 dt_first_seen:=0;
	unsigned6 dt_last_seen:=0;
	
	//CCPA-9 Add CCPA fields
	unsigned4 global_sid:=0;
	unsigned8 record_sid:=0;

end;

// remove all seemingly unnecessary fields
slim_layout into_slim(baseCID le) := transform
	self.did := if(le.did = 0, le.did_instantID, le.did);
	self := le;
end;
p := dedup(sort(project(baseCID, into_slim(left)), record, except persistent_record_id, local), record, except persistent_record_id, local);

export Key_Infutor_DID_FCRA := index(p,{did},{p},data_services.data_location.prefix() + 'thor_data400::key::infutorcid::fcra::did_' + doxie.Version_SuperKey);