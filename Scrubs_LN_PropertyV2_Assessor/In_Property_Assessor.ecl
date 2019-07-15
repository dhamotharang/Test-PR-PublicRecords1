import ln_propertyv2, ut, LN_PropertyV2_Fast;
EXPORT In_Property_Assessor (string1 source, string version = '') := function


File_Assessment_delta := LN_PropertyV2_Fast.Files.base.assessment;
File_Assessment_full := LN_PropertyV2.File_Assessment;

MaxprocessDate := if(version = '', Max(File_Assessment_full + File_Assessment_delta,process_date), version);

// RecsforDate := if(count(File_Assessment_delta( process_date[..8] = MaxprocessDate)) > 0, 
																	// File_Assessment_delta( process_date[..8] = MaxprocessDate),
																	// File_Assessment_full( process_date[..8] = MaxprocessDate)) :INDEPENDENT;	
	RecsforDate:=File_Assessment_full( process_date[..4] = '2018');
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
															self.assessed_land_value := if(trim(left.assessed_land_value, all) = '', INTFORMAT(0, 11, 0),INTFORMAT((unsigned)trim(left.assessed_land_value, all), 11, 0)),
															self.assessed_improvement_value := if(trim(left.assessed_improvement_value, all) = '', INTFORMAT(0, 11, 0),INTFORMAT((unsigned)trim(left.assessed_improvement_value, all), 11, 0)),
															self.assessed_total_value := if(trim(left.assessed_total_value, all)= '', INTFORMAT(0, 11, 0),INTFORMAT((unsigned)trim(left.assessed_total_value, all), 11, 0)),
															self.market_land_value := if(trim(left.market_land_value, all)= '', INTFORMAT(0, 11, 0),INTFORMAT((unsigned)trim(left.market_land_value, all), 11, 0)),
															self.market_improvement_value := if(trim(left.market_improvement_value, all)= '', INTFORMAT(0, 11, 0),INTFORMAT((unsigned)trim(left.market_improvement_value, all), 11, 0)),
															self.market_total_value := if(trim(left.market_total_value, all) = '', INTFORMAT(0, 11, 0),INTFORMAT((unsigned)trim(left.market_total_value, all), 11, 0)),
															self.assessed_land_improvement_value := if((unsigned)self.assessed_land_value <> 0 or (unsigned) self.assessed_improvement_value <> 0, INTFORMAT( (unsigned)left.assessed_land_value +  (unsigned)left.assessed_improvement_value, 11, 0), INTFORMAT((unsigned) trim(self.assessed_total_value, all), 11, 0)),
															self.market_land_improvement_value :=  if((unsigned)self.market_improvement_value <> 0 or (unsigned)self.market_land_value <> 0, INTFORMAT((unsigned)left.market_land_value +  (unsigned)left.market_improvement_value, 11, 0),INTFORMAT((unsigned) trim(self.market_total_value, all), 11, 0)),
															self.fips := left.fips_code;	
															self := left));
return 	In_Property_Assessor;		
end;								 