
import header_services, DriversV2;

export fn_dlamx (dataset(recordof(DriversV2.Layout_DL)) dl_in) := FUNCTION

			return DriversV2.regulatory.applyDriversLicense(dl_in);

end;