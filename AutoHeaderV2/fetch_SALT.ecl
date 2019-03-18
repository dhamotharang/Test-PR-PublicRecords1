IMPORT IDLExternalLinking, InsuranceHeader_xLink, doxie, SALT37, ut, STD;
// requirements of search:
// limits and atmost 10K
// no dobforce 
 
EXPORT fetch_SALT (dataset (AutoHeaderV2.layouts.search) ds_search, integer search_code=0) := function
  
	boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;		
	
	// flat layout for salt		
	inLayout := {Insuranceheader_xLink.Layout_Person_xLink, dataset(InsuranceHeader_xLink.Process_xIDL_layouts().layout_ZIP_cases) zips, 
            string rel_fname, string rel_lname, unsigned1 saltLeadThreshold};
	inDataOne(unsigned1 stInd) :=  project(ds_search,
				transform(inLayout, 
			self.did := 0;
			self.new_score := 0;			
			self.ssn := if(left.tssn.ssn in ut.Set_BadSSN, '', left.tssn.ssn) ;	 // remove from inquiry bad ssn searches			
			self.dob := (STRING)IF(left.tdob.dob=0, LEFT.tdob.dob_low, left.tdob.dob) ; // left.tdob.agehigh
			self.fname := left.tname.fname;
			self.mname := left.tname.mname;
			self.lname := left.tname.lname;
			self.name_suffix := '';
			self.city := IF(left.taddress.city='', left.taddress.city_other, left.taddress.city);
      self.state := MAP(stInd=0 => left.taddress.state,
                      stInd=1 => left.taddress.state_prev_1,
                      stInd=2 => left.taddress.state_prev_2,
                      IF(left.taddress.state='', LEFT.taddress.state_prev_1, left.taddress.state));
			self.prim_range := left.taddress.prim_range;
			self.prim_name := left.taddress.prim_name;
			self.sec_range := left.taddress.sec_range; 
			String5 theZip := left.taddress.zip5;		
			unsigned1 zip_radius := left.taddress.zip_radius;			 			
			zipDs := MAP(left.taddress.zip_set<>[] => dataset(left.taddress.zip_set,{Integer4 zip}), 
                left.taddress.zip5<>'' => dataset([{left.taddress.zip5}],{Integer4 zip}),
                dataset([], {Integer4 zip}));
			self.zips := project(zipDs, transform(InsuranceHeader_xLink.Process_xIDL_Layouts().layout_ZIP_cases,
						 self.zip := INTFORMAT(left.zip, 5, 1);
						 integer dist := ut.zip_Dist(theZip, (string5)left.zip)+1;			
					  self.weight := IF(self.zip=theZip, 100, 100-((dist/zip_radius)*80))));
					
			self.phone := left.tphone.phone10;
			self.UniqueID := left.seq + stInd;
			self.rel_fname := left.tname.fname_rel_1;
			self.rel_lname := left.tname.lname,       
			self.saltLeadThreshold := left.options.saltLeadThreshold, self := []));
		ssnDs := dataset(ds_search[1].tssn.ssn_set, {string9 ssn});
		inDataSSn := project(ssnDs, transform (inLayout, 
			self.did := 0;
			self.new_score := 0;
			self.ssn := if(left.ssn in ut.Set_BadSSN, '', left.ssn) ;	 // remove from inquiry bad ssn searches
			self.fname := ds_search[1].tname.fname;
			self.mname := ds_search[1].tname.mname;
			self.lname := ds_search[1].tname.lname;
			self.city := IF(ds_search[1].taddress.city='', ds_search[1].taddress.city_other, ds_search[1].taddress.city);
			self.state := IF(ds_search[1].taddress.state='', ds_search[1].taddress.state_prev_1, ds_search[1].taddress.state);
			self.UniqueID := ds_search[1].seq;
      self.saltLeadThreshold :=  ds_search[1].options.saltLeadThreshold;
			 self := []));
    inDataNickname(unsigned1 stInd) := project(inDataOne(stInd), transform(inLayout,
        self.fname := InsuranceHeader_xlink.fn_preferredName(left.fname),         
        self := left));
	 // Releavant options
	boolean isStrict := ds_search[1].options.strict_match;
	boolean isEditDistance := ~isStrict and ds_search[1].tname.check_name_variants;
	boolean isNickName := ~isStrict and ds_search[1].tname.nicknames;
  boolean isFullssn  := length(trim(inDataOne(0)[1].ssn))=9 and STD.Str.FindCount(inDataOne(0)[1].ssn, '00000')=0;
  boolean isCompleteAddr := inDataOne(0)[1].prim_range<>'' and inDataOne(0)[1].prim_name<>'' and ((inDataOne(0)[1].city<>'' and inDataOne(0)[1].state<>'') or inDataOne(0)[1].zip<>'');
  boolean isNickNameLink := isNickName and inDataOne(0)[1].dob='0' and not isFullSsn and not isCompleteAddr;
	boolean isPhonetic := ~isStrict and ds_search[1].tname.phonetic;
	boolean isWildcard := search_code & AutoHeaderV2.Constants.SearchCode.ALLOW_WILDCARD;
  boolean isOtherSt1 := ds_search[1].taddress.state_prev_1<>'';
  boolean isOtherSt2 := ds_search[1].taddress.state_prev_2<>'';
  inData := DEDUP(SORT(IF(ds_search[1].tssn.fuzzy_ssn and count(ds_search[1].tssn.ssn_set) >1,  inDataSSn,
              inDataOne(0) + IF(isNickNameLink, inDataNickname(0), dataset([],inLayout)))
              + IF(isOtherSt1, inDataOne(1) + IF(isNickNameLink, inDataNickname(1), dataset([],inLayout))) +
             IF(isOtherSt2, inDataOne(2) + IF(isNickNameLink, inDataNickname(2), dataset([],inLayout))), RECORD), ALL);
  UNSIGNED2 maxId := IF(isOTherSt1 or isOTherSt2, 1000, 200); // max lexIDs returned from SALT
	IDLExternalLinking.mac_xLinking_PS(inData, UniqueID, name_suffix , fname , mname , lname ,, 
								 ,PRIM_NAME ,PRIM_RANGE ,SEC_RANGE ,city ,
												 state , zips ,SSN ,DOB, PHONE,  , , 
														rel_fname, rel_lname, saltleadthreshold, maxID, outfile1);
				
		// build filtering condition
    outfile2 := IF (isOtherSt1, dedup(sort(join(outfile1(stweight>0 and reference=ds_search[1].seq), outfile1(stweight>0 and reference=ds_search[1].seq+1), left.did=right.did), did, reference), did), outfile1);
    outfile := IF (isOtherSt2, dedup(sort(join(outfile2, outfile1(stweight>0 and reference=ds_search[1].seq+2), left.did=right.did and left.reference<>right.reference), did, reference), did), outfile2);
    
		result1 := IF(isEditDistance, outfile, outfile(fname_match_code <> SALT37.MatchCode.EditdistanceMatch or (ssn5weight>0 and ssn4weight>0)));
		result2 := IF(isEditDistance, result1, result1(lname_match_code <> SALT37.MatchCode.EditdistanceMatch or (ssn5weight>0 and ssn4weight>0)));
		
		result3 := IF(isNickname, result2, result2(fname_match_code<>SALT37.MatchCode.CustomFuzzyMatch or (ssn5weight>0 and ssn4weight>0)));
		
		result4 := IF(isPhonetic, result3, result3(fname_match_code <> SALT37.MatchCode.PhoneticMatch or (ssn5weight>0 and ssn4weight>0)));
		result5 := IF(isPhonetic, result4, result4(lname_match_code<>SALT37.MatchCode.PhoneticMatch or (ssn5weight>0 and ssn4weight>0)));
		
		result6 := IF(isWildcard, result5, result5(fname_match_code<>SALT37.MatchCode.WildMatch or (ssn5weight>0 and ssn4weight>0)));
		result7 := IF(isWildcard, result6, result6(lname_match_code<>SALT37.MatchCode.WildMatch or (ssn5weight>0 and ssn4weight>0)));
		result8 := IF(isWildcard, result7, result7(prim_name_match_code<>SALT37.MatchCode.WildMatch or (ssn5weight>0 and ssn4weight>0)));
		result9 := IF(isWildcard, result8, result8(prim_range_match_code<>SALT37.MatchCode.WildMatch or (ssn5weight>0 and ssn4weight>0)));
		
		// remove insurance LexIDs
		result := result9(DID<IDLExternalLinking.Constants.INSURANCE_LEXID and DID>0);
		
		// transform in search output		
		resultfinal := project(result, 
					transform (AutoheaderV2.layouts.search_out, 
					self.did := left.did, 
					self.seq := left.reference,
					self.score := left.score,
					Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.SALT, 	// maybe we should have a new fetch hit called SALT				
					self.index_hit := left.keys_used, 
					self.status := 0, 
					self.err_code := 0));										
 
	integer errorCode := 203;
	RETURN MAP(resultfinal[1].did>0 => resultfinal,
							no_fail => dataset([], AutoheaderV2.layouts.search_out), 
							FAIL(resultfinal, 203, doxie.ErrorCodes(errorCode) + ' - SALT'));	
END;

