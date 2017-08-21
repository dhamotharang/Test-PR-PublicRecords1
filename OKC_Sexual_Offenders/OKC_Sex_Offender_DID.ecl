import DID_Add, Header, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville, sexoffender, lib_ziplib, idl_header;

Lay_OKC_Sex_Off_WithDID := record
		OKC_Sexual_Offenders.Layout_OKC_Sex_Offender_Common.final;
		unsigned6 DID             := 0;
		unsigned6 DID_Score_field := 0;
end;

In_File := OKC_Sexual_Offenders.Cleaned_OKC_Sex_Offender;

//Add FlipFlop Macro///////////////////
ut.mac_flipnames(In_File, fname, mname, lname, In_Base_File);

//#stored('did_add_force','roxi'); // remove or set to 'thor' to put recs through thor
#stored('did_add_force','thor'); // remove or set to 'thor' to put recs through thor
matchSet := ['A','D','S'];

//DID_Add.MAC_Match_Flex_Sensitive    // NOTE <- senstitive macro
DID_Add.MAC_Match_Flex                // regular did macro
				(In_Base_File
				,matchSet
				,orig_ssn, date_of_birth
				,fname, mname,lname
				,name_suffix
				,prim_range, prim_name, sec_range, zip, st
				,''
				,DID
				,Lay_OKC_Sex_Off_WithDID, true, DID_Score_field
				,75                   // DIDs with a score below here will be dropped
				// ,90                   // DIDs with a score below here will be dropped
				,Ds_OKC_Sex_Off_WithDID					
				)

Lay_OKC_Sex_Off_WithDidSsn := record
	Lay_OKC_Sex_Off_WithDID;
	string9	ssn := '';	
end;

Lay_OKC_Sex_Off_WithDidSsn tDefault_ssn(Ds_OKC_Sex_Off_WithDID l) := transform
	self.ssn := '';
	self := l;
end;

In_OKC_Sex_off_WithDidSsn := project(Ds_OKC_Sex_Off_WithDID, tDefault_ssn(left));

did_add.MAC_Add_SSN_By_DID(In_OKC_Sex_off_WithDidSsn, did, ssn, Out_OKC_Sex_Off_WithDidSsn)

//output('Count of records with DIDs added: ' + count(Out_OKC_Sex_Off_WithDidSsn(DID != 0)));

/* Clean out invalid SSN values to ensure none of the wrong ones are appended */
slim_Sex_Off_DID_SSN_rec := record
    string16  seisint_primary_key;
	string    name_orig;
	string1   name_type;
	string    date_of_birth;
	unsigned6 DID;
    unsigned6 did_score;
    string9	  ssn;	
end;

slim_Sex_Off_DID_SSN_rec tSlim_down_Sex_Off(Out_OKC_Sex_Off_WithDidSsn L) := transform
    self.did_score := L.DID_Score_field;
    self           := L;
end;

In_OKC_Sex_Off_WithDidSsn_Slim := project(Out_OKC_Sex_Off_WithDidSsn
                                         ,tSlim_down_Sex_Off(left));

did_add.mac_BlankDIDWhenSSNInvalid(In_OKC_Sex_Off_WithDidSsn_Slim, Out_OKC_Sex_Off_WithDidSsn_Slim);

//output('Count of slim records with DIDs after cleaning: ' + count(Out_OKC_Sex_Off_WithDidSsn_Slim(DID != 0)));

Lay_OKC_Sex_Off_WithDidSsn tRejoin_SSNs(Out_OKC_Sex_Off_WithDidSsn      L
                                       ,Out_OKC_Sex_Off_WithDidSsn_Slim R) := transform
	self.ssn := if(R.DID != 0
	              ,R.ssn
				  ,'');
	self := L;
end;

Out_OKC_Sex_off_WithDidSsn2 := join(Out_OKC_Sex_Off_WithDidSsn
                                   ,Out_OKC_Sex_Off_WithDidSsn_Slim
								   ,Left.seisint_primary_key = Right.seisint_primary_key
								AND Left.name_orig           = Right.name_orig
								AND Left.name_type           = Right.name_type
								AND Left.date_of_birth       = Right.date_of_birth
								AND Left.ssn                 = Right.ssn
								   ,tRejoin_SSNs(LEFT,RIGHT));

/* End of process removing invalid SSN values */

Ds_OKC_Sex_Off_with_did_ssn := Out_OKC_Sex_off_WithDidSsn2;

//output('Count of full records with DIDs after cleaning: ' + count(Ds_OKC_Sex_Off_with_did_ssn(DID != 0)));

Layout_outf := record
		string12 did;
		string3  did_score;
		string9  ssn;
		OKC_Sexual_Offenders.Layout_OKC_Sex_Offender_Common.final;
end;

Layout_outf trf(Ds_OKC_Sex_Off_with_did_ssn l) := TRANSFORM
	self.did := if((trim((string)l.did) != '' 
	               AND           l.did  != 0)
			      ,intformat(l.did, 12, 1)
				  ,'');
	self.did_score	:= (string3)L.did_score_field;
	self := l;
end;
	
Ds_OKC_Sex_Off_WithDidSsn := Project(Ds_OKC_Sex_Off_with_did_ssn,trf(left));

//Suppress Records  ////////////////////////////
	
	//Bugzilla #Bug 80123, #93439
	Ds_OKC_Sex_Off_WithDidSsn removeInfo(Ds_OKC_Sex_Off_WithDidSsn l):= transform
		self.ssn		:= if(l.ssn='353561176' and l.did='2275932305',
							'',
							if(l.ssn='567086017' and l.did='637548399',
							'',
							l.ssn));
		self.did		:= if(l.ssn='353561176' and l.did='2275932305',
							'',
							if(l.ssn='567086017' and l.did='637548399',
							'',
							l.did));
		self.did_score	:= if(l.ssn='353561176' and l.did='2275932305',
							'',
							if(l.ssn='567086017' and l.did='637548399',
							'',
							l.did_score));
		self 			:= l;
	end;

	suppressed_records := project(Ds_OKC_Sex_Off_WithDidSsn, removeInfo(left));

// To run on Dataland
// export OKC_Sex_Offender_DID := Ds_OKC_Sex_Off_WithDidSsn : persist(OKC_Sexual_Offenders.Cluster + 'Persist::Cleaned_OKC_Sex_Offender_With_did_ssn');
// To run on Production
export OKC_Sex_Offender_DID := suppressed_records : persist('~thor_data400::Persist::Cleaned_OKC_Sex_Offender_With_did_ssn2','thor400_92');
