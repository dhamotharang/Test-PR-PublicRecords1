import BIPV2_Crosswalk;
import BIPV2;
import AutoStandardI;

export Key_ConsumerToBip := module
     export Key := BIPV2_Crosswalk.Keys().ConsumerToBipKey();
     export l_lexid_links := record
		unsigned6 contact_did;
		unsigned6 uniqueID;
	end;

     shared restrict(ds, in_mod, permits, ds_src='', dnbWillMask=false, isDateFirstSeenExists=false) := functionmacro
          ds_filt := ds(BIPV2.mod_sources.isPermitted(in_mod,dnbWillMask).byBmap(permits));
          #IF(#TEXT(ds_src)='')
               return ds_filt;
          #ELSE
		
          ds_filt xform (ds_filt L) := function
               #IF(isDateFirstSeenExists)
                    unsigned4 dt_first_seen := L.dt_first_seen;
               #ELSE
                    unsigned4 dt_first_seen := 0;
               #END
               ds_src_filt := L.ds_src (BIPV2.mod_sources.isPermitted(in_mod,dnbWillMask).bySource(source,vl_id,dt_first_seen));
               ds_filt xTransform := transform, skip (~exists(ds_src_filt))
                    self.ds_src := ds_src_filt;
                    self := L;
               end;
               return xTransform;
           end;

               
		 return project(ds_filt, xform(left)); //Using a SKIP in the transform was giving a syntax error and hence, had to use to this EXISTS filter condition
         
	     #END
     endmacro;

	// Removes record data matching the permit bitmask
	shared filterSrcCode(ds, permits, ds_src='', codeBmap) := functionmacro
		ds_filt := ds(permits & codeBmap <> 0);
		#IF(#TEXT(ds_src)='')
			return ds_filt;
		#ELSE
      // function instead of transform: need to check complicated SKIP condition.
			ds_filt xform (ds_filt L) := function
        ds_src_filt := L.ds_src (BIPV2.mod_sources.src2bmap(source) & codeBmap <> 0);
        ds_filt xTransform := transform, skip (~exists(ds_src_filt))
  				self.ds_src := ds_src_filt;
	  			self := L;
		  	end;
        return xTransform;
      end;
			return project(ds_filt, xform(left)); //Using a SKIP in the transform was giving a syntax error and hence, had to use to this EXISTS filter condition
		#END
	endmacro;  
     
     export kFetch(
                    dataset(l_lexid_links) inputs,
                    BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
                    JoinLimit=25000,
                    unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin,
				boolean applyMarketingRestrictions = false
     ) := function
	
	     FetchedRec := record
		     recordof(Key);
		     inputs.uniqueID;
		end;
		
          ds_fetched := join(inputs, Key, 
		                   left.contact_did = right.contact_did,
					    transform(FetchedRec, self := right, self := left), keep(JoinLimit));
		
          // apply restrictions in child datasets       
          ds_fetched apply_restrict(ds_fetched L) := transform
		     self.jobTitles                    := restrict(L.jobTitles, in_mod, job_title_permits,, true); 
		     self.contactNames                 := restrict(L.contactNames, in_mod, contact_name_permits,, true); 
               self := L;
          end;
          ds_restricted := project(ds_fetched, apply_restrict(left));

	     allowCodeBmap := BIPV2.mod_Sources.code2bmap(BIPV2.mod_Sources.code.MARKETING_UNRESTRICTED);
	     recordof(ds_restricted) apply_src_filter(recordof(ds_restricted) L) := transform
		     // NOTE: These filter the "sources" child dataset when applicable, but not all sections have that	
               self.contactNames                 := filterSrcCode(L.contactNames, contact_name_permits,, allowCodeBmap); 
		     self.jobTitles                    := filterSrcCode(L.jobTitles, job_title_permits,, allowCodeBmap); 
               self := L;
	     end;		
		marketingRestrictions :=  project(ds_restricted, apply_src_filter(left));
		
		return if(applyMarketingRestrictions, marketingRestrictions, ds_restricted);
     end;

     shared normalize_mac(inDs, normalize_field, newLayout, sourcesToInclude, sourcesGroupsToInclude) := functionmacro
	     no_recs_to_normalize := project(inDs(count(normalize_field)=0), 
		                                transform(newLayout,
								            self := left,
										  self := []));
		
		normalize_recs       := normalize(inDs(count(normalize_field)>0),
		                                  left.normalize_field,
								    transform(newLayout,
								              skip((right.source not in sourcesToInclude) or (right.sourceGroup not in sourcesGroupsToInclude)),
								              newSourceInfo   := dataset([{right.source,right.source_record_id}],Layouts.SourceInfoRec);
								              self.sourceInfo := left.sourceInfo + newSourceInfo(trim(source)!='');
								              self            := left, 
										    self            := right));
										    
          return normalize_recs(count(sourceInfo) > 0) + no_recs_to_normalize;									    
	endmacro;
		
     export getDataFiltered(
                    dataset(l_lexid_links) inputs,
                    BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
                    boolean IncludeStatus = true,
                    JoinLimit=25000,
                    unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin,
				set of string sourcesToInclude = ALL,
				set of string sourceGroupsToInclude = ALL,
				boolean applyMarketingRestrictions = false
     ) := function
						
	      remove_restricted := kfetch(inputs, in_mod, JoinLimit, JoinType, applyMarketingRestrictions);

           addSourceRecInfo       := project(remove_restricted, Layouts.ConsumerToBipWorkRec0);		 
		 normalizeJobTitles     := normalize_mac(addSourceRecInfo, jobTitles, Layouts.ConsumerToBipWorkRec1,sourcesToInclude,sourceGroupsToInclude);
		 normalizeContactNames  := normalize_mac(normalizeJobTitles, contactNames, Layouts.ConsumerToBipWorkRec2,sourcesToInclude,sourceGroupsToInclude);
		 
		 normSourceInfoRecs     := normalize(normalizeContactNames, left.sourceInfo,
		                                     transform(Layouts.SourceInfoWorkRec3,
									            self := right,
									            self := left));											 
		 
           dedupSourceInfoRecs    := dedup(normSourceInfoRecs, UniqueID, ultid, orgid, seleid, contact_did, source, source_record_id,  all);
		 createChildDatasets    := project(dedupSourceInfoRecs,
		                                   transform(Layouts.SourceInfoWorkRec4,
									          self            := left,
											self.sourceInfo := dataset([{left.source,left.source_record_id}],Layouts.SourceInfoRec)));

           rollSourceInfo   := rollup(sort(createChildDatasets, uniqueID, ultid, orgid, seleid, contact_did), 
		                                  left.uniqueID    = right.uniqueID and
		                                  left.ultid       = right.ultid and
								    left.orgid       = right.orgid and
								    left.seleid      = right.seleid and
								    left.contact_did = right.contact_did, 
								    transform(Layouts.SourceInfoWorkRec4,
								              self.sourceInfo := left.sourceInfo + right.sourceInfo,
										    self            := left));
											    
		 changeToFinalForm      := project(normalizeContactNames,
		                                   transform(Layouts.ConsumerToBipFinalRec,
									          self.sourceInfo := dedup(left.sourceInfo(source!=''),source,source_record_id);
									          self            := left,
											self.job_title1 := left.job_title,
											self.job_title2 := '',
											self.job_title3 := ''));
	
	      sortFinalForm     := sort(changeToFinalForm(contact_did>0), uniqueID, ultid, orgid, seleid, contact_did);
		 
           rolljobTitle      := rollup(sortFinalForm, 
		                              left.uniqueID = right.uniqueID and
		                              left.ultid    = right.ultid and
								left.orgid    = right.orgid and
								left.seleid   = right.seleid and
								left.contact_did = right.contact_did, 
								transform(Layouts.ConsumerToBipFinalRec,
										self.dt_first_seen_at_business := if(right.dt_first_seen_at_business > 0 and right.dt_first_seen_at_business < left.dt_first_seen_at_business,
										                                     right.dt_first_seen_at_business, left.dt_first_seen_at_business);
										self.dt_last_seen_at_business  := if(right.dt_last_seen_at_business > left.dt_last_seen_at_business,
										                                     right.dt_last_seen_at_business, left.dt_last_seen_at_business);
                                                  newJobTitle     := if(right.job_title1 in [left.job_title1, left.job_title2, left.job_title3],
										                      '',right.job_title1);
	                                             self.job_title1 := left.job_title1,
										self.job_title2 := if(left.job_title2='',newJobTitle, left.job_title2),
										self.job_title3 := if(left.job_title3='' and left.job_title2!='',newJobTitle, left.job_title3),
										self            := left));
										

           addSourceInfo := join(rolljobTitle, rollSourceInfo,
		                       left.uniqueID    = right.uniqueID and
		                       left.ultid       = right.ultid and
						   left.orgid       = right.orgid and
						   left.seleid      = right.seleid and
						   left.contact_did = right.contact_did, 		 
						   transform(Layouts.ConsumerToBipFinalRec,
							        self.sourceInfo := right.sourceInfo,
								   self            := left));
									   
           adjustDates       := project(addSourceInfo, 
		                              transform(Layouts.ConsumerToBipFinalRec,
								          self.dt_first_seen_at_business := map(
										                                      left.dt_first_seen_at_business > left.dt_last_seen                                          => left.dt_last_seen,
																	   left.dt_first_seen_at_business < left.dt_first_seen and  left.dt_first_seen_at_business > 0 => left.dt_first_seen,
																	   left.dt_first_seen_at_business
																	   );
								          self.dt_last_seen_at_business  := map(
										                                      left.dt_last_seen_at_business  > left.dt_last_seen                                          => left.dt_last_seen,
																	   left.dt_last_seen_at_business  < left.dt_first_seen and left.dt_last_seen_at_business   > 0 => left.dt_first_seen,
																	   left.dt_last_seen_at_business
																	   );
						                    self := left));
	 
		 return adjustDates;
     end;
	
end;