import corrections, iesp, FFD;

export layouts := module

	export l_search := record
		string60	offender_key;
		boolean		isDeepDive	:= false;
	end;

	export docnum_rec := record
		string25	doc_number;
	end;

	export casenum_rec := record
		string35 case_number;
	end;
	
	export l_raw := record
		corrections.layout_Offender;
		boolean		isDeepDive	:= false;
		unsigned2	penalt			:= 0;
		FFD.Layouts.CommonRawRecordElements;
	end;

	export offense_rec := record
		unsigned bitmap;
		string description;
	end;

	export raw_with_offenses := record
		l_raw;
		dataset(offense_rec) offenses;
	end;

	export t_CrimSearchRecordWithPenalty := record
		iesp.criminal_fcra.t_FcraCrimSearchRecord;
	end;
	
end;