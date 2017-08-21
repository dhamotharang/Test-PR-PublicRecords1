import Address, prte2, std, PromoteSupers, ut;

//Convert Incoming File to Base Layout
layouts.base 		ConvertToBase(files.incoming L) := transform

//Name Cleaning
v_clean_name		:= Address.CleanPerson73_fields(STD.Str.CleanSpaces(L.spons_signed_name)); 

//Address Cleanding
// For now, we just want the sponsored company and sponsor signer name info
prep_addr_line1		:= Address.Addr1FromComponents(STD.Str.CleanSpaces(L.spons_dfe_mail_str_address),'','',''	,'','','');
prep_addr_line2		:= Address.Addr2FromComponents(L.spons_dfe_city, L.spons_dfe_state, L.spons_dfe_zip_code);
clean_address			:= Address.CleanAddress182(prep_addr_line1, prep_addr_line2);

self.admin_signed_name			:= STD.Str.ToUpperCase(L.admin_signed_name);
self.spons_signed_name			:= STD.Str.ToUpperCase(L.spons_signed_name);
self.spons_sign_title				:= v_clean_name.title;
self.spons_sign_fname				:= v_clean_name.fname;
self.spons_sign_mname				:= v_clean_name.mname;
self.spons_sign_lname				:= v_clean_name.lname;
self.spons_sign_suffix			:= v_clean_name.name_suffix;
self.spons_sign_name_score 	:= (UNSIGNED1)v_clean_name.name_score;
self.spons_prim_range  	:=  clean_address[1..10];
self.spons_predir  			:=  clean_address[11..12];
self.spons_prim_name  	:=  clean_address[13..40];
self.spons_addr_suffix  :=  clean_address[41..44];
self.spons_postdir  		:=  clean_address[45..46];
self.spons_unit_desig  	:=  clean_address[47..56];
self.spons_sec_range  	:=  clean_address[57..64];
self.spons_p_city_name  :=  clean_address[65..89];
self.spons_v_city_name  :=  clean_address[90..114];
self.spons_st						:=  clean_address[115..116];
self.spons_zip5  				:=  clean_address[117..121];
self.spons_zip4  				:=  clean_address[122..125];
self.spons_cart  				:=  clean_address[126..129];
self.spons_cr_sort_sz  	:=  clean_address[130];
self.spons_lot  				:=  clean_address[131..134];
self.spons_lot_order  	:=  clean_address[135];
self.spons_dpbc  				:=  clean_address[136..137];
self.spons_chk_digit  	:=  clean_address[138];
self.spons_rec_type  		:=  clean_address[139..140];
self.spons_county  			:=  clean_address[141..145];
self.spons_geo_lat  		:=  clean_address[146..155];
self.spons_geo_long  		:=  clean_address[156..166];
self.spons_msa  				:=  clean_address[167..170];
self.spons_geo_blk  		:=  clean_address[171..177];
self.spons_geo_match  	:=  clean_address[178];
self.spons_err_stat  		:=  clean_address[179..182];

//Appending DID/BDID
self.did		:= 0;  	
self.bdid		:= prte2.fn_AppendFakeID.bdid(L.sponsor_dfe_name, self.spons_prim_range, self.spons_prim_name, self.spons_v_city_name, self.spons_st, self.spons_zip5, L.customer_name);
self := L;
self := [];
end;
outfile := project(Files.incoming(form_id<>''), ConvertToBase(left)); 

//Appending source_rec_id									
ut.MAC_Append_Rcid(outfile,Source_rec_id,newfile);
									
//Populate LinkID fields

PromoteSupers.MAC_SF_BuildProcess(newfile, Constants.base_prefix_name, bld_base,,,true);

EXPORT proc_build_base := bld_base;
