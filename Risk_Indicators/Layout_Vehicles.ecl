/*2015-03-20T00:34:03Z (Andrea Koenen)
RR: 177262: checkin for review
*/
export Layout_Vehicles :=
MODULE

	export Vehicle_Information :=
	RECORD
		UNSIGNED2 year_make;
		STRING10 make;		// TODO: type
		STRING10 model;	// TODO: type
		BOOLEAN title;
		STRING25 vin;
	END;

	export Vehicle_Set :=
	RECORD
		UNSIGNED1 current_count;
		UNSIGNED1 historical_count;
		Vehicle_Information Vehicle1;
		Vehicle_Information Vehicle2;
		Vehicle_Information Vehicle3;
	END;

export Vehicle_InformationAddl :=
	RECORD
		UNSIGNED2 year_make;
		STRING10 make;		// TODO: type
		STRING10 model;	// TODO: type
		BOOLEAN title;
		STRING25 vin;
		string2	Source_Code;
		string2	orig_state;	
	END;

	export Vehicle_SetAddl :=
	RECORD
		UNSIGNED1 current_count;
		UNSIGNED1 historical_count;
		Vehicle_InformationAddl Vehicle1;
		Vehicle_InformationAddl Vehicle2;
		Vehicle_InformationAddl Vehicle3;
	END;

	export VehRec :=
    RECORD
		Layout_Boca_Shell_ids;
		Vehicle_Set;
		unsigned1 relative_owned_count;
	END;
END;

