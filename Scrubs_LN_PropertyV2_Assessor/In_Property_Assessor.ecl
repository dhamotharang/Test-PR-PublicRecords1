import ln_propertyv2, ut, LN_PropertyV2_Fast;
EXPORT In_Property_Assessor (string1 source, string version = '') := function


File_Assessment_delta := LN_PropertyV2_Fast.Files.base.assessment;
File_Assessment_full := LN_PropertyV2.File_Assessment;

MaxprocessDate := if(version = '', Max(File_Assessment_full + File_Assessment_delta,process_date), version);

RecsforDate := if(count(File_Assessment_delta( process_date[..8] = MaxprocessDate)) > 0, 
																	File_Assessment_delta( process_date[..8] = MaxprocessDate),
																	File_Assessment_full( process_date[..8] = MaxprocessDate)) :INDEPENDENT;	
												
File_source := if(source = 'O', RecsforDate (vendor_source_flag = source), RecsforDate (vendor_source_flag <> 'O'));

/*
  LN_   := File_Assessment(vendor_source_flag ='O');
   Fares := File_Assessment(vendor_source_flag in ['F','S']);

   MaxprocessDateLN    := Max(LN_,process_date); 
   MaxProcessDateFares := Max(Fares,process_date);*/

/*In_Property_Assessor_ := LN_ ( process_date[..6] = MaxprocessDateLN and vendor_source_flag = source_flag) +  
	                      Fares( process_date[..6] = MaxProcessDateFares and vendor_source_flag = source_flag);
	*/
	

 new_ly := record
 recordof (File_Assessment_full);
 string11 assessed_land_improvement_value;
 string11 market_land_improvement_value;
 string5 fips;
 end;
	
In_Property_Assessor := project(File_source,
															transform(new_ly, 
															self.assessed_land_value := if(left.assessed_land_value = '', '0',left.assessed_land_value),
															self.assessed_improvement_value := if(left.assessed_improvement_value= '', '0',left.assessed_improvement_value),
															self.assessed_total_value := if(left.assessed_total_value= '', '0',left.assessed_total_value),
															self.market_land_value := if(left.market_land_value= '', '0',left.market_land_value),
															self.market_improvement_value := if(left.market_improvement_value= '', '0',left.market_improvement_value),
															self.market_total_value := if(left.market_total_value = '', '0',left.market_total_value),
															self.assessed_land_improvement_value := if(self.assessed_land_value <> '0' or self.assessed_improvement_value <> '0', (string) ((unsigned)left.assessed_land_value +  (unsigned)left.assessed_improvement_value), self.assessed_total_value),
															self.market_land_improvement_value :=  if(self.market_improvement_value <> '0' or self.market_land_value <> '0', (string)((unsigned)left.market_land_value +  (unsigned)left.market_improvement_value), self.market_total_value),
															self.fips := left.fips_code;	
															self := left));
return 	In_Property_Assessor;		
end;								 