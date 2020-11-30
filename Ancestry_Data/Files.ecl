Import Data_Services, Watchdog, Infutor_NARC, Infutor, Ancestry_Data;

Export Files := Module

// Global filter
Export watchdog_best := distribute(Watchdog.File_best(did<>0,dob between 19300101 and 19991231), did );

// #1 infutor narc after applying global filter [I]
lfn := data_services.foreign_prod + 'thor_data400::base::infutor_narc::qa';
narc1 := distribute(dataset(lfn, Infutor_NARC.layouts.Base, thor)(did<>0), did );

Export input_ds_narc := join(narc1, watchdog_best, left.did=right.did, transform(Infutor_NARC.layouts.Base, self := left;), inner, local );


// #2 knowx after applying global filter [I]
knowx := distribute(infutor.Key_Header_Infutor_Knowx(s_did<>0), s_did );

Export infutor_best_knowx := join(knowx, watchdog_best, left.s_did=right.did, transform(recordof(knowx), self := left;), inner, local );


//#3 infutor best after applying global filter [I] for best file
allbest := distribute(infutor.Key_infutor_best_did(did<>0), did );

Export infutor_best := join(allbest, watchdog_best, left.did=right.did, transform(infutor.layout_best.lbest, self := left;), inner, local );

End;