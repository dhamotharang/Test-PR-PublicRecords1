EXPORT fn_apply_alpha_rids(dataset(header.Layout_Header) hdr) := function

outRec := RECORD
	Header.Layout_LAB_Pairs.did;
	Header.Layout_LAB_Pairs.rid;
	unsigned8  alpha_rid;
	Header.Layout_LAB_Pairs;
END;

mapping:=pull(index({outRec.rid},outRec,'~thor_data400::key::mapping::did_rid::'+header.version_build));

// map alpha rids to new records
{hdr} use_alpha_rids(hdr L, mapping R) := transform

    self.rid := if(L.pflag1='A',R.alpha_rid,L.rid);
    SELF := L;

end;
hdr2:=join(distribute(hdr,hash32(rid)),distribute(mapping,hash32(rid)),LEFT.rid=RIGHT.rid,use_alpha_rids(LEFT,RIGHT),local);

// find bad rids (new LexIDs were created and now conflicting with old rids)
rids_to_fix:=join(distribute(hdr2,hash32(did)),distribute(hdr2,hash32(rid)),
LEFT.did=RIGHT.rid AND LEFT.did<>RIGHT.did AND
 (LEFT.ssn<>RIGHT.ssn OR (LEFT.ssn='' and LEFT.lname<>RIGHT.lname)),
transform({unsigned6 l_did, unsigned6 l_rid, unsigned6 r_did, unsigned6 r_rid,
           dataset({string side, recordof(LEFT)}) recs            }
           
          ,self.l_did:=LEFT.did
          ,self.l_rid:=LEFT.rid
          ,self.r_did:=RIGHT.did
          ,self.r_rid:=RIGHT.rid
          ,self.recs:=project(LEFT, transform({string side:='L', recordof(LEFT)},SELF:=LEFT))
                     +project(RIGHT, transform({string side:='R', recordof(RIGHT)},SELF:=RIGHT))
         ),LOCAL):persist('~thor_data400::persist::header::bad_raw_rids1');

// _rids_to_fix := dataset('~thor_data400::persist::header::bad_raw_rids__p4220577076',{rids_to_fix},thor);
rids_to_fix1:=dedup(rids_to_fix,r_did);
rids_to_fix2:=when(rids_to_fix1,sequential(output(count(rids_to_fix1),named('rids_to_fix_count')),
                                          output(choosen(rids_to_fix1,50) ,named('rids_to_fix_smple'))));

// filter conflicting rids from mapping file
mapping_of_bads:=join(distribute(mapping,hash32(rid)),distribute(rids_to_fix2,hash32(r_rid)),LEFT.rid=RIGHT.r_rid,transform(LEFT),local);

// apply rid correction on conflicting rids 
{hdr2} take_alpha_rids2(hdr2 L, mapping_of_bads R) := transform

        self.rid:=if(R.alpha_rid<>0,R.alpha_rid,L.rid);
        self:=L;

end;

head_out:=join(distribute(hdr2,hash32(rid)),distribute(mapping_of_bads,hash32(rid))
               ,LEFT.rid=RIGHT.rid,take_alpha_rids2(LEFT,RIGHT)
               ,LEFT OUTER,LOCAL);

RETURN head_out;

END;