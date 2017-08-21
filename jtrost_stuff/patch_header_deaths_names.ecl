import header, ut;

single_name_segment_obscenities := [
'ASSFUCK',
'ASSHOLE',
'ASSHOLES',
'BITCH',
'BLOWME',
'BLOWMEBITCH',
'BLOWMEDOWN',
'COCKLICKING',
'COCKSUCKER',
'COCKSUCKERS',
'CUNT',
'CUNTLIPS',
'FAGGOT',
'FUCK',
'FUCKCHOPS',
'FUCKED',
'FUCKER',
'FUCKFACE',
'FUCKHEAD',
'FUCKINGASS',
'FUCKKKKKKYOU',
'FUCKOFF',
'FUCKYOU',
'FUCKYOUFOR',
'FUCKYOUMORE',
'FUCKYOURSELF',
'MOTHERFOURKER',
'MOTHERFUCKER',
'PUSSY',
'PUSSYDILDOHEAD',
'PUSSYEAT',
'PUSSYFACE',
'PUSSYLICKER',
'PUSSYLIPS',
'PUSSYLOVER',
'SHIT',
'SLUT',
'WHOREFACE',
'YOUBLOW',
'YOUBLOWME'
];

full_name_obscenities := [
'BUTKISS MCCROTCH',
'HAYWOOD BLOWMEE',
'HEYWOOD BLOWMEI',
'HOLDEN MCCROTCH',
'JACK ASS',
'LICK BALLS',
'MOTHA FUCKA',
//Reversed
'MCCROTCH BUTKISS',
'BLOWMEE HAYWOOD',
'BLOWMEI HEYWOOD',
'MCCROTCH HOLDEN',
'ASS JACK',
'BALLS LICK',
'FUCKA MOTHA'
];

ds := header.File_Headers;
output(count(ds),named('count_coming_in'));

junk_names := ut.BogusNames(ds.fname,ds.mname,ds.lname);
good_names := ds(not junk_names);
the_junk   := ds(    junk_names);

output(count(good_names),named('count_after_obscenity_filter'));

stat_rec := record
 the_junk.fname;
 the_junk.lname;
 count_ := count(group);
end;

t_stat := sort(table(the_junk,stat_rec,fname,lname,few),fname,lname);
output(t_stat,all);

r_death_patch := record
 string20 fname;
 string20 mname;
 string20 lname;
 string5  name_suffix;
 string5  orig_clean_title;
 string20 orig_clean_fname;
 string20 orig_clean_mname;
 string20 orig_clean_lname;
 string5  orig_clean_name_suffix;
 string5  preferred_title;
 string20 preferred_fname;
 string20 preferred_mname;
 string20 preferred_lname;
 string5  preferred_suffix;
end;

ds_death      := dataset('~thor_dell400_2::out::death_master_plus_reclean_final',r_death_patch,flat);
ds_death_dist := distribute(ds_death,hash(orig_clean_fname,orig_clean_mname,orig_clean_lname,orig_clean_name_suffix));

    ds_header_death_recs := good_names(src     in ['DE','DS']);
not_ds_header_death_recs := good_names(src not in ['DE','DS']);

ds_header_death_recs_dist := distribute(ds_header_death_recs,hash(fname,mname,lname,name_suffix));

header.Layout_Header t_fix_names(header.Layout_Header l, r_death_patch r) := transform
 
 boolean has_right_rec := r.preferred_fname<>'';
 
 self.title       := if(has_right_rec,r.preferred_title ,l.title);
 self.fname       := if(has_right_rec,r.preferred_fname ,l.fname);
 self.mname       := if(has_right_rec,r.preferred_mname ,l.mname);
 self.lname       := if(has_right_rec,r.preferred_lname ,l.lname);
 self.name_suffix := if(has_right_rec,r.preferred_suffix,l.name_suffix);
 
 self             := l;

end;

p_fix_names := join(ds_header_death_recs_dist,ds_death_dist,
                    (left.fname       = right.orig_clean_fname       and
					 left.mname       = right.orig_clean_mname       and
					 left.lname       = right.orig_clean_lname       and
					 left.name_suffix = right.orig_clean_name_suffix
					),
				    t_fix_names(left,right),
				    left outer,local,keep(1)
				   );

bring_together := distribute(p_fix_names+not_ds_header_death_recs,hash(did));

output(count(bring_together),named('count_after_death_name_patch'));

output(bring_together,,'~thor_dell400_2::out::header_20070102_patched',__compressed__);

//Header Death record Stats before patch
r_stat_before
 :=
  record
    CountGroup := count(group);
    did_CountNonZero                                     := sum(group,if(ds_header_death_recs.did<>0,1,0));
    rid_CountNonZero                                     := sum(group,if(ds_header_death_recs.rid<>0,1,0));
    pflag1_CountNonBlank                                 := sum(group,if(ds_header_death_recs.pflag1<>'',1,0));
    pflag2_CountNonBlank                                 := sum(group,if(ds_header_death_recs.pflag2<>'',1,0));
    pflag3_CountNonBlank                                 := sum(group,if(ds_header_death_recs.pflag3<>'',1,0));
    ds_header_death_recs.src;
    dt_first_seen_CountNonZero                           := sum(group,if(ds_header_death_recs.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(ds_header_death_recs.dt_last_seen<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(ds_header_death_recs.dt_vendor_last_reported<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(ds_header_death_recs.dt_vendor_first_reported<>0,1,0));
    dt_nonglb_last_seen_CountNonZero                     := sum(group,if(ds_header_death_recs.dt_nonglb_last_seen<>0,1,0));
    rec_type_CountNonBlank                               := sum(group,if(ds_header_death_recs.rec_type<>'',1,0));
    vendor_id_CountNonBlank                              := sum(group,if(ds_header_death_recs.vendor_id<>'',1,0));
    phone_CountNonBlank                                  := sum(group,if(ds_header_death_recs.phone<>'',1,0));
    ssn_CountNonBlank                                    := sum(group,if(ds_header_death_recs.ssn<>'',1,0));
    dob_CountNonZero                                     := sum(group,if(ds_header_death_recs.dob<>0,1,0));
    title_CountNonBlank                                  := sum(group,if(ds_header_death_recs.title<>'',1,0));
    fname_CountNonBlank                                  := sum(group,if(ds_header_death_recs.fname<>'',1,0));
    mname_CountNonBlank                                  := sum(group,if(ds_header_death_recs.mname<>'',1,0));
    lname_CountNonBlank                                  := sum(group,if(ds_header_death_recs.lname<>'',1,0));
    name_suffix_CountNonBlank                            := sum(group,if(ds_header_death_recs.name_suffix<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(ds_header_death_recs.prim_range<>'',1,0));
    predir_CountNonBlank                                 := sum(group,if(ds_header_death_recs.predir<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(ds_header_death_recs.prim_name<>'',1,0));
    suffix_CountNonBlank                                 := sum(group,if(ds_header_death_recs.suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(ds_header_death_recs.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(ds_header_death_recs.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(ds_header_death_recs.sec_range<>'',1,0));
    city_name_CountNonBlank                              := sum(group,if(ds_header_death_recs.city_name<>'',1,0));
    st_CountNonBlank                                     := sum(group,if(ds_header_death_recs.st<>'',1,0));
    zip_CountNonBlank                                    := sum(group,if(ds_header_death_recs.zip<>'',1,0));
    zip4_CountNonBlank                                   := sum(group,if(ds_header_death_recs.zip4<>'',1,0));
    county_CountNonBlank                                 := sum(group,if(ds_header_death_recs.county<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(ds_header_death_recs.geo_blk<>'',1,0));
    cbsa_CountNonBlank                                   := sum(group,if(ds_header_death_recs.cbsa<>'',1,0));
    tnt_CountNonBlank                                    := sum(group,if(ds_header_death_recs.tnt<>'',1,0));
    valid_SSN_CountNonBlank                              := sum(group,if(ds_header_death_recs.valid_SSN<>'',1,0));
    jflag1_CountNonBlank                                 := sum(group,if(ds_header_death_recs.jflag1<>'',1,0));
    jflag2_CountNonBlank                                 := sum(group,if(ds_header_death_recs.jflag2<>'',1,0));
    jflag3_CountNonBlank                                 := sum(group,if(ds_header_death_recs.jflag3<>'',1,0));
end;

t_stat_before := sort(table(ds_header_death_recs,r_stat_before,src,few),src);
output(t_stat_before,named('death_stats_before_name_patch'));

//Header Death record Stats after patch
r_stat_after
 :=
  record
    CountGroup := count(group);
    did_CountNonZero                                     := sum(group,if(p_fix_names.did<>0,1,0));
    rid_CountNonZero                                     := sum(group,if(p_fix_names.rid<>0,1,0));
    pflag1_CountNonBlank                                 := sum(group,if(p_fix_names.pflag1<>'',1,0));
    pflag2_CountNonBlank                                 := sum(group,if(p_fix_names.pflag2<>'',1,0));
    pflag3_CountNonBlank                                 := sum(group,if(p_fix_names.pflag3<>'',1,0));
    p_fix_names.src;
    dt_first_seen_CountNonZero                           := sum(group,if(p_fix_names.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(p_fix_names.dt_last_seen<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(p_fix_names.dt_vendor_last_reported<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(p_fix_names.dt_vendor_first_reported<>0,1,0));
    dt_nonglb_last_seen_CountNonZero                     := sum(group,if(p_fix_names.dt_nonglb_last_seen<>0,1,0));
    rec_type_CountNonBlank                               := sum(group,if(p_fix_names.rec_type<>'',1,0));
    vendor_id_CountNonBlank                              := sum(group,if(p_fix_names.vendor_id<>'',1,0));
    phone_CountNonBlank                                  := sum(group,if(p_fix_names.phone<>'',1,0));
    ssn_CountNonBlank                                    := sum(group,if(p_fix_names.ssn<>'',1,0));
    dob_CountNonZero                                     := sum(group,if(p_fix_names.dob<>0,1,0));
    title_CountNonBlank                                  := sum(group,if(p_fix_names.title<>'',1,0));
    fname_CountNonBlank                                  := sum(group,if(p_fix_names.fname<>'',1,0));
    mname_CountNonBlank                                  := sum(group,if(p_fix_names.mname<>'',1,0));
    lname_CountNonBlank                                  := sum(group,if(p_fix_names.lname<>'',1,0));
    name_suffix_CountNonBlank                            := sum(group,if(p_fix_names.name_suffix<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(p_fix_names.prim_range<>'',1,0));
    predir_CountNonBlank                                 := sum(group,if(p_fix_names.predir<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(p_fix_names.prim_name<>'',1,0));
    suffix_CountNonBlank                                 := sum(group,if(p_fix_names.suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(p_fix_names.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(p_fix_names.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(p_fix_names.sec_range<>'',1,0));
    city_name_CountNonBlank                              := sum(group,if(p_fix_names.city_name<>'',1,0));
    st_CountNonBlank                                     := sum(group,if(p_fix_names.st<>'',1,0));
    zip_CountNonBlank                                    := sum(group,if(p_fix_names.zip<>'',1,0));
    zip4_CountNonBlank                                   := sum(group,if(p_fix_names.zip4<>'',1,0));
    county_CountNonBlank                                 := sum(group,if(p_fix_names.county<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(p_fix_names.geo_blk<>'',1,0));
    cbsa_CountNonBlank                                   := sum(group,if(p_fix_names.cbsa<>'',1,0));
    tnt_CountNonBlank                                    := sum(group,if(p_fix_names.tnt<>'',1,0));
    valid_SSN_CountNonBlank                              := sum(group,if(p_fix_names.valid_SSN<>'',1,0));
    jflag1_CountNonBlank                                 := sum(group,if(p_fix_names.jflag1<>'',1,0));
    jflag2_CountNonBlank                                 := sum(group,if(p_fix_names.jflag2<>'',1,0));
    jflag3_CountNonBlank                                 := sum(group,if(p_fix_names.jflag3<>'',1,0));
end;

t_stat_after := sort(table(p_fix_names,r_stat_after,src,few),src);
output(t_stat_after,named('death_stats_after_name_patch'));