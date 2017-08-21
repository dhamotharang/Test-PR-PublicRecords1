import header,codes,Prof_License_Mari,mdr,lib_fileservices,data_services;

export	Mari_as_header(dataset(Prof_License_Mari.layouts.final) pProflicMari = dataset([],Prof_License_Mari.layouts.final), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dMariasSource	:=	FCRA_List.Mari_as_source(pProflicMari,pForFCRAHeaderBuild);
	
/* Proflic Mari into Header base layout */
unsigned3 fYYYYMMIntegerFromDate(string pDateIn)
	 :=
	  (unsigned3)(string6)pDateIn;
		
Header.Layout_New_Records tMariToHeader(dMariasSource pInput) := transform

	self.did := pInput.did;
	self.rid := pInput.UID; 
	self.src := pInput.src;
	self.dt_first_seen						:= fYYYYMMIntegerFromDate((string)pInput.date_first_seen);
	self.dt_last_seen							:= if(fYYYYMMIntegerFromDate((string)pInput.date_last_seen) != 0, fYYYYMMIntegerFromDate((string)pInput.date_last_seen), SELF.dt_first_seen);
	self.dt_vendor_first_reported := fYYYYMMIntegerFromDate((string)pInput.DATE_VENDOR_FIRST_REPORTED);
	self.dt_vendor_last_reported	:= fYYYYMMIntegerFromDate((string)pInput.DATE_VENDOR_LAST_REPORTED);
	self.dt_nonglb_last_seen := if(fYYYYMMIntegerFromDate((string)pInput.date_last_seen) != 0, fYYYYMMIntegerFromDate((string)pInput.date_last_seen), SELF.dt_first_seen);
	self.vendor_id := '';
	self.ssn := '';
	self.rec_type := '';
	self := pInput;
	
	END;
	
hdrMari := dedup(sort(distribute(project(dMariasSource, tMariToHeader(left)), hash(did)), 
record, except rid, uid,vendor_id,persistent_record_id,local), record, except rid, uid, vendor_id,persistent_record_id,local);

return hdrMari;

end;