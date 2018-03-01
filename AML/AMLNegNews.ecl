import iesp, Risk_Indicators, Fingerprint, ut, Gateway, std;

/*
This information is required on transactions...
gates := dataset([{'News','HTTP://xmlrsk_qa_gw_roxie:[PASSWORD_REDACTED]@gatewaycertesp.sc.seisint.com:7726/WsGateway'}], Risk_Indicators.Layout_Gateways_In);
#stored('_TransactionId', '111r000');
#stored('Gateways',gates);
*/

/* -- need to all be migrated...
	dependencies:
		iesp.gateway_news
		Gateway.Configuration
		Gateway.Constants
		Gateway.SoapCall_NewsSearch
		Gateway.SoapCall_NewsAuthenticate
		AML.AMLBusnNegNews
		AML.AMLIndvNegNews
		AML.AMLNegNews
*/

export AMLNegNews := MODULE

export newsCite := RECORD
	string doc_id 			:= XMLTEXT('head/docdata/doc-id@id-string');
	integer date_issue 	:= (integer)(XMLTEXT('head/docdata/date.issue@norm')[1..8]);
	string position			:= XMLTEXT('head/pubdata@position.section');
	string name					:= XMLTEXT('head/pubdata@name');
	string headline1 		:= XMLTEXT('body/body.head/hedline/hl1');
	string headline2 		:= XMLTEXT('body/body.head/hedline/hl2');
	string byline 			:= XMLTEXT('body/body.head/byline');
end;

export AMLNegNewsInput := RECORD
	UNSIGNED4 seq;
	unsigned3 historydate;
	string query;
END;

export AMLNegNewsOutput := RECORD
	integer seq;
	integer n_status;
	string 	n_transactionid;
	string 	n_searchid;
	integer n_doc_count;
	integer months24count;
	integer days90count;
	dataset(newsCite) 	n_documents;
end;

export AMLNegNewsRequest( DATASET(AMLNegNewsInput) iin, boolean enableNews) := FUNCTION
														
			gateway_cfg  := Gateway.Configuration.get()(Gateway.Configuration.IsNews(servicename) and enableNews)[1];	
			auth := Gateway.SoapCall_NewsAuthenticate(dataset([TRANSFORM(iesp.gateway_news.t_NewsAuthenticateRequest, self.user.BillingCode := 'AMLRISK', self.user.QueryID := 'auth', self:=[])]), gateway_cfg);

			securityToken := auth[1].response.SecurityToken;
			
			iesp.gateway_news.t_NewsSearchRequest into_inq(AMLNegNewsInput L, string securityToken) := transform
				dateConvert(string d) := d[1..4] + '-' + d[5..6] + '-' + d[7..8];	

				historydate := if( L.historydate >= 999999, (STRING)Std.Date.Today(), (string)(L.historydate) + '01');
				self.query := L.query;

				useDate := historyDate != (STRING)Std.Date.Today();
				sourceId := if( useDate, '8399', '140560'); // if we are running history use 8339 for source.
				self.SourceInfo.SourceIdList := dataset([{sourceId}],iesp.share.t_StringArrayItem);
				self.SearchOptions.DateRestriction.StartDate := if(useDate, dateConvert(ut.getDateOffset(-2*365,historydate)), '');
				self.SearchOptions.DateRestriction.EndDate := if(useDate, dateConvert(historyDate), '');
				
				self.user.referenceCode := '';
				self.user.BillingCode := '';
				self.user.queryId := (string)L.seq;
				self.SecurityToken := securityToken; 
				self.ProjectID := 'AMLRISK';
				self.SearchOptions.SearchMethod := 'Boolean';
				self.RetrievalOptions.documentMarkup := 'Semantic';
				self.RetrievalOptions.DocumentView := 'Cite';
				self.RetrievalOptions.DocumentRange.Begin := 1;
				self.RetrievalOptions.DocumentRange._End := 100;
				self := [];
			end;
																
		in_req := project(iin, into_inq(left, securityToken));																									

    // call the gateway individually for each item in the request							
		iesp.gateway_news.t_NewsSearchResponseEx runrequests(iesp.gateway_news.t_NewsSearchRequest iin, Gateway.Layouts.Config gtw) := TRANSFORM
			res := Gateway.SoapCall_NewsSearch( DATASET([iin], iesp.gateway_news.t_NewsSearchRequest) , gtw);
			self := res[1];
		END;

//		outfq := Gateway.SoapCall_NewsSearch( in_req, gateway_cfg);
		outfq := project( in_req, runrequests(left,gateway_cfg));
		
		AMLNegNewsOutput newsTransform(AMLNegNewsInput L, iesp.gateway_news.t_NewsSearchResponseEx R) := TRANSFORM
				
				historydate := if( L.historydate >= 999999, (STRING)Std.Date.Today(), (string)(L.historydate) + '01');
				
				self.seq := L.seq; //(integer)R.response._header.QueryId;
				self.n_status := R.response._header.status;
				self.n_transactionid := R.response._header.TransactionId;
				self.n_searchid := R.response.searchid;
				self.n_doc_count := R.response.DocsFound;
				
				documents := parse(R.response.DocContainerList, Fingerprint.Decode64(Document), newsCite, XML('nitf'));
				self.n_documents := documents;
				
				integer days90 := (integer)ut.getDateOffset(-90, historyDate);
				self.months24count := R.response.DocsFound; //count(documents); // query filters documents to 24 month range, so, it is just all of them.
				self.days90count := count(documents((integer)date_issue>= days90));
		end;		

	  res := join(iin, outfq, (string)left.seq=right.response._header.QueryId, newsTransform(left, right), left outer);
		return(res);												
END;

END;