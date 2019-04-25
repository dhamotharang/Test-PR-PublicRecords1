EXPORT riskview_v5_capone_new_bins := module
EXPORT range_function_1(DS,f1,Result) := MACRO//AddrChangeCount03Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_2(DS,f1,Result) := MACRO//AddrChangeCount06Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_3(DS,f1,Result) := MACRO//AddrChangeCount12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_4(DS,f1,Result) := MACRO//AddrChangeCount24Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_5(DS,f1,Result) := MACRO//AddrChangeCount60Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_6(DS,f1,Result) := MACRO//AddrCurrentAVMRatio12MonthPrior

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.96 => '> 0.0-0.96',
(real)left.#expand(f1) > 0.96 and (real)left.#expand(f1) <= 1.03 => '> 0.96-1.03',
(real)left.#expand(f1) > 1.03 and (real)left.#expand(f1) <= 1.07 => '> 1.03-1.07',
(real)left.#expand(f1) > 1.07 and (real)left.#expand(f1) <= 1.18 => '> 1.07-1.18',
(real)left.#expand(f1) > 1.18 and (real)left.#expand(f1) <= 99.99 => '> 1.18-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_7(DS,f1,Result) := MACRO//AddrCurrentAVMRatio60MonthPrior

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.01 => '> 0.0-1.01',
(real)left.#expand(f1) > 1.01 and (real)left.#expand(f1) <= 1.13 => '> 1.01-1.13',
(real)left.#expand(f1) > 1.13 and (real)left.#expand(f1) <= 1.37 => '> 1.13-1.37',
(real)left.#expand(f1) > 1.37 and (real)left.#expand(f1) <= 1.76 => '> 1.37-1.76',
(real)left.#expand(f1) > 1.76 and (real)left.#expand(f1) <= 99.99 => '> 1.76-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_8(DS,f1,Result) := MACRO//AddrCurrentAVMValue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 68000.0 => '> 0.0-68000.0',
(real)left.#expand(f1) > 68000.0 and (real)left.#expand(f1) <= 124938.0 => '> 68000.0-124938.0',
(real)left.#expand(f1) > 124938.0 and (real)left.#expand(f1) <= 182524.0 => '> 124938.0-182524.0',
(real)left.#expand(f1) > 182524.0 and (real)left.#expand(f1) <= 299932.0 => '> 182524.0-299932.0',
(real)left.#expand(f1) > 299932.0 and (real)left.#expand(f1) <= 9999999.0 => '> 299932.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_9(DS,f1,Result) := MACRO//AddrCurrentAVMValue12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 64900.0 => '> 0.0-64900.0',
(real)left.#expand(f1) > 64900.0 and (real)left.#expand(f1) <= 117996.0 => '> 64900.0-117996.0',
(real)left.#expand(f1) > 117996.0 and (real)left.#expand(f1) <= 174000.0 => '> 117996.0-174000.0',
(real)left.#expand(f1) > 174000.0 and (real)left.#expand(f1) <= 285836.0 => '> 174000.0-285836.0',
(real)left.#expand(f1) > 285836.0 and (real)left.#expand(f1) <= 9999999.0 => '> 285836.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_10(DS,f1,Result) := MACRO//AddrCurrentAVMValue60Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 57000.0 => '> 0.0-57000.0',
(real)left.#expand(f1) > 57000.0 and (real)left.#expand(f1) <= 99636.0 => '> 57000.0-99636.0',
(real)left.#expand(f1) > 99636.0 and (real)left.#expand(f1) <= 145724.0 => '> 99636.0-145724.0',
(real)left.#expand(f1) > 145724.0 and (real)left.#expand(f1) <= 227335.0 => '> 145724.0-227335.0',
(real)left.#expand(f1) > 227335.0 and (real)left.#expand(f1) <= 9999999.0 => '> 227335.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_11(DS,f1,Result) := MACRO//AddrCurrentBlockRatio

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.66 => '> 0.0-0.66',
(real)left.#expand(f1) > 0.66 and (real)left.#expand(f1) <= 0.87 => '> 0.66-0.87',
(real)left.#expand(f1) > 0.87 and (real)left.#expand(f1) <= 1.0 => '> 0.87-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 1.22 => '> 1.0-1.22',
(real)left.#expand(f1) > 1.22 and (real)left.#expand(f1) <= 99.99 => '> 1.22-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_12(DS,f1,Result) := MACRO//AddrCurrentCorrectional

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_13(DS,f1,Result) := MACRO//AddrCurrentCountyRatio

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.43 => '> 0.0-0.43',
(real)left.#expand(f1) > 0.43 and (real)left.#expand(f1) <= 0.69 => '> 0.43-0.69',
(real)left.#expand(f1) > 0.69 and (real)left.#expand(f1) <= 0.9 => '> 0.69-0.9',
(real)left.#expand(f1) > 0.9 and (real)left.#expand(f1) <= 1.2 => '> 0.9-1.2',
(real)left.#expand(f1) > 1.2 and (real)left.#expand(f1) <= 99.99 => '> 1.2-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_14(DS,f1,Result) := MACRO//AddrCurrentDeedMailing

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_15(DS,f1,Result) := MACRO//AddrCurrentDwellTypeIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_16(DS,f1,Result) := MACRO//AddrCurrentLastSalesPrice

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 15000.0 => '> 0.0-15000.0',
(real)left.#expand(f1) > 15000.0 and (real)left.#expand(f1) <= 42500.0 => '> 15000.0-42500.0',
(real)left.#expand(f1) > 42500.0 and (real)left.#expand(f1) <= 87195.0 => '> 42500.0-87195.0',
(real)left.#expand(f1) > 87195.0 and (real)left.#expand(f1) <= 175000.0 => '> 87195.0-175000.0',
(real)left.#expand(f1) > 175000.0 and (real)left.#expand(f1) <= 9999999.0 => '> 175000.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_17(DS,f1,Result) := MACRO//AddrCurrentLengthOfRes

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 12.0 => '> 0.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 42.0 => '> 12.0-42.0',
(real)left.#expand(f1) > 42.0 and (real)left.#expand(f1) <= 118.0 => '> 42.0-118.0',
(real)left.#expand(f1) > 118.0 and (real)left.#expand(f1) <= 208.0 => '> 118.0-208.0',
(real)left.#expand(f1) > 208.0 and (real)left.#expand(f1) <= 960.0 => '> 208.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_18(DS,f1,Result) := MACRO//AddrCurrentOwnershipIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_19(DS,f1,Result) := MACRO//AddrCurrentPhoneService

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_20(DS,f1,Result) := MACRO//AddrCurrentSubjectOwned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_21(DS,f1,Result) := MACRO//AddrCurrentTaxMarketValue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 21500.0 => '> 0.0-21500.0',
(real)left.#expand(f1) > 21500.0 and (real)left.#expand(f1) <= 53682.0 => '> 21500.0-53682.0',
(real)left.#expand(f1) > 53682.0 and (real)left.#expand(f1) <= 97110.0 => '> 53682.0-97110.0',
(real)left.#expand(f1) > 97110.0 and (real)left.#expand(f1) <= 149300.0 => '> 97110.0-149300.0',
(real)left.#expand(f1) > 149300.0 and (real)left.#expand(f1) <= 9999999.0 => '> 149300.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_22(DS,f1,Result) := MACRO//AddrCurrentTaxValue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 11700.0 => '> 0.0-11700.0',
(real)left.#expand(f1) > 11700.0 and (real)left.#expand(f1) <= 33925.0 => '> 11700.0-33925.0',
(real)left.#expand(f1) > 33925.0 and (real)left.#expand(f1) <= 79600.0 => '> 33925.0-79600.0',
(real)left.#expand(f1) > 79600.0 and (real)left.#expand(f1) <= 143400.0 => '> 79600.0-143400.0',
(real)left.#expand(f1) > 143400.0 and (real)left.#expand(f1) <= 9999999.0 => '> 143400.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_23(DS,f1,Result) := MACRO//AddrCurrentTimeLastSale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 17.0 => '> 0.0-17.0',
(real)left.#expand(f1) > 17.0 and (real)left.#expand(f1) <= 41.0 => '> 17.0-41.0',
(real)left.#expand(f1) > 41.0 and (real)left.#expand(f1) <= 93.0 => '> 41.0-93.0',
(real)left.#expand(f1) > 93.0 and (real)left.#expand(f1) <= 155.0 => '> 93.0-155.0',
(real)left.#expand(f1) > 155.0 and (real)left.#expand(f1) <= 960.0 => '> 155.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_24(DS,f1,Result) := MACRO//AddrCurrentTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 17.0 and (real)left.#expand(f1) <= 44.0 => '> 17.0-44.0',
(real)left.#expand(f1) > 44.0 and (real)left.#expand(f1) <= 111.0 => '> 44.0-111.0',
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


EXPORT range_function_25(DS,f1,Result) := MACRO//AddrCurrentTimeOldest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 33.0 => '> 0.0-33.0',
(real)left.#expand(f1) > 33.0 and (real)left.#expand(f1) <= 80.0 => '> 33.0-80.0',
(real)left.#expand(f1) > 80.0 and (real)left.#expand(f1) <= 160.0 => '> 80.0-160.0',
(real)left.#expand(f1) > 160.0 and (real)left.#expand(f1) <= 239.0 => '> 160.0-239.0',
(real)left.#expand(f1) > 239.0 and (real)left.#expand(f1) <= 960.0 => '> 239.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_26(DS,f1,Result) := MACRO//AddrCurrentTractRatio

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.7 => '> 0.0-0.7',
(real)left.#expand(f1) > 0.7 and (real)left.#expand(f1) <= 0.9 => '> 0.7-0.9',
(real)left.#expand(f1) > 0.9 and (real)left.#expand(f1) <= 1.01 => '> 0.9-1.01',
(real)left.#expand(f1) > 1.01 and (real)left.#expand(f1) <= 1.22 => '> 1.01-1.22',
(real)left.#expand(f1) > 1.22 and (real)left.#expand(f1) <= 99.99 => '> 1.22-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_27(DS,f1,Result) := MACRO//AddrInputAVMRatio12MonthPrior

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.96 => '> 0.0-0.96',
(real)left.#expand(f1) > 0.96 and (real)left.#expand(f1) <= 1.03 => '> 0.96-1.03',
(real)left.#expand(f1) > 1.03 and (real)left.#expand(f1) <= 1.07 => '> 1.03-1.07',
(real)left.#expand(f1) > 1.07 and (real)left.#expand(f1) <= 1.18 => '> 1.07-1.18',
(real)left.#expand(f1) > 1.18 and (real)left.#expand(f1) <= 99.99 => '> 1.18-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_28(DS,f1,Result) := MACRO//AddrInputAVMRatio60MonthPrior

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 1.01 => '> 0.0-1.01',
(real)left.#expand(f1) > 1.01 and (real)left.#expand(f1) <= 1.13 => '> 1.01-1.13',
(real)left.#expand(f1) > 1.13 and (real)left.#expand(f1) <= 1.37 => '> 1.13-1.37',
(real)left.#expand(f1) > 1.37 and (real)left.#expand(f1) <= 1.75 => '> 1.37-1.75',
(real)left.#expand(f1) > 1.75 and (real)left.#expand(f1) <= 99.99 => '> 1.75-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_29(DS,f1,Result) := MACRO//AddrInputAVMValue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 67257.0 => '> 0.0-67257.0',
(real)left.#expand(f1) > 67257.0 and (real)left.#expand(f1) <= 124602.0 => '> 67257.0-124602.0',
(real)left.#expand(f1) > 124602.0 and (real)left.#expand(f1) <= 183513.0 => '> 124602.0-183513.0',
(real)left.#expand(f1) > 183513.0 and (real)left.#expand(f1) <= 304994.0 => '> 183513.0-304994.0',
(real)left.#expand(f1) > 304994.0 and (real)left.#expand(f1) <= 9999999.0 => '> 304994.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_30(DS,f1,Result) := MACRO//AddrInputAVMValue12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 64900.0 => '> 0.0-64900.0',
(real)left.#expand(f1) > 64900.0 and (real)left.#expand(f1) <= 119171.0 => '> 64900.0-119171.0',
(real)left.#expand(f1) > 119171.0 and (real)left.#expand(f1) <= 175601.0 => '> 119171.0-175601.0',
(real)left.#expand(f1) > 175601.0 and (real)left.#expand(f1) <= 290617.0 => '> 175601.0-290617.0',
(real)left.#expand(f1) > 290617.0 and (real)left.#expand(f1) <= 9999999.0 => '> 290617.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_31(DS,f1,Result) := MACRO//AddrInputAVMValue60Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 58000.0 => '> 0.0-58000.0',
(real)left.#expand(f1) > 58000.0 and (real)left.#expand(f1) <= 100261.0 => '> 58000.0-100261.0',
(real)left.#expand(f1) > 100261.0 and (real)left.#expand(f1) <= 148463.0 => '> 100261.0-148463.0',
(real)left.#expand(f1) > 148463.0 and (real)left.#expand(f1) <= 231428.0 => '> 148463.0-231428.0',
(real)left.#expand(f1) > 231428.0 and (real)left.#expand(f1) <= 9999999.0 => '> 231428.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_32(DS,f1,Result) := MACRO//AddrInputBlockRatio

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.66 => '> 0.0-0.66',
(real)left.#expand(f1) > 0.66 and (real)left.#expand(f1) <= 0.87 => '> 0.66-0.87',
(real)left.#expand(f1) > 0.87 and (real)left.#expand(f1) <= 1.0 => '> 0.87-1.0',
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 1.24 => '> 1.0-1.24',
(real)left.#expand(f1) > 1.24 and (real)left.#expand(f1) <= 99.99 => '> 1.24-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_33(DS,f1,Result) := MACRO//AddrInputCountyRatio

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.43 => '> 0.0-0.43',
(real)left.#expand(f1) > 0.43 and (real)left.#expand(f1) <= 0.69 => '> 0.43-0.69',
(real)left.#expand(f1) > 0.69 and (real)left.#expand(f1) <= 0.91 => '> 0.69-0.91',
(real)left.#expand(f1) > 0.91 and (real)left.#expand(f1) <= 1.22 => '> 0.91-1.22',
(real)left.#expand(f1) > 1.22 and (real)left.#expand(f1) <= 99.99 => '> 1.22-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_34(DS,f1,Result) := MACRO//AddrInputDeedMailing

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_35(DS,f1,Result) := MACRO//AddrInputDelivery

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_36(DS,f1,Result) := MACRO//AddrInputDwellTypeIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_37(DS,f1,Result) := MACRO//AddrInputLastSalePrice

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 10700.0 => '> 0.0-10700.0',
(real)left.#expand(f1) > 10700.0 and (real)left.#expand(f1) <= 29900.0 => '> 10700.0-29900.0',
(real)left.#expand(f1) > 29900.0 and (real)left.#expand(f1) <= 58000.0 => '> 29900.0-58000.0',
(real)left.#expand(f1) > 58000.0 and (real)left.#expand(f1) <= 124500.0 => '> 58000.0-124500.0',
(real)left.#expand(f1) > 124500.0 and (real)left.#expand(f1) <= 9999999.0 => '> 124500.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_38(DS,f1,Result) := MACRO//AddrInputLengthOfRes

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 20.0 => '> 0.0-20.0',
(real)left.#expand(f1) > 20.0 and (real)left.#expand(f1) <= 62.0 => '> 20.0-62.0',
(real)left.#expand(f1) > 62.0 and (real)left.#expand(f1) <= 144.0 => '> 62.0-144.0',
(real)left.#expand(f1) > 144.0 and (real)left.#expand(f1) <= 223.0 => '> 144.0-223.0',
(real)left.#expand(f1) > 223.0 and (real)left.#expand(f1) <= 960.0 => '> 223.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_39(DS,f1,Result) := MACRO//AddrInputMatchIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_40(DS,f1,Result) := MACRO//AddrInputOwnershipIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_41(DS,f1,Result) := MACRO//AddrInputPhoneCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 5.0 => '> 2.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 11.0 => '> 5.0-11.0',
(real)left.#expand(f1) > 11.0 and (real)left.#expand(f1) <= 255.0 => '> 11.0-255.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_42(DS,f1,Result) := MACRO//AddrInputPhoneService

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_43(DS,f1,Result) := MACRO//AddrInputProblems

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 5.0 => '> 2.0-5.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_44(DS,f1,Result) := MACRO//AddrInputSubjectCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_45(DS,f1,Result) := MACRO//AddrInputSubjectOwned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_46(DS,f1,Result) := MACRO//AddrInputTaxMarketValue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 17000.0 => '> 0.0-17000.0',
(real)left.#expand(f1) > 17000.0 and (real)left.#expand(f1) <= 44100.0 => '> 17000.0-44100.0',
(real)left.#expand(f1) > 44100.0 and (real)left.#expand(f1) <= 79200.0 => '> 44100.0-79200.0',
(real)left.#expand(f1) > 79200.0 and (real)left.#expand(f1) <= 133840.0 => '> 79200.0-133840.0',
(real)left.#expand(f1) > 133840.0 and (real)left.#expand(f1) <= 9999999.0 => '> 133840.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_47(DS,f1,Result) := MACRO//AddrInputTaxValue

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 10780.0 => '> 0.0-10780.0',
(real)left.#expand(f1) > 10780.0 and (real)left.#expand(f1) <= 32500.0 => '> 10780.0-32500.0',
(real)left.#expand(f1) > 32500.0 and (real)left.#expand(f1) <= 75300.0 => '> 32500.0-75300.0',
(real)left.#expand(f1) > 75300.0 and (real)left.#expand(f1) <= 136747.0 => '> 75300.0-136747.0',
(real)left.#expand(f1) > 136747.0 and (real)left.#expand(f1) <= 9999999.0 => '> 136747.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_48(DS,f1,Result) := MACRO//AddrInputTimeLastSale

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 34.0 => '> 0.0-34.0',
(real)left.#expand(f1) > 34.0 and (real)left.#expand(f1) <= 72.0 => '> 34.0-72.0',
(real)left.#expand(f1) > 72.0 and (real)left.#expand(f1) <= 127.0 => '> 72.0-127.0',
(real)left.#expand(f1) > 127.0 and (real)left.#expand(f1) <= 189.0 => '> 127.0-189.0',
(real)left.#expand(f1) > 189.0 and (real)left.#expand(f1) <= 960.0 => '> 189.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_49(DS,f1,Result) := MACRO//AddrInputTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 19.0 => '> 1.0-19.0',
(real)left.#expand(f1) > 19.0 and (real)left.#expand(f1) <= 49.0 => '> 19.0-49.0',
(real)left.#expand(f1) > 49.0 and (real)left.#expand(f1) <= 114.0 => '> 49.0-114.0',
(real)left.#expand(f1) > 114.0 and (real)left.#expand(f1) <= 960.0 => '> 114.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_50(DS,f1,Result) := MACRO//AddrInputTimeOldest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 47.0 => '> 0.0-47.0',
(real)left.#expand(f1) > 47.0 and (real)left.#expand(f1) <= 134.0 => '> 47.0-134.0',
(real)left.#expand(f1) > 134.0 and (real)left.#expand(f1) <= 192.0 => '> 134.0-192.0',
(real)left.#expand(f1) > 192.0 and (real)left.#expand(f1) <= 255.0 => '> 192.0-255.0',
(real)left.#expand(f1) > 255.0 and (real)left.#expand(f1) <= 960.0 => '> 255.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_51(DS,f1,Result) := MACRO//AddrInputTractRatio

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.7 => '> 0.0-0.7',
(real)left.#expand(f1) > 0.7 and (real)left.#expand(f1) <= 0.9 => '> 0.7-0.9',
(real)left.#expand(f1) > 0.9 and (real)left.#expand(f1) <= 1.01 => '> 0.9-1.01',
(real)left.#expand(f1) > 1.01 and (real)left.#expand(f1) <= 1.22 => '> 1.01-1.22',
(real)left.#expand(f1) > 1.22 and (real)left.#expand(f1) <= 99.99 => '> 1.22-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_52(DS,f1,Result) := MACRO//AddrLastMoveEconTrajectory

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 3.0 => '> 1.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 7.0 => '> 3.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 9.0 => '> 7.0-9.0',
(real)left.#expand(f1) > 9.0 and (real)left.#expand(f1) <= 12.0 => '> 9.0-12.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_53(DS,f1,Result) := MACRO//AddrLastMoveEconTrajectoryIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_54(DS,f1,Result) := MACRO//AddrLastMoveTaxRatioDiff

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 99.99 => '> 0.0-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_55(DS,f1,Result) := MACRO//AddrOnFileCollege

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_56(DS,f1,Result) := MACRO//AddrOnFileCorrectional

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_57(DS,f1,Result) := MACRO//AddrOnFileCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_58(DS,f1,Result) := MACRO//AddrOnFileHighRisk

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_59(DS,f1,Result) := MACRO//AddrPreviousCorrectional

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_60(DS,f1,Result) := MACRO//AddrPreviousDwellTypeIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_61(DS,f1,Result) := MACRO//AddrPreviousLengthOfRes

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 5.0 => '> 0.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 22.0 => '> 5.0-22.0',
(real)left.#expand(f1) > 22.0 and (real)left.#expand(f1) <= 60.0 => '> 22.0-60.0',
(real)left.#expand(f1) > 60.0 and (real)left.#expand(f1) <= 135.0 => '> 60.0-135.0',
(real)left.#expand(f1) > 135.0 and (real)left.#expand(f1) <= 960.0 => '> 135.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_62(DS,f1,Result) := MACRO//AddrPreviousOwnershipIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_63(DS,f1,Result) := MACRO//AddrPreviousSubjectOwned

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_64(DS,f1,Result) := MACRO//AddrPreviousTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 37.0 => '> 1.0-37.0',
(real)left.#expand(f1) > 37.0 and (real)left.#expand(f1) <= 103.0 => '> 37.0-103.0',
(real)left.#expand(f1) > 103.0 and (real)left.#expand(f1) <= 163.0 => '> 103.0-163.0',
(real)left.#expand(f1) > 163.0 and (real)left.#expand(f1) <= 960.0 => '> 163.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_65(DS,f1,Result) := MACRO//AddrPreviousTimeOldest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 52.0 => '> 0.0-52.0',
(real)left.#expand(f1) > 52.0 and (real)left.#expand(f1) <= 124.0 => '> 52.0-124.0',
(real)left.#expand(f1) > 124.0 and (real)left.#expand(f1) <= 191.0 => '> 124.0-191.0',
(real)left.#expand(f1) > 191.0 and (real)left.#expand(f1) <= 263.0 => '> 191.0-263.0',
(real)left.#expand(f1) > 263.0 and (real)left.#expand(f1) <= 960.0 => '> 263.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_66(DS,f1,Result) := MACRO//AddrStabilityIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_67(DS,f1,Result) := MACRO//AlertRegulatoryCondition

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_68(DS,f1,Result) := MACRO//AssetIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '> 2.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 9.0 => '> 6.0-9.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_69(DS,f1,Result) := MACRO//AssetOwnership

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_70(DS,f1,Result) := MACRO//AssetPersonal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_71(DS,f1,Result) := MACRO//AssetPersonalCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_72(DS,f1,Result) := MACRO//AssetProp

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_73(DS,f1,Result) := MACRO//AssetPropCurrentCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_74(DS,f1,Result) := MACRO//AssetPropCurrentTaxTotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 9680.0 => '> 0.0-9680.0',
(real)left.#expand(f1) > 9680.0 and (real)left.#expand(f1) <= 28550.0 => '> 9680.0-28550.0',
(real)left.#expand(f1) > 28550.0 and (real)left.#expand(f1) <= 74145.0 => '> 28550.0-74145.0',
(real)left.#expand(f1) > 74145.0 and (real)left.#expand(f1) <= 145867.0 => '> 74145.0-145867.0',
(real)left.#expand(f1) > 145867.0 and (real)left.#expand(f1) <= 9999999.0 => '> 145867.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_75(DS,f1,Result) := MACRO//AssetPropEverCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_76(DS,f1,Result) := MACRO//AssetPropEverSoldCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_77(DS,f1,Result) := MACRO//AssetPropIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_78(DS,f1,Result) := MACRO//AssetPropNewestMortgageType

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_79(DS,f1,Result) := MACRO//AssetPropNewestSalePrice

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 35000.0 => '> 0.0-35000.0',
(real)left.#expand(f1) > 35000.0 and (real)left.#expand(f1) <= 77000.0 => '> 35000.0-77000.0',
(real)left.#expand(f1) > 77000.0 and (real)left.#expand(f1) <= 129000.0 => '> 77000.0-129000.0',
(real)left.#expand(f1) > 129000.0 and (real)left.#expand(f1) <= 214000.0 => '> 129000.0-214000.0',
(real)left.#expand(f1) > 214000.0 and (real)left.#expand(f1) <= 9999999.0 => '> 214000.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_80(DS,f1,Result) := MACRO//AssetPropPurchaseCount12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_81(DS,f1,Result) := MACRO//AssetPropPurchaseTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 24.0 => '> 0.0-24.0',
(real)left.#expand(f1) > 24.0 and (real)left.#expand(f1) <= 66.0 => '> 24.0-66.0',
(real)left.#expand(f1) > 66.0 and (real)left.#expand(f1) <= 131.0 => '> 66.0-131.0',
(real)left.#expand(f1) > 131.0 and (real)left.#expand(f1) <= 205.0 => '> 131.0-205.0',
(real)left.#expand(f1) > 205.0 and (real)left.#expand(f1) <= 960.0 => '> 205.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_82(DS,f1,Result) := MACRO//AssetPropPurchaseTimeOldest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 27.0 => '> 0.0-27.0',
(real)left.#expand(f1) > 27.0 and (real)left.#expand(f1) <= 76.0 => '> 27.0-76.0',
(real)left.#expand(f1) > 76.0 and (real)left.#expand(f1) <= 144.0 => '> 76.0-144.0',
(real)left.#expand(f1) > 144.0 and (real)left.#expand(f1) <= 221.0 => '> 144.0-221.0',
(real)left.#expand(f1) > 221.0 and (real)left.#expand(f1) <= 960.0 => '> 221.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_83(DS,f1,Result) := MACRO//AssetPropSalePurchaseRatio

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 0.87 => '> 0.0-0.87',
(real)left.#expand(f1) > 0.87 and (real)left.#expand(f1) <= 1.02 => '> 0.87-1.02',
(real)left.#expand(f1) > 1.02 and (real)left.#expand(f1) <= 1.62 => '> 1.02-1.62',
(real)left.#expand(f1) > 1.62 and (real)left.#expand(f1) <= 99.99 => '> 1.62-99.99',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_84(DS,f1,Result) := MACRO//AssetPropSaleTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 55.0 => '> 0.0-55.0',
(real)left.#expand(f1) > 55.0 and (real)left.#expand(f1) <= 130.0 => '> 55.0-130.0',
(real)left.#expand(f1) > 130.0 and (real)left.#expand(f1) <= 175.0 => '> 130.0-175.0',
(real)left.#expand(f1) > 175.0 and (real)left.#expand(f1) <= 216.0 => '> 175.0-216.0',
(real)left.#expand(f1) > 216.0 and (real)left.#expand(f1) <= 960.0 => '> 216.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_85(DS,f1,Result) := MACRO//AssetPropSaleTimeOldest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 38.0 => '> 0.0-38.0',
(real)left.#expand(f1) > 38.0 and (real)left.#expand(f1) <= 136.0 => '> 38.0-136.0',
(real)left.#expand(f1) > 136.0 and (real)left.#expand(f1) <= 180.0 => '> 136.0-180.0',
(real)left.#expand(f1) > 180.0 and (real)left.#expand(f1) <= 220.0 => '> 180.0-220.0',
(real)left.#expand(f1) > 220.0 and (real)left.#expand(f1) <= 960.0 => '> 220.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_86(DS,f1,Result) := MACRO//AssetPropSoldCount12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_87(DS,f1,Result) := MACRO//BankruptcyChapter

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_88(DS,f1,Result) := MACRO//BankruptcyCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_89(DS,f1,Result) := MACRO//BankruptcyCount24Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_90(DS,f1,Result) := MACRO//BankruptcyDismissed24Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_91(DS,f1,Result) := MACRO//BankruptcyStatus

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_92(DS,f1,Result) := MACRO//BankruptcyTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 12.0 => '> 0.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 37.0 => '> 12.0-37.0',
(real)left.#expand(f1) > 37.0 and (real)left.#expand(f1) <= 69.0 => '> 37.0-69.0',
(real)left.#expand(f1) > 69.0 and (real)left.#expand(f1) <= 120.0 => '> 69.0-120.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_93(DS,f1,Result) := MACRO//BusinessAssociation

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_94(DS,f1,Result) := MACRO//BusinessAssociationIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_95(DS,f1,Result) := MACRO//BusinessAssociationTimeOldest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 9.0 => '> 0.0-9.0',
(real)left.#expand(f1) > 9.0 and (real)left.#expand(f1) <= 29.0 => '> 9.0-29.0',
(real)left.#expand(f1) > 29.0 and (real)left.#expand(f1) <= 50.0 => '> 29.0-50.0',
(real)left.#expand(f1) > 50.0 and (real)left.#expand(f1) <= 83.0 => '> 50.0-83.0',
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


EXPORT range_function_96(DS,f1,Result) := MACRO//BusinessTitleLeadership

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_97(DS,f1,Result) := MACRO//ConfirmationInputAddress

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_98(DS,f1,Result) := MACRO//ConfirmationInputDOB

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_99(DS,f1,Result) := MACRO//ConfirmationInputName

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_100(DS,f1,Result) := MACRO//ConfirmationInputSSN

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_101(DS,f1,Result) := MACRO//ConfirmationSubjectFound

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_102(DS,f1,Result) := MACRO//CriminalFelonyCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_103(DS,f1,Result) := MACRO//CriminalFelonyCount12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_104(DS,f1,Result) := MACRO//CriminalFelonyTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 18.0 => '> 0.0-18.0',
(real)left.#expand(f1) > 18.0 and (real)left.#expand(f1) <= 32.0 => '> 18.0-32.0',
(real)left.#expand(f1) > 32.0 and (real)left.#expand(f1) <= 50.0 => '> 32.0-50.0',
(real)left.#expand(f1) > 50.0 and (real)left.#expand(f1) <= 67.0 => '> 50.0-67.0',
(real)left.#expand(f1) > 67.0 and (real)left.#expand(f1) <= 84.0 => '> 67.0-84.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_105(DS,f1,Result) := MACRO//CriminalNonFelonyCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_106(DS,f1,Result) := MACRO//CriminalNonFelonyCount12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_107(DS,f1,Result) := MACRO//CriminalNonFelonyTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 16.0 => '> 0.0-16.0',
(real)left.#expand(f1) > 16.0 and (real)left.#expand(f1) <= 31.0 => '> 16.0-31.0',
(real)left.#expand(f1) > 31.0 and (real)left.#expand(f1) <= 46.0 => '> 31.0-46.0',
(real)left.#expand(f1) > 46.0 and (real)left.#expand(f1) <= 66.0 => '> 46.0-66.0',
(real)left.#expand(f1) > 66.0 and (real)left.#expand(f1) <= 84.0 => '> 66.0-84.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_108(DS,f1,Result) := MACRO//DerogCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_109(DS,f1,Result) := MACRO//DerogCount12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_110(DS,f1,Result) := MACRO//DerogSeverityIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_111(DS,f1,Result) := MACRO//DerogTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 12.0 => '> 0.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 27.0 => '> 12.0-27.0',
(real)left.#expand(f1) > 27.0 and (real)left.#expand(f1) <= 42.0 => '> 27.0-42.0',
(real)left.#expand(f1) > 42.0 and (real)left.#expand(f1) <= 64.0 => '> 42.0-64.0',
(real)left.#expand(f1) > 64.0 and (real)left.#expand(f1) <= 120.0 => '> 64.0-120.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_112(DS,f1,Result) := MACRO//EducationAttendance

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_113(DS,f1,Result) := MACRO//EducationEvidence

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_114(DS,f1,Result) := MACRO//EducationInstitutionPrivate

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_115(DS,f1,Result) := MACRO//EducationInstitutionRating

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_116(DS,f1,Result) := MACRO//EducationProgramAttended

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 3.0 => '> 1.0-3.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_117(DS,f1,Result) := MACRO//EvictionCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_118(DS,f1,Result) := MACRO//EvictionCount12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_119(DS,f1,Result) := MACRO//EvictionTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 12.0 => '> 0.0-12.0',
(real)left.#expand(f1) > 12.0 and (real)left.#expand(f1) <= 29.0 => '> 12.0-29.0',
(real)left.#expand(f1) > 29.0 and (real)left.#expand(f1) <= 40.0 => '> 29.0-40.0',
(real)left.#expand(f1) > 40.0 and (real)left.#expand(f1) <= 61.0 => '> 40.0-61.0',
(real)left.#expand(f1) > 61.0 and (real)left.#expand(f1) <= 84.0 => '> 61.0-84.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_120(DS,f1,Result) := MACRO//InputProvidedCity

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_121(DS,f1,Result) := MACRO//InputProvidedDateofBirth

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_122(DS,f1,Result) := MACRO//InputProvidedFirstName

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_123(DS,f1,Result) := MACRO//InputProvidedLastName

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_124(DS,f1,Result) := MACRO//InputProvidedLexID

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_125(DS,f1,Result) := MACRO//InputProvidedPhone

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
STRING50 attribute_value ;
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


EXPORT range_function_126(DS,f1,Result) := MACRO//InputProvidedSSN

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_127(DS,f1,Result) := MACRO//InputProvidedState

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_128(DS,f1,Result) := MACRO//InputProvidedStreetAddress

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_129(DS,f1,Result) := MACRO//InputProvidedZipCode

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_130(DS,f1,Result) := MACRO//InquiryAuto12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_131(DS,f1,Result) := MACRO//InquiryBanking12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_132(DS,f1,Result) := MACRO//InquiryCollections12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_133(DS,f1,Result) := MACRO//InquiryNonShortTerm12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_134(DS,f1,Result) := MACRO//InquiryShortTerm12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_135(DS,f1,Result) := MACRO//InquiryTelcom12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_136(DS,f1,Result) := MACRO//LienJudgmentCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_137(DS,f1,Result) := MACRO//LienJudgmentCount12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_138(DS,f1,Result) := MACRO//LienJudgmentCourtCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_139(DS,f1,Result) := MACRO//LienJudgmentDollarTotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 763.0 => '> 0.0-763.0',
(real)left.#expand(f1) > 763.0 and (real)left.#expand(f1) <= 1637.0 => '> 763.0-1637.0',
(real)left.#expand(f1) > 1637.0 and (real)left.#expand(f1) <= 3482.0 => '> 1637.0-3482.0',
(real)left.#expand(f1) > 3482.0 and (real)left.#expand(f1) <= 8167.0 => '> 3482.0-8167.0',
(real)left.#expand(f1) > 8167.0 and (real)left.#expand(f1) <= 9999999.0 => '> 8167.0-9999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_140(DS,f1,Result) := MACRO//LienJudgmentForeclosureCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_141(DS,f1,Result) := MACRO//LienJudgmentOtherCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_142(DS,f1,Result) := MACRO//LienJudgmentSeverityIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_143(DS,f1,Result) := MACRO//LienJudgmentSmallClaimsCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_144(DS,f1,Result) := MACRO//LienJudgmentTaxCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_145(DS,f1,Result) := MACRO//LienJudgmentTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 10.0 => '> 0.0-10.0',
(real)left.#expand(f1) > 10.0 and (real)left.#expand(f1) <= 21.0 => '> 10.0-21.0',
(real)left.#expand(f1) > 21.0 and (real)left.#expand(f1) <= 37.0 => '> 21.0-37.0',
(real)left.#expand(f1) > 37.0 and (real)left.#expand(f1) <= 61.0 => '> 37.0-61.0',
(real)left.#expand(f1) > 61.0 and (real)left.#expand(f1) <= 84.0 => '> 61.0-84.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_146(DS,f1,Result) := MACRO//PhoneInputMobile

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_147(DS,f1,Result) := MACRO//PhoneInputProblems

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_148(DS,f1,Result) := MACRO//PhoneInputSubjectCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_149(DS,f1,Result) := MACRO//ProfLicCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_150(DS,f1,Result) := MACRO//ProfLicTypeCategory

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_151(DS,f1,Result) := MACRO//PurchaseActivityCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_152(DS,f1,Result) := MACRO//PurchaseActivityDollarTotal

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_153(DS,f1,Result) := MACRO//PurchaseActivityIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_154(DS,f1,Result) := MACRO//SSNDateLowIssued

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 19640101.0 => '> 0.0-19640101.0',
(real)left.#expand(f1) > 19640101.0 and (real)left.#expand(f1) <= 19730101.0 => '> 19640101.0-19730101.0',
(real)left.#expand(f1) > 19730101.0 and (real)left.#expand(f1) <= 19820101.0 => '> 19730101.0-19820101.0',
(real)left.#expand(f1) > 19820101.0 and (real)left.#expand(f1) <= 19930309.0 => '> 19820101.0-19930309.0',
(real)left.#expand(f1) > 19930309.0 and (real)left.#expand(f1) <= 99999999.0 => '> 19930309.0-99999999.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_155(DS,f1,Result) := MACRO//SSNDeceased

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_156(DS,f1,Result) := MACRO//SSNProblems

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_157(DS,f1,Result) := MACRO//SSNSubjectCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_158(DS,f1,Result) := MACRO//ShortTermLoanRequest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_159(DS,f1,Result) := MACRO//ShortTermLoanRequest12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_160(DS,f1,Result) := MACRO//ShortTermLoanRequest24Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_161(DS,f1,Result) := MACRO//SourceCredHeaderTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 19.0 => '> 1.0-19.0',
(real)left.#expand(f1) > 19.0 and (real)left.#expand(f1) <= 41.0 => '> 19.0-41.0',
(real)left.#expand(f1) > 41.0 and (real)left.#expand(f1) <= 102.0 => '> 41.0-102.0',
(real)left.#expand(f1) > 102.0 and (real)left.#expand(f1) <= 960.0 => '> 102.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_162(DS,f1,Result) := MACRO//SourceCredHeaderTimeOldest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 84.0 => '> 0.0-84.0',
(real)left.#expand(f1) > 84.0 and (real)left.#expand(f1) <= 210.0 => '> 84.0-210.0',
(real)left.#expand(f1) > 210.0 and (real)left.#expand(f1) <= 296.0 => '> 210.0-296.0',
(real)left.#expand(f1) > 296.0 and (real)left.#expand(f1) <= 360.0 => '> 296.0-360.0',
(real)left.#expand(f1) > 360.0 and (real)left.#expand(f1) <= 960.0 => '> 360.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_163(DS,f1,Result) := MACRO//SourceNonDerogCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_164(DS,f1,Result) := MACRO//SourceNonDerogCount03Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_165(DS,f1,Result) := MACRO//SourceNonDerogCount06Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_166(DS,f1,Result) := MACRO//SourceNonDerogCount12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_167(DS,f1,Result) := MACRO//SourceNonDerogProfileIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 7.0 => '> 5.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 8.0 => '> 7.0-8.0',
(real)left.#expand(f1) > 8.0 and (real)left.#expand(f1) <= 9.0 => '> 8.0-9.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_168(DS,f1,Result) := MACRO//SourceVoterRegistration

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_169(DS,f1,Result) := MACRO//SubjectAbilityIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '> 2.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 9.0 => '> 6.0-9.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_170(DS,f1,Result) := MACRO//SubjectActivityIndex03Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 3.0 => '> 0.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 7.0 => '> 5.0-7.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_171(DS,f1,Result) := MACRO//SubjectActivityIndex06Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 3.0 => '> 0.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 7.0 => '> 5.0-7.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_172(DS,f1,Result) := MACRO//SubjectActivityIndex12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 3.0 => '> 0.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 4.0 => '> 3.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 5.0 => '> 4.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 6.0 => '> 5.0-6.0',
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


EXPORT range_function_173(DS,f1,Result) := MACRO//SubjectAge

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 43.0 => '> 0.0-43.0',
(real)left.#expand(f1) > 43.0 and (real)left.#expand(f1) <= 53.0 => '> 43.0-53.0',
(real)left.#expand(f1) > 53.0 and (real)left.#expand(f1) <= 61.0 => '> 53.0-61.0',
(real)left.#expand(f1) > 61.0 and (real)left.#expand(f1) <= 73.0 => '> 61.0-73.0',
(real)left.#expand(f1) > 73.0 and (real)left.#expand(f1) <= 150.0 => '> 73.0-150.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_174(DS,f1,Result) := MACRO//SubjectDeceased

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_175(DS,f1,Result) := MACRO//SubjectNewestRecord12Month

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_176(DS,f1,Result) := MACRO//SubjectRecordTimeNewest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 16.0 => '> 1.0-16.0',
(real)left.#expand(f1) > 16.0 and (real)left.#expand(f1) <= 36.0 => '> 16.0-36.0',
(real)left.#expand(f1) > 36.0 and (real)left.#expand(f1) <= 97.0 => '> 36.0-97.0',
(real)left.#expand(f1) > 97.0 and (real)left.#expand(f1) <= 960.0 => '> 97.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_177(DS,f1,Result) := MACRO//SubjectRecordTimeOldest

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 0.0 and (real)left.#expand(f1) <= 93.0 => '> 0.0-93.0',
(real)left.#expand(f1) > 93.0 and (real)left.#expand(f1) <= 218.0 => '> 93.0-218.0',
(real)left.#expand(f1) > 218.0 and (real)left.#expand(f1) <= 302.0 => '> 218.0-302.0',
(real)left.#expand(f1) > 302.0 and (real)left.#expand(f1) <= 371.0 => '> 302.0-371.0',
(real)left.#expand(f1) > 371.0 and (real)left.#expand(f1) <= 960.0 => '> 371.0-960.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_178(DS,f1,Result) := MACRO//SubjectSSNCount

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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


EXPORT range_function_179(DS,f1,Result) := MACRO//SubjectStabilityIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 1.0 and (real)left.#expand(f1) <= 3.0 => '> 1.0-3.0',
(real)left.#expand(f1) > 3.0 and (real)left.#expand(f1) <= 5.0 => '> 3.0-5.0',
(real)left.#expand(f1) > 5.0 and (real)left.#expand(f1) <= 7.0 => '> 5.0-7.0',
(real)left.#expand(f1) > 7.0 and (real)left.#expand(f1) <= 9.0 => '> 7.0-9.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
%rc_tab% := record
%Bks_project%.field_name;
%Bks_project%.distribution_type;
%Bks_project%.attribute_value ;
decimal20_4 Count1 := count(group);
end;

result := table(%Bks_project%,%rc_tab%,field_name,distribution_type,attribute_value);

endmacro;



//==================================================================


EXPORT range_function_180(DS,f1,Result) := MACRO//SubjectWillingnessIndex

#uniquename(tble)
%tble% := table(ds);
#uniquename(cnt)
%cnt% := count(%tble%);
#uniquename(rc)
%rc% := record
string field_name;
string distribution_type ;
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
(real)left.#expand(f1) > 2.0 and (real)left.#expand(f1) <= 4.0 => '> 2.0-4.0',
(real)left.#expand(f1) > 4.0 and (real)left.#expand(f1) <= 6.0 => '> 4.0-6.0',
(real)left.#expand(f1) > 6.0 and (real)left.#expand(f1) <= 9.0 => '> 6.0-9.0',
                                                                'UNDEFINED'),
                                                                    'UNDEFINED'
                                                                        );     
                                                                                ));

#uniquename(rc_tab)
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
end;
