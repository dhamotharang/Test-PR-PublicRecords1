import ut, Business_Header, Business_Header_SS, did_add;

dca_in := DCA.File_DCA_all_In;

layout_dca_temp := record
unsigned4 seq;
qstring34 vendor_id;
dca_in;
end;

layout_dca_temp AddSeqNum(dca_in l, unsigned4 cnt) := transform
self.seq := cnt;
self.vendor_id := l.root + '-' + l.sub;
self := l;
end;

dca_seq := project(dca_in, AddSeqNum(left, counter));

layout_dca_bdid := record
unsigned6 bdid := 0;
dca_seq.seq;
dca_seq.vendor_id;
dca_seq.Name;
dca_seq.prim_range;
dca_seq.prim_name;
dca_seq.sec_range;
dca_seq.state;
dca_seq.zip;
dca_seq.phone;
end;

dca_to_bdid := table(dca_seq, layout_dca_bdid);

// BDID DCA records
Business_Header.MAC_Source_Match(dca_to_bdid, dca_bdid_init,
                        false, bdid,
                        false, 'DC',
                        true, vendor_id,
                        Name,
                        prim_range, prim_name, sec_range, zip,
                        true, phone,
                        false, fein_field,
				    true, vendor_id);


BDID_Matchset := ['A','P'];

dca_bdid_match := dca_bdid_init(bdid <> 0);

dca_bdid_nomatch := dca_bdid_init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(dca_bdid_nomatch,
                                  BDID_Matchset,
                                  Name,
                                  prim_range, prim_name, zip,
                                  sec_range, state,
                                  phone, fein_field,
                                  bdid, layout_dca_bdid,
                                  false, BDID_score_field,
                                  dca_bdid_rematch)

dca_bdid_all := dca_bdid_match + dca_bdid_rematch;
					
// Append BDIDs and create base file
dca_bdid_append := join(dca_seq,
                        dca_bdid_all,
				    left.seq = right.seq,
				    transform(DCA.Layout_DCA_Base, self.bdid := right.bdid, self := left),
				    left outer,
				    hash);

export dca_bdid := dca_bdid_append : persist('TEMP::dca_bdid');