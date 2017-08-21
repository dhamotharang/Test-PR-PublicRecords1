import header, lib_KeyLib, Lib_ZipLib;
 
h := header.File_EQ_OUT_plus;   // Unix despray version 292 byte layout
 
STRING10 FormatLZ10(STRING str) := 
    MAP((10-LENGTH(TRIM(str))) = 1 => '0' + str,
        (10-LENGTH(TRIM(str))) = 2 => '00' + str,
        (10-LENGTH(TRIM(str))) = 3 => '000' + str,
        (10-LENGTH(TRIM(str))) = 4 => '0000' + str,
        (10-LENGTH(TRIM(str))) = 5 => '00000' + str,
        (10-LENGTH(TRIM(str))) = 6 => '000000' + str,
        (10-LENGTH(TRIM(str))) = 7 => '0000000' + str,
        (10-LENGTH(TRIM(str))) = 8 => '00000000' + str,
        (10-LENGTH(TRIM(str))) = 9 => '000000000' + str,
        '0000000000');
 

MyFields := record     // Fields needed to build all keys 
  h.did;       // This would be "keymaps" section of Unix def file
  h.zip;
  h.prim_name;
  h.prim_range;
  h.city_name;
  h.suffix;
  h.predir;
  h.postdir;
  h.sec_range;
  h.unit_desig;
  h.county;
  h.tnt;
  h.st;
  h.lname;
  h.fname;
  h.mname;
  h.name_suffix;
  h.ssn;
  h.dob;
  h.phone;
  string2 src := h.src + h.src2;
  // string10 prim_ranger := intformat((integer)h.prim_range,10,1);
  string10 prim_ranger := FormatLZ10(h.prim_range);
  h.zip4;
  h.dt_nonglb_last_seen;  
  h.dt_first_seen;    
  h.dt_last_seen;    
  h.dt_vendor_last_reported;    
  h.dt_vendor_first_reported; 
  h.vendor_id;
  h.valid_ssn;
  h.__filepos;
  end;
 
t := table(h,MyFields);
 
ZipCitiesRec2 := record
  t.city_name;
  t.st;
  t.prim_name;
  t.prim_ranger;
  t.prim_range;
  t.predir;
  t.postdir;
  t.suffix;
  t.sec_range;
  t.lname;
  t.fname;
  t.mname;
  t.name_suffix;
  t.zip;
  t.zip4;
  t.src;
  t.phone;
  t.ssn;
  t.dob;
  t.unit_desig;
  t.county;
  t.tnt;
  t.did;
  t.dt_nonglb_last_seen;  
  t.dt_first_seen;    
  t.dt_last_seen;    
  t.dt_vendor_last_reported;    
  t.dt_vendor_first_reported;    
  t.vendor_id;
  t.valid_ssn;
  VARSTRING citylist;
  t.__filepos;
end;
 
// Project to get city list for each zip
ZipCitiesRec2 GetCityList2(t L) := TRANSFORM
 SELF.citylist := ZipLib.ZipToCities(L.zip);
 SELF:= L;
END;
 
ZipCitiesSet2 := PROJECT(t, GetCityList2(LEFT));
 
ZipCityRec2 := RECORD
  t.city_name;
  t.st;
  string13 city_from_zip;
  t.prim_name;
  t.prim_ranger;
  t.prim_range;
  t.predir;
  t.postdir;
  t.suffix;
  t.sec_range;
  t.lname;
  t.fname;
  t.mname;
  t.name_suffix;
  t.zip;
  t.zip4;
  t.src;
  t.phone;
  t.ssn;
  t.dob;
  t.unit_desig;
  t.county;
  t.tnt;
  t.did;
  t.dt_nonglb_last_seen;  
  t.dt_first_seen;    
  t.dt_last_seen;    
  t.dt_vendor_last_reported;    
  t.dt_vendor_first_reported;    
  t.vendor_id;
  t.valid_ssn;
  t.__filepos;
END;
 
ZipCityRec2 NormCityList2(ZipCitiesRec2 L, INTEGER C) := TRANSFORM
 SELF.city_from_zip := IF ( C = 1, l.city_name, Stringlib.StringExtract(L.citylist, C ));
 SELF := L;
END;
 
//ZipCityDist2	:= distribute(ZipCitiesSet2, hash(__filepos));
ZipCityNorm2	:= normalize(ZipCitiesSet2,(INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst2(LEFT, COUNTER));
ZipCitySort2	:= sort(ZipCityNorm2, __filepos,city_from_zip, st, local);
ZipCityDedup2	:= dedup(ZipCitySort2, __filepos,city_from_zip, st, local);
 
city_per := ZipCityDedup2;
 
export moxie_quick_header_keys_Part_8 := BUILDINDEX(City_per,
{st,city_from_zip,prim_name,prim_ranger,predir,postdir,suffix,lname,sec_range,fname,mname,name_suffix,
zip,zip4,did,src,dt_first_seen,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported,
dt_nonglb_last_seen,phone,ssn,dob,unit_desig,county,tnt,vendor_id,valid_ssn,(big_endian unsigned8 )__filepos},
'~thor_data400::key::moxie.eq_header.really_long.key',moxie,overwrite);