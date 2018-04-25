import ut, risk_indicators, header_services, gong, dops, std;

h := DISTRIBUTE(File_Gong_History_FullEx);	

ut.mac_suppress_by_phonetype(h,phone10,st,histGong_out,true,did);

/* Swap City Names - V City provides a better quality of names - Bug 42318 */

trSwapCityNames := project(histGong_out, 
											transform(recordof(histGong_out),
												self.p_city_name := left.v_city_name;
												self.v_city_name := left.p_city_name;
												self := left));


layout_gong_inj := RECORD
 gong.Layout_history;
 string2 eor ;
END;

header_services.Supplemental_Data.mac_verify('file_gong_inj.txt', layout_gong_inj , attr);

gong_append_in := attr();

gong_in1 := PROJECT (gong_append_in, transform(gong_Neustar.Layout_history, self := left; self := [];)) ;

gong_in := PROJECT(gong_in1, Transform(gong_Neustar.Layout_history,
				self.Persistent_Record_id := (unsigned8)0x7FFFFFFFFFFFFFFF - COUNTER;
				self := left;));

trSwapCityNamesFiltWithGong0 := trSwapCityNames;

r1 := record
 trSwapCityNamesFiltWithGong0;
 string8 patched_first_seen    :='';
 boolean match_found_by_did    :=false;
 boolean match_found_by_address:=false;
 boolean match_found_by_seleid :=false;
end;

trSwapCityNamesFiltWithGong := project(trSwapCityNamesFiltWithGong0,r1);

neustar_recs       := trSwapCityNamesFiltWithGong(bell_id='NEU');
lssi_recs          := trSwapCityNamesFiltWithGong(bell_id='LSS');
other_sourced_recs := trSwapCityNamesFiltWithGong(bell_id not in ['NEU','LSS']);

//non-pubs currently not addressed
neustar_current_recs := neustar_recs(current_record_flag='Y' and (integer)phone10>0);
neustar_remainder    := neustar_recs(~(current_record_flag='Y' and (integer)phone10>0));
maxdate := MAX(lssi_recs, deletion_date);
lssi_forced_deletes  := lssi_recs(deletion_date=maxdate or deletion_date='', (integer)phone10>0);	//'20140731'
//lssi_forced_deletes  := lssi_recs(current_record_flag<>'Y' and deletion_date='' and (integer)phone10>0);

neustar_currents_with_did    := distribute(neustar_current_recs(did>0),hash(did,phone10));
neustar_currents_with_no_did := neustar_current_recs(did=0);

lssi_by_did     := dedup(sort(distribute(lssi_forced_deletes(did>0),hash(did,phone10)),did,phone10,local),did,phone10,local);
lssi_by_address := dedup(sort(distribute(lssi_forced_deletes(prim_range<>'' and prim_name<>'' and z5<>''),hash(phone10,prim_range,prim_name,z5)),phone10,prim_range,prim_name,z5,local),phone10,prim_range,prim_name,z5,local);
lssi_by_seleid := dedup(sort(distribute(lssi_forced_deletes(seleid>0),hash(phone10,seleid)),phone10,seleid,local),phone10,seleid,local);

//first try and match by phone+DID
r1 xform1(neustar_currents_with_did le, lssi_by_did ri) := transform
 
 boolean match_found := le.did=ri.did and le.phone10=ri.phone10;
 
 self.patched_first_seen := if(match_found,ri.dt_first_seen,le.dt_first_seen);
 self.match_found_by_did := if(match_found,true,false);
 self                    := le;
end;

did_attempt     := join(neustar_currents_with_did,lssi_by_did,left.did=right.did and left.phone10=right.phone10,xform1(left,right),left outer,local);
concat_currents := did_attempt + neustar_currents_with_no_did;

//for those that don't match by phone+DID do a 2nd pass this time by address
neustar_currents_with_address           := concat_currents(match_found_by_did=false and prim_range<>'' and prim_name<>'' and z5<>'');
neustar_currents_not_address_candidates := concat_currents(~(match_found_by_did=false and prim_range<>'' and prim_name<>'' and z5<>''));

r1 xform2(neustar_currents_with_address le, lssi_by_address ri) := transform
 
 boolean match_found := le.prim_range=ri.prim_range and le.prim_name=ri.prim_name and le.z5=ri.z5 and le.phone10=ri.phone10;
 
 self.patched_first_seen     := if(match_found,ri.dt_first_seen,le.dt_first_seen);
 self.match_found_by_did     := le.match_found_by_did;
 self.match_found_by_address := if(match_found,true,false);
 self                        := le;
end; 

address_attempt := join(neustar_currents_with_address,lssi_by_address,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.z5=right.z5 and left.phone10=right.phone10,xform2(left,right),left outer,local);
concat_currents_again := address_attempt+neustar_currents_not_address_candidates;

//and as a 3rd pass try and match on the SELEID business identifier
neustar_currents_with_business           := concat_currents_again(match_found_by_did=false and match_found_by_address=false and seleid>0);
neustar_currents_not_business_candidates := concat_currents_again(~(match_found_by_did=false and match_found_by_address=false and seleid>0));

r1 xform3(neustar_currents_with_business le, lssi_by_seleid ri) := transform
 
 boolean match_found := le.seleid=ri.seleid and le.phone10=ri.phone10;
 
 self.patched_first_seen     := if(match_found,ri.dt_first_seen,le.dt_first_seen);
 self.match_found_by_did     := le.match_found_by_did;
 self.match_found_by_address := le.match_found_by_address;
 self.match_found_by_seleid  := if(match_found,true,false);
 self                        := le;
end; 

business_attempt         := join(neustar_currents_with_business,lssi_by_seleid,left.seleid=right.seleid and left.phone10=right.phone10,xform3(left,right),left outer,local);
concat_currents_3rd_time := business_attempt+neustar_currents_not_business_candidates;

concat_all_sources := concat_currents_3rd_time
                    + neustar_remainder
										+ lssi_recs
										+ other_sourced_recs;

changed_dates := concat_all_sources(match_found_by_did=true or match_found_by_address=true or match_found_by_seleid=true);
//count(changed_dates);
//output(choosen(changed_dates,1000));

r2 := record
 concat_all_sources.match_found_by_did;
 concat_all_sources.match_found_by_address;
 concat_all_sources.match_found_by_seleid;
 count_ := count(group);
end;

ta1 := table(concat_all_sources,r2,match_found_by_did,match_found_by_address,match_found_by_seleid,few);
//output(ta1,named('patched_how_distribution'));

recordof(histGong_out) xform4(concat_all_sources le) := transform
 self.dt_first_seen := if(le.bell_id='NEU' 
                     and (le.match_found_by_did=true or le.match_found_by_address=true or le.match_found_by_seleid=true)
										 ,le.patched_first_seen,le.dt_first_seen);
 self               := le;
end;

first_seen_patched := project(concat_all_sources,xform4(left));

EXPORT File_History_PreProcess_for_Keys := 
	first_seen_patched(deletion_date<>'' OR current_record_flag='Y')		// filter out "replaced" records)
			 + gong_in	// include supplemental records
							: persist('~thor_data400::persist::neustar::gong_history_preprocess_for_keys');
