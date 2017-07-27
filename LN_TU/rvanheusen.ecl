import header,address,ut;
//don't clean names that are empty and don't clean addresses that are empty.

Layout_Clean_Name := record
  string73 clean_name1;
  string73 clean_name2;
  string73 clean_name3;
  string73 clean_name4;
	string27 street_name;
  string100 addr1;
  string100 addr2;
  //string182 clean;
  LN_TU.Layout_In_Header_UID_SRC;
end;

Layout_Clean_Name CleanName(LN_TU.File_In_Header_UID_SRC l) := Transform
  self.clean_name1 := if(l.orig_first_name='' and l.orig_middle_name='' and l.orig_last_name='','',addrcleanlib.CleanPersonfml73(l.orig_first_name + ' ' + l.orig_middle_name + ' ' + l.orig_last_name + ' ' + l.orig_name_suffix));
  self.clean_name2 := if(l.orig_aka_1='','',addrcleanlib.CleanPersonlfm73(l.orig_aka_1));
  self.clean_name3 := if(l.orig_aka_2='','',addrcleanlib.CleanPersonlfm73(l.orig_aka_2));
  self.clean_name4 := if(l.orig_aka_3='','',addrcleanlib.CleanPersonlfm73(l.orig_aka_3));
  self.street_name := regexreplace('^0+',l.orig_street_name,'');
	self.addr1 := Address.Addr1FromComponents(l.orig_house_number,l.orig_street_direction,self.street_name,
                        l.orig_street_suffix,',',',',l.orig_apartment_number);
  self.addr2 := Address.Addr2FromComponents(l.orig_city, l.orig_state, l.orig_zip5);  
  
  //self.addr1 := l.orig_house_number+' '+l.orig_street_suffix+' '+l.orig_street_direction+' '+l.orig_street_name+' '+l.orig_apartment_number;
  //self.addr2 := l.orig_city+','+l.orig_state+','+l.orig_zip5;
  //self.clean :=if(self.addr1='' and self.addr2='','',addrCleanLib.CleanAddress182(self.addr1,self.addr2));
  self := L;
end;

headers_name_cleaned := PROJECT(LN_TU.File_In_Header_UID_SRC, CleanName(LEFT));


valid_addr_file := headers_name_cleaned(addr1 <> ''and addr2 <> '');

address.mac_address_clean(valid_addr_file,
          	           addr1, 
			           addr2,
			           true,
			           clean_addr_file1);
					 
invalid_addr_file := headers_name_cleaned(addr1 = '' or addr2 = '');					 
					 
clean_addr_record := record
	Layout_Clean_Name,
	string182 clean,
end;

 
clean_addr_record clean_others(invalid_addr_file l) := transform
	self.clean := AddrCleanLib.CleanAddress182(l.addr1,l.addr2);
	self := l;
end;

clean_addr_file2 := project(invalid_addr_file, clean_others(left));

clean_addr_file := clean_addr_file1 + clean_addr_file2;

//output(clean_addr_file,  ,'base::headers_ln_tu_1996',overwrite);
output(clean_addr_file)

  

