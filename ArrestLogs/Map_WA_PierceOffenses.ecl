import Crim_Common, Address, VersionControl;

dIn	:= Dedup(file_WA_Pierce(Name<>'Name' and length(trim(name,all))>4),all);
fDate(string dt):=function
     yearyy:= TRIM(dt,ALL)[7..8]; 
	 Year  := IF((INTEGER) yearyy<30, '20'+yearyy,'19'+yearyy);
	 date  := IF(yearyy='','',Year+TRIM(dt,ALL)[1..2] +TRIM(dt,ALL)[4..5]);
	 RETURN date;
	 END;
Crim_Common.Layout_In_Court_offenses tGwinnett(dIn pinput) 
	:= TRANSFORM
	 name     :=IF(REGEXFIND('[(]',pInput.name),
										  pInput.name[1..Stringlib.StringFind(Pinput.name,'(', 1)-1],
										  stringlib.stringfilterout(pInput.name,'>'));
	 pointer  :=Stringlib.StringFind(pInput.bail,'=',1)+1;
	 arr_off  :=stringlib.stringfilterOut(pInput.charge,'0123456789`') ;   
	 arr_disp :=REGEXREPLACE('[\r\n]',pinput.disposition,''); ;									
		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G2'+hash(pInput.Jurisdiction+(string) pinput.id+REGEXREPLACE('[ ]+|[>]',name,' '));
		SELF.vendor				:= 'G2';
		SELF.state_origin		:= 'WA';
		SELF.source_file		:= '(CV)WA-PierceCtyArr';
		SELF.le_agency_desc 	:= regexreplace('[0-9]|'+'-',pinput.arresting_agency,'');
		SELF.arr_disp_desc_1 	:= 'BOOKED';
		SELF.sent_date          := fDate(pInput.sentence_date);
        SELF.sent_jail          := IF(regexfind('^0 ',pInput.sentence),'',pInput.sentence);
		SELF.num_of_counts      := pInput.countno;
		SELF.arr_off_desc_1     := REGEXREPLACE('/$',arr_off,'');
		SELF.arr_off_lev        := IF(length(stringlib.stringfilter(pInput.charge,'1234'))=1,stringlib.stringfilter(pInput.charge,'1234'),'');
		SELF                    := [];

      END;
Crim_Common.Layout_In_Court_offenses tRollup(Crim_Common.Layout_In_Court_offenses l,Crim_Common.Layout_In_Court_offenses r)
     :=TRANSFORM
        SELF.le_agency_desc     := IF(l.le_agency_desc='',r.le_agency_desc,l.le_agency_desc);
		SELF.arr_disp_desc_2 	:= IF(l.arr_disp_desc_2='',r.arr_disp_desc_2,l.arr_disp_desc_2);
		SELF.arr_disp_desc_1 	:= IF(l.arr_disp_desc_1='',r.arr_disp_desc_1,l.arr_disp_desc_1);
		SELF.sent_date          := IF(l.sent_date='',r.sent_date,l.sent_date);
		SELF.sent_jail          := IF(l.sent_jail='',r.sent_jail,l.sent_jail);
		SELF.num_of_counts      := IF(l.num_of_counts='',r.num_of_counts,l.num_of_counts);
		SELF.arr_off_desc_1     := IF(l.arr_off_desc_1='',r.arr_off_desc_1,l.arr_off_desc_1);
		SELF.arr_off_lev        := IF(l.arr_off_lev ='',r.arr_off_lev,r.arr_off_lev);	
		self                    := l;
		
	  END;
	  
dProject  := PROJECT(dIn, tGwinnett(LEFT));

dd_arrOut := SORT(DISTRIBUTE(dProject,HASH(offender_key)),
								   offender_key,le_agency_desc,-arr_disp_desc_2,-arr_disp_desc_1,local);
								
dRollup   := rollup(dd_arrOut,trollup(left,Right),offender_key,le_agency_desc,local):
			PERSIST('~thor_dell400::persist::Arrestlogs::WA::Pierceoffenses');

export map_WA_Pierceoffenses := dRollup ;