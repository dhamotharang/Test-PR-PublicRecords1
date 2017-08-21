

layout_results := Compliance.Layout_srch_results;
//	RECORD
//		compliance.Layout_Out;
//		compliance.Layout_Out_v2;
//		string srch_dataset := '';
//		string source_value := '';
//	END;	


//EXPORT layout_results Dataset_searched(Compliance.Layout_Out resultfile) := 
EXPORT layout_results Dataset_searched(Compliance.Layout_Out_v2 resultfile) := 
	TRANSFORM
		SELF.srch_dataset := MAP(
															regexfind('(BLJSEARCH|BANKRUPTREPORT2|BANKRUPTSEARCH2)',resultfile.file)	=> 'Bankruptcies',
															regexfind('(ALSOFOUNDBUSREP|BIZCREDITSEARCH|BUSSEARCH|CORPREPORTV2|CORPSEARCHV2|DNBSEARCH|ENHANCEDBUSRPT|ENHANCEDBUSSRCH|FAB|GV_BUSREPORT)',resultfile.file)	=> 'Bus_Hdr',
															regexfind('(CIVILCOURTSEARCH|COURTSEARCH|CRIMREPORT|CRIMSEARCH|NATCRM)',resultfile.file)	=> 'Crims',
															regexfind('DEATHSEARCH',resultfile.file)	=> 'Death_Master',
															regexfind('(DLSEARCH2|DRVLIC)',resultfile.file)		=> 'Drivers',
															
															regexfind('EMAILSEARCH',resultfile.file)			=> 'Email_Addrs',
															regexfind('CONCEALED_WEAPON',resultfile.file)	=> 'Concealed_Weapons',
															regexfind('(PHONEL|PHONEP|PHONES|WIRELESS)',resultfile.file)	=> 'Phones',
															
															regexfind('(LIENREPORT|LIENSEARCH)',resultfile.file)	=> 'Liens',
															regexfind('(PROPERTYREPORT2|PROPERTYSEARCH2|PROPSEARCHA2|PROPSEARCHD2|RPROP)',resultfile.file)	=> 'Real_Prop',
															
															regexfind('(MDSEARCH2|MLDVRC)',resultfile.file)	=> 'Mar_Div',
															regexfind('OFFICIALRECSEARC',resultfile.file)	=> 'Off_Rec',
															regexfind('(PEOPLEATWORK|PEOPLEATWORKV2)',resultfile.file)	=> 'Peop_at_Work',
															regexfind('(PROFLICSEARCH2|PROLIC)',resultfile.file)	=> 'Prof_Lic',
															regexfind('(PROVIDERSEARCH|SANCTIONSEARCH)',resultfile.file)	=> 'Providers',
															regexfind('SEXOFFSEARCH',resultfile.file)	=> 'SOFF',
															
															regexfind('UCCSEARCHV2',resultfile.file)	=> 'UCC_Party',
															regexfind('(GV_MVREPORT|MOTORV|MVREPORT2|MVSEARCH2|MVWILDSRCH)',resultfile.file)	=> 'Veh_Regs',
															regexfind('VOTERSEARCH2',resultfile.file)	=> 'Voters',
															regexfind('GLOBALWATCHLIST',resultfile.file)	=> 'WatchLists',
															regexfind('WHOIS',resultfile.file)	=> 'WhoIs_Domains',
															regexfind('WORKPLACESEARCH',resultfile.file)	=> 'WPL_POE',
															
														'Person_Hdr'
														);
															
		SELF.source_value := MAP(
															self.srch_dataset = 'Bankruptcies' => resultfile.vendor_id,		//court_code
															self.srch_dataset = 'Bus_Hdr' => resultfile.src,
															self.srch_dataset = 'Crims' => resultfile.vendor_id,		//src = vendor; vendor_id = source_file
															self.srch_dataset = 'Death_Master' => resultfile.src,
															self.srch_dataset = 'Drivers' => resultfile.src,
															self.srch_dataset = 'Email_Addrs' => resultfile.src,
															self.srch_dataset = 'Concealed_Weapons' => resultfile.src,
															self.srch_dataset = 'Phones' => resultfile.src,
															self.srch_dataset = 'Liens' => resultfile.src,
															self.srch_dataset = 'Real_Prop' => resultfile.src,
															self.srch_dataset = 'Mar_Div' => resultfile.vendor_id,	//or can use src	//vendor
															self.srch_dataset = 'Off_Rec' => resultfile.src + ',' + resultfile.listed_name,	//src = state_origin; listed_name := doc_type_desc
															self.srch_dataset = 'Peop_at_Work' => resultfile.src,
															self.srch_dataset = 'Prof_Lic' => resultfile.src + ',' + resultfile.listed_name,	//src = source_st; listed_name := vendor
															self.srch_dataset = 'Providers' => 'INGNX,' + resultfile.vendor_id,	//src = 'IG' = Ingenix; vendor_id := FILETYP
															self.srch_dataset = 'UCC_Party' => IF(resultfile.src = 'DN', 'DNB', resultfile.src + ',UCC'),
															self.srch_dataset = 'Veh_Regs' => resultfile.src,
															self.srch_dataset = 'Voters' => resultfile.src,
															self.srch_dataset = 'WatchLists' => resultfile.vendor_id,	//src = 'GL' = Global WatchLists; vendor_id := listid
															self.srch_dataset = 'WhoIs_Domains' => 'WhoIs',		//src = 'DN' = WhoIs domains
															self.srch_dataset = 'WPL_POE' => resultfile.src,
															
															resultfile.src
														);
														
		SELF := resultfile;
	END;
	