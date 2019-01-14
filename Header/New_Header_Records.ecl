import ut,ak_perm_fund,utilfile,vehiclev2,bankrupt,mdr,driversv2,emerges,
       atf,prof_license,govdata,mdr,faa,dea,watercraft,property,targus,
       LiensV2,ln_propertyv2,american_student_list,OKC_Student_List,votersv2,certegy,
	   ExperianCred,ExperianIRSG_Build,address,eq_hist, TransunionCred, AlloyMedia_student_list,header,Std,cd_seed;

export New_Header_Records(boolean pFastHeader = false) := function
//pFastHeader parameter used to determine if the run of the funtion is for Fast header or Full Header

use_eq_hist := true;
use_death_master := true;
use_state_death  := true;
use_header := header.build_type = 'M';	//only take EQ records in monthly build
use_dl := true;
use_vreg := true;
use_bank := true;
use_util_misses := true;
use_emerge := true;
use_AK_Perm_Fund := true;
use_ATF := true;
use_ProLic := true;
use_MS_Worker := true;
use_Liens := false;
use_airmen := true;
use_aircraft := true;
use_watercraft := true;
use_boaters := true;
use_foreclosures := true;
use_dea := true;
use_ln_tu := true;
use_targus := true;
use_liensv2 := true;
use_asl := true;
use_osl := true;
use_voters := true;
use_certegy := true;
use_nod := true;
use_Experian := true; 
use_Experian_phones := true;
use_Transunion := true; 
use_AlloyMedia_SL := true; 

ids := header.file_new_month(pFastHeader)(use_header);

eq_hist_in := eq_hist.As_header(,true)(use_eq_hist);

death_in := death_as_header(,true)(use_death_master);

state_death_in := state_death_as_header(,true)(use_state_death);

//Sources that can be added to Fast Header or Full Header depending on the pFastHeader parameter
dl_in := if(pFastHeader,driversv2.dls_as_header(pFastHeader:=true)(use_dl), driversv2.dls_as_header(pForHeaderBuild:=true)(use_dl));

vr_in := if(pFastHeader,vehiclev2.vehicle_as_header(pFastHeader:=true)(use_vreg), vehiclev2.vehicle_as_header(pForHeaderBuild:=true)(use_vreg));

ba_in := if(pFastHeader, Bankrupt.BK_as_header(pFastHeader:=true)(use_bank), Bankrupt.BK_as_header(pForHeaderBuild:=true)(use_bank));

fa_in := if(pFastHeader, ln_propertyv2.ln_propertyv2_as_source(true).ln_propertyv2_as_fheader, ln_propertyv2.ln_propertyv2_as_source().ln_propertyv2_as_header);
											   
em_in := emerges.master_As_Header(,true)(use_emerge);

ut_in := utilfile.sequenced(use_util_misses);					// not a function yet

ak_in := ak_perm_fund.APF_As_Header(,,true)(use_ak_perm_fund);

atf_in := atf.atf_as_header(,true)(use_atf);

pro_lic := prof_license.proflic_as_header(,true)(use_prolic and pflag3<>'I');

MS_work := govdata.MS_Worker_as_header(,true)(use_MS_worker);

liens := bankrupt.Liens_As_Header(,false)(use_liens);

forcl := property.Foreclosure_as_Header(,true)(use_foreclosures);

airm := faa.airmen_as_header(,true)(use_airmen);

airc := faa.aircraft_as_header(,true)(use_aircraft);

water := watercraft.Watercraft_as_Header(,,,true)(use_watercraft);

boat := emerges.boat_as_header(,true)(use_boaters);

dea_in := dea.DEA_As_Header(,true)(use_dea);

targus_wp := targus.consumer_as_header(,true)(use_targus);

//Sources that can be added to Fast Header or Full Header depending on the pFastHeader parameter
liens_v2 := if(pFastHeader, LiensV2.LiensV2_as_header(pFastHeader:=true)(use_liensv2), LiensV2.LiensV2_as_header(pForHeaderBuild:=true)(use_liensv2));

asl_in := american_student_list.asl_as_header(,true)(use_asl);

osl_in := okc_student_list.OKC_Student_List_as_header(,true)(use_osl);

voters_in := votersv2.voters_as_header(,true)(use_voters);

certegy_in := Certegy.As_header(,true)(use_certegy);

nod_in := property.NOD_as_Header(,true)(use_nod);

//Sources that can be added to Fast Header or Full Header depending on the pFastHeader parameter
Experian_in :=  if(pFastHeader, ExperianCred.Experian_as_header(pFastHeader:=true)(use_experian), ExperianCred.Experian_as_header(pForHeaderBuild:=true)(use_experian)); 

Tranunion_in := if(pFastHeader,TransunionCred.as_header(pFastHeader:=true)(use_transunion), TransunionCred.as_header(pForHeaderBuild:=true)(use_transunion));

Exprn_ph_in :=  ExperianIRSG_Build.ExperianIRSG_asHeader(,true)(use_Experian_phones); 

AlloyMedia_in :=  AlloyMedia_student_list.alloy_as_header(,true)(use_AlloyMedia_SL); 

cd_seed_in := cd_seed.as_header(,true);

//Sources that can be added to Fast Header or Full Header depending on the pFastHeader parameter
concat0 := if(~pFastHeader, 
				 ids 
         + eq_hist_in 
         + death_in 
		 + state_death_in
		 + dl_in 
		 + vr_in 
		 + ba_in 
		 + fa_in 
		 + atf_in 
		 + ut_in 
		 + ak_in 
		 + em_in 
		 + pro_lic 
		 + MS_Work 
		 + liens 
		 + forcl 
		 + airm 
		 + airc 
		 + water 
		 + boat 
		 + dea_in 
		 + targus_wp 
		 + liens_v2 
		 + asl_in 
         + osl_in
		 + voters_in
		 + certegy_in
		 + nod_in
		 + Experian_in
		 + Exprn_ph_in
		 + AlloyMedia_in
		 + cd_seed_in,
		 
		 dl_in
		 + ba_in
		 + liens_v2
		 + fa_in
		 + vr_in
		 + Experian_in
		 + Tranunion_in
		 );

concat1 := distribute(concat0,hash(fname,lname,zip,zip4));
concat2 := sort(concat1
				,src
				,fname
				,mname
				,lname
				,name_suffix
				,phone
				,ssn
				,dob
				,prim_range
				,predir
				,prim_name
				,suffix
				,postdir
				,unit_desig
				,sec_range
				,city_name
				,st
				,zip
				,zip4
				,county
				,local);//: persist ('~thor400_data::new_header_records_pre_roll');

header.layout_new_records t_rollup(concat0 le, concat0 ri) := transform
//keep the most recent of the rec_types
  self.rec_type                 := if ( le.rec_type='' or (le.dt_last_seen<ri.dt_last_seen and le.dt_last_seen>0), ri.rec_type, le.rec_type );
//keep the latest vendor_id if any
	self.vendor_id                := map(Header.Vendor_Id_Null(le.vendor_id) => ri.vendor_id
                                        ,Header.Vendor_Id_Null(ri.vendor_id) => le.vendor_id
                                        ,le.dt_vendor_last_reported > ri.dt_vendor_last_reported => le.vendor_id
// Bug: 173413
// this change is in conjunction with other changes made in:
// DriversV2.dls_as_header
// Header.Mac_dedup_header
// Header.Header_Joined
                                        ,le.rec_type <= ri.rec_type => le.vendor_id
                                        ,ri.vendor_id);
	self.uid                      := if (le.dt_vendor_last_reported > ri.dt_vendor_last_reported, le.uid, ri.uid);
	self.dt_first_seen            := ut.min2(le.dt_first_seen,ri.dt_first_seen);
	self.dt_last_seen             := max(le.dt_last_seen, ri.dt_last_seen);
	self.dt_vendor_first_reported := ut.min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
	self.dt_vendor_last_reported  := max(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
	self.dt_nonglb_last_seen      := max(le.dt_nonglb_last_seen, ri.dt_nonglb_last_seen);
	self := le;
end;

concat := rollup(concat2,
						left.src        =right.src         and
						(		~Mdr.SourceTools.SourceIsDL(left.src)
							or left.vendor_id=right.vendor_id)    and
						left.fname      =right.fname       and
						left.mname      =right.mname       and
						left.lname      =right.lname       and
						left.name_suffix=right.name_suffix and
						left.phone      =right.phone       and
						left.ssn        =right.ssn         and
						left.dob        =right.dob         and
						left.prim_range =right.prim_range  and
						left.predir     =right.predir      and
						left.prim_name  =right.prim_name   and
						left.suffix     =right.suffix      and
						left.postdir    =right.postdir     and
						left.unit_desig =right.unit_desig  and
						left.sec_range  =right.sec_range   and
						left.city_name  =right.city_name   and
						left.st         =right.st          and
						left.zip        =right.zip         and
						left.zip4       =right.zip4        and
						left.county     =right.county
						,t_rollup(left,right),local);


//W20080219-152437
fn_cleanup(string pIn) := function
 pOut1 := trim(regexreplace('[!$^*<>?]',pIn,' '),left,right);
 pOut  := trim(stringlib.stringfindreplace(pOut1,'\'',''),left,right);
 return pOut;
end;

is_junky(string in_name) := function
 is_true := length(trim(stringlib.stringfilterout(in_name,' ')))>ut.fn_count_unique_characters_in_a_string(in_name)*4
            or
		    (length(trim(stringlib.stringfilterout(in_name,' ')))>2 and ut.fn_count_unique_characters_in_a_string(in_name)=1);
 return is_true;
end;
  
header.layout_new_records t1(header.layout_new_records le) := transform

 //'II' not added because it wouldn't qualify as junky to begin with
 name_exception_set := ['III','IIII'];
 addr_exception_set := ['RR RR'];

 string4 v_dob   := (string)((string)le.dob)[1..4];
 boolean bad_dob := (~(v_dob between '1800' and ((STRING8)Std.Date.Today())[1..4])) and le.dob>0;
 
 string v_prim_name := fn_cleanup(le.prim_name);
 
 boolean prim_name_is_bogus := header.bogusstreets(v_prim_name) or (is_junky(v_prim_name) and v_prim_name not in addr_exception_set);

	prim_name	:= if(prim_name_is_bogus,'',v_prim_name);;
	unit_desig	:= if(prim_name_is_bogus,'',le.unit_desig);
	sec_range	:= if(prim_name_is_bogus,'',fn_cleanup(le.sec_range));

	pl:=length(trim(prim_name));
	ul:=length(trim(unit_desig));
	sl:=length(trim(sec_range));

	usl:=ul + sl;

	filter:='('
			+'^ *( *PO *BOX *[0-9]{1,}) *$'
			+'|^ *(COUNTY *ROAD *[0-9]{1,}) *$'
			+')';

	boolean OK2dedup := usl > 0	
						and  regexfind(filter,prim_name)
						and  trim(prim_name)[pl-usl..]=trim(unit_desig)+' '+trim(sec_range);

 
 
 self.prim_name	:= if(regexfind('SSN [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]',stringlib.stringfilterout(prim_name,'-'))
	or prim_name in Header.set_derogatory_address
	or regexfind('^error | error | error$',trim(prim_name),nocase)
	,'',prim_name);

 self.unit_desig := if(OK2dedup,'',unit_desig);
 self.sec_range  := if(OK2dedup,'',sec_range);

 self.phone     := if(length(trim(le.phone,left,right)) in [7,10],le.phone,'');
 
 self.vendor_id := fn_cleanup(le.vendor_id);
 self.title     := '';
 fname     := if(is_junky(fn_cleanup(le.fname))=false and le.fname not in name_exception_set,fn_cleanup(le.fname),'');
 mname     := if(is_junky(fn_cleanup(le.mname))=false and le.mname not in name_exception_set,fn_cleanup(le.mname),'');
 lname     := if(is_junky(fn_cleanup(le.lname))=false and le.lname not in name_exception_set,fn_cleanup(le.lname),'');

// remove junk at end of of name parts
 self.fname      := header.fn_blankout_junk(fname);
 self.mname      := header.fn_blankout_junk(mname);
 self.lname      := header.fn_blankout_junk(lname);
 self.prim_range := if(prim_name_is_bogus or trim(le.prim_range)='0','',le.prim_range);
 self.predir     := if(prim_name_is_bogus,'',le.predir);
 self.suffix     := if(prim_name_is_bogus,'',le.suffix);
 self.postdir    := if(prim_name_is_bogus,'',le.postdir);
 self.city_name  := if(le.city_name in Header.set_derogatory_address,'',stringlib.stringcleanspaces(fn_cleanup(le.city_name)));
 self.st         := fn_cleanup(le.st);
 self.zip        := if((integer)le.zip=0,'',le.zip);
 
 self.ssn       := if(length(trim(le.ssn,left,right))=9 and le.ssn=stringlib.stringfilter(le.ssn,'0123456789'),le.ssn,
                   if(le.src in ['BA','L2'] and length(trim(le.ssn,left,right))=4 and le.ssn=stringlib.stringfilter(le.ssn,'0123456789'),'00000'+le.ssn,
				   ''));
 self.dob       := if(bad_dob=true,0,le.dob);
 self           := le;
end;

p1 := project(concat,t1(left))(fname<>'' and lname<>'');

r1 := record
 p1;
 boolean acceptable_street;
 boolean acceptable_csz;
 boolean keep_record;
end;

r1 t2(header.layout_new_records le) := transform
 self.acceptable_street := (~(trim(le.prim_range)='' and (trim(le.prim_name)='' or trim(le.prim_name,all)=trim(le.city_name+le.st,all))));
 self.acceptable_csz    := (le.city_name<>'' and le.st<>'') or le.zip<>'';
 self.keep_record       := (~(trim(le.ssn)='' and le.dob=0 and (self.acceptable_street=false or self.acceptable_csz=false)));
 self                   := le;
end;

p2 := project(p1,t2(left));

//the only reason to have any filtering in new_header_records is to prevent a rapidly increasing MAX RID
keep_em       := p2(keep_record=true);
get_rid_of_em := p2(keep_record=false);

//Fix any funky DOBs
header.MAC_format_DOB(keep_em,dob,keep_em_better_dob)

//fix any funky prim_ranges
header.MAC_Improve_Prim_Range(keep_em_better_dob,prim_range,keep_em_better_pr)

//Patch where mname equals 'NMI' or 'NMN'
header.MAC_NMI_NMN(keep_em_better_pr,mname,keep_em_mname);

//Patch where phone exchange equals '555'
header.MAC_555_phones(keep_em_mname, phone, keep_em_555);
					 
//Patch to filter bad names
check_for_junk := header.BogusNames(keep_em_555.fname,keep_em_555.mname,keep_em_555.lname) 
               or header.boguscities(keep_em_555.city_name,keep_em_555.st);
			   
good_names0    := keep_em_555(not check_for_junk);

good_names1:=header.fn_character_swapping(project(good_names0,header.Layout_New_Records));

ut.mac_flipnames(good_names1,fname,mname,lname,good_names2);

Header.mac_Fix_Suffix(good_names2,good_names3);

header.Mac_clean_trustee_name(good_names3,good_names4);

address.Mac_Is_Business_Parsed(good_names4,good_names5);
good_names6 := good_names5(nametype='P');

good_names  := good_names6(fname<>'' and lname<>'');

new_recs := project(good_names,header.layout_new_records);

//remove duplicate source records after they were slimed into header format
dis_use := distribute(new_recs,hash(fname,lname,zip,zip4));
use_srt := sort(dis_use
				,src
				,fname
				,mname
				,lname
				,name_suffix
				,phone
				,ssn
				,dob
				,prim_range
				,predir
				,prim_name
				,suffix
				,postdir
				,unit_desig
				,sec_range
				,city_name
				,st
				,zip
				,zip4
				,county
				,local);


use_record_d := rollup(use_srt,
						left.src        =right.src         and
						(		~Mdr.SourceTools.SourceIsDL(left.src)
							or left.vendor_id=right.vendor_id)    and
						left.fname      =right.fname       and
						left.mname      =right.mname       and
						left.lname      =right.lname       and
						left.name_suffix=right.name_suffix and
						left.phone      =right.phone       and
						left.ssn        =right.ssn         and
						left.dob        =right.dob         and
						left.prim_range =right.prim_range  and
						left.predir     =right.predir      and
						left.prim_name  =right.prim_name   and
						left.suffix     =right.suffix      and
						left.postdir    =right.postdir     and
						left.unit_desig =right.unit_desig  and
						left.sec_range  =right.sec_range   and
						left.city_name  =right.city_name   and
						left.st         =right.st          and
						left.zip        =right.zip         and
						left.zip4       =right.zip4        and
						left.county     =right.county
						,t_rollup(left,right),local);


nhr:=use_record_d;
bkh:=Header.File_header_raw_blanked_history;
dnhr := distribute(nhr,hash(prim_name,zip,lname));
dbkh := distribute(bkh,hash(prim_name,zip,lname));

j :=  join(dnhr, dbkh,
				left.vendor_id  =right.vendor_id   and
				left.src        =right.src         and
				left.fname      =right.fname       and
				left.mname      =right.mname       and
				left.lname      =right.lname       and
				left.name_suffix=right.name_suffix and
				left.phone      =right.phone       and
				left.ssn        =right.ssn         and
				left.dob        =right.dob         and
				left.prim_range =right.prim_range  and
				left.predir     =right.predir      and
				left.prim_name  =right.prim_name   and
				left.suffix     =right.suffix      and
				left.postdir    =right.postdir     and
				left.unit_desig =right.unit_desig  and
				left.sec_range  =right.sec_range   and
				left.city_name  =right.city_name   and
				left.st         =right.st          and
				left.zip        =right.zip         and
				left.zip4       =right.zip4        and
				left.county     =right.county
				,transform(left)
				,left only
				,local
				);

tt1:=table(nhr,{src,cnt:=count(group)},src,few);
tt2:=table(j,{src,cnt:=count(group)},src,few);
output(tt1,named('NhrBefore_src_cnt'),all);
output(tt2,named('NhrAfter_src_cnt'),all);
return j;

end;