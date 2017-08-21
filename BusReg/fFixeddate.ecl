Import ut;

prepros_file := DATASET('~thor_data400::in::fbn::sprayed::accutrend_clean', Layout_BusReg_In, THOR);
//File from previous run.
previousfile := DATASET(ut.foreign_prod+'thor_data400::in::accutrend_fbn',Layout_BusReg_In, THOR);

completefile := prepros_file + previousfile; 

layout_uid:=
	RECORD
		UNSIGNED uid;
		completefile;
	END;

layout_uid tadduid(completefile pInput,UNSIGNED c):=
	TRANSFORM
		SELF.uid:=c;
		SELF	:=pInput;
	END;

Duid	   :=DISTRIBUTE(PROJECT(completefile,tAddUid(LEFT,COUNTER)),UID);

layout_date:=
	RECORD
		Duid.uid;
		string10 date;
	END;

layout_date tNORMALIZEdate(Duid pinput,integer c):=
	TRANSFORM
		SELF.date:=CHOOSE(c,pInput.start_date,pInput.file_date,pInput.record_date);
		SELF:=pInput;
	END;

dNormal		:=NORMALIZE(dUid,3,tNORMALIZEdate(LEFT,COUNTER));

ut.macAppendStandardizedDate(dNormal,date,dDateStandardized);

Layout_last_first_seen :=
   RECORD
	dDateStandardized.uid;
	dt_last_seen	:=MAX(GROUP,dDateStandardized.yyyy+dDateStandardized.mm+dDateStandardized.dd);
	dt_first_seen	:=MIN(GROUP,dDateStandardized.yyyy+dDateStandardized.mm+dDateStandardized.dd);
   END;

Layout_BusReg_In tGetFulldata(Duid pLeft,Layout_last_first_seen pright):= 
   TRANSFORM
     SELF.date_last_seen :=pright.dt_last_seen;
	 SELF.date_first_seen:=pright.dt_First_seen;
	 SELF  			   :=pLeft;
   END;
dDates :=  TABLE(dDateStandardized(YYYY<>'0000'),Layout_last_first_seen,uid);
 
export fFixeddate := JOIN(dUid,dDates,LEFT.uid=RIGHT.uid ,tGetFullData(left,right),left outer,local);