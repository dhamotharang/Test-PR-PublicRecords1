IMPORT ut;

EXPORT file_LeadIntegrityAttributes := DATASET('~thor_data400::base::testseed_leadintegrityattributes', Layout_LeadIntegrityAttributes, CSV(HEADING(single), QUOTE('"'), MAXLENGTH(32768)));