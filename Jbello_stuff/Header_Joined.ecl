import header,ut,address,mdr,idl_header;

// PH    = Previous Header
// NMPH  = Not Matched PH

// NHR   = New Header Records
// MNHR  = Matched NHR
// NMNHR = Not Matched NHR

PHin := header.file_headers(header.Blocked_data());

Jbello_stuff.Mac_Prep_for_BM(PHin,inPH,'PH');
Jbello_stuff.Mac_Prep_for_BM(jbello_stuff.New_Header_Records,inNHR,'NHR');

jbello_stuff.Mac_BasicMatch(inPH, inNHR, oNMPH, oNMNHR, oMNHR);

r_nbm := record
	oNMNHR.src;
	string30 src_desc := mdr.sourcetools.translatesource(oNMNHR.src);
	count_            := count(group);
end;

ta1 := sort(table(oNMNHR,r_nbm,src,few),-count_);
output(ta1,all,named('no_basic_match_'));

ut.MAC_Sequence_Records(oNMNHR,uid,outfile1)

outf := outfile1 + oMNHR;

header.Layout_Header to_form(outf l) := transform
	self.rid    := IF (l.rid=0,mdr.max_rid+l.uid,l.rid);
	self.did    := IF (l.did=0,mdr.max_rid+l.uid,l.did);
	self.pflag1 := MAP(l.did=0=>'A',l.rid=0=>'P','+');
	self := l;
end;

new_month_joined := project(outf,to_form(left))(header.Blocked_data_new());

Header.Layout_header blank_pflag(oNMPH l) := transform
	self.pflag1 := ''; // old rolled header records - no longer updating (NLU)
	self        := l;
end;

//get no longer updating Previous Header recs
pnew := project(oNMPH,blank_pflag(left)) + new_month_joined;

jbello_stuff.MAC_Merge_ByRid(pnew, merged0__);
if ( count(merged0__(did>rid)) <> 0, output('DID > RID constraint violated') );

merged_out:=Jbello_stuff.fn_post_BasicMatch_deletes(merged0__):global;

temp_layout:={unsigned8 old_rid,header.Layout_New_Records};
merged0:=project(merged_out,transform(temp_layout
									,self.old_rid:=left.rid
									,self.uid:=left.rid
									,self:=left));

merged1:=group(sort(distribute(merged0,hash(rid)),rid,dt_vendor_first_reported,local),rid);
//flag sequense candidates - duplicate rid - with a "zero"
merged2:=group(iterate(merged1,transform(recordof(merged1)
						,self.rid:=if(left.did=0, right.rid, 0) //keep the first, zero the rest - assumes every rec has a did
						,self:=right)));

merged3    := merged2(rid=0);

ut.MAC_Sequence_Records(merged3,uid,merged4)
//get a new max rid
max_rid:=max(merged2(not header.isDemoData()),rid);
//assign a new rid using the new max rid and sequensed uid
temp_layout to_form2(merged4 l) := transform
	self.rid    := IF (l.rid=0,max_rid+l.uid,l.rid);
	self.pflag1 := MAP(l.did=0=>'A',l.rid=0=>'P','+');
	self := l;
end;

merged5 := project(merged4,to_form2(left))(header.Blocked_data_new());
merged6 := merged5 + merged2(rid>0);

// fixes did > rid problems
merged := jbello_stuff.FN_Patch_RID(merged6);
   
export Header_joined := merged(fname<>'' and lname<>'') : persist('~thor_data::persist::Header_joined');