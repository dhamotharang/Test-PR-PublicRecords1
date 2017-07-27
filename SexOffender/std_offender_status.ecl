export std_offender_status(string in_status) := function
   clean_status := stringlib.StringToUpperCase(trim(in_status));
   return 
     map(clean_status in ['STATE INCARCERATION', 
	                     'COUNTY INCARCERATION',
					 'INCARCERATED',
					 'FEDERAL INCARCERATION',
					 'INS CUSTODY',
					 'NON-COMPLIANT/INCARCERATED',
					 'INCARCERATED NOT REGISTERED',
					 'INCARCERATED REGISTERED'] => 'C', //in custody
	   clean_status in ['DEPORTED',
	                    'REPORTED DECEASED',
					'DECEASED'] => 'D',  //deported or deceased 
				                    'O'); //others 
end;