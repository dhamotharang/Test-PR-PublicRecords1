import doxie, data_services;

Util_daily_bus := UtilFile.Util_daily_bus_with_bdid;

export Key_Util_Daily_Bus_ID := INDEX(Util_daily_bus, {id},{Util_daily_bus},data_services.data_location.prefix() + 'thor_data400::key::utility::daily::bus::id_'+doxie.Version_SuperKey);