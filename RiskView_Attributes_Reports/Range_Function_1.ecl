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
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
																				        self.attribute_value := MAP((real)left.#expand(f1)= -1 => '-1',
                                                                     (real)left.#expand(f1) =0 => '0',
																																		 (real)left.#expand(f1) between 0.1 and 0.9 => '0.1-0.9',
                                                                     (real)left.#expand(f1)= 1.0 => '1.0',
																																		 (real)left.#expand(f1) between 1.1 and 99 => '1.1-99',
                                                                     // (integer)left.#expand(f1) between 251 and 255 => '251-255',
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