
IMPORT Data_Services, ut,doxie, risk_indicators, VerificationOfOccupancy;

EXPORT VerificationOfOccupancy_Report_keys := MODULE

	shared locat := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::VOOreport::';

	
	d := Seed_Files.VerificationOfOccupancy_Report_files.Summary;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(
																									trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring); 
	  d;
	end;
	newtable := table(d, newrec);
	export Summary := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'Summary_'+ doxie.Version_SuperKey);
											
											
											
											
											
	d := Seed_Files.VerificationOfOccupancy_Report_files.TargetSummary;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring); 
	 d;
	end;
	newtable := table(d, newrec);
	export TargetSummary := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'TargetSummary_'+ doxie.Version_SuperKey);									
											
											
											
	d := Seed_Files.VerificationOfOccupancy_Report_files.Sources;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring); 
	  d;
	end;
	newtable := table(d, newrec);
	export Sources := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'Sources_'+ doxie.Version_SuperKey);																																			 
		
		
		
		
	d := Seed_Files.VerificationOfOccupancy_Report_files.OwnedProperties;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring); 
	  d;
	end;
	newtable := table(d, newrec);
	export OwnedProperties := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'OwnedProperties_'+ doxie.Version_SuperKey);						
		
		
		
	d := Seed_Files.VerificationOfOccupancy_Report_files.OwnedPropertiesAsOf;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring); 
	  d;
	end;
	newtable := table(d, newrec);
	export OwnedPropertiesAsOf := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'OwnedPropertiesAsOf_'+ doxie.Version_SuperKey);			
		
																				 
	
		
	d := Seed_Files.VerificationOfOccupancy_Report_files.PhoneAndUtility;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring); 
	  d;
	end;
	newtable := table(d, newrec);
	export PhoneAndUtility := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'PhoneAndUtility_'+ doxie.Version_SuperKey);			
	
	
	
	
	
	
	d := Seed_Files.VerificationOfOccupancy_Report_files.AssociatedIdentities;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring); 
	  d;
	end;
	newtable := table(d, newrec);
	export AssociatedIdentities := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'AssociatedIdentities_'+ doxie.Version_SuperKey);			
	
	
	END;
	            
 