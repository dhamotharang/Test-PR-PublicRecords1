/*--SOAP--
<message name="Outlet_Report_Service">
	<part name="Gennum"            type="xsd:string"/>

	<!-- COMPLIANCE/USER SETTINGS -->
  <part name="DPPAPurpose"         type="xsd:byte"/>
  <part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>

	<!-- ADDITIONAL USER OPTIONS -->
  <part name="getOutletReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

 </message>
*/


IMPORT iesp, AutoStandardI, doxie;

export Outlet_Report_Service := 
MACRO

		//*** Get XML input
		rec_in := iesp.searchpoint.t_getOutletReportRequest;
		ds_in := DATASET ([], rec_in) : STORED ('getOutletReportRequest', FEW);
		first_row := ds_in[1] : independent;

		//*** Set some base options
		iesp.ECL2ESP.SetInputBaseRequest (first_row);

		//*** Store main search criteria:
		options				 := GLOBAL (first_row.Options);
		#stored ('Gennum', GLOBAL (first_row.Gennum));
		
		//*** Get system date for query date
    dateTime := ut.GetTimeDate();
    queryDate := dateTime[1..10] + 'T' + dateTime[11..12] + ':' + dateTime[13..14] + ':' + dateTime[15..16] + '.00' + dateTime[17..] +'Z';


		input_params := AutoStandardI.GlobalModule();
		
		tempmod := MODULE(PROJECT(input_params,SearchPoint_Services.Outlet_Report_Records.Iparams,opt));
				//*** Store product specific search option
				EXPORT STRING   Gennum		        := ''    : STORED( 'Gennum' );
				EXPORT STRING32 applicationType	 	:= AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		end;
		
		outlet_results := SearchPoint_Services.Outlet_Report_Records.resultRecs( tempmod );
		
		iesp.searchpoint.t_getOutletReportResponse xform() := transform
				tempCnt													:= count(outlet_results);
				self._Header 										:= iesp.ECL2ESP.GetHeaderRow();
				self.RecordCount 								:= tempCnt;
				self.return.Outlet							:= if (tempCnt > 0, outlet_results[1]);				
				self.return.ErrorCode    				:= '';
				self.return.ErrorMessage 				:= '';
				self.return.QueryDate    				:= queryDate;
		end;
		
		results := Choosen(DATASET([xform()]), iesp.ECL2ESP.Marshall.max_return, iesp.ECL2ESP.Marshall.starting_record);
		//output(Gennum, named('XML Gennum'));
		output(results, named('Results'));	
	
ENDMACRO;
/*
<getOutletReportRequest>
<row>
	<User>
		<ReferenceCode></ReferenceCode>
		<BillingCode></BillingCode>
		<QueryId></QueryId>
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
	<Options> </Options>
	<Gennum></Gennum>
</row>
</getOutletReportRequest>
*/
