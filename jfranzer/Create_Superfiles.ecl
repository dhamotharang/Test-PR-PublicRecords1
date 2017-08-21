//to run in builder window: jfranzer.Create_Superfiles();


import Marketing_best;

export create_superfiles() := 
macro
// #uniquename(do_base_super)
#uniquename(do_key_super)

// %do_base_super% := sequential(
// FileServices.CreateSuperFile('~thor_data400::in::Prof_LicenseV2_CommonLayout',false),
// FileServices.CreateSuperFile('~thor_data400::in::Prof_LicenseV2_CommonLayout_delete',false),
// FileServices.CreateSuperFile('~thor_data400::in::Prof_LicenseV2_CommonLayout_father',false),
// FileServices.CreateSuperFile('~thor_data400::in::Prof_LicenseV2_CommonLayout_grandfather',false)
// );

%do_key_super% := sequential(
FileServices.CreateSuperFile('~thor_data400::key::American_Student::built::DID',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::delete::DID',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::father::DID',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::grandfather::DID',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::great_grandfather::DID',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::qa::DID',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::prod::DID',false),

FileServices.CreateSuperFile('~thor_data400::key::American_Student::built::Address',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::delete::Address',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::father::Address',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::grandfather::Address',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::great_grandfather::Address',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::qa::Address',false),
FileServices.CreateSuperFile('~thor_data400::key::American_Student::prod::Address',false)
);


sequential(
// %do_base_super%
%do_key_super%
);

endmacro;