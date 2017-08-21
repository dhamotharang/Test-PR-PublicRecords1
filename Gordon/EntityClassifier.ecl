import Address,Business_Header,Business_Header_ss,Doxie,doxie_cbrs,fsm,Header_Services,Text,ut,Watchdog, Risk_Indicators, VIN, doxie_files, Gordon;

// Temporary fix for ERROR:  (0, 0): 100 Dataset '' is not active
#option ('commonUpChildGraphs', false)

export EntityClassifier(DATASET(Gordon.DocContentsRecord) indata) := FUNCTION

set of string in_categories_raw := all : stored('Categories');
unsigned in_format := 0 : stored('Format');

boolean nocat := in_categories_raw = [];
set of string in_categories := in_categories_raw; //if (in_categories_raw = [], all, in_categories_raw);


entity :=
  record
	  string orig := '';
		unsigned4 docId;
		unsigned4 pos;
	end;

// The general idea is 6 phases:
// PARSE phase will generate a crude list of possible entity labels
// SCORE phase will determine the likelihood of it being a genuine label
// RECLASSIFY phase will reassign additional match types to common patterns
// FILTER phase will get rid of ones we don't want
// DEDUP phase will get rid of overhanging and possibly overlapping ones
// ENRICH phase will gather additional information

// This is the PARSE phase
				 
PATTERN IndiPattern := ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday',
					      'January', 'February', 'March', 'April', 'May', 'June', 
					      'July', 'August', 'September', 'October', 'November', 'December'];

PATTERN front		:= ANY NOT IN PATTERN('^[a-zA-Z0-9]') | FIRST;
PATTERN back 		:= ANY NOT IN PATTERN('^[a-zA-Z0-9]') | LAST;
PATTERN ws := text.ws;
PATTERN wsc := ws | (OPT(ws) ',' OPT(ws));
PATTERN zip := text.digit*5 OPT('-' text.Digit*4);
PATTERN state := text.state;
PATTERN word := text.word;

// Various forms of address line 2

PATTERN addr2a := word wsc state wsc zip?;
PATTERN addr2b := word ws word wsc state wsc zip?;
PATTERN addr2c := word ws word ws word wsc state wsc zip?;

pattern addr1 := (text.digit*2 ANY* Length(1..50)) NOT AFTER text.Digit;

PATTERN possibleaddressA := addr1 addr2a;
PATTERN possibleaddressB := addr1 addr2b;
PATTERN possibleaddressC := addr1 addr2c;

PATTERN possibleaddress := possibleaddressA | possibleaddressB | possibleaddressC;

PATTERN Countries := NOCASE(Text.Countries) not in ['us','Us'];
PATTERN States := NOCASE(text.State) not in ['or','Or','in','In','co','Co','me',
'Me','oh','Oh','ok','Ok','id','Id','hi','Hi'];

PATTERN url := NOCASE(text.url) | NOCASE(text.domain_name);

PATTERN entityLabel := ((((
					(text.Name) | 
					(text.Name_Reverse) |
					(text.BusinessName) |
					(IndiPattern penalty(2)) |
					//(Text.last_name penalty(3)) | 
					(Text.PhoneNumber) |
					(Text.ssn) |
					(url) |
					(possibleAddress) |
					(text.email) |
					(States) |
					(Countries) |
					(text.Date) |
					(Text.VIN) |
					(Text.fein)) LENGTH(1..150)) AFTER FRONT) BEFORE BACK) |
					(Text.Federal_Docket_Number);
				
Matches := 
	record
		STRING150 	parsed	:= MATCHTEXT(entityLabel);
		UNSIGNED  	pos 		:= MATCHPOSITION(entityLabel);
        UNSIGNED  	len		  := MATCHLENGTH(entityLabel);
		INTEGER   	docID		:= inData.docId;
		unsigned1   matchType   := MAP (
										MATCHED(Text.name) => 0,
										MATCHED(IndiPattern) => 6,
										MATCHED(Text.ssn) => 1,
										MATCHED(url) => 2,
										MATCHED(Text.phoneNumber) => 3,
										MATCHED(Text.email) => 4,
										MATCHED(possibleAddress)  => 5,
										MATCHED(Text.BusinessName) => 7,
										// matchType=8 reserved for Cities
										MATCHED(States) => 9,
										MATCHED(Countries) => 10,
										MATCHED(Text.VIN) => 11,
										MATCHED(Text.fein) => 12,
										MATCHED(Text.Federal_Docket_Number) => 13,
										MATCHED(Text.Date) => 14,
										MATCHED(Text.Name_Reverse) => 15,
										16);
		unsigned score := 0;
		unsigned1 isCompany := 0;
		unsigned1 isPerson := 0;
		unsigned1 isCity := 0;
		boolean verifiedCompany := FALSE;
		boolean verifiedPerson := FALSE;
		boolean VinValid := FALSE;
		boolean VinVerified := FALSE;
	    string60 VinManufacturer := '';
	    string60 VinModel := '';
	    string4 VinYear := '';
		string ParseTokens := '';
	end;

parsed := dedup(sort(PARSE(GROUP(inData, docId), docContents, entityLabel, Matches, MANY, SCAN ALL), pos, len));

Matches_Temp := record
  string150 classify_input;
  Matches;
end;

string FixReverseName(STRING name) := FUNCTION
	string73 cleanedName := Address.CleanPerson73(name);
		fname_value := cleanedName[6..25];
		mname_value := cleanedName[26..45];
		lname_value := cleanedName[46..65];
		suffix_value := cleanedName[66..70];
		
		name_fixed := StringLib.StringCleanSpaces(trim(fname_value) + ' ' + trim(mname_value) + ' ' + trim(lname_value) + ' ' + trim(suffix_value));

        return name_fixed;
  END;

// Remove any nickname in parenthesis
RemoveNickname(string name) := FUNCTION

  unsigned1 paren_start := stringlib.StringFind(name, '(', 1);
  unsigned1 paren_end := stringlib.StringFind(name, ')', 1);
  string fixed_name := if(paren_start > 0 and paren_end > 0,
                          name[1..(paren_start-1)] + name[(paren_end+1)..],
						  name);
  
  return fixed_name;
END;

// Clean up possessive names and trailing punctuation, create input for classify
Matches_Temp FixPossessive(Matches l) := transform
    boolean possessive := l.matchType in [0,7] and length(trim(l.parsed)) > 2 and
	                          stringlib.stringtouppercase(l.parsed)[(length(trim(l.parsed))-1)..] in ['\'S','\'s'];
	boolean punctuation_only := l.matchType in [0,5,7] and stringlib.stringtouppercase(l.parsed)[length(trim(l.parsed))..] in ['\'','.',',',':',';','?','!','-'] and
	                            // Exclude possible company abbreviations
	                            not (l.matchType = 7 and length(trim(Stringlib.StringFilter(l.parsed, '.'))) > 1);

	self.parsed := map(possessive => l.parsed[1..(length(trim(l.parsed))-2)],
	                   punctuation_only => l.parsed[1..(length(trim(l.parsed))-1)],
			           l.parsed);
	self.len := map(possessive => length(l.parsed[1..(length(trim(l.parsed))-2)]),
	                punctuation_only => length(l.parsed[1..(length(trim(l.parsed))-1)]),
			        l.len);
	self.classify_input := if(l.matchType = 15, FixReverseName(self.parsed), RemoveNickname(stringlib.stringtouppercase(fsm.cl(self.parsed))));
	self := l;
end;

parsed_fixed := dedup(sort(project(parsed, FixPossessive(left)), pos, len));

// Classify person and business match types
layout_classify := record
        unsigned1   matchType;
		string150   classify_input;
		unsigned1 isCompany := 0;
		unsigned1 isPerson := 0;
		unsigned1 isCity := 0;
		boolean verifiedCompany := FALSE;
		boolean verifiedPerson := FALSE;
		string ParseTokens := '';
end;

classify_init := dedup(sort(project(group(parsed_fixed)(matchType in [0,7,15]), layout_classify), classify_input), classify_input);

layout_classify ClassifyCandidates(layout_classify L) := transform

        ClassificationInfo := fsm.Classify(L.classify_input, false).result[1];
		SELF.isCompany := ClassificationInfo.isCompany;
		SELF.isPerson := ClassificationInfo.isPerson;
		SELF.isCity := ClassificationInfo.isCity;
		SELF.VerifiedCompany := ClassificationInfo.VerifiedCompany;
		SELF.VerifiedPerson := ClassificationInfo.VerifiedPerson;
		SELF.ParseTokens := ClassificationInfo.ParseTokens;
		SELF := L;
end;  
						  
classified := project(classify_init, ClassifyCandidates(left));

// combine classification information
parsed_fixed_classified := join(parsed_fixed,
                                classified,
							    left.classify_input = right.classify_input,
							    transform(Matches,
							             self.parsed := left.parsed,
										 self.matchType := left.matchType,
							             self := right,
							             self := left),
							    left outer);

// Phase 2 - score all possibles
// MORE - we get some info about the entity back for free as a side effect of scoring - should find a way to keep it

scoreName(STRING name) := FUNCTION
		string73 cleanedName := Address.CleanPerson73(name);
		unsigned1 cn := (unsigned1) cleanedName[71..73];
		return cn;
  END;

scoreBusinessName(STRING name) := FUNCTION
		string120 cleanedCompanyName := datalib.CompanyClean(name);
        string73 cleanedName := Address.CleanPerson73(name);
        unsigned1 cn := (unsigned1) cleanedName[71..73];

		unsigned1 cls := map(cleanedCompanyName[41..120] <> '' and cn < 85 => 100,
		                     cleanedCompanyName[41..120] <> '' and cn >= 85 => 50,
				             0);
							 
		return cls;
  END;
	
scoreSSN(STRING ssn) := FUNCTION
		// MORE - we can look at issue info, check if it's in header, etc etc
		return 100;
  END;

scoreFEIN(STRING fein) := FUNCTION
		// MORE - we can look at issue info, check if it's in header, etc etc
		return 100;
  END;

scoreURL(STRING url) := FUNCTION
		// MORE - dns lookup?
		return 100;
  END;

scorePhone(STRING phone) := FUNCTION
		// MORE - check valid npa-nxx, look it up in reverse EDA, etc etc
		return 100;
  END;

scoreEmail(STRING email) := FUNCTION
		// MORE - ping the mailserver or at least dns lookup, check against some known bad ones, look it up, etc
		return 100;
  END;

scoreVIN(boolean valid, boolean verified) := FUNCTION
		// MORE - ping the mailserver or at least dns lookup, check against some known bad ones, look it up, etc
		return map(valid and verified => 100,
		           valid or verified => 50,
				   0);
  END;

scoreAddress(STRING addr) := FUNCTION
		return 100;
 END;

	  
Dummy_VinVerifyResponse := dataset([{'','','','','',0,false,false,false,false}],
                          VIN.Layout_Vin_Info);

Matches scoreCandidates(Matches L) := TRANSFORM

		VinInfo := if(L.matchType = 11, VIN.VerifyVin(L.parsed),
		                                Dummy_VinVerifyResponse)[1];

		SELF.VinValid := VinInfo.Valid;
		SELF.VinVerified := VinInfo.Verified;
	    SELF.VinManufacturer := VinInfo.Manufacturer;
	    SELF.VinModel := VinInfo.Model;
	    SELF.VinYear := if(VinInfo.Year <> 0, intformat(VinInfo.Year, 4,1), '');
		SELF.score := CASE(L.matchtype,
										0 =>  scoreName(RemoveNickname(L.parsed)),
										1 =>  scoreSSN(L.parsed),
										2 =>  scoreURL(L.parsed),
										3 =>  scorePhone(L.parsed),
										4 =>  scoreEmail(L.parsed),
										5 =>  scoreAddress(L.parsed),
										6 =>  SKIP,
										7 =>  scoreBusinessName(L.parsed),
										9 =>  100,
										10 => 100,
										11 => scoreVIN(SELF.VinValid, SELF.VinVerified),
										12 => scoreFEIN(L.parsed),
										13 => 100,
										14 => 100,
										15 => scoreName(L.parsed),
										SKIP);
		SELF := L;
	END;

scored := project(parsed_fixed_classified, scoreCandidates(LEFT));

// Phase 3 - reclassify
// This phase reclassifies entities based on classification information
// City names are parsed as business names, but must be reclassified
reclassify_city := project(scored(matchType=7, /* ParseTokens[1] in ['D','d'], */ isCity >= 50),
                             transform(Matches,
							           self.matchType := 8; // Create City matchType record
									   self := left));
									   
reclassify_reverse_names := project(scored(matchType=15),
                             transform(Matches,
							           self.matchType := 0; // Reclassify reverse person names
									   self := left));
									   
reclassified := scored(matchType <> 15) + reclassify_city + reclassify_reverse_names;

// Phase 4 - filter
// MORE - configurable, possibly by entity type...

filtered := reclassified((matchType = 0 and (isPerson >= 50 or parseTokens in ['Il','IIl'] or verifiedPerson) and score >= 85) or
                   // Filter companies using parseTokens for now until verification and enhance can be improved
				   // City names are assumed to be business names as well
                   (matchType = 7 and ParseTokens[1] in ['C','D','d','V'] and (isCompany >= 50 or verifiedCompany or isCity >= 50 or score >= 50)) or
				   (matchType = 8 and /* ParseTokens[1] in ['D','d'] and */ isCity >= 50) or
				   (matchType not in [0, 7, 8] and score >= 50));

// Cities list for address entity verification
cities := dedup(group(filtered(matchType = 8)),
                        left.docID = right.docID and
						left.len >= right.len and
						left.pos <= right.pos and
                        (right.pos + right.len) <= (left.pos + left.len), ALL);

layout_city_name := record
string city_name;
end;

city_names := project(cities,
                      transform(layout_city_name,
					            self.city_name := stringlib.stringtouppercase(fsm.cl(trim(left.parsed)))));

set_city_names := set(city_names, city_name);

set_day_names := ['MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY'];

set_month_names := ['JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER'];
			   
// Phase 5 - dedup
// MORE - get clever with removing overhanging entities by selecting the one with the highest score
// Scoring needs to be refined before it can be used

found := group(sort(dedup(group(filtered),
                        left.docID = right.docID and
						left.len >= right.len and
						left.pos <= right.pos and
						// dedup partial matches of same matchType
						(((left.matchType = right.matchType or
						// dedup any match type from within email, city, state, phone numbers, dates, and country names
						  left.matchType in [3,4,8,9,10,14] or
						// dedup businesses,person, dates and dockets from address patterns, allow cities, states, and countries
						  (left.matchType = 5 and right.matchType in [0,7,13,14]) or
						// dedup cities, states, and countries from within person names),
						  (left.matchType = 0 and right.matchType in [8,9,10] and left.pos < right.pos))
						    and (right.pos + right.len) <= (left.pos + left.len))
						 or
						// dedup businesses from within person names
						 (left.matchType = 0 and right.matchType = 7 and
						   ((right.pos + right.len) < (left.pos + left.len) or (left.pos < right.pos and (right.pos + right.len) <= (left.pos + left.len))))),
						ALL),docID,pos,len),docID);
						
// Phase 6 - validate

entity extract_person(found L) := 
  TRANSFORM
		string73 cleanedName := Address.CleanPerson73(RemoveNickname(L.parsed));
		cn := cleanedName[71..73];
        string20 clean_fname := cleanedName[6..25];
        string20 clean_lname := cleanedName[46..65];
        string20 clean_mname := cleanedName[26..45];

		// Special check to filter out person names that look like city,state or day of week, month
		// Special check to filter out person names that look like city,state or day of week, month
		flg := ((clean_lname in set_city_names and (clean_fname in ut.Set_State_Abbrev or clean_fname in ut.Set_State_Names or
		                                          (trim(clean_fname)+trim(clean_mname)) in ut.Set_State_Abbrev or
												  clean_fname in set_month_names))
				or
				((clean_lname in set_day_names or clean_lname in ut.Set_State_Names) and clean_fname in set_month_names));
		
		ok := not flg and (L.verifiedPerson or L.isPerson >= 90);

		self.orig  := IF((unsigned)cn < 85 OR NOT ok, SKIP, L.parsed);
		self.docId := L.docId;
		self.pos := L.pos;
  END;

entity extract_business(found L) := 
  TRANSFORM
		string81 cleanCompanyName := ut.CleanCompany(L.parsed);

		ok := L.verifiedCompany or EXISTS(Business_Header_SS.Key_BH_CompanyName_Unlimited(
			KEYED(clean_company_name20=cleanCompanyName[1..20]),
			KEYED(clean_company_name60=cleanCompanyName[21..80])) 
		   );

		self.orig := IF(ok, L.parsed, SKIP);
		self.docId := L.docId;
		self.pos := L.pos;
  END;

StripExtension(string phone) := FUNCTION
extpos := map(Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'EXT', 1) > 0 =>  
                Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'EXT', 1),
			  Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'X', 1) > 0 =>
			    Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'X', 1),
			  0);
			  
  return if(extpos > 0, trim(phone[1..(extpos -1)]), trim(phone));
END;

entity extract_phone(found L) := 
  TRANSFORM
	string10 clean_phone := Address.CleanPhone(StripExtension(L.parsed));
		ok := clean_phone[1..3] in ['800','866','877','888'] or EXISTS(Risk_Indicators.Key_Telcordia_tds(
		    KEYED(npa=clean_phone[1..3]),
			KEYED(nxx=clean_phone[4..6]))
		   );
		self.orig := IF(ok, L.parsed, SKIP);
		self.docId := L.docId;
		self.pos := L.pos;
  END;

entity extract_ssn(found L) := 
  TRANSFORM
	string9	clean_ssn := StringLib.stringFilter(L.parsed, '0123456789');
		ok := EXISTS(doxie.Key_Header_SSN(
            keyed(s1=clean_ssn[1]),
			keyed(s2=clean_ssn[2]),
			keyed(s3=clean_ssn[3]),
			keyed(s4=clean_ssn[4]),
			keyed(s5=clean_ssn[5]),
			keyed(s6=clean_ssn[6]),
			keyed(s7=clean_ssn[7]),
			keyed(s8=clean_ssn[8]),
			keyed(s9=clean_ssn[9]))
		   );
		self.orig := IF(ok, L.parsed, SKIP);
		self.docId := L.docId;
		self.pos := L.pos;
  END;
  
entity extract_fein(found L) := 
  TRANSFORM
	string9	clean_fein := StringLib.stringFilter(L.parsed, '0123456789');
		ok := EXISTS(Business_Header_SS.Key_BH_FEIN(KEYED(fein=(unsigned6)clean_fein)));
		self.orig := IF(ok, L.parsed, SKIP);
		self.docId := L.docId;
		self.pos := L.pos;
  END;

entity extract_address(found L) := 
  TRANSFORM
        layout_city_position := record
          string city_name := '';
		  unsigned city_pos := 0;
          unsigned position := 0;
        end;
		
        city_info := sort(join(dataset(L), cities,
		                      left.docID = right.docID and
						      left.len >= right.len and
						      left.pos <= right.pos and
                              (right.pos + right.len) <= (left.pos + left.len),
							  transform(layout_city_position,
							            self.position := right.pos - left.pos,
										self.city_name := right.parsed,
										self.city_pos := right.pos)), -city_pos);
										
        splitpoint := if(count(city_info) = 0, skip, city_info[1].position);
		
		clean := Address.CleanAddress182(L.parsed[..(splitpoint-1)], L.parsed[(splitpoint+1)..]);

		prim_range := clean[1..10];
		predir := clean[11..12];
		prim_name := clean[13..40];
		addr_suffix := clean[41..44];			// If using USPS Standard Suffixes char suffix[4] is OK.
		postdir := clean[45..46];
		unit_desig := clean[47..56];
		sec_range := clean[57..64];
		p_city_name := clean[65..89];
		v_city_name := clean[90..114];
		st := clean[115..116];
		zip5 := clean[117..121];
		zip4 := clean[122..125];

        self.orig := IF (clean[179] = 'E', SKIP, L.parsed);
		self.docId := L.docId;
		self.pos := L.pos;
  END;

entity extract_url(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;
  
entity extract_email(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;
   
entity extract_city(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;

entity extract_state(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;

entity extract_country(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;

entity extract_vehicle(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;

entity extract_docket(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;

entity extract_date(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;
  
//output(indata, named('input'), all);
//output(parsed_fixed, named('parsed'), all);
//output(parsed_fixed_classified, named('classified'), all);
//output(scored, named('scored'), all);
//output(filtered, named('filtered'), all);
//output(found, named('found'), all);

output(if (nocat OR 'person' in in_categories, PROJECT(found(matchType = 0), extract_person(LEFT))), named('person'));
output(if (nocat OR 'phone' in in_categories, PROJECT(found(matchType = 3), extract_phone(LEFT))), named('phone'));
output(if (nocat OR 'ssn' in in_categories, PROJECT(found(matchType = 1), extract_ssn(LEFT))), named('ssn'));
output(if (nocat OR 'business' in in_categories, PROJECT(found(matchType = 7), extract_business(LEFT))), named('business'));
output(if (nocat OR 'address' in in_categories, PROJECT(found(matchType = 5), extract_address(LEFT))), named('address'));
output(if (nocat OR 'url' in in_categories, PROJECT(found(matchType = 2), extract_url(LEFT))), named('url'));
output(if (nocat OR 'email' in in_categories, PROJECT(found(matchType = 4), extract_email(LEFT))), named('email'));
output(if (nocat OR 'city' in in_categories, PROJECT(found(matchType = 8), extract_city(LEFT))), named('city'));
output(if (nocat OR 'state' in in_categories, PROJECT(found(matchType = 9), extract_state(LEFT))), named('state'));
output(if (nocat OR 'country' in in_categories, PROJECT(found(matchType = 10), extract_country(LEFT))), named('country'));
output(if (nocat OR 'vehicle' in in_categories, PROJECT(found(matchType = 11), extract_vehicle(LEFT))), named('vehicle'));
output(if (nocat OR 'fein' in in_categories, PROJECT(found(matchType = 12), extract_fein(LEFT))), named('fein'));
output(if (nocat OR 'docket' in in_categories, PROJECT(found(matchType = 13), extract_docket(LEFT))), named('docket'));
output(if (nocat OR 'date' in in_categories, PROJECT(found(matchType = 14), extract_date(LEFT))), named('date'));


	return count(found);
END;