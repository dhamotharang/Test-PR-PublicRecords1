EXPORT ERO := module

	shared	lApprissSubDirName		  :=	'';
	shared	lCSVVersion							:=	'20130201';
	shared	lCSVFileNamePrefix			:=	'~thor_200::prte::';



	export	rCSVERO__facility_address	:=
	RECORD
  string10 prim_range;
  string28 prim_name;
  string5 zip;
  UNSIGNED8 RecPtr {virtual(fileposition)};

  END;	 
	
	
export	dCSVAppriss__state_id						:= 	dataset(lCSVFileNamePrefix + 'prte__key__ERO__' + lCSVVersion + '__facility_address.csv', rCSVERO__facility_address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

end;

