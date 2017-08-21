import ln_propertyv2, ut,LN_PropertyV2_Fast;
assessor_f := LN_PropertyV2_Fast.Files.prep.assessment;

 new_ly := record
 recordof(assessor_f);
 string11 assessed_land_improvement_value;
 string11 market_land_improvement_value;
 string5 fips;
 end;

File_Assessment := assessor_f;
													

  LN_   := File_Assessment(vendor_source_flag ='O');
   Fares := File_Assessment(vendor_source_flag in ['F'/*,'S'*/]);

   MaxprocessDateLN    := Max(LN_,process_date); 
   MaxProcessDateFares := Max(Fares,process_date);

In_Property_Assessor_ := LN_ ( process_date = MaxprocessDateLN)+  
	                       Fares(process_date = MaxProcessDateFares and vendor_source_flag = 'F');
												 
In_Property_Assessor_p := project(In_Property_Assessor_,
															transform(new_ly, 
															self.assessed_land_value := (string)(unsigned)if(left.assessed_land_value = '', '0',left.assessed_land_value),
															self.assessed_improvement_value := (string)(unsigned)if(left.assessed_improvement_value= '', '0',left.assessed_improvement_value),
															self.assessed_total_value := (string)(unsigned)if(left.assessed_total_value= '', '0',left.assessed_total_value),
															self.market_land_value := (string)(unsigned)if(left.market_land_value= '', '0',left.market_land_value),
															self.market_improvement_value := (string)(unsigned)if(left.market_improvement_value= '', '0',left.market_improvement_value),
															self.market_total_value := (string)(unsigned)if(left.market_total_value = '', '0',left.market_total_value),
															self.assessed_land_improvement_value := (string)(unsigned)if(self.assessed_land_value <> '0' or self.assessed_improvement_value <> '0', (string) ((unsigned)left.assessed_land_value +  (unsigned)left.assessed_improvement_value), self.assessed_total_value),
															self.market_land_improvement_value :=  (string)(unsigned)if(self.market_improvement_value <> '0' or self.market_land_value <> '0', (string)((unsigned)left.market_land_value +  (unsigned)left.market_improvement_value), self.market_total_value),
															self.fips := left.fips_code;	
															self := left));
												 

EXPORT In_Property_Assessor_Prep := In_Property_Assessor_p;