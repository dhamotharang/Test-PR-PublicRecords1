import PropertyCharacteristics, ut;

base_file_ := PropertyCharacteristics.Files.Base.Property;
// base_file_ := dataset('~thor_data400::base::propertyinfo_20150720',PropertyCharacteristics.Layouts.Base,thor); 
base_file  := project(base_file_, {base_file_}-insurbase_codes);

EXPORT In_Property_Characteristics := base_file;


