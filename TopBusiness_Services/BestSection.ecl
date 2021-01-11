import iesp, Doxie, Suppress, AutoStandardI, MDR, BIPV2, BIPV2_Best,
  TopBusiness_Services, ut, dx_Gong, std;

export BestSection := MODULE
  EXPORT  GetBestBipLinkids(dataset(BIPV2.IDlayouts.l_xlink_ids)   ds_in_unique_ids_only, 
                     string1 FETCH_LEVEL, unsigned4 FETCH_LIMIT 	= 25000) 
                     := BIPV2_Best.Key_LinkIds.KFetch(ds_in_unique_ids_only,FETCH_LEVEL, , , ,
      FETCH_LIMIT)(proxid = 0);    
  
  export fn_fullView(
		dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids,
		TopBusiness_Services.BestSection_Layouts.rec_optionsLayout in_options,
		AutoStandardI.DataRestrictionI.params in_mod,
		dataset(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_busHeaderRecs,
    unsigned2 in_sourceDocMaxCount = iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
	 ) := function

  gm := AutoStandardI.GlobalModule();
  mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm))
    export ln_branded := in_options.lnbranded;
    export glb := in_mod.GLBPurpose;
    export dppa := in_mod.DPPAPurpose;
    export show_minors := in_mod.IncludeMinors;
    export DataRestrictionMask := in_mod.DataRestrictionMask;
  END;

 FETCH_LEVEL := in_options.BusinessReportFetchLevel;
 string8 CurDate := (STRING8) STD.Date.today();
 unsigned2 CurYear := (unsigned2) (CurDate[1..4]);
	 ds_in_unique_ids_only := project(ds_in_ids,
	   transform(BIPV2.IDlayouts.l_xlink_ids,
              self.dotid := 0;
              self.powid := 0;
              self.empid := 0;
              self.proxweight := 0;
              self.proxscore := 0;
              self.seleweight := 0;
              self.selescore := 0;
              self.ultscore := 0;
              self.ultweight := 0;
              self.dotscore := 0;
              self.dotweight := 0;
              self.orgscore := 0;
              self.orgweight := 0;
              self.powscore := 0;
              self.powweight := 0;
              self.empscore := 0;
              self.empweight := 0;
              self := left,
  ));         

    ds_slimBusHeaderRecs :=  dedup(sort(
	  project(ds_busHeaderRecs(company_name <> '' and
              source <> MDR.sourceTools.src_Dunn_Bradstreet),
              transform(recordof(left),
                 self.company_name := left.Company_Name;
                 self.cnp_Name := trim(std.str.filterout(left.cnp_Name,' '),left,right);
                 self := left;
               )
         ),vl_id,source_record_id, source, cnp_name, if (company_fein <> '', 0, 1), if (dt_last_seen <> 0, 0, 1),
            if (dt_first_seen <> 0, 0, 1), -length(trim(company_name,left,right)),
         record), vl_id, source_record_id, source, cnp_name);

    // constant for choosen is 1 less than 200 cause best row is added to this DS later
    tmpOtherCompanyNameVariationsPre := if (in_options.IncludeNameVariations,
    sort(
      project(
          choosen(ds_slimBusHeaderRecs, TopBusiness_Services.Constants.OtherCompanyNamesVariationsMax),
              transform(TopBusiness_Services.BestSection_Layouts.layout_other_cnames,
                 OtherDirectoriesSource := (not( left.source in TopBusiness_Services.SourceServiceInfo.SourceSectionSources));

              isDNBDMIRow := MDR.sourceTools.SourceIsDunn_Bradstreet(left.source);
              self.cnp_name := left.cnp_name;
              self.companyName :=  std.str.filterout(trim(left.Company_Name, left, right),'.\'`');
                   //to ensure no dups later in final results.
               self.DateFirstSeen := iesp.ecl2esp.ToDate(left.dt_first_seen);
               self.DateLastSeen := iesp.ecl2esp.ToDate(left.dt_last_seen);
               self.status := left.current;

                // In order to set the IDtype and IDvalue fields within the
		     // iesp.TopBusiness_share.t_TopBusinessSourceDocInfo Structure
                // (this structure is populated and then the contents of this
		     //  structure are passed into the sourceDocService when paying
                //  customer clicks 'source docs' for the particular row in output
	           // results on the GUI in this case 'other company names').
			// Because some sources have various lengths
		      // of fields to reference an individual specific document we needed
			// need to do special thing for the IDType and IDValue.
			// The BIP bus header vl_id field is only string35 and can't fit
			// the two fields in WC and MVR and liens sources necessary to get to a particular
		      // source Doc.  Thus these this function call for idType and IDvalue settings.
			// and set those 2 fields accordingly based on the source of the document.
                
                self.SourceDocs := dataset([transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,
                              self.idtype := topbusiness_services.functions.fn_SourceDocSetIDType(left.source,otherDirectoriesSource);
                              self.idvalue := topbusiness_services.functions.fn_SourceDocSetIdValue(left.source,
						                             left.source_record_id,
                                                             left.source_docid,
                                                             left.vl_id,otherDirectoriesSource);
                              self.Section := '';
                              self.Source := left.source,
                              self.businessIDs.dotid := if (not (isDNBDMIRow), left.dotid, 0);
                              self.businessIDs.powid := if (not (isDNBDMIRow), left.powid, 0);
                              self.businessIDs.empid := if (not  (isDNBDMIRow), left.empid, 0);
                              self.businessIDs.proxid := if ( not (isDNBDMIRow), left.proxid, 0);
                              self.businessIDs.seleid := if (not (isDNBDMIRow), left.seleid, 0);
                              self.businessIDs.orgid := if (not (isDNBDMIRow), left.orgid, 0);
                              self.businessIDs.ultid := if (not  (isDNBDMIRow), left.ultid, 0);
                              self.address := [];
                              self.name := [];
                            )]);
                            )
                           ),cnp_name
                            , -DateLastSeen.Year
                            , -DateLastSeen.Month
                            , -DateLastSeen.Day,record)
              );

   // *** do a rollup on cname here and save source docs
           TopBusiness_Services.BestSection_Layouts.layout_other_cnames rollCnames
             (TopBusiness_Services.BestSection_Layouts.layout_other_cnames l,
               TopBusiness_Services.BestSection_Layouts.layout_other_cnames r) := transform
		     self.sourceDocs := l.sourceDocs + r.sourceDocs; // no choosen needed here cause max of rollup i
                      // TopBusiness_Services.Constants.OtherCompanyNamesVariationsMax
                 self := l;
                 self := r;
             end;

          tmpOtherCompanyNameVariationsAll := rollup(tmpOtherCompanyNameVariationsPre,
               left.cnp_name = right.cnp_name,
         rollCnames(left,right));
      tmpOtherCompanyNameVariations := project(tmpOtherCompanyNameVariationsAll,                                                                           
          transform(iesp.topbusinessREport.t_TopBusinessBestOtherCompany,
              self.SourceDocs := choosen(dedup(left.sourceDocs, all), Topbusiness_services.constants.OTHERCNAMES_SRCDOC_RECORDS);                                                                                                                                                                                                                       
              self := left));
                                                        
   // 2 year window
   twoYearBackDateLastSeen := (unsigned4) (((string4)(CurYear  - 2)) + CurDate[5..8]);

     // slim the Bus header DS before doing project.
    // removes the 'DNBDMI rows'
     ds_busHeaderRecsTinVariations := ds_busHeaderRecs(company_fein <> '' and
     source <> MDR.sourceTools.src_Dunn_Bradstreet);

    // get tin variations   // choosen here helps restrict the sourceDocs Child DS.
    // MAX_TIN_ROWS higher to get all variations if possible
    tmpOtherTinVariations :=  if (in_options.IncludeNameVariations,
           project(
              choosen(
                ds_busHeaderRecsTinVariations,
                   TopBusiness_Services.BestSection_Layouts.MAX_TIN_ROWS),
                         transform(TopBusiness_Services.BestSection_Layouts.layout_other_tins,
                            self.dt_last_seen := left.dt_last_seen;
                            self.source := left.source;
                            compFein := left.company_fein;
                           self.digitsSame := compFein <> '' and length(compFein)  = 9 and
                             compFein[1] = compFein[2] and
                             compFein[1] = compFein[3] and
                             compFein[1] = compFein[4] and
                             compFein[1] = compFein[5] and
                             compFein[1] = compFein[6] and
                             compFein[1] = compFein[7] and
                             compFein[1] = compFein[8] and
                             compFein[1] = compFein[9];
                          self.tin := compFein;
                          self.companyName := trim(left.company_name, left,right);
                          self.cnp_name := trim(left.cnp_name,left,right);
                      // In order to set the IDtype and IDvalue fields within the
                      // iesp.TopBusiness_share.t_TopBusinessSourceDocInfo Structure
                      // (this structure is populated and then the contents of this
                     //  structure are passed into the sourceDocService when paying
                   //  customer clicks 'source docs' for the particular row in output
                   // results on the GUI).  Because some sources have various lengths
                  // of fields to reference an individual specific document we needed
                 // need to do special thing for the IDType and IDValue.
                  // The BIP bus header vl_id field is only string35 and can't fit
                  // the two fields in WC and MVR and liens sources necessary to get to a particular
                  // source Doc.  Thus these this function call for idType and IDvalue settings.
                  // and set those 2 fields accordingly based on the source of the document.
                  self.SourceDocs :=
			          dataset([transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,
					OtherDirectoriesSource :=  (not( left.source in TopBusiness_Services.SourceServiceInfo.SourceSectionSources));
                           self.idType := topbusiness_services.functions.fn_SourceDocSetIdType(left.source,otherDirectoriesSource);
                           self.idValue := topbusiness_services.functions.fn_SourceDocSetIdValue(left.source,
                                    left.source_record_id,
                                    left.source_docid,
						    left.vl_id,otherDirectoriesSource);
                           self.Section := '';
                           self.Source := left.source,
                           self.businessIDs.dotid := left.dotid;
                           self.businessIDs.powid :=  left.powid;
                           self.businessIDs.empid := left.empid;
                           self.businessIDs.proxid := left.proxid;
                          self.businessIDs.seleid := left.seleid;
                          self.businessIDs.orgid := left.orgid;
                          self.businessIDs.ultid := left.ultid;
                          self.address := [];
                          self.name := [];
                        )])(source <> MDR.sourceTools.src_Dunn_Bradstreet)
			 ))
		);

          tmpOtherTinVariationsReduced := dedup(sort(dedup(sort(
                project(tmpOtherTinVariations, transform(recordof(left),
                   self.companyName := std.str.cleanspaces(std.str.filterout(trim(left.companyname,left, right),',-.'));
                   self := left))
               , tin, companyname, -dt_last_seen, record)
		     ,tin, companyName),
			tin, cnp_name,
			-dt_last_seen, record), tin, cnp_name);

               // slim the tin variations if there are any rows that have dups but don't lose any source docs
               // that are different

               tmpOtherTinVariationsSlim := dedup(sort(
               tmpOtherTinVariationsReduced, tin, companyName,SourceDocs[1].IdValue,SourceDocs[1].Source),
                 tin, companyName,SourceDocs[1].IdValue,SourceDocs[1].Source);
          //
          // adding in this choosen in an effort to resolve bug # : 132138
          // also adding -1 since best tin is added later.
          //
          tmpOtherTinVariationsSlim2 := project(
            choosen(tmpOtherTinVariationsSlim,iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS-1),
            transform(TopBusiness_Services.BestSection_Layouts.layout_Best_other_Tins,
                  self.source := left.source;
                  self.tin := left.tin;
                  self.companynames := project(tmpOtherTinVariationsSlim[counter],
                       transform(iesp.topbusinessReport.t_TopBusinessBestCompanyNameInfo,
                             self.companyName := left.CompanyName));
                             self.SourceDocs := left.SourceDocs));

                // rollup on tin and keep cnames and sourcedocs available.
                //iesp.topbusinessReport.t_TopBusinessBestOtherTins
                 TopBusiness_Services.BestSection_Layouts.layout_Best_other_Tins
                      rollit(TopBusiness_Services.BestSection_Layouts.layout_Best_other_Tins L,
                        TopBusiness_Services.BestSection_Layouts.layout_Best_other_Tins R) := transform
                          self.sourceDocs := L.SourceDocs + R.sourceDocs;
                          self := L;
                           self := R;
                end;

                otherTinVariations :=  rollup(sort(tmpOtherTinVariationsSlim2 ,tin),
                        left.tin = right.tin and left.companyNames = right.companyNames,
			rollit(left,right));

         TopBusiness_Services.BestSection_Layouts.layout_Best_other_Tins  rollitTinOnly(
                 TopBusiness_Services.BestSection_Layouts.layout_Best_other_Tins L,
                 TopBusiness_Services.BestSection_Layouts.layout_Best_other_Tins R) := transform
                  self.source := l.source + R.source;
                  self.companyNames := choosen(L.companyNames + R.companyNames, iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_OTHER_COMPANIES);
                  self.sourceDocs := choosen(L.SourceDocs + R.sourceDocs, iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
                  self := L;
                  self := R;
		end;

          otherTins := rollup(sort(otherTinVariations ,tin),
                   left.tin = right.tin,
                   rollitTinOnly(left,right));

             CompActiveRecs := dedup(sort(ds_BusHeaderRecs, ultid, orgid, seleid,-dt_last_seen,
                                       -dt_vendor_last_reported,record),
                                       ultid, orgid, seleid);

       // now start getting the best information
       // get information from the best key.
  
     ds_initial_best := GetBestBipLinkids(ds_in_unique_ids_only
                                                                       ,FETCH_LEVEL                                                                       
                                                                       ,TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit);

    rec_yearStarted := record
    integer year_started;
    integer years_inBusiness;
    string2 YearStartedSource;
    string50 yearStartedSourceDocID;
    boolean yearStartedDerived;
     string10 fax; // added here cause its not on the best key. but will put it from header.
          // and populated it from bus header key BIPV2.Key_BH_Linking_Ids.kfetch
    end;
    rec_yearStartedLinkIds := record
        BIPV2.IDlayouts.l_header_ids;
         rec_yearStarted;
     end;

    // pick off the year started from the best rec returned above.
    // so that years in business and year started can be calculated based on current date

    //
    ds_year_startedFromBest := project(ds_initial_best,
          transform({recordof(left); rec_yearStarted;},
          tmp_year_started_string := project(left.company_incorporation_date,
         transform({string8 company_incorporation_date},
        self.company_incorporation_date := (string8) left.company_incorporation_date;
        ))[1].company_incorporation_date;

       year_startedIncorp :=  (integer) tmp_year_started_string[1..4]; // using from best file.
       year_startedFirstSeen := (integer) (((string8) (left.company_name[1].dt_first_seen))[1..4]);
       year_started := if (year_startedIncorp <>  0,  year_startedincorp, year_startedFirstSeen);

        tmpSource := project(left.company_incorporation_date,
            transform(BIPV2_Best.Layouts.company_incorporation_date_layout,
              self.sources := left.sources;
        self := []));

        self.YearStartedSourceDocID := project(tmpSource.Sources, transform({string50 sourceDocID},
	                 self.sourceDocID := left.vl_id))[1].SourceDocID;
        self.YearStartedSource := project(tmpSource.Sources, transform({string2 source;},
					self.source := left.source;
		))[1].source;

           tmpyears_inBusiness   := if (year_started <> 0, if (left.company_name[1].dt_last_seen <> 0,
             ((unsigned4)  (((string8) (left.company_name[1].dt_last_seen))   [1..4])) - year_started, 0), 0);
            self.Year_started     := year_started;
            self.years_inBusiness := tmpyears_inBusiness;

	       // set these two fields from chad's changes.
           self.YearStartedDerived := false;
           self.fax := '';
           self.isActive := left.isActive;
           self.isDefunct := left.isDefunct;
		self := left;
	     ));                                                                             

      // now add the best row information into the other company name variations
     // so that GUI can display the best row at the top of the other company name variations set of rows
     // and so that source doc information can be retrieved correctly.
     // left only join and then a regular join and addition of the two results take care of this.

     FinalCompanyNameVariationsWithOutBestRow := sort(join(tmpOtherCompanyNameVariations, ds_year_startedFromBest,
	trim(left.CompanyName,left,right) = std.str.filterout(trim(right.company_name[1].company_name,left, right),'.`'),
     transform(recordof(left),
          self := left), left only)
        , CompanyName
        , -DateLastSeen.Year
        , -DateLastSeen.Month
        , -DateLastSeen.Day,record);

       ds_FinalCompanyNameVariationsBestRowOnly := dedup(sort(join(tmpOtherCompanyNameVariations, ds_year_startedFromBest,
        trim(left.CompanyName,left,right) = trim(right.company_name[1].company_name,left, right),
        transform(recordof(left),
        self := left), INNER)
           , -DateLastSeen.Year
           , -DateLastSeen.Month
           , -DateLastSeen.Day,record), all);
     // if we overflow 50 on the cname variations ensure that best row is still appended.

     BestRowCname := project(ds_initial_best, transform(iesp.topbusinessREport.t_TopBusinessBestOtherCompany,
           self.companyName := trim(left.company_name[1].company_name, left, right);
           self.DateFirstSeen := iesp.ecl2esp.ToDate(left.company_name[1].dt_first_seen);
           self.DateLastSeen := iesp.ecl2esp.ToDate(left.company_name[1].dt_last_seen);
            tmpDotid := left.dotid;
            tmpPowid := left.powid;
            tmpempid := left.empid;
           tmpproxid := left.proxid;
           tmpSeleid := left.seleid;
           tmpOrgid := left.orgid;
           tmpUltid := left.ultid;

           self.SourceDocs := choosen(dedup(project(left.company_name[1].sources(source <> MDR.sourceTools.src_Dunn_Bradstreet), transform(
               iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,

           isDNBDMIRow := MDR.sourceTools.SourceIsDunn_Bradstreet(left.source);
		OtherDirectoriesSource := (not( left.source in TopBusiness_Services.SourceServiceInfo.SourceSectionSources));
            self.idType := topbusiness_services.functions.fn_SourceDocSetIdType(left.source,otherDirectoriesSource);
            // below source_docid field commented to null
           // because best key doesn't have source_docid field	yet..
           self.idValue :=  topbusiness_services.functions.fn_SourceDocSetIdValue(left.source,
                      left.source_record_id,
                      '',//left.source_docid,
                     left.vl_id,
                     otherDirectoriesSource);

                   self.businessIDs.dotid := if (not (isDNBDMIRow), tmpDotid, 0);
                   self.businessIDs.powid := if (not (isDNBDMIRow), tmpPowid, 0);
                   self.businessIDs.empid := if (not  (isDNBDMIRow), tmpempid, 0);
                   self.businessIDs.proxid := if ( not (isDNBDMIRow), tmpproxid, 0);
                   self.businessIDs.seleid := if (not (isDNBDMIRow), tmpseleid, 0);
                  self.businessIDs.orgid := if (not (isDNBDMIRow), tmporgid, 0);
                  self.businessIDs.ultid := if (not  (isDNBDMIRow), tmpultid, 0);
                self.Section := '';
                self.Source :=left.Source,
                self.address := [];
                self.name := [];
                ) ),all),in_sourceDocMaxCount);
                self := [];
       ));
 
     //
     // done in case there is overflow to source doc constant of 50 which its possible that
		 // inner join above (ds_FinalCompanyNameVariationsBestRowOnly ) will not have best row in it..thus
		 // manually adding it into mix here in case the bus header rec set got chopped.
		 //
     FinalCompanyNameVariationsBestRowOnly := if (count(ds_FinalCompanyNameVariationsBestRowOnly) = 0,
            BestRowCname, ds_FinalCompanyNameVariationsBestRowOnly);

       FinalCompanyNameVariations := if (in_options.IncludeNameVariations,
            FinalCompanyNameVariationsBestRowOnly & FinalCompanyNameVariationsWithOutBestRow);

		 // now do the same thing for tin variations ensuring that the "best tin" is at the top of
		 // the rows.
		 // ** note entirely possible that finalCompanyNameVariations and FinalTinVariations
		 // will only contain the best row and nothing else.
		 //
      FinalTinVariationsWithOutTinBest := join(otherTins, ds_year_startedFromBest,
         trim(left.tin,left,right) = trim(right.company_fein[1].company_fein,left,right),
		transform(recordof(left),
       self.sourceDocs := CHOOSEN(left.SourceDocs,in_sourceDocMaxCount),
       self := left), left only);

     FinalTinVariationsBestRowOnly := dedup(join(otherTins, ds_year_startedFromBest,
        trim(left.tin,left,right) = trim(right.company_fein[1].company_fein,left,right),
       transform(recordof(left),
         self := left), INNER),all);

     tmpFinalTinVariations := FinalTinVariationsBestRowOnly &  FinalTinVariationsWithOutTinBest;

      finalTinVariations := project(tmpFinalTinVariations,
		                     transform(iesp.topbusinessReport.t_TopBusinessBestOtherTins,
                               self := left));

    // set the isDefunct and IsActive fields using the DS obtained above.

IsCompanyActiveRecs := join(ds_year_startedFromBest, CompActiveRecs,
       left.ultid = right.ultid AND
       left.orgid = right.orgid AND
       left.seleid = right.seleid,
       transform({recordof(left);},
       self.YearStartedDerived := false;
       self.Fax := if (trim(right.phone_type, left,right) = 'F', right.company_phone, '');
       self := left,
       self := []),
       left outer);

   // now sort header recs to bring the very first non zero dt_vendor_first_reported to the top
	 // have to deal with any BIP header recs that have 6 digit dt_vendor_first_reported field so fix that so that sort remains true
	 ds_BusHeaderRecsUCCdateFix := project(ds_BusHeaderRecs, transform(RECORDOF(LEFT),
	    self.dt_vendor_first_reported := if (length((string) left.dt_vendor_first_reported) = 6,
	    left.dt_vendor_first_reported * 100, left.dt_vendor_first_reported);
	    self := left));
      CompActiveRecsLastReported := dedup(sort( ds_BusHeaderRecsUCCdateFix,ultid, orgid, seleid,
	    if (dt_vendor_first_reported <> 0, 0, 1),
           dt_vendor_first_reported, record),
           ultid, orgid, seleid);
   //
   // now join the two DS's together to pull any bus header recs that show a dt_vendor_first_reported
	 // and use that value if the year_started Value is not already filled in
	 //
	 CompanyDerivedStartDate := join(IsCompanyActiveRecs, CompActiveRecsLastReported,
            left.ultid = right.ultid AND
            left.orgid = right.orgid AND
            left.seleid = right.seleid,
            transform(recordof(left),
            // if not alrady populated fill it in with
            // a derived field and set the YearStartedDerivedBoolean as well
             tmpdtVendorFirstReportedAppended := right.dt_vendor_first_reported;
             tmpDateVendorFirstReported := if (length((string)(tmpdtVendorFirstReportedAppended)) = 8,
                  tmpdtVendorFirstReportedAppended div 10000,
		     0); //
           // right.dt_vendor_first_reported is an unsigned4 field in orginal layout so divide by 10,000 to get just
		// year field.

            UseDerivedYearStarted      := if (left.Year_started = 0,
              if ( tmpDateVendorFirstReported  <> 0,
                      tmpDateVendorFirstReported,  0),
                      left.year_started);
                       Year_Started := if (left.year_started = 0, UseDerivedYearStarted, left.year_started);
		  self.Year_started := Year_started;
             self.years_inBusiness :=  left.years_inbusiness;

             self.YearStartedDerived := UseDerivedYearStarted <> 0; // set accordingly
								                                      // based on information in bug # : 119312
             self.yearStartedSource := if (Year_started <> 0, right.source, left.yearStartedSource);
             self.yearStartedSourceDocID := If (Year_started <> 0, right.vl_id, left.YearStartedSourceDocID);
             self := left;
                           ),
         left outer);

   // create a slimmed layout out of the phone information from best key
   // which will be used to set phone metadata based on lookup in gong history key

        ds_trim_phone := project(companyDerivedStartDate, transform({unsigned6 ultid; unsigned6 orgid;
	                                 unsigned6 seleid; unsigned6 proxid; unsigned6 powid; unsigned6 empid;
																	 unsigned6 dotid;
	                                 string10 company_phone;},
              self.company_phone := left.company_phone[1].company_phone;
              self.ultid := left.ultid;
              self.orgid := left.orgid;
              self.seleid := left.seleid;
              self.proxid := left.proxid;
              self.powid := left.powid;
              self.empid := left.empid;
              self.dotid := left.dotid;
        )); // sets  linkids;

  ds_phone_info_raw := join(ds_trim_phone, dx_Gong.key_history_phone(),
    keyed(left.company_phone[4..10] = right.p7) and
    keyed(left.company_phone[1..3]  = right.p3),
    limit(10000,skip));

     ds_phone_info := Suppress.MAC_SuppressSource(ds_phone_info_raw, mod_access);

     unique_phones_wgongdata_1 := dedup(ds_phone_info, all);

     unique_phones_wgongdata := rollup(
           sort(unique_phones_wgongdata_1,
                 #expand(BIPV2.IDmacros.mac_ListAllLinkids()),			
                 company_phone,if (current_flag, 0, 1),
             if(current_flag,listed_name,'')),
         transform(recordof(left),
                self.listing_type_gov := max(left.listing_type_gov,right.listing_type_gov),
                self.listing_type_bus := max(left.listing_type_bus,right.listing_type_bus),
                self.listing_type_res := max(left.listing_type_res,right.listing_type_res),
                self.listed_name := left.listed_name,
                self.dt_first_seen := min(left.dt_first_seen,right.dt_first_seen),
                self.dt_last_seen := max(left.dt_last_seen,right.dt_last_seen),
                self := left),
           #expand(BIPV2.IDmacros.mac_ListAllLinkids()),
           company_phone,if (current_flag, 0, 1),
           if(current_flag,listed_name,''));

           unique_phones_gong_rolled := rollup(
           group(sort(unique_phones_wgongdata,
                                #expand(BIPV2.IDmacros.mac_ListAllLinkids()),
		              company_phone, if (current_flag, 0, 1)),
                                                     #expand(BIPV2.IDmacros.mac_ListAllLinkids()),
									      company_phone),
           group,
           transform({
                ds_trim_phone;
                string1 phone_type;
                string1 active_EDA;
                string1 disconnected;
                string8 from_date;
                string8 to_date;
                string8 from_dateNotCurrent;
                string8 to_dateNotCurrent;
                string120 listed_name;},
                self.disconnected := if(not exists(rows(left)(current_flag)),'Y','N'),
                self.active_EDA := if(exists(rows(left)(current_flag)),'Y','N'),
                self.from_date := min(rows(left)(current_flag),dt_first_seen),
                self.to_date := max(rows(left)(current_flag),dt_last_seen),
                self.from_dateNotCurrent := min(rows(left),dt_first_seen),
                self.to_dateNotCurrent := max(rows(left),dt_last_seen),
                self.phone_type := map(
                      exists(rows(left)(current_flag and listing_type_gov != '')) => max(rows(left)(current_flag and listing_type_gov != ''),listing_type_gov),
				exists(rows(left)(current_flag and listing_type_bus != '')) => max(rows(left)(current_flag and listing_type_bus != ''),listing_type_bus),
				exists(rows(left)(current_flag and listing_type_res != '')) => max(rows(left)(current_flag and listing_type_res != ''),listing_type_res),
				''),
                self.listed_name := max(rows(left)(current_flag),listed_name),
                self := left,
                self := []));

    // take the input and setup the final layout
    // join to get the acctno from left side.

    tmp_best_final_records := join(ds_in_ids, CompanyDerivedStartDate,
          left.ultid = right.ultid AND
          left.orgid = right.orgid AND
          left.seleid = right.seleid,

		transform({string10 phone; string3 timezone; TopBusiness_Services.BestSection_Layouts.Final},
            self.acctno := left.acctno,
            self.BusinessIds.DotID := left.dotid, // getting from original input
            self.BusinessIds.empid := left.empid,
            self.BusinessIds.powid := left.powid,
            self.BusinessIds.proxid := left.proxid,
            self.BusinessIds.seleid := left.seleid,
            self.BusinessIds.orgid := left.orgid,
            self.BusinessIds.ultid := left.ultid,
            self.CompanyName := right.company_name[1].company_name,
            self.CompanyNameSource := '';
            self.CompanyNameSourceDocId := project(right.company_name[1].sources, transform({string34 vl_id;},
            self.vl_id := left.vl_id))[1].vl_id;
            self.TIN := right.company_fein[1].company_fein,
            self.TINSource := project(right.company_fein[1].sources, transform({string2 source;},
                self.source := left.source))[1].source;
                self.Ticker := ''; //right.Ticker  field removed
                self.Exchange := ''; //right.Exchange field removed
                tmpUrl := right.company_url[1].company_url;
                SlashPosition := std.str.find(tmpurl,'/',1);
                self.URL := if (tmpurl <> '' and SlashPosition > 1,  tmpUrl[1..slashPosition-1], tmpUrl);
                self.Address.StreetNumber := right.company_address[1].company_prim_range,
                self.Address.StreetPreDirection := right.company_address[1].company_predir,
                self.Address.StreetName := right.company_address[1].company_prim_name,
                self.Address.StreetSuffix := right.company_address[1].company_addr_suffix,
                self.Address.StreetPostDirection := right.company_address[1].company_postdir,
                self.Address.UnitDesignation := right.company_address[1].company_unit_desig,
                self.Address.UnitNumber := right.company_address[1].company_sec_range,
                self.address.city := right.company_address[1].address_v_city_name,
                self.Address.State := right.company_address[1].company_st,
                self.Address.ZIP5 := right.company_address[1].company_zip5,
                self.Address.Zip4 := right.company_address[1].company_zip4,
                self.Address.County := right.company_address[1].county_name;

             tmpPhone := right.company_phone[1].company_phone;
               self.phoneInfo.Phone10 := tmpPhone;
            // not set here but set later.
           self.timezone := '';
           self.PhoneFromDate := iesp.ecl2esp.toDateString8('');
           self.PhoneToDate := iesp.ecl2esp.ToDatestring8('');
           self.phone := tmpPhone;

           self.WirelessIndicator := if (tmpPhone <> '', 'L',''); // default it phone to landline
           // changed later to 'W' (wireless) if we have a entry for it
           // in cell phone keys.
           self.Fax := right.fax,
           self.YearStarted := right.year_Started,

           self.YearStartedSource := '' ;//right.yearStartedSource;
           self.YearStartedSourceDocid := '' ; //right.yearStartedSourceDocID;
           self.yearStartedDerived := right.YearStartedDerived;
           self.YearsInBusiness   := (unsigned2)right.years_inBusiness,
           self.IsDefunct         := right.IsDefunct;
           self.IsActive := right.isActive;
           self.countOtherTins := count(FinalTinVariations);
           self.TotalCountOtherTins := if (count(FinalTinVariations) <= iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FEINS,
                       count(FinalTinVariations),iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FEINS);
          self.totalCountOtherCompanies := count(FinalCompanyNameVariations);
          self.CountOtherCompanies := if (count(FinalCompanyNameVariations) <= 
                       iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_OTHER_COMPANIES, count(FinalCompanyNameVariations),
           iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_OTHER_COMPANIES);
            // boolean option to add these 2 DS (finalccompanynamevariations and
            // finalTinVariations  is taken care above.
            self.OthercompanyNames := choosen(FinalCompanyNameVariations ,iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_OTHER_COMPANIES);
            self.OthercompanyTins := choosen(FinalTinVariations ,iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_OTHER_COMPANIES);
            self.AddressFromDate := iesp.ECL2ESP.toDate(RIGHT.company_name[1].dt_first_seen);
            self.AddressToDate :=  iesp.ECL2ESP.toDate(RIGHT.company_name[1].dt_last_seen);
            self.BestSicCode   :=  right.sic_code[1].company_sic_code1;
            Self.BestNaicsCode := right.naics_code[1].company_naics_code1;
            self := []),
            left outer
         );

      TopBusiness_Services.Macro_AppendWirelessIndicator(tmp_best_final_records, tmp_best_final_recordsWWirelessINdicator);
           ds_phone_final := join(tmp_best_final_recordsWWirelessINdicator, unique_phones_gong_rolled,
                                                 left.businessIDs.ultid  = right.ultid AND
                                                 left.businessIDs.orgid  = right.orgid AND
                                                 left.businessIDs.seleid = right.seleid AND
                                                 left.PhoneInfo.Phone10 = right.company_phone,
         transform(recordof(tmp_best_final_records),
                 self.phoneInfo.phone10 := left.phoneInfo.phone10;
			 self.PhoneInfo.ListingName := right.listed_name,
			 self.phoneInfo.timezone := left.timezone;
			 self.PhoneType := right.phone_type,
			 self.ActiveEDA := map (right.active_eda = 'Y' => true,
			                             right.active_eda = 'N' => false,
																	 false);
		      tmpdisconnected := map( right.disconnected = 'Y' => true,
			                                right.disconnected = 'N' => false,
																			false);
                self.Disconnected := tmpDisconnected;
                tmpFromDate := if (right.from_date <> '', right.from_date, right.from_dateNotCurrent);
                tmpToDate := if (right.to_date <> '', right.to_date, right.to_dateNotCurrent);		
                self.PhoneFromDate := iesp.ECL2ESP.toDate((unsigned) tmpFromDate),
			self.PhoneToDate := iesp.ECL2ESP.toDate((unsigned) tmpToDate),
			self.IsActive :=  // OVERRIDE BUS HEADER DATA
                left.isActive OR (right.active_EDA = 'Y' and
                    (ut.StringSimilar(left.CompanyName ,right.listed_name) <= TopBusiness_Services.Constants.STRINGSIMILARCONSTANT));

                self.IsDefunct := left.IsDefunct and (NOT(right.active_EDA = 'Y' and right.phone_type = 'B'));
                self := left),
           left outer);

           ds_final_records := project(ds_phone_final,
           transform(TopBusiness_Services.BestSection_Layouts.Final,
           self := left));
           // final_records := best_final_records;
		// output(ds_in_ids, named('ds_in_ids'));
          // output(ds_in_unique_ids_onlyForHeader, named('ds_in_unique_ids_onlyForHeader'));
         // output(ds_in_unique_ids_only, named('ds_in_unique_ids_only'));
         //output(ds_initial_best, named('ds_initial_best')); 
         // output(ds_phone_info , named('ds_phone_info'));
          // output(unique_phones_wgongdata, named('unique_phones_wgongdata'));
          //output(unique_phones_against_names, named('unique_phones_against_names'));
          // output(unique_phones_gong_rolled, named('unique_phones_gong_rolled'));
    
          // output(choosen(ds_slimBusHeaderRecs, 3000), named('ds_slimbusheaderRecs'));
          // output(ds_busHeaderRecs, named('ds_busHeaderRecs'));
          // output(choosen(ds_slimBusHeaderRecs,4000), named('ds_slimBusHeaderRecs'));
           //output(ds_slimBusHeaderRecsPre, named('ds_slimBusHeaderRecsPre'));
           //output(ds_slimBusHeaderRecs, named('ds_slimBusHeaderRecs'));
             // output(ds_slimBusHeaderRecsFinal, named('ds_slimBusHeaderRecsFinal'));
             //output(ds_busHeaderRecsTinVariations , named('ds_busHeaderRecsTinVariations'));
            // output(ds_year_startedFromBest, named('ds_year_startedFromBest'));
            // output(CompActiveRecs, named('CompActiveRecs'));
            //output(IsCompanyActiveRecs, named('IsCompanyActiveRecs'));
            // output(CompActiveRecsLastReported, named('CompActiveRecsLastReported'));

             //  output(tmpOtherCompanyNameVariationsPre, named('tmpOtherCompanyNameVariationsPre'));
            // output(tmpOtherCompanyNameVariations, named('tmpOtherCompanyNameVariations'));
           // output(tmpOtherCompanyNameVariationsAll, named('tmpOtherCompanyNameVariationsAll'));
           // output(BestRowCname, named('BestRowCname'));
           // output(tmpOtherTinVariations, named('tmpOtherTinVariations'));
          // output(tmpOtherTinVariationsReduced, named('tmpOtherTinVariationsReduced'));
           // output(tmpOtherTinVariationsSlim, named('tmpOtherTinVariationsSlim'));
            // output(otherTinVariations, named('otherTinVariations'));
           // output(otherTins, named('otherTins'));
           // output(twoYearBackDateLastSeen, named('twoYearBackDateLastSeen'));
          // output(CompanyDerivedStartDate, named('CompanyDerivedStartDate'));
          // output(tmpdtVendorFirstReportedAppended, named('tmpdtVendorFirstReportedAppended'));
          // output(tmpDateVendorFirstReported, named('tmpDateVendorFirstReported'));
         // output(tickerInfo, named('tickerInfo'));
           // output(tickerBestRecs, named('ticker'));
          // output(tmpFinalTinVariationsBestRowOnly, named('tmpFinalTinVariationsBestRowOnly'));
          // output(FinalTinVariationsBestRowOnlyMasked, named('FinalTinVariationsBestRowOnlyMasked'));
          // output(FinalCompanyNameVariationsWithOutBestRow, named('FinalCompanyNameVariationsWithOutBestRow'));
         // output(FinalCompanyNameVariationsBestRowOnly, named('FinalCompanyNameVariationsBestRowOnly'));
         // output(FinalCompanyNameVariations, named('FinalCompanyNameVariations'));
        // output(FinalTinVariationsWithOutTinBest, named('FinalTinVariationsWithOutTinBest'));
       // output(FinalTinVariationsBestRowOnly, named('FinalTinVariationsBestRowOnly'));
        // output(tmpFinalTinVariations, named('tmpFinalTinVariations'));
         // output(FinalTinVariations, named('FinalTinVariations'));
          // output(best_final_records_suppressedFein, named('best_final_records_suppressedFein'));
         //output(ds_phone_final, named('ds_phone_final'));
         // output(ds_final_records, named('ds_final_records'));   
		return ds_final_records;
	end;
end;
