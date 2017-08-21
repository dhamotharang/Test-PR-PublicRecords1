
import ut,data_services;
export File_Infutor_Narc_DID := dataset(data_services.Data_location.prefix('Infutor_NARC')+'thor_data400::base::infutor_narc::built',infutor_narc.layouts.base, flat);