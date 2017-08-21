import PromoteSupers, prte2, Address, std, ut;


Layouts.base 	ConvertToBase(Files.infile L) := transform

//Name Cleaning
v_clean_name		:= Address.CleanPerson73_fields(L.exec_full_name); 

//Address Cleanding
prep_addr_line1		:= std.str.cleanspaces(STD.Str.ToUpperCase(L.Address1 +' ' + L.Address2));        
prep_addr_line2		:= Address.Addr2FromComponents(L.city, L.state, L.zip_code);
clean_address			:= Address.CleanAddress182(prep_addr_line1, prep_addr_line2);

self.title									:= v_clean_name.title;
self.fname									:= v_clean_name.fname;
self.mname									:= v_clean_name.mname;
self.lname									:= v_clean_name.lname;
self.prim_range  						:= clean_address[1..10];
self.predir  								:= clean_address[11..12];
self.prim_name  						:= clean_address[13..40];
self.addr_suffix  					:= clean_address[41..44];
self.postdir  							:= clean_address[45..46];
self.unit_desig  						:= clean_address[47..56];
self.sec_range  						:= clean_address[57..64];
self.p_city_name  					:= clean_address[65..89];
self.v_city_name  					:= clean_address[90..114];
self.st											:= clean_address[115..116];
self.zip  									:= clean_address[117..121];
self.zip4  									:= clean_address[122..125];
self.cart  									:= clean_address[126..129];
self.cr_sort_sz  						:= clean_address[130];
self.lot  									:= clean_address[131..134];
self.lot_order  						:= clean_address[135];
self.dbpc  									:= clean_address[136..137];
self.chk_digit  						:= clean_address[138];
self.rec_type  							:= clean_address[139..140];
self.fips_state							:= clean_address[141..142];
self.fips_county						:= clean_address[143..145];
self.geo_lat  							:= clean_address[146..155];
self.geo_long  							:= clean_address[156..166];
self.msa  									:= clean_address[167..170];
self.geo_blk  							:= clean_address[171..177];
self.geo_match  						:= clean_address[178];
self.err_stat  							:= clean_address[179..182];
self.prep_addr_line1				:= prep_addr_line1;
self.prep_addr_line_last		:= prep_addr_line2;
self.clean_phone						:= ut.CleanPhone(L.phone);
self.clean_secondary_phone	:= ut.CleanPhone(L.secondary_phone);
self.exec_full_name					:= std.str.ToUpperCase(L.exec_full_name);
self.industry								:= std.str.ToUpperCase(L.industry);
self.sector									:= std.str.ToUpperCase(L.sector);

//Append ID(s)
self.bdid := prte2.fn_AppendFakeID.bdid(L.brand_name, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip, L.cust_name);
self.did	:= prte2.fn_AppendFakeID.did(v_clean_name.fname, v_clean_name.lname, L.ssn, L.dob, L.cust_name);
self := L;
self := [];

end;
outfile := project(Files.infile(cust_name <> ''), ConvertToBase(left)); 

//** Appending source record ids. 
ut.MAC_Append_Rcid(outfile, source_rec_id, pDataset_append_sric);

PromoteSupers.MAC_SF_BuildProcess(pDataset_append_sric, Constants.base_prefix_name, fileout,,,true);

EXPORT proc_build_base := fileout;


			