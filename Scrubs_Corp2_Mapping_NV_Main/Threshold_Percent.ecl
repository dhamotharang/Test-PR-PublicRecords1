export Threshold_Percent := module

		//The max THRESHOLD percent that the input data is validated against.
		//When this percentage is exceeded, the input data will not be processed
		//because the mapper will NOT move the input data into the sprayed 
		//superfile.

		Export CORP_KEY										 					:= 0;
		Export CORP_ORIG_SOS_CHARTER_NBR 	 					:= 0;
		Export CORP_LN_NAME_TYPE_CD		  	 					:= 10;
		Export CORP_LN_NAME_TYPE_DESC 			 				:= 10;
		Export CORP_LEGAL_NAME 						 					:= 10;
		Export CORP_STATUS_CD 							 				:= 10;
		Export CORP_INC_DATE 						 	 					:= 10;
		Export CORP_ORIG_ORG_STRUCTURE_CD 	 				:= 0;
		Export CORP_ORIG_ORG_STRUCTURE_DESC 				:= 0;	
		Export CORP_RA_FULL_NAME 					 					:= 10;

end;