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