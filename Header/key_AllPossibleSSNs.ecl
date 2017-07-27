import ut, Data_Services;
  idx           := dataset([],Header.layout_AllPossibleSSNs._main); 
  file_key_name := Data_Services.Data_location.Prefix('All_SSN') + 'thor_data400::key::insuranceheader::qa::allpossiblessns';	
	EXPORT key_AllPossibleSSNs   := INDEX(idx, {did}, {idx},	file_key_name);