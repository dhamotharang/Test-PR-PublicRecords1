import BIPV2_Seleid_Relative,ut,BizLinkFull,bipv2_build,tools;

EXPORT Key_BH_Relationship_SELEID := module

  export keyversions(string pversion = 'qa',boolean pUseOtherEnvironment = false) := tools.macf_FilesIndex('BIPV2_Seleid_Relative.Keys(DATASET([],BIPV2_Seleid_Relative.layout_Base)).ASSOC',BIPV2_Seleid_Relative.keynames(pversion,pUseOtherEnvironment).assoc);
  
                export Key := keyversions().qa; // QA version of key.  Should be used for debugging only
                // export Key := index(BIPV2_Seleid_Relative.Keys(DATASET([],BIPV2_Seleid_Relative.layout_Base)).ASSOC,BIPV2_Seleid_Relative.keynames().assoc.qa); // Should be used for debugging only
                
                export l_kFetch_in := {BIPV2.IDlayouts.l_xlink_ids.SELEID};
                
                export kFetch(dataset(l_kFetch_in) inputs,
                              joinLimit = ut.limits.DEFAULT) := function
                                fetched := 
                                join(
                                                dedup(sort(inputs,seleid),seleid), Key,
                                                keyed(left.seleid = right.seleid1),
                                                transform(right),
                                                keep(joinLimit)                                    
                                )(not((contact_score+mname_score) >= total_score and contact_score < 100));//bug 143472 - filter out relationships that are by contact only and score < 100.  if you put this filter in the join, then the keep no longer protects against failures.
                                upped :=
                                join(
                                                fetched,
                                                BizLinkFull.Process_Biz_Layouts.KeyseleidUp,
                                                keyed(left.seleid2 = right.seleid),
                                                transform(
                                                                {fetched, BizLinkFull.Process_Biz_Layouts.id_stream_layout.orgid, BizLinkFull.Process_Biz_Layouts.id_stream_layout.ultid},
                                                                self.orgid := right.orgid,
                                                                self.ultid := right.ultid,
                                                                self := left
                                                ),
                                                keep(1)
                                );
                                return upped;
                end;

end;
