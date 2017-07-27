import Standard;
export Standard.Date.datestr date_mask(unsigned4 i, unsigned1 dob_mask_value):= function
  prep_date := map( i < 1800 => 0, //date is invalid
									i < 10000 => i *10000, // year only
									i > 10000 and i < 1000000 => i * 100 ,// year and month
									i
								);
	// do not mask a component of the date if that component is 0							
	maskedyear := case(dob_mask_value,
		constants.datemask.all			=>	'XXXX',
		constants.datemask.year => if(prep_date div 10000 <> 0,'XXXX','0000'),
		(string4)intformat((prep_date div 10000),4,1)
	);
	
	maskedmonth := case(dob_mask_value,
		constants.datemask.all			=>	'XX',
		constants.datemask.month => if((prep_date % 10000) div 100 <> 0,'XX','00'),
		(string2)intformat(((prep_date % 10000) div 100),2,1)
	);

	maskedday := case(dob_mask_value,
		constants.datemask.all			=>	'XX',
		constants.datemask.day		=>	if(prep_date % 100 <> 0 ,'XX','00') ,
		(string2)intformat((prep_date % 100),2,1)
	);
	
	return ROW ({maskedyear, maskedmonth, maskedday}, Standard.Date.Datestr);
end;

