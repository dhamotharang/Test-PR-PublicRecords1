import Address,did_add,ut,header_slimsort,business_header_ss,risk_indicators,targus,_control, aid, gong, std;

EXPORT proc_build_neustar_master(string rundate) := function

//filter then distribute, not the other way around
adds0 := File_DailyUpdates(Action_code='A');
adds  := distribute(adds0,Record_id);
								
deletes := distribute(File_DailyUpdates(Action_code='D'),Record_id);

adds t_flagDeletes(adds L ,deletes R) := transform

precleanName    := if(length(L.lstnm) = 1 and
								 L.lstnm[1] = L.lstgn[1],
								 stringlib.stringtouppercase(L.lstgn),
							     trim(stringlib.stringtouppercase(L.lstnm),left,right) + ' ' + trim(stringlib.stringtouppercase(L.lstgn),left,right));
								 
self.dt_first_seen:= L.last_udt_date[5..8]+L.last_udt_date[1..4];
self.dt_last_seen:= if(trim(R.recordid,left,right) = trim(L.seisintid,left,right),R.filedate[1..8],'');
self.current_record_flag:= if(trim(R.recordid,left,right) = trim(L.seisintid,left,right),'','Y');  
self.deletion_date:= if(trim(R.recordid,left,right) = trim(L.seisintid,left,right),R.filedate[1..8],'');
self := L;
end;

flaggedGong	:= join(adds,deletes,trim(left.seisintid,left,right) = trim(right.recordid,left,right),t_flagDeletes(left,right),left outer,local);

acChange := Risk_Indicators.File_AreaCode_Change;

flaggedGong tChange(flaggedGong L, acChange R) := transform
self.prior_area_code 	:= map(L.phone10[1..6] = R.new_npa+R.new_nxx
								and ut.GetDate < 
								if(R.permissive_end[5]='9','19'+R.permissive_end[5..6]+R.permissive_end[1..4],'20'+R.permissive_end[5..6]+R.permissive_end[1..4])
								=> R.old_npa,'');
								
self 					:= L;

end;

j_acChange := join(flaggedGong,acChange,left.phone10[1..6]=right.new_npa+right.new_nxx,tChange(left,right),left outer,lookup);

//see phone_number 2077938621
//the name + zip is also a good example of people moving down the street
//that phone has 2 records with the same name and dt_last_seen yet only one of them has a prim_range
//up 'til now (12/4/2008) the dedup was randomly choosing which of the 2 records to keep
//let's include the pub_date in our dedup
//Bug 38390 - remove targus records with XXX in phone number - private records
dd_Targus := dedup(
              sort(
               distribute(Targus.File_consumer_base(phone_number<>'' and lname<>'' and fname<>'' and stringlib.stringfind(stringlib.stringtouppercase(phone_number), 'XXX',1) = 0),hash(phone_number,lname,fname)),
			  phone_number,lname,fname,-dt_last_seen,-pubdate,local),
			 phone_number,lname,fname,local);

join_to_targus_candidates     := distribute(j_acChange(  phone10<>'' and name_last<>'' and name_first<>''),hash(phone10,name_last,name_first));
not_join_to_targus_candidates :=            j_acChange(~(phone10<>'' and name_last<>'' and name_first<>''));

boolean collect_targus(string comb_left, string comb_right) := function
  iszip4 := comb_right[39..42] <> '' and comb_left[39..42] = '';
  isaddr := comb_right[1..38] = comb_left[1..38];
	iszip  := ut.nneq(comb_right[43..47], comb_left[43..47]);
  flag := if(iszip4 and isaddr and iszip, true, false);
  return flag;
end;

boolean left_is_blank(string in_field) := function
 
  ret_left_is_blank := in_field='';
  
  return ret_left_is_blank;

end;

boolean these_are_equal(string left_in_field, string right_in_field) := function

 ret_these_are_equal := left_in_field=right_in_field;
 
 return ret_these_are_equal;

end;

append_function(boolean if_condition1, 
                boolean if_condition2,
				string left_appnd_field,string right_appnd_field,
                boolean if_condition3,
				boolean if_condition4
			   ) := function

 string return_value := if(if_condition4=true,
							right_appnd_field
						,if(if_condition1=true,
							map(if_condition2=true and                        left_appnd_field='' => right_appnd_field,''),
							map(if_condition2=true and if_condition3=true and left_appnd_field='' => right_appnd_field,''))
						 );
                         
 return return_value;

end;

gong_v2.layout_temp_addr_fields  taddr(join_to_targus_candidates L, dd_Targus R):= transform

boolean isJoin := (R.phone_number=L.phone10    and
		           R.lname   	 =L.name_last  and
		           R.fname   	 =L.name_first and
							 R.prim_range  = L.prim_range and
							 ut.NNEQ(r.zip, l.z5) and
							 L.z4 = '' and R.zip4 <> '' and 
		           L.current_record_flag = 'Y');

comb_left :=	l.prim_range + l.prim_name + l.z4 + l.z5;
comb_right :=	r.prim_range + r.prim_name + r.zip4 + r.zip;

pre_appnd_prim_range  := append_function(left_is_blank(l.prim_name), isjoin,l.prim_range, r.prim_range, these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));
pre_appnd_predir      := append_function(left_is_blank(l.prim_name), isjoin,l.predir,     r.predir,     these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));
pre_appnd_prim_name   := append_function(left_is_blank(l.prim_range),isjoin,l.prim_name,  r.prim_name,  these_are_equal(l.prim_range,r.prim_range),	collect_targus(comb_left, comb_right));
pre_appnd_suffix      := append_function(left_is_blank(l.prim_name), isjoin,l.suffix,     r.suffix,     these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));
pre_appnd_postdir     := append_function(left_is_blank(l.prim_name), isjoin,l.postdir,    r.postdir,    these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));
pre_appnd_unit_desig  := append_function(left_is_blank(l.prim_name), isjoin,l.unit_desig, r.unit_desig, these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));
pre_appnd_sec_range   := append_function(left_is_blank(l.prim_name), isjoin,l.sec_range,  r.sec_range,  these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));
pre_appnd_p_city_name := append_function(left_is_blank(l.prim_name), isjoin,l.p_city_name,r.city_name,  these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));
pre_appnd_st          := append_function(left_is_blank(l.prim_name), isjoin,l.st,         r.st,         these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));
pre_appnd_z5          := append_function(left_is_blank(l.prim_name), isjoin,l.z5,         r.z5,         these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));
pre_appnd_z4          := append_function(left_is_blank(l.prim_name), isjoin,l.z4,         r.zip4,       these_are_equal(l.prim_name,r.prim_name),	collect_targus(comb_left, comb_right));

recleaned_append 	  := Address.CleanAddress182(pre_appnd_prim_range + ' ' + pre_appnd_predir + ' ' + pre_appnd_prim_name + ' ' + pre_appnd_suffix + ' ' + pre_appnd_unit_desig + ' ' + pre_appnd_sec_range,
														pre_appnd_p_city_name + ' ' + pre_appnd_st + ' ' + pre_appnd_z5 + ' ' + pre_appnd_z4);

self.targus_append_flag	   := collect_targus(comb_left, comb_right);

self.appnd_prim_range	:= recleaned_append[1..10];
self.appnd_predir		:= recleaned_append[11..12];
self.appnd_prim_name	:= recleaned_append[13..40];
self.appnd_suffix		:= recleaned_append[41..44];
self.appnd_postdir		:= recleaned_append[45..46];
self.appnd_unit_desig	:= recleaned_append[47..56];
self.appnd_sec_range	:= recleaned_append[57..64];
self.appnd_p_city_name	:= recleaned_append[65..89];
self.appnd_st			:= recleaned_append[115..116];
self.appnd_z5			:= recleaned_append[117..121];
self.appnd_z4			:= recleaned_append[122..125];

self := L;
end;

appndedAddr := join(join_to_targus_candidates,dd_Targus,left.phone10 = right.phone_number and left.name_last=right.lname and left.name_first=right.fname,taddr(left,right),left outer,local);

concat := appndedaddr+project(not_join_to_targus_candidates,gong_v2.layout_temp_addr_fields);


history_did_hhid := Gong_v2.fn_did_bdid_hhid_trg(concat);

Gong_v2.mac_add_disc_cnt(history_did_hhid,cmplt_history);


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


pmaster := cmplt_history;

layout_master_aid := record
recordof(pmaster);
	unsigned8 ct := 0;
	string nerr_stat := '';
	string caption_text_piece := '';
	string last_line := '';
	string cleaned := '';
end;

history := project(pmaster, transform(layout_master_aid, self.ct := counter, self := left));

set_stabbr := ['AA','AE','AK','AL','AP','AR','AS','AZ','CA','CO','CT','DC','DE','FL','FM','GA','GU','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MH','MI','MN','MO','MP','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','PW','RI','SC','SD','TN','TX','UT','VA','VI','VT','WA','WI','WV','WY','AB','BC','MB','NB','NF','NT','NS','ON','PE','QC','SK','YT'];

NormAddrs :=
	NORMALIZE(history,length(stringlib.stringfilter(left.caption_text, '|'))+1,
				transform(layout_master_aid,
							nCaption := '|' + left.caption_text + '|';
							prepped1(string pcaption_text_piece) := function
									caption_text_piece := stringlib.stringtouppercase(pcaption_text_piece);
									c := regexreplace('^OFC.',stringlib.stringcleanspaces(stringlib.stringfilterout(caption_text_piece, '|')), '');
									h_num := length(stringlib.stringfilter(c, '12345679')) > 0;
									am_pm := regexfind('(AM).*(PM)', c);
									hr24 := regexfind('(24.*HR)|(24.*HOUR)', c);
									toll_fax_res := regexfind('(TOLL )|(FAX )|( TOLL)|( FAX)|(RESIDENCE)', c);
							return if(h_num and ~am_pm and ~hr24 and ~toll_fax_res, c, ''); end;
							prepped2(string city, string st, string zip) := function
									h_city := city <> '';
									h_st := st <> '' and trim(st, all) in set_stabbr;
									h_zip := zip <> '';
									bogus := 'XXXXXXXX, XX 99999';
							return if(h_zip or (h_st and h_city), stringlib.stringcleanspaces(city + ' ' + if(~h_st, '', st) + ' ' + zip), bogus); end;
							
						self.caption_text := left.caption_text;
						self.caption_text_piece := nCaption[stringlib.stringfind(nCaption, '|', counter)..stringlib.stringfind(nCaption, '|', counter+1)];
						self.last_line := left.p_city_name + ' ' + left.st + ' ' + left.z5;
						self.cleaned := address.CleanAddress182(prepped1(self.caption_text_piece), if(prepped1(self.caption_text_piece) <> '', prepped2(left.p_city_name,left.st,left.z5), ''));
						self.nerr_stat := self.cleaned[179..182];
						self := left));	

dist := distribute(NormAddrs, hash(phone10,prim_range,prim_name,z5,company_name)) : persist('~thor_200::gongbasecaptionfix');

prNoChange := project(dist(caption_text = ''), transform(recordof(pmaster), self := left));

dedNormAddrs := 	dedup(sort(dist(caption_text <> ''), ct, -nerr_stat[..1], nerr_stat[2..]),ct);
				
prAddr := 			project(dedNormAddrs, transform(recordof(pmaster),
						pick_address := function // is the old address good enough, do we pick the caption
							validOld := left.prim_name <> '' OR left.sec_range <> '';
							validNew := left.cleaned[13..40] <> '' OR left.cleaned[57..64] <> '';
							cleanNew1 := if(validNew, stringlib.stringfindreplace(left.cleaned, 'XX', '  '), '');
							cleanNew2 := if(cleanNew1 <> '', stringlib.stringfindreplace(cleanNew1, 'XXXXXXXX', '        '), '');
							cleanNew := if(cleanNew2 <> '', stringlib.stringfindreplace(CleanNew2, '99999', '     '), '');
						return  if(~validOld and validNew and length(stringlib.stringfilter(left.caption_text_piece, '0123456789'))>0, cleanNew, ''); 
						end;					
						self.prim_range := 		if(pick_address = '', left.prim_range, pick_address[1..10]);
						self.predir := 			if(pick_address = '', left.predir, pick_address[11..12]);
						self.prim_name := 		if(pick_address = '', left.prim_name, pick_address[13..40]);
						self.suffix := 			if(pick_address = '', left.suffix, pick_address[41..44]);
						self.postdir := 		if(pick_address = '', left.postdir, pick_address[45..46]);
						self.unit_desig := 		if(pick_address = '', left.unit_desig, pick_address[47..56]);
						self.sec_range := 		if(pick_address = '', left.sec_range, pick_address[57..64]);
						self.p_city_name := 	if(pick_address = '', left.p_city_name, pick_address[65..89]);
						self.v_city_name := 	if(pick_address = '', left.v_city_name, pick_address[90..114]);
						self.st := 				if(pick_address = '', left.st, pick_address[115..116]);
						self.z5 := 				if(pick_address = '', left.z5, pick_address[117..121]);
						self.z4 := 				if(pick_address = '', left.z4, pick_address[122..125]);
						self.cart := 			if(pick_address = '', left.cart, pick_address[126..129]);
						self.cr_sort_sz := 		if(pick_address = '', left.cr_sort_sz, pick_address[130..130]);
						self.lot := 			if(pick_address = '', left.lot, pick_address[131..134]);
						self.lot_order := 		if(pick_address = '', left.lot_order, pick_address[135..135]);
						self.dpbc := 			if(pick_address = '', left.dpbc, pick_address[136..137]);
						self.chk_digit := 		if(pick_address = '', left.chk_digit, pick_address[138..138]);
						self.rec_type := 		if(pick_address = '', left.rec_type, pick_address[139..140]);
						self.county_code := 	if(pick_address = '', left.county_code, pick_address[141..145]);
						self.geo_lat := 		if(pick_address = '', left.geo_lat, pick_address[146..155]);
						self.geo_long := 		if(pick_address = '', left.geo_long, pick_address[156..166]);
						self.msa := 			if(pick_address = '', left.msa, pick_address[167..170]);
						self.geo_blk := 		if(pick_address = '', left.geo_blk, pick_address[171..177]);
						self.geo_match := 		if(pick_address = '', left.geo_match, pick_address[178..178]);
						self.err_stat := 		if(pick_address = '', left.err_stat, pick_address[179..182]);
												
							tCapText :=	stringlib.stringfindreplace(left.caption_text_piece, '|', '');
							refirst(string t) := if(t[..1] = '|', t[2..], t); 
						self.caption_text := 
											refirst(stringlib.stringfindreplace(
											if(pick_address <> '' or 
																				(left.prim_name <> '' and left.prim_name = left.cleaned[13..40]) or 
																				(left.sec_range <> '' and left.sec_range = left.cleaned[57..64]) or 
																				left.nerr_stat[..1] = 'S', 
																			stringlib.stringfindreplace(left.caption_text, tCapText, ''), ''),
																			'||', '|'));
						
						self := left));
						
// output(prAddr + prNoChange,,'~thor_200::base::20100130::lss_master::caption_fix', overwrite, __compressed__);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

aid_layout := record
	gong_v2.layout_gongmasteraid;
	string line1 := '';
	string line2 := '';
end;
	
	

master := project(prAddr + prNoChange, transform(aid_layout,
						self.rawaid := 0;
						self.line1 := stringlib.stringcleanspaces( 
							left.predir + ' ' +
							left.prim_name + ' ' +
							left.suffix + ' ' +
							left.postdir + ' ' +
							left.unit_desig + ' ' +
							left.sec_range);
						self.line2 := stringlib.stringcleanspaces(
							trim(left.p_city_name, left, right) + if(left.p_city_name <> '' and left.st <> '', ', ', '') + left.st + ' ' + left.z5);
						self.pclean := left.prim_range +
							left.predir +
							left.prim_name +
							left.suffix +
							left.postdir +
							left.unit_desig +
							left.sec_range +
							left.p_city_name +
							left.v_city_name + 
							left.st +
							left.z5 +
							left.z4 +
							left.cart +
							left.cr_sort_sz +
							left.lot +
							left.lot_order +
							left.dpbc +
							left.chk_digit +
							left.rec_type +
							left.county_code +
							left.geo_lat +
							left.geo_long +
							left.msa +
							left.geo_blk +
							left.geo_match +
							left.err_stat;
						self := left));
													
aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;

masterAID := master(prim_name <> '' or sec_range <> '');
masterNoAID := project(master(prim_name = '' and sec_range = ''), transform(gong_v2.layout_gongmasteraid, self := left));
	
aid.MacAppendFromRaw_2Line(masterAID, line1, line2, rawaid , master_out, laidappendflags);

nmmaster := normalize(master_out, 1, transform(gong_v2.layout_gongmasteraid,
				choose_field(string old, string new) := function
					S := left.err_stat[..1] = 'S';
					prim_range := left.prim_range <> '' and left.aidwork_acecache.prim_range = '';
					prim_name := left.prim_name <> '' and left.aidwork_acecache.prim_name = '';
					sec_range := left.sec_range <> '' and left.aidwork_acecache.sec_range = '';
				return if(prim_range or s or prim_name or sec_range, old, new); end;
						self.rawaid := left.aidwork_rawaid;
						self.prim_range := choose_field(left.prim_range, left.aidwork_acecache.prim_range);
						self.predir := choose_field(left.predir, left.aidwork_acecache.predir);
						self.prim_name := choose_field(left.prim_name, left.aidwork_acecache.prim_name);
						self.suffix := choose_field(left.suffix, left.aidwork_acecache.addr_suffix);
						self.postdir := choose_field(left.postdir, left.aidwork_acecache.postdir);
						self.unit_desig := choose_field(left.unit_desig, left.aidwork_acecache.unit_desig);
						self.sec_range := choose_field(left.sec_range, left.aidwork_acecache.sec_range);
						self.p_city_name := choose_field(left.p_city_name, left.aidwork_acecache.p_city_name);
						self.v_city_name := choose_field(left.v_city_name, left.aidwork_acecache.v_city_name);
						self.st := choose_field(left.st, left.aidwork_acecache.st);
						self.z5 := choose_field(left.z5, left.aidwork_acecache.zip5);
						self.z4 := choose_field(left.z4, left.aidwork_acecache.zip4);
						self.cart := choose_field(left.cart, left.aidwork_acecache.cart);
						self.cr_sort_sz := choose_field(left.cr_sort_sz, left.aidwork_acecache.cr_sort_sz);
						self.lot := choose_field(left.lot, left.aidwork_acecache.lot);
						self.lot_order := choose_field(left.lot_order, left.aidwork_acecache.lot_order);
						self.dpbc := choose_field(left.dpbc, left.aidwork_acecache.dbpc);
						self.chk_digit := choose_field(left.chk_digit, left.aidwork_acecache.chk_digit);
						self.rec_type := choose_field(left.rec_type, left.aidwork_acecache.rec_type);
						self.county_code := choose_field(left.county_code, left.aidwork_acecache.county);
						self.geo_lat := choose_field(left.geo_lat, left.aidwork_acecache.geo_lat);
						self.geo_long := choose_field(left.geo_long, left.aidwork_acecache.geo_long);
						self.msa := choose_field(left.msa, left.aidwork_acecache.msa);
						self.geo_blk := choose_field(left.geo_blk, left.aidwork_acecache.geo_blk);
						self.geo_match := choose_field(left.geo_match, left.aidwork_acecache.geo_match);
						self.err_stat := choose_field(left.err_stat, left.aidwork_acecache.err_stat);
						self:=left));

outfile := 			
sequential(
	output(nmmaster + masterNoAID,,Gong_v2.thor_cluster+'base::'+rundate+'::lss_master',overwrite,__compressed__),
			std.File.StartSuperFileTransaction(),
			
			std.File.AddSuperFile(gong_v2.thor_cluster+'base::gongv3_master_delete',
									  gong_v2.thor_cluster+'base::gongv3_master_grandfather',,true,),
			std.File.clearsuperfile(gong_v2.thor_cluster+'base::gongv3_master_grandfather'),
			
			std.File.AddSuperFile(gong_v2.thor_cluster+'base::gongv3_master_grandfather',
									  gong_v2.thor_cluster+'base::gongv3_master_father',,true,),
			std.File.clearsuperfile(gong_v2.thor_cluster+'base::gongv2_master_father'),
			
			std.File.AddSuperFile(gong_v2.thor_cluster+'base::gongv3_master_father',
									  gong_v2.thor_cluster+'base::gongv3_master',,true,),
			std.File.clearsuperfile(gong_v2.thor_cluster+'base::gongv2_master'),
			
			std.File.AddSuperFile(gong_v2.thor_cluster+'base::gongv3_master',
									  gong_v2.thor_cluster+'base::'+rundate+'::lss_master',,,),
			
			std.File.clearsuperfile(gong_v2.thor_cluster+'base::gongv2_master_delete', true),
			
			std.File.FinishSuperFileTransaction());
			
			// gong.strata_popFileDailyAdditions);

return outfile;



;