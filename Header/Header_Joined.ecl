import header,ut,address,mdr,idl_header,watchdog,strata,AID,STD;

export header_joined(string versionBuild=Header.version_build) := module

inNHR := header.New_Header_Records()(header.Blocked_data_new())
        : persist ('~thor400_data::new_header_records_'+ versionBuild,expire(60)); // we need this for rid_srid key build

// First address re-clean is ONLY for ingested records
header.macGetCleanAddr(inNHR, RawAID, true, inNHR_addr_recleaned);
NHRin := distribute(inNHR_addr_recleaned,hash(prim_name,zip,lname));

inPHR0 := Header.File_header_raw_latest.File(~header.IsOldUtil(versionBuild));
inPHR  := inPHR0(header.Blocked_data_new());
PHin   := distribute(inPHR,hash(prim_name,zip,lname));

header.Layout_New_Records add_rid_all(PHin l, NHRin r) := transform
 self.rid            := l.rid;
 self.did            := l.did;
 self                := r;
end;

//Basic  Match - a one to one join - basic assumption here is:
 //that there are absolutely no duplicates in the left nor the right side
j_all_new :=  join(PHin, NHRin,
				left.src        =right.src         and
// Bug: 173413
// this change is in conjunction with other changes made in:
// Header.New_Header_Records
// DriversV2.dls_as_header
// Header.Mac_dedup_header
				(~Mdr.SourceTools.SourceIsDL(left.src)
					or 
					(Mdr.SourceTools.SourceIsDL(left.src)
					and left.vendor_id=right.vendor_id) ) and
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
				,add_rid_all(left,right)
				,right outer
				,local
				): persist(                     '~thor_data400::persist::hbm::'+ versionBuild ,expire(60),REFRESH(FALSE));

j_all:= if(nothor(std.file.fileexists(  '~thor_data400::persist::hbm::'+ versionBuild )) 
                         ,dataset(      '~thor_data400::persist::hbm::'+ versionBuild ,header.Layout_New_Records,thor)
                         ,j_all_new);

outf_noID := dedup(j_all,record,all,local);

oNMNHR    := outf_noID(rid=0);
oMNHR     := outf_noID(rid>0);

r_nbm := record
	oNMNHR.src;
	string30 src_desc := mdr.sourcetools.translatesource(oNMNHR.src);
	count_            := count(group);
end;

//these are the records not seen before
ta1 := sort(table(oNMNHR, r_nbm, src, few), -count_);
//Strata.modOrbitAdaptersForPersonHdrBld.fnGetNoBasicMatchAction(ta1, header.version_build);
output(ta1, all, named('no_basic_match_incremental'));

//these are the records not seen before since the previous monthly build
mxr_monthly := max(Header.File_Latest_Header_Raw(FALSE),rid);
oNMNHRM := oNMNHR+oMNHR(rid>mxr_monthly);
output(mxr_monthly,named('max_rid_previous_month'));
r_nbm2 := record
	oNMNHRM.src;
	string30 src_desc := mdr.sourcetools.translatesource(oNMNHRM.src);
	count_            := count(group);
end;
ta2 := sort(table(oNMNHRM, r_nbm2, src, few), -count_);
Strata.modOrbitAdaptersForPersonHdrBld.fnGetNoBasicMatchAction(ta2,  versionBuild);
output(ta2, all, named('no_basic_match_monthly'));

ut.MAC_Sequence_Records(oNMNHR,uid,outfile1);

outf := outfile1 + oMNHR;
mxr:=max(Header.File_header_raw_latest.File,rid);
header.Layout_Header to_form(outf l) := transform
	self.rid    := IF (l.rid=0,mxr+l.uid,l.rid);
	self.did    := IF (l.did=0,mxr+l.uid,l.did);
	self.pflag1 := MAP(l.did=0=>'A',l.rid=0=>'P','+');
	self := l;
end;

new_month_joined := when(project(outf,to_form(left)),output(mxr,named('mxr')));

Header.Layout_header blank_pflag(inPHR l) := transform
	self.pflag1 := ''; // old rolled header records - no longer Reported (NLR)
	self        := l;
end;

//append NLR
pnew := project(inPHR,blank_pflag(left))(header.Blocked_data_new()) + new_month_joined;

dpnew:=dedup(sort(distribute(pnew,hash32(rid,zip,fname,lname)),rid,zip,fname,lname,local),rid,zip,fname,lname,ORDERED(true),local);

nneq(string s1, string s2) := if (s1<>'' AND s2<>'' AND s1<>s2,true,false);

{dpnew} chk(dpnew L, dpnew R) :=transform, skip(~(L.rid=R.rid AND 
																																															( nneq(L.zip,R.zip) OR 
																																															  nneq(L.zip,R.zip) OR
																																																 nneq(L.zip,R.zip)   )
																																														))
  self:=R

end;

duplicate_rids_with_bad_pii:=iterate(dpnew,chk(LEFT,RIGHT),local);

output(duplicate_rids_with_bad_pii,named('duplicate_rids_with_bad_pii'));
output(count(duplicate_rids_with_bad_pii),named('cnt_duplicate_rids_with_bad_pii'));
assert(count(duplicate_rids_with_bad_pii)=0,'duplicate rids with mismatching pii found',fail);

Header.MAC_Merge_ByRid(pnew, merged);

merged_with_prim := merged(  (prim_range<>'' OR prim_name<>''));
merged_no_prim   := merged( ~(prim_range<>'' OR prim_name<>''));

// Second address re-clean for all records going into base..raw
header.macGetCleanAddr(merged_with_prim, RawAID, true, merged_with_prim_addr_recleaned); 

merged_addr_recleaned := merged_no_prim + merged_with_prim_addr_recleaned;

OldUtil := Header.File_Latest_Header_Raw(TRUE)(header.IsOldUtil(versionBuild));
patched:=Header.fn_clear_deletion_candidates(merged_addr_recleaned + OldUtil,versionBuild);//****** remove PII off deleted records

patched1:=header.fn_fix_dates(patched,,versionBuild);
patched2:=header.fn_remove_post_header_joined(patched1);

if ( count(patched2(did>rid)) <> 0, output('DID > RID constraint violated') );
output(table(patched2(fname='',lname=''),{src,cnt:=count(group)},src,few),named('BlankedRecordsCountBySource'),all);

newblanks := patched2(  (rid>mxr_monthly AND pflag1='A' AND fname='' AND lname='') ):persist('~persist::header::new_blanks::'+versionBuild); // new blanks
patched3  := patched2( ~(rid>mxr_monthly AND pflag1='A' AND fname='' AND lname='') ); // not new blanks


output(table(newblanks,{src,cnt:=count(group)},src,few),named('BlankedNewRecordsRemoved'),all);

export final := patched3 : persist('Header_Joined::'+ versionBuild,expire(60));

end;