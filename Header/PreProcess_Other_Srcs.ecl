import header, ut, mdr, address, NID,dx_header;
//Get new header records for sources other than EQ
inNHR := header.New_Header_Records(true) : persist ('~thor400::new_fheader_records');
NHRin := distribute(inNHR,hash(prim_name,zip,lname));

inPHR:=file_header_raw(header.Blocked_data_new()) + projecT(Header.File_TN_did,dx_header.layout_header);
PHin  := distribute(inPHR,hash(prim_name,zip,lname));

//Did is persisted in "as_header" for fast header 
//keep anything new; this includes dt_last_seen
j_all_ :=  join(PHin, NHRin,
				left.src        =right.src         and
				left.fname      =right.fname       and
				(left.mname[1]  = right.mname[1]         or
				(left.mname <> '' and right.mname = '')) and
				left.lname      =right.lname       and
				(left.name_suffix  = right.name_suffix         or
				(left.name_suffix <> '' and right.name_suffix = '')) and
				(left.phone      =right.phone or
				(left.phone <> '' and right.phone = '')) and
				(left.ssn        =right.ssn         or
				(left.ssn <> '' and right.ssn = '')) and
				(left.dob        =right.dob         or
				(left.dob <> 0 and right.dob = 0)) and
				left.prim_range =right.prim_range  and
				left.predir     =right.predir      and
				left.prim_name  =right.prim_name   and
				left.suffix     =right.suffix      and
				left.postdir    =right.postdir     and
				ut.NNEQ(left.unit_desig , right.unit_desig)  and
				left.sec_range  =right.sec_range   and
				left.city_name  =right.city_name   and
				left.st         =right.st          and
				left.zip        =right.zip         and
				left.zip4       =right.zip4        and
				left.county     =right.county      and
				left.dt_last_seen>=right.dt_last_seen
				,transform(right)
				,right only
				,local
				): persist('~thor400::persist::basic_match_fheader');
			
outf_noID := dedup(j_all_,record,all,local);

r_nbm := record
	outf_noID.src;
	string30 src_desc := mdr.sourcetools.translatesource(outf_noID.src);
	count_            := count(group);
end;              

//these are the records not seen before
ta1_ := sort(table(outf_noID,r_nbm,src,few),-count_);
output(ta1_,all,named('no_basic_match'));

new_month_joined := outf_noID;
export PreProcess_Other_Srcs := new_month_joined;