// Creates a module in the repository with the name given in the parameter.

EXPORT CreateModule(string modulename) := FUNCTION

	filetype := 'ecl';
	
	attributename :=  'Keys';
	
	InputRec := record
		string ModuleName{xpath('ModuleName')} := modulename;
		string AttributeName{xpath('AttributeName')} := attributename;
		string Type{xpath('Type')} := filetype;
	end;
	
	inrec := dataset([	{modulename, 'Files', filetype},
						{modulename, 'Constants', filetype},
						{modulename, 'Keys', filetype},
						{modulename, 'Layouts', filetype},
						{modulename, 'proc_build_all', filetype},
						{modulename, 'proc_build_base', filetype},
						{modulename, 'proc_build_keys', filetype},
						{modulename, 'as_headers', filetype},
						{modulename, 'fspray', filetype},
						{modulename, 'bwr_one_time_code', filetype}], InputRec);
						
    ECLAttribute := Record
		string ModuleName{xpath('ModuleName')};
		string Name{xpath('ModuleName')}; 
		string Type{xpath('Type')};
	end;
	
	CreateAttributeResponse := record
		DataSet(ECLAttribute) DataColumns{xpath('AttributeInfo')}  ;
	end;
	
	CreateAttributeResponse xform(inrec le) := transform
		localRec := record
			string ModuleName{xpath('ModuleName')} := le.modulename;
			string AttributeName{xpath('AttributeName')} := le.attributename;
			string Type{xpath('Type')} := le.Type;
		end;
		result := SOAPCALL('http://10.241.12.204:8145/WsAttributes',
					'CreateAttribute',
					localrec,
					CreateAttributeResponse,
					xpath('CreateAttributeResponse')
		);
		SELF := result;
	END;
	
	mysoapresults := project(inrec,xform(LEFT));	
	
	return mysoapresults;
	
end;
