import doxie,doxie_cbrs,dnb_services, dnb, iesp, Census_Data, Codes;

export Raw := module
				
		export Layouts.dnbNumberPlus byBDIDs(dataset(doxie_cbrs.layout_references) in_bdids,
                                       doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := function
			deduped := dedup(sort(in_bdids,bdid),bdid);
			joinup := join(deduped,dnb.Key_dnb_BDID,keyed(left.bdid = right.bd) and mod_access.use_DNB(),transform(Layouts.dnbNumberPlus,
				self.duns_number := right.duns_number,
				self.bdid := right.bd,
				self := right),limit(dnb_services.constants.max_recs_on_bdid_join, skip));
			dedup_joinup :=dedup(sort(joinup,record),record);
			// return joinup;
			// output(dedup_joinup);
			return dedup_joinup;
		end;		
		export Layouts.dnbNumberPlus bydunsnumber(dataset(Layouts.dnbNumberPlus) in_dunsnumber,
                                            doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := function
			deduped := dedup(sort(in_dunsnumber,duns_number),duns_number);
			joinup := join(deduped,dnb.Key_dnb_dunsNum,
											keyed(left.duns_number =  right.duns) and mod_access.use_DNB(),
												 transform(Layouts.dnbNumberPlus,														 
															 self.duns_number  := right.duns,
															 self.bdid := right.bdid,
															 self := right), limit(dnb_services.constants.max_recs_on_dnbNumber_join, skip));
													
			deduped_dnbnum := dedup(sort(joinup, duns_number,bdid), duns_number,bdid);
			
			//for debugging purpose
			// output(in_dunsnumber,named('Raw_in_dunsnumber'));
			// output(dedup_joinup,named('Raw_joinup'));
			// output(deduped_dnbnum,named('Raw_deduped_dnbnum'));
			
			return deduped_dnbnum;
		end;

  // Added new for the BIP project, but may be able to be used by others in the future.
  export Report_view := module

			export bydunsnumber(dataset(DNB_Services.Layouts.dnbNumberPlus) in_dunsnumber)
			       := function

			deduped := dedup(sort(in_dunsnumber,duns_number),duns_number);

			joinup := join(deduped,dnb.Key_dnb_dunsNum,
										   keyed(left.duns_number =  right.duns),
										 transform(DNB_Services.Layouts.rawrec,
											 self := right), 
										 limit(DNB_Services.Constants.max_recs_on_dnbNumber_join, skip));
													
			deduped_dnbnum := dedup(sort(joinup, duns_number), duns_number);
			
			//for debugging purpose
			// output(in_dunsnumber,named('Raw_in_dunsnumber'));
			// output(dedup_joinup,named('Raw_joinup'));
			// output(deduped_dnbnum,named('Raw_deduped_dnbnum'));
			
			//return deduped;
			return deduped_dnbnum;

	   end;

  end;
	
end;		
