raw_rec := record
 string40 orig_first_name;
 string40 orig_last_name;
 string60 orig_company;
 string50 orig_street;
 string25 orig_city;
 string2  orig_st;
 string9  orig_zip;
 string10 orig_phone;
 string8  record_date;
 string10 type_of_business;
 string20 orig_county;
 string6  refile;
 string4  sic;
 string8  process_date;
 //string1  lf;
end;

ds_raw_in := dataset('~thor_200::in::20070206::stratum::evaluation',raw_rec,csv(separator(['\t']),terminator(['\r\n'])));
//output(count(ds_raw_in),named('raw_record_ct'));
ds_raw := dedup(ds_raw_in,all);
//output(count(ds_raw),named('unique_record_ct'));

clean_rec := record
 raw_rec;
 address.Layout_Clean_Name;
 address.Layout_Clean182;
 unsigned6 did        :=0;
 integer   did_score  :=0;
 unsigned6 bdid       :=0;
 integer   bdid_score :=0;
end;

clean_rec t_clean(ds_raw l) := transform
 
 string73 v_pname := if(l.orig_first_name<>'' and l.orig_last_name<>'',addrcleanlib.cleanpersonlfm73(trim(l.orig_last_name)+', '+trim(l.orig_first_name)),'');
 string182 v_ca   := addrcleanlib.cleanaddress182(l.orig_street,stringlib.stringcleanspaces(l.orig_city+l.orig_st+l.orig_zip));
 
 self.title       := v_pname[ 1.. 5];
 self.fname       := v_pname[ 6..25];
 self.mname       := v_pname[26..45];
 self.lname       := v_pname[46..65];
 self.name_suffix := v_pname[66..70];
 self.name_score  := v_pname[71..73];

 self.prim_range 	  :=	v_ca[1..10];
 self.predir 		  :=	v_ca[11..12];
 self.prim_name 	  :=	v_ca[13..40];
 self.addr_suffix	  :=	v_ca[41..44];
 self.postdir 		  :=	v_ca[45..46];
 self.unit_desig 	  :=	v_ca[47..56];
 self.sec_range 	  :=	v_ca[57..64];
 self.p_city_name 	  :=	v_ca[65..89];
 self.v_city_name 	  :=	v_ca[90..114];
 self.st 			  :=	v_ca[115..116];
 self.zip  			  :=	v_ca[117..121];
 self.zip4 			  :=	v_ca[122..125];
 self.cart 			  :=	v_ca[126..129];
 self.cr_sort_sz 	  :=	v_ca[130];
 self.lot 			  :=	v_ca[131..134];
 self.lot_order 	  :=	v_ca[135];
 self.dbpc 			  :=	v_ca[136..137];
 self.chk_digit 	  :=	v_ca[138];
 self.rec_type		  :=	v_ca[139..140];
 //self.ace_fips_st 	:=	v_ca[141..142];
 //self.ace_fips_county :=	v_ca[143..145];
 self.county          :=    v_ca[141..145];
 self.geo_lat 		  :=	v_ca[146..155];
 self.geo_long 		  :=	v_ca[156..166];
 self.msa 			  :=	v_ca[167..170];
 self.geo_blk 		  :=	v_ca[171..177];
 self.geo_match 	  :=	v_ca[178];
 self.err_stat 		  :=	v_ca[179..182];

 self := l;
end;

p_clean := project(ds_raw,t_clean(left)) : persist('~thor_200::persist::stratum_p1');

did_match_set 	:= ['A','P','Z'];
bdid_match_set 	:= ['A','P'];

did_Add.MAC_Match_Flex
	(p_clean, did_match_set,
	 '', '', fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, orig_phone, 
	 did,
	 clean_rec, 
	 true, did_score,		//these should default to zero in definition
	 75,
	 p_clean_did);		//try the dedup DIDing

business_header_ss.MAC_Match_Flex(p_clean_did,bdid_match_set,
								  orig_company,
								  prim_range, prim_name, zip,
								  sec_range, st,
								  orig_phone,'',
								  bdid,
								  clean_rec,
								  false,bdid_score,
								  p_clean_did_bdid
								 );

//output(p_clean_did_bdid,,'~thor_200::out::20070206::stratum_did_bdid',__compressed__,overwrite);

ds_out := dataset('~thor_200::out::20070206::stratum_did_bdid',clean_rec,flat);

output(count(ds_out),named('total_recs'));

has_did := ds_out(did<>0);
output(count(has_did),named('total_dids'));

unique_dids := dedup(has_did,did,all);
output(count(unique_dids),named('unique_dids'));


has_bdid := ds_out(bdid<>0);
output(count(has_bdid),named('total_bdids'));

unique_bdids := dedup(has_bdid,bdid,all);
output(count(unique_bdids),named('unique_bdids'));

//export stratum_did_bdid := 'todo';