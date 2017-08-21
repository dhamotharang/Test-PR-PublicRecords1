import Address,Business_Header,Business_Header_ss,Doxie,doxie_cbrs,fsm,Header_Services,Text,ut,Watchdog, Risk_Indicators, VIN, doxie_files, Gordon;

// Temporary fix for ERROR:  (0, 0): 100 Dataset '' is not active
#option ('commonUpChildGraphs', false)

export EntityExtractor(DATASET(Gordon.DocContentsRecord) indata) := FUNCTION

set of string in_categories_raw := all : stored('Categories');
unsigned in_format := 0 : stored('Format');
unsigned in_maxDids := 25 : stored('MaxDids');
unsigned in_maxFull := 25 : stored('MaxFull');

maxDids := if (in_maxDids > 100, 100, in_maxDids);
maxFull := if (in_maxFull > maxDids, maxDids, in_maxFull);

boolean nocat := in_categories_raw = [];
set of string in_categories := in_categories_raw; //if (in_categories_raw = [], all, in_categories_raw);

result_score :=
	record
		integer score;
	end;
	
result_address := 
	record(result_score)
		string street :='';
		string city := '';
		string2 st := '';
		string5 zip5 := '';
  end;

result_person := 
	record(result_score)
		string fname :='';
		string lname := '';
		integer did := 0;
		dataset(result_address) addresses { maxcount(1) };
  end;

result_business_association := 
	record(result_score)
		string name :='';
		integer bdid := 0;
		dataset(result_address) addresses { maxcount(1) };
  end;

result_person_business := 
	record(result_score)
		string fname :='';
		string lname := '';
		integer did := 0;
		dataset(result_address) addresses { maxcount(1) };
		dataset(result_business_association) businesses { maxcount(25) };
  end;

result_business := 
	record(result_score)
		string name :='';
		integer bdid := 0;
		dataset(result_address) addresses { maxcount(1) };
		dataset(result_person) people { maxcount(50) };
  end;

entity :=
  record
	  string orig := '';
		unsigned4 docId;
		unsigned4 pos;
	end;

entity_address := 
	record(entity)
	  String182 clean;
		dataset(result_address) addresses { maxcount(1) };
		DATASET(result_person) people { maxcount(100) };
		DATASET(result_business) businesses { maxcount(25) };
  end;

entity_person := 
	record(entity)
	  Address.Layout_Clean_Name clean;
		DATASET(result_person_business) people { maxcount(100) };
  end;

entity_ssn := 
	record(entity)
	  string9 clean;
		DATASET(result_person) people { maxcount(100) };
  end;
  
entity_fein := 
	record(entity)
	  string9 clean;
		DATASET(result_business) businesses { maxcount(25) };
  end;

entity_phone := 
	record(entity)
	  string10 clean;
		DATASET(result_person) people { maxcount(100) };
		DATASET(result_business) businesses { maxcount(25) };
  end;

entity_business := 
	record(entity)
		dataset(result_business) businesses { maxcount(25) };
  end;

entity_url := entity;

entity_email := entity;
  
entity_city := entity;
  
entity_state := entity;
  
entity_country := entity;

entity_vehicle := 
	record(entity)
	  string4 model_year := '';
	  string60 make_description := '';
	  string60 model_description := '';
		DATASET(result_person) people { maxcount(100) };
		DATASET(result_business) businesses { maxcount(25) };
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

PATTERN entityLabel := (((
					(text.Name) | 
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
					(Text.VIN) |
					(Text.fein)) LENGTH(1..150)) AFTER FRONT) BEFORE BACK;
				
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
										13);
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

// Clean up possessive names and trailing punctuation
Matches FixPossessive(Matches l) := transform
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
	self := l;
end;

parsed_fixed := dedup(sort(project(parsed, FixPossessive(left)), pos, len));

// Phase 2 - score all possibles
// MORE - we get some info about the entity back for free as a side effect of scoring - should find a way to keep it

scoreName(STRING name) := FUNCTION
		string73 cleanedName := Address.CleanPerson73(name);
		unsigned1 cn := (unsigned1) cleanedName[71..73];
		fname_value := cleanedName[6..25];
		lname_value := cleanedName[46..65];
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

boolean checkAddress(unsigned citywords, string addr) := FUNCTION
  string decomma := stringlib.stringFilterOut(trim(addr), ',');
	string unispace := stringlib.stringCleanSpaces(decomma);
	unsigned numspaces := length(stringlib.stringFilter(unispace, ' '));
	unsigned splitpoint := stringlib.stringFind(unispace, ' ', numspaces-citywords-1);
  return Address.CleanAddress182(unispace[..splitpoint], unispace[splitpoint..])[179] != 'E';
END;

scoreAddress(STRING addr) := FUNCTION
		return MAP(
			checkAddress(1, addr)=>100,
			checkAddress(2, addr)=>100,
			checkAddress(3, addr)=>100,
			0);
  END;

Dummy_ClassifyResponse := dataset([{'','',0,0,0,0,'',0,0,false,false,false}],
                          FSM.Layout_ClassifyResponse);
						  
Dummy_VinVerifyResponse := dataset([{'','','','','',0,false,false,false,false}],
                          VIN.Layout_Vin_Info);

Matches scoreCandidates(Matches L) := TRANSFORM

		ClassificationInfo := if(L.matchType in [0,7], fsm.Classify(L.parsed),
		                                               Dummy_ClassifyResponse)[1];
		VinInfo := if(L.matchType = 11, VIN.VerifyVin(L.parsed),
		                                Dummy_VinVerifyResponse)[1];

		SELF.isCompany := ClassificationInfo.isCompany;
		SELF.isPerson := ClassificationInfo.isPerson;
		SELF.isCity := ClassificationInfo.isCity;
		SELF.VerifiedCompany := ClassificationInfo.VerifiedCompany;
		SELF.VerifiedPerson := ClassificationInfo.VerifiedPerson;
		SELF.VinValid := VinInfo.Valid;
		SELF.VinVerified := VinInfo.Verified;
	    SELF.VinManufacturer := VinInfo.Manufacturer;
	    SELF.VinModel := VinInfo.Model;
	    SELF.VinYear := if(VinInfo.Year <> 0, intformat(VinInfo.Year, 4,1), '');
		SELF.ParseTokens := ClassificationInfo.ParseTokens;
		SELF.score := CASE(L.matchtype,
										0 =>  /*ClassificationInfo.isPerson */ scoreName(L.parsed),
										1 =>  scoreSSN(L.parsed),
										2 =>  scoreURL(L.parsed),
										3 =>  scorePhone(L.parsed),
										4 =>  scoreEmail(L.parsed),
										5 =>  scoreAddress(L.parsed),
										6 =>  SKIP,
										7 =>  /* ClassificationInfo.isCompany */ scoreBusinessName(L.parsed),
										9 =>  100,
										10 => 100,
										11 => scoreVIN(SELF.VinValid, SELF.VinVerified),
										12 => scoreFEIN(L.parsed),
										SKIP);
		SELF := L;
	END;

scored := project(parsed_fixed, scoreCandidates(LEFT));

// Phase 3 - reclassify
// This phase reclassifies entities based on classification information
// City names are parsed as business names, but must be reclassified
reclassify_city := project(scored(matchType=7, /* ParseTokens[1] in ['D','d'], */ isCity >= 50),
                             transform(Matches,
							           self.matchType := 8; // Create City matchType record
									   self := left));
									   
reclassified := scored + reclassify_city;

// Phase 4 - filter
// MORE - configurable, possibly by entity type...

filtered := reclassified((matchType = 0 and (isPerson >= 50 or parseTokens in ['Il','IIl']) and score >= 85) or
                   // Filter companies using parseTokens for now until verification and enhance can be improved
				   // City names are assumed to be business names as well
                   (matchType = 7 and ParseTokens[1] in ['C','D','d','V'] and (isCompany >= 50 or isCity >= 50 or score >= 50)) or
				   (matchType = 8 and /* ParseTokens[1] in ['D','d'] and */ isCity >= 50) or
				   (matchType not in [0, 7, 8] and score >= 50));
				   
// Phase 5 - dedup
// MORE - get clever with removing overhanging entities by selecting the one with the highest score
// Scoring needs to be refined before it can be used

found := group(sort(dedup(group(filtered),
                        left.docID = right.docID and
						left.len >= right.len and
						left.pos <= right.pos and
						// dedup partial matches of same matchType
						(((left.matchType = right.matchType or
						// dedup any match type from within url, email, city, state, phone numbers, and country names
						  left.matchType in [2,3,4,8,9,10] or
						// dedup businesses, cities, states, and countries from address patterns
						  (left.matchType = 5 and right.matchType in [7,8,9,10]) or
						// dedup cities, states, and countries from within person names),
						  (left.matchType = 0 and right.matchType in [8,9,10] and left.pos < right.pos))
						    and (right.pos + right.len) <= (left.pos + left.len))
						 or
						// dedup businesses from within person names
						 (left.matchType = 0 and right.matchType = 7 and
						   ((right.pos + right.len) < (left.pos + left.len) or (left.pos < right.pos and (right.pos + right.len) <= (left.pos + left.len))))),
						ALL),docID,pos,len),docID);
						
// Phase 6 - enrich

getBdidsByDID(unsigned6 indid) := FUNCTION
  bdids := Business_Header.Key_Employment_Did(KEYED(sdid = indid), (unsigned6) bdid <> 0, (integer) score > 100);
	return PROJECT(bdids, transform(doxie.Layout_ref_bdid, self.bdid := (unsigned6)left.bdid));
END;

getBusinessAssociations(DATASET(doxie.Layout_ref_bdid) allbdids) := module
 deduped := choosen(DEDUP(SORT(allbdids, bdid), bdid), maxDids); 
 numBdids := count(deduped);
 selected := if(numBDIDs > maxFull, choosen(deduped, maxFull), deduped);
 fullinfo := PROJECT(join(selected,Business_Header.Key_BH_Best,KEYED(left.bdid = right.bdid)),
   TRANSFORM(result_business_association, 
	    inbdid := LEFT.bdid;
	    self.name := LEFT.company_name;
			self.addresses := DATASET([{0, Address.addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name,
                         LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range), LEFT.city, LEFT.state, LEFT.zip}], result_address);
	    self := LEFT, 
			self := []
      )
	 );

 export DATASET(result_business_association) businesses := fullinfo;
end;

getPeople(DATASET(doxie.layout_references) alldids) := module
 shared deduped := choosen(DEDUP(SORT(alldids, did),did), maxDids); 
 shared fullinfo := PROJECT(join(deduped,watchdog.Key_watchdog_glb,KEYED(left.did = right.did)),
   TRANSFORM(result_person, 
	    self := LEFT, 
			self.addresses := DATASET([{0, Address.addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name,
                         LEFT.suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range), LEFT.city_name, LEFT.st, LEFT.zip}], result_address);
			self := []
      )
	 );
 shared fullinfo_business := PROJECT(join(deduped,watchdog.Key_watchdog_glb,KEYED(left.did = right.did)),
   TRANSFORM(result_person_business, 
	    self := LEFT, 
			self.addresses := DATASET([{0, Address.addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name,
                         LEFT.suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range), LEFT.city_name, LEFT.st, LEFT.zip}], result_address);
		bigbdids := getBdidsByDID(LEFT.did);
		self.businesses  := getBusinessAssociations(bigbdids).businesses;
		self := []
      )
	 );
	 
 export DATASET(result_person) people := fullinfo;
 export DATASET(result_person_business) people_business_association := fullinfo_business;
end;

getBusinesses(DATASET(doxie.Layout_ref_bdid) allbdids) := module
 deduped := choosen(DEDUP(SORT(allbdids, bdid), bdid), maxDids); 
 numBdids := count(deduped);
 selected := if(numBDIDs > maxFull, choosen(deduped, maxFull), deduped);
 fullinfo := PROJECT(join(selected,Business_Header.Key_BH_Best,KEYED(left.bdid = right.bdid)),
   TRANSFORM(result_business, 
	    inbdid := LEFT.bdid;
	    contacts := PROJECT(Business_Header.Key_Business_Contacts_BDID(KEYED(bdid = inbdid), did <> 0), doxie.layout_references);
	    self.name := LEFT.company_name;
			self.addresses := DATASET([{0, Address.addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name,
                         LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range), LEFT.city, LEFT.state, LEFT.zip}], result_address);
			self.people := getPeople(contacts).people;
	    self := LEFT, 
			self := []
      )
	 );
 export DATASET(result_business) businesses := fullinfo;
end;

getBdidsByPhone(integer inphone) := FUNCTION
  bdids := Business_Header_SS.Key_BH_Phone(KEYED(phone=inphone));
	return PROJECT(bdids, doxie.Layout_ref_bdid);
END;

getBdidsByFEIN(integer infein) := FUNCTION
  bdids := Business_Header_SS.Key_BH_FEIN(KEYED(fein=infein));
	return PROJECT(bdids, doxie.Layout_ref_bdid);
END;

getBdidsByName(string81 inname) := FUNCTION
  bdids := Business_Header_SS.Key_BH_CompanyName_Unlimited(KEYED(clean_company_name20=inname[1..20]),
			KEYED(clean_company_name60=inname[21..80]));
	return PROJECT(bdids, doxie.Layout_ref_bdid);
END;

getBdidsByAddr(qstring10 in_prim_range, qstring28 in_prim_name, unsigned3 in_zip, qstring8 in_sec_range) := FUNCTION
  bdids := doxie_cbrs.key_addr_bdid(keyed(prim_name=in_prim_name),
									keyed(zip=in_zip),
									keyed(in_sec_range = '' or sec_range=in_sec_range),
									keyed(prim_range=in_prim_range));
	return PROJECT(bdids, doxie.Layout_ref_bdid);
END;

Layout_ref_seq := record
unsigned4 seq_no;
end;

getVehicle(DATASET(Layout_ref_seq) allseqs, boolean verified, string60 Manufacturer, string60 Model, string4 Year) := module
 shared fullinfo := join(allseqs,doxie_files.Key_Vehicles,KEYED(left.seq_no = right.sseq_no));

 // Dedup to most current according to history flag
 shared deduped := dedup(sort(fullinfo, history), true);
 shared numseqs := count(deduped);
 
 shared doxie.layout_references getVehicleDids(deduped l, unsigned1 cnt) := transform
   self.did := choose(cnt, (unsigned6)l.own_1_did, (unsigned6)l.own_2_did,
                           (unsigned6)l.reg_1_did, (unsigned6)l.reg_2_did);
 end;
 
 shared doxie.Layout_ref_bdid getVehicleBdids(deduped l, unsigned1 cnt) := transform
   self.bdid := choose(cnt, l.own_1_bdid, l.own_2_bdid,
                            l.reg_1_bdid, l.reg_2_bdid);
 end;

 shared dids := normalize(deduped, 4, getVehicleDids(left, counter))(did <> 0);
 shared result_people := getPeople(dids).people;                                            
 
 shared bdids := normalize(deduped, 4, getVehicleBdids(left, counter))(bdid <> 0);
 shared result_businesses := getBusinesses(bdids).businesses;                                            

 export string4 model_year := if(verified and numseqs > 0, deduped[1].model_year, Year);
 export string60 make_description := if(verified and numseqs > 0, deduped[1].make_description, Manufacturer);
 export string60 model_description := if(verified and numseqs > 0, deduped[1].model_description, Model);
 export DATASET(result_person) people := if(verified and numseqs > 0, result_people, dataset([], result_person));
 export DATASET(result_business) businesses := if(verified and numseqs > 0, result_businesses, dataset([], result_business));

end;

getSeqsByVin(string17 invin, boolean verified) := FUNCTION
  seqs := doxie_files.Key_Vehicle_Vin(KEYED(svin=invin));
	return if(verified, PROJECT(seqs, Layout_ref_seq), dataset([], Layout_ref_seq));
END;

entity_person extract_person(found L) := 
  TRANSFORM
		string73 cleanedName := Address.CleanPerson73(L.parsed);
    self.orig := L.parsed;
		self.docId := L.docId;
		self.pos := L.pos;
		fname_value := cleanedName[6..25];
		lname_value := cleanedName[46..65];
		ok := // Make sure name is in same sequence, ignore reversals for now
		         trim(Stringlib.StringFilterOut(Stringlib.StringToUpperCase(ut.Word(L.parsed, 1)), '.')) = trim(fname_value)
			  and
			     L.verifiedPerson;
/*
			     // allow for nicknames and first initials, but exact match on last name
		         EXISTS(doxie.Key_Header_Name(
			     KEYED(dph_lname=metaphonelib.DMetaPhone1(lname_value)),
			     KEYED(lname=lname_value),
			     KEYED(pfname=Datalib.preferredfirst(fname_value) OR pfname[1..length(trim(fname_value))]=(STRING20)fname_value OR LENGTH(TRIM(fname_value))<2),
				 KEYED(fname[1..length(trim(fname_value))]=fname_value OR LENGTH(TRIM(fname_value))>=2)) 
		   );
*/
		self.clean.title			 := cleanedName[1..5];
		self.clean.fname			 := fname_value;
		self.clean.mname			 := cleanedName[26..45];
		self.clean.lname			 := lname_value;
		self.clean.name_suffix := cleanedName[66..70];
		CN := cleanedName[71..73];
		self.clean.name_score  := IF((unsigned)cn < 85 OR NOT ok, SKIP, cn);
		// No phonetics on last name for now
		bignames := Header_Services.Fetch_Header_Name_Function(fname_value, lname_value, false, true);
		// We need to decide if we want to return the names where best does not match parsed input
//		self.people := choosen(getPeople(bignames.outrec).people, maxFull);
		self.people := choosen(sort(getPeople(bignames.outrec).people_business_association(lname=lname_value,
		                            Datalib.preferredfirst(fname) = Datalib.preferredfirst(fname_value)
									  OR Datalib.preferredfirst(fname)[1..length(trim(fname_value))]=(STRING20)fname_value
									  OR fname[1..length(trim(fname_value))]=fname_value),
									if(fname = fname_value, 0, 1), fname, did), maxFull);
  END;

entity_business extract_business(found L) := 
  TRANSFORM
		string81 cleanCompanyName := ut.CleanCompany(L.parsed);
		self.docId := L.docId;
		self.pos := L.pos;

		ok := EXISTS(Business_Header_SS.Key_BH_CompanyName_Unlimited(
			KEYED(clean_company_name20=cleanCompanyName[1..20]),
			KEYED(clean_company_name60=cleanCompanyName[21..80])) 
		   );

//        ok := L.verifiedCompany;
		self.orig := IF(ok, L.parsed, SKIP);
		bigbdids := getBdidsByName(cleanCompanyName);
		self.businesses  := getBusinesses(bigbdids).businesses;
  END;

entity_phone extract_phone(found L) := 
  TRANSFORM
	string10 clean_phone := Address.CleanPhone(L.parsed);
    self.orig := L.parsed;
		self.docId := L.docId;
		self.pos := L.pos;
		ok := clean_phone[1..3] in ['800','866','877','888'] or EXISTS(Risk_Indicators.Key_Telcordia_tds(
		    KEYED(npa=clean_phone[1..3]),
			KEYED(nxx=clean_phone[4..6]))
		   );
		self.clean := IF(ok, clean_phone, SKIP);
		bigdids := Header_Services.Fetch_Header_Phone_Function(clean_phone, '', '');
		bigbdids := getBdidsByPhone((integer) clean_phone);

		self.people := getPeople(bigdids).people;
		self.businesses  := getBusinesses(bigbdids).businesses;
  END;

entity_ssn extract_ssn(found L) := 
  TRANSFORM
	string9	clean_ssn := StringLib.stringFilter(L.parsed, '0123456789');
    self.orig := L.parsed;
		self.docId := L.docId;
		self.pos := L.pos;
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
		self.clean := IF(ok, clean_ssn, SKIP);

		bigdids := Header_Services.Fetch_Header_SSN_Function(clean_ssn, '', '', 100);
		self.people := getPeople(bigdids).people;
  END;
  
  
entity_fein extract_fein(found L) := 
  TRANSFORM
	string9	clean_fein := StringLib.stringFilter(L.parsed, '0123456789');
    self.orig := L.parsed;
		self.docId := L.docId;
		self.pos := L.pos;
		ok := EXISTS(Business_Header_SS.Key_BH_FEIN(KEYED(fein=(unsigned6)clean_fein)));
		self.clean := IF(ok, clean_fein, SKIP);

		bigbdids := getBdidsByFEIN((unsigned6)clean_fein);
		self.businesses  := getBusinesses(bigbdids).businesses;
  END;

entity_address extract_address(found L) := 
  TRANSFORM
        string decomma := stringlib.stringFindReplace(trim(L.parsed), ',', ' ');
		string unispace := stringlib.stringCleanSpaces(decomma);
		unsigned numspaces := length(stringlib.stringFilter(unispace, ' '));
		unsigned splitpoint := stringlib.stringFind(unispace, ' ', numspaces-2);
		clean := Address.CleanAddress182(unispace[..splitpoint], unispace[splitpoint..]);

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

		bigdids := Header_Services.Fetch_Address_Function(prim_range, ut.stripOrdinal(prim_name), v_city_name, st, zip5, 10, sec_range, '', '', false);
		bigbdids := getBdidsByAddr((qstring)prim_range, (qstring)prim_name, (unsigned3)zip5, (qstring)sec_range);

    self.orig := IF (clean[179] = 'E', SKIP, L.parsed);
		self.docId := L.docId;
		self.pos := L.pos;
		self.clean := clean;
		self.addresses := dataset([{ 0, Address.addr1FromComponents(prim_range, predir, prim_name,
                         addr_suffix, postdir, unit_desig, sec_range), v_city_name, st, zip5}], result_address);
		self.people := getPeople(bigdids.outrecs).people;
		self.businesses  := getBusinesses(bigbdids).businesses;
		self := [];
  END;

entity_url extract_url(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;
  
entity_email extract_email(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;
   
entity_city extract_city(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;

entity_state extract_state(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;

entity_country extract_country(found L) := 
  TRANSFORM
		self.orig := L.parsed;
		self := L;
  END;

entity_vehicle extract_vehicle(found L) := 
  TRANSFORM
        bigseqs := getSeqsByVin(L.parsed, L.VinVerified);
		
		vehinfo := getVehicle(bigseqs, L.VinVerified, L.VinManufacturer, L.VinModel, L.VinYear);
		
		self.orig := L.parsed;
	    self.model_year := vehinfo.model_year;
	    self.make_description := vehinfo.make_description;
	    self.model_description := vehinfo.model_description;
		self.people := vehinfo.people;
		self.businesses := vehinfo.businesses;
		
		self := L;
		self := [];
  END;

//output(indata, named('input'));
//output(parsed, named('parsed'));
//output(scored, named('scored'));
//output(filtered, named('filtered'));
//output(found, named('found'));

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


	return count(found);
END;