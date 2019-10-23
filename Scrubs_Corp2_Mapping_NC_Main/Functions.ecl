IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
			//invalid_ln_name_type_cd: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_name_type_code(STRING s, STRING recordorigin) := FUNCTION

			uc_s 		  := corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','07','42','P','43','H','07','44','46','47','CD','CL','PS','5','35','CR',''] => true, 
													false
												 ),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;


		
		//Below table needs to be updated when we see new Org_Struc codes in Raw updates!
		EXPORT set_valid_org_codes :=['NDTB','LP','BK','COOP','CORR','DS','BUS','FAIR','INS','LLC','LLP','MBA','MDGA',
																	'MUN','MUT','NP','PA','PTA','S&L','SSB','RR','PLLC','OTH','NATB','EMC',
																	'NPCT','NINP','L3C','LLLP','CO54','CAPI','RESA',''];
																	
	 //Below table needs to be updated when we see new status codes in Raw updates!
		EXPORT set_valid_status_codes:=['1','2','3','5','7','8','9','10','11','12','13','14','15','16','17','18',
																	  '19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34',''];
																		
    //Below table needs to be updated when we see new Event codes in Raw updates!
		EXPORT set_valid_Event_codes :=['AADR','AAUT','ACOP','ADIS','ADMN','AGT','AINC','ALLC','AMLP','AMNC','AMND','AMU','AMU1','ANNX',
																		'AREI','AREL','AS&L','AUTH','BAMD','BINC','BYL','CAAB','CALP','CANC','CAMP','CBIN','CBNP','CFLP','CINC',
																		'CLLC','CMA','CMAP','CMER','CNP','CNSL','COI','CON','CONV','COPA','CORR','CROA','DESG','DISS','DLLP','DLP',
																		'DLPC','DNAM','DNLP','DOPA','EXPI','FDBA','FDCV','FLLP','FLP','FNAM','FNLP','HINC','ICOP','IMU','IMU1',
																		'INC','INCC','IRDM','IS&L','JDIS','JREI','JUDO','L3C','L3CF','LIQD','LLCC','LLCD','LLCF','LLCN','LLP','LLPC',
																		'MDIS','MERD','MERG','MISC','NADR','NAME','NBAN','NCCV','NCOP','NIAM','NIAP','NICA','NINC','NIRE','NOP',
																		'PASP','PLSP','PREI','RCCA','RCCC','RCCN','RCCP','RCLL','RCPC','RCPL','RDEV','RDNF','REG','REN','RESR','REV',
																		'REVK','REVL','REVR','RINC','RLLC','RNSE','RNST','RREG','RSCH','RSGC','RSGD','RSGN','RSLP','RVLB','SHRX','SSID',
																		'SSPC','SURV','SUSP','TAUT','TDSG','TRAN','TRLP','VOID','VSUR','WDMG','WINC','WITC','WITH','WIPT','WITP',''];
		
		//Below table needs to be updated when we see new AR descs in Raw updates!																
		EXPORT fn_valid_AR_type(string desc) := function

			isValiddesc := case(corp2.t2u(desc),
													'ANNUAL REPORT PRE98'=> true, 
													'ANNUAL FINANCIALS'=> true,  
													'ANNUAL REPORT RLLP'=> true,  
													'ANNUAL REPORT LLC'=> true,  
													'ANNUAL REPORT LLP'=> true,  
													'ANNUAL REPORT (NOTICE GIVEN)'=> true,  
													'ANNUAL REPORT'=> true,  
													'AMENDED ANNUAL REPORT'=> true, false); 
			return if(isValiddesc,1,0);	
	  END;
		
END;