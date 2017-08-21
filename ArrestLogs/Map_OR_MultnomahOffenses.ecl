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

Crim_Common.Layout_In_Court_offenses tGwinnett(dIn pinput) 
	
	:= TRANSFORM
	
		charge:=trim(pInput.charge,left,right)+' '+trim(pInput.Second_charge,left,right);
		
		arr_desc :=TRIM(REGEXREPLACE('[*]+|[-]$|[@]$|[#]$|FEL|MISD|MIS |\\n|\\r|XX+|\\$',Charge,' '));
		
		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G5'+pInput. SWIS_ID+hash(pInput.Name); 
		SELF.vendor				:= 'G5';
		SELF.state_origin		:= 'OR';
		SELF.source_file		:= '(CV)OR-MultnomahArr';
		SELF.arr_disp_desc_1 	:=  'BOOKED';
		SELF.arr_off_desc_1     :=  IF(LENGTH(TRIM(arr_desc,ALL))>4 OR ARR_DESC='DUI' ,
										regexreplace('[ ]+',arr_desc,' '),'');
		SELF.arr_off_lev        :=  MAP(REGEXFIND('FEL',charge)=>'F',REGEXFIND('MISD|MIS ',charge)=>'M','');
		SELF.arr_date 			:=  fDate(pinput.BOOKING_DATE_TIME);
        SELF                    := [];
	 END;

dProject := PROJECT(dIn, tGwinnett(LEFT));




dRollup  := DEDUP(SORT(DISTRIBUTE(dProject,HASH(offender_key)),
								   offender_key,le_agency_desc,arr_off_desc_1,arr_off_lev ,local),
								   offender_key,le_agency_desc,arr_off_desc_1,arr_off_lev):
								   PERSIST('~thor_dell400::persist::Arrestlogs::OR::MultnomahOffenses');

export Map_OR_MultnomahOffenses := dRollup; 