/*--SOAP--
<message name="RightAddress">
  <part name="RightAddressSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- This service searches the header file (Autonomy-style fed-ex search).*/

export RightAddressService := MACRO
	
	#CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	#stored ('ScoreThreshold', UPS_Services.Constants.SCORE_THRESHOLD);
	#constant('AllowWildcard',true);
	#constant('isCP_V2',true);
	resp := UPS_Services.RightAddress().soap_response;
  output (resp, named(doxie.strResultsName));

ENDMACRO;

/*
<RightAddressSearchRequest>
	<row>
		<User>
			<ReferenceCode></ReferenceCode>
			<BillingCode></BillingCode>
			<QueryId></QueryId>
			<GLBPurpose>1</GLBPurpose>
			<DLPurpose>1</DLPurpose>
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
			<EntityType></EntityType>
			<Name>
				<First></First>
				<Middle></Middle>
				<Last></Last>
				<CompanyName></CompanyName>
			</Name>
			<LastNameOrCompany></LastNameOrCompany>
			<PowerSearch></PowerSearch>
			<Address>
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
			<Phone10></Phone10>
		</SearchBy>
		<Options>
			<DemoMode></DemoMode>
			<DemoModeEditDistance></DemoModeEditDistance>
			<ReturnCount>20</ReturnCount>
			<StartingRecord>1</StartingRecord>
			<MaxResults>100</MaxResults>
			<Penaltythreshold>50</Penaltythreshold>
			<UseNicknames>1</UseNicknames>
			<IncludeAlsoFound>0</IncludeAlsoFound>
			<UsePhonetics>1</UsePhonetics>
			<StrictMatch>0</StrictMatch>
			<ZipRadius></ZipRadius>
		</Options>
	</row>
</RightAddressSearchRequest>
*/