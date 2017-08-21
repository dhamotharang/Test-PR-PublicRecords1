import infutor, ut, data_services;
lfn := '~thor_data400::base::infutor_best_no_FR';
//lfn := data_services.foreign_dataland + 'thor_data400::base::infutor_best_no_FR';

EXPORT File_Infutor_best := dataset(lfn, infutor.layout_best.lbest, thor)(did<>0);
