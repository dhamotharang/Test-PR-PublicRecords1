import	ut
			 ,Impulse_Email
			 ,lib_stringlib;

export fn_rollup_Impulse_Email(string file_date)
	:=
		FUNCTION

Impulse_Email_last_base	:=	PROJECT(files.file_Impulse_Email_Base, layouts.layout_Impulse_Email_Dates_append);

Impulse_Email_in	:=	files.file_Impulse_Email_In + Impulse_Email_last_base;

distIERecAll	:=	DISTRIBUTE(Impulse_Email_in, HASH(
																																		TRIM(EMAIL)
																																	+ TRIM(FIRSTNAME)
																																	+ TRIM(MIDDLENAME)
																																	+ TRIM(LASTNAME)
																																	+ TRIM(ADDRESS1)
																																	+ TRIM(ADDRESS2)
																																	+ TRIM(CITY)
																																	+ TRIM(STATE)
																																	+ TRIM(ZIP)
																																	));
																																	
srtIERecAll	:=	SORT(distIERecAll
                         , TRIM(EMAIL)
												 , TRIM(FIRSTNAME)
												 , TRIM(MIDDLENAME)
												 , TRIM(LASTNAME)
												 , TRIM(ADDRESS1)
												 , TRIM(ADDRESS2)
												 , TRIM(CITY)
												 , TRIM(STATE)
												 , TRIM(ZIP)
												 , -TRIM(CREATED)
												 , LOCAL);

layouts.layout_Impulse_Email_Dates_append RollUpTrans(srtIERecAll L, srtIERecAll R)
	:=
		TRANSFORM
			self.DateVendorFirstReported	:=	ut.EarliestDate(L.DateVendorFirstReported, R.DateVendorFirstReported);
			self.DateVendorLastReported		:=	ut.LatestDate(L.DateVendorLastReported, R.DateVendorLastReported);			
			self													:=	L;
		END
	;

ruIERec	:=	ROLLUP(srtIERecAll, 
												 TRIM(left.EMAIL) 			= TRIM(right.EMAIL)
										 AND TRIM(left.FIRSTNAME) 	= TRIM(right.FIRSTNAME)
										 // AND TRIM(left.MIDDLENAME)	= TRIM(right.MIDDLENAME)
										 AND TRIM(left.LASTNAME) 		= TRIM(right.LASTNAME)
										 AND TRIM(left.ADDRESS1) 		= TRIM(right.ADDRESS1)
										 AND TRIM(left.ADDRESS2) 		= TRIM(right.ADDRESS2)
										 AND TRIM(left.CITY) 				= TRIM(right.CITY)
										 AND TRIM(left.STATE) 			= TRIM(right.STATE)
										 AND TRIM(left.ZIP) 				= TRIM(right.ZIP)
										   , RollUpTrans(LEFT, RIGHT), LOCAL);

RETURN ruIERec;

END;