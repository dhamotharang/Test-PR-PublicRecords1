import Crim_Common, Address, VersionControl;

dIn	:= file_WA_Kitsap(Name<>'Name' and name<>'');
 
Crim_Common.Layout_In_Court_Offenses tGwinnett(dIn pinput) 
	:= TRANSFORM
	
 	        Booking_Date:=pInput.Booking_Date[7..10]+pInput.Booking_Date[1..2]+pInput.Booking_Date[4..5]; 
	        
			SELF.process_date		:= Crim_Common.Version_In_Arrest_Offenses;
			SELF.offender_key    	:= (sTRING)'G1'+pInput.id;
			SELF.vendor				:= 'G1';
			SELF.state_origin		:= 'WA';
			SELF.source_file		:= '(CV)WA-KitsapCtyArr';
			SELF.arr_disp_desc_1    := 'BOOKED';
			SELF.arr_date           := Booking_Date;
			SELF.arr_off_desc_1 	:= IF(length(stringlib.stringfilter(Pinput.Charge,'0987654321'))>1,regexreplace('-$',Pinput.Charge,''),
			                           stringlib.stringfilterout(Pinput.Charge,'0987654321'));
			self.arr_off_lev 		:= IF(Pinput.fel_misd in['M','F'],Pinput.fel_misd,'');
			self.arr_disp_desc_2 	:= if(regexreplace('[$]|[0]|[,]',pinput.Bond_Amount,'')<>'',
									    regexreplace('[\r\n]',pInput.Bond_Type,'')+': '+pinput.Bond_Amount,'');
									
			SELF                    :=[];

      END;


dProject  := PROJECT(dIn, tGwinnett(LEFT));

arrOut := DEDUP(SORT(DISTRIBUTE(dProject,HASH(offender_key)),
								   offender_key,arr_date,arr_off_desc_1,arr_off_desc_2,local)
								  ,offender_key,arr_date,arr_off_desc_1,arr_off_desc_2,local);
dd_ArrOut  := arrout(arr_off_desc_1+arr_off_desc_2 <>'')+ 
          Join(arrout(arr_off_desc_1+arr_off_desc_2 =''),arrout(arr_off_desc_1+arr_off_desc_2 <>''),
		  left.offender_key=right.offender_key,left only,local):
			PERSIST('~thor_dell400::persist::Arrestlogs::WA::KitsapOffenses');

export map_WA_KitsapOffenses := dd_arrOut;