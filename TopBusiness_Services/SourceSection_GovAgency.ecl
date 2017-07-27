/* Status as of 02/24/2015, coding is DONE to count source docs for these sources: 
      11. Government Agencies - ATF, CALBUS, CA sales tax, DEA, Edgar, FCC, FDIC, FL Non profit, 
                                GSA, IA sales tax, Insurance Certification, IRS5500(ret), 
                                IRS990(nonprofit), MS Workers Comp, Natural Disaster Readiness, 
                                OIG, OR Workers Comp, OSHAIR, Prof Lics, SEC_Broker/Dealer, TXBUS
                                & Workers Compensation
TBD:
   1. Add coding: to use appropriate TopBusiness_Services.***Source_Records (vers1)            
               OR to use individual source ***.key_linkids.kfetch, (vers2b)
               OR to use (new as of 07/28/14) TopBusiness_Services.Key_Fetches attr, (vers3)
               Then sort/dedup/count to match # docs returned by the SourceService.
      for these categories/sources: see below
       
       As of 02/24/15, still need to add coding for these sources?:
       (these sources do not display in any section of the report, nor are they included in the
        BIP Bus Hdr, Contacts, Industry or License linkids keys, but they need to be counted???)
       a. FDIC Sod Annual 
       b. Mari professional licenses 
       c. Mari public sanctions (Aka SANCTN)
*/
IMPORT BIPV2, iesp, MDR, TopBusiness_Services;

EXPORT SourceSection_GovAgency := MODULE

 // *********** Main function to return count of all sources in the the BIP report SourceSection, 
 //             "Government Agency" category (#11).
 export fn_count_govagency(
	 dataset(BIPV2.IDlayouts.l_xlink_ids) ds_in_ids_woacctno 
	 ,dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) ds_in_ids_srcrecs_inlayout
   ,TopBusiness_Services.SourceService_Layouts.OptionsLayout rs_options
	 ,dataset(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_bh_keyrecs
   ):= function 

  FETCH_LEVEL := rs_options.fetch_level;

/* */
  // ***** Get ATF counts
  // *** Key fetch to get linkids key data.
 	ds_atf_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
								                                     FETCH_LEVEL,
																										 TopBusiness_Services.Constants.AtfSourceDocsKfetchMaxLimit).ds_atf_linkidskey_recs;

  ds_atf_keyrecs_dd := dedup(sort(ds_atf_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   license_number),
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              license_number);

  // table to count # of recs (license_numbers) per group (set of linkids)
	ds_atf_keyrecs_dd_tabled := table(ds_atf_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_atf_count(recordof(ds_atf_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_Federal_Firearms; // but need source code
				// ^--- 2 source codes for ATF data, shouldn't matter which one we use
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_atf_counts := project(ds_atf_keyrecs_dd_tabled,tf_atf_count(left));

  // ***** Get CALBUS counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_calbus_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := TopBusiness_Services.CalbusSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_Calbus;
				self                   := l; // to assign all linkids
		 end;
	
  ds_calbus_counts := project(ds_in_ids_srcrecs_inlayout,tf_calbus_count(left));

  // ***** Get CA Sales Tax counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_castx_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := TopBusiness_Services.CASalesTaxSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_CA_Sales_Tax;
				self                   := l; // to assign all linkids
		 end;
	
  ds_castx_counts := project(ds_in_ids_srcrecs_inlayout,tf_castx_count(left));

	// ***** Get DEA counts
  // *** Key fetch to get linkids key data.
 	ds_dea_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
								                                     FETCH_LEVEL,
																										 TopBusiness_Services.Constants.DeaSourceDocsKfetchMaxLimit).ds_dea_linkidskey_recs;

  ds_dea_keyrecs_dd := dedup(sort(ds_dea_keyrecs,
	     			                      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                  dea_registration_number),
	     			                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                             dea_registration_number);

  // table to count # of recs (dea_registration_number) per group (set of linkids)
	ds_dea_keyrecs_dd_tabled := table(ds_dea_keyrecs_dd,
	                                  // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_dea_count(recordof(ds_dea_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_DEA; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_dea_counts := project(ds_dea_keyrecs_dd_tabled,tf_dea_count(left));

  // ***** Get Edgar counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_edgar_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
				// use generic OtherSource_Records atrribute, since Edgar data is on the 
				// BIP Directories key and no Edgar Linkids key currently exists in prod.
	      self.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_Edgar}],
					          TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_Edgar;
				self                   := l; // to assign all linkids
		 end;
	
  ds_edgar_counts := project(ds_in_ids_srcrecs_inlayout,tf_edgar_count(left));	
	

  // ***** Get FCC counts
  // *** Key fetch to get linkids key data.
  ds_fcc_keyrecs := TopBusiness_Services.Key_Fetches(
	                                  ds_in_ids_woacctno, // input file to join key with
								                    FETCH_LEVEL,
																		TopBusiness_Services.Constants.FCCSourceDocsKfetchMaxLimit).ds_fcc_linkidskey_recs;

  ds_fcc_keyrecs_dd := dedup(sort(ds_fcc_keyrecs,
	     			                      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                  fcc_seq),
	     			                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                             fcc_seq);

  // table to count # of recs (fcc_seq) per group (set of linkids)
	ds_fcc_keyrecs_dd_tabled := table(ds_fcc_keyrecs_dd,
	                                  // v--- Create table layout on the fly
                                    {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											               recs_count := count(group)
																		},
																    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_fcc_count(recordof(ds_fcc_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_FCC_Radio_Licenses; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_fcc_counts := project(ds_fcc_keyrecs_dd_tabled,tf_fcc_count(left));

  // ***** Get FDIC (institutions) counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_fdic_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := TopBusiness_Services.FDICSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_FDIC;
				self                   := l; // to assign all linkids
		 end;
	
  ds_fdic_counts := project(ds_in_ids_srcrecs_inlayout,tf_fdic_count(left));

  // ***** Get FL non-profit counts
  // vers1 used instead of vers2b since a small amount of data
	TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_flnonpt_count(Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
				// use generic OtherSource_Records atrribute, since FL NP data is on the 
				// BIP Directories key and the FL NP linkids key in prod is currently empty.
	      self.category_doccount := TopBusiness_Services.OtherSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
           // v---  need ids plus source code when using generic OtherSource_Records attr.
 					 dataset([{'',l.dotid,l.empid,l.powid,l.proxid,l.seleid,l.orgid,l.ultid,'','','',MDR.sourceTools.src_FL_Non_Profit}],
					          TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false,ds_bh_keyrecs).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_FL_Non_Profit;
				self                   := l; // to assign all linkids
		 end;
	
  ds_flnonpt_counts := project(ds_in_ids_srcrecs_inlayout,tf_flnonpt_count(left));

  // ***** Get GSA (General Service Administration) counts
  // vers1 used instead of vers2b since a small amount of data
	TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	tf_gsa_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
		 self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
		 self.category_doccount := TopBusiness_Services.GSASource_Records(
				 //create dataset with 1 rec in the layout input to all ***Source_Records
				 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
				 rs_options,false).SourceView_RecCount;
			self.Section           := ''; //section name N/A
			self.Source            := MDR.sourceTools.src_GSA; // but need source code
			self                   := l; // to assign all linkids
	 end;

  ds_gsa_counts := project(ds_in_ids_srcrecs_inlayout,tf_gsa_count(left));

  // ***** Get IA(Iowa) Sales Tax counts
  // vers1 used instead of vers2b since a small amount of data
	TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_iastx_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := TopBusiness_Services.IASalesTaxSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_IA_Sales_Tax;
				self                   := l; // to assign all linkids
		 end;
	
  ds_iastx_counts := project(ds_in_ids_srcrecs_inlayout,tf_iastx_count(left));

  // ***** Get Insurance Certification counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_inscert_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := TopBusiness_Services.InsuranceCertSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_Insurance_Certification;
				self                   := l; // to assign all linkids
		 end;
	
  ds_inscert_counts := project(ds_in_ids_srcrecs_inlayout,tf_inscert_count(left));

  // ***** Get IRS5500(retirement info) counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_irs5500_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := TopBusiness_Services.IRS5500Source_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_IRS_5500;
				self                   := l; // to assign all linkids
		 end;
	
  ds_irs5500_counts := project(ds_in_ids_srcrecs_inlayout,tf_irs5500_count(left));

  // ***** Get IRS990(non-profit info) counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_irs990_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := TopBusiness_Services.IRS990Source_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_IRS_Non_Profit;
				self                   := l; // to assign all linkids
		 end;
	
  ds_irs990_counts := project(ds_in_ids_srcrecs_inlayout,tf_irs990_count(left));

  // ***** Get MS(Mississippi) Workers Comp counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	  tf_mswork_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
       self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	     self.category_doccount := TopBusiness_Services.MSWorkSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_MS_Worker_Comp; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_mswork_counts := project(ds_in_ids_srcrecs_inlayout,tf_mswork_count(left));

  // ***** Get Natural Disaster Readiness counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	  tf_ndr_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
       self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	     self.category_doccount := TopBusiness_Services.NDRSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_NaturalDisaster_Readiness; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_ndr_counts := project(ds_in_ids_srcrecs_inlayout,tf_ndr_count(left));
	
  // ***** Get OIG(Office of Inspector General) counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	  tf_oig_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
       self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	     self.category_doccount := TopBusiness_Services.OIGSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section          := ''; //section name N/A
				self.Source           := MDR.sourceTools.src_OIG; // but need source code
				self                  := l; // to assign all linkids
		 end;
	
  ds_oig_counts := project(ds_in_ids_srcrecs_inlayout,tf_oig_count(left));

  // ***** Get OR(Oregon) Workers Comp counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	  tf_orwork_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
       self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	     self.category_doccount := TopBusiness_Services.ORWorkSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section          := ''; //section name N/A
				self.Source           := MDR.sourceTools.src_OR_Worker_Comp; // but need source code
				self                  := l; // to assign all linkids
		 end;
	
  ds_orwork_counts := project(ds_in_ids_srcrecs_inlayout,tf_orwork_count(left));

  // ***** Get OSHA IR (Occupational Safety & Hazard Act Incident Reports) counts
  // Probably could use vers1 instead of vers3 since a small amount of data, 
	// but this works so leave it as is.
  // *** Key fetch to get linkids key data.
  ds_oshair_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
								                                        FETCH_LEVEL,TopBusiness_Services.Constants.SlimKeepLimit).ds_osha_linkidskey_recs;
 
  ds_oshair_keyrecs_dd := dedup(sort(ds_oshair_keyrecs,
	     			                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                     activity_number),
	     			                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                activity_number);

  // table to count # of recs (activity_numbers) per group (set of linkids)
	ds_oshair_keyrecs_dd_tabled := table(ds_oshair_keyrecs_dd,
	                                     // v--- Create table layout on the fly
                                       {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                  recs_count := count(group)
																		   },
																       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_oshair_count(recordof(ds_oshair_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not applicable
				self.Source            := MDR.sourceTools.src_OSHAIR; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_oshair_counts := project(ds_oshair_keyrecs_dd_tabled,tf_oshair_count(left));

	// ***** Get Professional License counts
  // *** Key fetch to get linkids key data.
  ds_prolic_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
								                                        FETCH_LEVEL,
																												TopBusiness_Services.Constants.ProfLicSourceDocsKfetchMaxLimit).ds_pl_linkidskey_recs;													

  ds_prolic_keyrecs_dd := dedup(sort(ds_prolic_keyrecs,
	     			                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                     prolic_seq_id),
	     			                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                prolic_seq_id);

  // table to count # of recs (prolic_seq_ids) per group (set of linkids)
	ds_prolic_keyrecs_dd_tabled := table(ds_prolic_keyrecs_dd,
	                                     // v--- Create table layout on the fly
                                       {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                  recs_count := count(group)
																		   },
																       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_prolic_count(recordof(ds_prolic_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_Professional_License; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_prolic_counts := project(ds_prolic_keyrecs_dd_tabled,tf_prolic_count(left));
	
	// ***** Get SEC Broker/Dealer counts
  // vers1 used instead of vers2b since a small amount of data
	TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	tf_secbd_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
		 self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
		 self.category_doccount := TopBusiness_Services.SEC_BDSource_Records(
				 //create dataset with 1 rec in the layout input to all ***Source_Records
				 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
				 rs_options,false).SourceView_RecCount;
			self.Section           := ''; //section name N/A
			self.Source            := MDR.sourceTools.src_SEC_Broker_Dealer; // but need source code
			self                   := l; // to assign all linkids
	 end;

  ds_secbd_counts := project(ds_in_ids_srcrecs_inlayout,tf_secbd_count(left));

  // ***** Get TXBUS counts
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_txbus_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := TopBusiness_Services.TxbusSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_TXBUS; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_txbus_counts := project(ds_in_ids_srcrecs_inlayout,tf_txbus_count(left));


  // ***** Get Workers Compensation counts (NOTE: different than MS & OR Worker's comp data)
  // vers1 used instead of vers2b since a small amount of data
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_wkcomp_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.GovAgCategoryName,
	      self.category_doccount := TopBusiness_Services.WorkersCompensationSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
 					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
					 rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_Workers_Compensation; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_wkcomp_counts := project(ds_in_ids_srcrecs_inlayout,tf_wkcomp_count(left));

// */

  // Concatenate counts info from all categories/sources
	ds_all_ga_counts := 
/* */   
									   ds_atf_counts     +
                     ds_calbus_counts  +
									   ds_castx_counts   +
									   ds_dea_counts     +
										 ds_edgar_counts	 +
									   ds_fcc_counts     +
								     ds_fdic_counts    +
										 ds_flnonpt_counts +
										 ds_gsa_counts     + 
										 ds_iastx_counts   +  
										 ds_inscert_counts + 
									   ds_irs5500_counts +
									   ds_irs990_counts  +
                     ds_mswork_counts  +  
                     ds_ndr_counts		 +  
                     ds_oig_counts     +
                     ds_orwork_counts  +
									   ds_oshair_counts  + 
								     ds_prolic_counts  +
									   ds_secbd_counts   + 
									   ds_txbus_counts   + 
									   ds_wkcomp_counts  + 
/* */
									 // v--- Empty dataset to make it easier to comment out/uncomment 
									 // ds_***s above for testing.
									 // REMOVE (-^ & -v) WHEN FINAL PROD VERSION IS CHECKED IN <---------------!!! ???
									 dataset([],TopBusiness_Services.SourceSection_Layouts.rec_SourceCount) // for initial testing
	                 ;

  // Uncomment for debugging
  // output(ds_in_ids_woacctno,               named('ds_in_ids_woacctno'));
  // output(ds_in_ids_srcrecs_inlayout,       named('ds_in_ids_srcrecs_inlayout'));
  // output(rs_options,                       named('rs_options'));

  // output(ds_atf_keyrecs,                   named('ds_atf_keyrecs'));
  // output(ds_atf_keyrecs_dd,                named('ds_atf_keyrecs_dd'));
	// output(ds_atf_keyrecs_dd_tabled,         named('ds_atf_keyrecs_dd_tabled'));
	// output(ds_atf_counts,                    named('ds_atf_counts'));
	// output(ds_calbus_counts,                 named('ds_calbus_counts'));
	// output(ds_castx_counts,                  named('ds_castx_counts'));
  // output(ds_dea_keyrecs,                   named('ds_dea_keyrecs'));
  // output(ds_dea_keyrecs_dd,                named('ds_dea_keyrecs_dd'));
	// output(ds_dea_keyrecs_dd_tabled,         named('ds_dea_keyrecs_dd_tabled'));
	// output(ds_dea_counts,                    named('ds_dea_counts'));
	// output(ds_edgar_counts,                  named('ds_edgar_counts'));
  // output(ds_fcc_keyrecs,                   named('ds_fcc_keyrecs'));
  // output(ds_fcc_keyrecs_dd,                named('ds_fcc_keyrecs_dd'));
	// output(ds_fcc_keyrecs_dd_tabled,         named('ds_fcc_keyrecs_dd_tabled'));
	// output(ds_fcc_counts,                    named('ds_fcc_counts'));
  // output(ds_fdic_counts,                   named('ds_fdic_counts'));
  // output(ds_flnonpt_counts,                named('ds_flnonpt_counts'));
	// output(ds_gsa_counts,                  	named('ds_gsa_counts'));
	// output(ds_inscert_counts,                named('ds_inscert_counts'));
	// output(ds_iastx_counts,                  named('ds_iastx_counts'));
	// output(ds_irs5500_counts,                named('ds_irs5500_counts'));
	// output(ds_irs990_counts,                 named('ds_irs990_counts'));
	// output(ds_mswork_counts,                 named('ds_mswork_counts'));
	// output(ds_ndr_counts,                 		named('ds_ndr_counts'));
	// output(ds_oig_counts,                    named('ds_oig_counts'));
	// output(ds_orwork_counts,                 named('ds_orwork_counts'));
  // output(ds_oshair_keyrecs,                named('ds_oshair_keyrecs'));
  // output(ds_oshair_keyrecs_dd,             named('ds_oshair_keyrecs_dd'));
	// output(ds_oshair_keyrecs_dd_tabled,      named('ds_oshair_keyrecs_dd_tabled'));
	// output(ds_oshair_counts,                 named('ds_oshair_counts'));
  // output(ds_prolic_keyrecs,                named('ds_prolic_keyrecs'));
  // output(ds_prolic_keyrecs_dd,             named('ds_prolic_keyrecs_dd'));
	// output(ds_prolic_keyrecs_dd_tabled,      named('ds_prolic_keyrecs_dd_tabled'));
	// output(ds_prolic_counts,                 named('ds_prolic_counts'));
	// output(ds_secbd_counts,                 	named('ds_secbd_counts'));
	// output(ds_txbus_counts,                  named('ds_txbus_counts'));
	// output(ds_wkcomp_counts,                  named('ds_wkcomp_counts'));

  // output(ds_all_ga_counts,                 named('ds_all_ga_counts'));
 
	return ds_all_ga_counts;

 end; // end of fn_count_govagency

END; // end of module

/*  to test, in a builder window use this: 
// v--- Needed for testing any section:  
IMPORT AutoStandardI;

//v--- for use with Todd's macro???
#STORED('DPPAPurpose',1);
#STORED('GLBPurpose',1);  // 2= shows minors
#STORED('DataRestrictionMask','00000000000000000000'); // pos 3 = ebr, set to non-blank (0 or 1) to include ebr data
//#STORED('DataRestrictionMask','')
#STORED('LnBranded',true);

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

  // Input options for all report sections (except UCCs, see UCC section testing info)
	// Just 2 booleans & 1 char for now: lnbranded , internal_testing and busrpt_fetch_level
  ds_options := dataset([{false, false, 'S'} //3rd parm=BusinessReportFetchLevel, default='S'=seleid
                        ],topbusiness_services.Layouts.rec_input_options);
// ^--- Needed for testing any section:  

// input dataset for all sections, layout = topbusiness_services.Layouts.rec_input_ids = 
//         acctno,DotID,EmpID,POWID,ProxID,SeleID,OrgID,UltID

// To test the Source section: 

source_sec := TopBusiness_Services.SourceSection.fn_FullView(
             dataset([
										  //{'test27ap', 0, 0, 0, 0, 93, 93, 93} // 4 irs5500 docs
										  //{'test28ap', 0, 0, 0, 0, 273, 273, 273} // 3 irs990 docs
										  //{'test28bp', 0, 0, 0, 0, 135, 135, 135} // 4 irs5500 docs + 25 irs990 docs
										  //{'test29p', 0, 0, 0, 0, 456, 456, 456} // 4 ca sales tax docs
                      //{'test30p', 0, 0, 0, 0, 9301, 9301, 9301} // 46 fdic docs
                      //{'test31p', 0, 0, 0, 0, 770, 770, 770} // 1 txbus doc
                      //{'test37p214', 0, 0, 0, 0, 30463, 30463, 30463} // no bug/chg to use src li keys-test case 2.14 atf; 3 li key recs/2 src  docs counted/retd                      //{'test37p219a', 0, 0, 0, 0, 295, 295, 295} // no bug/chg to use src li keys-test case 2.19a dea; 2 li key recs/2 dea-reg#s/src docs counted&retd
                      //{'test37p219b', 0, 0, 0, 0, 2036, 2036, 2036} // no bug/chg to use src li keys-test case 2.19b dea; 3 li key recs/1 dea-reg#s/src docs counted&retd
                      //{'test37p220', 0, 0, 0, 0, 1041, 1041, 1041} // no bug/chg to use src li keys-test case 2.20 fcc; 2 li key recs/2 fcc-seqs/src docs counted&retd
                      //{'test37p221', 0, 0, 0, 0, 165, 165, 165} // no bug/chg to use src li keys-test case 2.21 pl; 5 li key recs/5 prolic-seq-ids/src docs counted&retd
                      //{'test37p222', 0, 0, 0, 0, 537, 537, 537} // no bug/chg to use src li keys-test case 2.22 oshair; 5 li key recs/5 act_nums/src docs counted&retd
                      //{'test37p227v1', 0, 0, 0, 0, 456, 456, 456} // no bug/chg to use src li keys-test case 2.27 casalestax; 4 li key recs/4 src  docs counted/retd
                      //{'test37p228v1', 0, 0, 0, 0, 6291, 6291, 6291} // no bug/chg to use src li keys-test case 2.28 fdic; 4 li key recs/1 src  docs counted/retd
                      //{'test62calbus1', 0, 0, 0, 0, 66, 66, 66} // bug 156809 add Calbus; 2 li key recs/1 src  doc counted/retd
                      //{'test62calbus2', 0, 0, 0, 0, 281, 281, 281} // bug 156809 add Calbus; 10 li key recs/9 src  docs counted/retd
                      //{'test66orwork1', 0, 0, 0, 0, 110968, 110968, 110968} // bug 156815 add ORWORK; 2 li key recs/1 src  docs counted/retd
                      //{'test66orwork2', 0, 0, 0, 0, 1263667, 1263667, 1263667} // bug 156815 add ORWORK; 6 li key recs/1 src  docs counted/retd
                      //{'test67txbus1', 0, 0, 0, 0, 256, 256, 256} // bug 169439 chg to use txbussource_records; 2 li key recs/1 src  docs counted/retd
                      //{'test67txbus2', 0, 0, 0, 0, 1702, 1702, 1702} // bug 160439 chg to use txbussource_records; 17 li key recs/4 src  docs counted/retd
                      //{'test68oig1', 0, 0, 0, 0, 324658, 324658, 324658} // bug 156775 add OIG; 7 li key recs/1 src  docs counted/retd
                      //{'test68oig2', 0, 0, 0, 0, 2080621, 2080621, 2080621} // bug 156775 add OIG; 7 li key recs/2 src  docs counted/retd
											//{'test81atfp1', 0, 0, 0, 0, 3471, 3471, 3471} // no bug/chg to use new ga attr - atf 4 li key recs/3 source docs
											//{'test81govagy2p1', 0, 0, 0, 0, 2218, 2218, 2218} // no bug/chg to use new ga attr - calbus 1 li key recs/1 source docs & casalestax 1 li key recs/1 source docs 

											//{'testiastx1', 0, 0, 0, 0, 7842, 7842, 7842}, // bug 156760 to add src for IASTX; 3 li key recs/3 src docs counted/retd
											//{'testiastx2', 0, 0, 0, 0, 20454, 20454, 20454}, // bug 156760 to add src for IASTX; 2 li key recs/2 src docs counted/retd
											//{'testMSWork1', 0, 0, 0, 0, 34196, 34196, 34196}, // bug 156765 to add src for MSWork; 5 li key recs/3 src docs counted/retd
											//{'testMSWork2', 0, 0, 0, 0, 38970, 38970, 38970}, // bug 156765 to add src for MSWork; 5 li key recs/2 src docs counted/retd
											//{'testWorkComp1', 0, 0, 0, 0, 2578, 2578, 2578}, // bug 156641 to add src for WorkComp; 53 li key recs/20 src docs counted/retd
											//{'testWorkComp2', 0, 0, 0, 0, 8, 8, 8}, // bug 156641 to add src for WorkComp; 4 li key recs/2 src docs counted/retd
											//{'testWorkComp3', 0, 0, 0, 0, 7842, 7842, 7842}, // bug 156641 to add src for WorkComp; 117 li key recs/15 src docs counted/retd
											//{'testINSCert1', 0, 0, 0, 0, 456, 456, 456}, // bug 156763 to add src for WorkComp; 10 li key recs/10 src docs counted/retd
											//{'testINSCert2', 0, 0, 0, 0, 1371, 1371, 1371}, // bug 156763 to add src for WorkComp; 6 li key recs/6 src docs counted/retd
											// {'testFLNonPt1', 0, 0, 0, 0, 139350318, 139350318, 139350318}, // bug 156751 to add src for FLNonPt; 3 li key recs/1 src docs counted/retd
											// {'testFLNonPt2', 0, 0, 0, 0, 691264803, 691264803, 691264803}, // bug 156751 to add src for FLNonPt; 4 li key recs/1 src docs counted/retd
											// {'testEdgar1', 0, 0, 0, 0, 7779884, 7779884, 7779884}, // bug 156810 to add src for Edgar; 1 li key recs/1 src docs counted/retd
											// {'testEdgar2', 0, 0, 0, 0, 140199014, 140199014, 140199014}, // bug 156810 to add src for Edgar; 2 li key recs/1 src docs counted/retd
											// {'testEdgar3', 0, 0, 0, 0, 508865301, 508865301, 508865301}, // bug 156810 to add src for Edgar; 1 li key recs/1 src docs counted/retd
											// {'testNDR1', 0, 0, 0, 0, 1501227503, 1501227503, 1501227503}, // bug 156897 to add src for NDR; 6 li key recs/1 src docs counted/retd
											// {'testNDR2', 0, 0, 0, 0, 4983617, 4983617, 4983617}, // bug 156897 to add src for NDR; 2 li key recs/1 src docs counted/retd
											// {'testSecBD1', 0, 0, 0, 0, 29290, 29290, 29290}, // bug 156898 to add src for Sec Broker/Dealer; 42 li key recs/1 src docs counted/retd
											// {'testSecBD2', 0, 0, 0, 0, 33850, 33850, 33850}, // bug 156898 to add src for Sec Broker/Dealer; 60 li key recs/3 src docs counted/retd
											// {'testSecBD3', 0, 0, 0, 0, 26037, 26037, 26037}, // bug 156898 to add src for Sec Broker/Dealer; 24 li key recs/3 src docs counted/retd
											// {'testGSA2', 0, 0, 0, 0, 362612, 362612, 362612}, // bug 156755 to add src for General Service Administration; 47 li key recs/47 src docs counted/retd
											// {'testGSA3', 0, 0, 0, 0, 374627, 374627, 374627}, // bug 156755 to add src for General Service Administration; 24 li key recs/24 src docs counted/retd
											// {'testGSA8', 0, 0, 0, 0, 847000, 847000, 847000} // bug 156755 to add src for General Service Administration; 24 li key recs/24 src docs counted/retd

                  ],topbusiness_services.Layouts.rec_input_ids)
						,ds_options[1]
					  ,tempmod
            );

output(source_sec);
// */
