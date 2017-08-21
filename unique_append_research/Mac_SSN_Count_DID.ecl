export MAC_SSN_Count_DID(infile,outfile,ssn_field,fname_field,mname_field,lname_field,bool_has_name = 'false', bool_has_mname = 'false') := MACRO

#uniquename(r)
%r% := record
 #if(bool_has_name and bool_has_mname)
  infile.fname_field;
	infile.mname_field;
  infile.lname_field;
  infile.ssn_field;
#elseif(bool_has_name)
  infile.fname_field;
	infile.mname_field;
  infile.lname_field;
  infile.ssn_field;
#else
  infile.ssn_field;
#end
	unsigned8 cnt := count(group);
  end;

#if(bool_has_name and bool_has_mname)
	
outfile := table(infile,%r%,ssn_field,fname_field,mname_field,lname_field,merge); // uses new thor feature
 #elseif(bool_has_name)
	
outfile := table(infile,%r%,ssn_field,fname_field,lname_field,merge); // uses new thor feature
#else
outfile := table(infile,%r%,ssn_field,merge); // uses new thor feature
#end
endmacro;