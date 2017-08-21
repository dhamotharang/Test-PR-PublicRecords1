
EXPORT transforms := MODULE

	EXPORT layouts_census.layout_out xfm_redact_results(layouts_census.layout_out l) :=
		TRANSFORM
				redaction := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
			SELF.lname := l.lname;	// no name masking

			SELF.ssn       := l.ssn;
			SELF.dob       := l.dob;
			SELF.dod       := l.dod;
			string dl := TRIM(l.dl_number,LEFT,RIGHT);
			SELF.dl_number := MAP(
													dl = '' => '',
													LENGTH(dl) > 4 => dl[1..LENGTH(dl)-4] + 'XXXX',
													'XXXX');
			SELF := l;
		END;
		
	EXPORT layouts_census.layout_out xfm_redact_results_2014(layouts_census.layout_out l) :=
		TRANSFORM
				redaction := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
			SELF.lname := 
				CASE( LENGTH(TRIM(l.lname)),
					1          => l.lname,
					2          => l.lname[1] + 'X',
					3          => l.lname[1] + 'XX',
					/* default */ (l.lname[1..3] + redaction)[1..LENGTH( TRIM(l.lname,LEFT,RIGHT) )]
				);
			SELF.ssn       := IF( TRIM(l.ssn) != '', 
			                      l.ssn[1..5] + 'XXXX',
														'' );
			SELF.dob       := IF( TRIM(l.dob) != '',
			                      l.dob[1..2] + 'XX' + l.dob[5..8],
														'');
			SELF.dod       := IF( TRIM(l.dod) != '',
			                      l.dod[1..2] + 'XX' + l.dod[5..8],
														'');
			SELF.dl_number := IF( TRIM(l.dl_number) != '',
			                      (l.dl_number[1..LENGTH( TRIM(l.dl_number,LEFT,RIGHT) )-5] + redaction)[1..LENGTH( TRIM(l.dl_number,LEFT,RIGHT) )],
														'');
			SELF := l;
		END;		

END;
