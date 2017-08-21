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

Crim_Common.Layout_In_Court_offenses tGwinnett(dIn pinput) 
	
	:= TRANSFORM
	
		pointer:=stringlib.stringfind(pInput.charge,'-',1);
		arr_desc :=TRIM(REGEXREPLACE('[*]+|[-]$|[@]$|[#]$|FEL|MISD|\\n|\\r|XX+|\\$',IF(pointer=0,pInput.charge,pInput.Charge[pointer+2..]),' '),LEFT,RIGHT);
		
		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G6'+pInput.id+hash(pInput.Name); 
		SELF.vendor				:= 'G6';
		SELF.state_origin		:= 'OR';
		SELF.source_file		:= '(CV)OR-ClackamasArr';
		SELF.arr_disp_desc_1 	:=  'BOOKED';
		SELF.arr_off_desc_1     :=  IF(LENGTH(TRIM(arr_desc,ALL))>4 OR ARR_DESC='DUI' ,
										regexreplace('[ ]+',arr_desc,' '),'');
		SELF.arr_off_lev        :=  MAP(REGEXFIND('FEL',pInput.charge)=>'F',REGEXFIND('MISD',pInput.charge)=>'M','');
		SELF.arr_date 			:=  if(REGEXFIND('-',pinput.arrest_date), regexreplace('-', pinput.arrest_date, ''),
                               fDate(pinput.arrest_date));
        SELF.arr_statute        := IF(pointer<>0 and pInput.charge[1..2]='OR',pInput.charge[1..pointer-1],'');
		SELF.arr_disp_desc_2 	:= if(REGEXFIND('[1-9]',pinput.bail),'BAIL AMT '+trim(pinput.bail,left,right),'');
		SELF                    := [];
	 END;

dProject := PROJECT(dIn, tGwinnett(LEFT));




dRollup  := DEDUP(SORT(DISTRIBUTE(dProject,HASH(offender_key)),
								   offender_key,le_agency_desc,arr_off_desc_1,arr_off_lev ,local),
								   offender_key,le_agency_desc,arr_off_desc_1,arr_off_lev):
								   PERSIST('~thor_dell400::persist::Arrestlogs::OR::ClackamasOffenses');

export Map_OR_ClackamasOffenses := dRollup; 