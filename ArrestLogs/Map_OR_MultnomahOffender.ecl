import Crim_Common, Address, VersionControl;
 
din	      := file_OR_Multnomah(~regexfind('Name|[0-9]',name) and length(name)>4 );

fDate(STRING inDate) 
	:= FUNCTION
			Position1            := StringLib.StringFind(inDate,'/',1);
	        position2            := StringLib.StringFind(inDate,'/',2);
		    STRING8 newDate 	 := TRIM(MAP(length(indate[position2+1..])=4=>indate[position2+1..],
			                                 inDate[position2+1]='0'=>'20'+indate[position2+1..position2+3],
											 '19'+indate[position2+1..position2+3]),ALL)+
											 IF(position1=2, '0'+ inDate[1],inDate[1..2])+
			                          IF(position2-position1=3,inDate[position1+1..position1+2], '0'+inDate[position1+1..position2]);
			RETURN   IF(LENGTH(TRIM(newDate,ALL))<8,'',newDate);	
			 
		END;	 

Crim_Common.Layout_In_Court_Offender tGwinnett(dIn  pinput) 
	:= TRANSFORM
	    SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G5'+pInput. SWIS_ID+hash(pInput.Name); 
		SELF.vendor				:= 'G5';
		SELF.state_origin		:= 'OR';
		SELF.source_file		:= '(CV)OR-MultnomahArr';
		SELF.case_number		:= '';
		SELF.DOB                := if((INTEGER)stringlib.GetDateYYYYMMDD()[1..4]-(INTEGER)fDate(pinput.DOB)[1..4]<18,'',fDate(pinput.DOB));
		SELF.case_filing_dt		:= fdate(pinput.BOOKING_DATE_TIME); 
		SELF.pty_nm				:= IF(REGEXFIND('[(]',pInput.name),
									  pInput.name[1..Stringlib.StringFind(Pinput.name,'(', 1)-1],
									  pInput.name);
		SELF.pty_nm_fmt			:= 'L';
		SELF.pty_typ			:= '0'; 
		SELF                    := [];

      END;

dProject  := PROJECT(dIn, tGwinnett(LEFT));

ArrestLogs.ArrestLogs_clean(dProject,cleanProject);

arrOut    := cleanProject ;

dd_arrOut := DEDUP(SORT(DISTRIBUTE(arrOut,HASH(offender_key)),
								   offender_key,REGEXREPLACE('[ ]+',pty_nm,' '),pty_typ,-case_filing_dt,local)
								  ,offender_key,REGEXREPLACE('[ ]+',pty_nm,' '),pty_typ,local): 
								   PERSIST('~thor_dell400::persist::Arrestlogs::OR::MultnomahOffender');

export map_OR_MultnomahOffender := dd_arrOut ; 