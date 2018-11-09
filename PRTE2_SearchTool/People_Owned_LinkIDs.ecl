import doxie_cbrs,TopBusiness_services;

EXPORT People_Owned_LinkIDs := Module
//read in busines_header_contacts_filepos

p_index := index( 	{unsigned6 ultid,unsigned6 orgid,unsigned6 seleid,unsigned6 proxid,unsigned6 powid,unsigned6 empid,unsigned6 dotid},
																						Layouts.bip_contact_linkid,
																						constants.Key_BipV2_Contacts);
																						
			//contact_job_title_derived

businesses := join(p_index,TopBusiness_services.ExecutiveTitles, 
					left.contact_job_title_derived = right.position_title,
					transform({unsigned6 did} or layouts.business_linkid_layout, 
															self.did := left.contact_did,
															self := left),
					lookup);

cmb_layout := record
		businesses.did;
		dataset(layouts.business_linkid_layout,ChooseN(50)) Businesses_linkids := dataset([],layouts.business_linkid_layout) ;
end;	
parent := project(businesses, transform(cmb_layout, self.Businesses_linkids := [], self.did := left.did));
cmb_layout	denormit(parent l, businesses r) := transform
 self.did := l.did;
	self.Businesses_linkids := l.Businesses_linkids + ROW({r.ultid, r.orgid, r.seleid}, layouts.business_linkid_layout);
end;
cmbd := denormalize(parent, businesses, left.did = right.did, denormit(left, right));

export records := dedup(cmbd, did, all);
//export records_count := count(cmbd); 




end;