/* Drivers License Validation Logic - US States and Territories, Canadian Provinces

Drivers License result code definition:
0=valid id number										7=last name failed
1=length of id failed								8=last character failed
2=soundex failed for first name			9=first name failed
3=ssn failed											 10=middle name failed
4=soundex failed for last name		 11=soundex failed for middle name
5=birth date failed								 12=all digits failed
6=first character failed					 13=missing some or all characters in license number field or all characters identical

*/
import NID;

export Validate_DL(STRING2 state, STRING dl_num, STRING20 fname, STRING20 lastname, STRING8 dob, boolean dlmatch, STRING1 socsvalflag, STRING1 dobvalflag) :=
FUNCTION

lname_trim := TRIM(lastname);
lname := lname_trim;	// don't add an X to a 2 byte last name
nickname := NID.PreferredFirstNew(trim(fname));

dl_trim := TRIM(dl_num);
dl_len := LENGTH(dl_trim);

month := dob[5..6];
firstTwo := dl_trim[1..2];

// logic added for washington
lnlength := length(lname_trim);
walname := if(lnlength<5,lname_trim[1..lnlength]+'*****',lname_trim);

// added on 4-25
ssnVerifyValidate(BOOLEAN dlmatch, STRING1 socsval, STRING1 dobval) := MAP(dl_trim<>'' and dlmatch => '0',
														    socsval IN ['0','4','5'] and dobval='0' => '0',
														    '3');


// if a state is added here, please add it to the list of dl validation states in iid_constants
ret := CASE(state,
		'AL'	=>	MAP(dl_len IN [7, 8] AND IsAllNumeric(dl_trim) => '0',
				    dl_len IN [7, 8] AND ~IsAllNumeric(dl_trim) => '12',
				    '1'),
		'AK' =>  	MAP(dl_len<=7 AND IsAllNumeric(dl_trim) => '0',
				    dl_len<=7 AND ~IsAllNumeric(dl_trim) => '12',
				    '1'),
		'AZ' =>  	MAP(dl_len=9 AND IsAllNumeric(dl_trim) => ssnVerifyValidate(dlmatch,socsvalflag,dobvalflag),
				    dl_len=9 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..9]) => '0',
				    dl_len=9 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND ~IsAllNumeric(dl_trim[2..9]) => '12',
				    dl_len=9 => '6',
				    '1'),
		'AR' =>  	MAP(dl_len=9 AND IsAllNumeric(dl_trim[2..9]) AND dl_trim[1]='9' => '0',
				    dl_len=9 => '12',
				    '1'),
		'CA'	=>	MAP(dl_len=8 AND IsAllNumeric(dl_trim[2..8]) AND dl_trim[1]>='A' AND dl_trim[1]<='Z' => '0',
				    dl_len=8 AND IsAllNumeric(dl_trim[2..8]) => '6',
				    dl_len=8 AND ~IsAllNumeric(dl_trim[2..8]) => '12',
				    '1'),
		'CO' =>  	MAP(dl_len=9 AND IsAllNumeric(dl_trim) => '0',
									dl_len=9 AND ~IsAllNumeric(dl_trim) => '12',
									'1'),
		'CT' =>  	MAP(dob='' => '99',
				    dl_len=9 AND IsAllNumeric(dl_trim) AND dob[4] IN ['0','2','4','6','8'] AND ((UNSIGNED1)firstTwo=(UNSIGNED1)month+12) => '0',
				    dl_len=9 AND IsAllNumeric(dl_trim) AND dob[4] IN ['0','2','4','6','8'] => '5',
				    dl_len=9 AND IsAllNumeric(dl_trim)/* AND dob[4] IN ['1','3','5','7','9']*/ AND dl_trim[1..2]=dob[5..6] => '0',
				    dl_len=9 AND IsAllNumeric(dl_trim)/* AND dob[4] IN ['1','3','5','7','9']*/ => '5',
				    dl_len=9 => '12',
				    '1'),
		'DE' =>  	MAP(dl_len<=7 AND IsAllNumeric(dl_trim) => '0',
				    dl_len<=7 AND ~IsAllNumeric(dl_trim) => '12',
				    '1'),
		'DC' =>  	MAP(dl_len=9 AND IsAllNumeric(dl_trim) => ssnVerifyValidate(dlmatch,socsvalflag,dobvalflag),
				    dl_len=7 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=7 AND ~IsAllNumeric(dl_trim) => '12',
				    dl_len=9 => '12',
				    '1'),
		'FL' =>  	MAP(dob='' => '99',
				    dl_len=13 AND IsAllNumeric(dl_trim[13]) AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..12]) AND
															dl_trim[1..4] = lnSoundex(lname) AND dl_trim[8..9] = dob[3..4] => '0',
				    dl_len=13 AND IsAllNumeric(dl_trim[13]) AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..12]) AND
																					dl_trim[1..4] = lnSoundex(lname) => '5',
				    dl_len=13 AND IsAllNumeric(dl_trim[13]) AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..12]) => '4',
				    dl_len=13 AND IsAllNumeric(dl_trim[13]) AND dl_trim[1]>='A' AND dl_trim[1]<='Z' => '12',
				    dl_len=13 AND IsAllNumeric(dl_trim[13]) => '6',
				    dl_len=13 => '12',
				    '1'),
		'GA' =>  	MAP(dl_len<=9 AND IsAllNumeric(dl_trim) => '0',
				    dl_len<=9 => '12',
				    '1'),
		'HI' =>  	MAP(/* dl_len=9 AND IsAllNumeric(dl_trim) => ssnVerifyValidate(dlmatch,socsvalflag,dobvalflag), */
				    dl_len=9 AND dl_trim[1]='H' AND IsAllNumeric(dl_trim[2..9]) => '0',
				    dl_len=9 => '12',
				    '1'),
		'ID' =>  	MAP(dl_len=9 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND dl_trim[2]>='A' AND dl_trim[2]<='Z' AND
								dl_trim[9]>='A' AND dl_trim[9]<='Z' and IsAllNumeric(dl_trim[3..8]) => '0',
				    dl_len=9 => '12',
				    '1'),
		'IL' =>  	MAP(dob='' => '99',
				    dl_len=12 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..12]) AND dl_trim[1..4]=lnSoundex(lname) 
																						AND dl_trim[8..9] = dob[3..4] => '0',
				    dl_len=12 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..12]) AND dl_trim[1..4]=lnSoundex(lname) => '5',
				    dl_len=12 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..12]) => '4',
				    dl_len=12 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' => '12',
				    dl_len=12 => '6',
				    '1'),
		'IN' =>  	MAP(dl_len=10 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=10 => '12',
				    '1'),
		'IA' =>  MAP(dl_len=9 AND dl_trim[4]>='A' AND dl_trim[4]<='Z' AND dl_trim[5]>='A' AND dl_trim[5]<='Z' AND
										IsAllNumeric(dl_trim[1..3]) AND IsAllNumeric(dl_trim[6..9]) => '0',
				    dl_len=9 => '12',
				    '1'),
		'KS' =>  	MAP(/*dl_len=9 AND IsAllNumeric(dl_trim) => ssnVerifyValidate(dlmatch,socsvalflag,dobvalflag), */
				    dl_len=9 AND dl_trim[1]='K' AND IsAllNumeric(dl_trim[2..9]) => '0',
				    dl_len=9 => '12',
				    '1'),
		'KY' =>  	MAP(dl_len=9 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..9]) => '0',
				    dl_len=9 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' => '12',
				    dl_len=9 => '6',
				    '1'),
		'LA' =>  	MAP(dl_trim[1..2] in ['00','01'] AND dl_len=9 AND IsAllNumeric(dl_trim) => '0',
									dl_trim[1..2] in ['00','01'] AND dl_len=9 => '12',	// anything higher than 1 means invalid format, correct length
									dl_len<>9 => '1',	// '1' means either too short or too long
									'12'),
		'ME' =>  	MAP(dl_len=7 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=7 => '12',
				    dl_len=8 AND dl_trim[8]='X' AND IsAllNumeric(dl_trim[1..7]) => '0',
				    dl_len=8 AND dl_trim[8]='X' => '12',
				    dl_len=8 => '8',
				    '1'),
		'MD' =>  	MAP(dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..13]) AND dl_trim[1..4]=lnSoundex(lname)
																			AND fnSoundex(dl_trim,fname)=0 => '0',
				    dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..13]) AND dl_trim[1..4]=lnSoundex(lname) AND
															fnSoundex(dl_trim,fname)=2 => (STRING1)fnSoundex(dl_trim,nickname),
				    dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..13]) AND dl_trim[1..4]=lnSoundex(lname) => (STRING1)fnSoundex(dl_trim,fname),
				    dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..13]) => '4',
				    dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' => '12',
				    dl_len=13 => '6',
				    '1'),
		'MA' =>  	MAP(/*dl_len=9 AND IsAllNumeric(dl_trim) => ssnVerifyValidate(dlmatch,socsvalflag,dobvalflag),*/
            dl_len=9 AND dl_trim[1]='S' AND dl_trim[2]IN ['A','0','1','2','3','4','5','6','7','8','9'] AND IsAllNumeric(dl_trim[3..9]) => '0',
				    dl_len=9 => '12',			    
				    '1'),
		'MI' =>  	MAP(dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..13]) /* AND dl_trim[1..4]=lnSoundex(lname) */
																			AND fnSoundex(dl_trim,fname)=0 => '0',
				    dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..13]) /* AND dl_trim[1..4]=lnSoundex(lname) */ AND
															fnSoundex(dl_trim,fname)=2 => (STRING1)fnSoundex(dl_trim,nickname),
				    // dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..13]) /* AND dl_trim[1..4]=lnSoundex(lname) */ => (STRING1)fnSoundex(dl_trim,fname), // This is the same thing as the line below now
				    dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..13]) => '4',
				    dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' => '12',
				    dl_len=13 => '6',
				    '1'),
		'MN' =>  	MAP(dl_len=13 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..13]) => '0',
						dl_len=13 AND IsAllNumeric(dl_trim) => '6', //can't be all numbers
						dl_len=13 => '12',		//can't all be alpha		   
					 '1'),
		'MS' =>  	MAP(dl_trim[1..3] IN ['000','001','800','801','802','900'] and dl_len=9 and IsAllNumeric(dl_trim) => '0',
					dl_len=9 => '12',
					'1'),
		'MO' =>  	MAP(dl_len between 7 and 10 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..dl_len]) => '0',
				    			dl_len not between 7 and 10 AND dl_num[1]>='A' AND dl_trim[1]<='Z' => '1',
									dl_len<11 => '6',  
									   '1'), 
										 
		'MT' =>  	MAP(dob=''                                => '99',            // DOB is empty
				    dl_len=13 AND IsAllNumeric(dl_trim) 
						          AND dl_trim[1..2]=dob[5..6]                           // digits 1 - 2   = month of birth 
											AND dl_trim[6..9]=dob[1..4]                           // digits 6 - 9   = year of birth 
											AND dl_trim[12..13]=dob[7..8]                         // digits 12 - 13 = day of birth
											AND dl_trim[10..11]='41'          => '0',             // digits 10 - 11 = 41 (the year of Montana statehood)
				    dl_len=13 AND IsAllNumeric(dl_trim) 
						          AND dl_trim[1..2]=dob[5..6]                           // digits 1 - 2    = month of birth
											AND dl_trim[6..9]=dob[1..4]                           // digits 6 - 9    = year of birth
											AND dl_trim[12..13]=dob[7..8]     => '12',            // digits 12 - 13  = day of birth
				    dl_len=13 AND IsAllNumeric(dl_trim)         => '5',             // all 13 digits are numeric 
				    dl_len=13                                   => '12',            // 13 digits were entered
				                                                   '1'),            //  ELSE default to a 1
						
		'NE' =>  	MAP(dl_len<10 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..dl_len]) => '0',
				    dl_len<10 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' => '12',
				    dl_len<10 => '6',
				    '1'),
		'NV' =>  	MAP(dl_len=10 AND IsAllNumeric(dl_trim) => '0',
									dl_len=10 => '12',
									'1'),
		'NH' =>  	MAP(dob='' => '99',
				    dl_len=10 AND dl_trim[1..2]=dob[5..6] AND dl_trim[6..7]=dob[3..4] AND dl_trim[8..9]=dob[7..8] AND
						dl_trim[3]=lname[1] AND dl_trim[4]=lname[LENGTH(lname)] AND dl_trim[5]=fname[1] AND IsAllNumeric(dl_trim[10]) => '0',
				    dl_len=10 AND dl_trim[1..2]=dob[5..6] AND dl_trim[6..7]=dob[3..4] AND dl_trim[8..9]=dob[7..8] AND
						dl_trim[3]=lname[1] AND dl_trim[4]=lname[LENGTH(lname)] AND dl_trim[5]=fname[1] => '8',
				    dl_len=10 AND dl_trim[1..2]=dob[5..6] AND dl_trim[6..7]=dob[3..4] AND dl_trim[8..9]=dob[7..8] AND
						dl_trim[3]=lname[1] AND dl_trim[4]=lname[LENGTH(lname)] => '9',
				    dl_len=10 AND dl_trim[1..2]=dob[5..6] AND dl_trim[6..7]=dob[3..4] AND dl_trim[8..9]=dob[7..8] => '7',
				    dl_len=10 => '5',
						dl_len=11 AND dl_trim[1..2] = 'NH' and dl_trim[3] >= 'A' and dl_trim[3] <= 'Z' and IsAllNumeric(dl_trim[4..11]) => '0',
						dl_len=11 AND dl_trim[1..2] = 'NH' and dl_trim[3] >= 'A' and dl_trim[3] <= 'Z' => '12',
						dl_len=11 => '6',
				    '1'),
		'NJ' =>  	MAP(dob='' => '99',
				    dl_len=15 AND dl_trim[1]=lname[1] AND IsAllNumeric(dl_trim[2..15]) AND dl_trim[13..14]=dob[3..4] AND
			          ((dl_trim[11..12]=dob[5..6]) OR (dob[5..6]<'10' AND dl_trim[11]='5' AND dl_trim[12]=dob[6]) OR (dob[5..6]>'09' AND
																dl_trim[11]='6' AND dl_trim[12]=dob[6])) => '0',
				    dl_len=15 AND dl_trim[1]=lname[1] AND IsAllNumeric(dl_trim[2..15]) => '5',
				    dl_len=15 AND dl_trim[1]=lname[1] => '12',
				    dl_len=15 => '6',
				    '1'),
		'NM' =>  	MAP(dl_len=9 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=9 => '12',
				    '1'),
		'NY' =>  	MAP(dl_len=9 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=9 => '12',
				    '1'),
		'NC' =>  	MAP(dl_len<13 AND IsAllNumeric(dl_trim) => '0',
				    dl_len<13 => '12',
				    '1'),
		'ND' =>  	MAP(dob='' => '99',
				    dl_len=9 AND (IsAllNumeric(dl_trim) OR (lname[1..3]=dl_trim[1..3] AND dl_trim[4..5]=dob[3..4] AND IsAllNumeric(dl_trim[6..9]))) => '0',
				    dl_len=9 AND lname[1..3]=dl_trim[1..3] AND dl_trim[4..5]=dob[3..4] => '12',
				    dl_len=9 AND lname[1..3]=dl_trim[1..3] => '5',
				    dl_len=9 => '7',
				    '1'),
		'OH' =>  	MAP(dl_len=8 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND dl_trim[2]>='A' AND dl_trim[2]<='Z' AND IsAllNumeric(dl_trim[3..8]) => '0',
				    dl_len=8 => '12',
				    '1'),
		'OK' =>  	MAP(
					dl_len=10 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..10]) => '0',
					dl_len in [9,10] => '12',
				    '1'),
		'OR' =>  	MAP(dl_len<=7 AND IsAllNumeric(dl_trim) => '0',
						dl_len=7 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..dl_len]) => '0',
				    dl_len<=7 AND ~IsAllNumeric(dl_trim) => '12',
				    '1'),
		'PA' =>  	MAP(dl_len=8 AND IsAllNumeric(dl_trim) =>'0',
				    dl_len=8 => '12',
				    '1'),
    'RI' =>  	MAP(dl_len=7 AND dl_trim[1] ='3' AND IsAllNumeric(dl_trim)  => '0',
                  dl_len=7 AND dl_trim[1] ='V' AND IsAllNumeric(dl_trim[2..7]) => '0',
                  dl_len=8 AND dl_trim[1] ='4' AND IsAllNumeric(dl_trim) => '0',
                  dl_len=7 OR dl_len=8 => '12',
				    '1'),
		'SC' =>  	MAP(dl_len=9 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=9 => '12',
				    '1'),
		'SD' =>  	MAP(dl_len=8 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=8=> '12',
				    '1'),
		'TN' =>  	MAP((dl_len=8 OR dl_len=9) AND IsAllNumeric(dl_trim) => '0',
				    dl_len=8 OR dl_len=9 => '12',
				    '1'),
		'TX' =>  	MAP(dl_len=8 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=8 => '12',
				    '1'),
		'UT' =>  	MAP(dl_len>=4 AND dl_len<=9 AND IsAllNumeric(dl_trim) => '0',
				    dl_len>=4 AND dl_len<=9 => '12',
				    '1'),
		'VT' =>  	MAP(dl_len=8 AND dl_trim[8]='A' AND IsAllNumeric(dl_trim[1..7]) => '0',
				    dl_len=8 AND dl_trim[8]='A' => '12',
				    dl_len=8 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=8 => '12',
				    '1'),
		'VA' =>  	MAP(dl_len=9 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..9]) => '0',
									dl_len=9 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' => '12',
									dl_len=9 => '6',
									'1'),
		'WA' =>  	MAP(dob='' => '99',
				    (dl_len=12 AND dl_trim[1..5]=walname[1..5] AND dl_trim[6]=fname[1] AND ((dl_trim[7]>='A' AND dl_trim[7]<='Z') OR
						dl_trim[7]='*') AND (INTEGER)(dl_trim[8..9])=(100-(INTEGER)(dob[3..4])) AND (dl_trim[10]='*' OR (dl_trim[10]>='A' AND dl_trim[10]<='Z') OR
						IsAllNumeric(dl_trim[10])) AND (((dl_trim[11]>='A' AND dl_trim[11]<='Z') OR (dl_trim[12]>='A' AND dl_trim[12]<='Z')) OR IsAllNumeric(dl_trim[11])))
            OR (LENGTH(StringLib.StringFilter(StringLib.StringToUpperCase(dl_trim[1..12]), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'))=12 AND dl_trim[1..3]='WDL') => '0',
				    dl_len=12 AND dl_trim[1..5]=walname[1..5] AND dl_trim[6]=fname[1] AND (dl_trim[7]>='A' AND dl_trim[7]<='Z' OR
						dl_trim[7]='*') AND (INTEGER)(dl_trim[8..9])=(100-(INTEGER)(dob[3..4])) => '12',
				    dl_len=12 AND dl_trim[1..5]=walname[1..5] AND dl_trim[6]=fname[1] AND ((dl_trim[7]>='A' AND dl_trim[7]<='Z') OR dl_trim[7]='*') => '5',
				    dl_len=12 AND dl_trim[1..5]=walname[1..5] AND dl_trim[6]=fname[1] => '10',
				    dl_len=12 AND dl_trim[1..5]=walname[1..5] => '9',
				    dl_len=12 => '7',
				    '1'),
		'WI' =>  	MAP(dob='' => '99',
				    dl_trim[1..4]=lnSoundex(lname) AND IsAllNumeric(dl_trim[5..14]) AND dl_trim[8..9]=dob[3..4] => '0',
				    dl_trim[1..4]=lnSoundex(lname) AND IsAllNumeric(dl_trim[5..14]) => '5',
				    dl_trim[1..4]=lnSoundex(lname) => '12',
				    '4'),
		'WV' =>  	MAP(dl_len=7 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=7 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' AND IsAllNumeric(dl_trim[2..7]) => '0',
				    dl_len=7 AND dl_trim[1]>='A' AND dl_trim[1]<='Z' => '12',
				    dl_len=7 => '6',
				    '1'),
		'WY' =>  	MAP(dl_len=9 AND IsAllNumeric(dl_trim) => '0',
				    dl_len=9 => '12',
				    '1'),
		
		// US Territories and Canadian Provinces
		// Alberta
		'AB' => MAP(dl_len <= 9 AND IsAllNumeric(dl_trim[1..9]) => '0',
								'1'),
		
		// Brittish Columbia
    'BC' => MAP(dl_len = 7 AND IsAllNumeric(dl_trim[2..9]) => '0',
								'1'),
		
		// Manitoba
		'MB' => MAP(dl_len=12 AND dl_trim[1..5]=walname[1..5] AND 
									dl_trim[6]=fname[1] AND
									(INTEGER)(dl_trim[8..9])=100-(INTEGER)(dob[3..4]) AND IsAllNumeric(dl_trim[10]) 
									AND dl_trim[11]>='A' AND dl_trim[11]<='Z' AND dl_trim[12]>='A' AND dl_trim[12]<='Z' => '0',
								dl_len!=12 => '1',
								dl_trim[1..5]!=walname[1..5] => '7',
								dl_trim[6]!=fname[1] => '6',
								'5'),
								
		// New Brunswick
		'NB' => MAP(dl_len <= 7 => '0',
								'1'),
								
		// Newfoundland and Labrador
		'NL' => MAP(dl_len = 10 AND dl_trim[1] = lname[1] AND dl_trim[2..3] = dob[3..4] AND dl_trim[4..5] = dob[5..6] AND dl_trim[6..7] = dob[7..8]
									AND IsAllNumeric(dl_trim[8..10]) => '0',
								dl_len != 10 => '1',								 
								dl_trim[2..3] != dob[5..6] OR dl_trim[4..5] != dob[1..2] OR dl_trim[6..7] != dob[3..4] => '5',
								'6'),
								 
		//Nova Scotia
		'NS' => MAP(dl_len = 14 AND dl_trim[1..5] = lname[1..5] AND dl_trim[6..7] = dob[7..8] AND dl_trim[8..9] = dob[5..6] AND
									dl_trim[10..11] = dob[3..4]	=> '0',
								dl_len != 14 => '1',
								dl_trim[1..5] != lname[1..5] => '7',
								'5'),
								
    // Ontario
		'ON' => MAP(dl_len = 15 AND dl_trim[1] = lname[1] AND IsAllNumeric(dl_trim[2..5]) AND 
									dl_trim[10..11] = dob[3..4] AND IsAllNumeric(dob) AND 
									dl_trim[12..13] = dob[5..6] AND IsAllNumeric(dob) AND 
									dl_trim[14..15] =dob[7..8] AND IsAllNumeric(dob) => '0', 
								dl_len != 15 => '1',
								dl_trim[1] != lname[1] => '6',
								'5'),
									
		// Prince Edward Island
		'PE' => MAP(dl_len >= 1 AND dl_len <= 6 AND IsAllNumeric(dl_trim[1..6]) => '0',
								'1'),
								
		// Quebec
		'QC' => MAP(dl_len = 13 AND (dl_trim[1]>='A' AND dl_trim[1]<='Z' AND dl_trim[1] = lname[1]) AND 
									dl_trim[1..4] = lnSoundex(lname+ ', ' + fname) AND
									dl_trim[6..11] = dob[7..8] + dob[5..6] + dob[3..4] AND
									IsAllNumeric(dl_trim[5]) AND
									IsAllNumeric(dl_trim[12]) AND IsAllNumeric(dl_trim[13]) => '0',
								dl_len != 13 => '1',
								(NOT (dl_trim[1]>='A' AND dl_trim[1]<='Z') OR dl_trim[1] != lname[1]) => '6',
								dl_trim[6..11] != dob[3..5] + dob[1..2] + dob[5..6] => '5',
								'12'),
								
		// Saskatchewan
		'SK' => MAP(dl_len = 8 AND IsAllNumeric(dl_trim) => '0',
								dl_len != 8 => '1',
								'12'),
								
		// Northwest Territories
		'NT' => MAP(dl_len = 6 AND IsAllNumeric(dl_trim) AND (INTEGER)dl_trim >= 400000 => '0',
								dl_len != 6 => '1',
								'12'),

		// Yukon
		'YT' => MAP(dl_len >= 1 AND dl_len <= 6 AND IsAllNumeric(dl_trim[1..6]) => '0',
								'1'),
								
		// Nunavut Territory
		'NU' => MAP(dl_len = 6 AND IsAllNumeric(dl_trim[1..6]) => '0',
								'1'),		
								
		// Puerto Rico
		'PR' => MAP(dl_len = 7 AND IsAllNumeric(dl_trim[1..7]) => '0',
								'1'),		
								
		// Guam
		'GU' => MAP(dl_len = 10 AND IsAllNumeric(dl_trim[1..10]) => '0',
								'1'),	

		// Northern Mariana Islands
		'MP' => MAP(dl_len = 7 AND IsAllNumeric(dl_trim[1..7]) => '0',
								'1'),	
								
		// US Virgin Islands
		'VI' => MAP(dl_len = 13 AND IsAllNumeric(dl_trim[2..10]) AND (dl_trim[1]>='A' AND dl_trim[1]<='Z') => '0',
								'1'),	

		'0');  


RETURN (ret /*or dl_len=0*/);

END;