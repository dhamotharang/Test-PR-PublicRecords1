
EXPORT file_ExceptionListin := dataset('~thor_data400::in::collateralanalytics::exceptionlist::sprayed',
                           CollateralAnalytics.layouts.ExceptionListLayout,csv(SEPARATOR(','),TERMINATOR(['\n','\r','\r\n']),quote('\"'),heading(1)));