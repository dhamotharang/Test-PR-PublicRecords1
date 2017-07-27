
IMPORT Address, LN_PropertyV2, Risk_Indicators,ut;

EXPORT Functions := MODULE
		
	// Remove the words "TRUST" or "TR" as the first or last word in a name (Req. 3.1-7)
	EXPORT fn_remove_trust(STRING unparsed_name) := 
		FUNCTION
			rec := {STRING name};
			SET OF STRING name_elems := ut.StringSplit( unparsed_name, ' ');
			ds_name_elems := DATASET( name_elems, rec );
	
			last_elem := COUNT(ds_name_elems);
			second_to_last := last_elem - 1;
			
			ds_filt :=
				MAP(
					ds_name_elems[1].name IN ['TRUST','TR']         => ds_name_elems[2..last_elem],
					ds_name_elems[last_elem].name IN ['TRUST','TR'] => ds_name_elems[1..second_to_last],
					ds_name_elems
				);

			reassembled_name := 
				ROLLUP( ds_filt, TRUE, TRANSFORM( rec, SELF.name := LEFT.name + ' ' + RIGHT.name ) );
			
			RETURN reassembled_name[1].name;
		END;
	
	// Determine whether there is enough data in the input record to run it through the service 
	// process. NOTE: we're presuming First-Middle-Last format for the person's name (as opposed
	// to Last-First-Middle). (Req. 3.1-5)
	
	EXPORT fn_determine_sufficient_data(Layouts.batch_in_raw_with_seq le) :=
		FUNCTION
	
			clean_name := Address.CleanPersonFML73( fn_remove_trust(le.owner_name_1) );
			
			name_first  := clean_name[6..25];  
			name_last   := clean_name[46..65];

			has_sufficient_data := 
				((INTEGER)le.tax_year >= 1900 and (INTEGER)le.tax_year <= 2100) AND name_last != '' AND (name_first != '' OR le.owner_ssn_1 != '') AND
				le.street_addr != '' AND ((le.city != '' AND le.state != '') OR le.zip != '');
				
			RETURN has_sufficient_data;
		END;
		
  EXPORT fn_findTerm(STRING inString) := FUNCTION
	       searchString :=  stringlib.StringToUpperCase(inString);
	       found := (stringlib.StringFind(searchString, 'HOMESTEAD',1) > 0) OR
				          (stringlib.StringFind(searchString, 'SENIOR',1) > 0) OR
									(stringlib.StringFind(searchString, 'HEAD OF HOUSEHOLD',1) > 0) OR
									(stringlib.StringFind(searchString, 'LOW INCOME',1) > 0) OR
									(stringlib.StringFind(searchString, 'DISABLED',1) > 0) OR
									(stringlib.StringFind(searchString, 'MISC',1) > 0) OR
									(stringlib.StringFind(searchString, 'PARTIAL EXEMPTION',1) > 0) OR
									(stringlib.StringFind(searchString, 'TAX EXEMPT',1) > 0) OR
									(stringlib.StringFind(searchString, 'VETERAN',1) > 0) OR
									(stringlib.StringFind(searchString, 'WIDOW',1) > 0) OR
									(stringlib.StringFind(searchString, 'WIDOWER',1) > 0) OR
									(stringlib.StringFind(searchString, 'WELFARE',1) > 0) ;
	  RETURN found;
	END;
	
	EXPORT fn_trimAcctno(STRING inAcctno) := FUNCTION
	  trimLength := LENGTH(inAcctno)-2;
	  acctno := inAcctno[1..trimLength];
 	  RETURN acctno;
	END;
	
	EXPORT fn_findCorpWords(STRING inString) := FUNCTION
	  searchString :=  trim(stringlib.stringfilter(stringlib.stringtouppercase(inString),' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))+' ';
	  found := (stringlib.StringFind(searchString, 'LLC ',1) > 0) OR
		         (stringlib.StringFind(searchString, 'CORP ',1) > 0) OR
		 				 (stringlib.StringFind(searchString, 'CORPORATION ',1) > 0) OR
						 (stringlib.StringFind(searchString, 'BANK ',1) > 0) OR
						 (stringlib.StringFind(searchString, 'LLP ',1) > 0) OR
						 (stringlib.StringFind(searchString, 'INC ',1) > 0) OR
						 (stringlib.StringFind(searchString, 'INCORPORATED ',1) > 0);
	  RETURN found;
	END;
	EXPORT fn_addZeroToParcelID(STRING l_ParcelNumber) := FUNCTION
	    parcelID_V2 := LN_PropertyV2.fn_strip_pnum(l_ParcelNumber);
	    parcelIDLen := length(trim(parcelID_V2));
		  addThis := if (parcelIDLen = 0 or parcelID_V2[parcelIDLen] = '0','','0');
		  parcelWZeroAdded := stringlib.StringCleanSpaces(trim(parcelID_V2) + addThis);	
			RETURN parcelWZeroAdded;
	END;
	// FUNCTION to compare 1 input last,first with 2 pairs of last, first using a fuzzy match score of 80 to 100
	// ALSO consider missing names 1 and 2 a match because they don't proof they are not the subject.
	EXPORT fn_names_match(STRING inlast, STRING inFirst,   STRING last1, STRING first1, STRING last2, STRING first2) := FUNCTION
	  name1found := last1 + first1 <> '';
	  name2found := last2 + first2 <> '';
	  matchFound := map(name1found AND ((Risk_Indicators.FnameScore(infirst, first1) BETWEEN 80 AND 100) AND
		                                  (Risk_Indicators.LnameScore(inlast, last1) BETWEEN 80 AND 100)) => TRUE,
                      name2found AND ((Risk_Indicators.FnameScore(infirst, first2) BETWEEN 80 AND 100) AND
		                                   (Risk_Indicators.LnameScore(inlast, last2) BETWEEN 80 AND 100)) => TRUE,		
           						FALSE);
	  RETURN matchFound;
	END;
	//consider missing seller1 and 2 dids as a match since there isnt proof they are not the subject.
	EXPORT fn_dids_match(INTEGER inDID, INTEGER seller1DID, INTEGER seller2DID) := FUNCTION
	    did1found := seller1did > 0;
			did2found := seller2did > 0;
			didMatchFound := map  (did1found and (inDid = seller1DID) => TRUE,
												     did2found and (inDid = seller2DID) => TRUE,
													 	FALSE);
	  RETURN didMatchFound;
	END;
END;
