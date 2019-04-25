EXPORT compare_function_field_change(current_dt,previous_dt) := functionmacro


DS1:= dataset('~foreign::10.241.3.238::sghatti::out::batch_fcra_rvattributes_v3_'+previous_dt, RiskView_Attributes_Reports.batch_fcra_rvattributes_v3_layout,


 CSV(HEADING(single), QUOTE('"')));
DS2:= dataset('~foreign::10.241.3.238::sghatti::out::batch_fcra_rvattributes_v3_'+current_dt, RiskView_Attributes_Reports.batch_fcra_rvattributes_v3_layout,


 CSV(HEADING(single), QUOTE('"')));


 DS3:= dataset('~foreign::10.241.3.238::sghatti::out::fcra_rvattributes_v4_'+previous_dt, RiskView_Attributes_Reports.fcra_rvattributes_v4_layout,


 CSV(HEADING(single), QUOTE('"')));

 DS4:= dataset('~foreign::10.241.3.238::sghatti::out::fcra_rvattributes_v4_'+current_dt, RiskView_Attributes_Reports.fcra_rvattributes_v4_layout,


 CSV(HEADING(single), QUOTE('"')));




                              
                            
                              
                              Missing_values:= JOIN(DS2,DS1,LEFT.accountnumber=RIGHT.accountnumber and LEFT.did!=RIGHT.did,local);
															Missing_values2:= JOIN(DS4,DS3,LEFT.accountnumber=RIGHT.accountnumber and LEFT.did!=RIGHT.did,local);
															
															
															// Missing_values;
                // count_Missing_values:=count(Missing_values);
								// count_Missing_values;
								
 								 
   	myrec1 := {  
		     string file_version,
				 string mode,
   		   string field_name,
				 integer p_file_count,
				 integer c_file_count,
				 integer file_count_diff,
         decimal20_4 field_change_count,
         decimal20_4 field_change_count_proportion,
         decimal20_4 perc_field_change_count
   	
				};
				
				
				myrec := {
   		   string file_version,
				 string mode,
   		   string field_name,
				 integer p_file_count,
				 integer c_file_count,
				 integer file_count_diff,
         STRING50 reason_code,
         decimal20_4 p_frequency,
         decimal20_4 c_frequency,
         decimal20_4 frequency_diff,
   			 decimal20_4 perc_frequency_diff,
      	 decimal20_4 p_proportion,
         decimal20_4 c_proportion,
         decimal20_4 proportion_diff,
   			 decimal20_4 abs_proportion_diff,
   			 decimal20_4 perc_proportion_diff
   	
   								
               };		
   			
   pfc := count(ds1);
   cfc := count(ds2);
   fcd :=cfc-pfc;
pf:=count(Missing_values);
cf:=count(Missing_values);
// fd:= cf-pf;
// pfd:= fd/cf;
// pp:= pf/pfc;
// cp:=cf/cfc;
pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
abd:=abs(pd);
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);
	 
	 
	 // fcc:=count(Missing_values);
	 // fccp:=if(pfc!= 0 and cfc=0,1,fcc/cfc);
	 // pfcc:=if(pfc!= 0 and cfc=0,100,(fcc/cfc)*100);
	 
	 
	 pfc2 := count(ds3);
   cfc2 := count(ds4);
   fcd2 :=cfc2-pfc2;
	 
pf2:=count(Missing_values2);
cf2:=count(Missing_values2);
// fd:= cf-pf;
// pfd:= fd/cf;
// pp:= pf/pfc;
// cp:=cf/cfc;
pd2:=if(pfc2!= 0 and cfc2=0,1,cf2/cfc2);
abd2:=abs(pd2);
ppd2:=if(pfc2!= 0 and cfc2=0,1,(cf2/cfc2)*100);
	 
	 // fcc2:=count(Missing_values2);
	 // fccp2:=if(pfc2!= 0 and cfc2=0,1,fcc2/cfc2);
	 // pfcc2:=if(pfc2!= 0 and cfc2=0,100,(fcc2/cfc2)*100);
	 
	 
   btable := DATASET([{'fcra_rvattributes_v3','batch','did',pfc,cfc,fcd,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd},
	                    {'fcra_rvattributes_v4','xml','did',pfc2,cfc2,fcd2,'<DID not equal>',pf2,cf2,'','','','',pd2,abd2,ppd2}], myrec);
   
   
 return  btable;


endmacro;