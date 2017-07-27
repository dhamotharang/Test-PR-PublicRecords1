import standard, ut, doxie; 

dbase := file_deadco_base;

rec := record	
  dBase.Abi_number;
  dbase.phone;
  dbase.company_name;
  dbase.bdid;
  standard.Name Name;
  Standard.L_Address.base addr;
  unsigned1 zero := 0;
  unsigned6 fdid := 0;
end;

rec tra(dbase l) := transform
    self.name           := l;
	self.name           := [];
	self.addr   		:= l;
	self.addr.fips_state :=l.ace_fips_st;
	self.addr.fips_county:=l.ace_fips_county;
	self.addr 	:= [];
	self 				:= l;
end;
b:=project(dbase,tra(left));

export File_Deadco_SearchAutokey := b;