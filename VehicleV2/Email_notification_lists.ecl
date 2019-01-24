export Email_notification_lists (string filedate) := module

export VehicleV2BuildCompletion	:= fileservices.sendemail('krishna.gummadi@lexisnexis.com;qualityassurance@seisint.com;CAmaral@seisint.com',
			'VehicleV2 Full Build Process Completed ' + filedate,
			'Sample records are in WUID:' + workunit);
			

export VehicleV2PersistfilesDeletion	:= fileservices.sendemail('kgummadi@seisint.com',
			'VehicleV2 Persist Files Deleted' + filedate, 'Persist files are deleted in WUID:' + workunit);
			

export PickerBuildCompletion	:= fileservices.sendemail('Andrew.Frederickson@lexisnexisrisk.com;ADeshpande@seisint.com;VInnocent@seisint.com;CMacDonald@seisint.com',
			'New Picker file is available on bctlpedata11/data/data_999/vehreg_make_model/vehicle_valid_make_model_'	+filedate	+'.csv',
			'http://prod_esp.br.seisint.com:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3D' + thorlib.wuid());
		
		
end;

