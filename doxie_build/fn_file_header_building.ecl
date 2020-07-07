import doxie_build, header, header_services,ut, yellowpages, AID, suppress, DriversV2;

export fn_file_header_building(dataset(recordof(header.Layout_Header)) in_hdr0) := 
function

in_hdr1 := Header.fn_blank_phone(in_hdr0 + Header.file_TUCS_did + Header.File_TN_did) + Header.File_Transunion_did;

not_from_raw := in_hdr1(  src in ['TS','TU','LT'] );
yes_from_raw := in_hdr1(~(src in ['TS','TU','LT']));

header.macGetCleanAddr(not_from_raw, RawAID, true, not_from_raw_recleaned);

in_hdr2 := yes_from_raw + not_from_raw_recleaned;

in_hdr3 := project(in_hdr2,transform(recordof(in_hdr2)
									,self.name_suffix:=if(left.name_suffix[1..2]='UN','',left.name_suffix)
									,self.prim_name:=map(
																			 left.prim_name='WARRINGT0N' => 'WARRINGTON'
																			,left.prim_name
																			)
									,self:=left));
in_hdr  := in_hdr3(rid not in header.fraud_records);
in_base_ := in_hdr;

layout_hashed := {
							// data16 hval_id_1;
							data16 hval_id_2 ;
							data16 hval_address ;
							header.Layout_Header ;							
						} ;
					
layout_hashed xTohash(header.Layout_Header L) := transform
     // self.hval_id_1 := HASHMD5(	intformat((unsigned6)l.did,15,1),TRIM((string14)l.vendor_id, left, right));     
     self.hval_id_2 := HASHMD5(	intformat((unsigned6)l.did,15,1),TRIM((string14)l.vendor_id, left, right),intformat((unsigned4)l.dob,8,1),Trim((string9)l.ssn));      
		 self.hval_address := hashmd5(intformat(l.did,15,1),(string)l.st,(string)l.zip,(string)l.city_name,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.suffix,(string)l.postdir,(string)l.sec_range);
		 self := L ;
end ;

in_base := project (in_base_, xTohash(left)) ;

full_ShortSuppress := DriversV2.regulatory.applyDriversLicenseSup_DIDVend(in_base);

// Start of code to suppress data based on an MD5 Hash of DID+Address
Suppression_Layout 	:= suppress.Applyregulatory.layout_in; 

header_services.Supplemental_Data.mac_verify('didaddress_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

header.layout_header tSuppress(full_ShortSuppress l) := transform
 self := l;
end;
// dSuppressedIn substituted below with full_LongSuppress

full_out_suppress := join(full_ShortSuppress, dSuppressedIn,
                          left.hval_address=right.hval,
													tSuppress(left),
													left only,lookup);
												
fix_addr_suffix    := header.fn_addr_suffix_corrections(full_out_suppress);
remove_old_records := header.fn_remove_old_records(fix_addr_suffix);
fix_dobs           := header.fn_patch_dob(remove_old_records);
fix_name_suffix    := header.fn_name_suffix_corrections(fix_dobs)(fname<>'',lname<>'');
													
/////////////////////////////////////////////////////////////////////////////

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
	string20  RawAID;
  string1   eor; 
end;

header_services.Supplemental_Data.mac_verify('file_headersv2_inj.txt',Drop_Header_Layout,attr); // V2 added - KLM
 
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
			self.RawAID := (unsigned8) L.RawAID;			
    self := L;
 end;
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

layout_ff := Record
     data16 hval_did ;
     data16 hval_ssn ;
		 string1 nl := '\n' ;
END ;

header_services.Supplemental_Data.mac_verify('ff_sup.txt',layout_ff, ff_sup_attr); // 
 
Base_ff_sup := ff_sup_attr();


ff_base := JOIN(fix_name_suffix, Base_ff_sup,
                    hashmd5((string9)left.ssn) = right.hval_ssn 
                    AND
						  hashmd5(intformat(left.did,15,1)) != right.hval_did,
						  TRANSFORM(LEFT),
						  LEFT ONLY, ALL) ;

///

header_services.Supplemental_Data.mac_verify('ridrec_sup.txt',Suppression_Layout, base_sup_attr); // 
 
Base_rid_sup_in := base_sup_attr() ;

base_rid_sup := PROJECT(Base_rid_sup_in ,header_services.Supplemental_Data.in_to_out(left));

rid_base := JOIN(ff_base, base_rid_sup,
                 hashmd5(intformat((unsigned6)left.rid,15,1)) = right.hval,                    
						     TRANSFORM(LEFT),
						    LEFT ONLY, ALL) ;
						  
base_file_inj := 	rid_base ;					   

//***********END*************************************************************


concat := doxie_build.header_blocked_data(base_file_inj) + Base_File_Append ;

//correct phone areacode
ut.mac_phone_areacode_corrections(concat, correct_phone_areacode,phone)
return Header.fn_blank_bogus_ssn(correct_phone_areacode);

end ;