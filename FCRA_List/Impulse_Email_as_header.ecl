import header,codes,Impulse_Email,mdr,lib_fileservices,ut,data_services;

export	Impulse_Email_as_header(dataset(Impulse_Email.layouts.layout_Impulse_Email_final) pImpulseEmail = dataset([],Impulse_Email.layouts.layout_Impulse_Email_final), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dImpulseasSource	:=	FCRA_List.Impulse_Email_as_Source(pImpulseEmail,pForFCRAHeaderBuild);

/* //InfutorCID into Header base layout */

unsigned3 fYYYYMMIntegerFromDate(string pDateIn)
	 :=
	  (unsigned3)(string6)pDateIn;
		
Header.Layout_New_Records tImpulseEmailToHeader(dImpulseasSource pInput) := transform
	
	self.did := pInput.did;
	self.rid := pInput.UID; 
	self.src := pInput.src;
	self.dt_first_seen						:= fYYYYMMIntegerFromDate((string)pInput.DateVendorFirstReported);
	self.dt_last_seen							:= fYYYYMMIntegerFromDate((string)pInput.DateVendorLastReported);
	self.dt_vendor_first_reported := fYYYYMMIntegerFromDate((string)pInput.DateVendorFirstReported);
	self.dt_vendor_last_reported	:= fYYYYMMIntegerFromDate((string)pInput.DateVendorLastReported);
	self.dt_nonglb_last_seen := fYYYYMMIntegerFromDate((string)pInput.DateVendorLastReported);
	self.vendor_id := '';
	self.dob := (unsigned4)pInput.ln_dob;
	self.ssn := pInput.ln_ssn;
	self.rec_type := if(pInput.record_type = 'C', '1', '2');
	self.title						:= '';
	self.fname						:= pInput.cln_fname;
  self.mname						:= pInput.cln_mname;
	self.lname						:= pInput.cln_lname;
	self.name_suffix			:= pInput.cln_name_suffix;
	self.prim_range				:= pInput.prim_range;
	self.predir						:= pInput.predir;
	self.prim_name				:= pInput.prim_name;
	self.suffix						:= pInput.addr_suffix;
	self.postdir					:= pInput.postdir;
	self.unit_desig				:= pInput.unit_desig;
	self.sec_range				:= pInput.sec_range;
	self.city_name				:= pInput.v_city_name;
	self.st							  := pInput.st;
	self.zip						  := pInput.zip5;
	self.zip4						  := pInput.zip4;
	self.county						:= pInput.county[3..];
	self.cbsa						  := '';
	self.geo_blk					:= pInput.geo_blk;
	self.phone						:= if(pInput.homephone <> '', pInput.homephone, pInput.cellphone);
	self.persistent_record_ID := 0;//(unsigned8)pInput.persistent_record_ID;
	self := pinput;
	end
	 ;

hdrImpulseEmail := dedup(sort(distribute(project(dImpulseasSource,tImpulseEmailToHeader(left)),hash(did)),
 record, except rid, uid,vendor_id,persistent_record_id,local), record, except rid, uid,vendor_id,persistent_record_id, local);

return hdrImpulseEmail;

end;
