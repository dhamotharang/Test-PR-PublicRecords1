import progressive_phone;
EXPORT FN_GetIntegratorCode(string1 p_confirmed,integer p_count,string p_relation):= FUNCTION
	position_code := CASE(p_count,
										1=>'1',2=>'2',3=>'3',4=>'4',5=>'5',6=>'6',7=>'7',8=>'8',9=>'9',10=>'A',
										11=>'B',12=>'C',13=>'D',14=>'E',15=>'F',16=>'G',17=>'H',18=>'I',19=>'J',
										20=>'K',21=>'L',22=>'M',23=>'N',24=>'O',25=>'P',26=>'Q',27=>'R',
										28=>'S',29=>'T',30=>'U',31=>'V',32=>'W',33=>'X',34=>'Y',35=>'Z','');
										
	relation_code := CASE(p_relation,
									'ASSOCIATE'=>'A','ASSOCIATE BY ADDRESS'=>'B','ASSOCIATE BY BUSINESS'=>'C','ASSOCIATE BY PROPERTY'=> 'D',
									'ASSOCIATE BY SSN'=>'E','ASSOCIATE BY SHARED ASSOCIATES'=>'F','ASSOCIATE BY VEHICLE'=>'G','BROTHER'=>'H',
									'CHILD'=>'I','DAUGHTER'=>'J','FATHER'=>'K','GRANDDAUGHTER'=>'L','GRANDFATHER'=>'M',
									'GRANDMOTHER'=>'N','GRANDPARENT'=>'O','GRANDSON'=>'P','HUSBAND'=>'Q','MOTHER'=>'R','NEIGHBOR'=>'S',
									'PARENT'=>'T','RELATIVE'=>'U','SIBLING'=>'V','SISTER'=>'W','SON'=>'X','SPOUSE'=>'Y','SUBJECT'=>'Z',
									'SUBJECT AT HOUSEHOLD'=>'1','WIFE'=>'2','GRANDCHILD'=>'3','');

	//dup_phone_flag + phone position + relationship code
	string3 integrator_code:= p_confirmed + position_code + relation_code;

	//to stay within the string3 character limit, we only support integrator codes for the first 35 phones
	RETURN if(p_count<=progressive_phone.Constants.max_integrator,integrator_code,'');
END;