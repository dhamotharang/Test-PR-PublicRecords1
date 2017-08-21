
import crim_common,sexOffender,doxie,doxie_files;

hps_with_did := distribute(misc._hps_201002_phase0_did(did<>0),hash(did));

layout_flagged := record
	//
	recordof(misc._hps_201002_phase0_did);
	//
	// string1 has_crim:='';
	string1 has_doc:= '';
	string1 has_court := '';
	// string1 has_arrest := '';
	string1 has_sor:='';
	//
	// string1 has_death:='';
	//
	// string1 has_sanction:='';
	//
	end;
	
crimx := distribute(crim_common.File_Crim_Offender2_Plus(did<>''),hash((unsigned6) did));
sorx := distribute(sexoffender.file_Main(did<>0),hash((unsigned6)did));

// layout_flagged to_flag_crim(hps_with_did l, crimx r)  := transform
	// self.has_crim := if(l.did<>0 and l.did = (unsigned6) r.did,'Y','');
	// self := l;
	// end;
// hps_with_crim := join(hps_with_did,crimx,left.did=(unsigned6) right.did, to_flag_crim(left,right),keep(1), left outer, local);

layout_flagged to_flag_doc(hps_with_did l, crimx r)  := transform
	self.has_doc := if(l.did<>0 and l.did = (unsigned6) r.did,'Y','');
	self := l;
	end;
hps_with_doc := join(hps_with_did,crimx(data_type='1'),left.did=(unsigned6) right.did, to_flag_doc(left,right),keep(1), left outer, local);

layout_flagged to_flag_court(hps_with_doc l, crimx r)  := transform
	self.has_court := if(l.did<>0 and l.did = (unsigned6) r.did,'Y','');
	self := l;
	end;
hps_with_court := join(hps_with_doc,crimx(data_type='2'),left.did=(unsigned6) right.did, to_flag_court(left,right),keep(1), left outer, local);

// layout_flagged to_flag_arrest(hps_with_court l, crimx r)  := transform
	// self.has_arrest := if(l.did<>0 and l.did = (unsigned6) r.did,'Y','');
	// self := l;
	// end;
// hps_with_arrest := join(hps_with_court,crimx(data_type='5'),left.did=(unsigned6) right.did, to_flag_arrest(left,right),keep(1), left outer, local);

layout_flagged to_flag_sor(hps_with_court l, sorx r)  := transform
	self.has_sor := if(l.did<>0 and l.did = (unsigned6) r.did,'Y','');
	self := l;
	end;
hps_with_sor := join(hps_with_court,sorx,left.did=(unsigned6) right.did,to_flag_sor(left,right),keep(1), left outer, local);

// deaths := distribute(pull(Doxie.key_death_masterV2_DID),hash( (unsigned6) did));
// layout_flagged to_flag_death(hps_with_sor l, deaths r)  := transform
	// self.has_death := if(l.did<>0 and l.did = (unsigned6) r.did,'Y','');
	// self := l;
	// end;
// hps_with_death := join(hps_with_sor,deaths,left.did=(unsigned6) right.did,to_flag_death(left,right),keep(1), left outer, local);

// sanctions := distribute(pull(Doxie_files.key_sanctions_did),hash( (unsigned6) l_did));
// layout_flagged to_flag_sanction(hps_with_death l, sanctions r)  := transform
	// self.has_sanction := if(l.did<>0 and l.did = (unsigned6) r.l_did,'Y','');
	// self := l;
	// end;
// hps_with_sanction := join(hps_with_death,sanctions,left.did=(unsigned6) right.l_did,to_flag_sanction(left,right),keep(1), left outer, local);

// output(count(hps_with_did),named('input_count_with_did'));
// output(count(hps_with_sor(has_doc='Y')),named('has_doc'));
// output(count(hps_with_sor(has_court='Y')),named('has_court'));
// output(count(hps_with_sor(has_sor='Y')),named('has_sor'));

export _hps_201002_phase1_flagged := hps_with_sor : persist('~thor::temp::misc._hps_201002_phase1_flagged');

