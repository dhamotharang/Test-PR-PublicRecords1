
export stats_Pop_FeinExtract:=function

FEIN_base:=FEIN_CP_Extract.File_FEINExtract_base;


FEIN_Extract_Stats:= record 
	FEIN_base.ADR_STATE;
	countgroup					:=count(group);			
			TAX_ID_NO 			:=ave(group,if(FEIN_base.TAX_ID_NO<>''  ,100,0));         
			SRC_DUN_NBR 		:=ave(group,if(FEIN_base.SRC_DUN_NBR<>''  ,100,0));         
		  	NAME_BUS  			:=ave(group,if(FEIN_base.NAME_BUS<>''  ,100,0));    
		  	ADR_ADDRESS 		:=ave(group,if(FEIN_base.ADR_ADDRESS<>''  ,100,0));      
		  	ADR_CITY 			:=ave(group,if(FEIN_base.ADR_CITY<>''  ,100,0));        
		  	ADR_ZIP    			:=ave(group,if(FEIN_base.ADR_ZIP<>''  ,100,0));      
		  	REF_NAME_SRC  		:=ave(group,if(FEIN_base.REF_NAME_SRC<>''  ,100,0));  
		    DATE_INPUT    		:=ave(group,if(FEIN_base.DATE_INPUT<>''  ,100,0));        
		  	DATE_CL_IMP  		:=ave(group,if(FEIN_base.DATE_CL_IMP<>''  ,100,0));     
		 	CASE_DUN_NBR   		:=ave(group,if(FEIN_base.CASE_DUN_NBR<>''  ,100,0));        
		 	PAR_DUN_NBR    		:=ave(group,if(FEIN_base.PAR_DUN_NBR<>''  ,100,0));         
		 	HDQ_DUN_NBR   		:=ave(group,if(FEIN_base.HDQ_DUN_NBR<>''  ,100,0));         
		 	PHONE_NO     		:=ave(group,if(FEIN_base.PHONE_NO<>''  ,100,0));       
		  	NAME_EXEC  			:=ave(group,if(FEIN_base.NAME_EXEC<>''  ,100,0));        
		  	NAME_COMPANY 		:=ave(group,if(FEIN_base.NAME_COMPANY<>''  ,100,0));        
		  	TRADE_STYLE 		:=ave(group,if(FEIN_base.TRADE_STYLE<>''  ,100,0));        
			SIC_CODE     		:=ave(group,if(FEIN_base.SIC_CODE<>''  ,100,0));         
		 	TMP_HOUSENO  		:=ave(group,if(FEIN_base.TMP_HOUSENO<>''  ,100,0)); 

 end;
 
 FEIN_Extract_Field_PopulationStats := sort(table(FEIN_base,FEIN_Extract_Stats,
													  ADR_STATE,
													    few),ADR_STATE);
return sequential (output(count(FEIN_base),named('FEIN_ExtractRecordCount'))
                  ,output(choosen(FEIN_base,1000),named('FEIN_ExtractSampleRecords'))
					,output(FEIN_Extract_Field_PopulationStats,named('FEIN_Extract_PopulationStats'))
					);

end;