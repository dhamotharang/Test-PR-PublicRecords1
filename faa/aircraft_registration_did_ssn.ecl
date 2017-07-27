#stored('did_add_force','thor');
import business_header,business_header_ss,didville,DID_Add,header_slimsort,ut,watchdog,fair_isaac,mdr,header,TopBusiness_External;

infile := file_aircraft_registration_in;

bt_rec := record
  unsigned6 did := 0;
  unsigned2 did_score := 0;
  layout_aircraft_registration_in;
end;

bt_rec addDID(layout_aircraft_registration_in L):= transform
 self := l;
end;

infile_did := project(infile,addDID(left));

//add src 
src_rec := record
header_slimsort.Layout_Source;
bt_rec;
end;

DID_Add.Mac_Set_Source_Code(infile_did, src_rec, MDR.sourceTools.src_Aircrafts, infile_did_src)

matchset := ['A'];//['A','P','D'];  removing phone for now cuz of skew

//DID file
DID_Add.MAC_Match_Flex(infile_did_src,matchset,junk,junk,fname,mname,
	lname,name_suffix,prim_range,prim_name,sec_range,
	zip,st,junk,
	did,src_rec,true,did_score, 
	75,infile_out,true,src)

outrec := layout_aircraft_registration_out;

outrec forthem(src_rec l) := transform
	self.DID_out := if (l.did = 0,'',intformat(l.did, 12, 1));
	self.d_score := intformat(l.did_score,3,1);
	self.best_ssn := '';
	self.bdid_out := '';
	self.bid_out := '';
	self := l;
end;
	
withdid := project(infile_out, forthem(left));

dw := watchdog.File_Best;

outrec getssn(dw L, withdid R) := transform
	self.best_ssn := if((l.did = 0 or l.ssn = '000000000' or l.ssn = ''),'',intformat((integer)L.ssn,9,1));
	self := R;
end;

ssn_records := join(distribute(dw,hash((integer)did)),distribute(withdid(did_out != ''),hash((integer)did_out)),(integer)left.did = (integer)right.did_out,getssn(LEFT,RIGHT),right outer,local);

allrecs := ssn_records + withdid(did_out = '');

bdid_rec := record
	allrecs;
	unsigned6	bdid := 0;
end;

pre_for_bdid := table(allrecs,bdid_rec);

for_bdid := pre_for_bdid(compname != '');

business_header.MAC_Source_Match(for_bdid,wbdid1,
							false,bdid,
							false,MDR.sourceTools.src_Aircrafts,
							false,foo,
							compname,
							prim_range,prim_name,sec_range,zip,
							false,foo,
							false,foo)
							
for_bdid2 := wbdid1(bdid = 0);
myset := ['A'];

business_header_Ss.mac_match_flex(for_bdid2,myset,
						compname,
						prim_range,prim_name,zip,sec_range,st,
						foo,foo,
						bdid,
						bdid_rec,
						false,foo,
						wbdid2)

outrec into_final(bdid_rec L) := transform
	self.bdid_out := if (L.bdid != 0, intformat(L.bdid,12,1),'');
	self.bid_out := '';
	self := L;
end;

outfinal_prebid := project(wbdid2 + wbdid1(bdid != 0) + pre_for_bdid(compname = ''),
		into_final(LEFT));

TopBusiness_External.MAC_External_BID(
	 outfinal_prebid
	,outfinal_postbid
	,bid
	,
	,MDR.SourceTools.src_Aircrafts
	,trim(serial_number,left,right) + '//' + trim(n_number,left,right) + '//' + if(cert_issue_date != '',trim(cert_issue_date,left,right),trim(last_action_date,left,right))
	,'REGISTRANT'
	,compname
	,zip
	,prim_name
	,prim_range
	,
	,
	,false		// Do we want to return a BID score at all?
);

outfinal := project(outfinal_postbid,
	transform(outrec,
		self.bid_out := if (left.bid != 0, intformat(left.bid,12,1),''),
		self := left));

export  aircraft_registration_did_ssn := outfinal : persist('persist::aircraft_temp');
