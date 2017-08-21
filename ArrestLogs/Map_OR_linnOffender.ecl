import Crim_Common, Address, VersionControl;

dInOld	:= file_OR_linn.Old(~regexfind('Name|[0-9]',name) and ~regexfind('[A-Z]',charge) and length(name)>4 and ~regexfind('CONTEMPT OF COURT',charge_description));
dInNew	:= file_OR_linn.new(~regexfind('Name|[0-9]',name) and ~regexfind('[A-Z]',charge) and length(name)>4 and ~regexfind('CONTEMPT OF COURT',charge_description));
layout_OR_linn.new T(dinold pInput)
  := TRANSFORM
      SELF.ID:=pInput.Master_ID;
	  SELF   :=pInput;
   END; 
   
Din:=dInNew+PROJECT(dInOld,t(left));

fDate(string dt):=function
    yearyy:= stringlib.Stringfind(dt,'/',2); 
	Year  := IF(dt='','',
			  IF((INTEGER) dt[yearyy+1..]<30, '20','19')+dt[yearyy+1..]);
	date  := IF(yearyy=0,'',
	           year+IF(stringlib.Stringfind(dt,'/',1)=2,'0'+dt[1],dt[1..2])+
			   dt[stringlib.Stringfind(dt,'/',1)+1..stringlib.Stringfind(dt,'/',1)+2]);
	 RETURN date;
	 END;


Crim_Common.Layout_In_Court_Offender tGwinnett(dIn  pinput) 
	:= TRANSFORM
	       	SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
			SELF.offender_key		:= (sTRING)'G3'+pInput.id+hash(pInput.name);
			SELF.vendor				:= 'G3';
			SELF.state_origin		:= 'OR';
			SELF.data_type			:= '5';
			SELF.source_file		:= '(CV)OR-LinnCtyArr';
			SELF.case_number		:= '';
			//SELF.case_court			:= IF(REGEXFIND('HOLD',pInput.Court),'',pInput.Court);
			SELF.case_filing_dt		:= fdate(pinput.Date_Lodged); 
			SELF.pty_nm				:= IF(REGEXFIND('[(]',pInput.name),
										  pInput.name[1..Stringlib.StringFind(Pinput.name,'(', 1)-1],
										  pInput.name);
			SELF.pty_nm_fmt			:= 'L';
			SELF.pty_typ			:= '0'; 
			SELF.party_status		:= IF(regexfind('NA',pInput.Status),'',pInput.Status);
			SELF                    := [];

      END;

dProject  := PROJECT(dIn, tGwinnett(LEFT));

ArrestLogs.ArrestLogs_clean(dProject,cleanProject);

arrOut    := cleanProject ;

dd_arrOut := DEDUP(SORT(DISTRIBUTE(arrOut,HASH(offender_key)),
								   offender_key,REGEXREPLACE('[ ]+',pty_nm,' '),pty_typ,-case_filing_dt,local)
								  ,offender_key,REGEXREPLACE('[ ]+',pty_nm,' '),pty_typ,local): 
								   PERSIST('~thor_dell400::persist::Arrestlogs::OR::linnOffender');

export map_OR_linnOffender := dd_arrOut;