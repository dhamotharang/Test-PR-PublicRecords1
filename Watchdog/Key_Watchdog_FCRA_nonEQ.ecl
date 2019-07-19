Import Data_Services, doxie, vault, _control;

Best_FCRA_nonEQ := watchdog.File_Best_FCRA_nonEQ;

//apply supplemental

nonEQ_supplement := watchdog.fn_apply_supplemental(Best_FCRA_nonEQ);

//build index on DID


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_Watchdog_FCRA_nonEQ:= vault.Watchdog.Key_Watchdog_FCRA_nonEQ;

#ELSE
export Key_Watchdog_FCRA_nonEQ:= INDEX(nonEQ_supplement,{did},{nonEQ_supplement}, Data_Services.Data_location.Prefix('Watchdog_Best') + 'thor_data400::key::watchdog_best::FCRA::nonEQ_did_'+ doxie.Version_SuperKey);

#END;

