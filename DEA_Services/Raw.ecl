import doxie,doxie_cbrs,DEA_services, DEA, iesp, Census_Data, Codes,UT;

export Raw := module
		export Layouts.DEANumberPlus byDIDs(dataset(doxie.layout_references) in_dids) := function		
			deduped := dedup(sort(in_dids,did),did);
			joinup := join(deduped,DEA.Key_DEA_did,keyed(left.did= right.my_did),transform(Layouts.DEANumberPlus,
				self.Dea_Registration_Number := right.Dea_Registration_Number,
				self.did := right.my_did,
				self.bdid := 0,
				// self.isDeepDive := left.isDeepDive,
				self := right), limit(ut.limits.DEA_PER_DID, skip));
			return joinup;
		end;
				
		export Layouts.DEANumberPlus byBDIDs(dataset(doxie_cbrs.layout_references) in_bdids) := function
			deduped := dedup(sort(in_bdids,bdid),bdid);
			joinup := join(deduped,DEA.Key_DEA_BDID,keyed(left.bdid = right.bd),transform(Layouts.DEANumberPlus,
				self.Dea_Registration_Number := right.Dea_Registration_Number,
				self.did := (unsigned6) right.did,
				self.bdid := right.bd,
				 //self.isDeepDive := left.isDeepDive,
				self := right),limit(ut.limits.DEA_PER_BDID, skip));
				
			return joinup;
		end;		
		export Layouts.DEANumberPlus byRegistrationNumber(dataset(Layouts.DEANumberPlus) in_RegistrationNumber) := function
			deduped := dedup(sort(in_RegistrationNumber,Dea_Registration_Number),Dea_Registration_Number);
			joinup := join(deduped,DEA.Key_dea_reg_num,
											keyed(left.Dea_Registration_Number =  right.Dea_Registration_Number),
												 transform(Layouts.DEANumberPlus,														 
															 self.Dea_Registration_Number  := right.Dea_Registration_Number,
															 self.bdid := 0,
															 self.did := (unsigned6) right.did,
															 self := right), limit(ut.limits.DEA_MAX, skip));
													
			// deduped_Regnum := dedup(sort(joinup, DEA_id), DEA_id);
			// return deduped_lnum;
			return joinup;
		end;
	
end;