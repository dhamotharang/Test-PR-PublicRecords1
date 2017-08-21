import Header,FCRA_list,NCPDP,mdr,doxie,lib_fileservices,ut,data_services;

export	NCPDP_as_header(dataset(NCPDP.layouts.keybuild) pNCPDP = dataset([],NCPDP.layouts.keybuild), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dNCPDPasSource	:=	FCRA_List.NCPDP_as_Source(pNCPDP,pForFCRAHeaderBuild);	

	unsigned3 fYYYYMMIntegerFromDate(string pDateIn)
	 :=
	  (unsigned3)(string6)pDateIn;	
		
	Header.Layout_New_Records	tNCPDPToHeader(dNCPDPasSource pInput)
	 :=
	  transform
		self.did						:= pInput.did;
		self.rid						:= pInput.UID;
		self.src						:= pInput.src;
		self.dt_first_seen						:= fYYYYMMIntegerFromDate((string)pInput.dt_first_seen);
	  self.dt_last_seen							:= if(fYYYYMMIntegerFromDate((string)pInput.dt_last_seen) != 0, fYYYYMMIntegerFromDate((string)pInput.dt_last_seen), SELF.dt_first_seen);
	  self.dt_vendor_first_reported := fYYYYMMIntegerFromDate((string)pInput.dt_first_seen);
	  self.dt_vendor_last_reported	:= fYYYYMMIntegerFromDate((string)pInput.dt_last_seen);
	  self.dt_nonglb_last_seen := if(fYYYYMMIntegerFromDate((string)pInput.dt_last_seen) != 0, fYYYYMMIntegerFromDate((string)pInput.dt_last_seen), SELF.dt_first_seen);
		self.ssn						:= '';
		self.dob						:= 0;
		self.title						:= '';
		self.fname						:= pInput.fname;
		self.mname						:= pInput.mname;
		self.lname						:= pInput.lname;
		self.name_suffix				:= pInput.suffix;
		self.prim_range					:= pInput.prim_range;
		self.predir						:= pInput.predir;
		self.prim_name					:= pInput.prim_name;
		self.suffix						:= pInput.addr_suffix;
		self.postdir					:= pInput.postdir;
		self.unit_desig					:= pInput.unit_desig;
		self.sec_range					:= pInput.sec_range;
		self.city_name					:= pInput.city_name;
		self.st							:= pInput.st;
		self.zip						:= pInput.zip;
		self.zip4						:= pInput.zip4;
		self.county						:= pInput.county;
		self.cbsa						:= '';
		self.geo_blk					:= pInput.geo_blk;
		self.phone						:= pInput.phone;
		self.vendor_id					:= '';
		self := pinput;
	  end
	 ;
	 
hdrNCPDP := dedup(sort(distribute(project(dNCPDPasSource,tNCPDPToHeader(left)),hash(did)), 
record, except rid, uid,vendor_id,persistent_record_id,local), record, except rid, uid,vendor_id,persistent_record_id, local);

return hdrNCPDP;

end;