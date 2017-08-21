import ut, VersionControl, business_header, aid, Business_Header_SS;

export Proc_build_cleanAddr_base
(

	dataset(paw.layout.Employment_Out	) pPawBase	= paw.File_Base

) :=
function

	dBase 	  	  := pPawBase;
	
	//===================== Start of AID process to get the best addr for keys ========================
	Layout_PAW_seq := record
		paw.layout.Employment_Out;
		unsigned6 rec_seq := 0;
	end;
	
	PAW_base_seq := project(dBase, transform(Layout_PAW_seq, self := left,self.rec_seq := counter)):persist('~thor_data400::persist::paw::Proc_build_cleanAddr_base::PAW_base_seq');
	
	Layout_norm := record
		Layout_PAW_seq.prim_range;
		Layout_PAW_seq.predir;
		Layout_PAW_seq.prim_name;
		Layout_PAW_seq.addr_suffix;
		Layout_PAW_seq.postdir;
		Layout_PAW_seq.unit_desig;
		Layout_PAW_seq.sec_range;
		Layout_PAW_seq.city;
		Layout_PAW_seq.state;
		Layout_PAW_seq.zip;
		Layout_PAW_seq.zip4;
		Layout_PAW_seq.rawaid;
		string1	addr_type := '';
		unsigned6 rec_seq := 0;
	end;
	
	Layout_norm normAddrForAID(PAW_base_seq l, integer c) := transform
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
	
	PAW_norm_Addr := normalize(PAW_base_seq, 2, normAddrForAID(left,counter));

	//Propage the Business Contacts with AID and get the best addresses for keys
	business_header.macGetCleanAddr(PAW_norm_Addr, prim_range, predir, prim_name, 
									addr_suffix, postdir, unit_desig, sec_range, city, state,
									zip, zip4, RawAID, true, true, PAW_With_AID_result);									
	
	dPAW_With_AID_result := PAW_With_AID_result : INDEPENDENT;
	
	Layout_PAW_seq DenormRecs(Layout_PAW_seq l,  Layout_norm r) := transform	
		self.rawAID 								:= if(r.addr_type = 'O', r.rawAID, l.rawAID);
		self.Company_rawAID 				:= if(r.addr_type = 'C', r.rawAID, l.Company_rawAID);
		
		self.prim_range							:= if(r.addr_type = 'O', r.prim_range, l.prim_range); 
		self.predir									:= if(r.addr_type = 'O', r.predir, l.predir); 
		self.prim_name							:= if(r.addr_type = 'O', r.prim_name, l.prim_name); 
		self.addr_suffix						:= if(r.addr_type = 'O', r.addr_suffix, l.addr_suffix); 
		self.postdir								:= if(r.addr_type = 'O', r.postdir, l.postdir);              
		self.unit_desig							:= if(r.addr_type = 'O', r.unit_desig, l.unit_desig); 
		self.sec_range							:= if(r.addr_type = 'O', r.sec_range, l.sec_range); 
		self.city										:= if(r.addr_type = 'O', r.city, l.city); 
		self.state									:= if(r.addr_type = 'O', r.state, l.state); 
		self.zip										:= if(r.addr_type = 'O', r.zip, l.zip); 
		self.zip4										:= if(r.addr_type = 'O', r.zip4, l.zip4);
		
		self.company_prim_range			:= if(r.addr_type = 'C', r.prim_range, l.company_prim_range); 
		self.company_predir					:= if(r.addr_type = 'C', r.predir, l.company_predir); 
		self.company_prim_name			:= if(r.addr_type = 'C', r.prim_name, l.company_prim_name); 
		self.company_addr_suffix		:= if(r.addr_type = 'C', r.addr_suffix, l.company_addr_suffix); 
		self.company_postdir				:= if(r.addr_type = 'C', r.postdir, l.company_postdir);              
		self.company_unit_desig			:= if(r.addr_type = 'C', r.unit_desig, l.company_unit_desig); 
		self.company_sec_range			:= if(r.addr_type = 'C', r.sec_range, l.company_sec_range); 
		self.company_city						:= if(r.addr_type = 'C', r.city, l.company_city); 
		self.company_state					:= if(r.addr_type = 'C', r.state, l.company_state); 
		self.company_zip						:= if(r.addr_type = 'C', r.zip, l.company_zip); 
		self.company_zip4						:= if(r.addr_type = 'C', r.zip4, l.company_zip4);		
		self        								:= l;		 
	end;

	PAW_denorm := denormalize(sort(distribute(PAW_base_seq, rec_seq), rec_seq, local),
	                          sort(distribute(dPAW_With_AID_result, rec_seq), rec_seq, local),
														left.rec_seq = right.rec_seq,
														DenormRecs(left, right),
														local);
	
	PAW_With_AID := project(PAW_denorm, transform(paw.layout.Employment_Out, self := left));
	

	BDID_Matchset := ['A','F','P'];													 

	Business_Header_SS.MAC_Add_BDID_FLEX(
		 PAW_With_AID													// Input Dataset						
		,BDID_Matchset                        // BDID Matchset what fields to match on           
		,company_name	                        // company_name	              
		,company_prim_range		                // prim_range		              
		,company_prim_name		                // prim_name		              
		,company_zip					                // zip5					              
		,company_sec_range		                // sec_range		              
		,company_state				                // state				              
		,company_phone				                // phone				              
		,company_fein	                        // fein              
		,bdid													        // bdid												
		,Layout.Employment_Out_BIPv2				  // Output Layout 
		,false                                // output layout has bdid score field?                       
		,0						                        // bdid_score                 
		,dBdidFlexOut                         // Output Dataset 
		,
		,																			// default to use prod version of superfiles
		,																			// default is to hit prod from dataland, and on prod hit prod.
		,[2]																	// produce BIPV2 LinkIDs ONLY - BDID is supplied by other build processes.
		,
		,email_address                        // email
		,city                                 // city
		,fname
		,mname
		,lname
	);   		
	
	
	VersionControl.macBuildNewLogicalFile(business_header._Dataset().thor_cluster_Files +'base::paw::bestAddr::keybuild',dBdidFlexOut,abuildBase,,,true);

	return sequential(abuildBase);
	
end;
