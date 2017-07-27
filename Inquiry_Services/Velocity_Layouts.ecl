import	doxie,iesp,inquiry_acclogs;

export	Velocity_Layouts	:=
module

	export	r_uniqueid	:=
	record
		unsigned6 uniqueid;
	end;

	export	r_add_booleans	:=
	record
		inquiry_acclogs.key_inquiry_did;
		boolean InVerticalSet								:=	false;
		boolean InFunctionSet								:=	false;
		boolean InAnyIndustry								:=	false;
		boolean InIndustryKba								:=	false;
		// Below boolean flags are for future enhancement
		boolean InIndustryAuto							:=	false;
		boolean InIndustryCommunications		:=	false;
		boolean InIndustryCredit						:=	false;
		boolean InIndustryDirectToConsumer	:=	false;
		boolean InIndustryFinance						:=	false;
		boolean InIndustryOther							:=	false;
		boolean InIndustryRetail						:=	false;
		boolean InIndustryUtility						:=	false;
		string8 InquiryDate									:=	'';	
		string8 InquiryTime									:=	'';	
		integer DaysApart										:=	0;
		boolean WithinDateRange							:=	false;
		integer FunctionCnt									:=	0;
		integer FunctionDateCnt							:=	0;
		// New fields added for the identity velocity service
		boolean	Within24Hours								:=	false;
		boolean	Within7Days									:=	false;
		boolean	Within30Days								:=	false;
		boolean	Within90Days								:=	false;
		boolean	Within12Months							:=	false;
		boolean	isValidIndustry							:=	false;
	end;
	
	// Gateway layouts
	export	Gateway	:=
	module
		
		// Records layout including the error codes and descriptions
		export	Records	:=
		record(iesp.accurintspsearchalertidsproc.t_Record)
			integer	ProcedureStatus;
			integer	Success;
			integer	ErrorCode;
			string	Message;
		end;
		
		// Gateway soap call response slimmed layout
		export	SlimResponse	:=
		record
			dataset(Records)	Recs	{MAXCOUNT(Inquiry_Services.Velocity_Constants.MAX_COUNT_RECORDS)};
		end;
		
		// Gateway out layout
		export	Out	:=
		record
			integer	ProcedureStatus;
			integer	Success;
			integer	ErrorCode;
			string	Message;
			string	Transaction_ID := '';
			string	Search_date;
			string	Search_time;
			string	Vertical;
			string	Industry;
			string	Description;
			string	Rec_Use;
		end;
		
	end;
	
end;