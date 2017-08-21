export string20 PreferredFirstVersionedStr(
	NID.Interfaces.type_name name, integer version) 
		:= FUNCTION
 
  return NID.PreferredFirstNew(name, if(version=2,true,false));
	
END;

