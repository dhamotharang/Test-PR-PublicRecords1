import doxie, data_services;

util_daily_bus := UtilFile.Util_daily_bus_with_bdid(bdid <> 0);

export Key_Util_Daily_Bus_Bdid := INDEX(util_daily_bus, {bdid,id},{util_daily_bus},data_services.data_location.prefix() + 'thor_data400::key::utility::daily::bus::bdid_'+doxie.Version_SuperKey);;