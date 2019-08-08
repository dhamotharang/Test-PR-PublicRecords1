import BIPV2_Crosswalk;
import BIPV2;
import AutoStandardI;

export Key_BipToConsumer := module
     export Key := BIPV2_Crosswalk.Keys().BipToConsumerKey();

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
                    dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
                    string1 Level = BIPV2.IDconstants.Fetch_Level_ProxID, //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                                          //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                                          //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
                    BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
                    JoinLimit=25000,
                    unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin,
				boolean applyMarketingRestrictions = false
     ) := function
          BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, ds_fetched, Level, JoinLimit, JoinType);
	     allowCodeBmap := BIPV2.mod_Sources.code2bmap(BIPV2.mod_Sources.code.MARKETING_UNRESTRICTED);
		
          // apply restrictions in child datasets       
          ds_fetched apply_restrict(ds_fetched L) := transform
               self.contactNames                 := restrict(L.contactNames, in_mod, contact_name_permits,, true); 
               self.contactSSNs                  := restrict(L.contactSSNs, in_mod, contact_ssn_permits,, true); 
               self.contactDOBs                  := restrict(L.contactDOBs, in_mod, contact_dob_permits,, true); 
               self.contactPhones                := restrict(L.contactPhones, in_mod, contact_phone_permits,, true); 
               self.contactEmails                := restrict(L.contactEmails, in_mod, contact_email_permits,, true); 
               self.contactAddresses             := restrict(L.contactAddresses, in_mod, contact_address_permits,, true); 
		     self.jobTitles                    := restrict(L.jobTitles, in_mod, job_title_permits,, true); 
               self := L;
          end;
          ds_restricted := project(ds_fetched, apply_restrict(left));

	     recordof(ds_restricted) apply_src_filter(recordof(ds_restricted) L) := transform
		     // NOTE: These filter the "sources" child dataset when applicable, but not all sections have that
               self.contactNames                 := filterSrcCode(L.contactNames, contact_name_permits,, allowCodeBmap); 
               self.contactSSNs                  := filterSrcCode(L.contactSSNs, contact_ssn_permits,, allowCodeBmap); 
               self.contactDOBs                  := filterSrcCode(L.contactDOBs, contact_dob_permits,, allowCodeBmap); 
               self.contactPhones                := filterSrcCode(L.contactPhones, contact_phone_permits,, allowCodeBmap); 
               self.contactEmails                := filterSrcCode(L.contactEmails, contact_email_permits,, allowCodeBmap); 
               self.contactAddresses             := filterSrcCode(L.contactAddresses, contact_address_permits,, allowCodeBmap); 
		     self.jobTitles                    := filterSrcCode(L.jobTitles, job_title_permits,, allowCodeBmap); 
               self := L;
	     end;
		
		marketingRestrictions :=  project(ds_restricted, apply_src_filter(left));
		
		return if(applyMarketingRestrictions, marketingRestrictions, ds_restricted);
     end;


     shared normalize_mac(inDs, normalize_field, newLayout) := functionmacro
	     no_recs_to_normalize := project(inDs(count(normalize_field)=0), 
		                                transform(newLayout,
								            self := left,
										  self := []));
		
		normalize_recs       := normalize(inDs(count(normalize_field)>0),
		                                  left.normalize_field,
								    transform(newLayout,
								              self := left, 
										    self := right));
										    
          return normalize_recs + 	no_recs_to_normalize;									    
	endmacro;
	
     export getDataFiltered(
                    dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
                    string1 Level = BIPV2.IDconstants.Fetch_Level_ProxID, //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                                          //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                                          //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
                    BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
                    JoinLimit=25000,
                    unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin,
				set of string sourcesToInclude = ALL,
				set of string sourceGroupsToInclude = ALL,
				boolean applyMarketingRestrictions = false
     ) := function
	      remove_restricted := kfetch(inputs, level, in_mod, JoinLimit, JoinType, applyMarketingRestrictions);
		 
		 normalizeContactNames  := normalize_mac(remove_restricted, contactNames, Layouts.BipToConsumerWorkRec1);
		 normalizeSSNs          := normalize_mac(normalizeContactNames, contactSSNs, Layouts.BipToConsumerWorkRec2);
		 normalizeDOBs          := normalize_mac(normalizeSSNs, contactDOBs, Layouts.BipToConsumerWorkRec3);
		 normalizeEmails        := normalize_mac(normalizeDOBs, contactEmails, Layouts.BipToConsumerWorkRec4);
		 normalizePhones        := normalize_mac(normalizeEmails, contactPhones, Layouts.BipToConsumerWorkRec5);
		 normalizeAddresses     := normalize_mac(normalizePhones, contactAddresses, Layouts.BipToConsumerWorkRec6);
		 normalizeJobTitles     := normalize_mac(normalizeAddresses, jobTitles, Layouts.BipToConsumerWorkRec7);
		 
		 filterSourcesAndGroups := normalizeJobTitles(source in sourcesToInclude and sourceGroup in sourceGroupsToInclude);
		 
		 changeToFinalForm      := project(filterSourcesAndGroups,
		                                   transform(Layouts.BipToConsumerFinalRec,
									          self            := left,
											self.job_title1 := left.job_title,
											self.job_title2 := '',
											self.job_title3 := ''));
	
	      sortFinalFormLexId     := sort(changeToFinalForm(contact_did>0), uniqueID, ultid, orgid, seleid, contact_did);
	      sortFinalFormEmpId     := sort(changeToFinalForm(contact_did=0 and empId>0), uniqueID, ultid, orgid, seleid, empid);
		 
           rolljobTitleLexID  := rollup(sortFinalFormLexId, 
		                              left.uniqueID    = right.uniqueID and
		                              left.ultid       = right.ultid and
								left.orgid       = right.orgid and
								left.seleid      = right.seleid and
								left.contact_did = right.contact_did, 
								transform(Layouts.BipToConsumerFinalRec, 
								          skip(right.job_title1 in [left.job_title1, left.job_title2, left.job_title3]),
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
										
           rolljobTitleEmpID  := rollup(sortFinalFormEmpId, 
		                              left.uniqueID    = right.uniqueID and
		                              left.ultid       = right.ultid and
								left.orgid       = right.orgid and
								left.seleid      = right.seleid and
								left.empid       = right.empid, 
								transform(Layouts.BipToConsumerFinalRec, 	
								          skip(right.job_title1 in [left.job_title1, left.job_title2, left.job_title3]),
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

		 return rolljobTitleLexID + rolljobTitleEmpID + changeToFinalForm(empId = 0 and contact_did=0);
     end;
end;