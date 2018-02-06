EXPORT Bus_Functions_Module3 := MODULE

import ut;


EXPORT range_Function_500(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 99=>'0-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_501(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 19999=>'1-19999',	
																													 (integer)left.#expand(f1) between 20000 and 59999=>'20000-59999',	
																													 (integer)left.#expand(f1) between 60000 and 199999=>'60000-199999',	
																													 (integer)left.#expand(f1) between 200000 and 599999=>'200000-599999',	
																													 (integer)left.#expand(f1) between 600000 and 99999999=>'600000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_502(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 39999=>'1-39999',	
																													 (integer)left.#expand(f1) between 40000 and 99999=>'40000-99999',	
																													 (integer)left.#expand(f1) between 100000 and 249999=>'100000-249999',	
																													 (integer)left.#expand(f1) between 250000 and 799999=>'250000-799999',	
																													 (integer)left.#expand(f1) between 800000 and 99999999=>'800000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_503(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 499=>'1-499',	
																													 (integer)left.#expand(f1) between 500 and 999=>'500-999',	
																													 (integer)left.#expand(f1) between 1000 and 7999=>'1000-7999',	
																													 (integer)left.#expand(f1) between 8000 and 29999=>'8000-29999',	
																													 (integer)left.#expand(f1) between 30000 and 99999999=>'30000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_504(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 5999=>'1-5999',	
																													 (integer)left.#expand(f1) between 6000 and 11999=>'6000-11999',	
																													 (integer)left.#expand(f1) between 12000 and 19999=>'12000-19999',	
																													 (integer)left.#expand(f1) between 20000 and 29999=>'20000-29999',	
																													 (integer)left.#expand(f1) between 30000 and 99999999=>'30000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_505(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 24999=>'1-24999',	
																													 (integer)left.#expand(f1) between 25000 and 49999=>'25000-49999',	
																													 (integer)left.#expand(f1) between 50000 and 99999=>'50000-99999',	
																													 (integer)left.#expand(f1) between 100000 and 249999=>'100000-249999',	
																													 (integer)left.#expand(f1) between 250000 and 99999999=>'250000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_506(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 5999=>'1-5999',	
																													 (integer)left.#expand(f1) between 6000 and 10999=>'6000-10999',	
																													 (integer)left.#expand(f1) between 11000 and 17499=>'11000-17499',	
																													 (integer)left.#expand(f1) between 17500 and 26499=>'17500-26499',	
																													 (integer)left.#expand(f1) between 27500 and 99999999=>'27500-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_507(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 15999=>'1-15999',	
																													 (integer)left.#expand(f1) between 16000 and 29999=>'16000-29999',	
																													 (integer)left.#expand(f1) between 30000 and 49999=>'30000-49999',	
																													 (integer)left.#expand(f1) between 50000 and 74999=>'50000-74999',	
																													 (integer)left.#expand(f1) between 75000 and 99999999=>'75000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_508(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 24999=>'1-24999',	
																													 (integer)left.#expand(f1) between 25000 and 54999=>'25000-54999',	
																													 (integer)left.#expand(f1) between 55000 and 119999=>'55000-119999',	
																													 (integer)left.#expand(f1) between 120000 and 99999999=>'120000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_509(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 349=>'1-349',	
																													 (integer)left.#expand(f1) between 350 and 549=>'350-549',	
																													 (integer)left.#expand(f1) between 550 and 999=>'550-999',	
																													 (integer)left.#expand(f1) between 1000 and 999999=>'1000-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_510(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																													 (integer)left.#expand(f1) between 100 and 299=>'100-299',	
																													 (integer)left.#expand(f1) between 300 and 799=>'300-799',	
																													 (integer)left.#expand(f1) between 800 and 999999=>'800-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_511(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 25=>'1-25',	
																													 (integer)left.#expand(f1) between 26 and 79=>'26-79',	
																													 (integer)left.#expand(f1) between 80 and 129=>'80-129',	
																													 (integer)left.#expand(f1) between 130 and 999999=>'130-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_512(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 19=>'0-19',	
																													 (integer)left.#expand(f1) between 20 and 54=>'20-54',	
																													 (integer)left.#expand(f1) between 55 and 139=>'55-139',	
																													 (integer)left.#expand(f1) between 140 and 319=>'140-319',	
																													 (integer)left.#expand(f1) between 320 and 999999=>'320-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_513(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
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


EXPORT range_Function_514(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																													 (integer)left.#expand(f1) between 100 and 174=>'100-174',	
																													 (integer)left.#expand(f1) between 175 and 299=>'175-299',	
																													 (integer)left.#expand(f1) between 300 and 999999=>'300-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_515(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 399=>'1-399',	
																													 (integer)left.#expand(f1) between 400 and 999=>'400-999',	
																													 (integer)left.#expand(f1) between 1000 and 3999=>'1000-3999',	
																													 (integer)left.#expand(f1) between 4000 and 999999=>'4000-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_516(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 50=>'1-50',	
																													 (integer)left.#expand(f1) between 51 and 125=>'51-125',	
																													 (integer)left.#expand(f1) between 126 and 299=>'126-299',	
																													 (integer)left.#expand(f1) between 300 and 999999=>'300-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_517(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 299=>'0-299',	
																													 (integer)left.#expand(f1) between 300 and 499=>'300-499',	
																													 (integer)left.#expand(f1) between 500 and 799=>'500-799',	
																													 (integer)left.#expand(f1) between 800 and 1599=>'800-1599',	
																													 (integer)left.#expand(f1) between 1600 and 999999=>'1600-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_518(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 199=>'1-199',	
																													 (integer)left.#expand(f1) between 200 and 499=>'200-499',	
																													 (integer)left.#expand(f1) between 500 and 1999=>'500-1999',	
																													 (integer)left.#expand(f1) between 2000 and 999999=>'2000-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_519(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 49=>'1-49',	
																													 (integer)left.#expand(f1) between 50 and 124=>'50-124',	
																													 (integer)left.#expand(f1) between 125 and 299=>'125-299',	
																													 (integer)left.#expand(f1) between 300 and 999999=>'300-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_520 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 49=>'0-49',	
																													 (integer)left.#expand(f1) between 50 and 79=>'50-79',	
																													 (integer)left.#expand(f1) between 80 and 149=>'80-149',	
																													 (integer)left.#expand(f1) between 150 and 329=>'150-329',	
																													 (integer)left.#expand(f1) between 330 and 999999=>'330-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_521 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 150 => '150',
																													 (integer)left.#expand(f1) between 0 and 29=>'0-29',	
																													 (integer)left.#expand(f1) between 30 and 149=>'30-149',	
																													 (integer)left.#expand(f1) between 151 and 499=>'151-499',	
																													 (integer)left.#expand(f1) between 500 and 999999=>'500-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_522 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 349=>'0-349',	
																													 (integer)left.#expand(f1) between 350 and 1999=>'350-1999',	
																													 (integer)left.#expand(f1) between 2000 and 6999=>'2000-6999',	
																													 (integer)left.#expand(f1) between 7000 and 19999=>'7000-19999',	
																													 (integer)left.#expand(f1) between 20000 and 999999=>'20000-999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_523 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 6=>'1-6',	
																													 (integer)left.#expand(f1) between 7 and 19=>'7-19',	
																													 (integer)left.#expand(f1) between 20 and 59=>'20-59',	
																													 (integer)left.#expand(f1) between 60 and 100=>'60-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_524 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 39=>'1-39',	
																													 (integer)left.#expand(f1) between 40 and 69=>'40-69',	
																													 (integer)left.#expand(f1) between 70 and 94=>'70-94',	
																													 (integer)left.#expand(f1) between 95 and 100=>'95-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_525 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 5=>'1-5',	
																													 (integer)left.#expand(f1) between 6 and 19=>'6-19',	
																													 (integer)left.#expand(f1) between 20 and 49=>'20-49',	
																													 (integer)left.#expand(f1) between 50 and 100=>'50-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_526 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 5=>'1-5',	
																													 (integer)left.#expand(f1) between 6 and 19=>'6-19',	
																													 (integer)left.#expand(f1) between 20 and 44=>'20-44',	
																													 (integer)left.#expand(f1) between 45 and 100=>'45-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_527 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 29=>'1-29',	
																													 (integer)left.#expand(f1) between 30 and 64=>'30-64',	
																													 (integer)left.#expand(f1) between 65 and 94=>'65-94',	
																													 (integer)left.#expand(f1) between 95 and 100=>'95-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_528 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 29=>'1-29',	
																													 (integer)left.#expand(f1) between 30 and 59=>'30-59',	
																													 (integer)left.#expand(f1) between 60 and 89=>'60-89',	
																													 (integer)left.#expand(f1) between 90 and 100=>'90-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_529 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 24=>'1-24',	
																													 (integer)left.#expand(f1) between 25 and 59=>'25-59',	
																													 (integer)left.#expand(f1) between 60 and 89=>'60-89',	
																													 (integer)left.#expand(f1) between 90 and 100=>'90-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_530 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 19=>'1-19',	
																													 (integer)left.#expand(f1) between 20 and 49=>'20-49',	
																													 (integer)left.#expand(f1) between 50 and 84=>'50-84',	
																													 (integer)left.#expand(f1) between 85 and 100=>'85-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_531 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 5=>'1-5',	
																													 (integer)left.#expand(f1) between 6 and 14=>'6-14',	
																													 (integer)left.#expand(f1) between 15 and 49=>'15-49',	
																													 (integer)left.#expand(f1) between 50 and 100=>'50-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_532 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 5=>'1-5',	
																													 (integer)left.#expand(f1) between 6 and 14=>'6-14',	
																													 (integer)left.#expand(f1) between 15 and 44=>'15-44',	
																													 (integer)left.#expand(f1) between 45 and 100=>'45-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_533 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 5=>'1-5',	
																													 (integer)left.#expand(f1) between 6 and 16=>'6-16',	
																													 (integer)left.#expand(f1) between 17 and 44=>'17-44',	
																													 (integer)left.#expand(f1) between 45 and 100=>'45-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_534 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 5=>'1-5',	
																													 (integer)left.#expand(f1) between 6 and 16=>'6-16',	
																													 (integer)left.#expand(f1) between 17 and 39=>'17-39',	
																													 (integer)left.#expand(f1) between 40 and 100=>'40-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_535 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 19=>'1-19',	
																													 (integer)left.#expand(f1) between 20 and 54=>'20-54',	
																													 (integer)left.#expand(f1) between 55 and 84=>'55-84',	
																													 (integer)left.#expand(f1) between 85 and 100=>'85-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_536 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 14=>'1-14',	
																													 (integer)left.#expand(f1) between 15 and 44=>'15-44',	
																													 (integer)left.#expand(f1) between 45 and 79=>'45-79',	
																													 (integer)left.#expand(f1) between 80 and 100=>'80-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_537(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 4=>'1-4',	
																													 (integer)left.#expand(f1) between 5 and 14=>'5-14',	
																													 (integer)left.#expand(f1) between 15 and 49=>'15-49',	
																													 (integer)left.#expand(f1) between 50 and 100=>'50-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_538(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 4=>'1-4',	
																													 (integer)left.#expand(f1) between 5 and 19=>'5-19',	
																													 (integer)left.#expand(f1) between 20 and 49=>'20-49',	
																													 (integer)left.#expand(f1) between 50 and 100=>'50-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_539(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																													 (integer)left.#expand(f1) between 100 and 2699=>'100-2699',	
																													 (integer)left.#expand(f1) between 2700 and 9999=>'2700-9999',	
																													 (integer)left.#expand(f1) between 10000 and 99999999=>'10000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_540(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 19999=>'1-19999',	
																													 (integer)left.#expand(f1) between 20000 and 49999=>'20000-49999',	
																													 (integer)left.#expand(f1) between 50000 and 149999=>'50000-149999',	
																													 (integer)left.#expand(f1) between 150000 and 99999999=>'150000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_541(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 76=>'1-76',	
																													 (integer)left.#expand(f1) between 77 and 1699=>'77-1699',	
																													 (integer)left.#expand(f1) between 1700 and 5499=>'1700-5499',	
																													 (integer)left.#expand(f1) between 5500 and 99999999=>'5500-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_542(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1)= 3 => '3',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_543(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 159=>'1-159',	
																													 (integer)left.#expand(f1) between 160 and 14999=>'160-14999',	
																													 (integer)left.#expand(f1) between 15000 and 39999=>'15000-39999',	
																													 (integer)left.#expand(f1) between 40000 and 99999999=>'40000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_544(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 8=>'1-8',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_545(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 9=>'1-9',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_546(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 3 and 9=>'3-9',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_547(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 1=>'0-1',	
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1)= 3 => '3',
																													 (integer)left.#expand(f1) between 4 and 99=>'4-99',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_548(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 2=>'1-2',	
																													 (integer)left.#expand(f1) between 3 and 8=>'3-8',	
																													 (integer)left.#expand(f1)= 9 => '9',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_549(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 8=>'1-8',	
																													 (integer)left.#expand(f1)= 9 => '9',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_550(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 8=>'0-8',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_551(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 9=>'0-9',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_552(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 2=>'1-2',	
																													 (integer)left.#expand(f1) between 3 and 9=>'3-9',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_553(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 1=>'0-1',	
																													 (integer)left.#expand(f1) between 2 and 99=>'2-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_554(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 9=>'1-9',	
																													 (integer)left.#expand(f1) between 10 and 29=>'10-29',	
																													 (integer)left.#expand(f1) between 30 and 49=>'30-49',	
																													 (integer)left.#expand(f1) between 50 and 74=>'50-74',	
																													 (integer)left.#expand(f1) between 75 and 600=>'75-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_555(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 9=>'1-9',	
																													 (integer)left.#expand(f1) between 10 and 29=>'10-29',	
																													 (integer)left.#expand(f1) between 30 and 49=>'30-49',	
																													 (integer)left.#expand(f1) between 50 and 74=>'50-74',	
																													 (integer)left.#expand(f1) between 75 and 600=>'75-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_556(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_557(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_558(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 99=>'0-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_559(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 10=>'0-10',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_560(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 4=>'2-4',	
																													 (integer)left.#expand(f1) between 5 and 99=>'5-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_561(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 39=>'1-39',	
																													 (integer)left.#expand(f1) between 40 and 199=>'40-199',	
																													 (integer)left.#expand(f1) between 120 and 349=>'120-349',	
																													 (integer)left.#expand(f1) between 350 and 99999999=>'350-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_562(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
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


EXPORT range_Function_563(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 54=>'1-54',	
																													 (integer)left.#expand(f1) between 55 and 399=>'55-399',	
																													 (integer)left.#expand(f1) between 400 and 2999=>'400-2999',	
																													 (integer)left.#expand(f1) between 3000 and 99999999=>'3000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_564(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 400 and 2999=>'400-2999',	
																													 (integer)left.#expand(f1) between 400 and 99999999=>'400-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_565(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
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


EXPORT range_Function_566(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 49=>'1-49',	
																													 (integer)left.#expand(f1) between 50 and 99999999=>'50-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_567(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 39=>'1-39',	
																													 (integer)left.#expand(f1) between 40 and 99999999=>'40-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_568(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 4=>'1-4',	
																													 (integer)left.#expand(f1) between 5 and 34=>'5-34',	
																													 (integer)left.#expand(f1) between 35 and 99999999=>'35-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_569(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 3=>'1-3',	
																													 (integer)left.#expand(f1) between 4 and 19=>'4-19',	
																													 (integer)left.#expand(f1) between 20 and 99=>'20-99',	
																													 (integer)left.#expand(f1) between 100 and 99999999=>'100-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_570(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_571(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 99=>'2-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_572(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 99=>'0-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_573(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
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


EXPORT range_Function_574(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 1 and 19=>'1-19',	
																													 (integer)left.#expand(f1) between 20 and 44=>'20-44',	
																													 (integer)left.#expand(f1) between 45 and 600=>'45-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_575(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_576(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
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


EXPORT range_Function_577(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 001 => '001',
																													 (integer)left.#expand(f1)= 002 => '002',
																													 (integer)left.#expand(f1)= 003 => '003',
																													 (integer)left.#expand(f1)= 004 => '004',
																													 (integer)left.#expand(f1)= 005 => '005',
																													 (integer)left.#expand(f1)= 006 => '006',
																													 (integer)left.#expand(f1)= 007 => '007',
																													 (integer)left.#expand(f1)= 008 => '008',
																													 (integer)left.#expand(f1)= 009 => '009',
																													 (integer)left.#expand(f1)= 010 => '010',
																													 (integer)left.#expand(f1)= 011 => '011',
																													 (integer)left.#expand(f1)= 012 => '012',
																													 (integer)left.#expand(f1)= 013 => '013',
																													 (integer)left.#expand(f1)= 014 => '014',
																													 (integer)left.#expand(f1)= 015 => '015',
																													 (integer)left.#expand(f1)= 016 => '016',
																													 (integer)left.#expand(f1)= 050 => '050',
																													 (integer)left.#expand(f1)= 051 => '051',
																													 (integer)left.#expand(f1)= 052 => '052',
																													 (integer)left.#expand(f1)= 053 => '053',
																													 (integer)left.#expand(f1)= 070 => '070',
																													 (integer)left.#expand(f1)= 071 => '071',
																													 (integer)left.#expand(f1)= 083 => '083',
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_578(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_579 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_580 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 3 and 5=>'3-5',	
																													 (integer)left.#expand(f1) between 6 and 99=>'6-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_581 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 3 and 99=>'3-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_582 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 99=>'1-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_583 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 99=>'2-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_584 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 9=>'0-9',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_585 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 3 and 9=>'3-9',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_586 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1) between 2 and 5=>'2-5',	
																													 (integer)left.#expand(f1) between 6 and 99=>'6-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_587 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1)= 9 => '9',
																													 (integer)left.#expand(f1) between 3 and 8=>'3-8',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_588(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
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
																														 	  (integer)left.#expand(f1)= -99 => '-99',
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


EXPORT range_Function_589(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
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
																														 	  (integer)left.#expand(f1)= -99 => '-99',
																														 	  (integer)left.#expand(f1)= 0 => '0',
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


EXPORT range_Function_590(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
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
																														 	  (integer)left.#expand(f1)= -99 => '-99',
																														 	  (integer)left.#expand(f1)= -98 => '-98',
																														 	  (integer)left.#expand(f1)= 0 => '0',
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


EXPORT range_Function_591(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
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
																														 	  (integer)left.#expand(f1)= -99 => '-99',
																														 	  (integer)left.#expand(f1)= -97 => '-97',
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

END;