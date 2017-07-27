import crim, ut,did_add,didville, doxie_files;

boolean daily_file := false : stored('daily');

input_files := crim.FL_as_Identity;
		     //crim.PA_as_Identity;

// Sequence incoming file
layout_seq := RECORD
	UNSIGNED4 seq_no := 0;
	input_files;
END;

layout_seq add_seq(layout_seq l, layout_seq r) := TRANSFORM
	SELF.seq_no := IF(l.seq_no = 0, thorlib.node() + 1, l.seq_no + thorlib.nodes());
	SELF := r;
END;

sequenced := ITERATE(
		TABLE(input_files, layout_seq), 
		add_seq(LEFT, RIGHT), LOCAL);

//Get ready for HASH DID
didville.Layout_Did_InBatch intoSmall(layout_seq L) := transform
 self.seq := l.seq_no;
 self.ssn := l.orig_ssn;
 self.phone10 := '';
 self.p_city_name := l.city_name;
 self.z5 := l.zip;
 self := l;
end;

to_did := project(sequenced,intoSmall(left));

//Add DIDs
did_add.mac_match_hash_roxie(to_did, dids_small)

crim.Layout_Crim_Identity getDID(sequenced L, dids_small R) := transform 
 self.did := r.did;
 self := l;
end;

with_dids := join(distribute(sequenced,hash(seq_no)),distribute(dids_small,hash(seq)),
				left.seq_no=right.seq,getDID(left,right),local);

ut.MAC_SF_BuildProcess(with_dids,'~thor_data400::base::CrimHist_Identity_'+doxie_build.buildstate,executer,2);

//if daily file build key too.
out_daily := output(with_dids,,'~thor_data400::base::CrimHist_Identity_'+buildstate+thorlib.wuid(),overwrite);
add_daily := fileservices.addsuperfile('~thor_data400::base::CrimHist_Identity_'+buildstate,'~thor_data400::base::CrimHist_Identity_'+buildstate+thorlib.wuid());
key_daily1 := buildindex(doxie_files.key_crim_did,'~thor_data400::key::CrimHist_DID_'+buildstate+thorlib.wuid());
key_daily2 := buildindex(doxie_files.key_crim_ident,'~thor_data400::key::CrimHist_Identity_'+buildstate+thorlib.wuid());
add_key1 := fileservices.addsuperfile('~thor_data400::key::CrimHist_DID_'+buildstate,'~thor_data400::key::CrimHist_DID_'+buildstate+thorlib.wuid());
add_key2 := fileservices.addsuperfile('~thor_data400::key::CrimHist_Identity_'+buildstate,'~thor_data400::key::CrimHist_Identity_'+buildstate+thorlib.wuid());

daily_stuff := sequential(out_daily,add_daily,key_daily1,key_daily2,add_key1,add_key2);

export proc_build_crim_offender := if(daily_file,daily_stuff,executer);