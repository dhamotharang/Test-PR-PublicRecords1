import doxie_build, lib_fileservices, header_services, driversV2, data_services;

		rec := RECORD
				DriversV2.Layout_Drivers;
		END;

		base := dataset(data_services.Data_Location.prefix()+'thor_data400::base::DL2::DLSearch_' + doxie_build.buildstate, rec, flat);

		dlFixed := DriversV2.Regulatory.applyDriversLicense(base);

export File_DL_KeyBuilding := dlFixed;