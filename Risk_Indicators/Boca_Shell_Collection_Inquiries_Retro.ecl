import riskwisefcra, doxie, gateway;

EXPORT Boca_Shell_Collection_Inquiries_Retro(grouped dataset(risk_indicators.layout_boca_shell) clam,
	dataset(Gateway.Layouts.Config) gateways) := function

// soapcall to the neutral roxie to get counts of inquiries in collections
// we only do this in retro testing mode to account for collection transactions that would have happened in neutral roxie
// prior to Project July conversion of collection products over to FCRA roxie

inrec := record
	dataset(risk_indicators.layout_input) batch_in;
	boolean _Blind := false;
end;

// only bother making soapcall for records with DIDs
clams_with_dids := clam(did<>0);
clams_without_did := clam(did=0);
		
foo := dataset([{Project(clams_with_dids, transform(risk_indicators.Layout_Input, 
	self.seq := left.seq;
	self := left.shell_input, 
	self := left)), Gateway.Configuration.GetBlindOption(gateways)}], inrec);

ox := record
	risk_indicators.layout_boca_shell;
end;

ox errX(foo L) := transform
	self.errmsg := ERROR (FAILCODE, 'Neutral Collection Inquiry Service: ' + FAILMESSAGE);
	SELF.seq := L.batch_in[1].seq; 
	self := [];
end;

gateway_check := gateways(servicename IN riskwisefcra.Neutral_Service_Name)[1].url;
gateway_url := IF(gateway_check='',ERROR(301,doxie.ErrorCodes(301)),gateway_check);

soap_response := soapcall(foo, gateway_url, 
				'Risk_Indicators.Boca_Shell_Collections_Inquiry_Service',
		 		 inrec, transform(inrec, self := left), 
			 	 dataset(ox),
			 	 parallel(3), merge(33), // pass multiple records at 1 time
				 onFail(errX(LEFT)),
				 timeout(600));	// changed the timeout		


appended_collections := join(clams_with_dids, soap_response, left.seq=right.seq,
	transform(risk_indicators.Layout_Boca_Shell,
		self.acc_logs.collection.CountTotal := left.acc_logs.collection.CountTotal + right.acc_logs.collection.CountTotal;
		self.acc_logs.collection.CountDay := left.acc_logs.collection.CountDay + right.acc_logs.collection.CountDay;
		self.acc_logs.collection.CountWeek := left.acc_logs.collection.CountWeek + right.acc_logs.collection.CountWeek ;
		self.acc_logs.collection.Count01 := left.acc_logs.collection.Count01 + right.acc_logs.collection.Count01 ;
		self.acc_logs.collection.Count03 := left.acc_logs.collection.Count03 + right.acc_logs.collection.Count03 ;
		self.acc_logs.collection.Count06 := left.acc_logs.collection.Count06 + right.acc_logs.collection.Count06 ;
		self.acc_logs.collection.Count12 := left.acc_logs.collection.Count12 + right.acc_logs.collection.Count12 ;
		self.acc_logs.collection.Count24 := left.acc_logs.collection.Count24 + right.acc_logs.collection.Count24 ;
		self.acc_logs.collection.CBDCountTotal := left.acc_logs.collection.CBDCountTotal + right.acc_logs.collection.CBDCountTotal ;
		self.acc_logs.collection.CBDCount01 := left.acc_logs.collection.CBDCount01 + right.acc_logs.collection.CBDCount01 ;
		self := left;
		), left outer, keep(1));

appended_collections_retro := clams_without_did + appended_collections;

// output(clams_with_dids, named('clams_with_dids'));
// output(foo, named('foo'));
// output(soap_response, named('soap_response'));
// output(appended_collections_retro, named('appended_collections_retro'));

return group(appended_collections_retro, seq);

end;