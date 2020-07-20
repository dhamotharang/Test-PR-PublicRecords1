import doxie, dx_Gong, ut, suppress;
import lib_datalib, NID, address; // to be able to call a macro in a JOIN condition

export fn_AppendGongByAddr(
    dataset(doxie.layout_AppendGongByAddr_input) a,
    doxie.IDataAccess mod_access,
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

outf_sup := record(outf)
 unsigned4 global_sid;
 unsigned8 record_sid;
end;
//***** HISTORY KEYS METHOD

str_unlisted := dx_Gong.Constants.STR_UNLISTED;

doxie.gong_append_utils.MAC_lookupAptCount(a, withApt, secRangeStrict);

outf_sup GetPhones (key R) := transform
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


string search_type := '' : STORED('GONG_SEARCHTYPE');
boolean IsRightType (unsigned1 ltype) :=
  ~mod_access.isConsumer() or (ltype = dx_Gong.Constants.PTYPE.UNKNOWN) OR (
      ((ltype & dx_Gong.Constants.PTYPE.BUSINESS    != dx_Gong.Constants.PTYPE.BUSINESS)    or (search_type='BUSINESS')) AND
      ((ltype & dx_Gong.Constants.PTYPE.GOVERNMENT  != dx_Gong.Constants.PTYPE.GOVERNMENT)  or (search_type='BUSINESS')) AND
      ((ltype & dx_Gong.Constants.PTYPE.RESIDENTIAL != dx_Gong.Constants.PTYPE.RESIDENTIAL) or (search_type='PERSON'))
  );

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

dd_pre := dedup(sort(jr,whole record), whole record);
dd_sup := suppress.MAC_SuppressSource(dd_pre, mod_access);
dd := project(dd_sup,outf);
ut.getTimeZone(dd,phone,timezone, dd_w_tzone)

return dd_w_tzone;

END;
