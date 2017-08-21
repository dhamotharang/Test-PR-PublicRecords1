import ut, MPRD;
	
EXPORT special_keys( string		pversion = ''	,boolean pUseProd = false)	:= module

	export individual_joined_key:=function

		input:= MPRD.InFile_Preprocessor(pversion,pUseProd).Prepped_Individual;

		MPRD.layouts.individual_in_for_grpkey tMapping(MPRD.layouts.individual_in L, integer C) := TRANSFORM , skip(l.full_name = '' AND l.first_name ='' AND l.last_name = '' AND l.prac_company1_name='')
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2','3','4');  
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF  															:= L;	
			SELF 																:= [];
		END;

		std_input_individual := NORMALIZE(input, 4, tMapping(LEFT, counter));
		std_input_individual_1:= sort(distribute(std_input_individual,hash32(surrogate_key,normed_addr_rec_type)),surrogate_key,istest,local);
	
		individual_base:= sort(distribute(MPRD.Files(,false).individual_base.built,hash32(surrogate_key,normed_addr_rec_type)),surrogate_key,isTest,local);
		
		final_output:=join(std_input_individual_1,individual_base,
														left.normed_addr_rec_type=right.normed_addr_rec_type
												and left.surrogate_key=right.surrogate_key
												and left.isTest=right.isTest);
		return final_output;
	end;

	export facility_joined_key := function

		input:= MPRD.InFile_Preprocessor(pversion,pUseProd).Prepped_facility;

		MPRD.layouts.facility_in_for_grpkey tMapping(MPRD.layouts.facility_in L, integer C) := TRANSFORM , skip(l.full_name = '' AND l.first_name ='' AND l.last_name = '' AND l.prac_company1_name='')
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2','3','4');  
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF  															:= L;
			SELF 																:= [];
		END;

		std_input_facility := NORMALIZE(input, 4, tMapping(LEFT, counter));
		std_input_facility_1:= sort(distribute(std_input_facility,hash32(surrogate_key,normed_addr_rec_type)),surrogate_key,isTest,local);
	
		facility_base := sort(distribute(MPRD.Files(,false).facility_base.built,hash32(surrogate_key,normed_addr_rec_type)),surrogate_key,isTest,local);

		final_output:=join(std_input_facility_1,facility_base,
														left.normed_addr_rec_type=right.normed_addr_rec_type
												and left.surrogate_key=right.surrogate_key
												and left.isTest=right.isTest);
		return final_output;
	end;
end;