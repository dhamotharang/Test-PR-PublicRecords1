//Excludes fnames or mnames from best calculation when they have already been picked as best lname or best fname
import header, watchdog;
export Mac_Exclude_as_Best(in_file, out_file, name_field) := macro
//values for name_field: 
//mname (will check against best lname and best fname)
//fname (will check against best lname)

#uniquename(temp_ly)
%temp_ly% := RECORD
  unsigned did;
  string name;
END;
#uniquename(best_fname)
%best_fname% := dataset('persist::watchdog_bestfname',{ unsigned6 did, qstring20 fname, integer4 fname_count }, thor);
#uniquename(best_lname)
%best_lname% := watchdog.File_Best;
 
#uniquename(del_already_lname)
%del_already_lname% := join(distribute(in_file, hash(did)),
																		distribute(%best_lname%, hash(did)),
																		left.did = right.did and
																		#if(name_field = 'mname')
																		left.mname = right.lname,
																		#else
																		left.fname = right.lname,
																		#end
																		transform(recordof(in_file), self := left),
																		left only, 
																		local);

#uniquename(del_already_fname)					
%del_already_fname% := join(distribute(%del_already_lname%, hash(did)),
																		distribute(%best_fname%, hash(did)),
																		left.did = right.did and
																		left.mname = right.fname,
																		transform(recordof(%del_already_lname%), self := left),
																		left only, 
																		local);
																		

out_file := if(name_field = 'mname' , %del_already_fname%, %del_already_lname%);
endmacro;