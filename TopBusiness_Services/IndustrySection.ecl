IMPORT TopBusiness_services,AutoStandardI, BIPV2, Codes, iesp, MDR, STD;

EXPORT IndustrySection := MODULE;

EXPORT GetIndustryBipLinkids(DATASET(BIPV2.IDlayouts.l_xlink_ids)  bipLinkids, 
                    STRING1 FETCH_LEVEL
                    ,UNSIGNED4 FETCH_KEEP_LIMIT) :=  TopBusiness_Services.Key_Fetches(
                           bipLInkids// input file to join key with
                           ,FETCH_LEVEL // level of ids to join with				    						              
                           ,FETCH_KEEP_LIMIT  
                      ).ds_industry_linkidskey_recs;

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
   dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids_wacctno
       ,TopBusiness_Services.industrySection_layouts.rec_OptionsLayout in_options
	 ,AutoStandardI.DataRestrictionI.params in_mod 
 ) := function

   FETCH_LEVEL := in_options.businessReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later
	ds_in_ids_only := project(ds_in_ids_wacctno,transform(BIPV2.IDlayouts.l_xlink_ids, 
                                        self := left,
							   self := []));

  // *** Key fetch to get Industry related data from multiple sources by joining
	//     to the new (as of 04/10/13) combined industry linkids key file.
 
 ds_industry_keyrecs  := GetIndustryBipLinkids(ds_in_ids_only
                                                                                     , FETCH_LEVEL
                                                                                     , TopBusiness_Services.Constants.defaultJoinLimit );
  // Filter to only include recs with at least 1 of the 4 pieces of data being output
	// and only use rec_type="C" recs for EBR (bug 143521). 
	ds_industry_keyrecs_filtered := ds_industry_keyrecs((SicCode !='' or NAICS !='' or
                                                        industry_description !=''   or
                                                        business_description !='')
                                                        and 
                                                        ((source=MDR.sourceTools.src_EBR and 
                                                        record_type='C') or
                                                        source !=MDR.sourceTools.src_EBR)
	);

  // Sort/dedup to get rid of multiple recs with exact duplicate industry info for a source.
	// This should help reduce total number of industry key recs being used.
  ds_industry_keyrecs_touse := dedup(sort(ds_industry_keyrecs_filtered, 
                                                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
                                                               source, 
                                                               source_docid,  
                                                               source_rec_id, //or -source_rec_id to put non-zero values first???
                                                               siccode, naics, 
                                                               industry_description, business_description,
                                                               record_type, // C(Curr) before H(Hist) when applicable (i.e. for EBR)
                                                               // v--- most recent
                                                               -dt_last_seen, -dt_vendor_last_reported, -record_date,
                                                              // v--- earliest most recent
                                                              dt_first_seen, dt_vendor_first_reported 
                                                              //,record ???
                                                              ), 
                                                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                                              source, 
                                                              source_docid,
                                                              source_rec_id,
                                                              siccode, naics, 
                                                              industry_description,business_description
                                                              //,record_type, etc.??? //???
                                                              );

  // Next sort/dedup to keep only 1 record for each linkids/source/source_docid/source_rec_id???
	// combo that has some industry info to be used.  Then project onto the source child layout.
  ds_industry_keyrecs_srcs := dedup(sort(project(ds_industry_keyrecs_touse, 
     transform(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_Source,

       OtherDirectoriesSource := not(left.source in 
                 TopBusiness_Services.SourceServiceInfo.SourceSectionSources); //???
                  self.IdType       := if(left.source_docid != '' OR
                              (OtherDirectoriesSource and // see above for meaning of boolean.
                              left.source != MDR.sourceTools.src_Spoke),
                              TopBusiness_Services.Constants.sourcerecid,'');
                  self.source_docid := if(OtherDirectoriesSource, // see above for meaning of boolean.
                                                              if (left.source_rec_id=0,'',(string) left.source_rec_id),
										    left.source_docid);
                  self := left, // to retain all linkids & other source related fields
	    )),
         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
            source,source_docid),
        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
            source,source_docid);
            
  // After all industry key data is retrieved/filtered/deduped, prep the data for the report fields.
	//
  // First filter to process recs with non-blank, non-zero SIC codes.
	ds_indusrecs_sic_filtered := ds_industry_keyrecs_touse(siccode !='' and siccode !='0000');
 
	// Sort/dedup to only keep unique sics for each set of linkids, then join to the 
	// "Codes" SIC4 key file to get the Standard Industry Code "official" description  
	// and then put the info into the interim SIC child layout.
	ds_Tmpds_indusrecs_sic_wdescs := join(dedup(sort(ds_indusrecs_sic_filtered, 
                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                siccode,record),
                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                siccode), 
                             Codes.Key_SIC4,
                            left.siccode = right.sic4_code,	
                            transform(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_SIC,
                               // Convert SIC descriptions on the key file in all
                               // upper case text, first to all lower case and then
                               // to mixed case; per Req. BIZ2.0-0450
                               self.sicdescription :=  STD.STR.ToTitleCase(STD.STR.ToLowerCase(right.SIC4_Description));
                               self := left), // to preserve all 6 ids
                               inner, // only keep recs from left if match to right 
						          // (i.e. has a sic description)
                               keep(1) //should only be 1 key file record per sic4 code
                        );

                                                
  // Second, filter to only use recs with non-blank, non-zero NAICS codes.
  ds_indusrecs_naics_filtered := ds_industry_keyrecs_touse (naics !=''and naics !='000000'); 

	// Sort/dedup to only keep unique naics codes for each set of linkids, then join to the 
	// "Codes" NAICS key file to get the NAICS "official" description and put the info into 
	// the interim NAICS child layout.
  // If "raw" NAICS length = 5 instead of 6, try adding a "0" at the front of the data??? 
	// Do here or ???  // See BR data with ids=???, naics=20080 s/b 020080 ???
  ds_Tmpds_indusrecs_naics_wdescs := 
              join(dedup(sort(ds_indusrecs_naics_filtered, 
                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
                     naics, record), 
                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                     naics),
                    Codes.Key_NAICS,
                   left.naics = right.NAICS_code, 
                  transform(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_NAICS,
                      self.naics            := left.naics,
                      self.naicsdescription := right.NAICS_Description,
                      self := left), // to preserve all linkids
                      inner, // only keep recs from left if match to right
                       // (i.e. has a naics description)
                       keep(1) // should only be 1 key file record per naics code
	              );
   
  ds_TheBestSicCode :=  IF (in_options.BestSicCode[1].SicCode != '',DATASET([{in_options.BestSicCode[1].sicCode}], {STRING8 SicCode}));
                                                                                                  
  ds_TheBestNaicsCode := IF (in_options.BestNaicsCode[1].NaicsCode != '', DATASET([{in_options.BestNaicsCode[1].naicsCode}], {STRING8 NaicsCode}));
                                                                                                                                                          
   ds_Slim_ds_indusrecs_sic_wdescs := ds_Tmpds_indusrecs_sic_wdescs(siccode !=  TRIM(ds_TheBestSicCode[1].sicCode[1..4],LEFT,RIGHT));
   ds_Slim_ds_indusrecs_naics_wdesc := ds_Tmpds_indusrecs_naics_wdescs(naics != TRIM(ds_TheBestNaicsCode[1].naicsCode,LEFT,RIGHT));
   
   ds_BestSlim_ds_indusrecs_sic_wdescs := ds_Tmpds_indusrecs_sic_wdescs(siccode = TRIM(ds_TheBestSicCode[1].sicCode[1..4],LEFT,RIGHT));
   ds_BestSlim_ds_indusrecs_naics_wdesc  := ds_Tmpds_indusrecs_naics_wdescs(naics = TRIM(ds_TheBestNaicsCode[1].naicsCode,LEFT,RIGHT));
   // if sic does not exist  result of the filter above then add it to the top of list of sics.
   // and if it does exist (2nd part of if statement) then use the filtered sic/naics from industry key list as it has a description along with it
   // and pull out that sic from list and add it to top of industry section key list without the best sic/naics which is :   ds_Slim_ds_indusrecs_[SIC/NAICS]_wdescs
   ds_indusrecs_sic_wdescs := IF (~(EXISTS(ds_BestSlim_ds_indusrecs_sic_wdescs)), 
                                      // this project is just 1 row  very key to allow project below
                              PROJECT(ds_TheBestSicCode, TRANSFORM(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_SIC,
                                    tmpBestSic := LEFT.sicCode;
                                     SELF.SicCode := LEFT.sicCode;
                                     SELF.ultid := ds_in_ids_wacctno[1].ultid;
                                     SELF.orgid := ds_in_ids_wacctno[1].orgid;
                                     SELF.seleid := ds_in_ids_wacctno[1].seleid;                                       
                                     SELF.SICDescription :=    PROJECT(Codes.Key_SIC4(sic4_code = tmpBestSic[1..4]), transform({string80 SICDescription;},
                                                                     self.SicDescription := STD.STR.ToTitleCase(STD.STR.ToLowerCase( LEFT.SIC4_Description))))[1].SicDescription;
                                                                        
                                     SELF := [];
                                     ))                                                                                                                                                     
                                   & ds_Tmpds_indusrecs_sic_wdescs,
                               ds_BestSlim_ds_indusrecs_sic_wdescs & ds_Slim_ds_indusrecs_sic_wdescs);
   ds_indusrecs_naics_wdescs := IF (~(EXISTS(ds_BestSlim_ds_indusrecs_naics_wdesc )), 
                                       // this project is just 1 row very key to allow project below
                             PROJECT(ds_TheBestNaicsCode, TRANSFORM(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_NAICS,
                                   tmpNaics := TRIM(LEFT.NAICSCode, LEFT,RIGHT);
                                    SELF.NAICS := TRIM(LEFT.NAICSCode, LEFT,RIGHT);
                                    SELF.ultid := ds_in_ids_wacctno[1].ultid;
                                    SELF.orgid := ds_in_ids_wacctno[1].orgid;
                                    SELF.seleid := ds_in_ids_wacctno[1].seleid;
                                    SELF.NaicsDescription :=  PROJECT(Codes.Key_NAICS(NAICS_code = tmpNaics), transform({string120 NAICSDescription;},
                                                                     self.NaicsDescription := LEFT.NAICS_Description))[1].NaicsDescription;
                                    SELF := [];
                                     ))               
                                   &  ds_Tmpds_indusrecs_naics_wdescs,
                                  ds_BestSlim_ds_indusrecs_naics_wdesc & ds_Slim_ds_indusrecs_naics_wdesc);
   
 	// Third, project to only use recs with non-blank industry_description and 
	// assign a hierarchy order based upon the source code.
  rec_indusrecs_plusido := record
   	TopBusiness_services.IndustrySection_Layouts.rec_ids_withdata_slimmed;
		unsigned1 indus_desc_order := 255;
	end;
	
  ds_indusrecs_windesc := project(ds_industry_keyrecs_touse(industry_description !=''),
          transform(rec_indusrecs_plusido,
              self.indus_desc_order := //v--- revise for any additional/new/removed sources <-------- !!!
                  TopBusiness_Services.Constants.IndustryDescSourceOrder(left.source),
              self := left, // to retain all fields with same name
              self := []));
 
	// Sort/dedup to only keep 1 industry_description for each set of ids based upon the 
	// hierarchy, then project to blank out the other fields.
  ds_indusrecs_windesc_deduped := 
	         project(dedup(sort(ds_indusrecs_windesc, 
                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                       indus_desc_order,
                       // v--- most recent
                         -dt_last_seen,
                        -dt_vendor_last_reported,
                        -record_date,  //not always present???
                         industry_description, //???
                record), 
               #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
             ), 
    transform(TopBusiness_services.IndustrySection_Layouts.rec_ids_withdata_slimmed,
    self := left));	
 
     // Fourth, project to process recs with non-blank businesss_description and 
     // assign a hierarchy order based upon the source code.
  rec_indusrecs_plusbdo := record
      IndustrySection_Layouts.rec_ids_withdata_slimmed;
      integer1 bus_desc_order := 255;
  end;
	
  ds_indusrecs_wbusdesc := project(ds_industry_keyrecs_touse(business_description !=''),
     transform(rec_indusrecs_plusbdo,
       self.bus_desc_order := //v--- revise for any additional/new/removed sources <-------- !!!
           TopBusiness_Services.Constants.BusinessDescSourceOrder(left.source),
           self := left, // to retain all fields with same name
           self := []));

 	// Sort/dedup to only keep 1 business_description for each set of ids based upon the 
	// hierarchy, then project to blank out the other fields.
  ds_indusrecs_wbusdesc_deduped :=  
      project(dedup(sort(ds_indusrecs_wbusdesc, 
        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
        bus_desc_order,
        // current before historical regardless of date_last_seen
        if(record_type = '', 'Z',record_type), //sort blank ones last?, otherwise 'C'(current) before 'H'(historical) ??? 
         // v--- most recent
       -dt_last_seen,
       -dt_vendor_last_reported,
       -record_date, //not always present???
       dt_first_seen, //earliest most recent
         record), 
         #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
          ),
         transform(TopBusiness_services.IndustrySection_Layouts.rec_ids_withdata_slimmed,
        self := left));	

  // *** Create the interim Parent record layout
	//
  // First join the input ids to any ids with an industry description and
  // put into the needed parent layout.
	ds_parents_windesc := join(ds_in_ids_wacctno,ds_indusrecs_windesc_deduped,
            BIPV2.IDmacros.mac_JoinTop3Linkids(), 
           transform(TopBusiness_services.IndustrySection_Layouts.rec_IndustryParent,
              self.industry_description := right.industry_description,
              self := left,
              self := []), 
             left outer // keep all from left
       );
	
  // Then join those recs with the business descriptions for a set of ids.
	ds_parents_wbothdescs := join(ds_parents_windesc, ds_indusrecs_wbusdesc_deduped,
                                BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                transform(TopBusiness_services.IndustrySection_Layouts.rec_IndustryParent,
                                   self.business_description := right.business_description,
                                   self := left),
                                left outer // keep all from left
                                );

  // Denormalize to attach child SIC recs to their associated parent recs.
  IndustrySection_Layouts.rec_IndustryParent tf_denorm_SIC(
      IndustrySection_Layouts.rec_IndustryParent L,   
         dataset(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_SIC) R)	:= transform
            self.SICs    := choosen(project(R,TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_SIC),
            iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SIC_RECORDS);
            self         := L;
         end;

  ds_parents_wdescs_SIC := denormalize(ds_parents_wbothdescs,ds_indusrecs_sic_wdescs,
                                                     BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                                     group,
                                                   tf_denorm_SIC(left,rows(right)));

  // Denormalize a second time to attach child NAICS recs to their associated parent recs.
  TopBusiness_services.IndustrySection_Layouts.rec_IndustryParent tf_denorm_NAICS(
        TopBusiness_services.IndustrySection_Layouts.rec_IndustryParent L,   
        dataset(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_NAICS) R)	:= transform
             self.NAICSs := choosen(project(R,TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_NAICS),
                  iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_NAICS_RECORDS);
             self        := L;
        end;

  ds_parents_wdescs_SIC_NAICS := denormalize(ds_parents_wdescs_SIC,ds_indusrecs_naics_wdescs,
                                                    BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                                    group,
                                                    tf_denorm_NAICS(left,rows(right)));

  // Denormalize a third time to attach child SourceDoc recs to their associated parent recs.
  TopBusiness_services.IndustrySection_Layouts.rec_IndustryParent tf_denorm_sourceinfo(
      TopBusiness_services.IndustrySection_Layouts.rec_IndustryParent L,   
      dataset(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_Source) R)	:= transform
          self.SourceDocs := choosen(project(R,IndustrySection_Layouts.rec_IndustryChild_Source), //vers2???
              iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
         self := L;
      end;

  ds_parents_wchildren := denormalize(ds_parents_wdescs_SIC_NAICS,ds_industry_keyrecs_srcs,
        BIPV2.IDmacros.mac_JoinTop3Linkids(),
        group,
        tf_denorm_sourceinfo(left,rows(right)));


  // Transforms for the iesp layouts 
	//
  // transform to handle "SourceDocs" child dataset
      iesp.topbusiness_share.t_TopBusinessSourceDocInfo 
	   tf_rpt_Source(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_Source l) := transform
            self.BusinessIds := l, // to store all linkids
            self.IdType      := l.IdType,
            self.IdValue     := l.source_docid,
            self.Source      := l.source,
            self             := [] // to null unused fields
        end;

  // transform to handle "SIC" child dataset
   iesp.TopbusinessReport.t_TopbusinessIndustrySIC 
       tf_rpt_SIC(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_SIC l) := transform
       self.SICCode            := l.siccode,
       self.SICCodeDescription := l.SICDescription; 
    end;

  // transform to handle "NAICS" child dataset
   iesp.TopbusinessReport.t_TopbusinessIndustryNAICS 
       tf_rpt_NAICS(TopBusiness_services.IndustrySection_Layouts.rec_IndustryChild_NAICS l) := transform
           self.NAICS            := l.naics,
           self.NAICSDescription := l.NAICSDescription;
      end;

// transform to store data in the iesp report detail parent dataset fields
     TopBusiness_services.IndustrySection_Layouts.rec_ids_plus_IndustryDetail
         tf_rpt_detail(TopBusiness_services.IndustrySection_Layouts.rec_IndustryParent l) := transform
          self.SourceDocs := choosen(project(l.SourceDocs,tf_rpt_source(left)),
                iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
          self.SICs  := choosen(project(l.SICs,tf_rpt_SIC(left)), 
               iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SIC_RECORDS);
          self.NAICSs  := choosen(project(l.NAICSs,tf_rpt_NAICS(left)),
          iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_NAICS_RECORDS),
          self.IndustryDescription := l.industry_description,
          self.BusinessDescription := l.business_description,
          self := l; // to retain all linkids
    end;

  // Project parent/children recs into iesp report record detail layout plus linkids	
  ds_recs_rptdetail := project(ds_parents_wchildren,tf_rpt_detail(left));

  // Sort/Group/Rollup all recs for a set of linkids
  TopBusiness_services.IndustrySection_Layouts.rec_ids_plus_IndustrySection tf_rollup_rptdetail(
      TopBusiness_services.IndustrySection_Layouts.rec_ids_plus_IndustryDetail l,   
         dataset(TopBusiness_services.IndustrySection_Layouts.rec_ids_plus_IndustryDetail) allrows) := transform
            self.acctno          := '';
            self.industryrecords := choosen(project(allrows,
            transform(iesp.TopbusinessReport.t_TopbusinessIndustryRecord,
               self := left)),
           iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_INDUSTRY_RECORDS);
           self                   := l; // to retain all linkids
     end;

  ds_all_rptdetail_grouped := group(sort(ds_recs_rptdetail, 
                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), record), 
                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
                                    );

  ds_all_rptdetail_rolled := rollup(ds_all_rptdetail_grouped,
                                                         group,
                                                         tf_rollup_rptdetail(left,rows(left)));

  // Attach input acctnos back to the bdids
  ds_all_wacctno_joined := join(ds_in_ids_wacctno,ds_all_rptdetail_rolled,
                                                        BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                                        transform(TopBusiness_services.IndustrySection_Layouts.rec_ids_plus_IndustrySection,
                                                        self.acctno   := left.acctno,
                                                        self          := right),
                                                 left outer); // 1 out rec for every left (input) rec

	// Roll up all recs for the acctno
     ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),
       acctno),
       group,
        transform(TopBusiness_services.IndustrySection_Layouts.rec_Final,
       self := left));

  // Uncomment for debugging
  //output(ds_in_ids_wacctno,             named('ds_in_ids_wacctno'));
	//output(ds_in_ids_wacctno_deduped,     named('ds_in_ids_wacctno_deduped'));
	//output(ds_in_ids_only,                named('ds_in_ids_only'));
  // output(ds_TheBestSicCode, named('ds_TheBestSicCode'));
   // output(ds_BestSlim_ds_indusrecs_sic_wdescs, named('ds_BestSlim_ds_indusrecs_sic_wdescs'));
  //output(ds_industry_keyrecs,           named('ds_indusry_keyrecs'));
  //output(ds_industry_keyrecs_filtered,  named('ds_industry_keyrecs_filtered'));
	//output(ds_industry_keyrecs_touse,     named('ds_indusry_keyrecs_touse'));	
  //output(ds_industry_keyrecs_srcs,      named('ds_indusry_keyrecs_srcs'));	
	//output(ds_indusrecs_sic_filtered,     named('ds_indusrecs_sic_filtered'));
  //output(ds_indusrecs_sic_wdescs,       named('ds_indusrecs_sic_wdescs'));
  //output(ds_indusrecs_naics_filtered,   named('ds_indusrecs_naics_filtered'));	
  //output(ds_indusrecs_naics_wdescs,     named('ds_indusrecs_naics_wdescs'));	
  //output(ds_indusrecs_windesc,          named('ds_indusrecs_windesc'));	
  //output(ds_indusrecs_windesc_deduped,  named('ds_indusrecs_windesc_deduped'));	
  //output(ds_indusrecs_wbusdesc,         named('ds_indusrecs_wbusdesc'));	
  //output(ds_indusrecs_wbusdesc_deduped, named('ds_indusrecs_wbusdesc_deduped'));
	//output(ds_parents_windesc,            named('ds_parents_windesc'));
	//output(ds_parents_wbothdescs,         named('ds_parents_wbothdescs'));
  //output(ds_parents_wdescs_SIC,         named('ds_parents_wadescs_SIC'));
  //output(ds_parents_wdescs_SIC_NAICS,   named('ds_parents_wdescs_SIC_NAICS'));
  //output(ds_parents_wchildren,          named('ds_parents_wchildren'));
  //output(ds_recs_rptdetail,             named('ds_recs_rptdetail'));
  //output(ds_all_rptdetail_grouped,      named('ds_all_rptdetail_grouped'));
  //output(ds_all_rptdetail_rolled,       named('ds_all_rptdetail_rolled'));
  //output(ds_all_wacctno_joined,         named('ds_all_wacctno_joined'));
	//output(ds_final_results,              named('ds_final_results'));
	
     return ds_final_results;

 end; // end of FullView function

END; // end of module

/*  to test, in a builder window use this: 
IMPORT AutoStandardI;

  // Report sections input options & params.
	// Just 2 booleans for now: lnbranded and internal_testing
  ds_options := dataset([{false, false}
                     ],topbusiness_services.Layouts.rec_input_options);

	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := '' : stored('DataRestrictionMask'); //pos 3=0 to use EBR
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;

indus_sec := TopBusiness_Services.IndustrySection.fn_FullView(
             dataset([
                        //{'busreg1', 185166, 0, 0, 185166, 185166, 185166}
                        //{'dnbdmi1', 5975, 0, 0, 5975, 5975, 5975} //has fbn data also for this id
                        //{'dnbdmi2', 7348, 0, 0, 7348, 7348, 7348}
                        //{'dnbfein1', 96, 0, 0, 96, 96, 96}
                        //{'ebr1', 7739, 0, 0, 7739, 7739, 7739}
                        //{'ebr2', 2734259, 0, 0, 2734259, 2734259, 2734259}
												//{'ebr3d', 0, 0, 0, 165, 165, 165, 165}
												//{'ebr4d', 0, 0, 0, 11085450, 11085450, 11085450, 11085450}
						            //{'ebr5pa', 0, 0, 0, 0, 86030884, 86030884, 86030884} // bug 133469, 24 linkids recs, 1 seleid with 1 proxid
                        //{'fbn1', 0, 0, 0, 49, 49, 49, 49} // no longer a valid id???
                        //{'frandx1', 0, 0, 0, 1004, 1004, 1004, 1004}
												//{'comb1', 0, 0, 0, 78, 78, 78, 78}
											  //{'comb2', 0, 0, 0, 145, 145, 145, 145}
												//{'comb3', 0, 0, 0, 344, 344, 344, 344}
												//{'comb4P', 0, 0, 0, 0, 60501819, 60501819, 60501819} // bug 134260, 143 industry linkids key recs; sources=ER(EBR), FH(FBN), BR(BusRegs), CR(generic code for CORP), DN(DNBFein) 
												//{'comb5P', 0, 0, 0, 0, 11084446, 11084446, 11084446} // bug 131533, 319 industry linkids key recs; sources=ER(EBR), FH(FBN), BR(BusRegs), CR(generic code for CORP), DN(DNBFein)??? 
												//{'comb6P', 0, 0, 0, 0, 58863459, 58863459, 58863459} // bug 134260, 60,000+ industry linkids key recs; sources=DF(DCA), SP(Spoke), & ???
												//{'comb7p', 0, 0, 0, 0, 55078751, 55078751, 55078751} //bug 143521, 125 industry key recs
												//{'comb8p', 0, 0, 0, 0, 60844437, 60844437, 60844437} //bug 139473, 52 industry key recs 
												//{'comb9pa', 0, 0, 0, 0, 16013341, 16013341, 16013341} //bug 150018 test case 1 PRINCIPAL LIFE INS, 338 industry key recs
												//{'comb9pb', 0, 0, 0, 0, 5125, 5125, 5125} //bug 150018 test case 2 BLOOD SYSTEMS INC, 28 industry key recs

                  ],topbusiness_services.Layouts.rec_input_ids)
						,ds_options[1]
					  ,tempmod
            );

output(indus_sec);
*/
