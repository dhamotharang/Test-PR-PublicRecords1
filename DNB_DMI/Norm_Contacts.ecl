import STD;

export Norm_Contacts(

	 dataset(Layouts.input.Sprayed	)	pSprayedFile
	,string														pversion

) :=
function

	dnormcontacts  := normalize(pSprayedFile, left.exec_names, transform(layouts.input.contacts,

		self													:= right												;
		self.duns_number  						:= left.duns_number							;
		self.business_name						:= left.business_name						;
		self.report_date            	:= left.report_date							;
		self.delete_record_indicator	:= left.delete_record_indicator	;
	
	))(exec_last_name != '',delete_record_indicator = '');

	dsetDates	:= project(dnormcontacts,transform(Layouts.Base.contacts,

		mmdd	:= left.report_date[1..4];
		yyyy	:= if((unsigned)left.report_date[5..6] > (unsigned)((string8)std.date.today())[3..4]
								,'19' + left.report_date[5..6]
								,'20' + left.report_date[5..6]
						);
		fulldate := (unsigned4)(yyyy + mmdd);

		self.date_first_seen															:= fulldate									;
		self.date_last_seen																:= fulldate									;
		self.date_vendor_first_reported										:= (unsigned4)pversion			;
		self.date_vendor_last_reported										:= (unsigned4)pversion			;
		self.rawfields																		:= left											;
		self.company_name																	:= left.business_name				;
		self																							:= left											;
		self																							:= []												;
	
	
	));
	
	return dsetDates;

end;