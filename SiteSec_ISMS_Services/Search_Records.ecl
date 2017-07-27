IMPORT AutoStandardI, ut, iesp, FCRA;

EXPORT Search_Records := MODULE

	EXPORT getFormatedRecords(DATASET(Layouts.rawrec) recs, IParam.searchrecords in_mod):= FUNCTION
		 
		//Dedup Recs
		recs_dedup := DEDUP(SORT(recs,businessname,businesslocation,businessdba,country,certificatenumber,certificationbody,certificationtype,RECORD),
												businessname,businesslocation,businessdba,country,certificatenumber,certificationbody,certificationtype);
		
		// Calculate the penalty on the records
		recs_plus_pen := project(recs_dedup,transform(Layouts.rawrec,
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

		// sort by penalty, business name and date updated.
		recs_sort := sort(recs_pen,penalt,BusinessName,-DateUpdated,record);
		
		// Format into iesp layout
		iesp.siteSecurity.t_siteSecurityRecord xfm_iesp(Layouts.rawrec l) := TRANSFORM
				SELF.Name.CompanyName := l.BusinessName;
				SELF.Name := [];
				SELF.DBAName := l.BusinessDBA;
				SELF.Location := l.BusinessLocation;
				SELF.Website := l.Website;
				SELF.State := l.State;
				SELF.Country := l.Country;
				
				SELF.Certification.Number := l.CertificateNumber;
				SELF.Certification.Body := l.CertificationBody;
				SELF.Certification.BodyDescription := l.CertificationBodyDescrip;
				SELF.Certification._Type := l.CertificationType;
		END;
		
		recsresults := PROJECT(recs_sort,xfm_iesp(LEFT));

		return(recsresults);
	end;
	
	EXPORT val(IParam.searchrecords in_mod) := FUNCTION

		// get records from input criteria.
		recs := Search_IDs.val(in_mod);
 
		finalresults :=	getFormatedRecords(recs,in_mod);
	
		RETURN(finalresults);
	END;
END;