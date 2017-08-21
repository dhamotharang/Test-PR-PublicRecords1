import Crim_Common, Address, VersionControl;

dIn	:= Dedup(file_WA_Pierce(Name<>'Name' and length(trim(name,all))>4),all);

fDate(string dt):=function
     yearyy:= TRIM(dt,ALL)[7..8]; 
	 Year  := IF((INTEGER) yearyy<30, '20'+yearyy,'19'+yearyy);
	 date  := IF(yearyy='','',Year+TRIM(dt,ALL)[1..2] +TRIM(dt,ALL)[4..5]);
	 RETURN date;
	 END;

Crim_Common.Layout_In_Court_Offender tGwinnett(dIn pinput) 
	:= TRANSFORM
	
 	        Booking_Date:=pInput.Booking_Date[7..10]+pInput.Booking_Date[1..2]+pInput.Booking_Date[4..5]; 
			 name:=IF(REGEXFIND('[(]',pInput.name),
										  pInput.name[1..Stringlib.StringFind(Pinput.name,'(', 1)-1],
										  stringlib.stringfilterout(pInput.name,'>'));
	        
			SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
			SELF.offender_key		:= (sTRING)'G2'+hash(pInput.Jurisdiction+(string) pinput.id+REGEXREPLACE('[ ]+|[>]',name,' '));
			SELF.vendor				:= 'G2';
			SELF.state_origin		:= 'WA';
			SELF.data_type			:= '5';
			SELF.source_file		:= '(CV)WA-PierceCtyArr';
			SELF.case_court			:= pInput.Jurisdiction;
			SELF.case_filing_dt		:= pinput.Booking_Date[7..10]+pinput.Booking_Date[1..2]+pinput.Booking_Date[4..5];
			SELF.pty_nm				:= REGEXREPLACE('[ ]+|[>]',name,' ');
			self.party_status_desc  := MAP(pInput.Rls_Date_Time<>''=>'Future/Rlease Date:'+fDate(pInput.Rls_Date_Time),
			                               pInput.Future_Release_Date<>''=>'Future/Rlease Date:'+fDate(pInput.Future_Release_Date),'');
			SELF.pty_nm_fmt			:= 'L';
			SELF.pty_typ			:= '0'; 
			SELF.race               := IF(pInput.race[1]='A',pInput.race[2],pInput.race[1]);
			SELF.race_desc			:= MAP(Self.race='U'=>'HISPANIC',
			                               self.race='M'=>'AMER INDIAN',
										   self.race='S'=>'ASIAN',pInput.race);
			SELF.sex				:= IF(pInput.Gender[1] ~in['F','M'],'',pInput.Gender);
			SELF                    := [];

      END;

dProject  := PROJECT(dIn, tGwinnett(LEFT));

ArrestLogs.ArrestLogs_clean(dProject,cleanProject);

arrOut    := cleanProject;

dd_arrOut := DEDUP(SORT(DISTRIBUTE(arrOut,HASH(offender_key)),
								   offender_key,-case_filing_dt,-party_status_desc,local)
								  ,offender_key,local): 
								   PERSIST('~thor_dell400::persist::Arrestlogs::WA::PierceOffender');

export map_WA_PierceOffender := dd_arrOut;