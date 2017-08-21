IMPORT Gong_Neustar,ut;

Gong_history := PULL(Gong_Neustar.File_GongHistory);
rs_EDA := Gong_history(bell_id = 'NEU'
//										AND current_record_flag = 'Y'
											);

layout_EDA := {rs_EDA};

EXPORT Compliance.Layout_Out_v3 xfmGONG(layout_EDA LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.src := LE.bell_id;
		
		self.rec_type := LE.current_record_flag;
		self.pflag1 := LE.listing_type_bus;
		self.pflag2 := LE.listing_type_res;
		self.pflag3 := LE.listing_type_gov;
		self.jflag1 := LE.publish_code;
		self.jflag2 := LE.style_code;
		self.jflag3 := LE.indent_code;
		
		self.did := LE.did;
		self.rid := LE.persistent_record_id;
		self.dt_first_seen := (unsigned3) LE.dt_first_seen;
		self.dt_last_seen := (unsigned3) LE.dt_last_seen;
		self.dt_vendor_last_reported := (unsigned3) LE.filedate[1..8];
//		self.dt_vendor_first_reported := (unsigned3) LE.date_vendor_first_reported;
		self.dt_nonglb_last_seen := (unsigned3) LE.deletion_date;
		self.vendor_id := LE.phone10;
		self.phone := LE.phone10;
		self.title := LE.name_prefix;
		self.fname := LE.name_first;
		self.mname := LE.name_middle;
		self.lname := LE.name_last;
		self.name_suffix := LE.name_suffix;
		self.prim_range := LE.prim_range;
		self.predir := LE.predir;
		self.prim_name := LE.prim_name;
		self.suffix := LE.suffix;
		self.postdir := LE.postdir;
		self.unit_desig := LE.unit_desig;
		self.sec_range := LE.sec_range;
		self.city_name := LE.v_city_name;
		self.st := LE.st;
		self.zip := LE.z5;
		self.zip4 := LE.z4;
		
		self.RawAID := LE.RawAID;
		self.NID := LE.NID;
		self.name_ind := LE.name_ind;
		self.persistent_record_ID := LE.persistent_record_ID;
		self.hhid := LE.hhid;
		
		self.listed_name := LE.listed_name;
		self.listed_phone := LE.phone10;
		
		self.source_value := LE.bell_id;
						
		SELF := LE;
		SELF := RI;
	END;