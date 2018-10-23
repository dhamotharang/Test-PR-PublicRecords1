/*--SOAP--
<message name="Identity Management Report" wuTimeout="300000">
	<part name="IdentityManagementReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
  <part name="DID" type="xsd:string"/>
  <part name="IncludePersonReport" type="xsd:boolean"/>
  <part name="IncludeDriversLicenses" type="xsd:boolean"/>
  <part name="IncludeMotorVehicles" type="xsd:boolean"/>
  <part name="IncludeHistoricalPhones" type="xsd:boolean"/>
  <part name="IncludeProperties" type="xsd:boolean"/>
  <part name="IncludeRelatives" type="xsd:boolean"/>
	<part name="IncludeNeighbors" type="xsd:boolean"/>
  <part name="IncludeAssociates" type="xsd:boolean"/>
  <part name="IncludeStudentRecords" type="xsd:boolean"/>
  <part name="IncludeWatercrafts" type="xsd:boolean"/>
  <part name="IncludeAircrafts" type="xsd:boolean"/>
  <part name="IncludePeopleAtWork" type="xsd:boolean"/>
  <part name="IncludeCorporateAffiliations" type="xsd:boolean"/>
  <part name="IncludeEmailAddresses" type="xsd:boolean"/>
  <part name="IncludeRealTimeVehicle" type="xsd:boolean"/>
  <part name="IncludeTransactionHistory" type="xsd:boolean"/>
  <part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
  <part name="IncludeInternetDomains" type="xsd:boolean"/>
  <part name="RelativeDepth" type="xsd:byte" indent="true" default="1"/>
	<part name="MaxNeighborhoods" type="xsd:unsignedInt" indent="true" default="0"/>
  <part name="NeighborsPerAddress" type="xsd:byte" indent="true" default="3"/>
	<part name="NeighborsPerNA" type="xsd:byte" indent="true" default="6"/>
	<part name="RealTimePermissibleUse" type="xsd:string"/>
  <part name="IncludeNonRegulatedVehicleSources" type="xsd:boolean"/>
  <part name="IncludeNonRegulatedWatercraftSources" type="xsd:boolean"/>
  <part name="SuppressCompromisedDLs" type="xsd:boolean"/>
</message>
*/
/*--INFO-- IDM (Identity Management) searches through nine services to create a set of questions.
<pre>
&lt;IdentityManagementReportRequest&gt;
 &lt;row&gt;
  &lt;User&gt;
   &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
   &lt;DLPurpose&gt;&lt;/DLPurpose&gt;
   &lt;SSNMask&gt;&lt;/SSNMask&gt;
   &lt;DOBMask&gt;&lt;/DOBMask&gt;
   &lt;DLMask&gt;&lt;/DLMask&gt;
   &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt;
   &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt;
   &lt;ApplicationType&gt;&lt;/ApplicationType&gt;
   &lt;SSNMaskingOn&gt;&lt;/SSNMaskingOn&gt;
   &lt;DLMaskingOn&gt;&lt;/DLMaskingOn&gt;
  &lt;/User&gt;
  &lt;Options&gt;
   &lt;IncludePersonReport&gt;&lt;/IncludePersonReport&gt;
   &lt;IncludeDriversLicenses&gt;&lt;/IncludeDriversLicenses&gt;
   &lt;IncludeMotorVehicles&gt;&lt;/IncludeMotorVehicles&gt;
   &lt;IncludeHistoricalPhones&gt;&lt;/IncludeHistoricalPhones&gt;
   &lt;IncludeProperties&gt;&lt;/IncludeProperties&gt;
   &lt;IncludeRelatives&gt;&lt;/IncludeRelatives&gt;
   &lt;IncludeNeighbors&gt;&lt;/IncludeNeighbors&gt;
   &lt;IncludeAssociates&gt;&lt;/IncludeAssociates&gt;
   &lt;IncludeStudentRecords&gt;&lt;/IncludeStudentRecords&gt;
   &lt;IncludeWatercrafts&gt;&lt;/IncludeWatercrafts&gt;
   &lt;IncludeAircrafts&gt;&lt;/IncludeAircrafts&gt;
   &lt;IncludePeopleAtWork&gt;&lt;/IncludePeopleAtWork&gt;
   &lt;IncludeCorporateAffiliations&gt;&lt;/IncludeCorporateAffiliations&gt;
   &lt;IncludeEmailAddresses&gt;&lt;/IncludeEmailAddresses&gt;
   &lt;IncludeTransactionHistory&gt;&lt;/IncludeTransactionHistory&gt;
   &lt;IncludeRealTimeVehicle&gt;&lt;/IncludeRealTimeVehicle&gt;
   &lt;IncludeNonRegulatedVehicleSources&gt;&lt;/IncludeRealTimeVehicle&gt;
   &lt;IncludeNonRegulatedWatercraftSources&gt;&lt;/IncludeRealTimeVehicle&gt;
   &lt;IncludeProfessionalLicenses&gt;&lt;/IncludeProfessionalLicenses&gt;
   &lt;IncludeInternetDomains&gt;&lt;/IncludeProfessionalLicenses&gt;
   &lt;RelativeDepth&gt;1&lt;/RelativeDepth&gt;
   &lt;MaxNeighborhoods&gt;0&lt;/MaxNeighborhoods&gt;
   &lt;NeighborsPerAddress&gt;3&lt;/NeighborsPerAddress&gt;
   &lt;NeighborsPerNA&gt;6&lt;/NeighborsPerNA&gt;
	 &lt;RealTimePermissibleUse&gt;&lt;/RealTimePermissibleUse&gt;
	 &lt;LinkingWeightThreshold&gt;&lt;/LinkingWeightThreshold&gt;
   &lt;ReturnCount&gt;0&lt;/ReturnCount&gt;
   &lt;StartingRecord&gt;0&lt;/StartingRecord&gt;
  &lt;/Options&gt;
  &lt;ReportBy&gt;
   &lt;UniqueId&gt;&lt;/UniqueId&gt;
  &lt;/ReportBy&gt;
 &lt;/row&gt;
&lt;/IdentityManagementReportRequest&gt;
</pre>
*/


export ReportService := macro
import AutoStandardI, AutoHeaderI, iesp, doxie, PersonReports, suppress, IdentityManagement_Services, Relationship;
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		//All constants should be at start of service: Property constanats, Neighbors Constants
		#CONSTANT('IncludeDetails', true);
		#CONSTANT('DisplayMatchedParty', true);
		#CONSTANT('NeighborRecency' , 3);
		#CONSTANT('NeighborsProximityRadius' , 10);
		#CONSTANT('IncludeNonDMVSources', TRUE);
		// #CONSTANT('IncludeNonRegulatedVehicleSources', TRUE);
		#STORED('MaxRelativeAddresses', IdentityManagement_Services.Constants.MaxRelativeAddresses);
		//To show both vendor A and B DataRestrictionMask needs to be '0000000000' (first digit needs to be '0')
		// #STORED('DataRestrictionMask', '0000000000');

		//We need to set IncludeInsuranceDrivers to false as a stored constant since we do not need to retrieve the Insurance Drivers records from DriversV2.
		//In DriversV2 we have to retrieve the Insurance Drivers by DL which did not make sense here as we want to retrieve records by DID and not be forced to retrieve records we do not want.
		//For example we might want to only retrieve Insurance Drivers without other sources from DriversV2, but this would not be possible using DriversV2 code.
		#CONSTANT('IncludeInsuranceDrivers', FALSE);

		//Include options
		GetInputOptions (iesp.identitymanagementreport.t_IdentityManagementReportOption tag) := function
			options := module
				export boolean include_personreport						:= tag.IncludePersonReport     			: STORED('IncludePersonReport');
				export boolean include_driverslicenses  			:= tag.IncludeDriversLicenses  			: STORED('IncludeDriversLicenses');
				export boolean include_motorvehicles    			:= tag.IncludeMotorVehicles    			: STORED('IncludeMotorVehicles');
				export boolean include_histphones	      			:= tag.IncludeHistoricalPhones 			: STORED('IncludeHistoricalPhones');
				export boolean include_properties							:= tag.IncludeProperties       			: STORED('IncludeProperties');
				export boolean include_relatives							:= tag.IncludeRelatives;						//DEFAULT : FALSE
				export boolean include_neighbors							:= tag.IncludeNeighbors;						//DEFAULT : FALSE
				export boolean include_associates							:= tag.IncludeAssociates;						//DEFAULT : FALSE
				export boolean include_studentrecords					:= tag.IncludeStudentRecords   			: STORED('IncludeStudentRecords');
				export boolean include_watercrafts						:= tag.IncludeWatercrafts      			: STORED('IncludeWatercrafts');
				export boolean include_aircrafts        			:= tag.IncludeAircrafts        			: STORED('IncludeAircrafts');
				export boolean include_peopleatwork       		:= tag.IncludePeopleAtWork        	: STORED('IncludePeopleAtWork');
				export boolean include_corporateaffiliations  := tag.IncludeCorporateAffiliations : STORED('IncludeCorporateAffiliations');
				export boolean include_emailaddresses     		:= tag.IncludeEmailAddresses      	: STORED('IncludeEmailAddresses');
				export boolean include_transactionhistory 		:= tag.IncludeTransactionHistory  	: STORED('IncludeTransactionHistory');
				export boolean include_realtimevehicle    		:= tag.IncludeRealTimeVehicle				: STORED('IncludeRTVeh');
				export boolean include_noregulatedvehicles   	:= tag.IncludeNonRegulatedVehicleSources		: STORED('IncludeNonRegulatedVehicleSources');
				export boolean include_noregulatedwatercrafts := tag.IncludeNonRegulatedWatercraftSources	: STORED('IncludeNonRegulatedWatercraftSources');
				export boolean include_professionallicenses		:= tag.IncludeProfessionalLicenses	: STORED('IncludeProfessionalLicenses');
				export boolean include_InternetDomains		    := tag.IncludeInternetDomains				: STORED('IncludeInternetDomains');
				export boolean include_InsuranceDL				    := tag.IncludeInsuranceDrivers;               //DEFAULT	:	FALSE
				export unsigned1 relative_depth         			:= MIN(MAX(tag.RelativeDepth, 1), 3);					//DEFAULT : 1
			  	export unsigned1 neighborhoods 								:= IF(tag.MaxNeighborhoods > 0,MIN(tag.MaxNeighborhoods,5), 1);
				export unsigned1 neighbors_per_address 				:= MIN(MAX(tag.NeighborsPerAddress, 3), 20);	//DEFAULT : 3
				export unsigned1 neighbors_per_na 						:= MIN(MAX(tag.NeighborsPerNA, 6), 10);				//DEFAULT : 6
				export string RealTimePermissibleUse					:= tag.RealTimePermissibleUse;								//DEFAULT : ''
				export unsigned2 LinkingWeightThreshold				:= tag.LinkingWeightThreshold;								//DEFAULT : 0
				export boolean SuppressCompromisedDLs := tag.SuppressCompromisedDLs : STORED('SuppressCompromisedDLs');
			end;
			return options;
		end;

		// Only Stores user's input for esdl compatibility - Used by Mac header declare later in service.
		SetInputLocalOptions (IdentityManagement_services.IParam._report options_esdl) := FUNCTION
			// RNA storeds
			#STORED('includerelatives', options_esdl.include_relatives);
			#STORED('includeassociates', options_esdl.include_associates);
			#STORED('includeneighbors', options_esdl.include_neighbors);
			#STORED('relativedepth', options_esdl.relative_depth);
			#STORED('MaxNeighborhoods', options_esdl.neighborhoods);
			#STORED('NeighborsPerAddress', options_esdl.neighbors_per_address);
			#STORED('NeighborsPerNA', options_esdl.neighbors_per_na);
			#STORED('RealTimePermissibleUse', options_esdl.RealTimePermissibleUse);
			#STORED('xadl2_weight_threshold', options_esdl.LinkingWeightThreshold);
			RETURN iesp.ECL2ESP.EnforceRead ();
		end;

		rec_in := iesp.identitymanagementreport.t_IdentityManagementReportRequest;
		ds_in := DATASET ([], rec_in) : STORED ('IdentityManagementReportRequest', FEW);
		first_row := ds_in[1] : INDEPENDENT;

		//Search
		reportby := first_row.reportby;
		reportby_bps:=project(reportby,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[]));

		// this will #store some standard input parameters (generally, for search purpose)
		iesp.ECL2ESP.SetInputReportBy (reportby_bps);
		iesp.ECL2ESP.SetInputBaseRequest (first_row);

		// create module incorporating XML input options
		options_in := GetInputOptions (global (first_row.Options));

		// define parameters
		global_mod := AutoStandardI.GlobalModule();
		Relationship.IParams.storeHighConfidence(global_mod.ApplicationType);

		// set up default options
		AI := AutoStandardI.InterfaceTranslator;
		idm_mod := module (project (options_in, IdentityManagement_services.IParam._report, opt))
			// all required report's options (cleaned/translated)
			export unsigned1 GLBPurpose  := AI.glb_purpose.val (project(global_mod,AI.glb_purpose.params));
			export unsigned1 DPPAPurpose := AI.dppa_purpose.val (project(global_mod,AI.dppa_purpose.params));
			export string6 ssn_mask   := AI.ssn_mask_val.val (project(global_mod,AI.ssn_mask_val.params));
			export unsigned1 dob_mask := suppress.date_mask_math.MaskIndicator (AI.dob_mask_val.val (project(global_mod,AI.dob_mask_val.params)));
			export string DataRestrictionMask := global_mod.DataRestrictionMask;
			export STRING DataPermissionMask := global_mod.DataPermissionMask;
			// other parameters, if needed, are taken from globals by legacy code: ApplicationType, mask_dl, etc.
		end;

		SetInputLocalOptions(idm_mod);

		// only needed for search did
		search_mod := module (project (global_mod, PersonReports.input._didsearch, opt))
		end;

		//Only one DID is expected; otherwise fail:
		dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do (search_mod);
		// #stored ('DID', dids[1].did);

		recs := IdentityManagement_Services.Report(dids, idm_mod);

		 // wrap it into output structure
		iesp.identitymanagementreport.t_IdentityManagementReportResponse SetResponse (iesp.identitymanagementreport.t_IdentityManagementReportIndividual L) := transform
			Self._Header := iesp.ECL2ESP.GetHeaderRow ();
			Self.InputEcho := ReportBy;
			Self.Individual := L;
		end;

		results := PROJECT (recs, SetResponse (Left));

		// Royalties Count and Sources
		// This code will be tagged under unacceptable coding style.But this gets rid of project and normalize.
		Royalty.RoyaltyVehicles.MAC_ReportSet(recs.MotorVehicleRecords, royalties_rtv, datasource, vehicleinfo.vin);
		Royalty.MAC_RoyaltyEmail(recs.Emailaddresses, royalties_email, source);

		//Access to this data has to be authorized by FDN team and royalty tracking is required
	  royalties_insuraceDL := Royalty.RoyaltyFDNDLDATA.GetWebRoyalties(recs.InsuranceDriverLicenses,UniqueId,(Source <>'' and LicenseNumber <>'' and IssueState <>''), TRUE); //doesn't pay to search unless input DID has DL info populated

		royalties := if(idm_mod.include_emailaddresses , royalties_email) +
                 if(idm_mod.include_realtimevehicle, royalties_rtv) +
                 if(idm_mod.include_InsuranceDL,royalties_insuraceDL);


		IF (count (dids) > 1,
			fail (203, doxie.ErrorCodes (203)), // or ('ambiguous criteria')
			// comment the "fail" above and uncomment the "output" below for debugging
			// output (choosen(dids, 10), named('TOO_MANY_DIDS')),
			parallel(
			output (results, named ('Results')),
			output (royalties, named('RoyaltySet'))));

endmacro;

 // IdentityManagement_Services.ReportService();