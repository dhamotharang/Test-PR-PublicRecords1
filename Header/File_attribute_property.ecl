IMPORT header;
EXPORT file_attribute_property:=MODULE

    EXPORT filename := '~thor_data400::header::ingest::attributes::property';
    EXPORT file     := dataset(filename,{header.Proc_File_Linking_Attribute},thor);

END;