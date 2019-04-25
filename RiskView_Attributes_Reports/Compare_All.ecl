EXPORT Compare_All(current_dt,previous_dt) := functionmacro



    rpt:=RiskView_Attributes_Reports.Compare_function_v4('current_dt','previous_dt');
    rpt1:=RiskView_Attributes_Reports.Compare_function_v3('current_dt','previous_dt');
		            // warning_flag =1 results only
		
		final_rpt:= rpt + rpt1;
	      final_rpt1:=choosen(final_rpt,all);
		
	        	// output(rpt(distribution_type=''));
      	 
	
	return final_rpt1 ;


endmacro;