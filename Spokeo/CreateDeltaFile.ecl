import STD;
/**
	create delta file
		param1: original output file
		param2: reprocessed file
**/

 Layout_New := RECORD
		string64		SpokeoID;
		string64		name;
		unsigned4		dob;

		unsigned6			LexId1;
		unsigned6				Lexid2;
		string3			score1;
		string3			score2;
		string70			cln_addr1;
		string40			cln_addr2;
		integer				dt_first_seen1;
		integer				dt_last_seen1;
		integer				dt_first_seen2;
		integer				dt_last_seen2;
		string1				current1_address_flag;
		string1				current2_address_flag;
		//unsigned8			address1_id;
		//unsigned8			address2_id;
		unsigned8			hhid1;
		unsigned8			hhid2;
		string70			BestAddressStreet1;
		string40			BestAddressCityStateZip1;
		string70			BestAddressStreet2;
		string40			BestAddressCityStateZip2;
		unsigned8			best1_address_id;
		unsigned8			best2_address_id;
		string1				deceased_flag1;
		string1				deceased_flag2;
		string1				better1_address_flag;
		string1				better2_address_flag;
		string1				confirmed1_address_flag;
		string1				confirmed2_address_flag;
//
		string20 			best_first_name1;
		string20 			best_middle_name1;
		string20 			best_last_name1;
		string5 			best_name_suffix1;
		string6 			best_birth_yearmonth1;
//
		string20 			best_first_name2;
		string20 			best_middle_name2;
		string20 			best_last_name2;
		string5 			best_name_suffix2;
		string6 			best_birth_yearmonth2;
END;


EXPORT CreateDeltaFile(dataset(spokeo.Layout_Out) param1, dataset(spokeo.Layout_Out) param2) := FUNCTION

		sp1 := DISTRIBUTE(Spokeo.proc_GetBestAddress(param1), hash32(spokeoid));
		sp2 := DISTRIBUTE(Spokeo.proc_GetBestAddress(param2), hash32(spokeoid));

		j := JOIN(sp1, sp2, left.spokeoid=right.spokeoid, TRANSFORM(Layout_New,
				self.name := Std.Str.ToUpperCase(left.name);
				self.dob := (unsigned4)left.dob;
				self.LexId1 := left.LexId;
				self.LexId2 := right.LexId;
				self.score1 := left.Lexid_Score;
				self.score2 := right.Lexid_Score;
				self.dt_first_seen1 := left.dt_first_seen;
				self.dt_last_seen1 := left.dt_last_seen;
				self.dt_first_seen2 := right.dt_first_seen;
				self.dt_last_seen2 := right.dt_last_seen;
				self.current1_address_flag := left.current_address_flag;
				self.current2_address_flag := right.current_address_flag;
				//self.address1_id := left.address_id;
				//self.address2_id := right.address_id;
				self.hhid1 := left.hhid;
				self.hhid2 := right.hhid;
				self.BestAddressStreet1 := left.BestAddressStreet;
				self.BestAddressCityStateZip1 := left.BestAddressCityStateZip;
				self.BestAddressStreet2 := right.BestAddressStreet;
				self.BestAddressCityStateZip2 := right.BestAddressCityStateZip;
				
				self.best1_address_id := left.bestAddressId;
				self.best2_address_id := right.bestAddressId;
				self.deceased_flag1 := left.deceased_flag;
				self.deceased_flag2 := right.deceased_flag;
				self.better1_address_flag := left.better_address_flag;
				self.better2_address_flag := right.better_address_flag;
				self.confirmed1_address_flag := left.confirmed_address_flag;
				self.confirmed2_address_flag := right.confirmed_address_flag;
				
				self.best_first_name1 := left.best_first_name;
				self.best_middle_name1 := left.best_middle_name;
				self.best_last_name1 := left.best_last_name;
				self.best_name_suffix1 := left.best_name_suffix;
				self.best_birth_yearmonth1 := IF(left.best_birth_yearmonth='0','',left.best_birth_yearmonth);
				
				self.best_first_name2 := right.best_first_name;
				self.best_middle_name2 := right.best_middle_name;
				self.best_last_name2 := right.best_last_name;
				self.best_name_suffix2 := right.best_name_suffix;
				self.best_birth_yearmonth2 := IF(right.best_birth_yearmonth='0','',right.best_birth_yearmonth);
				
				self := left), inner, local);

		changes := j(LexId1<>LexId2
							OR best1_address_id<>best2_address_id
							OR hhid1<>hhid2
							OR deceased_flag1<>deceased_flag2
							OR best_first_name1<>best_first_name2
							OR best_middle_name1<>best_middle_name2
							OR best_last_name1<>best_last_name2
							OR best_name_suffix1<>best_name_suffix2
							OR best_birth_yearmonth1<>best_birth_yearmonth2
							);

		delta := JOIN(sp2, DISTRIBUTE(changes, hash32(spokeoid)), left.spokeoid=right.spokeoid,
							TRANSFORM(Spokeo.Layout_delta,
								self.LexIdChanged						:= IF(right.LexId1<>right.LexId2, 'Y', '');
								self.BestAddressChanged			:= IF(right.best1_address_id<>right.best2_address_id, 'Y', '');
								self.HhidChanged						:= IF(right.hhid1<>right.hhid2, 'Y', '');
								self.deceasedFlagChanged		:= IF(right.deceased_flag1<>right.deceased_flag2, 'Y', '');
								self.Best_First_Name_Changed		:= IF(right.best_first_name1<>right.best_first_name2, 'Y', '');
								self.Best_Middle_Name_Changed		:= IF(right.best_middle_name1<>right.best_middle_name2, 'Y', '');
								self.Best_Last_Name_Changed			:= IF(right.best_last_name1<>right.best_last_name2, 'Y', '');
								self.Best_Name_Suffix_Changed		:= IF(right.best_name_suffix1<>right.best_name_suffix2, 'Y', '');
								self.Best_Birth_YearMonth_Changed		:= IF(right.best_birth_yearmonth1<>right.best_birth_yearmonth2, 'Y', '');
														
								self := left;), INNER, LOCAL);

		return delta;
END;