import doxie_files;
export MAC_Add_DL_By_DID(infile, did_field, DL_number_field, outfile) := macro

#uniquename(should_join)
%should_join% := infile.did_field > 0;

#uniquename(infile_attempt)
#uniquename(infile_skip)
%infile_attempt% := infile(%should_join%);
%infile_skip% := infile(~%should_join%);

#uniquename(dl)
%dl% := dedup(sort(doxie_files.File_dl(did > 0, dl_number <> ''), did, dl_number, -dt_vendor_first_reported), did, dl_number);
#uniquename(dld)
%dld% := table(%dl%, {%dl%.did, %dl%.dl_number});

#uniquename(infile_dist)
%infile_dist% := distribute(%infile_attempt%, hash(did_field));

#uniquename(add_dl)
typeof(infile) %add_dl%(infile l, %dld% r) := transform
	self.dl_number_field := r.dl_number;
	self :=l;
end;


#uniquename(dl_added)
%dl_added% := join(%infile_dist%,distribute(%dld%, hash(did)),
				  left.did_field = right.did,
				  %add_dl%(left, right),
				  left outer,keep(1),
				  local);

//****** Add back those that skipped over
outfile := %dl_added% + %infile_skip%;
endmacro;