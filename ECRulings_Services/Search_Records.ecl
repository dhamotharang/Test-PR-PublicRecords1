IMPORT AutoStandardI, ut, iesp, ECRulings;

EXPORT Search_Records := MODULE

	EXPORT getFormatedRecords(DATASET(ECRulings.Layouts.Clean_comp_DeciPub_EconomicAct_Eventdoc) recs, IParam.searchrecords in_mod):= FUNCTION
							
		 // Filter by input date range if it was supplied
    ds_filt := recs(ut.isInRange(LastDecisionDate,in_mod.DecisionStartDate,in_mod.DecisionEndDate));

    recs_filt := if(in_mod.DecisionStartDate != '' or in_mod.DecisionEndDate != '',ds_filt,recs);
		
		//Calculate the penalty on the records
		recs_plus_pen := project(recs_filt,transform(Layouts.rawrec,
			tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
				export cname_field := left.BusinessName;
			end;
		
		  tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempindvmod);
			 
			self.penalt := tempPenaltBiz;
			self := left));
    
		// Format for output				
		
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
		recs_pen := recs_plus_pen (penalt <= pthreshold_translated);
		
		// sort, note companies with the same euid and casenumber have the same business name.
		recs_sort := SORT(recs_pen,penalt,euid,casenumber,businessname,RECORD);
		recs_grouped := group(recs_sort,penalt,euid,casenumber);
		
		// Format into iesp layout
		iesp.ECRuling.t_ECRulingsRecord xfm_iesp(Layouts.rawrec l,DATASET(Layouts.rawrec) allrows) := TRANSFORM
				SELF.State := l.state;
				SELF.CountryCode := l.EU_country_code;
				SELF.Euid := l.EUID;
				SELF.PolicyArea := l.PolicyArea;
				SELF.CaseNumber := l.CaseNumber;
				SELF.MemberState := l.MemberState;
				SELF.LastDecisionDate := iesp.ECL2ESP.toDatestring8(l.LastDecisionDate);
				SELF.Title := l.Title;
				SELF.Name.CompanyName := l.BusinessName;
				SELF.Name := [];
				SELF.Region := l.Region;
				SELF.PrimaryObjective := l.PrimaryObjective;
				SELF.AidInstrument := l.AidInstrument;
				SELF.CaseType := l.CaseType;
				SELF.DurationDateFrom := iesp.ECL2ESP.toDatestring8(l.DurationDateFrom);
				SELF.DurationDateTo := iesp.ECL2ESP.toDatestring8(l.DurationDateTo);
				SELF.NotificationRegistrationDate := iesp.ECL2ESP.toDatestring8(l.NotificationRegistrationDate);
				SELF.DGResponsible := l.DGResponsible;
				
				RelCaseRecs := DATASET([{l.RelatedCaseNumber1,l.RelatedCaseInformation1},
																{l.RelatedCaseNumber2,l.RelatedCaseInformation2},
																{l.RelatedCaseNumber3,l.RelatedCaseInformation3},
																{l.RelatedCaseNumber4,l.RelatedCaseInformation4},
																{l.RelatedCaseNumber5,l.RelatedCaseInformation5}],iesp.ecRuling.t_ecRulingsRelatedCaseRecord);
				SELF.RelatedCaseRecs := RelCaseRecs(Number !='' or Information!=''); //removed empty records
				
				SELF.Provisional.DeadLineDate := iesp.ECL2ESP.toDatestring8(l.ProvisionalDeadlineDate);
				SELF.Provisional.DeadLineArticle := l.ProvisionalDeadlineArticle;
				SELF.Provisional.DeadLineStatus := l.ProvisionalDeadlineStatus;
				SELF.Regulation := l.Regulation;
				SELF.RelatedLink := l.RelatedLink;
				
				// added deduping since most of the records here are duplicates (empty or contain just zeros)
				SELF.Decisions := DEDUP(PROJECT(CHOOSEN(allrows,iesp.Constants.EC_RULING.MaxDecisions),
																	TRANSFORM(iesp.ECRuling.t_ecRulingsDecisionRecord,
																						SELF.PubId := LEFT.DecPubID,
																						SELF.Date := iesp.ECL2ESP.toDatestring8(LEFT.DecisionDate),
																						SELF.Article := LEFT.DecisionArticle,
																						SELF.Details := LEFT.DecisionDetails)),
																		RECORD,ALL);
				
				SELF.PressReleases := DEDUP(PROJECT(CHOOSEN(allrows,iesp.Constants.EC_RULING.MaxPressRelease),
																	TRANSFORM(iesp.ECRuling.t_ecRulingsPressRecord,
																						SELF.Release := LEFT.PressRelease,
																						SELF.Date := iesp.ECL2ESP.toDatestring8(LEFT.PressReleaseDate))),
																		RECORD,ALL);
				
				SELF.PublicationJournals := DEDUP(PROJECT(CHOOSEN(allrows,iesp.Constants.EC_RULING.MaxPublicationJournals),
																	TRANSFORM(iesp.ECRuling.t_ecRulingsPubJournalRecord,
																						SELF.Date := iesp.ECL2ESP.toDatestring8(LEFT.PublicationJournalDate),
																						SELF.Journal := LEFT.PublicationJournal,
																						SELF.Edition := LEFT.PublicationJournalEdition,
																						SELF.Year := LEFT.PublicationJournalYear,
																						SELF.PriorDate := iesp.ECL2ESP.toDatestring8(LEFT.PublicationPriorJournalDate),
																						SELF.PriorJournal := LEFT.PublicationPriorJournal)),
																			   RECORD,ALL);
																					
				SELF.EconomicActivity.ID := l.EconActID;
				SELF.EconomicActivity.Activity := l.EconomicActivity;
				SELF.Events.Id := l.CompEventID;
				SELF.Events.Date := iesp.ECL2ESP.toDatestring8(l.EventDate);
				SELF.Events.Doctype := l.EventDocType;
				SELF.Events.Document := l.EventDocument;
				
		END;
		
		recsresults := ROLLUP(recs_grouped,group,xfm_iesp(LEFT,rows(left)));
		
		return(recsresults);
	end;
	
	EXPORT val(IParam.searchrecords in_mod) := FUNCTION

		// get records from input criteria.
		recs := ECRulings_Services.Search_IDs.val(in_mod);
 
		finalresults :=	getFormatedRecords(recs,in_mod);
		RETURN(finalresults);

	END;
END;