
/*
EXPORT InRecord := RECORD
			STRING20  acctno;
			QSTRING30	ChannelIdentifier;
			QSTRING30  NameFirst;
			QSTRING30  NameMiddle;
			QSTRING30  NameLast;
			STRING5   NameSuffix;
			STRING11 	SSN;
			STRING10 	DOB_YYYYMMDD;
			QSTRING65	GIID_AddressLine1;
			QSTRING65	GIID_AddressLine2;
			QSTRING25	GIID_City;
			STRING2		GIID_State;
			STRING10	GIID_ZipCode;
			QSTRING65	Current_AddressLine1;
			QSTRING65	Current_AddressLine2;
			QSTRING25	Current_City;
			STRING2		Current_State;
			STRING10	Current_ZipCode;						
			QSTRING65	Previous_AddressLine1;
			QSTRING65	Previous_AddressLine2;
			QSTRING25	Previous_City;
			STRING2		Previous_State;
			STRING10	Previous_ZipCode;
		END;
*/

/*
FAILURECODE_FIRSTLASTNOTFOUND = 4,
	FAILURECODE_FIRSTLASTSTATENOTFOUND = 5,
	FAILURECODE_FIRSTLASTZIPNOTFOUND = 6,
	FAILURECODE_NOADDRFULLNAME = 7,
	FAILURECODE_NODOBWITHADDRFULLNAME = 8,
	FAILURECODE_DIFFERENTDOBWITHADDRFULLNAME = 9,
	FAILURECODE_PREVIOUSFAILNOWHIT
*/																	
export _Sample_Records := DATASET([		
		/*{'109','BATCH', '', 'DAWN','','ATKINSON','','', '1981-08-20', '7805 FIREFLY CTS', '', 'ORLANDO', 'FL', '32807', '', '', '', '', '', '', '', '', '', ''}, 
		*/{'403','BATCH', '', 'SUSAN','','RACK','','', '19720908', '444 W ORANGE GROVE RD', '', 'TUCSON', 'AZ', '85704', '', '', '', '', '', '', '', '', '', ''}/*, 
		{'searchPass10_Addr1','BATCH', '', 'Juan','R','BOLANOS','JR','', '19760727', '321 SPRUCE ST', '', 'BOYNTON BEACH', 'FL', '33426', '1650-F LINTON LAKE DR', '', 'DELRAY BEACH', 'FL', '33445', '5669 PACIFIC BLVD', 'APT 2509', 'BOCA RATON', 'FL', '33443'}, 
		{'searchPass10_Addr2','BATCH', '', 'Juan','R','BOLANOS','JR','', '19760727', 'BLAH', '', 'BOYNTON BEACH', 'FL', '33426', '1650-F LINTON LAKE DR', '', 'DELRAY BEACH', 'FL', '33445', '5669 PACIFIC BLVD', 'APT 2509', 'BOCA RATON', 'FL', '33443'}, 
		{'searchPass10_Addr3','BATCH', '', 'Juan','R','BOLANOS','JR','', '19760727', 'BLAH', '', 'BOYNTON BEACH', 'FL', '33426', 'BLAH', '', 'DELRAY BEACH', 'FL', '33445', '5669 PACIFIC BLVD', 'APT 2509', 'BOCA RATON', 'FL', '33443'}, 
		{'searchPass20','BATCH', '', 'Juan','R','BOLANOS','JR', '595590751', '19760727', 'BLAH', '', 'BOYNTON BEACH', 'FL', '33426', 'BLAH', '', 'DELRAY BEACH', 'FL', '33445', 'BLAH', 'APT 2509', 'BOCA RATON', 'FL', '33443'}, 
	  {'searchPass30_Addr1','BATCH', '', 'BOLANOS','R','JUAN','JR','', '19760727', '321 SPRUCE ST', '', 'BOYNTON BEACH', 'FL', '33426', '1650-F LINTON LAKE DR', '', 'DELRAY BEACH', 'FL', '33445', '5669 PACIFIC BLVD', 'APT 2509', 'BOCA RATON', 'FL', '33443'}, 		
		{'searchPass40','BATCH', '', 'BOLANOS','R','JUAN','JR','595590751', '19760727', 'BLAH', '', 'BOYNTON BEACH', 'FL', '33426', 'BLAH', '', 'DELRAY BEACH', 'FL', '33445', 'BLAH', 'APT 2509', 'BOCA RATON', 'FL', '33443'}, 		
		{'searchPass50_Addr1','BATCH', '', 'J','R','BOLANOS','JR','', '19760727', '321 SPRUCE ST', '', 'BOYNTON BEACH', 'FL', '33426', '1650-F LINTON LAKE DR', '', 'DELRAY BEACH', 'FL', '33445', '5669 PACIFIC BLVD', 'APT 2509', 'BOCA RATON', 'FL', '33443'}, 
		{'searchPass60_Addr1','BATCH', '', 'JAN','R','BOLANS','JR','', '19760727', '321 SPRUCE ST', '', 'BOYNTON BEACH', 'FL', '33426', '1650-F LINTON LAKE DR', '', 'DELRAY BEACH', 'FL', '33445', '5669 PACIFIC BLVD', 'APT 2509', 'BOCA RATON', 'FL', '33443'}, 
		{'searchPass70_Addr1','BATCH', '', 'JUAN','R','BOLANOS','JR','', '19760727', '323 SPRUCE ST', '', 'BOYNTON BEACH', 'FL', '33426', 'BLAH', '', 'DELRAY BEACH', 'FL', '33445', 'BLAH', 'APT 2509', 'BOCA RATON', 'FL', '33443'}, 
		{'searchPass71','BATCH', '', 'JUAN','R','SMITH','JR','595590751', '19760727', '321 SPRUCE ST', '', 'BOYNTON BEACH', 'FL', '33426', '1650-F LINTON LAKE DR', '', 'DELRAY BEACH', 'FL', '33445', '5669 PACIFIC BLVD', 'APT 2509', 'BOCA RATON', 'FL', '33443'},
		{'failurecode4','BATCH', '', 'THISNAMESHOULDNOT','','BEFOUNDANYWHERE','JR','595590751', '19760727', '321 SPRUCE ST', '', 'BOYNTON BEACH', 'FL', '33426', '', '', '', '', '', '', '', '', '', ''},
		{'failurecode5','BATCH', '', 'JUAN','R','BOLANOS','JR','595590751', '19760727', '500 West 36th Ave., Ste. 110', '', 'ANCHORAGE', 'AK', '99503', '', '', '', '', '', '', '', '', '', ''},
		{'failurecode6','BATCH', '', 'JUAN','R','BOLANOS','JR','595590751', '19760727', '7805 FIREFLY CTS', '', 'ORLANDO', 'FL', '32807', '', '', '', '', '', '', '', '', '', ''},
		{'failurecode7','BATCH', '', 'JUAN','R','BOLANOS','JR','595590751', '19760727', '107 ELM ST', '', 'BOYNTON BEACH', 'FL', '33426', '', '', '', '', '', '', '', '', '', ''},
		//{'failurecode8','BATCH', '', 'JUAN','R','BOLANOS','JR','595590751', '19760727', '321 SPRUCE ST', '', 'BOYNTON BEACH', 'FL', '33426', '', '', '', '', '', '', '', '', '', ''},
		{'failurecode9','BATCH', '', 'JUAN','R','BOLANOS','JR','595590751', '19790727', '321 SPRUCE ST', '', 'BOYNTON BEACH', 'FL', '33426', '', '', '', '', '', '', '', '', '', ''}
		*/], PhilipMorris.Layouts_Batch.InRecord);

		