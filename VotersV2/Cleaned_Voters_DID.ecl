import DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville,mdr,header;


In_Base_File    := VotersV2.Updated_Voters: persist('~thor_data400::persist::voters::InBaseFile',SINGLE) ;

Lay_Voters_WithDID := record
		VotersV2.Layouts_Voters.Layout_Voters_Common_new;
		unsigned6 DID       := 0;
		unsigned1 did_score := 0;
end;

//Added Base File to DID to refresh dids
//DF-26929 Adding the MA Census base to re-DID
baseFile := VotersV2.File_Voters_Base + VotersV2.File_MA_Census_Base : persist('~thor_data400::persist::voters::BaseFile',SINGLE) ;

Layout_outfile := VotersV2.Layouts_Voters.Layout_Voters_Common_new;

Layout_outfile transformBase(baseFile l) := transform		
//populated name fields for flip name utility below 
  self.title := l.prefix_title;
	self.fname := l.first_name;
	self.mname := l.middle_name;
	self.lname := l.last_name;
	self.name_suffix := l.name_suffix_in;
	self              := l;
  self              := [];
end;

transformedBaseFile := project(baseFile, transformBase(left)): persist('~thor_data400::persist::voters::tranformedBaseFile',SINGLE) ;

inputAndBaseFile := In_Base_File + transformedBaseFile;

// Added for DF-27802 - Emerges Opt Out - This will filter out Voters records that are found in the Emerges Opt Out file.  
OptOut :=	dedup(sort(distribute(VotersV2.File_OptOut_Cleaned,hash(dob)),dob,last_name,first_name,state,local),dob,last_name,first_name,state,local)(dob <> '' and last_name <> '' and first_name <> '' and state <> '');

joinLayout := record
	 Layout_outfile;	
	 string optout_flag;
end;
	
joinVoters_OptOut := join(inputAndBaseFile, OptOut,
													 left.dob        = right.dob and
													 left.last_name  = right.last_name and
													 left.first_name = right.first_name and
													 (left.res_state = right.state or left.mail_state = right.state),
														transform(joinLayout,
																			 self.optout_flag := if( left.dob        = right.dob and
																															 left.last_name  = right.last_name and 
																															 left.first_name = right.first_name and 
																															 (left.res_state = right.state or left.mail_state = right.state) and 
																															 left.dob        <> '' and right.dob        <> ''  and 
																															 left.last_name  <> '' and right.last_name  <> ''  and 
																															 left.first_name <> '' and right.first_name <> ''  and 
																															 (left.res_state <> '' or left.mail_state   <> '') and right.state <> ''
																															 ,'O' ,'');	
																			 self 				  := left;
																			 self  				  := [];),
															 left outer, lookup);
																	 
Base_filterOptOuts := project(joinVoters_OptOut(optOut_flag <> 'O'),transform(Layout_outfile,self := left));
// End of Emerges Opt Out filter

ut.mac_flipnames(Base_filterOptOuts,fname,mname,lname, base_FlipNames)

dist_In_Base_File := distribute(base_FlipNames, hash64(source_state, lname, name_suffix, fname, mname, 
																dob, prim_range, prim_name, predir, addr_suffix, postdir,
																unit_desig, sec_range, p_city_name, st, zip)): persist('~thor_data400::persist::voters::distInBaseFile',SINGLE) ;

// deduping the records based on vtid key, political party, mailing address fields.																
ded_In_base_file  := dedup(sort(dist_In_Base_File, vtid, -process_date, lname, name_suffix, fname, mname, dob,
																prim_range, prim_name, predir, addr_suffix, postdir, unit_desig, sec_range,
																p_city_name, st, zip, political_party, phone, work_phone, clean_maiden_pri,
                                mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix, mail_postdir,
													  		mail_unit_desig, mail_sec_range, mail_p_city_name, mail_st,	mail_ace_zip, local), 
													 vtid, lname, name_suffix, fname, mname, dob, prim_range, prim_name, predir, addr_suffix, postdir,
													 unit_desig, sec_range, p_city_name, st, zip, political_party, phone, work_phone, clean_maiden_pri,
													 mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix, mail_postdir, mail_unit_desig, 
													 mail_sec_range, mail_p_city_name, mail_st, mail_ace_zip, local): persist('~thor_data400::persist::voters::dedInbasefile',SINGLE) ;

//#stored('did_add_force','roxi'); // remove or set to 'thor' to put recs through thor
//add src 
src_rec := record
header_slimsort.Layout_Source;
Lay_Voters_WithDID;
end;

ded_Plus_Base_File := ded_In_base_file: persist('~thor_data400::persist::voters::dedPlusBaseFile',SINGLE) ;

DID_Add.Mac_Set_Source_Code(ded_Plus_Base_File, src_rec, 'VO', ded_In_base_file_src)

outputded_In_base_file_src := ded_In_base_file_src: persist('~thor_data400::persist::voters::dedInbasefilesrc',SINGLE) ;

matchSet := ['A','D','P'];

DID_Add.MAC_Match_Flex            // regular did macro
				 (outputded_In_base_file_src, matchSet, '',
				 dob, fname, mname, lname, name_suffix,
				 prim_range, prim_name, sec_range, zip, st, phone,
				 DID,
				 src_rec,
				 true, did_score,
				 75,                 //dids with a score below here will be dropped
				 Ds_Voters_WithDID_src,true,src					
				)

//remove src
Ds_Voters_WithDID := project(Ds_Voters_WithDID_src, transform(Lay_Voters_WithDID, self := left))
: persist('~thor_data400::persist::voters::DsVotersWithDID',SINGLE) ;

Lay_Voters_WithDidSsn := record
	Lay_Voters_WithDID;
	string9	ssn := '';	
end;

Lay_Voters_WithDidSsn tDefault_ssn(Ds_Voters_WithDID l) := transform
	self.ssn := '';
	self := l;
end;

In_Voters_WithDidSsn := project(Ds_Voters_WithDID, tDefault_ssn(left)): persist('~thor_data400::persist::voters::InVotersWithDidSsn',SINGLE) ;

did_add.MAC_Add_SSN_By_DID(In_Voters_WithDidSsn, did, ssn, Out_Voters_WithDidSsn)

Ds_Voters_with_did_ssn := Out_Voters_WithDidSsn: persist('~thor_data400::persist::voters::OutVotersWithDidSsn',SINGLE) ;

export Cleaned_Voters_DID := Ds_Voters_with_did_ssn : persist(VotersV2.Cluster + 'Persist::Cleaned_Voters_With_did_ssn',SINGLE);
