EXPORT Mac_SSN_By_DID(infile,outfile,did_field,ssn_field,fname_field,mname_field,lname_field,bool_infile_has_name = 'false', bool_infile_has_mname = 'flase') := MACRO
#if(bool_infile_has_name and bool_infile_has_mname)
 outfile :=  dedup ( sort(table(infile,{did_field,ssn_field,fname_field, mname_field,lname_field}),did_field,ssn_field,fname_field,mname_field,lname_field,local), did_field,ssn_field,fname_field,mname_field,lname_field,local );
#elseif(bool_infile_has_name)
 outfile :=  dedup ( sort(table(infile,{did_field,ssn_field,fname_field,mname_field,lname_field}),did_field,ssn_field,fname_field,lname_field,local), did_field,ssn_field,fname_field,lname_field,local );
#else 
  outfile :=  dedup ( sort(table(infile,{did_field,ssn_field}),did_field,ssn_field,local), did_field,ssn_field,local );
#end

endmacro;
