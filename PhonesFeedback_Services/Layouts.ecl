import PhonesFeedback;

export Layouts := MODULE

	export Layout_PhonesFeedback_base := PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base;

	export feedback_report :=record //same as iesp/phonesfeedback/t_PhonesFeedback
		integer feedback_count;
		string Last_Feedback_Result;
		integer Last_Feedback_Result_Provided;
	end;
	export rec_in_request:=record
		string Phone_Number;
		string in_DID;
	end;

	export rec_fmt_layout:=record
		Layout_PhonesFeedback_base;
		integer fmt_date;
	end;
	
	end;