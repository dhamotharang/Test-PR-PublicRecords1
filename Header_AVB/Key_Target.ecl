import header;

tgtFile := dataset([], recordof(header.File_Headers));

export Key_Target := index(tgtFile,{rid},{tgtFile},'~thor_data400::key::header_delta::target');