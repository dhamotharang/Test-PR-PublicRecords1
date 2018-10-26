import $;

prefix := '~';

File_Provider_Attributes := DATASET ([],$.Layouts.Layout_best);

EXPORT Key_Provider_Attributes := INDEX(File_Provider_Attributes,
                           {LNPID},{File_Provider_Attributes},
                            prefix + 'thor::key::healthcareprovider::qa::shell');

