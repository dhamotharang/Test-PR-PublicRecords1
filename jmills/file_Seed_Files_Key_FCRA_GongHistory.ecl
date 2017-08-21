// Output(Seed_Files.Key_FCRA_GongHistory);

// #CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
// key_in := ln_propertyv2.key_ownership.did(true);

layout_key_out := RECORD
  string20 dataset_name;
  data16 hashvalue;
  string30 acctno;
  string15 fname;
  string20 lname;
  string9 zip;
  string9 ssn;
  string10 hphone;
  string30 account_number;
  // layout_fcragongslim gong;
	 string adl;
   string hhid;
   string20 name_first;
   string20 name_middle;
   string20 name_last;
   string65 address;
   string25 p_city_name;
   string2 st;
   string5 z5;
   string4 z4;
   string10 phone10;
   string1 omit_address;
   string1 omit_phone;
   string1 omit_locality;
   string1 listing_type_bus;
   string1 listing_type_res;
   string1 listing_type_gov;
   string1 publish_code;
   string8 dt_first_seen;
   string8 dt_last_seen;
   unsigned8 __internal_fpos__;
 END;

 key_in := Seed_Files.Key_FCRA_GongHistory;

// transform statement
layout_key_out makerecord (key_in L) := transform

self.dataset_name := L.dataset_name;
self.hashvalue := L.hashvalue;
self.acctno := L.acctno;
self.fname := L.fname;
self.lname := L.lname;
self.zip := L.zip;
self.ssn := L.ssn;
self.hphone := L.hphone;
self.account_number := L.account_number;
//	layout_fcragongslim	gong;
self.adl := 'adl';
self.hhid := 'hhid';
self.name_first := 'name_first';
self.name_middle := 'name_middle';
self.name_last := 'name_last';
self.address := 'address';
self.p_city_name := 'p_city_name';
self.st := 'st';
self.z5 := 'z5';
self.z4 := 'z4';
self.phone10 := 'phone10';
self.omit_address := 'omit_address';
self.omit_phone := 'omit_phone';
self.omit_locality := 'omit_locality';
self.listing_type_bus := 'listing_type_bus';
self.listing_type_res := 'listing_type_res';
self.listing_type_gov := 'listing_type_gov';
self.publish_code := 'publish_code';
self.dt_first_seen := 'dt_first_seen';
self.dt_last_seen := 'dt_last_seen';
self.__internal_fpos__ := L.__internal_fpos__;
END;

EXPORT file_Seed_Files_Key_FCRA_GongHistory := project(key_in,makerecord(left));
