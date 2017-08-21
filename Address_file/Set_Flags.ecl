
address_file.Layout_address_file tSetFlags(address_file.Rollup_On_AddressID l) := transform
 self.govt_flag     := if(l.src_bus_header='G' or l.src_property[3]='G','Y','');
 self.business_flag := if(l.src_bus_header='Y' or l.src_property[1]='B','Y','');
 self.resident_flag := if(l.src_so='Y' or l.src_pcnsr='Y','Y',
                       if(l.src_header='Y' and l.src_bus_header not in ['G','Y'],'Y',
					   if(l.src_property[2]='I','Y',
					   '')));
 self               := l;
end;

pSetFlags := project(address_file.Rollup_On_AddressID,tSetFlags(left));

address_file.Layout_Address_File tRemoveJunk(pSetFlags l) := transform
 self.zip    := if((integer)l.zip   >0,l.zip,'');
 self.zip4   := if((integer)l.zip4  >0,l.zip4,'');
 self.county := if((integer)l.county>0,l.county,'');
 self        := l;
end;

pRemoveJunk := project(pSetFlags,tRemoveJunk(left))((prim_range<>'' or prim_name<>'') and zip<>'');

export Set_Flags := project(pRemoveJunk,tSetFlags(left));