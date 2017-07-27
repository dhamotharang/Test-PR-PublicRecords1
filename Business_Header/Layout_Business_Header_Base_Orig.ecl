import Business_Header;
export Layout_Business_Header_Base_Orig :=
record
	Business_header.Layout_Business_Header_orig					;
	qstring81 match_company_name				;
	qstring20 match_branch_unit					;
	qstring25 match_geo_city			:= ''	;
end;