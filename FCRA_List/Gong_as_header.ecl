import header,codes,Gong_Neustar,mdr,lib_fileservices,ut,data_services;

export	Gong_as_header(dataset(gong_neustar.Layout_History) pGonghistory = dataset([],gong_neustar.Layout_History), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dGongasSource	:=	FCRA_List.Gong_as_source(pGonghistory,pForFCRAHeaderBuild);

/* //Gong History into Header base layout */
Header.Layout_New_Records tGongToHeader(dGongasSource pInput) := transform

	unsigned3 fYYYYMMIntegerFromDate(string pDateIn)
	 :=(unsigned3)(string6)pDateIn;

	self.did := pInput.did;
	self.rid := pInput.UID; 
	self.src := pInput.src;
	self.dt_first_seen						:= fYYYYMMIntegerFromDate(pInput.dt_first_seen);
	self.dt_last_seen							:= if(fYYYYMMIntegerFromDate(pInput.dt_last_seen) != 0, fYYYYMMIntegerFromDate(pInput.dt_last_seen), SELF.dt_first_seen);
	self.dt_vendor_first_reported := fYYYYMMIntegerFromDate(pInput.dt_first_seen);
	self.dt_vendor_last_reported	:= fYYYYMMIntegerFromDate(pInput.filedate[1..8]);
	self.dt_nonglb_last_seen := if(fYYYYMMIntegerFromDate(pInput.dt_last_seen) != 0, fYYYYMMIntegerFromDate(pInput.dt_last_seen), SELF.dt_first_seen);
	self.vendor_id := (STRING34)(pInput.bell_id + '-' + pInput.group_id);
	self.dob := 0;
	self.suffix := pInput.suffix;
	self.city_name := pInput.v_city_name;
	self.phone := pInput.phone10;
	self.ssn := '';
	self.rec_type := if(pInput.current_record_flag = 'Y', '1', '2');
	self.title := pInput.name_prefix;
	self.fname := pInput.name_first;
	self.mname := pInput.name_middle;
	self.lname := pInput.name_last;
	self.zip := pInput.z5;
	self.zip4 := pInput.z4;
	self.county := pInput.county_code[3..5];
	self.rawaid  := pInput.rawaid;
	self := pInput;
	
	END;
	
hdrGong := dedup(sort(distribute(project(dGongasSource, tGongToHeader(left)), hash(did)),
 record, except rid, uid,vendor_id,persistent_record_id,local), record, except rid, uid, vendor_id,persistent_record_id,local);

return hdrGong;

end;
