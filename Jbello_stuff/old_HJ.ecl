import header,ut,address,mdr,idl_header;

// pre_header_file0 := header.file_headers(header.Blocked_data());
pre_header_file0 := dataset('~thor_data::hd_eq_en_jbello',header.Layout_Header,flat);

//Patch to filter bad names
check_for_junk := ut.BogusNames(pre_header_file0.fname,pre_header_file0.mname,pre_header_file0.lname) 
               or ut.boguscities(pre_header_file0.city_name,pre_header_file0.st);
			   
pre_header_file     := pre_header_file0(not check_for_junk);

//fix any funky DOBs
header.MAC_format_DOB(pre_header_file,dob, header_file_better_dob )

//fix any funky prim_ranges
header.MAC_Improve_Prim_Range(header_file_better_dob,prim_range, hd )

// new records enter header process here.
dis_use := distribute(header.New_Header_Records,hash(fname,lname,zip,zip4));

//Take latest date
use_srt := sort(dis_use,fname,lname,zip,zip4,src,rec_type,phone,ssn,dob,mname,name_suffix,
									 prim_range,predir,prim_name,suffix,postdir,unit_desig,
									 sec_range,city_name,st,county,local);

recordof(use_srt) t_rollup(use_srt le, use_srt ri) := transform
 self.dt_first_seen            := ut.min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen             := ut.max2(le.dt_last_seen, ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := ut.max2(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
 self.dt_nonglb_last_seen      := ut.max2(le.dt_nonglb_last_seen, ri.dt_nonglb_last_seen);
 self := le;
end;

use_record_d := rollup(use_srt,
                        left.fname      =right.fname       and
						left.lname      =right.lname       and
						left.zip        =right.zip         and
						left.zip4       =right.zip4        and
						left.src        =right.src         and
						left.rec_type   =right.rec_type    and
						left.phone      =right.phone       and
						left.ssn        =right.ssn         and
						left.dob        =right.dob         and
						left.mname      =right.mname       and
						left.name_suffix=right.name_suffix and
						left.prim_range =right.prim_range  and
						left.predir     =right.predir      and
						left.prim_name  =right.prim_name   and
						left.suffix     =right.suffix      and
						left.postdir    =right.postdir     and
						left.unit_desig =right.unit_desig  and
						left.sec_range  =right.sec_range   and
						left.city_name  =right.city_name   and
						left.st         =right.st and
						left.county     =right.county,
						t_rollup(left,right),local);

mdr.MAC_BasicMatch(use_record_d,outf_noID0)
outf_noID := outf_noID0 : persist('~thor_data::persist::hdr_no_basic_match');
no_rid    := outf_noID(rid=0);

r_nbm := record
 no_rid.src;
 string30 src_desc := mdr.sourcetools.translatesource(no_rid.src);
 count_            := count(group);
end;

ta1 := sort(table(no_rid,r_nbm,src,few),-count_);
output(ta1,all,named('no_basic_match'));

ut.MAC_Sequence_Records(no_rid,uid,outfile1)

outf := outfile1 + outf_noID(rid>0);

header.Layout_Header to_form(outf l) := transform
 self.rid := IF (l.rid=0,mdr.max_rid+l.uid,l.rid);
 self.did := IF (l.did=0,mdr.max_rid+l.uid,l.did);
 self.pflag1 := MAP(l.did=0=>'A',l.rid=0=>'P','+');
 self := l;
 end;

new_month_joined := project(outf,to_form(left))(header.Blocked_data_new());

Header.Layout_header blank_pflag(hd l) := transform
 self.pflag1 := ''; // Header is now considered clean
 self        := l;
 end;

pnew := project(hd,blank_pflag(left));

// remove death records that have been purged from Death Master since the last Header
head := header.fn_remove_deaths_not_in_death_master(pnew);

// i wanted to move this ahead of the 'repeated value' check so that ZZZZZZZZZZ (10 Z's) 
// would be removed rather than just truncate to ZZZZZ (5 Z's)
remove_junk_names := header.fn_junk_names(head+new_month_joined);

// created just so we have a single point of reference for straightening-up
header.layout_header more_cleanup(header.layout_header le) := transform

 self.ssn   := if(le.ssn in ut.set_badssn,'',le.ssn);
 self.phone := header.fn_blank_bogus_phones(le.phone);
 
 self.title     := '';
 self.fname     := if(ut.mod_value_is_repeated(le.fname).is_repeated,    ut.mod_value_is_repeated(le.fname).fixed,    le.fname);
 self.mname     := if(ut.mod_value_is_repeated(le.mname).is_repeated,    ut.mod_value_is_repeated(le.mname).fixed,    le.mname);
 self.lname     := if(ut.mod_value_is_repeated(le.lname).is_repeated,    ut.mod_value_is_repeated(le.lname).fixed,    le.lname);
 self.prim_name := if(ut.mod_value_is_repeated(le.prim_name).is_repeated,ut.mod_value_is_repeated(le.prim_name).fixed,le.prim_name);
 self.name_suffix := header.fn_cleanup_name_suffix(le.name_suffix);
 self := le;

end;

o_and_n := project(remove_junk_names,more_cleanup(left));

rldup := MDR.Rollup1;

ut.MAC_Patch_Id(o_and_n,rid,rldup,old_rid,new_rid,old_and_new_nopatch)

// fixes did > rid problems
old_and_new := header.FN_Patch_RID(old_and_new_nopatch);

// ****** Remove some known bad names  city_name='OZ' and st
isjunky := UT.BogusNames(old_and_new.FNAME, old_and_new.MNAME, old_and_new.LNAME) or UT.BogusCities(old_and_new.city_name, old_and_new.st);
kill_junk := old_and_new(not isjunky);
the_junk  := old_and_new(isjunky);
// output(the_junk,,'base::header_bogusjunk' + thorlib.wuid(),overwrite);

Header.MAC_Merge_ByRid(kill_junk,merged0)
// if ( count(merged0(did>rid)) <> 0, output('DID > RID constraint violated') );

remove_EN_deletes0 := Header.Fn_Remove_EN_deletes(merged0); 

header.Mac_clean_trustee_name(remove_EN_deletes0,remove_EN_deletes1);

address.Mac_Is_Business_Parsed(remove_EN_deletes1,remove_EN_deletes2);
remove_EN_deletes := project(remove_EN_deletes2(nametype<>'I'),header.layout_header);

merged              := header.fn_remove_companies(remove_EN_deletes);

ut.mac_flipnames(merged,fname,mname,lname,merged_out0);

merged_out1   := project(header.fn_character_swapping(project(merged_out0,header.Layout_New_Records)),header.layout_header);

Header.mac_Fix_Suffix(merged_out1,merged_out);

// this filter is applied because of mac_flipnames rule 2; this can result in records with no last_name W20100505-090313
merged_out_filter   := merged_out(fname<>'' and lname<>'');
   
export old_HJ := merged_out_filter : persist('~thor_data::persist::old_Header_joined');