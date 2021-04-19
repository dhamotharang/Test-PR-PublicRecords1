pb1i_layout := record
	string30 ACCOUNT := '';
     string30 CMPY := '';
     string30 DBANAME := '';
     string50 CMPYADDR := '';
     string30 CMPYCITY := '';
     string2 CMPYSTATE := '';
     string9 CMPYZIP := '';
     string1 CMPYTYPE := '';
     string9 FEIN := '';
     string10 CMPYPHONE1 := '';
     string10 CMPYPHONE2 := '';
     string10 CMPYPHONE3 := '';
     string50 WEBSITE := '';
     string15 FIRST := '';
     string20 LAST := '';
     string15 AUTHREPTITLE := '';
     string50 ADDR := '';
     string30 CITY := '';
     string2 STATE := '';
     string9 ZIP := '';
     string9 SOCS := '';
     string8 DOB := '';
     string10 HPHONE := '';
     string10 WPHONE := '';
     string20 DRLC := '';
     string2 DRLCSTATE := '';
     string20 EMAIL := '';
	string6 historydateyyyymm := '';
end;

f := dataset('~mzhang::in::GE_Samp_BIID', pb1i_layout, csv(quote('"')));
//f := enth(dataset('~eschepers::in::GE_Samp_BIID', pb1i_layout, csv(quote('"'))),5);
//output(f);

roxieIP :='http://oroxievip.sc.seisint.com:9876';  //DR Roxie
// roxieIP := 'http://certstagingvip.hpcc.risk.regn.net:9876'; 

// populate the input values to business instant id with the original input values
riskprocessing.Layout_BIID_Soapcall into_bus_input(f le) := transform
	self.accountnumber := le.account; 
	self.companyname:= le.cmpy;
	self.alternatecompanyname := le.dbaname;
	self.addr := le.cmpyaddr;
	self.city := le.CMPYCITY;
	self.state := le.CMPYstate;
	self.zip := le.cmpyzip;
	self.taxidnumber		 := le.fein;
	self.businessphone    := le.cmpyphone1;
	self.representativefirstname := le.first;
	self.representativelastname  := le.last;
	self.representativeaddr := le.addr;
	self.representativecity := le.city;
	self.representativestate := le.state;
	self.representativezip := le.zip;
	self.representativessn := le.socs;
	self.representativedob := le.dob;
	self.representativehomephone := le.hphone;
	self.dppapurpose := 1;
	self.glbpurpose := 1;
	self.scores := dataset([{'Models.BusinessAdvisor_Service',roxieIP,[]}],models.Layout_Score_Chooser);
	self := [];
end;

batch_in := project(f,into_bus_input(LEFT));
output(batch_in, named('batch_in'));
 
 
s_f := riskprocessing.BIID_Soapcall(batch_in, roxieIP);
try_2 := JOIN(batch_in, s_f(errorcode<>''), LEFT.accountnumber=RIGHT.account, TRANSFORM(riskprocessing.Layout_BIID_Soapcall,SELF := LEFT));
s_f2 := riskprocessing.BIID_Soapcall(try_2, roxieIP);

s := s_f(errorcode='') + s_f2;

output(s(errorcode=''), named('biid_sample'));
output(s(errorcode!=''), named('errors'));

ox := RECORD
	business_risk.Layout_Final_Batch;	
	string1 lf;
END;

final := project(s, transform(ox,
													SELF.Acctno := ''; // only used by the batch folks
													self.fd_score1 := left.models[1].scores[1].i;
													self.fd_score2 := left.models[1].scores[2].i;
													self.fd_score3 := left.models[1].scores[3].i;
													self.fd_reason1 := left.models[1].scores[1].reason_codes[1].reason_code;
													self.fd_reason2 := left.models[1].scores[1].reason_codes[2].reason_code;
													self.fd_reason3 := left.models[1].scores[1].reason_codes[3].reason_code;
													self.fd_reason4 := left.models[1].scores[1].reason_codes[4].reason_code;
													self.fd_Desc1 := left.models[1].scores[1].reason_codes[1].reason_description;	
													self.fd_Desc2 := left.models[1].scores[1].reason_codes[2].reason_description;	
													self.fd_Desc3 := left.models[1].scores[1].reason_codes[3].reason_description;	
													self.fd_Desc4 := left.models[1].scores[1].reason_codes[4].reason_description;
													self.lf:='\n';
													self:=left));

output(final, named('final_sample'));
// output(final,, '~mzhang::out::biid_testing', overwrite);