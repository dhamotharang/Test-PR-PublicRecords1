import ut;

export BuildKeyName(boolean isFCRA = false) := function
	//filedate :=Banko.version; 
	prefix :=  if(isFCRA, 
								'~thor_data400::KEY::Banko::fcra::qa::courtcode.casenumber.caseId.payload', 
								'~thor_data400::KEY::Banko::qa::courtcode.casenumber.caseId.payload');
	return prefix;
end;
