import iesp, Address, Std;

// Given an input name (actually, a t_RightAddressSearchBy block), make sense
// of the values given.
//
// If there are any spaces included in an individual's input name (first,
// middle, or last name fields), the parsed inputs will be re-assembled in
// the unparsed name input (possibly overwriting anything already in the 
// field!).
//
// If the unparsed full name input is not empty (either spaces found, as above
// or it was actualy set as an input value), it will be passed through the
// "fix redirects" function to remove C/O:, "ATTN:" and other variants and
// the name cleaner.  ANY VALUES CREATED BY THIS PROCESS WILL OVERWRITE THE
// ORIGINAL PARSED NAME INPUTS.

// If we're searching businesses, the company name is populated through a 
// combination of the first + middle + LastNameOrCompany inputs and a pass
// through FixRedirects.

export mod_Names(iesp.rightaddress.t_RightAddressSearchBy inName) := MODULE

	shared inEntityType := if(inName.EntityType = Constants.TAG_ENTITY_IND OR
														inName.EntityType = Constants.TAG_ENTITY_BIZ OR
														inName.EntityType = Constants.TAG_ENTITY_UNK, inName.EntityType, Constants.TAG_ENTITY_UNK);
	
	shared doIndividual := inEntityType = Constants.TAG_ENTITY_IND OR 
												 inEntityType = Constants.TAG_ENTITY_UNK;
	shared doBusiness := inEntityType = Constants.TAG_ENTITY_BIZ OR 
											 inEntityType = Constants.TAG_ENTITY_UNK;

  // This regex nukes any ATN:, ATTN:, C/O: address redirections.  It may be
	// broken into three parts:
	// 
	//   regex := '\\bAT{1,2}N?:?\\b.+$';
	//   regex := '^.*\\b(I/?)?C/?O:';
	//   regex := '^.*\\b(I/)?C/O:?\\b';
	//
	// The first removes "ATT", "ATT:", "ATN", "ATN:", "ATTN", and "ATTN:".  The
	// second handles CO:, C/O:, ICO:, and I/C/O:, all with a trailing colon.
  // Finally, the third hanldes C/O and I/C/O without a trailing colon.  The
	// difference between the second and third is that we need to be very careful
	// applying this regex to a company term which might contain CO  :)
	SHARED ln_regex := '\\bAT{1,2}N?:?\\b.+$|^.*\\b(I/?)?C/?O:|^.*\\b(I/)?C/O:?\\b';
	export STRING FixRedirect(STRING s) := TRIM(RegexReplace(ln_regex, s, ''), left, right);

	// Last name cleaning removes ATTN:* and *C/O:
	SHARED inLastNameOrCompany := std.str.toUpperCase(TRIM(inName.LastNameOrCompany));
	// SHARED fixedLastNameOrCompany := FixRedirect(inLastNameOrCompany);

	SHARED inUnparsedFullName := TRIM(inName.Name.Full);
	SHARED inLastName := inLastNameOrCompany;
	SHARED inFirstName := TRIM(inName.Name.First);
	SHARED inMiddleName := TRIM(inName.Name.Middle);
	SHARED inCompanyName := inLastnameOrCompany;

	BOOLEAN hasFirst := inFirstName <> '';
	BOOLEAN hasMiddle := inMiddleName <> '';

	SHARED tmpCompanyName := 
		MAP(hasFirst AND hasMiddle => inFirstName + ' ' + inMiddleName + ' ' + inCompanyname,
				hasFirst AND NOT hasMiddle => inFirstName + ' ' + inCompanyName,
				 NOT hasFirst AND hasMiddle => inMiddleName + ' ' + inCompanyName,
				 inCompanyName);
	shared outCompanyName := if(doBusiness, TRIM(fn_Translate(FixRedirect(tmpCompanyName))), '');

	boolean isMoreThanOneWord(string s) := length(trim(s,left,right)) > length(trim(s, all));

	shared string unparsedFullName := map(
		inUnparsedFullName <> '' => inUnparsedFullName,
		isMoreThanOneWord(inFirstName) OR 
			isMoreThanOneWord(inMiddleName) OR 
			isMoreThanOneWord(inLastName) => inFirstName + ' ' + inMiddleName + ' ' + inLastName,
		'');

	shared string fixedFullName := if(unparsedFullName <> '', FixRedirect(unparsedFullName), '');
	shared string clnFullName := if (fixedFullName <> '', Address.CleanPersonFML73(fixedFullName), '');

	shared BOOLEAN useCleanName := clnFullName <> '';

	shared clnFirst := TRIM(clnFullName[6..25]);
	shared clnMiddle := TRIM(clnFullName[26..45]);
	shared clnLast := TRIM(clnFullName[46..70]);

	shared outLastName := MAP(doIndividual AND useCleanName AND clnLast <> '' => clnLast,
														doIndividual AND NOT useCleanName AND inLastName <> '' => inLastName,
														'');
	shared outFirstName := MAP(doIndividual AND useCleanName AND clnFirst <> '' => clnFirst,
														 doIndividual AND NOT useCleanName AND inFirstName <> '' => inFirstName,
														 '');
	shared outMiddleName := MAP(doIndividual AND useCleanName AND clnMiddle <> '' => clnMiddle,
															doIndividual AND NOT useCleanName AND inMiddleName <> '' => inMiddleName,
															'');

	export iesp.share.t_NameAndCompany bestparser() := FUNCTION		
	
   return iesp.ECL2ESP.SetNameAndCompany(
		first := outFirstName, 
		middle := outMiddleName, 
		last := outLastName, 
		suffix := '', 
    prefix := '', 
		full := '', 
		company := outCompanyName);
	
	END;

END;