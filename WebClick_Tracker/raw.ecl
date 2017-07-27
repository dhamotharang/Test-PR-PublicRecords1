import WebClick_Tracker;


export raw := MODULE
  
	//Global Frequency Count
  export global_freqCount(DATASET(Layouts.rec_freq) in_ds):= FUNCTION
				total_c := SUM(in_ds,frequency_count);
				out_nl := GROUP(SORT(PROJECT(in_ds,Layouts.rec_freq),event),event);
				Layouts.rec_freq xfm_rec(Layouts.rec_freq L,DATASET(Layouts.rec_freq) R) := TRANSFORM
					SELF.frequency_count := sum(r,frequency_count);
					SELF.frequency_percent := sum(r,frequency_count)/total_c *100;
					SELF := L;
				END;
				out_f := ROLLUP(out_nl,group,xfm_rec(LEFT,ROWS(LEFT)));
				return out_f;
	END;

	
	export report := MODULE
		//get report by SID
		EXPORT get_report_by_SID(Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
				ds_user_1_tmp :=  ALLNODES(LOCAL(DSIndex.Key_SessionID_dis(Session_Id in	inp.SessionID )));
				ds_user_1:=if(inp.Datasource<>'',ds_user_1_tmp(source=inp.Datasource),ds_user_1_tmp);
				// ds_user_2 :=  
				MAC_Freq_Distribution(ds_user_1,event,out)
				out_f := global_freqCount(PROJECT(out,Layouts.rec_freq));
				ds_freq := PROJECT(SORT(out_f,-frequency_count),Layouts.rec_freq);											
				RETURN ds_freq;
		END;
	  
		//get report by UID
		EXPORT get_report_by_UID(String1 user_type ='L' ,Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
				ds_user_1_tmp :=  if(user_type='L' ,DSIndex.Key_UserID_dis(ID_Type=user_type and UserID in inp.User_ID )
																			 ,if(user_type='C' 
																			 ,DSIndex.Key_UserID_dis(ID_Type=user_type and UserID in inp.Company_ID )));
				ds_user_1:=if(inp.Datasource<>'',ds_user_1_tmp(source=inp.Datasource),ds_user_1_tmp);
				// if(inp.Datasource<>'',right.source=inp.Datasource,right.source<>'')
				ds_user   := JOIN(ds_user_1,DSIndex.Key_SessionId_dis
													,LEFT.session_id=RIGHT.session_id and
													if(inp.Datasource<>'',right.source=inp.Datasource,right.source<>'')
													,TRANSFORM(Layouts.SD_rec,SELF := RIGHT, SELF := [])
													,LIMIT(1000,SKIP)); 
				ds_user_sdft := IF(inp.date_s >0,ds_user(date_accessed >=inp.date_s),ds_user);
				ds_user_edft := IF(inp.date_e >0,ds_user_sdft(date_accessed <=inp.date_e),ds_user_sdft);
				                     
				// MAC_Freq_Distribution(LOCAL(ds_user),event,out)
				MAC_Freq_Distribution(ds_user_edft,event,out)
				out_s := ALLNODES(LOCAL(out));	
				out_f := global_freqCount(PROJECT(out_s,Layouts.rec_freq));
				RETURN SORT(out_f,-frequency_count);
		END;
    
		//get report by AID
		EXPORT get_report_by_AID(Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
				ds_appID_1_tmp :=  DSIndex.Key_AppID_dis(Vert in inp.App_ID );
				ds_appID_1:=if(inp.Datasource<>'',ds_appID_1_tmp(source=inp.Datasource),ds_appID_1_tmp);														 
				ds_appID   := JOIN(ds_appID_1,DSIndex.Key_SessionId_dis
													,LEFT.session_id=RIGHT.session_id and
													if(inp.Datasource<>'',right.source=inp.Datasource,right.source<>'')
													,TRANSFORM(Layouts.SD_rec,SELF := RIGHT, SELF := [])
													);  
				ds_appID_sdft := IF(inp.date_s >0,ds_appID(date_accessed >=inp.date_s),ds_appID);
				ds_appID_edft := IF(inp.date_e >0,ds_appID_sdft(date_accessed <=inp.date_e),ds_appID_sdft);
				                     													
				MAC_Freq_Distribution(LOCAL(ds_appID_edft),event,out)
				out_s := ALLNODES(out);	
				out_f := global_freqCount(PROJECT(out_s,Layouts.rec_freq));
				// output(ds_appID_1_tmp);
				RETURN SORT(out_f,-frequency_count);
		END;

		//get report by Event
		EXPORT get_report_by_event(Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
				
				
				INrec := RECORD
					String1 op_code;
					String45 evt;
					Integer6 orig_order;
					Set of Integer6 range_list := [] ;
				END;
				InRec NormIt(set of string45 L,integer6 c) := TRANSFORM
						SELF.op_code := '1';
						SELF.evt := TRIM(StringLib.StringToUpperCase(L[c]));
						SELF.orig_order := c;
						SELF := [];
				END;
				
				//Noamlised input 
				// evtlist1 := inp.evtlist ;
				evtlist1 := if(EXISTS(inp.evtlist),inp.evtlist, if(inp.DataSource='D',['FIND A PERSON'],['LOGIN/LOGIN']));
				Norm_evt := NORMALIZE(dataset([{'a','1','1'}],Inrec),COUNT(evtlist1),NormIt(evtlist1,counter));
				Norm := SORT(Norm_evt + DATASET([{'2','','',set(Norm_evt,orig_order)}],Inrec),op_code) : GLOBAL ;

				//empty input dataset for the graph
				emp_ds := DATASET([],WebClick_Tracker.Layouts.SD_rec);
				
				decode_opcode(Inrec in_ds, set of dataset(WebClick_Tracker.Layouts.SD_rec) sid, integer c) := FUNCTION
						 WebClick_Tracker.Layouts.SD_rec xfm_join(WebClick_Tracker.Layouts.SD_rec l,dataset(WebClick_Tracker.Layouts.SD_rec) r):= TRANSFORM
								SELF.order := MAX(r,order);
								SELf := r[count(r)];
								SELF := L;
								SELF := [];
						 ENd;
						 
						 //reading index
						 NDX_READ(string45 str) := FUNCTION
						    
								ftr_rec := RECORD
									string32 session_id ;
								END;
								
								// Init_ds := If(inp.Date_s>0,indx_r(Date_accessed >= inp.Date_s),indx_r);
								// Init_de := If(inp.Date_e>0,InitSID_ds(Date_accessed <= inp.Date_e),InitSID_ds);
								
								// if (inp.Date_s>0 and inp.Date_e>0
								
								// sid_ftr := DEDUP(PROJECT(WebClick_Tracker.DSIndex.Key_SessionID_dis(session_id in inp.SessionID),ftr_rec), session_id, all);
								// uid_ftr := PROJECT(WebClick_Tracker.DSIndex.Key_UserID_dis(ID_Type ='L' and UserID in inp.User_ID),ftr_rec); 
								// cid_ftr := PROJECT(WebClick_Tracker.DSIndex.Key_UserID_dis(ID_Type ='C' and UserID in inp.Company_ID),ftr_rec);
								// aid_ftr := PROJECT(WebClick_Tracker.DSIndex.Key_AppID_dis(Vert in inp.App_ID),ftr_rec);

								sid_ftr_src := DEDUP(PROJECT(WebClick_Tracker.DSIndex.Key_SessionID_dis(session_id in inp.SessionID and source=inp.Datasource),ftr_rec), session_id, all);
								uid_ftr_src := PROJECT(WebClick_Tracker.DSIndex.Key_UserID_dis(ID_Type ='L' and UserID in inp.User_ID and source=inp.Datasource),ftr_rec); 
								cid_ftr_src := PROJECT(WebClick_Tracker.DSIndex.Key_UserID_dis(ID_Type ='C' and UserID in inp.Company_ID and source=inp.Datasource),ftr_rec);
								aid_ftr_src := PROJECT(WebClick_Tracker.DSIndex.Key_AppID_dis(Vert in inp.App_ID and source=inp.Datasource),ftr_rec);

								sid_ftr_all := DEDUP(PROJECT(WebClick_Tracker.DSIndex.Key_SessionID_dis(session_id in inp.SessionID and source=inp.Datasource),ftr_rec), session_id, all);
								uid_ftr_all := PROJECT(WebClick_Tracker.DSIndex.Key_UserID_dis(ID_Type ='L' and UserID in inp.User_ID),ftr_rec); 
								cid_ftr_all := PROJECT(WebClick_Tracker.DSIndex.Key_UserID_dis(ID_Type ='C' and UserID in inp.Company_ID),ftr_rec);
								aid_ftr_all := PROJECT(WebClick_Tracker.DSIndex.Key_AppID_dis(Vert in inp.App_ID),ftr_rec);
								
								sid_ftr:=if(inp.Datasource<>'',sid_ftr_src,sid_ftr_all);
								uid_ftr:=if(inp.Datasource<>'',uid_ftr_src,uid_ftr_all);
								cid_ftr:=if(inp.Datasource<>'',cid_ftr_src,cid_ftr_all);
								aid_ftr:=if(inp.Datasource<>'',aid_ftr_src,aid_ftr_all);
								
								ID_Exists := Exists(inp.SessionID) OR Exists(inp.User_ID) OR Exists(inp.Company_ID) OR Exists(inp.App_ID);
								
								ftr_sids := MAP(Exists(inp.SessionID)=>sid_ftr
											,Exists(inp.User_ID)=>uid_ftr
											,Exists(inp.Company_ID)=>cid_ftr  						  
											,Exists(inp.App_ID)=>aid_ftr
										     ,dataset([],ftr_rec));
								
                							
								InitSID_1 := JOIN(ftr_sids,WebClick_Tracker.DSIndex.Key_EventID_dis
								                ,RIGHT.event = str
															   and 
																 LEFT.session_id = RIGHT.session_id
																 and
																 if(inp.Datasource<>'',right.source=inp.Datasource,right.source<>'')
																,TRANSFORM(WebClick_Tracker.Layouts.SD_rec, SELF.AppID := RIGHT.vert,SELF := RIGHT)
																,LIMIT(1000,SKIP)
															 );
															 
								InitSID_2 := PROJECT(WebClick_Tracker.DSIndex.Key_EventID_dis(event=str and if(inp.Datasource<>'',source=inp.Datasource,source<>''))
															 ,TRANSFORM(WebClick_Tracker.Layouts.SD_rec, SELF.AppID := LEFt.vert,SELF := LEFT));
								InitSID := IF(ID_Exists,InitSID_1,InitSID_2);		
								// output(sid_ftr);
								// output(uid_ftr);
								// output(cid_ftr);
								// output(aid_ftr);
								RETURN InitSID;
  					 END;												
					 
						 //filtering inital set by company id, login id , session, vertical data
						 PROJ_NDX(string45 str) := FUNCTION
								indx_r := NDX_READ(str);
								InitSID_ds := If(inp.Date_s>0,indx_r(Date_accessed >= inp.Date_s),indx_r);
								InitSID_de := If(inp.Date_e>0,InitSID_ds(Date_accessed <= inp.Date_e),InitSID_ds);
								// output(indx_r);
								// output(InitSID_ds);
								// output(InitSID_de);
								// output(inp.Date_s);
								// output(inp.Date_e);
								
								RETURN InitSID_de;
						 END;

						 // SELECT the right operation for graph
						 out := 
										 MAP(
												 in_ds.op_code='2'=> JOIN(range(sid,in_ds.range_list),STEPPED(
																							LEFT.session_id=RIGHT.session_id
																							and
																							LEFt.order+1 = RIGHT.order 
																							),xfm_join(LEFt,ROWS(LEFT)),SORTED(Session_id,order))
												 ,
													in_ds.op_code='1'=> PROJ_NDX(in_ds.evt)
												);
												
						RETURN out;					
			END;
				
				FinalSIDs := GRAPH(emp_ds,count(Norm),decode_opcode(Norm[counter],rowset(left),counter),parallel);
    		RETURN FinalSIDs;

		END;
	END;


	EXPORT search := MODULE
	
  	//get SD by event 
    EXPORT get_SD_by_event(Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
  			FinalSIDs := report.get_report_by_event(inp);
				forward := False : STORED('Forward');
				Backward := False : STORED('Backward');
				step := If(Backward,(-count(inp.evtlist)),1);
				FinalDSet:=join(FinalSIDs, DSIndex.Key_SEssionID_dis
				                ,LEFT.session_id=RIGHT.session_id
												and
												left.order+step = RIGHT.order
												and
												if(inp.Datasource<>'',right.source=inp.Datasource,right.source<>'')
												,Transforms.xfm_SID(LEFT,RIGHT)
												,LIMIT(1000,SKIP)
												);
  				// FinalDSet:=if(inp.Datasource<>'',
								// FinalDSet_tmp(Source=inp.Datasource),
								// FinalDSet_tmp); 
			MAC_Freq_Distribution(FinalDSet,event,out)
				out_s := ALLNODES(LOCAL(out));	
        out_f := global_freqCount(PROJECT(out_s,Layouts.rec_freq));
				RETURN SORT(out_f,-frequency_count);
		END;

		//get sessionIDS by event
		EXPORT get_SID_by_event(Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
		 SUID_1 := report.get_report_by_event(inp);
		 SUID := GROUP(SORT(CHOOSEN(ALLNODES(LOCAL(CHOOSEN(DEDUP(SORT(PROJECT(SUID_1,Layouts.rec_SUID1)
																			 ,CompanyID,LoginID,session_id)
															,CompanyID,LoginID,session_id),constants.SID_limit_byEP)))
															,constants.SID_limit_byEP),companyID,LoginID,Session_id),companyID,LoginID);
			Layouts.rec_SID xfm_SID(recordof(SUID) l) := TRANSFORM
				SELF := l;
			END;
			Layouts.rec_SUID xfm_SUID(recordof(SUID) l,DATASET(recordof(SUID)) r) := TRANSFORM
				SELF.LoginID := l.LoginID;
				SELF.CompanyID := L.CompanyID;
				SELF.sessionIDs := PROJECT(r,xfm_SID(LEFT));
			END;
			RETURN ROLLUP(SUID,group,xfm_SUID(LEFT,rows(LEFT)));
		END;
		
		
	//get SesionID by LoginID
		EXPORT get_SID_by_UID(string1 user_type ='L',Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
			ds_user_1_tmp :=  if(user_type='L' ,DSIndex.Key_UserID_dis(ID_Type=user_type and UserID in inp.User_ID)
			                               ,DSIndex.Key_UserID_dis(ID_Type=user_type and UserID in inp.Company_ID));
			ds_user_1:=if(inp.Datasource<>'',ds_user_1_tmp(source=inp.Datasource),ds_user_1_tmp);
			ds_user := if(user_type='C' 
			                ,if(Count(inp.Company_ID)>0,ds_user_1(ID_Type='C' and UserId in inp.company_id),ds_user_1)
											,if(Count(inp.User_ID)>0,ds_user_1(ID_Type='L' and UserId in inp.user_id),ds_user_1)
											);

			ds_sessions   := JOIN(ds_user,DSIndex.Key_SessionId_dis
			                  ,LEFT.session_id=RIGHT.session_id and 
						   if(inp.Datasource<>'',right.source=inp.Datasource,right.source<>'')
												,TRANSFORM(Layouts.SD_rec,SELF.appId := RIGHT.vert,SELF := RIGHT, SELF := [])
												);  
			ds_sessions_sdft := IF(inp.date_s >0,ds_sessions(date_accessed >=inp.date_s),ds_sessions);
			ds_sessions_edft := IF(inp.date_e >0,ds_sessions_sdft(date_accessed <=inp.date_e),ds_sessions_sdft);
				             												
			SUID := GROUP(DEDUP(SORT(CHOOSEN(ALLNODES(LOCAL(CHOOSEN(DEDUP(SORT(ds_sessions,CompanyID,LoginID,Session_ID)
													,CompanyID,LoginID,Session_ID),constants.SID_limit_byUID))),constants.SID_limit_byUID)
			                         ,CompanyID,LoginID,Session_ID)
													,CompanyID,LoginID,Session_ID)
										,CompanyID,LoginID);
       
			Layouts.rec_SID xfm_SID(recordof(SUID) l) := TRANSFORM
				SELF := l;
			END;
			Layouts.rec_SUID xfm_SUID(recordof(SUID) l,DATASET(recordof(SUID)) r) := TRANSFORM
																	SELF.sessionIDs := PROJECT(r,xfm_SID(LEFT));
																	SELF := L;
			END;
			RETURN ROLLUP(SUID,group,xfm_SUID(LEFT,rows(LEFT)));
		END;
		
	
		/*
		EXPORt get_log_by_SID(set of string32 sessionID = []) := FUNCTION
		 sess_log := GROUP(SORT(DSIndex.Key_SessionID(session_Id in	sessionID)
		                        ,CompanyID,LoginID,Session_ID,local)
											 ,CompanyID,LoginID,Session_ID,local);
     RETURN sess_log;											 
		 //RETURN ROLLUP(sess_log,group,Transforms.xfm_session(LEFT,rows(LEFT)));
		 
	  END;
		*/
		
	END;

	EXPORT Compare_IDS := MODULE
		EXPORT compare_EP_CUIDS(String1 user_type ='',Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
		

		
		  // inp1 := inp_values(inp.evtlist,inp.APP_ID,[inp.Company_ID[1]],,,inp.date_s,inp.date_e);
		  rp1 := SORT(if(user_type = 'C', search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,[inp.Company_ID[1]],,,inp.date_s,inp.date_e))
			                         ,  if(user_type = 'L',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,,[inp.User_ID[1]],,inp.date_s,inp.date_e))
															 ,  if(user_type = 'S',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,,,[inp.SessionID[1]],inp.date_s,inp.date_e))
															 ,  if(user_type = 'A',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,[inp.App_ID[1]],,,,inp.date_s,inp.date_e))))
															 )
															 ),event);

		  rp2 := SORT(if(user_type = 'C', search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,[inp.Company_ID[2]],,,inp.date_s,inp.date_e))
			                         ,  if(user_type = 'L',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,,[inp.User_ID[2]],,inp.date_s,inp.date_e))
															 ,  if(user_type = 'S',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,,,[inp.SessionID[2]],inp.date_s,inp.date_e))
															 ,  if(user_type = 'A',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,[inp.APP_ID[2]],,,,inp.date_s,inp.date_e))))
															 )
															 ),event);
      
	
			res := JOIN(rp1,rp2
			            ,LEFT.event = RIGHT.event
									,Transforms.xfm_rp(LEFT,RIGHT)
									,FULL OUTER
								);

		  RETURN SORT(res,-frequency_count_1,-frequency_count_2);	
				
		END;
		
		EXPORT compare_CUIDS(string1 user_type ='',Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
		  rp1 := SORT(if(user_type = 'C', report.get_report_by_UID('C',Layouts.inp_values(,inp.APP_ID,[inp.Company_ID[1]],,,inp.date_s,inp.date_e))
			                         ,  if(user_type = 'L',report.get_report_by_UID('L',Layouts.inp_values(,inp.APP_ID,,[inp.User_ID[1]],,inp.date_s,inp.date_e))
															 ,  if(user_type = 'S',report.get_report_by_SID(Layouts.inp_values(,inp.APP_ID,,,[inp.SessionID[1]],inp.date_s,inp.date_e))
                               // ,  if(user_type = 'A',report.get_report_by_AID(Layouts.inp_values(,[inp.APP_ID[1]],,,,inp.date_s,inp.date_e)))
															 ))),event);

		  rp2 := SORT(if(user_type = 'C', report.get_report_by_UID('C',Layouts.inp_values(,inp.APP_ID,[inp.Company_ID[2]],,,inp.date_s,inp.date_e))
			                         ,  if(user_type = 'L',report.get_report_by_UID('L',Layouts.inp_values(,inp.APP_ID,,[inp.User_ID[2]],,inp.date_s,inp.date_e))
															 ,  if(user_type = 'S',report.get_report_by_SID(Layouts.inp_values(,inp.APP_ID,,,[inp.SessionID[2]],inp.date_s,inp.date_e))
                               // ,  if(user_type = 'A',report.get_report_by_AID(Layouts.inp_values(,[inp.APP_ID[2]],,,,inp.date_s,inp.date_e)))
															 ))),event);
															 
		
			res := JOIN(rp1,rp2
			            ,LEFT.event = RIGHT.event
									,Transforms.xfm_rp(LEFT,RIGHT)
									,full outer
									);
	
			
		  RETURN SORT(res,-frequency_count_1,-frequency_count_2);		
				
		END;
	//***************************	
		EXPORT compare_CUID_Dates(string1 user_type ='',Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
		  rp_d1 := SORT(if(user_type = 'C', report.get_report_by_UID('C',Layouts.inp_values(,inp.APP_ID,[inp.Company_ID[1]],,,inp.date_s,inp.date_e))
			                         ,  if(user_type = 'L',report.get_report_by_UID('L',Layouts.inp_values(,inp.APP_ID,,[inp.User_ID[1]],,inp.date_s,inp.date_e))
															 ,  if(user_type = 'S',report.get_report_by_SID(Layouts.inp_values(,inp.APP_ID,,,[inp.SessionID[1]],inp.date_s,inp.date_e))
                               // ,  if(user_type = 'A',report.get_report_by_AID(Layouts.inp_values(,[inp.APP_ID[1]],,,,inp.date_s,inp.date_e)))
															 ))),event);

		  rp_d2 := SORT(if(user_type = 'C', report.get_report_by_UID('C',Layouts.inp_values(,inp.APP_ID,[inp.Company_ID[1]],,,inp.date_s2,inp.date_e2))
			                         ,  if(user_type = 'L',report.get_report_by_UID('L',Layouts.inp_values(,inp.APP_ID,,[inp.User_ID[1]],,inp.date_s2,inp.date_e2))
															 ,  if(user_type = 'S',report.get_report_by_SID(Layouts.inp_values(,inp.APP_ID,,,[inp.SessionID[1]],inp.date_s2,inp.date_e2))
                               // ,  if(user_type = 'A',report.get_report_by_AID(Layouts.inp_values(,[inp.APP_ID[2]],,,,inp.date_s,inp.date_e)))
															 ))),event);
															 
		
			res_d := JOIN(rp_d1,rp_d2
			            ,LEFT.event = RIGHT.event
									,Transforms.xfm_rp(LEFT,RIGHT)
									,full outer
									);
	
			
		  RETURN SORT(res_d,-frequency_count_1,-frequency_count_2);		
				
		END;		
	//************************************
			EXPORT compare_EP_CUID_Dates(String1 user_type ='',Webclick_Tracker.Layouts.inp_param inp) := FUNCTION
		

		
		  // inp1 := inp_values(inp.evtlist,inp.APP_ID,[inp.Company_ID[1]],,,inp.date_s,inp.date_e);
		  rp_d1 := SORT(if(user_type = 'C', search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,[inp.Company_ID[1]],,,inp.date_s,inp.date_e))
			                         ,  if(user_type = 'L',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,,[inp.User_ID[1]],,inp.date_s,inp.date_e))
								,  if(user_type = 'S',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,,,[inp.SessionID[1]],inp.date_s,inp.date_e))
								,  if(user_type = 'A',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,[inp.App_ID[1]],,,,inp.date_s,inp.date_e))
								,  if(user_type = 'E',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,,,,,inp.date_s,inp.date_e)))))
															 )
															 ),event);

		  rp_d2 := SORT(if(user_type = 'C', search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,[inp.Company_ID[1]],,,inp.date_s2,inp.date_e2))
			                         ,  if(user_type = 'L',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,,[inp.User_ID[1]],,inp.date_s2,inp.date_e2))
								,  if(user_type = 'S',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,inp.APP_ID,,,[inp.SessionID[1]],inp.date_s2,inp.date_e2))
								,  if(user_type = 'A',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,[inp.APP_ID[1]],,,,inp.date_s2,inp.date_e2))
								,  if(user_type = 'E',search.get_SD_by_event(Layouts.inp_values(inp.evtlist,,,,,inp.date_s2,inp.date_e2)))))
															 )
															 ),event);
      
	
			res_d := JOIN(rp_d1,rp_d2
			            ,LEFT.event = RIGHT.event
									,Transforms.xfm_rp(LEFT,RIGHT)
									,FULL OUTER
								);

		  RETURN SORT(res_d,-frequency_count_1,-frequency_count_2);	
				
		END;
	
	//*************************************
	END;

	

ENd;
