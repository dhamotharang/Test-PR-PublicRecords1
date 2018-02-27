IMPORT Corp2, Corp2_Mapping, lib_stringlib;
EXPORT Functions := Module;                                                                                  

	//********************************************************************
		//fgetAgentName: validates AgentNames !
	//********************************************************************	
		EXPORT fgetAgentName( string Ra_name, string state_origin ='WI', string state_desc='WISCONSIN'):= FUNCTION
		
  	   invalid_name  := 'NO AGENT LISTED|NO AGENT|XX|X|AGENT RESIGNED|FOR REFERENCE ONLY|ADDRESS FOR SERVICE OF PROCESS|NO AGENT LISTED|^SEE 07 SCREEN|^\\*\\*\\* SEE|^\\*\\*\\*SEE|^\\*\\*\\*';
			 valid_ra_name :=	map(regexfind(invalid_name ,corp2.t2u(Ra_name),nocase)=> '',
														Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,Ra_name).BusinessName);	
			 RETURN valid_ra_name;
			 
	  End;
		
	//********************************************************************
		//fgetRoll_frame: validates and Returns to ar_roll ,ar_frame and event_roll
	//********************************************************************	
		EXPORT fgetRoll_frame( string roll):=function
		
		  valid_len:= length(roll);
			searchpattern := '^(0{'+valid_len+'})*(1{'+valid_len+'})*(9{'+valid_len+'})*$';
			
			// If not all zeros, ones, 9's,populate
			cleaned_roll := if(regexfind(searchpattern,roll,0) <> '' ,'',roll);
			RETURN cleaned_roll;
			
		End;
		
	//********************************************************************
		//Get_State_Code: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
	//********************************************************************	
		EXPORT Get_State_Code(string code) 
	        := map (corp2.t2u(code) in 
									['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA',
									 'GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA',
									 'MI','MN','MS','MO','MT','NE','NC','NV','NH','NJ','NM','NY','NC',
									 'ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX',
									 'UT','VT','VI','VA','WA','WV','WY']	=> corp2.t2u(code), //as per Lucinda F021341 /org_id  record has 'WI' has foreign sate and it is valid !
									 corp2.t2u(code) in ['X','XX','XXX','NA','WI','']=>'', //as per lucinda  
									'**');
									
	//********************************************************************
		//fGetStateDesc: Returns full name from "Two digit State_Code" 
	//********************************************************************	
	EXPORT  string fGetStateDesc(STRING state) := FUNCTION

		st  := corp2.t2u(state);
		RETURN case(st,
								'AL'=>'ALABAMA',
								'AK'=>'ALASKA',
								'AS'=>'AMERICAN SAMOA',
								'AZ'=>'ARIZONA',
								'AR'=>'ARKANSAS',
								'CA'=>'CALIFORNIA',
								'CO'=>'COLORADO',
								'CT'=>'CONNECTICUT',
								'DE'=>'DELAWARE',
								'DC'=>'DISTRICT OF COLUMBIA',
								'FM'=>'FEDERATED STATES OF MICRONESIA',
								'FL'=>'FLORIDA',
								'GA'=>'GEORGIA',
								'GU'=>'GUAM',
								'HI'=>'HAWAII',
								'ID'=>'IDAHO',
								'IL'=>'ILLINOIS',
								'IN'=>'INDIANA',
								'IA'=>'IOWA',
								'KS'=>'KANSAS',
								'KY'=>'KENTUCKY',
								'LA'=>'LOUISIANA',
								'ME'=>'MAINE',
								'MH'=>'MARSHALL ISLANDS',
								'MD'=>'MARYLAND',
								'MA'=>'MASSACHUSETTS',
								'MI'=>'MICHIGAN',
								'MN'=>'MINNESOTA',
								'MS'=>'MISSISSIPPI',
								'MO'=>'MISSOURI',
								'MT'=>'MONTANA',
								'NE'=>'NEBRASKA',
								'NC'=>'NORTH CAROLINA',
								'NV'=>'NEVADA',
								'NH'=>'NEW HAMPSHIRE',
								'NJ'=>'NEW JERSEY',
								'NM'=>'NEW MEXICO',
								'NY'=>'NEW YORK',
								'ND'=>'NORTH DAKOTA',
								'MP'=>'NORTHERN MARIANA ISLANDS',
								'OH'=>'OHIO',
								'OK'=>'OKLAHOMA',
								'OR'=>'OREGON',
								'PW'=>'PALAU',
								'PA'=>'PENNSYLVANIA',
								'PR'=>'PUERTO RICO',
								'RI'=>'RHODE ISLAND',
								'SC'=>'SOUTH CAROLINA',
								'SD'=>'SOUTH DAKOTA',
								'TN'=>'TENNESSEE',
								'TX'=>'TEXAS',
								'UT'=>'UTAH',
								'VT'=>'VERMONT',
								'VI'=>'VIRGIN ISLANDS',
								'VA'=>'VIRGINIA',
								'WA'=>'WASHINGTON',
								'WV'=>'WEST VIRGINIA',
								'WY'=>'WYOMING',
								'X' =>'',
								'XX'=>'',
								'XXX'=>'',
								'NA'=>'',
								'WI'=>'',
								''	=>'',
								'**|'+ st);
							
		END;	

	//********************************************************************
		//fGetStatus_desc: Returns "corp_status_desc" 
	//********************************************************************	
	EXPORT  string fGetStatus_desc(STRING Status) := FUNCTION

		st  := corp2.t2u(Status);
		RETURN case(st,
								'ADS'=>'ADMINISTRATIVELY DISSOLVED',
								'CAN'=>'CERTIFICATE OF CANCELLATION',
								'CMC'=>'NAME CONSENT REQUIRED',
								'CNF'=>'NAME CONFLICT',
								'CNS'=>'CONSOLIDATED -- NON-SURVIVOR',
								'COM'=>'IN PROCESS, NOT YET FILED',
								'DEL'=>'RECORD DELETED',
								'DIS'=>'DISSOLVED',
								'DLQ'=>'DELINQUENT',
								'DNP'=>'DISSOLVED, NAME PROTECTED',
								'EXP'=>'EXPIRED FOREIGN REGISTERED NAME',
								'FDE'=>'FILED, DELAYED EFFECTIVE',
								'IBS'=>'IN BAD STANDING',
								'IGS'=>'RESTORED TO GOOD STANDING',
								'IDS'=>'INVOLUNTARILY DISSOLVED',
								'INC'=>'INCORPORATED/QUALIFIED',
								'MGD'=>'MERGED -- NON-SURVIVOR',
								'ORG'=>'ORGANIZED',
								'PND'=>'NAME RESERVED, NOT YET FILED',
								'RCA'=>'CERTIFICATE OF AUTHORITY REVOKED',
								'RES'=>'NAME RESERVED, SHORT-TERM',
								'RGD'=>'REGISTERED',
								'RGL'=>'NAME REGISTERED, LONG-TERM',
								'RLT'=>'NAME RESERVED, LONG-TERM',
								'TER'=>'TERMINATED FOREIGN REGISTERED NAME',
								'WTD'=>'WITHDRAWAL',
								'' );
		end;	

  //********************************************************************
		//fGetOrg_structure_desc: Returns "corp_orig_org_structure_desc" 
	//********************************************************************	
	EXPORT  string fGetOrg_structure_desc(STRING Org_code) := FUNCTION

		st  := corp2.t2u(Org_code);
		RETURN case(st,
								'01' =>'DOMESTIC BUSINESS CORPORATION',
								'02' =>'FOREIGN CORPORATION',
								'03' =>'MEMBERSHIP COOPERATIVE',
								'04' =>'STOCK COOPERATIVE',														
								'05' =>'SERVICE CORPORATION',
								'06' =>'NONSTOCK CORPORATION',
								'07' =>'DOMESTIC LIMITED PARTNERSHIP',
								'08' =>'FOREIGN LIMITED PARTNERSHIP',
								'09' =>'CLOSE CORPORATION',
								'10' =>'SERVICE CLOSE CORPORATION',
								'11' =>'MISCELLANEOUS',
								'12' =>'DOMESTIC LIMITED LIABILITY COMPANY',
								'13' =>'FOREIGN LIMITED LIABILITY COMPANY',
								'14' =>'DOMESTIC LIMITED LIABILITY PARTNERSHIP',	
								'15' =>'FOREIGN LIMITED LIABILITY PARTNERSHIP',	
								'16' =>'FOREIGN NONSTOCK CORPORATION', 				//'96' =>'SHORT TERM NAME RESERVATION' -Name Type 
								'17' =>'DOMESTIC GENERAL PARTNERSHIP',
								'18' =>'FOREIGN GENERAL PARTNERSHIP',
								'24' =>'DOMESTIC LIMITED LIABILITY PARTNERSHIP - EXEMPT',
								'25' =>'DOMESTIC LIMITED LIABILITY PARTNERSHIP - EXAMPLE',
								'');
		end;	
		
	//********************************************************************
		//fGetNameStatus_desc: Returns "Corp_Name_Status_Desc" 
	//********************************************************************	
	EXPORT  string fGetNameStatus_desc(STRING Status) := FUNCTION

		st  := corp2.t2u(Status);
		RETURN case(st,
								 'CMC'=>'NAME CONSENT REQUIRED',
								 'CNF'=>'NAME CONFLICT',
								 'DNP'=>'DISSOLVED, NAME PROTECTED',
								 'EXP'=>'EXPIRED FOREIGN REGISTERED NAME',
								 'PND'=>'NAME RESERVED, NOT YET FILED',
								 'RES'=>'NAME RESERVED, SHORT-TERM',
								 'RGL'=>'NAME REGISTERED, LONG-TERM',
								 'RLT'=>'NAME RESERVED, LONG-TERM',
								 'TER'=>'TERMINATED FOREIGN REGISTERED NAME',
								 '');
		end;	
		
END;