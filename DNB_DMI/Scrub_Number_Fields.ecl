import std,tools;
export Scrub_Number_Fields( 
	 dataset(Layouts.Input.Sprayed	)	pRawFileInput
	,string														pversion
	,string														pPersistname = persistnames().AppendCompanyDates
) :=
function

	Layouts.base.CompaniesChild tPreProcess(Layouts.Input.Sprayed l) :=
	transform
		
		mmdd	:= l.report_date[1..4];
		yyyy	:= if((unsigned)l.report_date[5..6] > (unsigned)((string8)std.date.today())[3..4]
								,'19' + l.report_date[5..6]
								,'20' + l.report_date[5..6]
						);
		fulldate := (unsigned4)(yyyy + mmdd);

		self.date_first_seen															:= fulldate									;
		self.date_last_seen																:= fulldate									;
		self.date_vendor_first_reported										:= (unsigned4)pversion			;
		self.date_vendor_last_reported										:= (unsigned4)pversion			;
		self.clean_mail_address														:= []												;
		self.clean_address																:= []												;
		self.rawfields.annual_sales_volume_sign						:= utilities.Fieldsign					(l.annual_sales_volume						);
		self.rawfields.annual_sales_volume								:= utilities.SignedField				(l.annual_sales_volume						);  //signed field
		self.rawfields.employees_here_sign								:= utilities.Fieldsign					(l.employees_here									);
		self.rawfields.employees_here											:= utilities.SignedField				(l.employees_here									);  //signed field
		self.rawfields.employees_total_sign								:= utilities.Fieldsign					(l.employees_total								);
		self.rawfields.employees_total										:= utilities.SignedField				(l.employees_total								); //signed field
		self.rawfields.net_worth_sign											:= utilities.Fieldsign					(l.net_worth											);
		self.rawfields.net_worth													:= utilities.SignedField				(l.net_worth											);  //signed field
		self.rawfields.trend_sales_sign										:= utilities.Fieldsign					(l.trend_sales										);
		self.rawfields.trend_sales												:= utilities.SignedField				(l.trend_sales										);  //signed field
		self.rawfields.trend_employment_total_sign				:= utilities.Fieldsign					(l.trend_employment_total					);
		self.rawfields.trend_employment_total							:= utilities.SignedField				(l.trend_employment_total					);  //signed field
		self.rawfields.base_sales_sign										:= utilities.Fieldsign					(l.base_sales											);
		self.rawfields.base_sales													:= utilities.SignedField				(l.base_sales											);  //signed field
		self.rawfields.base_employment_total_sign					:= utilities.Fieldsign					(l.base_employment_total					);
		self.rawfields.base_employment_total							:= utilities.SignedField				(l.base_employment_total					);  //signed field
		self.rawfields.percentage_sales_growth_sign 			:= utilities.Fieldsign					(l.percentage_sales_growth				);
		self.rawfields.percentage_sales_growth						:= utilities.SignedField				(l.percentage_sales_growth				);  //signed field
		self.rawfields.percentage_employment_growth_sign	:= utilities.Fieldsign					(l.percentage_employment_growth		);
		self.rawfields.percentage_employment_growth				:= utilities.SignedField				(l.percentage_employment_growth		);  //signed field
		self.rawfields.date_of_incorporation 							:= utilities.SwitchDate					(l.date_of_incorporation					);
		self.rawfields.annual_sales_revision_date 				:= utilities.SwitchDate					(l.annual_sales_revision_date			);
		self.rawfields.hot_list_new_change_date 					:= utilities.CvtDate4to6				(l.hot_list_new_change_date				);
		self.rawfields.hot_list_ownership_change_date 		:= utilities.CvtDate4to6				(l.hot_list_ownership_change_date	);
		self.rawfields.hot_list_ceo_change_date 					:= utilities.CvtDate4to6				(l.hot_list_ceo_change_date				);
		self.rawfields.hot_list_company_name_chg_date 		:= utilities.CvtDate4to6				(l.hot_list_company_name_chg_date	);
		self.rawfields.hot_list_address_change_date 			:= utilities.CvtDate4to6				(l.hot_list_address_change_date		);
		self.rawfields.hot_list_telephone_change_date 		:= utilities.CvtDate4to6				(l.hot_list_telephone_change_date	);
		self.rawfields.report_date 												:= utilities.CvtDate6to8				(l.report_date										);
		self.rawfields.square_footage 										:= utilities.RemoveLeadingZeros	(l.square_footage									);
		self.rawfields.number_of_accounts 								:= utilities.RemoveLeadingZeros	(l.number_of_accounts							);
		self.rawfields.parent_duns_number									:= utilities.BlankIfZero				(l.parent_duns_number							);
		self.rawfields.ultimate_duns_number 							:= utilities.BlankIfZero				(l.ultimate_duns_number						);
		self.rawfields.headquarters_duns_number 					:= utilities.BlankIfZero				(l.headquarters_duns_number				);
		self.rawfields.bank_duns_number 									:= utilities.BlankIfZero				(l.bank_duns_number								);
		self.rawfields.dias_code 													:= utilities.RemoveLeadingZeros	(l.dias_code											);
		self.rawfields.hierarchy_code 										:= utilities.RemoveLeadingZeros	(l.hierarchy_code									);
		self.rawfields.telephone_number 									:= utilities.BlankIfZero				(l.telephone_number								);
		self.rawfields.year_started 											:= utilities.BlankIfZero				(l.year_started										);
		self.rawfields.msa_code 													:= utilities.BlankIfZero				(l.msa_code												);
		self.record_type																	:= 0;
		self.active_duns_number 													:= 'Y';
		self.rawfields																		:= l												;
		self																							:= []												;
	end;
	
	dPreProcess := project(pRawFileInput, tPreProcess(left));
	tools.mac_RedefineFormat(dPreProcess		,Layouts.base.companies		,dRedef		,,[30]	);
	dRedef_persisted := dRedef 
			: persist(pPersistname);

	return dRedef_persisted;

end;
