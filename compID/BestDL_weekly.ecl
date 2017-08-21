import DriversV2,ut;

best_dl := dedup(sort(distribute(DriversV2.File_Dl,hash(did))	,did
																,history
																,-dt_last_seen
																,-dt_first_seen
																,-if(lic_issue_date > 0	,lic_issue_date
																						,expiration_date)
																,-dl_number
																,local),did,local);

export BestDL_weekly := best_dl;