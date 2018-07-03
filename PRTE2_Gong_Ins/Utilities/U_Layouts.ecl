IMPORT PRTE2_Gong_Ins;

EXPORT U_Layouts := MODULE

Files := PRTE2_Gong_Ins.Files;
		
		EXPORT LindaPartialLayout := RECORD
				STRING phone10;
				STRING prim_range;
				STRING predir;
				STRING prim_name;
				STRING suffix;
				STRING postdir;
				STRING unit_desig;
				STRING sec_range;
				STRING p_city_name;
				STRING v_predir;
				STRING v_prim_name;
				STRING v_suffix;
				STRING v_postdir;
				STRING st;
				STRING z5;
				STRING z4;
				STRING name_first;
				STRING name_middle;
				STRING name_last;
				STRING name_suffix;
				STRING listed_name;
				STRING did;
				STRING order;
		END;

END;