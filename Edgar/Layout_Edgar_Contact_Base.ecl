export Layout_Edgar_Contact_Base := record
  unsigned6 bdid := 0;
  unsigned6 did := 0;
// Fields from original input record
  string40 firstname;
  string40 middlename;
  string40 lastname;
  string10 prefix;
  string10 suffix;
  string1  gender;
  string1  confidence;
  string40 companyprime;
  string40 companysecond;
  string40 companydiscard;
  string5  age;
  string80 position;
  string80 organization;
  string20 status;
  string20 startdate;
  string20 enddate;
  string40 conformed;
  string20 taxid;
  string40 accession;
// Fields from corresponding Company Record
  string60 companyName := ''; // Conformed Company Name
  string20 cikcode; // SEC CIK code (unique company identifier)
  string20 accNumber := ''; // Document Accession number
  string20 Companytaxid := ''; // Company tax id
  string10 bus_prim_range := '';
  string2  bus_predir := '';
  string28 bus_prim_name := '';
  string4  bus_addr_suffix := '';
  string2  bus_postdir := '';
  string10 bus_unit_desig := '';
  string8  bus_sec_range := '';
  string25 bus_p_city_name := '';
  string25 bus_v_city_name := '';
  string2  bus_st := '';
  string5  bus_zip := '';
  string4  bus_zip4 := '';
  string5  bus_county := '';
  string10 bus_geo_lat := '';
  string11 bus_geo_long := '';
  string4  bus_msa := '';
  string10 bus_phone10 := '';
// Clean name fields
  string5  title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5  name_suffix;
  string3  name_score;
end;