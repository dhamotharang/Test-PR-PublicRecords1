export MAC_Add_SSN_By_DID(infile, did_field, ssn_field, outfile,glb = 'true') := macro

IMPORT watchdog;

#uniquename(should_join)
%should_join% := infile.did_field > 0; // and (integer)infile.ssn_field = 0;

#uniquename(infile_attempt)
#uniquename(infile_skip)
%infile_attempt% := infile(%should_join%);
%infile_skip% := infile(~%should_join%);

#uniquename(dw)
#uniquename(dwng)
%dw% := watchdog.file_best(ssn != '');
%dwng% := watchdog.File_Best_nonglb(ssn != '');

#uniquename(infile_dist)
%infile_dist% := distribute(%infile_attempt%, hash((unsigned6)did_field));

#uniquename(add_ssn)
typeof(infile) %add_ssn%(infile l, %dw% r) := transform
	self.ssn_field := r.ssn;
	self :=l;
end;

#uniquename(add_ssn_nglb)
typeof(infile) %add_ssn_nglb%( infile L,%dwng% R) := transform
	self.ssn_field := R.ssn;
	self := L;
end;


#uniquename(ssn_added)
#if (glb)
%ssn_added% := join(%infile_dist%,%dw%,
				  left.did_field = right.did,
				  %add_ssn%(left, right),
				  left outer,
				  local);
#else
%ssn_added% := join(%infile_dist%,%dwng%,
				left.did_field = right.did,
				  %add_ssn_nglb%(left, right),
				  left outer,
				  local);
#end

//****** Add back those that skipped over
outfile := %ssn_added% + %infile_skip%;
endmacro;
