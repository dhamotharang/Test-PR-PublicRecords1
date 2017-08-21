export Layout_Business_Contacts_Stats_Plus :=
RECORD
	business_header.Layout_Business_Contact_Plus					;
	UNSIGNED4 bdid_per_addr 											:= 0		;
	UNSIGNED4 apts																:= 0		;
	UNSIGNED4 ppl																	:= 0		;
	UNSIGNED4 r_phone_per_addr										:= 0		;
	UNSIGNED4 b_phone_per_addr										:= 0		;
	UNSIGNED4 dnb_emps														:= 0		;
	UNSIGNED4 irs5500_emps												:= 0		;
	UNSIGNED4 domainss														:= 0		;
	UNSIGNED1 sources															:= 0		;
	UNSIGNED1 company_name_score									:= 0		;
	UNSIGNED1 combined_score											:= 0		;
	UNSIGNED1 combined_new_score									:= 0		;
	BOOLEAN   has_gong_yp													:= FALSE;
	BOOLEAN   eq_emp_match												:= FALSE;
	BOOLEAN   current_corp												:= FALSE;
	UNSIGNED6 best_phone													:= 0		;
END;