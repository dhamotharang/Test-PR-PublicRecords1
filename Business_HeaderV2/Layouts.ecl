import business_header;

export Layouts :=
module

	export Base :=
	module
	
		export Business_headers					:= business_header.Layout_Business_Header_Base;
		export Business_Best						:= Business_Header.Layout_BH_Best;
		export Supergroup								:= Business_Header.Layout_BH_Super_Group;
		export Business_Contacts				:= Business_Header.Layout_Business_Contact;
		export Business_Contact_Stats		:= Business_Header.Layout_Business_Contacts_Stats;
		export Business_header_Stat			:= Business_Header.Layout_Business_Header_Stat;
		export Business_Relative				:= Business_Header.Layout_Business_Relative;
		export Business_Relative_Group	:= Business_Header.Layout_Business_Relative_Group;
		export PeopleAtWork							:= Business_Header.Layout_Employment_Out;
	
	end;

	export Out :=
	module
	
		export Business_headers					:= Business_Header.Layout_Business_Header_Out;
		export Business_Best						:= Business_Header.Layout_BH_Best_Out;
		export Business_Contacts				:= Business_Header.Layout_Business_Contact_Out;
		export Business_header_Stat			:= Business_Header.Layout_Business_Header_Stat_Out;
		export Business_Relative				:= Business_Header.Layout_Business_Relatives_Out;
		export Business_Relative_Group	:= Business_Header.Layout_Business_Relatives_Group_Out;
		export PeopleAtWork							:= Business_Header.Layout_Employment_Out;
	
	end;

	export bdid_collapse :=
	module

		export linking :=
		record
		
			unsigned6 bdid1							;	// lower of the two bdids 
			unsigned6 bdid2							;	// bdid to collapse into other bdid
			string20	collapse_rule			; // rule that allows collapse to happen -- corp_key, duns number, dba parsing, fbns, uccs, bankruptcies
			string9		date_rule_created	;	// date of build											
																		
		end;
		
		shared bestlayout := Business_Header.Layout_BH_Best;
		
		export Testing :=
		record
		
			bestlayout	bdid1							;	// lower of the two bdids 
			bestlayout	bdid2							;	// bdid to collapse into other bdid
			string20		collapse_rule			; // rule that allows collapse to happen -- corp_key, duns number, dba parsing, fbns, uccs, bankruptcies
			string9			date_rule_created	;	// date of build											
																		
		end;

	end;

end;