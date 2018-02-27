#workunit('name','NonFCRA-nd20 process');
#option ('hthorMemoryLimit', 1000)

/* *** Note that Neticuity is turned ON *** needs to use Cert gateway  */

cdci_sprayed := record
	string30 account := '';
	string1  ordertype := '';
	string30 cmpy := '';
	string1  cmpytype := '';
	string15 first := '';
	string20 last := '';
	string50 addr := '';
	string   locality := '';
	string   province := '';
	string   postalcode := '';	
	string10 hphone := '';
	string10 wphone := '';
	string50 email := '';
	string32 ipaddr := '';
	string1  avscode := '';
	string2  channel := '';
	string15 first2 := '';  
	string20 last2 := '';
	string30 cmpy2 := '';
	string50 addr2 := '';
	string   locality2 := '';
	string   province2 := '';
	string   postalcode2 := '';	
	string10 hphone2 := '';
	string2  channel2 := '';
	string6  orderamt := '';
	string3  numitems := '';
	string8  orderdate := '';
	string4  cidcode := '';
	string2  shipmode := '';
	string2  pymtmethod := '';
	string2  prodcode := '';
	integer  HistoryDateYYYYMM;
end;

// settings
unsigned1 parallel_threads := 30;  //max number of parallel threads = 30
roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie; //Regular Roxie


//ds_in := dataset('~tfuerstenberg::in::costco_1355_canadian_in', cdci_sprayed, csv(quote('"')));
ds_in := choosen(dataset('~tfuerstenberg::in::costco_1355_canadian_in', cdci_sprayed, csv(QUOTE('"'))),20);
output(ds_in, named('cdci_sprayed'));

//mapping
Scoring.layout_cdco_soapcall into_CDCO_input(ds_in le) := transform
	self.tribcode := 'nd20';  // !! replace the tribcode here !!
	self.HistoryDateYYYYMM:=999999;			// as of 6/30/2009 this product is realtime only =============================================
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.gateways := riskwise.shortcuts.gw_netacuity;
	self := le;
	self := [];
end;

soap_in := project(ds_in,into_CDCO_input(LEFT));
output(soap_in, named('soap_in'));


Scoring.MAC_PROD_Soapcall(soap_in, RiskWise.Layouts.Layout_CDCO, roxieIP, 'RiskWise.RiskWiseMainCDCO', s_f, parallel_threads);


sg := s_f(errorcode=''); 
se := s_f(errorcode<>'');

output(sg, named('results'));
output(sg,,'~tfuerstenberg::out::test_nd20_out',csv(heading(single), quote('"')),overwrite );
output(se,,'~tfuerstenberg::out::test_error',CSV(QUOTE('"')), overwrite);