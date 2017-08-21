import Header,FCRA_list,mdr,CNLD_Practitioner,doxie,lib_fileservices,ut,data_services;

export	CNLD_Practitioner_as_header(dataset(CNLD_Practitioner.layouts.keybuild) pCNLDPractitioner = dataset([],CNLD_Practitioner.layouts.keybuild), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dCNLDSource	:=	FCRA_List.CNLD_Practitioner_as_Source(pCNLDPractitioner,pForFCRAHeaderBuild);
unsigned3 fYYYYMMIntegerFromDate(string pDateIn)
	 :=
	  (unsigned3)(string6)pDateIn;	
	Header.Layout_New_Records	tCNLDToHeader(dCNLDSource pInput)
	 :=
	  transform
		self.did						:= (unsigned6)pInput.did;
	  self.rid            :=  pInput.UID; 
		self.src						:= pInput.src;
	  self.dt_first_seen						:= fYYYYMMIntegerFromDate((string)pInput.date_firstseen);
	  self.dt_last_seen							:= if(fYYYYMMIntegerFromDate((string)pInput.date_lastseen) != 0, fYYYYMMIntegerFromDate((string)pInput.date_lastseen), SELF.dt_first_seen);
	  self.dt_vendor_first_reported := fYYYYMMIntegerFromDate((string)pInput.date_firstseen);
	  self.dt_vendor_last_reported	:= fYYYYMMIntegerFromDate((string)pInput.date_firstseen);
	  self.dt_nonglb_last_seen := if(fYYYYMMIntegerFromDate((string)pInput.date_lastseen) != 0, fYYYYMMIntegerFromDate((string)pInput.date_lastseen), SELF.dt_first_seen);
		self.rec_type 					:= '';
		self.ssn						:= pInput.SSN;
		self.dob						:= (integer)pInput.DOB;
		self.title						:= pInput.title;
		self.fname						:= pInput.fname;
		self.mname						:= pInput.mname;
		self.lname						:= pInput.lname;
		self.name_suffix				:= pInput.name_suffix;
		self.prim_range					:= pInput.prim_range;
		self.predir						:= pInput.predir;
		self.prim_name					:= pInput.prim_name;
		self.suffix						:= pInput.suffix;
		self.postdir					:= pInput.postdir;
		self.unit_desig					:= pInput.unit_desig;
		self.sec_range					:= pInput.sec_range;
		self.city_name					:= pInput.v_city_name;
		self.st							:= pInput.st;
		self.zip						:= pInput.zip;
		self.zip4						:= pInput.zip4;
		self.county						:= pInput.fips_county;
		self.cbsa						:= '';
		self.geo_blk					:= pInput.geo_blk;
		self.phone						:= pInput.address_phone;
		self.rawAID           := pInput.Append_RawAID;
		self.vendor_id					:= '';
		self := pinput;
	  end
	 ;
	 
hdrCNLD:= dedup(sort(distribute(project(dCNLDSource,tCNLDToHeader(left)),hash(did)), 
record, except rid, uid,vendor_id,persistent_record_id,local), record, except rid, uid, vendor_id,persistent_record_id,local);

return hdrCNLD;

end;
