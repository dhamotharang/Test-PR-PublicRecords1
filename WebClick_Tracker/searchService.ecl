/*--SOAP--
<message name="SearchService">
	<part name="Events" type="tns:EspStringArray"/>
	<part name="CompanyID" type="tns:EspStringArray"/>
	<part name="AppID" type="tns:EspStringArray"/>
	<part name="UserID" type="tns:EspStringArray"/>
	<part name="sessionID" type="tns:EspStringArray"/>
	<part name="StartDate" type="xsd:unsignedInt"/>
	<part name="EndDate" type="xsd:unsignedInt"/>
	<part name="DataSource" type="xsd:string"/>
	<part name="StartDate2" type="xsd:unsignedInt"/>
	<part name="EndDate2" type="xsd:unsignedInt"/>

<!--	<part name="StartTime" type="xsd:unsignedInt"/>
	<part name="EndTime" type="xsd:unsignedInt"/>	-->
	<part name="CompareByDates" type="xsd:boolean"/>
	<part name="Compare" type="xsd:boolean"/>
	<part name="Forward" type="xsd:boolean"/>
	<part name="Backward" type="xsd:boolean"/>
	<part name="Frequencythreshold" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This calculates the distribution of events after the input series
*/

export SearchService:=macro

  //  input data
	inital_values := MODULE(Webclick_Tracker.Layouts.inp_param)
		export set of string45 evtlist     := []    :STORED('Events');
		export set of string20 Company_Id  :=[]     :stored('CompanyID');
		export set of string3 App_Id       :=[]     :stored('AppID');
		export set of string20 user_Id     :=[]     :stored('UserID');
		export set of string32 sessionID   :=[]     :STORED('sessionID');
		export Integer Time_s              :=0      :stored('StartTime');
		export Integer Time_e              :=0      :stored('EndTime');	
		export string DataSource           :=''     :stored('DataSource');	
	END;

	Boolean compare := FALSE : STORED('Compare');
	Boolean compare_by_dates := FALSE : STORED('CompareByDates');
	Boolean Sess_List_EP := FALSE : STORED('DisplaySessionsContainEP');
	Boolean Sess_List_Comp := FALSE : STORED('DisplayCompleteSessionList');
	Boolean SD_by_Event := FALSE : STORED('DoNotDisplaySDByEvent');
	Boolean rpt_by_ID := FALSE : STORED('DisplayIDReport');
	Integer freq_Threshold := 0 : STORED('Frequencythreshold');
	// string DataSource           :=''     :stored('DataSource');	

   //outputs input event pattern 
	 out_evt := IF(EXISTS(inital_values.evtlist),
					  inital_values.evtlist,
					  if(inital_values.DataSource='D',['FIND A PERSON'],['LOGIN/LOGIN']));
	 OUTPUT(out_evt,NAMED('EventPattern'));

	 WebClick_Tracker.functions.TEST_203(inital_values)
	
	 //Displays the SD of events following Event Pattern
		a := if(not compare and NOT SD_by_Event and NOT compare_by_dates, 
					webclick_tracker.raw.search.get_SD_by_event(inital_values));
          
		a_limit:=if(freq_Threshold=0,a,a(frequency_percent>=freq_Threshold));
          
    rec_format_a:=record
		String45 Event;
		String60 Event_Description:='';
		recordof(a_limit) and not Event;
		
		end;
		rec_format_a xform_a (a_limit l, WebClick_Tracker.key_Event_Description r):=transform
		
		self.Event_Description:=if(r.Description<>'',StringLib.StringToUpperCase(r.Description),l.event),
		self:=l,
		end;
		
		a_limit_fmt:=join(a_limit,WebClick_Tracker.key_Event_Description,keyed(left.event=right.event),xform_a(left,right),left outer);
		
		// output(a, NAMED('DistributionOfNextEvent'));
		// output(a_limit, NAMED('DistributionOfNextEvent_limited'));
		output(a_limit_fmt, NAMED('DistributionOfNextEvent')); //_limited_desc
     
		
		ip := [inital_values.Company_ID[1],inital_values.Company_ID[2]]
		     +[inital_values.User_ID[1],inital_values.User_ID[2]]
				 +[inital_values.SessionID[1],inital_values.SessionID[2]];
				 
		STR := MAP(COUNT(inital_values.SessionID)=2 => 'S',
				   COUNT(inital_values.User_ID)=2 => 'L',
				   COUNT(inital_values.Company_ID)=2 => 'C',
				   COUNT(inital_values.App_ID)=2 => 'A','');
		
		if(Compare AND STR='', FAIL(0,'Must enter exactly 2 of some ID for Compare'));
		
		//Compares SID/UID/CID which contains the event pattern
		b := IF(Compare AND STR<>'', webclick_tracker.raw.Compare_IDS.compare_EP_CUIDS(STR,inital_values));

		b_limit:=if(freq_Threshold=0,b,b(frequency_percent_1>=freq_Threshold or frequency_percent_2>=freq_Threshold));
		
		rec_format_b:=record
		String45 Event;
		String60 Event_Description:='';
		recordof(b_limit) and not Event;
		end;
		
		rec_format_b xform_b (b_limit l, WebClick_Tracker.key_Event_Description r):=transform
		self.Event_Description:=if(r.Description<>'',StringLib.StringToUpperCase(r.Description),l.event),
		self:=l,
		end;
		
		b_limit_fmt:=join(b_limit,WebClick_Tracker.key_Event_Description,keyed(left.event=right.event),xform_b(left,right),left outer);
		
		// output(b,NAMED('ComparisonOfEventPatterns'))
		output(b_limit_fmt,NAMED('ComparisonOfEventPatterns'));
//***********************Compare by ID and Dates***************************************

		ip_2 := [inital_values.Company_ID[1],inital_values.Company_ID[2]]
		     +[inital_values.User_ID[1],inital_values.User_ID[2]]
				 +[inital_values.SessionID[1],inital_values.SessionID[2]];
				 
		STR_2 := MAP(COUNT(inital_values.SessionID)>=1 => 'S',
				   COUNT(inital_values.User_ID)>=1 => 'L',
				   COUNT(inital_values.Company_ID)>=1 => 'C',
				   COUNT(inital_values.App_ID)>=1 => 'A',
				   COUNT(inital_values.evtlist)>=1 => 'E','');
		
		Dte :=map(exists(inital_values.Date_s) AND 
				exists(inital_values.Date_e) AND
				exists(inital_values.Date_s2) AND
				exists(inital_values.Date_e2) => 'T','');
		if(compare_by_dates AND (STR_2='' OR Dte=''), FAIL(0,'Must enter Some ID or Event and dates for Compare'));
		
		//Compares SID/UID/CID which contains the event pattern
		b_2 := IF(compare_by_dates AND STR_2<>'' AND Dte<>'', webclick_tracker.raw.Compare_IDS.compare_EP_CUID_Dates(STR_2,inital_values));

		b_limit_2:=if(freq_Threshold=0,b_2,b_2(frequency_percent_1>=freq_Threshold or frequency_percent_2>=freq_Threshold));
		
		rec_format_b_2:=record
		String45 Event;
		String60 Event_Description:='';
		recordof(b_limit) and not Event;
		end;
		
		rec_format_b_2 xform_b_2 (b_limit_2 l, WebClick_Tracker.key_Event_Description r):=transform
		self.Event_Description:=if(r.Description<>'',StringLib.StringToUpperCase(r.Description),l.event),
		self:=l,
		end;
		
		b_limit_fmt_2:=join(b_limit_2,WebClick_Tracker.key_Event_Description,keyed(left.event=right.event),xform_b_2(left,right),left outer);
		
		// output(b,NAMED('ComparisonOfEventPatterns'))
		output(b_limit_fmt_2,NAMED('ComparisonOfEventPatterns_By_Dates'));
//*************************************************************************************
endmacro;
// SearchService();