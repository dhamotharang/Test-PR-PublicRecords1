import header,did_add,didville,ut,header_slimsort,watchdog;

#workunit('name','ReDID SexPreds');

so_in := dataset('~thor_data400::in::so_accurint_searchpublic',SexOffender.Layout_Accurint_SearchFile,thor);

layout_so_did := record
	string16 seisint_primary_key;
	string8 dt_last_reported;
	string2 vendor_code;
	string20 source_file;
	string2 orig_state;
	string50 name_orig;
	string1 name_type;
	string9 ssn;
	string8 dob;
	string8 dob_aka;
	string125 registration_address_1;
	string45 registration_address_2;
	string35 registration_address_3;
	string35 registration_address_4;
	string35 registration_address_5;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 cleaning_score;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 fips_st;
	string3 fips_county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	unsigned6	did;
	unsigned1	did_score;
	string9	ssn_appended;
	unsigned1 restr;
end;

layout_so_did add_fields(so_in l) := transform
	self.did := 0;
	self.did_score := 0;
	self.ssn_appended := '';
	self.restr := 0;
	self := l;
end;

so_for_redid := project(so_in,add_fields(left));

matchset := ['S','D','A','Z'];

did_add.MAC_Match_Flex(so_for_redid,matchset,ssn,dob,fname,mname,lname,name_suffix,
			prim_range,prim_name,sec_range,zip,st,foo,did,layout_so_did,true,did_score,75,outf)
			
did_add.MAC_Add_SSN_By_DID(outf,did,ssn_appended,out2)

SexOffender.Layout_Accurint_SearchFile searchfile_format(out2 l) := transform
	self.did := if(l.did = 0,'',intformat(l.did,12,1));
	self.did_score := intformat(l.did_score,3,1);
	self := l;
end;

sex_pred_redid := project(out2,searchfile_format(left));

output(sex_pred_redid,,'~thor_data400::out::sex_pred_search_redid_' + ut.GetDate);