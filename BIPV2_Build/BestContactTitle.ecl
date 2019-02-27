Import BIPV2, tools, AutoStandardI, InsuranceHeader_PostProcess, STD;

YEARS2 := 2*365;
YEARS7 := 7*365;

export BestContactTitle(typeof(key_contact_linkids.dkeybuild) contactKey = dataset([],recordof(BIPV2_Build.key_contact_linkids.dkeybuild)), 
                        unsigned TODAYS_DATE = STD.Date.Today()) := module
    slim_layout := {
                    BIPV2_Build.key_contact_linkids.Key.ultid,
                    BIPV2_Build.key_contact_linkids.Key.orgid,
                    BIPV2_Build.key_contact_linkids.Key.seleid,
                    BIPV2_Build.key_contact_linkids.Key.proxid,
                    BIPV2_Build.key_contact_linkids.Key.contact_did,
                    string10 seg_ind;
                    BIPV2_Build.key_contact_linkids.Key.dt_first_seen_contact,
                    BIPV2_Build.key_contact_linkids.Key.dt_last_seen_contact,
                    BIPV2_Build.key_contact_linkids.Key.contact_job_title_derived;
                    BIPV2_Build.key_contact_linkids.Key.executive_ind;
                    BIPV2_Build.key_contact_linkids.Key.executive_ind_order;										  
                    typeof(BIPV2_Build.key_contact_linkids.Key.dt_first_seen_contact) dt_first_seen_title,
                    typeof(BIPV2_Build.key_contact_linkids.Key.dt_last_seen_contact) dt_last_seen_title,
                    unsigned4 days_old_title;
                    unsigned4 days_old_contact;
                    unsigned data_permits;
                    };	
 				
    contacts_proj := project(contactKey, 
	                            transform(slim_layout, 
                                       self.dt_first_seen_title:=left.dt_first_seen_contact;
                                       self.dt_last_seen_title:=left.dt_last_seen_contact;
                                       days_old := STD.Date.DaysBetween(left.dt_last_seen_contact, TODAYS_DATE);
                                       self.days_old_contact := days_old;
                                       self.days_old_title := days_old;
                                       self.seg_ind:='UNKN'; 
                                       self.executive_ind_order := if(left.executive_ind_order=0, 9999, left.executive_ind_order);
                                       self.data_permits := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
                                       self:=left;));
 
    // Append Consumer Seg Ind
    seg_key := InsuranceHeader_PostProcess.segmentation_keys.key_did_ind;
		
    contacts_seg := join(table(contacts_proj(contact_did<>0), {contact_did}, contact_did), 
                                seg_key, 
                                KEYED(left.contact_did = right.did),
                                transform({contacts_proj.contact_did, seg_key.ind}, 
                                          self.ind := right.ind; 
                                          self:=left),
                                left outer, keep(1));

    contacts_with_lexid := join(contacts_proj(contact_did<>0), 
                                contacts_seg, 
                                left.contact_did = right.contact_did,
                                transform(slim_layout, 
                                          self.seg_ind := right.ind; 
                                          self:=left),
                                left outer, keep(1));
																
    slim_layout contactTitleValueRollup(slim_layout l, 	slim_layout r) := transform
        self.dt_first_seen_contact:= if(l.dt_first_seen_contact<>0, 
                                         if(r.dt_first_seen_contact<>0, 
                                             min(l.dt_first_seen_contact, r.dt_first_seen_contact),
                                             l.dt_first_seen_contact),
                                         r.dt_first_seen_contact);
        self.dt_last_seen_contact := max(l.dt_last_seen_contact, r.dt_last_seen_contact);
        self.dt_first_seen_title:= if(l.dt_first_seen_title<>0, 
                                       if(r.dt_first_seen_title<>0, 
                                           min(l.dt_first_seen_title, r.dt_first_seen_title),
                                           l.dt_first_seen_title),
                                       r.dt_first_seen_title);
        self.dt_last_seen_title := max(l.dt_last_seen_title, r.dt_last_seen_title);
        self.executive_ind := l.executive_ind or r.executive_ind;
        self.executive_ind_order := min(l.executive_ind_order, r.executive_ind_order);
        self.days_old_contact := min(l.days_old_contact, r.days_old_contact);
        self.days_old_title := min(l.days_old_title, r.days_old_title);
        self.data_permits := l.data_permits | r.data_permits;
        self := l;
    end;
 
 
    // Some contacts are prox level, sele level (proxid=0), ult level (prox&sele=0), and ult level(prox,sele,&org =0), 
    // so make sure best titles only use entries for thier level			
    prox_level_contacts :=         contacts_with_lexid(proxid<>0);
    sele_level_contacts := project(contacts_with_lexid(seleid<>0), transform(slim_layout, self.proxid:=0; self:=left));
    org_level_contacts  := project(contacts_with_lexid(orgid <>0), transform(slim_layout, self.proxid:=0; self.seleid:=0; self:=left));
    ult_level_contacts  := project(contacts_with_lexid(ultid <>0), transform(slim_layout, self.proxid:=0; self.seleid:=0; self.orgid:=0; self:=left));
 				
    titles_prox_s := sort(prox_level_contacts,                                   ultid, orgid, seleid, proxid, contact_did, contact_job_title_derived);
    titles_prox   := ROLLUP(titles_prox_s, contactTitleValueRollup(left, right), ultid, orgid, seleid, proxid, contact_did, contact_job_title_derived);	
 
    titles_sele_s := sort(sele_level_contacts,                                   ultid, orgid, seleid,         contact_did, contact_job_title_derived);
    titles_sele   := ROLLUP(titles_sele_s, contactTitleValueRollup(left, right), ultid, orgid, seleid,         contact_did, contact_job_title_derived);	
 
    titles_org_s  := sort(org_level_contacts,                                    ultid, orgid,                 contact_did, contact_job_title_derived);
    titles_org    := ROLLUP(titles_org_s,  contactTitleValueRollup(left, right), ultid, orgid,                 contact_did, contact_job_title_derived);	
 
    titles_ult_s  := sort(ult_level_contacts,                                    ultid,                        contact_did, contact_job_title_derived);
    titles_ult    := ROLLUP(titles_ult_s,  contactTitleValueRollup(left, right), ultid,                        contact_did, contact_job_title_derived);	
 
  
    agePrefTitle(unsigned days_old) := function
        return if(days_old<YEARS2, 1, if(days_old<YEARS7, 2, 3));
    end;
 
    title_layout := {
        unsigned title_rank;
        unsigned2 data_permits;
        unsigned2 accum_data_permits;
        BIPV2_Build.key_contact_linkids.Key.contact_job_title_derived;
        };
				
    slim_child_title_layout := {
        {slim_layout - contact_job_title_derived - dt_first_seen_title -dt_last_seen_title -days_old_title};
        dataset(title_layout) titles
        };				

 			
    // For each contact, rollup title rankings and set contacts data_permits
    slim_child_title_layout doRollupTitle(slim_layout l, DATASET(slim_layout) allRows) := TRANSFORM
        allrows_p := project(allRows, transform(title_layout, self.title_rank:=counter; self.accum_data_permits:=left.data_permits; self:=left));
        accum := iterate(allrows_p, transform(title_layout, 
                                              self.accum_data_permits := left.accum_data_permits | right.accum_data_permits; 
                                              self:=right));
        accum_keepers := rollup(accum, accum_data_permits, transform(left)); // if accum_data_permits is same, then lower ranking title could never be useful                
        self.titles                := accum_keepers;
        self.data_permits          := accum[count(accum)].accum_data_permits;
        self.days_old_contact      := min(allRows, days_old_contact);
        self.dt_first_seen_contact := min(allRows(dt_first_seen_contact<>0), dt_first_seen_contact);
        self.dt_last_seen_contact  := max(allRows, dt_last_seen_contact);
        self.executive_ind         := max(allRows, executive_ind); // this is a boolean so I hope max works like an OR
        self.executive_ind_order   := min(allRows, executive_ind_order);
        self.seg_ind               := l.seg_ind;
        self := l;
    END;

    // Choose best title by: 1)Has a title, 2)Prefred age range (0-2y, 2-7y, 7+y), 3)Executive order, 4)dt_last_seen_title
    prox_title_s    := sort(titles_prox,   ultid, orgid, seleid, proxid, contact_did, contact_job_title_derived='', agePrefTitle(days_old_title), executive_ind_order, -dt_last_seen_title);
    prox_title_g    := group(prox_title_s, ultid, orgid, seleid, proxid, contact_did);
    best_prox_title := rollup(prox_title_g, group, doRollupTitle(LEFT,ROWS(LEFT)));
 
    sele_title_s    := sort(titles_sele,   ultid, orgid, seleid, contact_did,         contact_job_title_derived='', agePrefTitle(days_old_title), executive_ind_order, -dt_last_seen_title);
    sele_title_g    := group(sele_title_s, ultid, orgid, seleid, contact_did);
    best_sele_title := rollup(sele_title_g, group, doRollupTitle(LEFT,ROWS(LEFT)));
 
    org_title_s     := sort(titles_org,    ultid, orgid, contact_did,                 contact_job_title_derived='', agePrefTitle(days_old_title), executive_ind_order, -dt_last_seen_title);
    org_title_g     := group(org_title_s,  ultid, orgid, contact_did);
    best_org_title  := rollup(org_title_g, group, doRollupTitle(LEFT,ROWS(LEFT)));
 
    ult_title_s     := sort(titles_ult,    ultid, contact_did,                        contact_job_title_derived='', agePrefTitle(days_old_title), executive_ind_order, -dt_last_seen_title);
    ult_title_g     := group(ult_title_s,  ultid, contact_did);
    best_ult_title  := rollup(ult_title_g, group, doRollupTitle(LEFT,ROWS(LEFT)));
	 
	 
    agePrefContact(unsigned days_old) := function
        return if(days_old<YEARS2, 1, 2);
    end;

    segmentationPrefContact(string10 seg) := function
        return map(seg='CORE'     => 1,
                   seg='DEAD'     => 2,
                   seg='NO_SSN'   => 3,
                   seg='C_MERGE'  => 4,
									          seg='INACTIVE' => 5,
                   seg='H_MERGE'  => 6,
                   7);
    end;
				
    contact_layout := {
        unsigned contact_rank;
        unsigned2 data_permits;
        unsigned2 accum_data_permits;
        BIPV2_Build.key_contact_linkids.Key.contact_did,
        dataset(title_layout) titles;
        };
 
  
   slim_child_contact_layout := {
       {slim_child_title_layout -contact_did -seg_ind -dt_first_seen_contact -dt_last_seen_contact -executive_ind -executive_ind_order - days_old_contact -data_permits -titles};
			  			dataset(contact_layout) contacts;
			  			};			
 
    // For each contact, rollup title rankings
    slim_child_contact_layout doRollupContact(slim_child_title_layout l, DATASET(slim_child_title_layout) allRows) := TRANSFORM
        allrows_p := project(allRows, transform(contact_layout, self.contact_rank:=counter; self.accum_data_permits:=left.data_permits; self:=left));
        accum := iterate(allrows_p, transform(contact_layout, 
                                              self.accum_data_permits := left.accum_data_permits | right.accum_data_permits; 
                                              self:=right));
        accum_keepers := rollup(accum, accum_data_permits, transform(left)); // if accum_data_permits is same, then lower ranking title could never be useful
        self.contacts := accum_keepers;
        self := l;
        END;

    //Choose best contact by: 1)Consumer segmentation 1)Prefred age range (0-2y, 2+y), 3)Executive order, 4)dt_last_seen_contact
    prox_contact_s    := sort(best_prox_title, ultid, orgid, seleid, proxid, segmentationPrefContact(seg_ind), agePrefContact(days_old_contact), executive_ind_order, -dt_last_seen_contact);
    prox_contact_g    := group(prox_contact_s, ultid, orgid, seleid, proxid);
    best_prox_contact := rollup(prox_contact_g, group, doRollupContact(LEFT,ROWS(LEFT)));

    sele_contact_s    := sort(best_sele_title, ultid, orgid, seleid,         segmentationPrefContact(seg_ind), agePrefContact(days_old_contact), executive_ind_order, -dt_last_seen_contact);
    sele_contact_g    := group(sele_contact_s, ultid, orgid, seleid);
    best_sele_contact := rollup(sele_contact_g, group, doRollupContact(LEFT,ROWS(LEFT)));

    org_contact_s     := sort(best_org_title,  ultid, orgid,                 segmentationPrefContact(seg_ind), agePrefContact(days_old_contact), executive_ind_order, -dt_last_seen_contact);
    org_contact_g     := group(org_contact_s,  ultid, orgid);
    best_org_contact  := rollup(org_contact_g, group, doRollupContact(LEFT,ROWS(LEFT)));

    ult_contact_s     := sort(best_ult_title, ultid,                         segmentationPrefContact(seg_ind), agePrefContact(days_old_contact), executive_ind_order, -dt_last_seen_contact);
    ult_contact_g     := group(ult_contact_s, ultid);
    best_ult_contact  := rollup(ult_contact_g, group, doRollupContact(LEFT,ROWS(LEFT)));


    flat_contact_title_layout := {
        unsigned contact_title_rank;
        unsigned2 data_permits;
        unsigned2 accum_data_permits;
        BIPV2_Build.key_contact_linkids.Key.contact_did,
        BIPV2_Build.key_contact_linkids.Key.contact_job_title_derived;
        };

    contact_title_layout := {
        flat_contact_title_layout - accum_data_permits
        };

    final_layout := {
        {slim_child_contact_layout - contacts};
        dataset(contact_title_layout) contact_title;
        };
				
    dataset(contact_title_layout) flatten(dataset(contact_layout) contacts) := function
        flat_contact_title_layout flattenContactTitles(contact_layout l, title_layout r, unsigned cntr) :=transform
              self.contact_title_rank := cntr;
              self.data_permits := r.data_permits;
	  																												self.accum_data_permits := r.data_permits;
                               self.contact_did := l.contact_did;
	  																												self.contact_job_title_derived := r.contact_job_title_derived;
		  		end;
      x := normalize(contacts, left.titles, transform(flat_contact_title_layout,
																																																					 self.contact_title_rank := counter;
																																																						self.data_permits := right.data_permits;
																																																						self.accum_data_permits := right.data_permits;
																																																						self.contact_did := left.contact_did;
																																																						self.contact_job_title_derived := right.contact_job_title_derived));
																																					
	  			accum := iterate(x, transform(flat_contact_title_layout, 
																																		self.accum_data_permits := left.accum_data_permits | right.accum_data_permits; 
																																		self.contact_title_rank := counter;
																																		self:=right));
	  		 accum_keepers := rollup(accum, accum_data_permits, transform(left)); // if accum_data_permits is same, then lower ranking title could never be useful
	  			return project(accum_keepers, contact_title_layout);
	  	end;
    
	  	prox_flat := project(best_prox_contact, transform(final_layout, self.contact_title := flatten(left.contacts); self := left));
	  	sele_flat := project(best_sele_contact, transform(final_layout, self.contact_title := flatten(left.contacts); self := left));
	  	org_flat  := project(best_org_contact,  transform(final_layout, self.contact_title := flatten(left.contacts); self := left));
	  	ult_flat  := project(best_ult_contact,  transform(final_layout, self.contact_title := flatten(left.contacts); self := left));
		
	  	AllBestUlt  := prox_flat + sele_flat + org_flat + ult_flat;
			 AllBestSele := prox_flat + sele_flat;
			 
		  export contact_title  := sort(AllBestSele,  ultid, orgid, seleid, proxid);
			 export layout := recordof(contact_title);

		end;