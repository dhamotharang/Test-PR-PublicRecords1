EXPORT constants := MODULE

	EXPORT prefix := MAP(thorlib.daliServers() = '10.239.227.24:7070' => '~thordev_socialthor_50::', '~thor_data400::');
	EXPORT prefix_persist := MAP(thorlib.daliServers() = '10.239.227.24:7070' => '~thordev_socialthor_50::out::', '~thor_data400::persist::');
	
	EXPORT prefix_input := MAP(thorlib.daliServers() = '10.239.227.24:7070' => '~thordev_socialthor_50::in::', '~thor_data400::in::');
	EXPORT prefix_output := MAP(thorlib.daliServers() = '10.239.227.24:7070' => '~thordev_socialthor_50::out::', '~thor_data400::out::');

	EXPORT TestSampleSize := 1000000 : STORED('TestSampleSize');

END;