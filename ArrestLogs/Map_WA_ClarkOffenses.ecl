import Crim_Common, Address, Gong;

p	:= file_WA_Clark.cmbnd;

Crim_Common.Layout_In_Court_Offenses  tCanyon(p input) 
	:= TRANSFORM
		yearyy:= TRIM(input.book_date,RIGHT)[7..8]; 
		Year  := IF((INTEGER) yearyy<30, '20'+yearyy,'19'+yearyy);

		SELF.process_date				:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key				:= 'F9'+TRIM(input.ID,LEFT,RIGHT);
		SELF.vendor						:= 'F9';
		SELF.state_origin				:= 'WA';
		SELF.source_file				:= '(CV)WA-ClarkCtyArr';
		SELF.arr_date 					:= IF(yearyy='','',Year+TRIM(input.book_date,ALL)[1..2] +TRIM(input.book_date,ALL)[4..5]);
		SELF.le_agency_case_number 		:= input.ID;
		SELF.arr_off_desc_1				:= regexreplace('\r',input.charge,'');
		SELF.arr_disp_desc_1 			:= 'BOOKED';
		SELF:=[];
	 END;
pCanyon := PROJECT(p,tCanyon(LEFT));
dd_arrOut:= DEDUP(SORT(DISTRIBUTE(pCanyon,HASH(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,LOCAL),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,LOCAL,RIGHT):
									PERSIST('~thor_dell400::persist::ArrestLogs::WA::Clark_Offenses');

export map_WA_ClarkOffenses	:= dd_arrOut;