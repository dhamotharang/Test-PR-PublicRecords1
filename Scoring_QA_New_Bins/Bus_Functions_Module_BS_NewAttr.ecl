EXPORT Bus_Functions_Module_BS_NewAttr := MODULE

import ut;

//***************************************//
//***************************************//


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
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1) between 0 and 2=>'0-2',	
																													 (integer)left.#expand(f1) between 3 and 4=>'3-4',	
																													 (integer)left.#expand(f1) between 5 and 300=>'5-300',	
																													 (integer)left.#expand(f1) between 301 and 700=>'300-700',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= -97 => '-97',
																													 (integer)left.#expand(f1) between 0 and 25=>'0-25',	
																													 (integer)left.#expand(f1) between 26 and 50=>'26-50',	
																													 (integer)left.#expand(f1) between 51 and 75=>'51-75',	
																													 (integer)left.#expand(f1) between 76 and 100=>'76-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 500000=>'0-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 15000=>'0-15000',	
																													 (integer)left.#expand(f1) between 15001 and 45000=>'15001-45000',	
																													 (integer)left.#expand(f1) between 45001 and 60000=>'45001-60000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 3000000=>'2000001-3000000',	
																													 (integer)left.#expand(f1) between 3000001 and 4000000=>'3000001-4000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 300000=>'0-300000',	
																													 (integer)left.#expand(f1) between 300000 and 700000=>'300000-700000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 5000000=>'0-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 10000000=>'5000001-10000000',	
																													 (integer)left.#expand(f1) between 10000001 and 25000000=>'10000001-25000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 3000000=>'0-3000000',	
																													 (integer)left.#expand(f1) between 3000001 and 6500000=>'3000001-6500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 100000=>'0-100000',	
																													 (integer)left.#expand(f1) between 100001 and 200000=>'100001-200000',	
																													 (integer)left.#expand(f1) between 200001 and 300000=>'200001-300000',	
																													 (integer)left.#expand(f1) between 300001 and 400000=>'300001-400000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 200000=>'0-200000',	
																													 (integer)left.#expand(f1) between 200001 and 400000=>'200001-400000',	
																													 (integer)left.#expand(f1) between 400000 and 650000=>'400000-650000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 2500000=>'0-2500000',	
																													 (integer)left.#expand(f1) between 2500001 and 5000000=>'2500001-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 7500000=>'5000001-7500000',	
																													 (integer)left.#expand(f1) between 7500001 and 10000000=>'7500001-10000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 2500000=>'0-2500000',	
																													 (integer)left.#expand(f1) between 2500001 and 5000000=>'2500001-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 7500000=>'5000001-7500000',	
																													 (integer)left.#expand(f1) between 7500001 and 12000000=>'7500001-12000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 5000000=>'1-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 10500000=>'5000001-10500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 2500000=>'0-2500000',	
																													 (integer)left.#expand(f1) between 2500001 and 7500000=>'2500001-7500000',	
																													 (integer)left.#expand(f1) between 7500001 and 1500000=>'7500001-1500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 2000000=>'0-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 4000000=>'2000001-4000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 500000=>'1-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 1500000=>'1000001-1500000',	
																													 (integer)left.#expand(f1) between 1500001 and 2000000=>'1500001-2000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 500000=>'1-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 1500000=>'1000001-1500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 50000=>'1-50000',	
																													 (integer)left.#expand(f1) between 50001 and 125000=>'50001-125000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 50000=>'1-50000',	
																													 (integer)left.#expand(f1) between 50001 and 125000=>'50001-125000',	
																													 (integer)left.#expand(f1) between 125001 and 150000=>'125001-150000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 25000=>'0-25000',	
																													 (integer)left.#expand(f1) between 25001 and 50000=>'25001-50000',	
																													 (integer)left.#expand(f1) between 50001 and 75000=>'50001-75000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 25000=>'0-25000',	
																													 (integer)left.#expand(f1) between 25001 and 50000=>'25001-50000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 500000=>'0-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 1500000=>'1000001-1500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 500000=>'0-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 1500000=>'1000001-1500000',	
																													 (integer)left.#expand(f1) between 1500001 and 1750000=>'1500001-1750000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 500000=>'0-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 1500000=>'1000001-1500000',	
																													 (integer)left.#expand(f1) between 1500001 and 1750000=>'1500001-1750000',	
																													 (integer)left.#expand(f1) between 1750001 and 2000000=>'1750001-2000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 250000=>'0-250000',	
																													 (integer)left.#expand(f1) between 250001 and 500000=>'250001-500000',	
																													 (integer)left.#expand(f1) between 500001 and 750000=>'500001-750000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 700000=>'0-700000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= -98 => '-98',
																													 (integer)left.#expand(f1) between 0 and 15000=>'0-15000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_28 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 30000=>'0-30000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_29 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 300000=>'0-300000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_30 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 500000=>'0-500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_31 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 5000000=>'1-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 10000000=>'5000001-10000000',	
																													 (integer)left.#expand(f1) between 10000001 and 20000000=>'10000001-20000000',	
																													 (integer)left.#expand(f1) between 20000001 and 25000000=>'20000001-25000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_32 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500000=>'1-2500000',	
																													 (integer)left.#expand(f1) between 2500001 and 5000000=>'2500001-5000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_33 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500000=>'1-2500000',	
																													 (integer)left.#expand(f1) between 2500001 and 5500000=>'2500001-5500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_34 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 3000000=>'1000001-3000000',	
																													 (integer)left.#expand(f1) between 3000001 and 5000000=>'3000001-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 7000000=>'5000001-7000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_35 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 5000000=>'0-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 10000000=>'5000001-10000000',	
																													 (integer)left.#expand(f1) between 10000001 and 15000000=>'10000001-15000000',	
																													 (integer)left.#expand(f1) between 15000001 and 20000000=>'15000001-20000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_36 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 5000000=>'0-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 10000000=>'5000001-10000000',	
																													 (integer)left.#expand(f1) between 10000001 and 15000000=>'10000001-15000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_37 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 1000000=>'0-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 3000000=>'2000001-3000000',	
																													 (integer)left.#expand(f1) between 3000001 and 4000000=>'3000001-4000000',	
																													 (integer)left.#expand(f1) between 4000001 and 5000000=>'4000001-5000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																								
				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_38 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 1000000=>'0-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 3000000=>'1000001-3000000',	
																													 (integer)left.#expand(f1) between 3000001 and 5000000=>'3000001-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 7000000=>'5000001-7000000',	
																													 (integer)left.#expand(f1) between 7000001 and 10000000=>'7000001-10000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_39 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 250000=>'0-250000',	
																													 (integer)left.#expand(f1) between 250001 and 500000=>'250001-500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_40 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 100000=>'0-100000',	
																													 (integer)left.#expand(f1) between 100001 and 200000=>'100001-200000',	
																													 (integer)left.#expand(f1) between 200001 and 250000=>'200001-250000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_41 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 50000=>'0-50000',	
																													 (integer)left.#expand(f1) between 50001 and 100000=>'50001-100000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_42 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 25000=>'0-25000',	
																													 (integer)left.#expand(f1) between 25001 and 50000=>'25001-50000',	
																													 (integer)left.#expand(f1) between 50001 and 75000=>'50001-75000',	
																													 (integer)left.#expand(f1) between 75001 and 100000=>'75001-100000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

				
		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_43 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 200000=>'0-200000',	
																													 (integer)left.#expand(f1) between 200001 and 400000=>'200001-400000',	
																													 (integer)left.#expand(f1) between 400001 and 600000=>'400001-600000',	
																													 (integer)left.#expand(f1) between 600001 and 700000=>'600001-700000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_44 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 2000000=>'0-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 4000000=>'2000001-4000000',	
																													 (integer)left.#expand(f1) between 4000001 and 5000000=>'4000001-5000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_45 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 300000=>'0-300000',	
																													 (integer)left.#expand(f1) between 300001 and 600000=>'300001-600000',	
																													 (integer)left.#expand(f1) between 600001 and 900000=>'600001-900000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_46 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 450000=>'0-450000',	
																													 (integer)left.#expand(f1) between 450001 and 900000=>'450001-900000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_47 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 2 and 5=>'2-5',	
																													 (integer)left.#expand(f1) between 6 and 50=>'6-50',	
																													 (integer)left.#expand(f1) between 51 and 99=>'51-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_48 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 2 and 25=>'2-25',	
																													 (integer)left.#expand(f1) between 26 and 50=>'26-50',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_49 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 2 and 50=>'2-50',	
																													 (integer)left.#expand(f1) between 51 and 100=>'51-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_50 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 3 and 5=>'3-5',	
																													 (integer)left.#expand(f1) between 6 and 50=>'6-50',	
																													 (integer)left.#expand(f1) between 51 and 100=>'51-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_51 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 50=>'0-50',	
																													 (integer)left.#expand(f1) between 51 and 100=>'51-100',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_52 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_53 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 2=>'0-2',	
																													 (integer)left.#expand(f1) between 3 and 50=>'3-50',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_54 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 0 and 400000=>'0-400000',	
																													 (integer)left.#expand(f1) between 400001 and 850000=>'400001-850000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_55 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 2500000=>'2000001-2500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_56 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500000=>'1-2500000',	
																													 (integer)left.#expand(f1) between 2500001 and 5500000=>'2500001-5500000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_57 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 200000=>'1-200000',	
																													 (integer)left.#expand(f1) between 200001 and 400000=>'200001-400000',	
																													 (integer)left.#expand(f1) between 400001 and 650000=>'400001-650000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_58 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 500000=>'1-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 1500000=>'1000001-1500000',	
																													 (integer)left.#expand(f1) between 1500001 and 2000000=>'1500001-2000000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_59 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 200000=>'1-200000',	
																													 (integer)left.#expand(f1) between 200001 and 450000=>'200001-450000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_60 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 25000=>'1-25000',	
																													 (integer)left.#expand(f1) between 25001 and 50000=>'25001-50000',	
																													 (integer)left.#expand(f1) between 50001 and 75000=>'50001-75000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_61 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 25000=>'1-25000',	
																													 (integer)left.#expand(f1) between 25001 and 50000=>'25001-50000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_62 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 15000=>'1-15000',	
																													 (integer)left.#expand(f1) between 15001 and 30000=>'15001-30000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_63 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 25000=>'1-25000',	
																													 (integer)left.#expand(f1) between 25001 and 50000=>'25001-50000',	
																													 (integer)left.#expand(f1) between 50001 and 75000=>'50001-75000',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_64 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 50000=>'1-50000',	
																													 (integer)left.#expand(f1) between 50001 and 100000=>'50001-100000',	
																													 (integer)left.#expand(f1) between 100001 and 150000=>'100001-150000',	
																													 (integer)left.#expand(f1) between 150001 and 175000=>'150001-175000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_65 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 150000=>'1-150000',	
																													 (integer)left.#expand(f1) between 150001 and 300000=>'150001-300000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_66 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 15000=>'1-15000',	
																													 (integer)left.#expand(f1) between 15001 and 30000=>'15001-30000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_67 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 45000=>'1-45000',	
																													 (integer)left.#expand(f1) between 45001 and 90000=>'45001-90000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_68 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 75000=>'1-75000',	
																													 (integer)left.#expand(f1) between 75001 and 150000=>'75001-150000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_69 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 150000=>'1-150000',	
																													 (integer)left.#expand(f1) between 150001 and 300000=>'150001-300000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_70 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 75000=>'1-75000',	
																													 (integer)left.#expand(f1) between 75001 and 150000=>'75001-150000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_71 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_72 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 7500000=>'1-7500000',	
																													 (integer)left.#expand(f1) between 7500001 and 1600000=>'7500001-1600000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																																 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_73 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 500000=>'1-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 1500000=>'1000001-1500000',	
																													 (integer)left.#expand(f1) between 1500001 and 2000000=>'1500001-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 2500000=>'2000001-2500000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																												 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_74 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500000=>'1-2500000',	
																													 (integer)left.#expand(f1) between 2500001 and 5000000=>'2500001-5000000',	
																													 (integer)left.#expand(f1) between 5000001 and 7500000=>'5000001-7500000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'

																										 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_75 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2000000=>'1-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 4000000=>'2000001-4000000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'

																										 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_76 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1500000=>'1-1500000',	
																													 (integer)left.#expand(f1) between 1500001 and 3000000=>'1500001-3000000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'

																										 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_77 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 500000=>'1-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 1500000=>'1000001-1500000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																										 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_78 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2000000=>'1-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 4000000=>'2000001-4000000',	
																													 (integer)left.#expand(f1) between 4000001 and 6500000=>'4000001-6500000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																									 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_79 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 100000=>'1-100000',	
																													 (integer)left.#expand(f1) between 100001 and 250000=>'100001-250000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																									 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_80 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 10000=>'1-10000',	
																													 (integer)left.#expand(f1) between 10001 and 20000=>'10001-20000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																									 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_81 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2000=>'1-2000',	
																													 (integer)left.#expand(f1) between 2001 and 4000=>'2001-4000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																									 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_82 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1500=>'1-1500',	
																													 (integer)left.#expand(f1) between 1501 and 3000=>'1501-3000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																									 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_83 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500=>'1-2500',	
																													 (integer)left.#expand(f1) between 2501 and 5000=>'2501-5000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																									 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_84 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 3000=>'1-3000',	
																													 (integer)left.#expand(f1) between 3001 and 6000=>'3001-6000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																									 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_85 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 7000=>'1-7000',	
																													 (integer)left.#expand(f1) between 7001 and 14000=>'7001-14000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																									 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_86 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 75000=>'1-75000',	
																													 (integer)left.#expand(f1) between 75001 and 145000=>'75001-145000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																									 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_87 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 500000=>'1-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000000 and 1600000=>'1000000-1600000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																				 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_88 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 40000=>'1-40000',	
																													 (integer)left.#expand(f1) between 40001 and 80001=>'40001-80001',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																				 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_89 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 90000=>'1-90000',	
																													 (integer)left.#expand(f1) between 90001 and 185000=>'90001-185000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																				 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_90 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 100000=>'1-100000',	
																													 (integer)left.#expand(f1) between 100001 and 200000=>'100001-200000',	
																													 (integer)left.#expand(f1) between 200001 and 300000=>'200001-300000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_91 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 3500000=>'2000001-3500000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_92 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500000=>'1-2500000',	
																													 (integer)left.#expand(f1) between 2500001 and 5000000=>'2500001-5000000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_93 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 3000000=>'2000001-3000000',	
																													 (integer)left.#expand(f1) between 3000001 and 4000000=>'3000001-4000000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_94 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 26 and 50=>'26-50',	
																													 (integer)left.#expand(f1) between 51 and 75=>'51-75',	
																													 (integer)left.#expand(f1) between 76 and 100=>'76-100',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_95 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 15000=>'1-15000',	
																													 (integer)left.#expand(f1) between 15001 and 35000=>'15001-35000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_96 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 8000=>'1-8000',	
																													 (integer)left.#expand(f1) between 8001 and 16500=>'8001-16500',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_97 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 25000=>'1-25000',	
																													 (integer)left.#expand(f1) between 25001 and 55000=>'25001-55000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_98 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 100000=>'1-100000',	
																													 (integer)left.#expand(f1) between 100001 and 200000=>'100001-200000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_99 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 7500=>'1-7500',	
																													 (integer)left.#expand(f1) between 7501 and 150000=>'7501-150000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_100 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 5000=>'1-5000',	
																													 (integer)left.#expand(f1) between 5001 and 11000=>'5001-11000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_101 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_102 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 2 and 25=>'2-25',	
																													 (integer)left.#expand(f1) between 26 and 50=>'26-50',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_103 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 6000=>'1-6000',	
																													 (integer)left.#expand(f1) between 6001 and 12000=>'6001-12000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_104 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_105 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2000=>'1-2000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_106 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 3000=>'1-3000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_107 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 7000=>'1-7000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_108 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 500000=>'1-500000',	
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',	
																													 (integer)left.#expand(f1) between 1000001 and 1600000=>'1000001-1600000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_109 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 8000=>'1-8000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_110 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_111 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2000000=>'1-2000000',	
																													 (integer)left.#expand(f1) between 2000001 and 4000000=>'2000001-4000000',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_112 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 7=>'1-7',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_113 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_114 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 12=>'1-12',	
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_115 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_116 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_117 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 300=>'1-300',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_118 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 3000=>'1-3000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_119 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 200=>'1-200',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_120 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 800=>'1-800',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_121 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1500=>'1-1500',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_122 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_123 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 4000=>'1-4000',
																													 (integer)left.#expand(f1) between 4001 and 8500=>'4001-8500',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_124 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 25000=>'1-25000',
																													 (integer)left.#expand(f1) between 25001 and 50000=>'25001-50000',
																													 (integer)left.#expand(f1) between 50001 and 80000=>'50001-80000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_125 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 4000=>'1-4000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_126 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 5000=>'1-5000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_127 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_128 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_129 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 2 and 100=>'2-100',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_130 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 3 and 100=>'3-100',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_131 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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

EXPORT range_Function_132 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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

EXPORT range_Function_133 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 3=>'1-3',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_134 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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

EXPORT range_Function_135 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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

EXPORT range_Function_136 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1=>'1-11',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_137 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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

EXPORT range_Function_138 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 13=>'1-13',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_139 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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

EXPORT range_Function_140 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 50=>'1-50',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_141 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 300000=>'1-300000',
																													 (integer)left.#expand(f1) between 300001 and 600000=>'300001-600000',
																													 (integer)left.#expand(f1) between 600001 and 900000=>'600001-900000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_142 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',
																													 (integer)left.#expand(f1) between 2000001 and 3000000=>'2000001-3000000',
																													 (integer)left.#expand(f1) between 3000001 and 4000000=>'3000001-4000000',
																													 (integer)left.#expand(f1) between 4000001 and 5000000=>'4000001-5000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_143 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',
																													 (integer)left.#expand(f1) between 1000001 and 2500000=>'1000001-2500000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_144 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',
																													 (integer)left.#expand(f1) between 2000001 and 4000000=>'2000001-4000000',
																													 (integer)left.#expand(f1) between 4000001 and 6000000=>'4000001-6000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_145 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 25000=>'1-25000',
																													 (integer)left.#expand(f1) between 25000 and 50000=>'25000-50000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_146 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 25000=>'1-25000',
																													 (integer)left.#expand(f1) between 25000 and 60000=>'25000-60000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
																	 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_147 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 50000=>'1-50000',
																													 (integer)left.#expand(f1) between 50001 and 100000=>'50001-100000',
																													 (integer)left.#expand(f1) between 100001 and 150000=>'100001-150000',
																													 (integer)left.#expand(f1) between 150001 and 200000=>'150001-200000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_148 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 5000=>'1-5000',
																													 (integer)left.#expand(f1) between 5001 and 10000=>'5001-10000',
																													 (integer)left.#expand(f1) between 10001 and 15000=>'10001-15000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_149 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 30000=>'1-30000',
																													 (integer)left.#expand(f1) between 30001 and 60000=>'30001-60000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_150 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 20=>'1-20',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_151 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 10000=>'1-10000',
																													 (integer)left.#expand(f1) between 10001 and 20000=>'10001-20000',
																													 (integer)left.#expand(f1) between 20001 and 30000=>'20001-30000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_152 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 50000=>'1-50000',
																													 (integer)left.#expand(f1) between 50001 and 100000=>'50001-100000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_153 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_154 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',
																													 (integer)left.#expand(f1) between 2000001 and 3000000=>'2000001-3000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_155 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2000000=>'1-2000000',
																													 (integer)left.#expand(f1) between 2000001 and 4000000=>'2000001-4000000',
																													 (integer)left.#expand(f1) between 4000001 and 6000000=>'4000001-6000000',
																													 (integer)left.#expand(f1) between 6000001 and 8000000=>'6000001-8000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_156 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_157 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',
																													 (integer)left.#expand(f1) between 2000001 and 3000000=>'2000001-3000000',
																													 (integer)left.#expand(f1) between 3000001 and 4000000=>'3000001-4000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_158 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 10=>'1-10',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_159 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000=>'1-1000',
																													 (integer)left.#expand(f1) between 1001 and 2000=>'1001-2000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_160 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 50000=>'1-50000',
																													 (integer)left.#expand(f1) between 50001 and 100000=>'50001-100000',
																													 (integer)left.#expand(f1) between 100001 and 150000=>'100001-150000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_161 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',
																													 (integer)left.#expand(f1) between 2000001 and 3500000=>'2000001-3500000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_162 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500000=>'1-2500000',
																													 (integer)left.#expand(f1) between 2500001 and 5000000=>'2500001-5000000',
																													 (integer)left.#expand(f1) between 5000001 and 7500000=>'5000001-7500000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_163 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 250000=>'1-250000',
																													 (integer)left.#expand(f1) between 250001 and 500000=>'250001-500000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_164 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 26 and 50=>'26-50',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_165 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 500000=>'1-500000',
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',
																													 (integer)left.#expand(f1) between 1000001 and 1750000=>'1000001-1750000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_166 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000000=>'1-1000000',
																													 (integer)left.#expand(f1) between 1000001 and 2000000=>'1000001-2000000',
																													 (integer)left.#expand(f1) between 2000001 and 3000000=>'2000001-3000000',
																													 (integer)left.#expand(f1) between 3000001 and 4000000=>'3000001-4000000',
																													 (integer)left.#expand(f1) between 4000001 and 5000000=>'4000001-5000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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


// EXPORT range_Function_167 (DS,f1,cname) := FUNCTIONMACRO

		// #uniquename(tble)
		// %tble% := table(ds);

		// #uniquename(cnt)
		// %cnt% := count(%tble%);

		// #uniquename(rc)
		// %rc% := RECORD
			// string100 field_name;
			// string100 category := cname;
			// string30 distribution_type ;
			// string50 attribute_value ;
		// END;
									
		// #uniquename(Bks_project)
		// %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			// self.field_name:=f1;
																			// self.distribution_type := 'range';
																			// self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															// MAP(
																														// length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 // (integer)left.#expand(f1)= -99 => '-99',
																													 // (integer)left.#expand(f1)= -98 => '-98',
																													 // (integer)left.#expand(f1)= -97 => '-97',
																													 // (integer)left.#expand(f1)= 0 => '0',
																													 // (integer)left.#expand(f1) between 1 and 5000=>'1-5000',
																													 // (integer)left.#expand(f1) between 5001 and 10000=>'5001-10000',
																															 // 'UNDEFINED'),
																															 // 'UNDEFINED'
													 // );     

		 // ));

		// #uniquename(rc_tab)
		// %rc_tab% := RECORD
			// %Bks_project%.field_name;
			// %Bks_project%.category;
			// %Bks_project%.distribution_type;
			// %Bks_project%.attribute_value ;
			// decimal20_4 frequency := count(group);
		// END;

		// RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

// ENDMACRO;


//***************************************//
//***************************************//

EXPORT range_Function_168 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2=>'1-2',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_169 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000=>'1-1000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_170 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 1000=>'1-1000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_171 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500=>'1-2500',
																													 (integer)left.#expand(f1) between 2501 and 5000=>'2501-5000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_172 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2000000=>'1-2000000',
																													 (integer)left.#expand(f1) between 2000001 and 4000000=>'2000001-4000000',
																													 (integer)left.#expand(f1) between 4000001 and 6000000=>'4000001-6000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_173 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 500000=>'1-500000',
																													 (integer)left.#expand(f1) between 500001 and 1000000=>'500001-1000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_174 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 200000=>'1-200000',
																													 (integer)left.#expand(f1) between 200001 and 400000=>'200001-400000',
																													 (integer)left.#expand(f1) between 400001 and 600000=>'400001-600000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_175 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500000=>'1-2500000',
																													 (integer)left.#expand(f1) between 2500001 and 5000000=>'2500001-5000000',
																													 (integer)left.#expand(f1) between 5000001 and 7500000=>'5000001-7500000',
																													 (integer)left.#expand(f1) between 7500001 and 10000000=>'7500001-10000000',
																													 (integer)left.#expand(f1) between 10000001 and 12500000=>'10000001-12500000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_176 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 5000000=>'1-5000000',
																													 (integer)left.#expand(f1) between 5000001 and 10000000=>'5000001-10000000',
																													 (integer)left.#expand(f1) between 10000001 and 15000000=>'10000001-15000000',
																													 (integer)left.#expand(f1) between 15000001 and 20000000=>'15000001-20000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_177 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2500000=>'1-2500000',
																													 (integer)left.#expand(f1) between 2500001 and 5000000=>'2500001-5000000',
																													 (integer)left.#expand(f1) between 5000001 and 7500000=>'5000001-7500000',
																													 (integer)left.#expand(f1) between 7500001 and 10000000=>'7500001-10000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_178 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 10000000=>'1-10000000',
																													 (integer)left.#expand(f1) between 10000001 and 20000000=>'10000001-20000000',
																													 (integer)left.#expand(f1) between 20000001 and 30000000=>'20000001-30000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_179 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 10000000=>'1-10000000',
																													 (integer)left.#expand(f1) between 10000001 and 20000000=>'10000001-20000000',
																													 (integer)left.#expand(f1) between 20000001 and 30000000=>'20000001-30000000',
																													 (integer)left.#expand(f1) between 30000001 and 40000000=>'30000001-40000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_180 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 100000=>'1-100000',
																													 (integer)left.#expand(f1) between 100001 and 200000=>'100001-200000',
																													 (integer)left.#expand(f1) between 200001 and 300000=>'200001-300000',
																													 (integer)left.#expand(f1) between 300001 and 400000=>'300001-400000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_181 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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

EXPORT range_Function_182 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 10000000=>'1-10000000',
																													 (integer)left.#expand(f1) between 10000001 and 20000000=>'10000001-20000000',
																													 (integer)left.#expand(f1) between 20000001 and 30000000=>'20000001-30000000',
																													 (integer)left.#expand(f1) between 30000001 and 40000000=>'30000001-40000000',
																													 (integer)left.#expand(f1) between 40000001 and 50000000=>'40000001-50000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_183 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 20000000=>'1-10000000',
																													 (integer)left.#expand(f1) between 20000001 and 40000000=>'20000001-40000000',
																													 (integer)left.#expand(f1) between 40000001 and 60000000=>'40000001-60000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_184 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 25000000=>'1-25000000',
																													 (integer)left.#expand(f1) between 25000001 and 50000000=>'25000001-50000000',
																													 (integer)left.#expand(f1) between 50000001 and 75000000=>'50000001-75000000',
																													 (integer)left.#expand(f1) between 75000001 and 99999999=>'75000001-99999999',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_185 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 5000000=>'1-5000000',
																													 (integer)left.#expand(f1) between 5000001 and 10000000=>'5000001-10000000',
																													 (integer)left.#expand(f1) between 10000001 and 15000000=>'10000001-15000000',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_186 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 50=>'1-50',
																													 (integer)left.#expand(f1) between 51 and 100=>'51-100',
																													 (integer)left.#expand(f1) between 101 and 200=>'101-200',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_187 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 100=>'1-100',
																													 (integer)left.#expand(f1) between 101 and 200=>'101-200',
																													 (integer)left.#expand(f1) between 201 and 300=>'201-300',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_188 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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

EXPORT range_Function_189 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1)= 0 => '0',
																													 (integer)left.#expand(f1) between 1 and 200=>'1-200',
																													 (integer)left.#expand(f1) between 201 and 400=>'201-400',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_190 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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

EXPORT range_Function_191 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 2 and 25=>'2-25',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_192 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 2 and 100=>'2-100',
																													 (integer)left.#expand(f1) between 101 and 200=>'101-200',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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

EXPORT range_Function_193 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 2 and 100=>'2-100',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     


		 ));

		#uniquename(rc_tab)
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


EXPORT range_Function_194 (DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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
																													 (integer)left.#expand(f1) between 1 and 2=>'1-2',
																															 'UNDEFINED'),
																															 'UNDEFINED'
													 );     

		 ));

		#uniquename(rc_tab)
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
