import riskwise, Scoring;

pi_layout := record
string	ProPay_ID	;
string	First_Name	;
string	Initial	;
string	Last_Name	;
string	DOB	;
string	SSN	;
string	Address	;
string	Apt 	;
string	City	;
string	State	;
string	Zip	;
string	Daytime_Phone	;
string	Evening_Phone	;
string	application_date	;
string	Current_status	;
end;

//f := dataset('~thor_data50::in::propay', pi_layout, csv(heading(1)));
f := enth(dataset('~thor_data50::in::propay', pi_layout, csv(heading(1))),5);
output(f);

//mapping
Scoring.Layout_PRIO_Soapcall into_PRIO_input(f le) := transform
self.tribcode := 'pi05';
self.account  := le.ProPay_ID;
self.first    := le.First_Name;
self.middleini:= le.Initial;
self.last	  := le.Last_Name;
self.addr	  := le.address+' '+ le.apt;
self.hphone	  := le.Evening_Phone;
self.socs	  := le.SSN;
self.wphone	  := le.Daytime_Phone;
self.HistoryDate:=le.application_date[1..6];
self.run_Seed:=false ;
self.dppapurpose := 1;
self.glbpurpose := 1;
self := [];
self := le;
end;

soap_in := project(f,into_PRIO_input(LEFT));
output(soap_in);

roxieIP :='http://prdrroxiethorvip.hpcc.risk.regn.net:9876' ; // DR roxie


s_f := Scoring.PRIO_Soapcall(soap_in, roxieIP);
try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_PRIO_Soapcall,SELF := LEFT));
s_f2 := Scoring.PRIO_Soapcall(try_2, roxieIP);

s := s_f(errorcode='') + s_f2;

output(s(errorcode!=''), named('errors'));
output(s,,'~thor_data50::out::propay', overwrite);





//  ***********************************************************************************************
//  to-despray the file after it has been run on hthor, you need to run the following code to 
//  output that file with a cluster, use either the 50x or the 400x to run the code below.
//  ***********************************************************************************************

/*
ox := RECORD
	STRING errorcode;
	business_risk.Layout_Final_Batch;	
END;

d := dataset('~dvstemp::out::biid_testing', ox, flat);
f := project(d, transform(business_risk.Layout_Final_Batch, self:=left));

output(f,, '~thor_data50::out::biid_testing', overwrite);
*/