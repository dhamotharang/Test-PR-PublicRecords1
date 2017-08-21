import corp2;

export Prep_CorpV2 :=
module
	
	// get filing dates from event corporate filing records in case of blank corp filing date on corp record
	// then filter out all dates newer than 20091009
	export fCorp(

		 string																							pFilterDate			= _Dataset().CurrentDate
		,dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pCorp						= corp2.files().base.corp.qa
		,dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pCorpEvent			= corp2.files().base.events.qa
	
	):=
	function

/*		
		export dcorp_with_filing_date			:= pCorp((unsigned8)corp_filing_date != 0);
		export dcorp_without_filing_date	:= pCorp((unsigned8)corp_filing_date  = 0);
		
		export dprep_event := pCorpEvent((unsigned8)event_filing_date != 0,(unsigned8)event_filing_date <=  pFilterDate,corp_key != '',regexfind('(filing|filed)',event_filing_desc,nocase));
		
		export dget_filing_date := join(
			 distribute(dcorp_without_filing_date	,hash64(corp_key))
			,distribute(dprep_event								,hash64(corp_key))
			,left.corp_key = right.corp_key
			and (unsigned4)right.corp_process_date between left.dt_vendor_first_reported and left.dt_vendor_last_reported
			,transform(
				 Corp2.Layout_Corporate_Direct_Corp_Base
				,self.corp_filing_date := right.event_filing_date;
				 self := left;
			)
			,local
			,keep(1)
		);
		
		export dget_filing_date_else := join(
			 distribute(dcorp_without_filing_date	,hash64(corp_key))
			,distribute(dprep_event								,hash64(corp_key))
			,left.corp_key = right.corp_key
			and (unsigned4)right.corp_process_date between left.dt_vendor_first_reported and left.dt_vendor_last_reported
			,transform(
				 Corp2.Layout_Corporate_Direct_Corp_Base
				,self.corp_filing_date := right.event_filing_date;
				 self := left;
			)
			,local
			,left only
		);
		
		export dcorpv2_all := dcorp_with_filing_date + dget_filing_date + dget_filing_date_else;
		
		export dcorpv2_all_filt := dcorpv2_all((unsigned8)corp_filing_date <= pFilterDate or (unsigned8)corp_filing_date = 0);

		export countpCorp := count(pCorp);
		export countpCorpEvent := count(pCorpEvent);
		export countdcorp_with_filing_date := count(dcorp_with_filing_date);
		export countdcorp_without_filing_date := count(dcorp_without_filing_date);
		export countdprep_event := count(dprep_event);
		export countdget_filing_date := count(dget_filing_date);
		export countdget_filing_date_else := count(dget_filing_date_else);
		export countdcorpv2_all := count(dcorpv2_all);
		
		return dcorpv2_all_filt;
*/
		return Filters.fCorpV2(pCorp);
		
	end;

	export fEvent(

		 string																							pFilterDate			= _Dataset().CurrentDate
		,dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pCorpEvent			= corp2.files().base.events.qa
	
	):=
	function
		
		dprep_event := Filters.fEvent(pCorpEvent);
		
		return dprep_event;
		
	end;

	export fCont(

		 string																							pFilterDate			= _Dataset().CurrentDate
		,dataset(Corp2.Layout_Corporate_Direct_Cont_Base	) pCorpCont				= corp2.files().base.cont.qa
	
	):=
	function
		
		dprep_cont := Filters.fcont(pCorpCont);
		
		return dprep_cont;
		
	end;

end;