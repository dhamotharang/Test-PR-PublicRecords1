import watchdog,doxie,_Control;
export Key_best_compID_DID := INDEX(file_compid_best, {did}
													, {{file_compid_best}-[did]} - watchdog.Layout_Exclusions
									, '~thor_data400::key::compid::'+ doxie.Version_SuperKey+'::did');