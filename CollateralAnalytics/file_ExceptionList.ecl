
EXPORT file_ExceptionList := dataset('~thor_data400::in::collateralanalytics::exceptionlist::20200414',
                           CollateralAnalytics.layouts.ExceptionListLayout,csv(SEPARATOR(','),TERMINATOR(['\n','\r','\r\n']),quote('\"'),heading(1)));