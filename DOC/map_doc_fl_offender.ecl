import Crim_common, Address, Lib_AddrClean, Ut, lib_stringlib;
// Transforms
input := DOC.file_doc_fl(regexfind('[0-9]', dc_number));

String heightToInches(String s) := FUNCTION
cleanheight := regexreplace('[^0-9]', s, '');
height_ft:=(integer)cleanheight[1..1];
height_in:=(integer)cleanheight[2..3];
return (string)(height_ft*12+height_in);
END;

input_new_layout := record, maxlength(7020) 
	string alias; 
	input; 
end;


input_new_layout NormAlias(input L, integer c) := TRANSFORM
	SELF := l;
	SELF.alias := trim(regexreplace(';', (';'+l.aliases)[stringlib.Stringfind(l.aliases,';',c)+1..stringlib.Stringfind(l.aliases,';',c+1)], ''), left, right);
END;

normedINPUT := NORMALIZE(input, stringlib.stringfindcount(left.aliases, ';') ,NormAlias(left, counter));

crim_common.Layout_In_DOC_Offender.previous tFL(normedINPUT l) := transform

self.process_date		:= Crim_Common.Version_In_DOC_Offender; 
self.offender_key		:= 'FL' +  trim(l.DC_Number,left, right) + hash(trim(l.Birth_Date, left, right), trim(L.Name, left, right)); 
self.vendor				:= 'FL';
self.data_type			:= '1';   
self.source_file		:= 'FL-doc';
self.pty_nm				:= if(l.alias = '', trim(L.Name, left, right), l.alias); 
self.pty_nm_fmt			:= if(l.alias = '', 'L', 'F');
self.orig_lname			:= ''; 
self.orig_fname			:= ''; 
self.orig_mname			:= ''; 
self.orig_name_suffix	:= '';
self.pty_typ			:= if(l.alias = '', '0', '2');
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.citizenship		:= '';
self.fbi_num			:= '';
self.doc_num			:= trim(l.DC_Number, left, right);
self.ins_num			:= '';
self.id_num				:= '';
self.dob				:= trim(if(l.Birth_Date >= '19150101' and l.Birth_Date < (string)((integer)Crim_Common.Version_In_DOC_Offender - 160000), l.Birth_Date, ''), left, right);
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= trim(stringlib.stringfilterout(l.Current_Verified_Address[1..stringlib.stringfind(l.Current_Verified_Address, ';', 1)], ',;'), left, right);
self.street_address_2	:= trim(stringlib.stringfilterout(l.Current_Verified_Address[stringlib.stringfind(l.Current_Verified_Address, ';', 1)..stringlib.stringfind(l.Current_Verified_Address, ';', 2)], ',;'), left, right);
self.street_address_3	:= trim(stringlib.stringfilterout(l.Current_Verified_Address[stringlib.stringfind(l.Current_Verified_Address, ';', stringlib.stringfindcount(l.Current_Verified_Address, ';'))..stringlib.stringfind(l.Current_Verified_Address, ',', 1)], ',;'), left, right);
self.street_address_4	:= trim(stringlib.stringfilterout(l.Current_Verified_Address[stringlib.stringfind(l.Current_Verified_Address, ',', 1)..200], ',;'), left, right);
self.street_address_5	:= '';
self.race				:= ''; 
self.race_desc			:= trim(if(regexfind('UNKNOWN', L.race), '', L.race), left, right);
self.sex				:= trim(L.sex, left, right); 
self.hair_color			:= ''; 
self.hair_color_desc	:= trim(if(regexfind('UNKNOWN', L.Hair_Color), '', L.Hair_Color), left, right);
self.eye_color			:= '';
self.eye_color_desc		:= trim(if(regexfind('UNKNOWN', L.Eye_Color), '', L.Eye_Color), left, right);
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= trim(if(heightToInches(L.Height) > '035' and heightToInches(L.Height) < '085', INTFORMAT((integer)heightToInches(L.Height), 3, 1), ''), left, right); 
self.weight				:= trim(if(intformat((integer)l.weight, 3, 1) > '049' and intformat((integer)l.weight, 3, 1) < '400', intformat((integer)l.weight, 3, 1), ''), left, right);
self.party_status		:= '';
self.party_status_desc	:= trim('Information Current as of ' + L.Current_As_Of + ' - ' + if(l.current_status = '', l.search_type, l.current_status), left, right);
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

infile := project(normedINPUT, tFL(left));

DOC_clean(infile,outfile)

history := dataset(ut.foreign_prod+'~thor_data400::in::fl_doc_offender_clean_history',
			crim_common.Layout_In_DOC_Offender.previous, flat)(vendor = 'FL');

crim_common.Layout_In_DOC_Offender.previous dojoin(crim_common.Layout_In_DOC_Offender.previous r) := transform
	self := r;
end;

historyout := join(distribute(outfile, hash(doc_num)), distribute(history, hash(doc_num)), left.doc_num = right.doc_num, dojoin(right), right only, local);

dedFile := dedup(sort(distribute(outfile + historyout, hash(offender_key)), offender_key, lname[1..length(lname)-1], fname, -mname, pty_typ,  dob, -street_address_1, -street_address_2, -street_address_3, -street_address_4, -party_status_desc[26..34], local), offender_key, lname[1..length(lname)-1], fname, dob, local);


export map_doc_fl_offender := dedFile :PERSIST('~thor_data400::persist::doc::map_fl_offender');