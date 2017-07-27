export string20 PreferredFirstVersionedStr(
	NID.Interfaces.type_name name, integer version) 
		:= FUNCTION

  return (string20)PreferredFirstVersioned(name, [version])[1].name;
	
END;

