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
%Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                self.field_name:=f1;
                                                self.distribution_type := 'range';
																				        self.attribute_value := MAP((integer)left.#expand(f1) between 0 and 50 => '0-50',
                                                                     (integer)left.#expand(f1) between 51 and 50 => '51-100',
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