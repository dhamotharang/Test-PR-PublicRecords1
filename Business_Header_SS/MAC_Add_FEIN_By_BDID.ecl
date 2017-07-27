export MAC_Add_FEIN_By_BDID(infile, bdid_field, fein_field, outfile) := macro

#uniquename(should_join)
%should_join% := (unsigned6)infile.bdid_field > 0; // and (integer)infile.ssn_field = 0;

#uniquename(infile_attempt)
#uniquename(infile_skip)
%infile_attempt% := infile(%should_join%);
%infile_skip% := infile(~%should_join%);

#uniquename(bhb)
%bhb% := Business_Header.File_Business_Header_Best(fein > 0, business_header.ValidFEIN(fein));
#uniquename(dw)
%dw% := table(%bhb%, {%bhb%.bdid, %bhb%.fein});

#uniquename(infile_dist)
%infile_dist% := distribute(%infile_attempt%, hash((unsigned6)bdid_field));

#uniquename(add_fein)
typeof(infile) %add_fein%(infile l, %dw% r) := transform
	self.fein_field := if(r.fein = 0, '', intformat(r.fein,9,1));
	self :=l;
end;


#uniquename(fein_added)
%fein_added% := join(%infile_dist%,distribute(%dw%, hash((unsigned6)bdid)),
				  (unsigned6)left.bdid_field = right.bdid,
				  %add_fein%(left, right),
				  left outer,
				  local);

//****** Add back those that skipped over
outfile := %fein_added% + %infile_skip%;
endmacro;