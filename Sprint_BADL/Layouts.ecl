import address;
export Layouts :=
module

	shared max_size := _Dataset().max_record_size;

	export Input :=
	record

		string	account_number;
		string	bdid					;

	end;

	export Temp :=
	record
		
		Input;
		string rtype;

	end;

end;