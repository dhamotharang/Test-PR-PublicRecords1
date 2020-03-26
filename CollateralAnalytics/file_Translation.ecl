//thor_data400::collateralanalytics::translations::ln_field_translations_v2.csv

EXPORT file_Translation := dataset('~thor_data400::collateralanalytics::translations::ln_field_translations_v2.csv',
                           CollateralAnalytics.layouts.translation,csv(SEPARATOR(','),TERMINATOR(['\n','\r','\r\n']),heading(1)));