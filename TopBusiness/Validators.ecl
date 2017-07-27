export Validators := module

	export boolean IsValidPhone(string val) := function
	
		return map(
			val = ''                                          => false,
			(unsigned)val = 0                                 => false,
			length(trim(val)) not in [7,10]                   => false,
			val in [
				'1111111111',
				'2222222222',
				'3333333333',
				'4444444444',
				'5555555555',
				'6666666666',
				'7777777777',
				'8888888888',
				'9999999999',
				'0000000000']                                   => false,
			length(trim(val)) = 10 and val[4..10] in [
				'0000000',
				'1234567']                                      => false,
			length(trim(val)) = 10 and val[7..10] in [
				'9999']                                         => false,
			/* otherwise */ true);
	
	end;

end;
