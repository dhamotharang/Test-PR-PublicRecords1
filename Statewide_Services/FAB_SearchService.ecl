/*--SOAP--
<message name="FAB_SearchService" wuTimeout="300000">
	<part name="GLBPurpose"      type="xsd:byte" />
	<part name="DPPAPurpose"     type="xsd:byte" />
	<part name="ApplicationType"     	type="xsd:string"/>

	<part name="CompanyName"     type="xsd:string" />
  <part name="LastName"        type="xsd:string" />
	<part name="FirstName"       type="xsd:string" />
	<part name="MiddleName"      type="xsd:string" />
	<part name="PhoneticMatch"   type="xsd:boolean" />
	<part name="AllowNickNames"  type="xsd:boolean" />
	
	<part name="Addr"            type="xsd:string" />
	<part name="City"            type="xsd:string" />
	<part name="State"           type="xsd:string" />
	<part name="County"          type="xsd:string" />
	<part name="Zip"             type="xsd:unsignedInt" />
	<part name="ZipRadius"       type="xsd:unsignedInt" />
	<part name="phone"           type="xsd:string" />
	<part name="FEIN"            type="xsd:string" />

	<part name="ParcelID"						type="xsd:string"/>

	<part name="AdditionalTerms" type="xsd:string" />

	<part name="TwoPartySearch"          type="xsd:boolean"/>
	<part name="Entity2_DID" 								type="xsd:string"/>
	<part name="Entity2_BDID" 							type="xsd:string"/>
	<part name="Entity2_CompanyName" 				type="xsd:string"/>
	<part name="Entity2_SSN"								type="xsd:string"/>
	<part name="Entity2_FEIN"								type="xsd:string"/>
	<part name="Entity2_UnParsedFullName" 	type="xsd:string"/>
	<part name="Entity2_FirstName"   				type="xsd:string"/>
	<part name="Entity2_MiddleName"  				type="xsd:string"/>
	<part name="Entity2_LastName"    				type="xsd:string"/>
	<part name="Entity2_Addr"	       				type="xsd:string"/>
	<part name="Entity2_City"        				type="xsd:string"/>
	<part name="Entity2_State"       				type="xsd:string"/>
	<part name="Entity2_Zip"         				type="xsd:string"/>
	<part name="Entity2_County"             type="xsd:string"/>
	<part name="Entity2_AllowNickNames" 		type="xsd:boolean"/>
	<part name="Entity2_PhoneticMatch"  		type="xsd:boolean"/>
	<part name="Entity2_ZipRadius"  				type="xsd:unsignedInt"/>
	<part name="Entity2_phone"           		type="xsd:string" />
	
	<part name="Jurisdiction"    type="xsd:string"/>
	
  <part name="PenaltThreshold"      type="xsd:unsignedInt"/>
	<part name="IncludeAllDIDRecords" type="xsd:boolean"/>
	<part name="SelectIndividually" type="xsd:boolean"/>
  <part name="NewStyle" type="xsd:boolean"/>	
	<part name="IncludeUCC" type="xsd:boolean"/>
	<part name="IncludeProperty" type="xsd:boolean"/>
	<part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
	<part name="IncludeBankruptcy" type="xsd:boolean"/>
	<part name="IncludeLiens" type="xsd:boolean"/>
	<part name="IncludeWatercraft" type="xsd:boolean"/>
	<part name="IncludeVehicles" type="xsd:boolean"/>
	<part name="IncludeCorp" type="xsd:boolean"/>
	<part name="IncludeFBN" type="xsd:boolean"/>
	<part name="IncludeCalBus" type="xsd:boolean"/>
	<part name="IncludeTxBus" type="xsd:boolean"/>
	<part name="NoDeepDive"           type="xsd:boolean"/>
	<part name="LnBranded"					type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="MaxResults"           type="xsd:unsignedInt" />
  <part name="MaxResultsThisTime"   type="xsd:unsignedInt" />
  <part name="SkipRecords"          type="xsd:unsignedInt" />	
	<part name="StrictMatch"		type="xsd:boolean"/>
	
   // Enhancement/Bug: 64514
	<part name="MatchByBuyerAddresses"    type="xsd:boolean"/> 
  <part name="MatchByMailingAddresses"  type="xsd:boolean"/> 
  <part name="MatchByOwnerAddresses"    type="xsd:boolean"/> 
  <part name="MatchByPropertyAddresses" type="xsd:boolean"/> 
  <part name="MatchBySellerAddresses"   type="xsd:boolean"/> 

	<part name="PartyTypeBK" type="xsd:string"/>
</message>
*/
/*--INFO-- 
FAB StateWide Service. If the Jurisdiction is not specified, this service returns all results.
*/

IMPORT doxie, FAB_Statewide, FAP_Statewide;

EXPORT FAB_SearchService() := MACRO
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#OPTION ('optimizeProjects', FALSE);
	
	#STORED('PenaltThreshold', 10);
	#Stored('IsBdid',TRUE);
	doxie.MAC_Header_Field_Declare()
	
	BOOLEAN TwoPartySearch := FALSE : STORED('TwoPartySearch');
	
	STRING2 jurisdiction := '' : STORED('Jurisdiction');
	input_jurisdiction := StringLib.StringToUpperCase(jurisdiction);	
	
		
	out_set := MODULE(Statewide_Services.layout_FAB_FAP_out.output_set)END;
	boolean Inc_ALL := ~out_set.SelectIndividually;
  boolean Inc_Liens := Inc_ALL OR out_set.IncludeLiens = true;
	
	// 1. Run all of the required single source searches.	
	CorpData_recs   := FAB_Statewide.FAB_raw.Search.FAB_SearchCorpData();
	UCC_recs        := FAP_Statewide.FAP_raw.Search.FAP_SearchUCC();
	Property_recs   := FAP_Statewide.FAP_raw.Search.FAP_SearchProperty();
	ProfLic_recs    := FAP_Statewide.FAP_raw.Search.FAP_SearchProfLic();
	Bankruptcy_recs := FAP_Statewide.FAP_raw.Search.FAP_SearchBankruptcy();
	Liens_recs      := FAP_Statewide.FAP_raw.Search.FAP_SearchLiens(Inc_Liens);
	FBN_recs        := FAB_Statewide.FAB_raw.Search.FAB_SearchFBN(); 
	WaterCraft_recs := FAP_Statewide.FAP_raw.search.FAP_SearchWC();
	Vehicles_recs   := FAP_Statewide.FAP_raw.search.FAP_SearchVeh();	
	
	// 1a. Include CalBus and/or TxBus if Jurisdiction is 'CA' or 'TX' or no jurisdiction is specified. 
	CalBus_recs    := IF( (input_jurisdiction = '') OR (input_jurisdiction = 'CA'), FAB_Statewide.FAB_raw.Search.FAB_SearchCALBUS() );
	TxBus_recs     := IF( (input_jurisdiction = '') OR (input_jurisdiction = 'TX'), FAB_Statewide.FAB_raw.Search.FAB_SearchTXBUS() );	
	
	// 2. Filter on jurisdiction.
	CorpData_filtered     := CorpData_recs( (input_jurisdiction = '') OR (Jurisdiction = input_jurisdiction) );
	UCC_filtered          := UCC_recs( (input_jurisdiction = '') OR (Jurisdiction = input_jurisdiction) );
	Property_filtered     := Property_recs( (input_jurisdiction = '') OR (Jurisdiction = input_jurisdiction) );
	ProfLic_filtered      := ProfLic_recs( (input_jurisdiction = '') OR (Jurisdiction = input_jurisdiction) );
	Bankruptcies_filtered := Bankruptcy_recs( (input_jurisdiction = '') OR (Jurisdiction = input_jurisdiction) );
	Liens_filtered        := Liens_recs( (input_jurisdiction = '') OR (Jurisdiction = input_jurisdiction) );
	FBN_filtered          := FBN_recs( (input_jurisdiction  = '') OR (Jurisdiction = input_jurisdiction) );
  Watercraft_filtered   := Watercraft_recs( (input_jurisdiction  = '') OR (Jurisdiction = input_jurisdiction) );
	Vehicles_filtered     := Vehicles_recs( (input_jurisdiction  = '') OR (Jurisdiction = input_jurisdiction) );
		
	// 3. Union each dataset after limiting each.
	combined_recs := 
		  if(Inc_ALL OR out_set.IncludeCorp, CHOOSEN(CorpData_filtered,     MaxResults_val))	
			
		+ if(Inc_ALL OR out_set.IncludeUCC,CHOOSEN(UCC_filtered,          MaxResults_val))
		+ if(Inc_ALL OR out_set.IncludeProperty,CHOOSEN(Property_filtered,     MaxResults_val))
		+ if((Inc_ALL OR out_set.IncludeProfessionalLicenses) AND NOT TwoPartySearch,CHOOSEN(ProfLic_filtered,      MaxResults_val))
		+ if(Inc_ALL OR out_set.IncludeBankruptcy,CHOOSEN(Bankruptcies_filtered, MaxResults_val))
		+ if(Inc_Liens,CHOOSEN(Liens_filtered, MaxResults_val))
		+ if(Inc_ALL OR out_set.IncludeFBN,CHOOSEN(FBN_filtered,          MaxResults_val))
		+ if((Inc_ALL OR out_set.IncludeCalBus) AND NOT TwoPartySearch,CHOOSEN(CalBus_recs,           MaxResults_val))
		+ if((Inc_ALL OR out_set.IncludeTxBus) AND NOT TwoPartySearch,CHOOSEN(TxBus_recs,            MaxResults_val))
 		+ if(out_set.NewStyle and Inc_ALL OR out_set.IncludeWatercraft,CHOOSEN(Watercraft_filtered,   MaxResults_val))
		+ if(out_set.NewStyle and Inc_ALL OR out_set.IncludeVehicles,CHOOSEN(Vehicles_filtered,     MaxResults_val))
		;

	unsigned2 pt	:= AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
	
	// 4. Sort on penalty. We want only the highest quality for that Total Customer Experience.
	sorted_recs := SORT(combined_recs(penalt <= pt or isDeepDive), penalt, source_doc_type);
	
	// 5. Then, transform into a more-or-less standard output layout.
	transformed_recs := PROJECT(sorted_recs, Statewide_Services.layout_FAB_FAP_out.xfm_OutLayout_FAB(LEFT));

	// 6. Finally, limit the final set to 2000 and output.
	doxie.MAC_Marshall_Results(transformed_recs, marshalled_recs);
	
	// output(pt, named('pt_fabSearchService'));

	OUTPUT(marshalled_recs, NAMED('Results'), ALL);
	
ENDMACRO;
//FAB_SearchService()