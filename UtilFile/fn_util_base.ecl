import utilfile;

export fn_util_base(dataset(UtilFile.layout_util.base) file_in) := function
//**** Filtered Business Utility records from the Utility file.
 
Util_bus_base := file_in(name_flag = 'B');

	//Reformat back to the standard format layout of the Base search file 
  //*** Function that makes the company name by concatenating the given name fields in the FMLS order.
	fMakeCompanyName(string lname, string fname, string mname, string sname) := function
		string100 cname	:=	if(length(trim(fname,left,right)) = 20, trim(fname) + trim(mname), 
														if(trim(fname) <> '', trim(fname)+ ' '+ trim(mname), trim(mname))) + 
												if(length(trim(mname,left,right)) = 20, trim(lname), 
														if(trim(mname) <> '',' '+ trim(lname),trim(lname))) + 
												if(length(trim(lname,left,right)) = 25, trim(sname), 
														if(trim(lname) <> '', ' '+trim(sname), trim(sname)));
		return trim(cname,left,right);
	end;
	
	UtilFile.Layout_Utility_Bus_Base tMarkUtilBusinessRecs(Util_bus_base l) := transform
		self.company_name	:=	fMakeCompanyName(trim(l.orig_lname), trim(l.orig_fname), trim(l.orig_mname), trim(l.orig_name_suffix));			
		self				:=	l;
	end;

	
	dUtilBusRecs := project(Util_bus_base, tMarkUtilBusinessRecs(left));
	
	return dUtilBusRecs;
	
	end;