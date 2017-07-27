import WebClick_Tracker;


export debug_raw := MODULE


	
	export report := MODULE
	/*
		//get report by SID
		EXPORT get_report_by_SID(set of String20 Company_ID=[],set of string20 UserID=[],set of String32 SessionID=[]) := FUNCTION
			ds_user_1 :=  DSIndex.Key_SessionID(Session_Id in	SessionID);
			// OUTPUT(ds_user_1);
			ds_user_2 := if(Count(UserID)>0,ds_user_1(LoginId in UserID),ds_user_1);
			ds_user := if(Count(Company_ID)>0,ds_user_2(Companyid in Company_Id),ds_user_2);
			
			MAC_Freq_Distribution(ds_user,event,out)
			// OUTPUT(ds_user);
			ds_freq := GROUP(SORT(out,event),event);											
  		RETURN ds_freq;
		END;
	  
		//get report by UID
		EXPORT get_report_by_UID(set of String20 Company_ID=[],set of string20 UserID=[],set of String32 SessionID=[]) := FUNCTION
			ds_user_1 :=  DSIndex.Key_UserID(loginId in	UserID and count(UserId)>0);
			ds_user_2 := if(Count(Company_ID)>0,ds_user_1(companyId in company_id),ds_user_1);
			ds_user := if(Count(SessionID)>0,ds_user_2(session_id in SessionId),ds_user_2);
			// ds_user   := PROJECT(ds_user_3,TRANSFORM(Layouts.EP_SID_rec,SELF := LEFT, SELF := []));  
      MAC_Freq_Distribution(ds_user,event,out)
			ds_freq := GROUP(SORT(out,event),event);											
  		RETURN ds_freq;
		END;
		
		//get report by CID
		EXPORT get_report_by_CID(set of String20 Company_ID=[],set of string20 UserID=[],set of String32 SessionID=[]) := FUNCTION
			ds_user_1 :=  DSIndex.Key_CompanyID(CompanyId in	Company_ID and count(Company_Id)>0);
			ds_user_2 := if(Count(UserID)>0,ds_user_1(LoginId in UserID),ds_user_1);
			ds_user := if(Count(SessionID)>0,ds_user_2(session_id in SessionId),ds_user_2);
			// ds_user   := PROJECT(ds_user_3,TRANSFORM(Layouts.EP_SID_rec,SELF := LEFT, SELF := []));  
      MAC_Freq_Distribution(ds_user,event,out)
			ds_freq := GROUP(SORT(out,event),event);											
  		RETURN ds_freq;
		END;
		*/
		//get report by Event
		EXPORT get_report_by_event(set of string45 evtlist = [],set of string20 Company_ID = [],set of string20 UserID = [],set of string32 SessionID =[]) := FUNCTION

        norm_ip := functions.norm_evtlist(evtlist):GLOBAL;
				
				// OUTPUT(norm_ip);
				
        orig_pos1(INTEGER lvl):=norm_ip[lvl]-norm_ip[lvl+1];
				
				match_p1(dataset(Layouts.SD_Rec) ids,integer lvl ) := //, string45 evt):=
															
																join(ids
																		, DSIndex.key_SessionID_dis
																		,
  																	KEYED(right.session_id= left.session_id) 
																		and
																		right.order = left.order-orig_pos1(lvl)
																		and
																		right.event=StringLib.StringToUpperCase(evtlist[norm_ip[lvl+1]])
																		,
																		Transforms.xfm_SID(left,right)
																		,limit(0,skip)
																		// ,local
																		);
				// OUTPUT(norm_ip);
				int_pos := norm_ip[1];
        int_evt := StringLib.StringToUpperCase(evtlist[int_pos]) :global;	
				// OUTPUT(int_evt);
  			InitSID_3 := PROJECT(DSIndex.Key_EventID_dis(event=int_evt)
				                                // OR
																				// (Count(evtlist) = 0 and event ='LOGIN/LOGIN')
				                                ,TRANSFORM(Layouts.SD_rec,SELF := LEFT,SELF := []));
 															
//				OUTPUT(COUNT(InitSID_3));
				// InitSIDRec_3 := p1+p2;
				// InitSID_2 := If(Count(Company_ID)>=1,InitSID_3(CompanyId in Company_ID),InitSID_3);
			  // InitSID_1 := If(Count(UserID)>=1,InitSID_2(LoginId in UserID),InitSID_2);
				// InitSID   := If(Count(SessionID)>=1,InitSID_1(session_id in SessionID),InitSID_1);
				
				evt_len := count(evtlist)-1;
				// OUTPUT(evt_len );

        
				FinalSIDs  :=     																		
											loop(InitSID_3,evt_len-1
											,match_p1(InitSID_3,counter
											));
											// ,StringLib.StringToUpperCase(evtlist[norm_ip[counter+1]])
				
				// OUTPUT(COUNT(ALLNODES(LOCAL(FinalSIds))));
				
    		RETURN FinalSIds;

		END;
	END;


	EXPORT search := MODULE
	
		//get SD by event 
    EXPORT get_SD_by_event(set of string45 evtlist = [],set of string20 Company_ID = [],set of string20 UserID =[],set of string32 SessionID =[]) := FUNCTION
				FinalSIDs := SORT(report.get_report_by_event(evtlist,Company_ID,UserID,SessionID)
				                        ,order,session_id);
        														
				FinalDSet:=join(FinalSIDs, DSIndex.Key_SEssionID_dis
				                ,LEFT.session_id=RIGHT.session_id
												and
												left.order+1 = RIGHT.order
												,Transforms.xfm_SID(LEFT,RIGHT)
												);
			  			
				MAC_Freq_Distribution(FinalDSet,event,out)
				out_s := SORT(Out,-frequency_percent);	
				RETURN out_s;
		END;

		//get sessionIDS by event
		EXPORT get_SID_by_event(set of string20 evtlist = [],set of string20 Company_ID = [],set of string20 UserID =[],set of string32 SessionID =[]) := FUNCTION
			SUID := GROUP(CHOOSEN(DEDUP(SORT(TABLE(report.get_report_by_event(evtlist,Company_Id,UserID,SessionID)
			                                       ,{LoginID,CompanyID,session_id})
																			 ,CompanyID,LoginID,session_id)
																	,CompanyID,LoginID,session_id)
														,500)
										,CompanyID,LoginID);
      RETURN SUID;
			// Layouts.rec_SID xfm_SID(recordof(SUID) l) := TRANSFORM
				// SELF := l;
			// END;
			// Layouts.rec_SUID xfm_SUID(recordof(SUID) l,DATASET(recordof(SUID)) r) := TRANSFORM
				// SELF.LoginID := l.LoginID;
				// SELF.CompanyID := L.CompanyID;
				// SELF.sessionIDs := PROJECT(r,xfm_SID(LEFT));
			// END;
			// RETURN ROLLUP(SUID,group,xfm_SUID(LEFT,rows(LEFT)));
		END;
		
		//get LoginIDs by event
		EXPORT get_UID_by_event(set of string20 evtlist = [],set of string20 UserID =[],set of string32 SessionID =[]) := FUNCTION
			RETURN DEDUP(SORT(TABLE(report.get_report_by_event(evtlist,UserID,SessionID)
			                       ,{CompanyID,LoginID},local)
											 ,CompanyID,LoginID,local)
									,CompanyID,LoginID,local);
		END;
	  
		//get SesionID by LoginID
		EXPORT get_SID_by_UID(set of String20 Company_ID=[],set of string20 input_UserID=[],set of String32 input_SessionID=[]) := FUNCTION
			ds_user_1 :=  DSIndex.Key_UserID_dis(UserID in input_UserID);
			ds_user   := if(COUNT(input_SessionID)>0,ds_user_1(session_id in input_SessionId),ds_user_1);
			SUID := GROUP(DEDUP(SORT(ds_user
			                         ,UserID,Session_ID,local)
													,UserID,Session_ID,local)
										,UserID,local);
       RETURN SUID;
			// Layouts.rec_SID xfm_SID(recordof(SUID) l) := TRANSFORM
				// SELF := l;
			// END;
			// Layouts.rec_SUID xfm_SUID(recordof(SUID) l,DATASET(recordof(SUID)) r) := TRANSFORM
																	// SELF.sessionIDs := PROJECT(r,xfm_SID(LEFT));
			// END;
			// RETURN ROLLUP(SUID,group,xfm_SUID(LEFT,rows(LEFT)));
		END;
		
		EXPORt get_log_by_SID(set of string32 sessionID = []) := FUNCTION
		 sess_log := GROUP(SORT(DSIndex.Key_SessionID_dis(session_Id in	sessionID)
		                        ,CompanyID,LoginID,Session_ID,local)
											 ,CompanyID,LoginID,Session_ID,local);
     RETURN sess_log;											 
		 //RETURN ROLLUP(sess_log,group,Transforms.xfm_session(LEFT,rows(LEFT)));
		 
	  END;

		
	END;
	
	// EXPORT Compare_IDS := MODULE
		// export 
		
	// END;

ENd;
