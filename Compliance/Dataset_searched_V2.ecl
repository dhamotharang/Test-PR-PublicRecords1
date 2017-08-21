IMPORT Address, Compliance, ut,Data_Services;


string ToCaps(string s) := stringlib.stringToUpperCase(s);
string CleanSpaces(string s) := stringlib.StringCleanSpaces(s);


EXPORT  Compliance.Layout_orig_out Dataset_searched_V2(Compliance.Layout_Parms_v4 LE) := 

	TRANSFORM
		SELF.srch_class := LE.class;
		SELF.srch_uid := LE.uid;
		
		SELF.srch_fname := LE.fname;
		SELF.srch_mname := LE.mname;
		SELF.srch_lname := LE.lname;
		SELF.srch_fullname := LE.fullname;
		SELF.srch_busname := LE.busname;
//		SELF.srch_address := LE.address;
//		SELF.srch_city := LE.city;
//		SELF.srch_state := LE.state;
//		SELF.srch_zip := LE.zip;
		SELF.srch_address := IF(LE.address <> '' AND REGEXFIND ('5E101', LE.addr_clnr_string),	// If the cleaner has no output then return the original data
														LE.address
														, LE.addr_clnr_string[1..10] + ' ' + LE.addr_clnr_string[11..12] + ' ' + LE.addr_clnr_string[13..40] + ' ' + LE.addr_clnr_string[41..44] + ' ' + LE.addr_clnr_string[45..46]);	//LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir
		SELF.srch_address_sec_range := IF(SELF.srch_address <> '', LE.addr_clnr_string[57..64], '');												
		SELF.srch_city 		:= IF(LE.city <> '' AND REGEXFIND ('5E101', LE.addr_clnr_string),
														LE.city, LE.addr_clnr_string[65..89]);
		SELF.srch_state 	:= IF(LE.state <> '' AND REGEXFIND ('5E101', LE.addr_clnr_string),
														LE.state, LE.addr_clnr_string[115..116]);
		SELF.srch_zip 		:= IF(LE.zip <> '' AND REGEXFIND ('5E101', LE.addr_clnr_string),
														LE.zip, LE.addr_clnr_string[117..121]);

		SELF.srch_ssn := LE.ssn;
		SELF.srch_dob := LE.dob;
		SELF.srch_phone := LE.phone;
		
		SELF.srch_tag := trim(LE.tag, all);
		SELF.srch_vin := trim(LE.vin, all);
		
		SELF.edited_search_terms := MAP(LE.edited_search_terms <> '' => LE.edited_search_terms
																		,LE.edited_search_terms = '' AND SELF.srch_uid <> 0 => 'UID=' + (string) SELF.srch_uid
																		,LE.edited_search_terms = '' AND SELF.srch_tag <> '' => 'TAG=' + SELF.srch_tag
																		,LE.edited_search_terms = '' AND SELF.srch_vin <> '' => 'VIN=' + SELF.srch_vin	
																		,'');
		SELF.search_str := ToCaps(SELF.edited_search_terms);
		SELF.srch_criteria := SELF.search_str;
		
		
		SELF.srch_dataset := MAP(
															regexfind('(BLJSEARCH|BANKRUPTREPORT2|BANKRUPTSEARCH2)',LE.file)	=> 'Bankruptcies',
															regexfind('(ALSOFOUNDBUSREP|BIZCREDITSEARCH|BUSSEARCH|CORPREPORTV2|CORPSEARCHV2|DNBSEARCH|ENHANCEDBUSRPT|ENHANCEDBUSSRCH|FAB|GV_BUSREPORT|TOPBIZSEARCH)',LE.file)	=> 'Bus_Hdr',
															regexfind('(CIVILCOURTSEARCH|COURTSEARCH|CRIMREPORT|CRIMSEARCH|NATCRM)',LE.file)	=> 'Crims',
															regexfind('DEATHSEARCH',LE.file)	=> 'Death_Master',
															regexfind('(DLSEARCH2|DRVLIC)',LE.file)		=> 'Drivers',
															
															regexfind('EMAILSEARCH',LE.file)			=> 'Email_Addrs',
															regexfind('CONCEALED_WEAPON',LE.file)	=> 'Concealed_Weapons',
															regexfind('(PHONEL|PHONEP|PHONES|WIRELESS)',LE.file)	=> 'Phones',
															
															regexfind('(LIENREPORT|LIENSEARCH)',LE.file)	=> 'Liens',
															regexfind('(PROPERTYREPORT2|PROPERTYSEARCH2|PROPSEARCHA2|PROPSEARCHD2|RPROP)',LE.file)	=> 'Real_Prop',
															
															regexfind('(MDSEARCH2|MLDVRC)',LE.file)	=> 'Mar_Div',
															regexfind('OFFICIALRECSEARC',LE.file)	=> 'Off_Rec',
															regexfind('(PEOPLEATWORK|PEOPLEATWORKV2)',LE.file)	=> 'Peop_at_Work',
															regexfind('(PROFLICSEARCH2|PROLIC)',LE.file)	=> 'Prof_Lic',
															regexfind('(PROVIDERSEARCH|SANCTIONSEARCH)',LE.file)	=> 'Providers',
															regexfind('(NA|NSASSOCIATES|NSNEIGHBORS|NSRELATIVES|RELATIVEREPORT|RNASEARCH)',LE.file)	=> 'RNA',
															
															regexfind('SEXOFFSEARCH',LE.file)	=> 'SOFF',
															
															regexfind('UCCSEARCHV2',LE.file)	=> 'UCC_Party',
															regexfind('(GV_MVREPORT|MOTORV|MVREPORT2|MVSEARCH2|MVWILDSRCH)',LE.file)	=> 'Veh_Regs',
															regexfind('VOTERSEARCH2',LE.file)	=> 'Voters',
															regexfind('GLOBALWATCHLIST',LE.file)	=> 'WatchLists',
															regexfind('WHOIS',LE.file)	=> 'WhoIs_Domains',
															regexfind('(WORKPLACE|WORKPLACESEARCH|WORKPLACEREPORT)',LE.file)	=> 'WPL_POE',
															regexfind('(IMAGE|IMAGE_ACCESS)',LE.file)	=> 'Image_No_Data',
															
														'Person_Hdr'
														);

/*
set_PHDR_FILE_values := [
													 'ADDRCOUNT'
													,'ADDRREPORT'
													,'ASSETREPORT'
													,'CAPSW'
													,'CLR'
													,'COMPREPORT'					//March 2014: Can't simulate Comp Reports
													,'CPRS'								//March 2014: Can't simulate Comp Reports
													,'CPRS,CLR,FAP'				//March 2014: Can't simulate Comp Reports
													,'CPRS,FAP'						//March 2014: Can't simulate Comp Reports
													,'CP_ROLLPERSSRCH'		//March 2014
													,'FAL'
													,'FAL,PRPHIS,FAP,CPRS'//March 2014: Can't simulate Comp Reports
													,'FAP'
													,'FAP,CLR'
													,'FAP,CPRS'							//March 2014: Can't simulate Comp Reports
													,'FAP,CPRS,PRPHIS'			//March 2014: Can't simulate Comp Reports
													,'FINDERREPORT'
													,'GV_ADDRREPORT'
													,'GV_COMPREPORT'				//March 2014: Can't simulate Comp Reports
													,'IDREPT'
													,'LOCATIONREPORT'
													,'LOCATIONSEARCH'
													
													,'NA'										//March 2014: Can't simulate Comp Reports
													,'NSASSOCIATES'					//March 2014: Can't simulate Comp Reports
													,'NSNEIGHBORS'					//March 2014: Can't simulate Comp Reports
													,'NSRELATIVES'					//March 2014: Can't simulate Comp Reports
													,'RNASEARCH'						//March 2014: Can't simulate Comp Reports
													
													,'PRPHIS'								//Is this Property History report?
													
													,'ROLLPERSEARCH'
													,'RTPERSONSEARCH'				//Can't simulate real-time
													,'SOURCEDCO'						//Usually there's no seacrh string with this "FILE" value
													,'STATEWIDEPERSSRC'
													,'SUMMARYREPORT'
													
													,'AFINDICATORS'			// 2 searches with PII. All others, state only => skip
													,'SOCNETSRCH'				// this is a gateway, but the app returns PII data
													
													,'DLSEARCH2'				// Drivers: Filter later
													,'PROPSEARCHA2'			// RP Tax: Filter later
													,'PROPSEARCHD2'			// RP Deeds: Filter later
													,'RPROP'						// Real Property: Filter later
													,'VOTERSEARCH2'			// Voters: Filter later
													];
*/															
/*		SELF.source_value := MAP(
															self.srch_dataset = 'Bankruptcies' => LE.vendor_id,		//court_code
															self.srch_dataset = 'Bus_Hdr' => LE.src,
															self.srch_dataset = 'Crims' => LE.vendor_id,		//src = vendor; vendor_id = source_file
															self.srch_dataset = 'Death_Master' => LE.src,
															self.srch_dataset = 'Drivers' => LE.src,
															self.srch_dataset = 'Email_Addrs' => LE.src,
															self.srch_dataset = 'Concealed_Weapons' => LE.src,
															self.srch_dataset = 'Phones' => LE.src,
															self.srch_dataset = 'Liens' => LE.src,
															self.srch_dataset = 'Real_Prop' => LE.src,
															self.srch_dataset = 'Mar_Div' => LE.vendor_id,	//or can use src	//vendor
															self.srch_dataset = 'Off_Rec' => LE.src + ',' + LE.listed_name,	//src = state_origin; listed_name := doc_type_desc
															self.srch_dataset = 'Peop_at_Work' => LE.src,
															self.srch_dataset = 'Prof_Lic' => LE.src + ',' + LE.listed_name,	//src = source_st; listed_name := vendor
															self.srch_dataset = 'Providers' => 'INGNX,' + LE.vendor_id,	//src = 'IG' = Ingenix; vendor_id := FILETYP
															self.srch_dataset = 'UCC_Party' => IF(LE.src = 'DN', 'DNB', LE.src + ',UCC'),
															self.srch_dataset = 'Veh_Regs' => LE.src,
															self.srch_dataset = 'Voters' => LE.src,
															self.srch_dataset = 'WatchLists' => LE.vendor_id,	//src = 'GL' = Global WatchLists; vendor_id := listid
															self.srch_dataset = 'WhoIs_Domains' => 'WhoIs',		//src = 'DN' = WhoIs domains
															self.srch_dataset = 'WPL_POE' => LE.src
															
															,LE.src
														);
*/		
		SELF := LE;
		
	END;