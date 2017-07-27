EXPORT fnIsInsufficientInput(report_by) := functionmacro

  streetNotBlank := ( report_by.Address.StreetNumber <> '' and  
                      report_by.Address.StreetName <> '') OR
                      report_by.Address.StreetAddress1 <> '';
  
  isNotEnough    := map( 
											report_by.Name.First <> ''    and 
											report_by.Name.Last <> ''     and  
											report_by.SSN <> ''           and  
											streetNotBlank                and
											((report_by.Address.City <> ''  and   
											report_by.Address.State <> '') or
											report_by.Address.Zip5 <> '')  and
											report_by.IdentityType = ChildIdentityFraudSolutionServices.Constants.IdentityTypeIndicator.ADULT 
									=> false,
											report_by.Name.First <> ''    and 
											report_by.Name.Last <> ''     and  
											report_by.SSN <> ''           and  
											report_by.IdentityType = ChildIdentityFraudSolutionServices.Constants.IdentityTypeIndicator.DEPENDENT
									=> false,
											true
											);
                return(isNotEnough);
endmacro;
