EXPORT MAC_Add_DOB_By_DID(infile, did_field, dob_field, outfile,glb = 'true') := macro

#uniquename(should_join)
%should_join% := infile.did_field > 0;

#uniquename(infile_attempt)
#uniquename(infile_skip)
%infile_attempt% := infile(%should_join%);
%infile_skip% := infile(~%should_join%);

#uniquename(dw)
#uniquename(dwng)
%dw% := watchdog.file_best(dob > 0);
%dwng% := watchdog.File_Best_nonglb(dob > 0);

#uniquename(infile_dist)
%infile_dist% := distribute(%infile_attempt%, hash((unsigned6)did_field));

#uniquename(add_dob)
typeof(infile) %add_dob%(infile l, %dw% r) := transform
	self.dob_field := r.dob;
	self :=l;
end;

#uniquename(add_dob_nglb)
typeof(infile) %add_dob_nglb%( infile L,%dwng% R) := transform
	self.dob_field := R.dob;
	self := L;
end;


#uniquename(dob_added)
#if (glb)
%dob_added% := join(%infile_dist%,%dw%,
				  left.did_field = right.did,
				  %add_dob%(left, right),
				  left outer,
				  local);
#else
%dob_added% := join(%infile_dist%,%dwng%,
				left.did_field = right.did,
				  %add_dob_nglb%(left, right),
				  left outer,
				  local);
#end

//****** Add back those that skipped over
outfile := %dob_added% + %infile_skip%;
endmacro;