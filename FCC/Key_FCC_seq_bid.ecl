import doxie;

bfile := project(fcc.File_FCC_base_bid,transform(fcc.Layout_FCC_base,self.licensee_bdid:=left.licensee_bid,self.dba_bdid:=left.dba_bid,self.firm_bdid:=left.firm_bid,self:=left));
export Key_FCC_seq_bid := index(bfile,{fcc_seq},{bfile},'~thor_data400::key::fcc::'+doxie.Version_SuperKey+'::bid::seq');