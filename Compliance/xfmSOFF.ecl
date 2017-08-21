

IMPORT Sexoffender,Hygenics_SOff,Images,doxie_build,ut;

layout_SOFF := sexoffender.layout_out_main;

//Hygenics_SOff.File_Main
SO_Offender			:= DATASET(ut.foreign_prod+'thor_data400::base::sex_offender_mainpublic'+ doxie_build.buildstate,layout_SOFF,flat);
//Hygenics_SOff.File_Offense
SO_Offense			:= DATASET(ut.foreign_prod+'thor_data400::base::sex_offender_offensespublic', hygenics_soff.Layout_common_Offense_new, flat);
//SOFF_Images				:= Images.File_Images; //(rtype=â€™SOâ€™);


EXPORT Compliance.Layout_Out_v3 xfmSOFF(layout_SOFF LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.src := LE.source_file;
		self.did := (unsigned6) LE.did;
		self.vendor_id := LE.offender_id;
		self.ssn := LE.ssn_appended;
		self.dob := (integer4) LE.dob;
		self.dt_last_seen := (integer) LE.fcra_date;
		self.dt_vendor_last_reported := (integer) LE.dt_last_reported;
		self.dt_vendor_first_reported := (integer) LE.dt_first_reported;
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
		self.st := LE.st;
		self.zip := LE.zip5;
		self.zip4 := LE.zip4;
		self.county_name := LE.registration_county;
		self.listed_name := LE.seisint_primary_key;
		self.persistent_record_ID := LE.offender_persistent_id;
		
		self.tag_num := LE.orig_veh_plate_1;
		self.veh_reg_num := LE.orig_registration_number_1;
		
		self.DL_state := LE.orig_dl_state;
		self.DL_num := LE.orig_dl_number;
		
		self.DOC_num := LE.doc_number;
		
		self.source_value :=  self.src;
		
						
		SELF := LE;
		SELF := RI;
	END;