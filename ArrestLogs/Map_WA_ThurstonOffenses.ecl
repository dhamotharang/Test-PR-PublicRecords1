import Crim_Common, Address, VersionControl;

dIn	:= file_WA_thurston(Name<>'Name'  and ~regexfind('[0-9]|NO BAIL',name) and length(name)>4);


Crim_Common.Layout_In_Court_offenses tGwinnett(dIn pinput) 
	:= TRANSFORM
		
		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
			SELF.offender_key		:= (sTRING)'G4'+pInput.id;
			SELF.vendor				:= 'G4';
			SELF.state_origin		:= 'WA';
			SELF.source_file		:= '(CV)WA-ThurstonCtyArr';
			SELF.arr_off_desc_1 	:= regexreplace('FIRST|DEGREE|SECOND|THIRD|1ST|2ND|2nd|1st|3rd|3RD',pinput.Charge,'');
            SELF.arr_off_desc_2     := if(REGEXFIND('NO BAIL',pinput.bail),'','BAIL AMT '+trim(pinput.bail,left,right));
			SELF.arr_off_lev 		:= MAP(regexfind('FIRST |1ST|1st',pinput.Charge) =>'1ST',
								           regexfind('SECOND|2ND|2nd',pinput.Charge)=>'2ND',
								           regexfind('THIRD |3RD|3rd',pinput.Charge)=>'3RD','');
			SELF.arr_disp_desc_1    := 'BOOKED';
			SELF                    := [];
	 END;

dProject := PROJECT(dIn, tGwinnett(LEFT));


dRollup  := DEDUP(SORT(DISTRIBUTE(dProject,HASH(offender_key)),
								   offender_key,le_agency_desc,arr_off_desc_1,arr_off_lev ,local),
								   offender_key,le_agency_desc,arr_off_desc_1,arr_off_lev):
								   PERSIST('~thor_dell400::persist::Arrestlogs::WA::thurstonOffenses');

export Map_WA_thurstonOffenses := dRollup;