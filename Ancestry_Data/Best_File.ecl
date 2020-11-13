Import Ancestry_Data, ut;

Export best_file( string pVersion ) := Function

// Input from dependency files
d2c_best := Ancestry_Data.Files.infutor_best(fname<>'' or lname<>'');

// All layouts 
best_file_output := Ancestry_Data.Layouts.best_file_output;
layout_infutor_best := Ancestry_Data.Layouts.layout_infutor_best;


infutor_best_processed := project(d2c_best, transform(layout_infutor_best,
						  self.LexID := left.did;
						  self.first := left.fname;
						  self.middle := left.mname;
						  self.last := left.lname;
						  self.suffix := left.name_suffix;
						  self.address_suffix := left.suffix;
						  self.city := left.city_name;
						  self.state := left.st;
						  self.date_first_seen := (unsigned3)(((string8)left.addr_dt_first_seen)[1..6]);
						  self.date_last_seen := (unsigned3)(((string8)left.addr_dt_last_seen)[1..6]);
						  self := left;
						  ));


final_dataset := project(infutor_best_processed, transform(best_file_output,
				city_name := trim(left.city, right);
				self.first := trim(left.first, right);
				self.middle := trim(left.middle, right);
				self.last := trim(left.last, right);
				self.suffix := trim(ut.fGetSuffix(left.suffix), right);
				self.line1 := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.address_suffix + ' ' + left.postdir + ' ' + IF(left.sec_range='','',left.unit_desig+' '+left.sec_range) );
				self.line2 := stringlib.stringcleanspaces(city_name + ', ' + left.state + ' ' + left.zip);
				self := left;
				));

outputDS := sort(final_dataset, LexID); // sort is not local to analyze data LExids start from 5 and up
				
Return outputDS;

End;