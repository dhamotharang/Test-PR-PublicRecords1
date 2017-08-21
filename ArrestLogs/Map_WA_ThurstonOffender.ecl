import Crim_Common, Address, VersionControl;

dIn	:= file_WA_thurston(Name<>'Name'  and ~regexfind('[0-9]|NO BAIL',name) and length(name)>4 );


Crim_Common.Layout_In_Court_Offender tGwinnett(dIn  pinput) 
	:= TRANSFORM
	        nm                      :=IF(REGEXFIND('[(]',pInput.name),
										  pInput.name[1..Stringlib.StringFind(Pinput.name,'(', 1)-1],
										  pInput.name);
	       	SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
			SELF.offender_key		:= (sTRING)'G4'+pInput.id;
			SELF.vendor				:= 'G4';
			SELF.state_origin		:= 'WA';
			SELF.data_type			:= '5';
			SELF.source_file		:= '(CV)WA-ThurstonCtyArr';
			SELF.case_number		:= '';
			SELF.case_court			:= IF(REGEXFIND('HOLD',pInput.Court),'',pInput.Court);
			SELF.pty_nm				:= REGEXREPLACE('[*]',nm,'');
			SELF.pty_nm_fmt			:= 'F';
			SELF.pty_typ			:= '0'; 
			SELF                    := [];

      END;

dProject  := PROJECT(dIn, tGwinnett(LEFT));

ArrestLogs.ArrestLogs_clean(dProject,cleanProject);

arrOut    := cleanProject(length(pty_nm)>4) ;

dd_arrOut := DEDUP(SORT(DISTRIBUTE(arrOut,HASH(offender_key)),
								   offender_key,REGEXREPLACE('[ ]+',pty_nm,' '),pty_typ,-case_filing_dt,local)
								  ,offender_key,REGEXREPLACE('[ ]+',pty_nm,' '),pty_typ,local): 
								   PERSIST('~thor_dell400::persist::Arrestlogs::WA::thurstonOffender');

 
export Map_WA_ThurstonOffender := dd_arrOut;