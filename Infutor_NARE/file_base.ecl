Import Infutor_NARE, ut;

	ds_base := dataset('~thor_data400::base::email::infutor_email_base',Infutor_NARE.layouts.Scrubs,thor);

EXPORT file_base := project(ds_base,Infutor_NARE.layouts.base_new);