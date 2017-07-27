IMPORT Statewide_Services,doxie, AutoStandardI;

export FAPSearchService_ids(Statewide_Services.layout_FAB_FAP_out.output_set out_set) := MODULE
#stored('PenaltThreshold','10');

	shared STRING2 jurisdiction       := '' : STORED('Jurisdiction');
	shared STRING2 input_jurisdiction := StringLib.StringToUpperCase(jurisdiction);

		EXPORT search_result() :=  
		  FUNCTION
				voters_list             := FAP_raw.search.FAP_SearchVoters();
				UCC_list                := FAP_raw.search.FAP_SearchUCC();
				Property_list           := FAP_raw.search.FAP_SearchProperty();
				Hunting_Fishing_list    := FAP_raw.search.FAP_SearchHunting();
				ProfLic_list            := FAP_raw.search.FAP_SearchProfLic();
				Bankruptcy_List         := FAP_raw.search.FAP_SearchBankruptcy();
				Liens_List              := FAP_raw.search.FAP_SearchLiens();
				MD_List                 := FAP_raw.search.FAP_SearchMD();
				Death_List              := FAP_raw.search.FAP_SearchDeaths();
				DriversLicense_List     := FAP_raw.search.FAP_SearchDL();
				WaterCraft_List         := FAP_raw.search.FAP_SearchWC();
				Vehicles_List           := FAP_raw.search.FAP_SearchVeh();
				EQ_list                 := FAP_raw.search.FAP_SearchHeaderEQ();
				EN_list                 := FAP_raw.search.FAP_SearchHeaderEN();
				TN_list                 := FAP_raw.search.FAP_SearchHeaderTN();
				Crim_list               := FAP_raw.search.FAP_SearchCrim();
				Targus_List             := FAP_raw.search.FAP_SearchTargusWhitePages();
				
				boolean Inc_ALL := ~out_set.SelectIndividually;
				boolean IncludenewService := out_set.NewStyle and Inc_ALL;
				boolean is_twoPartySearchEnabled := AutoStandardI.GlobalModule().TwoPartySearch;
				
				FAP_recs :=
								if(~is_twoPartySearchEnabled and (Inc_ALL OR out_set.IncludeVoters),voters_list)
								+
								if(Inc_ALL OR out_set.IncludeUCC,ucc_list)
								+
								if(Inc_ALL OR out_set.IncludeProperty,Property_list)
			          +
								if(~is_twoPartySearchEnabled and (Inc_ALL OR out_set.IncludeHunting OR out_set.IncludeHFLicenses),Hunting_Fishing_list)
								+
								if(~is_twoPartySearchEnabled and (Inc_ALL OR out_set.IncludeProfessionalLicenses
								   OR out_set.IncludeSanctions OR out_set.IncludeProviders),ProfLic_list)
								+
								if(Inc_ALL OR out_set.IncludeBankruptcy,Bankruptcy_list)
								+ 
								if(Inc_ALL OR out_set.IncludeLiens,Liens_list)
								+
								if(Inc_ALL OR out_set.IncludeMarriageDivorce,MD_list)
								+ 
								if(~is_twoPartySearchEnabled and (Inc_ALL OR out_set.IncludeDeath),Death_list)
								+
								if(~is_twoPartySearchEnabled and (IncludeNewService OR out_set.IncludeDriverLicenses),DriversLicense_list)
								+
								if(IncludeNewService OR out_set.IncludeWatercraft,WaterCraft_list)
								+					
								if(IncludeNewService OR out_set.IncludeVehicles,Vehicles_List)
								+
								if(~is_twoPartySearchEnabled and (IncludeNewService OR out_set.IncludeEquifax OR out_set.IncludePersonLocator1),EQ_list)
								+
								if((~is_twoPartySearchEnabled and (IncludeNewService OR out_set.IncludePersonLocator5) and not doxie.DataRestriction.ECH)  ,EN_list)
								+
								if((~is_twoPartySearchEnabled and (IncludeNewService OR out_set.IncludePersonLocator6) and not doxie.DataRestriction.TCH)  ,TN_list)
								+
								if(~is_twoPartySearchEnabled and (IncludeNewService OR out_set.IncludeCriminalRecords),Crim_list)
								+
								if(~is_twoPartySearchEnabled and (Inc_ALL OR out_set.IncludeWhitePages or out_set.IncludeTargus),Targus_List)
								;

        recs := FAP_recs;								
			  final_recs    := if(input_jurisdiction<>''
						  		         ,recs( jurisdiction = input_jurisdiction )
									         ,recs);
			 trans_recs := PROJECT(final_recs,Statewide_Services.layout_FAB_FAP_out.xfm_OutLayout(LEFT));																										 
			 sorted_recs := SORT(trans_recs,penalt,source_doc_type,id);
			 RETURN sorted_recs;
			
	END;

END;