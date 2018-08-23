EXPORT Constants := Module

	export lfnMaster := '~thor::gong::neustar::master::';
	export lfnHistory := '~thor::gong::neustar::history::';
	export lfnBase := '~thor::gong::neustar::base::';

	export sfMaster := '~thor::gong::neustar::master';
	//export sfHistory := '~thor::gong::neustar::history';
	export sfHistory := '~thor_data400::base::gong_history';
	export sfBase := '~thor::gong::neustar::base';

	export govtRecordTypes := ['G','L','F','S','C'];
	
	//DF-22158 - define fields to be deprecated in 3 FCRA keys
  export fields_to_clear := 'caption_text,county_code,designation,disc_cnt18,disc_cnt6,prior_area_code,see_also_text';

END;