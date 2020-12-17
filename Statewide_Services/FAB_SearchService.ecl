// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
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
