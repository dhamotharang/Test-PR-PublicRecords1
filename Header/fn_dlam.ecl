
import header_services, DriversV2;

export fn_dlam (dataset(recordof(DriversV2.Layout_Drivers)) dl_in) := FUNCTION

			return DriversV2.regulatory.applyDriversLicense(dl_in);
			
end ;