// Output(Seed_Files.RiskViewReport_keys.businessassociation);

#CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
key_in := Seed_Files.RiskViewReport_keys.businessassociation;

layout_out := RECORD
  string20 dataset_name;
  data16 hashvalue;
  string30 acctno;
  string15 fname;
  string20 lname;
  string9 zip;
  string9 in_ssn;
  string10 hphone;
  string2 seq;
  string62 full{xpath('Full')};
  string20 first{xpath('First')};
  string20 middle{xpath('Middle')};
  string20 last{xpath('Last')};
  string5 suffix{xpath('Suffix')};
  string3 prefix{xpath('Prefix')};
  string10 streetnumber{xpath('StreetNumber')};
  string2 streetpredirection{xpath('StreetPreDirection')};
  string28 streetname{xpath('StreetName')};
  string4 streetsuffix{xpath('StreetSuffix')};
  string2 streetpostdirection{xpath('StreetPostDirection')};
  string10 unitdesignation{xpath('UnitDesignation')};
  string8 unitnumber{xpath('UnitNumber')};
  string60 streetaddress1{xpath('StreetAddress1')};
  string60 streetaddress2{xpath('StreetAddress2')};
  string25 city{xpath('City')};
  string2 state{xpath('State')};
  string5 zip5{xpath('Zip5')};
  string4 zip4{xpath('Zip4')};
  string18 county{xpath('County')};
  string9 postalcode{xpath('PostalCode')};
  string50 statecityzip{xpath('StateCityZip')};
  string35 title;
  string120 company;
  string10 company_streetnumber;
  string2 company_streetpredirection;
  string28 company_streetname;
  string4 company_streetsuffix;
  string2 company_streetpostdirection;
  string10 company_unitdesignation;
  string8 company_unitnumber;
  string60 company_streetaddress1;
  string60 company_streetaddress2;
  string25 company_city;
  string2 company_state;
  string5 company_zip5;
  string4 company_zip4;
  string18 company_county;
  string9 company_postalcode;
  string50 company_statecityzip;
  string10 status;
  string4 firstreport_year;
  string2 firstreport_month;
  string2 firstreport_day;
  string4 lastreport_year;
  string2 lastreport_month;
  string2 lastreport_day;
  unsigned8 __internal_fpos__;
 END;


 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Seed_Files_RiskViewReport_keys_businessassociation := project(key_in,makelayout(left));