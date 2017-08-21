Import Data_Services, doxie, ut;

util_daily_bus := project(UtilFile.file_util_bus.full_BDID_for_index(bdid <> 0), transform(UtilFile.Layout_util_daily_bus_out, self.ssn := '', self := left));

export Key_Util_Daily_Bus_Bdid := INDEX(util_daily_bus, {bdid,id},{util_daily_bus},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::utility::daily::bus::bdid_'+doxie.Version_SuperKey);;