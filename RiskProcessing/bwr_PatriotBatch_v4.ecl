import Gateway, iesp, Patriot, Riskwise;
plugin_version := 4;
eyeball := 100;

prii_layout := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING HomePhone;
	STRING SSN;
	STRING DateOfBirth;
	STRING WorkPhone;
	STRING income;  
	string DLNumber;
	string DLState;
	string BALANCE; 
	string CHARGEOFFD;  
	string FormerName;
	string EMAIL;  
	string COMPANY;
	string historydate;
	// string search_type; // a file could have a field similar to this, if it does there are two different searchtype fileds that would need to be updated if this field exists
END;


// sdn := dataset('~dvstemp::in::ofac::20160325::sdn.csv', r, csv(quote('"')) )(sdn_number in ['15771', '12904', '10795', '12193','12437','11525']);
r := choosen(dataset('~mmarshik::in::bridgertestsamplenames::bridgertestsamplenames.csv', prii_layout, csv(quote('"'),heading(1))),100 );
output(r);

// I-Individual, N-NonIndividual, B-Both
// STRING1 searchtype_value := 'B' 

batch_in := record
	Patriot.Layout_batch_in;
end;

layout_soap := RECORD
	// You can use either as grouping, as we don't actually use either in base_function
	dataset(batch_in) batch_in;
	
	unsigned8 MaxResults := 2000 ;
	unsigned8 MaxResultsThisTime ;
	unsigned8 SkipRecords := 0;

	unsigned1 OFACversion := plugin_version ;
	real Threshold := 0.85; 
	boolean OfacOnly := false;
	boolean IncludeAdditionalWatchlists := FALSE;
	boolean IncludeOfac := FALSE;
  dataset(iesp.share.t_StringArrayItem) Watchlist {xpath('Watchlist/Row/WatchList/Name')};
	boolean UseDobFilter := FALSE;
	integer2 DobRadius := -1;
	// string10 acctno;
	// unsigned4 seq := 0;
	
	// STRING50 FirstName;
	// STRING50 MiddleName;
	// STRING50 LastName;
	// STRING150 UnParsedName;
	STRING20 search_type;
	// string20 country;
	// STRING8  DateOfBirth := '';
		DATASET(Gateway.Layouts.Config) gateways;

END;

batch_in SDNbatch_in(r le, integer c) := transform
	self.acctno := le.AccountNumber; // if file doesn't have an account number set to '';
	self.seq := c;	
		self.name_first := le.FirstName; // if your file layout is not using this and using the name_unparsed set to '';
	self.name_middle := le.MiddleName; // if your file layout is not using this and using the name_unparsed set to '';
	self.name_last  := le.LastName; // if your file layout is not using this and using the name_unparsed set to '';
	self.name_unparsed  := ''; // if you're using this set as le.(name of the unparsed field coming from the prii_layout); Look at the examples above for first, middle, and last
	// self.search_type  := 'B'; // the searchtype in batch_in isn't looked at so set this in search_type on line 116
	self.Country  := '';
	self.dob := '';

  self := [];
end;


layout_soap SDNprep_soap(r le, integer c) := transform
	self.batch_in := project(le, SDNbatch_in(left, c));
	self.MaxResults := 2000 ;
	// self.MaxResultsThisTime ;
	// self.SkipRecords := 0;
/*	
	WATCHLIST DEFINITIONS

OFAConly - this makes it so only OFAC hits are returned, this should not be used with IncludeOfac, IncludeAdditionalWatchlists, and Watchlist as it was created for use only in version 1 of OFAC, can be set to either true or false  

ExcludeWatchlists - this will make it so no watchlists are ever returned, this function only works with OFACversion equal to 1, can be set to either true or false

IncludeOFAC - this makes it so only OFAC hits are returned, this function only works with OFACversions >= 2, can be set to either true or false, simliar to only requesting OFAC in the watchlist dataset

IncludeAdditionalWatchlists - this makes it so other watchlist outside of OFAC are returned, this functon only works with OFACversions >= 2, can be set to either true or false, combined with IncludeOFAC it is similar to running ALL in the watchlist dataset

Watchlist - this allows to input a watchlist or watchlist(s) that you specifically want to search. Examples of possible input are ALL - all watchlists, ALLV4 - all watchlists including new bridger ones, OFAC - just OFAC watchlists, BES - just BES watchlist, etc.
*/
	self.OFACversion := plugin_version ;
	self.Threshold := .85 ;
	self.OfacOnly := false;
	self.IncludeAdditionalWatchlists := FALSE;
	self.IncludeOfac := FALSE;
  self.watchlist := dataset([{'OFAC'}],iesp.share.t_StringArrayItem); // use this if you only need one watchlist
  // self.watchlist := dataset([{'OFAC'}],iesp.share.t_StringArrayItem) +
									  // dataset([{'BES'}],iesp.share.t_StringArrayItem); // use this if you need more than one watchlist, follow the same formatting to add one more if needing more than two 
	self.UseDobFilter := FALSE;
	self.dobradius := -1;
	self.search_type  := 'B'; // use this if no searchtype is given from the file
	// self.search_type  := MAP(le.PersonalBusiness  in ['Business']  => 'N', 
												  // le.PersonalBusiness  in [ 'Personal'] => 'I',
																			// 'B'); //use this if a searchtype is given and modify based on what searchtype is called in the file
	// self.gateways := dataset([{'bridgerxg5', 'http://bridger_dev:NoMoreBugs!@10.173.132.10:7001/WsSearchCore?ver_=1'}], Gateway.Layouts.Config); 
	self.gateways := dataset([{'bridgerwlc', 'http://bridger_batch_cert:Br1dg3rBAtchC3rt@172.16.70.19:7003/WsSearchCore?ver_=1'}], Gateway.Layouts.Config); 

	SELF := [];
end;	

SDNsoapIN := PROJECT (if(eyeball = 0, r, choosen(r,eyeball)), SDNprep_soap(left,counter));
output(SDNsoapIN, named('SDNsoapIN_Input'));
output(count(SDNsoapIN), named('countSDNsoapIN_Input'));

// dist_dataset := PROJECT(ALTsoapIN,TRANSFORM(layout_soap,SELF := LEFT));
dist_dataset := PROJECT(SDNsoapIN,TRANSFORM(layout_soap,SELF := LEFT));
output(dist_dataset, named('dist_dataset'));

// roxieIP := 'http://roxiebatch.br.seisint.com:9856'; // roxiebatch
// roxieIP := riskwise.shortcuts.Dev194;
// roxieIP := riskwise.shortcuts.Dev192;
// roxieIP := riskwise.shortcuts.prod_batch_neutral;
// roxieIP := riskwise.shortcuts.staging_neutral_roxieIP;
// roxieIP := riskwise.shortcuts.cert_OSS_neutral_roxieIP;
// roxieIP := riskwise.shortcuts.staging_neutral_roxieIP;
// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';
// roxieIP := riskwise.shortcuts.Dev156;
roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;




remark := RECORD
  STRING75 remark_v;
END;
address := RECORD
	STRING100 country;
	STRING50 addr_1;
	STRING50 addr_2;
	STRING50 addr_3;
	STRING50 addr_4;
	STRING50 addr_5;
	STRING50 addr_6;
	STRING50 addr_7;
	STRING50 addr_8;
	STRING50 addr_9;
	STRING50 addr_10;
END;

 aka :=
RECORD
	STRING350 orig_pty_name;
	STRING5 score;
END;

xlayout := RECORD
	patriot.layout_batch_out; // Results {XPATH('Dataset[@name=\'Results\']/Row')};
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	// SELF.AccountNumber := le.AccountNumber;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, roxieIP,
				'patriot.patriot_batch', {dist_dataset}, 
				DATASET(xlayout),
				//RETRY(2), TIMEOUT(500), //LITERAL,
			  // XPATH('patriot.patriot_searchResponse/Result/Results/Dataset[@name=\'Results\']/Row'),
				PARALLEL(1), 
				onFail(myFail(LEFT)));
				
Misses := join(resu, dist_dataset, right.batch_in[1].acctno = left.acctno,
								transform(recordof(dist_dataset), self := right), right only);			
				
output(Misses, named('Misses'));
output(resu, named('RESULTS'));
output(resu,, '~mmarshik::out::PatriotSearchBatch_v4',CSV(HEADING(single), QUOTE('"')), OVERWRITE);

				