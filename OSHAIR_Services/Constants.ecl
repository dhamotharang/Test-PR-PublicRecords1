EXPORT Constants := MODULE

  EXPORT unsigned4 VIOLATION_MAX := 1000;
  EXPORT unsigned2 SUBSTANCE_MAX := 200;
  EXPORT unsigned2 ACCIDENT_MAX  := 200;
  EXPORT unsigned2 PROGRAM_MAX   := 20; // actual ~12

  // text search
	export STRING stem		:= '~thor_data400::base';
	export STRING srcType := 'oshair';
	export STRING qual		:= 'test';
END;
