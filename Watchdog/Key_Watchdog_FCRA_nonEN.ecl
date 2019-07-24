Import Data_Services, doxie, vault, _control;

Best_FCRA_nonEN := watchdog.File_Best_FCRA_nonEN;

//apply supplemental

nonEN_supplement := watchdog.fn_apply_supplemental(Best_FCRA_nonEN);

//build index on DID

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_Watchdog_FCRA_nonEN:= vault.Watchdog.Key_Watchdog_FCRA_nonEN;

#ELSE
export Key_Watchdog_FCRA_nonEN:= INDEX(nonEN_supplement,{did},{nonEN_supplement}, Data_Services.Data_location.Prefix('Watchdog_Best') + 'thor_data400::key::watchdog_best::FCRA::nonEN_did_'+ doxie.Version_SuperKey);

#END;

