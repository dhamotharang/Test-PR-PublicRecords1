EXPORT Functions_Module := MODULE

IMPORT ut;

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

EXPORT Average_func(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0);

		#uniquename(rc)
		%rc% := record
		  string100 field_name;
			string100 category;
			string30 distribution_type ;
			string50 attribute_value ;
			decimal20_4 frequency;
		end;

		#uniquename(a)
		%a% := dataset([{'','','average','average',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  self.category:=cname;
																						 self.frequency := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		RETURN %Bks_project%;

ENDMACRO;

EXPORT Average_func1(DS,f1,cname) := FUNCTIONMACRO

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

EXPORT Average_func2(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and 
		                                                      (integer)#expand(f1) between 0 and 254);

		#uniquename(rc)
		%rc% := record
		  string100 field_name;
			string100 category;
			string30 distribution_type ;
			string50 attribute_value ;
			decimal20_4 frequency;
		end;

		#uniquename(a)
		%a% := dataset([{'','','average','ave>=0 and ave<=254',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  self.category:=cname;
																						 self.frequency := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		RETURN %Bks_project%;

ENDMACRO;

EXPORT Average_func3(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and (integer)#expand(f1)<>12
		                                                     and (integer)#expand(f1)<>255  and (integer)#expand(f1)>=0);

		#uniquename(rc)
		%rc% := record
		  string100 field_name;
			string100 category;
			string30 distribution_type ;
			string50 attribute_value ;
			decimal20_4 frequency;
		end;

		#uniquename(a)
		%a% := dataset([{'','','average','ave>=0 and ave<>255 and ave<>12',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  self.category:=cname;
																						 self.frequency := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		RETURN %Bks_project%;

ENDMACRO;

EXPORT Average_func4(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and (integer)#expand(f1)<>9999
		                                                                                                     and (integer)#expand(f1)>=0);     
		                                                  

		#uniquename(rc)
		%rc% := record
		  string100 field_name;
			string100 category;
			string30 distribution_type ;
			string50 attribute_value ;
			decimal20_4 frequency;
		end;

		#uniquename(a)
		%a% := dataset([{'','','average','ave>=0 and ave<>9999',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  self.category:=cname;
																						 self.frequency := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		RETURN %Bks_project%;

ENDMACRO;

EXPORT Average_func5(DS,f1,cname) := FUNCTIONMACRO

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
																						  self.category:=cname;
																						 self.frequency := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																						 self := left;											
																						));

		RETURN %Bks_project%;

ENDMACRO;

EXPORT Average_func6(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and  (integer)#expand(f1)>0); 

		#uniquename(rc)
		%rc% := record
		  string100 field_name;
			string100 category;
			string30 distribution_type ;
			string50 attribute_value ;
			decimal20_4 frequency;
		end;

		#uniquename(a)
		%a% := dataset([{'','','average','ave months >0',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  self.category:=cname;
																						  self.frequency := Ave(%a2%,(decimal20_4) ut.MonthsApart(ut.getdate,(string)%a2%.#expand(f1)));
																						
																						 self := left;											
																						));

		RETURN %Bks_project%;

ENDMACRO;

EXPORT Average_func7(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(a2)
		%a2% :=%tble%(regexfind('[0-9]',(string)#expand(f1)) and  length(trim((string)#expand(f1),left,right))<> 0 and  (integer)#expand(f1)>0); 

		#uniquename(rc)
		%rc% := record
		  string100 field_name;
			string100 category;
			string30 distribution_type ;
			string50 attribute_value ;
			decimal20_4 frequency;
		end;

		#uniquename(a)
		%a% := dataset([{'','','average','ave days  >0',0}],%rc%);

		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,                                      
																						 self.field_name:=f1;
																						  self.category:=cname;
																						 self.frequency := Ave(%a2%,(decimal20_4) ut.DaysApart(ut.getdate,(string)%a2%.#expand(f1)));
																						
																						 self := left;											
																						));

		RETURN %Bks_project%;

ENDMACRO;

EXPORT range_Function_1(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between -200 and -51  => '(-200)-(-51)',
																													 (integer)left.#expand(f1) between -50 and -2  => '(-50)-(-2)',
																													 (integer)left.#expand(f1) between 1 and 50  => '1_50',
																													 (integer)left.#expand(f1) between 50 and 200  => '50-200',																																													
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

EXPORT range_Function_2(DS,f1,cname) := FUNCTIONMACRO

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
																														length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) >=4  => '>=4',																																																																						
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

EXPORT range_Function_3(DS,f1,cname) := FUNCTIONMACRO

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
																														length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between -300000 and -2  => '(-300000)-(-2)',
																													 (integer)left.#expand(f1) between 0 and 200000  => '0-200000',
																													 																																												
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

EXPORT range_Function_4(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) between -900000 and -100001  => '(-900000)-(-100001)',
																													 (integer)left.#expand(f1) between -100000 and -2  => '(-100000)-(-2)',
																													 (integer)left.#expand(f1) between 0 and 100000  => '0-100000',
																													 (integer)left.#expand(f1) between 100001 and 900000  => '100001-900000',
																													 																																												
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

EXPORT range_Function_5(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := IF(regexfind('[0-9a-zA-Z]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

EXPORT range_Function_6(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1) = 1  => '1',																														 																																												
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

EXPORT range_Function_7(DS,f1,cname) := FUNCTIONMACRO

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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

EXPORT range_Function_8(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 10  => '10',
																													 (integer)left.#expand(f1) = 12  => '12',
																													 (integer)left.#expand(f1) = 20  => '20',
																													 (integer)left.#expand(f1) = 255  => '255',
																													 (integer)left.#expand(f1) between 30 and 100  => '30-100',																																																																						
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

EXPORT range_Function_9(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 100000  => '1-100,000',		
																													 (integer)left.#expand(f1) > 100000  => '>100,000',
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

EXPORT range_Function_10(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 50000  => '1-50,000',	
																													 (integer)left.#expand(f1) between 50001 and 150000  => '50,001-150,000',
																													 (integer)left.#expand(f1) > 150000  => '>150,000',
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

EXPORT range_Function_11(DS,f1,cname) := FUNCTIONMACRO

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
																							  					 (integer)left.#expand(f1) between 1 and 70  => '1_70',		
																													 (integer)left.#expand(f1) between 71 and 100  => '71-100',	
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

EXPORT range_Function_12(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																							  					
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

EXPORT range_Function_13(DS,f1,cname) := FUNCTIONMACRO

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
																							  					 (integer)left.#expand(f1) between 1 and 1000  => '1-1000',		
																													 (integer)left.#expand(f1) >1000  => '>1000',	
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

EXPORT range_Function_14(DS,f1,cname) := FUNCTIONMACRO

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
																							  					 (integer)left.#expand(f1) between 1 and 29  => '1_29',		
																													 (integer)left.#expand(f1) between 30 and 33  => '30-33',	
																													 (integer)left.#expand(f1) between 34 and 37  => '34-37',	
																													 (integer)left.#expand(f1) between 38 and 43  => '38-43',	
																													 (integer)left.#expand(f1) >43  => '>43',	
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

EXPORT range_Function_15(DS,f1,cname) := FUNCTIONMACRO

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
																													 (decimal5_2)left.#expand(f1) = 0  => '0',
																							  					 (decimal5_2)left.#expand(f1) between 0.01 and 1  => '0.01-1',		
																													 (decimal5_2)left.#expand(f1) between 1 and 2  => '1_2',	
																													 (decimal5_2)left.#expand(f1) >2 => '>2',	
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

EXPORT range_Function_16(DS,f1,cname) := FUNCTIONMACRO

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
																													 (decimal5_2)left.#expand(f1) = 0  => '0',
																							  					 (decimal5_2)left.#expand(f1) between 0.01 and 1  => '0.01-1',		
																													 (decimal5_2)left.#expand(f1) between 1.01 and 2  => '1.01-2',	
																													 (decimal5_2)left.#expand(f1) between 2.01 and 4.99  => '2.01-4.99',	
																													 (decimal5_2)left.#expand(f1) >=5 => '>=5',	
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

EXPORT range_Function_17(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 150000  => '1-150,000',		
																													 (integer)left.#expand(f1) > 150000  => '>150,000',
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

EXPORT range_Function_18(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) >= 3  => '>=3',
																												
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

EXPORT range_Function_19(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 2 => '1_2',
																													 (integer)left.#expand(f1) =3 => '3',
																													 (integer)left.#expand(f1) >3  => '>3',
																												
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

EXPORT range_Function_20(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =1 => '1',
																													 (integer)left.#expand(f1) >1 => '>1',																										
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

EXPORT range_Function_21(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 5 => '1_5',
																													 (integer)left.#expand(f1) >5  => '>5',
																												
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

EXPORT range_Function_22(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =1 => '1',
																													 (integer)left.#expand(f1) =2 => '2',
																													 (integer)left.#expand(f1) >2 => '>2',																										
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

EXPORT range_Function_23(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 50000  => '1-50,000',	
																													 (integer)left.#expand(f1) between 50001 and 100000  => '50,001-100,000',
																													 (integer)left.#expand(f1) between 100001 and 150000  => '100,001-150,000',
																													 (integer)left.#expand(f1) > 150000  => '>150,000',
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

EXPORT range_Function_24(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) = 4  => '4',
																													 (integer)left.#expand(f1) > 4 => '>4',
																												
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

EXPORT range_Function_25(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := IF(regexfind('[0-9a-zA-Z]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																														length(trim((string)left.#expand(f1),left,right))<> 0 => 'value populated', 
																													
																												
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

EXPORT range_Function_26(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) >0  => '>0',
																											
																												
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

EXPORT range_Function_27(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 10  => '10',
																													 (integer)left.#expand(f1) = 12  => '12',
																													 (integer)left.#expand(f1) between 20 and 30  => '20-30',		
																													 (integer)left.#expand(f1) between 40 and 100  => '40-100',	
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

EXPORT range_Function_28(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 29  => '1_29',		
																													 (integer)left.#expand(f1) between 30 and 33  => '30-33',	
																													 (integer)left.#expand(f1) between 34 and 38  => '34-38',	
																													 (integer)left.#expand(f1) between 39 and 45  => '39-45',	
																													 (integer)left.#expand(f1) >45  => '>45',	
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

EXPORT range_Function_29(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 12  => '1_12',		
																													 (integer)left.#expand(f1) between 13 and 24  => '13-24',	
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

EXPORT range_Function_30(DS,f1,cname) := FUNCTIONMACRO

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
																													 (decimal5_2)left.#expand(f1) = 0  => '0',
																							  					 (decimal5_2)left.#expand(f1) between 0.01 and 0.75  => '0.01-0.75',		
																													 (decimal5_2)left.#expand(f1) between 0.76 and 1.25  => '0.76-1.25',	
																													 (decimal5_2)left.#expand(f1) between 1.26 and 2  => '1.26-2',	
																													 (decimal5_2)left.#expand(f1) >2 => '>2',	
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

EXPORT range_Function_31(DS,f1,cname) := FUNCTIONMACRO

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
																													 (decimal5_2)left.#expand(f1) between 0 and 1  => '0-1',		
																													 (decimal5_2)left.#expand(f1) between 1 and 2  => '1_2',	
																													 (decimal5_2)left.#expand(f1) >2 => '>2',	
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

EXPORT range_Function_32(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 3 => '1_3',
																													 (integer)left.#expand(f1) >3  => '>3',
																												
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

EXPORT range_Function_33(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) between 4 and 5 => '4_5',
																													 (integer)left.#expand(f1) >5  => '>5',
																												
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

EXPORT range_Function_34(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 10 => '1_10',
																													 (integer)left.#expand(f1) >10  => '>10',
																												
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

EXPORT range_Function_35(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 25 => '1_25',
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

EXPORT range_Function_36(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2_3',
																													 (integer)left.#expand(f1) between 4 and 7 => '4_7',
																													 (integer)left.#expand(f1) >7 => '>7',
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

EXPORT range_Function_37(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 2 => '1_2',
																													 (integer)left.#expand(f1) >2 => '>2',
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

EXPORT range_Function_38(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',
																													 (integer)left.#expand(f1) >4 => '>4',
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

EXPORT range_Function_39(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 100 => '1-100',
																													 (integer)left.#expand(f1) between 101 and 200 => '101-200',
																													 (integer)left.#expand(f1) >200=> '>200',
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

EXPORT range_Function_40(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2_3',
																													 (integer)left.#expand(f1) >3=> '>3',
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

EXPORT range_Function_41(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 10=> '1_10',
																													 (integer)left.#expand(f1) >=11=> '>=11',
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

EXPORT range_Function_42(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 30=> '1_30',
																													 (integer)left.#expand(f1) = 40  => '40',
																													 (integer)left.#expand(f1) = 50  => '50',
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

EXPORT range_Function_43(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3=> '2_3',
																													 (integer)left.#expand(f1) >3  => '>3',																												
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

EXPORT range_Function_44(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 3=> '1_3',
																													 (integer)left.#expand(f1) = 4  => '4',
																													 (integer)left.#expand(f1) = 5  => '5',
																													 (integer)left.#expand(f1) >5  => '>5',																													
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

EXPORT range_Function_45(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 0  => '0',
																													  (integer)left.#expand(f1) = 1  => '1',
																													  (integer)left.#expand(f1) >1  => '>1',																												
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

EXPORT range_Function_46(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 0  => '0',
																														(integer)left.#expand(f1) between 1 and 3=> '1_3', 
																														(integer)left.#expand(f1) = 4  => '4',
																													  (integer)left.#expand(f1) between 5 and 6=> '5_6', 
																												 	  (integer)left.#expand(f1) >6  => '>6',																													
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

EXPORT range_Function_47(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 0  => '0',
																														(integer)left.#expand(f1) between 1 and 3=> '1_3', 
																														(integer)left.#expand(f1) between 4 and 5=> '4_5', 
																													  (integer)left.#expand(f1) between 6 and 7=> '6_7', 
																												 	  (integer)left.#expand(f1) >7  => '>7',																													
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

EXPORT range_Function_48(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 0  => '0',
																														(integer)left.#expand(f1) between 1 and 50=> '1_50', 
																														(integer)left.#expand(f1) between 51 and 100=> '51-100', 
																													  (integer)left.#expand(f1) between 101 and 150=> '101-150', 
																												 	  (integer)left.#expand(f1) >150  => '>150'	,																												
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

EXPORT range_Function_49(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 0  => '0',
																														(integer)left.#expand(f1) between 1 and 100000=> '1-100,000', 
																														(integer)left.#expand(f1) between 100001 and 200000=> '100001-200,000', 
																													  (integer)left.#expand(f1) between 200001 and 300000=> '200,001-300,000', 
																												 	  (integer)left.#expand(f1) >300000  => '>300,000',																													
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

EXPORT range_Function_50(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 1 and 10=> '1_10', 
																														(integer)left.#expand(f1) between 11 and 20=> '11_20', 
																													  (integer)left.#expand(f1) between 21 and 30=> '21-30', 
																												 	  (integer)left.#expand(f1) >30  => '>30',																													
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

EXPORT range_Function_51(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 1 and 2=> '1_2', 
																														(integer)left.#expand(f1) between 3 and 6=> '3_6', 
																												 	  (integer)left.#expand(f1) >6  => '>6',																													
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

EXPORT range_Function_52(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 0 and 2=> '0-2', 
																														(integer)left.#expand(f1) between 3 and 5=> '3_5', 
																														(integer)left.#expand(f1) between 5 and 10=> '5_10',
																												 	  (integer)left.#expand(f1) >10  => '>10',																													
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

EXPORT range_Function_53(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 1  => '1',
																														(integer)left.#expand(f1) between 2 and 5=> '2_5', 
																													  (integer)left.#expand(f1) >5  => '>5',																											
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

EXPORT range_Function_54(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 1 and 2=> '1_2', 
																														(integer)left.#expand(f1) between 3 and 10=> '3_10', 
																													  (integer)left.#expand(f1) >10  => '>10',																												
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

EXPORT range_Function_55(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 0  => '0',
																														(integer)left.#expand(f1) = 1  => '1',
																														(integer)left.#expand(f1) = 2  => '2',
																														(integer)left.#expand(f1) = 3  => '3',
																													  (integer)left.#expand(f1) >3  => '>3',																												
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

EXPORT range_Function_56(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 1  => '1',
																										    	  (integer)left.#expand(f1) >1  => '>1',																													
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

EXPORT range_Function_57(DS,f1,cname) := FUNCTIONMACRO

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

EXPORT range_Function_58(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 0  => '0',
																														(integer)left.#expand(f1) = 1  => '1',
																																																		
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

EXPORT range_Function_59(DS,f1,cname) := FUNCTIONMACRO

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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

EXPORT range_Function_60(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 12  => '12',
																														(integer)left.#expand(f1) = 100  => '100',
																														(integer)left.#expand(f1) = 255  => '255',
																														(integer)left.#expand(f1) between 0 and 10  => '0-10',
																														(integer)left.#expand(f1) between 20 and 90  => '20-90',																																														
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

EXPORT range_Function_61(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'count';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																														(integer)left.#expand(f1) =0  => 'count 0',
																														(integer)left.#expand(f1) >0  => 'count>0',
																																																																							
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

EXPORT range_Function_62(DS,f1,cname) := FUNCTIONMACRO

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
																													 (decimal5_2)left.#expand(f1) between 0 and 1 => '0-1',
																							  					 (decimal5_2)left.#expand(f1) between 1.01 and 3  => '1.01-3',		
																													 (decimal5_2)left.#expand(f1) between 3.01 and 8  => '3.01-8',	
																													 (decimal5_2)left.#expand(f1)> 8 and (decimal5_2)left.#expand(f1)< 255  => '8<x<255',	
																													 (decimal5_2)left.#expand(f1) =255 => '255',	
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

EXPORT range_Function_63(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 5  => '1_5',
																														(integer)left.#expand(f1) =6  => '6',
																														(integer)left.#expand(f1) >6  => '>6',
																																																																							
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

EXPORT range_Function_64(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 3  => '1_3',
																														(integer)left.#expand(f1) between 4 and 5  => '4_5',
																														(integer)left.#expand(f1) between 6 and 7  => '6_7',
																														(integer)left.#expand(f1) >7  => '>7',
																																																																							
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

EXPORT range_Function_65(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) between 2 and 10  => '2_10',																																
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

EXPORT range_Function_66(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 3  => '1_3',
																														(integer)left.#expand(f1) between 4 and 6  => '4_6',
																														(integer)left.#expand(f1) between 7 and 10  => '7_10',
																														(integer)left.#expand(f1) >11  => '11+',
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

EXPORT range_Function_67(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) >1  => '>1',
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

EXPORT range_Function_68(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) between 2 and 4  => '2_4',
																														(integer)left.#expand(f1) >4  => '>4',
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

EXPORT range_Function_69(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 0 and 1  => '0-1',
																														(integer)left.#expand(f1) between 2 and 3  => '2_3',
																														(integer)left.#expand(f1) between 4 and 5  => '4_5',
																														(integer)left.#expand(f1) >5  => '>5',
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

EXPORT range_Function_70(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) between 2 and 3  => '2_3',
																														(integer)left.#expand(f1) between 4 and 6  => '4_6',
																														(integer)left.#expand(f1) >6  => '>6',
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

EXPORT range_Function_71(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 0 and 1  => '0_1',
																														(integer)left.#expand(f1) between 2 and 3  => '2_3',
																														(integer)left.#expand(f1) between 4 and 6  => '4_6',
																														(integer)left.#expand(f1) between 7 and 10  => '7_10',
																														(integer)left.#expand(f1) >10  => '>10',
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

EXPORT range_Function_72(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 0 and 5  => '0_5',
																														(integer)left.#expand(f1) between 6 and 10  => '6_10',
																														(integer)left.#expand(f1) >10  => '>10',
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

EXPORT range_Function_73(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 0 and 1  => '0-1',
																														(integer)left.#expand(f1) between 2 and 3  => '2_3',
																														(integer)left.#expand(f1) between 4 and 6  => '4_6',
																														(integer)left.#expand(f1) between 7 and 10  => '7_10',
																														(integer)left.#expand(f1) between 11 and 244  => '>10 and <=244',
																														(integer)left.#expand(f1) =255  => '255',
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

EXPORT range_Function_74(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 0 and 5  => '0_5',
																														(integer)left.#expand(f1) between 6 and 10  => '6_10',
																														(integer)left.#expand(f1) between 11 and 244  => '>10 and <=244',
																														(integer)left.#expand(f1) =255  => '255',
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

EXPORT range_Function_75(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 0 and 4  => '0_4',
																														(integer)left.#expand(f1) between 5 and 10  => '5_10',
																														(integer)left.#expand(f1) between 11 and 244  => '>10 and <=244',
																														(integer)left.#expand(f1) =255  => '255',
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

EXPORT range_Function_76(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) between 2 and 3  => '2_3',
																														(integer)left.#expand(f1) between 4 and 10  => '4_10',
																														(integer)left.#expand(f1) between 11 and 244  => '>10 and <=244',
																														(integer)left.#expand(f1) =255  => '255',
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

EXPORT range_Function_77(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 7  => '1_7',
																														(integer)left.#expand(f1) =8  => '8',
																														(integer)left.#expand(f1) >8  => '>8',
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

EXPORT range_Function_78(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 0 and 11  => '0_11',
																														(integer)left.#expand(f1) =12  => '12',
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

EXPORT range_Function_79(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 200  => '1-200',
																														(integer)left.#expand(f1) between 201 and 400  => '201-400',
																														(integer)left.#expand(f1) between 401 and 600  => '401-600',
																														(integer)left.#expand(f1) >600  => '>600',
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

EXPORT range_Function_80(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 200  => '1-200',
																														(integer)left.#expand(f1) between 201 and 400  => '201-400',
																														(integer)left.#expand(f1) between 401 and 600  => '401-600',
																														(integer)left.#expand(f1) >600  => '>600',
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

EXPORT range_Function_81(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 10  => '1_10',
																														(integer)left.#expand(f1) between 11 and 30  => '11_30',
																														(integer)left.#expand(f1) between 31 and 70  => '31-70',
																														(integer)left.#expand(f1) >70  => '>70',
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

EXPORT range_Function_82(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 0 and 20  => '0-20',
																														(integer)left.#expand(f1) between 21 and 30  => '21-30',
																														(integer)left.#expand(f1) between 31 and 40  => '31-40',
																														(integer)left.#expand(f1) between 41 and 55  => '41-55',
																														(integer)left.#expand(f1) >55  => '>55',
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

EXPORT range_Function_83(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 0 and 1  => '0-1',
																														(integer)left.#expand(f1) =2  => '2',
																														(integer)left.#expand(f1) =3  => '3',
																														(integer)left.#expand(f1) >3 => '>3',
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

EXPORT range_Function_84(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 1 and 5  => '1_5',
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =6  => '6',
																														(integer)left.#expand(f1) >=7 => '>=7',
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

EXPORT range_Function_85(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =-1  => '-1',
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 10  => '1_10',
																														(integer)left.#expand(f1) between 11 and 20  => '11_20',
																														(integer)left.#expand(f1) >20 => '>20',
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

EXPORT range_Function_86(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																														length(trim((string)left.#expand(f1),left,right))between 0 and 8 => '0-8',
																													  length(trim((string)left.#expand(f1),left,right))= 9  => '9',
																													  length(trim((string)left.#expand(f1),left,right))= 10 => '10',
																														length(trim((string)left.#expand(f1),left,right))= 11 => '11',
																														length(trim((string)left.#expand(f1),left,right))= 12 => '12',
																													
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

EXPORT range_Function_87(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 30  => '1_30',
																														(integer)left.#expand(f1) between 31 and 40  => '31-40',
																														(integer)left.#expand(f1) between 41 and 50  => '41-50',
																														(integer)left.#expand(f1) >50 => '>50',
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

EXPORT range_Function_88(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																														length(trim((string)left.#expand(f1),left,right))between 0 and 9 => '0-9',
																							  					  length(trim((string)left.#expand(f1),left,right))= 10 => '10',
																														length(trim((string)left.#expand(f1),left,right))>10 => '>10',
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

EXPORT range_Function_89(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																														length(trim((string)left.#expand(f1),left,right))between 0 and 4 => '0-4',
																														length(trim((string)left.#expand(f1),left,right))=5 => '5',
																							  						length(trim((string)left.#expand(f1),left,right))>5 => '>5',
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

EXPORT range_Function_90(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 3=> '1_3', 
																														(integer)left.#expand(f1) = 4  => '4',
																													  (integer)left.#expand(f1) = 5  => '5',
																														(integer)left.#expand(f1) = 6  => '6',
																												 	  (integer)left.#expand(f1) >6  => '>6'	,																												
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

EXPORT range_Function_91(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) = 1  => '1',
																													  (integer)left.#expand(f1) between 2 and 6=> '2_6', 
																												 	  (integer)left.#expand(f1) >6  => '>6'	,																												
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

EXPORT range_Function_92(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) between 2 and 4  => '2_4',
																														(integer)left.#expand(f1) >4  => '>4',
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

EXPORT range_Function_93(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 10  => '10',
																													 (integer)left.#expand(f1) = 20  => '20',
																													 (integer)left.#expand(f1) = 255  => '255',
																													 (integer)left.#expand(f1) between 30 and 100  => '30-100',																																																																						
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

EXPORT range_Function_94(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = -9999  => '-9999',
																													 (integer)left.#expand(f1)>2 => '>2',																																																																						
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

EXPORT range_Function_95(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = -9999  => '-9999',
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',		
																													 (integer)left.#expand(f1)>4 => '>4',																																																																						
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

EXPORT range_Function_96(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = -9999  => '-9999',
																													 (integer)left.#expand(f1) between 0 and 3 => '0-3',	
																													 (integer)left.#expand(f1) between 4 and 6 => '4_6',	
																													 (integer)left.#expand(f1) between 7 and 9 => '7_9',
																													 (integer)left.#expand(f1) between 10 and 12 => '10_12',
																													 (integer)left.#expand(f1)>12 => '>12',																																																																						
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

EXPORT range_Function_97(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = -9999  => '-9999',
																													 (integer)left.#expand(f1) between 0 and 1 => '0-1',	
																													 (integer)left.#expand(f1) between 2 and 3 => '2_3',	
																													 (integer)left.#expand(f1) between 4 and 6 => '4_6',
																													 (integer)left.#expand(f1)>6 => '>6',																																																																						
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

EXPORT range_Function_98(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',	
																													 (integer)left.#expand(f1) between 5 and 6 => '5_6',
																													 (integer)left.#expand(f1) between 6 and 9 => '6_9',
																													 (integer)left.#expand(f1)>9 => '>9',																																																																						
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

EXPORT range_Function_99(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 0 and 1 => '0-1',	
																													 (integer)left.#expand(f1) =2 => '2',	
																													 (integer)left.#expand(f1) =3 => '3',	
																													 (integer)left.#expand(f1) =4 => '4',	
																													 (integer)left.#expand(f1)>4 => '>4',																																																																						
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

EXPORT range_Function_100(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 0 and 1 => '0-1',	
																													 (integer)left.#expand(f1) between 2 and 3 => '2_3',	
																													 (integer)left.#expand(f1) between 4 and 5 => '4_5',	
																													 (integer)left.#expand(f1) between 6 and 8 => '6_8',	
																													 (integer)left.#expand(f1)>8 => '>8',																																																																						
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

EXPORT range_Function_101(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 0 and 3 => '0-3',	
																													 (integer)left.#expand(f1) between 4 and 6 => '4_6',	
																													 (integer)left.#expand(f1) between 5 and 8 => '5_8',	
																													 (integer)left.#expand(f1) between 9 and 12 => '9_12',	
																													 (integer)left.#expand(f1)>12 => '>12',																																																																						
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

EXPORT range_Function_102(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 0 and 4 => '0-4',	
																													 (integer)left.#expand(f1) between 5 and 7 => '5_7',	
																													 (integer)left.#expand(f1) between 8 and 10 => '8_10',	
																													 (integer)left.#expand(f1) between 11 and 13 => '11_13',	
																													 (integer)left.#expand(f1)>13 => '>13',																																																																						
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

EXPORT range_Function_103(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 99 => '1_99',	
																													 (integer)left.#expand(f1)=100 => '100',																																																																						
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

EXPORT range_Function_104(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 10 => '1_10',	
																													 (integer)left.#expand(f1) between 11 and 20 => '11_20',	
																													 (integer)left.#expand(f1) between 21 and 30 => '21-30',	
																													 (integer)left.#expand(f1) between 31 and 254 => '31-254',	
																													 (integer)left.#expand(f1)=255 => '255',																																																																						
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

EXPORT range_Function_105(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =1 => '1',	
																													 (integer)left.#expand(f1) =2 => '2',	
																													 (integer)left.#expand(f1) between 3 and 254 => '3-254',	
																													 (integer)left.#expand(f1)=255 => '255',																																																																						
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

EXPORT range_Function_106(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =1 => '1',	
																													 (integer)left.#expand(f1) =2 => '2',	
																													 (integer)left.#expand(f1) between 3 and 5 => '3_5',	
																													 (integer)left.#expand(f1)>5 => '>5',																																																																						
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

EXPORT range_Function_107(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 15 => '1_15',
																													 (integer)left.#expand(f1) between 16 and 35 => '16-35',
																													 (integer)left.#expand(f1) between 36 and 75 => '36-75',
																													 (integer)left.#expand(f1)>75 => '>75',																																																																						
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

EXPORT range_Function_108(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 25 => '1_25',
																													 (integer)left.#expand(f1) between 26 and 125 => '26-125',
																													 (integer)left.#expand(f1)>125 => '>125',																																																																						
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

EXPORT range_Function_109(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 300 => '1-300',
																													 (integer)left.#expand(f1) between 301 and 400 => '301-400',
																													 (integer)left.#expand(f1)>400 => '>400',																																																																						
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

EXPORT range_Function_110(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 10 => '1_10',
																													 (integer)left.#expand(f1) between 11 and 30 => '11_30',
																													 (integer)left.#expand(f1) between 31 and 100 => '31-100',
																													 (integer)left.#expand(f1)>100 => '>100',																																																																						
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

EXPORT range_Function_111(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 25 => '1_25',
																													 (integer)left.#expand(f1) between 26 and 35 => '26-35',
																													 (integer)left.#expand(f1) between 36 and 45 => '36-45',
																													 (integer)left.#expand(f1) between 46 and 60 => '46-60',
																													 (integer)left.#expand(f1)>60 => '>60',																																																																						
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

EXPORT range_Function_112(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 60 => '1_60',
																													 (integer)left.#expand(f1) between 61 and 90 => '61-90',
																													 (integer)left.#expand(f1) between 91 and 135 => '91-135',
																													 (integer)left.#expand(f1)>135 => '>135',																																																																						
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

EXPORT range_Function_113(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 200 => '1-200',
																													 (integer)left.#expand(f1) between 201 and 250 => '201-250',
																													 (integer)left.#expand(f1) between 251 and 300 => '251-300',
																													 (integer)left.#expand(f1) between 301 and 400 => '301-400',
																													 (integer)left.#expand(f1)>400 => '>400',																																																																						
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

EXPORT range_Function_114(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 200 => '1-200',
																													 (integer)left.#expand(f1) between 201 and 300 => '201-300',
																													 (integer)left.#expand(f1) between 301 and 400 => '301-400',
																													 (integer)left.#expand(f1) between 401 and 500 => '401-500',
																													 (integer)left.#expand(f1)>500 => '>500',																																																																						
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

EXPORT range_Function_115(DS,f1,cname) := FUNCTIONMACRO

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
																														
																													 (integer)left.#expand(f1) between 1 and 30 => '1_30',
																													 (integer)left.#expand(f1) between 31 and 50 => '31-50',
																													 (integer)left.#expand(f1) between 51 and 80 => '51-80',
																													 (integer)left.#expand(f1) between 81 and 130 => '81-130',
																													 (integer)left.#expand(f1)>130 => '>130',																																																																						
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

EXPORT range_Function_116(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = -9999 =>'-9999',
																													 (integer)left.#expand(f1) between 0 and 15 => '0-15',
																													 (integer)left.#expand(f1) between 16 and 20 => '16-20',
																													 (integer)left.#expand(f1) between 21 and 30 => '21-30',
																													 (integer)left.#expand(f1) between 31 and 50 => '31-50',
																													 (integer)left.#expand(f1)>50 => '>50',																																																																						
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

EXPORT range_Function_117(DS,f1,cname) := FUNCTIONMACRO

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
																													
																													 (integer)left.#expand(f1) between 0 and 11 => '0-11',
																													 (integer)left.#expand(f1) = 12 =>'12',
																													 (integer)left.#expand(f1) between 13 and 99 => '13-99',
																													 (integer)left.#expand(f1) = 100 =>'100',
																													 (integer)left.#expand(f1) =255 =>'255',
																																																																																								
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

EXPORT range_Function_118(DS,f1,cname) := FUNCTIONMACRO

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
																													
																													 (integer)left.#expand(f1) between 0 and 99 => '0-99',
																													 (integer)left.#expand(f1) = 100 =>'100',
																													 (integer)left.#expand(f1) =255 =>'255',
																																																																																								
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

EXPORT range_Function_119(DS,f1,cname) := FUNCTIONMACRO

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
																													
																													 (integer)left.#expand(f1) between 0 and 5 => '0-5',
																													 (integer)left.#expand(f1) between 6 and 8 => '6_8',
																													 (integer)left.#expand(f1) between 9 and 10 => '9_10',
																													 (integer)left.#expand(f1) between 11 and 12 => '11_12',
																													 (integer)left.#expand(f1) >12 =>'>12',
																																																																																								
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

EXPORT range_Function_120(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 99 => '1_99',
																													 (integer)left.#expand(f1) = 100 =>'100',
																													 (integer)left.#expand(f1) =255 =>'255',
																																																																																								
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

EXPORT range_Function_121(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 5 => '1_5',
																													 (integer)left.#expand(f1) between 6 and 7 => '6_7',
																													 (integer)left.#expand(f1) between 8 and 9 => '8_9',
																													 (integer)left.#expand(f1) between 10 and 11 => '10_11',
																													 (integer)left.#expand(f1) >11 =>'>11',
																																																																																								
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

EXPORT range_Function_122(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 90 => '1_90',
																																																																																																																				
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

EXPORT range_Function_123(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 0 =>'0',
																													 (integer)left.#expand(f1) = 1 =>'1',
																													 (integer)left.#expand(f1) = 2 =>'2',
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',
																													(integer)left.#expand(f1) >4 =>'>4',																																																																																						
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

EXPORT range_Function_124(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 length(trim((string)left.#expand(f1),left,right)) between 1 and 8 =>'1_8',
																													 length(trim((string)left.#expand(f1),left,right)) = 9 =>'9',
																													 length(trim((string)left.#expand(f1),left,right)) = 10 =>'10',
																													 length(trim((string)left.#expand(f1),left,right)) = 11 => '11',
																													 length(trim((string)left.#expand(f1),left,right)) = 12 =>'12',																																																																																						
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

EXPORT range_Function_125(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =0=>'0',
																													 (integer)left.#expand(f1) between 1 and 9998 =>'1-9998',
																													 (integer)left.#expand(f1) = 9999 =>'9999',																																																																																				
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

EXPORT range_Function_126(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) =0=>'0',
																													 (integer)left.#expand(f1) between 1 and 5 =>'1_5',
																													 (integer)left.#expand(f1) between 6 and 15 =>'6_15',
																													 (integer)left.#expand(f1) between 16 and 9998 =>'16-9998',
																													 (integer)left.#expand(f1) = 9999 =>'9999',																																																																																				
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

EXPORT range_Function_127(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) =0=>'0',
																													 (integer)left.#expand(f1) between 1 and 5 =>'1_5',
																													 (integer)left.#expand(f1) between 6 and 20 =>'6_20',
																													 (integer)left.#expand(f1) between 21 and 9998 =>'21-9998',
																													 (integer)left.#expand(f1) = 9999 =>'9999',																																																																																				
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

EXPORT range_Function_128(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) =0=>'0',
																													 (integer)left.#expand(f1) between 1 and 30000 =>'1-30,000',
																													 (integer)left.#expand(f1) between 30001 and 40000 =>'30,001-40,000',
																													 (integer)left.#expand(f1) between 40001 and 65000 =>'40,001-65,000',
																													 (integer)left.#expand(f1) between 65001 and 85000 =>'65,001-85,000',
																													 (integer)left.#expand(f1) >85000 =>'>85,000',																																																																																				
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

EXPORT range_Function_129(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 600 =>'1-600',
																													 (integer)left.#expand(f1) between 601 and 620 =>'601-620',
																													 (integer)left.#expand(f1) between 621 and 635 =>'621-635',
																													 (integer)left.#expand(f1) between 636 and 650 =>'636-650',
																													 (integer)left.#expand(f1) >650 =>'>650',																																																																																				
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

EXPORT range_Function_130(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 615 =>'1-615',
																													 (integer)left.#expand(f1) between 616 and 635 =>'616-635',
																													 (integer)left.#expand(f1) between 636 and 650 =>'636-650',
																													 (integer)left.#expand(f1) between 651 and 665=>'651-665',
																													 (integer)left.#expand(f1) >665 =>'>665',																																																																																				
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

EXPORT range_Function_131(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 72 =>'1_72',
																													 (integer)left.#expand(f1) =73 =>'73',
																													 (integer)left.#expand(f1) >73 =>'>73',																																																																																				
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

EXPORT range_Function_132(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := IF(regexfind('[0-9a-zA-Z]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																														left.#expand(f1) ='PA' =>'PA',
																														left.#expand(f1) ='PO' =>'PO',
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 33 =>'1_33',
																													 (integer)left.#expand(f1) =34 =>'34',
																													 (integer)left.#expand(f1) between 35 and 38 =>'35-38',
																													 (integer)left.#expand(f1) between 39 and 73 =>'39-73',
																													 (integer)left.#expand(f1) >73 =>'>73',																																																																																				
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

EXPORT range_Function_133(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := IF(regexfind('[0-9a-zA-Z]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																														left.#expand(f1) ='PA' =>'PA',
																														left.#expand(f1) ='PO' =>'PO',
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 33 =>'1_33',
																													 (integer)left.#expand(f1) between 34 and 81 =>'34-81',
																													 (integer)left.#expand(f1) >81 =>'>81',																																																																																				
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

EXPORT range_Function_134(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := IF(regexfind('[0-9a-zA-Z]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																														left.#expand(f1) ='PA' =>'PA',
																														left.#expand(f1) ='PO' =>'PO',
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) =10 =>'10',
																													 (integer)left.#expand(f1) between 1 and 9 =>'1_9',
																													 (integer)left.#expand(f1) between 11 and 81 =>'11_81',
																													 (integer)left.#expand(f1) >81 =>'>81',																																																																																				
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

EXPORT range_Function_135(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 5 =>'1_5',
																													 (integer)left.#expand(f1) between 6 and 7=>'6_7',
																													 (integer)left.#expand(f1) between 8 and 9=>'8_9',
																													 (integer)left.#expand(f1) between 10 and 11=>'10_11',
																													 (integer)left.#expand(f1) >11 =>'>11',																																																																																				
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

EXPORT range_Function_136(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 4 =>'1_4',
																													 (integer)left.#expand(f1) between 5 and 9=>'5_9',
																													 (integer)left.#expand(f1) between 10 and 19=>'10_19',
																													 (integer)left.#expand(f1) >19 =>'>19',																																																																																				
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

EXPORT range_Function_137(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 2 =>'1_2',
																													 (integer)left.#expand(f1) between 3 and 6=>'3_6',
																													 (integer)left.#expand(f1) between 7 and 15=>'7_15',
																													 (integer)left.#expand(f1) >15 =>'>15',																																																																																				
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

EXPORT range_Function_138(DS,f1,cname) := FUNCTIONMACRO

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
																													
																													 (integer)left.#expand(f1) between 300 and 600 =>'300-600',
																													 (integer)left.#expand(f1) between 601 and 660=>'601-660',
																													 (integer)left.#expand(f1) between 661 and 700=>'661-700',
																													 (integer)left.#expand(f1) between 701 and 740=>'701-740',
																													 (integer)left.#expand(f1) >740 =>'>740',																																																																																				
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

EXPORT range_Function_139(DS,f1,cname) := FUNCTIONMACRO

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
																													
																													 (integer)left.#expand(f1) between 300 and 500 =>'300-500',
																													 (integer)left.#expand(f1) between 501 and 600=>'501-600',
																													 (integer)left.#expand(f1) between 601 and 660=>'601-660',
																													 (integer)left.#expand(f1) between 661 and 710=>'661-710',
																													 (integer)left.#expand(f1) >710 =>'>710',																																																																																				
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

EXPORT range_Function_140(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 28 =>'1_28',
																													 (integer)left.#expand(f1) between 29 and 36=>'29-36',
																													 (integer)left.#expand(f1) between 37 and 45=>'37-45',
																													 (integer)left.#expand(f1) between 46 and 55=>'46-55',
																													 (integer)left.#expand(f1) >55 =>'>55',																																																																																				
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

EXPORT range_Function_141(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 20 =>'1_20',
																													 (integer)left.#expand(f1) between 21 and 40=>'21-40',
																													 (integer)left.#expand(f1) between 41 and 90=>'41-90',
																													 (integer)left.#expand(f1) between 91 and 150=>'91-150',
																													 (integer)left.#expand(f1) >150 =>'>150',																																																																																				
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

EXPORT range_Function_142(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 15 =>'1_15',
																													 (integer)left.#expand(f1) between 16 and 50=>'16-50',
																													 (integer)left.#expand(f1) between 51 and 115=>'51-115',
																													 (integer)left.#expand(f1) >115 =>'>115',																																																																																				
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

EXPORT range_Function_143(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 20 =>'1_20',
																													 (integer)left.#expand(f1) between 21 and 55=>'21-55',
																													 (integer)left.#expand(f1) between 56 and 115=>'56-115',
																													 (integer)left.#expand(f1) >115 =>'>115',																																																																																				
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

EXPORT range_Function_144(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=-9999 =>'-9999',
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 2 =>'1_2',
																													 (integer)left.#expand(f1) between 3 and 4=>'3_4',
																													 (integer)left.#expand(f1) between 5 and 6=>'5_6',
																													 (integer)left.#expand(f1) between 7 and 9=>'7_9',
																													 (integer)left.#expand(f1) >9 =>'>9',																																																																																				
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

EXPORT range_Function_145(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=-9999 =>'-9999',
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1)=1 =>'1',
																													 (integer)left.#expand(f1)=2 =>'2',
																													 (integer)left.#expand(f1) between 3 and 4=>'3_4',
																													 (integer)left.#expand(f1) >4 =>'>4',																																																																																				
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

EXPORT range_Function_146(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=-9999 =>'-9999',
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1)=1 =>'1',
																													 (integer)left.#expand(f1) between 2 and 3=>'2_3',
																													 (integer)left.#expand(f1) between 4 and 5=>'4_5',
																													 (integer)left.#expand(f1) >5 =>'>5',																																																																																				
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

EXPORT range_Function_147(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 50=>'1_50',
																													 (integer)left.#expand(f1) between 51 and 100=>'51-100',
																													 (integer)left.#expand(f1) between 101 and 165=>'101-165',
																													 (integer)left.#expand(f1) >165 =>'>165',																																																																																				
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

EXPORT range_Function_148(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => '0', 
																														length(trim((string)left.#expand(f1),left,right)) between 1 and 5 => '1_5', 
																													  length(trim((string)left.#expand(f1),left,right)) between 6 and 7 => '6_7', 
																														length(trim((string)left.#expand(f1),left,right))>7 => '>7', 
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

EXPORT range_Function_149(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 50000=>'1-50000',
																													 (integer)left.#expand(f1) between 50001 and 100000=>'50001-100000',
																													 (integer)left.#expand(f1) between 100001 and 150000=>'100001-150000',
																													 (integer)left.#expand(f1) between 150001 and 200000=>'150001-200000',
																													 (integer)left.#expand(f1) between 200001 and 250000=>'200001-250000',	 
																													 (integer)left.#expand(f1) >250000 =>'>250000',																																																																																				
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

EXPORT range_Function_150(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := IF(regexfind('[0-9a-zA-Z]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

EXPORT range_Function_152(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => '0', 
																													  length(trim((string)left.#expand(f1),left,right))= 5  => '5',
																																																							 																																												
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

EXPORT range_Function_153(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													     (integer)left.#expand(f1)=0 =>'0',																																						 																																												
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

EXPORT range_Function_154(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',																														 																																												
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

EXPORT range_Function_155(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2_3',
																													 (integer)left.#expand(f1) between 4 and 7 => '4_7',
																													 (integer)left.#expand(f1) >7 => '>7',
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

EXPORT range_Function_156(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) >0   => '>0',
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

EXPORT range_Function_157(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 10 => '1_10',
																													 (integer)left.#expand(f1) >10  => '>10',
																												
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

EXPORT range_Function_158(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 50000  => '1-50,000',	
																													 (integer)left.#expand(f1) between 50001 and 100000  => '50,001-100,000',
																													 (integer)left.#expand(f1) > 100000  => '>100,000',
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

EXPORT range_Function_159(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 99999999  => '99999999',
																										
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

EXPORT range_Function_160(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 100  => '100',
																										
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

EXPORT range_Function_161(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =1 => '1',
																													 (integer)left.#expand(f1) =2 => '2',
																													 (integer)left.#expand(f1) >2 => '>2',																										
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

EXPORT range_Function_162(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =1 => '1',
																													 (integer)left.#expand(f1)between 2 and 4 => '2_4',
																													 (integer)left.#expand(f1)between 5 and 6 => '5_6',
																													 (integer)left.#expand(f1) =7 => '7',
																													 (integer)left.#expand(f1) >7 => '>7',																										
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

EXPORT range_Function_163(DS,f1,cname) := FUNCTIONMACRO

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
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;

EXPORT range_Function_164 (file_name,fieldname, cname, offset1):= functionmacro

r_FIELD_NAME := record 
  string100 field_name := fieldname;
	string100 category := cname;
  string30 distribution_type := 'DATE-DAYS-APART';
  string50 attribute_value := MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	(unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	length(trim((string)file_name.#expand(fieldname))) > 8 => 'undefined',
																	length(trim((string)file_name.#expand(fieldname))) < 8  => 'undefined',
																	(unsigned)file_name.#expand(fieldname) > (unsigned)Scoring_Project.Function_Last30Days(ut.GetDate, offset1) => 'Less Than ' +  (string)offset1 + ' days',
																	 'Greater Than ' +  (string)offset1 + ' days');
decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME,MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	(unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	length(trim((string)file_name.#expand(fieldname))) > 8 => 'undefined',
																	length(trim((string)file_name.#expand(fieldname))) < 8  => 'undefined',
																	(unsigned)file_name.#expand(fieldname) > (unsigned)Scoring_Project.Function_Last30Days(ut.GetDate, offset1) => 'Less Than ' +  (string)offset1 + ' days',
																	 'Greater Than ' +  (string)offset1 + ' days'));
	

return t_FIELD_NAME;

endmacro;

EXPORT range_Function_165(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) between 2 and 10  => '2_10',
																														(integer)left.#expand(f1) >10  => '>10',
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

EXPORT range_Function_166(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																													  (integer)left.#expand(f1) between 1 and 60  => '1_60',
																														(integer)left.#expand(f1) between 61 and 70  => '61-70',
																														(integer)left.#expand(f1) between 71 and 80  => '71-80',
																														(integer)left.#expand(f1) between 81 and 100  => '81-100',
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

EXPORT range_Function_167(DS,f1,cname) := FUNCTIONMACRO

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
																													 (decimal5_2)left.#expand(f1) between 0 and 1  => '0-1',		
																													 (decimal5_2)left.#expand(f1) between 1.01 and 2  => '1.01-2',					
																													 (decimal5_2)left.#expand(f1) >2 => '>2',	
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

EXPORT range_Function_168(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) =255  => '255',
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

EXPORT range_Function_169(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 0 and 3  => '0-3',
																														(integer)left.#expand(f1) between 4 and 6  => '4_6',
																														(integer)left.#expand(f1) between 7 and 10  => '7_10',
																														(integer)left.#expand(f1) between 11 and 244  => '>10 and <=244',
																														(integer)left.#expand(f1) =255  => '255',
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

EXPORT range_Function_170(DS,f1,cname) := FUNCTIONMACRO

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
																														length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1) = -1  => '-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) =4  => '4',																																																																						
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

EXPORT range_Function_171(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) = 1  => '1',
																														(integer)left.#expand(f1) between 2 and 4=> '2_4', 
																													  (integer)left.#expand(f1) between 5 and 6=> '5_6', 
																												 	  (integer)left.#expand(f1) >6  => '>6',																												
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


EXPORT range_Function_174(DS,f1,cname) := FUNCTIONMACRO

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
																													(integer)left.#expand(f1) between 0 and 11  => '0-11',																											
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

EXPORT range_Function_175(DS,f1,cname) := FUNCTIONMACRO

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
																													(integer)left.#expand(f1) = 0 => '0',
																													(integer)left.#expand(f1) between 1 and 20  => '1_20',		
																													(integer)left.#expand(f1) between 21 and 100  => '21-100',	
																													(integer)left.#expand(f1)>100  => '>100',	
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

EXPORT range_Function_176(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)between 1 and 5 => '1_5',
																													 (integer)left.#expand(f1)=6 => '6',
																													 (integer)left.#expand(f1) >=7 => '>=7',																										
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

EXPORT range_Function_177(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2_3',
																													 (integer)left.#expand(f1) between 4 and 7 => '4_7',
																													 (integer)left.#expand(f1) >7 => '>7',
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

EXPORT range_Function_178(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 4 => '1_4',
																													 (integer)left.#expand(f1) between 5 and 10 => '5_10',
																													 (integer)left.#expand(f1) >10 => '>10',
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

EXPORT range_Function_179(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 4  => '4',
																													 (integer)left.#expand(f1) = 5  => '5',
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

EXPORT range_Function_180(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
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

EXPORT range_Function_181(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 4 => '1_4',
																													 (integer)left.#expand(f1) >4  => '>4',
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

EXPORT range_Function_182(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 100 => '1-100',
																													 (integer)left.#expand(f1) between 101 and 200 => '101-200',
																													 (integer)left.#expand(f1) >200=> '>200',
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

EXPORT range_Function_183(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 0 and 50=> '0-50', 
																														(integer)left.#expand(f1) between 51 and 100=> '51-100', 
																													  (integer)left.#expand(f1) between 101 and 150=> '101-150', 
																												 	  (integer)left.#expand(f1) >150  => '>150',																													
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

EXPORT range_Function_186(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 2 =>'1_2',																																																																																
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

EXPORT range_Function_187(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																														   (integer)left.#expand(f1)=-1 =>'-1',		
																													     (integer)left.#expand(f1)=0 =>'0',																																						 																																												
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

EXPORT range_Function_188(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=-1 =>'-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 2 => '1_2',
																													 (integer)left.#expand(f1) >2 => '>2',
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

EXPORT range_Function_189(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=-1 =>'-1',
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) >0  => '>0',
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

EXPORT range_Function_190(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 3  => '1_3',
																													 (integer)left.#expand(f1) >3  => '>3',
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

EXPORT range_Function_191(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 10  => '1_10',
																														(integer)left.#expand(f1) between 11 and 20  => '11_20',
																														(integer)left.#expand(f1) >20 => '>20',
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

EXPORT range_Function_192(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =-1 => '-1',	
																													 (integer)left.#expand(f1) between 0 and 2 => '0-2',		
																													 (integer)left.#expand(f1) between 3 and 5 => '3_5',	
																													 (integer)left.#expand(f1) =6 => '6',
																													 (integer)left.#expand(f1) =7 => '7',
																													 (integer)left.#expand(f1)>7 => '>7',																																																																						
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

EXPORT range_Function_193(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																														length(trim((string)left.#expand(f1),left,right))between 0 and 8 => '0-8',
																													  length(trim((string)left.#expand(f1),left,right))= 9  => '9',
																													  length(trim((string)left.#expand(f1),left,right))> 9 => '>9',
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

EXPORT range_Function_194(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) >1  => '>1',
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

EXPORT range_Function_195(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 25 => '1_25',
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

EXPORT range_Function_196(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =1 => '1',
																													 (integer)left.#expand(f1) =2 => '2',
																													 (integer)left.#expand(f1) >2 => '>2',																										
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

EXPORT range_Function_197(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													  length(trim((string)left.#expand(f1),left,right))= 1  => '1',
																													  length(trim((string)left.#expand(f1),left,right))= 10 => '10',
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

EXPORT range_Function_198(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =3 => '3',	
																													 (integer)left.#expand(f1) =4 => '4',
																													 (integer)left.#expand(f1) =5 => '5',
																													 (integer)left.#expand(f1) =6 => '6',																																																																						
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

EXPORT range_Function_199(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => '0',
																													  length(trim((string)left.#expand(f1),left,right))= 4 => '4',
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

EXPORT range_Function_200(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 1  => '1',
																														(integer)left.#expand(f1) = 2  => '2',
																														(integer)left.#expand(f1) = 3  => '3',
																													  (integer)left.#expand(f1) >3  => '>3',																												
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

EXPORT range_Function_201(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 1 and 5  => '1_5',
																														(integer)left.#expand(f1) between 6 and 10  => '6_10',
																														(integer)left.#expand(f1) between 11 and 15  => '11_15',
																														(integer)left.#expand(f1) between 16 and 20  => '16-20',
																														(integer)left.#expand(f1) between 21 and 25  => '21-25',
																													  (integer)left.#expand(f1) >25  => '>25',																												
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

EXPORT range_Function_202(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 0 and 5  => '0-5',
																														(integer)left.#expand(f1) between 6 and 9  => '6_9',
																														(integer)left.#expand(f1) between 10 and 13  => '10_13',
																														(integer)left.#expand(f1) between 14 and 18  => '14-18',
																													  (integer)left.#expand(f1) >18  => '>18',																												
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

EXPORT range_Function_204(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) = 0 => '0',
																														(integer)left.#expand(f1) between 1 and 2=> '1_2', 
																														(integer)left.#expand(f1) between 3 and 4=> '3_4',
																													  (integer)left.#expand(f1) between 5 and 6=> '5_6', 
																												 	  (integer)left.#expand(f1) >6  => '>6',																												
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

EXPORT range_Function_210(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 3 => '1_3',
																													 (integer)left.#expand(f1) between 4 and 10 => '4_10',
																													 (integer)left.#expand(f1) >10 => '>10',
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

EXPORT range_Function_211(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)between 0 and 2=>'0-2',
																													 (integer)left.#expand(f1)=3 =>'3',
																													 (integer)left.#expand(f1)=4 =>'4',
																													 (integer)left.#expand(f1)=5 =>'5',
																													 (integer)left.#expand(f1) >5 =>'>5',																																																																																				
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

EXPORT range_Function_212(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 4 => '1_4',
																													 (integer)left.#expand(f1) between 5 and 8 => '5_8',
																													 (integer)left.#expand(f1) between 9 and 10 => '9_10',
																													 (integer)left.#expand(f1) >10 =>'>10',
																																																																																								
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

EXPORT range_Function_213(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) = 6  => '6',
																													  (integer)left.#expand(f1) between 1 and 2 => '1_2',
																													 (integer)left.#expand(f1) between 4 and 5 => '4_5',
																													 (integer)left.#expand(f1) >6  => '>6',
																												
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

EXPORT range_Function_214(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 90 => '1_90',
																													 (integer)left.#expand(f1) = 100 =>'100',
																													 (integer)left.#expand(f1) =255 =>'255',
																																																																																								
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

EXPORT range_Function_215(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) = 0 => '0',
																														(integer)left.#expand(f1) between 1 and 2=> '1_2', 
																														(integer)left.#expand(f1) between 3 and 4=> '3_4',
																												 	  (integer)left.#expand(f1) >4  => '>4',																												
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

EXPORT range_Function_216(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := if(RegexFind('[0-9.~!@&%$^*()_=+?<>,/"{}|]',
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

EXPORT range_Function_217(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 99 => '1_99',
																													 (integer)left.#expand(f1) = 100 =>'100',
																													 (integer)left.#expand(f1) =255 =>'255',
																																																																																								
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

EXPORT range_Function_218(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 1 and 5  => '1_5',
																														(integer)left.#expand(f1) between 6 and 10  => '6_10',
																													  (integer)left.#expand(f1) >10  => '>10',																												
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

EXPORT range_Function_219(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) between 1 and 3=> '1_3', 
																														(integer)left.#expand(f1) between 4 and 5=> '4_5', 
																													  (integer)left.#expand(f1) =6 => '6', 
																												 	  (integer)left.#expand(f1) >6  => '>6',																													
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

EXPORT range_Function_220(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																														length(trim((string)left.#expand(f1),left,right))between 1 and 10 => '1_10',
																														length(trim((string)left.#expand(f1),left,right))= 11 => '11',
																														length(trim((string)left.#expand(f1),left,right))> 11 => '>11',
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

EXPORT range_Function_221(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 2 => '1_2',		
																													 (integer)left.#expand(f1) between 3 and 5 => '3_5',	
																													 (integer)left.#expand(f1)>5 => '>5',																																																																						
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

EXPORT range_Function_222(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) = 2  => '2',
																														(integer)left.#expand(f1) = 3  => '3',
																													  (integer)left.#expand(f1) >3  => '>3',																												
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

EXPORT range_Function_223(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => '0',
																													  length(trim((string)left.#expand(f1),left,right))= 4 => '4',
																														length(trim((string)left.#expand(f1),left,right))= 5 => '5',
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

EXPORT range_Function_224(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																														(integer)left.#expand(f1) = 0  => '0',
																														length(trim((string)left.#expand(f1),left,right))= 8 => '8',
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

EXPORT range_Function_225(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1)=0 =>'0',
																													 (integer)left.#expand(f1) between 1 and 5 =>'1_5',
																													 (integer)left.#expand(f1) between 6 and 7=>'6_7',
																													 (integer)left.#expand(f1) between 8 and 9=>'8_9',
																													 (integer)left.#expand(f1) >9 =>'>9',																																																																																				
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

EXPORT range_Function_226(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) = 0 => '0',
																														(integer)left.#expand(f1) between 1 and 2=> '1_2', 
																														(integer)left.#expand(f1) = 3 => '3',
																														(integer)left.#expand(f1) = 4 => '4',
																												 	  (integer)left.#expand(f1) >4  => '>4',																												
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

EXPORT range_Function_227(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 3=> '1_3',
																													 (integer)left.#expand(f1) = 4  => '4',
																													 (integer)left.#expand(f1) = 5  => '5',
																													 (integer)left.#expand(f1) >5  => '>5',																													
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

EXPORT range_Function_228(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 3=> '1_3', 
																														(integer)left.#expand(f1) = 4  => '4',
																													  (integer)left.#expand(f1) = 5  => '5',
																														(integer)left.#expand(f1) = 6  => '6',
																												 	  (integer)left.#expand(f1) >6  => '>6'	,																												
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

EXPORT range_Function_229(DS,f1,cname) := FUNCTIONMACRO

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
																													  length(trim((string)left.#expand(f1),left,right))<> 0 => 'Value Populate (NOT zero)',																											
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

EXPORT range_Function_230(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) = 1  => '1',
																													  (integer)left.#expand(f1) between 2 and 3=> '2_3', 
																												 	  (integer)left.#expand(f1) >3  => '>3'	,																												
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

EXPORT range_Function_231(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 4=> '1_4', 
																														(integer)left.#expand(f1) = 5  => '5',
																												 	  (integer)left.#expand(f1) >5  => '>5'	,																												
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

EXPORT range_Function_232(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 2 => '1_2',		
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',	
																													 (integer)left.#expand(f1) between 5 and 7 => '5_7',	
																													 (integer)left.#expand(f1)>7 => '>7',																																																																						
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

EXPORT range_Function_233(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 2 => '1_2',		
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',	
																													 (integer)left.#expand(f1) between 5 and 7 => '5_7',	
																													 (integer)left.#expand(f1) between 8 and 11 => '8_11',
																													 (integer)left.#expand(f1)>11 => '>11',																																																																						
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

EXPORT range_Function_234(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := if(RegexFind('[0-9.~!@&%#$^*()_=+?<>/"{}|]',
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

EXPORT range_Function_235(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 3  => '1_3',
																														(integer)left.#expand(f1) between 4 and 6  => '4_6',
																														(integer)left.#expand(f1) between 7 and 10  => '7_10',
																														(integer)left.#expand(f1) >10  => '>10',
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

EXPORT range_Function_236(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 8  => '1_8',
																														(integer)left.#expand(f1) between 9 and 14  => '9_14',
																														(integer)left.#expand(f1) between 15 and 23  => '15_23',
																														(integer)left.#expand(f1) >23  => '>23',
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

EXPORT range_Function_237(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 4 => '1_4',	
																													 (integer)left.#expand(f1) between 5 and 12 => '5_12',	
																													 (integer)left.#expand(f1) between 13 and 30 => '13-30',	
																													 (integer)left.#expand(f1) between 31 and 254 => '31-254',	
																													 (integer)left.#expand(f1)=255 => '255',																																																																						
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

EXPORT range_Function_238(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 5 => '1_5',	
																													 (integer)left.#expand(f1) between 6 and 10 => '6_10',	
																													 (integer)left.#expand(f1) between 11 and 15 => '11_15',	
																													 (integer)left.#expand(f1)>15 => '>15',																																																																						
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

EXPORT range_Function_239(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) between 2 and 4  => '2_4',
																														(integer)left.#expand(f1) between 5 and 20  => '5_20',
																														(integer)left.#expand(f1) >20 => '>20',
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

EXPORT range_Function_240(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) =2  => '2',
																														(integer)left.#expand(f1) between 3 and 4  => '3_4',
																														(integer)left.#expand(f1) between 5 and 11  => '5_11',
																														(integer)left.#expand(f1) >11 => '>11',
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

EXPORT range_Function_241(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 3 => '1_3',	
																													 (integer)left.#expand(f1) between 4 and 6 => '4_6',
																													 (integer)left.#expand(f1) between 7 and 10 => '7_10',
																													 (integer)left.#expand(f1) between 11 and 15 => '11_15',	
																													 (integer)left.#expand(f1)>15 => '>15',																																																																						
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

EXPORT range_Function_242(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =1 => '1',	
																													 (integer)left.#expand(f1) =2 => '2',			
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',	
																													 (integer)left.#expand(f1) between 5 and 7 => '5_7',	
																													 (integer)left.#expand(f1)>7 => '>7',																																																																						
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

EXPORT range_Function_243(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 11 => '1_11',	
																													 (integer)left.#expand(f1)=12 => '12',																																																																						
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

EXPORT range_Function_244(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 10  => '1_10',
																														(integer)left.#expand(f1) between 11 and 20  => '11_20',
																														(integer)left.#expand(f1) >20 => '>20',
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

EXPORT range_Function_245(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 2=> '1_2', 
																														(integer)left.#expand(f1) = 3  => '3',
																														(integer)left.#expand(f1) = 4  => '4',
																														(integer)left.#expand(f1) = 5  => '5',
																												 	  (integer)left.#expand(f1) >5  => '>5'	,																												
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

EXPORT range_Function_246(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 9=> '1_9', 
																														(integer)left.#expand(f1) between 10 and 16=> '10_16', 
																														(integer)left.#expand(f1) between 17 and 28=> '17-28', 
																												 	  (integer)left.#expand(f1) >28  => '>28'	,																												
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

EXPORT range_Function_247(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 2=> '1_2', 
																														(integer)left.#expand(f1) = 3  => '3',
																														(integer)left.#expand(f1) between 4 and 5=> '4_5',
																												 	  (integer)left.#expand(f1) >5  => '>5'	,																												
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

EXPORT range_Function_248(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 7=> '1_7', 
																														(integer)left.#expand(f1) between 8 and 12=> '8_12',
																														(integer)left.#expand(f1) between 13 and 19=> '13_19',
																												 	  (integer)left.#expand(f1) >19  => '>19'	,																												
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

EXPORT range_Function_249(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 30=> '1_30', 
																												 	  (integer)left.#expand(f1) >30  => '>30'	,																												
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

EXPORT range_Function_250(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 200=> '1-200', 
																														(integer)left.#expand(f1) between 201 and 250=> '201-250',
																														(integer)left.#expand(f1) between 251 and 300=> '251-300',
																														(integer)left.#expand(f1) between 301 and 350=> '301-350',
																												 	  (integer)left.#expand(f1) >350  => '>350'	,																												
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

EXPORT range_Function_251(DS,f1,cname) := FUNCTIONMACRO

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
																													  (integer)left.#expand(f1) between 1 and 5=> '1_5', 
																														(integer)left.#expand(f1) between 6 and 9=> '6_9',
																														(integer)left.#expand(f1) between 10 and 12=> '10_12',
																														(integer)left.#expand(f1) between 13 and 16=> '13-16',
																												 	  (integer)left.#expand(f1) >16  => '>16'	,																												
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

EXPORT range_Function_252(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 2 => '1_2',	
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',		
																													 (integer)left.#expand(f1) between 5 and 8 => '5_8',	
																													 (integer)left.#expand(f1)>8 => '>8',																																																																						
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

EXPORT range_Function_253(DS,f1,cname) := FUNCTIONMACRO

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
																			self.attribute_value := if(RegexFind('[~!@&%#$^*()_=+?<>,/"{}|]',
																			                              TRIM((string)left.#expand(f1),LEFT,RIGHT)), 'undefined',
                                                                                                                      (string) left.#expand(f1));
 
																																							
				
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

EXPORT range_Function_254(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2_3',	
																													 (integer)left.#expand(f1) between 4 and 5 => '4_5',		
																													 (integer)left.#expand(f1)>5 => '>5',																																																																						
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
																													 (integer)left.#expand(f1) = 0  => '0',
																												   (integer)left.#expand(f1) between 1 and 10 => '1_10',	
																													 (integer)left.#expand(f1) between 11 and 20 => '11_20',	
																													 (integer)left.#expand(f1) between 21 and 30 => '21-30',	
																													 (integer)left.#expand(f1) between 31 and 40 => '31-40',
																													 (integer)left.#expand(f1) between 41 and 50 => '41-50',	
																													 (integer)left.#expand(f1) between 51 and 60 => '51-60',
																													 (integer)left.#expand(f1) between 61 and 70 => '61-70',	
																													 (integer)left.#expand(f1) between 71 and 80 => '71-80',
																													 (integer)left.#expand(f1) between 81 and 90 => '81-90',	
																													 (integer)left.#expand(f1) between 91 and 100 => '91-100',
																													 (integer)left.#expand(f1)>100 => '>100',																																																																						
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

EXPORT range_Function_258(DS,f1,cname) := FUNCTIONMACRO

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
																												   (integer)left.#expand(f1) between 1 and 1000 => '1_1000',	
																													 (integer)left.#expand(f1) between 1001 and 1500 => '1001-1500',	
																													 (integer)left.#expand(f1)>=1501 => '>=1501',																																																																						
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

EXPORT range_Function_259(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) = 4  => '4',	
																													 (integer)left.#expand(f1) = 5  => '5',	
																													 (integer)left.#expand(f1) >=6  => '>=6',	
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

EXPORT range_Function_260(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) = 4  => '4',	
																													 (integer)left.#expand(f1) >=5  => '>=5',	
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

EXPORT range_Function_261(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) >=4  => '>=4',		
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

EXPORT range_Function_262(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) = 4  => '4',	
																													 (integer)left.#expand(f1) = 5  => '5',	
																													 (integer)left.#expand(f1) = 6  => '6',
																													 (integer)left.#expand(f1) = 7  => '7',
																													 (integer)left.#expand(f1) = 8  => '8',
																													 (integer)left.#expand(f1) >=9 => '>=9',	
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

EXPORT range_Function_263(DS,f1,cname) := FUNCTIONMACRO

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
																							  					 (integer)left.#expand(f1) between 1 and 30  => '1_30',		
																													 (integer)left.#expand(f1) between 31 and 50  => '31-50',
																													 (integer)left.#expand(f1) between 51 and 70  => '51-70',
																													 (integer)left.#expand(f1) between 71 and 100  => '71-100',	
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

EXPORT range_Function_264(DS,f1,cname) := FUNCTIONMACRO

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
																							  					 (integer)left.#expand(f1) between 1 and 2  => '1_2',		
																													 (integer)left.#expand(f1) between 3 and 10  => '3_10',
																													 (integer)left.#expand(f1) >10  => '>10',
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

EXPORT range_Function_265(DS,f1,cname) := FUNCTIONMACRO

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
																							  					 (integer)left.#expand(f1) between 1 and 2  => '1_2',		
																													 (integer)left.#expand(f1) between 3 and 5  => '3_5',
																													 (integer)left.#expand(f1) >=6  => '>=6',
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

EXPORT range_Function_266(DS,f1,cname) := FUNCTIONMACRO

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
																							  					 (integer)left.#expand(f1) between 1 and 100  => '1_100',		
																													 (integer)left.#expand(f1) between 101 and 200  => '101-200',
																													 (integer)left.#expand(f1) between 201 and 400  => '201-400',
																													 (integer)left.#expand(f1) >=401  => '>=401',
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

EXPORT range_Function_267(DS,f1,cname) := FUNCTIONMACRO

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
																												   (integer)left.#expand(f1) between 1 and 10 => '1_10',	
																													 (integer)left.#expand(f1) between 11 and 20 => '11_20',	
																													 (integer)left.#expand(f1) between 21 and 30 => '21-30',	
																													 (integer)left.#expand(f1) between 31 and 40 => '31-40',
																													 (integer)left.#expand(f1) between 41 and 50 => '41-50',	
																													 (integer)left.#expand(f1)>=51 => '>=51',																																																																						
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

EXPORT range_Function_268(DS,f1,cname) := FUNCTIONMACRO

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
																												   (integer)left.#expand(f1) between 1 and 4 => '1_4',	
																													 (integer)left.#expand(f1) = 5  => '5',	
																													 (integer)left.#expand(f1) = 6  => '6',
																													 (integer)left.#expand(f1) = 7  => '7',
																													 (integer)left.#expand(f1) = 8  => '8',
																													 (integer)left.#expand(f1)>=9 => '>=9',																																																																						
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

EXPORT range_Function_269(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',	
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) between 4 and 5 => '4_5',
																													 (integer)left.#expand(f1)>=6 => '>=6',																																																																						
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

EXPORT range_Function_270(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',	
																													 (integer)left.#expand(f1) between 2 and 10 => '2_10',
																													 (integer)left.#expand(f1) between 11 and 99=> '11_99',
																													 (integer)left.#expand(f1)>=100 => '>=100',																																																																						
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

EXPORT range_Function_271(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',	
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',
																													 (integer)left.#expand(f1)>=5 => '>=5',																																																																						
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

EXPORT range_Function_272(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 2 => '1_2',
																													 (integer)left.#expand(f1) between 3 and 9 => '3_9',
																													 (integer)left.#expand(f1)>=10 and (integer)left.#expand(f1)<>225 => '>=10',																																																																						
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

EXPORT range_Function_273(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2_3',
																													 (integer)left.#expand(f1) between 4 and 9 => '4_9',
																													 (integer)left.#expand(f1)>=10 and (integer)left.#expand(f1)<>225=> '>=10',																																																																						
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

EXPORT range_Function_274(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) between 4 and 6 => '4_6',
																													 (integer)left.#expand(f1)>=7 => '>=7',																																																																						
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

EXPORT range_Function_275(DS,f1,cname) := FUNCTIONMACRO

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
																												   (integer)left.#expand(f1) between 1 and 20 => '1_20',		
																													 (integer)left.#expand(f1) between 21 and 30 => '21-30',	
																													 (integer)left.#expand(f1) between 31 and 40 => '31-40',
																													 (integer)left.#expand(f1) between 41 and 50 => '41-50',	
																													 (integer)left.#expand(f1) between 51 and 60 => '51-60',
																													 (integer)left.#expand(f1) between 61 and 70 => '61-70',	
																													 (integer)left.#expand(f1) between 71 and 80 => '71-80',
																													 (integer)left.#expand(f1) between 81 and 90 => '81-90',
																													 (integer)left.#expand(f1)>90 => '>90',																																																																						
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

EXPORT range_Function_276(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3 => '2_3',
																													 (integer)left.#expand(f1) >=4  => '>=4',		
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

EXPORT range_Function_277(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) between 4 and 5 => '4_5',
																													 (integer)left.#expand(f1) between 6 and 8 => '6_8',
																													 (integer)left.#expand(f1) >=9 => '>=9',	
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

EXPORT range_Function_279(DS,f1,cname) := FUNCTIONMACRO

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
										MAP((string)left.#expand(f1) in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU'
															,'HI','ID','IL','IN','IA',
                              'KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND',
                              'MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VA','VI','WA',
                              'WV','WI','WY']=> 'valid state',
                                            (integer)left.#expand(f1) = 0 and length(trim(left.#expand(f1),left,right))= 0 => 'Blank',                                                                                  
                                                                     'UNDEFINED'));
				
				
				
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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => '0',
																														length(trim((string)left.#expand(f1),left,right))= 1 => '1',
																													  length(trim((string)left.#expand(f1),left,right))= 4 => '4',
																														length(trim((string)left.#expand(f1),left,right))= 5 => '5',
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

EXPORT length_distinct_func(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9a-zA-Z]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													  length(trim((string)left.#expand(f1),left,right))<>0  =>  (string)length(trim((string)left.#expand(f1),left,right)),
																																																							 																																												
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
																													 (integer)left.#expand(f1) = 1  => '1',	
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) between 3 and 5 => '3_5',
																													 (integer)left.#expand(f1)>=5 => '>5',																																																																						
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

EXPORT range_Function_282(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 5 => '1_5',	
																													 (integer)left.#expand(f1) between 6 and 10 => '6_10',
																													 (integer)left.#expand(f1) between 11 and 15 => '11_15',
																													 (integer)left.#expand(f1) between 16 and 25 => '16-25',
																													 (integer)left.#expand(f1)>25 => '>25',																																																																						
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

EXPORT range_Function_283(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 3 => '1_3',	
																													 (integer)left.#expand(f1) between 4 and 5 => '4_5',
																													 (integer)left.#expand(f1) between 6 and 7 => '6_7',
																													 (integer)left.#expand(f1) between 8 and 9 => '8_9',
																													 (integer)left.#expand(f1) between 10 and 12 => '10_12',
																													 (integer)left.#expand(f1) between 13 and 14 => '13-14',
																													 (integer)left.#expand(f1)>=20 => '>=20',																																																																						
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

EXPORT range_Function_284(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 9 => '1_9',	
																													 (integer)left.#expand(f1) between 11 and 19 => '11_19',
																													 (integer)left.#expand(f1)>=20 => '>=20',																																																																						
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

EXPORT range_Function_285(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) between 3 and 5 => '3_5',	
																													 (integer)left.#expand(f1) between 6 and 49 => '6_49',
																													 (integer)left.#expand(f1)>=50 => '>=50',																																																																						
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

EXPORT range_Function_286(DS,f1,cname) := FUNCTIONMACRO

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
																													(integer)left.#expand(f1) between 1 and 19 => '1_19',	
																													 (integer)left.#expand(f1) between 20 and 39 => '20-39',
																													 (integer)left.#expand(f1) between 40 and 59 => '40-59',	
																													 (integer)left.#expand(f1) between 60 and 79 => '60-79',
																													 (integer)left.#expand(f1) between 80 and 99 => '80-99',	
																													 (integer)left.#expand(f1)=100 => '100',																																																																						
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

EXPORT range_Function_287(DS,f1,cname) := FUNCTIONMACRO

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
																													(integer)left.#expand(f1) between 1 and 9 => '1_9',	
																													 (integer)left.#expand(f1) between 10 and 14 => '10_14',
																													 (integer)left.#expand(f1) between 15 and 24 => '15-24',	
																													 (integer)left.#expand(f1) between 25 and 49 => '25-49',
																													 (integer)left.#expand(f1) between 50 and 149 => '50-149',	
																													 (integer)left.#expand(f1)>=150 => '>=150',																																																																						
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

EXPORT range_Function_288(DS,f1,cname) := FUNCTIONMACRO

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
																													(integer)left.#expand(f1) between 1 and 5 => '1_5',	
																													 (integer)left.#expand(f1) between 6 and 10 => '6_10',
																													 (integer)left.#expand(f1) between 11 and 25 => '11_25',	
																													 (integer)left.#expand(f1) between 26 and 30 => '26-30',																																																																					
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
EXPORT range_Function_289(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) between 4 and 5 => '4_5',
																													 (integer)left.#expand(f1) between 6 and 9 => '6_9',
																													 (integer)left.#expand(f1)>=10 => '>=10',																																																																						
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


EXPORT range_Function_290(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 4 => '1_4',	
																													 (integer)left.#expand(f1) between 5 and 7 => '5_7',	
																													 (integer)left.#expand(f1) between 8 and 10 => '8_10',	
																													 (integer)left.#expand(f1) between 11 and 19 => '11_19',
																													 (integer)left.#expand(f1)>=20 => '>=20',																																																																						
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

EXPORT range_Function_291(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) = 4  => '4',
																													 (integer)left.#expand(f1) >= 5  => '>=5',
																													 
																												
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

EXPORT range_Function_292(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 5 => '1_5',	
																													 (integer)left.#expand(f1) between 6 and 15 => '6_15',
																													 (integer)left.#expand(f1) between 16 and 25 => '16-25',
																													 (integer)left.#expand(f1)>25 => '>25',																																																																						
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

EXPORT range_Function_293(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 99 => '2_99',	
																													 (integer)left.#expand(f1)>=100 => '>=100',																																																																						
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

EXPORT range_Function_294(DS,f1,cname) := FUNCTIONMACRO

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
																												   (integer)left.#expand(f1) between 1 and 10 => '1_10',	
																													 (integer)left.#expand(f1) between 11 and 20 => '11_20',	
																													 (integer)left.#expand(f1) between 21 and 30 => '21-30',	
																													 (integer)left.#expand(f1) between 31 and 40 => '31-40',
																													 (integer)left.#expand(f1) between 41 and 50 => '41-50',	
																													 (integer)left.#expand(f1) between 51 and 60 => '51-60',
																													 (integer)left.#expand(f1) between 61 and 70 => '61-70',	
																													 (integer)left.#expand(f1) between 71 and 80 => '71-80',
																													 (integer)left.#expand(f1) between 81 and 90 => '81-90',
																													 (integer)left.#expand(f1) between 91 and 100 => '91-100',
																													 (integer)left.#expand(f1)>100 => '>100',																																																																						
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
	
EXPORT range_Function_295(DS,f1,cname) := FUNCTIONMACRO

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
																												   (integer)left.#expand(f1) between 1 and 10000 => '1_10000',		
																													 (integer)left.#expand(f1) between 10001 and 100000 => '10001-100,000',	
																													 (integer)left.#expand(f1) between 100001 and 250000 => '100,001-250,000',
																													 (integer)left.#expand(f1) between 250001 and 500000 => '250,001-500,000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000 => '500,001-1,000,000',																																																																	
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
	
EXPORT range_Function_296(DS,f1,cname) := FUNCTIONMACRO

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
																												   (integer)left.#expand(f1) between 1 and 10000 => '1_10000',		
																													 (integer)left.#expand(f1) between 10001 and 100000 => '10001-100,000',	
																													 (integer)left.#expand(f1) between 100001 and 250000 => '100,001-250,000',
																													 (integer)left.#expand(f1) between 250001 and 500000 => '250,001-500,000',																																																																								
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

EXPORT range_Function_297(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 102  => '102',
																													 (integer)left.#expand(f1) = 222  => '222',
																													 (integer)left.#expand(f1) between 500 and 524 => '500-524',
																													 (integer)left.#expand(f1) between 525 and 549 => '525-549',
																													 (integer)left.#expand(f1) between 550 and 574 => '550-574',
																													 (integer)left.#expand(f1) between 575 and 599 => '575-599',
																													 (integer)left.#expand(f1) between 600 and 624 => '600-624',
																													 (integer)left.#expand(f1) between 625 and 649 => '625-649',
																													 (integer)left.#expand(f1) between 650 and 674 => '650-674',
																													 (integer)left.#expand(f1) between 675 and 699 => '675-699',
																													 (integer)left.#expand(f1) between 700 and 724 => '700-724',
																													 (integer)left.#expand(f1) between 725 and 749 => '725-749',
																													 (integer)left.#expand(f1) between 750 and 774 => '750-774',
																													 (integer)left.#expand(f1) between 775 and 799 => '775-799',																																																																		
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

EXPORT range_Function_298(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 102  => '102',
																													 (integer)left.#expand(f1) = 222  => '222',
																													 (integer)left.#expand(f1) between 500 and 524 => '500-524',
																													 (integer)left.#expand(f1) between 525 and 549 => '525-549',
																													 (integer)left.#expand(f1) between 550 and 574 => '550-574',
																													 (integer)left.#expand(f1) between 575 and 599 => '575-599',
																													 (integer)left.#expand(f1) between 600 and 624 => '600-624',
																													 (integer)left.#expand(f1) between 625 and 649 => '625-649',
																													 (integer)left.#expand(f1) between 650 and 674 => '650-674',
																													 (integer)left.#expand(f1) between 675 and 699 => '675-699',
																													 (integer)left.#expand(f1) between 700 and 724 => '700-724',
																													 (integer)left.#expand(f1) between 725 and 749 => '725-749',
																													 (integer)left.#expand(f1) between 750 and 774 => '750-774',
																													 (integer)left.#expand(f1) between 775 and 799 => '775-799',	
																													 (integer)left.#expand(f1) between 800 and 824 => '800-824',
																													 (integer)left.#expand(f1)>=825 => '>=825',
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

EXPORT range_Function_299(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 102  => '102',
																													 (integer)left.#expand(f1) = 222  => '222',
																													 (integer)left.#expand(f1) between 500 and 524 => '500-524',
																													 (integer)left.#expand(f1) between 525 and 549 => '525-549',
																													 (integer)left.#expand(f1) between 550 and 574 => '550-574',
																													 (integer)left.#expand(f1) between 575 and 599 => '575-599',
																													 (integer)left.#expand(f1) between 600 and 624 => '600-624',
																													 (integer)left.#expand(f1) between 625 and 649 => '625-649',
																													 (integer)left.#expand(f1) between 650 and 674 => '650-674',
																													 (integer)left.#expand(f1) between 675 and 699 => '675-699',
																													 (integer)left.#expand(f1) between 700 and 724 => '700-724',
																													 (integer)left.#expand(f1) between 725 and 749 => '725-749',
																													 (integer)left.#expand(f1) between 750 and 774 => '750-774',
																													 (integer)left.#expand(f1) between 775 and 799 => '775-799',	
																													 (integer)left.#expand(f1) between 800 and 824 => '800-824',
																													 (integer)left.#expand(f1) between 825 and 849 => '825-849',
																													 (integer)left.#expand(f1) between 850 and 874 => '850-874',
																													 (integer)left.#expand(f1)>=875 => '>=875',
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
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 249 => '1_249',
																													 (integer)left.#expand(f1)>=250 => '>=250',
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
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 19 => '1_19',
																													 (integer)left.#expand(f1) between 2 and 39 => '20-39',
																													 (integer)left.#expand(f1) between 40 and 59 => '40-59',
																													 (integer)left.#expand(f1) between 60 and 79 => '60-79',
																													 (integer)left.#expand(f1) between 80 and 99 => '80-99',
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
																													 (integer)left.#expand(f1) = 0  => '0',
																												   (integer)left.#expand(f1) between 1 and 10 => '1_10',	
																													 (integer)left.#expand(f1) between 11 and 20 => '11_20',	
																													 (integer)left.#expand(f1) between 21 and 30 => '21-30',	
																													 (integer)left.#expand(f1) between 31 and 40 => '31-40',
																													 (integer)left.#expand(f1) between 41 and 50 => '41-50',	
																													 (integer)left.#expand(f1) between 51 and 60 => '51-60',
																													 (integer)left.#expand(f1) between 61 and 70 => '61-70',	
																													 (integer)left.#expand(f1) between 71 and 80 => '71-80',
																													 (integer)left.#expand(f1) between 81 and 90 => '81-90',	
																													 (integer)left.#expand(f1) between 91 and 100 => '91-100',
																													 (integer)left.#expand(f1)=225 => '225',																																																																						
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
																													 (integer)left.#expand(f1) = 0  => '0',
																												   (integer)left.#expand(f1) between 1 and 10 => '1_10',	
																													 (integer)left.#expand(f1) between 11 and 100 => '11_100',	
																													 (integer)left.#expand(f1) between 101 and 9999 => '>100,<9999',																																																																						
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
																													 (integer)left.#expand(f1) = 0  => '0',
																												   (integer)left.#expand(f1) between 1 and 5 => '1_5',	
																													 (integer)left.#expand(f1) between 6 and 10 => '6_10',	
																													 (integer)left.#expand(f1) between 11 and 9998 => '11_9998',																																																																						
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
																													 (integer)left.#expand(f1) = 0  => '0',
																												   (integer)left.#expand(f1) between 1 and 10 => '1_10',	
																													 (integer)left.#expand(f1) between 11 and 100 => '11_100',	
																													 (integer)left.#expand(f1) between 101 and 9999 => '>100,<9999',																																																																						
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
																														(integer)left.#expand(f1) = 0  => '0', 
																														(integer)left.#expand(f1) = 1  => '1',
																														(integer)left.#expand(f1) = 2  => '2',
																														(integer)left.#expand(f1) between 3 and 4=> '3_4', 
																														(integer)left.#expand(f1) between 5 and 10=> '5_10',
																												 	  (integer)left.#expand(f1) >10  => '>10',																													
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
																														(integer)left.#expand(f1) = 0  => '0', 
																														(integer)left.#expand(f1) between 1 and 24999=> '1-24,999', 
																														(integer)left.#expand(f1) between 25000 and 29999 => '25,000-29,999',
																														(integer)left.#expand(f1) between 30000 and 34999=> '30,000-34,999',
																														(integer)left.#expand(f1) between 35000 and 49999=> '35,000-49,999',
																														(integer)left.#expand(f1) between 50000 and 99999 => ' 50,000-99,999',
																														(integer)left.#expand(f1) between 100000 and 200000=> '100,000-200,000',
																												 	  (integer)left.#expand(f1) >200000  => '>200,000',																													
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
																													 (integer)left.#expand(f1) = 102  => '102',
																													 (integer)left.#expand(f1) = 222  => '222',
																													 (integer)left.#expand(f1) between 500 and 524 => '500-524',
																													 (integer)left.#expand(f1) between 525 and  549=> '525-549',
																													 (integer)left.#expand(f1) between 550 and  574=> '550-574',
																													 (integer)left.#expand(f1) between 575 and 599 => '575-599',
																													 (integer)left.#expand(f1) between 600 and 624 => '600-624',
																													 (integer)left.#expand(f1) between 625 and 649 => '625-649',
																													 (integer)left.#expand(f1) between 650 and 674 => '650-674',
																													 (integer)left.#expand(f1) between 675 and 699 => '675-699',
																													 (integer)left.#expand(f1) between 700 and 724 => '700-724',
																													 (integer)left.#expand(f1) between 725 and 749 => '725-749',
																													 (integer)left.#expand(f1) between 750 and 774 => '750-774',
																													 (integer)left.#expand(f1) between 775 and 799 => '775-799',	
																													 (integer)left.#expand(f1) between 800 and 824 => '800-824',
																													 (integer)left.#expand(f1) between 825 and 849 => '825-849',
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
																													 (integer)left.#expand(f1) = 0  => '0',
																												   (integer)left.#expand(f1) between 1 and 5 => '1_5',		
																													 (integer)left.#expand(f1) between 6 and 10 => '6_10',		
																													 (integer)left.#expand(f1) between 11 and 15 => '11_15',		
																													 (integer)left.#expand(f1) between 16 and 20 => '16-20',		
																													 (integer)left.#expand(f1) between 21 and 25 => '21-25',		
																													 (integer)left.#expand(f1) between 26 and 30 => '26-30',		
																													 (integer)left.#expand(f1) between 31 and 35 => '31-35',		
																													 (integer)left.#expand(f1) between 36 and 40 => '36-40',		
																													 (integer)left.#expand(f1) between 41 and 45 => '41-45',																																	 																																																																					
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
																														(integer)left.#expand(f1) = 0  => '0',
																														(integer)left.#expand(f1) between 1 and 50=> '1_50', 
																														(integer)left.#expand(f1) between 51 and 100=> '51-100', 
																													  (integer)left.#expand(f1) between 101 and 150=> '101-150', 
																														(integer)left.#expand(f1) between 151 and 200=> '151-200', 
																														(integer)left.#expand(f1) between 201 and 250=> '201-250', 
																														(integer)left.#expand(f1) between 251 and 300=> '251-300', 
																												 	  (integer)left.#expand(f1) >300  => '>300'	,																												
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
																													 (integer)left.#expand(f1) = 0  => '0',
																												   (integer)left.#expand(f1) between 1 and 2 => '1_2',		
																													 (integer)left.#expand(f1) between 3 and 5 => '3_5',		
																													 (integer)left.#expand(f1) between 6 and 10 => '6_10',		
																													 (integer)left.#expand(f1) >10=> '>10',																							 																																																																					
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
																													 (integer)left.#expand(f1) =0 => '0',	
																													 (integer)left.#expand(f1) =1 => '1',	
																													 (integer)left.#expand(f1) =2 => '2',	
																											     (integer)left.#expand(f1) =3 => '3',	
																										       (integer)left.#expand(f1) =4 => '4',	
																													 (integer)left.#expand(f1) between 5 and 7 => '5_7',	
																													 (integer)left.#expand(f1) between 8 and 10 => '8_10',	
																													 (integer)left.#expand(f1)>=10 => '>=10',																																																																						
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
																													  (integer)left.#expand(f1) = 0 => '0',
																														(integer)left.#expand(f1) = 1 => '1',
																														(integer)left.#expand(f1) between 2 and 3=> '2_3', 
																												 	  (integer)left.#expand(f1) >=4  => '>=4',																												
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
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																												   (integer)left.#expand(f1) between 2 and 3 => '2_3',		
																													 (integer)left.#expand(f1) between 4 and 5 => '4_5',		
																													 (integer)left.#expand(f1) between 6 and 10 => '6_10',		
																													 (integer)left.#expand(f1) >10=> '>10',																																																																																							
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
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																												   (integer)left.#expand(f1) between 2 and 3 => '2_3',		
																													 (integer)left.#expand(f1) between 4 and 8 => '4_8',		
																													 (integer)left.#expand(f1) >8=> '>8',																																																																																									
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
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) =1 =>'1',
																													 (integer)left.#expand(f1) =2 =>'2',
																													 (integer)left.#expand(f1) between 3 and 4 =>'3_4',
																													 (integer)left.#expand(f1) between 5 and 9=>'5_9',
																													 (integer)left.#expand(f1) >=10 =>'>=10',																																																																																				
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
																													  (integer)left.#expand(f1) =0 =>'0',
																													  (integer)left.#expand(f1) =1 =>'1',
																													  (integer)left.#expand(f1) =2 =>'2', 
																														(integer)left.#expand(f1) between 3 and 5=> '3_5', 
																														(integer)left.#expand(f1) between 6 and 10=> '6_10',
																												 	  (integer)left.#expand(f1) >10  => '>10',																													
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
																													  (integer)left.#expand(f1) =0 =>'0',
																													  (integer)left.#expand(f1) =1 =>'1',
																													  (integer)left.#expand(f1) =2 =>'2',
																														(integer)left.#expand(f1) =3 =>'3', 
																														(integer)left.#expand(f1) =4 =>'4', 
																														(integer)left.#expand(f1) between 5 and 10=> '5_10',
																												 	  (integer)left.#expand(f1) >10  => '>10',																													
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
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) =1 =>'1',
																													 (integer)left.#expand(f1) =2 =>'2',	
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',		
																													 (integer)left.#expand(f1) between 5 and 8 => '5_8',	
																													 (integer)left.#expand(f1)>8 => '>8',																																																																						
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
																													 (integer)left.#expand(f1) =0 =>'0',
																													 (integer)left.#expand(f1) =1 =>'1',
																													 (integer)left.#expand(f1) >=2 =>'>=2',																																																																
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
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 19 => '1_19',
																													 (integer)left.#expand(f1) between 20 and 40 => '20-40',
																													 (integer)left.#expand(f1) between 60 and 80 => '60-80',
																													 (integer)left.#expand(f1) between 100 and 200 => '100-200',
																													 (integer)left.#expand(f1) >200=> '>200',
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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) between 2 and 4  => '2_4',
																														(integer)left.#expand(f1) between 5 and 10  => '5_10',
																														(integer)left.#expand(f1) >10 => '>10',
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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) =2  => '2',
																														(integer)left.#expand(f1) between 3 and 5  => '3_5',
																														(integer)left.#expand(f1) between 5 and 9  => '5_9',
																														(integer)left.#expand(f1) >=10 => '>=10',
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
																													 (integer)left.#expand(f1) between 501 and 570=>'501-570',
																													 (integer)left.#expand(f1) between 571 and 590=>'571-590',
																													 (integer)left.#expand(f1) between 591 and 610=>'591-610',
																													 (integer)left.#expand(f1) between 611 and 630=>'611-630',
																													 (integer)left.#expand(f1) between 631 and 660=>'631-660',
																													 (integer)left.#expand(f1) between 661 and 710=>'661-710',																																																																																							
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
																													  (integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) between 2 and 3  => '2_3',
																														(integer)left.#expand(f1) between 4 and 6  => '4_6',
																														(integer)left.#expand(f1) between 7 and 10  => '7_10',
																														(integer)left.#expand(f1) >10  => '>10',
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
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) between 1 and 3 => '1_3',	
																													 (integer)left.#expand(f1) = 4  => '4',
																													 (integer)left.#expand(f1) = 5  => '5',
																													 (integer)left.#expand(f1) >=6 => '>=6',																																																																						
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
																													 (integer)left.#expand(f1) = 0  => '0',
																							  					 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',		
																													 (integer)left.#expand(f1) between 3 and 5  => '3_5',
																													 (integer)left.#expand(f1) >=6  => '>=6',
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
																													 (integer)left.#expand(f1) = 0  => '0',
																							  					 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 9  => '2_9',	
																													 (integer)left.#expand(f1) between 10 and 24  => '10_24',
																													 (integer)left.#expand(f1) between 25 and 50  => '25_50',
																													 (integer)left.#expand(f1) >50  => '>50',
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
																													 (integer)left.#expand(f1) = 0  => '0',
																							  					 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 4  => '2_4',	
																													 (integer)left.#expand(f1) between 5 and 14  => '5_14',
																													 (integer)left.#expand(f1) >=15  => '>=15',
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
																													  (integer)left.#expand(f1) between 1 and 5  => '1_5',
																														(integer)left.#expand(f1) between 6 and 10  => '6_10',
																														(integer)left.#expand(f1) >10  => '>10',
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
																														(integer)left.#expand(f1) =222  => '222',
																													  (integer)left.#expand(f1) between 500 and 549  => '500-549',
																														(integer)left.#expand(f1) between 550 and 599  => '550-599',
																														(integer)left.#expand(f1) between 600 and 649  => '600-649',
																														(integer)left.#expand(f1) between 650 and 699  => '650-699',
																														(integer)left.#expand(f1) >=700  => '>=700',
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
																														(integer)left.#expand(f1) =222  => '222',
																													  (integer)left.#expand(f1) between 500 and 599  => '500-599',
																														(integer)left.#expand(f1) between 600 and 649  => '600-649',
																														(integer)left.#expand(f1) between 650 and 699  => '650-699',
																														(integer)left.#expand(f1) between 700 and 799  => '700-799',
																														(integer)left.#expand(f1) between 800 and 899  => '800-899',																
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
																														(integer)left.#expand(f1) =102  => '102',
																														(integer)left.#expand(f1) =222  => '222',
																													  (integer)left.#expand(f1) between 500 and 599  => '500-599',
																														(integer)left.#expand(f1) between 600 and 633  => '600-633',
																														(integer)left.#expand(f1) between 634 and 666  => '634-666',
																														(integer)left.#expand(f1) between 667 and 699  => '667-699',
																														(integer)left.#expand(f1) between 700 and 733  => '700-733',
																														(integer)left.#expand(f1) >=734 => '>=734',
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
																														(integer)left.#expand(f1) =102  => '102',
																														(integer)left.#expand(f1) =222  => '222',
																													  (integer)left.#expand(f1) between 500 and 599  => '500-599',
																														(integer)left.#expand(f1) between 600 and 633  => '600-633',
																														(integer)left.#expand(f1) between 634 and 666  => '634-666',
																														(integer)left.#expand(f1) between 667 and 699  => '667-699',
																														(integer)left.#expand(f1) >=700 => '>=700',													
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
																														(integer)left.#expand(f1) =0  => '0',
																													  (integer)left.#expand(f1) between 1 and 24  => '1_24',
																														(integer)left.#expand(f1) between 25 and 49  => '25-49',
																														(integer)left.#expand(f1) between 50 and 74  => '50-74',
																														(integer)left.#expand(f1) between 75 and 99  => '75-99',
																														(integer)left.#expand(f1) =100 => '100',														
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
																														(integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =100  => '100',
																														(integer)left.#expand(f1) =225  => '225',
																													  (integer)left.#expand(f1) between 1 and 24  => '1_24',
																														(integer)left.#expand(f1) between 25 and 49  => '25-49',
																														(integer)left.#expand(f1) between 50 and 74  => '50-74',
																														(integer)left.#expand(f1) between 75 and 99  => '75-99',																							
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
																														(integer)left.#expand(f1) = 0  => '0',
																														(integer)left.#expand(f1) between 1 and 5  => '1_5',
																														(integer)left.#expand(f1) between 6 and 10  => '6_10',
																														(integer)left.#expand(f1) between 11 and 15  => '11_15',
																														(integer)left.#expand(f1) between 16 and 20  => '16-20',
																													  (integer)left.#expand(f1) >20  => '>20',																												
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
																													 (integer)left.#expand(f1) = 0  => '0',
																													 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) = 2  => '2',
																													 (integer)left.#expand(f1) = 3  => '3',
																													 (integer)left.#expand(f1) between 4 and 9  => '4_9',
																													 (integer)left.#expand(f1) >=10  => '>=10',		
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
																													  (integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) between 1 and 2  => '1_2',
																														(integer)left.#expand(f1) between 3 and 4  => '3_4',
																														(integer)left.#expand(f1) between 5 and 6  => '5_6',
																														(integer)left.#expand(f1) between 7 and 10  => '7_10',
																														(integer)left.#expand(f1) >10  => '>10',
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
																													  (integer)left.#expand(f1) =0  => '0',
																														(integer)left.#expand(f1) =1  => '1',
																														(integer)left.#expand(f1) =2  => '2',
																														(integer)left.#expand(f1) =3  => '3',
																														(integer)left.#expand(f1) between 4 and 9  => '4_9',
																														(integer)left.#expand(f1) between 10 and 25  => '10_25',
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

EXPORT range_Function_341(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =102  => '102',
																														(integer)left.#expand(f1) =222  => '222',
																													  (integer)left.#expand(f1) between 500 and 599  => '500-599',
																														(integer)left.#expand(f1) between 600 and 633  => '600-633',
																														(integer)left.#expand(f1) between 634 and 666  => '634-666',
																														(integer)left.#expand(f1) between 667 and 699  => '667-699',
																														(integer)left.#expand(f1) between 700 and 799  => '700-799',																								
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

EXPORT range_Function_342(DS,f1,cname) := FUNCTIONMACRO

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
																														(integer)left.#expand(f1) =102  => '102',
																														(integer)left.#expand(f1) =222  => '222',
																													  (integer)left.#expand(f1) between 500 and 533  => '500-533',
																														(integer)left.#expand(f1) between 534 and 566  => '534-566',
																														(integer)left.#expand(f1) between 567 and 599  => '567-599',
																														(integer)left.#expand(f1) between 600 and 633  => '600-633',
																														(integer)left.#expand(f1) between 634 and 666  => '634-666',
																														(integer)left.#expand(f1) between 667 and 699  => '667-699',
																														(integer)left.#expand(f1)>=700  => '>=700',			
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

EXPORT range_Function_343(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) = 102  => '102',
																													 (integer)left.#expand(f1) = 222  => '222',
																													 (integer)left.#expand(f1) between 500 and 524 => '500-524',
																													 (integer)left.#expand(f1) between 525 and 549 => '525-549',
																													 (integer)left.#expand(f1) between 550 and 599 => '550-599',
																													 (integer)left.#expand(f1) between 600 and 699 => '600-699',
																													 (integer)left.#expand(f1) between 700 and 799 => '700-799',
																													 (integer)left.#expand(f1) >=800 => '>=800',
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

EXPORT range_Function_344(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) =1 => '1',	
																													 (integer)left.#expand(f1) =2 => '2',		
																													 (integer)left.#expand(f1) between 3 and 4 => '3_4',	
																													 (integer)left.#expand(f1) between 5 and 7 => '5_7',	
																													 (integer)left.#expand(f1) between 8 and 15 => '8_15',
																													 (integer)left.#expand(f1)>15 => '>15',																																																																						
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

EXPORT range_Function_345(DS,f1,cname) := FUNCTIONMACRO

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
																							  					 (integer)left.#expand(f1) = 1  => '1',
																													 (integer)left.#expand(f1) between 2 and 3  => '2_3',	
																													 (integer)left.#expand(f1) between 4 and 5  => '4_5',
																													 (integer)left.#expand(f1) >=6  => '>=6',
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

EXPORT range_Function_346(DS,f1,cname) := FUNCTIONMACRO

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
																			self.distribution_type := 'length';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank',
																													  length(trim((string)left.#expand(f1),left,right))= 10 => 'is populated as valid 10phone',
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

EXPORT range_Function_347(DS,f1,cname) := FUNCTIONMACRO

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
																													 (integer)left.#expand(f1) between 1 and 24  => '1_24',	
																													 (integer)left.#expand(f1) between 25 and 34  => '25_34',
																													 (integer)left.#expand(f1) between 35 and 44  => '35_44',
																													 (integer)left.#expand(f1) >=45  => '>=45',
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

END;