import doxie, dx_Gong, ut;
import lib_datalib, NID, address; // to be able to call a macro in a JOIN condition

export fn_AppendGongByAddr(
	dataset(doxie.layout_AppendGongByAddr_input) a,
	boolean secRangeStrict = false) :=
FUNCTION

key := dx_Gong.key_address_current();

outf := record
	doxie.layout_AppendGongByAddr_input;
	boolean	business_flag; //I'm scared to change it to more correct and general "listing_type" at the moment
	typeof (key.fname) name_first; // this is clearly redundant, but removing it is a nightmare!
	typeof (key.lname) name_last;
	key.publish_code;
	key.omit_phone;
	string8 dt_first_seen;
	unsigned1 listing_type;
end;

//***** HISTORY KEYS METHOD

str_unlisted := dx_Gong.Constants.STR_UNLISTED;

doxie.gong_append_utils.MAC_lookupAptCount(a, withApt, secRangeStrict);

knowx_ftr_set := ut.IndustryClass.gong_knowx_src;

outf GetPhones (key R) := transform
  self.phone := if(R.publish_code = 'N' or R.omit_phone = 'Y', str_unlisted, R.phone10);
  self.zip := R.z5;
  self.listing_name := R.listed_name;
	self.name_first := R.fname;
	self.name_last := R.lname;
  self.timezone := '';
  self.business_flag := R.listing_type & dx_Gong.Constants.PTYPE.BUSINESS = dx_Gong.Constants.PTYPE.BUSINESS;
	// populating Fields for Accurint Comp Report Redesign
  self.dt_first_seen := R.date_first_seen;
  self.listing_type := R.listing_type;
  self := R;
end;

boolean IsRightType (unsigned1 ltype) := function
  return (knowx_ftr_Set=[]) or (ltype = dx_Gong.Constants.PTYPE.UNKNOWN) OR
         (((ltype & dx_Gong.Constants.PTYPE.BUSINESS    != dx_Gong.Constants.PTYPE.BUSINESS)    or ('B' in knowx_ftr_Set)) AND
          ((ltype & dx_Gong.Constants.PTYPE.GOVERNMENT  != dx_Gong.Constants.PTYPE.GOVERNMENT)  or ('G' in knowx_ftr_Set)) AND
          ((ltype & dx_Gong.Constants.PTYPE.RESIDENTIAL != dx_Gong.Constants.PTYPE.RESIDENTIAL) or ('R' in knowx_ftr_Set))
         );
end;

jr	    :=  join(withApt, key,
								 keyed(left.prim_name=right.prim_name) and
								 keyed(left.st=right.st) and
								 keyed(left.zip=right.z5) and
								 keyed(left.prim_range=right.prim_range) and
								 // the first parm to macro needs to be a constant expression
								 IF(secRangeStrict,
								 	 doxie.gong_append_utils.MAC_sec_range(true),
								 	 doxie.gong_append_utils.MAC_sec_range(false)) and
								 ut.NNEQ(left.predir,right.predir) and
								 ut.NNEQ(left.suffix,right.suffix) and
                 IsRightType (right.listing_type),
								 GetPhones (Right),
								 limit(ut.limits.PHONE_PER_ADDRESS * 5, skip));

dd := dedup(sort(jr,whole record), whole record);

ut.getTimeZone(dd,phone,timezone, dd_w_tzone)

return dd_w_tzone;

END;
