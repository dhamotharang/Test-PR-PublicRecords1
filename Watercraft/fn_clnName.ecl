import watercraft,Address;

export fn_clnName(DATASET(recordof(Watercraft.Layout_Watercraft_Search_Group)) ds) := function

statestoclean := ['FL','NC'];

recordof(ds) prjt(recordof(ds) l) := transform

             clean_name            := Address.Clean_n_Validate_Name(l.orig_name,'L',85); 
 boolean v_company_flag            := if(clean_name.full_name='',true,false);
 boolean v_orig_cleaned_as_company := l.company_name<>'';
 
 //let's only re-clean records that originally cleaned as a company
 self.company_name := if(l.state_origin in statestoclean and v_orig_cleaned_as_company,
                       if(v_company_flag,l.company_name,''),
					  l.company_name);
 self.clean_pname  := if(l.state_origin in statestoclean and v_orig_cleaned_as_company,
                       if(not v_company_flag,l.clean_pname,clean_name.full_name),
					  l.clean_pname);
 self.dob := if (l.state_origin = 'AL' and l.dob = '20000101', '', l.dob); 
 self := l;
end;

recleaned := project(ds,prjt(left));

return recleaned;

end;
