export Layout_Override_Infutor := RECORD
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
	STRING20 flag_file_id;
END;