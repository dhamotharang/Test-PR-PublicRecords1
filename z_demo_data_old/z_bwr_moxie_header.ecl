import header,mdr,address,ut,header_services;

// Moxie Keys built on demo thor and DKC'ed automatically

ds := dataset('~thor_data400::base::header',header.Layout_Header,thor);

addr2 := ds(not mdr.Source_is_DPPA(src));
header.MAC_Best_Address(addr2, did, 4, b);
header.mac_despray(ds, b, full_out);


rFullOut := record // Referenced string_rec layout in header.MAC_Despray
 string12 did;
 string12 rid;
 string1  src;
 string1 src2;
 string6  dt_first_seen;
 string6  dt_last_seen;
 string6  dt_vendor_last_reported;
 string6  dt_vendor_first_reported;
 string6  dt_nonglb_last_seen;
 string1  rec_type;
 string18 vendor_id;
 string10 phone;
 string9  ssn;
 string8  dob;
 string5  title;
 string20 fname;
 string20 mname;
 string20 lname;
 string5  name_suffix;
 string10 prim_range;
 string2  predir;
 string28 prim_name;
 string4  suffix;
 string2  postdir;
 string10 unit_desig;
 string8  sec_range;
 string25 city_name;
 string2  st;
 string5  zip;
 string4  zip4;
 string3  county;
 string4  msa;
 string1  tnt;  
 string1  valid_ssn;
end;



rFullOut tSuppress(full_out l) := transform
 self.src2 := l.src[2];
 self := l;
end;

full_out_suppress := project(full_out,tsuppress(left));
full_out_per := full_out_suppress;

export bwr_moxie_header := sequential(
															output(full_out_per,,'~thor_data400::OUT::Header',overwrite),
															Header.MOXIE_Header_Keys_Part_1,
															Header.MOXIE_Header_Keys_Part_10,
															Header.MOXIE_Header_Keys_Part_2,
															Header.MOXIE_Header_Keys_Part_3,
Header.MOXIE_Header_Keys_Part_4,
Header.MOXIE_Header_Keys_Part_5,
Header.MOXIE_Header_Keys_Part_7,
Header.MOXIE_Header_Keys_Part_8,
Header.MOXIE_Header_Keys_Part_9,
Header.DKC_Header_Keys_01,
Header.DKC_Header_Keys_02,
Header.DKC_Header_Keys_03,
Header.DKC_Header_Keys_04,
Header.DKC_Header_Keys_05,
Header.DKC_Header_Keys_07,
Header.DKC_Header_Keys_08,
Header.DKC_Header_Keys_09,
Header.DKC_Header_Keys_10

															
															);