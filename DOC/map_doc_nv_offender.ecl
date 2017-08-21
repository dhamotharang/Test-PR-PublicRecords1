import Crim_common, Address, Ut, lib_stringlib;
// Transforms
input := DOC.file_doc_nv.cmbndFiles;

crim_common.Layout_In_DOC_Offender.previous tNV(input l) := transform

self.process_date		:= Crim_Common.Version_In_DOC_Offender; 
self.offender_key		:= 'NV' +  l.offender_id; 
self.vendor				:= 'NV';
self.data_type			:= '1';   
self.source_file		:= 'NV-DOC';
self.pty_nm				:= if(l.alias_last_name = '', trim(l.last_name, left, right) + ' ' + 
											trim(l.first_name, left, right) + ' ' + 
											trim(l.middle_name, left, right),trim(l.alias_last_name, left, right) + ' ' + 
																			 trim(l.alias_first_name, left, right) + ' ' +
																			 trim(stringlib.stringfilterout(l.alias_middle_name,'\r'), left, right));

self.pty_nm_fmt			:= 'L';
self.orig_lname			:= trim(l.last_name, left, right); 
self.orig_fname			:= trim(l.first_name, left, right); 
self.orig_mname			:= trim(l.middle_name, left, right); 
self.orig_name_suffix	:= '';
self.pty_typ			:= if(l.alias_last_name = '', '0', '2');
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.citizenship		:= '';
self.fbi_num			:= '';
self.doc_num			:= l.offender_id, 
self.ins_num			:= '';
self.id_num				:= '';
self.dob				:= stringlib.stringfilter(l.birth_date,'0123456789');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= ''; 
self.race_desc			:= stringlib.stringfilterout(l.ethnic,'\r');
self.sex				:= trim(L.gender, left, right); 
self.hair_color			:= ''; 
self.hair_color_desc	:= l.hair;
self.eye_color			:= '';
self.eye_color_desc		:= l.eyes;
self.skin_color			:= '';
self.skin_color_desc	:= l.complexion;
self.height				:= (string)((unsigned)l.height_feet*12 + (unsigned)l.height_inches);
self.weight				:= l.weight_pounds;
self.party_status		:= '';
self.party_status_desc	:= '';
self.prim_range 		:= ''; 
self.predir 			:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 			:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 				:= '';
self.zip5 				:= '';
self.zip4 				:= '';
self.cart 				:= '';
self.cr_sort_sz 		:= '';
self.lot 				:= '';
self.lot_order 			:= '';
self.dpbc 				:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county	:= '';
self.geo_lat 			:= '';
self.geo_long 			:= '';
self.msa 				:= '';
self.geo_blk 			:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title				:= '';
self.fname				:= '';
self.mname				:= '';
self.lname				:= '';
self.name_suffix		:= '';
self.cleaning_score		:= '';

end;

infile := project(input, tNV(left));

DOC_clean(infile,outfile)



ddFile := dedup(sort(distribute(outfile, hash(offender_key))
							,offender_key, pty_nm,pty_typ,local)
							,offender_key, pty_nm,pty_typ,local);


export map_doc_NV_offender := ddFile :PERSIST('~thor_data400::persist::doc::map_NV_offender');