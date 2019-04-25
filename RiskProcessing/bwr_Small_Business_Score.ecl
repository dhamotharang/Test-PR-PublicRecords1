#workunit('name','Small Business Score');
#option ('hthorMemoryLimit', 1000);

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT;
/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
recordsToRun := 0;
eyeball := 50;

threads := 30;

roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

inputFile := '~jpyon::in::compass_1190_bus_shell_in_in';
outputFile := '~tfuerstenberg::out::sbr_score_out';

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
bus_in := record
     string30  AccountNumber := '';
     string100 CompanyName := '';
	   string100 AlternateCompanyName := '';
     string50  Addr := '';
     string30  City := '';
     string2   State := '';
     string9   Zip := '';
     string10  BusinessPhone := '';
     string9   TaxIdNumber := '';
	   string16  BusinessIPAddress := '';
     string15  Representativefirstname := '';
	   string15  RepresentativeMiddleName := '';
     string20  Representativelastname := '';
	   string5   RepresentativeNameSuffix := '';
     string50  RepresentativeAddr := '';
     string30  RepresentativeCity := '';
     string2   RepresentativeState := '';
     string9   RepresentativeZip := '';
     string9   RepresentativeSSN := '';
     string8   RepresentativeDOB := '';
	   string3   RepresentativeAge := '';
     string20  RepresentativeDLNumber := '';
     string2   RepresentativeDLState := '';
	   string10  RepresentativeHomePhone := '';
     string50  RepresentativeEmailAddress := '';
	   string20  RepresentativeFormerLastName := '';
	   integer   historydateyyyymm;
end;

f := IF(recordsToRun <= 0, DATASET(inputFile, bus_in, CSV(QUOTE('"'))), 
                          choosen(dataset(inputFile, bus_in, csv(quote('"'))), recordsToRun));

output(choosen(f, eyeball), named('Sample_Raw_Input'));


layout_small_business_soap := record
	string original_account;
	dataset(iesp.ws_analytics.t_SmallBusinessRiskRequest) SmallBusinessRiskRequest;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;	
	unsigned HistoryDateYYYYMM;
end;

layout_small_business_soap into_soap_layout(bus_in le, integer c) := transform	
	self.original_account := le.accountnumber;
	
	self.gateways := dataset([], risk_indicators.Layout_Gateways_In);

	self.SmallBusinessRiskRequest := project(ut.ds_oneRecord,
			transform(iesp.ws_analytics.t_SmallBusinessRiskRequest, 
						self.user.AccountNumber := (string)C,
						self.user.GLBPurpose := (string)riskwise.permittedUse.fraudGLBA;
						self.user.DLPurpose := (string)riskwise.permittedUse.fraudDPPA;
						
						self.searchby.business.name := le.companyname;
						self.searchby.business.address.StreetAddress1 := le.addr;
						self.searchby.business.address.city := le.city;
						self.searchby.business.address.state := le.state;
						self.searchby.business.address.zip5 := le.zip;	
						self.searchby.business.fein := le.TaxIdNumber;
						self.searchby.business.phone10 := le.BusinessPhone;
						
						self.searchby.owneragent.name.first := le.Representativefirstname;
						self.searchby.owneragent.name.middle := le.RepresentativeMiddleName;
						self.searchby.owneragent.name.last := le.Representativelastname;
						self.searchby.owneragent.name.suffix := le.RepresentativeNameSuffix;
						self.searchby.owneragent.address.streetaddress1 := le.RepresentativeAddr;
						self.searchby.owneragent.address.city := le.RepresentativeCity;
						self.searchby.owneragent.address.state := le.RepresentativeState;
						self.searchby.owneragent.address.zip5 := le.RepresentativeZip;
						self.searchby.owneragent.ssn := le.RepresentativeSSN;
						self.searchby.owneragent.dob.year := (unsigned)le.RepresentativeDOB[1..4];
						self.searchby.owneragent.dob.month := (unsigned)le.RepresentativeDOB[5..6];
						self.searchby.owneragent.dob.day := (unsigned)le.RepresentativeDOB[7..8];						
						self.searchby.owneragent.phone10 := le.RepresentativeHomePhone;
						
						self := []));
	SELF.HistoryDateYYYYMM := (Integer) le.historydateyyyymm[1..6];					
	// self.historydateyyyymm := le.historydateyyyymm;
	self := [];
end;

indata := DISTRIBUTE(project(f,into_soap_layout(LEFT, counter)), RANDOM());
output(choosen(indata, eyeball), named('sample_soap_input'));

ox := record
	iesp.ws_analytics.t_SmallBusinessRiskResponse;
	string errorcode;
end;

ox myFail(indata le) :=	TRANSFORM
	self._header.queryid := le.SmallBusinessRiskRequest[1].user.AccountNumber;
	self.errorcode := FAILCODE + FAILMESSAGE;
	SELF := [];
END;

resu := SOAPCALL(indata, roxieIP,
				'LNSmallBusiness.SmallBusiness_Service', {indata}, 
				DATASET(ox),
        RETRY(5), TIMEOUT(500), LITERAL,
        XPATH('LNSmallBusiness.SmallBusiness_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

output(choosen(resu, eyeball), named('sample_roxie_result'));
output(count(resu(errorcode<>'')), named('number_of_errors'));

// this is probably all the customer is interested in from the roxie results
layout_out := record
	string30  AccountNumber := '';
	string30  seq := '';
	string3   score1; // actual score (eg, 500-999)
	string4   rep_rc11; // rep reason codes and descriptions
	string4   rep_rc21;
	string4   rep_rc31;
	string4   rep_rc41;
	string4   bus_rc11; // business reason codes and descriptions
	string4   bus_rc21;
	string4   bus_rc31;
	string4   bus_rc41;
	string errorcode;	
end;

j := join(indata,resu, (unsigned)left.SmallBusinessRiskRequest[1].user.AccountNumber = (unsigned)right._header.queryid,
		transform(layout_out,
			self.accountnumber := left.original_account,
			self.seq := right._header.queryid,
			self.score1 := (string)right.result.models[1].scores[1].value,	
			self.rep_rc11 := (string)right.result.models[1].scores[1].owneragenthighriskindicators[1].riskcode,
			self.rep_rc21 := (string)right.result.models[1].scores[1].owneragenthighriskindicators[2].riskcode,
			self.rep_rc31 := (string)right.result.models[1].scores[1].owneragenthighriskindicators[3].riskcode,
			self.rep_rc41 := (string)right.result.models[1].scores[1].owneragenthighriskindicators[4].riskcode,
			self.bus_rc11 := (string)right.result.models[1].scores[1].businesshighriskindicators[1].riskcode,
			self.bus_rc21 := (string)right.result.models[1].scores[1].businesshighriskindicators[2].riskcode,
			self.bus_rc31 := (string)right.result.models[1].scores[1].businesshighriskindicators[3].riskcode,
			self.bus_rc41 := (string)right.result.models[1].scores[1].businesshighriskindicators[4].riskcode,
	
			self.errorcode := right.errorcode));
output(choosen(j, eyeball), named('sample_slim_results'));
output(j,, outputFile, CSV(heading(single), quote('"')), overwrite);
