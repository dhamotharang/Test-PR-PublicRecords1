EXPORT IntermediaryLayoutDeniedEntity := MODULE

	EXPORT BaseLayout := RECORD
		string10 	Ent_Key;
		string30 	Country;
		string300 License_Requirement;
		string500 License_Review_Policy;
		string150 Federal_Register_Citation;
		string35 	Federal_Register_Citation_1;
		string35 	Federal_Register_Citation_2;
		string35 	Federal_Register_Citation_3;
		string35 	Federal_Register_Citation_4;
		string35 	Federal_Register_Citation_5;
		string35 	Federal_Register_Citation_6;
		string35 	Federal_Register_Citation_7;
		string35 	Federal_Register_Citation_8;
		string35 	Federal_Register_Citation_9;
		string35 	Federal_Register_Citation_10;
	END;
	
	EXPORT tempLayout := RECORD
		Layouts.rDeniedEntity;
		string Federal_Register_Citation_Parsed;
		string Federal_Register_Citation_1;
		string Federal_Register_Citation_2;
		string Federal_Register_Citation_3;
		string Federal_Register_Citation_4;
		string Federal_Register_Citation_5;
		string Federal_Register_Citation_6;
		string Federal_Register_Citation_7;
		string Federal_Register_Citation_8;
		string Federal_Register_Citation_9;
		string Federal_Register_Citation_10;
	END;
	
	EXPORT tempLayout1 := RECORD
		string800 Entities;
		BaseLayout;
		integer3 num;
	END;
	
	EXPORT tempLayout2 := RECORD
		string350 Entity;
		BaseLayout;
		string350 orig_raw_name;
	END;
	
	EXPORT tempLayout3 := RECORD
		string350 Entity;
		string10  name_type;
		string150 Address;
		string350 orig_raw_name;
		BaseLayout;
	END;
	
	EXPORT tempLayout4 := RECORD
		string200 Comments;
		tempLayout3;
	END;
END;