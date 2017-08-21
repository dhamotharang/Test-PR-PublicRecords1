import address;

export fn_clean_the_addresses(dataset(recordof(gong_v2.layout_temp_for_daily_raw_processing)) in_gong) := function;

r1 := record
 in_gong;
 string10 pfrd_prim_range;
 string2  pfrd_predir;
 string28 pfrd_prim_name;
 string4  pfrd_addr_suffix;
 string2  pfrd_postdir;
 string10 pfrd_unit_desig;
 string8  pfrd_sec_range;
 string25 pfrd_p_city_name;
 string25 pfrd_v_city_name;
 string2  pfrd_st;
 string5  pfrd_zip;
 string4  pfrd_zip4;
 string4  pfrd_cart;
 string1  pfrd_cr_sort_sz;
 string4  pfrd_lot;
 string1  pfrd_lot_order;
 string2  pfrd_dbpc;
 string1  pfrd_chk_digit;
 string2  pfrd_rec_type;
 string5  pfrd_county;
 string10 pfrd_geo_lat;
 string11 pfrd_geo_long;
 string4  pfrd_msa;
 string7  pfrd_geo_blk;
 string1  pfrd_geo_match;
 string4  pfrd_err_stat;
end;

r1 t1(in_gong le) := transform

 boolean v_leads_with_oad := stringlib.stringfind(le.orig_strt[1..5],'(OAD)',1);
 string  v_orig_strt      := if(v_leads_with_oad,le.orig_strt[6..],le.orig_strt);
 
 boolean v_has_orig_2nd_line := (le.orig_loc<>'' and le.orig_state<>'') or le.orig_zip<>'';
 
 boolean v_dirtx_has_number := length(trim(stringlib.stringfilter(le.dirtx,'0123456789')))>0;
 
 string182 v_ca1 := address.CleanAddress182(stringlib.stringcleanspaces(le.hseno+' '+le.hsesx+' '+le.strt),
                                            stringlib.stringcleanspaces(le.locnm+' '+le.state+' '+le.zip)
										   );

 string182 v_ca2 := address.CleanAddress182(stringlib.stringcleanspaces(le.hseno+' '+le.hsesx+' '+le.strt),
                                            stringlib.stringcleanspaces(le.state+' '+le.zip)
										   );
 
 //rather common for the orig_ fields to just have the street
 string182 v_ca3 := address.CleanAddress182(stringlib.stringcleanspaces(le.orig_hseno+' '+le.orig_hsesx+' '+v_orig_strt),
                                            if(v_has_orig_2nd_line,
											 stringlib.stringcleanspaces(le.orig_loc+' '+le.orig_state+' '+le.orig_zip),
											 stringlib.stringcleanspaces(le.locnm+' '+le.state+' '+le.zip)
											 )
										   );

 string182 v_ca4 := address.CleanAddress182(stringlib.stringcleanspaces(le.orig_hseno+' '+le.orig_hsesx+' '+v_orig_strt),
                                            if(v_has_orig_2nd_line,
											 stringlib.stringcleanspaces(le.orig_state+' '+le.orig_zip),
											 stringlib.stringcleanspaces(le.state+' '+le.zip)
											 )
										   );

 string182 v_ca5 := if(v_dirtx_has_number,address.CleanAddress182(le.dirtx,le.locnm+' '+le.state+' '+le.zip),'');
 string182 v_ca6 := if(v_dirtx_has_number,address.CleanAddress182(le.dirtx,le.state+' '+le.zip),'');
  
 boolean v_ca1_has_s := v_ca1[179]='S';
 boolean v_ca2_has_s := v_ca2[179]='S';
 boolean v_ca3_has_s := v_ca3[179]='S';
 boolean v_ca4_has_s := v_ca4[179]='S';
 boolean v_ca5_has_s := v_ca5[179]='S';
 boolean v_ca6_has_s := v_ca6[179]='S';
 
 boolean v_ca1_has_z4 := v_ca1[122..125]<>'';
 boolean v_ca2_has_z4 := v_ca2[122..125]<>'';
 boolean v_ca3_has_z4 := v_ca3[122..125]<>'';
 boolean v_ca4_has_z4 := v_ca4[122..125]<>'';
 boolean v_ca5_has_z4 := v_ca5[122..125]<>'';
 boolean v_ca6_has_z4 := v_ca6[122..125]<>'';
 
 //necessary?
 //W20090330-134016 indicates all S's have a zip4 (and vice versa)
 //best_address should never resolve to B or C categories
 boolean v_ca1_has_both := v_ca1_has_s=true and v_ca1_has_z4=true;
 boolean v_ca2_has_both := v_ca2_has_s=true and v_ca2_has_z4=true;
 boolean v_ca3_has_both := v_ca3_has_s=true and v_ca3_has_z4=true;
 boolean v_ca4_has_both := v_ca4_has_s=true and v_ca4_has_z4=true;
 boolean v_ca5_has_both := v_ca5_has_s=true and v_ca5_has_z4=true;
 boolean v_ca6_has_both := v_ca6_has_s=true and v_ca6_has_z4=true;
 
 boolean v_ca1_has_pr_or_pn := v_ca1[1..10]<>'' or v_ca1[13..40]<>'';
 boolean v_ca2_has_pr_or_pn := v_ca2[1..10]<>'' or v_ca2[13..40]<>'';
 boolean v_ca3_has_pr_or_pn := v_ca3[1..10]<>'' or v_ca3[13..40]<>'';
 boolean v_ca4_has_pr_or_pn := v_ca4[1..10]<>'' or v_ca4[13..40]<>'';
 boolean v_ca5_has_pr_or_pn := v_ca5[1..10]<>'' or v_ca5[13..40]<>'';
 boolean v_ca6_has_pr_or_pn := v_ca6[1..10]<>'' or v_ca6[13..40]<>'';
 
 boolean v_ca1_has_zip := v_ca1[117..121]<>'';
 boolean v_ca2_has_zip := v_ca2[117..121]<>'';
 boolean v_ca3_has_zip := v_ca3[117..121]<>'';
 boolean v_ca4_has_zip := v_ca4[117..121]<>'';
 boolean v_ca5_has_zip := v_ca5[117..121]<>'';
 boolean v_ca6_has_zip := v_ca6[117..121]<>'';
 
 boolean v_ca1_has_strt_and_zip := v_ca1_has_pr_or_pn=true and v_ca1_has_zip=true;
 boolean v_ca2_has_strt_and_zip := v_ca2_has_pr_or_pn=true and v_ca2_has_zip=true;
 boolean v_ca3_has_strt_and_zip := v_ca3_has_pr_or_pn=true and v_ca3_has_zip=true;
 boolean v_ca4_has_strt_and_zip := v_ca4_has_pr_or_pn=true and v_ca4_has_zip=true;
 boolean v_ca5_has_strt_and_zip := v_ca5_has_pr_or_pn=true and v_ca5_has_zip=true;
 boolean v_ca6_has_strt_and_zip := v_ca6_has_pr_or_pn=true and v_ca6_has_zip=true;

 string182 v_best_clean_address := map(v_ca1_has_both => v_ca1,
                                       v_ca2_has_both => v_ca2,
									   v_ca3_has_both => v_ca3,
									   v_ca4_has_both => v_ca4,
									   v_ca5_has_both => v_ca5,
									   v_ca6_has_both => v_ca6,
									   v_ca1_has_z4   => v_ca1,
									   v_ca2_has_z4   => v_ca2,
									   v_ca3_has_z4   => v_ca3,
									   v_ca4_has_z4   => v_ca4,
									   v_ca5_has_z4   => v_ca5,
									   v_ca6_has_z4   => v_ca6,
									   v_ca1_has_s    => v_ca1,
									   v_ca2_has_s    => v_ca2,
									   v_ca3_has_s    => v_ca3,
									   v_ca4_has_s    => v_ca4,
									   v_ca5_has_s    => v_ca5,
									   v_ca6_has_s    => v_ca6,
									   v_ca1_has_strt_and_zip => v_ca1,
									   v_ca2_has_strt_and_zip => v_ca2,
									   v_ca3_has_strt_and_zip => v_ca3,
									   v_ca4_has_strt_and_zip => v_ca4,
									   v_ca5_has_strt_and_zip => v_ca5,
									   v_ca6_has_strt_and_zip => v_ca6,
									   v_ca1_has_zip => v_ca1,
									   v_ca2_has_zip => v_ca2,
									   v_ca3_has_zip => v_ca3,
									   v_ca4_has_zip => v_ca4,
									   v_ca5_has_zip => v_ca5,
									   v_ca6_has_zip => v_ca6,
									   v_ca1);

 string2 v_best_clean_address_ind := map(v_ca1_has_both => '1A',
                                         v_ca2_has_both => '2A',
									     v_ca3_has_both => '3A',
									     v_ca4_has_both => '4A',
										 v_ca5_has_both => '5A',
										 v_ca6_has_both => '6A',
									     v_ca1_has_z4   => '1B',
									     v_ca2_has_z4   => '2B',
									     v_ca3_has_z4   => '3B',
									     v_ca4_has_z4   => '4B',
										 v_ca5_has_z4   => '5B',
										 v_ca6_has_z4   => '6B',
									     v_ca1_has_s    => '1C',
									     v_ca2_has_s    => '2C',
									     v_ca3_has_s    => '3C',
									     v_ca4_has_s    => '4C',
										 v_ca5_has_s    => '5C',
										 v_ca6_has_s    => '6C',
									     v_ca1_has_strt_and_zip => '1D',
									     v_ca2_has_strt_and_zip => '2D',
									     v_ca3_has_strt_and_zip => '3D',
									     v_ca4_has_strt_and_zip => '4D',
										 v_ca5_has_strt_and_zip => '5D',
										 v_ca6_has_strt_and_zip => '6D',
									     v_ca1_has_zip => '1E',
									     v_ca2_has_zip => '2E',
									     v_ca3_has_zip => '3E',
									     v_ca4_has_zip => '4E',
										 v_ca5_has_zip => '5E',
										 v_ca6_has_zip => '6E',
									     'XX');



 self.opt1_err_stat          := v_ca1[179..182];
 self.opt2_err_stat          := v_ca2[179..182];
 self.opt3_err_stat          := v_ca3[179..182];
 self.opt4_err_stat          := v_ca4[179..182];
 self.opt5_err_stat          := v_ca5[179..182];
 self.opt6_err_stat          := v_ca6[179..182];
 self.pfrd_address_ind := v_best_clean_address_ind;

 self.pfrd_prim_range  := v_best_clean_address[ 1..  10];
 self.pfrd_predir      := v_best_clean_address[ 11.. 12];
 self.pfrd_prim_name   := v_best_clean_address[ 13.. 40];
 self.pfrd_addr_suffix := v_best_clean_address[ 41.. 44];
 self.pfrd_postdir     := v_best_clean_address[ 45.. 46];
 self.pfrd_unit_desig  := v_best_clean_address[ 47.. 56];
 self.pfrd_sec_range   := v_best_clean_address[ 57.. 64];
 self.pfrd_p_city_name := v_best_clean_address[ 65.. 89];
 self.pfrd_v_city_name := v_best_clean_address[ 90..114];
 self.pfrd_st          := v_best_clean_address[115..116];
 self.pfrd_zip         := v_best_clean_address[117..121];
 self.pfrd_zip4        := v_best_clean_address[122..125];
 self.pfrd_cart        := v_best_clean_address[126..129];
 self.pfrd_cr_sort_sz  := v_best_clean_address[130..130];
 self.pfrd_lot         := v_best_clean_address[131..134];
 self.pfrd_lot_order   := v_best_clean_address[135..135];
 self.pfrd_dbpc        := v_best_clean_address[136..137];
 self.pfrd_chk_digit   := v_best_clean_address[138..138];
 self.pfrd_rec_type    := v_best_clean_address[139..140];
 self.pfrd_county      := v_best_clean_address[141..145];
 self.pfrd_geo_lat     := v_best_clean_address[146..155];
 self.pfrd_geo_long    := v_best_clean_address[156..166];
 self.pfrd_msa         := v_best_clean_address[167..170];
 self.pfrd_geo_blk     := v_best_clean_address[171..177];
 self.pfrd_geo_match   := v_best_clean_address[178..178];
 self.pfrd_err_stat    := v_best_clean_address[179..182];

 self                  := le;
end;

p1 := project(in_gong,t1(left));// : persist('persist::gong_clean_address');

return p1;

end;