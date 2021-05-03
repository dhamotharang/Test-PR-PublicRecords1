import BIPV2_Crosswalk;
import BIPV2;
import AutoStandardI;
import doxie;

export Key_BipToConsumer := module
     export Key := BIPV2_Crosswalk.Keys().BipToConsumerKey();
     export Keyvs(string pversion = '',boolean pUseOtherEnvironment = false) := BIPV2_Crosswalk.Keys(pversion,pUseOtherEnvironment).bipToConsumer;
     
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
                    boolean applyMarketingRestrictions = false,
                    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END

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
          
          BIPV2_Crosswalk.mac_check_access(marketingRestrictions, marketingRestrictions_out, mod_access);
          BIPV2_Crosswalk.mac_check_access(ds_restricted, ds_restricted_out, mod_access);
          
          return if(applyMarketingRestrictions, marketingRestrictions_out, ds_restricted_out);     
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
                    dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
                    string1 Level = BIPV2.IDconstants.Fetch_Level_ProxID, //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                                          //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                                          //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
                    BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
                    JoinLimit=25000,
                    unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin,
                    set of string sourcesToInclude = ALL,
                    set of string sourceGroupsToInclude = ALL,
                    boolean applyMarketingRestrictions = false,
                    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
										boolean execsOnly = true
     ) := function
           remove_restricted := kfetch(inputs, level, in_mod, JoinLimit, JoinType, applyMarketingRestrictions, mod_access);
           
           addSourceRecInfo       := project(remove_restricted, Layouts.BipToConsumerWorkRec0);
           normalizeContactNames  := normalize_mac(addSourceRecInfo, contactNames, Layouts.BipToConsumerWorkRec1,sourcesToInclude,sourceGroupsToInclude);
           normalizeSSNs          := normalize_mac(normalizeContactNames, contactSSNs, Layouts.BipToConsumerWorkRec2,sourcesToInclude,sourceGroupsToInclude);
           normalizeDOBs          := normalize_mac(normalizeSSNs, contactDOBs, Layouts.BipToConsumerWorkRec3,sourcesToInclude,sourceGroupsToInclude);
           normalizeEmails        := normalize_mac(normalizeDOBs, contactEmails, Layouts.BipToConsumerWorkRec4,sourcesToInclude,sourceGroupsToInclude);
           normalizePhones        := normalize_mac(normalizeEmails, contactPhones, Layouts.BipToConsumerWorkRec5,sourcesToInclude,sourceGroupsToInclude);
           normalizeAddresses     := normalize_mac(normalizePhones, contactAddresses, Layouts.BipToConsumerWorkRec6,sourcesToInclude,sourceGroupsToInclude);
           normalizeJobTitles     := normalize_mac(normalizeAddresses, jobTitles, Layouts.BipToConsumerWorkRec7,sourcesToInclude,sourceGroupsToInclude);
                      
           normSourceInfoRecs     := normalize(normalizeJobTitles, left.sourceInfo,
                                               transform(Layouts.SourceInfoWorkRec1,
                                                         self := right,
                                                         self := left));                                                        
           
           dedupSourceInfoRecs    := dedup(normSourceInfoRecs, UniqueID, ultid, orgid, seleid, contact_did, source, source_record_id, all);
           createChildDatasets    := project(dedupSourceInfoRecs,
                                             transform(Layouts.SourceInfoWorkRec2,
                                                       self            := left,
                                                       self.sourceInfo := dataset([{left.source,left.source_record_id}],Layouts.SourceInfoRec)));

           rollSourceInfoLexId   := rollup(sort(createChildDatasets(contact_did>0), uniqueID, ultid, orgid, seleid, contact_did), 
                                                 left.uniqueID    = right.uniqueID and
                                                 left.ultid       = right.ultid and
                                                 left.orgid       = right.orgid and
                                                 left.seleid      = right.seleid and
                                                 left.contact_did = right.contact_did, 
                                                 transform(Layouts.SourceInfoWorkRec2,
                                                           self.sourceInfo := left.sourceInfo + right.sourceInfo,
                                                           self            := left));
                                                           
           rollSourceInfoEmpId    := rollup(sort(createChildDatasets(contact_did=0 and empId>0), uniqueID, ultid, orgid, seleid, empid), 
                                                 left.uniqueID    = right.uniqueID and
                                                 left.ultid       = right.ultid and
                                                 left.orgid       = right.orgid and
                                                 left.seleid      = right.seleid and
                                                 left.empid       = right.empid, 
                                                 transform(Layouts.SourceInfoWorkRec2,
                                                           self.sourceInfo := left.sourceInfo + right.sourceInfo,
                                                           self            := left));
                      
           changeToWorkForm      := project(normalizeJobTitles,
                                             transform(Layouts.BipToConsumerWorkRec8,
                                                       self.sourceInfo := dedup(left.sourceInfo(source!=''),source,source_record_id);
                                                       self            := left,
                                                       self.job_title1 := left.job_title,
                                                       self.job_title2 := '',
                                                       self.job_title3 := ''));
     
           sortFinalFormLexId     := sort(changeToWorkForm(contact_did>0), uniqueID, ultid, orgid, seleid, contact_did, jobTitleOrder, executive_ind_order, -dt_title_last_seen);
           sortFinalFormEmpId     := sort(changeToWorkForm(contact_did=0 and empId>0), uniqueID, ultid, orgid, seleid, empid, jobTitleOrder, executive_ind_order, -dt_title_last_seen);
           
           rolljobTitleLexID  := rollup(sortFinalFormLexId, 
                                        left.uniqueID    = right.uniqueID and
                                        left.ultid       = right.ultid and
                                        left.orgid       = right.orgid and
                                        left.seleid      = right.seleid and
                                        left.contact_did = right.contact_did, 
                                        transform(Layouts.BipToConsumerWorkRec8, 
                                                  self.dt_first_seen_at_business := if(right.dt_first_seen_at_business > 0 and right.dt_first_seen_at_business < left.dt_first_seen_at_business,
                                                                                       right.dt_first_seen_at_business, left.dt_first_seen_at_business);
                                                  self.dt_last_seen_at_business  := if(right.dt_last_seen_at_business > left.dt_last_seen_at_business,
                                                                                       right.dt_last_seen_at_business, left.dt_last_seen_at_business);
                                                  newJobTitle     := if(right.job_title1 in [left.job_title1, left.job_title2, left.job_title3] or (execsOnly and right.executive_ind_order=0),
                                                                        '',right.job_title1);
                                                  self.job_title1 := if(left.job_title1='' or (execsOnly and left.executive_ind_order=0),newJobTitle,left.job_title1);
                                                  self.job_title2 := if(left.job_title2='' and self.job_title1!=newJobTitle and self.job_title1!='',newJobTitle, left.job_title2),
                                                  self.job_title3 := if(left.job_title3='' and left.job_title2!='',newJobTitle, left.job_title3),
                                                  self            := left));
                                                  
           rolljobTitleEmpID  := rollup(sortFinalFormEmpId, 
                                        left.uniqueID    = right.uniqueID and
                                        left.ultid       = right.ultid and
                                        left.orgid       = right.orgid and
                                        left.seleid      = right.seleid and
                                        left.empid       = right.empid, 
                                        transform(Layouts.BipToConsumerWorkRec8,      
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

           addSourceInfoLexID := join(rolljobTitleLexID, rollSourceInfoLexId,
                                      left.uniqueID    = right.uniqueID and
                                      left.ultid       = right.ultid and
                                      left.orgid       = right.orgid and
                                      left.seleid      = right.seleid and
                                      left.contact_did = right.contact_did,            
                                      transform(Layouts.BipToConsumerFinalRec,
                                                self.sourceInfo := right.sourceInfo,
                                                self            := left));
                                               
           addSourceInfoEmpID := join(rolljobTitleEmpId, rollSourceInfoEmpId,
                                      left.uniqueID    = right.uniqueID and
                                      left.ultid       = right.ultid and
                                      left.orgid       = right.orgid and
                                      left.seleid      = right.seleid and
                                      left.empid       = right.empid,            
                                      transform(Layouts.BipToConsumerFinalRec,
                                                self.sourceInfo := right.sourceInfo,
                                                self            := left));
                                               
           adjustDates       := project(addSourceInfoLexID + addSourceInfoEmpID + project(changeToWorkForm(empId = 0 and contact_did=0),Layouts.BipToConsumerFinalRec) , 
                                        transform(Layouts.BipToConsumerFinalRec,
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
					
     export kFetch_thor(
         string1                    Level                       = BIPV2.IDconstants.Fetch_Level_ProxID 
        ,BIPV2.mod_sources.iParams  in_mod                      = PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
        ,boolean                    applyMarketingRestrictions  = false
        ,doxie.IDataAccess          mod_access                  = MODULE (doxie.IDataAccess) END
        ,string                     pKeyVersion                 = 'qa'
        ,boolean                    pUseOtherEnvironment        = false
     ) := function

          keyversion := Keyvs(pKeyVersion,pUseOtherEnvironment).logical;
          
					bip2Consumer  := pull(keyversion);
          allowCodeBmap := BIPV2.mod_Sources.code2bmap(BIPV2.mod_Sources.code.MARKETING_UNRESTRICTED);

          bip2Consumer apply_restrict(bip2Consumer L) := transform
               self.contactNames                 := restrict(L.contactNames, in_mod, contact_name_permits,, true); 
               self.contactSSNs                  := restrict(L.contactSSNs, in_mod, contact_ssn_permits,, true); 
               self.contactDOBs                  := restrict(L.contactDOBs, in_mod, contact_dob_permits,, true); 
               self.contactPhones                := restrict(L.contactPhones, in_mod, contact_phone_permits,, true); 
               self.contactEmails                := restrict(L.contactEmails, in_mod, contact_email_permits,, true); 
               self.contactAddresses             := restrict(L.contactAddresses, in_mod, contact_address_permits,, true); 
               self.jobTitles                    := restrict(L.jobTitles, in_mod, job_title_permits,, true); 
               self := L;
          end;
          ds_restricted := project(bip2Consumer, apply_restrict(left));
										
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

          remove_restricted := if(applyMarketingRestrictions, marketingRestrictions, ds_restricted);     
										
          BIPV2_Crosswalk.mac_check_access(remove_restricted, remove_restricted_ccpa, mod_access);							

          withContactDids := remove_restricted_ccpa(contact_did>0);
          withEmpids      := remove_restricted_ccpa(empid>0 and contact_did=0);
          withNoids       := remove_restricted_ccpa(empid=0 and contact_did=0);
					
					sortContactDids := sort(distribute(withContactDids, hash32(seleid)), seleid, contact_did, local);
					sortEmpIds      := sort(distribute(withEmpids, hash32(seleid)), seleid, empid, local);
			 
					rollContactDids := rollup(sortContactDids, left.seleid = right.seleid and left.contact_did=right.contact_did,
					                          transform(recordof(remove_restricted_ccpa),
																		          self.contactNames     := left.contactNames + right.contactNames,
																		          self.contactSSNs      := left.contactSSNs + right.contactSSNs,
																		          self.contactDOBs      := left.contactDOBs + right.contactDOBs,
																		          self.contactEmails    := left.contactEmails + right.contactEmails,
																		          self.contactPhones    := left.contactPhones + right.contactPhones,
																		          self.contactAddresses := left.contactAddresses + right.contactAddresses,
																		          self.jobTitles        := left.jobTitles + right.jobTitles,
																							self                  := left),local);
																		
					rollEmpIds      := rollup(sortEmpIds, left.seleid = right.seleid and left.empid=right.empid,
					                          transform(recordof(remove_restricted_ccpa),
																		          self.contactNames     := left.contactNames + right.contactNames,
																		          self.contactSSNs      := left.contactSSNs + right.contactSSNs,
																		          self.contactDOBs      := left.contactDOBs + right.contactDOBs,
																		          self.contactEmails    := left.contactEmails + right.contactEmails,
																		          self.contactPhones    := left.contactPhones + right.contactPhones,
																		          self.contactAddresses := left.contactAddresses + right.contactAddresses,
																		          self.jobTitles        := left.jobTitles + right.jobTitles,
																							self                  := left),local);
	
	        rollSeleIDs      := rollEmpIds + rollContactDids + withNoids;
					
					finalDs          := if(Level = BIPV2.IDconstants.Fetch_Level_SeleID, rollSeleIDs, remove_restricted_ccpa);

					return finalDs;   
     end;
end;