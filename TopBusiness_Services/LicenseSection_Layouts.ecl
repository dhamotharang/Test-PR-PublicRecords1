import BIPV2, iesp;

export LicenseSection_Layouts := module;

	export rec_child_source := record 
	  BIPV2.IDlayouts.l_header_ids;
		TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid;
		//TopBusiness_Services.Layouts.rec_input_ids_wSrc.IdType; // not needed for license sources???
  end;

	export rec_ids_with_licdata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;     
	  TopBusiness_Services.Layouts.rec_common.source_docid; 
		string2   license_state;  // license issuing state, if applicable
		string60  license_board;  // the license issuing board/agency name
		string25  license_number; // the license number issued
		string25  license_number_nlz := ''; // lic# with leading zeroes removed (when numeric), needed for deduping
		string60  license_type;   // the type of license (pharmacy, pharmacist, etc.)
		string8   issue_date;
		string8   expiration_date;
		string8   date_last_seen;
		unsigned2 tot_rec_count :=0;
    dataset(rec_child_source) RawSourceDocs; 
	end;		

	export rec_ids_plus_LicenseRecord := record
    BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid;
	  iesp.topbusinessReport.t_TopBusinessLicenseRecord;
		unsigned2 tot_rec_count;
	end;

	export rec_ids_plus_LicenseSummary := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
    BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.T_TopbusinessLicenseSummary;
		unsigned2 tot_rec_count;
	end;			
	
	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.topbusinessReport.t_TopBusinessLicenseSection; 
	end;	

end;
