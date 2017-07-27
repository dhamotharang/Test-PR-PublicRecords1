import ut, AutoStandardI, doxie_cbrs, Business_Header, Business_Header_SS, ups_services,
Text_Search;

export FetchI_Hdr_Biz_Metaphone() := 
MODULE

//****** INTERFACE 
export params := 
INTERFACE(
		autoheaderi.LIBIN.FetchI_Hdr_Biz.full
	)
	export boolean DoNameStOnly := true; 
	//if you want to attempt a namest only match regardless of whether you have a zip or city
	
	export boolean TryWordsOutOfOrder := true; 
	//if you want to attempt to match SUPERIOR HONDA when you input HONDA SUPERIOR.  
	//without this, your input words must be found occuring in order
	//only occurs if full word misses.  only matches within city or zip if given.
	//only returns bdids that match > 1 input word
END;

shared indx := Business_Header_SS.Key_BH_Header_Words_Metaphone;

export outrec := record
	indx;
	boolean matched_zip_or_city := false;
	boolean matched_full_input := false;
	unsigned1 num_individual_input_words_matched := 0;
end;

//****** CONSTANTS
messagingOn			:= false;
message_code 		:= 999;//temp.  i dont know what we should use for internal messages.
message_prefix 	:= 'AutoHeaderI.FetchI_Hdr_Biz_Metaphone ';

export records(params in_mod) :=
FUNCTION

	//****** DECLARE SOME INPUT VARIABLES
	string120 temp_company_name_metaphone := AutoStandardI.InterfaceTranslator.company_name_metaphone.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_metaphone.params));
	/*dataset*/ temp_company_name_metaphone_words := AutoStandardI.InterfaceTranslator.cnvf_words_new.val(project(in_mod,AutoStandardI.InterfaceTranslator.cnvf_words_new.params));
	string temp_state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
	derivedZipFromCity := 
		IF(
			in_mod.state <> '' and in_mod.city <> '',  //i am using the input values here, because i really dont want to derive zips from a derived city :)
			ut.ZipsWithinCity(in_mod.state, in_mod.city),
			[]
		);
	set of integer4 temp_bh_zip_value := AutoStandardI.InterfaceTranslator.bh_zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.bh_zip_value.params))
		+ derivedZipFromCity;


	//****** DECIDE WHETHER WE HAVE THE NECESSARY INPUTS
	company_name_matchable 	:= temp_company_name_metaphone <> '';
	state_matchable 				:= temp_state_value <> '';
	zip_matchable						:= 	not( 
																temp_bh_zip_value = [] or 
																(count(temp_bh_zip_value) = 1 and 0 in temp_bh_zip_value)
															);
	matchable 							:= company_name_matchable and 
														 state_matchable;//zip_matchable was intentionally removed

	message_boolean_convert(boolean b) := if(b, 'true', 'false');
	matchability_messages := 
	parallel(
		ut.outputMessage(message_code, message_prefix + 'matchable := ' + message_boolean_convert(matchable)),
		ut.outputMessage(message_code, message_prefix + 'company_name_matchable := ' + message_boolean_convert(company_name_matchable)),
		ut.outputMessage(message_code, message_prefix + 'state_matchable := ' + message_boolean_convert(state_matchable)),
		ut.outputMessage(message_code, message_prefix + 'zip_matchable := ' + message_boolean_convert(zip_matchable))
	);

	indx_read1 := 
	//****** INDEX READ
	project(
		limit(
			indx(
				matchable,
				keyed(temp_company_name_metaphone = metaphone),
				keyed(temp_state_value = state),
				keyed(zip in (set of string6)temp_bh_zip_value OR not zip_matchable) //will attempt namest when zip is not useable
			),
			ut.limits.FETCH_UNKEYED, 
			keyed, 
			skip
		),
		transform(
			outrec,
			self.matched_zip_or_city := true,
			self.matched_full_input := true,
			self := left
		)
	);
	
	indx_read2 := 
	//****** LOOSER INDEX READ WHEN DoNameStOnly
	project(
		limit(
			indx(
				matchable,in_mod.DoNameStOnly,
				keyed(temp_company_name_metaphone = metaphone),
				keyed(temp_state_value = state)
			),
			ut.limits.FETCH_UNKEYED, 
			keyed, 
			skip
		),
		transform(
			outrec,
			self.matched_zip_or_city := false,
			self.matched_full_input := true,
			self := left
		)
	);
	
	words_use0 := temp_company_name_metaphone_words(metaphone <> temp_company_name_metaphone); //filter out the metaphone that i have already tried
	
	//three part SEQUENTIAL plan for getting rid of what i think is some fairly hacky code in the definition of 'words_use' (also less efficient than it could be)
	//1) release the search such that looks both the orig and stem (as seen below) - see RR bug in comments near 10/1
	//2) change and release keybuild such that it only ever builds the stem (and not the orig)
	//3) change the search such that it only ever searches the stem (and not the orig) 
	//when 3 is done, i would expect the only stemming call to be in Business_Header_SS.mod_MakeCNameWords
	words_use :=  
	dedup(
		words_use0 +
		project(
			words_use0,
			transform(
				{words_use0},
				self.word := Text_Search.Stem_Word(left.word),
				self.metaphone := metaphonelib.DMetaPhone1(Text_Search.Stem_Word(left.word))[1..6],
				self := left
			)
		),
		all
	);
	
	pre_indx_read3 := 
	//****** LOOSER INDEX READ WHEN TryIndividualInputWords
	if(
		matchable and in_mod.TryWordsOutOfOrder and ~exists(indx_read1),
		join(
			words_use,
			indx,
			keyed(left.metaphone = right.metaphone) and
			keyed(temp_state_value = right.state) and
			keyed(right.zip in (set of string6)temp_bh_zip_value OR not zip_matchable), //will attempt namest when zip is not useable
			transform(
				outrec,
				self.matched_zip_or_city := true,
				self.matched_full_input := false,
				self.num_individual_input_words_matched := 1,
				self := right
			),
			limit(ut.limits.FETCH_UNKEYED, skip)
		)
	);	
			
	indx_read3 := //see how many words matched the bdid
	rollup(
		dedup(pre_indx_read3, bdid, metaphone, all),  //i dont want to count two separate instances as two unless they are different words
		transform(
			outrec,
			self.num_individual_input_words_matched := left.num_individual_input_words_matched + right.num_individual_input_words_matched,
			self.metaphone := '-multiple-',  //actual metaphone is meaningless since i rolled up two
			self := left
		),
		bdid
	)
	(num_individual_input_words_matched > 1)
	;
	
	best3 := indx_read1 + indx_read2 + indx_read3;
	
	indx_read := 
	dedup(
		sort(
			// if(  // this if() might be a decent loosening option, but it doesnt help my specific cases and i dont want to change too much at once
				// exists(best3),
				// best3,
				// pre_indx_read3 
			// ),
			best3,
			bdid,
			-matched_full_input,  
			-matched_zip_or_city
		),
		bdid
	);
		
			
	
	if(messagingOn, matchability_messages);
	if(messagingOn, ut.outputMessage(message_code, message_prefix + 'records returned indx_read1 := ' + count(indx_read1)));
	if(messagingOn, ut.outputMessage(message_code, message_prefix + 'records returned indx_read2 := ' + count(indx_read2)));
	if(messagingOn, ut.outputMessage(message_code, message_prefix + 'records returned indx_read3 := ' + count(indx_read3)));
	if(messagingOn, ut.outputMessage(message_code, message_prefix + 'records returned := ' + count(indx_read)));
	
	// output(temp_company_name_metaphone, named('temp_company_name_metaphone'));
	// output(temp_state_value, named('temp_state_value'));
	// output(temp_bh_zip_value, named('temp_bh_zip_value'));
	// output(indx_read, named('indx_read'));
	// output(count(indx_read), named('cnt_indx_read'));
	// output(words_use, named('words_use'));
	// output(pre_indx_read3, named('pre_indx_read3'));
	
	return indx_read;

END;

END;