export MAC_HIST_FULL_SLIM_DEP(in_file, out_file, usepid = false) := macro

#uniquename(in_slim_rec)
%in_slim_rec% := record
//      in_file.bell_id;
//      in_file.filedate;
//      in_file.dual_name_flag;
//      in_file.sequence_number;
      in_file.listing_type_bus;
      in_file.listing_type_res;
      in_file.listing_type_gov;
      in_file.publish_code;
//      in_file.style_code;
//      in_file.indent_code;
//      in_file.book_neighborhood_code;
      in_file.prior_area_code;
      in_file.phone10; 
      in_file.prim_range;
      in_file.predir;
      in_file.prim_name;
      in_file.suffix;
      in_file.postdir;
      in_file.unit_desig;
      in_file.sec_range;
      in_file.p_city_name;
      in_file.v_predir;
      in_file.v_prim_name;
      in_file.v_suffix;
      in_file.v_postdir;
      in_file.v_city_name;
      in_file.st;
      in_file.z5;
      in_file.z4;
//      in_file.cart;
//      in_file.cr_sort_sz;
//      in_file.lot;
//      in_file.lot_order;
//      in_file.dpbc;
//      in_file.chk_digit;
//      in_file.rec_type;
      in_file.county_code;
      in_file.geo_lat;
      in_file.geo_long;
      in_file.msa;
//      in_file.geo_blk;
//      in_file.geo_match;
//      in_file.err_stat;
      in_file.designation;
      in_file.name_prefix;
      in_file.name_first;
      in_file.name_middle;
      in_file.name_last;
      in_file.name_suffix;
      in_file.listed_name;
      in_file.caption_text;
//      in_file.group_id;	
//      in_file.group_seq;		
  	 in_file.omit_address;
	 in_file.omit_phone;
	 in_file.omit_locality;
      in_file.see_also_text;	
	 in_file.did;
      in_file.hhid;
      in_file.bdid;
      in_file.dt_first_seen;
      in_file.dt_last_seen;
      in_file.current_record_flag;  
      in_file.deletion_date;
      in_file.disc_cnt6;
      in_file.disc_cnt12;
      in_file.disc_cnt18;
#if(usepid=true)
			in_file.persistent_record_id;
#end
      //CCPA-22
				in_file.global_sid;
      in_file.record_sid;

end;

#uniquename(in_slim)
%in_slim% := table(in_file, %in_slim_rec%);

#uniquename(in_slim_dst)
#uniquename(in_slim_srt)
#uniquename(in_slim_dep)
%in_slim_dst% := distribute(%in_slim%,hash(phone10,prim_range,prim_name,sec_range,z5,listed_name));								   
%in_slim_srt% := sort(%in_slim_dst%, record, local);
#if(usepid=true)
	out_file := dedup(%in_slim_srt%, record, except persistent_record_id, local);
#else
	out_file := dedup(%in_slim_srt%, record, local);
#end
								  								 
endmacro;