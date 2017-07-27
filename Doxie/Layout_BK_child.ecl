import bankrupt;

//Change maxlength to maxcount when build 656+ is available

export layout_bk_child := record
	integer penalt,
	string5 court_code;
	string7 case_number;
	string2 debtor_type;
	string9 debtor_ssn;
	string12 debtor_DID;
	string3 debtor_DID_score;
	string12 bdid;
	dataset(bankrupt.layout_bk_search_name) names{maxcount(Bankrupt.max_children_constant)};
	dataset(bankrupt.layout_bk_search_addr) addresses{maxcount(Bankrupt.max_children_constant)};
end;