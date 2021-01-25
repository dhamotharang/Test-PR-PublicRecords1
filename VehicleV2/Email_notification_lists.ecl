IMPORT STD;

EXPORT Email_notification_lists (STRING filedate) := MODULE

	EXPORT VehicleV2BuildCompletion := STD.System.Email.SendEmail(
		'krishna.gummadi@lexisnexis.com;qualityassurance@seisint.com;CAmaral@seisint.com',
		'VehicleV2 Full Build Process Completed ' + filedate,
		'Sample records are in WUID:' + workunit
	);

	EXPORT VehicleV2PersistfilesDeletion := STD.System.Email.SendEmail(
		'kgummadi@seisint.com',
		'VehicleV2 Persist Files Deleted' + filedate, 'Persist files are deleted in WUID:' + workunit
	);

	EXPORT PickerBuildCompletion := STD.System.Email.SendEmail(
		'Andrew.Frederickson@lexisnexisrisk.com;ADeshpande@seisint.com;VInnocent@seisint.com;CMacDonald@seisint.com',
		'New Picker file is available on bctlpedata11/data/data_999/vehreg_make_model/vehicle_valid_make_model_'	+filedate	+'.csv',
		'http://prod_esp.br.seisint.com:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3D' + thorlib.wuid()
	);

END;
