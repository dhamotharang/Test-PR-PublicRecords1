export Layouts :=  MODULE


		export	rec_rp := RECORD
				string45 event;
				real4    frequency_percent_1;
				integer6  frequency_count_1;
				real4    frequency_percent_2;
				integer6  frequency_count_2;
		END;
			

		
  //SD from Mac_freq_distribution by Event
  export SD_rec:=record
			string32 session_id;
			String20 companyID;
			String3  AppID;
			STRING20 loginid;
			integer date_accessed;
			integer order;
			string45 event;		
			integer hrs;
			integer mins;
	end;
	
	//supporting layout for SD
	export rec_freq := RECORD
		string45 event;
		real4 frequency_percent;
		integer6 Frequency_count;
	end;
	
 
	//get SId by event
  EXPORT rec_SID := RECORD
		 string32 Session_id;
		 String3  AppID;		 
	END;

	//get SUId by event
	EXPORT rec_SUID1 := RECORD
	   string20 LoginID;
		 String20 companyID;
		 String32 session_id;
		 String3  AppID;
	END;
	
	//get SUId by event
	EXPORT rec_SUID := RECORD
	   string20 LoginID;
		 String20 companyID;
		 DATASET(rec_SID) sessionIDs;
	END;



	export inp_param := Interface
		export set of string45 evtlist := [];
		export set of string3 App_ID := [];
		export set of string20 Company_ID := [];
		export set of string20 User_ID := [];
		export set of string32 SessionID :=[];
		export integer6 date_s :=Constants.start_date;
		export integer6 date_e :=Constants.end_date;
		export integer6 date_s2 :=Constants.start_date2;
		export integer6 date_e2 :=Constants.end_date2;		
		export Integer Time_s   :=0 ;
		export Integer Time_e   :=0 ;
		export String DataSource   :='' ;
	END;
	
	export inp_values(Set of String45 evtlist1 =[]
	                , set of string3 AppId1=[]
									, set of string20 CompanyId1=[]
									, set of string20 UserId1=[]
									, set of string32 SessionId1=[]
									, Integer Date_s1=0
									, Integer Date_e1=0 
									, Integer Date_s2a=0
									, Integer Date_e2a=0 ) := MODULE(inp_param)
				export set of string45 evtlist    :=evtlist1;
				export set of string20 Company_Id  :=CompanyId1;
				export set of string3 App_Id       :=AppID1;
				export set of string20 user_Id     :=UserId1;
				export set of string32 sessionID  :=SessionId1;
				export Integer6 Date_s             :=Date_s1;
				export Integer6 Date_e             :=Date_e1;
				export Integer6 Date_s2            :=Date_s2a;
				export Integer6 Date_e2            :=Date_e2a;				
				// Integer Time_s             :=;
				// Integer Time_e             :=;
   	END;
END;