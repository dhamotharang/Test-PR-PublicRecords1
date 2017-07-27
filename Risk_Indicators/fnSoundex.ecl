export fnSoundex(STRING dl, STRING20 fname) := 
FUNCTION


	UNSIGNED2 sndxMatch1(UNSIGNED2 i, STRING1 letter, STRING1 start) := IF(TRANSFER(letter,UNSIGNED1) >= TRANSFER(start,UNSIGNED1),i + (TRANSFER(letter,UNSIGNED1)-TRANSFER(start,UNSIGNED1))+1,i);



	first3 := fname[3];				//3rd character of first name
	first2 := fname[2];				//2nd character of first name
	first1 := fname[1];				//first character of first name
	//two := fname[1..2];				//first two characters of first name
	firstlen := length(fname);		//length of first name
	drl := dl[5..7];		 		//digits 5-7 of drivers license #
	drlc := (UNSIGNED2)drl;


	ok := MAP(fname[1..3] = 'EDW' and (drlc = 188 or drlc = 189) => 0,
			fname[1..3] = 'ELI' and (drlc = 209 or drlc = 210) => 0,
			fname[1..3] = 'ELL' and (drlc = 213 or drlc = 214) => 0,
			fname[1..3] = 'JAM' and (drlc = 366 or drlc = 367) => 0,
			fname[1..3] = 'JOH' and (drlc = 428 or drlc = 429) => 0,
			fname[1..3] = 'JOS' and (drlc = 440 or drlc = 441) => 0,
			fname[1..3] = 'MAR' and (drlc = 585 or drlc = 586 or drlc = 587) => 0,
			fname[1..3] = 'WIL' and (drlc = 886 or drlc = 887) => 0,
			fname[1..2] = 'HE' and (drlc = 302 or drlc = 303) => 0,
			fname[1..2] = 'RO' and (drlc = 744 or drlc = 745) => 0,
			Stringlib.StringFilterOut(fname,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')<>'' => 9,
			1);
	

	Sndx := IF(ok in [0,9],ok,
	
				CASE(first1,
					'A' => MAP(first2 < 'L' => sndxMatch1(27,first2,'A'),
							 first2 > 'L' => sndxMatch1(65,first2,'M'),
							 first2 = 'L' and firstlen > 2 => sndxMatch1(39,first3,'A'),
							 firstlen = 2 => 39,
							 27),
					'B' => sndxMatch1(80,first2,'A'),	
					'C' => sndxMatch1(107,first2,'A'),
					'D' => sndxMatch1(134,first2,'A'),
					'E' => MAP(first2 < 'D' => sndxMatch1(161,first2,'A'),
							 first2 = 'D' => MAP(firstlen=2 => 165,
											 first3 < 'W' => sndxMatch1(165,first3,'A'),
											 first3 > 'W' => sndxMatch1(189,first3,'X'),
											 0),
							 first2 > 'D' and first2 < 'L' => sndxMatch1(192,first2,'E'),
							 first2 = 'L' => MAP(fname = 'EL' => 200,
											 first3 < 'I' => sndxMatch1(200,first3,'A'),
											 first3 > 'I' and first3 < 'L' => sndxMatch1(210,first3,'J'),
											 first3 > 'L' => sndxMatch1(214,first3,'M'),
											 0),
							 first2 > 'L' => sndxMatch1(228,first2,'M'),
							 0),
					'F' => sndxMatch1(243,first2,'A'),
					'G' => sndxMatch1(270,first2,'A'),
					'H' => MAP(firstlen = 1 => 297,
							 first2 < 'E' => sndxMatch1(297,first2,'A'),
							 first2 > 'E' => sndxMatch1(303,first2,'F'),
							 0),
					'I' => sndxMatch1(325,first2,'A'),
					'J' => MAP(fname = 'J' => 352,
							 fname = 'JA' => 353,
							 first2 = 'A' => MAP(first3 < 'M' => sndxMatch1(353,first3,'A'),
											 first3 > 'M' => sndxMatch1(367,first3,'N'),
											 0),
							 first2 < 'E' => sndxMatch1(380,first2,'B'),
							 first2 = 'E' => IF(firstlen=2,384,sndxMatch1(384,first3,'A')),
							 first2 > 'E' and first2 < 'O' => sndxMatch1(410,first2,'F'),
							 first2 = 'O' => MAP(firstlen=2 => 420,
											 first3 < 'H' => sndxMatch1(420,first3,'A'),
											 first3 > 'H' and first3 < 'S' => sndxMatch1(429,first3,'I'),
											 first3 > 'S' => sndxMatch1(441,first3,'T'),
											 0),
							 first2 > 'O' => sndxMatch1(448,first2,'P'),
							 0),
					'K' => sndxMatch1(460,first2,'A'),
					'L' => MAP(firstlen=1 => 487,
							 first2 < 'E' => sndxMatch1(487,first2,'A'),
							 first2 = 'E' => IF(firstlen>2,sndxMatch1(492,first3,'A'),492),
							 first2 > 'E' and first2 < 'O' => sndxMatch1(518,first2,'F'),
							 first2 = 'O' => IF(firstlen>2,sndxMatch1(528,first3,'A'),528),
							 sndxMatch1(554,first2,'P')),
					'M' => MAP(firstlen=1 => 566,
							 first2 = 'A' => MAP(fname = 'MA' => 567,
											 first3 < 'R' => sndxMatch1(567,first3,'A'),
											 first3 > 'R' => sndxMatch1(587,first3,'S'),
											 0),
							 sndxMatch1(595,first2,'B')),
					'N' => sndxMatch1(621,first2,'A'),
					'O' => sndxMatch1(648,first2,'A'),
					'P' => sndxMatch1(675,first2,'A'),
					'Q' => sndxMatch1(702,first2,'A'),
					'R' => MAP(firstlen=1 => 729,
							 first2 < 'O' => sndxMatch1(729,first2,'A'),
							 first2 > 'O' => sndxMatch1(745,first2,'P'),
							 0),
					'S' => sndxMatch1(757,first2,'A'),
					'T' => sndxMatch1(784,first2,'A'),
					'U' => sndxMatch1(811,first2,'A'),
					'V' => sndxMatch1(838,first2,'A'),
					'W' => MAP(firstlen=1 => 865,
							 first2 < 'I' => sndxMatch1(865,first2,'A'),
							 first2 = 'I' => MAP(fname = 'WI' => 874,
											first3 < 'L' => sndxMatch1(874,first3,'A'),
											first3 > 'L' => sndxMatch1(887,first3,'M'),
											0),
							 sndxMatch1(901,first2,'J')),
					'X' => sndxMatch1(919,first2,'A'),
					'Y' => sndxMatch1(946,first2,'A'),
					'Z' => sndxMatch1(973,first2,'A'),
					9));
					
	ret := MAP(Sndx in [0,9] => Sndx,
			 drlc = Sndx => 0,
			 2);
	
	RETURN (ret);
	
END;