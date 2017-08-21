import address,ut;

EXPORT files := module

EXPORT crashcarrier_IN := DATASET(constants.In_crashcarrier, Layouts.crashcarrier_IN, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

EXPORT crashcarrier_base := DATASET(constants.Base_crashcarrier, Layouts.base, FLAT );

export dkeybuild		:= project(crashcarrier_base, transform(layouts.keybuild, self := left));	        


END;