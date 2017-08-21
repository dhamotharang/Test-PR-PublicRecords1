import doxie;


bfile := project(fcc.File_FCC_base_bid,transform(fcc.Layout_FCC_base,self.licensee_bdid:=left.licensee_bid,self.dba_bdid:=left.dba_bid,self.firm_bdid:=left.firm_bid,self:=left));

key_rec := record
 unsigned6 bdid;
 unsigned6 fcc_seq;
end;

key_rec norm(bfile L,integer cnt) := transform
 self.bdid := choose(cnt,l.licensee_bdid,l.dba_bdid,l.firm_bdid);
 self := l;
end;
 
all_bdids := normalize(bfile,3,norm(left,counter));

rm_dups := dedup(all_bdids(bdid>0),all);

export Key_FCC_BID := index(rm_dups,{bdid},{fcc_seq},'~thor_data400::key::fcc::'+doxie.Version_SuperKey+'::bid');