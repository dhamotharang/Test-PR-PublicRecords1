//-----------------------------------------------------------------------------
// Gets the candidate records to be used in the main, which is the input data
// and data for two degrees of separation of relatives.
//-----------------------------------------------------------------------------
import header;

r := RECORD
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  unsigned8 persistent_record_id;
  unsigned4 global_sid;
  unsigned8 record_sid;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
 END;


EXPORT get_universe(unsigned1 mode):=MODULE
  // Start with a slim version of the original data from infutor header that 
  // contains just the DID and an integer came_from='1'.
  // inf_hdr := D2C_Customers.Files.InfutorHdr(mode);
  inf_hdr := dataset('~persist::d2c::full::infutor_hdr',r,thor);
  dOriginalDIDs:=DEDUP(SORT(DISTRIBUTE(PROJECT(inf_hdr(did>0),TRANSFORM(D2C_Customers.layouts.lIteration,SELF.came_from:='1';SELF:=LEFT;)),HASH(did)),did,LOCAL),did,LOCAL);
  // Pass2 gives us the input data with first-degree relatives (came_from='2')
  SHARED dFirstDegree := D2C_Customers.mod_get_universe(dOriginalDIDs,'2').universe;
  
  // Pass3 gives us the data from Pass 2 along with second-degree relatives
  // (came_from='3')
  SHARED dSecondDegree:=D2C_Customers.mod_get_universe(dFirstDegree,'3').universe;
  
  EXPORT get_relative_pairs_1:=D2C_Customers.mod_get_universe(dFirstDegree,'2').relative_pairs;
  EXPORT get_relative_pairs_2:=D2C_Customers.mod_get_universe(dSecondDegree,'3').relative_pairs;
  
END;