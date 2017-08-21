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

Layout_Temp:= Record
	STRING Booking_Number;
	STRING Booking_Date;
	STRING Name;
	STRING DOB;
	STRING Sex;
	STRING Race;
	STRING Height;
	STRING Weight;
	STRING Hair_Color;
	STRING Eye_Color;
END;

Layout_Temp T20060(df20060 l):=
 Transform
    b_dt               :=IF(l.booking_date='',l.arrest_date,l.booking_date);
    SELF.DOB   		   :=if((INTEGER)stringlib.GetDateYYYYMMDD()[1..4]-(INTEGER)fDate(l.DOB)[1..4]<18,'',fDate(l.DOB));
	SELf.Booking_date  :=IF(stringlib.GetDateYYYYMMDD()[1..4]<fdate(b_dt[1..4]),'',fdate(b_dt));
	SELF.booking_number:=REGEXREPLACE('[\n]|[\r]',l.booking,'');
	SELF.height        :=l.height[1..2]+' '+l.height[3..4];
	Self               :=L;
	SELF               :=[];
end;
Layout_Temp T20070(df20070 l):=
 Transform
    b_dt               :=IF(l.booking_date='',l.arrest_date,l.booking_date);
   
    SELF.DOB   		   :=if((INTEGER)stringlib.GetDateYYYYMMDD()[1..4]-(INTEGER)fDate(l.DOB)[1..4]<18,'',fDate(l.DOB));
	SELf.Booking_date  :=IF(stringlib.GetDateYYYYMMDD()[1..4]<fdate(b_dt[1..4]),'',fdate(b_dt));
	SELF.booking_number:=REGEXREPLACE('[\n]|[\r]',l.booking,'');
	Self               :=L;
	SELF               :=[];
end;
Layout_Temp T2008(df2008 l):=
 Transform
    b_dt               :=IF(l.booking_date='',l.arrest_date,l.booking_date);
    SELF.DOB   		 :=if((INTEGER)stringlib.GetDateYYYYMMDD()[1..4]-(INTEGER)fDate(l.DOB)[1..4]<18,'',fDate(l.DOB));
	SELf.Booking_date:=IF(stringlib.GetDateYYYYMMDD()[1..4]<fdate(b_dt[1..4]),'',fdate(b_dt));
	SELF.booking_number:=REGEXREPLACE('[\n]|[\r]',l.booking_number,'');
	SELF.height        :=l.height[1..2]+' '+l.height[3..4];
	Self             :=L;
	SELF             :=[];
end;

dIN  :=PROJECT(DF20060,T20060(LEFT))+PROJECT(DF20070,T20070(LEFT))+PROJECT(DF2008,T2008(LEFT));


Crim_Common.Layout_In_Court_Offender tdin(DIN  pinput) 
	:= TRANSFORM
	    HEIGHT                	:=(integer)pinput.height[1]*12+IF(pinput.height[1]='7',0,(integer)pinput.height[4..5]);
		weight                  :=(INTEGER)pinput.weight[1..4];
		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G8'+pInput.booking_number; 
		SELF.vendor				:= 'G8';
		SELF.state_origin		:= 'OK';
		SELF.source_file		:= '(CV)OK-CarterCtyArr';
		SELF.case_number		:= ''; 
		SELF.hair_color_desc	:= MAP(pInput.Hair_color[1] in['U','y']=>'',
									   pInput.Hair_color[1..3]='BAL'=>'BALD',
									   pInput.Hair_color[1..3]='BLK'=>'BLACK',
									   pInput.Hair_color[1..3]in['BLN','SDY']=>'BLONDE',
									   pInput.Hair_color[1..3]='BLU'=>'BLUE',
									   pInput.Hair_color[1..3]='BRO'=>'BROWN',
									   pInput.Hair_color[1..3]='GRY'=>'GRAY',
									   pInput.Hair_color[1..3]='GRN'=>'GREEN', 
    								   pInput.Hair_color[1..3]='WHI'=>'WHITE',pInput.Hair_color);
		SELF.Weight             := IF(weight<=500 AND weight>50,(STRING)weight,'');
		SELF.height				:= IF(HEIGHT<48,'',(STRING)height);
		SELF.race_desc			:= MAP(pInput.race[1] in['U','A','O']=>'',
		                               pInput.race='I'=>'INDIAN-ALASKAN ',
									   pInput.race='H'=>'HISPANIC',
									   pInput.race='B'=>'BLACK', 
									   pInput.race='W'=>'WHITE', pInput.race); 
		SELF.eye_color_desc		:= MAP(pinput.eye_color[1..3]='GRN'=>'GREEN',
									   pinput.eye_color[1..3]='BLU'=>'BLUE',
									   pinput.eye_color[1..3]='BLK'=>'BLACK',
									   pinput.eye_color[1..3]='BRW'=>'BROWN',
									   pinput.eye_color[1..3]='HAZ'=>'HAZEL',
									   pinput.eye_color[1..3]='GRY'=>'GRAY',
									   pinput.eye_color[1..3] in ['BRR','BRO','BRR']=>'BROWN',
									   pinput.eye_color[1] in['U','y','N']=>'',pinput.eye_color);
		SELF.SEX                := IF(PINPUT.SEX[1] IN[ 'F','M'],PINPUT.SEX,'');
		SELF.case_filing_dt		:= pInput.Booking_date;
		SELF.pty_nm				:= REGEXREPLACE('[ ]+',REGEXREPLACE(',',pInput.name,', '),' ');
									 
	
		SELF.pty_nm_fmt			:= 'L';
		SELF.pty_typ			:= '0';
		SELF.dob                := pInput.dob;
		SELF                    := [];

      END;
		 

dProject  := PROJECT(din, tdin(LEFT));

ArrestLogs.ArrestLogs_clean(dProject,cleanProject);


dd_arrOut := DEDUP(SORT(DISTRIBUTE(cleanProject,HASH(offender_key)),
								   offender_key, stringlib.StringToUpperCase(stringlib.stringfilterout(pty_nm,' , ')),pty_typ,-case_filing_dt,local)
								  ,offender_key,stringlib.StringToUpperCase(stringlib.stringfilterout(pty_nm,' , ')),pty_typ,local): 
								   PERSIST('~thor_dell400::persist::Arrestlogs::OK::CarterOffender');

export Map_OK_CarterOffender := dd_arrOut;