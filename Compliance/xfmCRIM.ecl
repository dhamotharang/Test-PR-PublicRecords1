
IMPORT Corrections,hygenics_crim,ut;

layout_CRIM := Corrections.layout_offender;

CRIM_Offender	:= DATASET(ut.foreign_prod+'thor_data400::base::corrections_offenders_public', layout_CRIM, flat);
COURT_Offenses	:= DATASET(ut.foreign_prod+'thor_data400::base::corrections_court_offenses_public', corrections.layout_CourtOffenses, flat);
DOC_Offenses		:= DATASET(ut.foreign_prod+'thor_data400::base::corrections_offenses_public', corrections.Layout_Offense, flat);
DOC_Punishment	:= DATASET(ut.foreign_prod+'thor_data400::base::corrections_punishment_public', hygenics_crim.Layout_CrimPunishment, flat);


EXPORT Compliance.Layout_Out_v3 xfmCRIM(layout_CRIM LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.src := LE.source_file;
		self.did := (unsigned6) LE.did;
		self.vendor_id := LE.case_num;
		self.ssn := LE.ssn_appended;
		self.dob := (integer4) LE.dob;
		self.dt_last_seen := (integer) LE.process_date;
		self.dt_vendor_last_reported := (integer) LE.case_date;
		self.dt_vendor_first_reported := (integer) LE.src_upload_date;
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
		self.county_name := LE.county_of_origin;
		self.listed_name := LE.offender_key + ' ' + LE.case_type_desc;
		self.persistent_record_ID := LE.offender_persistent_id;
		
		self.DL_state := LE.dl_state;
		self.DL_num := LE.dl_num;
		self.DOC_num := LE.doc_num;
		
		self.source_value := LE.datasource + ' ' + self.src;
		
						
		SELF := LE;
		SELF := RI;
	END;