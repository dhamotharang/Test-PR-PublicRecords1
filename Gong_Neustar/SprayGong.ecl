import std, _control;
srcdir := '/hds_3/gongneustar/';

root := '~thordata_400::in::gong::targus::';

sprayFile(string version, string filename, string outname) := 

		std.File.SprayVariable(_control.IPAddress.edata12,
							srcdir + version + '/' + filename,
							8192,'|',,'\t',						// pipe delimited, no quote character
							'thor40_241',
							root + outname,
							,,,true,false,true
						);
						
sfDaily := '~thordata_400::in::gong::targus::daily'; 
sfFull := '~thordata_400::in::gong::targus::full'; 

						
CreateSuperfiles := SEQUENTIAL(
		if (NOT STD.File.SuperFileExists(sfDaily),
				STD.File.CreateSuperFile(sfDaily));
		if (NOT STD.File.SuperFileExists(sfFull),
				STD.File.CreateSuperFile(sfFull));
);


EXPORT SprayGong(string version):= SEQUENTIAL
(	
	CreateSuperFiles,
	STD.File.StartSuperFileTransaction( ),
		STD.File.ClearSuperFile(sfDaily, false),
		STD.File.ClearSuperFile(sfFull, false),
	STD.File.FinishSuperFileTransaction( ),
	sprayFile(version[1..6], 'DailyFeed_'+version+'.txt', 'daily' + '::' + version),
	sprayFile(version[1..6], 'DLP_'+version[1..6]+'.txt', 'full' + '::' + version[1..6]),
	STD.File.StartSuperFileTransaction( ),
		STD.File.AddSuperFile(sfDaily, root + 'daily' + '::' + version),
		STD.File.AddSuperFile(sfFull, root + 'full' + '::' + version[1..6]),
	STD.File.FinishSuperFileTransaction( )
);	