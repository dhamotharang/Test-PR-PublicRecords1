//get penalt point for dataset with child dataset(s), pick the lowest score of 
//each child dataset and add up as the total penalt point 

export Mac_CHD_Penalty(prov_in_file, prov_out_file, 
                       name_child, fname_field, mname_field, lname_field,
				   ssn_flag, ssn_child, ssn_field,
				   dob_flag, dob_child, dob_field,
				   county_flag, addr_child, 
				     predir_field,prange_field,pname_field,
					suffix_field,postdir_field,sec_range_field,
					city_field,county_field,state_field,zip_field,
				   phone_flag, phone_child, phone_field, filter='false') := macro

#uniquename(w_penalt_rec)
%w_penalt_rec% := record
   unsigned1 penalt := 0,
   prov_in_file,
end;

#uniquename(in_w_penalt)
%in_w_penalt% := table(prov_in_file, %w_penalt_rec%);

#uniquename(penalt_rec)
%penalt_rec% := record
	unsigned1 penalt_pt,
end; 

#uniquename(get_penalt)
%w_penalt_rec% %get_penalt%(%in_w_penalt% l) := transform
    self.penalt := 
        min (project (l.name_child, transform(%penalt_rec%,self.penalt_pt := doxie.FN_Tra_Penalty_Name (Left.fname_field, Left.mname_field, Left.lname_field))),
             penalt_pt) + 
				#if(ssn_flag)
				min (project(l.ssn_child, transform(%penalt_rec%,self.penalt_pt := doxie.FN_Tra_Penalty_SSN (left.ssn_field),
             penalt_pt) +     
				#end
				#if(dob_flag)
				min (project(l.dob_child, transform(%penalt_rec%, self.penalt_pt := doxie.FN_Tra_Penalty_DOB (left.dob_field))),
             penalt_pt) + 
				#end	
				min(project(l.addr_child, transform(%penalt_rec%, 
            self.penalt_pt := doxie.FN_Tra_Penalty_Addr (left.predir_field, left.prange_field, left.pname_field, left.suffix_field,
                                                         left.postdir_field, '', left.city_field, left.state_field,
                                                         left.zip_field)
                              #if(county_flag) 
                              + doxie.FN_Tra_Penalty_Addr (left.county_field)
                              #end
                              )),              
             penalt_pt) + 
				#if(phone_flag)
        min (project (l.phone_child, transform(%penalt_rec%, self.penalt_pt := doxie.Fn_Tra_Penalty_Phone (left.phone_field))),
				     penalt_pt) +     
        #end
					0;
	self := l;
end;						 

#uniquename(out_w_penalt)				 
%out_w_penalt% := project(%in_w_penalt%, %get_penalt%(left));

prov_out_file := if(filter, %out_w_penalt%(penalt<score_threshold_value), %out_w_penalt%);
	
endmacro;
