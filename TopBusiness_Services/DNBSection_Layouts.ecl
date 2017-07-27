import BIPV2, DNB_DMI, iesp;

export DNBSection_Layouts := module;

	export rec_ids_withdata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
		DNB_DMI.Layouts.Base.Companies;  
		// ^--- use this one not DNB_DMI.Layouts.Base.CompaniesForBIP2, since it helps to have the
		//      linkids fields at the front of the internal datasets layout.
		// v--- These 3 additional "decoded" fields are output in the current 
		//      doxie_cbrs.Business_Report_Service DNB section.
	  //      See the output record coding in doxie_cbrs.DNB_records, lines 81-83.
		string15 structure_type_decoded;
	  string30 type_of_establishment_decoded;
	  string5  owns_rents_decoded;
	end;		

  export rec_DnbChild_SIC := record
		BIPV2.IDlayouts.l_header_ids;
    string8 sic_code;
    string60 sic_desc; 
	end;

	export rec_ids_plus_DnbDetail := record
		BIPV2.IDlayouts.l_header_ids;
		iesp.TopBusinessReport.t_TopBusinessDnbRecord;
	end;		

	export rec_ids_plus_DnbSecRec := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		BIPV2.IDlayouts.l_header_ids;
		iesp.TopBusinessReport.t_TopBusinessDunBradStreetSection;
	end;		

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.TopBusinessReport.t_TopBusinessDunBradStreetSection;
	end;

end;
