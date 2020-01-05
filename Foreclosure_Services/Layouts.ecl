IMPORT Foreclosure_Vacancy, Property, iesp;

export Layouts := MODULE;
	export Layout_Foreclosure_out :=record(Property.Layout_Fares_Foreclosure)
	end;
	EXPORT layout_fid := record
			string70	fid;
	end;
	export FIDNumberPlus := record
		   string70	fid;
		   unsigned6 did;
		   unsigned6 bdid;
		   boolean isDeepDive := false;
	end;	
	export rawrec := record

		   Layout_Foreclosure_out;
		   boolean isDeepDive := false;
		   unsigned2 penalt := 0;
	end;	
	export t_ForeclosureSearchRecordwithPenalty := record

		   iesp.foreclosure.t_ForeclosureSearchRecord;
		   boolean isDeepDive := false;
		   unsigned2 penalt := 0;
	end;
	export rawrec_plaintiffs_defendants :=record
			rawrec;
			string30 situs1_county_name:='';
			string30 situs2_county_name:='';
			dataset(iesp.share.t_StringArrayItem) Plaintiffs {xpath('Plaintiffs/Plaintiff'), MAXCOUNT(iesp.Constants.MAX_COUNT_PLAINTIFF)};
			dataset(iesp.foreclosure.t_ForeclosureReportDefendant) Defendants {xpath('Defendants/Defendant'), MAXCOUNT(iesp.Constants.MAX_COUNT_DEFENDANT)};
	end;
	export layout_batch_in := record
		string60	UniqueID       := '';
		string30	acctno         := '';
		string25	last_name      := '';
		string1		middle_initial := '';
		string15	first_name     := '';
		string10 	prim_range     := '';
		string28 	prim_name      := '';
		string4 	addr_suffix    := '';
		string2 	predir         := '';
		string2 	postdir        := '';
		string8 	sec_range      := '';
		string20	p_city_name    := '';
		string2		st             := '';
		string5		z5             := '';
		string4		zip4           := '';
	end;
	export Final_Batch := record
		STRING30	ACCTNO;
		Foreclosure_Vacancy.Layouts.Final_Renewal - PROPERTY_TYPE_CD;
		string45 parcel_number_parcel_id;
		string45 parcel_number_unmatched_id;
		string3 property_type_cd;
		String1 source;
	end;
END;
