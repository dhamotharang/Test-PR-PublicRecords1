IMPORT ut, scoring_project;
EXPORT Bus_Functions_Module := MODULE

																																		
EXPORT Average_func(DS,f1,cname) := FUNCTIONMACRO																																										
																																										
		#uniquename(tble)																																								
		%tble% := table(ds);																																								
																																										
		#uniquename(a2)																																								
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and (integer)#expand(f1)>0 );																																								
																																										
		#uniquename(rc)																																								
		%rc% := record																																								
		  string100 field_name;																																								
			string100 category;																																							
			string30 distribution_type ;																																							
			string50 attribute_value ;																																							
			decimal20_4 frequency;																																							
		end;																																								
																																										
		#uniquename(a)																																								
		%a% := dataset([{'','','average','ave>0',0}],%rc%);																																								
																																										
		#uniquename(Bks_project)																																								
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      																																								
																						 self.field_name:=f1;																				
																						 																				
																						 self.frequency := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));																				
																						 self := left;																				
																						));																				
																																										
		RETURN %Bks_project%;																																								
																																										
ENDMACRO;																																					


//***************************************//
//***************************************//

																																				
EXPORT Average_func2(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=0 );

		#uniquename(rc)
		%rc% := record
		  string100 field_name;
			string100 category;
			string30 distribution_type ;
			string50 attribute_value ;
			decimal20_4 frequency;
		end;

		#uniquename(a)
		%a% := dataset([{'','','average','ave>=0',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  self.category:=cname;
																						 self.frequency := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		RETURN %Bks_project%;

ENDMACRO;																																		


//***************************************//
//***************************************//


EXPORT MACRO_distinct_boolean_values(file_name,fieldname, cname):= FUNCTIONMACRO

		r_FIELD_NAME := RECORD 
			string100 field_name := fieldname;
			string100 category := cname;
			string30 distribution_type := 'DISTINCT-VALUE';
			string50 attribute_value :=if(file_name.#expand(fieldname),'true','false');
			decimal20_4 frequency := count(group);
		end;

		t_FIELD_NAME := table(file_name,r_FIELD_NAME,file_name.#expand(fieldname));

		RETURN t_FIELD_NAME;

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_distinct_numeric(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_distinct_alphabetic(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//

EXPORT range_Function_distinct_alphanumeric(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																																    TRIM((string)left.#expand(f1),LEFT,RIGHT))=> 'nulls',
																																		     (string) left.#expand(f1))); 
 
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

// EXPORT range_Function_164 (file_name,fieldname, cname, offset1):= functionmacro

// r_FIELD_NAME := record 
  // string100 field_name := fieldname;
	// string100 category := cname;
  // string30 distribution_type := 'DATE-DAYS-APART';
  // string50 attribute_value := MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	// (unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	// length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	// length(trim((string)file_name.#expand(fieldname))) > 8 => 'undefined',
																	// length(trim((string)file_name.#expand(fieldname))) < 8  => 'undefined',
																	// (unsigned)file_name.#expand(fieldname) > (unsigned)Scoring_Project.Function_Last30Days(ut.GetDate, offset1) => 'Less Than ' +  (string)offset1 + ' days',
																	 // 'Greater Than ' +  (string)offset1 + ' days');
// decimal20_4 frequency := count(group);
// end;


// t_FIELD_NAME := table(file_name,r_FIELD_NAME,MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	// (unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	// length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	// length(trim((string)file_name.#expand(fieldname))) > 8 => 'undefined',
																	// length(trim((string)file_name.#expand(fieldname))) < 8  => 'undefined',
																	// (unsigned)file_name.#expand(fieldname) > (unsigned)Scoring_Project.Function_Last30Days(ut.GetDate, offset1) => 'Less Than ' +  (string)offset1 + ' days',
																	 // 'Greater Than ' +  (string)offset1 + ' days'));
	

// return t_FIELD_NAME;

// endmacro;


//***************************************//
//***************************************//


EXPORT range_Function_255(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//

EXPORT range_Function_256(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_257(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_278(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//

EXPORT range_Function_280(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) >0  => 'Value Populated>0',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//

EXPORT range_Function_281(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) >0  => 'Value Populated>0',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//

EXPORT range_Function_300(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																												   (integer)left.#expand(f1) between 0 and 2 => '0-2',	
																													 (integer)left.#expand(f1) between 3 and 4 => '3-4',	
																													 (integer)left.#expand(f1) between 5 and 9 => '5-9',	
																													 (integer)left.#expand(f1) between 10 and 999 => '10-999',																																																													
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_301(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 4=>'2-4',
																													 (integer)left.#expand(f1) between 5 and 24=>'5-24', 		
																													 (integer)left.#expand(f1)>= 25  => '>=25',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_302(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 1=>'0-1',
																													 (integer)left.#expand(f1) between 2 and 4=>'2-4',
																													 (integer)left.#expand(f1) between 5 and 6=>'5-6', 
																													 (integer)left.#expand(f1) between 7 and 9999=>'7-9999', 																																																																															
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;



//***************************************//
//***************************************//

EXPORT range_Function_303(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 9999=>'2-9999',																																																																												
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_304(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 3 and 9999=>'3-9999',																																																																												
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_305(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 3=>'2-3',				
																													 (integer)left.#expand(f1) between 4 and 9999=>'4-9999',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_306(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 3=>'2-3',				
																													 (integer)left.#expand(f1)>= 4  => '>=4',					
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_307(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 2=>'1-2',	
																													 (integer)left.#expand(f1) between 3 and 6=>'3-6',				
																													 (integer)left.#expand(f1)>= 7  => '>=7',					
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_308(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 1=>'0-1',
																													 (integer)left.#expand(f1) between 2 and 4=>'2-4',				
																													 (integer)left.#expand(f1) between 5 and 9999=>'5-9999',						
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_309(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 3=>'1-3',
																													 (integer)left.#expand(f1) between 4 and 6=>'4-6',				
																													 (integer)left.#expand(f1) between 7 and 999=>'7-999',						
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_310(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 44=>'1-44',
																													 (integer)left.#expand(f1) between 45 and 99999=>'45-99999',									
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_311(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 999=>'0-999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_312(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 999=>'2-999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_313(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 999=>'1-999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_314(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 999999=>'0-999999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_315(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 6 => '6',
																													 (integer)left.#expand(f1)= 7 => '7',
																													 (integer)left.#expand(f1)= 8 => '8',
																													 (integer)left.#expand(f1) between 1 and 5=>'1-5',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_316(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 7 => '7',
																													 (integer)left.#expand(f1)= 8 => '8',
																													 (integer)left.#expand(f1) between 1 and 6=>'1-6',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_317(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 8 => '8',
																													 (integer)left.#expand(f1) between 1 and 5=>'1-5',		
																													 (integer)left.#expand(f1) between 6 and 7=>'6-7',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

//***************************************//
//***************************************//


EXPORT range_Function_318(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 7 => '7',
																													 (integer)left.#expand(f1)= 8 => '8',
																													 (integer)left.#expand(f1) between 1 and 6=>'1-6',		
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_319(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 69=>'0-69',		
																													 (integer)left.#expand(f1) between 70 and 109=>'70-109',		
																													 (integer)left.#expand(f1) between 110 and 179=>'110-179',		
																													 (integer)left.#expand(f1) between 180 and 99999=>'180-99999',		
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_320(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 4 => '4',
																													 (integer)left.#expand(f1) between 0 and 3=>'0-3',		
																													 (integer)left.#expand(f1) between 5 and 99999=>'5-99999',		
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_321(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 5=>'2-5',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_322(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 3 and 5=>'3-5',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_323(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 999=>'2-999',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_324(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 19=>'1-19',			
																													 (integer)left.#expand(f1) between 20 and 110=>'20-110',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_325(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 39=>'0-39',			
																													 (integer)left.#expand(f1) between 40 and 999999999=>'40-999999999',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_326(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 4=>'0-4',			
																													 (integer)left.#expand(f1) between 5 and 7=>'5-7',			
																													 (integer)left.#expand(f1) between 8 and 19=>'8-19',			
																													 (integer)left.#expand(f1) between 20 and 110=>'20-110',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_327(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 999999999=>'1-999999999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_328(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)>= 0  => '>=0',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_329(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 1 and 799=>'1-799',				
																													 (integer)left.#expand(f1) between 800 and 5999=>'800-5999',				
																													 (integer)left.#expand(f1)>= 6000  => '>=6000',			
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_330(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 99999=>'2-99999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_331(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 1 and 99999=>'1-99999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_332(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 3 and 99999=>'3-99999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_333(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 49=>'1-49',				
																													 (integer)left.#expand(f1) between 50 and 99=>'50-99',				
																													 (integer)left.#expand(f1) between 100 and 99999=>'100-99999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_334(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99999=>'1-99999',						
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_335(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 52=>'2-52',						
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_336(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 99999=>'2-99999',						
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_337(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 52=>'2-52',						
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_338(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)>= 2  => '>=2',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_339(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 52=>'1-52',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_340(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)>= 1  => '>=1',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_341 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)>= 1  => '>=1',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_342 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99999=>'1-99999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_343 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99999999=>'1-99999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_344 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 1 and 99999999=>'1-99999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_345 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_346 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 9999=>'2-9999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_347 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 999999=>'1-999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_348 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 1 and 999999=>'1-999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_349 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 4=>'0-4',
																													 (integer)left.#expand(f1) between 5 and 9=>'5-9',
																													 (integer)left.#expand(f1)>= 10  => '>=10',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_350 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 59=>'0-59',
																													 (integer)left.#expand(f1) between 60 and 159=>'60-159',
																													 (integer)left.#expand(f1)>= 160  => '>=160',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_351 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 999999=>'2-999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_352 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 100=>'1-100',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_353 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 100 => '100',
																													 (integer)left.#expand(f1) between 1 and 100=>'1-100',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;



//***************************************//
//***************************************//


EXPORT range_Function_354 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 4=>'1-4',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_355 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 3=>'0-3',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_356 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 1=>'0-1',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_357 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 1=>'0-1',
																													 (integer)left.#expand(f1) between 2 and 3=>'2-3',
																													 (integer)left.#expand(f1) between 4 and 6=>'4-6',
																													 (integer)left.#expand(f1) between 7 and 99999=>'7-99999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_358 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 1=>'0-1',
																													 (integer)left.#expand(f1) between 2 and 3=>'2-3',
																													 (integer)left.#expand(f1) between 4 and 6=>'4-6',
																													 (integer)left.#expand(f1)>= 7  => '>=7',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_359 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 9999=>'1-9999',
																													 (integer)left.#expand(f1) between 10000 and 999999999=>'10000-999999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_360 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 199999=>'1-199999',
																													 (integer)left.#expand(f1) between 200000 and 999999999=>'200000-999999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_361 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 1899=>'1-1899',
																													 (integer)left.#expand(f1) between 1999 and 999999999=>'1999-999999999',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_362 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 4 => '4',
																													 (integer)left.#expand(f1) between 1 and 3=>'1-3',
																													 (integer)left.#expand(f1) between 5 and 6=>'5-6',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_363 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)<= 1990  => '<=1990',
																													 (integer)left.#expand(f1) between 1991 and 1999=>'1991-1999',
																													 (integer)left.#expand(f1) between 2000 and 2005=>'2000-2005',
																													 (integer)left.#expand(f1) between 2006 and 2009=>'2006-2009',
																													 (integer)left.#expand(f1)>= 2010  => '>=2010',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_distinct_alphanumeric2(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := if(RegexFind('[.~!@&%#$^*()_=+?<>,/"{}|]',
																			                              TRIM((string)left.#expand(f1),LEFT,RIGHT)), 'undefined',
																															(string)left.#expand(f1)= Y => 'Y',
																															(string)left.#expand(f1)= N => 'N',
																																MAP(length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',	
																																RegexFind('[	 \n\r]',
																																    TRIM((string)left.#expand(f1),LEFT,RIGHT))=> 'nulls',																				
																															(integer)left.#expand(f1)= -1 => '-1',
																															(integer)left.#expand(f1)= 0 => '0',
																															(string)left.#expand(f1)= Y => 'Y',
																															(string)left.#expand(f1)= N => 'N',
																																		     (string) left.#expand(f1))); 
 
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_364(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -1 => '-1',
																													 (integer)left.#expand(f1) between 0 and 99999=>'0-99999',				
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

end;