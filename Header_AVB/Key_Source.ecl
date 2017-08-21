import header;

srcFile := dataset([], recordof(header.File_Headers));

export Key_Source := index(srcFile,{rid},{srcFile},'~thor_data400::key::header_delta::source');