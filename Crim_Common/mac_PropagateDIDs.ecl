import crim_common;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Mapping Instructions:
////	infile  - input file that contains a vendor id, did, did_score, and unique key (ex: criminal moxie or sex offender)
////	vendor  - field name for vendor id in file
////	key     - field name for key id in file (ex: offender key or seisint_primary_key)
////	pty_typ - field name for pty type in file (ex: pty_type or name_type)
////	allflag - 'A' for all vendors
////
//// Example syntax: 
////		mac_PropagateDIDs(Crim_Common.File_Moxie_Crim_Offender2_Prod, vendor, offender_key, pty_typ, 'A', outfile); output(outfile)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export mac_PropagateDIDs(infile, vendor, key, pty_typ, allflag, outfile) := macro

#uniquename(inputset)
%inputset% := crim_common.set_PropagateDIDs;

#uniquename(crim_header)
// %crim_header% := crim_header.file_crim_header;


#uniquename(tblOFFKEY)
#uniquename(tblCRIMH)
#uniquename(tblAKA)
#uniquename(new_infile)
#uniquename(d)
#uniquename(offkey_join)
#uniquename(jnOFFKEY)
#uniquename(crimh_join)
#uniquename(jnCRIMH)
#uniquename(aka_join)
#uniquename(jnAKA)

#if (allFlag = 'A')
	%new_infile% := infile;
#else
	%new_infile% := infile(vendor in %inputset%);
#end

/////////GENERATE LOOKUP TABLES FOR ASSIGNING NEW DID SCORES
	%tblOFFKEY% 	:= dedup(sort(table(%new_infile%(pty_typ = '0' and did > '0'), {key, did, did_score}), key, -did_score), key);  //extract lookup for offender key propogations
	// %tblCRIMH% 		:= dedup(sort(table(%crim_header%(did > 0), {key, did, did_score}), key, -did_score), key);  //extract lookup for aka propogations
	%tblAKA% 		:= dedup(sort(table(%new_infile%(pty_typ = '2' and did > '0'), {key, did, did_score}), key, -did_score), key);  //extract lookup for aka propogations

/////////OFFENDER KEY JOIN FOR DID SCORE 101
	%new_infile% %offkey_join%(%new_infile% l, %tblOFFKEY% r) := transform
		self.did := if(l.pty_typ = '2' and r.did > '0', r.did, l.did);
		self.did_score := if(l.pty_typ = '2' and r.did > '0', '101', l.did_score);
		self := l;
	end;
	
	%jnOFFKEY% := join(%new_infile%, %tblOFFKEY%, left.key = right.key, %offkey_join%(left, right), left outer);

/////////CRIMINAL HEADER JOIN FOR DID SCORE 102
	// %new_infile% %crimh_join%(%new_infile% l, %tblCRIMH% r) := transform
		// self.did := if(l.did <= '0' and r.did > 0, (string)r.did, l.did);
		// self.did_score := if(l.did <= '0' and r.did > 0 and r.did <> (integer)l.did, '102', l.did_score);
		// self := l;
	// end;
	
	// %jnCRIMH% := join(%jnOFFKEY%, %tblCRIMH%, left.key = right.key, %crimh_join%(left, right), left outer);


/////////AKA JOIN FOR DID SCORE 103
	%new_infile% %aka_join%(%new_infile% l, %tblAKA% r) := transform
		self.did := if(l.did <= '0' and r.did > '0', r.did, l.did);
		self.did_score := if(l.did <= '0' and r.did > '0' and r.did <> l.did, '103', l.did_score);
		self := l;
	end;
	
	// %jnAKA% := join(%jnCRIMH%, %tblAKA%, left.key = right.key, %aka_join%(left, right), left outer);
	%jnAKA% := join(%jnOFFKEY%, %tblAKA%, left.key = right.key, %aka_join%(left, right), left outer);

outfile := %jnAKA%;
 
endmacro;
