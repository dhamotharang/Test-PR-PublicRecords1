export Macro_CleanCompanyName(inds,incn,inccn,outds) := macro

	import TopBusiness;
	
	#uniquename(temprec);
	%temprec% := recordof(inds);
	
	// Combine the new BEID records with all others
	#uniquename(standardizecn);
	%standardizecn% := project(inds,
		transform(%temprec%,
			// UPPERCASE
			temp_uppercase := stringlib.StringToUpperCase(left.incn);
			// FILTER BAD CHARACTERS
			temp_filter := regexreplace('[^A-Z0-9&\' ]',temp_uppercase,' ');
			// ADD SPACE BEFORE/AFTER NUMERALS
			temp_numbers := regexreplace('[0-9]+',temp_filter,' $0 ');
			// REMOVE DOUBLE SPACES
			temp_spaces := stringlib.StringCleanSpaces(temp_numbers);
			// STANDARDIZE A B C = ABC
			self.inccn := temp_spaces,
			self := left));
	
	// Normalize for different possessive values -- JOE'S => JOES, JOE'S => JOE S, JOE'S => JOE
	#uniquename(dopossessives);
	%dopossessives% := %standardizecn%(stringlib.stringfind(inccn,'\'S ',1) = 0) +
		normalize(%standardizecn%(stringlib.stringfind(inccn,'\'S ',1) > 0),
			3,
			transform(%temprec%,
				self.inccn := choose(counter,
					regexreplace('([A-Z]+)[ ]?\'(S) ',left.inccn,'$1$2 '),
					regexreplace('([A-Z]+)[ ]?\'(S) ',left.inccn,'$1 $2 '),
					regexreplace('([A-Z]+)[ ]?\'(S) ',left.inccn,'$1 ')),
				self := left));
	
	#uniquename(dopluralpossessives);
	%dopluralpossessives% := %dopossessives%(stringlib.stringfind(inccn,'S\' ',1) = 0) +
		normalize(%dopossessives%(stringlib.stringfind(inccn,'S\' ',1) > 0),
			2,
			transform(%temprec%,
				self.inccn := choose(counter,
					regexreplace('([A-Z]+)(S)\' ',left.inccn,'$1$2 '),
					regexreplace('([A-Z]+)(S)\' ',left.inccn,'$1 ')),
				self := left));
	
	// Normalize out A B C => ABC
	#uniquename(whitespace);
	%whitespace% :=
		normalize(%dopluralpossessives%,if(regexfind('(?<=[ ][A-Z0-9])[ ]([A-Z0-9])(?=[ ])',left.inccn + ' '),2,1),transform(%temprec%,
			self.inccn := choose(counter,
				left.inccn,
				trim(regexreplace('(?<=[ ][A-Z0-9])[ ]([A-Z0-9])(?=[ ])',left.inccn + ' ','$1'))),
			self := left));
		
	#uniquename(uniquecompanynames);
	%uniquecompanynames% := dedup(table(%whitespace%,{inccn,string120 repl_phrase := inccn}),inccn,all); // remove distribute 20110511
	
	#uniquename(phrasesreplaced);
	%phrasesreplaced% := TopBusiness.Function_Phrase_Replace(
		project(%uniquecompanynames%,
			transform({string120 clean_company_name;string120 repl_phrase;},
				self.clean_company_name := left.inccn,
				self := left)))(repl_phrase != '');
	
	#uniquename(suffixesremoved);
	%suffixesremoved% := TopBusiness.Function_RemoveSuffixes(%phrasesreplaced%)(repl_phrase != '');
	
	#uniquename(namesalphabetized);
	%namesalphabetized% := TopBusiness.Function_AlphabetizeWithinName(%suffixesremoved%)(repl_phrase != ''); /* get alphabetized, PLUS parsed */
	
	outds := join(
		distribute(%whitespace%(inccn != ''),hash64(inccn)),
		distribute(%namesalphabetized%,hash64(clean_company_name)),
		left.inccn = right.clean_company_name,
		transform(%temprec%,
			self.inccn := right.repl_phrase,
			self := left),
		local) + %whitespace%(inccn = '');

endmacro;