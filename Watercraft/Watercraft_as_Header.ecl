import Header;

water_in := watercraft_as_source;

unsigned3 fYYYYMMIntegerFromDate(string pDateIn)
 :=
  (unsigned3)(string6)pDateIn;
 ;

Header.Layout_New_Records	tWatercraftToHeader(water_in pInput)
 :=
  transform
	self.did						:= 0;
	self.rid						:= 0;
	self.src						:= Watercraft.Header_Source_Code(pInput.Source_Code, pInput.State_Origin);
	self.dt_first_seen				:= fYYYYMMIntegerFromDate(pInput.Date_First_Seen);
	self.dt_last_seen				:= fYYYYMMIntegerFromDate(pInput.Date_Last_Seen);
	self.dt_vendor_last_reported		:= fYYYYMMIntegerFromDate(pInput.Date_Vendor_Last_Reported);
	self.dt_vendor_first_reported 	:= fYYYYMMIntegerFromDate(pInput.Date_Vendor_First_Reported);
	self.dt_nonglb_last_seen  		:= fYYYYMMIntegerFromDate(pInput.Date_Last_Seen);
	self.rec_type 					:= if(pInput.History_Flag='','1','2');
	self.ssn						:= pInput.Orig_SSN;
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
	self.zip						:= pInput.zip5;
	self.zip4						:= pInput.zip4;
	self.county						:= pInput.county;
	self.cbsa						:= '';
	self.geo_blk					:= pInput.geo_blk;
	self.phone						:= pInput.phone_1;
	self.vendor_id					:= pInput.Watercraft_Key;
     self := pinput;
  end
 ;

export Watercraft_as_Header := project(water_in,tWatercraftToHeader(left));
