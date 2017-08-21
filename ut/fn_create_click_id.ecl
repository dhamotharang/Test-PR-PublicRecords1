export fn_create_click_id 
(	 string55 i_address,
	 string5  i_zip,
	 string32 i_lname ,
	 string25 i_housenum ,
	 string55 i_streetname ,
	 string10 i_apt
	 )  := function 
// Construct dataset with parameters.
file_in := DATASET([
	 	{StringLib.StringToUpperCase(i_address)
	 	,StringLib.StringToUpperCase(i_zip)
	 	,StringLib.StringToUpperCase(i_lname)
	 	,StringLib.StringToUpperCase(i_housenum)
	 	,StringLib.StringToUpperCase(i_streetname)
	 	,StringLib.StringToUpperCase(i_apt)
		,0 
	 	}], layout_click_id.infile);
ut.layout_click_id.infile reformat1(file_in L) := TRANSFORM
    integer2 i_address_fcheck      := if((l.i_address[2..3] not in ['ST','RD','TH','ND']) and (REGEXFIND('^[[:digit:]]+$',l.i_address[1..1]) or REGEXFIND('^[[:digit:]]+$',l.i_address[2..2])),1,0);
    self.i_streetname     := if(i_address_fcheck = 1,l.i_address[StringLib.StringFind(l.i_address,' ', 1)+1 ..length(trim(l.i_address,right))],l.i_streetname);// check what should be else 
    self.i_housenum       := if(i_address_fcheck = 1,l.i_address[1..StringLib.StringFind(l.i_address,' ',1)-1],l.i_housenum);
    self.i_addr_chng      := if(i_address_fcheck = 1,1,l.i_addr_chng); 
    SELF := L; 
END;
projected1 := PROJECT(file_in, reformat1(LEFT)); 
  
ut.layout_click_id.infile reformat2(file_in L) := TRANSFORM
    i_address_scheck  := if(StringLib.StringFind( l.i_address,'BOX',1) > 0 or l.i_address[1..2] in ['RR','HC','RT','HW','HH','BX','HY'] or l.i_address[1..3] in ['POB'] , 1,0); 
    self.i_streetname := if(i_address_scheck = 1 and l.i_addr_chng = 0 , l.i_address, l.i_streetname);
    self.i_addr_chng  := if(i_address_scheck = 1 and l.i_addr_chng = 0 , 1, l.i_addr_chng);
    SELF := L; 
END;  
projected2 := PROJECT(projected1, reformat2(LEFT)); 
ut.layout_click_id.infile reformat3(file_in L) := TRANSFORM
	i_address_check    :=  if(l.i_address[1..2] in ['W ','S ','E ','N '] and REGEXFIND('^[[:digit:]]+$',l.i_address[2..4]),1,0); 
	self.i_housenum    :=  if(i_address_check = 1 and l.i_addr_chng = 0,ut.functions_click_id.fn_do_if_t(l.i_address).i_housenum, l.i_housenum);
	self.i_streetname  :=  if(i_address_check = 1 and l.i_addr_chng = 0,ut.functions_click_id.fn_do_if_t(l.i_address).i_streetname ,l.i_streetname);
	self.i_addr_chng   :=  if(i_address_check = 1  and l.i_addr_chng = 0 , 1, l.i_addr_chng);
    SELF := L;
	
END;  
projected3 := PROJECT(projected2, reformat2(LEFT)); 
ut.layout_click_id.infile reformat4(file_in L) := TRANSFORM
 
    i_address_check   :=  if(l.i_address[1..3] in ['SW ','SE ','NE '] and REGEXFIND('^[[:digit:]]+$',l.i_address[4..4]),1,0); 
    self.i_housenum   :=  if(i_address_check = 1 and l.i_addr_chng = 0,ut.functions_click_id.fn_do_if_t(l.i_address).i_housenum,l.i_housenum);
    self.i_streetname :=  if(i_address_check = 1 and l.i_addr_chng = 0,ut.functions_click_id.fn_do_if_t(l.i_address).i_streetname,l.i_streetname);
    self.i_addr_chng  :=  if(i_address_check = 1  and l.i_addr_chng = 0 , 1, l.i_addr_chng);
    SELF := L; 
END; 
projected4 := PROJECT(projected3, reformat4(LEFT));
ut.layout_click_id.infile reformat5(projected4 L) := TRANSFORM
    i_address_check   := if(L.i_address[1..3] in ['SW ','SE ','NE '] and L.i_addr_chng = 0,1,0);
    self.i_streetname := if(i_address_check =1,L.i_address[StringLib.StringFind(L.i_address , ' ',1)+1 .. length(trim(L.i_address,right))],L.i_streetname); 
    self.i_addr_chng  := if(i_address_check =1,1,L.i_addr_chng);
    self := L;
END;
projected5 := PROJECT(projected4, reformat5(LEFT));
ut.layout_click_id.infile reformat6(projected5 L) := TRANSFORM
 
    i_address_check        := if(REGEXFIND('^[[:digit:]]+$',l.i_address[3..3]) and l.i_addr_chng = 0 ,1,0); 
    self.i_streetname      := if(i_address_check = 1 , l.i_address[StringLib.StringFind(L.i_address , ' ',1)+1 .. length(trim(L.i_address,right))],l.i_streetname); 
    self.i_housenum        := if(i_address_check = 1 , l.i_address[1..(StringLib.StringFind(l.i_address, ' ',1)-1)] , l.i_housenum); 
    self.i_addr_chng       := if(i_address_check = 1 , 1,l.i_addr_chng);  
    self := l ; 
END ; 
projected6 := PROJECT(projected5, reformat6(LEFT));
ut.layout_click_id.infile  reformat7(projected6 L) := TRANSFORM
   self.i_streetname      :=  if(l.i_addr_chng = 0 , l.i_address ,l.i_streetname ) ;  
   self.i_addr_chng       :=  if(l.i_addr_chng = 0 , 1, l.i_addr_chng ); 
   self := l ; 
END ; 
projected7 := PROJECT(projected6, reformat7(LEFT));
ut.layout_click_id.infile  reformat8(projected4 L) := TRANSFORM
   i_address_check   :=  if(l.i_streetname[1..2] in ['N ',  'W ','S ','E '] or l.i_streetname[1..3] in ['NE ','NW ','SW ','SE '],1,0);
   self.i_streetname :=  if(i_address_check = 1, l.i_streetname[StringLib.StringFind(l.i_streetname,' ',1)+1 .. length(trim(l.i_streetname,right))], l.i_streetname); 
   self := l ; 
END ; 
projected8 := PROJECT(projected7, reformat8(LEFT));
ut.layout_click_id.infile  reformat9(projected4 L) := TRANSFORM
   self.i_apt        := ut.functions_click_id.fn_get_stringtype(l.i_streetname,l.i_apt).at20;
   self.i_streetname := ut.functions_click_id.fn_get_stringtype(l.i_streetname,l.i_apt).st20;
   self := l;
   
END ; 
projected9:= PROJECT(projected8, reformat9(LEFT));
ut.layout_click_id.out_rec   reformat10(projected9 l) := TRANSFORM
 
    self.i_lname       :=  regexreplace('([[:print:]])\\1*',StringLib.StringFilterOut(l.i_lname,'AEIOUY'), '$1',nocase);
	self.i_streetname  :=  regexreplace('([[:print:]])\\1*',StringLib.StringFilterOut(l.i_streetname,'AEIOUY '), '$1',nocase);
    self := l ; 
END ;		   
projected10 := PROJECT(projected9, reformat10(LEFT));
ut.layout_click_id.out_rec   reformat11(projected10 l) := TRANSFORM
  
  i_lname_t      := StringLib.StringToUpperCase(l.i_lname[1..4]);
  i_zip_t        := if(length(l.i_zip) >5 , l.i_zip[1..5] , l.i_zip ) ; 
  i_streetname_t := if(length(l.i_streetname)< 4, l.i_streetname+'    ' , l.i_streetname); 
  i_hhid_t := StringLib.StringFilterOut(trim(i_zip_t,left,right) + if(trim(l.i_housenum,left,right) != '', trim(l.i_housenum,left,right),
            StringLib.StringFilterOut(trim(i_streetname_t,left,right),' ')[length(StringLib.StringFilterOut(trim(i_streetname_t,left,right),' '))-3 .. length(StringLib.StringFilterOut(trim(i_streetname_t,left,right),' '))])
           + trim(StringLib.StringToUpperCase(i_streetname_t),left)[1..10]  
		   + l.i_apt + i_lname_t ,' -\'\'');
  self.i_hhid  := if(length(trim(i_hhid_t,left,right)) > 38 , '', i_hhid_t);
  self.i_lname := i_lname_t ; 
  self.i_zip   := i_zip_t ;
  self.i_streetname := i_streetname_t ;
  self := l ; 
END ;		   
projected11 := PROJECT(projected10, reformat11(LEFT)); 
		   
return  projected11[1].i_hhid ;
END : DEPRECATED('Application-specific; not appropriate for UT');
