IMPORT  
	 acf
	,advo
	,ak_busreg
	,amidir
	,atf
	,bankrupt
	,bankruptcyv2
	,Bankruptcy_Attorney_Trustee
	,bbb2
	,busdata
	,business_header
	,busreg
	,calbus
	,corp2
	,credit_unions
	,dcav2
	,dea
	,dnb_dmi
	,dnb_feinv2
	,domains
	,ebr
	,edgar
	,faa
	,fcc
	,fbnv2
	,gaming_licenses
	,gong_neustar    //gong_v2
	,govdata
	,header
	,infousa
	//,insurance_certification
	,irs5500
	//,jigsaw - Removed due to the contractual restrictions, as per Jason.
	//,laboractions_whd
	,liensv2
	,liquor_licenses
	,ln_propertyv2
	,lobbyists
	,martindale_hubbell
	// ,naturaldisaster_readiness
	,oshair
	,phonesplus
	,prof_license
	,redbooks
	,sda_sdaa
	,sheila_greco
	,spoke
	,txbus
	,uccv2
	,ut
	,UtilFile
	,versioncontrol
	,vickers
	,watercraft
	,wither_and_die
	//,workers_compensation
	,yellowpages
	,zoom
	;

export Source_Filenames :=
module
	
	shared prod := business_header.foreign_prod;
	
	shared wcluster				:= watercraft.cluster					[2..];
	shared acfcluster 		:= acf.Cluster.cluster_in			[2..];
	shared amidircluster	:= AMIDIR.Cluster							[2..];
	shared sdacluster			:= sda_sdaa.Cluster.cluster_in[2..];
	shared ucccluster			:= uccv2.cluster.cluster_out	[2..];

	shared ebr_demo					:= ebr.FileName_5610_Demographic_Data_Base		[2..];
	shared ebr_header				:= ebr.FileName_0010_Header_Base          		[2..];
	shared fnbv2cluster			:= fbnv2.Cluster.Cluster_In										[2..];
	shared calbuscluster		:= Calbus.Constants.cluster										[2..];
	shared txbuscluster			:= Txbus.Constants.cluster										[2..];
	//shared gongv2cluster		:= gong_v2.thor_cluster												[2..];
	
	export abius												:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::ABIUS_Company'       									     		);
	export acf													:= VersionControl.mBuildFilenameVersionsOld(prod + acfcluster+'Base::ACF'																							);
	export amidir												:= VersionControl.mBuildFilenameVersionsOld(prod + amidircluster + 'base::amidir'                  										);
	export atf													:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::atf_firearms_explosives'      								);
	export bankruptcy_main 							:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::bankruptcy::main'           									);
	export bankruptcy_search						:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::bankruptcy::search'         									);
	export bankruptcy_Attorney					:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::bat::attorneys'         											);
	export Calbus												:= VersionControl.mBuildFilenameVersionsOld(prod + calbuscluster + 'base::Calbus::basefile'            								);
	export dea 													:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::dea'                    											);
	export dnb_feinV2										:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::main::dnb_fein'            										);
	export ebr_demo_base								:= VersionControl.mBuildFilenameVersionsOld(prod + ebr_demo		          																							);
	export ebr_header_base 							:= VersionControl.mBuildFilenameVersionsOld(prod + ebr_header	          																							);
	export edgar_company								:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::edgar_company'             										);
	export edgar_contacts								:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::edgar_contacts'               								);
	export faa_aircraft 								:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::faa_aircraft_reg_built'       								);
	export fbnv2_Business								:= VersionControl.mBuildFilenameVersionsOld(prod + fnbv2cluster + 'Base::FBNv2::Business'						             			);	
	export fbnv2_Contact								:= VersionControl.mBuildFilenameVersionsOld(prod + fnbv2cluster + 'Base::FBNv2::Contact'							             		);	
	export fcc_base											:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::fcc'									      									);
	export fdic													:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_Data400::base::govdata_FDIC_BDID'													  );
	export fl_fbn												:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::in::fl::sprayed::fbn'																);
	export fl_fbn_events 								:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::in::fl::sprayed::fbn_events'												);
	export gong_neustar									:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::gong_history'              										);
	export gov_phones 									:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::gov_phones'                										);
	export header			 									:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::header'			               										);
	export ia_sales_tax 								:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::IA_Sales_Tax_AID'             								);
	export infousa_deadco								:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::infousa::deadco'              								);
	export infousa_idexec 							:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::infousa::idexec'           										);
	export irs5500											:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::irs5500'                											);
	export irs_non_profit 							:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::irs_nonprofit'             										);
	export liens_party_CA								:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::liens::party::CA_federal'     								);
	export liens_party_chicago_law			:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::liens::party::chicago_law'    								);
	export liens_party_Hogan 						:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::liens::party::Hogan'       										);
	export liens_party_ILFDLN						:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::liens::party::ILFDLN'         								);
	export liens_party_NYC							:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::liens::party::NYC'            								);
	export liens_party_NYFDLN 					:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::liens::party::NYFDLN'         								);
	export liens_party_SA								:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::liens::party::SA'          										);
	export liens_party_Superior					:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::liens::party::superior'     									);
	export ms_workers_comp 							:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::ms_workers_comp'           										);
	export or_workers										:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::or_workers_comp'           										);
	export oshair												:= VersionControl.mBuildFilenameVersionsOld(prod + OSHAIR.cluster[2..] + 'base::oshair::qa::inspection'			          );
	export phonesplus										:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::phonesplus'		             										);
	export professional_licenses				:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::prof_licenses_AID'             										);
	export propSearch										:= VersionControl.mBuildFilenameVersions(prod + 'thor_data400::base::ln_propertyv2::search'						);
	export propDeed											:= VersionControl.mBuildFilenameVersions(prod + 'thor_data400::base::ln_propertyv2::Deed'							);
	export propAssessment								:= VersionControl.mBuildFilenameVersions(prod + 'thor_data400::base::ln_propertyv2::Assesor'					);
	export propaddl_fares_deed					:= VersionControl.mBuildFilenameVersions(prod + 'thor_data400::base::ln_propertyv2::Addl::fares_deed'	);
	export propaddl_Fares_tax						:= VersionControl.mBuildFilenameVersions(prod + 'thor_data400::base::ln_propertyv2::Addl::fares_tax'	);
	export sda													:= VersionControl.mBuildFilenameVersionsOld(prod + sdacluster+'Base::SDA'          																		);
	export sdaa													:= VersionControl.mBuildFilenameVersionsOld(prod + sdacluster+'Base::SDAA'            																);
	export SEC 													:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::sec_bd_info'               										);
	export SEC2													:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::sec_broker_dealer'            								);
	export SKA_Nixie										:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::ska_nixie'                 										);
	export ska_verified									:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::ska_verified'              										);
	export txbus												:= VersionControl.mBuildFilenameVersionsOld(prod + txbuscluster + 'base::txbus::basefile'          										);
	export ucc_party 										:= VersionControl.mBuildFilenameVersionsOld(prod + ucccluster+'base::ucc::party_aid'        															);
	export vickers_13d13g								:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::vickers_13d13g_base'       										);
	export vickers_13d13g_in						:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::in::vickers::sprayed::13d13g'          							);
	export vickers_insider_filing				:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::vickers_insider_filing_base'  								);
	export vickers_insider_filing_in		:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::in::vickers::sprayed::insider_filing'								);
	export vickers_insider_security_in	:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::in::vickers::sprayed::insider_security'							);
	export Watercraft 									:= VersionControl.mBuildFilenameVersionsOld(prod + wcluster + 'base::watercraft_search'																);
	export whois 												:= VersionControl.mBuildFilenameVersionsOld(prod + 'thor_data400::base::whois'                     										);
                                                                         
/*                                                                      
	export Logical :=
			Vehicles.dall_filenames
		;
*/		  
	export New :=
			ak_busreg.Filenames().Base.dall_filenames
		+ Advo.Filenames().base.dall_filenames
		+ bbb2.Filenames().Base.Member.dall_filenames
		+ bbb2.Filenames().Base.NonMember.dall_filenames
		+ busreg.Filenames().Base.Companies.dall_filenames
		+ busreg.Filenames().Base.Contacts.dall_filenames
		+ Credit_Unions.Filenames().base.dAll_filenames
		+ dcav2.Filenames().dAll_filenames
		+ dnb_dmi.Filenames().dAll_filenames
		+ gaming_licenses.filenames().base.NJ.dall_filenames
		//+ Jigsaw.Filenames().dall_filenames    							// Removed due to the contractual restrictions, as per Jason.
		//+ insurance_certification.filenames().keybuild.dall_filenames
		//+ laboractions_whd.filenames().keybuild.dall_filenames
		+ liquor_licenses.filenames().base.CA.dall_filenames
		+ liquor_licenses.filenames().base.CT.dall_filenames
		+ liquor_licenses.filenames().base.IN.dall_filenames
		+ liquor_licenses.filenames().base.LA.dall_filenames
		+ liquor_licenses.filenames().base.OH.dall_filenames
		+ liquor_licenses.filenames().base.PA.dall_filenames
		+ liquor_licenses.filenames().base.TX.dall_filenames
		+ martindale_hubbell.filenames().base.organizations.dall_filenames
		+ martindale_hubbell.filenames().base.Affiliated_individuals.dall_filenames
		// + naturaldisaster_readiness.filenames().keybuild.dall_filenames
		+ Redbooks.filenames().base.combined.dall_filenames
		+ spoke.filenames().base.dall_filenames
		+ sheila_greco.filenames().base.dall_filenames
		+ UtilFile.Filenames().Base.dall_filenames
    // + workers_compensation.filenames().keybuild.dall_filenames		
		+ yellowpages.Filenames().Base.dall_filenames
		+ zoom.filenames().base.dall_filenames															
		;
	
	export NewProd := 
			corp2.Filenames().Base_xtnd.Cont.dall_filenames
		+ corp2.Filenames().Base_xtnd.Corp.dall_filenames
		;

	export OldProd :=
			Header.dall_filenames
		;

	export Old :=
			abius.dall_filenames
		+ acf.dall_filenames
		+ amidir.dall_filenames
		+ atf.dall_filenames
		+ bankruptcy_main.dall_filenames
		+ bankruptcy_search.dall_filenames
		+ bankruptcy_Attorney.dall_filenames
		+ Calbus.dall_filenames
		+ dea.dall_filenames
		+ dnb_feinv2.dall_filenames
		+ ebr_demo_base.dall_filenames
		+ ebr_header_base.dall_filenames
		+ edgar_company.dall_filenames
		+ edgar_contacts.dall_filenames
		+ faa_aircraft.dall_filenames
		+ fbnv2_Business.dall_filenames
		+ fbnv2_Contact.dall_filenames
		+ fcc_base.dall_filenames
		+ fdic.dall_filenames
		+ fl_fbn.dall_filenames
		+ fl_fbn_events.dall_filenames
		+ gong_neustar.dall_filenames
		+ gov_phones.dall_filenames
		+ ia_sales_tax.dall_filenames
		+ infousa_deadco.dall_filenames
		+ infousa_idexec.dall_filenames
		+ irs5500.dall_filenames
		+ irs_non_profit.dall_filenames
		+ liens_party_CA.dall_filenames
		+ liens_party_chicago_law.dall_filenames
		+ liens_party_Hogan.dall_filenames
		+ liens_party_ILFDLN.dall_filenames
		+ liens_party_NYC.dall_filenames
		+ liens_party_NYFDLN.dall_filenames
		+ liens_party_SA.dall_filenames
		+ liens_party_Superior.dall_filenames
		+ ms_workers_comp.dall_filenames
		+ or_workers.dall_filenames
		+ oshair.dall_filenames
		+ phonesplus.dall_filenames
		+ professional_licenses.dall_filenames
		+ propSearch.dall_filenames
		+ propDeed.dall_filenames
		+ propAssessment.dall_filenames
		+ propaddl_fares_deed.dall_filenames
		+ propaddl_Fares_tax.dall_filenames
		+ sda.dall_filenames
		+ sdaa.dall_filenames
		+ SEC.dall_filenames
		+ SEC2.dall_filenames
		+ SKA_Nixie.dall_filenames
		+ ska_verified.dall_filenames
		+ txbus.dall_filenames
		+ ucc_party.dall_filenames
		+ vickers_13d13g.dall_filenames
		+ vickers_13d13g_in.dall_filenames
		+ vickers_insider_filing.dall_filenames
		+ vickers_insider_filing_in.dall_filenames
		+ vickers_insider_security_in.dall_filenames
		+ Watercraft.dall_filenames
		+ whois.dall_filenames
		;
	
	export all :=
			New
//		+ Logical
		+ NewProd
		+ Old
		+ OldProd
		;

end;