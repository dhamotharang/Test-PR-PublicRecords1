import Crim_Common, Address, VersionControl;

dIn	:= file_WA_Kitsap(Name<>'Name'  and name<>'');
 
Crim_Common.Layout_In_Court_Offender tGwinnett(dIn pinput) 
	:= TRANSFORM
	
 	        Booking_Date:=pInput.Booking_Date[7..10]+pInput.Booking_Date[1..2]+pInput.Booking_Date[4..5]; 
	        
			SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
			SELF.offender_key		:= (sTRING)'G1'+pInput.id;
			SELF.vendor				:= 'G1';
			SELF.state_origin		:= 'WA';
			SELF.data_type			:= '5';
			SELF.source_file		:= '(CV)WA-KitsapCtyArr';
			SELF.case_number		:= '';
			SELF.case_court			:= pInput.Court;
			SELF.case_filing_dt		:= Booking_Date;
			SELF.pty_nm				:= IF(REGEXFIND('[(]',pInput.name),
										  pInput.name[1..Stringlib.StringFind(Pinput.name,'(', 1)-1],
										  pInput.name);
			SELF.pty_nm_fmt			:= 'F';
			SELF.pty_typ			:= '0'; 
			SELF.race               := IF(pInput.race[1]='U','',pInput.race[1]);
			SELF.race_desc			:= IF(pInput.race[1]='U','',pInput.race); 
			SELF.sex				:= IF(pInput.sex[1] ~in['F','M'],'',pInput.sex);
			SELF                    := [];

      END;

dProject  := PROJECT(dIn, tGwinnett(LEFT));

ArrestLogs.ArrestLogs_clean(dProject,cleanProject);

arrOut    := cleanProject ;

dd_arrOut := DEDUP(SORT(DISTRIBUTE(arrOut,HASH(offender_key)),
								   offender_key,REGEXREPLACE('[ ]+',pty_nm,' '),pty_typ,-case_filing_dt,local)
								  ,offender_key,REGEXREPLACE('[ ]+',pty_nm,' '),pty_typ,local): 
								   PERSIST('~thor_dell400::persist::Arrestlogs::WA::KitsapOffender');

export map_WA_KitsapOffender := dd_arrOut;