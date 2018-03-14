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
%filter1% := %tble%(#EXPAND(f1)<='-9999999999' and #EXPAND(f1)>='-2');

 #uniquename(ave1)
   %ave1% := ave(%filter1%,(decimal20_4)%filter1%.#expand(f1));
   
   #uniquename(filter2)
%filter2% := %tble%(#EXPAND(f1)<='9999999999' and #EXPAND(f1)>='0');

 #uniquename(ave2)
   %ave2% := ave(%filter2%,(decimal20_4)%filter2%.#expand(f1));
   
   #uniquename(filter3)
%filter3% := %tble%(#EXPAND(f1)='-1');

 #uniquename(ave3)
   %ave3% := ave(%filter3%,(decimal20_4)%filter3%.#expand(f1));
   
   							
   #uniquename(Bks_project)
   %Bks_project% := PROJECT(%tble%, TRANSFORM(%rc%,//self.file_version:='fcra_rvattributes_v4';
                                                   self.field_name:=f1;
                                                   self.distribution_type := 'average';
   																				        self.attribute_value := MAP((integer8)left.#expand(f1) between -9999999999 and -2 => '(-9999999999 )-(-2)',
   																																		 (integer8)left.#expand(f1) between 0 and 9999999999 => '0-9999999999',
                                                                       'UNDEFINED');
   																								self.Count1 := MAP(
                                                                        (integer8)left.#expand(f1) between -9999999999 and -2 => %ave1%,
   																																		 (integer8)left.#expand(f1) between 0 and 9999999999 => %ave2%,
                                                                       %ave3%);										
   		
    ));


#uniquename(dd)
%dd% := dedup( %Bks_project%,all);


result := %dd%;

endmacro;