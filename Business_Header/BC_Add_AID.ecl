import AID, ut;

export BC_Add_AID(

	dataset(Layout_Business_Contacts_Temp	)	pBC_Scored	= BC_Scored	()											

) :=
function
	
	Layout_BC_seq := record
		Layout_Business_Contacts_Temp;
		unsigned6 rec_seq := 0;
	end;
	
	BC_Scored_seq := project(pBC_Scored, transform(Layout_BC_seq, self := left, self.rec_seq := counter)) : persist('~thor_data400::persist::business_header::BC_Add_AID::BC_Scored_seq');
	
	Layout_norm := record
		Layout_BC_seq.prim_range;
		Layout_BC_seq.predir;
		Layout_BC_seq.prim_name;
		Layout_BC_seq.addr_suffix;
		Layout_BC_seq.postdir;
		Layout_BC_seq.unit_desig;
		Layout_BC_seq.sec_range;
		Layout_BC_seq.city;
		Layout_BC_seq.state;
		Layout_BC_seq.zip;
		Layout_BC_seq.zip4;
		Layout_BC_seq.rawaid;
		Layout_BC_seq.rec_seq;
		string1	addr_type := '';		
	end;
	
	Layout_norm normAddrForAID(BC_Scored_seq l, integer c) := transform
	   self.addr_type		:= choose(c,'O','C');
		 self.prim_range	:= choose(c, l.prim_range, l.company_prim_range); 
		 self.predir			:= choose(c, l.predir, l.company_predir); 
		 self.prim_name		:= choose(c, l.prim_name, l.company_prim_name); 
		 self.addr_suffix	:= choose(c, l.addr_suffix, l.company_addr_suffix); 
		 self.postdir			:= choose(c, l.postdir, l.company_postdir);              
		 self.unit_desig	:= choose(c, l.unit_desig, l.company_unit_desig); 
		 self.sec_range		:= choose(c, l.sec_range, l.company_sec_range); 
		 self.city				:= choose(c, l.city, l.company_city); 
		 self.state				:= choose(c, l.state, l.company_state); 
		 self.zip					:= choose(c, l.zip, l.company_zip); 
		 self.zip4				:= choose(c, l.zip4, l.company_zip4);
		 self.rawaid			:= choose(c, l.rawaid, l.company_rawaid);
		 self							:= l;
	end;
	
	BC_Scored_norm_Addr := normalize(BC_Scored_seq, 2, normAddrForAID(left,counter));

	//Propage the Business Contacts with AID
	macGetCleanAddr(BC_Scored_norm_Addr, prim_range, predir, prim_name, 
									addr_suffix, postdir, unit_desig, sec_range, city, state,
									zip, zip4, RawAID, false, false, BC_Scored_With_AID_result);									
	
	BC_Scored_With_AID_out := BC_Scored_With_AID_result : independent;
	
	//*** Denorm records to get them back to original form
	Layout_BC_seq DenormRecs(Layout_BC_seq l,  Layout_norm r) := transform	
		self.rawAID 				:= if(r.addr_type = 'O', r.rawAID, l.rawAID);
		self.Company_rawAID := if(r.addr_type = 'C', r.rawAID, l.Company_rawAID);
		self        				:= l;		 
	end;

	BC_Scored_denorm := denormalize(BC_Scored_seq,
																	BC_Scored_With_AID_out,
																	left.rec_seq = right.rec_seq,
																	DenormRecs(left, right)
																 );
	
	BC_scored_With_AID := project(BC_Scored_denorm, transform(Layout_Business_Contacts_Temp, self := left));
	
	return(BC_scored_With_AID);
	
end;