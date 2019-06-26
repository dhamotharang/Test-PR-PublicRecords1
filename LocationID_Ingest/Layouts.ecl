﻿import SALT37;

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
			string4 zip4;
	     string2 dbpc;
			string2 rec_type;
			string4 err_stat;
			unsigned8 cntprimname;
			string28 prim_name_normalized;
			string4 predir_derived;
			string28 prim_name_derived;
			string4 addr_suffix_derived;
		end;

		export VariantStreetNamesRec := record
				string5  zipCode;
				string2  alias_predir;
				string28 alias_prim_name;
				string4  alias_suffix;
				string2  alias_postdir;
				string2  predir;
				string28 prim_name;
				string4  suffix;
				string2  postdir;
				string1  aliasType; //A=ABBREVIATED, C=STREET NAME CHANGE, O=NICKNAME/OTHER, P=PREFERRED
				string4  year;
				string2  month;
				string2  day;
				string10 low_number;
				string10 high_number;
				string1  oddEvenCode;  //O=ODD, E=EVEN, B=BOTH
		end;
		
end;