IMPORT  Crim_Common, Address;

p	:= file_WA_Clark(name<>'Name' and name<>',');

fDate(string dt):=function
     yearyy:= TRIM(dt,ALL)[7..8]; 
	 Year  := IF((INTEGER) yearyy<30, '20'+yearyy,'19'+yearyy);
	 date  := IF(yearyy='','',Year+TRIM(dt,ALL)[1..2] +TRIM(dt,ALL)[4..5]);
	 RETURN date;
	 END;
        
Crim_Common.Layout_In_Court_Offender tada(p input) 
	:= TRANSFORM
			SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
			SELF.offender_key		:= 'F9'+TRIM(input.ID,ALL);
			SELF.vendor				:= 'F9';
			SELF.state_origin		:= 'WA';
			SELF.data_type			:= '5';
			SELF.source_file		:= '(CV)WA-ClarkCtyArr';
			SELF.case_filing_dt		:= fDate(input.Book_date);
			SELF.pty_nm				:= input.name;
			SELF.pty_nm_fmt			:= 'L';
			SELF.pty_typ			:= '0';
			SELF.party_status_desc	:=  IF(~regexfind('[0-9]',input.release_date),'','Release Date: '+fdate(input.release_date));
			SELF				    := [];
	 END;


pada := PROJECT(p, tada(LEFT));

ArrestLogs.ArrestLogs_clean(pada,cleanada);

dd_arrOut := DEDUP(SORT(DISTRIBUTE(cleanada,HASH(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,LOCAL)
										,offender_key,pty_nm,pty_typ,LOCAL,LEFT): 
										PERSIST('~thor_dell400::persist::Arrestlogs::WA::Clark_Offender');

EXPORT map_WA_ClarkOffender := dd_arrOut; 