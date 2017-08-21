IMPORT header, mdr,_Validate, Address, PRTE2_SexOffender, _Validate;

EXPORT as_headers := MODULE

	//For Person Records
	header.Layout_New_Records MapPeopleHeader(Layouts.SexOffender_base L) := TRANSFORM
	  self.did 						:= (integer)L.did;
	  self.rid 						:= 0;
		self.src 						:= MDR.sourceTools.src_sexoffender;
	  self.dt_first_seen	:= (UNSIGNED3)(L.dt_first_reported[1..6]);
	  self.dt_last_seen 	:= (UNSIGNED3)(L.dt_last_reported[1..6]);
	  self.dt_vendor_last_reported	:= (UNSIGNED3)(L.dt_last_reported[1..6]);
	  self.dt_vendor_first_reported := (UNSIGNED3)(L.dt_first_reported[1..6]);
	  self.dt_nonglb_last_seen			:= (UNSIGNED3)(L.dt_last_reported[1..6]);
	  self.rec_type 			:= L.record_type;
	  self.vendor_id 			:= L.seisint_primary_key;
	  SELF.ssn 						:= L.SSN;
	  self.dob 						:= (integer)L.DOB;
	  self 								:= L;
		self								:= [];
	END;

	nBase := PROJECT(Files.SexOffender_base, MapPeopleHeader(left));

	EXPORT person_header_SOF := DEDUP(SORT(nBase(did>0,prim_name <> '',lname <> '',fname <> ''),DID),ALL);
	
END;