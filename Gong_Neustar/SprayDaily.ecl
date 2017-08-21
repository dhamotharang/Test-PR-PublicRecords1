import std, _control;
// this will spray all the daily files in the directory
EXPORT SprayDaily(string version) := FUNCTION

//srcdir := '/hds_3/gongneustar/Daily/';
srcdir := '/data_build_5_2/gongneustar/Daily/';

root := '~thor::in::gong::targus::daily::';
sfDaily := '~thor::in::gong::targus::daily::' + version; 
//sfDailyPrev := '~thor::in::gong::targus::daily::201412';
ip := _control.IPAddress.edata10;

target := 'thor400_dev01';				//'thor40_241'

sprayFile(string filename) := 

		std.File.SprayVariable(_control.IPAddress.edata10,
							srcdir + version + '/' + filename,
							8192,'|',,'\t',						// pipe delimited, no quote character
							target,
							root + version + '::' + filename,
							,,,true,false,true
						);
						
fAddToSuper(string pSubName) :=
			STD.File.AddSuperFile(sfDaily, root + version + '::' + pSubName);

		List := STD.File.RemoteDirectory( _control.IPAddress.edata10, srcdir + version, '*.txt');
		List2 := SORT(List, (integer)REGEXFIND('DailyFeed_(\\d+)\\.txt', name, 1)) : GLOBAL(FEW);

						
SprayFiles := 
		APPLY(List2, SprayFile( name));

AddToSuperFile := 
		SEQUENTIAL
		(
			//NOTHOR(Std.File.PromoteSuperFileList([sfDaily, sfDailyPrev])),
			NOTHOR(Std.File.ClearSuperFile(sfDaily, false)),
			STD.File.StartSuperFileTransaction(),
				NOTHOR(APPLY(List2, fAddToSuper(name))),
			STD.File.FinishSuperFileTransaction()		
		);
						
						
CreateSuperfile := 
		if (NOT STD.File.SuperFileExists(sfDaily),
				STD.File.CreateSuperFile(sfDaily));

return SEQUENTIAL
(	
//	CreateSuperFile,
//	STD.File.StartSuperFileTransaction( ),
//		STD.File.ClearSuperFile(sfDaily, false),
//	STD.File.FinishSuperFileTransaction( ),
	OUTPUT(List2, named('files')),
	CreateSuperfile,
	sprayFiles,
	AddToSuperFile
);
END;