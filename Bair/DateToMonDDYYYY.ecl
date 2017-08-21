EXPORT DateToMonDDYYYY (string dt) := FUNCTION
	yyyy := TRIM(dt[1..4], ALL);
	mm 	 := TRIM(dt[5..6], ALL);
	dd   := TRIM(dt[7..8], ALL);
	
	mon := CASE(mm,
					'01' => 'Jan',
					'02' => 'Feb',
					'03' => 'Mar',
					'04' => 'Apr',
					'05' => 'May',
					'06' => 'Jun',
					'07' => 'Jul',
					'08' => 'Aug',
					'09' => 'Sep',
					'10' => 'Oct',
					'11' => 'Nov',
					'12' => 'Dec',
									 ''); // Invalid format, return blanks
	result := mon + ' ' + dd + ', ' + yyyy;
	return result;
end;