import BIPV2, EBR, iesp;

export EBRSection_Layouts := module;

	export rec_ids_plus_EbrSecRec := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		BIPV2.IDlayouts.l_header_ids;
		iesp.TopBusinessReport.t_TopBusinessExperianBusinessReportSection;
	end;		

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.TopBusinessReport.t_TopBusinessExperianBusinessReportSection;
	end;

end; // end of the module
