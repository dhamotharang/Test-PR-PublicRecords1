IMPORT Business_Header, ut, data_services;

//***** CONSTANT
ceiling_for_duplicates := 2000;

//***** BUSINESS HEADER FILE 
fb :=  Business_Header.File_Business_Header_Base_for_keybuild;

//***** PREPARE TO CALL THE NEWER WORDS FUNCTION
pfb2 :=
project(
	fb,
	transform(
		Business_Header_SS.mod_MakeCNameWords.metaphone.inrec,
		self.zip := (string6)left.zip;
		self.__filepos := [],
		self := left;
	)
);

//***** CALL WORDS FUNCTION
words_unfiltered := Business_Header_SS.mod_MakeCNameWords.metaphone.mrecords(pfb2);

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
		data_services.data_location.prefix() + 'thor_data400::key::business_header.CoNameWordsMetaphone_' + business_header_ss.key_version
	);



EXPORT Key_BH_Header_Words_Metaphone := myindex;
