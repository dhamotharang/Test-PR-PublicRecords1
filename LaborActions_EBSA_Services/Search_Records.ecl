IMPORT AutoStandardI, ut, iesp, FCRA;

EXPORT Search_Records := MODULE

	EXPORT getFormatedRecords(DATASET(Layouts.rawrec) recs, IParam.searchrecords in_mod):= FUNCTION
		 
		// Filter by input date range if it was supplied
		ds_filt :=  recs(ut.isInRange(closing_date,in_mod.ClosingStartDate,in_mod.ClosingEndDate));
		
		recs_filt := if(in_mod.ClosingStartDate != '' or in_mod.ClosingEndDate != '',ds_filt,recs);
		
		// Calculate the penalty on the records
		recs_plus_pen := project(recs_filt,transform(Layouts.rawrec,
			tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
				export cname_field := left.plan_administrator;
			end;
		
		  tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempindvmod);
			 
			self.penalt := tempPenaltBiz;
			self := left));
    
		// Format for output				
		
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
		recs_pen := recs_plus_pen (penalt <= pthreshold_translated);

		// sort by penalty, business name and date updated.
		recs_sort := sort(recs_pen,penalt,plan_administrator,plan_administrator,-closing_date,record);
		
		// Format into iesp layout
		iesp.LaborAction_EBSA.t_LaborAction_EBSARecord xfm_iesp(Layouts.rawrec l) := TRANSFORM
				SELF.Plan.Number := l.plan_no;
				SELF.Plan.Ein := l.plan_ein;
				SELF.Plan.Year := l.plan_year;
				SELF.Plan.Name := l.plan_name;
				SELF.Plan.Administrator := l.plan_administrator;
				
				SELF.Admin.State := l.admin_state;
				SELF.Admin.Zip5 := l.admin_zip_code;
				SELF.Admin.Zip4 := l.admin_zip_code4;

				SELF.CaseType := l.casetype;
				SELF.Website := l.Website;
				SELF.State := l.State;
				SELF.ClosingReason := l.closing_reason;
				SELF.ClosingDate := iesp.ECL2ESP.toDatestring8(l.closing_date);
				SELF.PenaltyAmount := l.penalty_amount;
		END;
		
		recsresults := PROJECT(recs_sort,xfm_iesp(LEFT));
		
		//Dedup Recs
		results_dedup := DEDUP(recsresults,RECORD,ALL,HASH);
		
		return(results_dedup);
	end;
	
	EXPORT val(IParam.searchrecords in_mod) := FUNCTION

		// get records from input criteria.
		recs := Search_IDs.val(in_mod);
 
		finalresults :=	getFormatedRecords(recs,in_mod);

		RETURN(finalresults);
	END;
END;