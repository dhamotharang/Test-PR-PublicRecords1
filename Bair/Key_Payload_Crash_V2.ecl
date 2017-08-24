import Data_Services;


r := RECORD
  string23 eid;
  string60 case_number;
  string20 reportnumber;
  string25 report_date;
  string100 address;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string4 zip4;
  string20 county;
  string30 crash_city;
  string20 crash_state;
  real8 x;
  real8 y;
  string1 hitandrun;
  string1 intersectionrelated;
  string30 officername;
  string20 crashtype;
  string40 locationtype;
  string50 accidentclass;
  string40 lightcondition;
  string30 weathercondition;
  string40 surfacetype;
  unsigned4 data_provider_id;
  string10 data_provider_ori;
  string70 data_provider_name;
  string specialcircumstance1;
  string specialcircumstance2;
  string specialcircumstance3;
  string roadspecialfeature1;
  string roadspecialfeature2;
  string roadspecialfeature3;
  string surfacecondition;
  string trafficcontrolpresent;
  unsigned8 __internal_fpos__;
END;
 
d:=dataset([],r);
 
 EXPORT Key_Payload_Crash_V2(string v='qa',boolean isDelta = false) := INDEX(d,{eid},{d},	data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::crash::v2::' +if(isDelta, 'delta::', '') +v+'::eid', OPT);

