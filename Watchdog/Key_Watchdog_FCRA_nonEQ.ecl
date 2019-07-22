Import Data_Services, doxie;

Best_FCRA_nonEQ := watchdog.File_Best_FCRA_nonEQ;

//apply supplemental

nonEQ_supplement := watchdog.fn_apply_supplemental(Best_FCRA_nonEQ);

//build index on DID

export Key_Watchdog_FCRA_nonEQ:= INDEX(nonEQ_supplement,{did},{nonEQ_supplement}, Data_Services.Data_location.Prefix('Watchdog_Best') + 'thor_data400::key::watchdog_best::FCRA::nonEQ_did_'+ doxie.Version_SuperKey);