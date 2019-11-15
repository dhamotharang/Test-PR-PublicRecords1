EXPORT macSourceSampler(inControl, inBase, outFile, isQA = false, sampleSize = 10000, inputFilterNum = 0) := macro               
  
    #uniquename(tFilter)
	BizLinkFull_ELERT.modLayouts.lSampleLayoutExp %tFilter%(BizLinkFull_ELERT.modLayouts.lSampleLayoutExp dRec, UNSIGNED iRandomID) := TRANSFORM
    
        macFieldFilter(inField) := macro
            SELF.inField := IF(#TEXT(inField) IN ssFilter, IF(dRec.inField = '', SKIP, dRec.inField), IF(bNoFilter,dRec.inField,''));
        endmacro; 
        
        macFieldFilterInt(inField) := macro
            SELF.inField := IF(#TEXT(inField) IN ssFilter, IF(dRec.inField = 0, SKIP, dRec.inField), IF(bNoFilter,dRec.inField,0));
        endmacro;

        //Change Field names to match your data. -ZRS 4/8/2019    
        SET OF STRING ssFilter := dRec.ssFilter;
        BOOLEAN bNoFilter := (COUNT(ssFilter) = 0);
        macFieldFilter(company_name);
        macFieldFilter(prim_range);
        macFieldFilter(prim_name);
        macFieldFilter(sec_range);
        macFieldFilter(city);
        macFieldFilter(state);
        macFieldFilter(zip5);
        macFieldFilterInt(zip_radius_miles);
        macFieldFilter(phone10);
        macFieldFilter(fein);
        macFieldFilter(url);
        macFieldFilter(email);
        macFieldFilter(contact_fname);
        macFieldFilter(contact_mname);
        macFieldFilter(contact_lname);
        macFieldFilter(contact_ssn);
        macFieldFilterInt(contact_did);
        macFieldFilter(sic_code);
        SELF.mode        := dRec.macroCallOrig;
        SELF.compareMode := dRec.macroCallNew;
        SELF.description := dRec.description;
        SELF.uniqueid := iRandomID;
        SELF := dRec;
    END;
	
  #uniquename(norm4cat);
  %norm4cat% := normalize(inControl,
                          count(left.srcFilters),
                          transform({recordof(left)-srcFilters, string srcFilter},
                                    self.srcFilter := trim(left.srcFilters[counter],left,right),
                                    self := left));                
  
  #uniquename(controlCnt);
  %controlCnt% := count(inControl);
  
  #uniquename(samplerLay);
  %samplerLay% := BizLinkFull_ELERT.modLayouts.lSampleLayout;
	
	#uniquename(samplerLayExp);
  %samplerLayExp% := BizLinkFull_ELERT.modLayouts.lSampleLayoutExp;
	
	#uniquename(samplerLayOut);
	%samplerLayOut% := BizLinkFull_ELERT.modLayouts.lSampleLayout;
 	
	#uniquename(dBase);
  %dBase% := project(inBase, 
                     transform({%samplerLay%, unsigned filt_num},
                               self.filt_num := random();
                               self:=left, 
                               self:=[])); 
                               
  #uniquename(addCategory);
  %addCategory% := join(%dBase%, %norm4cat%,
                        left.src_Category = right.srcFilter,
                        transform(%samplerLayExp%,
                                  self.profile_bucket := right.srcCategory;
																	self := right;
                                  self := left),
                        many lookup);
	// count(%dBase%);											
	// count(%addCategory%);											
	// %addCategory%;		
	
  #uniquename(filteredRecs);
  %filteredRecs%   :=  PROJECT(%addCategory%,%tFilter%(LEFT,RANDOM())); 
		// count(%filteredRecs%);											
	// %filteredRecs%;
	
  #uniquename(src_smp);
  // %src_smp% := ungroup(topn(group(SORT(%filteredRecs%, profile_bucket,  -rid, local), profile_bucket, local), sampleSize, record));
  // %src_smp% := ungroup(enth(group(SORT(%filteredRecs%, profile_bucket,  -rid, local), profile_bucket, local), sampleSize, local));
	  // %src_smp% := ungroup(topn(group(SORT(%filteredRecs%, profile_bucket, -dt_last_seen, -rid, local), profile_bucket, local)(filt_num = inputFilterNum), sampleSize, profile_bucket, -dt_last_seen, -rid));
	  %src_smp% := ungroup(topn(group(SORT(%filteredRecs%, profile_bucket, filt_num, -rid, local), profile_bucket, local), sampleSize, filt_num, -rid));
	  // %src_smp% := ungroup(topn(group(SORT(%filteredRecs%, profile_bucket,  -rid, local), profile_bucket, local), sampleSize, profile_bucket,  -rid));

   #uniquename(break_gr);
  %break_gr% := if(exists(%src_smp%), %src_smp%, %src_smp%(rid != 0));
  
  #uniquename(gas);
  %gas% := ungroup(topn(group(sort(distribute(%break_gr%, hash64(profile_bucket)), profile_bucket, filt_num, -rid, local), profile_bucket, local), sampleSize, filt_num, -rid));
  // %gas% := ungroup(topn(group(sort(distribute(%break_gr%, hash64(profile_bucket)), profile_bucket,  -rid, local), profile_bucket, local), sampleSize,  -rid));
  
  // #uniquename(stripIfQA);
  // %stripIfQA% := #if(isQA) project(%gas%, %samplerLayOut% - source_category) #else %gas% #end ;
  outFile := distribute(project(%gas%, %samplerLayOut%), rid);
  
  #uniquename(testTable);
  %testTable% := table(%gas%,
                       {string profile_bucket := %gas%.profile_bucket,
                        unsigned cnt := count(group)},
                       profile_bucket, skew(1.0));
  // #if(not isQA) output(%testTable%, named('src_cnt_table')); #end
  
endmacro;


                      