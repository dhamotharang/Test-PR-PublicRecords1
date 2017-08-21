import DriversV2,ut;

best_dl_ := dedup(sort(distribute(DriversV2.File_Dl,hash(did))	,did
																,history
																,-dt_last_seen
																,-dt_first_seen
																,-if(lic_issue_date > 0	,lic_issue_date
																						,expiration_date)
																,-dl_number
																,local),did,local);

ut.mac_sf_buildprocess(best_dl_,'~thor_data400::base::compid::best_dl', Best_DL, 3,,true);
export BestDL:=Best_DL;