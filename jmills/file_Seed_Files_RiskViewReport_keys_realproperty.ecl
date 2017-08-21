// Output(Seed_Files.RiskViewReport_keys.realproperty);

#CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
key_in := Seed_Files.RiskViewReport_keys.realproperty;

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
  string16 status;
  string4 purch_year;
  string2 purch_month;
  string2 purch_day;
  string8 purchaseprice;
  string4 sale_year;
  string2 sale_month;
  string2 sale_day;
  string8 saleprice;
  string8 assessedvalue;
  string4 as_year;
  string2 as_month;
  string2 as_day;
  unsigned8 __internal_fpos__;
 END;

 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Seed_Files_RiskViewReport_keys_realproperty := project(key_in,makelayout(left));