import header, header_services,ut,yellowpages,mdr, DriversV2, suppress;

export fn_file_FCRA_header_building(dataset(recordof(header.Layout_Header)) in_hdr0) := 
function

in_hdr1 := (Header.fn_blank_phone(in_hdr0 + Header.file_TUCS_did + Header.File_TN_did) + Header.File_Transunion_did)(src in mdr.sourceTools.set_scoring_FCRA);
in_hdr2 := project(in_hdr1,transform(recordof(in_hdr1)
									,self.name_suffix:=if(left.name_suffix[1..2]='UN','',left.name_suffix)
									,self:=left));
in_hdr  := in_hdr2(rid not in header.fraud_records);
in_base := in_hdr;

full_ShortSuppress := DriversV2.regulatory.applyDriversLicenseSup_DIDVend(in_base);

// Start of code to suppress data based on an MD5 Hash of DID+Address
Suppression_Layout 	:= suppress.Applyregulatory.layout_in; 
header_services.Supplemental_Data.mac_verify('didaddress_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out;

rFullOut_HashDIDAddress := record
 header.layout_header;
 rHashDIDAddress;
end;

rFullOut_HashDIDAddress tHashDIDAddress(header.Layout_Header l) := transform                            
 self.hval := hashmd5(intformat(l.did,15,1),(string)l.st,(string)l.zip,(string)l.city_name,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.suffix,(string)l.postdir,(string)l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(full_ShortSuppress, tHashDIDAddress(left));

header.layout_header tSuppress(dHeader_withMD5 l, dSuppressedIn r) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
                          left.hval=right.hval,
						  tSuppress(left,right),
						  left only,lookup);

fix_addr_suffix    := header.fn_addr_suffix_corrections(full_out_suppress);
remove_old_records := header.fn_remove_old_records(fix_addr_suffix);
fix_dobs           := header.fn_patch_dob(remove_old_records);
fix_name_suffix    := header.fn_name_suffix_corrections(fix_dobs)(fname<>'',lname<>'');

fn_cleanup(string pIn) := function
 pOut1 := trim(regexreplace('[!$^*<>?]',pIn,' '),left,right);
 pOut  := trim(stringlib.stringfindreplace(pOut1,'\'',''),left,right);
 return pOut;
end;

fix_sec_range := project(fix_name_suffix, transform({fix_name_suffix}, self.sec_range := fn_cleanup(left.sec_range), self := left;));


Base_File_Append := header.prep_build.Prep_FCRA_Header(doxie_build.header_blocked_data(fix_sec_range));

//correct phone areacode
ut.mac_phone_areacode_corrections(Base_File_Append, correct_phone_areacode, phone)
return Header.fn_blank_bogus_ssn(correct_phone_areacode);

end;