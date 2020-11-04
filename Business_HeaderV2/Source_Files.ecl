/*2012-05-04T20:47:13Z (vern_p bentley)

*/
IMPORT  
	 acf
	,amidir
	,atf
	,bankrupt
	,bankruptcyv2
	,Bankruptcy_Attorney_Trustee
	,bbb2
	,busdata
	,business_header
	,calbus
	,corp2
	,dea
	,dnb_feinv2
	,domains
	,ebr
	,edgar
	,faa
	,fbnv2
	,fcc
	,gong_neustar  //gong_v2
	,govdata
	,header
	,infousa
	,irs5500
	,liensv2
	,liquor_licenses
	,LN_Mortgage
	,ln_propertyv2
	,lobbyists
	,martindale_hubbell
	,oshair
	,onekey
	,phonesplus
	,prof_license
	,sda_sdaa
	,txbus
	,uccv2
	,ut
	,versioncontrol
	,vickers
	,watercraft
	,wither_and_die
	,yellowpages
	,zoom
	;

export Source_Files :=
module

	shared amidir_layout		:= recordof(AMIDIR.File_AMIDIR_DID_SSN_BDID_BIP);
	shared bkmain_layout		:= bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing;
	shared bksearch_layout	:= BankruptcyV2.layout_bankruptcy_search;
	shared bk_attorney_layout	:= Bankruptcy_Attorney_Trustee.Layouts.layout_attorneys_out;	
	
	shared propSearch_layout 					:= ln_propertyv2.Layout_DID_Out													;										
	shared propDeed_layout 						:= LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs ; 
	shared propAssessment_layout			:= LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs;
	shared propaddl_fares_deed_layout := ln_propertyv2.layout_addl_fares_deed									;
	shared propaddl_Fares_tax_layout	:= ln_propertyv2.layout_addl_fares_tax									;
	
	shared aircraft_layout		:= recordof(faa.file_aircraft_registration_out);
	shared bus_cont_layout		:= SDA_SDAA.Layouts.base;
	//shared watercraft_layout	:= Watercraft.Layout_Watercraft_Search_Base;
	shared watercraft_layout	:= Watercraft.Layout_Scrubs.Search_Base;
	
	
	VersionControl.macBuildFileVersions(Source_Filenames.propSearch									,propSearch_layout 										,propSearch									);
	VersionControl.macBuildFileVersions(Source_Filenames.propDeed										,propDeed_layout 											,propDeed										);
	VersionControl.macBuildFileVersions(Source_Filenames.propAssessment							,propAssessment_layout								,propAssessment							);
	VersionControl.macBuildFileVersions(Source_Filenames.propaddl_fares_deed				,propaddl_fares_deed_layout 					,propaddl_fares_deed				);
	VersionControl.macBuildFileVersions(Source_Filenames.propaddl_Fares_tax					,propaddl_Fares_tax_layout						,propaddl_Fares_tax					);
                                                                                                                     
	VersionControl.macBuildFileVersions(Source_Filenames.abius											,InfoUSA.Layout_ABIUS_Company_Base_AID,abius											);
	VersionControl.macBuildFileVersions(Source_Filenames.acf												,acf.Layout_Base											,acf												);
	VersionControl.macBuildFileVersions(Source_Filenames.amidir											,amidir_layout												,amidir											);
	VersionControl.macBuildFileVersions(Source_Filenames.atf												,atf.layout_firearms_explosives_out_Bip		,atf										);
	VersionControl.macBuildFileVersions(Source_Filenames.bankruptcy_main 						,bkmain_layout												,bankruptcy_main 						);
	VersionControl.macBuildFileVersions(Source_Filenames.bankruptcy_search					,bksearch_layout											,bankruptcy_search					);
	VersionControl.macBuildFileVersions(Source_Filenames.bankruptcy_Attorney 				,bk_attorney_layout										,bankruptcy_Attorney 				);
	VersionControl.macBuildFileVersions(Source_Filenames.Calbus											,Calbus.Layouts_Calbus.Layout_Base		,Calbus											);
	VersionControl.macBuildFileVersions(Source_Filenames.dea 												,dea.layout_dea_out_baseV2						,dea 												);
	VersionControl.macBuildFileVersions(Source_Filenames.dnb_feinV2									,DNB_FEINV2.layout_DNB_fein_base_main_new	,dnb_feinv2							);
	VersionControl.macBuildFileVersions(Source_Filenames.ebr_demo_base							,ebr.Layout_5610_Demographic_Data_Base,ebr_demo_base							);
	VersionControl.macBuildFileVersions(Source_Filenames.ebr_header_base 						,ebr.Layout_0010_Header_Base					,ebr_header_base 						);
	VersionControl.macBuildFileVersions(Source_Filenames.edgar_company							,edgar.Layout_Edgar_Company_BIP				,edgar_company							);
	VersionControl.macBuildFileVersions(Source_Filenames.edgar_contacts							,edgar.Layout_Edgar_Contact_Base			,edgar_contacts							);
	VersionControl.macBuildFileVersions(Source_Filenames.faa_aircraft 							,aircraft_layout											,faa_aircraft 							);
	VersionControl.macBuildFileVersions(Source_Filenames.fbnv2_Business							,FbnV2.Layout_Common.Business_AID			,fbnv2_Business							);
	VersionControl.macBuildFileVersions(Source_Filenames.fbnv2_Contact							,FbnV2.Layout_Common.contact_AID			,fbnv2_Contact							);
	VersionControl.macBuildFileVersions(Source_Filenames.fcc_base										,fcc.Layout_FCC_base_bip_AID					,fcc_base										);
	VersionControl.macBuildFileVersions(Source_Filenames.fdic												,govdata.layouts_fdic.base_aid				,fdic												);
	VersionControl.macBuildFileVersions(Source_Filenames.fl_fbn											,govdata.Layout_FL_FBN_In							,fl_fbn											);
	VersionControl.macBuildFileVersions(Source_Filenames.fl_fbn_events 							,govdata.Layout_FL_FBN_Events_In			,fl_fbn_events 							);
	VersionControl.macBuildFileVersions(Source_Filenames.gong_neustar								,Gong_neustar.Layout_History					,gong_neustar 							);
	VersionControl.macBuildFileVersions(Source_Filenames.gov_phones 								,govdata.Layout_Gov_Phones_Base				,gov_phones 								);
	VersionControl.macBuildFileVersions(Source_Filenames.header			 								,header.Layout_Header_v2							,header			 								);
	VersionControl.macBuildFileVersions(Source_Filenames.ia_sales_tax 							,govdata.Layout_IA_SalesTax_Base			,ia_sales_tax 							);
	VersionControl.macBuildFileVersions(Source_Filenames.infousa_deadco							,InfoUSA.Layout_Deadco_Base_AID				,infousa_deadco							);
	VersionControl.macBuildFileVersions(Source_Filenames.infousa_idexec 						,infousa.Layout_IDEXEC_Base						,infousa_idexec 						);
	VersionControl.macBuildFileVersions(Source_Filenames.irs5500										,irs5500.Layout_IRS5500_AID						,irs5500										);
	VersionControl.macBuildFileVersions(Source_Filenames.irs_non_profit 						,govdata.Layouts_IRS_NonProfit.Base_AID			,irs_non_profit 						);
	VersionControl.macBuildFileVersions(Source_Filenames.liens_party_CA							,LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags				,liens_party_CA							);
	VersionControl.macBuildFileVersions(Source_Filenames.liens_party_chicago_law		,LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags				,liens_party_chicago_law		);
	VersionControl.macBuildFileVersions(Source_Filenames.liens_party_Hogan 					,LiensV2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags				,liens_party_Hogan 					);
	VersionControl.macBuildFileVersions(Source_Filenames.liens_party_ILFDLN					,LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags				,liens_party_ILFDLN					);
	VersionControl.macBuildFileVersions(Source_Filenames.liens_party_NYC						,LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags				,liens_party_NYC						);
	VersionControl.macBuildFileVersions(Source_Filenames.liens_party_NYFDLN 				,LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags				,liens_party_NYFDLN 				);
	VersionControl.macBuildFileVersions(Source_Filenames.liens_party_SA							,LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags				,liens_party_SA							);
	VersionControl.macBuildFileVersions(Source_Filenames.liens_party_Superior				,LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags				,liens_party_Superior				);
	VersionControl.macBuildFileVersions(Source_Filenames.ms_workers_comp 						,govdata.Layout_MS_Workers_Comp_base	,ms_workers_comp 						);
	VersionControl.macBuildFileVersions(Source_Filenames.or_workers									,govdata.Layout_OR_Workers_Comp_Base	,or_workers									);
	VersionControl.macBuildFileVersions(Source_Filenames.oshair											,OSHAIR.layout_OSHAIR_inspection_clean_bip,oshair											);
	VersionControl.macBuildFileVersions(Source_Filenames.phonesplus									,Phonesplus.layoutCommonOut						,Phonesplus									);
	VersionControl.macBuildFileVersions(Source_Filenames.professional_licenses			,prof_license.layout_prolic_out_with_AID	,professional_licenses			);
	VersionControl.macBuildFileVersions(Source_Filenames.sda												,bus_cont_layout											,sda												);
	VersionControl.macBuildFileVersions(Source_Filenames.sdaa												,bus_cont_layout											,sdaa												);
	VersionControl.macBuildFileVersions(Source_Filenames.SEC 												,govdata.Layout_SEC_Broker_Dealer_In	,SEC 												);
	VersionControl.macBuildFileVersions(Source_Filenames.SEC2												,govdata.layout_sec_broker_dealer_BDID,SEC2												);
	//*** Modified code to replace ska with OneKey as per Jira# DF-26195
	//VersionControl.macBuildFileVersions(Source_Filenames.SKA_Nixie									,busdata.layout_ska_nixie_bdid				,SKA_Nixie									);
	//VersionControl.macBuildFileVersions(Source_Filenames.ska_verified								,busdata.layout_ska_verified_bdid			,ska_verified								);
	VersionControl.macBuildFileVersions(Source_Filenames.txbus											,TXBUS.Layouts_Txbus.Layout_Base			,txbus											);
	VersionControl.macBuildFileVersions(Source_Filenames.ucc_party 									,uccv2.Layout_UCC_Common.Layout_Party_with_AID	,ucc_party 									);
	VersionControl.macBuildFileVersions(Source_Filenames.vickers_13d13g							,vickers.layout_13d13g_base						,vickers_13d13g							);
	VersionControl.macBuildFileVersions(Source_Filenames.vickers_13d13g_in					,vickers.Layout_13d13g_In							,vickers_13d13g_in					);
	VersionControl.macBuildFileVersions(Source_Filenames.vickers_insider_filing			,vickers.Layout_insider_filing_base		,vickers_insider_filing			);
	VersionControl.macBuildFileVersions(Source_Filenames.vickers_insider_filing_in	,vickers.Layout_Insider_Filing_In			,vickers_insider_filing_in	);
	VersionControl.macBuildFileVersions(Source_Filenames.vickers_insider_security_in,vickers.Layout_Insider_Security_In		,vickers_insider_security_in);
	VersionControl.macBuildFileVersions(Source_Filenames.whois 											,domains.Layout_Whois_Base_BIP				,whois 											);
	VersionControl.macBuildFileVersions(Source_Filenames.Watercraft 								,watercraft_layout										,Watercraft 								,,,,,true);
                                                                                           
end;                                                                 