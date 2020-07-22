import mdr, ut,address,doxie_build, lib_fileservices, header_services;
#workunit('name', 'Header Despray Prep');

//************************************************************************
//ADD INFORMATION - CNG 20070426 - 400way W20070426-112643
//************************************************************************

Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
  string15  did;
  string15  rid;
  string1   pflag1;
  string1   pflag2;
  string1   pflag3;
  string2   src;
  string8   dt_first_seen;
  string8   dt_last_seen;
  string8   dt_vendor_last_reported;
  string8   dt_vendor_first_reported;
  string8   dt_nonglb_last_seen;
  string1   rec_type;
  string18  vendor_id;
  string10  phone;
  string9   ssn;
  string10  dob;
  string5   title;
  string20  fname;
  string20  mname;
  string20  lname;
  string5   name_suffix;
  string10  prim_range;
  string2   predir;
  string28  prim_name;
  string4   suffix;
  string2   postdir;
  string10  unit_desig;
  string8   sec_range;
  string25  city_name;
  string2   st;
  string5   zip;
  string4   zip4;
  string3   county;
  string7   geo_blk;
  string5   cbsa;
  string1   tnt;
  string1   valid_SSN;
  string1   jflag1;
  string1   jflag2;
  string1   jflag3;
  string2   eor;
end;

header_services.Supplemental_Data.mac_verify('file_headers_inj.txt', Drop_Header_Layout, attr);

Base_File_Append_In := attr();
 
header.Layout_Header reformat_header(Base_File_Append_In L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
    // FileName_Loc;
            self.did := (unsigned6) L.did;
            self.rid := (unsigned6) L.rid;
            self.dt_first_seen := (unsigned3) L.dt_first_seen;
            self.dt_last_seen := (unsigned3) L.dt_last_seen;
            self.dt_vendor_last_reported := (unsigned3) L.dt_vendor_last_reported;
            self.dt_vendor_first_reported := (unsigned3) L.dt_vendor_first_reported;
            self.dt_nonglb_last_seen := (unsigned3) L.dt_nonglb_last_seen;
			self.title := trim(L.title, left, right);
			self.fname := trim(L.fname, left, right);
			self.mname := trim(L.mname, left, right);
			self.lname := trim(L.lname, left, right);
			self.name_suffix := trim(L.name_suffix, left, right);
			self.vendor_id := trim(l.vendor_id,left,right);
			self.phone := trim(l.phone,left,right);
			self.ssn := trim(l.ssn,left,right);
			self.prim_range := trim(l.prim_range,left,right);
			self.predir := trim(l.predir,left,right);
			self.prim_name := trim(l.prim_name,left,right);
			self.suffix := trim(l.suffix,left,right);
			self.postdir := trim(l.postdir,left,right);
			self.unit_desig := trim(l.unit_desig,left,right);
			self.sec_range := trim(l.sec_range,left,right);
			self.city_name := trim(l.city_name,left,right);
			self.st := trim(l.st,left,right);
			self.zip := trim(l.zip,left,right);
			self.zip4 := trim(l.zip4,left,right);
			self.county := trim(l.county,left,right);
            self.dob := (integer4) L.dob;
    self := L;
 end;
 
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

//***********END*************************************************************
// Filter out TS,CY 
h_last_rollup := dataset('~thor_data400::base::header',header.layout_header,flat);
last_rollup_without_TS_CY := h_last_rollup(src not in mdr.sourceTools.filter_from_moxie); 

ut.mac_suppress_by_phonetype(last_rollup_without_TS_CY,phone,st,suppress_wa_cellphones,true,did);

// Blank bogus ssn's 
dsblank_ssn :=  Header.fn_blank_bogus_ssn(suppress_wa_cellphones); 

mini_in  := dataset('headerbuild_regression_new_smpl', header.layout_header, flat);
full_in0 := doxie_build.header_blocked_data(dsblank_ssn) + Base_File_Append + doxie_build.header_blocked_data(header.transunion_did);
full_in1 := header.fn_addr_suffix_corrections(full_in0);
full_in2 := header.fn_remove_old_records(full_in1);
full_in3 := header.fn_patch_dob(full_in2);
full_in4 := header.fn_name_suffix_corrections(full_in3);
full_in5 := full_in4(rid not in header.fraud_records);
ut.mac_phone_areacode_corrections(full_in5,full_in,phone)

addr1 := full_in(header.isPreGLB(full_in));
addr2 := addr1(not mdr.Source_is_DPPA(src));
MAC_Best_Address(addr2, did, 4, b)

//****** Put full and mini file to despray format

header.mac_despray(mini_in, b, mini_out)
header.mac_despray(full_in, b, full_out)


outname := Header.Filename_Out;

rFullOut := record // Referenced string_rec layout in header.MAC_Despray
 string12 did;
 string12 rid;
 string2  src;
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
full_out_r := project(full_out, rFullOut);
full_out_suppress := Header.Prep_Build.applyDidAddressSup2(full_out_r);

rFullOut_HashDIDAddress := record
 rFullOut;
 rHashDIDAddress;
end;

rFullOut_HashDIDAddress tHashDIDAddress(full_out l) := transform                            
 self.hval := hashmd5(l.did,l.st,l.zip,l.city_name,l.prim_name,l.prim_range,l.predir,l.suffix,l.postdir,l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(full_out, tHashDIDAddress(left));

rFullOut tSuppress(dHeader_withMD5 l, dSuppressedIn r) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
                          left.hval=right.hval,
						  tSuppress(left,right),
						  left only,lookup);
						  			  
// End of code to suppress data based on an MD5 Hash of DID+Address

mini_out_per := mini_out;
full_out_per := full_out_suppress;

despray_mini := output(mini_out_per,,outname + '_mini', overwrite);
despray_full := output(full_out_per,,outname, overwrite,__compressed__);

export Proc_Int_To_String_For_Despray := 
parallel(
despray_mini, 
despray_full);