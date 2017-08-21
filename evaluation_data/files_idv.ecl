import ut;
export files_idv := module
	export eFund:=dataset(ut.foreign_dataland+'~thor_data400::idv::lexis_nexis_debit_append_1107.txt',layouts_idv.eFund,flat);
	export impulse_marketing:=dataset(ut.foreign_dataland+'~thor_data400::idv::impulse_marketing::data_study_impulse_limited_return_20080623.csv',layouts_idv.impulse_marketing,csv(heading,maxlength(8192)));
	export infoDirect:=dataset(ut.foreign_dataland+'~thor_data400::idv::infodirect::ln_data_study_file_infodirect_matched1.txt',layouts_idv.infoDirect,csv(maxlength(8192)));
	export rent_bureau:=dataset(ut.foreign_dataland+'~thor_data400::idv::rent_bureau::lexnex_results.csv',layouts_idv.rent_bureau,csv(heading,maxlength(8192)));
	export teletrack:=dataset(ut.foreign_dataland+'~thor_data400::idv::teletrack::ind_attributes.csv',layouts_idv.teletrack,csv(maxlength(8192)));
	export Segment_52_SocialGuard_Data:=dataset(ut.foreign_dataland+'~thor_data400::idv::teletrack::seg52.txt',layouts_idv.Segment_52_SocialGuard_Data,csv(maxlength(8192)));
	export Segment_53_Charge_Offs:=dataset(ut.foreign_dataland+'~thor_data400::idv::teletrack::seg53.txt',layouts_idv.Segment_53_Charge_Offs,csv(maxlength(8192)));
	export Segment_54_Previous_Inquiries:=dataset(ut.foreign_dataland+'~thor_data400::idv::teletrack::seg54.txt',layouts_idv.Segment_54_Previous_Inquiries,csv(maxlength(8192)));
	export Segment_56_SkipGuard_Alerts:=dataset(ut.foreign_dataland+'~thor_data400::idv::teletrack::seg56.txt',layouts_idv.Segment_56_SkipGuard_Alerts,csv(maxlength(8192)));
	export Segment_61_Tenant_Evictions_and_Court_Dispositions:=dataset(ut.foreign_dataland+'~thor_data400::idv::teletrack::seg61.txt',layouts_idv.Segment_61_Tenant_Evictions_and_Court_Dispositions,csv(maxlength(8192)));
	export Segment_62_Paid_Charge_Offs:=dataset(ut.foreign_dataland+'~thor_data400::idv::teletrack::seg62.txt',layouts_idv.Segment_62_Paid_Charge_Offs,csv(maxlength(8192)));
	export Segment_68_Bankruptcies:=dataset(ut.foreign_dataland+'~thor_data400::idv::teletrack::seg68.txt',layouts_idv.Segment_68_Bankruptcies,csv(maxlength(8192)));
end;
