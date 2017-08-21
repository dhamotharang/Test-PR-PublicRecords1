import dnb_dmi;
EXPORT files := module

	EXPORT dnb_in := DATASET('~PRTE::IN::dnb::Companies', Layouts.Layout_In, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	
  Export dnb_base_plus := DATASET('~PRTE::BASE::dnb', Layouts.Layout_DNB_Base_Plus,flat );
	
	EXPORT dnb_base := Project(dnb_base_plus, Layouts.Layout_DNB_Base );
	
	base_bdid := project(dnb_base,  
		TRANSFORM(		layouts.bdid_layout, 
						SELF.bd := LEFT.bdid, 
						SELF.duns_number := LEFT.duns_number));
	
	EXPORT DNB_BDID := dedup(base_bdid,
					LEFT.BD=RIGHT.bd and 
					LEFT.DUNS_NUMBER=RIGHT.duns_number);

	Layouts.CompaniesForBIP2 xformLinkID(dnb_base_plus l) := transform
		SELF.date_first_seen := (integer)l.date_first_seen;
		SELF.date_last_seen := (integer)l.date_last_seen;
		SELF.record_type := (integer)l.record_type;
		self.date_vendor_first_reported										:= (integer)l.date_vendor_first_reported;
		self.date_vendor_last_reported										:= (integer)self.date_vendor_first_reported;
		self.clean_mail_address														:= [];
		self.clean_address																:= []			;
		self.rawfields.annual_sales_volume_sign						:= dnb_dmi.utilities.Fieldsign					(l.annual_sales_volume						);
		self.rawfields.annual_sales_volume								:= dnb_dmi.utilities.SignedField				(l.annual_sales_volume						);  //signed field
		self.rawfields.employees_here_sign								:= dnb_dmi.utilities.Fieldsign					(l.employees_here									);
		self.rawfields.employees_here											:= dnb_dmi.utilities.SignedField				(l.employees_here									);  //signed field
		self.rawfields.employees_total_sign								:= dnb_dmi.utilities.Fieldsign					(l.employees_total								);
		self.rawfields.employees_total										:= dnb_dmi.utilities.SignedField				(l.employees_total								); //signed field
		self.rawfields.net_worth_sign											:= dnb_dmi.utilities.Fieldsign					(l.net_worth											);
		self.rawfields.net_worth													:= dnb_dmi.utilities.SignedField				(l.net_worth											);  //signed field
		self.rawfields.trend_sales_sign										:= dnb_dmi.utilities.Fieldsign					(l.trend_sales										);
		self.rawfields.trend_sales												:= dnb_dmi.utilities.SignedField				(l.trend_sales										);  //signed field
		self.rawfields.trend_employment_total_sign				:= dnb_dmi.utilities.Fieldsign					(l.trend_employment_total					);
		self.rawfields.trend_employment_total							:= dnb_dmi.utilities.SignedField				(l.trend_employment_total					);  //signed field
		self.rawfields.base_sales_sign										:= dnb_dmi.utilities.Fieldsign					(l.base_sales											);
		self.rawfields.base_sales													:= dnb_dmi.utilities.SignedField				(l.base_sales											);  //signed field
		self.rawfields.base_employment_total_sign					:= dnb_dmi.utilities.Fieldsign					(l.base_employment_total					);
		self.rawfields.base_employment_total							:= dnb_dmi.utilities.SignedField				(l.base_employment_total					);  //signed field
		self.rawfields.percentage_sales_growth_sign 			:= dnb_dmi.utilities.Fieldsign					(l.percentage_sales_growth				);
		self.rawfields.percentage_sales_growth						:= dnb_dmi.utilities.SignedField				(l.percentage_sales_growth				);  //signed field
		self.rawfields.percentage_employment_growth_sign	:= dnb_dmi.utilities.Fieldsign					(l.percentage_employment_growth		);
		self.rawfields.percentage_employment_growth				:= dnb_dmi.utilities.SignedField				(l.percentage_employment_growth		);  //signed field
		self.rawfields.date_of_incorporation 							:= dnb_dmi.utilities.SwitchDate					(l.date_of_incorporation					);
		self.rawfields.annual_sales_revision_date 				:= dnb_dmi.utilities.SwitchDate					(l.annual_sales_revision_date			);
		self.rawfields.hot_list_new_change_date 					:= dnb_dmi.utilities.CvtDate4to6				(l.hot_list_new_change_date				);
		self.rawfields.hot_list_ownership_change_date 		:= dnb_dmi.utilities.CvtDate4to6				(l.hot_list_ownership_change_date	);
		self.rawfields.hot_list_ceo_change_date 					:= dnb_dmi.utilities.CvtDate4to6				(l.hot_list_ceo_change_date				);
		self.rawfields.hot_list_company_name_chg_date 		:= dnb_dmi.utilities.CvtDate4to6				(l.hot_list_company_name_chg_date	);
		self.rawfields.hot_list_address_change_date 			:= dnb_dmi.utilities.CvtDate4to6				(l.hot_list_address_change_date		);
		self.rawfields.hot_list_telephone_change_date 		:= dnb_dmi.utilities.CvtDate4to6				(l.hot_list_telephone_change_date	);
		self.rawfields.report_date 												:= dnb_dmi.utilities.CvtDate6to8				(l.report_date										);
		self.rawfields.square_footage 										:= dnb_dmi.utilities.RemoveLeadingZeros	(l.square_footage									);
		self.rawfields.number_of_accounts 								:= dnb_dmi.utilities.RemoveLeadingZeros	(l.number_of_accounts							);
		self.rawfields.parent_duns_number									:= dnb_dmi.utilities.BlankIfZero				(l.parent_duns_number							);
		self.rawfields.ultimate_duns_number 							:= dnb_dmi.utilities.BlankIfZero				(l.ultimate_duns_number						);
		self.rawfields.headquarters_duns_number 					:= dnb_dmi.utilities.BlankIfZero				(l.headquarters_duns_number				);
		self.rawfields.bank_duns_number 									:= dnb_dmi.utilities.BlankIfZero				(l.bank_duns_number								);
		self.rawfields.dias_code 													:= dnb_dmi.utilities.RemoveLeadingZeros	(l.dias_code											);
		self.rawfields.hierarchy_code 										:= dnb_dmi.utilities.RemoveLeadingZeros	(l.hierarchy_code									);
		self.rawfields.telephone_number 									:= dnb_dmi.utilities.BlankIfZero				(l.telephone_number								);
		self.rawfields.year_started 											:= dnb_dmi.utilities.BlankIfZero				(l.year_started										);
		self.rawfields.msa_code 													:= dnb_dmi.utilities.BlankIfZero				(l.msa_code												);
		self.active_duns_number 													:= 'Y';
		SELF.rawfields.duns_number	:= l.duns_number;
		SELF.rawfields.business_name	:= l.business_name;
		SELF.rawfields.trade_style	:= l.trade_style;
		SELF.rawfields.street	:= l.street;
		SELF.rawfields.city	:= l.city;
		SELF.rawfields.state	:= l.state;
		SELF.rawfields.zip_code	:= l.zip_code;
		SELF.rawfields.mail_address	:= l.mail_address;
		SELF.rawfields.mail_city	:= l.mail_city;
		SELF.rawfields.mail_state	:= l.mail_state;
		SELF.rawfields.mail_zip_code	:= l.mail_zip_code;
		SELF.rawfields.county_name	:= l.county_name;
		SELF.rawfields.msa_name	:= l.msa_name;
		SELF.rawfields.line_of_business_description	:= l.line_of_business_description;
		SELF.rawfields.sic1	:= l.sic1;
		SELF.rawfields.sic1desc	:= l.sic1desc;
		SELF.rawfields.sic1a	:= l.sic1a;
		SELF.rawfields.sic1adesc	:= l.sic1adesc;
		SELF.rawfields.sic1b	:= l.sic1b;
		SELF.rawfields.sic1bdesc	:= l.sic1bdesc;
		SELF.rawfields.sic1c	:= l.sic1c;
		SELF.rawfields.sic1cdesc	:= l.sic1cdesc;
		SELF.rawfields.sic1d	:= l.sic1d;
		SELF.rawfields.sic1ddesc	:= l.sic1ddesc;
		SELF.rawfields.sic2	:= l.sic2;
		SELF.rawfields.sic2desc	:= l.sic2desc;
		SELF.rawfields.sic2a	:= l.sic2a;
		SELF.rawfields.sic2adesc	:= l.sic2adesc;
		SELF.rawfields.sic2b	:= l.sic2b;
		SELF.rawfields.sic2bdesc	:= l.sic2bdesc;
		SELF.rawfields.sic2c	:= l.sic2c;
		SELF.rawfields.sic2cdesc	:= l.sic2cdesc;
		SELF.rawfields.sic2d	:= l.sic2d;
		SELF.rawfields.sic2ddesc	:= l.sic2ddesc;
		SELF.rawfields.sic3	:= l.sic3;
		SELF.rawfields.sic3desc	:= l.sic3desc;
		SELF.rawfields.sic3a	:= l.sic3a;
		SELF.rawfields.sic3adesc	:= l.sic3adesc;
		SELF.rawfields.sic3b	:= l.sic3b;
		SELF.rawfields.sic3bdesc	:= l.sic3bdesc;
		SELF.rawfields.sic3c	:= l.sic3c;
		SELF.rawfields.sic3cdesc	:= l.sic3cdesc;
		SELF.rawfields.sic3d	:= l.sic3d;
		SELF.rawfields.sic3ddesc	:= l.sic3ddesc;
		SELF.rawfields.sic4	:= l.sic4;
		SELF.rawfields.sic4desc	:= l.sic4desc;
		SELF.rawfields.sic4a	:= l.sic4a;
		SELF.rawfields.sic4adesc	:= l.sic4adesc;
		SELF.rawfields.sic4b	:= l.sic4b;
		SELF.rawfields.sic4bdesc	:= l.sic4bdesc;
		SELF.rawfields.sic4c	:= l.sic4c;
		SELF.rawfields.sic4cdesc	:= l.sic4cdesc;
		SELF.rawfields.sic4d	:= l.sic4d;
		SELF.rawfields.sic4ddesc	:= l.sic4ddesc;
		SELF.rawfields.sic5	:= l.sic5;
		SELF.rawfields.sic5desc	:= l.sic5desc;
		SELF.rawfields.sic5a	:= l.sic5a;
		SELF.rawfields.sic5adesc	:= l.sic5adesc;
		SELF.rawfields.sic5b	:= l.sic5b;
		SELF.rawfields.sic5bdesc	:= l.sic5bdesc;
		SELF.rawfields.sic5c	:= l.sic5c;
		SELF.rawfields.sic5cdesc	:= l.sic5cdesc;
		SELF.rawfields.sic5d	:= l.sic5d;
		SELF.rawfields.sic5ddesc	:= l.sic5ddesc;
		SELF.rawfields.sic6	:= l.sic6;
		SELF.rawfields.sic6desc	:= l.sic6desc;
		SELF.rawfields.sic6a	:= l.sic6a;
		SELF.rawfields.sic6adesc	:= l.sic6adesc;
		SELF.rawfields.sic6b	:= l.sic6b;
		SELF.rawfields.sic6bdesc	:= l.sic6bdesc;
		SELF.rawfields.sic6c	:= l.sic6c;
		SELF.rawfields.sic6cdesc	:= l.sic6cdesc;
		SELF.rawfields.sic6d	:= l.sic6d;
		SELF.rawfields.sic6ddesc	:= l.sic6ddesc;
		SELF.rawfields.industry_group	:= l.industry_group;
		SELF.rawfields.state_of_incorporation_abbr	:= l.state_of_incorporation_abbr;
		SELF.rawfields.annual_sales_code	:= l.annual_sales_code;
		SELF.rawfields.employees_here_code	:= l.employees_here_code;
		SELF.rawfields.internal_use	:= l.internal_use;
		SELF.rawfields.sals_territory	:= l.sales_territory;
		SELF.rawfields.owns_rents	:= l.owns_rents;
		SELF.rawfields.bank_name	:= l.bank_name;
		SELF.rawfields.accounting_firm_name	:= l.accounting_firm_name;
		SELF.rawfields.small_business_indicator	:= l.small_business_indicator;
		SELF.rawfields.minority_owned	:= l.minority_owned;
		SELF.rawfields.cottage_indicator	:= l.cottage_indicator;
		SELF.rawfields.foreign_owned	:= l.foreign_owned;
		SELF.rawfields.manufacturing_here_indicator	:= l.manufacturing_here_indicator;
		SELF.rawfields.public_indicator	:= l.public_indicator;
		SELF.rawfields.importer_exporter_indicator	:= l.importer_exporter_indicator;
		SELF.rawfields.structure_type	:= l.structure_type;
		SELF.rawfields.type_of_establishment	:= l.type_of_establishment;
		SELF.rawfields.parent_company_name	:= l.parent_company_name;
		SELF.rawfields.ultimate_company_name	:= l.ultimate_company_name;
		SELF.rawfields.ultimate_indicator	:= l.ultimate_indicator;
		SELF.rawfields.internal_use1	:= l.internal_use1;
		SELF.rawfields.internal_use2	:= l.internal_use2;
		SELF.rawfields.internal_use3	:= l.internal_use3;

		SELF.rawfields.hot_list_new_indicator		:= l.hot_list_new_indicator;
		SELF.rawfields.hot_list_ownership_change_indicator		:= l.hot_list_ownership_change_indicator;
		SELF.rawfields.hot_list_ceo_change_indicator		:= l.hot_list_ceo_change_indicator;
		SELF.rawfields.hot_list_company_name_change_ind		:= l.hot_list_company_name_change_ind;
		SELF.rawfields.hot_list_address_change_indicator		:= l.hot_list_address_change_indicator;
		SELF.rawfields.hot_list_telephone_change_indicator		:= l.hot_list_telephone_change_indicator;
		SELF.rawfields.delete_record_indicator		:= l.delete_record_indicator;
		self.rid := 0;
		SELF.bdid_score := 0;

		SELF := l;
	end;
	
	EXPORT dnb_linkids := PROJECT(dnb_base_plus, xformLinkID(LEFT));
	
	
	EXPORT header_base := PROJECT(dnb_linkids, TRANSFORM(Layouts.Base_Contacts, SELF := LEFT, SELF := []));
	
	
	EXPORT DS_dunsNum := PROJECT(dnb_base, Layouts.Layout_DunsNum );

	Layouts.layout_autokey SetAutoFields (dnb_base L) := transform
		self.suffix := l.addr_suffix;
		self.z5 := l.zip;
		self.z4 := l.zip4 ; 
		self := L;
	end;
	
	File_DNB_autoKey_1 := PROJECT (dnb_base, SetAutoFields (Left));

	Layouts.layout_autokey SetAutoFields_dba (dnb_base L) := transform
		self.business_name := l.trade_style;
		self.suffix := l.addr_suffix;
		self.z5 := l.zip;
		self.z4 := l.zip4 ; 
		self :=l;
	end;

	File_DNB_autoKey_2 := dedup(sort(PROJECT (dnb_base(trade_style<>''), SetAutoFields_dba (Left)),record),record);

	Layouts.layout_autokey SetAutoFields_mail (dnb_base L) := transform
		self.prim_range :=l.mail_prim_range;
		self.predir :=l.mail_predir;
		self.prim_name :=l.mail_prim_name;
		self.suffix:=l.mail_addr_suffix;
		self.postdir:=l.mail_postdir;
		self.unit_desig:=l.mail_unit_desig;
		self.sec_range:=l.mail_sec_range;
		self.p_city_name:=l.mail_p_city_name;
		self.st:=l.mail_st;
		self.z5:=l.mail_zip;
		self.z4:=l.mail_zip4;
		self :=l;
	end;

	File_DNB_autoKey_3 := dedup(sort(PROJECT (dnb_base(mail_address<>''), SetAutoFields_mail (Left)),record),record);

	Layouts.layout_autokey SetAutoFields_mail_trade (dnb_base L) := transform
		self.business_name := l.trade_style;
		self.prim_range :=l.mail_prim_range;
		self.predir :=l.mail_predir;
		self.prim_name :=l.mail_prim_name;
		self.suffix:=l.mail_addr_suffix;
		self.postdir:=l.mail_postdir;
		self.unit_desig:=l.mail_unit_desig;
		self.sec_range:=l.mail_sec_range;
		self.p_city_name:=l.mail_p_city_name;
		self.st:=l.mail_st;
		self.z5:=l.mail_zip;
		self.z4:=l.mail_zip4;
		self :=l;
	end;

	File_DNB_autoKey_4 := dedup(sort(PROJECT (dnb_base(mail_address<>'' and trade_style<>''), SetAutoFields_mail_trade (Left)),record),record);

	EXPORT File_DNB_autoKey :=dedup(sort(File_DNB_autoKey_1 +File_DNB_autoKey_2+File_DNB_autoKey_3+File_DNB_autoKey_4,record),record);

END;