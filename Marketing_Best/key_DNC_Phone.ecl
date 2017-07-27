import Marketing_Best, Doxie, ut,DMA;

file_in := DMA.file_suppressionTPS;

filteredFile := file_in(REGEXFIND('[0-9]', AreaCode+PhoneNumber));

export key_DNC_Phone := index(filteredFile,{string10 phone := AreaCode+PhoneNumber},{filteredFile},'~thor_data400::key::Marketing_Best::' + Doxie.Version_SuperKey +'::dnc_phone');