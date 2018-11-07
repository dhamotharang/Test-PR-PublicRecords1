import $;

prefix := '~';

File_Provider_Attributes_Data := DATASET ([],$.Layouts.ProfessionalAttributes_Rec);

EXPORT Key_Provider_Attributes_Data := INDEX(File_Provider_Attributes_Data,
                           {LNPID},{File_Provider_Attributes_Data},
                            prefix + 'thor::key::healthcareprovider::qa::shell::data');
                            // prefix + 'thor::key::healthcareprovider::father::shell::data');

