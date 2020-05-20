IMPORT corp2;
	
EXPORT Functions := MODULE

		EXPORT valid_org_structure_cd(STRING s) := FUNCTION
		
			 uc_s := corp2.t2u(s);
					 
			 isValidCD := MAP(uc_s in ['','CS','CU','DC55-PBC','DC55','DC56','DC56-PBC','DLCA','DLCA-PBC','DLLC','DLLLP',
																 'DLLP','DLP','DLPA','DNC','DNCDT','DNCIC','DNCSL','DNCWC',
																 'DPC','DPC-PBC','DPC-PBC','DPCCU','DPCDT','DPCIC','DPCSL','DPCWC',
																 'DT','FCOOP','FLCA','FLLC','FLLLP','FLLP','FLP','FLPA',
																 'FNC','FNCCU','FNCDT','FNCIC','FNCSL','FNCWC','FO','FPC',
																 'FPCCU','FPCDT','FPCIC','FPCSL','FPCWC','GP','IC','SL','UNA','WC'
																] => true,false
												);
								 
				RETURN IF(isValidCD,1,0);	
								
		END;

		//********************************************************************
		//valid_corp_forgn_state_cd: returns true or false based upon the
		//													 incoming code.
		//********************************************************************	
		EXPORT valid_corp_forgn_state_cd(STRING s) := FUNCTION

			 uc_s  			:= corp2.t2u(s);
					 
			 isValidCD  := if(stringlib.stringfind(uc_s,'*',1)=0,true,false);
			 
			 RETURN IF(isValidCD,1,0);

		END;		

	
		//********************************************************************
		//valid_corp_forgn_state_desc: returns true or false based upon the
		//														 incoming code.
		//********************************************************************	
		EXPORT valid_corp_forgn_state_desc(STRING s) := FUNCTION

			 uc_s  				:= corp2.t2u(s);
					 
			 isValidDesc  := if(stringlib.stringfind(uc_s,'*',1)=0,true,false);
			 													
			 RETURN IF(isValidDesc,1,0);

		END;

END;		