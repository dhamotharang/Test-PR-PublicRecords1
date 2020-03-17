Export File_Person_Header := Module
  Export Layout := Record
  Unsigned6 did; // 
  Unsigned6 rid; // Persistent Record Identifier
  String1 pflag1;
  String1 pflag2;
  String1 pflag3;
  String2 src; // source name
  Unsigned3 dt_first_seen;
  Unsigned3 dt_last_seen;
  Unsigned3 dt_vendor_last_reported;
  Unsigned3 dt_vendor_first_reported;
  Unsigned3 dt_nonglb_last_seen;
  String1 rec_type;
  Qstring18 vendor_id; // 
  Qstring10 phone;
  Qstring9 ssn;
  Integer4 dob; // 
  Qstring5 title;
  Qstring20 fname;
  Qstring20 mname;
  Qstring20 lname;
  Qstring5 name_suffix;
  Qstring10 prim_range; // house number 
  String2 predir; // north s
  Qstring28 prim_name; // name od street 
  Qstring4 suffix; // street blvd or etc
  String2 postdir; // 
  Qstring10 unit_desig; // apt
  Qstring8 sec_range; // number of aprtment 
  Qstring25 city_name; // *
  String2 st; // *
  Qstring5 zip; // *
  Qstring4 zip4;
  String3 county; 
  Qstring7 geo_blk;
  Qstring5 cbsa;
  String1 tnt;
  String1 valid_ssn; 
  String1 jflag1;
  String1 jflag2;
  String1 jflag3;
  Unsigned8 rawaid; // ubique address id cleaner
  String5 dodgy_tracking; 
  Unsigned8 nid; // unique id from cleaner
  Unsigned2 address_ind; //  
  Unsigned2 name_ind; 
  Unsigned8 persistent_record_id; // hash value for overides 
End;

Export File := Dataset('~thor::test::jdb', Layout, Thor);

END;