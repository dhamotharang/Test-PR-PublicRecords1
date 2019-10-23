import header;

//workaround
h_new_wo := sort(header.Apt_Patch,did);

h_new := distribute(h_new_wo,hash(rid));

tnt_f := header.TNT_Candidates(header.Apt_Patch) : persist('htemp::TNT_Candidates');

//Add TNT flag
header.Layout_Header add_flag(header.Layout_Header he, tnt_f i) := transform
  self.tnt := if (i.rid=0,'N',if (he.phone=i.phone10 and (integer)he.phone!=0,'P','Y'));
  self := he;
  end;

jnd_1 := join(h_new,distribute(tnt_f,hash(rid)),left.rid=right.rid,add_flag(left,right),left outer,local);

//Add valid SSN flag
header.Layout_Header add_sflag(header.Layout_Header le, header.ssn_validities ri) := transform
  self.valid_ssn := ri.val;
  self := le;
  end;

jnd_2 := join(jnd_1,distribute(header.ssn_validities,hash(rid)),left.rid=right.rid,add_sflag(left,right),left outer,local);

//Add valid DOB flag
header.Layout_Header add_jflag(header.Layout_Header le, header.DOB_Validities ri) := transform
  self.jflag1 := ri.jflag1;
  self := le;
  end;

jnd := join(jnd_2,distribute(header.DOB_Validities,hash(rid)),left.rid=right.rid,add_jflag(left,right),left outer,local);


// Now perform death append
d_jnd := distribute(jnd,hash(did));

s_sjn := sort(d_jnd,did,local);
g_did := group(s_sjn,did,local);
s_did := sort(g_did,if(src in ['DE','DS'],0,1));

header.Layout_Header propogate_death(header.Layout_Header le, header.layout_header ri) := transform
  self.tnt := if ( ri.src in ['DE','DS'] or le.tnt='D','D', ri.tnt );
  self := ri;
  end;

put_out := iterate(s_did,propogate_death(left,right));

// Tag and flag apartment buildings
napt := put_out(unit_desig='');
apt := put_out(unit_desig<>'');

apb := header.ApartmentBuildings(apt_cnt>5);

header.Layout_Header cpy(header.Layout_Header le, apb ap) := transform
  self.unit_desig := if ( le.unit_desig = '' and ap.apt_cnt > 0, 'APT',le.unit_desig );
  self := le;
  end;

dapt := distribute(napt,hash(trim(prim_range),trim(prim_name),trim(zip)));
dapb_dups := distribute(apb,hash(trim(prim_range),trim(prim_name),trim(zip)));
dapb_srtd := sort(dapb_dups, prim_range, prim_name, zip, local);
dapb := dedup(dapb_srtd, prim_range, prim_name, zip, local);

japt := join(dapt,dapb,left.prim_range=right.prim_range and
						  left.prim_name=right.prim_name and
						  left.zip=right.zip, cpy(left,right),left outer,local);

wtnt := japt+apt;

export With_TNT := wtnt : persist('headerbuild_with_tnt');