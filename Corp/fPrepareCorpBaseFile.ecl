export fPrepareCorpBaseFile(
							 dataset(Layout_Corp_Base)	pInput

) :=
function

	// Propagate Status Information from current record for corp_key to all records
	corp_base_init_dist			:= distribute(pInput, hash(corp_key));
	corp_base_init_sort			:= sort(	corp_base_init_dist	,corp_key	,local);
	corp_base_init_grpd			:= group(	corp_base_init_sort	,corp_key	,local);
	corp_base_init_grpd_sort	:= sort(corp_base_init_grpd, if(record_type = 'C', 0, 1), -dt_last_seen);

	Layout_Corp_Base PropagateStatus(Layout_Corp_Base l, Layout_Corp_Base r) :=
	transform
		status_are_blanks := l.corp_status_cd = '' and l.corp_status_desc = '' and l.corp_status_date = '';
		
		self.corp_status_cd		:= if(status_are_blanks, r.corp_status_cd	, l.corp_status_cd);
		self.corp_status_desc	:= if(status_are_blanks, r.corp_status_desc	, l.corp_status_desc);
		self.corp_status_date	:= if(status_are_blanks, r.corp_status_date	, l.corp_status_date);
		self := r;
	END;

	corp_base_status := group(iterate(corp_base_init_grpd_sort, PropagateStatus(left, right)));


	return corp_base_status;

end;