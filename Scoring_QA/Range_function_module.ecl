EXPORT Range_function_module := module

EXPORT Range_Average_Function_0(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
decimal20_4 Count1 ;
end;

#uniquename(filter1)
%filter1% := %tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<=-2 and (integer)#expand(f1)>=-9999999999);

 #uniquename(ave1)
   %ave1% := ave(%filter1%,(decimal20_4)%filter1%.#expand(f1));
   
   #uniquename(filter2)

%filter2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=0 and (integer)#expand(f1)<=9999999999);

 #uniquename(ave2)
   %ave2% := ave(%filter2%,(decimal20_4)%filter2%.#expand(f1));
   
   #uniquename(filter3)
%filter3% := %tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)= -1);

 #uniquename(ave3)
   %ave3% := ave(%filter3%,(decimal20_4)%filter3%.#expand(f1));
   
   							
   #uniquename(Bks_project)
   %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                   self.field_name:=f1;
                                                   self.distribution_type := 'average';
   																				        self.attribute_value := MAP((integer)left.#expand(f1) between -9999999999 and -2 => '(-9999999999 )-(-2)',
   																																		 (integer)left.#expand(f1) between 0 and 9999999999 and length(trim(left.#expand(f1),left,right))<> 0=> '0-9999999999',
                                                                       '-1');
   																								self.Count1 := MAP(
                                                                        (integer)left.#expand(f1) between -9999999999 and -2 => %ave1%,
   																																		 (integer)left.#expand(f1) between 0 and 9999999999 and length(trim(left.#expand(f1),left,right))<> 0=> %ave2%,
                                                                       %ave3%);										
   		
    ));


#uniquename(dd)
%dd% := dedup( %Bks_project%,all);


result := %dd%;

endmacro;

EXPORT Range_Average_Function_1(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
decimal20_4 Count1 ;
end;

#uniquename(filter1)
%filter1% := %tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<=-2 and (integer)#expand(f1)>=-200);

 #uniquename(ave1)
   %ave1% := ave(%filter1%,(decimal20_4)%filter1%.#expand(f1));
   
   #uniquename(filter2)

%filter2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=0 and (integer)#expand(f1)<=200);

 #uniquename(ave2)
   %ave2% := ave(%filter2%,(decimal20_4)%filter2%.#expand(f1));
   
   #uniquename(filter3)
%filter3% := %tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)= -1);

 #uniquename(ave3)
   %ave3% := ave(%filter3%,(decimal20_4)%filter3%.#expand(f1));
   
   		
   							
   #uniquename(Bks_project)
   %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                   self.field_name:=f1;
                                                   self.distribution_type := 'average';
   																				        self.attribute_value := MAP((integer)left.#expand(f1) between -200 and -2 => '(-200 )-(-2)',
   																																		 (integer)left.#expand(f1) between 0 and 200 and length(trim(left.#expand(f1),left,right))<> 0 => '0-200',
                                                                       'UNDEFINED');
   																								self.Count1 := MAP(
                                                                       (integer)left.#expand(f1) between -200 and -2 => %ave1%,
   																																		 (integer)left.#expand(f1) between 0 and 200 and length(trim(left.#expand(f1),left,right))<> 0 => %ave2%,
                                                                       %ave3%);										
   		
    ));


#uniquename(dd)
%dd% := dedup( %Bks_project%,all);


result := %dd%;

endmacro;
EXPORT Range_Average_Function_2(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
decimal20_4 Count1 ;
end;

#uniquename(filter1)
%filter1% := %tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<=-2 and (integer)#expand(f1)>=-9999999999);

 #uniquename(ave1)
   %ave1% := ave(%filter1%,(decimal20_4)%filter1%.#expand(f1));
   
   #uniquename(filter2)

%filter2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=0 and (integer)#expand(f1)<=9999999999);

 #uniquename(ave2)
   %ave2% := ave(%filter2%,(decimal20_4)%filter2%.#expand(f1));
   
   #uniquename(filter3)
%filter3% := %tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)= -1);

 #uniquename(ave3)
   %ave3% := ave(%filter3%,(decimal20_4)%filter3%.#expand(f1));
   
   							
   #uniquename(Bks_project)
   %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                   self.field_name:=f1;
                                                   self.distribution_type := 'average';
   																				        self.attribute_value := MAP((integer)left.#expand(f1) between -9999999999 and 2 => '(-9999999999 )-(2)',
   																																		 (integer)left.#expand(f1) between 0 and 9999999999 and length(trim(left.#expand(f1),left,right))<> 0=> '0-9999999999',
                                                                       'UNDEFINED');
   																								self.Count1 := MAP(
                                                                        (integer)left.#expand(f1) between -9999999999 and 2 => %ave1%,
   																																		 (integer)left.#expand(f1) between 0 and 9999999999 and length(trim(left.#expand(f1),left,right))<> 0 => %ave2%,
                                                                       %ave3%);										
   		
    ));


#uniquename(dd)
%dd% := dedup( %Bks_project%,all);


result := %dd%;

endmacro;
EXPORT Range_Average_Function_3(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
decimal20_4 Count1 ;
end;

#uniquename(filter1)
%filter1% := %tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<=-2 and (integer)#expand(f1)>=-9999999999);

 #uniquename(ave1)
   %ave1% := ave(%filter1%,(decimal20_4)%filter1%.#expand(f1));
   
   #uniquename(filter2)

%filter2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=0 and (integer)#expand(f1)<=9999999999);

 #uniquename(ave2)
   %ave2% := ave(%filter2%,(decimal20_4)%filter2%.#expand(f1));
   
   

   
   							
   #uniquename(Bks_project)
   %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                   self.field_name:=f1;
                                                   self.distribution_type := 'average';
   																				        self.attribute_value := MAP(
   																																		(integer)left.#expand(f1) between 0 and 9999999999 and length(trim(left.#expand(f1),left,right))<> 0=> '0-9999999999',
                                                                       'UNDEFINED');
   																								self.Count1 := MAP(
                                                                    
   																																		(integer)left.#expand(f1) between 0 and 9999999999 and length(trim(left.#expand(f1),left,right))<> 0=> %ave2%,
                                                                       %ave1%);										
   		
    ));


#uniquename(dd)
%dd% := dedup( %Bks_project%,all);


result := %dd%;

endmacro;

EXPORT Range_func(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 101 and 150 => '101-150',
                                                                     (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																		 (integer)left.#expand(f1) between 200 and 250 => '200-250',
                                                                     (integer)left.#expand(f1) between 251 and 300 => '251-300',
																																		 (integer)left.#expand(f1) between 300 and 350 => '300-350',
                                                                     (integer)left.#expand(f1) between 351 and 400 => '351-400',
																																		 (integer)left.#expand(f1) between 400 and 450 => '400-450',
                                                                     (integer)left.#expand(f1) between 451 and 500 => '451-500',
																																		 (integer)left.#expand(f1) between 500 and 550 => '500-550',
                                                                     (integer)left.#expand(f1) between 551 and 600 => '551-600',
																																		 (integer)left.#expand(f1) between 600 and 650 => '600-650',
                                                                     (integer)left.#expand(f1) between 651 and 700 => '651-700',
																																		 (integer)left.#expand(f1) between 700 and 750 => '700-750',
                                                                     (integer)left.#expand(f1) between 751 and 800 => '751-800',
																																		 (integer)left.#expand(f1) between 800 and 850 => '800-850',
                                                                     (integer)left.#expand(f1) between 851 and 900 => '851-900',
																																		 (integer)left.#expand(f1) between 900 and 950 => '900-950',
                                                                     (integer)left.#expand(f1) between 951 and 960 => '951-960',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_0(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 101 and 150 => '101-150',
                                                                     (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																		 (integer)left.#expand(f1) between 200 and 250 => '200-250',
                                                                     (integer)left.#expand(f1) between 251 and 255 => '251-255',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_1(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
string50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1)= -1 => '-1',   
																								(real)left.#expand(f1)= 0 => '0', 
																																		 (real)left.#expand(f1) between 0.1 and 0.9 => '0.1-0.9',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.1 and 99 => '1.1-99',
                                                                
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					  
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;
result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_10(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		   (integer)left.#expand(f1)= 0 => '0', 
                                                                       (integer)left.#expand(f1) = 1  => 1,
																																		   (integer)left.#expand(f1) between 3 and 7 => '3_7',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_11(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1)= 1 => '1',
                                                                     (integer)left.#expand(f1) != 1 and length(trim(left.#expand(f1),left,right))<> 0=> '!1',
																																		   	           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_12(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			 (integer)left.#expand(f1)= 0 => '0', 
																							                       	 (integer)left.#expand(f1)= 10=> '10',
																																		   (integer)left.#expand(f1) between 600 and 700 => '600-700',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_13(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
                                                                     (integer)left.#expand(f1) between 1 and 7=> '1_7',
																																		 
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_14(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																							                     	 (integer)left.#expand(f1)= 8 => '8',
                                                                     (integer)left.#expand(f1) != 8 and length(trim(left.#expand(f1),left,right))<> 0 => '!8',
																																		   
																																	         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_15(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			(integer)left.#expand(f1)= 0 => '0', 
                                                                      (integer)left.#expand(f1) = 1  => '1',
																																		  (integer)left.#expand(f1) = 2  => '2',
																																			(integer)left.#expand(f1) = -1  => '-1',
																																		  (integer)left.#expand(f1) between 3 and 960 => '3+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_16(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 60 and length(trim(left.#expand(f1),left,right))<> 0=> '0-60',
                                                                     (integer)left.#expand(f1) between 61 and 120 => '61-120',
																																		 (integer)left.#expand(f1) between 121 and 180 => '121-180',
                                                                     (integer)left.#expand(f1) between 181 and 240 => '181-240',
																																		 (integer)left.#expand(f1) between 241 and 300 => '241-300',
                                                                     (integer)left.#expand(f1) between 301 and 360 => '301-360',
																																		 (integer)left.#expand(f1) between 361 and 420 => '361-420',
                                                                     (integer)left.#expand(f1) between 421 and 480 => '421-480',
																																		 (integer)left.#expand(f1) between 480 and 960 => '480+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_17(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 12 and length(trim(left.#expand(f1),left,right))<> 0=> '0-12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 960 => '25+',
                                                                 
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_18(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 24 and length(trim(left.#expand(f1),left,right))<> 0=> '0-24',
                                                                     (integer)left.#expand(f1) between 25 and 48 => '25-48',
																																		 (integer)left.#expand(f1) between 49 and 960 => '49+',
                                                                   
																																                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_19(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 12 and length(trim(left.#expand(f1),left,right))<> 0=> '0-12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 36 => '25-36',
                                                                     (integer)left.#expand(f1) between 37 and 48 => '37-48',
																																		 (integer)left.#expand(f1) between 49 and 60 => '49-60',
																																		 (integer)left.#expand(f1) between 61 and 960 => '61+',
																																                                                                   
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_2(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1) between 1 and 50 => '1_50',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 101 and 150 => '101-150',
                                                                     (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																		 (integer)left.#expand(f1) between 201 and 250 => '201-250',
                                                                     (integer)left.#expand(f1) between 251 and 255 => '251-255',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_20(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 12 and length(trim(left.#expand(f1),left,right))<> 0=> '0-12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 36 => '25-36',
                                                                     (integer)left.#expand(f1) between 37 and 48 => '37-48',
																																		 (integer)left.#expand(f1) between 49 and 60 => '49-60',
                                                                     (integer)left.#expand(f1) between 61 and 120 => '61-120',
																																		 (integer)left.#expand(f1) between 121 and 180 => '121-180',
                                                                     (integer)left.#expand(f1) between 181 and 240 => '181-240',
																																		 (integer)left.#expand(f1) between 241 and 960 => '241+',
                                                                    
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_21(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																							                     	 (integer)left.#expand(f1)=-1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 24 and length(trim(left.#expand(f1),left,right))<> 0=> '0-24',
                                                                     (integer)left.#expand(f1) between 25 and 48 => '25-48',
																																		 (integer)left.#expand(f1) between 49 and 72 => '49-72',
                                                                     (integer)left.#expand(f1) between 73 and 96 => '73-96',
																																		 (integer)left.#expand(f1) between 97 and 120 => '97-120',
                                                                     (integer)left.#expand(f1) between 121 and 144 => '121-144',
																																		 (integer)left.#expand(f1) between 145 and 168 => '145-168',
                                                                     (integer)left.#expand(f1) between 169 and 192 => '169-192',
																																		 (integer)left.#expand(f1) between 193 and 216 => '193-216',
																																		 (integer)left.#expand(f1) between 217 and 240 => '217-240',
																																		 (integer)left.#expand(f1) between 241 and 960 => '241+',
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_22(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 10 and length(trim(left.#expand(f1),left,right))<> 0=> '0-10',
                                                                     (integer)left.#expand(f1) between 11 and 20 => '11_20',
																																		 (integer)left.#expand(f1) between 21 and 30=> '21-30',
                                                                     (integer)left.#expand(f1) between 31 and 40 => '31-40',
																																		 (integer)left.#expand(f1) between 41 and 50 => '41-50',
                                                                     (integer)left.#expand(f1) between 51 and 60 => '51-60',
																																		 (integer)left.#expand(f1) between 61 and 70 => '61-70',
                                                                     (integer)left.#expand(f1) between 71 and 80 => '71-80',
																																		 (integer)left.#expand(f1) between 81 and 90 => '81-90',
																																		 (integer)left.#expand(f1) between 91 and 100 => '91-100',
																																		
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_23(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					         (integer)left.#expand(f1)= 0 => '0', 
																																		 
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_24(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1) between 1 and 12 => '1_12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 36=> '25-36',
                                                                     (integer)left.#expand(f1) between 31 and 40=> '31-40',
																																		 (integer)left.#expand(f1) between 37 and 120 => '37+',
                                                                    
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_25(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			(integer)left.#expand(f1)= 0 => '0', 
																							                      	(integer)left.#expand(f1)= -1 => '-1',
                                                                      (integer)left.#expand(f1) = 1  => '1',
																																		  (integer)left.#expand(f1) between 2 and 255 => '2+',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_25a(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			(integer)left.#expand(f1)= 0 => '0', 
																							                      	(integer)left.#expand(f1)= -1 => '-1',
                                                                      (integer)left.#expand(f1) = 1  => '1',
																																		  (integer)left.#expand(f1) between 2 and 960 => '2+',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_26(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			 (integer)left.#expand(f1)= 0 => '0',   
																							                         (integer)left.#expand(f1)= -1 => '-1',	
																																		   (integer)left.#expand(f1) between 1 and 84 => '1+',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_27(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)=-1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 12 and length(trim(left.#expand(f1),left,right))<> 0=> '0_12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 36=> '25-36',
                                                                     (integer)left.#expand(f1) between 37 and 48=> '37-48',
																																		 (integer)left.#expand(f1) between 49 and 60 => '49-60',
																																		 (integer)left.#expand(f1) between 61 and 960 => '61+',
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_28(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			 (integer)left.#expand(f1)= 0 => '0',  						
																																		   (integer)left.#expand(f1) between 1 and 99999999 => '1+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_29(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1=> '-1',
																								                     (integer)left.#expand(f1) between 0 and 20 and length(trim(left.#expand(f1),left,right))<> 0=> '0-20',
                                                                     (integer)left.#expand(f1) between 21 and 30 => '21-30',
																																		 (integer)left.#expand(f1) between 31 and 40=> '31-40',
                                                                     (integer)left.#expand(f1) between 41 and 50 => '41-50',
																																		 (integer)left.#expand(f1) between 51 and 60 => '51-60',
																																		 (integer)left.#expand(f1) between 61 and 80 => '61-80',
																																		 (integer)left.#expand(f1) between 81 and 960 => '81+',
                                                                    
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT Range_Function_3(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
string50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
                                                                     (integer)left.#expand(f1) between 0 and 84 and length(trim(left.#expand(f1),left,right))<> 0=> '0-84',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_30(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1) between 0 and 5 and length(trim(left.#expand(f1),left,right))<> 0=> '0-5',
                                                                     (integer)left.#expand(f1) between 6 and 10 => '6_10',
																																		 (integer)left.#expand(f1) between 11 and 15=> '11_15',
                                                                     (integer)left.#expand(f1) between 16 and 20 => '16-20',
																																		 (integer)left.#expand(f1) between 21 and 25 => '21-25',
																																		 (integer)left.#expand(f1) between 26 and 30 => '26-30',
																																		 (integer)left.#expand(f1) between 31 and 35 => '31-35',
																																		 (integer)left.#expand(f1) between 36 and 40=> '36-40',
                                                                  	 (integer)left.#expand(f1) between 41 and 255 => '41+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_31(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					     (integer)left.#expand(f1)= 0 => '0',   
                                                                     				   (integer)left.#expand(f1) between 1 and 255 => '1+',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_31a(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					     (integer)left.#expand(f1)= 0 => '0',   
																																					     (integer)left.#expand(f1)= -1 => '-1',   
                                                                     				   (integer)left.#expand(f1) between 1 and 255 => '1+',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_32(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1) between 0 and 5 and length(trim(left.#expand(f1),left,right))<> 0=> '0-5',
                                                                     (integer)left.#expand(f1) between 6 and 10 => '6_10',
																																		 (integer)left.#expand(f1) between 11 and 15=> '11_15',
                                                                     (integer)left.#expand(f1) between 16 and 255 => '16+',
																																		
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_33(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1) between 0 and 5 and length(trim(left.#expand(f1),left,right))<> 0=> '0-5',
                                                                     (integer)left.#expand(f1) between 6 and 10 => '6_10',
																																		 (integer)left.#expand(f1) between 11 and 255=> '11+',
                                                                    
																																		
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_34(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																				(integer)left.#expand(f1)= 0 => '0',   
																								                        (integer)left.#expand(f1) =-1 => '-1',																																				
																								                        (integer)left.#expand(f1) = 2011 => '2011',
                                                                        (integer)left.#expand(f1) = 2012 => '2012',
																																		    (integer)left.#expand(f1) = 2013  => '2013',
																																			  (integer)left.#expand(f1) = 2014 => '2014',
                                                                        (integer)left.#expand(f1) = 2015 => '2015',
																																		    (integer)left.#expand(f1) = 2016  => '2016',
																																			  (integer)left.#expand(f1) = 2017  => '2017',
																																		    (integer)left.#expand(f1) = 2018  => '2018',
																																		    (integer)left.#expand(f1)<= 2010 and length(trim(left.#expand(f1),left,right))<> 0  => '2010_and_less',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_35(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = -1  => '-1',
																																		 (integer)left.#expand(f1) between 1 and 999999999 => '1+',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_36(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1) = 3  => '3',
                                                                     (integer)left.#expand(f1) = 4  => '4',
																																		 (integer)left.#expand(f1) = 5  => '5',
																																		 (integer)left.#expand(f1) = 6  => '6',
                                                                     (integer)left.#expand(f1) = 7  => '7',
																																		 (integer)left.#expand(f1) = 8  => '8',																														 
																																		 (integer)left.#expand(f1) between 9 and 255 => '9+',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_37(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1) = 3  => '3',                                                                     																										 
																																		 (integer)left.#expand(f1) between 4 and 255 => '4+',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_38(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1) = 3  => '3',    
																																		 (integer)left.#expand(f1) = 4 => '4',   
																																		 (integer)left.#expand(f1) between 5 and 255 => '5+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_39(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1) = 3  => '3',    
																																		 (integer)left.#expand(f1)= 4  => '4',   
																																		 (integer)left.#expand(f1)= 5  => '5',    
																																		 (integer)left.#expand(f1)= 6  => '6',  
																																		 (integer)left.#expand(f1) between 7 and 255 => '7+',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_4(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
//string file_version;
string field_name;
string distribution_type ;
string50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																							                       (integer)left.#expand(f1)= -1 => '-1',
                                                                     (integer)left.#expand(f1) between 0 and 120 and length(trim(left.#expand(f1),left,right))<> 0=> '0-120',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
//%Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_40(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = -1 => '-1',
																																		 (integer)left.#expand(f1) between 1 and 255 => '1+',
																																	         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_41(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					         (integer)left.#expand(f1)= 0 => '0',   
																								(integer)left.#expand(f1) < 20000 and length(trim(left.#expand(f1),left,right))<> 0 => '<20000',
                                                                     (integer)left.#expand(f1) between 20001 and 40000 => '20001-40000',
																																		 (integer)left.#expand(f1) between 40001 and 60000 => '40001-60000',
                                                                     (integer)left.#expand(f1) between 60001 and 80000=> '60001-80000',
																																		 (integer)left.#expand(f1) > 80000  and length(trim(left.#expand(f1),left,right))<> 0  => '80000+',
																																                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_42(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																									(integer)left.#expand(f1) = -1 => '-1',
																								(integer)left.#expand(f1) between 0 and 12 and length(trim(left.#expand(f1),left,right))<> 0=> '0-12',
																								                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
                                                                     (integer)left.#expand(f1) between 25 and 36 => '25-36',
																																		 (integer)left.#expand(f1) between 37 and 48=> '37-48',
                                                                     (integer)left.#expand(f1) between 49 and 60 => '49-60',
																																		 (integer)left.#expand(f1) between 61 and 72 => '61-72',
																																		 (integer)left.#expand(f1) between 73 and 84 => '73-84',
																																		 (integer)left.#expand(f1) between 85 and 96 => '85-96',
																																		 (integer)left.#expand(f1) between 97 and 108=> '97-108',
                                                                  	 (integer)left.#expand(f1) between 109 and 120=> '109-120',
																																		 (integer)left.#expand(f1) between 121 and 960 => '121+',
																																		 
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_43(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1)= 3 => '3',
																																		 (integer)left.#expand(f1)= 4 => '4',
                                                                     (integer)left.#expand(f1) = 5  => '5',																																
																																		 (integer)left.#expand(f1) between 6 and 255 => '6+',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_44(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_45(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1)= 3 => '3',
																																		 (integer)left.#expand(f1)= 4 => '4',
                                                                     (integer)left.#expand(f1) = 5  => '5',
																																		 (integer)left.#expand(f1)= 6 => '6',
                                                                     (integer)left.#expand(f1) = 7  => '7',
																																		 (integer)left.#expand(f1) = 8  => '8',																																		 
																																		 (integer)left.#expand(f1)= 9 => '9',
																											        			 (integer)left.#expand(f1) between 10 and 255  => '10+',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_46(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1 => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1)= 3 => '3',
																																		 (integer)left.#expand(f1)= 4 => '4',                                                                   
																																		 (integer)left.#expand(f1) between 5 and 255  => '5+',
																																	         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_47(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;

 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			 (integer)left.#expand(f1)= 0 => '0',   
																								                       (integer)left.#expand(f1)= -1 => '-1',																								                   
                                                                       (integer)left.#expand(f1) = 1  => '1',
																																		   (integer)left.#expand(f1) = 2  => '2',
																																			 (integer)left.#expand(f1) = 3  => '3',
																																		   (integer)left.#expand(f1) between 4 and 255 => '4+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_48(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		   (integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_5(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 101 and 150 => '101-150',
                                                                     (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																		
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_50(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 24 and length(trim(left.#expand(f1),left,right))<> 0=> '0-24',
                                                                     (integer)left.#expand(f1) between 25 and 48 => '25-48',
																																		 (integer)left.#expand(f1) between 49 and 96 => '49-96',
                                                                     (integer)left.#expand(f1) between 97 and 144 => '97-144',
																																		 (integer)left.#expand(f1) between 145 and 960 => '145+',
                                                                   
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_51(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',
																																		 (integer)left.#expand(f1) = -1 => '-1',
																																		 (integer)left.#expand(f1) between 3 and 255 => '3+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_52(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 60 and length(trim(left.#expand(f1),left,right))<> 0 => '0-60',
                                                                     (integer)left.#expand(f1) between 61 and 120 => '61-120',
																																		 (integer)left.#expand(f1) between 121 and 180 => '121-180',
                                                                     (integer)left.#expand(f1) between 181 and 240 => '181-240',
																																		 (integer)left.#expand(f1) between 241 and 300 => '241-300',
                                                                     (integer)left.#expand(f1) between 301 and 360 => '301-360',
																																		 (integer)left.#expand(f1) between 361 and 420 => '361-420',
                                                                     (integer)left.#expand(f1) between 421 and 480 => '421-480',
																																		 (integer)left.#expand(f1) between 480 and 960=> '480+',
                                                                		 (integer)left.#expand(f1) = -1  => '-1',
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_53(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 1 and 12 => '1_12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 36=> '25-36',
                                                                   	 (integer)left.#expand(f1) between 37 and 120 => '37+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_54(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					         (integer)left.#expand(f1)= 0 => '0',   
																								                                   (integer)left.#expand(f1)= -1=> '-1',
                                                                 
																																		 
																																         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_55(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		  (integer)left.#expand(f1)= 0 => '0',   
																								                      (integer)left.#expand(f1)= -1 => '-1',                                                                 
																																		  (integer)left.#expand(f1) = 1  => '1',
																																			(integer)left.#expand(f1)= 2=> '2',
                                                                      (integer)left.#expand(f1) = 3 => '3',
																																		  (integer)left.#expand(f1) = 4 => '4',
																																			(integer)left.#expand(f1) = 5  => '5',
																																		  (integer)left.#expand(f1) = 6  => '6',
																																		
																																	         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_56(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			(integer)left.#expand(f1)= 0 => '0',   
																								                      (integer)left.#expand(f1)= -1=> '-1',                                                                 
																																		  (integer)left.#expand(f1) = 1  => '1',
																																	
																																		
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_57(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                   	 (integer)left.#expand(f1) = -1 => '-1',
																								(integer)left.#expand(f1) between 0 and 24 and length(trim(left.#expand(f1),left,right))<> 0 => '0-24',
																								                     (integer)left.#expand(f1) between 25 and 48 => '25-48',
                                                                     (integer)left.#expand(f1) between 49 and 72 => '49-72',
																																		 (integer)left.#expand(f1) between 79 and 96=> '79-96',
                                                                     (integer)left.#expand(f1) between 97 and 120 => '97-120',
																																		 (integer)left.#expand(f1) between 121 and 960 => '121+',
																																		 
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_58(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)=-1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 101 and 125=> '101-125',
                                                                     (integer)left.#expand(f1) between 126 and 150 => '126-150',
																																		 (integer)left.#expand(f1) between 151 and 175 => '151-175',
																																		 (integer)left.#expand(f1) between 175 and 200 => '175-200',
                                                                     (integer)left.#expand(f1) between 201 and 960 => '201+',
                                                                       'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_59(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					         (integer)left.#expand(f1)= 0 => '0',   
																								                                   (integer)left.#expand(f1)= -1 => '-1',                                                                    
																															
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT Range_Function_6(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
//string file_version;
string field_name;
string distribution_type ;
string50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
                                                                     (integer)left.#expand(f1) between 0 and 200 and length(trim(left.#expand(f1),left,right))<> 0 => '0-200',
																																		 (integer)left.#expand(f1) between -200 and -2 => '(-200)-(-2)',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
//%Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_60(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)=-1 => '-1',																								                            
																								                     (integer)left.#expand(f1) between 1 and 5 => '1_5',
                                                                     (integer)left.#expand(f1) between 6 and 10 => '6_10',
																																		 (integer)left.#expand(f1) between 11 and 15=> '11_15',
                                                                     (integer)left.#expand(f1) between 16 and 255 => '16+',
																																		
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_61(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					         (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)=-1 => '-1',																								                     
																								                     (integer)left.#expand(f1) between 1 and 5=> '1_5',
                                                                     (integer)left.#expand(f1) between 6 and 10 => '6_10',
																																		 (integer)left.#expand(f1) between 11 and 255=> '11+',
                                                                  
																																		
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_62(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 12 => '1_12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 84 => '25+',
                                                                    
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_63(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 100 and 960 => '100+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_64(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 101 and 150=> '101-150',
                                                                  	 (integer)left.#expand(f1) between 151 and 960 => '151+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_65(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                              (integer)left.#expand(f1)= -1 => '-1',
																					  (integer)left.#expand(f1) between 0 and 149999 and length(trim(left.#expand(f1),left,right))<> 0=> '0-149,999',
                                                                     (integer)left.#expand(f1) between 150000 and 249000 => '150,000-249,000',
																																		 (integer)left.#expand(f1) between 250000 and 499999=> '250,000-499,999',
                                                                     (integer)left.#expand(f1) between 500000 and 100000000000 => '500,000+',
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_66(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 5 and length(trim(left.#expand(f1),left,right))<> 0 => '0-5',
                                                                     (integer)left.#expand(f1) between 6 and 960=> '5+',
																																		
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_67(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 99 and length(trim(left.#expand(f1),left,right))<> 0=> '0-99',
                                                                     (integer)left.#expand(f1) between 100 and 199=> '100-199',
																																		 (integer)left.#expand(f1) between 200 and 960=> '200+',
                                                                   
                                                                    
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_68(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																					         
																								                     (integer)left.#expand(f1)= -1 => '-1',
																							      (integer)left.#expand(f1) between 0 and 100000 and length(trim(left.#expand(f1),left,right))<> 0=> '0-100,000',
                                                                     (integer)left.#expand(f1) between 100001 and 300000 => '100,001-300,000',
																																		 (integer)left.#expand(f1) between 300001 and 100000000000 => '300,000+',
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					;
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_69(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							

 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',	
																							                     	 (integer)left.#expand(f1)= -1 => '-1',																								                            
																								                     (integer)left.#expand(f1) between 1 and 5=> '1_5',
                                                                     (integer)left.#expand(f1) between 6 and 288 => '6+',
																																		
                                                                    
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_7(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																								(integer)left.#expand(f1)= 0 and length(trim(left.#expand(f1),left,right))<> 0=> '0',
                                                                     (integer)left.#expand(f1) between 1 and 255 => '1_255',
																																		 
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



EXPORT range_function_70(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 251 and length(trim(left.#expand(f1),left,right))<> 0=> '0-251',
                                                                     (integer)left.#expand(f1) between 251 and 301 => '251-301',
																																		 (integer)left.#expand(f1) between 301 and 351=> '301-351',
                                                                     (integer)left.#expand(f1) between 351 and 401 => '351-401',
																																		 (integer)left.#expand(f1) between 401 and 451 => '401-451',
																																		 (integer)left.#expand(f1) between 451 and 501 => '451-501',
																																		 (integer)left.#expand(f1) between 501 and 551=> '501-551',
                                                                     (integer)left.#expand(f1) between 551 and 601 => '551-601',
																																		 (integer)left.#expand(f1) between 600 and 960 => '600+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_8(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) between 1 and 9 => '1_9',
																																		 
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_9(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) != 0  and length(trim(left.#expand(f1),left,right))<> 0=> '!0',
																																		 
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT count_function(file,f1,result) := macro



/*  lay:=record
      
      file.f1;
      integer freq:=count(group);
      end;
      
      result1:= table(file,lay,f1);
*/
	 
	


  #uniquename(tble)
         %tble% := table(file);
         
         #uniquename(lay)
      
              %lay%:=record
      				   	   string attribute:='<'+ trim(%tble%.#expand(f1),left,right)+'>';
         		    		 integer field_frequency:=count(group);
         		      	 end;
          #uniquename(result1)
         	 %result1%:=table(%tble%,%lay%,#expand(f1));

   		 

   
 #uniquename(rc)
%rc% := record
string field_name;
STRING50 attribute_value;
integer count1;
end;
                                      #uniquename(func)
                                       %rc% %func%(%result1% l):=TRANSFORM
                                                self.field_name:=f1;
                                                self.attribute_value :=l.attribute;
																								self.count1:=l.field_frequency;
																								
																					end;			
							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%result1%,%func%((integer)left));
		
					 
   									 
   									 result:=%Bks_project%;

	 
	 endmacro;
	 
	 EXPORT Distinct_function(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 // #uniquename(a2)
 // %a2% :=%tble%(#expand(f1)<>'-1');
 


 #uniquename(rc)
   %rc% := record
   // string file_version:='fcra_rvattributes_v4';
   // string field_name:=f1;
   // string distribution_type:='DISTINCT';
   STRING attribute_value_1:=(string)%tble%.#expand(f1);
  decimal20_4 Count_1 := count(group);
   end;
   
  #uniquename(a3)
%a3% := table(%tble%,%rc%,%tble%.#expand(f1));


 #uniquename(a4)
   %a4% := record
   // string file_version;
   string field_name;
   string distribution_type;
   STRING50 attribute_value;
   decimal20_4 Count1;
   end;
	
	#uniquename(Bks_project)
%Bks_project% := PROJECT(%a3%, TRANSFORM(%a4%,
                                         // self.file_version:='fcra_rvattributes_v4';
                                         self.field_name:=f1;
																				 self.distribution_type:='distinct';
																				 self.attribute_value:=left.attribute_value_1;
                                         self.Count1 :=left.Count_1;
																				 self := left;
																				 // self := [];
																	      ));

result := %Bks_project%;


endmacro;

EXPORT Distinct_function1(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) >= 1 and length(trim(left.#expand(f1),left,right))<> 0 => '1+',
																																		  
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Distinct_function2(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
																				        self.attribute_value := MAP(length(trim(left.#expand(f1),left,right))= 0 => 'not populated',
                                                                     length(trim(left.#expand(f1),left,right))!= 0  => 'populated',
																																		   (integer)left.#expand(f1) = -1 => '-1',
																																		   'UNDEFINED');
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Distinct_function3(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
																				        self.attribute_value := MAP(length(trim(left.#expand(f1),left,right))= 8 => 'populated valid',
                                              length(trim(left.#expand(f1),left,right))!= 8 and length(trim(left.#expand(f1),left,right))<> 0 => 'populated invalid',
																														
																																		   'UNDEFINED');
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Distinct_function4(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
																				        self.attribute_value := MAP(
                                                                     (integer)left.#expand(f1) = -1 => '-1',
						length(trim(left.#expand(f1),left,right))!= 0 and   (integer)left.#expand(f1) <> -1   => 'populates',
																																		   'UNDEFINED');
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Distinct_function5(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = -1  => '-1',
																																		 (integer)left.#expand(f1) = 1  => 'l',
																																		
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Length_Function(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(lo)
%lo%:= record
integer did_length;
end;
 
#uniquename(eeeeeeee1)

%lo% %eeeeeeee1%(%tble% l):=transform
self.did_length:=length(trim((string)l.#expand(f1),left,right));
end;
#uniquename(op)
%op%:=project(%tble%,%eeeeeeee1%(left));
 


  #uniquename(rc)
      %rc% := record
      // string file_version:='fcra_rvattributes_v4';
      // string field_name:=f1;
      // string distribution_type:='DISTINCT';
      STRING attribute_value_1:=(string)%op%.did_length;
     decimal20_4 Count_1 := count(group);
      end;
      
     #uniquename(a3)
   %a3% := table(%op%,%rc%,%op%.did_length);



  #uniquename(a4)
      %a4% := record
      // string file_version;
      string field_name;
      string distribution_type;
      STRING50 attribute_value;
      decimal20_4 Count1;
      end;
   	
   	#uniquename(Bks_project)
   %Bks_project% := PROJECT(%a3%, TRANSFORM(%a4%,
                                            // self.file_version:='fcra_rvattributes_v4';
                                            self.field_name:=f1;
   																				 self.distribution_type:='length';
   																				 self.attribute_value:=left.attribute_value_1;
                                            self.Count1 :=left.Count_1;
   																				 self := left;
   																				 // self := [];
   																	      ));


result := %Bks_project%;


endmacro;
EXPORT Average_func(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<> -1);

#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type;
STRING50 attribute_value;
decimal20_4 Count1;
end;

#uniquename(a)
%a% := dataset([{'','average','average',0}],%rc%);

// Result:= Ave(DS,(decimal4)DS.f1);

#uniquename(Bks_project)
%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,
                                         // self.file_version:='fcra_rvattributes_v4';
                                         self.field_name:=f1;
                                         self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																				 self := left;
																				 // self := [];
																	      ));

result := %Bks_project%;


endmacro;



EXPORT Average_func1(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(#expand(f1)>'1');

#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type;
STRING50 attribute_value;
decimal20_4 Count1;
end;

#uniquename(a)
%a% := dataset([{'','average','average',0}],%rc%);

// Result:= Ave(DS,(decimal4)DS.f1);

#uniquename(Bks_project)
%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,
                                         // self.file_version:='fcra_rvattributes_v4';
                                         self.field_name:=f1;
                                         self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																				 self := left;
																				 // self := [];
																	      ));

result := %Bks_project%;


endmacro;

EXPORT Average_func2(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<> -1);

#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type;
STRING50 attribute_value;
decimal20_4 Count1;
end;

#uniquename(a)
%a% := dataset([{'','average','Ave <>blank and Ave<>-1',0}],%rc%);

// Result:= Ave(DS,(decimal4)DS.f1);

#uniquename(Bks_project)
%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,
                                         // self.file_version:='fcra_rvattributes_v4';
                                         self.field_name:=f1;
                                         self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																				 self := left;
																				 // self := [];
																	      ));

result := %Bks_project%;


endmacro;

EXPORT range_function_71(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			(integer)left.#expand(f1)= 0 => '0',   
																							                      	(integer)left.#expand(f1)= -1 => '-1',
                                                                      (integer)left.#expand(f1) = 1  => '1',
																																		  (integer)left.#expand(f1) between 2 and 960 => '2+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_72(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																							                       (integer)left.#expand(f1)= -1 => '-1',
                                                                     (integer)left.#expand(f1) between 0 and 60 and length(trim(left.#expand(f1),left,right))<> 0=> '0-60',
                                                                     (integer)left.#expand(f1) between 61 and 120 => '61-120',
																																		 (integer)left.#expand(f1) between 181 and 240=> '181-240',
                                                                     (integer)left.#expand(f1) between 241 and 300 => '241-300',
																																		 (integer)left.#expand(f1) between 301 and 360 => '301-360',
																																		 (integer)left.#expand(f1) between 361 and 960 => '360+',
																																		
																																	         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_73(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)=  -1=> '-1',
																								                     (integer)left.#expand(f1) between 1 and 25=> '1_25',
                                                                     (integer)left.#expand(f1) between 26 and 50 => '26-50',
																															     	 (integer)left.#expand(f1) between 51 and 960 => '51+',
                                                                    
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



EXPORT range_function_74(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																									                   (integer)left.#expand(f1) = -1 => '-1',
																								(integer)left.#expand(f1) between 0 and 12 and length(trim(left.#expand(f1),left,right))<> 0=> '0-12',
																								                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
                                                                     (integer)left.#expand(f1) between 25 and 36 => '25-36',
																																		 (integer)left.#expand(f1) between 37 and 48=> '37-48',
                                                                     (integer)left.#expand(f1) between 49 and 60 => '49-60',
																																		 (integer)left.#expand(f1) between 61 and 72 => '61-72',
																																		 (integer)left.#expand(f1) between 73 and 84 => '73-84',
																																		 (integer)left.#expand(f1) between 85 and 96=> '85-96',
																																		 (integer)left.#expand(f1) between 97 and 108=> '97-108',
                                                                  	 (integer)left.#expand(f1) between 109 and 120 => '109-120',
																																		 (integer)left.#expand(f1) between 121 and 960 => '121+',
																																		 
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_75(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																									                   (integer)left.#expand(f1) = -1 => '-1',
																								(integer)left.#expand(f1) between 0 and 60 and length(trim(left.#expand(f1),left,right))<> 0=> '0-60',
																								                     (integer)left.#expand(f1) between 61 and 120=> '61-120',
                                                                     (integer)left.#expand(f1) between 121 and 960 => '121+',
																																		 
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_76(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			(integer)left.#expand(f1)= 0 => '0',   
																							                      	(integer)left.#expand(f1)= -1 => '-1',      
																																		  (integer)left.#expand(f1) between 1 and 255 => '1+',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_77(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																									                   (integer)left.#expand(f1) = -1=> '-1',
																								(integer)left.#expand(f1) between 0 and 24 and length(trim(left.#expand(f1),left,right))<> 0 => '0-24',
																								                     (integer)left.#expand(f1) between 25 and 48 => '25-48',
                                                                     (integer)left.#expand(f1) between 49 and 72 => '49-72',
																																		 (integer)left.#expand(f1) between 73 and 96=> '73-96',
                                                                     (integer)left.#expand(f1) between 97 and 960 => '97+',
																																		 
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_78(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 20 => '1_20',
                                                                     (integer)left.#expand(f1) between 21 and 40 => '21-40',
                                                                  	 (integer)left.#expand(f1) between 41 and 255=> '41+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_79(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1) between 1 and 10 => '1_10',
																																							(integer)left.#expand(f1) between 11 and 20 => '11_20',
																																							(integer)left.#expand(f1) between 21 and 30 => '21_30',
                                                                              (integer)left.#expand(f1) between 31 and 40 => '31-40', 																																	
                                                                  	          (integer)left.#expand(f1) between 41 and 255 => '41+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_80(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1 => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1)= 3=> '3',
																																		 (integer)left.#expand(f1)= 4 => '4',
                                                                     (integer)left.#expand(f1) = 5  => '5',
																																		 (integer)left.#expand(f1)= 6 => '6',
                                                                     (integer)left.#expand(f1) = 7  => '7',
																																		 (integer)left.#expand(f1) = 8  => '8',																																		 
																																		 (integer)left.#expand(f1)= 9 => '9',
																																		 (integer)left.#expand(f1)= 10 => '10',
																																		 (integer)left.#expand(f1) between 11 and 255  => '11+',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_81(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1)= 3 => '3',    
																																		 (integer)left.#expand(f1)= 4 => '4',   
																																		 (integer)left.#expand(f1)= 5 => '5',    
																																		 (integer)left.#expand(f1)= 6 => '6',  
																																		 (integer)left.#expand(f1)= 7 => '7',  
																																		 (integer)left.#expand(f1) between 8 and 255 => '8+',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_82(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					         (integer)left.#expand(f1)= 0 => '0',   
																									                   (integer)left.#expand(f1) = -1 => '-1',
																								                     (integer)left.#expand(f1) between 1 and 12 => '1_12',
																								                     (integer)left.#expand(f1) between 13 and 24=> '13-24',
                                                                     (integer)left.#expand(f1) between 25 and 36 => '25-36',
																																		 (integer)left.#expand(f1) between 37 and 48=> '37-48',
                                                                     (integer)left.#expand(f1) between 49 and 60 => '49-60',
																																		 (integer)left.#expand(f1) between 61 and 96 => '61-96',
																																		 (integer)left.#expand(f1) between 97 and 132 => '97-132',
																																		 (integer)left.#expand(f1) between 133  and 960 => '133+',
																																	
																																		 
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_83(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 36 and length(trim(left.#expand(f1),left,right))<> 0=> '0-36',
                                                                     (integer)left.#expand(f1) between 37 and 72 => '37-72',
																																		 (integer)left.#expand(f1) between 73 and 108 => '73-108',
                                                                     (integer)left.#expand(f1) between 109 and 144 => '109-144',
																																		 (integer)left.#expand(f1) between 145 and 960 => '145+',
                                                                   
                                                                    
                                                                   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					;
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_84(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																								                        (integer)left.#expand(f1)= -1 => '-1',
																								                        (integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0_50',
                                                                        (integer)left.#expand(f1) between 51 and 100 => '51-100',
																															     	    (integer)left.#expand(f1) between 101 and 150 => '101-150',
																																		    (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																			  (integer)left.#expand(f1) between 201 and 250 => '201-250',
																																			  (integer)left.#expand(f1) between 251 and 450 => '251-450',
																																				(integer)left.#expand(f1) between 451 and 960 => '451+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_85(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					          
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 100 and length(trim(left.#expand(f1),left,right))<> 0=> '0-100',
                                                                     (integer)left.#expand(f1) between 251 and 350 => '251-350',
																																		 (integer)left.#expand(f1) between 351 and 550=> '351-550',
                                                                     (integer)left.#expand(f1) between 551 and 960 => '551+',
																																
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_86(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																		
																								                     (integer)left.#expand(f1) between 1 and 10 => '1_10',
                                                                     (integer)left.#expand(f1) between 11 and 20 => '11_20',
																															     	 (integer)left.#expand(f1) between 21 and 30 => '21-30',
																																		 (integer)left.#expand(f1) between 31 and 40 => '31-40',
																																		 (integer)left.#expand(f1) between 41 and 50=> '41-50',
																																		 (integer)left.#expand(f1) between 51 and 255 => '51+',
                                                                    
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_87(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1=> '-1',																																					
																								                     (integer)left.#expand(f1) between 1 and 10 => '1_10',
                                                                     (integer)left.#expand(f1) between 11 and 20 => '11_20',
																															     	 (integer)left.#expand(f1) between 21 and 30 => '21-30',																													
																																		 (integer)left.#expand(f1) between 31 and 255 => '31+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_88(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																						
																								                     (integer)left.#expand(f1) between 1 and 5 => '1_5',
                                                                     (integer)left.#expand(f1) between 6 and 10 => '6_10',
																															     	 (integer)left.#expand(f1) between 11 and 15 => '11_15',
																													           (integer)left.#expand(f1) between 16 and 20 => '16-20',
																																		 (integer)left.#expand(f1) between 21 and 255 => '21+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_89(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																					
																								                     (integer)left.#expand(f1) between 1 and 5 => '1_5',
                                                                     (integer)left.#expand(f1) between 6 and 10 => '6_10',
																															     	 (integer)left.#expand(f1) between 11 and 15 => '11_15',																													
																																		 (integer)left.#expand(f1) between 16 and 20 => '16-20',
																																		 (integer)left.#expand(f1) between 21 and 25 => '21-25',
																																		 (integer)left.#expand(f1) between 26 and 30 => '26-30',
																																		 (integer)left.#expand(f1) between 31 and 255 => '31+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_90(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																												
																								                     (integer)left.#expand(f1) between 1 and 3=> '1_3',
                                                                     (integer)left.#expand(f1) between 4 and 6 => '4_6',
																															     	 (integer)left.#expand(f1) between 7 and 9 => '7_9',																													
																																		 (integer)left.#expand(f1) between 10 and 12 => '10_12',
																																		 (integer)left.#expand(f1) between 13 and 15 => '13-15',
																																		 (integer)left.#expand(f1) between 15 and 255 => '15+',
																																			
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_91(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1) between 1 and 5=> '1_5',
																																							(integer)left.#expand(f1) between 6 and 10 => '6_10',
																																							(integer)left.#expand(f1) between 11 and 15 => '11_15',
                                                                              (integer)left.#expand(f1) between 16 and 20 => '16-20', 																																	
                                                                  	          (integer)left.#expand(f1) between 21 and 25 => '21-25',
																																							(integer)left.#expand(f1) between 26 and 255 => '26+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_92(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1) between 1 and 960 => '1+',
																																				
                                                                    
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Distinct_function6(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
																				        self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'not populated', 
																					                                (integer)left.#expand(f1)= 0 => '0', 
                                                                     length(trim(left.#expand(f1),left,right))!= 0  => 'populated',
																																		   
																																	
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;





EXPORT Distinct_function7(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
																				        self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim((string)left.#expand(f1),left,right))= 0 => 'not populated', 
																					                                (string)left.#expand(f1)= '0' => '0', 
                                                                     length(trim((string)left.#expand(f1),left,right))!= 0  => 'populated',
																																		   
																																	
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Distinct_function7a(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
																				        self.attribute_value := IF(regexfind('[0-9]',(string)left.#expand(f1)) or length(trim((string)left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim((string)left.#expand(f1),left,right))= 0 => 'not populated', 
																					                                (string)left.#expand(f1)= '0' => '0', 
																					                                (string)left.#expand(f1)= '-1' => '-1',
                                                                     length(trim((string)left.#expand(f1),left,right))!= 0  => 'populated',
																																		   
																																	
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



EXPORT range_function_93(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',																																					      
																								(integer)left.#expand(f1) between 0 and 11 and length(trim(left.#expand(f1),left,right))<> 0=> '0-11',
                                                                     (integer)left.#expand(f1) between 12 and 23 => '12_23',
																																		 (integer)left.#expand(f1) between 24 and 36 => '24-36',
                                                                     (integer)left.#expand(f1) between 36 and 960 => '36+',
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_94(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 																																					   
																								(integer)left.#expand(f1) between 0 and 199 and length(trim(left.#expand(f1),left,right))<> 0 => '0-199',
                                                                     (integer)left.#expand(f1) between 200 and 249 => '200-249',
																																		 (integer)left.#expand(f1) between 250 and 299 => '250-299',
                                                                     (integer)left.#expand(f1) between 300 and 349 => '300-349',
																																		 (integer)left.#expand(f1) between 350 and 399 => '350-399',
                                                                    (integer)left.#expand(f1) between 400 and 960 => '400+',
																																	
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_95(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',																																					        
																								(integer)left.#expand(f1) between 0 and 25 and length(trim(left.#expand(f1),left,right))<> 0=> '0-25',
                                                                     (integer)left.#expand(f1) between 26 and 35 => '26-35',
																																		 (integer)left.#expand(f1) between 36 and 45 => '36-45',
                                                                     (integer)left.#expand(f1) between 46 and 55 => '46-55',
																																		 (integer)left.#expand(f1) between 56 and 65 => '56-65',
																																		 (integer)left.#expand(f1) between 66 and 960 => '66+',
																																		
																																                                                                   
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_96(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 																																					         
																							                       (integer)left.#expand(f1)= -1 => '-1',
                                                                     (integer)left.#expand(f1) between 0 and 19 and length(trim(left.#expand(f1),left,right))<> 0=> '0-19',
                                                                     (integer)left.#expand(f1) between 20 and 39 => '20-39',
																																		 (integer)left.#expand(f1) between 40 and 59=> '40-59',
                                                                     (integer)left.#expand(f1) between 60 and 960 => '60+',
																																		
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_97(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',																																					          
																								(integer)left.#expand(f1) between 0 and 9 and length(trim(left.#expand(f1),left,right))<> 0=> '0-9',
                                                                     (integer)left.#expand(f1) between 10 and 19 => '10_19',
																																		 (integer)left.#expand(f1) between 20 and 29 => '20-29',
                                                                     (integer)left.#expand(f1) between 30 and 39 => '30-39',
																																		 (integer)left.#expand(f1) between 40 and 960 => '40+',
																																                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_98(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 																																					          
																								(integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 100=> '51-100',
																																		 (integer)left.#expand(f1) between 101 and 150 => '101-150',
                                                                     (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																		 (integer)left.#expand(f1) between 201 and 250 => '201-250',
                                                                     (integer)left.#expand(f1) between 251 and 960 => '251+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_99(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 																																					        
																								(integer)left.#expand(f1) between 0 and 19 and length(trim(left.#expand(f1),left,right))<> 0 => '0-19',
                                                                     (integer)left.#expand(f1) between 20 and 29 => '20_29',
																																		 (integer)left.#expand(f1) between 30 and 50 => '30-50',
                                                                   
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_100(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					   (integer)left.#expand(f1)= 0 => '0',   
																								                             (integer)left.#expand(f1)= 1 => '1',
                                                                             (integer)left.#expand(f1)= 2 => '2',																												
																																		         (integer)left.#expand(f1) between 3 and 120 => '3+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_101(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																							                    	 (integer)left.#expand(f1)=-1 => '-1',																								                   
																								                     (integer)left.#expand(f1) between 1 and 20 => '1_20',
                                                                     (integer)left.#expand(f1) between 21 and 40 => '21-40',
																																		 (integer)left.#expand(f1) between 41 and 60=> '41-60',
                                                            				 (integer)left.#expand(f1) between 61 and 960 => '61+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_102(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)=-1 => '-1',																								                       
																								                     (integer)left.#expand(f1) between 1 and 20 => '1_20',
                                                                     (integer)left.#expand(f1) between 21 and 40 => '21-40',
																																		 (integer)left.#expand(f1) between 41 and 60=> '41-60',
                                                            				 (integer)left.#expand(f1) between 61 and 84 => '61+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_103(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																			 (integer)left.#expand(f1)= 0 => '0',   
																								                       (integer)left.#expand(f1)= -1 => '-1',																																			
																																		   (integer)left.#expand(f1)>=2000 and length(trim(left.#expand(f1),left,right))<> 0 => '2000_and_after',
																																		   (integer)left.#expand(f1)<=1999 and length(trim(left.#expand(f1),left,right))<> 0 => '1999_and_before',
																																		         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_104(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					         (integer)left.#expand(f1)= 0 => '0',   
																								                        (integer)left.#expand(f1)= -1 => '-1',																																	
																								                        (integer)left.#expand(f1) between 1960 and 1969 => '1960-1969',
																																				(integer)left.#expand(f1) between 1970 and 1979 => '1970-1979',
																																				(integer)left.#expand(f1) between 1980 and 1989 => '1980-1989',
																																			  (integer)left.#expand(f1) between 1990 and 1999 => '1990-1999',
																																		    (integer)left.#expand(f1)>=2000 and length(trim(left.#expand(f1),left,right))<> 0  => '2000_and_after',
																																		    (integer)left.#expand(f1)<=1959 and length(trim(left.#expand(f1),left,right))<> 0 => '1959_and_before',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_105(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					         (integer)left.#expand(f1)= 0 => '0',    
																									                   (integer)left.#expand(f1) = -1 => '-1',																									
																								                     (integer)left.#expand(f1) between 1 and 24=> '1_24',																								                           
                                                                     (integer)left.#expand(f1) between 25 and 48 => '25-48',																																
                                                                     (integer)left.#expand(f1) between 49 and 72 => '49-72',																																		
																																		 (integer)left.#expand(f1) between 73 and 96 => '73-96',																																		
																																		 (integer)left.#expand(f1) between 97 and 120=> '97-120',                                                                  	
																																		 (integer)left.#expand(f1) between 121 and 960 => '121+',
																																		 
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT Range_Function_106(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 																																					      
																								(integer)left.#expand(f1) between 0 and 25 and length(trim(left.#expand(f1),left,right))<> 0 => '0-25',
																								                     (integer)left.#expand(f1) between 26 and 50 => '26-50',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 101 and 150 => '101-150',
                                                                     (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																		 (integer)left.#expand(f1) between 201 and 250 => '201-250',
                                                                     (integer)left.#expand(f1) between 251 and 960 => '251+',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_107(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 																																					           
																								(integer)left.#expand(f1) between 0 and 25 and length(trim(left.#expand(f1),left,right))<> 0 => '0-25',
																								                     (integer)left.#expand(f1) between 26 and 50 => '26-50',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 101 and 150 => '101-150',
                                                                     (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																	   (integer)left.#expand(f1) between 201 and 960 => '201+',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_108(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) between 1 and 3 => '1_3',
																																		 (integer)left.#expand(f1) between 4 and 6 => '4_6',
																																		 (integer)left.#expand(f1) between 7 and 9 => '7_9',
																																		 (integer)left.#expand(f1) between 10 and 255 => '10+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_109(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																				(integer)left.#expand(f1)= 0 => '0',   
																								                        (integer)left.#expand(f1)= -1 => '-1',																																		
																								                        (integer)left.#expand(f1) between 1950 and 1959 => '1950-1959',
																								                        (integer)left.#expand(f1) between 1960 and 1969 => '1960-1969',
																																				(integer)left.#expand(f1) between 1970 and 1979 => '1970-1979',
																																				(integer)left.#expand(f1) between 1980 and 1989 => '1980-1989',
																																			  (integer)left.#expand(f1) between 1990 and 1999 => '1990-1999',
																																				(integer)left.#expand(f1) between 2000 and 2009 => '2000-2009',
																																		    (integer)left.#expand(f1)>=2010 and length(trim(left.#expand(f1),left,right))<> 0 => '2010_and_after',
																																		    (integer)left.#expand(f1)<=1949 and length(trim(left.#expand(f1),left,right))<> 0 => '1949_and_before',
																																	         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_110(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 24 => '1_24',
                                                                     (integer)left.#expand(f1) between 25 and 48 => '25-48',
																																		 (integer)left.#expand(f1) between 49 and 72 => '49-72',
                                                                     (integer)left.#expand(f1) between 73 and 96 => '73-96',
																																		 (integer)left.#expand(f1) between 97 and 120 => '97-120',
                                                                     (integer)left.#expand(f1) between 121 and 144 => '121-144',
																																		 (integer)left.#expand(f1) between 145 and 168 => '145-168',
                                                                     (integer)left.#expand(f1) between 169 and 192 => '169-192',
																																		 (integer)left.#expand(f1) between 193 and 960 => '193+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_111(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																     (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 12 => '1_12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 36 => '25-36',
																																		 (integer)left.#expand(f1) between 37 and 48 => '37-48',
																																		 (integer)left.#expand(f1) between 49 and 960 => '49+',
                                                                   
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_112(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1) between 0 and 19 and length(trim(left.#expand(f1),left,right))<> 0=> '0_19',
                                                                     (integer)left.#expand(f1) between 20 and 39 => '20-39',
																																		 (integer)left.#expand(f1) between 40 and 59 => '40-59',
																																		 (integer)left.#expand(f1) between 60 and 79 => '60-79',
																																		 (integer)left.#expand(f1) between 80 and 99 => '80-99',
																																		 (integer)left.#expand(f1) between 100 and 960 => '100+',
                                                                   
																																                                                                   
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_113(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 1 and 12 => '1_12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 36=> '25-36',
                                                                   	 (integer)left.#expand(f1) between 37 and 48 => '37-48',
																																		 (integer)left.#expand(f1) between 48 and 60 => '48-60',
																																		 (integer)left.#expand(f1) between 61 and 960 => '61+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_114(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 1 and 12 => '1_12',
                                                                     (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 36=> '25-36',
                                                                   	 (integer)left.#expand(f1) between 37 and 960 => '37+',
																														
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_115(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 9 and length(trim(left.#expand(f1),left,right))<> 0 => '0-9',
                                                                     (integer)left.#expand(f1) between 10 and 19 => '10_19',
																																		 (integer)left.#expand(f1) between 20 and 29 => '20-29',
                                                                     (integer)left.#expand(f1) between 30 and 39 => '30-39',
																																		 (integer)left.#expand(f1) between 40 and 49 => '40-49',
																																     (integer)left.#expand(f1) between 50 and 960 => '49+',                                                             
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_116(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
																				        self.attribute_value := MAP(left.#expand(f1) in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU'
																								,'HI','ID','IL','IN','IA',
                              'KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND',
                              'MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VA','VI','WA',
                              'WV','WI','WY']=> 'isstatevalue',
                                            (integer)left.#expand(f1) = 0 and length(trim(left.#expand(f1),left,right))= 0 => 'NULL',                                                                                  
                                                                     'UNDEFINED');
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_116a(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
																				        self.attribute_value := MAP(left.#expand(f1) in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU'
																								,'HI','ID','IL','IN','IA',
                              'KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND',
                              'MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VA','VI','WA',
                              'WV','WI','WY']=> 'isstatevalue',
																							(integer)left.#expand(f1)= -1 => '-1',
                                            (integer)left.#expand(f1) = 0 and length(trim(left.#expand(f1),left,right))= 0 => 'NULL',                                                                                  
                                                                     'UNDEFINED');
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_117(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                        (integer)left.#expand(f1)= -1 => '-1',
																																				(integer)left.#expand(f1)= 0 and length(trim(left.#expand(f1),left,right))<> 0=> '0',
																								                        (integer)left.#expand(f1) between 1960 and 1969 => '1960-1969',
																																				(integer)left.#expand(f1) between 1970 and 1979 => '1970-1979',
																																				(integer)left.#expand(f1) between 1980 and 1989 => '1980-1989',
																																			  (integer)left.#expand(f1)>=2000 and length(trim(left.#expand(f1),left,right))<> 0 => '1990_and_after',
																																		    (integer)left.#expand(f1)<=1959 and length(trim(left.#expand(f1),left,right))<> 0  => '1959_and_before',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_118(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',  
																								(integer)left.#expand(f1) between 0 and 24 and length(trim(left.#expand(f1),left,right))<> 0=> '0-24',
                                                                     (integer)left.#expand(f1) between 25 and 48 => '25-48',
																																		 (integer)left.#expand(f1) between 49 and 96 => '49-96',
                                                                     (integer)left.#expand(f1) between 97 and 120 => '97-120',
																																		 (integer)left.#expand(f1) between 121 and 144 => '121-144',
																																		 (integer)left.#expand(f1) between 145 and 960 => '145+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_119(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
																				        self.attribute_value := MAP(length(trim(left.#expand(f1),left,right))= 0 => 'not populated',
                                                                     length(trim(left.#expand(f1),left,right))!= 0  => 'populated',																																		  
																																		         
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_120(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																						     		                 (integer)left.#expand(f1)= -1 => '-1',																								                         
																																		 (integer)left.#expand(f1) between 0 and 36 and length(trim(left.#expand(f1),left,right))<> 0=> '0-36',
                                                                   	 (integer)left.#expand(f1) between 37 and 960=> '37+',
																														
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_121(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 75 and length(trim(left.#expand(f1),left,right))<> 0 => '0-75',
                                                                     (integer)left.#expand(f1) between 76 and 150=> '76-150',
                                                                  	 (integer)left.#expand(f1) between 151 and 960 => '151+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

 
EXPORT range_function_122(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 36 and length(trim(left.#expand(f1),left,right))<> 0 => '0-36',
                                                                     (integer)left.#expand(f1) between 37 and 72=> '37-72',
                                                                  	 (integer)left.#expand(f1) between 73 and 108 => '73-108',
                                                                     (integer)left.#expand(f1) between 109 and 960 => '109+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_123(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 5 and length(trim(left.#expand(f1),left,right))<> 0=> '0-5',
                                                                     (integer)left.#expand(f1) between 6 and 11=> '6_11',
                                                                  	 (integer)left.#expand(f1) between 12 and 17 => '12_17',
																																		 (integer)left.#expand(f1) between 18 and 23 => '18_23',
                                                                     (integer)left.#expand(f1) between 24 and 960 => '24+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
   
EXPORT range_function_124(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                      (integer)left.#expand(f1)= -1 => '-1',
																								         (integer)left.#expand(f1) between 0 and 36 and length(trim(left.#expand(f1),left,right))<> 0=> '0-36',
                                                                     (integer)left.#expand(f1) between 37 and 72=> '37-72',
                                                                  	 (integer)left.#expand(f1) between 73 and 108 => '73-108',
																																		 (integer)left.#expand(f1) between 109 and 144 => '109-144',
																																		 (integer)left.#expand(f1) between 145 and 252 => '145-252',
                                                                     (integer)left.#expand(f1) between 253 and 960 => '253+',
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
   
    
EXPORT range_function_125(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                              (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 25 and length(trim(left.#expand(f1),left,right))<> 0=> '0-25',
                                                                     (integer)left.#expand(f1) between 26 and 50=> '26-50',
                                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
       
EXPORT range_function_126(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 																																		  
																								                     (integer)left.#expand(f1)= -1=> '-1',
																								                     (integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 100=> '51-100',
                                                                  	 (integer)left.#expand(f1) between 101 and 200 => '101-200',
																																		 (integer)left.#expand(f1) between 201 and 300 => '201-300',
                                                                     (integer)left.#expand(f1) between 301 and 960 => '301+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_127(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																								      						 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																									                   (integer)left.#expand(f1) = -1 => '-1',																							
																								                     (integer)left.#expand(f1) between 0 and 100 and length(trim(left.#expand(f1),left,right))<> 0=> '0-100',                                                                  
                                                                     (integer)left.#expand(f1) between 101 and 960 => '101+',
																																	
																																		 
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_128(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																								(integer)left.#expand(f1) between 0 and 36 and length(trim(left.#expand(f1),left,right))<> 0=> '0-36',
                                                                     (integer)left.#expand(f1) between 37 and 72 => '37-72',
																																		 (integer)left.#expand(f1) between 73 and 108 => '73-108',
                                                                     (integer)left.#expand(f1) between 97 and 120 => '97-120',
																																		 (integer)left.#expand(f1) between 109 and 144 => '109-144',
																																		 (integer)left.#expand(f1) between 145 and 960 => '145+',
                                                                   
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_129(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                   	 (integer)left.#expand(f1) = -1 => '-1',																							
																								                     (integer)left.#expand(f1) between 0 and 5 and length(trim(left.#expand(f1),left,right))<> 0 => '0-5',                                                                  
                                                                     (integer)left.#expand(f1) between 6 and 12=> '6_12',
																																	   (integer)left.#expand(f1) between 13 and 960 => '13+',
																																		 
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_130(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
                                                                     (integer)left.#expand(f1) between 0 and 100 and length(trim(left.#expand(f1),left,right))<> 0=> '0-100',
																																		 (integer)left.#expand(f1) between 101 and 150 => '101-150',
                                                                     (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																	   (integer)left.#expand(f1) between 201 and 960 => '201+',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
   
EXPORT range_function_131(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																								(integer)left.#expand(f1) between 0 and 25 and length(trim(left.#expand(f1),left,right))<> 0=> '0-25',
                                                                     (integer)left.#expand(f1) between 26 and 50 => '26-50',
																																		                                                               
                                                                        'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_132(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
//string file_version;
string field_name;
string distribution_type ;
string50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								                     (integer)left.#expand(f1)= -1 => '-1',
                                                                     (integer)left.#expand(f1) between 0 and 100 and length(trim(left.#expand(f1),left,right))<> 0=> '0-100',
																																		 (integer)left.#expand(f1) between 101 and 200 => '101-200',
																																		 (integer)left.#expand(f1) between -200 and -2 => '(-200)-(-2)',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
//%Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_133(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
																								                     (integer)left.#expand(f1) between 51 and 100 => '51-100',
																																		 (integer)left.#expand(f1) between 101 and 150 => '101-150',
                                                                     (integer)left.#expand(f1) between 151 and 200 => '151-200',
																																		 (integer)left.#expand(f1) between 201 and 250 => '201-250',
																																	   (integer)left.#expand(f1) between 251 and 300 => '251-300',
																																	   (integer)left.#expand(f1) between 301 and 960 => '301+',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT Range_Function_134(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 50 and length(trim(left.#expand(f1),left,right))<> 0=> '0-50',
																								                     (integer)left.#expand(f1) between 51 and 960 => '51+',
																																		
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



EXPORT range_function_135(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                   	 (integer)left.#expand(f1) = -1 => '-1',	
																								                     (integer)left.#expand(f1) between 1 and 3 => '1_3',                                                                  
                                                                     (integer)left.#expand(f1) between 4 and 6 => '4_6',
																																		 (integer)left.#expand(f1) between 7 and 9 => '7_9',
																																		 (integer)left.#expand(f1) between 10 and 12 => '10_12',
																																	   (integer)left.#expand(f1) between 13 and 255 => '13+',
																																		 
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_136(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																									                   (integer)left.#expand(f1) = -1 => '-1',																									
																								                     (integer)left.#expand(f1) between 1 and 2 => '1_2',                                                                  
                                                                     (integer)left.#expand(f1) between 3 and 4 => '3_4',																																		
																																	   (integer)left.#expand(f1) between 5 and 255 => '5+',
																																		 
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_137(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 100 and length(trim(left.#expand(f1),left,right))<> 0=> '0-100',
                                                                     (integer)left.#expand(f1) between 101 and 200 => '101-200',
																																		 (integer)left.#expand(f1) between 200 and 960=> '200+',
                                                                   
                                                                    
                                                                          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_138(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																				
																								                     (integer)left.#expand(f1) between 1 and 10 => '1_10',
                                                                     (integer)left.#expand(f1) between 11 and 20 => '11_20',																															   
																																		 (integer)left.#expand(f1) between 21 and 255 => '21+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_139(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																				 (integer)left.#expand(f1)= 0 => '0',   
																								                        (integer)left.#expand(f1)= -1 => '-1',																																			
																																				(integer)left.#expand(f1) between 1970 and 1979 => '1970-1979',
																																				(integer)left.#expand(f1) between 1980 and 1989 => '1980-1989',
																																			  (integer)left.#expand(f1) between 1990 and 1999 => '1990-1999',
																																		    (integer)left.#expand(f1)>=2000 and length(trim(left.#expand(f1),left,right))<> 0  => '2000_and_after',
																																		    (integer)left.#expand(f1)<=1969 and length(trim(left.#expand(f1),left,right))<> 0 => '1969_and_before',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_140(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																				(integer)left.#expand(f1)= 0 => '0',   
																								                        (integer)left.#expand(f1)= -1 => '-1',																									
																								                        (integer)left.#expand(f1) between 1 and 150 => '1_150',
                                                                        (integer)left.#expand(f1) between 151 and 250 => '151-250',
																															     	    (integer)left.#expand(f1) between 251 and 375 => '251-375',
																																		    (integer)left.#expand(f1) between 376 and 450 => '376-450',																																
																																				(integer)left.#expand(f1) between 451 and 960 => '451+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_141(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',																																		 
																																		 (integer)left.#expand(f1)= 3 => '3',
																																		 (integer)left.#expand(f1)between 4 and 5=> '4_5',                                                                 
																																		 (integer)left.#expand(f1) between 6 and 255 => '6+',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_142(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 																																					          
																								(integer)left.#expand(f1) between 0 and 72 and length(trim(left.#expand(f1),left,right))<> 0=> '0-72',
                                                                     (integer)left.#expand(f1) between 73 and 144 => '73-144',																															
																																		 (integer)left.#expand(f1) between 145 and 960 => '145+',
                                                                   
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_143(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 0 and 36 and length(trim(left.#expand(f1),left,right))<> 0 => '0-36',
                                                                     (integer)left.#expand(f1) between 37 and 72=> '37-72',
                                                                  	 (integer)left.#expand(f1) between 73 and 108 => '73-108',
																																		 (integer)left.#expand(f1) between 109 and 144=> '109-144',
                                                                  	 (integer)left.#expand(f1) between 145 and 180 => '145-180',																																		 
                                                                     (integer)left.#expand(f1) between 181 and 960 => '181+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_144(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																						
																								                     (integer)left.#expand(f1) between 1 and 48 => '1_48',
                                                                     (integer)left.#expand(f1) between 49 and 96=> '49-96',
                                                                  	 (integer)left.#expand(f1) between 97 and 144 => '97-144',
																																		 (integer)left.#expand(f1) between 145 and 239=> '145-239',                                                                
																																	   (integer)left.#expand(f1) between 240 and 960 => '240+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_145(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',		
																																		 (integer)left.#expand(f1) between 1 and 6 => '1_6',
                                                                     (integer)left.#expand(f1) between 7 and 12=> '7_12',
                                                                  	 (integer)left.#expand(f1) between 13 and 18 => '13_18',																																	                                                              
																																	   (integer)left.#expand(f1) between 19 and 255 => '19+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_146(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																							
																								                     (integer)left.#expand(f1) between 1 and 6 => '1_6',
                                                                     (integer)left.#expand(f1) between 7 and 12=> '7_12',                                                                  	 																															                                                              
																																	   (integer)left.#expand(f1) between 13 and 255 => '13+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_147(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   	
																								                              (integer)left.#expand(f1)= -1 => '-1',																																						
																								                              (integer)left.#expand(f1) between 1 and 300 => '1_300',                                                                                                                                    	 																															                                                              
																																	            (integer)left.#expand(f1) between 301 and 960 => '301+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_148(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1)= -1 => '-1',																																			
																								                              (integer)left.#expand(f1) between 1 and 120 => '1_120',                                                                                                                                    	 																															                                                              
																																	            (integer)left.#expand(f1) between 121 and 960 => '121+',
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_149(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																									                   (integer)left.#expand(f1) = -1 => '-1',																								
																								                     (integer)left.#expand(f1) between 1 and 48 => '1_48',
																								                     (integer)left.#expand(f1) between 49 and 96 => '49-96',
                                                                     (integer)left.#expand(f1) between 97 and 960 => '97+',
																																	
																																		 
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_150(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																							
																								                     (integer)left.#expand(f1) between 1 and 6 => '1_6',
                                                                     (integer)left.#expand(f1) between 7 and 12=> '7_12',
                                                                  	 (integer)left.#expand(f1) between 13 and 18 => '13_18',																																	                                                              
																																	   (integer)left.#expand(f1) between 19 and 960 => '19+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_151(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1=> '-1',																																							
																								                     (integer)left.#expand(f1) between 1 and 72 => '1_72',
                                                                     (integer)left.#expand(f1) between 73 and 120=> '73-120',
                                                                  	 (integer)left.#expand(f1) between 121 and 192 => '121-192',																																	                                                              
																																	   (integer)left.#expand(f1) between 193 and 960 => '193+',
                                                                        'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_152(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																							
																								                     (integer)left.#expand(f1) between 1 and 24 => '1_24',
                                                                     (integer)left.#expand(f1) between 25 and 48=> '25-48',
                                                                  	 (integer)left.#expand(f1) between 49 and 72 => '49-72',																																	                                                              
																																	   (integer)left.#expand(f1) between 73 and 255 => '73+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_153(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) between 1 and 60 => '1_60',
																																		 (integer)left.#expand(f1) between 61 and 120 => '61-120',
                                                                     (integer)left.#expand(f1) between 121 and 204 => '121-204',
																																	   (integer)left.#expand(f1) between 205 and 960 => '205+',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_154(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) between 1 and 25 => '1_25',
																																		 (integer)left.#expand(f1) between 25 and 50 => '25-50',
                                                                     (integer)left.#expand(f1) between 51 and 250 => '51-250',
																																	   (integer)left.#expand(f1) between 251 and 255 => '251-255',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_155(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP( length(trim(left.#expand(f1),left,right))= 0 => 'not populated',
																																					         (integer)left.#expand(f1)= 0 => '0',   
																							                                   	 (integer)left.#expand(f1) = -1 => '-1',
                                                                     length(trim(left.#expand(f1),left,right))!= 0  => 'ValidSicCode',
																																		   
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT Range_Function_156(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																		 (integer)left.#expand(f1)= 251 => '251',
																																		 (integer)left.#expand(f1)= 252 => '252',
																																		 (integer)left.#expand(f1)= 253 => '253',
																																		 (integer)left.#expand(f1)= 254 => '254',
																																		 (integer)left.#expand(f1)= 255 => '255',
																																						 
																																		 
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_157(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																							
																								                     (integer)left.#expand(f1) between 1 and 12 => '1_12',
                                                                     (integer)left.#expand(f1) between 13 and 36=> '13-36',
                                                                  	 (integer)left.#expand(f1) between 37 and 72 => '37-72',																																	                                                              
																																	   (integer)left.#expand(f1) between 73 and 255 => '73+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT Range_Function_158(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																								(integer)left.#expand(f1) between 0 and 60 and length(trim(left.#expand(f1),left,right))<> 0=> '0-60',
																								                     (integer)left.#expand(f1) between 61 and 120 => '61-120',
																																		 (integer)left.#expand(f1) between 121 and 180 => '121-180',
                                                                     (integer)left.#expand(f1) between 181 and 240 => '181-240',
																																		 (integer)left.#expand(f1) between 241 and 300 => '241-300',																																
																																	   (integer)left.#expand(f1) between 301 and 360 => '301-360',
																																		  (integer)left.#expand(f1) between 361 and 960 => '361+',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT Range_Function_159(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 72 => '1_72',
																																		 (integer)left.#expand(f1) between 73 and 960 => '73+',
                                                                    
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_160(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 60 => '1_60',
																																		 (integer)left.#expand(f1) between 61 and 96 => '61-96',
                                                                     (integer)left.#expand(f1) between 96 and 960 => '97+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT Range_Function_161(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 6 => '1_6',
																																		 (integer)left.#expand(f1) between 7 and 12 => '7_12',
																																		 (integer)left.#expand(f1) between 13 and 48=> '13-48',
                                                                     (integer)left.#expand(f1) between 49 and 960 => '49+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
   
EXPORT Range_Function_162(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 36 => '1_36',
																																		 (integer)left.#expand(f1) between 37 and 72 => '37-72',
																																		 (integer)left.#expand(f1) between 73 and 120 => '73-120',
																																		 (integer)left.#expand(f1) between 121 and 180 => '121-180',
																																		 (integer)left.#expand(f1) between 181 and 240 => '181-240',
                                                                     (integer)left.#expand(f1) between 241 and 960 => '241+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT Range_Function_163(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 48 => '1_48',																																	
                                                                     (integer)left.#expand(f1) between 49 and 960 => '49+',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_164(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 48 => '1_48',																																	
                                                                     (integer)left.#expand(f1) between 49 and 96 => '49-96',
																																		 (integer)left.#expand(f1) between 97 and 144 => '97-144',																																	
                                                                     (integer)left.#expand(f1) between 145 and 300 => '145-300',																																		 																															
                                                                     (integer)left.#expand(f1) between 301 and 960 => '301+',
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_165(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1) between 1 and 96 => '1_96',
                                                                     (integer)left.#expand(f1) between 97 and 192=> '97-192',
																																	   (integer)left.#expand(f1) between 193 and 960 => '193+',
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;   
EXPORT range_function_166(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1)= -1 => '-1',																																		
																								                              (integer)left.#expand(f1) between 1 and 140000 => '1_140,000',                                                                   
																																	            (integer)left.#expand(f1) >140001 and length(trim(left.#expand(f1),left,right))<> 0 => '140,001+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_167(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																					
																								                     (integer)left.#expand(f1) between 1 and 2 => '1_2',
                                                                     (integer)left.#expand(f1) between 3 and 4 => '3_4',
																																	   (integer)left.#expand(f1) between 5 and 6 => '5_6',
																																		 (integer)left.#expand(f1) between 7 and 255 => '7+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;      
   EXPORT range_function_168(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																							
																								                     (integer)left.#expand(f1) between 1 and 3 => '1_3',
                                                                     (integer)left.#expand(f1) between 4 and 6 => '4_6',																																	 
																																		 (integer)left.#expand(f1) between 7 and 255 => '7+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;      
EXPORT range_function_169(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																					
																								                     (integer)left.#expand(f1) between 1 and 5 => '1_5',
                                                                     (integer)left.#expand(f1) between 6 and 8 => '6_8',
																																	   (integer)left.#expand(f1) between 9 and 12 => '9_12',
																																		 (integer)left.#expand(f1) between 13 and 19 => '13_19',
																																		 (integer)left.#expand(f1) between 20 and 255 => '20+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;    
EXPORT range_function_170(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																					
																																		 (integer)left.#expand(f1)= 1 => '1',
																								                     (integer)left.#expand(f1) between 2 and 3 => '2_3',                                                                     
																																		 (integer)left.#expand(f1) between 4 and 255 => '4+',
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;  
EXPORT range_function_171(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																		
																																		 (integer)left.#expand(f1)= 1 => '1',
																																		 (integer)left.#expand(f1)= 2 => '2',
																								                     (integer)left.#expand(f1) between 3 and 4 => '3_4',                                                                     
																																		 (integer)left.#expand(f1) between 5 and 255 => '5+',
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;  
EXPORT range_function_172(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   	
																								                     (integer)left.#expand(f1)= -1 => '-1',																																				
																																	 	 (integer)left.#expand(f1) between 1 and 4 => '1_4',
																																		 (integer)left.#expand(f1) between 5 and 7 => '5_7',
																								                     (integer)left.#expand(f1) between 8 and 10 => '8_10',                                                                     
																																		 (integer)left.#expand(f1) between 11 and 255 => '11+',
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;  
EXPORT range_function_173(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																					
																																	 	 (integer)left.#expand(f1) between 1 and 3 => '1_3',
																																		 (integer)left.#expand(f1)= 4 => '4',
																																		 (integer)left.#expand(f1)= 5 => '5',
																																		 (integer)left.#expand(f1) between 6 and 255 => '6+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro; 
EXPORT range_function_174(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   	
																								                     (integer)left.#expand(f1)= -1 => '-1',																																					
																																	 	 (integer)left.#expand(f1) between 1 and 3 => '1_3',
																																		 (integer)left.#expand(f1)= 4 => '4',
																																		 (integer)left.#expand(f1)= 5 => '5',
																																		 (integer)left.#expand(f1)= 6 => '6',
																																		 (integer)left.#expand(f1)= 7=> '7',
																																		 (integer)left.#expand(f1) between 8 and 255 => '8+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro; 

EXPORT range_function_175(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																						
																																	 	 (integer)left.#expand(f1) between 1 and 48 => '1_48',
																																		 (integer)left.#expand(f1) between 49 and 96 => '49-96',
																																		 (integer)left.#expand(f1) between 97 and 144 => '97-144',
																																		 (integer)left.#expand(f1) between 145 and 192 => '145-192',																																
																																		 (integer)left.#expand(f1) between 193 and 960 => '193+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_176(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																				
																																	 	 (integer)left.#expand(f1) between 1 and 48 => '1_48',
																																		 (integer)left.#expand(f1) between 49 and 96 => '49-96',
																																		 (integer)left.#expand(f1) between 97 and 144 => '97-144',
																																		 (integer)left.#expand(f1) between 145 and 240 => '145-240',																																
																																		 (integer)left.#expand(f1) between 241 and 960 => '241+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_177(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																							
																								                     (integer)left.#expand(f1) between 1 and 7 => '1_7',
                                                                     (integer)left.#expand(f1) between 8 and 12 => '8_12',
																															     	 (integer)left.#expand(f1) between 13 and 20 => '13_20',																													       
																																		 (integer)left.#expand(f1) between 21 and 255 => '21+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_178(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																							
																								                     (integer)left.#expand(f1) between 1 and 6 => '1_6',
                                                                     (integer)left.#expand(f1) between 7 and 10 => '7_10',
																															     	 (integer)left.#expand(f1) between 11 and 16 => '11_16',																													       
																																		 (integer)left.#expand(f1) between 17 and 255 => '17+',
                                                                    
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_179(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',
										             			                               (integer)left.#expand(f1) between 1 and 6 => '1_6',
                                                                     (integer)left.#expand(f1) between 7 and 10 => '7_10',
																															     	 (integer)left.#expand(f1) between 11 and 17 => '11_17',																													       
																																		 (integer)left.#expand(f1) between 18 and 255 => '18+',
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_180(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 192 => '1_192',
                                                                     (integer)left.#expand(f1) between 193 and 300 => '193-300',
																															     	 (integer)left.#expand(f1) between 301 and 360 => '301-360',																													       
																																		 (integer)left.#expand(f1) between 361 and 420 => '361-420',
                                                                     (integer)left.#expand(f1) between 421 and 960=> '421+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_181(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) between 1 and 7 => '1_7',
																																		 (integer)left.#expand(f1) =8 => '8',
																																		 (integer)left.#expand(f1) =9=> '9',
																																		 (integer)left.#expand(f1) =10 => '10',
																																		 (integer)left.#expand(f1) between 11 and 255 => '11+',
																																				 
																																		 
																																	         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_182(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) between 1 and 3 => '1_3',
																																		 (integer)left.#expand(f1) between 4 and 5 => '4_5',
																																		 (integer)left.#expand(f1) between 6 and 7 => '6_7',
																																		 (integer)left.#expand(f1) between 8 and 9 => '8_9',
																																		 (integer)left.#expand(f1) between 10 and 255 => '10+',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
   EXPORT range_function_183(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 2 => '1_2',
                                                                   	 (integer)left.#expand(f1)= 3 => '3',
																																		 (integer)left.#expand(f1)= 4 => '4',	 
																																		 (integer)left.#expand(f1)= 5=> '5',
																																		 (integer)left.#expand(f1)= 6 => '6',																																	 
																																		 (integer)left.#expand(f1) between 7 and 255 => '7+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;  
   EXPORT range_function_184(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 3 => '1_3',
                                                                   	 (integer)left.#expand(f1)= 4 => '4',																														 
																																		 (integer)left.#expand(f1) between 5 and 255 => '5+',
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
   EXPORT range_function_185(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																		 (integer)left.#expand(f1)= 1 => '1',	
																								                     (integer)left.#expand(f1) between 2 and 10 => '2_10',                                                                   																														 
																																		 (integer)left.#expand(f1) between 11 and 255 => '11+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

 EXPORT range_function_185a(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																		 (integer)left.#expand(f1)= -1 => '-1',	
																																		 (integer)left.#expand(f1)= 1 => '1',	
																								                     (integer)left.#expand(f1) between 2 and 10 => '2_10',                                                                   																														 
																																		 (integer)left.#expand(f1) between 11 and 960 => '11+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_186(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																	 	 (integer)left.#expand(f1) between 1 and 60 => '1_60',
																																		 (integer)left.#expand(f1) between 61 and 96 => '61-96',
																																		 (integer)left.#expand(f1) between 97 and 144=> '97-144',
																																		 (integer)left.#expand(f1) between 145 and 240 => '145-240',																																
																																		 (integer)left.#expand(f1) between 241 and 960 => '241+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
   EXPORT range_function_187(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1)= 0 => '0',   
																																	   (integer)left.#expand(f1)= 1 => '1',	
																																		 (integer)left.#expand(f1)= 2 => '2',	
																								                     (integer)left.#expand(f1) between 3 and 9 => '3_9',                                                                   																														 
																																		 (integer)left.#expand(f1) between 10 and 255 => '10+',
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_188(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 1 and 6 => '1_6',
                                                                     (integer)left.#expand(f1) between 7 and 16 => '7_16',
																																		 (integer)left.#expand(f1) between 17 and 35=> '17-35',
                                                                   	 (integer)left.#expand(f1) between 36 and 60 => '36-60',																																		 
																																		 (integer)left.#expand(f1) between 61 and 255 => '61+',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_189(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 1 and 15 => '1_15',
                                                                     (integer)left.#expand(f1) between 16 and 50 => '16-50',
																																		 (integer)left.#expand(f1) between 51 and 254=> '51-254',                                                                   																																			 
																																		 (integer)left.#expand(f1) =255 => '255',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_190(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 1 and 150 => '1_150',
                                                                     (integer)left.#expand(f1) between 151 and 254 => '151-254',																																		                                                                 																																			 
																																		 (integer)left.#expand(f1) =255 => '255',
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_191(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',
																								                     (integer)left.#expand(f1) between 1  and 10 => '1_10',
                                                                     (integer)left.#expand(f1) between 11 and 25 => '11_25',
																																		 (integer)left.#expand(f1) between 26 and 50 => '26-50',
																																		 (integer)left.#expand(f1) between 51 and 254=> '51-254',                                                                   																																			 
																																		 (integer)left.#expand(f1) =255 => '255',
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_192(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1)= -1 => '-1',
																																							(integer)left.#expand(f1)= 1 => '1',
																																							(integer)left.#expand(f1)= 2 => '2',
																								                              (integer)left.#expand(f1) between 3 and 20 => '3_20',
                                                                              (integer)left.#expand(f1) between 21 and 50 => '21-50',																																		                                                                  																																			 
																																		          (integer)left.#expand(f1) between 51 and 960 => '51+',
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_193(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																																																											
																								                     (integer)left.#expand(f1) between 1 and 48 => '1_48',
                                                                     (integer)left.#expand(f1) between 49 and 96 => '49-96',																																		                                                                  																																			 
																																		 (integer)left.#expand(f1) between 97 and 180 => '97-180',
                                                                     (integer)left.#expand(f1) between 181 and 960 => '181+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_194(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1)= -1 => '-1',																																							
																																							(integer)left.#expand(f1)= 1 => '1',
																																							(integer)left.#expand(f1)= 2 => '2',
																																							(integer)left.#expand(f1)= 3 => '3',
																								                              (integer)left.#expand(f1) between 4 and 5 => '4_5',
                                                                              (integer)left.#expand(f1) between 7 and 9 => '7_9',																																		                                                                  																																			 
																																		          (integer)left.#expand(f1) between 10 and 255 => '10+',
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_194a(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1)= -1 => '-1',																																							
																																							(integer)left.#expand(f1)= 1 => '1',
																																							(integer)left.#expand(f1)= 2 => '2',
																																							(integer)left.#expand(f1)= 3 => '3',
																								                              (integer)left.#expand(f1) between 4 and 6 => '4_6',
                                                                              (integer)left.#expand(f1) between 7 and 9 => '7_9',																																		                                                                  																																			 
																																		          (integer)left.#expand(f1) between 10 and 255 => '10+',
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_195(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
                                                                     (integer)left.#expand(f1) between 1 and 3 => '1_3',
																																		 (integer)left.#expand(f1) between 4 and 5 => '4_5',
																																		 (integer)left.#expand(f1) between 6 and 8 => '6_8',
																																		 (integer)left.#expand(f1) between 9 and 13 => '9_13',
																																		 (integer)left.#expand(f1) between 14 and 255 => '14+',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_196(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	  (integer)left.#expand(f1)= 0 => '0',   
																								                    (integer) left.#expand(f1) between 1 and 15 => '1_15',
                                                                    (integer) left.#expand(f1) between 16 and 30 => '16-30',
																															      (integer) left.#expand(f1) between 31 and 55 => '31-55',
																																		(integer) left.#expand(f1) between 56 and 85 => '56-85',
																																		(integer) left.#expand(f1) between 86 and 960 => '86+',
                                                                   
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_197(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 204 => '1_204',
                                                                     (integer)left.#expand(f1) between 205 and 278 => '205-278',
																															       (integer)left.#expand(f1) between 279 and 360 => '279-360',																																		 
																																		 (integer)left.#expand(f1) between 361 and 960 => '361+',
                                                                   
                                                                    
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					;
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_198(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 300 => '1_300',
                                                                     (integer)left.#expand(f1) between 301 and 360 => '301-360',
																															       (integer)left.#expand(f1) between 361 and 456 => '361-456',																																		 
																																		 (integer)left.#expand(f1) between 457 and 540 => '457-540',
                                                                     (integer)left.#expand(f1) between 541 and 960 => '541+',
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_198a(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																		 (integer)left.#expand(f1)= -1 => '-1',   
																								                     (integer)left.#expand(f1) between 1 and 300 => '1_300',
                                                                     (integer)left.#expand(f1) between 301 and 360 => '301-360',
																															       (integer)left.#expand(f1) between 361 and 456 => '361-456',																																		 
																																		 (integer)left.#expand(f1) between 457 and 540 => '457-540',
                                                                     (integer)left.#expand(f1) between 541 and 960 => '541+',
                                                                    
                                                                              'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_199(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  
																								                     (integer)left.#expand(f1)= -1 => '-1',
                                                                     (integer)left.#expand(f1) between 1 and 48 => '1_48',
																																		 (integer)left.#expand(f1) between 49 and 96 => '49-96',
                                                                     (integer)left.#expand(f1) between 96 and 200 => '96-200',
																																	   (integer)left.#expand(f1) between 201 and 960 => '201+',
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_200(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  
																								                     (integer)left.#expand(f1)= 100 => '100',
                                                                     (integer)left.#expand(f1) between 1 and 99 => '1_99',
																																		
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT Range_Function_201(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  																								                    
                                                                     (integer)left.#expand(f1) between 1 and 680 => '1_680',
																																		 (integer)left.#expand(f1) between 681 and 730 => '681-730',
																																		 (integer)left.#expand(f1) between 731 and 760 => '731-760',
																																		 (integer)left.#expand(f1) between 761 and 780 => '761-780',
																																		 (integer)left.#expand(f1) between 781 and 960 => '781+',
																																		
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_202(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  																							                    
                                                                     (integer)left.#expand(f1) between 1 and 4 => '1_4',
																																		
																																		
																																	         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_203(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  																								                    
                                                                     (integer)left.#expand(f1) between 1 and 8  => '1_8',
																																		
																																		
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT Range_Function_204(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  																							                    
                                                                     (integer)left.#expand(f1) between 1 and 7  => '1_7',
																																		 (integer)left.#expand(f1)= 8 => '8',
																																		
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_205(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1)= 0 => '0',  																							                    
                                                                     (integer)left.#expand(f1) between 600 and 640  => '600-640',
																																		 (integer)left.#expand(f1) between 641 and 670  => '641-670',
																																		 (integer)left.#expand(f1) between 661 and 700  => '661-700',
																																		 (integer)left.#expand(f1) between 701 and 960  => '701+',
																																		
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_206(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																			 (integer)left.#expand(f1)= 0 => '0',  	
																																		   (integer)left.#expand(f1)= 1 => '1',																																		
                                                                    
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT Range_Function_207(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 (integer)left.#expand(f1)= 0 => '0',  	
																																		 (integer)left.#expand(f1)= 1 => '1',
																																		 (integer)left.#expand(f1)= 2 => '2',																																		
                                                                    
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_208(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  	
																																		 (integer)left.#expand(f1)= 1 => '1',
                                                                     (integer)left.#expand(f1) between 2 and 9  => '2_9',																																		 
																																		 (integer)left.#expand(f1) between 11 and 255  => '11+',
																																		
																																		            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_209(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  
																																		 (integer)left.#expand(f1)= 1 => '1',
																																		 (integer)left.#expand(f1)= 2 => '2',
                                                                     (integer)left.#expand(f1) between 3 and 4  => '3_4',																																		 
																																		 (integer)left.#expand(f1) between 5 and 6  => '5_6',
																																		
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_210(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  																														 
																																		 (integer)left.#expand(f1) between 1 and 39  => '1_39',
																																		 (integer)left.#expand(f1)= 40 => '40',
																																		 (integer)left.#expand(f1)= 50 => '50',
																																																																	
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT Range_Function_211(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',																															 
																																		 (integer)left.#expand(f1) between 1 and 49  => '1_49',																																		
																																		 (integer)left.#expand(f1)= 50 => '50',
																																																																	
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_212(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  	
																																		 (integer)left.#expand(f1)= 1 => '1',
                                                                     (integer)left.#expand(f1) between 2 and 4  => '2_4',																																		 
																																		
																																		
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_213(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  																																			 
                                                                     (integer)left.#expand(f1) between 1 and 35  => '1_35',		
																																		 (integer)left.#expand(f1) between 36 and 50  => '36-50',		
																																		 (integer)left.#expand(f1) between 51 and 65  => '51-65',		
																																	   (integer)left.#expand(f1) between 66 and 90  => '66-90',		
																																		 (integer)left.#expand(f1) between 91 and 960 => '91+',		
																																		
																																		
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_214(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(	length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1)= 0 => '0', 																														 
                                                                     (integer)left.#expand(f1) between 300 and 649  => '300-649',		
																																		 (integer)left.#expand(f1) between 650 and 680  => '650-680',		
																																		 (integer)left.#expand(f1) between 681 and 729  => '681-729',		
																																	   (integer)left.#expand(f1) between 730 and 764  => '730-764',		
																																		 (integer)left.#expand(f1) between 765 and 999 => '765+',		
																																		
																																		
																																		           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Average_Function_1(DS,f1,Result) := MACRO


#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=1 and (integer)#expand(f1)<=100);
 
 
#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type;
STRING50 attribute_value;
decimal20_4 Count1;
end;

#uniquename(a)
%a% := dataset([{'','average','avg1_100',0}],%rc%);


#uniquename(Bks_project)
%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,
                                        
                                         self.field_name:=f1;
                                         self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																				 self := left;
																	
																	      ));

result :=   %Bks_project%  ;


endmacro;


EXPORT Average_Function_2(DS,f1,Result) := MACRO


#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=300 and (integer)#expand(f1)<=999);
 
 
#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type;
STRING50 attribute_value;
decimal20_4 Count1;
end;

#uniquename(a)
%a% := dataset([{'','average','avg300_999',0}],%rc%);


#uniquename(Bks_project)
%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,
                                        
                                         self.field_name:=f1;
                                         self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																				 self := left;
																	
																	      ));

result :=   %Bks_project%  ;


endmacro;
Export Average_Function_3(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)>0);
 
 

#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type;
STRING50 attribute_value;
decimal20_4 Count1;
end;

#uniquename(a)
%a% := dataset([{'','average','avg>0',0}],%rc%);

// Result:= Ave(DS,(decimal4)DS.f1);

#uniquename(Bks_project)
%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,
                                         // self.file_version:='fcra_rvattributes_v4';
                                         self.field_name:=f1;
                                         self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																				 self := left;
																				 // self := [];
																	      ));

result :=  %Bks_project% ;


endmacro;


Export Average_Function_4(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)>=0);
 
 

#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type;
STRING50 attribute_value;
decimal20_4 Count1;
end;

#uniquename(a)
%a% := dataset([{'','average','avg>=0',0}],%rc%);

// Result:= Ave(DS,(decimal4)DS.f1);

#uniquename(Bks_project)
%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,
                                         // self.file_version:='fcra_rvattributes_v4';
                                         self.field_name:=f1;
                                         self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																				 self := left;
																				 // self := [];
																	      ));

result :=  %Bks_project% ;


endmacro;

Export Average_Function_5(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<0);
 
 

#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type;
STRING50 attribute_value;
decimal20_4 Count1;
end;

#uniquename(a)
%a% := dataset([{'','average','avg<0',0}],%rc%);

// Result:= Ave(DS,(decimal4)DS.f1);

#uniquename(Bks_project)
%Bks_project% := PROJECT(%a%, TRANSFORM(%rc%,
                                         // self.file_version:='fcra_rvattributes_v4';
                                         self.field_name:=f1;
                                         self.Count1 := Ave(%a2%,(decimal20_4)%a2%.#expand(f1));
																				 self := left;
																				 // self := [];
																	      ));

result :=  %Bks_project% ;


endmacro;

EXPORT range_function_215(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1)= -1 => '-1',																																				
																																	 	 (integer)left.#expand(f1) between 1 and 48 => '1_48',
																																		 (integer)left.#expand(f1) between 49 and 96 => '49-96',
																																		 (integer)left.#expand(f1) between 97 and 144 => '97-144',
																																		 (integer)left.#expand(f1) between 145 and 192 => '145-192',	
																																		 (integer)left.#expand(f1) between 193 and 240 => '193-240',	
																																		 (integer)left.#expand(f1) between 241 and 960 => '241+',
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_216(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1)= -1 => '-1',																																			
																								                              (integer)left.#expand(f1) between 1 and 120 => '1_120',                                                                                                                                    	 																															                                                              
																																	          
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_217(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					    (integer)left.#expand(f1)= 0 => '0',   
																								                              (integer)left.#expand(f1)= -1 => '-1',																																			
																								                              (integer)left.#expand(f1) between 1 and 20 => '1_20',      
																																							(integer)left.#expand(f1) between 21 and 30 => '21_30',  
																																							(integer)left.#expand(f1) between 31 and 40 => '31_40',  
																																							(integer)left.#expand(f1) between 41 and 50 => '41_50',  
																																							(integer)left.#expand(f1) between 51 and 60 => '51_60',  
																																							(integer)left.#expand(f1) between 61 and 70 => '61_70',  
																																							(integer)left.#expand(f1) between 71 and 960 => '71+',  
																																	          
                                                                            'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_218(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',  
																						     		                 (integer)left.#expand(f1)= -1 => '-1',																								                         
																																		 (integer)left.#expand(f1) between 1 and 36 => '1_36',
                                                                   	 (integer)left.#expand(f1) between 37 and 960=> '37+',
																														
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_219(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																									                   (integer)left.#expand(f1) = -1=> '-1',
																																		 (integer)left.#expand(f1) = 0=> '0',
																																		 (integer)left.#expand(f1) = 1=> '1',
																							                     	 (integer)left.#expand(f1) between 2 and 24 => '2_24',
																								                     (integer)left.#expand(f1) between 25 and 48 => '25-48',
                                                                     (integer)left.#expand(f1) between 49 and 96 => '49-96',																																
                                                                     (integer)left.#expand(f1) between 97 and 960 => '97+',
																																		 
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_220(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 																									                 
																																		 (integer)left.#expand(f1) = 0=> '0',																																	
																							                     	 (integer)left.#expand(f1) between 1 and 99999 => '1_99999',
																								                     (integer)left.#expand(f1)>100000 => '100,000+',
                                                                  
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_221(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																									                   (integer)left.#expand(f1) = -1=> '-1',
																																		 (integer)left.#expand(f1) = 0=> '0',																																		
																							                     	 (integer)left.#expand(f1) between 1 and 12 => '1_12',
																								                     (integer)left.#expand(f1) between 13 and 48 => '13-48',
                                                                     (integer)left.#expand(f1) between 49 and 96 => '49-96',																																
                                                                     (integer)left.#expand(f1) between 97 and 960 => '97+',
																																		 
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_222(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																									                   (integer)left.#expand(f1) = -1=> '-1',
																																		 (integer)left.#expand(f1) = 0=> '0',																																		
																							                     	 (integer)left.#expand(f1) between 1 and 33 => '1_33',
																								                     (integer)left.#expand(f1) between 34 and 67 => '34-67',
                                                                     (integer)left.#expand(f1) between 68 and 100 => '68-100',																																
                                                                     
																																		 
                                                                    
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_223(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																				(integer)left.#expand(f1)= 0 => '0',   
																								                        (integer)left.#expand(f1) =-1 => '-1',		
																																		    (integer)left.#expand(f1) = 2013  => '2013',
																																			  (integer)left.#expand(f1) = 2014 => '2014',
                                                                        (integer)left.#expand(f1) = 2015 => '2015',
																																		    (integer)left.#expand(f1) = 2016  => '2016',
																																			  (integer)left.#expand(f1) = 2017  => '2017',
																																		    (integer)left.#expand(f1) = 2018  => '2018',
																																		    (integer)left.#expand(f1)<= 2012 and length(trim(left.#expand(f1),left,right))<> 0  => '2012_and_less',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_224(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 24 => '1_24',                                                                    
																																		 (integer)left.#expand(f1) between 25 and 84 => '25+',
                                                                    
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_225(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 10 => '1_10',   
																																		 (integer)left.#expand(f1) between 11 and 100 => '11_100', 
																																		 (integer)left.#expand(f1) between 101 and 960 => '101+',
                                                                    
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_226(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																				 (integer)left.#expand(f1)= 0 => '0',   
																								                        (integer)left.#expand(f1)= -1 => '-1',																																			
																																				(integer)left.#expand(f1) between 1970 and 1979 => '1970-1979',
																																				(integer)left.#expand(f1) between 1980 and 1989 => '1980-1989',
																																			  (integer)left.#expand(f1) between 1990 and 1999 => '1990-1999',
																																		    (integer)left.#expand(f1)>=2000 and length(trim(left.#expand(f1),left,right))<> 0  => '2000_and_after',
																																		    (integer)left.#expand(f1)<=1969 and length(trim(left.#expand(f1),left,right))<> 0 => 'before_1970',
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_227(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   			 
																								                     (integer)left.#expand(f1) between 1 and 24 => '1_24',
                                                                     (integer)left.#expand(f1) between 25 and 48 => '25-48',
																																		 (integer)left.#expand(f1) between 49 and 960 => '49+',
                                                                   
																																                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_228(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   			 
																								                     (integer)left.#expand(f1) between 1 and 20 => '1_20',
                                                                     (integer)left.#expand(f1) between 21 and 30 => '21-30',
																																		 (integer)left.#expand(f1) between 31 and 40 => '31-40',
																																		 (integer)left.#expand(f1) between 41 and 50 => '41-50',
																																		 (integer)left.#expand(f1) between 51 and 60 => '51-60',
																																		 (integer)left.#expand(f1) between 61 and 70 => '61-70',
																																		 (integer)left.#expand(f1) between 70 and 960 => '70+',
                                                                   
																																                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_229(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   			 
																								                     (integer)left.#expand(f1) between 1 and 20 => '1_20',
                                                                     (integer)left.#expand(f1) between 51 and 100 => '51-100',																															
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_230(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   			 
																								                     (integer)left.#expand(f1) between 1 and 5=> '1_5',
                                                                     (integer)left.#expand(f1) between 6 and 20 => '6_20',																															
																																	   (integer)left.#expand(f1) between 21 and 255 => '21+',
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_231(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   			 
																								                     (integer)left.#expand(f1) between 1 and 18=> '1_18',                                                              																															
																																	   (integer)left.#expand(f1) between 19 and 255 => '19+',
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_232(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   	
																																		 (integer)left.#expand(f1)= 1 => '1',  
																								                     (integer)left.#expand(f1) between 2 and 12=> '2_12',                                                              																															
																																	   (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 48 => '25-48',
																																		 (integer)left.#expand(f1) between 49 and 960 => '49+',
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_233(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1) between 1 and 12=> '1_12',                                                              																															
																																	   (integer)left.#expand(f1) between 13 and 24 => '13-24',
																																		 (integer)left.#expand(f1) between 25 and 48 => '25-48',
																																		 (integer)left.#expand(f1) between 49 and 960 => '49+',
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_234(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1) between 1 and 36=> '1_36',                                                              																															
																																	   (integer)left.#expand(f1) between 37 and 72 => '37-72',																																
																																		 (integer)left.#expand(f1) between 73 and 960 => '73+',
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_235(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1) between 1 and 60=> '1_60',                                                              																															
																																	   (integer)left.#expand(f1) between 61 and 100 => '61-100',																																
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_236(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1) between 1 and 12=> '1_12',                                                              																															
																																	   (integer)left.#expand(f1) between 13 and 960 => '13+',																																
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_237(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1) between 1 and 99=> '1_99',                                                              																															
																																	   (integer)left.#expand(f1) between 100 and 960 => '100+',																																
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_238(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1) between 1 and 2=> '1_2', 
																																		 (integer)left.#expand(f1) between 3 and 4=> '3_4', 
																																		 (integer)left.#expand(f1) between 5 and 6=> '5_6', 
																																		 (integer)left.#expand(f1) between 7 and 10=> '7_10', 																																		 
																																		 (integer)left.#expand(f1) between 11 and 255=> '11+', 
																																	  																															
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_239(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0', 
																								                     (integer)left.#expand(f1) between 1 and 2=> '1_2', 
																																		 (integer)left.#expand(f1) between 3 and 4=> '3_4', 
																																		 (integer)left.#expand(f1) between 5 and 6=> '5_6', 
																																		 (integer)left.#expand(f1) between 7 and 9=> '7_9', 			
																																		 (integer)left.#expand(f1) between 10 and 15=> '10_15', 
																																		 (integer)left.#expand(f1) between 16 and 255=> '16+', 
																																	  																															
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_240(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																								                     (integer)left.#expand(f1) between 0 and 23=> '0_23', 
																																		 (integer)left.#expand(f1) between 24 and 47=> '24-47', 
																																		 (integer)left.#expand(f1) between 48 and 71=> '48-71', 
																																		 (integer)left.#expand(f1) between 72 and 960=> '72+', 
																																	  																															
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_241(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																					 (integer)left.#expand(f1)= 0 => '0', 
																																					 (integer)left.#expand(f1)= -1 => '-1', 
																								                     (integer)left.#expand(f1) between 1 and 4=> '1_4', 
																																		 (integer)left.#expand(f1) between 5 and 8=> '5_8', 
																																		 (integer)left.#expand(f1) between 9 and 12=> '9_12', 
																																		 (integer)left.#expand(f1) between 13 and 72=> '13-72', 
																																	   (integer)left.#expand(f1) between 73 and 960=> '73+', 																														
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_function_242(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					 	 (integer)left.#expand(f1) = -1  => '-1',
																								(integer)left.#expand(f1) between 0 and 60 and length(trim(left.#expand(f1),left,right))<> 0 => '0-60',
                                                                     (integer)left.#expand(f1) between 61 and 120 => '61-120',
																																		 (integer)left.#expand(f1) between 121 and 180 => '121-180',
                                                                     (integer)left.#expand(f1) between 181 and 240 => '181-240',
																																		 (integer)left.#expand(f1) between 241 and 300 => '241-300',
                                                                     (integer)left.#expand(f1) between 301 and 360 => '301-360',
																																		 (integer)left.#expand(f1) between 361 and 960 => '361+',
                                                               
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_243(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					 	 (integer)left.#expand(f1) = -1  => '-1',
																								(integer)left.#expand(f1) between 0 and 50000  => '0-50,000',
                                                                     (integer)left.#expand(f1) between 50001 and 100000 => '50,001-100,000',
																																		 (integer)left.#expand(f1) between 100001 and 150000 => '100,001-150,000',
                                                                    
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_244(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					 	 (integer)left.#expand(f1) = -1  => '-1',
																								(integer)left.#expand(f1) between 0 and 35 and length(trim(left.#expand(f1),left,right))<> 0 => '0-35',
                                                                     (integer)left.#expand(f1) between 36 and 71 => '36-71',
																																		 (integer)left.#expand(f1) between 72 and 107 => '72-107',
                                                                     (integer)left.#expand(f1) between 108 and 143 => '108-143',
																																		 (integer)left.#expand(f1) between 144 and 960 => '144+',
                                                               
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

Export range_function_245(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
 #uniquename(a)
	%a%:= ut.GetDate;
	 #uniquename(date_inp)
	 
	  #uniquename(offset)
			  #uniquename(fn_LastTwoMonths)
%fn_LastTwoMonths%(string10 date_inp,integer offset) := function

res := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;
 #uniquename(fn_LastTwoMonths1)
%fn_LastTwoMonths1%(string10 date_inp,integer offset) := function

res := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) + offset));
return res[1..8];
end;
 #uniquename(old_dt)
%old_dt%:=%fn_LastTwoMonths%(%a%,30);

 #uniquename(new_dt)
%new_dt%:=%fn_LastTwoMonths1%(%a%,30);
 
 
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))= 8,
                                                                           
																																					 MAP(
																																					  (integer)left.#expand(f1)<=(integer)%old_dt%  => '<= 30Days',
																																						 (integer)left.#expand(f1)>(integer)%new_dt%  => '>30Days',
																																					      																											
																												 	                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
																																					
                                             ));



#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

Export range_function_246(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
 #uniquename(a)
	%a%:= ut.GetDate;
		 #uniquename(date_inp)
	 
	  #uniquename(offset)
	  #uniquename(fn_LastTwoMonths)
%fn_LastTwoMonths%(string10 date_inp,integer offset) := function

res := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;
  #uniquename(fn_LastTwoMonths1)
%fn_LastTwoMonths1%(string10 date_inp,integer offset) := function

res := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) + offset));
return res[1..8];
end;
 #uniquename(old_dt)
%old_dt%:=%fn_LastTwoMonths%(%a%,30);

 #uniquename(new_dt)
%new_dt%:=%fn_LastTwoMonths1%(%a%,30);
 
 
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[a-zA-Z]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))= 2,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					  left.#expand(f1)[1]<left.#expand(f1)[2] => 'move up in value',
																																						left.#expand(f1)[1]>left.#expand(f1)[2] => 'move down in value',
																																						left.#expand(f1)[1]=left.#expand(f1)[2] => 'samevalue',
																																			
																																					      																											
																												 	                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
																																					
                                             ));



#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT distinct_Function_247(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
                                                self.attribute_value := IF(
                                                                           
																																					length(trim(left.#expand(f1),left,right))= 0,'blank', 
																																																																	
                                                                    
																																		          'UNDEFINED');
                                                                       
                                                                         
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT distinct_Function_248(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 (integer)left.#expand(f1) = 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1 => '1',
																																		 (integer)left.#expand(f1) = 2 => '2',																																		 
																																		 (integer)left.#expand(f1) = 3 => '3',
																																		 (integer)left.#expand(f1) = 4 => '4',
                                                                     (integer)left.#expand(f1) = 5 => '5',
																																		 (integer)left.#expand(f1) = 6 => '6',
                                                                    
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT distinct_Function_249(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
                                                self.attribute_value :=   IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,                                                                        
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 (real)left.#expand(f1) = 14.3 => '14.3',   
                                                                     (real)left.#expand(f1) = 10.2 => '10.2',
																																		 (real)left.#expand(f1) = 4.1  => '4.1',																																		 
																																		 (real)left.#expand(f1) = 14.2 => '14.2',
																																		 (real)left.#expand(f1) = 3.1  => '3.1',
                                                                     (real)left.#expand(f1) = 11.6 => '11.6',
																																		
                                                                    
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
                                                                           
																																					
		
                                                                            
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_250(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					 	 (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 100000  => '1-100,000',
                                                                     (integer)left.#expand(f1) between 100001 and 150000 => '100,001-150,000',
																																		 (integer)left.#expand(f1) between 150001 and 200000 => '150,001-200,000',
                                                                     (integer)left.#expand(f1) > 200000 => '>200,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT distinct_Function_251(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 (integer)left.#expand(f1) = 0  => '0',   
                                                                     (integer)left.#expand(f1) = 18 => '18',
																																		 (integer)left.#expand(f1) = 21 => '21',																																		 
																																		 (integer)left.#expand(f1) = 70 => '70',
																																		 (integer)left.#expand(f1) = 80 => '80',
                                                                    
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT Range_Function_252(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
string50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                // self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
																																					 MAP(
																																							length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																								                     (real)left.#expand(f1)= -1 => '-1',   
																								                     (real)left.#expand(f1)= 1 => '1',   
																							                     	 (real)left.#expand(f1)= 0 => '0', 
																																		 // (real)left.#expand(f1) between 0.1 and 0.9 => '0.1-0.9',
																																		 // (real)left.#expand(f1) between 1.1 and 99 => '1.1-99',
																																		 (real)left.#expand(f1) > 0 and (real)left.#expand(f1) <= 0.1 => '0-0.1',
																																			(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.8 => '0.1-0.8',
																																			(real)left.#expand(f1) > 0.8 and (real)left.#expand(f1) <= 1.0 => '0.8-1.0',
																																			(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 1.3 => '1.0-1.4',
																																			(real)left.#expand(f1) > 1.3 and (real)left.#expand(f1) <= 99 => '1.4-99',
																																			// (string)left.#expand(f1) = '' => 'BLANK',

                                                                //need blank
																																		    		   'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					  
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;
result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_253(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					 	 (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 150000  => '1-150,000',
                                                                     (integer)left.#expand(f1) between 150001 and 300000 => '150,001-300,000',
																																		 (integer)left.#expand(f1) between 300001 and 450000 => '300,001-450,000',
                                                                     (integer)left.#expand(f1) > 450000 => '>450,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_254(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   			 
																								                     (integer)left.#expand(f1) between 1 and 50 => '1_50',
                                                                     (integer)left.#expand(f1) between 51 and 75 => '51-75',	
																																		 (integer)left.#expand(f1) between 76 and 100 => '76-100',	
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_255(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																					 	 (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 100000  => '1-100,000',
                                                                     (integer)left.#expand(f1) between 100001 and 150000 => '100,001-150,000',
																																		 (integer)left.#expand(f1) between 150001 and 200000 => '150,001-200,000',
																																		 (integer)left.#expand(f1) between 200001 and 300000 => '200,001-300,000',
                                                                     (integer)left.#expand(f1) > 300000 => '>300,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_256(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   			 
																								                     (integer)left.#expand(f1) between 0 and 23 => '0-23',
                                                                     (integer)left.#expand(f1) between 24 and 59 => '24-59',	
																																		 (integer)left.#expand(f1) between 60 and 119 => '60-119',	
																																     (integer)left.#expand(f1) between 120 and 239 => '120-239',	
																																		 (integer)left.#expand(f1) >  240 => '240+',
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_257(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1) =  0 => '0',		 
																								                     (integer)left.#expand(f1) between 1 and 30000 => '1-30,000',
                                                                     (integer)left.#expand(f1) between 30001 and 60000 => '30,001-60,000',	
																																		 (integer)left.#expand(f1) between 60001 and 90000 => '60,001-90,000',	
																																     (integer)left.#expand(f1) between 90001 and 120000 => '90,001-120,000',	
																																		 (integer)left.#expand(f1) >  120000 => '>120,000',
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_258(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1) =  0 => '0',		 
																								                     (integer)left.#expand(f1) < 0 => '<0',
                                                                     (integer)left.#expand(f1) between 1 and 100000 => '1-100,000',	
																																		 (integer)left.#expand(f1) > 100000 => '>100,000',	
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_259(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1) =  0 => '0',		 
																								                     (integer)left.#expand(f1) < -30 => '<(-30)',
                                                                     (integer)left.#expand(f1) between -30 and -1 => '(-30)-(-1)',	
																																		 (integer)left.#expand(f1) between 1 and 30 => '1_30',	
																																		 (integer)left.#expand(f1) > 30 => '>30',	
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_260(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1) =  0 => '0',		 
																								                     (integer)left.#expand(f1) < 0 => '<0',
                                                                     (integer)left.#expand(f1) between 1 and 100 => '1_100',	
																																		 (integer)left.#expand(f1) > 100 => '>100',	
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_261(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1) =  0 => '0',		 
																								                     (integer)left.#expand(f1) < -20000 => '<(-20,000)',
                                                                     (integer)left.#expand(f1) between -20000 and -1 => '(-20,000)-(-1)',	
																																		 (integer)left.#expand(f1) between 1 and 20000 => '1-20,000',
																																		 (integer)left.#expand(f1) > 20000 => '>20,000',	
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_262(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) =  0 => '0',		 
																																		 (integer)left.#expand(f1) between 1 and 150000 => '1-150,000',
																																		 (integer)left.#expand(f1) > 150000 => '>150,000',	
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_263(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1) =  0 => '0',		 
																																		 (integer)left.#expand(f1) between 1 and 120000 => '1-120,000',
																																		 (integer)left.#expand(f1) between 120001 and 200000 => '120,001-200,000',
																																		 (integer)left.#expand(f1) > 200000 => '>200,000',	
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_264(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) =  0 => '0',		 
																																		 (integer)left.#expand(f1) <0 => 'neg val',
																																		 (integer)left.#expand(f1) >0 => 'pos val',
																																		
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_265(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 (integer)left.#expand(f1) =0=> '0',			 
																																	   (integer)left.#expand(f1) between 1 and 40=> '1_40',	
																																		 (integer)left.#expand(f1) >40 => '>40',
																																		
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

 EXPORT range_function_266(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[a-zA-Z]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0, 
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 trim(left.#expand(f1),left,right) in ['S', 's']=> 'S',			 
																																	   trim(left.#expand(f1),left,right) in ['H', 'h']=> 'H',	
																																		 trim(left.#expand(f1),left,right) in ['P', 'p']=> 'P',			 
																																	   trim(left.#expand(f1),left,right) in ['R', 'r']=> 'R',
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_267(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 150000  => '1-150,000',
																																		 (integer)left.#expand(f1) between 150001 and 300000 => '150,001-300,000',
                                                                     (integer)left.#expand(f1) > 300000 => '>300,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_268(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 150000  => '1-150,000',
                                                                     (integer)left.#expand(f1) > 150000 => '>150,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_269(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 (integer)left.#expand(f1) =0=> '0',			 
																																	   (integer)left.#expand(f1) between 1 and 60=> '1_60',	
																																		 (integer)left.#expand(f1) between 61 and 120=> '61-120',	
																																		 (integer)left.#expand(f1) between 121 and 240=> '121-240',	
																																		 (integer)left.#expand(f1) >240 => '>240',
																																		
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_270(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 (integer)left.#expand(f1) =0=> '0',			 
																																	   (integer)left.#expand(f1) between 1 and 40000=> '1-40,000',	
																																		 (integer)left.#expand(f1) between 40001 and 70000=> '40,001-70,000',	
																																		 (integer)left.#expand(f1) between 70001 and 100000=> '70,001-100,000',	
																																		 (integer)left.#expand(f1) >100001 => '>100,001',
																																		
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_Function_271(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 350000  => '1-350,000',
                                                                     (integer)left.#expand(f1) > 350000 => '>350,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_272(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 150000  => '1-150,000',
																																		 (integer)left.#expand(f1) between 150001 and 350000  => '150,001-350,000',
                                                                     (integer)left.#expand(f1) > 350000 => '>350,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


 EXPORT range_function_273(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[a-zA-Z]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0, 
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 trim(left.#expand(f1),left,right) = 'Discharged'=> 'Discharged',	
																																		 trim(left.#expand(f1),left,right) = 'Dismissed'=> 'Dismissed',	
																																		 trim(left.#expand(f1),left,right) = 'Discharge NA'=> 'Discharge NA',	
																																	   trim(left.#expand(f1),left,right) = 'Discharge Granted'=> 'Discharge Granted',	        
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_274(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	    length(trim(left.#expand(f1),left,right))= 10 => 'IsTenDigits', 
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_275(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 33  => '1_33',
                                                                     (integer)left.#expand(f1) between 34 and 67  => '34-67',
																																		 (integer)left.#expand(f1) between 68 and 99  => '68-99',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_276(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 130000  => '1-130,000',
                                                                     (integer)left.#expand(f1) > 130000 => '>130,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_277(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 60  => '1_60',
                                                                     (integer)left.#expand(f1) between 61 and 120  => '61-120',
																																		 (integer)left.#expand(f1) >120  => '>120',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_278(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 40000  => '1-40,000',
																																		 (integer)left.#expand(f1) between 40001 and 80000  => '40,001-80,000',
                                                                     (integer)left.#expand(f1) > 80000 => '>80,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_279(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	    length(trim(left.#expand(f1),left,right))= 2 => '2 digit', 
																																			length(trim(left.#expand(f1),left,right))= 3 => '3 digit', 
																																			length(trim(left.#expand(f1),left,right))= 4 => '4 digit', 
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_280(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																																		 (integer)left.#expand(f1) = 10  => '10',
																																		 (integer)left.#expand(f1) = 12  => '12',
																																		 (integer)left.#expand(f1) = 14  => '14',
																																		 (integer)left.#expand(f1) = 100  => '100',
																																		 (integer)left.#expand(f1) = 103  => '103',
																																		 (integer)left.#expand(f1) = 104  => '104',
																																		 (integer)left.#expand(f1) = 105  => '105',
																																		 (integer)left.#expand(f1) = 106  => '106',
																																		 (integer)left.#expand(f1) = 107  => '107',
																																		 (integer)left.#expand(f1) = 108  => '108',
																																		 (integer)left.#expand(f1) = 109  => '109',
																																		 (integer)left.#expand(f1) = 110  => '110',
																																		 (integer)left.#expand(f1) = 111  => '111',
																																		 (integer)left.#expand(f1) = 180  => '180',
																																	
																							              
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

 EXPORT range_function_281(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[a-zA-Z]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0, 
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 trim(left.#expand(f1),left,right) in ['O', 'o']=> 'O',			 
																																	   trim(left.#expand(f1),left,right) in ['R', 'r']=> 'R',	
																																		 trim(left.#expand(f1),left,right) in ['U', 'u']=> 'U',			 
																																	  
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_282(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 120  => '1_120',
																																		 (integer)left.#expand(f1) between 121 and 240  => '121-240',
																																		 (integer)left.#expand(f1) between 241 and 360  => '241-360',
                                                                   	 (integer)left.#expand(f1) >360  => '>360',
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_283(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																																		 (integer)left.#expand(f1) = 1  => '1',
																																		 (integer)left.#expand(f1) = 2  => '2',
																							                       (integer)left.#expand(f1) between 3 and 999  => '3-999',
																																		
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_284(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																																		 (integer)left.#expand(f1) = 1  => '1',
																							                       (integer)left.#expand(f1) between 2 and 12  => '2_12',
																																		 (integer)left.#expand(f1) between 13 and 84  => '13-84',
																																		 (integer)left.#expand(f1) > 84  => '>84',
																																		
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_285(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																																		 (integer)left.#expand(f1) = -1  => '-1',
																							                       (integer)left.#expand(f1) between 1 and 50  => '1_50',
																																		 (integer)left.#expand(f1) > 50  => '>50',
																																		
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_286(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1) =  0 => '0',		 
																								                     (integer)left.#expand(f1) < -100000 => '<(-100,000)',
                                                                     (integer)left.#expand(f1) between -100000 and -1 => '(-100,000)-(-1)',	
																																		 (integer)left.#expand(f1) between 1 and 100000 => '1-100,000',
																																		 (integer)left.#expand(f1) > 100000 => '>100,000',	
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_287(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) =  0 => '0',		
																																		 (integer)left.#expand(f1) =  1 => '1',	
																								                   
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_288(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   // (integer)left.#expand(f1) =  0 => '0',		
																																		 (integer)left.#expand(f1) =  1 => '1',	
																								                     (integer)left.#expand(f1) =  2 => '2',	
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_289(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																			// length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   // (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 0 and 50  => '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 100  => '51-100',
																																		 (integer)left.#expand(f1) >100  => '>100',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_290(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   			 
																								                     (integer)left.#expand(f1) between 1 and 60 => '1_60',
                                                                     (integer)left.#expand(f1) between 61 and 75 => '61-75',	
																																		 (integer)left.#expand(f1) between 76 and 100 => '76-100',	
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_291(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																			// length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 40000  => '1-40,000',
																																		 (integer)left.#expand(f1) between 40001 and 65000  => '40,001-65,000',
																																		 (integer)left.#expand(f1) between 65001 and 90000  => '65,001-90,000',
																																		 (integer)left.#expand(f1) between 90001 and 120000 => '90,001-120,000',	
																																		 (integer)left.#expand(f1) >  120000 => '>120,000',
                                                                   
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_292(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																	   (integer)left.#expand(f1) =  0 => '0',	
                                                                     (integer)left.#expand(f1) between 1 and 10 => '1_10',	
																																		 (integer)left.#expand(f1) between 11 and 100 => '11_100',	
																																		 (integer)left.#expand(f1) > 100 => '>100',	
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_293(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 160000  => '1-160,000',
                                                                     (integer)left.#expand(f1) > 160000 => '>160,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_294(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																			// length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 150000  => '1-150,000',
																																		 (integer)left.#expand(f1) between 150001 and 300000 => '150,001-300,000',
                                                                     (integer)left.#expand(f1) > 300000 => '>300,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_295(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'NULL', 
																																		 (integer)left.#expand(f1)= 0 => '0',   			 
																								                     (integer)left.#expand(f1) between 1 and 60 => '1_60',
                                                                     (integer)left.#expand(f1) between 61 and 80 => '61-80',	
																																		 (integer)left.#expand(f1) between 81 and 100 => '81-100',	
																																	
                                                                   																															                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_296(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																					 length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 (integer)left.#expand(f1) =0=> '0',			 
																																	   (integer)left.#expand(f1) between 1 and 55000=> '1-55,000',	
																																		 (integer)left.#expand(f1) between 55001 and 75000=> '55,001-75,000',	
																																		 (integer)left.#expand(f1) between 75001 and 100000=> '75,001-100,000',	
																																		 (integer)left.#expand(f1) >100000 => '>100,000',
																																		
																																		                                                                   
                                                                           'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_297(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 45  => '1_45',
                                                                     (integer)left.#expand(f1) between 46 and 75  => '46-75',
																																		 (integer)left.#expand(f1) between 76 and 99  => '76-99',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_298(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 60  => '1_60',
                                                                     (integer)left.#expand(f1) between 61 and 120  => '61-120',
																																		 (integer)left.#expand(f1) between 121 and 180  => '121-180',
																																		 (integer)left.#expand(f1) >180  => '>180',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_Function_299(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   (integer)left.#expand(f1) = 0  => '0',
																							                       (integer)left.#expand(f1) between 1 and 45000  => '1-45,000',
																																		 (integer)left.#expand(f1) between 45001 and 80000  => '45,001-80,000',
                                                                     (integer)left.#expand(f1) > 80000 => '>80,000',
                                                                	
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_Function_300(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(
																																			length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																	   // (integer)left.#expand(f1) = 0  => '0',
																																		 (integer)left.#expand(f1) = 1  => '1',
																							                       (integer)left.#expand(f1) between 2 and 12  => '2_12',
																																		 (integer)left.#expand(f1) between 13 and 72  => '13-72',
																																		 (integer)left.#expand(f1) > 72  => '>72',
																																		
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT distinct_Function_301(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'distinct';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) and length(trim(left.#expand(f1),left,right))<> 0,
                                                                           
																																					 MAP(
																																					 // length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																																		 // (integer)left.#expand(f1) = 0 => '0',   
                                                                     (integer)left.#expand(f1) = 1 => '1',
																																		 (integer)left.#expand(f1) = 2 => '2',																																		 
																																		 (integer)left.#expand(f1) = 3 => '3',
																																		 (integer)left.#expand(f1) = 4 => '4',
                                                                     (integer)left.#expand(f1) = 5 => '5',
																																		 (integer)left.#expand(f1) = 6 => '6',
                                                                    
																																		          'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_302(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',  
																																		 (integer)left.#expand(f1)= 0 => '0',   
																								                     (integer)left.#expand(f1) between 1 and 100 => '1_100',
                                                                   	 (integer)left.#expand(f1) >100 => '>100',
                                                                    
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

//**********************************************************************************************************************************
EXPORT range_function_303(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',  
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																		 (integer)left.#expand(f1)= 1 => '1',   
																								                                                                                    
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_304(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',  
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																		 (integer)left.#expand(f1)= 1 => '1',   
																																		 (integer)left.#expand(f1)= 2 => '2',   
																																		 (integer)left.#expand(f1)= 3 => '3',   
																								                                                
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_305(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',  
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																		 (integer)left.#expand(f1)= 1 => '1',   
																																		 (integer)left.#expand(f1)= 2 => '2',   
																								                      (integer)left.#expand(f1) between 3 and 5 => '3_5',
																																			(integer)left.#expand(f1)= 6 => '6',   
																																		 (integer)left.#expand(f1)= 7 => '7',   
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
//******************************************************************************************************

EXPORT range_function_306(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																		 (integer)left.#expand(f1) between 1 and 9 => '1_9',   
																																		 (integer)left.#expand(f1) between 10 and 19 => '10_19',   
																																		 (integer)left.#expand(f1) between 20 and 39 => '20_39',   
																																		 (integer)left.#expand(f1) between 40 and 89 => '40_89',   
																																		 (integer)left.#expand(f1) between 90 and 255 => '90_255',   
																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_307(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',   
																																		 (integer)left.#expand(f1)= 0 => '0',   
																																		 (integer)left.#expand(f1) between 1 and 9 => '1_9',   
																																		 (integer)left.#expand(f1) between 10 and 19 => '10_19',   
																																		 (integer)left.#expand(f1) between 20 and 39 => '20_39',   
																																		 (integer)left.#expand(f1) between 40 and 89 => '40_89',   
																																		 (integer)left.#expand(f1) between 90 and 254 => '90_254',   
																																		 	(integer)left.#expand(f1)= 255 => '255',   

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_308(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',   
																																		 (integer)left.#expand(f1)= 0 => '0',    
																																		 (integer)left.#expand(f1)= 1 => '1',    
																																		 (integer)left.#expand(f1) between 2 and 255 => '2_255',   
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_309(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1) between 0 and 1 => '0_1',   
																																		 (integer)left.#expand(f1) between 2 and 3 => '2_3',   
																																		 (integer)left.#expand(f1) between 4 and 6 => '4_6',   
																																		 (integer)left.#expand(f1) between 7 and 12 => '7_12',      
																																		 (integer)left.#expand(f1) between 13 and 255 => '13_255',   
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_310(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1) between 0 and 9 => '0_9',   
																																		 (integer)left.#expand(f1) between 10 and 24 => '10_25',   
																																		 (integer)left.#expand(f1) between 25 and 69 => '25_69',   
																																		 (integer)left.#expand(f1) between 70 and 179 => '70_179',      
																																		 (integer)left.#expand(f1) between 180 and 960 => '180_960',   
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_311(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1)= 1 => '1',
																																		 (integer)left.#expand(f1) between 2 and 3 => '2_3',        
																																		 (integer)left.#expand(f1) between 4 and 255 => '4_255',   
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_312(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1) between 1 and 3 => '1_3', 
																																		 (integer)left.#expand(f1)= 4 => '4',
																																		 (integer)left.#expand(f1) between 5 and 7 => '5_7', 
																																		 (integer)left.#expand(f1) between 8 and 255 => '8_255', 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_313(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1) between 1 and 2 => '1_2', 
																																		 (integer)left.#expand(f1)= 3 => '3',
																																		 (integer)left.#expand(f1) between 4 and 5 => '4_5', 
																																		 (integer)left.#expand(f1) between 6 and 255 => '6_255', 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_314(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 
																																		 (integer)left.#expand(f1) between 0 and 1 => '0_1', 
																																		 (integer)left.#expand(f1)= 2 => '2',
																																		 (integer)left.#expand(f1)= 3 => '3',
																																		 (integer)left.#expand(f1) between 4 and 5 => '4_5', 
																																		 (integer)left.#expand(f1) between 6 and 255 => '6_255', 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_315(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 
																																		 (integer)left.#expand(f1) between 1 and 9 => '1_9', 
																																		 (integer)left.#expand(f1) between 10 and 24 => '10_24', 
																																		 (integer)left.#expand(f1) between 25 and 64 => '25_64', 
																																		 (integer)left.#expand(f1) between 65 and 149 => '65_149', 
																																		 (integer)left.#expand(f1) between 150 and 960 => '150_960', 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_316(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 
																																		 (integer)left.#expand(f1) between 0 and 14 => '0_14', 
																																		 (integer)left.#expand(f1) between 15 and 39 => '15_39', 
																																		 (integer)left.#expand(f1) between 40 and 89 => '40_89', 
																																		 (integer)left.#expand(f1) between 90 and 960 => '90_960', 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_317(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 
																																		 (integer)left.#expand(f1) between 0 and 2 => '0_2', 
																																		 (integer)left.#expand(f1) between 3 and 5 => '3_5', 
																																		 (integer)left.#expand(f1) between 6 and 10 => '6_10', 
																																		 (integer)left.#expand(f1) between 11 and 49 => '11_49', 
																																		 (integer)left.#expand(f1) between 50 and 255 => '50_255', 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_318(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1)= 1 => '1',
																																		 
																																		 (integer)left.#expand(f1) between 2 and 9 => '2_9', 
																																		 (integer)left.#expand(f1) between 10 and 39 => '10_39', 
																																		 (integer)left.#expand(f1) between 40 and 255 => '40_255', 
 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_319(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1) between 1 and 9 => '1_9', 
																																		 (integer)left.#expand(f1) between 10 and 19 => '10_19', 
																																		 (integer)left.#expand(f1) between 20 and 39 => '20_39', 
																																		 (integer)left.#expand(f1) between 40 and 255 => '40_255', 
 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_320(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1) between 1 and 7 => '1_7', 
																																		 (integer)left.#expand(f1) between 8 and 15 => '8_15', 
																																		 (integer)left.#expand(f1) between 16 and 34 => '16_34', 
																																		 (integer)left.#expand(f1) between 35 and 255 => '35_255', 
 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_321(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1)= 1 => '1',
																																		 (integer)left.#expand(f1)= 2 => '2', 
																																		 (integer)left.#expand(f1) between 3 and 255 => '3_255', 
 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_322(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1) between 0 and 24 => '0_24', 
																																		 (integer)left.#expand(f1) between 25 and 99 => '25_99', 
																																		 (integer)left.#expand(f1) between 100 and 249 => '100_249', 
																																		 (integer)left.#expand(f1) between 250 and 960 => '250_960', 

 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_323(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);

#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1) between 1 and 2 => '1_2', 
																																		 (integer)left.#expand(f1)= 3 => '3', 
																																		 (integer)left.#expand(f1) between 4 and 5 => '4_5', 
																																		 (integer)left.#expand(f1) between 6 and 8 => '6_8', 
																																		 (integer)left.#expand(f1) between 9 and 255 => '9_255', 

 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_324(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1) between 0 and 3 => '0_3', 
																																		 (integer)left.#expand(f1)= 4 => '4', 
																																		 (integer)left.#expand(f1) between 5 and 6 => '5_6', 
																																		 (integer)left.#expand(f1) between 7 and 255 => '7_255', 

 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_325(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1)= 1 => '1',
																																		 (integer)left.#expand(f1)= 2 => '2',
																																		 (integer)left.#expand(f1) between 3 and 4 => '3_4', 
																																		 (integer)left.#expand(f1) between 5 and 255 => '5_255', 

 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_326(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1) between 0 and 2 => '0_2', 
																																		 (integer)left.#expand(f1)= 3 => '3',
																																		
																																		 (integer)left.#expand(f1) between 4 and 6 => '4_6', 
																																		 (integer)left.#expand(f1) between 7 and 255 => '7_255', 

 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_327(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1) between 0 and 9 => '0_9', 
																																		 (integer)left.#expand(f1) between 10 and 24 => '10_24', 
																																		 (integer)left.#expand(f1) between 25 and 89 => '25_89', 
																																		 (integer)left.#expand(f1) between 90 and 960 => '90_960', 

 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_328(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1) between 0 and 29 => '0_29', 
																																		 (integer)left.#expand(f1) between 30 and 64 => '30_64', 
																																		 (integer)left.#expand(f1) between 65 and 109 => '65_109', 
																																		 (integer)left.#expand(f1) between 110 and 154 => '110_154', 
																																		 (integer)left.#expand(f1) between 155 and 200 => '155_200', 

 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_329(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1) between 1 and 4 => '1_4', 
																																		 (integer)left.#expand(f1) between 5 and 14 => '5_14', 
																																		 (integer)left.#expand(f1) between 15 and 39 => '15_39', 
																																		 (integer)left.#expand(f1) between 40 and 255 => '40_255', 


 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_330(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1)= 1 => '1',
																																		 (integer)left.#expand(f1) between 2 and 3 => '2_3', 
																																		 (integer)left.#expand(f1) between 4 and 14 => '4_14', 
																																		 (integer)left.#expand(f1) between 15 and 255 => '15_255', 



 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_331(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= 0 => '0',
																																		 (integer)left.#expand(f1)= 1 => '1',
																																		 (integer)left.#expand(f1) between 2 and 3 => '2_3', 
																																		 (integer)left.#expand(f1) between 4 and 9 => '4_9', 
																																		 (integer)left.#expand(f1) between 10 and 255 => '10_255', 



 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_332(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',

																																		 (integer)left.#expand(f1) between 0 and 4 => '0_4', 
																																		 (integer)left.#expand(f1) between 5 and 9 => '5_9', 
																																		 (integer)left.#expand(f1) between 10 and 19 => '10_19', 
																																		 (integer)left.#expand(f1) between 20 and 49 => '20_49', 
																																		 (integer)left.#expand(f1) between 50 and 960 => '50_960', 



 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_333(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',

																																		 (integer)left.#expand(f1) between 0 and 24 => '0_24', 
																																		 (integer)left.#expand(f1) between 25 and 99 => '25_99', 
																																		 (integer)left.#expand(f1) between 100 and 299 => '100_299', 
																																		 (integer)left.#expand(f1) between 300 and 960 => '300_960', 




 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

EXPORT range_function_334(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',

																																		 (integer)left.#expand(f1) between 0 and 62 => '0_62', 
																																		 (integer)left.#expand(f1) between 63 and 269 => '63_269', 
																																		 (integer)left.#expand(f1) between 270 and 359 => '270_359', 
																																		 (integer)left.#expand(f1) between 360 and 534 => '360_534', 
																																		 (integer)left.#expand(f1) between 535 and 960 => '535_960', 




 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;


EXPORT range_function_335(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																																					 MAP(length(trim(left.#expand(f1),left,right))= 0 => 'NULL',
																																		 (integer)left.#expand(f1)= -1 => '-1',
																																		 (integer)left.#expand(f1)= 0 => '0',

																																		 (integer)left.#expand(f1) between 1 and 14 => '1_14', 
																																		 (integer)left.#expand(f1) between 15 and 44 => '15_44', 
																																		 (integer)left.#expand(f1) between 45 and 144 => '45_144', 
																																		 (integer)left.#expand(f1) between 145 and 960 => '145_960', 




 
 

																																  
																								                                                                                                                      
																																                                                                   
                                                                             'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
EXPORT range_Function_336(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

#uniquename(cnt)


 // %cnt% := count(%tble%.#EXPAND(f1));
 %cnt% := count(%tble%);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;


							
 #uniquename(Bks_project)
 %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                                           
																													 // MAP(
																													 MAP(
																																length(trim(left.#expand(f1),left,right))= 0 => 'blank', 
																								                     (real)left.#expand(f1)= -1 => '-1',   
																							                     	 (real)left.#expand(f1)= 0 => '0', 
																																			(real)left.#expand(f1) > 0 and (real)left.#expand(f1) <= 2.0 => '0-2.0',
																																	(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '2.0-4.0',
																																	(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 7.0 => '4.0-7.0',
																																	(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 8.4 => '7.0-8.0',
																																		(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 999 => '8.0-999',
																														
																														
																																	// (real)left.#expand(f1) between 0 and 2.0 => '0-2.0',
																																	// (real)left.#expand(f1) between 2.0 and 4.0 => '2.0-4.0',
																																	// (real)left.#expand(f1) between 4.0 and 7.0 => '4.0-7.0',
																																	// (real)left.#expand(f1) between 7.0 and 8.0 => '7.0-8.0',
																																	// (real)left.#expand(f1) between 8.0 and 999 => '8.0-999',
																																	// (string)left.#expand(f1)= '' => 'Blank',
                                                                         'UNDEFINED'),
                                                                           'UNDEFINED'
                                                                          );     
																																					
		
 ));

#uniquename(rc_tab)
%rc_tab% := record
// %Bks_project%.file_version;
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
// decimal20_4 proportion :=count(group)/%cnt%;
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;
end;