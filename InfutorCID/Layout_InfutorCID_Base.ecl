import address;

export Layout_InfutorCID_Base := 
record
/* Unique ID for Development Record Tracking Purposes Only   */
  string34  persistent_record_id;
	string  sequence_number := '';

/* Original Fields */
	infutorcid.Layout_InfutorCID;
	
/* Standard Cleaned Name Fields */
  string10  phone:='';
	string5		title:='';
  string20	fname:='';
  string20	mname:='';
  string20	lname:='';
  string5		name_suffix:='';
  string3		name_score:='';
	
/* Standard Cleaned Address Fields */
  string10	prim_range:='';	
  string2		predir:='';
  string28	prim_name:='';
  string4		addr_suffix:='';	
  string2		postdir:='';
  string10	unit_desig:='';
  string8		sec_range:='';
  string25	p_city_name:='';
  string25	v_city_name:='';	
  string2		st:='';
  string5		zip:='';
  string4		zip4:='';
  string4		cart:='';
  string1		cr_sort_sz:='';
  string4		lot:='';
  string1		lot_order:='';
  string2		dbpc:='';
  string1		chk_digit:='';
  string2		rec_type:='';
  string5		county:='';
  string10	geo_lat:='';
  string11	geo_long:='';
  string4		msa:='';
  string7		geo_blk:='';
  string1		geo_match:='';
  string4		err_stat:='';
	
/* Appended Address Fields from Header - Standard  */
  string10	append_prim_range:='';
  string2		append_predir:='';
  string28	append_prim_name:='';
  string4		append_addr_suffix:='';
  string2		append_postdir:='';
  string8		append_sec_range:='';
  string25	append_p_city_name:='';
  string2		append_st:='';
  string5		append_zip:='';
  string4		append_zip4:='';
  boolean   append_is_po_box := false;
  string4   append_in_eq := '';
  string4   append_in_en := '';
  string4   append_in_wp := '';
  string4   append_in_util := '';
  string4   append_in_ts := '';
  string4   append_in_veh := '';
  string4   append_in_prop := '';
  string4   append_in_dl := '';
  string4   append_in_tu := '';
  string4   append_in_other := '';
  boolean   append_only_glb := false;
  integer   append_addr_in_zip := 0;
  integer   append_prange_srange_in_zip := 0;

/* DID's */
	unsigned6 did:=0;
	unsigned6 did_instantID:=0;
	
/* Standard Additional Base Fields */
	unsigned6 dt_first_seen:=0;
	unsigned6 dt_last_seen:=0;
  unsigned6 dt_vendor_first_reported:=0;
	unsigned6 dt_vendor_last_reported:=0;
	
/* Additional Fields */
  boolean 	historical:=false;
  unsigned8 rawAIDin := 0;
  string1 addresstype := '';
  string182 previous_cleanaddress := ''; 

	//CCPA-9 Add 2 CCPA fields
	unsigned4 global_sid := 0;
	unsigned8 record_sid := 0;

end;