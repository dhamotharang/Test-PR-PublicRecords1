import iesp, Risk_Indicators, Fingerprint, ut, Gateway;


export AMLBusnNegNews(GROUPED DATASET(AML.Layouts.AMLSlimBusnLayout) BusnIds, boolean enableNews) := FUNCTION
				
		AML.AMLNegNews.AMLNegNewsInput into_inq(AML.Layouts.AMLSlimBusnLayout L) := transform
			self.query := '#AMLRISK# and ' + L.company_name;
			self := L;
		end;
																
		iin := project(ungroup(BusnIds), into_inq(left));
																
		res := AML.AMLNegNews.AMLNegNewsRequest(iin, enableNews);
		
		newsAppend := join(BusnIds, res, left.seq=right.seq);

		return(newsAppend);												
END;

/*
EXAMPLE:


gates := dataset([{'News','http://khillqa:[PASSWORD_REDACTED]@espdev.br.seisint.com:5005/WsGateway'}], Risk_Indicators.Layout_Gateways_In);
#stored('_TransactionId', '111r000');
#stored('Gateways',gates);



// ----------------------------------------------------------
inputrecs := RECORD
	string fname;
	string lname;
	string company_name;
	integer seq;
	integer historyDate := 999999; //(integer)ut.GetDate;
end;

inputsq := dataset([ 
			{'William Ray','Johnson', 'somecompany','1'},
			{'Yaqub','Mirza', 'lexisnexis', '2'},
			{'Daniel','Cruz', 'enron', '3'},
//			{'Andrew','Grant', 'somecompany', '4'},
//			{'David','Garrison', 'somecompany', '5'},
//			{'Todd','Pea', 'somecompany', '6'},
//			{'Erivelton','Fernandes', 'somecompany', '7'},
//			{'Timothy','Potendyk', 'somecompany', '8'},
			{'Mohammad','Chehade', 'AIX', '9'}
			], inputrecs);
output(inputsq);			
//iin := project(inputsq, TRANSFORM(AML.Layouts.RelativeInLayout, self:=LEFT, self:=[]));
iin := project(inputsq, TRANSFORM(AML.Layouts.AMLSlimBusnLayout, self:=LEFT, self:=[]));
output(iin);
//res := AML.AMLIndvNegNews(group(iin,seq));
res := AML.AMLBusnNegNews(group(iin,seq));
output(res);
*/