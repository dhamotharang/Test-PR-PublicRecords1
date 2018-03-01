/*--SOAP--
<message name="ProfileReportService" wuTimeout="300000">
	<part name="BDID" type="xsd:string" required="1"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="SSNMask" type="xsd:string"/> 
	<part name="ShowPersonalData" type="xsd:boolean"/>
	<part name="SelectIndividually" type="xsd:boolean"/>
	<part name="MaxSupergroup" type="xsd:unsignedInt"/>
	<part name="DisregardLimits" type="xsd:boolean"/>
	<part name="IncludeNameVariations" type="xsd:boolean"/>
	<part name="MaxNameVariations" type="xsd:unsignedInt"/>
	<part name="IncludeReversePhone" type="xsd:boolean"/>
	<part name="MaxReverseLookup" type="xsd:unsignedInt"/>
	<part name="IncludeYellowPages" type="xsd:boolean"/>
	<part name="MaxYellowPages" type="xsd:unsignedInt"/>
	<part name="IncludeBusinessesAtAddress" type="xsd:boolean"/>
	<part name="MaxBusinessesAtAddress" type="xsd:unsignedInt"/>
	<part name="IncludeAssociatedBusinesses" type="xsd:boolean"/>
	<part name="MaxAssociatedBusinesses" type="xsd:unsignedInt"/>
	<part name="IncludeCorporationFilings" type="xsd:boolean"/>
	<part name="MaxCorporationFilings" type="xsd:unsignedInt"/>
	<part name="IncludeUCCFilings" type="xsd:boolean"/>
	<part name="MaxUCCFilings" type="xsd:unsignedInt"/>
	<part name="IncludeLiens" type="xsd:boolean"/> 
	<part name="MaxLiens" type="xsd:unsignedInt"/>
	<part name="IncludeJudgments" type="xsd:boolean"/>
	<part name="MaxJudgments" type="xsd:unsignedInt"/>
	<part name="IncludeAssociatedPeople" type="xsd:boolean"/>
	<part name="MaxAssociatedPeople" type="xsd:unsignedInt"/>
	<part name="IncludeInternetDomains" type="xsd:boolean"/>
	<part name="MaxInternetDomains" type="xsd:unsignedInt"/>
	<part name="IncludeBankruptcies" type="xsd:boolean"/>
	<part name="MaxBankruptcies" type="xsd:unsignedInt"/>
	<part name="IncludeBusinessRegistrations" type="xsd:boolean"/>
	<part name="MaxBusinessRegistrations" type="xsd:unsignedInt"/>
	<part name="IncludeDunBradstreetRecords" type="xsd:boolean"/> 
	<part name="IncludeProperties" type="xsd:boolean"/>
	<part name="MaxProperties" type="xsd:unsignedInt"/>
	<part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
	<part name="MaxProfessionalLicenses" type="xsd:unsignedInt"/>
	<part name="IncludeCompanyIDnumbers" type="xsd:boolean"/>
	<part name="IncludeParentChild" type="xsd:boolean"/>
	<part name="IncludeHRI" type="xsd:boolean"/>
	<part name="IncludePatriotAct" type="xsd:boolean"/>
	<part name="MaxPatriotAct" type="xsd:unsignedInt"/>
	<part name="IncludeBBB" type="xsd:boolean"/>
	<part name="MaxBBB" type="xsd:unsignedInt"/>
	<part name="IncludeEBRHeader" type="xsd:boolean"/>
	<part name="MaxEBRHeader" type="xsd:unsignedInt"/>
	<part name="IncludeEBRSummary" type="xsd:boolean"/>
	<part name="MaxEBRSummary" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="UccVersion" type="xsd:byte"/>
	<part name="JudgmentLienVersion" type="xsd:byte"/>
</message>
*/

IMPORT Royalty, WSInput;

EXPORT Profile_Report_Service := MACRO

		//The following macro defines the field sequence on WsECL page of query. 
		WSInput.MAC_Profile_Report_Service();
		
		#option('spotThroughAggregate', 0);
		#constant('useSupergroup',true);
		#stored('useSupergroupPropertyAddress',false);
		#constant('AlwaysCompute',true);
		#constant('useLevels',true);
		appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

		all_recs_prs :=doxie_cbrs.all_records_prs(doxie_cbrs.ds_subject_BDIDs);

		doxie_crs.layout_property_ln property_child(doxie_cbrs.layout_profile_property l):= transform
		self := l;
		self :=[];
		END;

		property_table := normalize(all_recs_prs, left.property_children,property_child(right));
		property_total :=dedup(sort(property_table,ln_fares_id),ln_fares_id);
		Royalty.RoyaltyFares.MAC_SetB(property_total, property_royalties);

		dnb_table := NORMALIZE(all_recs_prs, left.dnb_children, TRANSFORM(right));
		dnb_royalties := Royalty.RoyaltyDNB.GetOnlineRoyalties(dnb_table);

		royalties := property_royalties + dnb_royalties;
		DO_ALL := sequential(output(all_recs_prs, named('PRS_Result')),output(royalties,named('RoyaltySet')));
		if(doxie_cbrs.subject_BDID > 0, DO_ALL, output('No BDID Provided.'));
ENDMACRO;