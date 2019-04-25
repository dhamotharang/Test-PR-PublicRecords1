EXPORT ITAv3_new_bins := module
EXPORT range_function_1(DS,f1,Result) := MACRO//addrstability

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '> 2.0-4.0',
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


EXPORT range_function_2(DS,f1,Result) := MACRO//ageriskindicator

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 21.0 => '> 0.0-21.0',
(real)left.#expand(f1) > 21.0 and (real)left.#expand(f1) <= 70.0 => '> 21.0-70.0',
(real)left.#expand(f1) > 70.0 and (real)left.#expand(f1) <= 80.0 => '> 70.0-80.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_3(DS,f1,Result) := MACRO//curraddractivephonenumber

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 3306482707.0 => '> 0.0-3306482707.0',
(real)left.#expand(f1) > 3306482707.0 and (real)left.#expand(f1) <= 5303331513.0 => '> 3306482707.0-5303331513.0',
(real)left.#expand(f1) > 5303331513.0 and (real)left.#expand(f1) <= 7125262044.0 => '> 5303331513.0-7125262044.0',
(real)left.#expand(f1) > 7125262044.0 and (real)left.#expand(f1) <= 8286658608.0 => '> 7125262044.0-8286658608.0',
(real)left.#expand(f1) > 8286658608.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 8286658608.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_4(DS,f1,Result) := MACRO//curraddrassessedvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 98940.0 => '> 0.0-98940.0',
(real)left.#expand(f1) > 98940.0 and (real)left.#expand(f1) <= 158200.0 => '> 98940.0-158200.0',
(real)left.#expand(f1) > 158200.0 and (real)left.#expand(f1) <= 231800.0 => '> 158200.0-231800.0',
(real)left.#expand(f1) > 231800.0 and (real)left.#expand(f1) <= 371300.0 => '> 231800.0-371300.0',
(real)left.#expand(f1) > 371300.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 371300.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_5(DS,f1,Result) := MACRO//curraddrassessmarket

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 105293.0 => '> 0.0-105293.0',
(real)left.#expand(f1) > 105293.0 and (real)left.#expand(f1) <= 160840.0 => '> 105293.0-160840.0',
(real)left.#expand(f1) > 160840.0 and (real)left.#expand(f1) <= 227380.0 => '> 160840.0-227380.0',
(real)left.#expand(f1) > 227380.0 and (real)left.#expand(f1) <= 336100.0 => '> 227380.0-336100.0',
(real)left.#expand(f1) > 336100.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 336100.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_6(DS,f1,Result) := MACRO//curraddrautoval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 140075.0 => '> 0.0-140075.0',
(real)left.#expand(f1) > 140075.0 and (real)left.#expand(f1) <= 211542.0 => '> 140075.0-211542.0',
(real)left.#expand(f1) > 211542.0 and (real)left.#expand(f1) <= 299816.0 => '> 211542.0-299816.0',
(real)left.#expand(f1) > 299816.0 and (real)left.#expand(f1) <= 456206.0 => '> 299816.0-456206.0',
(real)left.#expand(f1) > 456206.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 456206.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_7(DS,f1,Result) := MACRO//curraddrblockindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.1 => '> 0.0-0.1',
(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.8 => '> 0.1-0.8',
(real)left.#expand(f1) > 0.8 and (real)left.#expand(f1) <= 1.0 => '> 0.8-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 1.3 => '> 1.0-1.3',
(real)left.#expand(f1) > 1.3 and (real)left.#expand(f1) <= 99.0 => '> 1.3-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_8(DS,f1,Result) := MACRO//curraddrburglaryindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 28.0 => '> 0.0-28.0',
(real)left.#expand(f1) > 28.0 and (real)left.#expand(f1) <= 60.0 => '> 28.0-60.0',
(real)left.#expand(f1) > 60.0 and (real)left.#expand(f1) <= 97.0 => '> 60.0-97.0',
(real)left.#expand(f1) > 97.0 and (real)left.#expand(f1) <= 139.0 => '> 97.0-139.0',
(real)left.#expand(f1) > 139.0 and (real)left.#expand(f1) <= 200.0 => '> 139.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_9(DS,f1,Result) := MACRO//curraddrcartheftindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 27.0 => '> 0.0-27.0',
(real)left.#expand(f1) > 27.0 and (real)left.#expand(f1) <= 58.0 => '> 27.0-58.0',
(real)left.#expand(f1) > 58.0 and (real)left.#expand(f1) <= 93.0 => '> 58.0-93.0',
(real)left.#expand(f1) > 93.0 and (real)left.#expand(f1) <= 136.0 => '> 93.0-136.0',
(real)left.#expand(f1) > 136.0 and (real)left.#expand(f1) <= 200.0 => '> 136.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_10(DS,f1,Result) := MACRO//curraddrconfscore

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 59.0 => '> 0.0-59.0',
(real)left.#expand(f1) > 59.0 and (real)left.#expand(f1) <= 68.0 => '> 59.0-68.0',
(real)left.#expand(f1) > 68.0 and (real)left.#expand(f1) <= 74.0 => '> 68.0-74.0',
(real)left.#expand(f1) > 74.0 and (real)left.#expand(f1) <= 80.0 => '> 74.0-80.0',
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


EXPORT range_function_11(DS,f1,Result) := MACRO//curraddrcountyindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.1 => '> 0.0-0.1',
(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.8 => '> 0.1-0.8',
(real)left.#expand(f1) > 0.8 and (real)left.#expand(f1) <= 1.1 => '> 0.8-1.1',
(real)left.#expand(f1) > 1.1 and (real)left.#expand(f1) <= 1.6 => '> 1.1-1.6',
(real)left.#expand(f1) > 1.6 and (real)left.#expand(f1) <= 99.0 => '> 1.6-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_12(DS,f1,Result) := MACRO//curraddrcrimeindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 27.0 => '> 0.0-27.0',
(real)left.#expand(f1) > 27.0 and (real)left.#expand(f1) <= 58.0 => '> 27.0-58.0',
(real)left.#expand(f1) > 58.0 and (real)left.#expand(f1) <= 93.0 => '> 58.0-93.0',
(real)left.#expand(f1) > 93.0 and (real)left.#expand(f1) <= 135.0 => '> 93.0-135.0',
(real)left.#expand(f1) > 135.0 and (real)left.#expand(f1) <= 200.0 => '> 135.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_13(DS,f1,Result) := MACRO//curraddrhedval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 140000.0 => '> 0.0-140000.0',
(real)left.#expand(f1) > 140000.0 and (real)left.#expand(f1) <= 210500.0 => '> 140000.0-210500.0',
(real)left.#expand(f1) > 210500.0 and (real)left.#expand(f1) <= 299000.0 => '> 210500.0-299000.0',
(real)left.#expand(f1) > 299000.0 and (real)left.#expand(f1) <= 450000.0 => '> 299000.0-450000.0',
(real)left.#expand(f1) > 450000.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 450000.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_14(DS,f1,Result) := MACRO//curraddrlastsalesamount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 52000.0 => '> 0.0-52000.0',
(real)left.#expand(f1) > 52000.0 and (real)left.#expand(f1) <= 119900.0 => '> 52000.0-119900.0',
(real)left.#expand(f1) > 119900.0 and (real)left.#expand(f1) <= 199900.0 => '> 119900.0-199900.0',
(real)left.#expand(f1) > 199900.0 and (real)left.#expand(f1) <= 349802.0 => '> 199900.0-349802.0',
(real)left.#expand(f1) > 349802.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 349802.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_15(DS,f1,Result) := MACRO//curraddrlenofres

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 54.0 => '> 0.0-54.0',
(real)left.#expand(f1) > 54.0 and (real)left.#expand(f1) <= 147.0 => '> 54.0-147.0',
(real)left.#expand(f1) > 147.0 and (real)left.#expand(f1) <= 229.0 => '> 147.0-229.0',
(real)left.#expand(f1) > 229.0 and (real)left.#expand(f1) <= 336.0 => '> 229.0-336.0',
(real)left.#expand(f1) > 336.0 and (real)left.#expand(f1) <= 999.0 => '> 336.0-999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_16(DS,f1,Result) := MACRO//curraddrmedianhomeval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 124896.0 => '> 0.0-124896.0',
(real)left.#expand(f1) > 124896.0 and (real)left.#expand(f1) <= 180208.0 => '> 124896.0-180208.0',
(real)left.#expand(f1) > 180208.0 and (real)left.#expand(f1) <= 254412.0 => '> 180208.0-254412.0',
(real)left.#expand(f1) > 254412.0 and (real)left.#expand(f1) <= 395519.0 => '> 254412.0-395519.0',
(real)left.#expand(f1) > 395519.0 and (real)left.#expand(f1) <= 999999.0 => '> 395519.0-999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_17(DS,f1,Result) := MACRO//curraddrmedianincome

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 47073.0 => '> 0.0-47073.0',
(real)left.#expand(f1) > 47073.0 and (real)left.#expand(f1) <= 61332.0 => '> 47073.0-61332.0',
(real)left.#expand(f1) > 61332.0 and (real)left.#expand(f1) <= 76220.0 => '> 61332.0-76220.0',
(real)left.#expand(f1) > 76220.0 and (real)left.#expand(f1) <= 97980.0 => '> 76220.0-97980.0',
(real)left.#expand(f1) > 97980.0 and (real)left.#expand(f1) <= 999999.0 => '> 97980.0-999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_18(DS,f1,Result) := MACRO//curraddrmurderindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 26.0 => '> 0.0-26.0',
(real)left.#expand(f1) > 26.0 and (real)left.#expand(f1) <= 56.0 => '> 26.0-56.0',
(real)left.#expand(f1) > 56.0 and (real)left.#expand(f1) <= 91.0 => '> 56.0-91.0',
(real)left.#expand(f1) > 91.0 and (real)left.#expand(f1) <= 138.0 => '> 91.0-138.0',
(real)left.#expand(f1) > 138.0 and (real)left.#expand(f1) <= 200.0 => '> 138.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_19(DS,f1,Result) := MACRO//curraddrprevaddrassesseddiff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 32200.0 => '> 0.0-32200.0',
(real)left.#expand(f1) > 32200.0 and (real)left.#expand(f1) <= 109290.0 => '> 32200.0-109290.0',
(real)left.#expand(f1) > 109290.0 and (real)left.#expand(f1) <= 999999999.0 => '> 109290.0-999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_20(DS,f1,Result) := MACRO//curraddrprevaddrcrimediff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 999999.0 => '> 0.0-999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_21(DS,f1,Result) := MACRO//curraddrprevaddrdistance

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 4.0 => '> 0.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 10.0 => '> 4.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 33.0 => '> 10.0-33.0',
(real)left.#expand(f1) > 33.0 and (real)left.#expand(f1) <= 389.0 => '> 33.0-389.0',
(real)left.#expand(f1) > 389.0 and (real)left.#expand(f1) <= 9999.0 => '> 389.0-9999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_22(DS,f1,Result) := MACRO//curraddrprevaddrhomevaldiff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 20680.0 => '> 0.0-20680.0',
(real)left.#expand(f1) > 20680.0 and (real)left.#expand(f1) <= 99999.0 => '> 20680.0-99999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_23(DS,f1,Result) := MACRO//curraddrprevaddrincomediff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 9441.0 => '> 0.0-9441.0',
(real)left.#expand(f1) > 9441.0 and (real)left.#expand(f1) <= 99999.0 => '> 9441.0-99999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_24(DS,f1,Result) := MACRO//curraddrpriceindval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 132918.0 => '> 0.0-132918.0',
(real)left.#expand(f1) > 132918.0 and (real)left.#expand(f1) <= 213503.0 => '> 132918.0-213503.0',
(real)left.#expand(f1) > 213503.0 and (real)left.#expand(f1) <= 314393.0 => '> 213503.0-314393.0',
(real)left.#expand(f1) > 314393.0 and (real)left.#expand(f1) <= 487698.0 => '> 314393.0-487698.0',
(real)left.#expand(f1) > 487698.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 487698.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_25(DS,f1,Result) := MACRO//curraddrtaxassessval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 140487.0 => '> 0.0-140487.0',
(real)left.#expand(f1) > 140487.0 and (real)left.#expand(f1) <= 211097.0 => '> 140487.0-211097.0',
(real)left.#expand(f1) > 211097.0 and (real)left.#expand(f1) <= 295576.0 => '> 211097.0-295576.0',
(real)left.#expand(f1) > 295576.0 and (real)left.#expand(f1) <= 440951.0 => '> 295576.0-440951.0',
(real)left.#expand(f1) > 440951.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 440951.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_26(DS,f1,Result) := MACRO//curraddrtractindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.1 => '> 0.0-0.1',
(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.8 => '> 0.1-0.8',
(real)left.#expand(f1) > 0.8 and (real)left.#expand(f1) <= 1.0 => '> 0.8-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 1.3 => '> 1.0-1.3',
(real)left.#expand(f1) > 1.3 and (real)left.#expand(f1) <= 99.0 => '> 1.3-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_27(DS,f1,Result) := MACRO//donotmail

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_28(DS,f1,Result) := MACRO//inputaddractivephonenumber

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 3306374151.0 => '> 0.0-3306374151.0',
(real)left.#expand(f1) > 3306374151.0 and (real)left.#expand(f1) <= 5208872825.0 => '> 3306374151.0-5208872825.0',
(real)left.#expand(f1) > 5208872825.0 and (real)left.#expand(f1) <= 7139956387.0 => '> 5208872825.0-7139956387.0',
(real)left.#expand(f1) > 7139956387.0 and (real)left.#expand(f1) <= 8288948467.0 => '> 7139956387.0-8288948467.0',
(real)left.#expand(f1) > 8288948467.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 8288948467.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_29(DS,f1,Result) := MACRO//inputaddrassessedvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 102333.0 => '> 0.0-102333.0',
(real)left.#expand(f1) > 102333.0 and (real)left.#expand(f1) <= 161300.0 => '> 102333.0-161300.0',
(real)left.#expand(f1) > 161300.0 and (real)left.#expand(f1) <= 235900.0 => '> 161300.0-235900.0',
(real)left.#expand(f1) > 235900.0 and (real)left.#expand(f1) <= 374100.0 => '> 235900.0-374100.0',
(real)left.#expand(f1) > 374100.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 374100.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_30(DS,f1,Result) := MACRO//inputaddrassessmarket

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 109000.0 => '> 0.0-109000.0',
(real)left.#expand(f1) > 109000.0 and (real)left.#expand(f1) <= 164800.0 => '> 109000.0-164800.0',
(real)left.#expand(f1) > 164800.0 and (real)left.#expand(f1) <= 231000.0 => '> 164800.0-231000.0',
(real)left.#expand(f1) > 231000.0 and (real)left.#expand(f1) <= 340100.0 => '> 231000.0-340100.0',
(real)left.#expand(f1) > 340100.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 340100.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_31(DS,f1,Result) := MACRO//inputaddrautoval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 143796.0 => '> 0.0-143796.0',
(real)left.#expand(f1) > 143796.0 and (real)left.#expand(f1) <= 215554.0 => '> 143796.0-215554.0',
(real)left.#expand(f1) > 215554.0 and (real)left.#expand(f1) <= 303018.0 => '> 215554.0-303018.0',
(real)left.#expand(f1) > 303018.0 and (real)left.#expand(f1) <= 459912.0 => '> 303018.0-459912.0',
(real)left.#expand(f1) > 459912.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 459912.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_32(DS,f1,Result) := MACRO//inputaddrblockindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.1 => '> 0.0-0.1',
(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.8 => '> 0.1-0.8',
(real)left.#expand(f1) > 0.8 and (real)left.#expand(f1) <= 1.0 => '> 0.8-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 1.3 => '> 1.0-1.3',
(real)left.#expand(f1) > 1.3 and (real)left.#expand(f1) <= 99.0 => '> 1.3-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_33(DS,f1,Result) := MACRO//inputaddrburglaryindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 25.0 => '> 0.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 57.0 => '> 25.0-57.0',
(real)left.#expand(f1) > 57.0 and (real)left.#expand(f1) <= 92.0 => '> 57.0-92.0',
(real)left.#expand(f1) > 92.0 and (real)left.#expand(f1) <= 135.0 => '> 92.0-135.0',
(real)left.#expand(f1) > 135.0 and (real)left.#expand(f1) <= 200.0 => '> 135.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_34(DS,f1,Result) := MACRO//inputaddrcartheftindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 27.0 => '> 0.0-27.0',
(real)left.#expand(f1) > 27.0 and (real)left.#expand(f1) <= 56.0 => '> 27.0-56.0',
(real)left.#expand(f1) > 56.0 and (real)left.#expand(f1) <= 90.0 => '> 56.0-90.0',
(real)left.#expand(f1) > 90.0 and (real)left.#expand(f1) <= 132.0 => '> 90.0-132.0',
(real)left.#expand(f1) > 132.0 and (real)left.#expand(f1) <= 200.0 => '> 132.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_35(DS,f1,Result) := MACRO//inputaddrconfscore

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 59.0 => '> 0.0-59.0',
(real)left.#expand(f1) > 59.0 and (real)left.#expand(f1) <= 68.0 => '> 59.0-68.0',
(real)left.#expand(f1) > 68.0 and (real)left.#expand(f1) <= 74.0 => '> 68.0-74.0',
(real)left.#expand(f1) > 74.0 and (real)left.#expand(f1) <= 80.0 => '> 74.0-80.0',
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


EXPORT range_function_36(DS,f1,Result) := MACRO//inputaddrcountyindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.1 => '> 0.0-0.1',
(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.8 => '> 0.1-0.8',
(real)left.#expand(f1) > 0.8 and (real)left.#expand(f1) <= 1.1 => '> 0.8-1.1',
(real)left.#expand(f1) > 1.1 and (real)left.#expand(f1) <= 1.6 => '> 1.1-1.6',
(real)left.#expand(f1) > 1.6 and (real)left.#expand(f1) <= 99.0 => '> 1.6-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_37(DS,f1,Result) := MACRO//inputaddrcrimeindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 25.0 => '> 0.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 55.0 => '> 25.0-55.0',
(real)left.#expand(f1) > 55.0 and (real)left.#expand(f1) <= 90.0 => '> 55.0-90.0',
(real)left.#expand(f1) > 90.0 and (real)left.#expand(f1) <= 135.0 => '> 90.0-135.0',
(real)left.#expand(f1) > 135.0 and (real)left.#expand(f1) <= 200.0 => '> 135.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_38(DS,f1,Result) := MACRO//inputaddrcurraddrassesseddiff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 999999999.0 => '> 0.0-999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_39(DS,f1,Result) := MACRO//inputaddrcurraddrcrimediff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 6.0 => '> 0.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 999999.0 => '> 6.0-999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_40(DS,f1,Result) := MACRO//inputaddrcurraddrdistance

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 4.0 => '> 0.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 10.0 => '> 4.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 32.0 => '> 10.0-32.0',
(real)left.#expand(f1) > 32.0 and (real)left.#expand(f1) <= 402.0 => '> 32.0-402.0',
(real)left.#expand(f1) > 402.0 and (real)left.#expand(f1) <= 9999.0 => '> 402.0-9999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_41(DS,f1,Result) := MACRO//inputaddrcurraddrhomevaldiff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 999999999.0 => '> 0.0-999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_42(DS,f1,Result) := MACRO//inputaddrcurraddrincomediff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 999999999.0 => '> 0.0-999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_43(DS,f1,Result) := MACRO//inputaddrhedval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 144000.0 => '> 0.0-144000.0',
(real)left.#expand(f1) > 144000.0 and (real)left.#expand(f1) <= 214000.0 => '> 144000.0-214000.0',
(real)left.#expand(f1) > 214000.0 and (real)left.#expand(f1) <= 299975.0 => '> 214000.0-299975.0',
(real)left.#expand(f1) > 299975.0 and (real)left.#expand(f1) <= 451500.0 => '> 299975.0-451500.0',
(real)left.#expand(f1) > 451500.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 451500.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_44(DS,f1,Result) := MACRO//inputaddrlastsalesamount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 50000.0 => '> 0.0-50000.0',
(real)left.#expand(f1) > 50000.0 and (real)left.#expand(f1) <= 119900.0 => '> 50000.0-119900.0',
(real)left.#expand(f1) > 119900.0 and (real)left.#expand(f1) <= 199900.0 => '> 119900.0-199900.0',
(real)left.#expand(f1) > 199900.0 and (real)left.#expand(f1) <= 348090.0 => '> 199900.0-348090.0',
(real)left.#expand(f1) > 348090.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 348090.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_45(DS,f1,Result) := MACRO//inputaddrlenofres

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 113.0 => '> 0.0-113.0',
(real)left.#expand(f1) > 113.0 and (real)left.#expand(f1) <= 182.0 => '> 113.0-182.0',
(real)left.#expand(f1) > 182.0 and (real)left.#expand(f1) <= 255.0 => '> 182.0-255.0',
(real)left.#expand(f1) > 255.0 and (real)left.#expand(f1) <= 349.0 => '> 255.0-349.0',
(real)left.#expand(f1) > 349.0 and (real)left.#expand(f1) <= 960.0 => '> 349.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_46(DS,f1,Result) := MACRO//inputaddrmedianhomeval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 127467.0 => '> 0.0-127467.0',
(real)left.#expand(f1) > 127467.0 and (real)left.#expand(f1) <= 183494.0 => '> 127467.0-183494.0',
(real)left.#expand(f1) > 183494.0 and (real)left.#expand(f1) <= 259191.0 => '> 183494.0-259191.0',
(real)left.#expand(f1) > 259191.0 and (real)left.#expand(f1) <= 401676.0 => '> 259191.0-401676.0',
(real)left.#expand(f1) > 401676.0 and (real)left.#expand(f1) <= 999999.0 => '> 401676.0-999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_47(DS,f1,Result) := MACRO//inputaddrmedianincome

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 48374.0 => '> 0.0-48374.0',
(real)left.#expand(f1) > 48374.0 and (real)left.#expand(f1) <= 63095.0 => '> 48374.0-63095.0',
(real)left.#expand(f1) > 63095.0 and (real)left.#expand(f1) <= 78228.0 => '> 63095.0-78228.0',
(real)left.#expand(f1) > 78228.0 and (real)left.#expand(f1) <= 100266.0 => '> 78228.0-100266.0',
(real)left.#expand(f1) > 100266.0 and (real)left.#expand(f1) <= 999999.0 => '> 100266.0-999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_48(DS,f1,Result) := MACRO//inputaddrmurderindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 26.0 => '> 0.0-26.0',
(real)left.#expand(f1) > 26.0 and (real)left.#expand(f1) <= 54.0 => '> 26.0-54.0',
(real)left.#expand(f1) > 54.0 and (real)left.#expand(f1) <= 89.0 => '> 54.0-89.0',
(real)left.#expand(f1) > 89.0 and (real)left.#expand(f1) <= 135.0 => '> 89.0-135.0',
(real)left.#expand(f1) > 135.0 and (real)left.#expand(f1) <= 200.0 => '> 135.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_49(DS,f1,Result) := MACRO//inputaddrpriceindval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 137753.0 => '> 0.0-137753.0',
(real)left.#expand(f1) > 137753.0 and (real)left.#expand(f1) <= 218341.0 => '> 137753.0-218341.0',
(real)left.#expand(f1) > 218341.0 and (real)left.#expand(f1) <= 319204.0 => '> 218341.0-319204.0',
(real)left.#expand(f1) > 319204.0 and (real)left.#expand(f1) <= 497183.0 => '> 319204.0-497183.0',
(real)left.#expand(f1) > 497183.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 497183.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_50(DS,f1,Result) := MACRO//inputaddrtaxassessval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 143569.0 => '> 0.0-143569.0',
(real)left.#expand(f1) > 143569.0 and (real)left.#expand(f1) <= 214556.0 => '> 143569.0-214556.0',
(real)left.#expand(f1) > 214556.0 and (real)left.#expand(f1) <= 297567.0 => '> 214556.0-297567.0',
(real)left.#expand(f1) > 297567.0 and (real)left.#expand(f1) <= 441010.0 => '> 297567.0-441010.0',
(real)left.#expand(f1) > 441010.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 441010.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_51(DS,f1,Result) := MACRO//inputaddrtractindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.1 => '> 0.0-0.1',
(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.8 => '> 0.1-0.8',
(real)left.#expand(f1) > 0.8 and (real)left.#expand(f1) <= 1.0 => '> 0.8-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 1.3 => '> 1.0-1.3',
(real)left.#expand(f1) > 1.3 and (real)left.#expand(f1) <= 99.0 => '> 1.3-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_52(DS,f1,Result) := MACRO//inputphoneaddrdist

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_53(DS,f1,Result) := MACRO//prevaddractivephonenumber

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 3303852745.0 => '> 0.0-3303852745.0',
(real)left.#expand(f1) > 3303852745.0 and (real)left.#expand(f1) <= 5176476440.0 => '> 3303852745.0-5176476440.0',
(real)left.#expand(f1) > 5176476440.0 and (real)left.#expand(f1) <= 7089230427.0 => '> 5176476440.0-7089230427.0',
(real)left.#expand(f1) > 7089230427.0 and (real)left.#expand(f1) <= 8437122765.0 => '> 7089230427.0-8437122765.0',
(real)left.#expand(f1) > 8437122765.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 8437122765.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_54(DS,f1,Result) := MACRO//prevaddrassessedvalue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 87700.0 => '> 0.0-87700.0',
(real)left.#expand(f1) > 87700.0 and (real)left.#expand(f1) <= 142494.0 => '> 87700.0-142494.0',
(real)left.#expand(f1) > 142494.0 and (real)left.#expand(f1) <= 214480.0 => '> 142494.0-214480.0',
(real)left.#expand(f1) > 214480.0 and (real)left.#expand(f1) <= 350935.0 => '> 214480.0-350935.0',
(real)left.#expand(f1) > 350935.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 350935.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_55(DS,f1,Result) := MACRO//prevaddrassessmarket

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 94200.0 => '> 0.0-94200.0',
(real)left.#expand(f1) > 94200.0 and (real)left.#expand(f1) <= 145900.0 => '> 94200.0-145900.0',
(real)left.#expand(f1) > 145900.0 and (real)left.#expand(f1) <= 208311.0 => '> 145900.0-208311.0',
(real)left.#expand(f1) > 208311.0 and (real)left.#expand(f1) <= 317269.0 => '> 208311.0-317269.0',
(real)left.#expand(f1) > 317269.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 317269.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_56(DS,f1,Result) := MACRO//prevaddrautoval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 126615.0 => '> 0.0-126615.0',
(real)left.#expand(f1) > 126615.0 and (real)left.#expand(f1) <= 192027.0 => '> 126615.0-192027.0',
(real)left.#expand(f1) > 192027.0 and (real)left.#expand(f1) <= 278883.0 => '> 192027.0-278883.0',
(real)left.#expand(f1) > 278883.0 and (real)left.#expand(f1) <= 427007.0 => '> 278883.0-427007.0',
(real)left.#expand(f1) > 427007.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 427007.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_57(DS,f1,Result) := MACRO//prevaddrblockindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.1 => '> 0.0-0.1',
(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.7 => '> 0.1-0.7',
(real)left.#expand(f1) > 0.7 and (real)left.#expand(f1) <= 0.9 => '> 0.7-0.9',
(real)left.#expand(f1) > 0.9 and (real)left.#expand(f1) <= 1.1 => '> 0.9-1.1',
(real)left.#expand(f1) > 1.1 and (real)left.#expand(f1) <= 99.0 => '> 1.1-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_58(DS,f1,Result) := MACRO//prevaddrburglaryindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 32.0 => '> 0.0-32.0',
(real)left.#expand(f1) > 32.0 and (real)left.#expand(f1) <= 66.0 => '> 32.0-66.0',
(real)left.#expand(f1) > 66.0 and (real)left.#expand(f1) <= 103.0 => '> 66.0-103.0',
(real)left.#expand(f1) > 103.0 and (real)left.#expand(f1) <= 146.0 => '> 103.0-146.0',
(real)left.#expand(f1) > 146.0 and (real)left.#expand(f1) <= 200.0 => '> 146.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_59(DS,f1,Result) := MACRO//prevaddrcartheftindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 31.0 => '> 0.0-31.0',
(real)left.#expand(f1) > 31.0 and (real)left.#expand(f1) <= 65.0 => '> 31.0-65.0',
(real)left.#expand(f1) > 65.0 and (real)left.#expand(f1) <= 101.0 => '> 65.0-101.0',
(real)left.#expand(f1) > 101.0 and (real)left.#expand(f1) <= 146.0 => '> 101.0-146.0',
(real)left.#expand(f1) > 146.0 and (real)left.#expand(f1) <= 200.0 => '> 146.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_60(DS,f1,Result) := MACRO//prevaddrconfscore

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 58.0 => '> 0.0-58.0',
(real)left.#expand(f1) > 58.0 and (real)left.#expand(f1) <= 68.0 => '> 58.0-68.0',
(real)left.#expand(f1) > 68.0 and (real)left.#expand(f1) <= 75.0 => '> 68.0-75.0',
(real)left.#expand(f1) > 75.0 and (real)left.#expand(f1) <= 83.0 => '> 75.0-83.0',
(real)left.#expand(f1) > 83.0 and (real)left.#expand(f1) <= 99.0 => '> 83.0-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_61(DS,f1,Result) := MACRO//prevaddrcountyindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.1 => '> 0.0-0.1',
(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.7 => '> 0.1-0.7',
(real)left.#expand(f1) > 0.7 and (real)left.#expand(f1) <= 1.0 => '> 0.7-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 1.5 => '> 1.0-1.5',
(real)left.#expand(f1) > 1.5 and (real)left.#expand(f1) <= 99.0 => '> 1.5-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_62(DS,f1,Result) := MACRO//prevaddrcrimeindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 30.0 => '> 0.0-30.0',
(real)left.#expand(f1) > 30.0 and (real)left.#expand(f1) <= 64.0 => '> 30.0-64.0',
(real)left.#expand(f1) > 64.0 and (real)left.#expand(f1) <= 101.0 => '> 64.0-101.0',
(real)left.#expand(f1) > 101.0 and (real)left.#expand(f1) <= 147.0 => '> 101.0-147.0',
(real)left.#expand(f1) > 147.0 and (real)left.#expand(f1) <= 200.0 => '> 147.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_63(DS,f1,Result) := MACRO//prevaddrhedval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 130000.0 => '> 0.0-130000.0',
(real)left.#expand(f1) > 130000.0 and (real)left.#expand(f1) <= 192600.0 => '> 130000.0-192600.0',
(real)left.#expand(f1) > 192600.0 and (real)left.#expand(f1) <= 280000.0 => '> 192600.0-280000.0',
(real)left.#expand(f1) > 280000.0 and (real)left.#expand(f1) <= 430000.0 => '> 280000.0-430000.0',
(real)left.#expand(f1) > 430000.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 430000.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_64(DS,f1,Result) := MACRO//prevaddrlastsalesamount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 61900.0 => '> 0.0-61900.0',
(real)left.#expand(f1) > 61900.0 and (real)left.#expand(f1) <= 127000.0 => '> 61900.0-127000.0',
(real)left.#expand(f1) > 127000.0 and (real)left.#expand(f1) <= 205000.0 => '> 127000.0-205000.0',
(real)left.#expand(f1) > 205000.0 and (real)left.#expand(f1) <= 356000.0 => '> 205000.0-356000.0',
(real)left.#expand(f1) > 356000.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 356000.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_65(DS,f1,Result) := MACRO//prevaddrlenofres

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 53.0 => '> 0.0-53.0',
(real)left.#expand(f1) > 53.0 and (real)left.#expand(f1) <= 132.0 => '> 53.0-132.0',
(real)left.#expand(f1) > 132.0 and (real)left.#expand(f1) <= 207.0 => '> 132.0-207.0',
(real)left.#expand(f1) > 207.0 and (real)left.#expand(f1) <= 292.0 => '> 207.0-292.0',
(real)left.#expand(f1) > 292.0 and (real)left.#expand(f1) <= 999.0 => '> 292.0-999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_66(DS,f1,Result) := MACRO//prevaddrmedianhomeval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 118750.0 => '> 0.0-118750.0',
(real)left.#expand(f1) > 118750.0 and (real)left.#expand(f1) <= 171491.0 => '> 118750.0-171491.0',
(real)left.#expand(f1) > 171491.0 and (real)left.#expand(f1) <= 246489.0 => '> 171491.0-246489.0',
(real)left.#expand(f1) > 246489.0 and (real)left.#expand(f1) <= 390171.0 => '> 246489.0-390171.0',
(real)left.#expand(f1) > 390171.0 and (real)left.#expand(f1) <= 999999.0 => '> 390171.0-999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_67(DS,f1,Result) := MACRO//prevaddrmedianincome

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 44097.0 => '> 0.0-44097.0',
(real)left.#expand(f1) > 44097.0 and (real)left.#expand(f1) <= 57851.0 => '> 44097.0-57851.0',
(real)left.#expand(f1) > 57851.0 and (real)left.#expand(f1) <= 71823.0 => '> 57851.0-71823.0',
(real)left.#expand(f1) > 71823.0 and (real)left.#expand(f1) <= 93316.0 => '> 71823.0-93316.0',
(real)left.#expand(f1) > 93316.0 and (real)left.#expand(f1) <= 999999.0 => '> 93316.0-999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_68(DS,f1,Result) := MACRO//prevaddrmurderindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 30.0 => '> 0.0-30.0',
(real)left.#expand(f1) > 30.0 and (real)left.#expand(f1) <= 63.0 => '> 30.0-63.0',
(real)left.#expand(f1) > 63.0 and (real)left.#expand(f1) <= 100.0 => '> 63.0-100.0',
(real)left.#expand(f1) > 100.0 and (real)left.#expand(f1) <= 147.0 => '> 100.0-147.0',
(real)left.#expand(f1) > 147.0 and (real)left.#expand(f1) <= 200.0 => '> 147.0-200.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_69(DS,f1,Result) := MACRO//prevaddrpriceindval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 119309.0 => '> 0.0-119309.0',
(real)left.#expand(f1) > 119309.0 and (real)left.#expand(f1) <= 192000.0 => '> 119309.0-192000.0',
(real)left.#expand(f1) > 192000.0 and (real)left.#expand(f1) <= 284618.0 => '> 192000.0-284618.0',
(real)left.#expand(f1) > 284618.0 and (real)left.#expand(f1) <= 450594.0 => '> 284618.0-450594.0',
(real)left.#expand(f1) > 450594.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 450594.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_70(DS,f1,Result) := MACRO//prevaddrtaxassessval

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 128124.0 => '> 0.0-128124.0',
(real)left.#expand(f1) > 128124.0 and (real)left.#expand(f1) <= 193832.0 => '> 128124.0-193832.0',
(real)left.#expand(f1) > 193832.0 and (real)left.#expand(f1) <= 277606.0 => '> 193832.0-277606.0',
(real)left.#expand(f1) > 277606.0 and (real)left.#expand(f1) <= 419973.0 => '> 277606.0-419973.0',
(real)left.#expand(f1) > 419973.0 and (real)left.#expand(f1) <= 9999999999.0 => '> 419973.0-9999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_71(DS,f1,Result) := MACRO//prevaddrtractindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.1 => '> 0.0-0.1',
(real)left.#expand(f1) > 0.1 and (real)left.#expand(f1) <= 0.7 => '> 0.1-0.7',
(real)left.#expand(f1) > 0.7 and (real)left.#expand(f1) <= 0.9 => '> 0.7-0.9',
(real)left.#expand(f1) > 0.9 and (real)left.#expand(f1) <= 1.1 => '> 0.9-1.1',
(real)left.#expand(f1) > 1.1 and (real)left.#expand(f1) <= 99.0 => '> 1.1-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_72(DS,f1,Result) := MACRO//propertyownedassessedtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 112190.0 => '> 0.0-112190.0',
(real)left.#expand(f1) > 112190.0 and (real)left.#expand(f1) <= 181100.0 => '> 112190.0-181100.0',
(real)left.#expand(f1) > 181100.0 and (real)left.#expand(f1) <= 278670.0 => '> 181100.0-278670.0',
(real)left.#expand(f1) > 278670.0 and (real)left.#expand(f1) <= 460540.0 => '> 278670.0-460540.0',
(real)left.#expand(f1) > 460540.0 and (real)left.#expand(f1) <= 999999999999.0 => '> 460540.0-999999999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_73(DS,f1,Result) := MACRO//recentupdate

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_74(DS,f1,Result) := MACRO//ssnlength

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 9.0 => '> 0.0-9.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_75(DS,f1,Result) := MACRO//timesincecurraddrfirstseen

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 56.0 => '> 0.0-56.0',
(real)left.#expand(f1) > 56.0 and (real)left.#expand(f1) <= 150.0 => '> 56.0-150.0',
(real)left.#expand(f1) > 150.0 and (real)left.#expand(f1) <= 232.0 => '> 150.0-232.0',
(real)left.#expand(f1) > 232.0 and (real)left.#expand(f1) <= 339.0 => '> 232.0-339.0',
(real)left.#expand(f1) > 339.0 and (real)left.#expand(f1) <= 960.0 => '> 339.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_76(DS,f1,Result) := MACRO//timesincecurraddrlastseen

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 8.0 => '> 1.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 18.0 => '> 8.0-18.0',
(real)left.#expand(f1) > 18.0 and (real)left.#expand(f1) <= 60.0 => '> 18.0-60.0',
(real)left.#expand(f1) > 60.0 and (real)left.#expand(f1) <= 960.0 => '> 60.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_77(DS,f1,Result) := MACRO//timesinceinputaddrfirstseen

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 118.0 => '> 0.0-118.0',
(real)left.#expand(f1) > 118.0 and (real)left.#expand(f1) <= 185.0 => '> 118.0-185.0',
(real)left.#expand(f1) > 185.0 and (real)left.#expand(f1) <= 257.0 => '> 185.0-257.0',
(real)left.#expand(f1) > 257.0 and (real)left.#expand(f1) <= 351.0 => '> 257.0-351.0',
(real)left.#expand(f1) > 351.0 and (real)left.#expand(f1) <= 960.0 => '> 351.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_78(DS,f1,Result) := MACRO//timesinceinputaddrlastseen

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 6.0 => '> 1.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 13.0 => '> 6.0-13.0',
(real)left.#expand(f1) > 13.0 and (real)left.#expand(f1) <= 27.0 => '> 13.0-27.0',
(real)left.#expand(f1) > 27.0 and (real)left.#expand(f1) <= 960.0 => '> 27.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_79(DS,f1,Result) := MACRO//timesincelastname

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 152.0 => '> 0.0-152.0',
(real)left.#expand(f1) > 152.0 and (real)left.#expand(f1) <= 256.0 => '> 152.0-256.0',
(real)left.#expand(f1) > 256.0 and (real)left.#expand(f1) <= 328.0 => '> 256.0-328.0',
(real)left.#expand(f1) > 328.0 and (real)left.#expand(f1) <= 384.0 => '> 328.0-384.0',
(real)left.#expand(f1) > 384.0 and (real)left.#expand(f1) <= 960.0 => '> 384.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_80(DS,f1,Result) := MACRO//timesinceprevaddrfirstseen

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 102.0 => '> 0.0-102.0',
(real)left.#expand(f1) > 102.0 and (real)left.#expand(f1) <= 180.0 => '> 102.0-180.0',
(real)left.#expand(f1) > 180.0 and (real)left.#expand(f1) <= 256.0 => '> 180.0-256.0',
(real)left.#expand(f1) > 256.0 and (real)left.#expand(f1) <= 344.0 => '> 256.0-344.0',
(real)left.#expand(f1) > 344.0 and (real)left.#expand(f1) <= 960.0 => '> 344.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_81(DS,f1,Result) := MACRO//timesinceprevaddrlastseen

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 17.0 => '> 1.0-17.0',
(real)left.#expand(f1) > 17.0 and (real)left.#expand(f1) <= 58.0 => '> 17.0-58.0',
(real)left.#expand(f1) > 58.0 and (real)left.#expand(f1) <= 104.0 => '> 58.0-104.0',
(real)left.#expand(f1) > 104.0 and (real)left.#expand(f1) <= 960.0 => '> 104.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_82(DS,f1,Result) := MACRO//timesincesubjectphonefirstseen

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 25.0 => '> 0.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 45.0 => '> 25.0-45.0',
(real)left.#expand(f1) > 45.0 and (real)left.#expand(f1) <= 64.0 => '> 45.0-64.0',
(real)left.#expand(f1) > 64.0 and (real)left.#expand(f1) <= 110.0 => '> 64.0-110.0',
(real)left.#expand(f1) > 110.0 and (real)left.#expand(f1) <= 999.0 => '> 110.0-999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_83(DS,f1,Result) := MACRO//timesincesubjectphonelastseen

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 6.0 => '> 3.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 8.0 => '> 6.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 10.0 => '> 8.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 999.0 => '> 10.0-999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_84(DS,f1,Result) := MACRO//v3__addrchangecount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_85(DS,f1,Result) := MACRO//v3__addrchangecount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_86(DS,f1,Result) := MACRO//v3__addrchangecount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_87(DS,f1,Result) := MACRO//v3__addrchangecount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_88(DS,f1,Result) := MACRO//v3__addrchangecount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_89(DS,f1,Result) := MACRO//v3__addrchangecount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_90(DS,f1,Result) := MACRO//v3__addrchangecount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_91(DS,f1,Result) := MACRO//v3__agenewestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 7.0 => '> 1.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 17.0 => '> 7.0-17.0',
(real)left.#expand(f1) > 17.0 and (real)left.#expand(f1) <= 41.0 => '> 17.0-41.0',
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


EXPORT range_function_92(DS,f1,Result) := MACRO//v3__ageoldestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 321.0 => '> 0.0-321.0',
(real)left.#expand(f1) > 321.0 and (real)left.#expand(f1) <= 374.0 => '> 321.0-374.0',
(real)left.#expand(f1) > 374.0 and (real)left.#expand(f1) <= 407.0 => '> 374.0-407.0',
(real)left.#expand(f1) > 407.0 and (real)left.#expand(f1) <= 449.0 => '> 407.0-449.0',
(real)left.#expand(f1) > 449.0 and (real)left.#expand(f1) <= 960.0 => '> 449.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_93(DS,f1,Result) := MACRO//v3__aircraftcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_94(DS,f1,Result) := MACRO//v3__aircraftcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_95(DS,f1,Result) := MACRO//v3__aircraftcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_96(DS,f1,Result) := MACRO//v3__aircraftcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_97(DS,f1,Result) := MACRO//v3__aircraftcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_98(DS,f1,Result) := MACRO//v3__aircraftcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_99(DS,f1,Result) := MACRO//v3__aircraftcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_100(DS,f1,Result) := MACRO//v3__aircraftcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_101(DS,f1,Result) := MACRO//v3__arrestage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 42.0 => '> 0.0-42.0',
(real)left.#expand(f1) > 42.0 and (real)left.#expand(f1) <= 79.0 => '> 42.0-79.0',
(real)left.#expand(f1) > 79.0 and (real)left.#expand(f1) <= 99.0 => '> 79.0-99.0',
(real)left.#expand(f1) > 99.0 and (real)left.#expand(f1) <= 111.0 => '> 99.0-111.0',
(real)left.#expand(f1) > 111.0 and (real)left.#expand(f1) <= 960.0 => '> 111.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_102(DS,f1,Result) := MACRO//v3__arrestcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_103(DS,f1,Result) := MACRO//v3__arrestcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_104(DS,f1,Result) := MACRO//v3__arrestcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_105(DS,f1,Result) := MACRO//v3__arrestcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_106(DS,f1,Result) := MACRO//v3__arrestcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_107(DS,f1,Result) := MACRO//v3__arrestcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_108(DS,f1,Result) := MACRO//v3__arrestcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_109(DS,f1,Result) := MACRO//v3__arrestcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_110(DS,f1,Result) := MACRO//v3__bankruptcyage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 53.0 => '> 0.0-53.0',
(real)left.#expand(f1) > 53.0 and (real)left.#expand(f1) <= 107.0 => '> 53.0-107.0',
(real)left.#expand(f1) > 107.0 and (real)left.#expand(f1) <= 172.0 => '> 107.0-172.0',
(real)left.#expand(f1) > 172.0 and (real)left.#expand(f1) <= 230.0 => '> 172.0-230.0',
(real)left.#expand(f1) > 230.0 and (real)left.#expand(f1) <= 960.0 => '> 230.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_111(DS,f1,Result) := MACRO//v3__bankruptcycount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_112(DS,f1,Result) := MACRO//v3__bankruptcycount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_113(DS,f1,Result) := MACRO//v3__bankruptcycount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_114(DS,f1,Result) := MACRO//v3__bankruptcycount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_115(DS,f1,Result) := MACRO//v3__bankruptcycount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_116(DS,f1,Result) := MACRO//v3__bankruptcycount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_117(DS,f1,Result) := MACRO//v3__bankruptcycount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_118(DS,f1,Result) := MACRO//v3__bankruptcycount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_119(DS,f1,Result) := MACRO//v3__creditbureaurecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_120(DS,f1,Result) := MACRO//v3__curraddractivephonelist

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_121(DS,f1,Result) := MACRO//v3__curraddragelastsale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 24.0 => '> 0.0-24.0',
(real)left.#expand(f1) > 24.0 and (real)left.#expand(f1) <= 53.0 => '> 24.0-53.0',
(real)left.#expand(f1) > 53.0 and (real)left.#expand(f1) <= 90.0 => '> 53.0-90.0',
(real)left.#expand(f1) > 90.0 and (real)left.#expand(f1) <= 162.0 => '> 90.0-162.0',
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


EXPORT range_function_122(DS,f1,Result) := MACRO//v3__curraddrapplicantowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_123(DS,f1,Result) := MACRO//v3__curraddrfamilyowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_124(DS,f1,Result) := MACRO//v3__curraddrlandusecode

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_125(DS,f1,Result) := MACRO//v3__curraddroccupantowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_126(DS,f1,Result) := MACRO//v3__curraddrprison

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_127(DS,f1,Result) := MACRO//v3__currprevaddrstatediff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_128(DS,f1,Result) := MACRO//v3__derogage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 38.0 => '> 0.0-38.0',
(real)left.#expand(f1) > 38.0 and (real)left.#expand(f1) <= 83.0 => '> 38.0-83.0',
(real)left.#expand(f1) > 83.0 and (real)left.#expand(f1) <= 139.0 => '> 83.0-139.0',
(real)left.#expand(f1) > 139.0 and (real)left.#expand(f1) <= 211.0 => '> 139.0-211.0',
(real)left.#expand(f1) > 211.0 and (real)left.#expand(f1) <= 960.0 => '> 211.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_129(DS,f1,Result) := MACRO//v3__derogcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_130(DS,f1,Result) := MACRO//v3__derogseverityindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_131(DS,f1,Result) := MACRO//v3__educationattendedcollege

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_132(DS,f1,Result) := MACRO//v3__educationfieldofstudytype

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 6.0 => '> 3.0-6.0',
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


EXPORT range_function_133(DS,f1,Result) := MACRO//v3__educationinstitutionprivate

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_134(DS,f1,Result) := MACRO//v3__educationinstitutionrating

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_135(DS,f1,Result) := MACRO//v3__educationprogram2yr

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_136(DS,f1,Result) := MACRO//v3__educationprogram4yr

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_137(DS,f1,Result) := MACRO//v3__educationprogramgraduate

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_138(DS,f1,Result) := MACRO//v3__evictionage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 41.0 => '> 0.0-41.0',
(real)left.#expand(f1) > 41.0 and (real)left.#expand(f1) <= 91.0 => '> 41.0-91.0',
(real)left.#expand(f1) > 91.0 and (real)left.#expand(f1) <= 141.0 => '> 91.0-141.0',
(real)left.#expand(f1) > 141.0 and (real)left.#expand(f1) <= 181.0 => '> 141.0-181.0',
(real)left.#expand(f1) > 181.0 and (real)left.#expand(f1) <= 960.0 => '> 181.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_139(DS,f1,Result) := MACRO//v3__evictioncount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_140(DS,f1,Result) := MACRO//v3__evictioncount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_141(DS,f1,Result) := MACRO//v3__evictioncount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_142(DS,f1,Result) := MACRO//v3__evictioncount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_143(DS,f1,Result) := MACRO//v3__evictioncount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_144(DS,f1,Result) := MACRO//v3__evictioncount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_145(DS,f1,Result) := MACRO//v3__evictioncount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_146(DS,f1,Result) := MACRO//v3__evictioncount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_147(DS,f1,Result) := MACRO//v3__felonyage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 128.0 => '> 0.0-128.0',
(real)left.#expand(f1) > 128.0 and (real)left.#expand(f1) <= 196.0 => '> 128.0-196.0',
(real)left.#expand(f1) > 196.0 and (real)left.#expand(f1) <= 246.0 => '> 196.0-246.0',
(real)left.#expand(f1) > 246.0 and (real)left.#expand(f1) <= 321.0 => '> 246.0-321.0',
(real)left.#expand(f1) > 321.0 and (real)left.#expand(f1) <= 960.0 => '> 321.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_148(DS,f1,Result) := MACRO//v3__felonycount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_149(DS,f1,Result) := MACRO//v3__felonycount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_150(DS,f1,Result) := MACRO//v3__felonycount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_151(DS,f1,Result) := MACRO//v3__felonycount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_152(DS,f1,Result) := MACRO//v3__felonycount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_153(DS,f1,Result) := MACRO//v3__felonycount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_154(DS,f1,Result) := MACRO//v3__felonycount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_155(DS,f1,Result) := MACRO//v3__felonycount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_156(DS,f1,Result) := MACRO//v3__historicaladdrprison

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_157(DS,f1,Result) := MACRO//v3__inputaddractivephonelist

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_158(DS,f1,Result) := MACRO//v3__inputaddragelastsale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 25.0 => '> 0.0-25.0',
(real)left.#expand(f1) > 25.0 and (real)left.#expand(f1) <= 55.0 => '> 25.0-55.0',
(real)left.#expand(f1) > 55.0 and (real)left.#expand(f1) <= 94.0 => '> 55.0-94.0',
(real)left.#expand(f1) > 94.0 and (real)left.#expand(f1) <= 166.0 => '> 94.0-166.0',
(real)left.#expand(f1) > 166.0 and (real)left.#expand(f1) <= 960.0 => '> 166.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_159(DS,f1,Result) := MACRO//v3__inputaddrapplicantowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_160(DS,f1,Result) := MACRO//v3__inputaddrfamilyowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_161(DS,f1,Result) := MACRO//v3__inputaddrhighrisk

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_162(DS,f1,Result) := MACRO//v3__inputaddridentitiescount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_163(DS,f1,Result) := MACRO//v3__inputaddridentitiesrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_164(DS,f1,Result) := MACRO//v3__inputaddrlandusecode

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_165(DS,f1,Result) := MACRO//v3__inputaddrnotprimaryres

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_166(DS,f1,Result) := MACRO//v3__inputaddroccupantowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_167(DS,f1,Result) := MACRO//v3__inputaddrphonecount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 7.0 => '> 2.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 19.0 => '> 7.0-19.0',
(real)left.#expand(f1) > 19.0 and (real)left.#expand(f1) <= 255.0 => '> 19.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_168(DS,f1,Result) := MACRO//v3__inputaddrphonerecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_169(DS,f1,Result) := MACRO//v3__inputaddrprison

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_170(DS,f1,Result) := MACRO//v3__inputaddrssncount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
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


EXPORT range_function_171(DS,f1,Result) := MACRO//v3__inputaddrssnrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_172(DS,f1,Result) := MACRO//v3__inputareacodechange

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_173(DS,f1,Result) := MACRO//v3__inputcurraddrmatch

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_174(DS,f1,Result) := MACRO//v3__inputcurraddrstatediff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_175(DS,f1,Result) := MACRO//v3__inputphonehighrisk

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_176(DS,f1,Result) := MACRO//v3__inputphonemobile

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_177(DS,f1,Result) := MACRO//v3__inputphonepager

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_178(DS,f1,Result) := MACRO//v3__inputphonetype

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_179(DS,f1,Result) := MACRO//v3__inputprevaddrmatch

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_180(DS,f1,Result) := MACRO//v3__inputzipcorpmil

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_181(DS,f1,Result) := MACRO//v3__inputzippobox

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_182(DS,f1,Result) := MACRO//v3__invalidaddr

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_183(DS,f1,Result) := MACRO//v3__invalidphone

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_184(DS,f1,Result) := MACRO//v3__invalidphonezip

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_185(DS,f1,Result) := MACRO//v3__invalidssn

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_186(DS,f1,Result) := MACRO//v3__lastnamechangecount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_187(DS,f1,Result) := MACRO//v3__lastnamechangecount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_188(DS,f1,Result) := MACRO//v3__lastnamechangecount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_189(DS,f1,Result) := MACRO//v3__lastnamechangecount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_190(DS,f1,Result) := MACRO//v3__lastnamechangecount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_191(DS,f1,Result) := MACRO//v3__lastnamechangecount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_192(DS,f1,Result) := MACRO//v3__lastnamechangecount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_193(DS,f1,Result) := MACRO//v3__liencount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_194(DS,f1,Result) := MACRO//v3__lienfiledage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 52.0 => '> 0.0-52.0',
(real)left.#expand(f1) > 52.0 and (real)left.#expand(f1) <= 99.0 => '> 52.0-99.0',
(real)left.#expand(f1) > 99.0 and (real)left.#expand(f1) <= 158.0 => '> 99.0-158.0',
(real)left.#expand(f1) > 158.0 and (real)left.#expand(f1) <= 222.0 => '> 158.0-222.0',
(real)left.#expand(f1) > 222.0 and (real)left.#expand(f1) <= 960.0 => '> 222.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_195(DS,f1,Result) := MACRO//v3__lienfiledcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_196(DS,f1,Result) := MACRO//v3__lienfiledcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_197(DS,f1,Result) := MACRO//v3__lienfiledcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_198(DS,f1,Result) := MACRO//v3__lienfiledcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_199(DS,f1,Result) := MACRO//v3__lienfiledcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_200(DS,f1,Result) := MACRO//v3__lienfiledcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_201(DS,f1,Result) := MACRO//v3__lienfiledcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_202(DS,f1,Result) := MACRO//v3__lienfiledcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_203(DS,f1,Result) := MACRO//v3__lienreleasedage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 61.0 => '> 0.0-61.0',
(real)left.#expand(f1) > 61.0 and (real)left.#expand(f1) <= 105.0 => '> 61.0-105.0',
(real)left.#expand(f1) > 105.0 and (real)left.#expand(f1) <= 165.0 => '> 105.0-165.0',
(real)left.#expand(f1) > 165.0 and (real)left.#expand(f1) <= 233.0 => '> 165.0-233.0',
(real)left.#expand(f1) > 233.0 and (real)left.#expand(f1) <= 960.0 => '> 233.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_204(DS,f1,Result) := MACRO//v3__lienreleasedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_205(DS,f1,Result) := MACRO//v3__lienreleasedcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_206(DS,f1,Result) := MACRO//v3__lienreleasedcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_207(DS,f1,Result) := MACRO//v3__lienreleasedcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_208(DS,f1,Result) := MACRO//v3__lienreleasedcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_209(DS,f1,Result) := MACRO//v3__lienreleasedcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_210(DS,f1,Result) := MACRO//v3__lienreleasedcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_211(DS,f1,Result) := MACRO//v3__lienreleasedcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_212(DS,f1,Result) := MACRO//v3__nonderogcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 7.0 => '> 0.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 8.0 => '> 7.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 9.0 => '> 8.0-9.0',
(real)left.#expand(f1) > 9.0 and (real)left.#expand(f1) <= 10.0 => '> 9.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 255.0 => '> 10.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_213(DS,f1,Result) := MACRO//v3__nonderogcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_214(DS,f1,Result) := MACRO//v3__nonderogcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_215(DS,f1,Result) := MACRO//v3__nonderogcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_216(DS,f1,Result) := MACRO//v3__nonderogcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 6.0 => '> 5.0-6.0',
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


EXPORT range_function_217(DS,f1,Result) := MACRO//v3__nonderogcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 6.0 => '> 5.0-6.0',
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


EXPORT range_function_218(DS,f1,Result) := MACRO//v3__nonderogcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 6.0 => '> 5.0-6.0',
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


EXPORT range_function_219(DS,f1,Result) := MACRO//v3__nonderogcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 6.0 => '> 5.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 7.0 => '> 6.0-7.0',
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


EXPORT range_function_220(DS,f1,Result) := MACRO//v3__phoneidentitiescount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_221(DS,f1,Result) := MACRO//v3__phoneidentitiesrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_222(DS,f1,Result) := MACRO//v3__phoneother

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_223(DS,f1,Result) := MACRO//v3__phoneotheragenewestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 8.0 => '> 0.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 19.0 => '> 8.0-19.0',
(real)left.#expand(f1) > 19.0 and (real)left.#expand(f1) <= 40.0 => '> 19.0-40.0',
(real)left.#expand(f1) > 40.0 and (real)left.#expand(f1) <= 82.0 => '> 40.0-82.0',
(real)left.#expand(f1) > 82.0 and (real)left.#expand(f1) <= 960.0 => '> 82.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_224(DS,f1,Result) := MACRO//v3__phoneotherageoldestrecord

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 125.0 => '> 0.0-125.0',
(real)left.#expand(f1) > 125.0 and (real)left.#expand(f1) <= 138.0 => '> 125.0-138.0',
(real)left.#expand(f1) > 138.0 and (real)left.#expand(f1) <= 161.0 => '> 138.0-161.0',
(real)left.#expand(f1) > 161.0 and (real)left.#expand(f1) <= 167.0 => '> 161.0-167.0',
(real)left.#expand(f1) > 167.0 and (real)left.#expand(f1) <= 960.0 => '> 167.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_225(DS,f1,Result) := MACRO//v3__predictedannualincome

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 44000.0 => '> 0.0-44000.0',
(real)left.#expand(f1) > 44000.0 and (real)left.#expand(f1) <= 68000.0 => '> 44000.0-68000.0',
(real)left.#expand(f1) > 68000.0 and (real)left.#expand(f1) <= 83000.0 => '> 68000.0-83000.0',
(real)left.#expand(f1) > 83000.0 and (real)left.#expand(f1) <= 102000.0 => '> 83000.0-102000.0',
(real)left.#expand(f1) > 102000.0 and (real)left.#expand(f1) <= 250999.0 => '> 102000.0-250999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_226(DS,f1,Result) := MACRO//v3__prevaddractivephonelist

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_227(DS,f1,Result) := MACRO//v3__prevaddragelastsale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 20.0 => '> 0.0-20.0',
(real)left.#expand(f1) > 20.0 and (real)left.#expand(f1) <= 48.0 => '> 20.0-48.0',
(real)left.#expand(f1) > 48.0 and (real)left.#expand(f1) <= 81.0 => '> 48.0-81.0',
(real)left.#expand(f1) > 81.0 and (real)left.#expand(f1) <= 146.0 => '> 81.0-146.0',
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


EXPORT range_function_228(DS,f1,Result) := MACRO//v3__prevaddrapplicantowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_229(DS,f1,Result) := MACRO//v3__prevaddrfamilyowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_230(DS,f1,Result) := MACRO//v3__prevaddrlandusecode

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_231(DS,f1,Result) := MACRO//v3__prevaddroccupantowned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_232(DS,f1,Result) := MACRO//v3__prevaddrprison

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_233(DS,f1,Result) := MACRO//v3__proflicage

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 2.0 => '> 0.0-2.0',
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 3.0 => '> 2.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 39.0 => '> 3.0-39.0',
(real)left.#expand(f1) > 39.0 and (real)left.#expand(f1) <= 113.0 => '> 39.0-113.0',
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


EXPORT range_function_234(DS,f1,Result) := MACRO//v3__profliccount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_235(DS,f1,Result) := MACRO//v3__profliccount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_236(DS,f1,Result) := MACRO//v3__profliccount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_237(DS,f1,Result) := MACRO//v3__profliccount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_238(DS,f1,Result) := MACRO//v3__profliccount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_239(DS,f1,Result) := MACRO//v3__profliccount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_240(DS,f1,Result) := MACRO//v3__profliccount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_241(DS,f1,Result) := MACRO//v3__profliccount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_242(DS,f1,Result) := MACRO//v3__proflicexpirecount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_243(DS,f1,Result) := MACRO//v3__proflicexpirecount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_244(DS,f1,Result) := MACRO//v3__proflicexpirecount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_245(DS,f1,Result) := MACRO//v3__proflicexpirecount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_246(DS,f1,Result) := MACRO//v3__proflicexpirecount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_247(DS,f1,Result) := MACRO//v3__proflicexpirecount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_248(DS,f1,Result) := MACRO//v3__proflicexpirecount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_249(DS,f1,Result) := MACRO//v3__proflictypecategory

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 2.0 => '> 0.0-2.0',
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


EXPORT range_function_250(DS,f1,Result) := MACRO//v3__propagenewestpurchase

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 50.0 => '> 0.0-50.0',
(real)left.#expand(f1) > 50.0 and (real)left.#expand(f1) <= 111.0 => '> 50.0-111.0',
(real)left.#expand(f1) > 111.0 and (real)left.#expand(f1) <= 164.0 => '> 111.0-164.0',
(real)left.#expand(f1) > 164.0 and (real)left.#expand(f1) <= 236.0 => '> 164.0-236.0',
(real)left.#expand(f1) > 236.0 and (real)left.#expand(f1) <= 960.0 => '> 236.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_251(DS,f1,Result) := MACRO//v3__propagenewestsale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 30.0 => '> 0.0-30.0',
(real)left.#expand(f1) > 30.0 and (real)left.#expand(f1) <= 68.0 => '> 30.0-68.0',
(real)left.#expand(f1) > 68.0 and (real)left.#expand(f1) <= 123.0 => '> 68.0-123.0',
(real)left.#expand(f1) > 123.0 and (real)left.#expand(f1) <= 175.0 => '> 123.0-175.0',
(real)left.#expand(f1) > 175.0 and (real)left.#expand(f1) <= 960.0 => '> 175.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_252(DS,f1,Result) := MACRO//v3__propageoldestpurchase

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 131.0 => '> 0.0-131.0',
(real)left.#expand(f1) > 131.0 and (real)left.#expand(f1) <= 191.0 => '> 131.0-191.0',
(real)left.#expand(f1) > 191.0 and (real)left.#expand(f1) <= 238.0 => '> 191.0-238.0',
(real)left.#expand(f1) > 238.0 and (real)left.#expand(f1) <= 296.0 => '> 238.0-296.0',
(real)left.#expand(f1) > 296.0 and (real)left.#expand(f1) <= 960.0 => '> 296.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_253(DS,f1,Result) := MACRO//v3__propnewestsalepurchaseindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.99 => '> 0.0-0.99',
(real)left.#expand(f1) > 0.99 and (real)left.#expand(f1) <= 1.09 => '> 0.99-1.09',
(real)left.#expand(f1) > 1.09 and (real)left.#expand(f1) <= 1.35 => '> 1.09-1.35',
(real)left.#expand(f1) > 1.35 and (real)left.#expand(f1) <= 1.95 => '> 1.35-1.95',
(real)left.#expand(f1) > 1.95 and (real)left.#expand(f1) <= 99.0 => '> 1.95-99.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_254(DS,f1,Result) := MACRO//v3__propownedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_255(DS,f1,Result) := MACRO//v3__propownedhistoricalcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_256(DS,f1,Result) := MACRO//v3__proppurchasedcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_257(DS,f1,Result) := MACRO//v3__proppurchasedcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_258(DS,f1,Result) := MACRO//v3__proppurchasedcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_259(DS,f1,Result) := MACRO//v3__proppurchasedcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_260(DS,f1,Result) := MACRO//v3__proppurchasedcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_261(DS,f1,Result) := MACRO//v3__proppurchasedcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_262(DS,f1,Result) := MACRO//v3__proppurchasedcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_263(DS,f1,Result) := MACRO//v3__propsoldcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_264(DS,f1,Result) := MACRO//v3__propsoldcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_265(DS,f1,Result) := MACRO//v3__propsoldcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_266(DS,f1,Result) := MACRO//v3__propsoldcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_267(DS,f1,Result) := MACRO//v3__propsoldcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_268(DS,f1,Result) := MACRO//v3__propsoldcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_269(DS,f1,Result) := MACRO//v3__propsoldcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_270(DS,f1,Result) := MACRO//v3__prsearchcollectioncount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 5.0 => '> 2.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 11.0 => '> 5.0-11.0',
(real)left.#expand(f1) > 11.0 and (real)left.#expand(f1) <= 35.0 => '> 11.0-35.0',
(real)left.#expand(f1) > 35.0 and (real)left.#expand(f1) <= 255.0 => '> 35.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_271(DS,f1,Result) := MACRO//v3__prsearchcollectioncount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 17.0 => '> 3.0-17.0',
(real)left.#expand(f1) > 17.0 and (real)left.#expand(f1) <= 18.0 => '> 17.0-18.0',
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


EXPORT range_function_272(DS,f1,Result) := MACRO//v3__prsearchcollectioncount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 10.0 => '> 3.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 43.0 => '> 10.0-43.0',
(real)left.#expand(f1) > 43.0 and (real)left.#expand(f1) <= 255.0 => '> 43.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_273(DS,f1,Result) := MACRO//v3__prsearchcollectioncount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 6.0 => '> 2.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 42.0 => '> 6.0-42.0',
(real)left.#expand(f1) > 42.0 and (real)left.#expand(f1) <= 255.0 => '> 42.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_274(DS,f1,Result) := MACRO//v3__prsearchcollectioncount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 30.0 => '> 5.0-30.0',
(real)left.#expand(f1) > 30.0 and (real)left.#expand(f1) <= 255.0 => '> 30.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_275(DS,f1,Result) := MACRO//v3__prsearchcollectioncount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 26.0 => '> 5.0-26.0',
(real)left.#expand(f1) > 26.0 and (real)left.#expand(f1) <= 255.0 => '> 26.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_276(DS,f1,Result) := MACRO//v3__prsearchcollectioncount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 8.0 => '> 3.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 36.0 => '> 8.0-36.0',
(real)left.#expand(f1) > 36.0 and (real)left.#expand(f1) <= 255.0 => '> 36.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_277(DS,f1,Result) := MACRO//v3__prsearchcollectioncount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 5.0 => '> 2.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 11.0 => '> 5.0-11.0',
(real)left.#expand(f1) > 11.0 and (real)left.#expand(f1) <= 39.0 => '> 11.0-39.0',
(real)left.#expand(f1) > 39.0 and (real)left.#expand(f1) <= 255.0 => '> 39.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_278(DS,f1,Result) := MACRO//v3__prsearchidvfraudcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_279(DS,f1,Result) := MACRO//v3__prsearchidvfraudcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_280(DS,f1,Result) := MACRO//v3__prsearchidvfraudcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_281(DS,f1,Result) := MACRO//v3__prsearchidvfraudcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_282(DS,f1,Result) := MACRO//v3__prsearchidvfraudcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_283(DS,f1,Result) := MACRO//v3__prsearchidvfraudcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_284(DS,f1,Result) := MACRO//v3__prsearchidvfraudcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_285(DS,f1,Result) := MACRO//v3__prsearchidvfraudcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_286(DS,f1,Result) := MACRO//v3__prsearchothercount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 120.0 => '> 0.0-120.0',
(real)left.#expand(f1) > 120.0 and (real)left.#expand(f1) <= 149.0 => '> 120.0-149.0',
(real)left.#expand(f1) > 149.0 and (real)left.#expand(f1) <= 181.0 => '> 149.0-181.0',
(real)left.#expand(f1) > 181.0 and (real)left.#expand(f1) <= 232.0 => '> 181.0-232.0',
(real)left.#expand(f1) > 232.0 and (real)left.#expand(f1) <= 255.0 => '> 232.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_287(DS,f1,Result) := MACRO//v3__prsearchothercount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 10.0 => '> 4.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 19.0 => '> 10.0-19.0',
(real)left.#expand(f1) > 19.0 and (real)left.#expand(f1) <= 36.0 => '> 19.0-36.0',
(real)left.#expand(f1) > 36.0 and (real)left.#expand(f1) <= 255.0 => '> 36.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_288(DS,f1,Result) := MACRO//v3__prsearchothercount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 22.0 => '> 12.0-22.0',
(real)left.#expand(f1) > 22.0 and (real)left.#expand(f1) <= 35.0 => '> 22.0-35.0',
(real)left.#expand(f1) > 35.0 and (real)left.#expand(f1) <= 58.0 => '> 35.0-58.0',
(real)left.#expand(f1) > 58.0 and (real)left.#expand(f1) <= 255.0 => '> 58.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_289(DS,f1,Result) := MACRO//v3__prsearchothercount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 19.0 and (real)left.#expand(f1) <= 30.0 => '> 19.0-30.0',
(real)left.#expand(f1) > 30.0 and (real)left.#expand(f1) <= 45.0 => '> 30.0-45.0',
(real)left.#expand(f1) > 45.0 and (real)left.#expand(f1) <= 70.0 => '> 45.0-70.0',
(real)left.#expand(f1) > 70.0 and (real)left.#expand(f1) <= 255.0 => '> 70.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_290(DS,f1,Result) := MACRO//v3__prsearchothercount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 36.0 => '> 0.0-36.0',
(real)left.#expand(f1) > 36.0 and (real)left.#expand(f1) <= 50.0 => '> 36.0-50.0',
(real)left.#expand(f1) > 50.0 and (real)left.#expand(f1) <= 68.0 => '> 50.0-68.0',
(real)left.#expand(f1) > 68.0 and (real)left.#expand(f1) <= 100.0 => '> 68.0-100.0',
(real)left.#expand(f1) > 100.0 and (real)left.#expand(f1) <= 255.0 => '> 100.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_291(DS,f1,Result) := MACRO//v3__prsearchothercount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 80.0 => '> 0.0-80.0',
(real)left.#expand(f1) > 80.0 and (real)left.#expand(f1) <= 103.0 => '> 80.0-103.0',
(real)left.#expand(f1) > 103.0 and (real)left.#expand(f1) <= 130.0 => '> 103.0-130.0',
(real)left.#expand(f1) > 130.0 and (real)left.#expand(f1) <= 175.0 => '> 130.0-175.0',
(real)left.#expand(f1) > 175.0 and (real)left.#expand(f1) <= 255.0 => '> 175.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_292(DS,f1,Result) := MACRO//v3__prsearchothercount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 98.0 => '> 0.0-98.0',
(real)left.#expand(f1) > 98.0 and (real)left.#expand(f1) <= 123.0 => '> 98.0-123.0',
(real)left.#expand(f1) > 123.0 and (real)left.#expand(f1) <= 151.0 => '> 123.0-151.0',
(real)left.#expand(f1) > 151.0 and (real)left.#expand(f1) <= 198.0 => '> 151.0-198.0',
(real)left.#expand(f1) > 198.0 and (real)left.#expand(f1) <= 255.0 => '> 198.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_293(DS,f1,Result) := MACRO//v3__prsearchothercount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

(real)left.#expand(f1)= 0.0 => '0.0',
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 116.0 => '> 0.0-116.0',
(real)left.#expand(f1) > 116.0 and (real)left.#expand(f1) <= 143.0 => '> 116.0-143.0',
(real)left.#expand(f1) > 143.0 and (real)left.#expand(f1) <= 172.0 => '> 143.0-172.0',
(real)left.#expand(f1) > 172.0 and (real)left.#expand(f1) <= 221.0 => '> 172.0-221.0',
(real)left.#expand(f1) > 221.0 and (real)left.#expand(f1) <= 255.0 => '> 221.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_294(DS,f1,Result) := MACRO//v3__relativesbankruptcycount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_295(DS,f1,Result) := MACRO//v3__relativescount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 7.0 => '> 4.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 10.0 => '> 7.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 15.0 => '> 10.0-15.0',
(real)left.#expand(f1) > 15.0 and (real)left.#expand(f1) <= 255.0 => '> 15.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_296(DS,f1,Result) := MACRO//v3__relativesdistanceclosest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.0 => '> 0.0-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 2.0 => '> 1.0-2.0',
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


EXPORT range_function_297(DS,f1,Result) := MACRO//v3__relativesfelonycount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_298(DS,f1,Result) := MACRO//v3__relativespropownedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_299(DS,f1,Result) := MACRO//v3__relativespropownedtaxtotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 241800.0 => '> 0.0-241800.0',
(real)left.#expand(f1) > 241800.0 and (real)left.#expand(f1) <= 473530.0 => '> 241800.0-473530.0',
(real)left.#expand(f1) > 473530.0 and (real)left.#expand(f1) <= 799011.0 => '> 473530.0-799011.0',
(real)left.#expand(f1) > 799011.0 and (real)left.#expand(f1) <= 1410603.0 => '> 799011.0-1410603.0',
(real)left.#expand(f1) > 1410603.0 and (real)left.#expand(f1) <= 9999999999999 => '> 1410603.0-9999999999999',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_300(DS,f1,Result) := MACRO//v3__sfduaddridentitiescount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_301(DS,f1,Result) := MACRO//v3__sfduaddrssncount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 4.0 => '> 0.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
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


EXPORT range_function_302(DS,f1,Result) := MACRO//v3__srcsconfirmidaddrcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 7.0 => '> 6.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 8.0 => '> 7.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 255.0 => '> 8.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_303(DS,f1,Result) := MACRO//v3__ssn3years

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_304(DS,f1,Result) := MACRO//v3__ssnaddrcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 9.0 => '> 6.0-9.0',
(real)left.#expand(f1) > 9.0 and (real)left.#expand(f1) <= 13.0 => '> 9.0-13.0',
(real)left.#expand(f1) > 13.0 and (real)left.#expand(f1) <= 255.0 => '> 13.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_305(DS,f1,Result) := MACRO//v3__ssnaddrrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_306(DS,f1,Result) := MACRO//v3__ssnafter5

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_307(DS,f1,Result) := MACRO//v3__ssndeceased

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_308(DS,f1,Result) := MACRO//v3__ssnfoundother

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_309(DS,f1,Result) := MACRO//v3__ssnidentitiescount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_310(DS,f1,Result) := MACRO//v3__ssnidentitiesrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_311(DS,f1,Result) := MACRO//v3__ssnissued

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_312(DS,f1,Result) := MACRO//v3__ssnissuedpriordob

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_313(DS,f1,Result) := MACRO//v3__ssnlastnamecount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_314(DS,f1,Result) := MACRO//v3__ssnnonus

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_315(DS,f1,Result) := MACRO//v3__ssnnotfound

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_316(DS,f1,Result) := MACRO//v3__ssnrecent

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_317(DS,f1,Result) := MACRO//v3__subjectaddrcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 7.0 => '> 4.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 10.0 => '> 7.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 14.0 => '> 10.0-14.0',
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


EXPORT range_function_318(DS,f1,Result) := MACRO//v3__subjectaddrrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_319(DS,f1,Result) := MACRO//v3__subjectlastnamecount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_320(DS,f1,Result) := MACRO//v3__subjectphonecount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_321(DS,f1,Result) := MACRO//v3__subjectphonerecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_322(DS,f1,Result) := MACRO//v3__subjectssncount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_323(DS,f1,Result) := MACRO//v3__subjectssnrecentcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_324(DS,f1,Result) := MACRO//v3__subprimesolicitedcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_325(DS,f1,Result) := MACRO//v3__subprimesolicitedcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_326(DS,f1,Result) := MACRO//v3__subprimesolicitedcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_327(DS,f1,Result) := MACRO//v3__subprimesolicitedcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_328(DS,f1,Result) := MACRO//v3__subprimesolicitedcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_329(DS,f1,Result) := MACRO//v3__subprimesolicitedcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_330(DS,f1,Result) := MACRO//v3__subprimesolicitedcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_331(DS,f1,Result) := MACRO//v3__subprimesolicitedcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_332(DS,f1,Result) := MACRO//v3__verificationfailure

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_333(DS,f1,Result) := MACRO//v3__verifiedaddress

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_334(DS,f1,Result) := MACRO//v3__verifieddob

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_335(DS,f1,Result) := MACRO//v3__verifiedname

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_336(DS,f1,Result) := MACRO//v3__verifiedphone

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_337(DS,f1,Result) := MACRO//v3__verifiedphonefullname

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_338(DS,f1,Result) := MACRO//v3__verifiedphonelastname

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_339(DS,f1,Result) := MACRO//v3__verifiedssn

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 2.0 => '> 0.0-2.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_340(DS,f1,Result) := MACRO//v3__watercraftcount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_341(DS,f1,Result) := MACRO//v3__watercraftcount01

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_342(DS,f1,Result) := MACRO//v3__watercraftcount03

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_343(DS,f1,Result) := MACRO//v3__watercraftcount06

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_344(DS,f1,Result) := MACRO//v3__watercraftcount12

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_345(DS,f1,Result) := MACRO//v3__watercraftcount24

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_346(DS,f1,Result) := MACRO//v3__watercraftcount36

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_347(DS,f1,Result) := MACRO//v3__watercraftcount60

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_348(DS,f1,Result) := MACRO//wealthindex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
end;
                                                                                                                
#uniquename(Bks_project)
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
                                                self.attribute_value := IF(regexfind('[0-9]',left.#expand(f1)) or length(trim(left.#expand(f1),left,right))= 0,
                                                    MAP(
                                                                length(trim(left.#expand(f1),left,right))= 0 => 'blank', 

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







//==================================================================
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

EXPORT Average_func(DS,f1,Result) := MACRO

#uniquename(tble)
%tble% := table(ds);

 #uniquename(a2)
 %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<> -1);
// %a2% :=%tble%(regexfind('[0-9]',#expand(f1)) and  length(trim(#expand(f1),left,right))<> 0 and (integer)#expand(f1)<> -1 and (integer)#expand(f1)<> 0);

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
end;

//==================================================================

