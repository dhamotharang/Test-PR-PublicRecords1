import infutor, header;
EXPORT Layouts := module

EXPORT layout_pre_infutor := 
{
recordof(infutor.key_infutor_best_did)             OR
recordof(Header.Key_Teaser_cnsmr_did)              OR
recordof(Header.Key_Teaser_cnsmr_search)           OR
{recordof(Infutor.Key_Header_Infutor_Knowx) - dod}
};
//infutor.layout_best.lbest;
EXPORT lbest := infutor.layout_best.lbest;
// EXPORT layout_infutor_best_did := RECORD
  // unsigned6 did;
  // qstring10 phone;
  // qstring9 ssn;
  // integer4 dob;
  // qstring5 title;
  // qstring20 fname;
  // qstring20 mname;
  // qstring20 lname;
  // qstring5 name_suffix;
  // qstring10 prim_range;
  // string2 predir;
  // qstring28 prim_name;
  // qstring4 suffix;
  // string2 postdir;
  // qstring10 unit_desig;
  // qstring8 sec_range;
  // qstring25 city_name;
  // string2 st;
  // qstring5 zip;
  // qstring4 zip4;
  // unsigned3 addr_dt_last_seen;
  // qstring8 dod;
  // qstring17 prpty_deed_id;
  // qstring22 vehicle_vehnum;
  // qstring22 bkrupt_crtcode_caseno;
  // integer4 main_count;
  // integer4 search_count;
  // qstring15 dl_number;
  // qstring12 bdid;
  // integer4 run_date;
  // integer4 total_records;
  // unsigned8 rawaid;
  // unsigned3 addr_dt_first_seen;
  // string10 adl_ind;
  // string1 valid_ssn;
  // unsigned8 __filepos{virtual(fileposition)};
 // END;
END;