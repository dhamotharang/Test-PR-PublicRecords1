export ExtractContacts(inContacts, key_did_ind) := functionmacro
   contactDs      := project(inContacts, BIPV2_Contacts.Layouts.contact_linkids.layoutOrigFile);
   bestContacts   := BIPV2_Build.BestContactTitle(contactDs).contact_title(proxid=0);
   
   FlatContactRec := record
      inContacts.seleid;
      unsigned6 best_contact_did;
      string50 best_contact_job_title;
	 string10 best_contact_seg_ind;
   end;
   
   flattenRec := project(bestContacts,
                         transform(FlatContactRec,
					          self.best_contact_did       := left.contact_title[1].contact_did,
					          self.best_contact_job_title := left.contact_title[1].contact_job_title_derived,
							self.best_contact_seg_ind   := '',
							self                        := left));


   addDidSeg  := join(flattenRec, key_did_ind,
                      keyed(left.best_contact_did = right.did),
				  transform(FlatContactRec,
				            self.best_contact_seg_ind := right.ind,
						  self                      := left), left outer, keep(1));
  
   return addDidSeg;
endmacro;        