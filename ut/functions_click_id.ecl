import ut;
export functions_click_id := MODULE
 
export fn_get_stringtype(string in_streetname, string in_apt) := MODULE 

 // try with rollup or iterate 
  shared  at1 := if(StringLib.StringFind(in_streetname , '#',1) > 0 , in_streetname[StringLib.StringFind(in_streetname,'#',1)+2 .. length(in_streetname)-StringLib.StringFind(in_streetname,'#',1)],in_apt);
  shared  st1 := if(StringLib.StringFind(in_streetname , '#',1) > 0 , in_streetname[1.. StringLib.StringFind(in_streetname,'#',1)-1], in_streetname);
    
  shared  at2 := if(StringLib.StringFind(st1 , ' FL ',1) > 0 , st1[StringLib.StringFind(st1,'FL',1)+3 .. length(st1)-StringLib.StringFind(st1,'FL',1)],at1);
  shared  st2 := if(StringLib.StringFind(st1 , ' FL ',1) > 0 , st1[1.. StringLib.StringFind(st1,'FL',1)-1], st1);
    
  shared  at3 := if(StringLib.StringFind(st2 , ' APT ',1) > 0 , st2[StringLib.StringFind(st2,'APT',1)+4 .. length(st2)-StringLib.StringFind(st2,'APT',1)],at2);
  shared  st3 := if(StringLib.StringFind(st2 , ' APT ',1) > 0 , st2[1.. StringLib.StringFind(st2,'APT',1)-1], st2);
    
  shared  at4 := if(StringLib.StringFind(st3 , ' STE ',1) > 0 , st3[StringLib.StringFind(st3,'STE',1)+4 .. length(st3)-StringLib.StringFind(st3,'STE',1)],at3);
  shared  st4 := if(StringLib.StringFind(st3 , ' STE ',1) > 0 , st3[1.. StringLib.StringFind(st3,'STE',1)-1], st3);

  shared at5 := if(StringLib.StringFind(st4 , ' UNIT ',1) > 0 , st4[StringLib.StringFind(st4,'UNIT',1)+5 .. length(st4)-StringLib.StringFind(st4,'UNIT',1)],at4);
  shared st5 := if(StringLib.StringFind(st4 , ' UNIT ',1) > 0 , st4[1.. StringLib.StringFind(st4,'UNIT',1)-1], st4);
   
  shared at6 := if(StringLib.StringFind(st5 , ' LOT ',1) > 0 , st5[StringLib.StringFind(st5,'UNIT',1)+4 .. length(st5)-StringLib.StringFind(st5,'LOT',1)],at5);
  shared st6 := if(StringLib.StringFind(st5 , ' LOT ',1) > 0 , st5[1.. StringLib.StringFind(st5,'UNIT',1)-1], st5);
    
  shared at7 := if(StringLib.StringFind(st6 , ' TRLR ',1) > 0 , st6[StringLib.StringFind(st6,'TRLR',1)+5 .. length(st6)-StringLib.StringFind(st6,'TRLR',1)],at6);
  shared st7 := if(StringLib.StringFind(st6 , ' TRLR ',1) > 0 , st6[1.. StringLib.StringFind(st6,'TRLR',1)-1], st6);
    
  shared at8 := if(StringLib.StringFind(st7 , ' BLDG ',1) > 0 , st7[StringLib.StringFind(st7,'BLDG',1)+5 .. length(st7)-StringLib.StringFind(st7,'BLDG',1)],at7);
  shared st8 := if(StringLib.StringFind(st7 , ' BLDG ',1) > 0 , st7[1.. StringLib.StringFind(st7,'BLDG',1)-1], st7);

  shared  at9 := if(StringLib.StringFind(st8 , ' BSMT ',1) > 0 , st8[StringLib.StringFind(st8,'BSMT',1)+5 .. length(st8)-StringLib.StringFind(st8,'BSMT',1)],at8);
  shared  st9 := if(StringLib.StringFind(st8 , ' BSMT ',1) > 0 , st8[1.. StringLib.StringFind(st8,'BSMT',1)-1], st8);

  shared at10 := if(StringLib.StringFind(st9 , ' FRNT ',1) > 0 , st9[StringLib.StringFind(st9,'FRNT',1)+5 .. length(st9)-StringLib.StringFind(st9,'FRNT',1)],at9);
  shared st10 := if(StringLib.StringFind(st9 , ' FRNT ',1) > 0 , st9[1.. StringLib.StringFind(st9,'FRNT',1)-1], st9);
   
  shared at11 := if(StringLib.StringFind(st10 , ' OFC ',1) > 0 , st10[StringLib.StringFind(st10,'OFC',1)+4 .. length(st10)-StringLib.StringFind(st10,'OFC',1)],at10);
  shared st11 := if(StringLib.StringFind(st10 , ' OFC ',1) > 0 , st10[1.. StringLib.StringFind(st10,'OFC',1)-1], st10);
   
  shared at12 := if(StringLib.StringFind(st11 , ' LOWR ',1) > 0 , st11[StringLib.StringFind(st11,'LOWR',1)+5 .. length(st11)-StringLib.StringFind(st11,'LOWR',1)],at11);
  shared st12 := if(StringLib.StringFind(st11 , ' LOWR ',1) > 0 , st11[1.. StringLib.StringFind(st11,'LOWR',1)-1], st11);

  shared  at13 := if(StringLib.StringFind(st12 , ' REAR ',1) > 0 , st12[StringLib.StringFind(st12,'REAR',1)+5 .. length(st12)-StringLib.StringFind(st12,'REAR',1)],at12);
  shared  st13 := if(StringLib.StringFind(st12 , ' REAR ',1) > 0 , st12[1.. StringLib.StringFind(st12,'REAR',1)-1], st12);

  shared  at14 := if(StringLib.StringFind(st13 , ' PH ',1) > 0 , st13[StringLib.StringFind(st13,'PH',1)+3 .. length(st13)-StringLib.StringFind(st13,'PH',1)],at13);
  shared  st14 := if(StringLib.StringFind(st13 , ' PH ',1) > 0 , st13[1.. StringLib.StringFind(st13,'PH',1)-1], st13);

  shared  at15 := if(StringLib.StringFind(st14 , ' RM ',1) > 0 , st14[StringLib.StringFind(st14,'RM',1)+3 .. length(st14)-StringLib.StringFind(st14,'RM',1)],at14);
  shared st15 := if(StringLib.StringFind(st14 , ' RM ',1) > 0 , st14[1.. StringLib.StringFind(st14,'RM',1)-1], st14);

  shared  at16 := if(StringLib.StringFind(st15 , ' SIDE ',1) > 0 , st15[StringLib.StringFind(st15,'SIDE',1)+5 .. length(st15)-StringLib.StringFind(st15,'SIDE',1)],at15);
  shared  st16 := if(StringLib.StringFind(st15 , ' SIDE ',1) > 0 , st15[1.. StringLib.StringFind(st15,'SIDE',1)-1], st15);
   
  shared  at17 := if(StringLib.StringFind(st16 , ' SLIP ',1) > 0 , st16[StringLib.StringFind(st16,'SLIP',1)+5 .. length(st16)-StringLib.StringFind(st16,'SLIP',1)],at16);
  shared  st17 := if(StringLib.StringFind(st16 , ' SLIP ',1) > 0 , st16[1.. StringLib.StringFind(st16,'SLIP',1)-1], st16);
   
  shared  at18 := if(StringLib.StringFind(st17 , ' SPC ',1) > 0 , st17[StringLib.StringFind(st17,'SPC',1)+4 .. length(st17)-StringLib.StringFind(st17,'SPC',1)],at17);
  shared  st18 := if(StringLib.StringFind(st17 , ' SPC ',1) > 0 , st17[1.. StringLib.StringFind(st17,'SPC',1)-1], st17);

  shared  at19 := if(StringLib.StringFind(st18 , ' STOP ',1) > 0 , st18[StringLib.StringFind(st18,'STOP',1)+5 .. length(st18)-StringLib.StringFind(st18,'STOP',1)],at18);
  shared  st19 := if(StringLib.StringFind(st18 , ' STOP ',1) > 0 , st18[1.. StringLib.StringFind(st18,'STOP',1)-1], st18);

  export  at20 := if(StringLib.StringFind(st19 , ' UPPR ',1) > 0 , st19[StringLib.StringFind(st19,'UPPR',1)+5 .. length(st19)-StringLib.StringFind(st19,'UPPR',1)],at19);
  export  st20 := if(StringLib.StringFind(st19 , ' UPPR ',1) > 0 , st19[1.. StringLib.StringFind(st19,'UPPR',1)-1], st19);
 
end; 

export fn_do_if_t(string i_address)  := module  
 shared x:= i_address[StringLib.StringFind(i_address,' ', 1)+1 ..length(trim(i_address,right))] ; 
 shared z:= StringLib.StringFind(i_address[StringLib.StringFind(i_address,' ',1)+1 ..length(trim(i_address,right))], ' ',1)+1;
 shared y:= i_address[StringLib.StringFind(i_address,' ', 1)+1 ..length(trim(i_address,right))] ; 
 
export i_housenum   :=  x[1..StringLib.StringFind((i_address[StringLib.StringFind(i_address,' ', 1)+1 ..length(trim(i_address,right))]),' ' , 1)-1] ; 
export i_streetname :=  y[z..length(trim(i_address[StringLib.StringFind(i_address,' ',1)+1 ..length(trim(i_address,right))]))] ;
end;
end :DEPRECATED('Application-specific; not appropriate for UT'); 