import BIPV2, iesp;

export FinanceSection_Layouts := module;

	export rec_ids_withdata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid;
		integer6  annual_sales_amount;
	  unsigned4 sales_as_of_date;
	end;		

	export rec_ids_plus_FinanceDetail := record
		BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_TopBusinessFinance;
	end;		

	export rec_ids_plus_FinanceSecRec := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_topbusinessFinanceSection;
	end;		

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.topbusinessReport.t_TopBusinessFinanceSection;
	end;

end;
