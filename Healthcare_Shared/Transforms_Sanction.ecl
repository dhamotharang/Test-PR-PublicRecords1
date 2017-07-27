Import Healthcare_Shared;
EXPORT Transforms_Sanction  := MODULE
	export Healthcare_Shared.layouts_commonized.layout_std_sanction normCPSanctions(Healthcare_Shared.layouts_commonized.std_record_struct L, INTEGER C) := TRANSFORM
				SELF.sanc_state := 		 CHOOSE(C, L.sanc1.sanc_state, L.sanc2.sanc_state, L.sanc3.sanc_state,L.sanc4.sanc_state,L.sanc5.sanc_state,
																								L.sanc6.sanc_state, L.sanc7.sanc_state, L.sanc8.sanc_state,L.sanc9.sanc_state,L.sanc10.sanc_state);
				SELF.sanc_date :=			 CHOOSE(C, L.sanc1.sanc_date, L.sanc2.sanc_date, L.sanc3.sanc_date,L.sanc4.sanc_date,L.sanc5.sanc_date,
																								L.sanc6.sanc_date, L.sanc7.sanc_date, L.sanc8.sanc_date,L.sanc9.sanc_date,L.sanc10.sanc_date);
				SELF.sanc_case := 		 CHOOSE(C, L.sanc1.sanc_case, L.sanc2.sanc_case, L.sanc3.sanc_case,L.sanc4.sanc_case,L.sanc5.sanc_case,
																								L.sanc6.sanc_case, L.sanc7.sanc_case, L.sanc8.sanc_case,L.sanc9.sanc_case,L.sanc10.sanc_case);
				SELF.sanc_source := 	 CHOOSE(C, L.sanc1.sanc_source, L.sanc2.sanc_source, L.sanc3.sanc_source,L.sanc4.sanc_source,L.sanc5.sanc_source,
																								L.sanc6.sanc_source, L.sanc7.sanc_source, L.sanc8.sanc_source,L.sanc9.sanc_source,L.sanc10.sanc_source);
				SELF.sanc_complaint := CHOOSE(C, L.sanc1.sanc_complaint, L.sanc2.sanc_complaint, L.sanc3.sanc_complaint,L.sanc4.sanc_complaint,L.sanc5.sanc_complaint,
																						  	L.sanc6.sanc_complaint, L.sanc7.sanc_complaint, L.sanc8.sanc_complaint,L.sanc9.sanc_complaint,L.sanc10.sanc_complaint);
				SELF.sanc_rein_date := CHOOSE(C, L.sanc1.sanc_rein_date, L.sanc2.sanc_rein_date, L.sanc3.sanc_rein_date,L.sanc4.sanc_rein_date,L.sanc5.sanc_rein_date,
																						  	L.sanc6.sanc_rein_date, L.sanc7.sanc_rein_date, L.sanc8.sanc_rein_date,L.sanc9.sanc_rein_date,L.sanc10.sanc_rein_date);
				SELF.sanc_type := 		 CHOOSE(C, L.sanc1.sanc_type, L.sanc2.sanc_type, L.sanc3.sanc_type,L.sanc4.sanc_type,L.sanc5.sanc_type,
																								L.sanc6.sanc_type, L.sanc7.sanc_type, L.sanc8.sanc_type,L.sanc9.sanc_type,L.sanc10.sanc_type);
				SELF.sanc_category :=  CHOOSE(C, L.sanc1.sanc_category, L.sanc2.sanc_category, L.sanc3.sanc_category,L.sanc4.sanc_category,L.sanc5.sanc_category,
																								L.sanc6.sanc_category, L.sanc7.sanc_category, L.sanc8.sanc_category,L.sanc9.sanc_category,L.sanc10.sanc_category);
				SELF.sanc_prof_type := CHOOSE(C, L.sanc1.sanc_prof_type, L.sanc2.sanc_prof_type, L.sanc3.sanc_prof_type,L.sanc4.sanc_prof_type,L.sanc5.sanc_prof_type,
																								L.sanc6.sanc_prof_type, L.sanc7.sanc_prof_type, L.sanc8.sanc_prof_type,L.sanc9.sanc_prof_type,L.sanc10.sanc_prof_type);
				SELF.sanc_lic_num :=	 CHOOSE(C, L.sanc1.sanc_lic_num, L.sanc2.sanc_lic_num, L.sanc3.sanc_lic_num,L.sanc4.sanc_lic_num,L.sanc5.sanc_lic_num,
																								L.sanc6.sanc_lic_num, L.sanc7.sanc_lic_num, L.sanc8.sanc_lic_num,L.sanc9.sanc_lic_num,L.sanc10.sanc_lic_num);
				SELF.sanc_st := 			 CHOOSE(C, L.sanc1.sanc_st, L.sanc2.sanc_st, L.sanc3.sanc_st,L.sanc4.sanc_st,L.sanc5.sanc_st,
																								L.sanc6.sanc_st, L.sanc7.sanc_st, L.sanc8.sanc_st,L.sanc9.sanc_st,L.sanc10.sanc_st);
				SELF := L;
	END;
End;