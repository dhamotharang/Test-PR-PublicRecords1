//// First get the DID from the PHDR search.  Then use the DID to search Property.	////

IMPORT LN_PropertyV2, Property, ut;

//LN_PropertyV2.File_Search_DID
Prop_Search_Mnthly := DATASET(ut.foreign_prod+'thor_data400::base::ln_propertyv2::search',
															LN_PropertyV2.Layout_DID_Out, flat);

rSource_Tax := 
	RECORD
		string source_val;
		string which_prop_file;
		LN_PropertyV2.Layout_DID_Out;
	END;

rSource_Tax TwoSourcesMonthly_Tax(LN_PropertyV2.Layout_DID_Out pInput) :=
	TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  //Source A is Fares
		SELF.which_prop_file := 'SEARCH_MONTHLY';
		SELF := pInput;
	END;

File_Base_Search_Mnthly := PROJECT(Prop_Search_Mnthly, TwoSourcesMonthly_Tax(LEFT)); 


//LN_PropertyV2_Fast.Files.base.search_prp
Prop_Search_Fast := DATASET(ut.foreign_prod+'thor_data400::base::property_fast::search_father',
															LN_PropertyV2.Layout_DID_Out, flat);
															
rSource_Tax TwoSourcesFast_Tax(LN_PropertyV2.Layout_DID_Out pInput) :=
	TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  //Source A is Fares
		SELF.which_prop_file := 'SEARCH_FAST';
		SELF := pInput;
	END;

File_Base_Search_Fast := PROJECT(Prop_Search_Fast, TwoSourcesFast_Tax(LEFT)); 


Prop_Search := File_Base_Search_Mnthly + File_Base_Search_Fast;

//-----


rec_xfmRPROP := {rSource_Tax, Compliance.Layout_orig_out};

//EXPORT Compliance.Layout_Out_v3 xfmRPROP(rSource_Tax LE, Compliance.Layout_Out_v3 RI) := 
EXPORT Compliance.Layout_Out_v3 xfmRPROP(rec_xfmRPROP LE) := 
	TRANSFORM
		self.did := MAP(LE.did = 0 AND (LE.seleid <> 0 AND LE.cname <> '') => LE.seleid
										,LE.did);
										
		self.rid := LE.source_rec_id;
		
		self.src := LE.source_val;
		
		self.vendor_id := LE.ln_fares_id;
		self.ssn := (qstring9) LE.app_ssn;
		self.phone := (qstring10) LE.phone_number;
		
		self.pflag1 := LE.source_code[1];
		self.pflag2 := LE.source_code[2];
		self.pflag3 := LE.which_orig[1];
		
		self.dt_first_seen := (unsigned3) LE.dt_first_seen;
		self.dt_last_seen := (unsigned3) LE.dt_last_seen;
		self.dt_vendor_last_reported := (unsigned3) LE.dt_vendor_last_reported;
		self.dt_vendor_first_reported := (unsigned3) LE.dt_vendor_first_reported;
		
		self.title := LE.title;
		self.fname := LE.fname;
		self.mname := LE.mname;
		self.lname := MAP(LE.cname <> '' => LE.cname
										 ,LE.lname);
		self.name_suffix := LE.name_suffix;
		self.prim_range := LE.prim_range;
		self.predir := LE.predir;
		self.prim_name := LE.prim_name;
		self.suffix := LE.suffix;
		self.postdir := LE.postdir;
		self.unit_desig := LE.unit_desig;
		self.sec_range := LE.sec_range;
		self.city_name := LE.p_city_name;
		self.st := LE.st;
		self.zip := (qstring5) LE.zip;
		self.zip4 := (qstring4) LE.zip4;
		self.RawAID := (unsigned8) LE.Append_RawAID;
		self.persistent_record_ID := LE.source_rec_id;
		self.nid := LE.nid;
		
		self.lookup_did := LE.did;
		
		self.source_value := MAP((LE.ln_fares_id[1..2] IN ['DD', 'OD']) OR LE.ln_fares_id[2] = 'M' => 'LP'
														,LE.ln_fares_id[1..2] IN ['RD'] => 'FP'
														,LE.ln_fares_id[1..2] IN ['DA', 'OA'] => 'LA'
														,LE.ln_fares_id[1..2] IN ['RA'] => 'FA'
														,LE.source_val);
		
		SELF := LE;
//		SELF := RI;
	END;
