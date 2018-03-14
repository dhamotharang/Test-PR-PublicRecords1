#workunit('name', 'FCRA derogs report historical');
#option ('hthorMemoryLimit', 1000);

eyeball := 5;
in_file := '~jpyon::in::sb_1000_input_f_s_in';
out_file := '~dvstemp::out::sb_1000_derogs_report';

f := choosen(dataset(in_file, riskprocessing.layouts.nugen_prii_layout, csv(quote('"'))), eyeball);
// f := dataset(in_file, riskprocessing.layouts.nugen_prii_layout, csv(quote('"')));
output(choosen(f, eyeball), named('raw_input'));

layout_soap := record
	string30 orig_account;
	STRING30 AccountNumber;
	STRING30 FirstName;
	STRING30 MiddleName;
	STRING30 LastName;
	STRING120 Addr;
	STRING25 City;
	STRING2 State;
	STRING9 Zip;
	STRING9 SSN;
	STRING8 DOB;
	STRING10 Phone; 
	unsigned4 historydateyyyymmdd;
	dataset(risk_indicators.Layout_Gateways_In) gateways;
end;

// neutral_roxieIP := 'http://roxiestaging.br.seisint.com:9876';
// neutral_roxieIP := 'http://oroxievip.sc.seisint.com:9876';
neutral_roxieIP := 'http://roxiebatch.br.seisint.com:9856';


layout_soap into_soap(f le, integer C) := transform
	self.orig_account := le.accountnumber;
	self.accountnumber := (string)c;
	self.addr := le.streetaddress;
	self.dob := le.dateofbirth;
	self.phone := le.homephone;
	self.gateways := dataset([{'neutralroxie', neutral_roxieIP}], risk_indicators.Layout_Gateways_In);
	self.historydateyyyymmdd := if(le.historydateyyyymm='', 99999999, (unsigned)(le.historydateyyyymm[1..6] + '01') );
	self := le;
	self := [];
end;

soap_in := project(f,into_soap(LEFT, counter)); 
output(choosen(soap_in, eyeball), named('soap_in'));

roxieIP := 'http://fcrabatch.sc.seisint.com:9876';  // fcra batch
// roxieIP :='http://ofcraroxievip.sc.seisint.com:9876' ; // fcra dr vip
// roxieIP := 'http://oroxievip.sc.seisint.com:9876'; // dr vip
// roxieIP := 'http://roxiebatch.br.seisint.com:9876';  // production batch roxie
// roxieIP := 'http://roxiestaging.br.seisint.com:9876';  // staging neutral
// roxieIP := 'http://10.173.202.3:9876';  //single node roxie
// roxieIP := 'http://10.173.195.3:9876';  //single node roxie
// roxieIP := 'http://roxiedevvip.sc.seisint.com:9876'; // dev64 roxie
// roxieIP := 'http://roxiedevvip32.sc.seisint.com:9876'; // dev32 roxie

ox := record
	fcra.RiskView_Derogs_Module.xml_layout;
	string200 errorcode := '';
end;

ox myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.seq := (unsigned)l.accountnumber;
	self := [];
end;

roxie_results := soapcall(soap_in, 
						  roxieIP ,
						  'FCRA.RiskView_Derogs_Report', 
						  {soap_in},
						  dataset(ox), 
						  parallel(30), 
						  onfail(myfail(LEFT)));
output(choosen(roxie_results, eyeball), named('roxie_results'));

just_flags := record
	string30 orig_account;
	string1 hit;
	fcra.RiskView_Derogs_Module.layout_derogs_summary;
	string200 errorcode := '';
end;

j := join(soap_in, roxie_results, (unsigned)left.accountnumber=right.seq, transform(just_flags, self.orig_account := left.orig_account, self := right));
output(choosen( j, eyeball), named('just_flags'));	
output(count( j(errorcode<>'')), named('error_count'));			
output(choosen( j(errorcode<>''), eyeball), named('errors'));

// write out the results to logical file to give back to customer
// output(j,,out_file, csv(heading(single), quote('"')));