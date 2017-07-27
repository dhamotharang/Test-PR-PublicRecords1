
	EXPORT _Sample_layout_input_raw := RECORD
		STRING20  acctno        := '';
		STRING20  name_last     := '';
		STRING100 addr          := '';
		STRING10  zip           := '';
		STRING20  city          := '';
		STRING2   state         := '';
		STRING120 comp_name     := '';
		STRING20  name_first    := '';
		STRING14  filing_number := '';
		STRING72  sic_code      := '';		
		STRING9   fein          := '';
		STRING9   ssn           := '';
		UNSIGNED8 DOB           :=  0;
		STRING20  name_middle   := '';
		UNSIGNED6 did			:= 	0;
		UNSIGNED6 bdid			:= 	0;
		UNSIGNED3 score_did		:= 	0;
		UNSIGNED3 score_bdid	:= 	0;
	END;