import Liensv2,MDR;

export Liens_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base_main  := LiensV2.file_allsources_base.main;
	shared base_party := LiensV2.file_allsources_base.party;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered_party := base_party(tmsid != '' and 
		                             cname != '' and cname not in ['PRO SE','PRO-SE']); // ???
		
		extract := normalize(filtered_party,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source          := MDR.sourceTools.src_Liens_v2,
				self.source_docid    := trim(left.tmsid,left,right), // NOTE: tmsid length is 50 
				//                      which is longer than source_docid can currently handle ???
				// v--- may need to revise ??? 
				self.source_party    := left.name_type[1] + intformat(hash32(left.cname,left.orig_address1,left.orig_address2,left.orig_city,left.orig_state,left.orig_zip5) % 1000000000,9,1),
			  //                      ^--- name_type values: 
				//                      A  = Attorney
			  //                      AD = Attorney for debtor; conflicts with "A" if we  
				//                           just use name_type[1], but does it matter         ???
        //                      C  = Plaintiff or Creditor 
				//                      D  = Defendant or Debtor 
				//                      T  = Third party
				self.date_first_seen := (unsigned4) (left.date_first_seen),
				self.date_last_seen  := (unsigned4) (left.date_last_seen),
				self.company_name    := stringlib.StringToUpperCase(left.cname),
				self.company_name_type := Constants.company_name_types.UNKNOWN,
				self.address_type := Constants.address_types.UNKNOWN,
				self.phone_type := Constants.phone_types.UNKNOWN,
				self.aid             := 0,
				self.prim_range      := left.prim_range,
				self.predir          := left.predir,
				self.prim_name       := left.prim_name,
				self.addr_suffix     := left.addr_suffix,
				self.postdir         := left.postdir,
				self.unit_desig      := left.unit_desig,
				self.sec_range       := left.sec_range,
				self.city_name       := choose(counter,left.p_city_name,left.v_city_name),
				self.state           := left.st,
				self.zip             := left.zip,
				self.zip4            := left.zip4,
				self.county_fips     := left.county[3..5],
				self.msa             := left.msa,
				self.phone           := left.phone, // length =20 on liens base party file  ???
				self.fein            := if (left.cname != '', left.tax_id, ''); 
				self.url             := '',
				self.duns            := '',
				self.experian        := '',
				self.zoom := '',
				self.incorp_state    := '',
				self.incorp_number   := ''
		));		
		
		return extract;	

	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function

		company_filtered := base_party(tmsid != '' and cname != '');
		person_filtered := base_party(tmsid != '' and lname != '');
		
		codebtors := join(
			company_filtered(name_type = 'D'),
			person_filtered(name_type = 'D'),
			left.tmsid = right.tmsid,
			transform(Layout_Contacts.Unlinked,
				self.source          := MDR.sourceTools.src_Liens_v2,
				self.source_docid    := trim(left.tmsid,left,right), // NOTE: tmsid length is 50 
				self.source_party    := left.name_type[1] + intformat(hash32(left.cname,left.orig_address1,left.orig_address2,left.orig_city,left.orig_state,left.orig_zip5) % 1000000000,9,1),
				self.date_first_seen := (unsigned4) (left.date_first_seen),
				self.date_last_seen  := (unsigned4) (left.date_last_seen),
				self.ssn := right.ssn,
				self.did := (unsigned)right.did,
				self.score := 0,
				self.name_prefix := right.title,
				self.name_first := right.fname,
				self.name_middle := right.mname,
				self.name_last := right.lname,
				self.name_suffix := right.name_suffix,
				self.addr_suffix := right.addr_suffix,
				self.city_name := right.p_city_name,
				self.zip := right.zip,
				self.state := right.st,
				self.position_title := 'Co-Debtors',
				self.position_type := 'O',
				self.email := '',
				self.phone := right.phone,
				self := right));
		
		return codebtors;
				
	end;
		
	export dataset(TopBusiness.Layout_Liens.main.unlinked) As_Liens_Master := function
		
		filtered_main := base_main(tmsid != '');
		
   // Extract the needed fields normalizing the filing_status child dataset recs.
    Layout_Liens.main.unlinked norm_xform(
		               liensv2.layout_base_allsources_main.rec l, 
                   liensv2.layout_base_allsources_main.layout_filing_status r) := transform
			  self.source              := MDR.sourceTools.src_Liens_v2,
		    self.source_docid        := trim(l.tmsid,left,right), 
				//self.rmsid               := left.rmsid, // is this needed ???
		    self.filing_jurisdiction := l.filing_jurisdiction,
	      self.orig_filing_number  := l.orig_filing_number,
	      self.orig_filing_type    := l.orig_filing_type,
	      self.orig_filing_date    := l.orig_filing_date,
				self.release_date        := l.release_date;
				self.amount              := l.amount;
				self.eviction            := l.eviction;
        self.satisfaction_type   := l.satisifaction_type;
        self.judg_satisfied_date := l.judg_satisfied_date;
        self.judg_vacated_date   := l.judg_vacated_date;
		    self.lapse_date          := l.lapse_date;
				self.expiration_date     := l.expiration_date;
				self.filing_number       := if(l.filing_number !='',l.filing_number,
				                               if(l.case_number !='',l.case_number,''));
	      self.filing_type_desc    := l.filing_type_desc,
	      self.filing_date         := l.filing_date,
	      self.filing_book         := l.filing_book,
	      self.filing_page         := l.filing_page,				
				self.agency              := l.agency;
				self.agency_state        := l.agency_state;
				self.agency_county       := l.agency_county;
        // v--- these fields are built from the filing_status (r) child dataset recs
        self.filing_status       := r.filing_status;
        self.filing_status_desc  := r.filing_status_desc;
    end;

    extract := normalize(filtered_main,
                         left.filing_status,
                         norm_xform(left,right));
			
	  return extract;	    

	end;


  // Extract party rec info matched to main rec info for the brm party file
	export dataset(Layout_Liens.Party) As_Liens_Master_Party := function
				
    filtered_party := base_party(tmsid != '');
	
		extract := project(filtered_party,
		  transform(Layout_liens.party,
				// fields from the party file that need their field name changed
				self.party_type := left.name_type, // change field name to party_type for consistency
				// may need to change name_type=AD to 1 char type ???
				// store appended ssn&taxid fields in separate fields or store into ssn & taxid ???
				// get all other fields from the base party file, with the same field names
				self            := left
		));		

		return extract;

	end;
		
end;