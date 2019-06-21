﻿import prte2_demoWatchlistScreening;

EXPORT Files := module

	export incoming		:= dataset(constants.incoming_filename, layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	export base				:= dataset(constants.base_filename, 	layouts.base, thor);
	export match_name	:= project(base, transform(layouts.key_match_name_entity , self := left));
end;	