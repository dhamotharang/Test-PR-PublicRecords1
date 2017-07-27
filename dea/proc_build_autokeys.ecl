import AutoKeyB2; 

export proc_build_autokeys(string filedate) := function

b_in := DEA.File_Dea_Doxie;
// b_in := DEA.File_DEA; - Maybe this file should be used because
				    // the DEA.File_Dea_Doxie points to thor_data400::base::dea_BUILDING, which is empty.

sep_rec := record
b_in;
string10 cprim_range;
string28 cprim_name;
string8  csec_range;
string25 cv_city_name;
string2  cst;
string5  czip;
unsigned1 zero := 0;
unsigned6 inDID;
unsigned6 inBDID;
end;

sep_rec into_bus(b_in L) := transform
 self.prim_range := if(l.is_company_flag,'',l.prim_range);
 self.prim_name := if(l.is_company_flag,'',l.prim_name);
 self.sec_range := if(l.is_company_flag,'',l.sec_range);
 self.v_city_name := if(l.is_company_flag,'',l.v_city_name);
 self.st := if(l.is_company_flag,'',l.st);
 self.zip := if(l.is_company_flag,'',l.zip);
 self.cprim_range := if(l.is_company_flag,l.prim_range,'');
 self.cprim_name := if(l.is_company_flag,l.prim_name,'');
 self.csec_range := if(l.is_company_flag,l.sec_range,'');
 self.cv_city_name := if(l.is_company_flag,l.v_city_name,'');
 self.cst := if(l.is_company_flag,l.st,'');
 self.czip := if(l.is_company_flag,l.zip,'');
 self.inDID := (unsigned6)l.did;
 self.inBDID := (unsigned6)l.bdid;
 self := l;
end;

b := project(b_in,into_bus(left));

skip_set := Dea.Constants('').skip_set;

AutoKeyB2.MAC_Build (b,
					fname,mname,lname,
					best_ssn,
					zero,
					zero,
					prim_name,prim_range,st,v_city_name,zip,sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					inDID,
					cname,
					zero,
					zero,
					cprim_name,cprim_range,cst,cv_city_name,czip,csec_range,
					inbdid,
					Constants(filedate).ak_keyname,
					Constants(filedate).ak_logical,
					outaction,false,
					skip_set,true,,
					true,,,zero) 

AutoKeyB2.MAC_AcceptSK_to_QA(Constants(filedate).ak_keyname, mymove)

retval := sequential(outaction,mymove);

 
return retval;

end;

