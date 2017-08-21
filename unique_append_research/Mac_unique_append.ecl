
//MATCHSET should be set of char1's indicating matchfields
/*
   matchset   -    should be set of char1's indicating the indicatives in infile
                          'N' = name
                          'A' = Address
                          'D' = DOB
                          'S' = ssn
                          'P' = phone
    */                


export mac_unique_append
	(infile, matchset,	//see above
	 ssn_field, fname_field, mname_field,lname_field, suffix_field, 
	 DID_field, outfile,bool_has_name = 'false',bool_has_mname = 'false')
	 := macro

cnt_total := count(infile);
#if(bool_has_name)
h_has_SSN := infile((unsigned)ssn > 0  and TRIM(fname, left, right) <> '' and TRIM(lname, left, right) <> '');
#else
h_has_SSN := infile((unsigned)ssn > 0);
#end
#uniquename(outfile_count_ssn)
#if('S' in matchset)
	unique_append_research.Mac_SSN_By_DID(h_has_SSN,outfile_ssn,did_field,ssn_field,fname_field,mname_field,lname_field,bool_has_name, bool_has_mname)
	unique_append_research.Mac_SSN_Count_DID(outfile_ssn,outfile_count_ssn,ssn_field,fname_field,mname_field,lname_field,bool_has_name, bool_has_mname)
	unique_append_research.Mac_SSN_DID_stats(outfile_count_ssn, cnt_total, outfile_ssn_stats)

#else
	%outfile_count_ssn% := infile;
#end

outfile := outfile_ssn_stats;

endmacro;
