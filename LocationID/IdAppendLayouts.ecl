export IdAppendLayouts := module
     export AppendInput := record
	     unsigned request_id;
	     string10 prim_range;
	     string2 predir;
	     string28 prim_name;
	     string4 addr_suffix;
	     string2 postdir;
	     string8 sec_range;
	     string25 v_city_name;
	     string2 st;
	     string5 zip5;
	     string4 zip4;
	end;
	
	export svcAppendOut := record
	     unsigned request_id;
		unsigned6 LocId;
	     string10 prim_range;
	     string2 predir;
	     string28 prim_name;
	     string4 addr_suffix;
	     string2 postdir;
	     string8 sec_range;
	     string25 v_city_name;
	     string2 st;
	     string5 zip5;
	     string4 zip4;
	end;
end;