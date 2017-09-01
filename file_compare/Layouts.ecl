﻿EXPORT Layouts := module
	export FullFileResultsLayout:= record
		STRING			Dataset_Name;
		STRING			FILE_TYPE;
		STRING			Version;
		STRING			WU;
		UNSIGNED		Count_OldFile;
		UNSIGNED		Count_NewFile;
		UNSIGNED		Count_Deduped_Combined;
		DECIMAL5_2	Percent_Change;
	end;
	export ImportantFieldsResultsLayout:= record
		STRING			Dataset_Name;
		STRING			FILE_TYPE;
		STRING			Version;
		STRING			Important_Fields;
		STRING			WU;
		UNSIGNED		Count_Unique_OldFile;
		UNSIGNED		Count_Unique_NewFile;
		UNSIGNED		Count_Unique_Combined;
		UNSIGNED		Count_Prev_Only;
		UNSIGNED		Count_New_Only;
		DECIMAL5_2	Percent_Change;
		DECIMAL5_2	Percent_Loss;
		DECIMAL5_2	Percent_Gain;
	end;
end;