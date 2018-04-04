import header, doxie_build;
export fn_header_joined(dataset(recordof(header.layout_new_records)) in_file) := function

infile_dist  := distribute(in_file,hash(prim_name,zip,lname));
//FCRA header 
//PL_Header := doxie_build.File_FCRA_header_building(src = 'PL');
PL_Header := header.File_FCRA_headers(fname <> '' and prim_name <> '' and src = 'PL');
//PL_Header := header.File_header_raw(fname <> '' and prim_name <> '' and src = 'PL');

PL_HR_dist := distribute(PL_Header,hash(prim_name,zip,lname));

header.Layout_New_Records add_rid_all(infile_dist l, PL_HR_dist r) := transform
 self.rid            := r.rid;
 self.did            := r.did;
 self.persistent_record_ID := r.persistent_record_ID;
 self                := l;
end;

//Basic  Match - a one to one join - basic assumption here is:
 //that there are absolutely no duplicates in the left nor the right side
PL_matched :=  join(infile_dist, PL_HR_dist,

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
				,left outer
				,local
				);
			
PL_matched_out := dedup(PL_matched,record,all,local);
oNMNHR    := PL_matched_out(rid=0);
oMNHR     := PL_matched_out(rid>0);

return PL_matched_out;
end;