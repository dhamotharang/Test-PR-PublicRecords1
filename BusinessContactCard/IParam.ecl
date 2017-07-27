import BIPV2;

EXPORT IParam := MODULE
	export options := interface
		export boolean IncludePhonesPlus   			:= false;
	  export boolean IncludePhonesFeedback 		:= false;
		export string1 BusinessReportFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID;
		export boolean useSupergroup 						:= false;
		export boolean useLevels     						:= false;
		export boolean isBIPReport							:= false;
	end;
END;