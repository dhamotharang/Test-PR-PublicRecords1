export MAC_BestAppendAddFieldsGlb(outfile,infile,key,supply,verify) := MACRO
  IMPORT STD;
	#uniquename (tra);
	typeof(infile) %tra%(infile le, recordof(key) ri,string options) := transform
		self.best_phone := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_PHONE',1)=0,'', ri.phone );
		self.best_ssn := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_SSN',1)=0,'', ri.ssn );
		//self.best_name := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0,'', os(ri.title)+os(ri.fname)+os(ri.mname)+os(ri.lname)+os(ri.NAME_suffix) );
		self.best_title := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0,'',ri.title);
		self.best_fname := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0,'',ri.fname);
		self.best_mname := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0,'',ri.mname);
		self.best_lname :=if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0,'',ri.lname);
		self.best_name_suffix := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0,'',ri.name_suffix);
		self.best_addr1 := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0,'', os(ri.prim_range)+os(ri.predir)+os(ri.prim_name)+os(ri.suffix)+os(ri.postdir)+IF(Std.Str.EndsWith(ri.prim_name,os(ri.unit_desig)+os(ri.sec_range)),'',os(ri.unit_desig)+os(ri.sec_range)) );
		//self.best_addr2 := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0,'', os(ri.city_name)+os(ri.st)+ri.zip+IF(ri.zip4<>'','-'+ri.zip4,'') );
		self.best_city :=if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0,'',ri.city_name);
		self.best_state := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0,'',ri.st);
		self.best_zip := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0,'',ri.zip);
		self.best_zip4 := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0,'',ri.zip4);
		self.best_addr_date := if ( stringlib.stringfind(options,'BEST_ALL',1)= 0 and stringlib.stringfind(options,'BEST_ADDRESS_DATE',1) = 0,0,ri.addr_dt_last_seen);
		self.best_dob := (string8)if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_DOB',1)=0,'',if(ri.dob<0,'',(string8)ri.dob));
		self.best_dod := (string8)if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_DOD',1)=0,'',ri.dod);
		self.verify_best_phone := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_PHONE',1)=0,255, did_add.phone_match_score(le.phone10,ri.phone));
		self.verify_best_ssn := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_SSN',1)=0 and stringlib.stringfind(verify,'FUZZY_SSN',1) = 0, 255,
		if (stringlib.stringfind(verify,'FUZZY_SSN',1) != 0, did_add.ssn_match_score(le.ssn, ri.ssn, true), did_add.ssn_match_score(le.ssn,ri.ssn)));
		self.verify_best_name := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_NAME',1)=0,255, did_add.name_match_score(le.fname,le.mname,le.lname,ri.fname,ri.mname,ri.lname));
		self.verify_best_address := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_ADDR',1)=0,255, did_add.Address_Match_Score(le.prim_range,le.prim_name,le.sec_range,le.z5,ri.prim_range,ri.prim_name,ri.sec_range,ri.zip,le.zip4,ri.zip4) );
		self.verify_best_dob := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_DOB',1)=0,255,did_add.dob_match_score((integer)le.dob,(integer)ri.dob));
		self := le;
	end;
	outfile := join(infile,key,left.did != 0 AND keyed(left.did=right.did),%tra%(left,right,supply),left outer, KEEP (1));

endmacro;
