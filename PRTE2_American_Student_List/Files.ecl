import data_services;
EXPORT Files := module

  export incoming_1:= dataset('~prte::in::american_student_list::student_list', layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) )(ssn <> '');
	export incoming_2 := dataset('~prte::in::american_student_list::student_list_Ins', layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) )(ssn <> '');
  
  export incoming := incoming_1 + incoming_2;
	
	export base     := dataset('~prte::base::american_student_list', layouts.base, thor);

  export DID_base	      :=	PROJECT(base((unsigned8)did<>0 AND HISTORICAL_FLAG = 'C'), layouts.ASL_Key_Layout);
  export DID_base_fcra  := 	PROJECT(base((unsigned8)did<>0 AND HISTORICAL_FLAG = 'C'), 
                                    transform(layouts.ASL_Key_Layout,
                                              self.income_level := '';
                                              self.income_level_code := '',
                                              self := left));

  export DID2_base	      :=	PROJECT(base((unsigned8)did<>0), layouts.american_student_base_v2);
  export DID2_base_fcra	  :=	PROJECT(base((unsigned8)did<>0), transform(layouts.american_student_base_v2,
                                        self.income_level := '';
                                        self.income_level_code := '',
                                        self.new_income_level := '';
                                        self.new_income_level_code := '',
                                        Self.collegeupdate :=	'';
                                        self := left));

 export address_matches    := dataset([], layouts.american_student_list_address_matches);
 
 export american_student_Autokeys := PROJECT(base(did <>0), layouts.ASL_Autokey);
 

end;