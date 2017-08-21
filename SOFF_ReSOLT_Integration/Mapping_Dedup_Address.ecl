  
	
	S_Address_List := SORT(Mapping_address_preprocess, persistent_key,did,relative_flag,address_key,confirmedcurrent,dt_last_seen,LOCAL) ;
  //output(S_Address_List(did =862604977)) ;
  S_Address_List_dedup := DEDUP(S_Address_List, persistent_key,did,relative_flag,address_key,RIGHT,LOCAL) ;

  //DS_Address_List_dedup := DISTRIBUTE(S_Address_List_dedup,HASH(prim_range,predir,prim_name ,addr_suffix,postdir,zip));
	//DS_Address_List_dedup := DISTRIBUTE(S_Address_List_dedup,HASH(did));
export Mapping_Dedup_Address := S_Address_List_dedup : Persist ('persist::IMAP::Deduped_Address_List');