
import header_services, DriversV2;

export fn_dlamxtnd (dataset(recordof(DriversV2.Layout_Drivers_Extended)) dl_in) := FUNCTION

			return DriversV2.regulatory.applyDriversLicense(dl_in);

end ;