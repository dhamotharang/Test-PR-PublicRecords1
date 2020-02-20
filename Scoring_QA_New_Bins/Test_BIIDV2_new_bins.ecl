EXPORT Test_BIIDV2_new_bins := module

EXPORT range_function_40(DS,f1,Result) := MACRO//divaddrssnmsourcecount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 11.0 => '> 6.0-11.0',
(real)left.#expand(f1) > 11.0 and (real)left.#expand(f1) <= 19.0 => '> 11.0-19.0',
(real)left.#expand(f1) > 19.0 and (real)left.#expand(f1) <= 38.0 => '> 19.0-38.0',
(real)left.#expand(f1) > 38.0 and (real)left.#expand(f1) <= 255.0 => '> 38.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;

//==================================================================


EXPORT range_function_198(DS,f1,Result) := MACRO//validationipproblems

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= -1.0 => '-1.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_199(DS,f1,Result) := MACRO//validationphoneproblems

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= -1.0 => '-1.0',
(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 3.0 => '> 0.0-3.0',
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


EXPORT range_function_200(DS,f1,Result) := MACRO//validationrisklevel

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '> 2.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 9.0 => '> 5.0-9.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_201(DS,f1,Result) := MACRO//validationssnproblems

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_202(DS,f1,Result) := MACRO//variationaddrchangeage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= -1.0 => '-1.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 21.0 => '> 0.0-21.0',
(real)left.#expand(f1) > 21.0 and (real)left.#expand(f1) <= 38.0 => '> 21.0-38.0',
(real)left.#expand(f1) > 38.0 and (real)left.#expand(f1) <= 77.0 => '> 38.0-77.0',
(real)left.#expand(f1) > 77.0 and (real)left.#expand(f1) <= 170.0 => '> 77.0-170.0',
(real)left.#expand(f1) > 170.0 and (real)left.#expand(f1) <= 960.0 => '> 170.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_203(DS,f1,Result) := MACRO//variationaddrcountnew

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_204(DS,f1,Result) := MACRO//variationaddrcountyear

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_205(DS,f1,Result) := MACRO//variationaddrstability

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
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


EXPORT range_function_206(DS,f1,Result) := MACRO//variationdobcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_207(DS,f1,Result) := MACRO//variationdobcountnew

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_208(DS,f1,Result) := MACRO//variationidentitycount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_220(DS,f1,Result) := MACRO//variationssncountnew

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_221(DS,f1,Result) := MACRO//vulnerablevictimindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 4.0 => '> 1.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 8.0 => '> 6.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 99.0 => '> 8.0-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================




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
//==================================================================
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