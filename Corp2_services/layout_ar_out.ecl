export layout_ar_out := RECORD

	unsigned4 dt_last_seen;
	unsigned4 corp_process_date;
	string4   ar_year;
	string8   ar_mailed_dt;
	string8   ar_due_dt;
	string8   ar_filed_dt;
	string8   ar_report_dt;
	string30  ar_report_nbr;
	string8   ar_franchise_tax_paid_dt;
	string8   ar_delinquent_dt;
	string10  ar_tax_factor;
	string10  ar_tax_amount_paid;
	string10  ar_annual_report_cap;
	string10  ar_illinois_capital;
	string10  ar_roll;
	string10  ar_frame;
	string10  ar_extension;
	string10  ar_microfilm_nbr;
	string350 ar_comment;
	string60   ar_type;
	end;