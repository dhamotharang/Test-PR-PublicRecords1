IMPORT corp2, corp2_mapping, lib_stringlib;

EXPORT Functions := Module
			
		//********************************************************************
		//CorpOrigOrgStructureDesc: Returns "corp_orig_org_structure_desc" from vendor code.
		//********************************************************************	
		EXPORT CorpOrigOrgStructDesc(STRING s) := FUNCTION
		
					 OrgSt_dec  := corp2.t2u(s);
					 RETURN map( OrgSt_dec = 'BK'  =>'BANK DOMESTIC CORP',
											 OrgSt_dec = 'BL'  =>'BANK', 
											 OrgSt_dec = 'CH'  =>'DOMESTIC CHURCH',
											 OrgSt_dec = 'CI'  =>'CITY-TOWN',
											 OrgSt_dec = 'CO'  =>'DOMESTIC COOPERATIVE',
											 OrgSt_dec = 'DA'  =>'DOMESTIC LIMITED LIABILITY COMPANY FARM',
											 OrgSt_dec = 'DB'  =>'DOMESTIC BUSINESS',
											 OrgSt_dec = 'DF'  =>'DOMESTIC BUSINESS FARM',
											 OrgSt_dec = 'DL'  =>'DOMESTIC LIMITED LIABILITY COMPANY',
											 OrgSt_dec = 'DP'  =>'DOMESTIC LIMITED PARTNERSHIP',
											 OrgSt_dec = 'DR'  =>'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
											 OrgSt_dec = 'DT'  =>'DOMESTIC TRUST',
											 OrgSt_dec = 'DM'  =>'DOMESTIC MISCELLANEOUS',
											 OrgSt_dec = 'EM'  =>'DOMESTIC MISCELLANEOUS',
											 OrgSt_dec = 'FA'  =>'FOREIGN LIMITED LIABILITY COMPANY FARM',
											 OrgSt_dec = 'FB'  =>'FOREIGN BUSINESS',
											 OrgSt_dec = 'FC'  =>'FOREIGN COOPERATIVE',
											 OrgSt_dec = 'FD'  =>'EMERGENCY MANAGEMENT',
											 OrgSt_dec = 'FF'  =>'FOREIGN BUSINESS FARM',
											 OrgSt_dec = 'FG'  =>'FOREIGN GENERAL PARTNERSHIP',
											 OrgSt_dec = 'FK'  =>'BANK FIDUCIARY',
											 OrgSt_dec = 'FL'  =>'FOREIGN LIMITED LIABILITY COMPANY',
											 OrgSt_dec = 'FM'  =>'FOREIGN MISCELLANEOUS',
											 OrgSt_dec = 'FN'  =>'FOREIGN NONPROFIT',
											 OrgSt_dec = 'FP'  =>'FOREIGN LIMITED PARTNERSHIP',
											 OrgSt_dec = 'FR'  =>'FOREIGN LIMITED LIABILITY PARTNERSHIP',
											 OrgSt_dec = 'FT'  =>'FOREIGN BUSINESS TRUST',
											 OrgSt_dec = 'GP'  =>'DOMESTIC GENERAL PARTNERSHIP',
											 OrgSt_dec = 'ID'  =>'IRRIGATION DISTRICT',
											 OrgSt_dec = 'IN'  =>'DOMESTIC INSURANCE COMPANIES',
											 OrgSt_dec = 'MP'  =>'DOMESTIC MUNICIPAL POWER',
											 OrgSt_dec = 'NS'  =>'DOMESTIC NONPROFIT',
											 OrgSt_dec = 'PF'  =>'FIRE PROTECTION DISTRICT',
											 OrgSt_dec = 'PU'  =>'PUBLIC UTILITY',
											 OrgSt_dec = 'RA'  =>'RAILROAD AUTHORITY',
											 OrgSt_dec = 'RD'  =>'TRANSPORTATION DISTRICT',
											 OrgSt_dec = 'SD'  =>'SANITARY DISTRICT',
											 OrgSt_dec = 'SG'  =>'SELF GOVERNMENT',
											 OrgSt_dec = 'TD'  =>'DOMESTIC MISCELLANEOUS',
											 OrgSt_dec = 'WD'  =>'WATER USER DISTRICT',
											 OrgSt_dec in ['RG','RL','RN','RP','RS','UB',''] =>'',
											 '**|'+ OrgSt_dec);
											 
	END;
			//********************************************************************
				//CorpStatusDesc: Returns "corp_status_desc".
		//********************************************************************	
		EXPORT CorpStatusDesc(STRING s) := FUNCTION
		
					 uc_Status  := corp2.t2u(s);
					 RETURN map(uc_Status='D'         => 'DELINQUENT',
											uc_Status='I'         => 'INACTIVE',
											uc_Status='S'         => 'DISSOLVED',
											uc_Status='V'         => 'REVOKED',
											uc_Status='G'         => 'GOOD STANDING',
											uc_Status in [''] => '',
											'**|'+ uc_Status);
											
		END;	
		
	//********************************************************************
		//Get_State_Code: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
	//********************************************************************	
		EXPORT Get_State_Code(string code) := FUNCTION
	
		 st  := corp2.t2u(stringlib.stringfilter(corp2.t2u(code),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
		 State_Code:= map (st in 
											 ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS',
											  'KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP',
											  'OH','OK','OR','PW','PA','PH','PR','RI','SC','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA',
											  'AP','JA','CN','BR','NO','SA','TH','AB','BC','MB','NB','NL','NT','NS','NU','ON','PE','QC',
											  'SK','YT','IO']=> st, 
												 st in ['S','DI','']=>'', //as per CI/lucinda 
											  '**');
	   return State_Code;
		 
	 End;							
	//********************************************************************
		//fGetStateDesc: Returns full name from "Two digit State_Code" 
	//********************************************************************	
	EXPORT  string fGetStateDesc(STRING state) := FUNCTION
	
		st  := corp2.t2u(stringlib.stringfilter(corp2.t2u(state),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
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
								'NV'=>'NEVADA',
								'NH'=>'NEW HAMPSHIRE',
								'NJ'=>'NEW JERSEY',
								'NM'=>'NEW MEXICO',
								'NY'=>'NEW YORK',
								'NC'=>'NORTH CAROLINA',
								'ND'=>'NORTH DAKOTA',
								'MP'=>'NORTHERN MARIANA ISLANDS',
								'OH'=>'OHIO',
								'OK'=>'OKLAHOMA',
								'OR'=>'OREGON',
								'PW'=>'PALAU',
								'PA'=>'PENNSYLVANIA',
								'PH'=>'PHILIPPINES',
								'PR'=>'PUERTO RICO',
								'RI'=>'RHODE ISLAND',
								'SC'=>'SOUTH CAROLINA',
								'TN'=>'TENNESSEE',
								'TX'=>'TEXAS',
								'UT'=>'UTAH',
								'VT'=>'VERMONT',
								'VI'=>'VIRGIN ISLANDS',
								'VA'=>'VIRGINIA',
								'WA'=>'WASHINGTON',
								'WV'=>'WEST VIRGINIA',
								'WI'=>'WISCONSIN',
								'WY'=>'WYOMING',
								'AE'=>'ARMED FORCES EUROPE, THE IDDLE EAST, AND CANADA',
								'AA'=>'ARMED FORCES AMERICAS EXCEPT CANADA',
								'AP'=>'ARMED FORCES PACIFIC',
								'ON'=>'ONTARIO, CANADA',
								'JA'=>'JAPAN',
								'CN'=>'CANADA',
								'BR'=>'BRITISH COLUMBIA, CANADA',
								'NO'=>'NORWAY',
								'SA'=>'SASKATCHEWAN, CANADA',
								'TH'=>'NETHERLANDS',
								'AB'=>'ALBERTA'	,
								'BC'=>'BRITISH COLUMBIA',
								'MB'=>'MANITOBA',
								'NB'=>'NEW BRUNSWICK',
								'NL'=>'NEWFOUNDLAND AND LABRADOR',
								'NT'=>'NORTHWEST TERRITORIES',
								'NS'=>'NOVA SCOTIA',
								'NU'=>'NUNAVUT',
								'PE'=>'PRINCE EDWARD ISLAND',
								'QC'=>'QUEBEC',
								'SK'=>'SASKATCHEWAN',
								'YT'=>'YUKON',
								'IO'=>'BRITISH INDIAN OCEAN TERRITORY',
								'S'=>'',
								'DI'=>'',
								''  =>'',
							  '**|'+ st);
							
		END;	

		//********************************************************************
				//EventFilingDesc: Returns "event_filing_desc" from vendor code.
		//********************************************************************	
		EXPORT fGetEventFilingDesc(STRING s) := FUNCTION
		
					 uc_Status  := corp2.t2u(s);
					 RETURN map(uc_Status='AA'=>'AMENDED CERTIFICATE OF AUTHORITY',
											uc_Status='AC'=>'ARTICLES OF INCORPORATION',
											uc_Status='AD'=>'ARTICLES OF DOMESTICATION',
											uc_Status='AE'=>'ARTICLES OF ENTITY CONVERSION',
											uc_Status='AM'=>'GENERAL AMENDMENT',
											uc_Status='AO'=>'ARTICLES OF ORGANIZATION', 
											uc_Status='AR'=>'ANNUAL REPORT',
											uc_Status='AS'=>'ARTICLES OF CHARTER SURRENDER',
											uc_Status='AT'=>'ARTICLES OF TERMINATION',
											uc_Status='AX'=>'ARTICLES OF CORRECTION',																			
											uc_Status='AEC'=>'ARTICLES OF ENTITY CONVERSION',
											uc_Status='ACS'=>'ARTICLES OF CHARTER SURRENDER',
											uc_Status='AOC'=>'ARTICLES OF CORRECTION',	
											uc_Status='BL'=>'BY-LAWS',
											uc_Status='CA'=>'CERTIFICATE OF AUTHORITY',
											uc_Status='CF'=>'CERTIFICATE OF FACT',
											uc_Status='CL'=>'CANCELLATION',
											uc_Status='CR'=>'CRA REGISTRATION',
											uc_Status='CT'=>'CRA TERMINATION',
											uc_Status='CX'=>'CRA CHANGE OF NAME OR ADDRESS',
											uc_Status='CZ'=>'CRA ADMINISTRATIVE CANCELLATION',
											uc_Status='DC'=>'ARTICLES OF DOMESTICATION AND CONVERSION',
											uc_Status='DL'=>'LLC ART. OF ORGANIZATION', 
											uc_Status='DR'=>'REVOCATION OF DISSOLUTION',
											uc_Status='DS'=>'DISSOLUTION',
											uc_Status='DT'=>'DECLARATION OF TRUST',
											uc_Status='DV'=>'DIVISION',
											uc_Status='EX'=>'EXPIRED - NO LONGER IN STATE TABLE',
											uc_Status='FL'=>'LLC AUTHORITY',
											uc_Status='FQ'=>'FARM QUALIFICATION',
											uc_Status='FR'=>'FARM REPORT',
											uc_Status='FU'=>'FIDUCIARY',
											uc_Status='GP'=>'GENERAL PARTNERSHIP',
											uc_Status='GS'=>'GOOD STANDING',
											uc_Status='ID'=>'INTENT TO DISSOLVE',
											uc_Status='LP'=>'LIMITED PARTNERSHIP',
											uc_Status='LT'=>'LETTER',
											uc_Status='MD'=>'MERGED',
											uc_Status='ME'=>'MERGER', 
											uc_Status='MS'=>'CORPORATION MISCELLANEOUS',
											uc_Status='NC'=>'NAME CHANGE',
											uc_Status='OD'=>'OFFICERS/DIRECTORS RESIGNATION INFO',																			
											uc_Status='ODI'=>'ORDER DECLARING INCORPORATION',
											uc_Status='PM'=>'JOINT AGREEMENT- NO LONGER IN STATE TABLE',
											uc_Status='RA'=>'RESIGNATION OF AGENT',
											uc_Status='RD'=>'STATEMENT OF DENIAL',
											uc_Status='RE'=>'PETITION FOR REINSTATEMENT- NO LONGER IN STATE TABLE',
											uc_Status='RG'=>'REGISTERED NAME',
											uc_Status='RI'=>'REINSTATEMENT',
											uc_Status='RP'=>'REGISTRATON FOR LIMITED LIABILITY PARTNERSHIP',
											uc_Status='RR'=>'REGISTRATION RENEWAL',
											uc_Status='RS'=>'RESERVATION OF NAME',
											uc_Status='RT'=>'TRANSFER OF RESERVED NAME',
											uc_Status='RV'=>'REVOCATION',
											uc_Status='RAI'=>'RAILROAD AUTHORITY INCORPORATION',
											uc_Status='RPA'=>'STATEMENT OF PARTNERSHIP AUTHORITY',																																					
											uc_Status='PCC'=>'PERPETUAL CARE CEMETERY',
											uc_Status='SA'=>'RESTATED ARTICLES',
											uc_Status='SC'=>'STATEMENT OF CHANGE', 
											uc_Status='SD' =>'STATEMENT OF DISSOCIATION',
											uc_Status='SE' =>'SHARE EXCHANGE',
											uc_Status='SH'=>'SHARE ESTABLISHMENT/REDUCTION/CANCEL',																			
											uc_Status='STM'=>'NOTICE OF SALE, TRANSFER OR MERGER',
											uc_Status='TC'=>'APPLICATION FOR TRANSFER OF AUTHORITY',
											uc_Status='TL'=>'STATEMENT OF AUTHORITY',
											uc_Status='TX'=>'LIMITED LIABILITY COMPANY ANNUAL TAX',
											uc_Status='UK'=>'UNKNOWN HISTORY CODE',
											uc_Status='WD'=>'WITHDRAWAL',
											uc_Status=''=>'',
											'**|'+ uc_Status);
											
		END;	

		EXPORT GetAddlInfo(STRING farm_qual_date,STRING farm_status,STRING farm_status_date,STRING llc_managed_ind) := FUNCTION
		
		farm_qual_dt              := if(Corp2_Mapping.fValidateDate(farm_qual_date).PastDate<>'','FARM QUALIFICATION DATE: '+Corp2_Mapping.fValidateDate(farm_qual_date).PastDate,'');
		farm_status_val  				  := Map(corp2.t2u(farm_status)='C'=>'FARM STATUS: CANCELLATION PENDING',
																		 corp2.t2u(farm_status)='D'=>'FARM STATUS: DELINQUENT',
																		 corp2.t2u(farm_status)='G'=>'FARM STATUS: GOOD STANDING',
																		 corp2.t2u(farm_status)='I'=>'FARM STATUS: INACTIVE',''); 		
		farm_status_dt						:= if(Corp2_Mapping.fValidateDate(farm_status_date).PastDate<>'','FARM STATUS DATE: '+Corp2_Mapping.fValidateDate(farm_status_date).PastDate,'');
		llc_managed_ind_val       := Map(corp2.t2u(llc_managed_ind)='B'=>'MANAGER MANAGED',
																		 corp2.t2u(llc_managed_ind)='M'=>'MEMBER MANAGED','');		
		concatFields					  	:= trim(trim(farm_qual_dt,left,right)+';'+trim(farm_status_val,left,right)+';'+trim(farm_status_dt,left,right) +';'+ trim(llc_managed_ind_val,left,right),left,right) ;				
		tempExp								   	:= regexreplace('[;]*$',concatFields,'',NOCASE);
		tempExp2							    := regexreplace('^[;]*',tempExp,'',NOCASE);
		tempExp3							    := regexreplace('[;]+',tempExp2,';',NOCASE);
		addl_info              		:= lib_stringlib.StringLib.StringFindReplace(tempExp3,';','; ');
					 
		RETURN Addl_info;
				
	End;
	
	EXPORT GetRA_AddlInfo(STRING craid,STRING agent_assign_date) := FUNCTION
		
		CRAID_val                 := if(trim(craid)<>'' ,'CRAID:'+corp2.t2u(craid),'');
		agent_assign_dt           := if(Corp2_Mapping.fValidateDate(agent_assign_date).GeneralDate<>'','ASSIGNMENT DATE: '+Corp2_Mapping.fValidateDate(agent_assign_date).GeneralDate,'');
		ra_addl_info              := if(trim(CRAID_val)<> '' and  trim(agent_assign_dt)<>'' , CRAID_val + '; '+ agent_assign_dt,if(trim(agent_assign_dt)<>'',agent_assign_dt,CRAID_val));														
		RETURN ra_addl_info;
				
	End;	
		
END;