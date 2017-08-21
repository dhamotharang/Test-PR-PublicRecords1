import Crim_Common, Address, VersionControl;
 
dF20060 := file_OK_Carter.F20060(~regexfind('Name|[0-9]',name)  and length(name)>4);
dF20070 := file_OK_Carter.F20070(~regexfind('Name|[0-9]',Name)  and length(Name)>4 );
dF2008  := file_OK_Carter.F2008(~regexfind('Name|[0-9]',Name)  and length(Name)>4 );

fDate(STRING inDate1) 
	:= FUNCTION
			searchpattern    := '^(.*)/(.*)/(.*)$';
			indate:=TRIM(indate1,all);
	        STRING8 newDate  := REGEXFIND(searchpattern, inDate, 3)[1..4]+
			                    IF(length(REGEXFIND(searchpattern, inDate, 1))=1,'0','')+
								REGEXFIND(searchpattern, inDate, 1)+
								 IF(length(REGEXFIND(searchpattern, inDate, 2))=1,'0','')+
								REGEXFIND(searchpattern, inDate, 2);
			RETURN   IF(LENGTH(TRIM(newDate,ALL))<8 or stringlib.GetDateYYYYMMDD()[1..6]<newdate[1..6]or newdate[1]='0','',newDate);			
 
		END;
Patten:='([[:space:]])([[:alpha:]]+)([[:digit:]]+)|-([[:alpha:]]+)-([[:digit:]]+)-([[:digit:]]+)|([[:alpha:]]+)-([[:digit:]]+)-([[:digit:]]+)|([[:digit:]]+).([[:digit:]]+)|([[:digit:]]+)-([[:digit:]]+)';	//arr_desc:=IF(pInput.Offense1[4]<>'.',pInput.Offense1[1..position1],pInput.Offense1[position..position1-2]);
		
Crim_Common.Layout_In_Court_offenses t20060(dF20060 pinput) 
	
	:= TRANSFORM
	
		agency  :=CASE(pinput.Arresting_Agency, 'APD'=>'ARDMORE POLICE DEPARMENT',
												'CCSO'=>'CARTER COUNTY SHERIFF OFFICE',
												'DPD'=>'DICKSON POLICE DEPARTMENT',
												'HPD'=>'HEALDTON POLICE DEPARTMENT',
												'LAKE'=>'LAKE MURRAY STATE PARK',
												'LGPD'=>'LONE GROVE POLICE DEPARTMENT',
												'OHP'=>'OKLAHOMA HIGHWAY PATROL',
												'CCSO-TSI'=>'CARTER COUNTY SHERIFF OFFICE','');
		statute                 :=REGEXREPLACE('^-',REGEXFIND(Patten,pInput.Offense,0),'');
        s:='COUNT (,)([[:digit:]]+)|COUNT ([[:alpha:]]+)| DEGREE|([[:digit:]]+)([[:alpha:]]+)|([[:digit:]]+)([[:alpha:]]+) DEGREE';
        arr_:=REGEXREPLaCE(s,pInput.offense,'');

		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G8'+pInput.booking; 
		SELF.vendor				:= 'G8';
		SELF.state_origin		:= 'OK';
		SELF.source_file		:= '(CV)OK-CarterCtyArr';
	    SELF.le_agency_desc     := MAP(length(agency)<11=>agency,
		                               length(pinput.Arresting_Agency)>=11=>REGEXREPLACE('[\r]|[\n]',REGEXREPLACE('DEPT.|DEPT',pInput.Arresting_Agency,'DEPARTMENT'),''),'');
		SELF.num_of_counts      := STRINGLIB.STRINGFILTER(REGEXFIND('COUNT (,)([[:digit:]]+)|COUNT ([[:alpha:]]+)|COUNT ([[:digit:]]+)',pInput.offense,0),'0123456789');
	    SELF.arr_date 			:= fDate(pinput.arrest_date);
        SELF.arr_statute        := IF(length(statute)<7 or ~REGEXFIND('[.]',statute),'',statute);
		SELF.arr_off_desc_1     := IF(LENGTH(TRIM(arr_,ALL))>4 OR arr_='DUI' ,
										trim(regexreplace('[ ]+|MISDEMEANOR|FELONY|MSID|MIS|FEL|(CASH ONLY)|[/]+',REGEXREPLACE(patten,arr_,''),' '),left),''); 
		SELF.arr_off_lev        := MAP(REGEXFIND('FELONY|FEL',pInput.offense1)=>'F',REGEXFIND('MISD|MIS|MISDEMEANOR',pInput.offense1)=>'M','');
		SELF.arr_disp_desc_2 	:= IF(pinput.total_bail>'1','BAIL: $'+pinput.total_bail+' ','')+
		                           IF(pinput.total_fines>'1','FINE: $'+pinput.total_fines,'')+ 
								   IF(pinput.total_bond>'1','BOND: $'+pinput.total_BOND,'');
		SELF.sent_jail          := IF(REGEXFIND('[1-9]',pInput.sentence),TRim(REGEXREPLACE('DAYS|Days',REGEXREPLACE('YRS',REGEXREPLACE('^0 YRS',pInput.sentence,''),'Year(s)'),'Day(s)'),left),'');
		
		SELF.arr_disp_desc_1    := IF(REGEXFIND('[1-9]|Bail|p|P|L',pInput.Disposition),'BOOKED',pInput.Disposition);
		SELF                    := [];
	 END;
Crim_Common.Layout_In_Court_offenses t20070(dF20070 pinput) 
	
	:= TRANSFORM
	
		agency  :=CASE(pinput.Arresting_Agency, 'APD'=>'ARDMORE POLICE DEPARMENT',
												'CCSO'=>'CARTER COUNTY SHERIFF OFFICE',
												'DPD'=>'DICKSON POLICE DEPARTMENT',
												'HPD'=>'HEALDTON POLICE DEPARTMENT',
												'LAKE'=>'LAKE MURRAY STATE PARK',
												'LGPD'=>'LONE GROVE POLICE DEPARTMENT',
												'OHP'=>'OKLAHOMA HIGHWAY PATROL',
												'CCSO-TSI'=>'CARTER COUNTY SHERIFF OFFICE','');
		statute                 :=REGEXFIND(Patten,pInput.Offense,0);
        s:='COUNT (,)([[:digit:]]+)|COUNT ([[:alpha:]]+)| DEGREE|([[:digit:]]+)([[:alpha:]]+)|([[:digit:]]+)([[:alpha:]]+) DEGREE';
        arr_:=REGEXREPLaCE(s,pInput.offense,'');
        Jail:=IF(REGEXFIND('[1-9]',pInput.sentence_for),TRim(REGEXREPLACE('YRS',pInput.sentence_for,'Year(s)'),left),'');
        Jail_days:=(integer)REGEXfind('([[:digit:]]+) D',jail,1);
	
		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G8'+pInput.booking; 
		SELF.vendor				:= 'G8';
		SELF.state_origin		:= 'OK';
		SELF.source_file		:= '(CV)OK-CarterCtyArr';
		SELF.num_of_counts      := STRINGLIB.STRINGFILTER(REGEXFIND('COUNT (,)([[:digit:]]+)|COUNT ([[:alpha:]]+)|COUNT ([[:digit:]]+)',pInput.offense,0),'1234567890');
	  	SELF.le_agency_desc     := MAP(length(agency)<11=>agency,
		                               length(pinput.Arresting_Agency)>=11=>REGEXREPLACE('[\r]|[\n]',REGEXREPLACE('DEPT.|DEPT',pInput.Arresting_Agency,'DEPARTMENT'),''),'');
		SELF.arr_date 			:= fDate(pinput.arrest_date);
        SELF.arr_statute        := IF(length(statute)<7 or ~REGEXFIND('[.]',statute),'',REGEXREPLACE('^-',statute,''));
		SELF.arr_off_desc_1     := IF(LENGTH(TRIM(arr_,ALL))>4 OR arr_='DUI' ,
										trim(regexreplace('[ ]+|MISDEMEANOR|FELONY|MSID|MIS|FEL|(CASH ONLY)|[/]+',REGEXREPLACE(patten,arr_,''),' '),left),''); 
		SELF.arr_off_lev        := MAP(REGEXFIND('FELONY|FEL',pInput.offense)=>'F',REGEXFIND('MISD|MIS|MISDEMEANOR',pInput.offense)=>'M','');
		SELF.arr_disp_desc_2 	:= IF(pinput.total_bail>'1','BAIL: $'+pinput.total_bail+' ','')+
		                           IF(pinput.total_fines>'1','FINE: $'+pinput.total_fines,'');
		SELF.sent_jail          := IF(jail_days>365,(STRING) (integer)(jail_days/365)+' Year(s) ' +
		                              IF(jail_days-(jail_days/365)*365<1,'',(STRING)(jail_days-(integer)(jail_days/365)*365)+' Day(s)'),REGEXREPLACE('DAYS|Days',Jail,'Day(s)'));  
		SELF.arr_disp_desc_1    := 'BOOKED';
		SELF                    := [];
	 END; 
Crim_Common.Layout_In_Court_offenses t2008(dF2008 pinput) 
	
	:= TRANSFORM
	
		agency  :=CASE(pinput.Arresting_Agency, 'APD'=>'ARDMORE POLICE DEPARMENT',
												'CCSO'=>'CARTER COUNTY SHERIFF OFFICE',
												'DPD'=>'DICKSON POLICE DEPARTMENT',
												'HPD'=>'HEALDTON POLICE DEPARTMENT',
												'LAKE'=>'LAKE MURRAY STATE PARK',
												'LGPD'=>'LONE GROVE POLICE DEPARTMENT',
												'OHP'=>'OKLAHOMA HIGHWAY PATROL',
												'CCSO-TSI'=>'CARTER COUNTY SHERIFF OFFICE','');
		statute                 :=REGEXREPLACE('[/]|[,]',REGEXFIND(Patten,pInput.charge,0),'');
		s:='COUNT (,)([[:digit:]]+)|COUNT ([[:alpha:]]+)| DEGREE|([[:digit:]]+)([[:alpha:]]+)|([[:digit:]]+)([[:alpha:]]+) DEGREE';
        arr_:=REGEXREPLaCE(s,pInput.charge,'');
		Jail:=IF(REGEXFIND('[1-9]',pInput.sentence),TRim(REGEXREPLACE('^0 Year[(]s[)]| 0 Day[(]s[)]| 0 Hours',pInput.sentence,''),left),''); 
        Jail_days:=(integer)REGEXfind('([[:digit:]]+) D',jail,1);
		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G8'+pInput.booking_number; 
		SELF.vendor				:= 'G8';
		SELF.state_origin		:= 'OK';
		SELF.source_file		:= '(CV)OK-CarterCtyArr';
		SELF.num_of_counts      := stringlib.stringfilter(REGEXFIND('COUNT (,)([[:digit:]]+)|COUNT ([[:alpha:]]+)|COUNT ([[:digit:]]+)',pInput.charge,0),'1234567890');
	    SELF.le_agency_desc     := MAP(length(agency)<11=>agency,
		                               length(pinput.Arresting_Agency)>=11=>REGEXREPLACE('[\r]|[\n]',REGEXREPLACE('DEPT.|DEPT',pInput.Arresting_Agency,'DEPARTMENT'),''),'');
		SELF.arr_date 			:= fDate(pinput.arrest_date);
        SELF.arr_statute        := IF(length(statute)<7 or ~REGEXFIND('[.]',statute),'',REGEXREPLACE('^-',statute,''));
		SELF.arr_off_desc_1     := IF(LENGTH(TRIM(arr_,ALL))>4 OR arr_='DUI' ,
										trim(regexreplace('[ ]+|FELONY|MISDEMEANOR|MSID|MIS|FEL|(CASH ONLY)|[/]+',REGEXREPLACE(patten,arr_,''),' '),left),''); 
		SELF.arr_off_lev        := MAP(REGEXFIND('FELONY|FEL',pInput.charge)=>'F',REGEXFIND('MISDEMEANOR|MISD|MIS',pInput.charge)=>'M','');
		SELF.arr_disp_desc_2 	:= IF(pinput.total_bail>'1','BAIL: $'+REGEXFIND('([[:digit:]]+).[0-9][0-9]',pinput.total_bail,0)+' ','')+
		                           IF(pinput.total_fines>'1','FINE: $'+REGEXFIND('([[:digit:]]+).[0-9][0-9]',pinput.total_fines,0),'');
		SELF.sent_jail          := IF(jail_days>365,(STRING) (integer)(jail_days/365)+' Year(s) ' +
		                              IF(jail_days-(jail_days/365)*365<1,'',(STRING)(jail_days-(integer)(jail_days/365)*365)+' Day(s)'),REGEXREPLACE('DAYS|Days',Jail,'Day(s)'));  
	    SELF.arr_disp_desc_1    := 'BOOKED';
		SELF                    := [];
	 END;

dP2008   :=PROJECT(dF2008, t2008(LEFT));
dP20070  :=PROJECT(dF20070, t20070(LEFT));
dP20060  :=PROJECT(dF20060, t20060(LEFT));
dProject :=dp2008+join(dp20070,dp2008,left.offender_key=right.offender_key,lookup,left only)+
					join(dp20060,dp2008,left.offender_key=right.offender_key,lookup,left only);

dRollup  := DEDUP(SORT(DISTRIBUTE(dProject,HASH(offender_key)),
								  offender_key ,-arr_off_desc_1 ,-IF(arr_off_lev='','',arr_off_lev),-le_agency_desc,-sent_jail,local),
								  offender_key,arr_off_desc_1,local);
dFinal   := dRollup (arr_off_desc_1<>'')+Join(dRollup (arr_off_desc_1=''),dRollup (arr_off_desc_1<>''),left.offender_key=right.offender_key,lookup,left only):
								   PERSIST('~thor_dell400::persist::Arrestlogs::OK::CarterOffenses');	 
				
export Map_OK_CarterOffenses :=dFinal  ;