export GetDaylightSavings(string2 st) := FUNCTION


	no_daylight_savings := ['HI','AZ','PR','VI','GU','AS','TR','SA','KA','BV','NN','VI',
	'PR','AI','AN','CQ','ZF','SK','DM','DR','GN','JM','BD','RT'];


	//getTimeDate will return in format YYYY-MM-DDHHMMSSW where W is the day of the week (1 = Monday)

	datetimeday := ut.GetTimeDate();

	date := (unsigned1) (datetimeday[9..10]);

	month := (unsigned1) (datetimeday[5..7]);

	day_of_week := (unsigned1) (datetimeday[17]);

	Time := (unsigned4) (datetimeday[11..16]);

	DS_nonboundary :=  month between 4 and 10;

	Nov_boundary := day_of_week=7 and date <=7;

	March_boundary := day_of_week=7 and date between 8 and 14;

	DS_Nov := month = 11 and (Nov_boundary or
	(integer1) (date - day_of_week) <= 0);

	DS_March := month = 3 and (March_boundary  or
	(integer1) (date - (day_of_week + 7)) > 0);

	DS_spring_forward := month =3 and March_boundary;

	DS_fall_back := month = 11 and Nov_boundary;


	DS_time_forward := TIME >= 020000; //before 2 am

	DS_time_back := TIME < 020000;


	is_daylight_savings_time_of_year :=  (Ds_nonboundary or Ds_March or DS_Nov) and 
	if(DS_spring_forward,DS_time_forward,TRUE) and if(DS_Fall_back,Ds_time_back,TRUE);


	daylight_savings := st not in no_daylight_savings and is_daylight_savings_time_of_year;
	
	RETURN daylight_savings;

END;