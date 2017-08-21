export Layout_Relative_Link :=
module

	export Pair :=
	record
		unsigned6	bdid1;
		unsigned6	bdid2;
		unsigned1	pflag;
	end;

	export Relative_Flagged :=
	record
		unsigned6 bdid1;
		unsigned6 bdid2;
		string20 pflag := 'Relative Record'; // can be 'transitive' or 'child'
		boolean corp_charter_number 	:= false;
		boolean business_registration	:= false;
		boolean bankruptcy_filing		:= false;
		boolean duns_number				:= false;
		boolean duns_tree				:= false;
		boolean edgar_cik				:= false;
		boolean name					:= false;
		boolean name_address			:= false;
		boolean name_phone				:= false;
		boolean gong_group				:= false;
		boolean ucc_filing				:= false;
		boolean fbn_filing				:= false;
		boolean fein					:= false;
		boolean phone					:= false;
		boolean addr					:= false;
		boolean mail_addr				:= false;
		boolean dca_company_number		:= false;
		boolean dca_hierarchy			:= false;
		boolean abi_number				:= false;
		boolean abi_hierarchy			:= false;
		boolean rel_group				:= false;
	end;

	export RelativesDegrees :=
	record
		unsigned6					bdid1;
		unsigned6					bdid2;
		dataset(Relative_Flagged)	dlinks;
		unsigned4					nDegrees;

	end;
end;