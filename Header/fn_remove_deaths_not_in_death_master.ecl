import mdr,Death_Master;
//SSA routinely provides updates whereby they remove SSN's from their list
//of deceased people.  those updates are not being applied to the header.
//since the SSN may have value for linking, for now just apply this to the keys

export fn_remove_deaths_not_in_death_master(dataset(recordof(header.layout_header)) in_file) := function

in_file_strings := project(in_file,header.layout_header_strings);

ds:=header.file_state_death(length(trim(ssn))=9 and fname<>'' and lname<>'');
dr:=Death_Master.Files.Resurrections(length(trim(ssn))=9 and fname<>'' and lname<>'');
d1:=join( ds ,dr
			,left.ssn=right.ssn
			and (
						(   left.fname=right.fname
						and left.lname=right.lname)
						or
						(   left.fname=right.lname
						and left.lname=right.fname)
					)
		,transform(left)
		,left only
		,lookup
	  );
d2 := header.file_did_death_masterv2(length(trim(ssn))=9 and fname<>'' and lname<>'');

slim:={
d1.fname
,d1.lname
,d1.ssn
};

ds_deaths := project(d1,slim) + project(d2,slim);

ds_deaths_dist := distribute(ds_deaths,hash(ssn));
ds_deaths_sort := sort      (ds_deaths_dist,ssn,fname,lname,local);
ds_deaths_dupd := dedup     (ds_deaths_sort,ssn,fname,lname,local);

ds_hdr_deaths      := in_file_strings(  mdr.sourcetools.sourceisdeath(src) and length(trim(ssn))=9 and fname<>'' and lname<>'');
ds_not_hdr_deaths  := in_file_strings(~(mdr.sourcetools.sourceisdeath(src) and length(trim(ssn))=9 and fname<>'' and lname<>''));
ds_hdr_deaths_dist := distribute(ds_hdr_deaths,hash(ssn));

j1 := join(ds_hdr_deaths_dist,ds_deaths_dupd
				,left.ssn=right.ssn
				and (
							(   left.fname=right.fname
							and left.lname=right.lname)
							or
							(   left.fname=right.lname
							and left.lname=right.fname)
						)
			,transform(left)
			,local
		  );

concat := j1+ds_not_hdr_deaths;

back_to_orig_layout := distribute(project(concat,header.layout_header),hash(did));

return back_to_orig_layout;

end;