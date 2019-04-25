EXPORT test_rvv3_experian_new_bins  := module


EXPORT range_function_1(DS,f1,Result) := MACRO//addrchanges12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_2(DS,f1,Result) := MACRO//addrchanges180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_3(DS,f1,Result) := MACRO//addrchanges24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_4(DS,f1,Result) := MACRO//addrchanges30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_5(DS,f1,Result) := MACRO//addrchanges36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_6(DS,f1,Result) := MACRO//addrchanges60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 255.0 => '> 5.0-255.0',
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



//==================================================================


EXPORT range_function_7(DS,f1,Result) := MACRO//addrchanges90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_8(DS,f1,Result) := MACRO//addrhighrisk

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_9(DS,f1,Result) := MACRO//addrprison

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_10(DS,f1,Result) := MACRO//agenewestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 7.0 => '> 1.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 11.0 => '> 7.0-11.0',
(real)left.#expand(f1) > 11.0 and (real)left.#expand(f1) <= 37.0 => '> 11.0-37.0',
(real)left.#expand(f1) > 37.0 and (real)left.#expand(f1) <= 960.0 => '> 37.0-960.0',
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



//==================================================================


EXPORT range_function_11(DS,f1,Result) := MACRO//ageoldestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 41.0 => '> 0.0-41.0',
(real)left.#expand(f1) > 41.0 and (real)left.#expand(f1) <= 103.0 => '> 41.0-103.0',
(real)left.#expand(f1) > 103.0 and (real)left.#expand(f1) <= 200.0 => '> 103.0-200.0',
(real)left.#expand(f1) > 200.0 and (real)left.#expand(f1) <= 280.0 => '> 200.0-280.0',
(real)left.#expand(f1) > 280.0 and (real)left.#expand(f1) <= 960.0 => '> 280.0-960.0',
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



//==================================================================


EXPORT range_function_12(DS,f1,Result) := MACRO//assesseddiff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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


(real)left.#expand(f1) < -55200.0 and (real)left.#expand(f1) >= -9999999999.0 => '< -55200.0--9999999999.0',

(real)left.#expand(f1) < -1.0 and (real)left.#expand(f1) >= -55200.0 => '< -1.0-55200.0',

(real)left.#expand(f1)= -1.0 => '-1.0',
(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 15500.0 => '> 0.0-15500.0',

(real)left.#expand(f1) > 15500.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 15500.0-9999999999.0',
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



//==================================================================


EXPORT range_function_13(DS,f1,Result) := MACRO//assesseddiff2

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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


(real)left.#expand(f1) < -45400.0 and (real)left.#expand(f1) >= -9999999999.0 => '< -45400.0--9999999999.0',

(real)left.#expand(f1) < -1.0 and (real)left.#expand(f1) >= -45400.0 => '< -1.0-45400.0',

(real)left.#expand(f1)= -1.0 => '-1.0',
(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 24200.0 => '> 0.0-24200.0',

(real)left.#expand(f1) > 24200.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 24200.0-9999999999.0',
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



//==================================================================


EXPORT range_function_14(DS,f1,Result) := MACRO//bankruptcy_count

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_15(DS,f1,Result) := MACRO//bankruptcy_count12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_16(DS,f1,Result) := MACRO//bankruptcy_count180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_17(DS,f1,Result) := MACRO//bankruptcy_count24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_18(DS,f1,Result) := MACRO//bankruptcy_count30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_19(DS,f1,Result) := MACRO//bankruptcy_count36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_20(DS,f1,Result) := MACRO//bankruptcy_count60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_21(DS,f1,Result) := MACRO//bankruptcy_count90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_22(DS,f1,Result) := MACRO//bankruptcyage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 16.0 => '> 0.0-16.0',
(real)left.#expand(f1) > 16.0 and (real)left.#expand(f1) <= 36.0 => '> 16.0-36.0',
(real)left.#expand(f1) > 36.0 and (real)left.#expand(f1) <= 61.0 => '> 36.0-61.0',
(real)left.#expand(f1) > 61.0 and (real)left.#expand(f1) <= 86.0 => '> 61.0-86.0',
(real)left.#expand(f1) > 86.0 and (real)left.#expand(f1) <= 120.0 => '> 86.0-120.0',
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



//==================================================================


EXPORT range_function_23(DS,f1,Result) := MACRO//bestreportedage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 23.0 => '> 0.0-23.0',
(real)left.#expand(f1) > 23.0 and (real)left.#expand(f1) <= 29.0 => '> 23.0-29.0',
(real)left.#expand(f1) > 29.0 and (real)left.#expand(f1) <= 39.0 => '> 29.0-39.0',
(real)left.#expand(f1) > 39.0 and (real)left.#expand(f1) <= 52.0 => '> 39.0-52.0',
(real)left.#expand(f1) > 52.0 and (real)left.#expand(f1) <= 150.0 => '> 52.0-150.0',
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



//==================================================================


EXPORT range_function_24(DS,f1,Result) := MACRO//caagelastsale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 22.0 => '> 0.0-22.0',
(real)left.#expand(f1) > 22.0 and (real)left.#expand(f1) <= 53.0 => '> 22.0-53.0',
(real)left.#expand(f1) > 53.0 and (real)left.#expand(f1) <= 94.0 => '> 53.0-94.0',
(real)left.#expand(f1) > 94.0 and (real)left.#expand(f1) <= 152.0 => '> 94.0-152.0',
(real)left.#expand(f1) > 152.0 and (real)left.#expand(f1) <= 960.0 => '> 152.0-960.0',
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



//==================================================================


EXPORT range_function_25(DS,f1,Result) := MACRO//caagenewestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 6.0 => '> 1.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 10.0 => '> 6.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 20.0 => '> 10.0-20.0',
(real)left.#expand(f1) > 20.0 and (real)left.#expand(f1) <= 960.0 => '> 20.0-960.0',
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



//==================================================================


EXPORT range_function_26(DS,f1,Result) := MACRO//caageoldestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 13.0 => '> 0.0-13.0',
(real)left.#expand(f1) > 13.0 and (real)left.#expand(f1) <= 32.0 => '> 13.0-32.0',
(real)left.#expand(f1) > 32.0 and (real)left.#expand(f1) <= 60.0 => '> 32.0-60.0',
(real)left.#expand(f1) > 60.0 and (real)left.#expand(f1) <= 148.0 => '> 60.0-148.0',
(real)left.#expand(f1) > 148.0 and (real)left.#expand(f1) <= 960.0 => '> 148.0-960.0',
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



//==================================================================


EXPORT range_function_27(DS,f1,Result) := MACRO//caassessedvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 55670.0 => '> 0.0-55670.0',
(real)left.#expand(f1) > 55670.0 and (real)left.#expand(f1) <= 99700.0 => '> 55670.0-99700.0',
(real)left.#expand(f1) > 99700.0 and (real)left.#expand(f1) <= 156200.0 => '> 99700.0-156200.0',
(real)left.#expand(f1) > 156200.0 and (real)left.#expand(f1) <= 264000.0 => '> 156200.0-264000.0',
(real)left.#expand(f1) > 264000.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 264000.0-9999999999.0',
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



//==================================================================


EXPORT range_function_28(DS,f1,Result) := MACRO//cafamilyowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_29(DS,f1,Result) := MACRO//calandusecode

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
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



//==================================================================


EXPORT range_function_30(DS,f1,Result) := MACRO//calastsaleamount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 37500.0 => '> 0.0-37500.0',
(real)left.#expand(f1) > 37500.0 and (real)left.#expand(f1) <= 86000.0 => '> 37500.0-86000.0',
(real)left.#expand(f1) > 86000.0 and (real)left.#expand(f1) <= 154900.0 => '> 86000.0-154900.0',
(real)left.#expand(f1) > 154900.0 and (real)left.#expand(f1) <= 273000.0 => '> 154900.0-273000.0',
(real)left.#expand(f1) > 273000.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 273000.0-9999999999.0',
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



//==================================================================


EXPORT range_function_31(DS,f1,Result) := MACRO//calenofres

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 12.0 => '> 0.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 31.0 => '> 12.0-31.0',
(real)left.#expand(f1) > 31.0 and (real)left.#expand(f1) <= 59.0 => '> 31.0-59.0',
(real)left.#expand(f1) > 59.0 and (real)left.#expand(f1) <= 146.0 => '> 59.0-146.0',
(real)left.#expand(f1) > 146.0 and (real)left.#expand(f1) <= 960.0 => '> 146.0-960.0',
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



//==================================================================


EXPORT range_function_32(DS,f1,Result) := MACRO//canotprimaryres

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_33(DS,f1,Result) := MACRO//caoccupantowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_34(DS,f1,Result) := MACRO//caownedbysubject

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_35(DS,f1,Result) := MACRO//caphonelisted

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 2.0 => '> 0.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
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



//==================================================================


EXPORT range_function_36(DS,f1,Result) := MACRO//correctedflag

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_37(DS,f1,Result) := MACRO//curraddravmconfidence

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 55.0 => '> 0.0-55.0',
(real)left.#expand(f1) > 55.0 and (real)left.#expand(f1) <= 66.0 => '> 55.0-66.0',
(real)left.#expand(f1) > 66.0 and (real)left.#expand(f1) <= 74.0 => '> 66.0-74.0',
(real)left.#expand(f1) > 74.0 and (real)left.#expand(f1) <= 82.0 => '> 74.0-82.0',
(real)left.#expand(f1) > 82.0 and (real)left.#expand(f1) <= 99.0 => '> 82.0-99.0',
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



//==================================================================


EXPORT range_function_38(DS,f1,Result) := MACRO//curraddravmhedonic

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 99900.0 => '> 0.0-99900.0',
(real)left.#expand(f1) > 99900.0 and (real)left.#expand(f1) <= 168000.0 => '> 99900.0-168000.0',
(real)left.#expand(f1) > 168000.0 and (real)left.#expand(f1) <= 248900.0 => '> 168000.0-248900.0',
(real)left.#expand(f1) > 248900.0 and (real)left.#expand(f1) <= 379990.0 => '> 248900.0-379990.0',
(real)left.#expand(f1) > 379990.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 379990.0-9999999999.0',
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



//==================================================================


EXPORT range_function_39(DS,f1,Result) := MACRO//curraddravmsalesprice

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 83478.0 => '> 0.0-83478.0',
(real)left.#expand(f1) > 83478.0 and (real)left.#expand(f1) <= 150115.0 => '> 83478.0-150115.0',
(real)left.#expand(f1) > 150115.0 and (real)left.#expand(f1) <= 227136.0 => '> 150115.0-227136.0',
(real)left.#expand(f1) > 227136.0 and (real)left.#expand(f1) <= 361016.0 => '> 227136.0-361016.0',
(real)left.#expand(f1) > 361016.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 361016.0-9999999999.0',
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



//==================================================================


EXPORT range_function_40(DS,f1,Result) := MACRO//curraddravmtax

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 85145.0 => '> 0.0-85145.0',
(real)left.#expand(f1) > 85145.0 and (real)left.#expand(f1) <= 152563.0 => '> 85145.0-152563.0',
(real)left.#expand(f1) > 152563.0 and (real)left.#expand(f1) <= 227308.0 => '> 152563.0-227308.0',
(real)left.#expand(f1) > 227308.0 and (real)left.#expand(f1) <= 352599.0 => '> 227308.0-352599.0',
(real)left.#expand(f1) > 352599.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 352599.0-9999999999.0',
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



//==================================================================


EXPORT range_function_41(DS,f1,Result) := MACRO//curraddravmvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 84500.0 => '> 0.0-84500.0',
(real)left.#expand(f1) > 84500.0 and (real)left.#expand(f1) <= 151632.0 => '> 84500.0-151632.0',
(real)left.#expand(f1) > 151632.0 and (real)left.#expand(f1) <= 226953.0 => '> 151632.0-226953.0',
(real)left.#expand(f1) > 226953.0 and (real)left.#expand(f1) <= 351658.0 => '> 226953.0-351658.0',
(real)left.#expand(f1) > 351658.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 351658.0-9999999999.0',
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



//==================================================================


EXPORT range_function_42(DS,f1,Result) := MACRO//curraddrblockindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.74 => '> 0.0-0.74',
(real)left.#expand(f1) > 0.74 and (real)left.#expand(f1) <= 0.93 => '> 0.74-0.93',
(real)left.#expand(f1) > 0.93 and (real)left.#expand(f1) <= 1.04 => '> 0.93-1.04',
(real)left.#expand(f1) > 1.04 and (real)left.#expand(f1) <= 1.26 => '> 1.04-1.26',
(real)left.#expand(f1) > 1.26 and (real)left.#expand(f1) <= 99.0 => '> 1.26-99.0',
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



//==================================================================


EXPORT range_function_43(DS,f1,Result) := MACRO//curraddrcountyindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.54 => '> 0.0-0.54',
(real)left.#expand(f1) > 0.54 and (real)left.#expand(f1) <= 0.79 => '> 0.54-0.79',
(real)left.#expand(f1) > 0.79 and (real)left.#expand(f1) <= 1.0 => '> 0.79-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 1.34 => '> 1.0-1.34',
(real)left.#expand(f1) > 1.34 and (real)left.#expand(f1) <= 99.0 => '> 1.34-99.0',
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



//==================================================================


EXPORT range_function_44(DS,f1,Result) := MACRO//curraddrtaxmarketvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 64400.0 => '> 0.0-64400.0',
(real)left.#expand(f1) > 64400.0 and (real)left.#expand(f1) <= 108000.0 => '> 64400.0-108000.0',
(real)left.#expand(f1) > 108000.0 and (real)left.#expand(f1) <= 163600.0 => '> 108000.0-163600.0',
(real)left.#expand(f1) > 163600.0 and (real)left.#expand(f1) <= 254900.0 => '> 163600.0-254900.0',
(real)left.#expand(f1) > 254900.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 254900.0-9999999999.0',
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



//==================================================================


EXPORT range_function_45(DS,f1,Result) := MACRO//curraddrtractindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.76 => '> 0.0-0.76',
(real)left.#expand(f1) > 0.76 and (real)left.#expand(f1) <= 0.94 => '> 0.76-0.94',
(real)left.#expand(f1) > 0.94 and (real)left.#expand(f1) <= 1.03 => '> 0.94-1.03',
(real)left.#expand(f1) > 1.03 and (real)left.#expand(f1) <= 1.22 => '> 1.03-1.22',
(real)left.#expand(f1) > 1.22 and (real)left.#expand(f1) <= 99.0 => '> 1.22-99.0',
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



//==================================================================


EXPORT range_function_46(DS,f1,Result) := MACRO//derogage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 12.0 => '> 0.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 25.0 => '> 12.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 44.0 => '> 25.0-44.0',
(real)left.#expand(f1) > 44.0 and (real)left.#expand(f1) <= 66.0 => '> 44.0-66.0',
(real)left.#expand(f1) > 66.0 and (real)left.#expand(f1) <= 120.0 => '> 66.0-120.0',
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



//==================================================================


EXPORT range_function_47(DS,f1,Result) := MACRO//diffstate

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_48(DS,f1,Result) := MACRO//diffstate2

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_49(DS,f1,Result) := MACRO//distcurrprev

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 3.0 => '> 0.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 7.0 => '> 3.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 17.0 => '> 7.0-17.0',
(real)left.#expand(f1) > 17.0 and (real)left.#expand(f1) <= 145.0 => '> 17.0-145.0',
(real)left.#expand(f1) > 145.0 and (real)left.#expand(f1) <= 9999.0 => '> 145.0-9999.0',
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



//==================================================================


EXPORT range_function_50(DS,f1,Result) := MACRO//distinputcurr

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 4.0 => '> 0.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 9.0 => '> 4.0-9.0',
(real)left.#expand(f1) > 9.0 and (real)left.#expand(f1) <= 25.0 => '> 9.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 230.0 => '> 25.0-230.0',
(real)left.#expand(f1) > 230.0 and (real)left.#expand(f1) <= 9999.0 => '> 230.0-9999.0',
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



//==================================================================


EXPORT range_function_51(DS,f1,Result) := MACRO//educationattendedcollege

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_52(DS,f1,Result) := MACRO//educationinstitutionprivate

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_53(DS,f1,Result) := MACRO//educationinstitutionrating

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 2.0 => '> 0.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 6.0 => '> 5.0-6.0',
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



//==================================================================


EXPORT range_function_54(DS,f1,Result) := MACRO//educationprogram2yr

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_55(DS,f1,Result) := MACRO//educationprogram4yr

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_56(DS,f1,Result) := MACRO//educationprogramgraduate

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_57(DS,f1,Result) := MACRO//eviction_count

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 255.0 => '> 5.0-255.0',
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



//==================================================================


EXPORT range_function_58(DS,f1,Result) := MACRO//eviction_count12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_59(DS,f1,Result) := MACRO//eviction_count180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_60(DS,f1,Result) := MACRO//eviction_count24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_61(DS,f1,Result) := MACRO//eviction_count30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_62(DS,f1,Result) := MACRO//eviction_count36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_63(DS,f1,Result) := MACRO//eviction_count60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 255.0 => '> 5.0-255.0',
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



//==================================================================


EXPORT range_function_64(DS,f1,Result) := MACRO//eviction_count90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_65(DS,f1,Result) := MACRO//evictionage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 14.0 => '> 0.0-14.0',
(real)left.#expand(f1) > 14.0 and (real)left.#expand(f1) <= 27.0 => '> 14.0-27.0',
(real)left.#expand(f1) > 27.0 and (real)left.#expand(f1) <= 43.0 => '> 27.0-43.0',
(real)left.#expand(f1) > 43.0 and (real)left.#expand(f1) <= 63.0 => '> 43.0-63.0',
(real)left.#expand(f1) > 63.0 and (real)left.#expand(f1) <= 84.0 => '> 63.0-84.0',
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



//==================================================================


EXPORT range_function_66(DS,f1,Result) := MACRO//felonies

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_67(DS,f1,Result) := MACRO//felonies12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_68(DS,f1,Result) := MACRO//felonies180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_69(DS,f1,Result) := MACRO//felonies24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_70(DS,f1,Result) := MACRO//felonies30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_71(DS,f1,Result) := MACRO//felonies36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_72(DS,f1,Result) := MACRO//felonies60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_73(DS,f1,Result) := MACRO//felonies90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_74(DS,f1,Result) := MACRO//felonyage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 15.0 => '> 0.0-15.0',
(real)left.#expand(f1) > 15.0 and (real)left.#expand(f1) <= 30.0 => '> 15.0-30.0',
(real)left.#expand(f1) > 30.0 and (real)left.#expand(f1) <= 46.0 => '> 30.0-46.0',
(real)left.#expand(f1) > 46.0 and (real)left.#expand(f1) <= 64.0 => '> 46.0-64.0',
(real)left.#expand(f1) > 64.0 and (real)left.#expand(f1) <= 84.0 => '> 64.0-84.0',
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



//==================================================================


EXPORT range_function_75(DS,f1,Result) := MACRO//iaagelastsale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 24.0 => '> 0.0-24.0',
(real)left.#expand(f1) > 24.0 and (real)left.#expand(f1) <= 56.0 => '> 24.0-56.0',
(real)left.#expand(f1) > 56.0 and (real)left.#expand(f1) <= 98.0 => '> 56.0-98.0',
(real)left.#expand(f1) > 98.0 and (real)left.#expand(f1) <= 153.0 => '> 98.0-153.0',
(real)left.#expand(f1) > 153.0 and (real)left.#expand(f1) <= 960.0 => '> 153.0-960.0',
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



//==================================================================


EXPORT range_function_76(DS,f1,Result) := MACRO//iaagenewestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 8.0 => '> 1.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 13.0 => '> 8.0-13.0',
(real)left.#expand(f1) > 13.0 and (real)left.#expand(f1) <= 26.0 => '> 13.0-26.0',
(real)left.#expand(f1) > 26.0 and (real)left.#expand(f1) <= 960.0 => '> 26.0-960.0',
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



//==================================================================


EXPORT range_function_77(DS,f1,Result) := MACRO//iaageoldestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 25.0 => '> 0.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 40.0 => '> 25.0-40.0',
(real)left.#expand(f1) > 40.0 and (real)left.#expand(f1) <= 72.0 => '> 40.0-72.0',
(real)left.#expand(f1) > 72.0 and (real)left.#expand(f1) <= 159.0 => '> 72.0-159.0',
(real)left.#expand(f1) > 159.0 and (real)left.#expand(f1) <= 960.0 => '> 159.0-960.0',
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



//==================================================================


EXPORT range_function_78(DS,f1,Result) := MACRO//iaassessedvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 54790.0 => '> 0.0-54790.0',
(real)left.#expand(f1) > 54790.0 and (real)left.#expand(f1) <= 102000.0 => '> 54790.0-102000.0',
(real)left.#expand(f1) > 102000.0 and (real)left.#expand(f1) <= 160900.0 => '> 102000.0-160900.0',
(real)left.#expand(f1) > 160900.0 and (real)left.#expand(f1) <= 275600.0 => '> 160900.0-275600.0',
(real)left.#expand(f1) > 275600.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 275600.0-9999999999.0',
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



//==================================================================


EXPORT range_function_79(DS,f1,Result) := MACRO//iafamilyowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_80(DS,f1,Result) := MACRO//ialandusecode

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
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



//==================================================================


EXPORT range_function_81(DS,f1,Result) := MACRO//ialastsaleamount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 34900.0 => '> 0.0-34900.0',
(real)left.#expand(f1) > 34900.0 and (real)left.#expand(f1) <= 83500.0 => '> 34900.0-83500.0',
(real)left.#expand(f1) > 83500.0 and (real)left.#expand(f1) <= 154000.0 => '> 83500.0-154000.0',
(real)left.#expand(f1) > 154000.0 and (real)left.#expand(f1) <= 269900.0 => '> 154000.0-269900.0',
(real)left.#expand(f1) > 269900.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 269900.0-9999999999.0',
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



//==================================================================


EXPORT range_function_82(DS,f1,Result) := MACRO//ialenofres

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 16.0 => '> 0.0-16.0',
(real)left.#expand(f1) > 16.0 and (real)left.#expand(f1) <= 35.0 => '> 16.0-35.0',
(real)left.#expand(f1) > 35.0 and (real)left.#expand(f1) <= 63.0 => '> 35.0-63.0',
(real)left.#expand(f1) > 63.0 and (real)left.#expand(f1) <= 153.0 => '> 63.0-153.0',
(real)left.#expand(f1) > 153.0 and (real)left.#expand(f1) <= 960.0 => '> 153.0-960.0',
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



//==================================================================


EXPORT range_function_83(DS,f1,Result) := MACRO//ianotprimaryres

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_84(DS,f1,Result) := MACRO//iaoccupantowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_85(DS,f1,Result) := MACRO//iaownedbysubject

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_86(DS,f1,Result) := MACRO//iaphonelisted

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 2.0 => '> 0.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
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



//==================================================================


EXPORT range_function_87(DS,f1,Result) := MACRO//idtheftflag

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_88(DS,f1,Result) := MACRO//inferredminimumage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 22.0 => '> 0.0-22.0',
(real)left.#expand(f1) > 22.0 and (real)left.#expand(f1) <= 28.0 => '> 22.0-28.0',
(real)left.#expand(f1) > 28.0 and (real)left.#expand(f1) <= 39.0 => '> 28.0-39.0',
(real)left.#expand(f1) > 39.0 and (real)left.#expand(f1) <= 52.0 => '> 39.0-52.0',
(real)left.#expand(f1) > 52.0 and (real)left.#expand(f1) <= 150.0 => '> 52.0-150.0',
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



//==================================================================


EXPORT range_function_89(DS,f1,Result) := MACRO//inputaddravmconfidence

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 55.0 => '> 0.0-55.0',
(real)left.#expand(f1) > 55.0 and (real)left.#expand(f1) <= 66.0 => '> 55.0-66.0',
(real)left.#expand(f1) > 66.0 and (real)left.#expand(f1) <= 73.0 => '> 66.0-73.0',
(real)left.#expand(f1) > 73.0 and (real)left.#expand(f1) <= 80.0 => '> 73.0-80.0',
(real)left.#expand(f1) > 80.0 and (real)left.#expand(f1) <= 99.0 => '> 80.0-99.0',
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



//==================================================================


EXPORT range_function_90(DS,f1,Result) := MACRO//inputaddravmhedonic

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 100000.0 => '> 0.0-100000.0',
(real)left.#expand(f1) > 100000.0 and (real)left.#expand(f1) <= 169900.0 => '> 100000.0-169900.0',
(real)left.#expand(f1) > 169900.0 and (real)left.#expand(f1) <= 250000.0 => '> 169900.0-250000.0',
(real)left.#expand(f1) > 250000.0 and (real)left.#expand(f1) <= 380000.0 => '> 250000.0-380000.0',
(real)left.#expand(f1) > 380000.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 380000.0-9999999999.0',
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



//==================================================================


EXPORT range_function_91(DS,f1,Result) := MACRO//inputaddravmsalesprice

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 82328.0 => '> 0.0-82328.0',
(real)left.#expand(f1) > 82328.0 and (real)left.#expand(f1) <= 150909.0 => '> 82328.0-150909.0',
(real)left.#expand(f1) > 150909.0 and (real)left.#expand(f1) <= 227010.0 => '> 150909.0-227010.0',
(real)left.#expand(f1) > 227010.0 and (real)left.#expand(f1) <= 360740.0 => '> 227010.0-360740.0',
(real)left.#expand(f1) > 360740.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 360740.0-9999999999.0',
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



//==================================================================


EXPORT range_function_92(DS,f1,Result) := MACRO//inputaddravmtax

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 85679.0 => '> 0.0-85679.0',
(real)left.#expand(f1) > 85679.0 and (real)left.#expand(f1) <= 153353.0 => '> 85679.0-153353.0',
(real)left.#expand(f1) > 153353.0 and (real)left.#expand(f1) <= 228834.0 => '> 153353.0-228834.0',
(real)left.#expand(f1) > 228834.0 and (real)left.#expand(f1) <= 354733.0 => '> 228834.0-354733.0',
(real)left.#expand(f1) > 354733.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 354733.0-9999999999.0',
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



//==================================================================


EXPORT range_function_93(DS,f1,Result) := MACRO//inputaddravmvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 84391.0 => '> 0.0-84391.0',
(real)left.#expand(f1) > 84391.0 and (real)left.#expand(f1) <= 151347.0 => '> 84391.0-151347.0',
(real)left.#expand(f1) > 151347.0 and (real)left.#expand(f1) <= 227941.0 => '> 151347.0-227941.0',
(real)left.#expand(f1) > 227941.0 and (real)left.#expand(f1) <= 354993.0 => '> 227941.0-354993.0',
(real)left.#expand(f1) > 354993.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 354993.0-9999999999.0',
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



//==================================================================


EXPORT range_function_94(DS,f1,Result) := MACRO//inputaddrblockindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.73 => '> 0.0-0.73',
(real)left.#expand(f1) > 0.73 and (real)left.#expand(f1) <= 0.93 => '> 0.73-0.93',
(real)left.#expand(f1) > 0.93 and (real)left.#expand(f1) <= 1.05 => '> 0.93-1.05',
(real)left.#expand(f1) > 1.05 and (real)left.#expand(f1) <= 1.28 => '> 1.05-1.28',
(real)left.#expand(f1) > 1.28 and (real)left.#expand(f1) <= 99.0 => '> 1.28-99.0',
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



//==================================================================


EXPORT range_function_95(DS,f1,Result) := MACRO//inputaddrcountyindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.55 => '> 0.0-0.55',
(real)left.#expand(f1) > 0.55 and (real)left.#expand(f1) <= 0.79 => '> 0.55-0.79',
(real)left.#expand(f1) > 0.79 and (real)left.#expand(f1) <= 1.01 => '> 0.79-1.01',
(real)left.#expand(f1) > 1.01 and (real)left.#expand(f1) <= 1.36 => '> 1.01-1.36',
(real)left.#expand(f1) > 1.36 and (real)left.#expand(f1) <= 99.0 => '> 1.36-99.0',
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



//==================================================================


EXPORT range_function_96(DS,f1,Result) := MACRO//inputaddridentitiescount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 5.0 => '> 0.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 8.0 => '> 5.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 12.0 => '> 8.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 18.0 => '> 12.0-18.0',
(real)left.#expand(f1) > 18.0 and (real)left.#expand(f1) <= 255.0 => '> 18.0-255.0',
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



//==================================================================


EXPORT range_function_97(DS,f1,Result) := MACRO//inputaddridentitiesrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_98(DS,f1,Result) := MACRO//inputaddrphonecount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 5.0 => '> 2.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 12.0 => '> 5.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 255.0 => '> 12.0-255.0',
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



//==================================================================


EXPORT range_function_99(DS,f1,Result) := MACRO//inputaddrphonerecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 6.0 => '> 3.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 255.0 => '> 6.0-255.0',
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



//==================================================================


EXPORT range_function_100(DS,f1,Result) := MACRO//inputaddrssncount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 3.0 => '> 0.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 6.0 => '> 3.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 9.0 => '> 6.0-9.0',
(real)left.#expand(f1) > 9.0 and (real)left.#expand(f1) <= 14.0 => '> 9.0-14.0',
(real)left.#expand(f1) > 14.0 and (real)left.#expand(f1) <= 255.0 => '> 14.0-255.0',
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



//==================================================================


EXPORT range_function_101(DS,f1,Result) := MACRO//inputaddrssnrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_102(DS,f1,Result) := MACRO//inputaddrtaxmarketvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 64730.0 => '> 0.0-64730.0',
(real)left.#expand(f1) > 64730.0 and (real)left.#expand(f1) <= 108482.0 => '> 64730.0-108482.0',
(real)left.#expand(f1) > 108482.0 and (real)left.#expand(f1) <= 163990.0 => '> 108482.0-163990.0',
(real)left.#expand(f1) > 163990.0 and (real)left.#expand(f1) <= 257692.0 => '> 163990.0-257692.0',
(real)left.#expand(f1) > 257692.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 257692.0-9999999999.0',
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



//==================================================================


EXPORT range_function_103(DS,f1,Result) := MACRO//inputaddrtractindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.75 => '> 0.0-0.75',
(real)left.#expand(f1) > 0.75 and (real)left.#expand(f1) <= 0.94 => '> 0.75-0.94',
(real)left.#expand(f1) > 0.94 and (real)left.#expand(f1) <= 1.04 => '> 0.94-1.04',
(real)left.#expand(f1) > 1.04 and (real)left.#expand(f1) <= 1.25 => '> 1.04-1.25',
(real)left.#expand(f1) > 1.25 and (real)left.#expand(f1) <= 99.0 => '> 1.25-99.0',
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



//==================================================================


EXPORT range_function_104(DS,f1,Result) := MACRO//inputcurrmatch

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_105(DS,f1,Result) := MACRO//inputprevmatch

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_106(DS,f1,Result) := MACRO//invalidaddr

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_107(DS,f1,Result) := MACRO//invalidphone

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_108(DS,f1,Result) := MACRO//invalidssn

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_109(DS,f1,Result) := MACRO//isnover

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_110(DS,f1,Result) := MACRO//isrecentupdate

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_111(DS,f1,Result) := MACRO//issued3

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_112(DS,f1,Result) := MACRO//issuedage5

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_113(DS,f1,Result) := MACRO//lienfederaltaxfiledcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_114(DS,f1,Result) := MACRO//lienfederaltaxfiledtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 11812.0 => '> 0.0-11812.0',
(real)left.#expand(f1) > 11812.0 and (real)left.#expand(f1) <= 16160.0 => '> 11812.0-16160.0',
(real)left.#expand(f1) > 16160.0 and (real)left.#expand(f1) <= 33482.0 => '> 16160.0-33482.0',
(real)left.#expand(f1) > 33482.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 33482.0-9999999999.0',
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



//==================================================================


EXPORT range_function_115(DS,f1,Result) := MACRO//lienfederaltaxreleasedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_116(DS,f1,Result) := MACRO//lienfederaltaxreleasedtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1727.0 => '> 0.0-1727.0',
(real)left.#expand(f1) > 1727.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 1727.0-9999999999.0',
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



//==================================================================


EXPORT range_function_117(DS,f1,Result) := MACRO//lienfiledage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 12.0 => '> 0.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 25.0 => '> 12.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 43.0 => '> 25.0-43.0',
(real)left.#expand(f1) > 43.0 and (real)left.#expand(f1) <= 64.0 => '> 43.0-64.0',
(real)left.#expand(f1) > 64.0 and (real)left.#expand(f1) <= 84.0 => '> 64.0-84.0',
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



//==================================================================


EXPORT range_function_118(DS,f1,Result) := MACRO//lienforeclosurefiledcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_119(DS,f1,Result) := MACRO//lienforeclosurefiledtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_120(DS,f1,Result) := MACRO//lienforeclosurereleasedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_121(DS,f1,Result) := MACRO//lienforeclosurereleasedtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_122(DS,f1,Result) := MACRO//lienjudgmentfiledcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 255.0 => '> 5.0-255.0',
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



//==================================================================


EXPORT range_function_123(DS,f1,Result) := MACRO//lienjudgmentfiledtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1006.0 => '> 0.0-1006.0',
(real)left.#expand(f1) > 1006.0 and (real)left.#expand(f1) <= 1954.0 => '> 1006.0-1954.0',
(real)left.#expand(f1) > 1954.0 and (real)left.#expand(f1) <= 3738.0 => '> 1954.0-3738.0',
(real)left.#expand(f1) > 3738.0 and (real)left.#expand(f1) <= 7676.0 => '> 3738.0-7676.0',
(real)left.#expand(f1) > 7676.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 7676.0-9999999999.0',
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



//==================================================================


EXPORT range_function_124(DS,f1,Result) := MACRO//lienjudgmentreleasedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_125(DS,f1,Result) := MACRO//lienjudgmentreleasedtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 643.0 => '> 0.0-643.0',
(real)left.#expand(f1) > 643.0 and (real)left.#expand(f1) <= 1014.0 => '> 643.0-1014.0',
(real)left.#expand(f1) > 1014.0 and (real)left.#expand(f1) <= 1690.0 => '> 1014.0-1690.0',
(real)left.#expand(f1) > 1690.0 and (real)left.#expand(f1) <= 3280.0 => '> 1690.0-3280.0',
(real)left.#expand(f1) > 3280.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 3280.0-9999999999.0',
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



//==================================================================


EXPORT range_function_126(DS,f1,Result) := MACRO//lienlandlordtenantfiledcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_127(DS,f1,Result) := MACRO//lienlandlordtenantfiledtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_128(DS,f1,Result) := MACRO//lienlandlordtenantreleasedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_129(DS,f1,Result) := MACRO//lienlandlordtenantreleasedtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_130(DS,f1,Result) := MACRO//lienotherfiledcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_131(DS,f1,Result) := MACRO//lienotherfiledtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1454.0 => '> 0.0-1454.0',
(real)left.#expand(f1) > 1454.0 and (real)left.#expand(f1) <= 1757.0 => '> 1454.0-1757.0',
(real)left.#expand(f1) > 1757.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 1757.0-9999999999.0',
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



//==================================================================


EXPORT range_function_132(DS,f1,Result) := MACRO//lienotherreleasedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_133(DS,f1,Result) := MACRO//lienotherreleasedtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 0.0-9999999999.0',
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



//==================================================================


EXPORT range_function_134(DS,f1,Result) := MACRO//lienpreforeclosurefiledcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_135(DS,f1,Result) := MACRO//lienpreforeclosurefiledtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_136(DS,f1,Result) := MACRO//lienpreforeclosurereleasedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_137(DS,f1,Result) := MACRO//lienpreforeclosurereleasedtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_138(DS,f1,Result) := MACRO//lienreleasedage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 25.0 => '> 0.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 43.0 => '> 25.0-43.0',
(real)left.#expand(f1) > 43.0 and (real)left.#expand(f1) <= 58.0 => '> 43.0-58.0',
(real)left.#expand(f1) > 58.0 and (real)left.#expand(f1) <= 71.0 => '> 58.0-71.0',
(real)left.#expand(f1) > 71.0 and (real)left.#expand(f1) <= 84.0 => '> 71.0-84.0',
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



//==================================================================


EXPORT range_function_139(DS,f1,Result) := MACRO//liensmallclaimsfiledcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_140(DS,f1,Result) := MACRO//liensmallclaimsfiledtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 664.0 => '> 0.0-664.0',
(real)left.#expand(f1) > 664.0 and (real)left.#expand(f1) <= 1346.0 => '> 664.0-1346.0',
(real)left.#expand(f1) > 1346.0 and (real)left.#expand(f1) <= 2304.0 => '> 1346.0-2304.0',
(real)left.#expand(f1) > 2304.0 and (real)left.#expand(f1) <= 3759.0 => '> 2304.0-3759.0',
(real)left.#expand(f1) > 3759.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 3759.0-9999999999.0',
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



//==================================================================


EXPORT range_function_141(DS,f1,Result) := MACRO//liensmallclaimsreleasedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_142(DS,f1,Result) := MACRO//liensmallclaimsreleasedtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 466.0 => '> 0.0-466.0',
(real)left.#expand(f1) > 466.0 and (real)left.#expand(f1) <= 932.0 => '> 466.0-932.0',
(real)left.#expand(f1) > 932.0 and (real)left.#expand(f1) <= 1454.0 => '> 932.0-1454.0',
(real)left.#expand(f1) > 1454.0 and (real)left.#expand(f1) <= 2322.0 => '> 1454.0-2322.0',
(real)left.#expand(f1) > 2322.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 2322.0-9999999999.0',
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



//==================================================================


EXPORT range_function_143(DS,f1,Result) := MACRO//lientaxotherfiledcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_144(DS,f1,Result) := MACRO//lientaxotherfiledtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 395.0 => '> 0.0-395.0',
(real)left.#expand(f1) > 395.0 and (real)left.#expand(f1) <= 960.0 => '> 395.0-960.0',
(real)left.#expand(f1) > 960.0 and (real)left.#expand(f1) <= 1720.0 => '> 960.0-1720.0',
(real)left.#expand(f1) > 1720.0 and (real)left.#expand(f1) <= 3895.0 => '> 1720.0-3895.0',
(real)left.#expand(f1) > 3895.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 3895.0-9999999999.0',
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



//==================================================================


EXPORT range_function_145(DS,f1,Result) := MACRO//lientaxotherreleasedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_146(DS,f1,Result) := MACRO//lientaxotherreleasedtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 257.0 => '> 0.0-257.0',
(real)left.#expand(f1) > 257.0 and (real)left.#expand(f1) <= 584.0 => '> 257.0-584.0',
(real)left.#expand(f1) > 584.0 and (real)left.#expand(f1) <= 1189.0 => '> 584.0-1189.0',
(real)left.#expand(f1) > 1189.0 and (real)left.#expand(f1) <= 2623.0 => '> 1189.0-2623.0',
(real)left.#expand(f1) > 2623.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 2623.0-9999999999.0',
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



//==================================================================


EXPORT range_function_147(DS,f1,Result) := MACRO//mobility_indicator

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '> 2.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
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



//==================================================================


EXPORT range_function_148(DS,f1,Result) := MACRO//nonus

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_149(DS,f1,Result) := MACRO//num_liens

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 255.0 => '> 5.0-255.0',
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



//==================================================================


EXPORT range_function_150(DS,f1,Result) := MACRO//num_nonderogs

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_151(DS,f1,Result) := MACRO//num_nonderogs12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_152(DS,f1,Result) := MACRO//num_nonderogs180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_153(DS,f1,Result) := MACRO//num_nonderogs24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_154(DS,f1,Result) := MACRO//num_nonderogs30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_155(DS,f1,Result) := MACRO//num_nonderogs36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_156(DS,f1,Result) := MACRO//num_nonderogs60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_157(DS,f1,Result) := MACRO//num_nonderogs90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_158(DS,f1,Result) := MACRO//num_proflic

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_159(DS,f1,Result) := MACRO//num_proflic12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_160(DS,f1,Result) := MACRO//num_proflic180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_161(DS,f1,Result) := MACRO//num_proflic24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_162(DS,f1,Result) := MACRO//num_proflic30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_163(DS,f1,Result) := MACRO//num_proflic36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_164(DS,f1,Result) := MACRO//num_proflic60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_165(DS,f1,Result) := MACRO//num_proflic90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_166(DS,f1,Result) := MACRO//num_proflic_exp12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_167(DS,f1,Result) := MACRO//num_proflic_exp180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_168(DS,f1,Result) := MACRO//num_proflic_exp24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_169(DS,f1,Result) := MACRO//num_proflic_exp30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_170(DS,f1,Result) := MACRO//num_proflic_exp36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_171(DS,f1,Result) := MACRO//num_proflic_exp60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_172(DS,f1,Result) := MACRO//num_proflic_exp90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_173(DS,f1,Result) := MACRO//num_released_liens

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_174(DS,f1,Result) := MACRO//num_released_liens12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_175(DS,f1,Result) := MACRO//num_released_liens180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_176(DS,f1,Result) := MACRO//num_released_liens24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_177(DS,f1,Result) := MACRO//num_released_liens30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_178(DS,f1,Result) := MACRO//num_released_liens36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_179(DS,f1,Result) := MACRO//num_released_liens60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_180(DS,f1,Result) := MACRO//num_released_liens90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_181(DS,f1,Result) := MACRO//num_unreleased_liens

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 255.0 => '> 5.0-255.0',
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



//==================================================================


EXPORT range_function_182(DS,f1,Result) := MACRO//num_unreleased_liens12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_183(DS,f1,Result) := MACRO//num_unreleased_liens180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_184(DS,f1,Result) := MACRO//num_unreleased_liens24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_185(DS,f1,Result) := MACRO//num_unreleased_liens30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_186(DS,f1,Result) := MACRO//num_unreleased_liens36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 255.0 => '> 5.0-255.0',
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



//==================================================================


EXPORT range_function_187(DS,f1,Result) := MACRO//num_unreleased_liens60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 255.0 => '> 5.0-255.0',
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



//==================================================================


EXPORT range_function_188(DS,f1,Result) := MACRO//num_unreleased_liens90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_189(DS,f1,Result) := MACRO//numaircraft

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_190(DS,f1,Result) := MACRO//numaircraft12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_191(DS,f1,Result) := MACRO//numaircraft180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_192(DS,f1,Result) := MACRO//numaircraft24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_193(DS,f1,Result) := MACRO//numaircraft30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_194(DS,f1,Result) := MACRO//numaircraft36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_195(DS,f1,Result) := MACRO//numaircraft60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_196(DS,f1,Result) := MACRO//numaircraft90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_197(DS,f1,Result) := MACRO//numpurchase12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_198(DS,f1,Result) := MACRO//numpurchase180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_199(DS,f1,Result) := MACRO//numpurchase24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_200(DS,f1,Result) := MACRO//numpurchase30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_201(DS,f1,Result) := MACRO//numpurchase36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_202(DS,f1,Result) := MACRO//numpurchase60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_203(DS,f1,Result) := MACRO//numpurchase90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_204(DS,f1,Result) := MACRO//numsold12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_205(DS,f1,Result) := MACRO//numsold180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_206(DS,f1,Result) := MACRO//numsold24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_207(DS,f1,Result) := MACRO//numsold30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_208(DS,f1,Result) := MACRO//numsold36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_209(DS,f1,Result) := MACRO//numsold60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_210(DS,f1,Result) := MACRO//numsold90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_211(DS,f1,Result) := MACRO//numsources

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_212(DS,f1,Result) := MACRO//numwatercraft

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_213(DS,f1,Result) := MACRO//numwatercraft12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_214(DS,f1,Result) := MACRO//numwatercraft180

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_215(DS,f1,Result) := MACRO//numwatercraft24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_216(DS,f1,Result) := MACRO//numwatercraft30

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_217(DS,f1,Result) := MACRO//numwatercraft36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_218(DS,f1,Result) := MACRO//numwatercraft60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_219(DS,f1,Result) := MACRO//numwatercraft90

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_220(DS,f1,Result) := MACRO//paagelastsale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 19.0 => '> 0.0-19.0',
(real)left.#expand(f1) > 19.0 and (real)left.#expand(f1) <= 47.0 => '> 19.0-47.0',
(real)left.#expand(f1) > 47.0 and (real)left.#expand(f1) <= 85.0 => '> 47.0-85.0',
(real)left.#expand(f1) > 85.0 and (real)left.#expand(f1) <= 148.0 => '> 85.0-148.0',
(real)left.#expand(f1) > 148.0 and (real)left.#expand(f1) <= 960.0 => '> 148.0-960.0',
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



//==================================================================


EXPORT range_function_221(DS,f1,Result) := MACRO//paagenewestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 6.0 => '> 1.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 15.0 => '> 6.0-15.0',
(real)left.#expand(f1) > 15.0 and (real)left.#expand(f1) <= 41.0 => '> 15.0-41.0',
(real)left.#expand(f1) > 41.0 and (real)left.#expand(f1) <= 960.0 => '> 41.0-960.0',
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



//==================================================================


EXPORT range_function_222(DS,f1,Result) := MACRO//paageoldestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 8.0 => '> 0.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 25.0 => '> 8.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 58.0 => '> 25.0-58.0',
(real)left.#expand(f1) > 58.0 and (real)left.#expand(f1) <= 141.0 => '> 58.0-141.0',
(real)left.#expand(f1) > 141.0 and (real)left.#expand(f1) <= 960.0 => '> 141.0-960.0',
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



//==================================================================


EXPORT range_function_223(DS,f1,Result) := MACRO//paassessedvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 51300.0 => '> 0.0-51300.0',
(real)left.#expand(f1) > 51300.0 and (real)left.#expand(f1) <= 93520.0 => '> 51300.0-93520.0',
(real)left.#expand(f1) > 93520.0 and (real)left.#expand(f1) <= 147145.0 => '> 93520.0-147145.0',
(real)left.#expand(f1) > 147145.0 and (real)left.#expand(f1) <= 253340.0 => '> 147145.0-253340.0',
(real)left.#expand(f1) > 253340.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 253340.0-9999999999.0',
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



//==================================================================


EXPORT range_function_224(DS,f1,Result) := MACRO//pafamilyowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_225(DS,f1,Result) := MACRO//palandusecode

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
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



//==================================================================


EXPORT range_function_226(DS,f1,Result) := MACRO//palastsaleamount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 36000.0 => '> 0.0-36000.0',
(real)left.#expand(f1) > 36000.0 and (real)left.#expand(f1) <= 83000.0 => '> 36000.0-83000.0',
(real)left.#expand(f1) > 83000.0 and (real)left.#expand(f1) <= 153500.0 => '> 83000.0-153500.0',
(real)left.#expand(f1) > 153500.0 and (real)left.#expand(f1) <= 275000.0 => '> 153500.0-275000.0',
(real)left.#expand(f1) > 275000.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 275000.0-9999999999.0',
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



//==================================================================


EXPORT range_function_227(DS,f1,Result) := MACRO//palenofres

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 14.0 => '> 1.0-14.0',
(real)left.#expand(f1) > 14.0 and (real)left.#expand(f1) <= 42.0 => '> 14.0-42.0',
(real)left.#expand(f1) > 42.0 and (real)left.#expand(f1) <= 107.0 => '> 42.0-107.0',
(real)left.#expand(f1) > 107.0 and (real)left.#expand(f1) <= 960.0 => '> 107.0-960.0',
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



//==================================================================


EXPORT range_function_228(DS,f1,Result) := MACRO//paoccupantowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_229(DS,f1,Result) := MACRO//paownedbysubject

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_230(DS,f1,Result) := MACRO//paphonelisted

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
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



//==================================================================


EXPORT range_function_231(DS,f1,Result) := MACRO//phoneaddrdist

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 5.0 => '> 2.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 13.0 => '> 5.0-13.0',
(real)left.#expand(f1) > 13.0 and (real)left.#expand(f1) <= 9999.0 => '> 13.0-9999.0',
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



//==================================================================


EXPORT range_function_232(DS,f1,Result) := MACRO//phoneedaagenewestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 29.0 => '> 0.0-29.0',
(real)left.#expand(f1) > 29.0 and (real)left.#expand(f1) <= 50.0 => '> 29.0-50.0',
(real)left.#expand(f1) > 50.0 and (real)left.#expand(f1) <= 83.0 => '> 50.0-83.0',
(real)left.#expand(f1) > 83.0 and (real)left.#expand(f1) <= 113.0 => '> 83.0-113.0',
(real)left.#expand(f1) > 113.0 and (real)left.#expand(f1) <= 960.0 => '> 113.0-960.0',
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



//==================================================================


EXPORT range_function_233(DS,f1,Result) := MACRO//phoneedaageoldestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 46.0 => '> 0.0-46.0',
(real)left.#expand(f1) > 46.0 and (real)left.#expand(f1) <= 110.0 => '> 46.0-110.0',
(real)left.#expand(f1) > 110.0 and (real)left.#expand(f1) <= 137.0 => '> 110.0-137.0',
(real)left.#expand(f1) > 137.0 and (real)left.#expand(f1) <= 160.0 => '> 137.0-160.0',
(real)left.#expand(f1) > 160.0 and (real)left.#expand(f1) <= 960.0 => '> 160.0-960.0',
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



//==================================================================


EXPORT range_function_234(DS,f1,Result) := MACRO//phonehighrisk

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_235(DS,f1,Result) := MACRO//phoneidentitiescount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_236(DS,f1,Result) := MACRO//phoneidentitiesrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_237(DS,f1,Result) := MACRO//phonemobile

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_238(DS,f1,Result) := MACRO//phoneotheragenewestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 9.0 => '> 0.0-9.0',
(real)left.#expand(f1) > 9.0 and (real)left.#expand(f1) <= 22.0 => '> 9.0-22.0',
(real)left.#expand(f1) > 22.0 and (real)left.#expand(f1) <= 40.0 => '> 22.0-40.0',
(real)left.#expand(f1) > 40.0 and (real)left.#expand(f1) <= 83.0 => '> 40.0-83.0',
(real)left.#expand(f1) > 83.0 and (real)left.#expand(f1) <= 960.0 => '> 83.0-960.0',
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



//==================================================================


EXPORT range_function_239(DS,f1,Result) := MACRO//phoneotherageoldestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 55.0 => '> 0.0-55.0',
(real)left.#expand(f1) > 55.0 and (real)left.#expand(f1) <= 118.0 => '> 55.0-118.0',
(real)left.#expand(f1) > 118.0 and (real)left.#expand(f1) <= 135.0 => '> 118.0-135.0',
(real)left.#expand(f1) > 135.0 and (real)left.#expand(f1) <= 162.0 => '> 135.0-162.0',
(real)left.#expand(f1) > 162.0 and (real)left.#expand(f1) <= 960.0 => '> 162.0-960.0',
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



//==================================================================


EXPORT range_function_240(DS,f1,Result) := MACRO//phonepager

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_241(DS,f1,Result) := MACRO//phonezipmismatch

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_242(DS,f1,Result) := MACRO//predictedannualincome

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 22000.0 => '> 0.0-22000.0',
(real)left.#expand(f1) > 22000.0 and (real)left.#expand(f1) <= 25000.0 => '> 22000.0-25000.0',
(real)left.#expand(f1) > 25000.0 and (real)left.#expand(f1) <= 29000.0 => '> 25000.0-29000.0',
(real)left.#expand(f1) > 29000.0 and (real)left.#expand(f1) <= 38000.0 => '> 29000.0-38000.0',
(real)left.#expand(f1) > 38000.0 and (real)left.#expand(f1) <= 250999.0 => '> 38000.0-250999.0',
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



//==================================================================


EXPORT range_function_243(DS,f1,Result) := MACRO//prevaddravmconfidence

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 54.0 => '> 0.0-54.0',
(real)left.#expand(f1) > 54.0 and (real)left.#expand(f1) <= 65.0 => '> 54.0-65.0',
(real)left.#expand(f1) > 65.0 and (real)left.#expand(f1) <= 73.0 => '> 65.0-73.0',
(real)left.#expand(f1) > 73.0 and (real)left.#expand(f1) <= 81.0 => '> 73.0-81.0',
(real)left.#expand(f1) > 81.0 and (real)left.#expand(f1) <= 99.0 => '> 81.0-99.0',
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



//==================================================================


EXPORT range_function_244(DS,f1,Result) := MACRO//prevaddravmhedonic

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 89900.0 => '> 0.0-89900.0',
(real)left.#expand(f1) > 89900.0 and (real)left.#expand(f1) <= 158000.0 => '> 89900.0-158000.0',
(real)left.#expand(f1) > 158000.0 and (real)left.#expand(f1) <= 235000.0 => '> 158000.0-235000.0',
(real)left.#expand(f1) > 235000.0 and (real)left.#expand(f1) <= 364000.0 => '> 235000.0-364000.0',
(real)left.#expand(f1) > 364000.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 364000.0-9999999999.0',
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



//==================================================================


EXPORT range_function_245(DS,f1,Result) := MACRO//prevaddravmsalesprice

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 73862.0 => '> 0.0-73862.0',
(real)left.#expand(f1) > 73862.0 and (real)left.#expand(f1) <= 136323.0 => '> 73862.0-136323.0',
(real)left.#expand(f1) > 136323.0 and (real)left.#expand(f1) <= 207094.0 => '> 136323.0-207094.0',
(real)left.#expand(f1) > 207094.0 and (real)left.#expand(f1) <= 330835.0 => '> 207094.0-330835.0',
(real)left.#expand(f1) > 330835.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 330835.0-9999999999.0',
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



//==================================================================


EXPORT range_function_246(DS,f1,Result) := MACRO//prevaddravmtax

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 79501.0 => '> 0.0-79501.0',
(real)left.#expand(f1) > 79501.0 and (real)left.#expand(f1) <= 139702.0 => '> 79501.0-139702.0',
(real)left.#expand(f1) > 139702.0 and (real)left.#expand(f1) <= 213561.0 => '> 139702.0-213561.0',
(real)left.#expand(f1) > 213561.0 and (real)left.#expand(f1) <= 335037.0 => '> 213561.0-335037.0',
(real)left.#expand(f1) > 335037.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 335037.0-9999999999.0',
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



//==================================================================


EXPORT range_function_247(DS,f1,Result) := MACRO//prevaddravmvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 76415.0 => '> 0.0-76415.0',
(real)left.#expand(f1) > 76415.0 and (real)left.#expand(f1) <= 139900.0 => '> 76415.0-139900.0',
(real)left.#expand(f1) > 139900.0 and (real)left.#expand(f1) <= 209064.0 => '> 139900.0-209064.0',
(real)left.#expand(f1) > 209064.0 and (real)left.#expand(f1) <= 334719.0 => '> 209064.0-334719.0',
(real)left.#expand(f1) > 334719.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 334719.0-9999999999.0',
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



//==================================================================


EXPORT range_function_248(DS,f1,Result) := MACRO//prevaddrblockindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.68 => '> 0.0-0.68',
(real)left.#expand(f1) > 0.68 and (real)left.#expand(f1) <= 0.89 => '> 0.68-0.89',
(real)left.#expand(f1) > 0.89 and (real)left.#expand(f1) <= 1.02 => '> 0.89-1.02',
(real)left.#expand(f1) > 1.02 and (real)left.#expand(f1) <= 1.24 => '> 1.02-1.24',
(real)left.#expand(f1) > 1.24 and (real)left.#expand(f1) <= 99.0 => '> 1.24-99.0',
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



//==================================================================


EXPORT range_function_249(DS,f1,Result) := MACRO//prevaddrcountyindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.49 => '> 0.0-0.49',
(real)left.#expand(f1) > 0.49 and (real)left.#expand(f1) <= 0.74 => '> 0.49-0.74',
(real)left.#expand(f1) > 0.74 and (real)left.#expand(f1) <= 0.95 => '> 0.74-0.95',
(real)left.#expand(f1) > 0.95 and (real)left.#expand(f1) <= 1.27 => '> 0.95-1.27',
(real)left.#expand(f1) > 1.27 and (real)left.#expand(f1) <= 99.0 => '> 1.27-99.0',
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



//==================================================================


EXPORT range_function_250(DS,f1,Result) := MACRO//prevaddrtaxmarketvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 58416.0 => '> 0.0-58416.0',
(real)left.#expand(f1) > 58416.0 and (real)left.#expand(f1) <= 100860.0 => '> 58416.0-100860.0',
(real)left.#expand(f1) > 100860.0 and (real)left.#expand(f1) <= 149980.0 => '> 100860.0-149980.0',
(real)left.#expand(f1) > 149980.0 and (real)left.#expand(f1) <= 234691.0 => '> 149980.0-234691.0',
(real)left.#expand(f1) > 234691.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 234691.0-9999999999.0',
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



//==================================================================


EXPORT range_function_251(DS,f1,Result) := MACRO//prevaddrtractindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.72 => '> 0.0-0.72',
(real)left.#expand(f1) > 0.72 and (real)left.#expand(f1) <= 0.92 => '> 0.72-0.92',
(real)left.#expand(f1) > 0.92 and (real)left.#expand(f1) <= 1.02 => '> 0.92-1.02',
(real)left.#expand(f1) > 1.02 and (real)left.#expand(f1) <= 1.23 => '> 1.02-1.23',
(real)left.#expand(f1) > 1.23 and (real)left.#expand(f1) <= 99.0 => '> 1.23-99.0',
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



//==================================================================


EXPORT range_function_252(DS,f1,Result) := MACRO//proflicage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 13.0 => '> 2.0-13.0',
(real)left.#expand(f1) > 13.0 and (real)left.#expand(f1) <= 108.0 => '> 13.0-108.0',
(real)left.#expand(f1) > 108.0 and (real)left.#expand(f1) <= 960.0 => '> 108.0-960.0',
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



//==================================================================


EXPORT range_function_253(DS,f1,Result) := MACRO//proflictypecategory

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
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



//==================================================================


EXPORT range_function_254(DS,f1,Result) := MACRO//propagenewestpurchase

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 26.0 => '> 0.0-26.0',
(real)left.#expand(f1) > 26.0 and (real)left.#expand(f1) <= 67.0 => '> 26.0-67.0',
(real)left.#expand(f1) > 67.0 and (real)left.#expand(f1) <= 133.0 => '> 67.0-133.0',
(real)left.#expand(f1) > 133.0 and (real)left.#expand(f1) <= 191.0 => '> 133.0-191.0',
(real)left.#expand(f1) > 191.0 and (real)left.#expand(f1) <= 960.0 => '> 191.0-960.0',
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



//==================================================================


EXPORT range_function_255(DS,f1,Result) := MACRO//propagenewestsale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 22.0 => '> 0.0-22.0',
(real)left.#expand(f1) > 22.0 and (real)left.#expand(f1) <= 56.0 => '> 22.0-56.0',
(real)left.#expand(f1) > 56.0 and (real)left.#expand(f1) <= 106.0 => '> 56.0-106.0',
(real)left.#expand(f1) > 106.0 and (real)left.#expand(f1) <= 161.0 => '> 106.0-161.0',
(real)left.#expand(f1) > 161.0 and (real)left.#expand(f1) <= 960.0 => '> 161.0-960.0',
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



//==================================================================


EXPORT range_function_256(DS,f1,Result) := MACRO//propageoldestpurchase

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 54.0 => '> 0.0-54.0',
(real)left.#expand(f1) > 54.0 and (real)left.#expand(f1) <= 135.0 => '> 54.0-135.0',
(real)left.#expand(f1) > 135.0 and (real)left.#expand(f1) <= 189.0 => '> 135.0-189.0',
(real)left.#expand(f1) > 189.0 and (real)left.#expand(f1) <= 257.0 => '> 189.0-257.0',
(real)left.#expand(f1) > 257.0 and (real)left.#expand(f1) <= 960.0 => '> 257.0-960.0',
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



//==================================================================


EXPORT range_function_257(DS,f1,Result) := MACRO//property_historically_owned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 255.0 => '> 5.0-255.0',
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



//==================================================================


EXPORT range_function_258(DS,f1,Result) := MACRO//property_owned_assessed_total

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 77130.0 => '> 0.0-77130.0',
(real)left.#expand(f1) > 77130.0 and (real)left.#expand(f1) <= 136300.0 => '> 77130.0-136300.0',
(real)left.#expand(f1) > 136300.0 and (real)left.#expand(f1) <= 209370.0 => '> 136300.0-209370.0',
(real)left.#expand(f1) > 209370.0 and (real)left.#expand(f1) <= 348600.0 => '> 209370.0-348600.0',
(real)left.#expand(f1) > 348600.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 348600.0-9999999999.0',
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



//==================================================================


EXPORT range_function_259(DS,f1,Result) := MACRO//property_owned_total

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_260(DS,f1,Result) := MACRO//propnewestsaleprice

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 79900.0 => '> 0.0-79900.0',
(real)left.#expand(f1) > 79900.0 and (real)left.#expand(f1) <= 135500.0 => '> 79900.0-135500.0',
(real)left.#expand(f1) > 135500.0 and (real)left.#expand(f1) <= 197500.0 => '> 135500.0-197500.0',
(real)left.#expand(f1) > 197500.0 and (real)left.#expand(f1) <= 313719.0 => '> 197500.0-313719.0',
(real)left.#expand(f1) > 313719.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 313719.0-9999999999.0',
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



//==================================================================


EXPORT range_function_261(DS,f1,Result) := MACRO//propnewestsalepurchaseindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.91 => '> 0.0-0.91',
(real)left.#expand(f1) > 0.91 and (real)left.#expand(f1) <= 1.03 => '> 0.91-1.03',
(real)left.#expand(f1) > 1.03 and (real)left.#expand(f1) <= 1.2 => '> 1.03-1.2',
(real)left.#expand(f1) > 1.2 and (real)left.#expand(f1) <= 1.61 => '> 1.2-1.61',
(real)left.#expand(f1) > 1.61 and (real)left.#expand(f1) <= 99.0 => '> 1.61-99.0',
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



//==================================================================


EXPORT range_function_262(DS,f1,Result) := MACRO//recentissue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_263(DS,f1,Result) := MACRO//securityalert

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_264(DS,f1,Result) := MACRO//securityfreeze

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_265(DS,f1,Result) := MACRO//ssnaddrcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '> 2.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 7.0 => '> 4.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 255.0 => '> 7.0-255.0',
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



//==================================================================


EXPORT range_function_266(DS,f1,Result) := MACRO//ssnaddrrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 13.0 => '> 2.0-13.0',
(real)left.#expand(f1) > 13.0 and (real)left.#expand(f1) <= 17.0 => '> 13.0-17.0',
(real)left.#expand(f1) > 17.0 and (real)left.#expand(f1) <= 255.0 => '> 17.0-255.0',
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



//==================================================================


EXPORT range_function_267(DS,f1,Result) := MACRO//ssndeceased

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_268(DS,f1,Result) := MACRO//ssnidentitiescount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '> 2.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 255.0 => '> 4.0-255.0',
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



//==================================================================


EXPORT range_function_269(DS,f1,Result) := MACRO//ssnidentitiesrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 12.0 => '> 1.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 15.0 => '> 12.0-15.0',
(real)left.#expand(f1) > 15.0 and (real)left.#expand(f1) <= 18.0 => '> 15.0-18.0',
(real)left.#expand(f1) > 18.0 and (real)left.#expand(f1) <= 255.0 => '> 18.0-255.0',
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



//==================================================================


EXPORT range_function_270(DS,f1,Result) := MACRO//ssnissuedpriordob

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_271(DS,f1,Result) := MACRO//ssnnotfound

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_272(DS,f1,Result) := MACRO//ssnvalid

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_273(DS,f1,Result) := MACRO//subjectaddrcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 3.0 => '> 1.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 9.0 => '> 5.0-9.0',
(real)left.#expand(f1) > 9.0 and (real)left.#expand(f1) <= 255.0 => '> 9.0-255.0',
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



//==================================================================


EXPORT range_function_274(DS,f1,Result) := MACRO//subjectaddrrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 255.0 => '> 3.0-255.0',
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



//==================================================================


EXPORT range_function_275(DS,f1,Result) := MACRO//subjectphonecount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 255.0 => '> 1.0-255.0',
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



//==================================================================


EXPORT range_function_276(DS,f1,Result) := MACRO//subjectphonerecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_277(DS,f1,Result) := MACRO//subjectssncount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 255.0 => '> 2.0-255.0',
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



//==================================================================


EXPORT range_function_278(DS,f1,Result) := MACRO//subjectssnrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 255.0 => '> 0.0-255.0',
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



//==================================================================


EXPORT range_function_279(DS,f1,Result) := MACRO//subprimesolicitedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_280(DS,f1,Result) := MACRO//subprimesolicitedcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_281(DS,f1,Result) := MACRO//subprimesolicitedcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_282(DS,f1,Result) := MACRO//subprimesolicitedcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_283(DS,f1,Result) := MACRO//subprimesolicitedcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_284(DS,f1,Result) := MACRO//subprimesolicitedcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_285(DS,f1,Result) := MACRO//subprimesolicitedcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_286(DS,f1,Result) := MACRO//subprimesolicitedcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
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



//==================================================================


EXPORT range_function_287(DS,f1,Result) := MACRO//total_number_derogs

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '> 2.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 7.0 => '> 4.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 255.0 => '> 7.0-255.0',
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



//==================================================================


EXPORT range_function_288(DS,f1,Result) := MACRO//verifiedaddress

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_289(DS,f1,Result) := MACRO//verifieddob

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 6.0 => '> 0.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 7.0 => '> 6.0-7.0',
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



//==================================================================


EXPORT range_function_290(DS,f1,Result) := MACRO//verifiedname

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 2.0 => '> 0.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
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



//==================================================================


EXPORT range_function_291(DS,f1,Result) := MACRO//verifiedphone

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
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



//==================================================================


EXPORT range_function_292(DS,f1,Result) := MACRO//verifiedphonefullname

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_293(DS,f1,Result) := MACRO//verifiedphonelastname

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_294(DS,f1,Result) := MACRO//verifiedssn

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
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



//==================================================================


EXPORT range_function_295(DS,f1,Result) := MACRO//wealth_indicator

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
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



//==================================================================


EXPORT range_function_296(DS,f1,Result) := MACRO//zipcorpmil

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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



//==================================================================


EXPORT range_function_297(DS,f1,Result) := MACRO//zippobox

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
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

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
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


EXPORT Average_func(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 // %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<> -1 and (integer)#expand(f1)<> 0);
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


EXPORT Average_func2(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<> -1 and (integer)#expand(f1)<> 0);
  // %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<> -1);


#uniquename(rc)
%rc% := record
// string file_version;
string field_name;
string distribution_type;
STRING50 attribute_value;
decimal20_4 Count1;
end;

#uniquename(a)
%a% := dataset([{'','Ave<>0,-1','Ave<>0,-1',0}],%rc%);

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
end;

//==================================================================


