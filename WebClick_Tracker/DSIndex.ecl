
EXPORT DSIndex := MODULE

		//session Key 
	 	shared dist_maps_dis := distribute(OrderedDSFPos,hash32(Session_id));
		shared maps_dis := sort(dist_maps_dis,Session_id,source,order,Event,local);
		export key_SessionID_dis := index(maps_dis,
							{string32 session_id := maps_dis.session_id ,source,order,event},{Thorlib.Node(),companyid,loginid,vert,date_accessed,hrs,mins},
									'~thor_data400::key::WebClick::qa::Session_dis',DISTRIBUTED);

    //Event Key 
		shared mape_dis := sort(dist_maps_dis,Event,session_id,order,local);						
		export Key_EventID_dis := index(mape_dis,
								{event,string32 session_id := mape_dis.session_id,source,order},{Thorlib.Node(),companyid,loginid,vert,date_accessed,hrs,mins},
										'~thor_data400::key::WebClick::qa::Event_dis',DISTRIBUTED);//,noroot);
   
	  
		//APPID KEy
		shared dist_vert :=distribute(build_vert,hash32(session_id));
		shared map_vert := sort(dist_vert,vert,source,session_id,local);					
		export Key_AppID_dis:= index(map_vert,{Vert,source},{Thorlib.Node(),session_id}
		                            ,'~thor_data400::key::WebClick::qa::Vert_dis',DISTRIBUTED);
		

    //USERID KEY
		shared dist_user :=distribute(build_userID,hash32(session_id));
		shared map_user := sort(dist_user,ID_Type,UserID,source,session_id,local);			
		export Key_userID_dis:= index(map_user,{ID_Type,UserID,source},{Thorlib.Node(),session_id}
		                            ,'~thor_data400::key::WebClick::qa::userid_dis',DISTRIBUTED);

    shared date_rec := RECORD
		    unsigned6 seq;
				unsigned6 min_date ;
				unsigned6 max_date ;
		END;
    
		date_s := min(Key_SessionID_dis,date_accessed);
		date_e := max(Key_SessionID_dis,date_accessed);
    date_ds := DATASET([{1,date_s, date_e}],date_rec);
		export date_key:= index(date_ds,{seq},{min_date,max_date}
		                            ,'~thor_data400::key::WebClick::qa::date_info');

END;								