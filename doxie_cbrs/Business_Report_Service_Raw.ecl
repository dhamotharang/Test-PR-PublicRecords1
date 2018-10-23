/*--SOAP--
<message name="BusinessReportServiceRaw" wuTimeout="300000">

	<part name="BDID" type="xsd:string" required="1"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
  <part name="DataRestrictionMask" type="xsd:string"/>

	<part name="UccVersion" type="xsd:byte"/>
	<part name="JudgmentLienVersion" type="xsd:byte"/>
	<part name="BankruptcyVersion" type="xsd:byte"/>
	<part name="VehicleVersion" type="xsd:byte"/>
	<part name="PropertyVersion" type="xsd:byte"/>
	
	<part name="SelectIndividually" type="xsd:boolean"/>
	<part name="IncludeNameVariations" type="xsd:boolean"/>
	<part name="SourceIdName" type="xsd:string"/>
	<part name="IncludeAddressVariations" type="xsd:boolean"/>
	<part name="SourceIdAddr" type="xsd:string"/>
	<part name="IncludePhoneVariations" type="xsd:boolean"/>
	<part name="SourceIdPhone" type="xsd:string"/>
	<part name="IncludeDCA" type="xsd:boolean"/>
	<part name="IncludeSales" type="xsd:boolean"/>
	<part name="IncludeIndustryInformation" type="xsd:boolean"/>
	<part name="IncludeLiensJudgments" type="xsd:boolean"/> 
	<part name="IncludeLiensJudgmentsUCC" type="xsd:boolean"/> 
	<part name="IncludeLiensJudgmentsV2" type="xsd:boolean"/> 
	<part name="IncludeLiensJudgmentsUCCV2" type="xsd:boolean"/> 
	<part name="IncludeAssociatedPeople" type="xsd:boolean"/>
	<part name="IncludeInternetDomains" type="xsd:boolean"/>
	<part name="IncludeBankruptcies" type="xsd:boolean"/>
	<part name="IncludeBankruptciesV2" type="xsd:boolean"/>
	<part name="IncludeBusinessRegistrations" type="xsd:boolean"/>
	<part name="IncludeProperties" type="xsd:boolean"/>
	<part name="IncludePropertiesV2" type="xsd:boolean"/>
	<part name="IncludeMotorVehicles" type="xsd:boolean"/>
	<part name="IncludeMotorVehiclesV2" type="xsd:boolean"/>
	<part name="IncludeWatercrafts" type="xsd:boolean"/>
	<part name="IncludeAircrafts" type="xsd:boolean"/>
	<part name="IncludeExperianBusinessReports" type="xsd:boolean"/>
	<part name="IncludeIRS5500" type="xsd:boolean"/>
	<part name="IncludeIRSNonP" type="xsd:boolean"/>
	<part name="IncludeFDIC" type="xsd:boolean"/>
	<part name="IncludeBBBMember" type="xsd:boolean"/>
	<part name="IncludeBBBNonMember" type="xsd:boolean"/>
	<part name="IncludeCASalesTax" type="xsd:boolean"/>
	<part name="IncludeIASalesTax" type="xsd:boolean"/>
	<part name="IncludeMSWorkComp" type="xsd:boolean"/>
	<part name="IncludeORWorkComp" type="xsd:boolean"/>
	<part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
	<part name="IncludeCompanyIDnumbers" type="xsd:boolean"/>
	<part name="IncludeCompanyIDnumbersV2" type="xsd:boolean"/>
	<part name="SourceIdFein" type="xsd:string"/>
	<part name="IncludeCompanyProfile" type="xsd:boolean"/>
	<part name="IncludeCompanyProfileV2" type="xsd:boolean"/>
	<part name="IncludeRegisteredAgents" type="xsd:boolean"/>
	<part name="IncludeExecutives" type="xsd:boolean"/>
	<part name="IncludeSuperiorLiens" type="xsd:boolean"/>
	<part name="IncludeBusinessAssociates" type="xsd:boolean"/>
	<part name="Include_Bus_DPPA" type="xsd:boolean"/>
	
	<part name="MaxSupergroup" type="xsd:unsignedInt"/>
	<part name="MaxNameVariations" type="xsd:unsignedInt"/>
	<part name="MaxPhoneVariations" type="xsd:unsignedInt"/>
	<part name="MaxDCA" type="xsd:unsignedInt"/>
	<part name="MaxSales" type="xsd:unsignedInt"/>
	<part name="MaxIndustryInformation" type="xsd:unsignedInt"/>
	<part name="MaxLiensJudgments" type="xsd:unsignedInt"/>
	<part name="MaxAssociatedPeople" type="xsd:unsignedInt"/>
	<part name="MaxInternetDomains" type="xsd:unsignedInt"/>
	<part name="MaxBankruptcies" type="xsd:unsignedInt"/>
	<part name="MaxBusinessRegistrations" type="xsd:unsignedInt"/>	
	<part name="MaxProperties" type="xsd:unsignedInt"/>
	<part name="MaxMotorVehicles" type="xsd:unsignedInt"/>
	<part name="MaxWatercrafts" type="xsd:unsignedInt"/>
	<part name="MaxAircrafts" type="xsd:unsignedInt"/>
	<part name="MaxExperianBusinessReports" type="xsd:unsignedInt"/>
	<part name="MaxIRS5500" type="xsd:unsignedInt"/>
	<part name="MaxIRSNonP" type="xsd:unsignedInt"/>
	<part name="MaxFDIC" type="xsd:unsignedInt"/>
	<part name="MaxBBBMember" type="xsd:unsignedInt"/>
	<part name="MaxBBBNonMember" type="xsd:unsignedInt"/>
	<part name="MaxCASalesTax" type="xsd:unsignedInt"/>
	<part name="MaxIASalesTax" type="xsd:unsignedInt"/>
	<part name="MaxMSWorkComp" type="xsd:unsignedInt"/>
	<part name="MaxORWorkComp" type="xsd:unsignedInt"/>
	<part name="MaxProfessionalLicenses" type="xsd:unsignedInt"/>
	<part name="MaxExecutives" type="xsd:unsignedInt"/>
	<part name="MaxBusinessAssociates" type="xsd:unsignedInt"/>
  <part name="IncludeOccurrences" type="xsd:boolean"/>
  <part name="ExcludeSources" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Dayton Smartlynx Business Report Replacement Sources.*/
IMPORT doxie_raw, Royalty, WSInput;

EXPORT Business_Report_Service_Raw := MACRO
		#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		//The following macro defines the field sequence on WsECL page of query. 
		WSInput.MAC_Business_Report_Service_Raw();

		#option ('globalAutoHoist', false);
		#option ('spotCSE', false);
		#stored('useSupergroup',true);
		#stored('isDayBR',true);
		#stored('IncludeMultipleSecured',true);
		#stored('ReturnRolledDebtors',true);

		// inclusion/exclusion
		Include_Occurrences := false : stored('IncludeOccurrences');
		Exclude_Sources	    := false : stored('ExcludeSources');
		Include_Sources		  := not Exclude_Sources;

		ssn_mask_val := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.ssn_mask_val.params));

		// =-=-=-=-=-=-=-=-=-=-=-= SourceInfo ByBDID =-=-=-=-=-=-=-=-=-=-=-=
		base_records_source := doxie_cbrs.all_base_records_source(doxie_cbrs.ds_subject_BDIDs, ssn_mask_val) : INDEPENDENT;
		// =-=-=-=-=-=-=-=-=-=-=-= RoyaltySet =-=-=-=-=-=-=-=-=-=-=-=
		doxie_crs.layout_property_ln property_child(doxie_cbrs.layout_property_records l):= transform
			self := l;
		END;

		property_table := normalize(base_records_source, left.property, property_child(right));

		Royalty.RoyaltyFares.MAC_SetB(property_table, royalties)

		// Below added for the Source Documents Additional Information project
		// (i.e. output a new "Occurrences" dataset when requested).
		// These changes were modeled after what was done in doxie.HeaderSource_Service

		// =-=-=-=-=-=-=-=-=-=-=-= Occurrences =-=-=-=-=-=-=-=-=-=-=-=
		ds_occur := if(Include_Occurrences,doxie_raw.Occurrence.fromBRSR(project(base_records_source,doxie_cbrs.layout_source)));


		// =-=-=-=-=-=-=-=-=-=-=-=-= Outputs =-=-=-=-=-=-=-=-=-=-=-=-=
		if(doxie_cbrs.subject_BDID > 0 or exists(doxie_cbrs.ds_subject_BDIDs), 
			 sequential(
				 if(Include_Sources,			output(base_records_source, named('ByBDID'))),
				 if(Include_Sources,			output(royalties,			      named('RoyaltySet'))),
				 if(Include_Occurrences,	output(ds_occur,			      named('Occurrences')))
			 ), 
			 output('No BDID Provided.'));

ENDMACRO;
