import doxie,header,codes,mdr,InfutorCID,mdr,lib_fileservices,ut,data_services;

export	InfutorCID_as_header(dataset(infutorCID.Layout_InfutorCID_Base) pInfutorCID = dataset([],infutorCID.Layout_InfutorCID_Base), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dInfutorCIDasSource	:=	FCRA_List.InfutorCID_as_source(pInfutorCID,pForFCRAHeaderBuild);
	
/* //InfutorCID into Header base layout */

unsigned3 fYYYYMMIntegerFromDate(string pDateIn)
	 :=
	  (unsigned3)(string6)pDateIn;
		
Header.Layout_New_Records tInfutorCIDToHeader(dInfutorCIDasSource pInput) := transform
	
	self.did := pInput.did;
	self.rid := pInput.UID; 
	self.src := pInput.src;
	self.dt_first_seen						:= fYYYYMMIntegerFromDate((string)pInput.dt_first_seen);
	self.dt_last_seen							:= if(fYYYYMMIntegerFromDate((string)pInput.dt_last_seen) != 0, fYYYYMMIntegerFromDate((string)pInput.dt_last_seen), SELF.dt_first_seen);
	self.dt_vendor_first_reported := fYYYYMMIntegerFromDate((string)pInput.dt_first_seen);
	self.dt_vendor_last_reported	:= fYYYYMMIntegerFromDate((string)pInput.dt_last_seen);
	self.dt_nonglb_last_seen := if(fYYYYMMIntegerFromDate((string)pInput.dt_last_seen) != 0, fYYYYMMIntegerFromDate((string)pInput.dt_last_seen), SELF.dt_first_seen);
	self.vendor_id := '';
	self.dob := 0;
	self.ssn := '';
	self.rec_type := if(pInput.historical = true, '2', '1');
	self.title						:= pInput.title;
	self.fname						:= pInput.fname;
  self.mname						:= pInput.mname;
	self.lname						:= pInput.lname;
	self.name_suffix			:= pInput.name_suffix;
	self.prim_range				:= pInput.prim_range;
	self.predir						:= pInput.predir;
	self.prim_name				:= pInput.prim_name;
	self.suffix						:= pInput.addr_suffix;
	self.postdir					:= pInput.postdir;
	self.unit_desig				:= pInput.unit_desig;
	self.sec_range				:= pInput.sec_range;
	self.city_name				:= pInput.v_city_name;
	self.st							  := pInput.st;
	self.zip						  := pInput.zip;
	self.zip4						  := pInput.zip4;
	self.county						:= pInput.county[3..];
	self.cbsa						  := '';
	self.geo_blk					:= pInput.geo_blk;
	self.phone						:= pInput.phone;
	self.persistent_record_ID := 0;//(unsigned8)pInput.persistent_record_ID;
	self.rawaid           := pInput.rawaidin;
	self := pinput;
	end
	 ;

hdrInfutorCID := dedup(sort(distribute(project(dInfutorCIDasSource,tInfutorCIDToHeader(left)),hash(did)), 
record, except rid, uid, vendor_id,persistent_record_id,local), record, except rid, uid, vendor_id,persistent_record_id,local);

return hdrInfutorCID;

end;
