import $;

prefix := '~';

File_Provider_Attributes := DATASET ([],$.Layouts.Layout_best_v3);

EXPORT Key_Provider_Attributes_V4 := INDEX(File_Provider_Attributes,
                           {LNPID},{File_Provider_Attributes},
                            prefix + 'thor::key::healthcareprovider::qa::shell::v4');
