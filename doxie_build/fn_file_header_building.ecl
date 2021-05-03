import doxie_build, header, header_services,ut, yellowpages, AID, suppress, DriversV2, mdr;

export fn_file_header_building(dataset(recordof(header.Layout_Header)) in_hdr0) := 
function

in_hdr1 := Header.fn_blank_phone(in_hdr0 + Header.file_TUCS_did + Header.File_TN_did) + Header.File_Transunion_did;

not_from_raw := in_hdr1(  src in ['TS','TU','LT'] );
yes_from_raw := in_hdr1(~(src in ['TS','TU','LT']));

header.macGetCleanAddr(not_from_raw, RawAID, true, not_from_raw_recleaned_);

fn_cleanup(string pIn) := function
 pOut1 := trim(regexreplace('[!$^*<>?]',pIn,' '),left,right);
 pOut  := trim(stringlib.stringfindreplace(pOut1,'\'',''),left,right);
 return pOut;
end;

not_from_raw_recleaned := project(not_from_raw_recleaned_, transform({not_from_raw_recleaned_}, self.sec_range	:= fn_cleanup(left.sec_range), self := left;));

not_from_raw_recleaned_TS     := not_from_raw_recleaned(src = 'TS');
not_from_raw_recleaned_not_TS := not_from_raw_recleaned(src <> 'TS');

//rollup to remove duplicate TS records after address cleaning
Header.Mac_dedup_header(not_from_raw_recleaned_TS, not_from_raw_recleaned_uniq_TS, '_TS');

in_hdr2 := yes_from_raw + not_from_raw_recleaned_uniq_TS + not_from_raw_recleaned_not_TS;

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

dSuppressedIn_tmp := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

header.layout_header tSuppress(full_ShortSuppress l) := transform
 self := l;
end;
// dSuppressedIn substituted below with full_LongSuppress

full_out_suppress := join(full_ShortSuppress, dSuppressedIn_tmp,
                          left.hval_address=right.hval,
													tSuppress(left),
													left only,lookup);
												
fix_addr_suffix    := header.fn_addr_suffix_corrections(full_out_suppress);
remove_old_records := header.fn_remove_old_records(fix_addr_suffix);
fix_dobs           := header.fn_patch_dob(remove_old_records);
fix_name_suffix    := header.fn_name_suffix_corrections(fix_dobs)(fname<>'',lname<>'');
													
rid_base :=  Header.Prep_Build.applyRidRecSup(fix_name_suffix);						  	
						  
base_file_inj := 	rid_base ;					   

prepped := header.prep_build.prep_header(doxie_build.header_blocked_data(base_file_inj)) ;

//correct phone areacode
ut.mac_phone_areacode_corrections(prepped, correct_phone_areacode,phone)
return Header.fn_blank_bogus_ssn(correct_phone_areacode);

end ;