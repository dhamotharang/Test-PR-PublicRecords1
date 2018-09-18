
/*--SOAP--
<message name="PhoneMetaDataSearchService">
	<part name="phonemetadataservicerequest" type="tns:XmlDataSet" cols="80" rows="30"/> 
	<separator/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- This service hits the PhoneMetadata key by Phone number and returns info with regards to the 
						status of the phone number. 
						The search requires a phone.
*/
IMPORT iesp, Phones;
EXPORT PhoneMetaDataSearchService() := MACRO

 WSInput.MAC_PhoneMetaDataSearchService();

 // Get XML Input
 rec_in		:= iesp.phonemetadatasearch.t_PhoneMetaDataSearchRequest;
 ds_in			:= dataset([], rec_in) : STORED('PhoneMetaDataSearchServiceRequest', few);
 first_row	:= ds_in[1] : INDEPENDENT;

 iesp.ECL2ESP.SetInputBaseRequest(first_row);
 report_opt	 := global (first_row.Options);
 
 in_mod := Phones.IParam.PhoneAttributes.getReportParams(report_opt);

	Phones.Layouts.PhoneAttributes.BatchIn t_input(iesp.phonemetadatasearch.t_PhoneMetaDataSearchRequest l) := TRANSFORM
		self.acctno := '1';
		self.phoneno := l.SearchBy.PhoneNumber;
  self := [];
	END;

  ds_searchby := PROJECT(ds_in, t_input(LEFT));

  ds_out := Phones.PhoneMetaDataRecords(ds_searchby, in_mod);

  iesp.phonemetadatasearch.t_PhoneMetadataSearchResponse tFormat2IespResponse() :=	TRANSFORM
    SELF._Header   := iesp.ECL2ESP.GetHeaderRow();
    SELF.Records   := ds_out;
    SELF.InputEcho.PhoneNumber := ds_searchby[1].phoneno;
  END;
      		
  Results := DATASET([tFormat2IespResponse()]);

  // Royalties
  ds_RoyaltiesRealTime_ATT := Royalty.RoyaltyATT.GetOnlineRoyalties(ds_out, Source);		
  RoyaltySet := if(in_mod.use_realtime_lidb, ds_RoyaltiesRealTime_ATT);

  OUTPUT(Results, NAMED('Results'));
  OUTPUT(RoyaltySet, NAMED('Royalties'));

ENDMACRO;