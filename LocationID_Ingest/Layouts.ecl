import SALT37;

export Layouts := module
	
		export Linking_Interface := record
			string2 source;
			unsigned8 source_record_id;
			SALT37.UIDType rid;
			SALT37.UIDType locid;
			unsigned8 aid;
			string8 dateseenfirst;
			string8 dateseenlast;
			string10 prim_range;
			string2 predir;
			string28 prim_name;
			string4 addr_suffix;
			string2 postdir;
			string10 unit_desig;
			string8 sec_range;
			string25 v_city_name;
			string2 st;
			string5 zip5;
			string2 rec_type;
			string4 err_stat;
			unsigned8 cntprimname;
		end;

end;