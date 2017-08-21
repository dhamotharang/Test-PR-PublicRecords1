import	ut;

export	constants	:=
MODULE

	export	cluster								:=	'~thor400_20::';
	
	export	str_PostalTableMatch	:=	'POSTAL TABLE MATCH'; 

	export	str_ZipChange					:=	'Zip Change';
	export	str_CityChange				:=	'City Change';
	export	str_StreetChange			:=	'Street Change';

	export	str_update						:=	'UPDATE';
	export	str_confirm						:=	'CONFIRM';
	export	str_historical				:=	'HISTORICAL';
	export	str_unknown						:=	'UNKNOWN';

	export	rank_address_type(string	s)	:=	case(	s,
																									str_update		=>	1,
																									str_confirm		=>	2,
																									str_historical=>	3,
																									str_unknown		=>	4,
																									5
																								);

	Set_cname	:=	[];
	Row_27		:=	['ILLEGIBLE-I'];
	Row_28		:=	['SEE ADDRESS ON LABEL'];
	
	copy_Record	:=
	record
		varstring	cname;
	end;
	
	copy_Dataset	:=	dataset(	[	{'ILLEGIBLE-I'}, 
																{'SEE ADDRESS ON LABEL'}
															],
															copy_Record
														);

			
	export	set_nulls	:=	[	'','-','--','---','PLEASE SEE','SEE ADDRESS LABEL','SEE LABEL','ILLEGIBLE','FOR ADDRESS INFORMATION',
													'.','..','...','SEE ADDRESS BELOW','ILLEGIBLE-I','SEE ADDRESS ON LABEL',
													'DEFAULT NAME','NAME','SEE ADDRESS LABEL ON PACKAGE','SEE ATTACHED','TEST','X',
													'RESIDENCE','N/A','SEE ADDITIONAL ADDRESS LABEL','SEE ADDITIONAL LABEL','XX','SEE ADDRESS',
													'SEE ADDR LABEL','ADDRESS LABEL','BILLED STAMP TRANSACTION','STORE MANAGER','RECIPIENT','STAMP TRANSACTION',
													'RECEIVING','PAYOFF DEPT','ACCOUNTS RECEIVABLE','MANAGER','PERSON IN CHARGE',
													'ACCOUNTS PAYABLE','CUSTOMER SERVICE','GENERAL MANAGER','RECEIVING DEPT.','SEE AIRBILL','CR','CURRENT RESIDENT',
													'RETURNS','ACCOUNTING','FREIGHT CASHIER','PAYROLL','RECEIVING DEPT','XXXX','_','-------','1',
													'COMMANDING OFFICER','CUSTODIAN OF RECORDS','FUNDING','FUNDING DEPT','MAIL ROOM','MAILROOM',
													'PAYMENT PROCESSING','PAYOFF DEPARTMENT','RECEIVING DEPARTMENT','SEE ATTACHED LABEL','SHIPPING','STORES RECEIVING',
													'9999999999','1111111111','5555555555','999-999-99','5550000000','1','1234567890','111-111-11','NOPHONE','N/A',
													'CLERK','DISTRIBUTION','8888888888','NOT GIVEN'
												];

END;