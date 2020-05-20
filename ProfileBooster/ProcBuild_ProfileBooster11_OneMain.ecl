IMPORT STD, ProfileBooster, ProfileBooster.ProfileBoosterV2_KEL, _Control;

EXPORT ProcBuild_ProfileBooster11_OneMain (string IPaddr, string AbsolutePath, string NotifyList) := FUNCTION

	// NotifyList := '';
	// IPaddr := 'bctlpedata12';  //dev
	// IPaddr := 'bctlpedata10';  //prod
	// AbsolutePath := '/data/Builds/builds/OneMain/data/fulfillment/20191112';  // change the date to the date it's run on

	onThor := _Control.Environment.onThor;
	
	filePB10 := '~thor400::out::profile_booster_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part1';
	isFilePB10 := STD.File.FileExists(filePB10);
	filePB11 := '~thor400::out::profile_boosterV11_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part1';
	isFilePB11 := STD.File.FileExists(filePB11);
	
	filePB10date := IF(isFilePB10,STD.File.GetLogicalFileAttribute(filePB10,'workunit')[2..9],(STRING)STD.Date.Today());
	filePB11date := IF(isFilePB11,STD.File.GetLogicalFileAttribute(filePB11,'workunit')[2..9],(STRING)STD.Date.Today());
	filetorun := MAP(
			(INTEGER)filePB10date>(INTEGER)filePB11date AND isFilePB10 => filePB10,
			(INTEGER)filePB11date>(INTEGER)filePB10date AND isFilePB11 => filePB11,
			filePB10);
	filetorunDate := 	MAP(
			(INTEGER)filePB10date>(INTEGER)filePB11date AND isFilePB10 => filePB10date,
			(INTEGER)filePB11date>(INTEGER)filePB10date AND isFilePB11 => filePB11date,
			(STRING)STD.Date.Today());	
	PB10Version := 	MAP(
			(INTEGER)filePB10date>(INTEGER)filePB11date AND isFilePB10 => '10',
			(INTEGER)filePB11date>(INTEGER)filePB10date AND isFilePB11 => '11',
			'10');		
	todaysDate := STD.Date.Today();
	daysSinceRun := STD.Date.DaysBetween((integer)filetorunDate,todaysDate);
	OUTPUT(daysSinceRun,named('_daysSinceRun'));
	OUTPUT(PB10Version,named('_PB10Version'));
	IF(daysSinceRun>28,
				sequential(
				ProfileBooster.bwr_ProfileBooster11_OneMain_Step1( NotifyList ),
				ProfileBooster.bwr_ProfileBooster11_OneMain_Step2_1( NotifyList ),
				ProfileBooster.bwr_ProfileBooster11_OneMain_Step2_2( NotifyList ),
				ProfileBooster.bwr_ProfileBooster11_OneMain_Step2_3( NotifyList ),
				ProfileBooster.bwr_ProfileBooster11_OneMain_Step2_4( NotifyList ),
				ProfileBooster.bwr_ProfileBooster11_OneMain_Step3( IPaddr, AbsolutePath, NotifyList, 'RERUN', PB10Version )
				),
				sequential(
				ProfileBooster.bwr_ProfileBooster11_OneMain_Step3( IPaddr, AbsolutePath, NotifyList, 'PB11Only', PB10Version )
				)
	);
			
	RETURN 'SUCCESSFULLY COMPLETED ONEMAIN PROCESS';

END;


