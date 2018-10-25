import $;

prefix := '~';

File_Facility_Attributes := DATASET ([],$.Layouts.Layout_best);

EXPORT Key_Facility_Attributes := INDEX(File_Facility_Attributes,
                           {LNPID},{File_Facility_Attributes},
                            prefix + 'thor::key::healthcarefacility::qa::shell');

