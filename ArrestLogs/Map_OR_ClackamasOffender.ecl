import Crim_Common, Address, VersionControl;

import Crim_Common, Address, VersionControl;
 
dF20061_20070 := file_OR_Clackamas.F20061_20070(~regexfind('Name|[0-9]',name)  and length(name)>4);
dF20071_2008  := file_OR_Clackamas.F20071_2008(~regexfind('Name|[0-9]',Name)  and length(Name)>4 );


layout_OR_Clackamas.l20071_2008 T(dF20061_20070 	 pInput)
  := TRANSFORM
     SELF            :=pInput;
	 SELF            :=[];
   END;
  
Din:=dF20071_2008+PROJECT(dF20061_20070,t(left));

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
	    HEIGHT                	:=(integer)pinput.height[1]*12+IF(pinput.height[1]='7',0,(integer)pinput.height[6..7]);
		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G6'+pInput.id+hash(pInput.Name); 
		SELF.vendor				:= 'G6';
		SELF.state_origin		:= 'OR';
		SELF.source_file		:= '(CV)OR-ClackamasArr';
		SELF.case_number		:= '';
		SELF.orig_lname			:= REGEXREPLACE(',',pinput.LastName,'');
		SELF.orig_fname			:= pinput.FirstName;
		SELF.orig_mname			:= pinput.MiddleName;
		SELF.DOB                := if((INTEGER)stringlib.GetDateYYYYMMDD()[1..4]-(INTEGER)fDate(pinput.DOB)[1..4]<18,'',fDate(pinput.DOB));
		SELF.hair_color_desc	:= pInput.Hair;
		SELF.Weight             := IF((INTEGER)pinput.weight[1..4]<=500 AND (INTEGER)pinput.weight[1..4]>50,pinput.weight[1..4],'');
		SELF.height				:= IF(HEIGHT<48,'',(STRING)height);
		SELF.race_desc			:= IF(pInput.race[1]='U','',pInput.race); 
		SELF.eye_color_desc		:= pinput.eyes ;
		SELF.SEX                := IF(PINPUT.SEX[1] IN[ 'F','M'],PINPUT.SEX,'');
		SELF.case_filing_dt		:= if(REGEXFIND('-',pinput.arrest_date), regexreplace('-', pinput.arrest_date, ''),
		                            fdate(pinput.Arrest_Date)); 
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
								   PERSIST('~thor_dell400::persist::Arrestlogs::OR::ClackamasOffender');

export map_OR_ClackamasOffender := dd_arrOut ; 