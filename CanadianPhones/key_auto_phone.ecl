import doxie, data_services;

layout_auto_phone := record
  string7 p7;
  string3 p3;
  string6 dph_lname;
  string20 pfname;
  string2 st;
  unsigned6 did;
END;

layout_auto_phone proj(file_cwp_with_fdid le) := TRANSFORM
  SELF.p7 := le.phonenumber[4..10];
  SELF.p3 := le.phonenumber[1..3];
  SELF.dph_lname := metaphonelib.DMetaPhone1(le.lastname);
  SELF.pfname := datalib.preferredfirst(le.firstname);
  SELF.st := le.province;
  SELF.did := le.fdid;
END;

p := PROJECT(file_cwp_with_fdid, proj(LEFT));

recs := DEDUP(SORT(p((integer)p7<>0),record),record);
  
export key_auto_phone := INDEX(recs, 
                               {recs}, 
                               data_services.data_location.prefix() + 'thor_data400::key::canadianwp_phone_' + doxie.Version_SuperKey);