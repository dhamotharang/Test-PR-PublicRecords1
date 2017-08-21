EXPORT layout_landflipDeedAddlRec
	:=
		RECORD
			string12 addl_ln_fares_id;							//Needed to join on addl_deed
			string3  transfer_type;									//FARES_TRANSACTION_TYPE
			string6  transfer_type_desc;						//Maps to FARES_1080 description fares_transaction_type
			string1  addl_foreclosure_flag;					//Value = 'U' then flag = 'Y'
		END
		;