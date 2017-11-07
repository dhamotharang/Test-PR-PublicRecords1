/* Status as of 10/20/2015, coding is DONE to count source docs for these sources: 
      12. Other Directories - ABIUS(aka UsaBiz from InfoUSA), ACF(American Corporate Finance), 
                              AMIDIR, AMS, BBB(mbr&nonmbr),
                              BusRegs, CNLD_Facilites, Cortera, Credit Unions, DEADCO(from InfoUSA), 
                              Diversity Cert, DnB_Fein, FBN, LaborActions_WHD,    
                              Martindale-Hubell, NCPDP, Redbooks, SDA, SDAA, Sheila Greco, 
                              SKA, Spoke & Utilities

TBD:
   1.  As of 10/20/15, still need to decide how to handle or add coding for these sources???:
       (these sources are not directly fetched in any other section of the report, but some
       are included on the BIPV2 bus hdr, Contacts or Industry linkids keys, 
       which in turn are used in various other report sections)
       Also see Tom Reed's BIP Source Files v8.xlsx (on BIP2.0 project sharepoint)
       v--- Category     - Key -v      - Sources ---v
       12. Other Dirs    - not any key - ABMS?(new in prod 02/11/2014. email sent to Tom Reed, 
                                               but he wanted to see a layout first and asked 
                                               Julie Ellison. Might need added to his xls?), 
                                         Bankruptcy Attorneys(& Trustees),
                                         CLIA, 
                                         Debt Settlement, 
                                         NPPES, 
                                         Vickers
*/
IMPORT BIPV2, iesp, MDR, TopBusiness_Services;

EXPORT SourceSection_OtherDirs := MODULE

 // *********** A function to return a count of all sources in the BIP report SourceSection, 
 //             "Other Directories" category.
 export fn_count_otherdirs(
	 dataset(BIPV2.IDlayouts.l_xlink_ids) ds_in_ids_woacctno 
	 ,dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) ds_in_ids_srcrecs_inlayout
   ,TopBusiness_Services.SourceService_Layouts.OptionsLayout rs_options
	 ,dataset(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_bh_keyrecs
   ):= function 
 
  FETCH_LEVEL := rs_options.fetch_level;

  // ***** Get ABIUS (aka InfoUSA USABiz) counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_abius_count(Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName, 
	      self.category_doccount := TopBusiness_Services.InfoUSA_ABIUSSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_abius_counts := project(ds_in_ids_srcrecs_inlayout,tf_abius_count(left));

  // ***** Get ACF (America's Corporate Financial Directory) counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_acf_count(TopBusiness_services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_ACF}],
					          TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount; 
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_ACF;
				self                   := l; // to assign all linkids
		 end;
	
  ds_acf_counts := project(ds_in_ids_srcrecs_inlayout,tf_acf_count(left));
 
  // ***** Get AMIDIR (American Medical Info Directory) counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_amidir_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName, 
	      self.category_doccount := TopBusiness_Services.AmidirSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_AMIDIR;
				self                   := l; // to assign all linkids
		 end;
	
  ds_amidir_counts := project(ds_in_ids_srcrecs_inlayout,tf_amidir_count(left));

	// ***** Get AMS (Advantage Medical Systems) counts 
  // *** Key fetch to get linkids key data.
	ds_ams_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
															                       FETCH_LEVEL, // level of ids to join with
																										  TopBusiness_Services.Constants.SlimKeepLimit
                                                    ).ds_ams_linkidskey_recs;

  ds_ams_keyrecs_dd := dedup(sort(ds_ams_keyrecs,
		     			                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																	,ams_id 
																 ),
	     			                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
														 ,ams_id
													  );

  // table to count # of recs (ams_ids) per group (set of linkids)
	ds_ams_keyrecs_dd_tabled := table(ds_ams_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_ams_count(recordof(ds_ams_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_AMS; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_ams_counts := project(ds_ams_keyrecs_dd_tabled,tf_ams_count(left));


	// ***** Get Bankruptcy Attorney & Trustee counts???


	// ***** Get Better Business Bureau (BBB) member counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_bbbm_count(Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.BBBSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_BBB_Member;
				self                   := l; // to assign all linkids
		 end;
	
  ds_bbbm_counts := project(ds_in_ids_srcrecs_inlayout,tf_bbbm_count(left));

	// ***** Get Better Business Bureau (BBB) non-member counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_bbbnm_count(Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.BBBNonMemSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_BBB_Non_Member;
				self                   := l; // to assign all linkids
		 end;
	
  ds_bbbnm_counts := project(ds_in_ids_srcrecs_inlayout,tf_bbbnm_count(left));

	// ***** Get BusRegs (Business Registrations from AccuTrend) counts
  // *** Key fetch to get linkids key data.
	ds_busreg_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
										                                    FETCH_LEVEL, // level of ids to join with
																												TopBusiness_Services.Constants.SlimKeepLimit
										                                   ).ds_busreg_linkidskey_recs;

  ds_busreg_keyrecs_dd := sort( ds_busreg_keyrecs,
                                #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
                              );

  // table to count # of recs (norm_taxids) per group (set of linkids)
	ds_busreg_keyrecs_dd_tabled := table(ds_busreg_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_busreg_count(recordof(ds_busreg_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_Business_Registration; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_busreg_counts := project(ds_busreg_keyrecs_dd_tabled,tf_busreg_count(left));


	// ***** Get CLIA (Clinical Laboratory Improvement Amendments database) counts???


	// ***** Get CNLD (Choicepoint National License Database) Facilities counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_cnldfac_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.CNLDFacilitySource_Records( 
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_CNLD_Facilities; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_cnldfac_counts := project(ds_in_ids_srcrecs_inlayout,tf_cnldfac_count(left));
	
  // ***** Get Cortera Counts
	ds_cortera_keyrecs :=  TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
										                                    FETCH_LEVEL
																												,TopBusiness_Services.Constants.defaultJoinLimit
										                                   ).ds_cortera_linkidskey_recs;
  
  ds_cortera_keyrecs_dd := dedup(sort(ds_cortera_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   link_id),
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              link_id);

  //table to count # of recs (cortera_keys) per group (set of linkids)
	ds_cortera_keyrecs_dd_tabled := table(ds_cortera_keyrecs_dd,
	                                   //v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_cortera_count(recordof(ds_cortera_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := '';                                  //section name not needed, 
				self.Source            := MDR.sourceTools.src_Cortera; 
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

   ds_cortera_counts := project(ds_cortera_keyrecs_dd_tabled,tf_cortera_count(left));
	 
  // ***** Get Credit Unions counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_crdtun_count(TopBusiness_services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_Credit_Unions}],
					          TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount; 
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_Credit_Unions;
				self                   := l; // to assign all linkids
		 end;
	
  ds_crdtun_counts := project(ds_in_ids_srcrecs_inlayout,tf_crdtun_count(left));


  // ***** Get Deadco (InfoUSA inactive/"dead" companies) counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_deadco_count_xfm( TopBusiness_Services.Layouts.rec_input_ids_wSrc l ) := TRANSFORM
        SELF.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName, 
	      SELF.category_doccount := TopBusiness_Services.InfoUSA_DeadcoSource_Records(
			     // create dataset with 1 rec in the layout input to all ***Source_Records
           DATASET([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount; 
				SELF.Section           := ''; //section name N/A
				SELF.Source            := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES;
				SELF                   := l; // to assign all linkids
		 END;
  
  ds_deadco_counts := PROJECT (ds_in_ids_srcrecs_inlayout,tf_deadco_count_xfm(LEFT));


  // ***** Get Debt Settlement counts???


  // ***** Get Diversity Certification counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_divcert_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) := transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName, 
	      self.category_doccount := TopBusiness_Services.DiversityCertSource_Records (
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_Diversity_Cert;
				self                   := l; // to assign all linkids
		 end;
	
  ds_divcert_counts := project(ds_in_ids_srcrecs_inlayout,tf_divcert_count(left));

  // ***** Get DNB_Fein counts
	ds_dnbfein_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
										                                     FETCH_LEVEL,// level of ids to join with										          
																												 TopBusiness_Services.Constants.SlimKeepLimit
										                                    ).ds_dnbfein_linkidskey_recs;

  ds_dnbfein_keyrecs_dd := dedup(sort(ds_dnbfein_keyrecs,
		     			                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	    tmsid),
	     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															   tmsid);

  // table to count # of recs (tmsids) per group (set of linkids)
	ds_dnbfein_keyrecs_dd_tabled := table(ds_dnbfein_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_dnbfein_count(recordof(ds_dnbfein_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_Dunn_Bradstreet_Fein; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_dnbfein_counts := project(ds_dnbfein_keyrecs_dd_tabled,tf_dnbfein_count(left));

	// ***** Get FBN (Fictitious Business Names aka Doing Business As) counts
  // *** Key fetch to get linkids key data.
	ds_fbn_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
										                                 FETCH_LEVEL,// level of ids to join with										          
																										 TopBusiness_Services.Constants.SlimKeepLimit
										                                ).ds_fbn_linkidskey_recs;
  
  ds_fbn_keyrecs_dd := dedup(sort(ds_fbn_keyrecs,
		     			                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	    tmsid),
	     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															   tmsid);

  // table to count # of recs (tmsids) per group (set of linkids)
	ds_fbn_keyrecs_dd_tabled := table(ds_fbn_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_fbn_count(recordof(ds_fbn_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_FBNV2_FL; // but need source code
				// fbn has multiple source codes, so picked first one ---^
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_fbn_counts := project(ds_fbn_keyrecs_dd_tabled,tf_fbn_count(left));

	// ***** Get LaborActions WHD counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_lawhd_count(Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.LaborActionsWHDSource_Records( 
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_LaborActions_WHD; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_lawhd_counts := project(ds_in_ids_srcrecs_inlayout,tf_lawhd_count(left));

  // ***** Get Martindale-Hubbell counts - Bug: 156764 
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_mdhbl_count(TopBusiness_services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_MartinDale_Hubbell}],
           TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount; 
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_MartinDale_Hubbell;
				self                   := l; // to assign all linkids
		 end;
	
  ds_mdhbl_counts := project(ds_in_ids_srcrecs_inlayout,tf_mdhbl_count(left));

	// ***** Get NCPDP (National Council for Prescription Drug Programs) counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_ncpdp_count(Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.NcpdpSource_Records( 
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_NCPDP; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_ncpdp_counts := project(ds_in_ids_srcrecs_inlayout,tf_ncpdp_count(left));


	// ***** Get NPPES (US National Provider & Plan Enumeration System) counts???

 
  // ***** Get Redbooks (International Advertisers) counts - bug: 156780,
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_rb_count(TopBusiness_services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_RedBooks}],
					          TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount; 
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_Redbooks;
				self                   := l; // to assign all linkids
		 end;
	
  ds_rb_counts := project(ds_in_ids_srcrecs_inlayout,tf_rb_count(left));
	
  // ***** Get SDA (Standard Directory of Advertisers) counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_sda_count(TopBusiness_services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_SDA}],
					          TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount; 
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_SDA;
				self                   := l; // to assign all linkids
		 end;
	
  ds_sda_counts := project(ds_in_ids_srcrecs_inlayout,tf_sda_count(left));

	
	// ***** Get SDAA (Standard Directory of Advertising Agencies) counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_sdaa_count(TopBusiness_services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_SDAA}],
					          TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount; 
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_SDAA;
				self                   := l; // to assign all linkids
		 end;
	
  ds_sdaa_counts := project(ds_in_ids_srcrecs_inlayout,tf_sdaa_count(left));


	// ***** Get Sheila Greco counts
  // *** Key fetch to get linkids key data.
  ds_sg_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
								                                    FETCH_LEVEL,TopBusiness_Services.Constants.SlimKeepLimit).ds_sg_linkidskey_recs;
  
  ds_sg_keyrecs_dd := sort(ds_sg_keyrecs,
                           #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
                          );

  // table to count # of recs (tmsids) per group (set of linkids)
	ds_sg_keyrecs_dd_tabled := table(ds_sg_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_sg_count(recordof(ds_sg_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_Sheila_Greco; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_sg_counts := project(ds_sg_keyrecs_dd_tabled,tf_sg_count(left));

  // ***** Get SKA (Nixie & Verified) counts
  // contact info for medical related businesses info from a data supplier named SK&A
  // vers 1 used instead of vers2b since a small amount of data, plus no SKASource_Records attribute exists.
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_ska_count(Layouts.rec_input_ids_wSrc l) := TRANSFORM
        SELF.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      SELF.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_SKA}],
					          TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount;
				SELF.Section           := ''; //section name N/A
				SELF.Source            := MDR.sourceTools.src_SKA;
				SELF                   := l; // to assign all linkids
		 END;
	
  ds_ska_counts := project(ds_in_ids_srcrecs_inlayout,tf_ska_count(left));

  // ***** Get Spoke counts
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_spoke_count(Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName, 
	      self.category_doccount := TopBusiness_Services.SpokeSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_Spoke; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_spoke_counts := project(ds_in_ids_srcrecs_inlayout,tf_spoke_count(left));

  // ***** Get Utilities counts
	TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_Util_count(Layouts.rec_input_ids_wSrc l) := TRANSFORM
        SELF.category_desc     := TopBusiness_Services.Constants.OtherDirCategoryName,
	      SELF.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_Utilities}],
					          TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount;
				SELF.Section           := ''; //section name N/A
				SELF.Source            := MDR.sourceTools.src_Utilities;
				SELF                   := l; // to assign all linkids
		 END;
 
  ds_util_counts := project(ds_in_ids_srcrecs_inlayout,tf_util_count(left));


  // ***** Get Vickers counts???


/* */
  // Concatenate counts info from all categories/sources
	ds_all_od_counts := 
/* */    
						       //other directories sources ---v
                     ds_abius_counts   +  
										 ds_acf_counts     +
                     ds_amidir_counts  +
                     ds_ams_counts     + 
										 //ds_bat_counts    + // bat = bankruptcy attorneys & trustees
                     ds_bbbm_counts    +										 
                     ds_bbbnm_counts   +
									   ds_busreg_counts  +
										 //ds_clia_counts    +
                     ds_cnldfac_counts + 
										 ds_cortera_counts +
                     ds_crdtun_counts  +
									   ds_deadco_counts  + 
										 //ds_debtset_counts + // debtset = debt settlement      
  								   ds_dnbfein_counts + 
										 ds_divcert_counts + // divcert = diversity certification
									   ds_fbn_counts     + 
                     ds_lawhd_counts   + // lawhd = LaborActions WHD
										 ds_mdhbl_counts   + // mdhbl = martindale-hubbell
									   // ds_ncpdp_counts   + 
										 //ds_nppes_counts   +
										 ds_rb_counts      + // rb = redbooks (international advertisers)
										 ds_sda_counts     +
										 ds_sdaa_counts    +
									   ds_sg_counts      + // sg = Sheila greco
                     ds_ska_counts     + 
                     ds_spoke_counts   +  
									   ds_util_counts    +
										 //ds_vickers_counts +
/* */
									 // v--- Empty dataset to make it easier to comment out/uncomment 
									 // ds_***s above for testing.
									 // REMOVE (--^ & --v) WHEN FINAL PROD VERSION IS CHECKED IN <-----------!!! ???
									 dataset([],TopBusiness_Services.SourceSection_Layouts.rec_SourceCount) // for initial testing
	                 ;

  // Uncomment for debugging
  // output(ds_in_ids_woacctno,               named('ds_in_ids_woacctno'));
  // output(ds_in_ids_srcrecs_inlayout,       named('ds_in_ids_srcrecs_inlayout'));
  // output(rs_options,                       named('rs_options'));

	// output(ds_abius_counts,                  named('ds_abius_counts'));
	// OUTPUT(ds_acf_counts,                    NAMED('ds_acf_counts'));
  // output(ds_amidir_counts,                 named('ds_amidir_counts'));
  // output(ds_ams_keyrecs,                   named('ds_ams_keyrecs'));
  // output(ds_ams_keyrecs_dd,                named('ds_ams_keyrecs_dd'));
	// output(ds_ams_keyrecs_dd_tabled,         named('ds_ams_keyrecs_dd_tabled'));
 	// output(ds_ams_counts,                    named('ds_ams_counts'));
	// output(ds_bbbm_counts,                   named('ds_bbbm_counts'));
	// output(ds_bbbnm_counts,                  named('ds_bbbnm_counts'));
  // output(ds_busreg_keyrecs,                named('ds_busreg_keyrecs'));
  // output(ds_busreg_keyrecs_dd,             named('ds_busreg_keyrecs_dd'));
	// output(ds_busreg_keyrecs_dd_tabled,      named('ds_busreg_keyrecs_dd_tabled'));
	// output(ds_busreg_counts,                 named('ds_busreg_counts'));
	// output(ds_cnldfac_counts,                named('ds_cnldfac_counts'));
	// output(ds_crdtun_counts,                 named('ds_crdtun_counts'));
  // ouptut(ds_deadco_counts,                 NAMED('ds_deadco_counts'));
  // OUTPUT(ds_divCert_counts,                NAMED('ds_divCert_counts'));
  // OUTPUT(ds_divcert_recs,                  NAMED('ds_divcert_recs'));
  // output(ds_dnbfein_keyrecs,               named('ds_dnbfein_keyrecs'));
  // output(ds_dnbfein_keyrecs_dd,            named('ds_dnbfein_keyrecs_dd'));
	// output(ds_dnbfein_keyrecs_dd_tabled,     named('ds_dnbfein_keyrecs_dd_tabled'));
	// output(ds_dnbfein_counts,                named('ds_dnbfein_counts'));
  // output(ds_fbn_keyrecs,                   named('ds_fbn_keyrecs'));
  // output(ds_fbn_keyrecs_dd,                named('ds_fbn_keyrecs_dd'));
	// output(ds_fbn_keyrecs_dd_tabled,         named('ds_fbn_keyrecs_dd_tabled'));
	// output(ds_fbn_counts,                    named('ds_fbn_counts'));
	// output(ds_lawhd_counts,                  named('ds_lawhd_counts'));
	// output(ds_ncpdp_counts,                  named('ds_ncpdp_counts'));
  // output(ds_sg_keyrecs,                    named('ds_sg_keyrecs'));
  // output(ds_sg_keyrecs_dd,                 named('ds_sg_keyrecs_dd'));
	// output(ds_sg_keyrecs_dd_tabled,          named('ds_sg_keyrecs_dd_tabled'));
	// output(ds_sg_counts,                     named('ds_sg_counts'));
	// output(ds_spoke_counts,                  named('ds_spoke_counts'));
  // output(ds_ska_counts,                    named('ds_ska_counts')); 
  // output(ds_util_keyrecs,                  named('ds_util_keyrecs'));
  // output(ds_util_keyrecs_dd,               named('ds_util_keyrecs_dd'));
	// output(ds_util_keyrecs_dd_tabled,        named('ds_util_keyrecs_dd_tabled'));
  // output(ds_util_counts,                   NAMED('ds_util_counts'));
  // output(ds_all_od_counts,                 named('ds_all_od_counts'));

	RETURN ds_all_od_counts;

 END; // end of fn_count_otherdirs

END; // end of module

/*  to test, in a builder window use this: 
// v--- Needed for testing any section:  
IMPORT AutoStandardI;

//v--- for use with Todd's macro???
#STORED('DPPAPurpose',1);
#STORED('GLBPurpose',1);  // 2 = show minors
#STORED('DataRestrictionMask','00000000000000000000'); // pos 3 = ebr, set to non-blank (0 or 1) to include ebr data
//#STORED('DataRestrictionMask','')
#STORED('LnBranded',true);
//#STORED('BusinessReportFetchLevel','S'); 

 //v--- revise for use with Todd's macro???
  tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export unsigned1 DPPAPurpose := 1 : stored('DPPAPurpose'); // chg as needed for testing
		export unsigned1 GLBPurpose := 1 : stored('GLBPurpose'); // chg as needed for testing
		export boolean includeMinors := false;
    //        position 3=0 to use EBR  -----v
		export string DataRestrictionMask := '00000000000000000000' : stored('DataRestrictionMask');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
	end;

  // Set SSN Mask for testing in certain sections: UCC, Liens, Bankr 
	string6 SSNMask := 'NONE'; //for testing chg default to: FIRST5, LAST4 or ALL
	//string6 SSNMask := 'FIRST5';
  #stored('SSNMask', SSNMask);

  // Input options for all report sections (except UCCs, see UCC section testing below)
	// Just 2 booleans & 1 char for now: lnbranded , internal_testing and busrpt_fetch_level
  ds_options := dataset([{false, false, 'S'} //3rd parm=BusinessReportFetchLevel, default='S'=seleid
                        ],topbusiness_services.Layouts.rec_input_options);
// ^--- Needed for testing any section:  

// input dataset for all sections, layout = topbusiness_services.Layouts.rec_input_ids = 
//         acctno,DotID,EmpID,POWID,ProxID,SeleID,OrgID,UltID

// To test the Source section: 

source_sec := TopBusiness_Services.SourceSection.fn_FullView(
             dataset([
											// {'test14p', 0, 0, 0, 0, 7, 7, 7} // 3 fbn
											// {'test17d', 0, 0, 0, 0, 7, 7, 7} // 1 busreg
										  // {'test19p', 0, 0, 0, 0, 39556, 39556, 39556} // 6? sheila greco
 											// {'othdir22p', 0, 0, 0, 0, 1564092983, 1564092983, 1564092983} // bug 129303 test case 4,  oth dir/2(?) dnb fein
										  // {'test26ap', 0, 0, 0, 0, 417, 417, 417} // 1 bbb member doc
										  // {'test26bp', 0, 0, 0, 0, 28188, 28188, 28188} // 2 bbb member docs & 7 bbb nm docs, 9 total
										  // {'test26cp', 0, 0, 0, 0, 529, 529, 529} // 2 bbb non-member docs
                      // {'test33p', 0, 0, 0, 0, 1677432124, 1677432124, 1677432124} // 1 abius doc (4 "directories" li recs)
                      // {'test37p215', 0, 0, 0, 0, 2, 2, 2} // no bug/chg to use src li keys-test case 2.15 busreg; 3 li key recs/3 src  docs counted&retd
                      // {'test37p216', 0, 0, 0, 0, 4, 4, 4} // no bug/chg to use src li keys-test case 2.16 dnbfein; 7 li key recs/4 tmsids/src  docs counted&retd
                      // {'test37p217', 0, 0, 0, 0, 2, 2, 2} // no bug/chg to use src li keys-test case 2.17 fbn; 3 li key recs/2 tmsids/src  docs counted&retd
                      // {'test37p218', 0, 0, 0, 0, 2578, 2578, 2578} // no bug/chg to use src li keys-test case 2.18 sheila greco; 3 li key recs/3 src  docs counted&retd
                      // {'test37p226mbrv1', 0, 0, 0, 0, 281, 281, 281} // no bug/chg to use src li keys-test case 2.26a bbb mbr; 3 li key recs/3 src  docs counted/retd
                      // {'test37p226nmbrv1', 0, 0, 0, 0, 529, 529, 529} // no bug/chg to use src li keys-test case 2.26b bbb nonmbr; 3 li key recs/3 src  docs counted/retd
                      // {'test38ams1v2b', 0, 0, 0, 0, 164, 164, 164} // bug 156617 add AMS; 2 li key recs/1 src  docs counted/retd
                      // {'test38cnldfac1', 0, 0, 0, 0, 135, 135, 135} // bug 156620 add CNLD_FACILITIES, test case 1; 8 li key recs/3 src  docs counted/retd
                      // {'test38cnldfac22', 0, 0, 0, 0, 4464, 4464, 4464} // bug 156620 add CNLD_FACILITIES, test case 2; 1 li key recs/1 src  docs counted/retd
                      // {'test61amidir1', 0, 0, 0, 0, 30445, 30445, 30445} // bug 156807 add AMIDIR; 3 li key recs/2 src  docs counted/retd
                      // {'test61amidir2', 0, 0, 0, 0, 33140, 33140, 33140} // bug 156807 add AMIDIR; 5 li key recs/5 src  docs counted/retd
                      // {'test64spoke1', 0, 0, 0, 0, 4, 4, 4} // bug 156817 add SPOKE; 8 li key recs/2 src  docs counted/retd
                      // {'test64spoke2', 0, 0, 0, 0, 135, 135, 135} // bug 156817 add SPOKE; 7 li key recs/1 src  docs counted/retd
                      // {'test65lawhd1', 0, 0, 0, 0, 14, 14, 14} // bug 156811 add LaborActions_WHD; 4 li key recs/1 src  docs counted/retd
                      // {'test65lawhd2', 0, 0, 0, 0, 5167, 5167, 5167} // bug 156811 add LaborActions_WHD; 6 li key recs/2? src  docs counted/retd
                      // {'test67abius1', 0, 0, 0, 0, 4, 4, 4} // bug 169439 chg to use infousa_abiussource_records; 3 li key recs/1 src  docs counted/retd
                      // {'test67abius2', 0, 0, 0, 0, 3616743, 233, 233} // bug 169439 chg to use infousa_abiussource_records; 5 li key recs/2 src  docs counted/retd
                      // {'test69ncpsp1', 0, 0, 0, 0, 702, 702, 702} // bug 156772 add NCPDP; 8 li key recs/2 src  docs counted/retd
                      // {'test69ncpdp2', 0, 0, 0, 0, 6022, 6022, 6022} // bug 156772 add NCPDP; 15 li key recs/2 src  docs counted/retd
                      // {'test81spokeP1', 0, 0, 0, 0, 4, 4, 4} //no bug/chg to use new od attr - SPOKE; 8 li key recs/2 src  docs counted/retd
											// {'test81othdir2p1', 0, 0, 0, 0, 4, 4, 4} // no bug/chg to use new od attr - busreg 1 li key recs/1 source docs & spoke 8 li key recs/2 source docs 
                      // {'testDeadco17270_singleRow', 0, 0, 0, 0, 17270, 17270, 17270} // bug: 156638 test deadco source docs - 1 recs in linkIDs key // 2 "OthDirs" source docs counted(1 IC & 1 WF)/1 "IC" src doc retd
                      // {'testDeadco281', 0, 0, 0, 0, 281, 281, 281} // bug: 156638 test deadco source docs - 10 recs in linkIDs key // 104 "OthDirs" source docs counted(10 IC & ? xx)/10 "IC" src doc retd
                      // {'testDeadco665', 0, 0, 0, 0, 665, 665, 665} // bug: 156638 test deadco source docs - 4 recs in linkIDs key // 18 "OthDirs" source docs counted(4 IC & ? xx)/4 "IC" src doc retd
                      // {'testSka135', 0, 0, 0, 0, 135, 135, 135} // Bug: 156635 test SK&A source docs -  recs in linkIDs key //  source docs counted
                      // {'testSka3657', 0, 0, 0, 0, 3657, 3657, 3657} // Bug: 156635 test SK&A source docs - 4 recs in ska nixie & bip directories linkIDs keys // 4 source docs counted/returned 
                      // {'testSka12941', 0, 0, 0, 0, 12941, 12941, 12941} // Bug: 156635 test SK&A source docs - 2 recs in ska nixie & bip directories linkIDs keys // 2 source docs counted/returned
                      // {'testUtil747', 0, 0, 0, 0, 747, 747, 747}  // 2 recs in linkIDs key // 1 source docs counted
                      // {'testUtil600', 0, 0, 0, 0, 600, 600, 600}   // no results is correct. bug: 174941
                      // {'testUtil6415', 0, 0, 0, 0, 6415, 6415, 6415}  // 1 recs in linkIDs key // 1 source docs counted
                      // {'testCreditUnion551991', 0, 0, 0, 0, 551991, 551991, 551991} // no bug/chg use to test deadco source docs - 4 recs in linkIDs key // 2 source docs counted
                      // {'testSka281', 0, 0, 0, 0, 281, 281, 281} // no bug/chg use to test deadco source docs - 4 recs in linkIDs key // 4 source docs counted
                      // {'testSka702', 0, 0, 0, 0, 702, 702, 702} // no bug/chg use to test deadco source docs - 4 recs in linkIDs key // 4 source docs counted
                      // {'testAcf233', 0, 0, 0, 0, 29150652, 233, 233} // // ? recs in linkIDs key // 1 source docs counted 
                      // {'testAcf7842', 0, 0, 0, 0, 7842, 7842, 7842} // ? recs in linkIDs key // 1 source docs counted
                      // bug: 156750 (Diversity Certification) 
                      // {'testDivCert217', 0, 0, 0, 0, 217, 217, 217} // 2 records
                      // {'testDivCert233_1', 0, 0, 0, 0, 127890024, 233, 233}  // 1 record
                      // {'testDivCert233_2', 0, 0, 0, 0, 3616743, 233, 233}  // 3 records                    // {'testCreditUnion551991', 0, 0, 0, 0, 551991, 551991, 551991} // no bug/chg use to test deadco source docs - 4 recs in linkIDs key // 2 source docs counted
                      // bug: 156781 (SDA & SDAA)
                      // {'testSda4182', 0, 0, 0, 0, 4182, 4182, 4182} // 1 record -> SDA -Standard Directory of Advertisers data (source code = SA) and 
                      // {'testSda233', 0, 0, 0, 0, 3616743, 233, 233} // 1 record -> SDA -Standard Directory of Advertisers data (source code = SA) and 
                      // {'testSda3376', 0, 0, 0, 0, 3376, 3376, 3376} // 1 - record
                      // {'testSdaa4706', 0, 0, 0, 0, 82074177, 4706, 4706}  // 1 record -- AA, but 5 other dir count -> the SDAA - Standard Directory of Advertisers International data (source code = AA)
                      // bug: 156764 Martindale-Hubbell 
                      // {'testMartinHub388', 0, 0, 0, 0, 0, 388, 388} // 1 record  
                      // {'testMartinHub388_2', 0, 0, 0, 0, 45725587, 388, 388}  // 1 record
                      // {'testMartinHub1253', 0, 0, 0, 0, 1253, 1253, 1253}  // 1 record
                      // {'testMartinHub1267', 0, 0, 0, 0, 1267, 1267, 1267}  // 1 record
                      // {'testMartinHub3841', 0, 0, 0, 0, 3841, 3841, 3841}  // 1 record
                      // bug: 156780 Redbooks 
                      // {'testRB233', 0, 0, 0, 0, 233, 233, 233} // 1 record
                      // {'testRB233_2', 0, 0, 0, 0, 3616743, 233, 233} // 1 record
                      // {'testRB233_3', 0, 0, 0, 0, 78706613, 233, 233} // 1 record
                      // {'testRB3859', 0, 0, 0, 0, 3859, 3859, 3859} // 1 record
                      // {'testRB3376', 0, 0, 0, 0, 3376, 3376, 3376} // 1 record
                      
                  ],topbusiness_services.Layouts.rec_input_ids)
						,ds_options[1]
					  ,tempmod
            );

output(source_sec);
// */
