EXPORT Range_function_module_2 := MODULE

IMPORT ut, scoring_project;
//***************************************//
//***************************************//


EXPORT Average_func(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0);

		#uniquename(rc)
		%rc% := record
		  string field_name;
			//  
			string distribution_type ;
			string50 attribute_value ;
			decimal20_4 Count1 ;
		end;

		#uniquename(a)
		%a% := dataset([{'','','average','average',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  
																						 self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

result := %Bks_project%;

ENDMACRO;


//***************************************//
//***************************************//


EXPORT Average_func1(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=300 );

		#uniquename(rc)
		%rc% := record
		  string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
			decimal20_4 Count1 ;
		end;

		#uniquename(a)
		%a% := dataset([{'','average','ave>=300',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  
																						 self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		result :=  %Bks_project%;

ENDMACRO;

//***************************************//
//***************************************//


EXPORT Average_func2(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=0 );

		#uniquename(rc)
		%rc% := record
		  string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
			decimal20_4 Count1 ;
		end;

		#uniquename(a)
		%a% := dataset([{'','average','ave>=0',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  
																						 self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		result :=  %Bks_project%;

ENDMACRO;


//***************************************//
//***************************************//


EXPORT Average_func3(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and 
		                                                      (integer)#expand(f1) between 0 and 254);

		#uniquename(rc)
		%rc% := record
		  string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
			decimal20_4 Count1 ;
		end;

		#uniquename(a)
		%a% := dataset([{'','average','ave>=0 and ave<=254',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  
																						 self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		result :=  %Bks_project%;

ENDMACRO;


//***************************************//
//***************************************//


EXPORT Average_func4(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and (integer)#expand(f1)<>12
		                                                     and (integer)#expand(f1)<>255  and (integer)#expand(f1)>=0);

		#uniquename(rc)
		%rc% := record
		  string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
			decimal20_4 Count1 ;
		end;

		#uniquename(a)
		%a% := dataset([{'','average','ave>=0 and ave<>255 and ave<>12',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  
																						 self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		result :=  %Bks_project%;

ENDMACRO;


//***************************************//
//***************************************//


EXPORT Average_func5(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and (integer)#expand(f1)<>9999
		                                                                                                     and (integer)#expand(f1)>=0);     
		                                                  

		#uniquename(rc)
		%rc% := record
		  string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
			decimal20_4 Count1 ;
		end;

		#uniquename(a)
		%a% := dataset([{'','average','ave>=0 and ave<>9999',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  
																						 self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		result :=  %Bks_project%;

ENDMACRO;


//***************************************//
//***************************************//


EXPORT Average_func6(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and (integer)#expand(f1)>0 );

		#uniquename(rc)
		%rc% := record
		  string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
			decimal20_4 Count1 ;
		end;

		#uniquename(a)
		%a% := dataset([{'','average','ave>0',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  
																						 self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		result :=  %Bks_project%;

ENDMACRO;


//***************************************//
//***************************************//


EXPORT Average_func7(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and  (integer)#expand(f1)>0); 

		#uniquename(rc)
		%rc% := record
		  string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
			decimal20_4 Count1 ;
		end;

		#uniquename(a)
		%a% := dataset([{'','average','ave months >0',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  
																						  self.Count1 := Ave(%a2%,(decimal20_4) ut.MonthsApart(ut.getdate,(string)%a2%.#expand(f1)));
																						
																						 self := left;											
																						));

		result :=  %Bks_project%;

ENDMACRO;


//***************************************//
//***************************************//


EXPORT Average_func8(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and  (integer)#expand(f1)>0); 

		#uniquename(rc)
		%rc% := record
		  string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
			decimal20_4 Count1 ;
		end;

		#uniquename(a)
		%a% := dataset([{'','average','ave days  >0',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  
																						 self.Count1 := Ave(%a2%,(decimal20_4) ut.DaysApart(ut.getdate,(string)%a2%.#expand(f1)));
																						
																						 self := left;											
																						));

		result :=  %Bks_project%;

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_distinct_alphanumeric2(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := if(RegexFind('[.~!@&%#$^*()=+?<>,/"{}|]',
																			                              TRIM((string)left.#expand(f1),LEFT,RIGHT)), 'undefined',
																																MAP(length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',	
																																RegexFind('[	 \n\r]',
																																    TRIM((string)left.#expand(f1),LEFT,RIGHT))=> 'nulls',
																																		     (string) left.#expand(f1))); 
 
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//

EXPORT range_Function_distinct_numeric(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := if(RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',
																			                              TRIM((string)left.#expand(f1),LEFT,RIGHT)), 'undefined',
																																MAP(length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',	
																																RegexFind('[	 \n\r]',
																																    TRIM((string)left.#expand(f1),LEFT,RIGHT))=> 'nulls',
																																		     (string) left.#expand(f1))); 
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_distinct_alphabetic(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := if(RegexFind('[0-9.~!@&%#$^*()_=+?<>,/"{}|]',
																			                              TRIM((string)left.#expand(f1),LEFT,RIGHT)), 'undefined',
																																MAP(length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',	
																																RegexFind('[	 \n\r]',
																																    TRIM((string)left.#expand(f1),LEFT,RIGHT))=> 'nulls',
																																		     (string) left.#expand(f1))); 
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


// EXPORT range_Function_164 (file_name,fieldname, Result, offset1):= MACRO

// r_FIELD_NAME := record 
  // string100 field_name := fieldname;
	//  
  // string30 distribution_type := 'DATE-DAYS-APART';
  // string50 attribute_value := MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	// (unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	// length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	// length(trim((string)file_name.#expand(fieldname))) > 8 => 'undefined',
																	// length(trim((string)file_name.#expand(fieldname))) < 8  => 'undefined',
																	// (unsigned)file_name.#expand(fieldname) > (unsigned)Scoring_Project.Function_Last30Days(ut.GetDate, offset1) => 'Less Than ' +  (string)offset1 + ' days',
																	 // 'Greater Than ' +  (string)offset1 + ' days');
// decimal20_4 Count1 := count(group);
// end;


// t_FIELD_NAME := table(file_name,r_FIELD_NAME,MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	// (unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	// length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	// length(trim((string)file_name.#expand(fieldname))) > 8 => 'undefined',
																	// length(trim((string)file_name.#expand(fieldname))) < 8  => 'undefined',
																	// (unsigned)file_name.#expand(fieldname) > (unsigned)Scoring_Project.Function_Last30Days(ut.GetDate, offset1) => 'Less Than ' +  (string)offset1 + ' days',
																	 // 'Greater Than ' +  (string)offset1 + ' days'));
	

// result :=  t_FIELD_NAME;

// endmacro;


//***************************************//
//***************************************//


EXPORT range_Function_255(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := if(RegexFind('[.~!@&%#$^*()_=+?<>,/"{}|]',
																			                              TRIM((string)left.#expand(f1),LEFT,RIGHT)), 'undefined',
																																MAP(length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',	
																																RegexFind('[	 \n\r]',
																																    TRIM((string)left.#expand(f1),LEFT,RIGHT))=> 'Null Value',
																																				 length(trim((string)left.#expand(f1),left,right))!= 0  => 'value populated',
																																				 'undefined'
																																				 )); 

		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//

EXPORT range_Function_256(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																														(integer)left.#expand(f1) =0 => '0',
																													 (string)left.#expand(f1)[1..4] = ut.GetDate[1..4] => 'Current Year',
																													 (string)left.#expand(f1)[1..4] <> ut.GetDate[1..4] => 'Not Current Year',																																																															
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );  
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_257(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																														(integer)left.#expand(f1) =0 => '0',
																														(integer)left.#expand(f1) =-1 => '-1',
																													 (string)left.#expand(f1)[1..4] = ut.getdate[1..4] => 'Current Year',
																													 (string)left.#expand(f1)[1..4] <> ut.getdate[1..4] => 'Not Current Year',																																																															
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );  
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_278(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) >0  => 'Value Populated>0',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//

EXPORT range_Function_300(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 100  => '100',
																													 (integer)left.#expand(f1) = 200  => '200',
																													 (integer)left.#expand(f1) = 222  => '222',
																													 (integer)left.#expand(f1) <= 659  => '<=659',	
																												   (integer)left.#expand(f1) between 660 and 679 => '660-679',	
																													 (integer)left.#expand(f1) between 680 and 699 => '680-699',	
																													 (integer)left.#expand(f1) between 700 and 719 => '700-719',	
																													 (integer)left.#expand(f1) >= 720  => '>=720',	
																													 (integer)left.#expand(f1) >= 300  => '>=300',																																																													
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_301(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													  length(trim((string)left.#expand(f1),left,right))!= 0  => 'value populated',
																																																							 																																												
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_302(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 100  => '100',
																													 (integer)left.#expand(f1) = 200  => '200',
																													 (integer)left.#expand(f1) = 222  => '222',
																												   (integer)left.#expand(f1) between 300 and 699 => '300-699',	
																													 (integer)left.#expand(f1) between 700 and 729 => '700-729',	
																													 (integer)left.#expand(f1) between 730 and 749 => '730-749',	
																													 (integer)left.#expand(f1) between 750 and 779 => '750-779',	
																													 (integer)left.#expand(f1) >= 780  => '>=780',	
																													 (integer)left.#expand(f1) >= 300  => '>=300',																																																													
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_303(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 100  => '100',
																													 (integer)left.#expand(f1) = 200  => '200',
																													 (integer)left.#expand(f1) = 222  => '222',
																												   (integer)left.#expand(f1) between 300 and 559 => '300-559',	
																													 (integer)left.#expand(f1) between 560 and 579 => '560-579',	
																													 (integer)left.#expand(f1) between 580 and 599 => '580-599',	
																													 (integer)left.#expand(f1) between 600 and 619 => '600-619',	
																													 (integer)left.#expand(f1) >= 620  => '>=620',	
																													 (integer)left.#expand(f1) >= 300  => '>=300',																																																													
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_304(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 100  => '100',
																													 (integer)left.#expand(f1) = 200  => '200',
																													 (integer)left.#expand(f1) = 222  => '222',
																												   (integer)left.#expand(f1) between 300 and 549 => '300-549',	
																													 (integer)left.#expand(f1) between 550 and 589 => '550-589',	
																													 (integer)left.#expand(f1) between 590 and 619 => '590-619',	
																													 (integer)left.#expand(f1) between 620 and 669 => '620-669',	
																													 (integer)left.#expand(f1) >= 670  => '>=670',	
																													 (integer)left.#expand(f1) >= 300  => '>=300',																																																													
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_305(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) >= 300  => '>=300',																																																													
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_306(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',																																																										
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_307(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',																																																											
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_308(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 3 => '1-3',	
																													 (integer)left.#expand(f1) between 4 and 6 => '4-6',	
																													 (integer)left.#expand(f1) = 7  => '7',																																																											
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_309(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2 => '2',																																																
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_310(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 144 => '1-144',	
																													 (integer)left.#expand(f1) between 115 and 179 => '115-179',	
																													 (integer)left.#expand(f1) between 180 and 249 => '180-249',	
																													 (integer)left.#expand(f1) between 250 and 319 => '250-319',	
																													 (integer)left.#expand(f1) between 320 and 960 => '320-960',																																															
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_311(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 960 => '2-960',																																															
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_312(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',																																													
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_313(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 3 => '1-3',	
																													 (integer)left.#expand(f1) = 4  => '4',
																													 (integer)left.#expand(f1) between 5 and 7 => '5-7',																																													
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_314(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 0 and 29 => '0-29',	
																													 (integer)left.#expand(f1) between 30 and 37 => '30-37',	
																													 (integer)left.#expand(f1) between 38 and 44 => '38-44',	
																													 (integer)left.#expand(f1) between 45 and 54 => '45-54',	
																													 (integer)left.#expand(f1) between 55 and 150 => '55-150',																																											
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_315(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 255 => '2-255',																																											
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_316(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2-3',																																											
																													 (integer)left.#expand(f1) between 4 and 6 => '4-6',																																											
																													 (integer)left.#expand(f1) between 7 and 9 => '7-9',																																											
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;



//***************************************//
//***************************************//


EXPORT range_Function_317(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) between 3 and 4 => '3-4',																																											
																													 (integer)left.#expand(f1) between 5 and 9 => '5-9',																																																																																				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_318(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',																																										
																													 (integer)left.#expand(f1) between 3 and 9 => '3-9',																																																																																				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_319(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																												
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_320(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																												
																													 (integer)left.#expand(f1) = 1  => '1',																																																																																																																												
																													 (integer)left.#expand(f1) = 2  => '2',																																																																																																																												
																													 (integer)left.#expand(f1) = 3  => '3',																																																																																																																												
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_321(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																												
																													 (integer)left.#expand(f1) = 7  => '7',																																																																																																																												
																													 (integer)left.#expand(f1) between 1 and 6 => '1-6',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_322(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 3  => '3',																																																																																																																												
																													 (integer)left.#expand(f1) = 4  => '4',																																																																																																																												
																													 (integer)left.#expand(f1) = 5  => '5',																																																																																																																												
																													 (integer)left.#expand(f1) = 9  => '9',																																																																																																																												
																													 (integer)left.#expand(f1) between 0 and 2 => '0-2',
																													 (integer)left.#expand(f1) between 6 and 8 => '6-8',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_323(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',																																																																																																																												
																													 (integer)left.#expand(f1) = 2  => '2',																																																																																																																												
																													 (integer)left.#expand(f1) = 3  => '3',																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) between 4 and 255 => '4-255',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_324(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',																																																																																																																												
																													 (integer)left.#expand(f1) = 2  => '2',																																																																																																																																																																																																																																																																																																																																																																																
																													 (integer)left.#expand(f1) between 3 and 255 => '3-255',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_325(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) between 1 and 109 => '1-109',
																													 (integer)left.#expand(f1) between 110 and 179 => '110-179',
																													 (integer)left.#expand(f1) between 180 and 244 => '180-244',
																													 (integer)left.#expand(f1) between 245 and 314 => '245-314',
																													 (integer)left.#expand(f1) between 315 and 960 => '315-960',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_326(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) between 1 and 6 => '1-6',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_327(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) between 1 and 255 => '1-255',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_328(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) between 0 and 5 => '0-5',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_329(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) between 1 and 24 => '1-24',
																													 (integer)left.#expand(f1) between 25 and 54 => '25-54',
																													 (integer)left.#expand(f1) between 55 and 64 => '55-64',
																													 (integer)left.#expand(f1) between 65 and 89 => '65-89',
																													 (integer)left.#expand(f1) between 90 and 960 => '90-960',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_330(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 1  => '1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 2  => '2',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_331(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 1  => '1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 2  => '2',		
																													 (integer)left.#expand(f1) between 3 and 4 => '3-4',
																													 (integer)left.#expand(f1) between 5 and 9 => '5-9',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_332(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 1  => '1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 2  => '2',		
																													 (integer)left.#expand(f1) = 3  => '3',		
																													 (integer)left.#expand(f1) = 4  => '4',		
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_333(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 1  => '1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) between 2 and 255 => '2-255',		
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_334(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																										
																													 (integer)left.#expand(f1) between 1 and 149 => '1-149',		
																													 (integer)left.#expand(f1) between 150 and 960 => '150-960',		
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_335(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																										
																													 (integer)left.#expand(f1) between 1 and 119 => '1-119',		
																													 (integer)left.#expand(f1) between 120 and 960 => '120-960',		
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_336(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																										
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																										
																													 (integer)left.#expand(f1) between 1 and 255 => '1-255',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_337(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																
																													 (integer)left.#expand(f1) between 1 and 960 => '1-960',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_338(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																
																													 (integer)left.#expand(f1) between 0 and 9999999 => '0-9999999',					
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_339(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
	                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.01 and 0.99 => '0.01-0.99',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.01 and 99.99 => '1.01-99.99',
                                                                
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );    
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_340 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																
																													 (integer)left.#expand(f1) = 1  => '1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																
																													 (integer)left.#expand(f1) = 2  => '2',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																
																													 (integer)left.#expand(f1) between 3 and 7 => '3-7',					
																													 (integer)left.#expand(f1) between 8 and 255 => '8-255',					
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_341 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																								
																													 (integer)left.#expand(f1) between 0 and 9 => '0-9',					
																													 (integer)left.#expand(f1) between 10 and 9999999 => '10-9999999',					
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_342 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) = 3  => '3',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) between 1 and 2 => '1-2',					
																													 (integer)left.#expand(f1) between 4 and 5 => '4-5',					
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_343 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) = 1 => '1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) between 2 and 3 => '2-3',					
																													 (integer)left.#expand(f1) between 4 and 255 => '4-255',					
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_344 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) between 1 and 29 => '1-29',					
																													 (integer)left.#expand(f1) between 30 and 120 => '30-120',					
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_345 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) between 1 and 84 => '1-84',									
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_346 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 6  => '6',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) between 1 and 5 => '1-5',									
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_347 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							
																													 (integer)left.#expand(f1) = 0  => '0',																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
																													 (integer)left.#expand(f1) between 1 and 2 => '1-2',									
																													 (integer)left.#expand(f1) between 3 and 255 => '3-255',									
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_348 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 29 => '1-29',									
																													 (integer)left.#expand(f1) between 30 and 84 => '30-84',									
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_349 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 9999999 => '1-9999999',																	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_350 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 120 => '1-120',																	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_351 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 5 => '1-5',																	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_352 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 0 and 2 => '0-2',																	
																													 (integer)left.#expand(f1) between 3 and 4 => '3-4',																	
																													 (integer)left.#expand(f1) between 5 and 6 => '5-6',																	
																													 (integer)left.#expand(f1) between 7 and 9 => '7-9',																	
																													 (integer)left.#expand(f1) between 10 and 255 => '10-255',																	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_353 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 19 => '1-19',																	
																													 (integer)left.#expand(f1) between 20 and 34 => '20-34',																	
																													 (integer)left.#expand(f1) between 35 and 79 => '35-79',																	
																													 (integer)left.#expand(f1) between 80 and 960 => '80-960',																																	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_354 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 14 => '2-14',																																																	
																													 (integer)left.#expand(f1) between 15 and 960 => '15-960',																																																	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_355 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 19 => '1-19',																																																	
																													 (integer)left.#expand(f1) between 20 and 39 => '20-39',																																																	
																													 (integer)left.#expand(f1) between 40 and 99 => '40-99',																																																	
																													 (integer)left.#expand(f1) between 100 and 960 => '100-960',																																																	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_356 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 0 and 1 => '0-1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2-3',
																													 (integer)left.#expand(f1) between 4 and 255 => '4-255',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_357 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 960 => '1-960',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_358 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 0 and 9999999 => '0-9999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_359 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 9999999 => '1-9999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_360 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 89999 => '1-89999',
																													 (integer)left.#expand(f1) between 90000 and 9999999 => '90000-9999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_361 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 99999 => '1-99999',
																													 (integer)left.#expand(f1) between 100000 and 9999999 => '100000-9999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_362 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 0.01 and 0.99 => '0.01-0.99',
																													 (integer)left.#expand(f1) between 1.01 and 1.49 => '1.01-1.49',
																													 (integer)left.#expand(f1) between 1.50 and 99.99 => '1.50-99.99',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_363 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
	                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.01 and 0.99 => '0.01-0.99',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.01 and 99.99 => '1.01-99.99',
                                                                
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );    
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_364 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
	                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.01 and 0.99 => '0.01-0.99',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.01 and 99.99 => '1.01-99.99',
                                                                
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_365 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
	                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.01 and 0.99 => '0.01-0.99',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.01 and 99.99 => '1.01-99.99',
                                                                
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );      
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_366 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
	                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.01 and 0.99 => '0.01-0.99',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.01 and 99.99 => '1.01-99.99',
                                                                
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );    			
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_367 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 9 => '1-9',
																													 (integer)left.#expand(f1) between 10 and 24 => '10-24',
																													 (integer)left.#expand(f1) between 25 and 49 => '25-49',
																													 (integer)left.#expand(f1) between 50 and 109 => '50-109',
																													 (integer)left.#expand(f1) between 110 and 960 => '110-960',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_368 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 9 => '1-9',
																													 (integer)left.#expand(f1) between 10 and 19 => '10-19',
																													 (integer)left.#expand(f1) between 20 and 49 => '20-49',
																													 (integer)left.#expand(f1) between 50 and 109 => '50-109',
																													 (integer)left.#expand(f1) between 110 and 960 => '110-960',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_369 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 960 => '1-960',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_370 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 9999999 => '1-9999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_371 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 0 and 9999999 => '0-9999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_372 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 0 and 79999 => '0-79999',
																													 (integer)left.#expand(f1) between 80000 and 9999999 => '80000-9999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_373 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.01 and 0.99 => '0.01-0.99',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.01 and 1.39 => '1.01-1.39',
																																		 (real)left.#expand(f1) between 1.40 and 99.99 => '1.40-99.99',
                                                                
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );    
																		

// self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															// MAP(
																														// length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 // (integer)left.#expand(f1) = -1  => '-1',
																													 // (integer)left.#expand(f1) = 0  => '0',
																													 // (integer)left.#expand(f1) = 1  => '1',
																													 // (integer)left.#expand(f1) between 0.01 and 0.99 => '0.01-0.99',
																													 // (integer)left.#expand(f1) between 1.01 and 1.39 => '1.01-1.39',
																													 // (integer)left.#expand(f1) between 1.40 and 99.99 => '1.40-99.99',
																															 // 'UNDEFINED'),
																															  // 'UNDEFINED'
																																 // );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_374 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.01 and 0.64 => '0.01-0.64',
																																		 (real)left.#expand(f1) between 0.65 and 0.99 => '0.65-0.99',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.01 and 1.19 => '1.01-1.19',
																																		 (real)left.#expand(f1) between 1.20 and 99.99 => '1.20-99.99',
                                                                
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );    
																			// self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															// MAP(
																														// length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 // (integer)left.#expand(f1) = -1  => '-1',
																													 // (integer)left.#expand(f1) = 0  => '0',
																													 // (integer)left.#expand(f1) = 1  => '1',
																													 // (integer)left.#expand(f1) between 0.01 and 0.64 => '0.01-0.64',
																													 // (integer)left.#expand(f1) between 0.65 and 0.99 => '0.65-0.99',
																													 // (integer)left.#expand(f1) between 1.01 and 1.19 => '1.01-1.19',
																													 // (integer)left.#expand(f1) between 1.20 and 99.99 => '1.20-99.99',
																															 // 'UNDEFINED'),
																															  // 'UNDEFINED'
																																 // );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_375 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																				self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.01 and 0.69 => '0.01-0.69',
																																		 (real)left.#expand(f1) between 0.70 and 0.99 => '0.70-0.99',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.01 and 99.99 => '1.01-99.99',
                                                                
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );    
																			// self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															// MAP(
																														// length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 // (integer)left.#expand(f1) = -1  => '-1',
																													 // (integer)left.#expand(f1) = 0  => '0',
																													 // (integer)left.#expand(f1) = 1  => '1',
																													 // (integer)left.#expand(f1) between 0.01 and 0.69 => '0.01-0.69',
																													 // (integer)left.#expand(f1) between 0.70 and 0.99 => '0.70-0.99',
																													 // (integer)left.#expand(f1) between 1.01 and 99.99 => '1.01-99.99',
																															 // 'UNDEFINED'),
																															  // 'UNDEFINED'
																																 // );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_376 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 19 => '1-19',
																													 (integer)left.#expand(f1) between 20 and 39 => '20-39',
																													 (integer)left.#expand(f1) between 40 and 79 => '40-79',
																													 (integer)left.#expand(f1) between 80 and 139 => '80-139',
																													 (integer)left.#expand(f1) between 140 and 960 => '140-960',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_377 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 19 => '2-19',
																													 (integer)left.#expand(f1) between 20 and 54 => '20-54',
																													 (integer)left.#expand(f1) between 55 and 960 => '55-960',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_378 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between 1 and 4 => '1-4',
																													 (integer)left.#expand(f1) between 5 and 19 => '5-19',
																													 (integer)left.#expand(f1) between 20 and 44 => '20-44',
																													 (integer)left.#expand(f1) between 45 and 89 => '45-89',
																													 (integer)left.#expand(f1) between 90 and 960 => '90-960',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_379 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_380 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 5  => '5',
																													 (integer)left.#expand(f1) between 1 and 4 => '1-4',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_381 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) = 4  => '4',
																													 (integer)left.#expand(f1) = 5  => '5',
																													 (integer)left.#expand(f1) = 6  => '6',
																													 (integer)left.#expand(f1) between 0 and 1 => '0-1',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_382 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) between 3 and 255 => '3-255',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_383 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			
																						self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.01 and 99.99 => '0.01-99.99',
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          ); 
																			// self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															// MAP(
																														// length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 // (integer)left.#expand(f1) = -1  => '-1',
																													 // (integer)left.#expand(f1) = 0  => '0',
																													 // (integer)left.#expand(f1) between 0.01 and 99.99 => '0.01-99.99',
																															 // 'UNDEFINED'),
																															  // 'UNDEFINED'
																																 // );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_384 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2-3',
																													 (integer)left.#expand(f1) between 4 and 7 => '4-7',
																													 (integer)left.#expand(f1) between 8 and 9 => '8-9',
																													 (integer)left.#expand(f1) between 10 and 12 => '10-12',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_385 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 5  => '5',
																													 (integer)left.#expand(f1) = 6  => '6',
																													 (integer)left.#expand(f1) between 0 and 1 => '0-1',
																													 (integer)left.#expand(f1) between 3 and 4 => '3-4',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_386 (DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 19999 => '1-19999',
																													 (integer)left.#expand(f1) between 20000 and 99999 => '20000-99999',
																													 (integer)left.#expand(f1) between 100000 and 9999999 => '100000-9999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_387(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := if(RegexFind('[.~!@&%#$^*()_=+?<>,/"{}|]',
																			                              TRIM((string)left.#expand(f1),LEFT,RIGHT)), 'undefined',
																																MAP(length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',	
																														 	  (integer)left.#expand(f1)= -1 => '-1',
																																RegexFind('[	 \n\r]',
																																    TRIM((string)left.#expand(f1),LEFT,RIGHT))=> 'Null Value',
																																				 length(trim((string)left.#expand(f1),left,right))!= 0  => 'value populated',
																																				 'undefined'
																																				 )); 

		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_388(DS,f1,Result) := MACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string field_name;
			 
			string distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := if(RegexFind('[.~!@&%#$^*()_=+?<>,/"{}|]',
																			                              TRIM((string)left.#expand(f1),LEFT,RIGHT)), 'undefined',
																																MAP(length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',	
																														 	  (integer)left.#expand(f1)= -1 => '-1',
																																RegexFind('[	 \n\r]',
																																    TRIM((string)left.#expand(f1),LEFT,RIGHT))=> 'Null Value',
																																				 length(trim((string)left.#expand(f1),left,right))!= 0  => 'value populated',
																																				 'undefined'
																																				 )); 

		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			 
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 Count1 := count(group);
		END;

		result :=  table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

ENDMACRO;

END;