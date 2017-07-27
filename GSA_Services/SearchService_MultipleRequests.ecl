/*--SOAP--
<message name="SearchService_MultipleRequests">
	<part name="BatchGSAVerificationRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns GSA Excluded Parties / Verifications Search records.*/

import iesp, AutoStandardI, doxie, ut, Autokey_batch;

export SearchService_MultipleRequests := macro
doxie.MAC_Header_Field_Declare()
		ds_in := DATASET ([], iesp.gsaverification.t_BatchGSAVerificationRequest) : STORED ('BatchGSAVerificationRequest', FEW);
		//output(ds_in,named('input'));
		
		first_row := ds_in[1] : independent;
		//output(first_row,named('firstRow'));
		
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
		#stored ('PenaltThreshold', first_row.options.PenaltyThreshold);	
		search_by := global (first_row.SearchBy);
		
		// fail on max input exceeded
		if(count(search_by)>GSA_Services.Constants.MAX_INPUT,fail(ut.constants_MessageCodes.MAX_INPUT_EXCEEDED,ut.MapMessageCodes(ut.constants_MessageCodes.MAX_INPUT_EXCEEDED)));
		
		shared inputData := project(search_by, GSA_Services.Functions.getInputItems(left, COUNTER));	
		
		batch_inputData := project(inputData,GSA_Services.Layouts.gsa_rec_inBatchMaster);
		
		//search and return results record structure
		ds_all_recs := sort(project(GSA_Services.BatchService_Records(batch_inputData).ds_outRecs,iesp.gsaverification.t_GSAVerificationRecord),searchid);
				
		//group by searchid 
		ds_searchid_group := group(ds_all_recs, searchid);
		
		iesp.gsaverification.t_BatchGSAResult xform_batchResult(recordof(iesp.gsaverification.t_GSAVerificationRecord) l, dataset(recordof(iesp.gsaverification.t_GSAVerificationRecord) ) r) := transform
							self.RecordCount := count(r);
							self.SearchId := l.searchId;
							self.Records := r;
			end;
		
		//transform GSA records into BatchResults format
		ds_batch_results := ROLLUP(ds_searchid_group, GROUP, xform_batchResult(LEFT, ROWS(LEFT)));
		
		ds_input_output := join(inputData,ds_batch_results,
										left.acctno = right.searchid,
										transform(iesp.gsaverification.t_BatchGSAResult, self.searchid := left.search_id,self := right),
										left outer);

		iesp.gsaverification.t_BatchGSAVerificationResponse final_xform():=transform
			self._Header := iesp.ECL2ESP.GetHeaderRow ();
			self.SearchResults:=ds_input_output;
		end;

		//transform BatchResults to GSABATchResponse
		results := dataset([final_xform()]);
		
		//display the final response.		
		output(results, named('Results'));

endmacro;
// SearchService_MultipleRequests ();

/*
<BatchGSAVerificationRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId>1</QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>

<SearchBy>
<Item>
 <SearchId>100</SearchId>
  <Name>
    <Full>smith john</Full>
    <First>john</First>
    <Middle></Middle>
    <Last>smith</Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
		<CompanyName></CompanyName>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
</Item>
<Item>
 <SearchId>2</SearchId>
  <Name>
    <Full>gerrad butler</Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
		<CompanyName></CompanyName>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
</Item>
<Item>
 <SearchId>3</SearchId>
  <Name>
    <Full>fraiser brandon</Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
		<CompanyName></CompanyName>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
</Item>

</SearchBy>
<Options>
  <StrictMatch></StrictMatch>
  <PenaltThreshold></PenaltThreshold>
</Options>
</row>
</BatchGSAVerificationRequest>
*/