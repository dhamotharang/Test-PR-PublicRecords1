﻿import PropertyCharacteristics, PRTE2_PropertyInfo_Ins;

EXPORT Layouts := module

	EXPORT base := PropertyCharacteristics.Layouts.Base;
	
	EXPORT incoming := record
				PRTE2_PropertyInfo_Ins.Layouts.AlphaPropertyCSVRec and not [__internal_fpos__];
				string10 cust_name;
				string10 bug_num;
	end;			

end;	