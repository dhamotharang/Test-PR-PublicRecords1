import BIPV2_Build;
import InsuranceHeader_PostProcess;

export ExtractContacts := module        
     shared findValues(ds, field, layout) := functionmacro
        return project(table(ds(trim(field)<>''), 
                       {field, 
                        cnt                := count(group);                                                                                                                                                                                                                                       
                        first_seen_contact := min(group, dt_first_seen_contact);
                        last_seen_contact  := max(group, dt_last_seen_contact)
                       }, field, few), 
                       transform(layout, 
                                 self.dt_first_seen_contact := left.first_seen_contact;
                                 self.dt_last_seen_contact  := left.last_seen_contact;
                                 self                       := left));
     endmacro;
          
     // for a contact, rollup by FEILD determine count, start date, end date, for each FIELD value
     shared findValues2(ds, field, layout) := functionmacro
          layout doRollup(layout l, dataset(layout) allRows) := transform
               self.field                 := l.field;
               self.cnt                   := count(allRows);
               dt_first                   := min(allRows(dt_first_seen_contact<>0), dt_first_seen_contact);;
               dt_last                    := max(allRows, dt_last_seen_contact);
               self.dt_first_seen_contact := if(dt_first=0, dt_last, dt_first);                                                                                                                   
               self.dt_last_seen_contact  := if(dt_last=0, dt_first, dt_last);
           end;
		 
           ds_withVal := group(project(sort(ds(trim(field)<>''), field), transform(layout, self.cnt:=1; self:=left)), field);
           return rollup(ds_withVal, group, doRollup(left,rows(left)));
    endmacro;

          
    export extractContactInfo(typeof(BIPV2_Build.key_contact_linkids.Key) contactKeyDs,
                              typeof(InsuranceHeader_PostProcess.segmentation_keys.key_did_ind) key_did_ind) := function
                                                                           
          Layouts.ContactSeleLayout seleProxDidRollup(recordof(BIPV2_Build.key_contact_linkids.Key) l, typeof(BIPV2_Build.key_contact_linkids.Key) allRows) := transform
               self.contact_type   := findValues2(allRows, contact_type_derived,      Layouts.ContactTypeLayout);
               self.job_title      := findValues2(allRows, contact_job_title_derived, Layouts.JobTitleLayout);
               self.contact_status := findValues2(allRows, contact_status_derived,    Layouts.ContactStatusLayout);                                     
               self.executive      := project(table(allRows(executive_ind_order<>0), {executive_ind, executive_ind_order, cnt:=count(group)}, executive_ind, executive_ind_order, few), Layouts.ExecutiveLayout);
               dt_first := min(allRows(dt_first_seen_contact<>0), dt_first_seen_contact);;
               dt_last  := max(allRows, dt_last_seen_contact);
               self.dt_first_seen_contact:= if(dt_first=0, dt_last, dt_first);                                                                                                                   
               self.dt_last_seen_contact := if(dt_last=0, dt_first, dt_last);
               self.seg_ind := 'UNKN';
               self := l;
          end;
          
          //Rollup by sele/prox/contact_did
          sele_prod_did_g := group(sort(contactKeyDs, seleid, proxid, contact_did, local),     seleid, proxid, contact_did);
          sele_did_roll   := ungroup(rollup(sele_prod_did_g, group, seleProxDidRollup(left,rows(left))));     
                    
          // Append Consumer Seg Ind
          sele_did_roll_app := join(sele_did_roll, key_did_ind, 
                                    keyed(left.contact_did = right.did),
                                    transform(Layouts.ContactSeleLayout, 
                                              self.seg_ind := right.ind; 
                                              self:=left), left outer, keep(1));
                                                                                                                                                                                                                                                                         
          Layouts.ResultLayout seleRollup(Layouts.ContactSeleLayout l, dataset(Layouts.ContactSeleLayout) allRows) := transform
               self.contacts   := project(allRows, Layouts.ContactProxLayout);
               self := l;
          end;                                                                                
                              
          // Rollup by Seleid
          sele_g        := group(sort(sele_did_roll_app, seleid, proxid, local), seleid);
          sele_roll     := rollup(sele_g, group, seleRollup(left,rows(left)));
          
          contactsBySeleidProxid := distribute(ungroup(sele_roll), hash32(seleid));
          return contactsBySeleidProxid;
  end;
     
end;