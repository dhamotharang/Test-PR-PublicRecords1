/* Status as of 10/20/2015, coding is DONE to count source docs for these categories & sources: 
       (NOTE: Category numbers below match BIP report requirement BIZ2.0-1430)
       1. LNCA (fka DCA)
       2. EBR
       3. N/A (this BIZ2.0-1430 requirement category# intentionally removed)
       4. Real Property (Tax/Deed/Mortgage, Foreclosure & NoticeOfDefault) 
       5. Personal Property (Aircraft, MVR/Vehicles & Watercraft)
       6. Corporations (corp only even though BusReg data is included in the Incorporation Section)
       7. Bankruptcy
       8. N/A (this BIZ2.0-1430 requirement category# intentionally removed)
       9. Liens & Judgments
      10. UCCs
      11. Government Agencies - ATF, CALBUS, CA sales tax, DEA, Edgar, FCC, FDIC, FL Non profit, 
                                GSA, IA sales tax, Insurance Certification, IRS5500(retirement), 
                                IRS990(nonprofit), MS Workers Comp, Natural Disaster Readiness, 
                                OIG, OR Workers Comp, OSHAIR, Prof Lics, SEC Broker/Dealer, 
                                TXBUS & Workers Compensation
      12. Other Directories - ABIUS(aka UsaBiz from InfoUSA), ACF, AMIDIR, AMS, BBB(mbr&nonmbr),
                              BusRegs, CNLD_Facilites, Credit Unions, DEADCO(from InfoUSA), 
                              D&B_Fein, Diversity Cert, FBNs, LaborActions_WHD, Martindale-Hubbell,
                              NCPDP, Redbooks, Sheila Greco, SDA, SDAA, SKA, Spoke & Utilites
      13. Telco - Gong & YellowPages
      14. Experian FEIN (new category/source added 02/07/14 and included in the 02/25/14 RR)
      15. Experian CRDB (new category/source added 02/07/14 and included in the 02/25/14 RR)
      16. US DOT SAFER Census Data (aka Crash Carrier) - added 04/20/2015.  
      17. TBD: Business Exchange (aka Commercial CLUE), as of 12/11/14 Giri built data in prod,
               but for data fab ingest only.  Data build process not production-ized yet.
      18. Franchise Directory (Added category for bug #146986 rcvd from Tom Reed on 02/21/14.)
          
TBD:
   1. Add coding: to use appropriate TopBusiness_Services.***Source_Records (vers1)            
               OR to use individual source ***.key_linkids.kfetch, (vers2b)
               OR to use (new as of 07/28/14) TopBusiness_Services.Key_Fetches attr, (vers3)
               OR to use Industry/Contact key for multiple sources and filter to     (vers4?)
                     only keep certain sources not already counted and then sort/dedup 
                     depending upon source fields/data content/unique id.
               Then sort/dedup/count to match # docs returned by the SourceService.
      for these categories/sources: see below

      As of 10/20/15, still need to decide how to handle or add coding for these sources:
      (these sources are not directly fetched in any other section of the report, but some
      are included on the BIPV2 bus hdr, Contacts or Industry linkids keys, 
      which in turn are used in various other report sections.  Whereas other sources are not 
      included any any BIP linkids keys and are not included in any section of the report.
      v--- Category     - Key -v      - Sources ---v
      11. Govt Agencies - not any key - FDIC SOD (Annual) 
                                        Mari-prof license, 
                                        Mari-public sanctions

      12. Other Dirs    - not any key - ABMS(TBD?),
                                        Bankruptcy Attorneys (& Trustees),
                                        CLIA, 
                                        Debt Settlement, 
                                        NPPES, 
                                        Vickers

      Sources not to be used - Should match the "Source Not In Consideration" tab/worksheet in
                               the "BIP Source Files v8.xlsx" created/updated by Tom Reed and 
                               stored on the Business Integration Project - BIP2.0 project 
                               sharepoint site here (https://teamsites.rs.lexisnexis.net/sites/
                                          engprjmgmt/Business_Integration_Project_2/default.aspx) 
                               under the "BIP header Sources" folder.
                               Those sources are:
                               ACA, Accurint Trade Show, AK business registration, 
                               Business healthcare sanctions from Ingenix, Civil Court, 
                               CNLD Practitioners, Domain registrations/Whois, 
                               D&B DMI (It is on the BH for linking, but we are not to
                                        return the data in the rpt)
                               Email(multi source codes), Employee Directories, Garnishments,
                               IdExec(from InfoUSA), Jigsaw, LaborActions EBSA, Labor Actions MSHA, 
                               Liquor Licenses(7 states-CA,CT,IN,LA,OH,PA&TX), Lobbyists, 
                               Mari non-public sanctions, NJ Gaming Licenses, Official Records, 
                               One Click data, PAW(People at work, internally derived data), 
                               PhonesFeedback, PhonePlus, POEsFromEmails, POEsFromUtilities, 
                               SalesChannel, Taxpro, Teletrack, Thrive, 
                               Zoom(Note: The Zoom data will eventually be on the BH to be used 
                                          for linking, but as of 02/15/15 it has not been ingested
                                          on BH yet. However the data is not to be returned in the
                                          report per Tom Reed & Tim Bernhard.)

   2. Add 2 new categories/sources (as of 11/20+/13 emails from Tom Reed) for:
       17. Business Exchange (aka Commercial CLUE) -
           as of 10/23/14, per Julie E, the data is now in-house and being built by Giri
           as of 12/11/14, Giri created the initial cclue linkds key on prod thor, but just for
              inclusion in the data fab ingest file (linking team is not ingesting it yet)
           as of 02/12/15, will also need a new CommClue(?)Source_Records attribute created, 
            so can use the "Count" feature OR 
            use the vers2b/vers3 approach of getting recs from the linkids key, but that will  
            require the linkids key to be added to DOPs in a new *DatasetName (which Giri should do).

   3. Pass in "Include*" options from "Guts" to know what category/source counts to return??? 
   4. Research/resolve open issues, search on "???"

   Background info:
   11/05/2012, BIP2 initial version to get recs from individual sources linkids keys then 
      sort/dedup and count them. 
   04/03/2013, major design change.  Instead of fetching records from each individual source
      linkids key, it was decided to call the appropriate exported "SourceView_RecCount" from 
      each of the new BIP2 TopBusiness_Services.***Source_Records attributes.
   This will work for category numbers (see req 1430): 
        1. LNCA
        2. EBR
        4. Real Property
        5. Personal Property (Aircraft, MVR, Watercraft)
        6. Corporate Filings
        7. Bankruptcy
        9. Judgments & Liens
       10. UCCs
   For other categories: 
       11. Government Agencies
       12. Other directories
       13. Telco
   we will have to accumulate source doc info from multiple datasets in various ***Source_Records.

   NOTE: Category #3(DNB DMI) has been removed (we are not supposed to return DNB data) and 
         Category #8(Default Notice/Foreclosure) has been combined into category 4(Real Property) 


   ************** 
   05/20/2014, Second major change (version 2b), due to report timing out at times in the 
               Source Section.
      Made change to get counts for certain sources by fetching recs from the individual source 
      linkids keys, then sort/dedup as needed and then table the deduped recs to count them.  
      Which should then match the number of source docs for a certain source returned by the 
      TopBusiness_Services.SourceService.
      This needs done for at least the sources that use old/existing "raw" attribute to format 
      the source docs and/or return a lot of data on the source doc.  (i.e. EBR, Corp, etc.)
      This approach might not need done for sources that have their own ***Source_Records attribute,
      but don't use an old/existing "raw" attribute or that only have a small amount of data on 
      the source doc. (i.e. FDIC, BBB, etc.) 
   
   Due to the potentially large volume of coding changes, the revisions will be done in phases.

   Phase 1:
   Revised in the 05/20/14 RR: LNCA, EBR, Pers Prop(Aircraft, MVR, Watercraft), Corp, 
                               Bankrutpcy, Liens, UCC, Frandx,
   Phase 2:
   Revised in the 06/03/14 RR: Real Property(T/D/M),
                               Gov Agency(ATF, DEA, FCC, OSHAIR, Prof Lics),
                               Oth Dir(BusReg, DnB_Fein, FBN, Sheila Greco), 
                               Telco(Gong & YellowPages), 
                               Experian FEIN, 
                               Experian CRDB
   Phase 3:
   Added in the 06/17/14 RR: Other Dir(AMS)

   TBD?: Other Directories - Credit Unions(li key on prod thor, but not in in dops yet. 
                                           will be in in dops in ??/?? RR???. (see Giri)   
                                           li key out of sync/needs re-adled 05/19?)

         Foreclosure & NOD (Need to still use ForeclosureNODSource_Records due to how coding
                           within Foreclosure_Services.raw.REPORT_VIEW.by_fid handles 
                           all the raw data recs for 1 foreclosure_id)
                           (for a FC example, see ult/org/sele ids=15159)
                           (for a NOD example, see ult/org/sele ids=1643)
end of version 2b comments
*/
IMPORT AutoStandardI, BIPV2, iesp, MDR, TopBusiness_Services, Doxie;

EXPORT SourceSection := MODULE

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
   dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids
	 ,TopBusiness_Services.Layouts.rec_input_options in_options 
	 ,Doxie.IDataAccess mod_access
	 ,dataset(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_bh_keyrecs
                   ):= function 
									   		 
  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_ids_woacctno    := project(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left,
																							           self := []));

  // Project input ids into layout needed by all the ***Source_Records modules.
	// combine with project above???
  ds_in_ids_srcrecs_inlayout := project(ds_in_ids_woacctno,
																		    transform(TopBusiness_Services.Layouts.rec_input_ids_wSrc,
																					self := left; //to assign all linkids
		  																    self := [];   //to null all other fields
																	      ));

	// Create 1 row in the "input options" layout needed by all the ***Source_Records modules.
	TopBusiness_Services.SourceService_Layouts.OptionsLayout tf_options() := TRANSFORM
		self.app_type  := AutoStandardI.GlobalModule().ApplicationType;
		self.ssn_mask  := AutoStandardI.GlobalModule().ssnmask;
	 // v--- Addded 02/12/14 due to Keith's SourceService enhancement
   self.fetch_level := in_options.BusinessReportFetchLevel;
   self.IncludeVendorSourceB := in_options.IncludeVendorSourceB;
   self.IncludeAssignmentsAndReleases := in_options.IncludeAssignmentsAndReleases;
	end;
	
	rs_options := row(tf_options());

  FETCH_LEVEL := in_options.BusinessReportFetchLevel;


  // ********** Get record counts for each category of source(s) to be returned in this section.  
	//  (See BIP Business Report 2.0 requirements BIZ2.0-1420 thru 1460 for more info.)

/* */
  // ********** Get LNCA (FKA DCA/DCAV2) record counts  - category 1
  // *** Key fetch to get linkids key data.
  ds_lnca_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
								                                      FETCH_LEVEL,
																											TopBusiness_Services.Constants.defaultJoinLimit
																											).ds_dca_linkidskey_recs;
 
  ds_lnca_keyrecs_dd := dedup(sort(ds_lnca_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   rawfields.enterprise_num),
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              rawfields.enterprise_num);

  // table to count # of recs (enterprise nums) per group (set of linkids)
	ds_lnca_keyrecs_dd_tabled := table(ds_lnca_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_lnca_count(recordof(ds_lnca_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.LncaCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := '';                      //section name not needed, 
				self.Source            := MDR.sourceTools.src_DCA; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_lnca_counts := project(ds_lnca_keyrecs_dd_tabled,tf_lnca_count(left));

  // ********** Get Experian Business Reports record counts  - category 2
  // *** Key fetch to get linkids key data.
  ds_ebr_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
								                                     FETCH_LEVEL,
																										 TopBusiness_Services.Constants.defaultJoinLimit
																										 ).ds_ebr0010_linkidskey_recs;
 
  ds_ebr_keyrecs_dd := dedup(sort(ds_ebr_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   file_number),  //??? and/or record_type OR source_rec_id??? 
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              file_number); //???

  // table to count # of recs (file numbers?) per group (set of linkids)
	ds_ebr_keyrecs_dd_tabled := table(ds_ebr_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_ebr_count(recordof(ds_ebr_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.EbrCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := '';                      //section name not needed, 
				self.Source            := MDR.sourceTools.src_EBR; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_ebr_counts := project(ds_ebr_keyrecs_dd_tabled,tf_ebr_count(left));


  // ********** Get Real Property (Tax/Deed/Mortgage/Foreclosure/NOD) record counts  - category 4
	//
	// ***** Get "Property"(tax/deed/mortgage) counts
  // *** Key fetch to get linkids key data.
	ds_prop_keyrecs := TopBusiness_Services.Key_Fetches(
	                                        ds_in_ids_woacctno, // input ids to join key with
                                          FETCH_LEVEL,
										                      TopBusiness_Services.Constants.PropertyKfetchMaxLimit
												                             ).ds_prop_linkidskey_recs;
  
  ds_prop_keyrecs_dd := dedup(sort(ds_prop_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   ln_fares_id), 
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              ln_fares_id);

  // table to count # of recs (ln_fares_ids) per group (set of linkids)
	ds_prop_keyrecs_dd_tabled := table(ds_prop_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_prop_count(recordof(ds_prop_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.RealPropCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_LnPropV2_Fares_Asrs; // but need source code
				// multiple property source codes exist, just picked one ---^
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_prop_counts := project(ds_prop_keyrecs_dd_tabled,tf_prop_count(left));

	// ***** Get Foreclosure counts
  // vers1. Can't be converted to version2b, gives wrong counts.  See comments at the top.
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_forec_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.RealPropCategoryName,
	      self.category_doccount := TopBusiness_Services.ForeclosureNODSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
           rs_options,false,false).SourceView_RecCount;
			  //Note: 4th parm ---^ tells ForeclosureNODSource_Records we do not want "NOD" counts.
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_Foreclosures; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_forec_counts := project(ds_in_ids_srcrecs_inlayout,tf_forec_count(left));

 	// ***** Get Notice of Default (NOD) counts
  // vers1. Can't be converted to version2b, gives wrong counts.  See comments at the top.
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_nod_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.RealPropCategoryName,
	      self.category_doccount := TopBusiness_Services.ForeclosureNODSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
           rs_options,false,true).SourceView_RecCount; 
			  //Note: 4th parm ---^ tells ForeclosureNODSource_Records we want "NOD" counts.
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_Foreclosures_Delinquent; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_nod_counts := project(ds_in_ids_srcrecs_inlayout,tf_nod_count(left));


  // ******* Get Personal Property (Aircraft/MVRs/Watercraft) record counts  - category 5
	//
	// ***** Get Aircraft counts
  // *** Key fetch to get linkids key data.
	ds_airc_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
								                                      FETCH_LEVEL).ds_airc_linkidskey_recs;
  
  ds_airc_keyrecs_dd := dedup(sort(ds_airc_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   n_number), 
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              n_number);

  // table to count # of recs (aircraft n_numbers?) per group (set of linkids)
	ds_airc_keyrecs_dd_tabled := table(ds_airc_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_airc_count(recordof(ds_airc_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.PersPropCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := TopBusiness_Services.Constants.AircraftSectionName;
				self.Source            := ''; //since source=section, source_code not needed here
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_airc_counts := project(ds_airc_keyrecs_dd_tabled,tf_airc_count(left));

	// ***** Get MVR/Vehicle counts
	// TopBusiness_Services.MotorVehicleSource_Records is called here to make use of 
	// VehicleV2_Services.Vehicle_raw.get_vehicle_crs_report_by_Veh_key() so the source
	// count here will be the same as the source count in Source Docs.
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_mvr_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.PersPropCategoryName,
	      self.category_doccount := TopBusiness_Services.MotorVehicleSource_Records(
			     //create dataset with 1 rec in the layout input to all ***Source_Records
					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
           rs_options,false).SourceView_RecCount;
				self.Section           := TopBusiness_Services.Constants.MVRSectionName;
				self.Source            := ''; 
				self                   := l; 
		 end;
	
	ds_mvr_counts := project(ds_in_ids_srcrecs_inlayout,tf_mvr_count(left));

	// ***** Get Watercraft counts
  // *** Key fetch to get linkids key data.
	ds_waterc_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
                                                        FETCH_LEVEL).ds_wc_linkidskey_recs;
																					 
  ds_waterc_keyrecs_dd := dedup(sort(ds_waterc_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
																	 Watercraft_Key,
																	 Sequence_Key,
																	 State_Origin 
																	 ), 
	     			                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
														 Watercraft_Key,
														 Sequence_Key,   
													   State_Origin 
														);

  // table to count # of recs (watercraft_key/sequence_key/state_origin) per group (set of linkids)
	ds_waterc_keyrecs_dd_tabled := table(ds_waterc_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_waterc_count(recordof(ds_waterc_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.PersPropCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := TopBusiness_Services.Constants.WatercraftSectionName;
				self.Source            := ''; //since source=section, source_code not needed here
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_waterc_counts := project(ds_waterc_keyrecs_dd_tabled,tf_waterc_count(left));


  // ********** Get Corporations record counts  - category 6
  // *** Key fetch to get linkids key data.
   ds_corp_keyrecs :=  TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input file to join key with
										                                    FETCH_LEVEL,
																												TopBusiness_Services.Constants.defaultJoinLimit
										                                   ).ds_corp_linkidskey_recs;
  
  ds_corp_keyrecs_dd := dedup(sort(ds_corp_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   corp_key),
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              corp_key);

  // table to count # of recs (corp_keys) per group (set of linkids)
	ds_corp_keyrecs_dd_tabled := table(ds_corp_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_corp_count(recordof(ds_corp_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.CorpCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := '';                                  //section name not needed, 
				self.Source            := MDR.sourceTools.src_AK_Corporations; // need any corp source code, just picked first 1??? 
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_corp_counts := project(ds_corp_keyrecs_dd_tabled,tf_corp_count(left));


  // ********** Get Bankruptcy record counts  - category 7
  // *** Key fetch to get linkids key data.
  ds_bankr_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
													                             FETCH_LEVEL,
																	                     TopBusiness_Services.Constants.defaultJoinLimit
																	                    ).ds_bankr_linkidskey_recs
                                   // v--- For BIP2, we only want debtor recs, not recs where
																	 //      the reported on company is an attorney.
																	 // So filter to only include debtor recs.
										               // Like done in the Bankruptcy Section coding.
																	 (name_type = TopBusiness_Services.Constants.DEBTOR);
 
  ds_bankr_keyrecs_dd := dedup(sort(ds_bankr_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   tmsid),
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              tmsid);

  // table to count # of recs (tmsids) per group (set of linkids)
	ds_bankr_keyrecs_dd_tabled := table(ds_bankr_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_bankr_count(recordof(ds_bankr_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.BankrCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := '';                             // section name not needed, 
				self.Source            := MDR.sourceTools.src_Bankruptcy; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_bankr_counts := project(ds_bankr_keyrecs_dd_tabled,tf_bankr_count(left));
 

  // ********** Get Judgments & Liens record counts  - category 9
  // *** Key fetch to get linkids key data.
	ds_liens_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno,
													                             FETCH_LEVEL,
																											 TopBusiness_Services.Constants.defaultJoinLimit
																											).ds_liens_linkidskey_recs;

  ds_liens_keyrecs_dd := dedup(sort(ds_liens_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   tmsid),
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              tmsid);

  // table to count # of recs (tmsids) per group (set of linkids)
	ds_liens_keyrecs_dd_tabled := table(ds_liens_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_liens_count(recordof(ds_liens_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.LiensCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := TopBusiness_Services.Constants.LienSectionName;
				self.Source            := ''; //since source=section, source_code not needed here
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_liens_counts := project(ds_liens_keyrecs_dd_tabled,tf_liens_count(left));


  // ********** Get UCC record counts  - category 10
  // *** Key fetch to get linkids key data.
	ds_ucc_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno,
													                           FETCH_LEVEL, 
																                     TopBusiness_Services.Constants.UCCKfetchMaxLimit
																										).ds_ucc_linkidskey_recs;

  ds_ucc_keyrecs_dd := dedup(sort(ds_ucc_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   tmsid),
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              tmsid);

  // table to count # of recs (tmsids) per group (set of linkids)
	ds_ucc_keyrecs_dd_tabled := table(ds_ucc_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_ucc_count(recordof(ds_ucc_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.UccCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := TopBusiness_Services.Constants.UccSectionName;
				self.Source            := ''; //since source=section, source_code not needed here
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_ucc_counts := project(ds_ucc_keyrecs_dd_tabled,tf_ucc_count(left));


	// As of 01/12/15, changed to split out Gov Agency category and Other Dirs category source 
	// counting coding into 2 new attributes.  Then call those attributes from here.
	
  // ********** Get Government Agencies record counts  - category 11
	//
  ds_govagy_counts := TopBusiness_Services.SourceSection_GovAgency.fn_count_govagency(
		 ds_in_ids_woacctno,
		 ds_in_ids_srcrecs_inlayout,
		 rs_options,
		 ds_bh_keyrecs,
     mod_access
    );

  
  // ********** Get "Other Directories" record counts  - category 12
  ds_othdir_counts := TopBusiness_Services.SourceSection_OtherDirs.fn_count_otherdirs(
		 ds_in_ids_woacctno,
		 ds_in_ids_srcrecs_inlayout,		 
		 rs_options,
		 ds_bh_keyrecs,
		 mod_access
    );


  // ********** Get Telco record counts  - category 13
	// ***** Get counts from individual sources: Gong & YellowPages

	// ***** Get Gong counts
  // *** Key fetch to get linkids key data.
  ds_gong_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
													                            FETCH_LEVEL // level of ids to join with
																										 ).ds_gong_linkidskey_recs;
 
  ds_gong_keyrecs_dd := dedup(sort(ds_gong_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	 // To match coding in TopBusiness_Services.GongSource_Records
																	 listed_name, 
																	 phone10,
                                   listing_type_bus,
																	 listing_type_res,
																	 listing_type_gov,
																	 prim_range, predir, prim_name, suffix, postdir,
																	 unit_desig, sec_range, v_city_name, st, z5, z4
																	),
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															listed_name,
															phone10,
                              listing_type_bus, 
															listing_type_res, 
															listing_type_gov, 
															prim_range, predir, prim_name, suffix, postdir,
															unit_desig, sec_range, v_city_name, st, z5, z4
															);

  // table to count # of recs (norm_taxids) per group (set of linkids)
	ds_gong_keyrecs_dd_tabled := table(ds_gong_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_gong_count(recordof(ds_gong_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.TelecoCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_Gong_Business; // but need 1 of the gong source codes
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_gong_counts := project(ds_gong_keyrecs_dd_tabled,tf_gong_count(left));

	// ***** Get YellowPages counts
  // *** Key fetch to get linkids key data.
  ds_yp_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
													                            FETCH_LEVEL // level of ids to join with
																									 ).ds_yp_linkidskey_recs;
 
  ds_yp_keyrecs_dd := sort(ds_yp_keyrecs,
   			                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids())	
													 );

  // table to count # of recs (norm_taxids) per group (set of linkids)
	ds_yp_keyrecs_dd_tabled := table(ds_yp_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_yp_count(recordof(ds_yp_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.TelecoCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name not needed
				self.Source            := MDR.sourceTools.src_Yellow_Pages; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_yp_counts := project(ds_yp_keyrecs_dd_tabled,tf_yp_count(left));


  // ********** Get Experian FEIN record counts - category 14
  // *** Key fetch to get linkids key data.
  ds_expfein_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
													                               FETCH_LEVEL // level of ids to join with
																									       ).ds_expfein_linkidskey_recs;
 
  ds_expfein_keyrecs_dd := dedup(sort(ds_expfein_keyrecs,
		     			                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                      norm_tax_id),
	     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                 norm_tax_id);

  // table to count # of recs (norm_taxids) per group (set of linkids)
	ds_expfein_keyrecs_dd_tabled := table(ds_expfein_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_expfein_count(recordof(ds_expfein_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.ExperianFeinCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name N/A
        // Need source code, but 2 values exist, E5 & E6. Use E5 the more restrictive one
				self.Source            := MDR.sourceTools.src_Experian_FEIN_Rest;
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_expfein_counts := project(ds_expfein_keyrecs_dd_tabled,tf_expfein_count(left));


  // ********** Get Experian Credit Risk DB (Experian CRDB) record counts - category 15
  // *** Key fetch to get linkids key data.
  ds_expcrdb_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
													                               FETCH_LEVEL // level of ids to join with
																									       ).ds_expcrdb_linkidskey_recs;
 
  ds_expcrdb_keyrecs_dd := dedup(sort(ds_expcrdb_keyrecs,
		     			                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                      experian_bus_id),
	     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                 experian_bus_id);

  // table to count # of recs (norm_taxids) per group (set of linkids)
	ds_expcrdb_keyrecs_dd_tabled := table(ds_expcrdb_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_expcrdb_count(recordof(ds_expcrdb_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.ExperianCRDBCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_Experian_CRDB;
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_expcrdb_counts := project(ds_expcrdb_keyrecs_dd_tabled,tf_expcrdb_count(left));


  // ********** Get US DOT SAFER Census Data (aka CrashCarrier) record counts - category 16
  // vers1 used instead of vers2b since a small amount of data
	//       vers2b could be used since the CrashCarrier linkids key has been added to DOPS, 
	//              but a small amount of data so should use vers1
  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_crashcar_count(TopBusiness_Services.Layouts.rec_input_ids_wSrc l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.SaferCensusCategoryName, 
	      self.category_doccount := TopBusiness_Services.CrashCarrierSource_Records(
			  //create dataset with 1 rec in the layout input to all ***Source_Records
					 dataset([l],TopBusiness_Services.Layouts.rec_input_ids_wSrc),
           rs_options,false).SourceView_RecCount;
				self.Section           := ''; //section name N/A
				self.Source            := MDR.sourceTools.src_CrashCarrier; // but need source code
				self                   := l; // to assign all linkids
		 end;
	
  ds_crashcar_counts := project(ds_in_ids_srcrecs_inlayout,tf_crashcar_count(left));


  //********** Get Business Exchange (aka Commerical CLUE) record counts - category 17
  // TBD/future addition, once:
	//    1. data fab work is done (Giri is in process as of 10/22/14) and  
  //       linkids key is built (not planning on it per Julie E, but Dave Wright requested
	//       via email on 10/23/14) in prod and Giri built it in prod on 12/11/14, but only 
	//       to be included in the next data fab BH ingest file???
	//    2. linkids key added to DOPS and/or new CC data is ingested into the BH(???)
	//    3. CommClueSource_Records will need to be created???
  // v---- vers1???
	//       vers2b could be used since the Commercial Clue linkids key has been added to 
	//              DOPS&copied to the cert oss roxie(130), 
	//              but small amount of data(?) so should use vers1???
  // SourceSection_Layouts.rec_SourceCount 
	   // tf_commclue_count(Layouts.rec_input_ids_wSrc l) :=transform
        // self.category_desc     := TopBusiness_Services.Constants.BusinessExchange???CategoryName, 
	      // self.category_doccount := CommClueSource_Records(
			  // //create dataset with 1 rec in the layout input to all ***Source_Records
					 // dataset([l],Layouts.rec_input_ids_wSrc),
           // rs_options,false).SourceView_RecCount;
				// self.Section           := ''; //section name N/A
				// self.Source            := MDR.sourceTools.src_CClue; // but need source code
				// self                   := l; // to assign all linkids
		 // end;
	
  // ds_commclue_counts := project(ds_in_ids_srcrecs_inlayout,tf_commclue_count(left));
  

  // ********** Get Franchise Directory (aka Frandx) record counts - category 18
	//      (new as of 02/21/14 for bug 146986)
  // *** Key fetch to get linkids key data.
  ds_fran_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_woacctno, // input ids to join key with
													                               FETCH_LEVEL // level of ids to join with
																									       ).ds_frandx_linkidskey_recs;
 
  ds_fran_keyrecs_dd := dedup(sort(ds_fran_keyrecs,
		     			                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                                   franchisee_id),  //??? and/or source_rec_id??? 
	     			                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
                              franchisee_id); //???

  // table to count # of recs (fran_keys?) per group (set of linkids)
	ds_fran_keyrecs_dd_tabled := table(ds_fran_keyrecs_dd,
	                                   // v--- Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                recs_count := count(group)
																		 },
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),few);

  TopBusiness_Services.SourceSection_Layouts.rec_SourceCount 
	   tf_fran_count(recordof(ds_fran_keyrecs_dd_tabled) l) :=transform
        self.category_desc     := TopBusiness_Services.Constants.FranchiseDirCategoryName,
	      self.category_doccount := l.recs_count;
				self.Section           := '';                         //section name not needed, 
				self.Source            := MDR.sourceTools.src_Frandx; // but need source code
				self                   := l;  // to assign top3 linkids
			  self                   := []; // to null unused linkids
		 end;

  ds_fran_counts := project(ds_fran_keyrecs_dd_tabled,tf_fran_count(left));
// */

  // Concatenate counts info from all categories/sources
	ds_all_counts := 
                   ds_lnca_counts      +
							     ds_ebr_counts       +

									 //real property sources ---v
							       ds_prop_counts    +
								     ds_forec_counts   +
									   ds_nod_counts     +

									 //personal property sources ---v
                     ds_airc_counts    + 
                     ds_mvr_counts     + 
									   ds_waterc_counts  +

									 ds_corp_counts      +
									 ds_bankr_counts     +
									 ds_liens_counts     +
									 ds_ucc_counts       +

                   ds_govagy_counts    +
                   ds_othdir_counts    +

									 // telco sources ---v
									   ds_gong_counts    +
									   ds_yp_counts      + 

									 //new categories/individual single sources (per Tom Reed starting 10/29/13+)
									 ds_expfein_counts   +  
									 ds_expcrdb_counts   + 
									 ds_crashcar_counts  +
									 //ds_commclue_counts  +
								   ds_fran_counts      + 
/* */
									 // v--- Empty dataset to make it easier to comment out/uncomment 
									 // ds_***s above for testing.
									 // REMOVE (--^ & --v) WHEN FINAL PROD VERSION IS CHECKED IN <-----------!!! ???
									 dataset([],SourceSection_Layouts.rec_SourceCount) // for initial testing
	                 ;


  // Do a sort/group/rollup to create parent dataset of all category count recs for each 
	// set of linkids/category.
	//
  // First sort/group all recs into order needed.
	ds_all_counts_slim := ds_all_counts(category_doccount != 0);
	ds_all_counts_srtd_grpd := group(sort(ds_all_counts_slim, //only categories with a count
			                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	
	                                      category_desc // ascending by category# 'nn...' 
																				              //(number is first 2 of the category description)
																				),
																	 //group on ids & category description		
			                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
	                                 category_desc
																	 );

	TopBusiness_Services.SourceSection_Layouts.rec_SourceParent tf_rollup_items(
    SourceSection_Layouts.rec_SourceCount l,
		dataset(TopBusiness_Services.SourceSection_Layouts.rec_SourceCount) allrows)	:= transform
			self.category_name     := l.category_desc[3..50]; //don't include first 2 chars which are the category number
      self.category_doccount := sum(allrows,category_doccount);
      // Create SourceDocs dataset from allrows sorted and deduped.
			self.SourceDocs  := //choosen( //???
			                    project(dedup(sort(allrows,section,source),section,source),
			                            transform(TopBusiness_Services.SourceSection_Layouts.rec_SourceChild_Item,
											                self := left)); // to assign all linkids and section or source
													//,iesp.???);
																			
      self             := l; // to assign all linkids
	end;

	// Then do group rollup on all recs for each set of linkids/category to create 
	// an interim parent(category) dataset.
  ds_all_counts_rolled_items  := rollup(ds_all_counts_srtd_grpd,
	                                      group,
	  												            tf_rollup_items(left,rows(left))); 


  // Transforms for the iesp layouts 
	//
  // transform to handle iesp SourceDocInfo child dataset fields
  iesp.topbusiness_share.t_TopBusinessSourceDocInfo  tf_rpt_item(
	  TopBusiness_Services.SourceSection_Layouts.rec_SourceChild_Item l) := transform
    self.BusinessIds := l,  // to store all linkids
    self             := l;  // to assign "Source" field???
		self             := []; // to null unused fields
	end;

  // transform to store data in the iesp report detail parent dataset fields
	TopBusiness_Services.SourceSection_Layouts.rec_ids_plus_SourceCategory tf_rpt_detail(
	  TopBusiness_Services.SourceSection_Layouts.rec_SourceParent l) := transform
    self.Name       := l.category_name,
 	  self.DocCount   := l.category_doccount,
    self.SourceDocs := choosen(project(l.sourcedocs,tf_rpt_item(left)), //use choosen just in case
                               iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS),
    self            := l, // to preserve all linkids
  end;

  // Project interim layout recs into iesp report record detail structures plus linkids.
	ds_all_recs_rptdetail := project(ds_all_counts_rolled_items,tf_rpt_detail(left));

  // Sort/Group/Rollup all recs for a set of linkids
  TopBusiness_Services.SourceSection_Layouts.rec_ids_plus_SourceSection tf_rollup_rptdetail(
	  TopBusiness_Services.SourceSection_Layouts.rec_ids_plus_SourceCategory l,
	  dataset(TopBusiness_Services.SourceSection_Layouts.rec_ids_plus_SourceCategory) allrows)
		:= transform
      self.acctno     := '';  // null here, will be assigned below
			// Sum up all the DocCounts from all rows
			self.AllSourcesCount := sum(allrows,DocCount);
			self.SourceDocs := choosen(project(allrows.SourceDocs,
                                         transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
																	         self := left)),
														     iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ALLSRCDOC_RECORDS);
      self.Categories := choosen(project(allrows,
		                                     transform(iesp.TopbusinessReport.t_TopBusinessSourceCategory,
		                       		             self := left)),
														     iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SOURCE_RECORDS);
      self            := l, // to preserve all linkids
	end;

  ds_all_rptdetail_grouped := group(sort(ds_all_recs_rptdetail, 
							                           #expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
					                          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
	
  ds_all_rptdetail_rolled := rollup(ds_all_rptdetail_grouped,
																    group,
																    tf_rollup_rptdetail(left,rows(left)));

  // Attach input acctnos back to the linkids
  ds_all_wacctno_joined := join(ds_in_ids,ds_all_rptdetail_rolled,
							                    BIPV2.IDmacros.mac_JoinTop3Linkids(),
														    transform(TopBusiness_Services.SourceSection_Layouts.rec_ids_plus_SourceSection,
														      self.acctno   := left.acctno,
															    self          := right),
														    left outer // 1 out rec for every left (input ids) rec
																//keep???
																//limit???
															 );

	// Roll up all recs for the acctno
	ds_final_results := rollup(group(sort(ds_all_wacctno_joined, acctno),
	                                 acctno),
														 group,
		                         transform(TopBusiness_Services.SourceSection_Layouts.rec_final,
                               self := left)
														);

  // Uncomment for debugging
  // output(ds_in_ids,                        named('ds_in_ids'));
  // output(ds_in_ids_woacctno,               named('ds_in_ids_woacctno'));
  // output(ds_in_ids_srcrecs_inlayout,       named('ds_in_ids_srcrecs_inlayout'));
  // output(count(ds_lnca_keyrecs),                  named('ds_lnca_keyrecs'));
  // output(ds_lnca_keyrecs_dd,               named('ds_lnca_keyrecs_dd'));
	// output(ds_lnca_keyrecs_dd_tabled,        named('ds_lnca_keyrecs_dd_tabled'));
	// output(ds_lnca_counts,                   named('ds_lnca_counts'));
  // output(count(ds_ebr_keyrecs),                   named('ds_ebr_keyrecs'));
  // output(ds_ebr_keyrecs_dd,                named('ds_ebr_keyrecs_dd'));
	// output(ds_ebr_keyrecs_dd_tabled,         named('ds_ebr_keyrecs_dd_tabled'));
  // output(ds_ebr_counts,                    named('ds_ebr_counts'));
  // output(count(ds_prop_keyrecs),                  named('ds_prop_keyrecs'));
  // output(ds_prop_keyrecs_dd,               named('ds_prop_keyrecs_dd'));
	// output(ds_prop_keyrecs_dd_tabled,        named('ds_prop_keyrecs_dd_tabled'));
  // output(ds_prop_counts,                   named('ds_prop_counts'));
  // output(ds_forec_counts,                  named('ds_forec_counts'));
  // output(ds_nod_counts,                    named('ds_nod_counts'));
  // output(count(ds_airc_keyrecs),                  named('ds_airc_keyrecs'));
  // output(ds_airc_keyrecs_dd,               named('ds_airc_keyrecs_dd'));
	// output(ds_airc_keyrecs_dd_tabled,        named('ds_airc_keyrecs_dd_tabled'));
  // output(ds_airc_counts,                   named('ds_airc_counts'));
  // output(count(ds_mvr_keyrecs),                   named('ds_mvr_keyrecs'));
  // output(ds_mvr_keyrecs_dd,                named('ds_mvr_keyrecs_dd'));
	// output(ds_mvr_keyrecs_dd_tabled,         named('ds_mvr_keyrecs_dd_tabled'));
  // output(ds_mvr_counts,                    named('ds_mvr_counts'));
  // output(count(ds_waterc_keyrecs),                named('ds_waterc_keyrecs'));
  // output(ds_waterc_keyrecs_dd,             named('ds_waterc_keyrecs_dd'));
	// output(ds_waterc_keyrecs_dd_tabled,      named('ds_waterc_keyrecs_dd_tabled'));
  // output(ds_waterc_counts,                 named('ds_waterc_counts'));
  // output(count(ds_corp_keyrecs),                  named('ds_corp_keyrecs'));
  // output(ds_corp_keyrecs_dd,               named('ds_corp_keyrecs_dd'));
	// output(ds_corp_keyrecs_dd_tabled,        named('ds_corp_keyrecs_dd_tabled'));
  // output(ds_corp_counts,                   named('ds_corp_counts'));
  // output(count(ds_bankr_keyrecs),                 named('ds_bankr_keyrecs'));
  // output(ds_bankr_keyrecs_dd,              named('ds_bankr_keyrecs_dd'));
	// output(ds_bankr_keyrecs_dd_tabled,       named('ds_bankr_keyrecs_dd_tabled'));
  // output(ds_bankr_counts,                  named('ds_bankr_counts'));
  // output(count(ds_liens_keyrecs),                 named('ds_liens_keyrecs'));
  // output(ds_liens_keyrecs_dd,              named('ds_liens_keyrecs_dd'));
	// output(ds_liens_keyrecs_dd_tabled,       named('ds_liens_keyrecs_dd_tabled'));
  // output(ds_liens_counts,                  named('ds_liens_counts'));
  // output(count(ds_ucc_keyrecs),                   named('ds_ucc_keyrecs'));
  // output(ds_ucc_keyrecs_dd,                named('ds_ucc_keyrecs_dd'));
	// output(ds_ucc_keyrecs_dd_tabled,         named('ds_ucc_keyrecs_dd_tabled'));
  // output(ds_ucc_counts,                    named('ds_ucc_counts'));
  // output(ds_govagy_counts,                 named('ds_govagy_counts'));
  // output(ds_othdir_counts,                 named('ds_othdir_counts'));
  // output(count(ds_gong_keyrecs),                  named('ds_gong_keyrecs'));
  // output(ds_gong_keyrecs_dd,               named('ds_gong_keyrecs_dd'));
	// output(ds_gong_keyrecs_dd_tabled,        named('ds_gong_keyrecs_dd_tabled'));
	// output(ds_gong_counts,                   named('ds_gong_counts'));
  // output(count(ds_yp_keyrecs),                    named('ds_yp_keyrecs'));
  // output(ds_yp_keyrecs_dd,                 named('ds_yp_keyrecs_dd'));
	// output(ds_yp_keyrecs_dd_tabled,          named('ds_yp_keyrecs_dd_tabled'));
	// output(ds_yp_counts,                     named('ds_yp_counts'));
  // output(count(ds_expfein_keyrecs),               named('ds_expfein_keyrecs'));
  // output(ds_expfein_keyrecs_dd,            named('ds_expfein_keyrecs_dd'));
	// output(ds_expfein_keyrecs_dd_tabled,     named('ds_expfein_keyrecs_dd_tabled'));
	// output(ds_expfein_counts,                named('ds_expfein_counts'));
	// output(ds_expcrdb_counts,                named('ds_expcrdb_counts'));
  // output(ds_crashcar_counts,               named('ds_crshcar_counts'));
  // output(ds_commclue_counts,               named('ds_commclue_counts'));
  // output(count(ds_fran_keyrecs),                  named('ds_fran_keyrecs'));
  // output(ds_fran_keyrecs_dd,               named('ds_fran_keyrecs_dd'));
	// output(ds_fran_keyrecs_dd_tabled,        named('ds_fran_keyrecs_dd_tabled'));
	// output(ds_fran_counts,                   named('ds_fran_counts'));

  // output(ds_all_counts,                    named('ds_all_counts'));
  // output(ds_all_counts_srtd_grpd,          named('ds_all_counts_srtd_grpd'));
  // output(ds_all_counts_rolled_items,       named('ds_all_counts_rolled_items'));
  // output(ds_all_recs_rptdetail,            named('ds_all_recs_rptdetail'));	
  // output(ds_all_rptdetail_grouped,         named('ds_all_rptdetail_grouped'));
  // output(ds_all_rptdetail_rolled,          named('ds_all_rptdetail_rolled'));
  // output(ds_all_wacctno_joined,            named('ds_all_wacctno_joined'));
  //output(count(ds_in_ids_srcrecs_inlayout), named('count_of_ds_in_ids_srcrecs_inlayout')); 
	return ds_final_results;

 end; // end of fn_FullView

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
						          // {'test01p', 0, 0, 0, 129079444, 129079444, 129079444, 129079444} // schreier electrix; 2 ebr, 1 corp, & ???
						          // {'test02d', 0, 0, 0, 130438913,130438913, 3, 3} // 2 lnca
											// {'test02p', 0, 0, 0, 16450,16450, 16450, 16450} // 1 lnca, 7 ebr, 21 corp
						          // {'test03p', 0, 0, 0, 149, 149, 149, 149} // 1 bankr, 1 ebr
						          // {'test04p', 0, 0, 0, 238, 238, 238, 238} // 2 liens
						          // {'test05p', 0, 0, 0, 88, 88, 88, 88} // 1 ucc, 1 ebr, 1 corp
                      // {'test06pa', 0, 0, 0, 901, 901, 901, 901} // 1? vs 13? aircraft,
 						          // {'test06pb', 0, 0, 0, 28063, 28063, 28063, 28063} // 1 aircraft, & ???
						          // {'test07p', 0, 0, 0, 165, 165, 165, 165} // 1 mvr, 1 ebr
						          // {'test08p', 0, 0, 0, 686, 686, 686, 686} // 1 watercraft, & 6? mvr
						          // {'test09d1', 0, 0, 0, 82459, 82459, 82459, 82459} // 1 atf???, 1 corp
						          // {'test10d', 0, 0, 0, 8475, 8475, 8475, 8475} // 1 dea, 1 corp
						          // {'test11p', 0, 0, 0, 22276, 22276, 22276, 22276} // 2 fcc, 1 ebr
						          // {'test12d', 0, 0, 0, 165, 165, 165, 165} // 5 pl, 1 mvr, 1 ebr, 4 fbn
						          // {'test13p', 0, 0, 0, 169, 169, 169, 169} // 2 dnbfein, 1? fbn?
											// {'test14p', 0, 0, 0, 7, 7, 7, 7} // 3 fbn
											// {'test15d', 0, 0, 0, 93, 93, 93, 93} // 11 prop
											// {'test16d', 0, 0, 0, 95, 95, 95, 95} // 1 foreclosure & 2 NODs
											// {'test17d', 0, 0, 0, 7, 7, 7, 7} // 1 busreg
										  // {'test18p', 0, 0, 0, 46, 46, 46, 46} // 4? frandx
										  // {'test19p', 0, 0, 0, 39556, 39556, 39556, 39556} // 6? sheila greco
 											// {'test20p', 0, 0, 0, 66343, 66343, 66343, 66343} // bug 129346, 3 other dirs, ? busreg & ? frandx
 											// {'telco21p', 0, 0, 0, 0, 86138, 86138, 86138} // bug 132724, 2 telco/1 gong & 1 yp
 											// {'othdir22p', 0, 0, 0, 0, 1564092983, 1564092983, 1564092983} // bug 129303 test case 4,  oth dir/2(?) dnb fein
										  // {'test23p', 0, 0, 0, 0, 15054936, 15054936, 15054936} // bug 144305 BACKSTREET BOAT SALES, 23 pers prop docs(6 mvr & 17 wc)
										  // {'test24ap', 0, 0, 0, 0, 1, 1, 1} // 1 experian fein doc
										  // {'test24bp', 0, 0, 0, 0, 51, 51, 51} // 2 experian fein docs
										  // {'test25ap', 0, 0, 0, 0, 1, 1, 1} // 1/5? experian crdb doc
										  // {'test25bp', 0, 0, 0, 0, 62, 62, 62} // 2/9? experian crdb docs
										  // {'test26ap', 0, 0, 0, 0, 417, 417, 417} // 1 bbb member doc
										  // {'test26bp', 0, 0, 0, 0, 28188, 28188, 28188} // 2 bbb member docs & 7 bbb nm docs, 9 total
										  // {'test26cp', 0, 0, 0, 0, 529, 529, 529} // 2 bbb non-member docs
										  // {'test27ap', 0, 0, 0, 0, 93, 93, 93} // 4 irs5500 docs
										  // {'test28ap', 0, 0, 0, 0, 273, 273, 273} // 3 irs990 docs
										  // {'test28bp', 0, 0, 0, 0, 135, 135, 135} // 4 irs5500 docs + 25 irs990 docs
										  // {'test29p', 0, 0, 0, 0, 456, 456, 456} // 4 ca sales tax docs
                      // {'test30p', 0, 0, 0, 0, 9301, 9301, 9301} // 46 fdic docs
                      // {'test31p', 0, 0, 0, 0, 770, 770, 770} // 1 txbus doc
                      // {'test32p', 0, 0, 0, 0, 551991, 551991, 551991} // 2 credit_union docs
                      // {'test33p', 0, 0, 0, 0, 1677432124, 1677432124, 1677432124} // 1 abius doc (4 "directories" li recs)
										  // {'test34p', 0, 0, 0, 0, 447, 447, 447} // 2 frandx docs (3 frandx li recs)
                      // {'test35p', 0, 0, 0, 0, 29, 29, 29} //bug 141686 3 corp li recs/2 corp docs
                      // {'test36p2', 0, 0, 0, 0, 2, 2, 2} // bug 145547 test case 2, 6 vehicle_keys/6 vins, 1 curr & 5 prior
                      // {'test37p1', 0, 0, 0, 0, 14, 14, 14} // no bug/chg to use dir li key?-test case 1; 28 dir li key recs/1 othdir rec
											// {'test37p201', 0, 0, 0, 0, 1553, 1553, 1553} // no bug/chg to use src li keys-test case 2.1 dca; 5 li key recs/1 enterprise_num
											// {'test37p201b', 0, 0, 0, 0, 16013341, 16013341, 16013341} // no bug/chg to use src li keys-test case 2.1b dca; 234 li key recs/10 enterprise_nums
											// {'test37p202', 0, 0, 0, 0, 1, 1, 1} // no bug/chg to use src li keys-test case 2.2 ebr; 6 li 0010 key recs/2 file_numbers
											// {'test37p203', 0, 0, 0, 0, 1, 1, 1} // no bug/chg to use src li keys-test case 2.3 corp2; 5 li key recs/1 corp_key
                      // {'test37p204', 0, 0, 0, 0, 447, 447, 447} // no bug/chg to use src li keys-test case 2.4 frandx; 3 li key recs/2 franchisee_ids
                      // {'test37p205', 0, 0, 0, 0, 249, 249, 249} // no bug/chg to use src li keys-test case 2.5 bankruptcy; 2 li key recs/1 tmsid
											// {'test37p206', 0, 0, 0, 0, 1, 1, 1} // no bug/chg to use src li keys-test case 2.6 liensv2; 2 li key recs/2 tmsids
                      // {'test37p207', 0, 0, 0, 0, 2, 2, 2} // no bug/chg to use src li keys-test case 2.7 uccv2; 12 li key recs/2 tmsids
                      // {'test37p208', 0, 0, 0, 0, 2485, 2485, 2485} // no bug/chg to use src li keys-test case 2.8 aircraft; 7 li key recs/6 n_numbers
                      // {'test37p209a', 0, 0, 0, 0, 91, 91, 91} // no bug/chg to use src li keys-test case 2.9 mvr; 10(8 kept) li key recs/7 vehicle_keys/7src docs ret
                      // {'test37p209b', 0, 0, 0, 0, 80, 80, 80} // no bug/chg to use src li keys-test case 2.9 mvr; 4(4 kept) li key recs/2 vehicle_keys/3 src docs ret
                      // {'test37p209c', 0, 0, 0, 0, 114, 114, 114} // no bug/chg to use src li keys-test case 2.9 mvr; 12(12 kept) li key recs/2 vehicle_keys/4 src  docs ret
                      // {'test37p209d', 0, 0, 0, 0, 2, 2, 2} // no bug/chg to use src li keys-test case 2.9 mvr; 188(16 kept) li key recs/6 vehicle_keys/7 src  docs ret
                      // {'test37p210a', 0, 0, 0, 0, 261, 261, 261} // no bug/chg to use src li keys-test case 2.10a watercraft; 3 li key recs/1 watercraft_key/3 src  docs counted&ret
                      // {'test37p210b', 0, 0, 0, 0, 5167, 5167, 5167} // no bug/chg to use src li keys-test case 2.10b watercraft; 7 li key recs/3 watercraft_keys/7 src  docs counted/19 src docs retd(lots of dupes), wcsrc_recs bug, Lorraine backed out her chgs???
                      // {'test37p211', 0, 0, 0, 0, 39, 39, 39} // no bug/chg to use src li keys-test case 2.11 exp fein; 4 li key recs/2 src  docs counted&retd
                      // {'test37p212', 0, 0, 0, 0, 4, 4, 4} // no bug/chg to use src li keys-test case 2.12 exp crdb;15 li key recs/2 src  docs counted&retd
                      // {'test37p213', 0, 0, 0, 0, 250, 250, 250} // no bug/chg to use src li keys-test case 2.13 gong&yp; 2(gong) & 3(yp) li key recs/2+3 src  docs counted&retd
                      // {'test37p214', 0, 0, 0, 0, 30463, 30463, 30463} // no bug/chg to use src li keys-test case 2.14 atf; 3 li key recs/2 src  docs counted/retd
                      // {'test37p215', 0, 0, 0, 0, 2, 2, 2} // no bug/chg to use src li keys-test case 2.15 busreg; 3 li key recs/3 src  docs counted&retd
                      // {'test37p216', 0, 0, 0, 0, 4, 4, 4} // no bug/chg to use src li keys-test case 2.16 dnbfein; 7 li key recs/4 tmsids/src  docs counted&retd
                      // {'test37p217', 0, 0, 0, 0, 2, 2, 2} // no bug/chg to use src li keys-test case 2.17 fbn; 3 li key recs/2 tmsids/src  docs counted&retd
                      // {'test37p218', 0, 0, 0, 0, 2578, 2578, 2578} // no bug/chg to use src li keys-test case 2.18 sheila greco; 3 li key recs/3 src  docs counted&retd
                      // {'test37p219a', 0, 0, 0, 0, 295, 295, 295} // no bug/chg to use src li keys-test case 2.19a dea; 2 li key recs/2 dea-reg#s/src docs counted&retd
                      // {'test37p219b', 0, 0, 0, 0, 2036, 2036, 2036} // no bug/chg to use src li keys-test case 2.19b dea; 3 li key recs/1 dea-reg#s/src docs counted&retd
                      // {'test37p220', 0, 0, 0, 0, 1041, 1041, 1041} // no bug/chg to use src li keys-test case 2.20 fcc; 2 li key recs/2 fcc-seqs/src docs counted&retd
                      // {'test37p221', 0, 0, 0, 0, 165, 165, 165} // no bug/chg to use src li keys-test case 2.21 pl; 5 li key recs/5 prolic-seq-ids/src docs counted&retd
                      // {'test37p222', 0, 0, 0, 0, 537, 537, 537} // no bug/chg to use src li keys-test case 2.22 oshair; 5 li key recs/5 act_nums/src docs counted&retd
                      // {'test37p223', 0, 0, 0, 0, 11, 11, 11} // no bug/chg to use src li keys-test case 2.23 prop; 3 li key recs/3 fares_ids/src docs counted&retd
                      // {'test37p224v1', 0, 0, 0, 0, 15159, 15159, 15159} // no bug/chg to use src li keys-test case 2.24 forec; 3 li key recs/2 foreclosure_ids/3 src docs counted&retd
                      // {'test37p225v1', 0, 0, 0, 0, 1643, 1643, 1643} // no bug/chg to use src li keys-test case 2.25 nod; 8 li key recs/1 foreclosure_id/3 src docs counted&retd
                      // {'test37p226mbrv1', 0, 0, 0, 0, 281, 281, 281} // no bug/chg to use src li keys-test case 2.26a bbb mbr; 3 li key recs/3 src  docs counted/retd
                      // {'test37p226nmbrv1', 0, 0, 0, 0, 529, 529, 529} // no bug/chg to use src li keys-test case 2.26b bbb nonmbr; 3 li key recs/3 src  docs counted/retd
                      // {'test37p227v1', 0, 0, 0, 0, 456, 456, 456} // no bug/chg to use src li keys-test case 2.27 casalestax; 4 li key recs/4 src  docs counted/retd
                      // {'test37p228v1', 0, 0, 0, 0, 6291, 6291, 6291} // no bug/chg to use src li keys-test case 2.28 fdic; 4 li key recs/1 src  docs counted/retd
                      // {'test38ams1v2b', 0, 0, 0, 0, 164, 164, 164} // bug 156617 add AMS; 2 li key recs/1 src  docs counted/retd
                      // {'test38cnldfac1', 0, 0, 0, 0, 135, 135, 135} // bug 156620 add CNLD_FACILITIES, test case 1; 8 li key recs/3 src  docs counted/retd
                      // {'test38cnldfac22', 0, 0, 0, 0, 4464, 4464, 4464} // bug 156620 add CNLD_FACILITIES, test case 2; 1 li key recs/1 src  docs counted/retd
											// {'test41ucc1', 0, 0, 0, 0, 6628, 6628, 6628} // no bug eff chg, 1 ucc li recs, 1 ucc tmsids/1 as debtor
					            // {'test41ucc2', 0, 0, 0, 0, 159332797, 159332797, 159332797} // no bug eff chg, 4 ucc linkids key recs/4 ucc tmsids, only 3 s/b used since 1 is Assignee
						          // {'test51airc', 0, 0, 0, 0, 702, 702, 702} // no bug key_fetches chg, 8 airc linkids key recs/3 aircrafts
                      // {'test51mvr', 0, 0, 0, 0, 2, 2, 2} // no bug key_fetches chg, 166 mvr li recs, 6 vehicles, but 7 docs whihc matched source service output
                      // {'test51wc', 0, 0, 0, 0, 76249693, 76249693, 76249693} // no bug key_fetches chg, 10 linkids recs, 3 prior wcs (5 wc_keys but only 3 unique hull#s), but 10 source docs
                      // {'test61amidir1', 0, 0, 0, 0, 30445, 30445, 30445} // bug 156807 add AMIDIR; 3 li key recs/2 src  docs counted/retd
                      // {'test61amidir2', 0, 0, 0, 0, 33140, 33140, 33140} // bug 156807 add AMIDIR; 5 li key recs/5 src  docs counted/retd
                      // {'test62calbus1', 0, 0, 0, 0, 66, 66, 66} // bug 156809 add Calbus; 2 li key recs/1 src  doc counted/retd
                      // {'test62calbus2', 0, 0, 0, 0, 281, 281, 281} // bug 156809 add Calbus; 10 li key recs/9 src  docs counted/retd
                      // {'test63multi1', 0, 0, 0, 0, 66, 66, 66} // bug 151725 chg high level sourcedocs; 1 gov agy(calbus) src  doc & 1 other(bus reg) source doc, 2 total counted/retd
                      // {'test63multi2', 0, 0, 0, 0, 186, 186, 186} // bug 151725 chg high level sourcedocs; 1 gov agy(calbus) src  doc & 4 other(2 bus reg + 2 fbn) source doc, 5 total counted/retd
                      // {'test63multi3', 0, 0, 0, 0, 64, 64, 64} // bug 151725 test case, fix high level sourcedocs; 17 other(1 abius + 12 busreg + 4 fbn) & 2 exp_fein = 19 total counted/retd
                      // {'test64spoke1', 0, 0, 0, 0, 4, 4, 4} // bug 156817 add SPOKE; 8 li key recs/2 src  docs counted/retd
                      // {'test64spoke2', 0, 0, 0, 0, 135, 135, 135} // bug 156817 add SPOKE; 7 li key recs/1 src  docs counted/retd
                      // {'test65lawhd1', 0, 0, 0, 0, 14, 14, 14} // bug 156811 add LaborActions_WHD; 4 li key recs/1 src  docs counted/retd
                      // {'test65lawhd2', 0, 0, 0, 0, 5167, 5167, 5167} // bug 156811 add LaborActions_WHD; 6 li key recs/2? src  docs counted/retd
                      // {'test66orwork1', 0, 0, 0, 0, 110968, 110968, 110968} // bug 156815 add ORWORK; 2 li key recs/1 src  docs counted/retd
                      // {'test66orwork2', 0, 0, 0, 0, 1263667, 1263667, 1263667} // bug 156815 add ORWORK; 6 li key recs/1 src  docs counted/retd
                      // {'test67txbus1', 0, 0, 0, 0, 256, 256, 256} // bug 169439 chg to use txbussource_records; 2 li key recs/1 src  docs counted/retd
                      // {'test67txbus2', 0, 0, 0, 0, 1702, 1702, 1702} // bug 160439 chg to use txbussource_records; 17 li key recs/4 src  docs counted/retd
                      // {'test67abius1', 0, 0, 0, 0, 4, 4, 4} // bug 169439 chg to use infousa_abiussource_records; 3 li key recs/1 src  docs counted/retd
                      // {'test67abius2', 0, 0, 0, 0, 3616743, 233, 233} // bug 169439 chg to use infousa_abiussource_records; 5 li key recs/2 src  docs counted/retd
                      // {'test68oig1', 0, 0, 0, 0, 324658, 324658, 324658} // bug 156775 add OIG; 7 li key recs/1 src  docs counted/retd
                      // {'test68oig2', 0, 0, 0, 0, 2080621, 2080621, 2080621} // bug 156775 add OIG; 7 li key recs/2 src  docs counted/retd
                      // {'test69ncpsp1', 0, 0, 0, 0, 702, 702, 702} // bug 156772 add NCPDP; 8 li key recs/2 src  docs counted/retd
                      // {'test69ncpdp2', 0, 0, 0, 0, 6022, 6022, 6022} // bug 156772 add NCPDP; 15 li key recs/2 src  docs counted/retd
											// {'test81atfp1', 0, 0, 0, 0, 3471, 3471, 3471} // no bug/chg to use new ga attr - atf 4 li key recs/3 source docs
											// {'test81govagy2p1', 0, 0, 0, 0, 2218, 2218, 2218} // no bug/chg to use new ga attr - calbus 1 li key recs/1 source docs & casalestax 1 li key recs/1 source docs 
                      // {'test81spokeP1', 0, 0, 0, 0, 4, 4, 4} //no bug/chg to use new od attr - SPOKE; 8 li key recs/2 src  docs counted/retd
                      // {'test81othdir2p1', 0, 0, 0, 0, 4, 4, 4} // no bug/chg to use new od attr - busreg 1 li key recs/1 source docs & spoke 8 li key recs/2 source docs 
											// {'testiastx', 0, 0, 0, 0, 7842, 7842, 7842} // bug 156760 to add src for IASTX; 3 li key recs/3 src docs counted&retd                      
											// {'testINSCert1', 0, 0, 0, 0, 456, 456, 456} // bug 156763 to add src for INSCert; 10 li key recs/10 src docs counted&retd 
											// {'testINSCert2', 0, 0, 0, 0, 1371, 1371, 1371} // bug 156763 to add src for INSCert; 6 li key recs/6 src docs counted&retd 
											// {'testMSWork2', 0, 0, 0, 0, 34196, 34196, 34196} // bug 156765 to add src for MSWork; 9 li key recs/4? src docs counted&retd 
											// {'testMSWork3', 0, 0, 0, 0, 38970, 38970, 38970} // bug 156765 to add src for MSWork; 5 li key recs/1? src docs counted&retd 
											// {'testWorkComp1', 0, 0, 0, 0, 4, 4, 4} // bug 156641 to add src for WorkComp; 8 li key recs/6 src docs counted&retd 
											// {'testWorkComp2', 0, 0, 0, 0, 8, 8, 8} // bug 156641 to add src for WorkComp; 4 li key recs/4 src docs counted&retd 
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
                      //{'testDeadco17270_singleRow', 0, 0, 0, 0, 17270, 17270, 17270} // bug: 156638 test deadco source docs - 1 recs in linkIDs key // 2 "OthDirs" source docs counted(1 IC & 1 WF)/1 "IC" src doc retd
                      //{'testDeadco281', 0, 0, 0, 0, 281, 281, 281} // bug: 156638 test deadco source docs - 10 recs in linkIDs key // 104 "OthDirs" source docs counted(10 IC & ? xx)/10 "IC" src doc retd
                      //{'testDeadco665', 0, 0, 0, 0, 665, 665, 665} // bug: 156638 test deadco source docs - 4 recs in linkIDs key // 18 "OthDirs" source docs counted(4 IC & ? xx)/4 "IC" src doc retd
                      // {'testCreditUnion551991', 0, 0, 0, 0, 551991, 551991, 551991} // no bug/chg use to test deadco source docs - 4 recs in linkIDs key // 2 source docs counted
                      //{'testSka3657', 0, 0, 0, 0, 3657, 3657, 3657} // Bug: 156635 test SK&A source docs - 4 recs in ska nixie & bip directories linkIDs keys // 4 source docs counted/returned 
                      //{'testSka12941', 0, 0, 0, 0, 12941, 12941, 12941} // Bug: 156635 test SK&A source docs - 2 recs in ska nixie & bip directories linkIDs keys // 2 source docs counted/returned
                      //{'testUtil747', 0, 0, 0, 0, 747, 747, 747} // bug: 156638 test 1 utilities source docs - 2 "UT" recs in BIP directories linkIDs key // 3 source docs counted(1 BR, 1 UT & 1 WF)/1 UT source doc returned
                      //{'testUtil6415', 0, 0, 0, 0, 6415, 6415, 6415} // bug: 156638 test 2 utilities source docs - 1 "UT" recs in BIP directories linkIDs key // 2 source docs counted(1 BN & 1 UT) /1 UT source doc returned
                      //{'testUtil16573', 0, 0, 0, 0, 16573, 16573, 16573} // bug: 156638 test 3 utilities source docs - 1 "UT" recs in BIP directories linkIDs key // 1 UT source doc ounted/1 UT source doc returned
                      // {'testAcf233', 0, 0, 0, 0, 29150652, 233, 233} // // ? recs in linkIDs key // 1 source docs counted 
                      // {'testAcf7842', 0, 0, 0, 0, 7842, 7842, 7842} // ? recs in linkIDs key // 1 source docs counted
											// {'testcrashcarrier1', 0, 0, 0, 0, 2348, 2348, 2348}, // bug 156642 add US DOT Safer Census; 2 li key recs/2 src  docs counted/retd
											// {'testcrashcarrier2', 0, 0, 0, 0, 2899, 2899, 2899} // bug 156642 add US DOT Safer Census; 8 li key recs/8 src  docs counted/retd
                      // bug: 156750 (Diversity Certification) 
                      // {'testDivCert135', 0, 0, 0, 0, 135, 135, 135}  // 16 docs in prod
                      // {'testDivCert217', 0, 0, 0, 0, 217, 217, 217} // 2 records
                      // {'testDivCert233_1', 0, 0, 0, 0, 127890024, 233, 233}  // 1 record
                      // {'testDivCert233_2', 0, 0, 0, 0, 3616743, 233, 233}  // 3 records                    
                      // bug: 156781 (SDA & SDAA)
                      // {'testSda4182', 0, 0, 0, 0, 4182, 4182, 4182} // 1 record -> SDA -Standard Directory of Advertisers data (source code = SA) and 
                      // {'testSda233', 0, 0, 0, 0, 3616743, 233, 233} // 1 record -> SDA -Standard Directory of Advertisers data (source code = SA) and 
                      // {'testSda3376', 0, 0, 0, 0, 3376, 3376, 3376} // 1 - record
                      // {'testSdaa4706', 0, 0, 0, 0, 82074177, 4706, 4706}  // 1 record -- AA, but 5 other dir count -> the SDAA - Standard Directory of Advertisers International data (source code = AA)
                      // bug: 156764 Martindale-Hubbell 
                      // {'testMartinHub388', 0, 0, 0, 0, 0, 388, 388} // 1 record
                      // {'testMartinHub1253', 0, 0, 0, 0, 1253, 1253, 1253}  // 1 record
                      // {'testMartinHub1267', 0, 0, 0, 0, 1267, 1267, 1267}  // 1 record
                      // {'testMartinHub3841', 0, 0, 0, 0, 3841, 3841, 3841}  // 1 record
                      // bug: 156780 Redbooks 
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
