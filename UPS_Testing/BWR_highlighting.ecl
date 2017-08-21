import ut;

//***** This will find the positions where one input word appears in the value
string find_match_oneword(string i, string v) :=
FUNCTION

	startpos := stringlib.stringfind(v, i, 1);
	endpos := length(trim(i)) + startpos;

	return 
	if(
		i <> '' and v <> '' and startpos > 0,
		(string)startpos + '-' + (string)endpos,
		''
	);

END;

//***** This call find_match_oneword for each word in the input
string find_match(string i, string v) :=
FUNCTION

	// count_input_words := length(trim(i, left, right)) - length(trim(i, all)) + 1; //count of internal spaces + 1  //i think this looks better without using the count
	return 
	trim(
		find_match_oneword(ut.Word(i, 1), v)
		+ ' ' + 
		find_match_oneword(ut.Word(i, 2), v) 
		+ ' ' + 
		find_match_oneword(ut.Word(i, 3), v)
		+ ' ' + 
		find_match_oneword(ut.Word(i, 4), v)
		+ ' ' + 
		find_match_oneword(ut.Word(i, 5), v), //only works if <= 5 words in input field
		left,
		right
	);

END;


/*

THIS IS JUST MY TESTING

*/



//test inputs
input_fname := 'RONALD';
input_lname := 'MASUDA';
input_fullname := 'MASUDA RONALD';
input_prim_range := '509';
input_prim_name := 'GUADALUPE';
input_zip := '94404';
input_addr := '509 GUADALUPE 94404';


//add highlight result fields and remove unwanted fields
inds := UPS_Testing.ds_temp;

ds :=  //just adding fields to contain the highlight info
project(
	inds,
	transform(
		{/*inds.fname, inds.lname, */inds.fullname, string20 highlight_fullname, /*inds.prim_range, inds.prim_name, inds.zip,*/ inds.addr, string20 highlight_addr},
		self := left,
		self := []
	)
);


//call my find_match function
ds_h := 
project(
	ds,
	transform(
		recordof(ds),
		
		//either way works.  
		// self.highlight_fullname := trim(find_match(input_fname, left.fullname) + ' ' + find_match(input_lname, left.fullname), left, right), //call once for each possible combo
		self.highlight_fullname := trim(find_match(input_fullname, left.fullname), left, right), //call once for each possible combo
		
		//either way works.
		self.highlight_addr := trim(find_match(input_prim_range, left.addr)  + ' ' + find_match(input_prim_name, left.addr)  + ' ' + find_match(input_zip, left.addr), left, right), //call once for each possible combo
		// self.highlight_addr := trim(find_match(input_addr, left.addr), left, right), //call once for each possible combo
		self := left
	)
);

output(ds_h, named('ds_h'));

