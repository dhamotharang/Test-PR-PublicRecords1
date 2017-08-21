IMPORT corp2;
	
EXPORT Functions := MODULE
		
		//Below table needs to be updated when we see new Org_Struc codes in Raw updates!
		EXPORT set_valid_sos_codes    :=['AN','AG','AT','BT','CTY','COL','COOP','CP','CSO','DB','FARM','FIN','FIRE','FN','FP','GP','HOS','HW',
																		 'INC','IND','INS','JV','LLC','LLP','LLLP','LP','NP','NR','NRG','PCP','PLLC','PLLP','PTR','RCP','RNP',
																		 'RLLC','RLLP','RLP','REL','RR','SAN','SCH','SM','SP','SOIL','TM','TN','TR','U','UTY','WTR',''];
																	
	 //Below table needs to be updated when we see new status codes in Raw updates!
		EXPORT set_valid_status_codes :=['AB','AC','AD','AR','CA','BR','CC','CH','CL','CN','CO','CR','DL','DS','EN','EP','EX','FR','GS',
																		 'IA','IN','MG','MO','MS','NW','PD','RF','RG','RJ','RV','RS','SS','TF','TR','WD',''];
																		
    //Below table needs to be updated when we see new Event codes in Raw updates!
		EXPORT set_valid_corp_codes 	:=['AN','BL','CP','DB','FN','LL','ML','OL','TL','TN','VL',''];
		
		EXPORT set_valid_gender_codes :=['F','M','N','U',''];
		
		EXPORT set_valid_off_title 		:=[ 'ACCOU','ACCT','ADJ','ADMIN','ADMN','AGENT','AGT','APPLI','ASSIS',         
																			'ASST','ATTOR','ATTY','AVP','BRK','CEO', 'CERTI','CHAIR','CHIEF',
																			'CHMN','CLERK','CLK','CNTR','CONT','CONTA','CONTR','CPA','DIR',
																			'DIREC','ESQ','ESQUI','EXEC','EXECU','EXVP','GENER','GM','INC',
																			'INCOR','MANAG','MEM','MEMBE','MGR', 'OFF','OFFIC','OPERA','OPR',
																			'ORGAN','OWN','OWNER','PARTN','PRES','PRESI','PTR','QUAL','QUALI',
																			'SALES','SECRE','SECY','SENIO','SHARE','SHD','SVP','TREAS','TRSY',
																			'TRUST','VICE','VP',''];
																		 
		EXPORT set_valid_filing_codes :=['D','DOMESTIC','F','FOREIGN',''];		
		
END;