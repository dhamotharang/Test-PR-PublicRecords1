EXPORT Bus_Functions_Module2 := MODULE

import ut;


EXPORT range_Function_400(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
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


EXPORT range_Function_401(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
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


// ***************************************//
// ***************************************//


// EXPORT range_Function_402(DS,f1,cname) := FUNCTIONMACRO

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
																													 // (integer)left.#expand(f1)= 0 => '0',
																													 // (integer)left.#expand(f1)= 1 => '1',
																													 // (integer)left.#expand(f1)= 2 => '2',
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


EXPORT range_Function_402(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_403(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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


EXPORT range_Function_404(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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


EXPORT range_Function_405(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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
																													 (integer)left.#expand(f1) between 1 and 59=>'1-59',	
																													 (integer)left.#expand(f1) between 60 and 69=>'60-69',	
																													 (integer)left.#expand(f1) between 70 and 89=>'70-89',	
																													 (integer)left.#expand(f1) between 90 and 139=>'90-139',	
																													 (integer)left.#expand(f1) between 140 and 600=>'140-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_406(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 3 and 24=>'3-24',	
																													 (integer)left.#expand(f1) between 25 and 49=>'25-49',	
																													 (integer)left.#expand(f1) between 50 and 600=>'50-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_407(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
		#uniquename(Bks_project)
		%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
																			self.field_name:=f1;
																			self.distribution_type := 'range';
																			self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
																																 
																															MAP(
																														length(trim((string)left.#expand(f1),left,right))= 0 => 'blank', 
																													 (integer)left.#expand(f1)= -99 => '-99',
																													 (integer)left.#expand(f1)= 1 => '1',
																													 (integer)left.#expand(f1)= 2 => '2',
																													 (integer)left.#expand(f1) between 3 and 7=>'3-7',	
																													 (integer)left.#expand(f1) between 8 and 19=>'8-19',	
																													 (integer)left.#expand(f1) between 20 and 999=>'20-999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;



//***************************************//
//***************************************//


EXPORT range_Function_408(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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


EXPORT range_Function_409(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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


EXPORT range_Function_410(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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
																													 (integer)left.#expand(f1)= 1 => '1',
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


EXPORT range_Function_411(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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
																													 (integer)left.#expand(f1) between 1 and 65=>'4-99',	
																													 (integer)left.#expand(f1) between 66 and 75=>'4-99',	
																													 (integer)left.#expand(f1) between 76 and 95=>'4-99',	
																													 (integer)left.#expand(f1) between 96 and 165=>'4-99',	
																													 (integer)left.#expand(f1) between 166 and 600=>'4-99',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_412(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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
																													 (integer)left.#expand(f1) between 1 and 24=>'1-24',	
																													 (integer)left.#expand(f1) between 25 and 49=>'25-49',	
																													 (integer)left.#expand(f1) between 50 and 69=>'50-69',	
																													 (integer)left.#expand(f1) between 70 and 79=>'70-79',	
																													 (integer)left.#expand(f1) between 80 and 600=>'80-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;



//***************************************//
//***************************************//


EXPORT range_Function_413(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 14=>'1-14',	
																													 (integer)left.#expand(f1) between 15 and 29=>'15-29',	
																													 (integer)left.#expand(f1) between 30 and 44=>'30-44',	
																													 (integer)left.#expand(f1) between 45 and 64=>'45-64',	
																													 (integer)left.#expand(f1) between 65 and 600=>'65-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;



//***************************************//
//***************************************//


EXPORT range_Function_414(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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
																													 (integer)left.#expand(f1) between 2 and 3=>'1-14',	
																													 (integer)left.#expand(f1) between 4 and 99=>'15-29',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;



//***************************************//
//***************************************//


EXPORT range_Function_415(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 29=>'1-29',	
																													 (integer)left.#expand(f1) between 30 and 49=>'30-49',	
																													 (integer)left.#expand(f1) between 50 and 89=>'50-89',	
																													 (integer)left.#expand(f1) between 90 and 119=>'90-119',	
																													 (integer)left.#expand(f1) between 120 and 600=>'120-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_416(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 20 and 39=>'20-39',	
																													 (integer)left.#expand(f1) between 40 and 49=>'40-49',	
																													 (integer)left.#expand(f1) between 50 and 89=>'50-89',	
																													 (integer)left.#expand(f1) between 90 and 600=>'90-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_417(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 20 and 39=>'20-39',	
																													 (integer)left.#expand(f1) between 40 and 59=>'40-59',	
																													 (integer)left.#expand(f1) between 60 and 89=>'60-89',	
																													 (integer)left.#expand(f1) between 90 and 600=>'90-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_418(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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


EXPORT range_Function_419(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 39=>'1-39',	
																													 (integer)left.#expand(f1) between 40 and 49=>'40-49',	
																													 (integer)left.#expand(f1) between 50 and 99=>'50-99',	
																													 (integer)left.#expand(f1) between 100 and 139=>'100-139',	
																													 (integer)left.#expand(f1) between 140 and 600=>'140-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_420(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 29=>'1-29',	
																													 (integer)left.#expand(f1) between 30 and 44=>'30-44',	
																													 (integer)left.#expand(f1) between 45 and 64=>'45-64',	
																													 (integer)left.#expand(f1) between 65 and 109=>'65-109',	
																													 (integer)left.#expand(f1) between 110 and 600=>'110-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_421(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 24=>'1-24',	
																													 (integer)left.#expand(f1) between 25 and 39=>'25-39',	
																													 (integer)left.#expand(f1) between 40 and 59=>'40-59',	
																													 (integer)left.#expand(f1) between 60 and 79=>'60-79',	
																													 (integer)left.#expand(f1) between 80 and 600=>'80-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_422(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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
																													 (integer)left.#expand(f1) between 3 and 4=>'3-4',	
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


EXPORT range_Function_423(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 64=>'1-64',	
																													 (integer)left.#expand(f1) between 65 and 74=>'65-74',	
																													 (integer)left.#expand(f1) between 75 and 89=>'75-89',	
																													 (integer)left.#expand(f1) between 90 and 159=>'90-159',	
																													 (integer)left.#expand(f1) between 160 and 600=>'160-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_424(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 39=>'1-39',	
																													 (integer)left.#expand(f1) between 40 and 64=>'40-64',	
																													 (integer)left.#expand(f1) between 65 and 69=>'65-69',	
																													 (integer)left.#expand(f1) between 70 and 79=>'70-79',	
																													 (integer)left.#expand(f1) between 80 and 600=>'80-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_425(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 14=>'1-14',	
																													 (integer)left.#expand(f1) between 15 and 29=>'15-29',	
																													 (integer)left.#expand(f1) between 30 and 59=>'30-59',	
																													 (integer)left.#expand(f1) between 60 and 69=>'60-69',	
																													 (integer)left.#expand(f1) between 70 and 600=>'70-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_426(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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


EXPORT range_Function_427(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 79=>'1-79',	
																													 (integer)left.#expand(f1) between 80 and 119=>'80-119',	
																													 (integer)left.#expand(f1) between 120 and 139=>'120-139',	
																													 (integer)left.#expand(f1) between 140 and 164=>'140-164',	
																													 (integer)left.#expand(f1) between 165 and 600=>'165-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_428(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 24=>'1-24',	
																													 (integer)left.#expand(f1) between 25 and 44=>'25-44',	
																													 (integer)left.#expand(f1) between 45 and 89=>'45-89',	
																													 (integer)left.#expand(f1) between 90 and 119=>'90-119',	
																													 (integer)left.#expand(f1) between 120 and 600=>'120-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_429(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 20 and 34=>'20-34',	
																													 (integer)left.#expand(f1) between 35 and 59=>'35-59',	
																													 (integer)left.#expand(f1) between 60 and 99=>'60-99',	
																													 (integer)left.#expand(f1) between 100 and 600=>'100-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_430(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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


EXPORT range_Function_431(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 79=>'1-79',	
																													 (integer)left.#expand(f1) between 80 and 89=>'80-89',	
																													 (integer)left.#expand(f1) between 90 and 94=>'90-94',	
																													 (integer)left.#expand(f1) between 95 and 114=>'95-114',	
																													 (integer)left.#expand(f1) between 115 and 600=>'115-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_432(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 34=>'1-34',	
																													 (integer)left.#expand(f1) between 35 and 64=>'35-64',	
																													 (integer)left.#expand(f1) between 65 and 69=>'65-69',	
																													 (integer)left.#expand(f1) between 70 and 99=>'70-99',	
																													 (integer)left.#expand(f1) between 100 and 600=>'100-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_433(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 49=>'1-49',	
																													 (integer)left.#expand(f1) between 50 and 99=>'50-99',	
																													 (integer)left.#expand(f1) between 100 and 149=>'100-149',	
																													 (integer)left.#expand(f1) between 150 and 199=>'150-199',	
																													 (integer)left.#expand(f1) between 200 and 600=>'200-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_434(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 39=>'1-39',	
																													 (integer)left.#expand(f1) between 50 and 64=>'50-64',	
																													 (integer)left.#expand(f1) between 65 and 99=>'65-99',	
																													 (integer)left.#expand(f1) between 100 and 149=>'100-149',	
																													 (integer)left.#expand(f1) between 150 and 600=>'150-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_435(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 29=>'1-29',	
																													 (integer)left.#expand(f1) between 30 and 49=>'30-49',	
																													 (integer)left.#expand(f1) between 50 and 74=>'50-74',	
																													 (integer)left.#expand(f1) between 75 and 99=>'75-99',	
																													 (integer)left.#expand(f1) between 100 and 600=>'100-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_436(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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


EXPORT range_Function_437(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 69=>'1-69',	
																													 (integer)left.#expand(f1) between 70 and 119=>'70-119',	
																													 (integer)left.#expand(f1) between 120 and 134=>'120-134',	
																													 (integer)left.#expand(f1) between 135 and 159=>'135-159',	
																													 (integer)left.#expand(f1) between 160 and 600=>'160-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_438(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 59=>'1-59',	
																													 (integer)left.#expand(f1) between 60 and 99=>'60-99',	
																													 (integer)left.#expand(f1) between 100 and 129=>'100-129',	
																													 (integer)left.#expand(f1) between 130 and 149=>'130-149',	
																													 (integer)left.#expand(f1) between 150 and 600=>'150-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_439(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 24=>'1-24',	
																													 (integer)left.#expand(f1) between 25 and 49=>'25-49',	
																													 (integer)left.#expand(f1) between 50 and 79=>'50-79',	
																													 (integer)left.#expand(f1) between 80 and 89=>'90-89',	
																													 (integer)left.#expand(f1) between 90 and 600=>'90-600',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_440(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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


EXPORT range_Function_441(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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
																													 (integer)left.#expand(f1) between 3 and 4=>'3-4',	
																													 (integer)left.#expand(f1) between 5 and 999=>'5-999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_442(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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


EXPORT range_Function_443(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
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


EXPORT range_Function_444(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 50 and 99=>'50-99',	
																													 (integer)left.#expand(f1) between 100 and 199=>'100-199',	
																													 (integer)left.#expand(f1) between 200 and 499=>'200-499',	
																													 (integer)left.#expand(f1) between 500 and 99999999=>'500-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_445(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 39999=>'1-39999',	
																													 (integer)left.#expand(f1) between 40000 and 149999=>'40000-149999',	
																													 (integer)left.#expand(f1) between 150000 and 999999=>'150000-999999',	
																													 (integer)left.#expand(f1) between 1000000 and 99999999=>'1000000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_446(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 14999=>'1-14999',	
																													 (integer)left.#expand(f1) between 15000 and 29999=>'15000-29999',	
																													 (integer)left.#expand(f1) between 30000 and 69999=>'30000-69999',	
																													 (integer)left.#expand(f1) between 70000 and 179999=>'70000-179999',	
																													 (integer)left.#expand(f1) between 180000 and 99999999=>'180000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_447(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 40 and 99=>'40-99',	
																													 (integer)left.#expand(f1) between 100 and 179=>'100-179',	
																													 (integer)left.#expand(f1) between 180 and 399=>'180-399',	
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


EXPORT range_Function_448(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 249=>'0-249',	
																													 (integer)left.#expand(f1) between 250 and 999=>'250-999',	
																													 (integer)left.#expand(f1) between 1000 and 4999=>'1000-4999',	
																													 (integer)left.#expand(f1) between 5000 and 19999=>'5000-19999',	
																													 (integer)left.#expand(f1) between 20000 and 99999999=>'20000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_449(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 99999999=>'0-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_450(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 10000 and 19999=>'10000-19999',	
																													 (integer)left.#expand(f1) between 20000 and 99999999=>'20000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_451(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 4999=>'1-4999',	
																													 (integer)left.#expand(f1) between 5000 and 19999=>'5000-19999',	
																													 (integer)left.#expand(f1) between 20000 and 99999=>'20000-99999',	
																													 (integer)left.#expand(f1) between 100000 and 99999999=>'100000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_452(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 20 and 59=>'20-59',	
																													 (integer)left.#expand(f1) between 60 and 129=>'60-129',	
																													 (integer)left.#expand(f1) between 130 and 299=>'130-299',	
																													 (integer)left.#expand(f1) between 300 and 99999999=>'300-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_453(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 45 and 114=>'45-114',	
																													 (integer)left.#expand(f1) between 115 and 269=>'115-269',	
																													 (integer)left.#expand(f1) between 270 and 99999999=>'270-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_454(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 10 and 39=>'10-39',	
																													 (integer)left.#expand(f1) between 40 and 99=>'40-99',	
																													 (integer)left.#expand(f1) between 100 and 249=>'100-249',	
																													 (integer)left.#expand(f1) between 250 and 99999999=>'250-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_455(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 10 and 24=>'10-24',	
																													 (integer)left.#expand(f1) between 25 and 79=>'25-79',	
																													 (integer)left.#expand(f1) between 80 and 189=>'80-189',	
																													 (integer)left.#expand(f1) between 190 and 99999999=>'190-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_456(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 20 and 79=>'20-79',	
																													 (integer)left.#expand(f1) between 80 and 169=>'80-169',	
																													 (integer)left.#expand(f1) between 170 and 99999999=>'170-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_457(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 6 and 25=>'6-25',	
																													 (integer)left.#expand(f1) between 26 and 85=>'26-85',	
																													 (integer)left.#expand(f1) between 86 and 185=>'86-185',	
																													 (integer)left.#expand(f1) between 186 and 99999999=>'186-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_458(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 49999=>'1-49999',	
																													 (integer)left.#expand(f1) between 50000 and 199999=>'50000-199999',	
																													 (integer)left.#expand(f1) between 200000 and 999999=>'200000-999999',	
																													 (integer)left.#expand(f1) between 1000000 and 99999999=>'1000000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;



//***************************************//
//***************************************//


EXPORT range_Function_459(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 49999=>'1-49999',	
																													 (integer)left.#expand(f1) between 50000 and 199999=>'50000-199999',	
																													 (integer)left.#expand(f1) between 200000 and 749999=>'200000-749999',	
																													 (integer)left.#expand(f1) between 750000 and 99999999=>'750000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_460(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 34999=>'1-34999',	
																													 (integer)left.#expand(f1) between 35000 and 149999=>'35000-149999',	
																													 (integer)left.#expand(f1) between 150000 and 999999=>'150000-999999',	
																													 (integer)left.#expand(f1) between 1000000 and 99999999=>'1000000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_461(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 29999=>'1-29999',	
																													 (integer)left.#expand(f1) between 30000 and 149999=>'30000-149999',	
																													 (integer)left.#expand(f1) between 150000 and 799999=>'150000-799999',	
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


EXPORT range_Function_462(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 30000 and 149999=>'30000-149999',	
																													 (integer)left.#expand(f1) between 150000 and 799999=>'150000-799999',	
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


EXPORT range_Function_463(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 9999=>'1-9999',	
																													 (integer)left.#expand(f1) between 10000 and 39999=>'10000-39999',	
																													 (integer)left.#expand(f1) between 40000 and 99999=>'40000-99999',	
																													 (integer)left.#expand(f1) between 100000 and 99999999=>'100000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_464(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 99999999=>'0-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_465(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 6999=>'1-6999',	
																													 (integer)left.#expand(f1) between 7000 and 21999=>'7000-21999',	
																													 (integer)left.#expand(f1) between 22000 and 69999=>'22000-69999',	
																													 (integer)left.#expand(f1) between 70000 and 99999999=>'70000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_466(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 400 and 14999=>'400-14999',	
																													 (integer)left.#expand(f1) between 15000 and 59999=>'15000-59999',	
																													 (integer)left.#expand(f1) between 60000 and 99999999=>'60000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_467(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 50 and 1999=>'50-1999',	
																													 (integer)left.#expand(f1) between 2000 and 34999=>'2000-34999',	
																													 (integer)left.#expand(f1) between 35000 and 99999999=>'35000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_468(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 40 and 249=>'40-249',	
																													 (integer)left.#expand(f1) between 250 and 29999=>'250-29999',	
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


EXPORT range_Function_469(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 30 and 99=>'30-99',	
																													 (integer)left.#expand(f1) between 100 and 219=>'100-219',	
																													 (integer)left.#expand(f1) between 220 and 99999999=>'220-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_470(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 15 and 74=>'15-74',	
																													 (integer)left.#expand(f1) between 75 and 214=>'75-214',	
																													 (integer)left.#expand(f1) between 215 and 99999999=>'215-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_471(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 15 and 69=>'15-69',	
																													 (integer)left.#expand(f1) between 70 and 199=>'70-199',	
																													 (integer)left.#expand(f1) between 200 and 99999999=>'200-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_472(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 15 and 59=>'15-59',	
																													 (integer)left.#expand(f1) between 60 and 199=>'60-199',	
																													 (integer)left.#expand(f1) between 200 and 99999999=>'200-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_473(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 10 and 49=>'10-49',	
																													 (integer)left.#expand(f1) between 50 and 149=>'50-149',	
																													 (integer)left.#expand(f1) between 150 and 99999999=>'150-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_474(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 2999=>'0-2999',	
																													 (integer)left.#expand(f1) between 3000 and 6999=>'3000-6999',	
																													 (integer)left.#expand(f1) between 7000 and 19999=>'7000-19999',	
																													 (integer)left.#expand(f1) between 20000 and 79999=>'20000-79999',	
																													 (integer)left.#expand(f1) between 80000 and 99999999=>'80000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_475(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 199=>'0-199',	
																													 (integer)left.#expand(f1) between 200 and 599=>'200-599',	
																													 (integer)left.#expand(f1) between 600 and 4999=>'600-4999',	
																													 (integer)left.#expand(f1) between 5000 and 19999=>'5000-19999',	
																													 (integer)left.#expand(f1) between 20000 and 99999999=>'20000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_476(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 199=>'0-199',	
																													 (integer)left.#expand(f1) between 200 and 599=>'200-599',	
																													 (integer)left.#expand(f1) between 600 and 3999=>'600-3999',	
																													 (integer)left.#expand(f1) between 4000 and 19999=>'4000-19999',	
																													 (integer)left.#expand(f1) between 20000 and 99999999=>'20000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_477(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 199=>'0-199',	
																													 (integer)left.#expand(f1) between 200 and 499=>'200-499',	
																													 (integer)left.#expand(f1) between 600 and 3999=>'600-3999',	
																													 (integer)left.#expand(f1) between 4000 and 14999=>'4000-14999',	
																													 (integer)left.#expand(f1) between 15000 and 99999999=>'15000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_478(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 249=>'0-249',	
																													 (integer)left.#expand(f1) between 250 and 499=>'250-499',	
																													 (integer)left.#expand(f1) between 500 and 2999=>'500-2999',	
																													 (integer)left.#expand(f1) between 3000 and 12999=>'3000-12999',	
																													 (integer)left.#expand(f1) between 13000 and 99999999=>'13000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_479(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 100 and 499=>'100-499',	
																													 (integer)left.#expand(f1) between 500 and 1999=>'500-1999',	
																													 (integer)left.#expand(f1) between 2000 and 9999=>'2000-9999',	
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


EXPORT range_Function_480(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 99999999=>'0-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_481(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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


EXPORT range_Function_482(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 50 and 999=>'50-999',	
																													 (integer)left.#expand(f1) between 1000 and 12999=>'1000-12999',	
																													 (integer)left.#expand(f1) between 13000 and 99999999=>'13000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_483(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 15 and 99=>'15-99',	
																													 (integer)left.#expand(f1) between 100 and 6999=>'100-6999',	
																													 (integer)left.#expand(f1) between 7000 and 99999999=>'7000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_484(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 30 and 99=>'30-99',	
																													 (integer)left.#expand(f1) between 100 and 249=>'100-249',	
																													 (integer)left.#expand(f1) between 250 and 99999999=>'250-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_485(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 25 and 89=>'25-89',	
																													 (integer)left.#expand(f1) between 99 and 199=>'99-199',	
																													 (integer)left.#expand(f1) between 200 and 99999999=>'200-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_486(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 0 and 199=>'0-199',	
																													 (integer)left.#expand(f1) between 200 and 3999=>'200-3999',	
																													 (integer)left.#expand(f1) between 4000 and 9999=>'4000-9999',	
																													 (integer)left.#expand(f1) between 10000 and 34999=>'10000-34999',	
																													 (integer)left.#expand(f1) between 35000 and 99999999=>'35000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_487(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 3999=>'1-3999',	
																													 (integer)left.#expand(f1) between 4000 and 11999=>'4000-11999',	
																													 (integer)left.#expand(f1) between 12000 and 59999=>'12000-59999',	
																													 (integer)left.#expand(f1) between 60000 and 99999999=>'60000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_488(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 3999=>'1-3999',	
																													 (integer)left.#expand(f1) between 4000 and 12999=>'4000-12999',	
																													 (integer)left.#expand(f1) between 13000 and 54999=>'13000-54999',	
																													 (integer)left.#expand(f1) between 55000 and 99999999=>'55000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_489(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 3999=>'1-3999',	
																													 (integer)left.#expand(f1) between 4000 and 12999=>'4000-12999',	
																													 (integer)left.#expand(f1) between 13000 and 99999=>'13000-99999',	
																													 (integer)left.#expand(f1) between 100000 and 99999999=>'100000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_490(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 1 and 74=>'1-74',	
																													 (integer)left.#expand(f1) between 75 and 7999=>'75-7999',	
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


EXPORT range_Function_491(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 30 and 349=>'30-349',	
																													 (integer)left.#expand(f1) between 350 and 9999=>'350-9999',	
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


EXPORT range_Function_492(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 30 and 149=>'30-149',	
																													 (integer)left.#expand(f1) between 150 and 3999=>'150-3999',	
																													 (integer)left.#expand(f1) between 4000 and 99999999=>'4000-99999999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_493(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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


EXPORT range_Function_494(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 3 and 4=>'3-4',	
																													 (integer)left.#expand(f1) between 5 and 999=>'5-999',	
																															 'UNDEFINED'),
																															  'UNDEFINED'
																																 );     
																																							
				
		 ));

		#uniquename(rc_tab)
		%rc_tab% := RECORD
			%Bks_project%.field_name;
			%Bks_project%.category;
			%Bks_project%.distribution_type;
			%Bks_project%.attribute_value ;
			decimal20_4 frequency := count(group);
		END;

		RETURN table(%Bks_project%,%rc_tab%,field_name,category,distribution_type,attribute_value);

ENDMACRO;


//***************************************//
//***************************************//


EXPORT range_Function_495(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 3 and 4=>'3-4',	
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


EXPORT range_Function_496(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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
																													 (integer)left.#expand(f1) between 2 and 3=>'2-3',	
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


EXPORT range_Function_497(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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


EXPORT range_Function_498(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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


EXPORT range_Function_499(DS,f1,cname) := FUNCTIONMACRO

		#uniquename(tble)
		%tble% := table(ds);

		#uniquename(cnt)
		%cnt% := count(%tble%);

		#uniquename(rc)
		%rc% := RECORD
			string100 field_name;
			string100 category := cname;
			string30 distribution_type ;
			string50 attribute_value ;
		END;
									
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

END;