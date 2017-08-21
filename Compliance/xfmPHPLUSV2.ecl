IMPORT zz_CDKelly,Phonesplus_v2,ut;

rs_PPlusV2 := zz_CDKelly.normalize_PhonesPlusV2_sources;

layout_PPlusV2 := {rs_PPlusV2};

EXPORT Compliance.Layout_Out_v3 xfmPHPLUSV2(layout_PPlusV2 LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.src := LE.vendor_ids;
		
		self.rec_type := IF(LE.current_rec = true, 'Y','N');
		self.pflag1 := (string) LE.confidencescore[1];
		self.pflag2 := (string) LE.confidencescore[2];
		self.pflag3 := IF(LE.append_indiv_has_active_eda_phone_flag = true, 'Y','N');
		self.jflag1 := LE.listingtype;
		self.jflag2 := LE.orig_publish_code;
		self.jflag3 := LE.orig_phone_type;
		self.tnt := IF(LE.append_latest_phone_owner_flag = true, 'Y','N');
		
		self.did := LE.did;
		self.rid := (unsigned8) LE.cellphoneidkey;	//not a real RID
		self.dt_first_seen := LE.datefirstseen;
		self.dt_last_seen := LE.datelastseen;
		self.dt_vendor_last_reported := LE.datevendorlastreported;
		self.dt_vendor_first_reported := LE.datevendorfirstreported;
		self.dt_nonglb_last_seen := LE.dt_nonglb_last_seen;
		
		self.vendor_id := LE.cellphone;
		self.phone := LE.cellphone;
		self.dob := (integer4) LE.dob;
		
		self.title := LE.title;
		self.fname := LE.fname;
		self.mname := LE.mname;
		self.lname := LE.lname;
		self.name_suffix := LE.name_suffix;
		self.prim_range := LE.prim_range;
		self.predir := LE.predir;
		self.prim_name := LE.prim_name;
		self.suffix := LE.addr_suffix;
		self.postdir := LE.postdir;
		self.unit_desig := LE.unit_desig;
		self.sec_range := LE.sec_range;
		self.city_name := LE.v_city_name;
		self.st := LE.state;
		self.zip := LE.zip5;
		self.zip4 := LE.zip4;
		
		self.RawAID := LE.RawAID;
//		self.NID := LE.NID;
//		self.name_ind := LE.name_ind;
//		self.persistent_record_ID := LE.persistent_record_ID;
		self.hhid := LE.hhid;
		
		self.county_name := LE.append_phone_type;
		self.listed_name := LE.append_ocn;
		self.listed_phone := LE.cellphone;
		
		self.source_value := LE.vendor_ids;
						
		SELF := LE;
		SELF := RI;
	END;