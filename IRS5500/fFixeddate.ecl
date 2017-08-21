Import ut;

export ffixedDate(dataset(Layout_IRS5500_AID) pIRRS5500)
 :=function
 
// We no longer use name scores... just have to go with the existance of a first and last name
dIn:=pIRRS5500(spons_sign_lname != '');


layout_uid:=
	RECORD
		UNSIGNED uid;
		dIn;
	END;

layout_uid tadduid(dIn pInput,UNSIGNED c):=
	TRANSFORM
		SELF.uid:=c;
		SELF	:=pInput;
	END;
//Create a unique ID
Duid	   :=DISTRIBUTE(PROJECT(dIn,tAddUid(LEFT,COUNTER)),UID);

layout_date:=
	RECORD
		Duid.uid;
		string10 date;
	END;

layout_date tNORMALIZEdate(Duid pinput,integer c):=
	TRANSFORM
		SELF.date:=CHOOSE(c,pInput.trans_date,pInput.form_plan_year_begin_date,pInput.form_tax_prd,pInput.date_received);
		SELF:=pInput;
	END;
//Slim the source date 
dNormal		:=NORMALIZE(dUid,4,tNORMALIZEdate(LEFT,COUNTER));
ut.macAppendStandardizedDate(dNormal,date,dDateStandardized);

Layout_last_first_seen :=
   RECORD
	dDateStandardized.uid;
	dt_last_seen	:=MAX(GROUP,dDateStandardized.yyyy+dDateStandardized.mm+dDateStandardized.dd);
	dt_first_seen	:=MIN(GROUP,dDateStandardized.yyyy+dDateStandardized.mm+dDateStandardized.dd);
   END;


dDates :=  TABLE(dDateStandardized(YYYY<>'0000'),Layout_last_first_seen,uid);
recordof(din) tGetFulldata(duid pLeft,Layout_last_first_seen pright):= 
   TRANSFORM
     SELF.trans_date :=pright.dt_last_seen;
	 SELF.form_plan_year_begin_date:=pright.dt_First_seen;
	 SELF  			   :=pLeft;
   END;
//get last seen and first seen dates

//join back the orig files 
REturn JOIN(duid ,dDates,LEFT.uid=RIGHT.uid ,tGetFullData(left,right),left outer,local);
END;