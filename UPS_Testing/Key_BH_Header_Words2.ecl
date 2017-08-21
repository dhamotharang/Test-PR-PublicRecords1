IMPORT Business_Header, ut, business_header_ss;

//***** CONSTANT
ceiling_for_duplicates := 1000;

//***** BUSINESS HEADER FILE
fb := Business_Header.File_Business_Header;

//***** PREPARE TO CALL THE NEWER WORDS FUNCTION
pfb2 :=
project(
	fb,
	transform(
		UPS_Testing.Fn_MakeCNameWords2().inrec,
		self.zip := (string6)left.zip;
		self := left,
		self.__filepos := []
	)
);

//***** CALL WORDS FUNCTION
words_unfiltered := UPS_Testing.Fn_MakeCNameWords2().records(pfb2);

//***** REQUIRE STATE AND ZIP
words_filtered := words_unfiltered(state <> '', zip not in ['','0']);

//***** DROP COMBINATIONS THAT ARE TOO COMMON TO BE USEFUL;
p := words_filtered;

r := record
	p.metaphone;
	p.state;
	p.zip;
	cnt := count(group);
end;

t := table(p, r, metaphone, state, zip);
b := t(cnt > ceiling_for_duplicates);

words := 
	join(
		words_filtered,
		b,
		left.metaphone = right.metaphone and
		left.state = right.state and
		left.zip = right.zip,
		transform(
			recordof(words_filtered),
			self := left
		),
		left only,
		hash
	);
		
//***** DECLARE MY INDEX	
myindex := 
	index(
		dedup(words,metaphone, state, zip, bdid, all),
		{metaphone, state, zip},
		{bdid}, 
		'~thor_data400::cemtemp::key::CNameWords_new3_full'
	);

EXPORT Key_BH_Header_Words2 := myindex;