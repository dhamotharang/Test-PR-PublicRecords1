#workunit('name','Business IID Process');
#option ('hthorMemoryLimit', 1000);

import models, Risk_Indicators, Business_Risk, ut, riskwise;

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
// inputFile := '~cgrinsteiner::in::Business_IID';

inputFile := '~sghatti::in::Business_IID';

outfile_name := '~nkoubsky::out::Business_Instant_ID_Cust_Rec_Dev196_' + thorlib.wuid();

/* 
 * Number of records to run from the input file.  
 * Set to 0 to run ALL records in the input file.
 */
recordsOnInput := 0;

/* 
 * Number of parallel calls to run in the SOAPCALL to the Roxie Query 
 */
threads := 1;

/* 
 * Roxie the ECL Query is located on 
 */
roxieIP :=riskwise.shortcuts.Dev196;  // Dev196

/* *****************************************************
 *                      Main Script                    *
 *******************************************************/
layout:= record
	string	AccountNumber	;
	string	CompanyName	;
	string	AlternateCompanyName	;
	string	addr	;
	string	city	;
	string	state	;
	string	zip	;
	string	BusinessPhone	;
	string	TaxIdNumber	;
	string	BusinessIPAddress ;
	string	RepresentativeFirstName	;
	string	RepresentativeMiddleName ;
	string	RepresentativeLastName	;
	string	RepresentativeNameSuffix  ;
	string	RepresentativeAddr	;
	string	RepresentativeCity	;
	string	RepresentativeState	;
	string	RepresentativeZip	;
	string	RepresentativeSSN	;
	string	RepresentativeDOB	;
	string  RepresentativeAge   ;
	string	RepresentativeDLNumber	;
	string	RepresentativeDLState	;
	string	RepresentativeHomePhone	;
	string	RepresentativeEmailAddress	;
	string  RepresentativeFormerLastName ;
	integer	HistoryDateYYYYMM;
end;

// f1 := IF(recordsOnInput = 0, 
                // DATASET(inputFile, Layout, CSV(QUOTE('"'))),
                // CHOOSEN(DATASET(inputFile, Layout, csv(QUOTE('"'))), recordsOnInput));
								
f1 := IF(recordsOnInput = 0, 
                DATASET(inputFile, Layout, thor ),
                CHOOSEN(DATASET(inputFile, Layout, thor ), recordsOnInput));
								
f := f1;
//f := f1 (AccountNumber = '6'); //Use to test single customer number
// output(f);

Layout_BIID_Soapcall := record
	string	AccountNumber;
	string	BDID;
	string	CompanyName;
	string	AlternateCompanyName;
	string	Addr;
	string	City;
	string	State;
	string	Zip;
	string	BusinessPhone;
	string	TaxIdNumber;
	string	BusinessIPAddress;
	string	RepresentativeFirstName;
	string	RepresentativeMiddleName;
	string	RepresentativeLastName;
	string	RepresentativeNameSuffix;
	string	RepresentativeAddr;
	string	RepresentativeCity;
	string	RepresentativeState;
	string	RepresentativeZip;
	string	RepresentativeSSN;
	string	RepresentativeDOB;
	string	RepresentativeAge;
	string	RepresentativeDLNumber;
	string	RepresentativeDLState;
	string	RepresentativeHomePhone;
	string	RepresentativeEmailAddress;
	string 	RepresentativeFormerLastName;
	integer	HistoryDateYYYYMM;
	unsigned1	DPPAPurpose;
	unsigned1	GLBPurpose;
	dataset(Models.Layout_Score_Chooser) scores;
end;

Layout_BIID_Soapcall into_bus_input(f le) := transform
	self.dppapurpose := 3;
	self.glbpurpose := 1;
//	self.scores := dataset([{'Models.BusinessAdvisor_Service',roxieIP,[]}],models.Layout_Score_Chooser);
	self := le;
	self := [];
end;

indata := project(f,into_bus_input(LEFT));
// output(indata, named('biid_in'));

errx := record
	string errorcode := '';
	business_risk.Layout_Final_Denorm - score - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators;  // requested to take the score field out of the layout during testprocessing because batch customers don't see it
	DATASET(Models.Layout_Model) models;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.company_name := L.companyname;
	self.addr1 := L.addr;
	self.p_city_name := L.city;
	self.st := L.state;
	self.z5 := L.zip;
	self.phone10 := L.businessphone;
	self := L;
	self := [];
end;

results := soapcall(indata, roxieIP,
				'Business_Risk.InstantID_Service', {indata},
				dataset(errx), 
        RETRY(3), TIMEOUT(120), LITERAL,
        XPATH('Business_Risk.InstantID_ServiceResponse/Results/Result/Dataset[@name=\'Result 1\']/Row'),
				PARALLEL(threads), onfail(err_out(LEFT)));


// output(results, named('biid_results'));
op_final := output(results,, outfile_name, CSV(HEADING(single), QUOTE('"')));

sequential(op_final);

EXPORT Business_Instant_ID_Cust_Rec := 'Success';