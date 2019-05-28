IMPORT IDL_Header,watchdog,Header;

EXPORT fn_EntityStats(DATASET(IDL_Header.Layout_Header_Link) hdr, DATASET(IDL_Header.Layout_Header_Link) f_hdr, string iter, boolean isForPublicRecords=FALSE) := FUNCTION

prefix:=if(isForPublicRecords,'~thor_data400::publicRecords','~thor::insurance');

iter_true := iter[..6];

inds := DISTRIBUTE(hdr(fname <> '' OR lname <> '' OR prim_name <> '' OR city <> ''),rid);

father := DISTRIBUTE(f_hdr,rid);

comp_rec := RECORD
	string9 src;
	unsigned8 rid_base;
	unsigned8 rid_father;
	unsigned8 did_base;
	unsigned8 did_father;
	unsigned8 cnt_base;
END;

j_rid := JOIN(inds,father,left.rid=right.rid,TRANSFORM(comp_rec,self.src := IF(left.src[..3] IN ['ICA','ICP','IVS'],left.src[..3],left.src),self.rid_base := left.rid, self.rid_father := right.rid, self.did_base := left.did, self.did_father := right.did, self.cnt_base := 0),local,left outer);

segi := InsuranceHeader_Postprocess.corecheck;
segp := Header.fn_ADLSegmentation_v2(header.File_Headers).core_check_pst;

j_segi := JOIN(j_rid,segi,left.did_base=right.did,transform(comp_rec,self.cnt_base := right.cnt, self := left),hash);
j_segp := JOIN(j_rid,segp,left.did_base=right.did,transform(comp_rec,self.cnt_base := right.rec_cnt, self := left),hash);

j_seg :=if(isForPublicRecords,j_segp,j_segi);

tab_src := TABLE(j_seg,{j_seg.src,cnt_new := COUNT(GROUP,j_seg.rid_father = 0), cnt_match := COUNT(GROUP,(j_seg.did_father = 0 AND j_seg.did_base < j_seg.rid_base) OR j_seg.did_base < j_seg.did_father), cnt_singleton := COUNT(GROUP,j_seg.cnt_base = 1)},src,few);

ded_did := DEDUP(SORT(DISTRIBUTE(j_seg,did_base),did_base,src,local),did_base,src,local);

tab_src_did := TABLE(ded_did,{j_seg.src,cnt_did := COUNT(GROUP)},src,few);

prerec := RECORD
	string9 src;
	unsigned8 cnt_new;
	unsigned8 cnt_match;
	unsigned8 cnt_singleton;
	unsigned8 cnt_did;
END;

pre_ds := JOIN(tab_src,tab_src_did,left.src = right.src,TRANSFORM(prerec,self:=left,self:=right));

outrec := RECORD
	string timestamp;
	string9 src;
	string StatName;
	unsigned8 StatValue;
END;

outrec normIt(prerec L, integer C) := TRANSFORM
	SELF.timestamp := iter_true;
	SELF.src := L.src;
	SELF.StatName := CASE(C,1 => 'New Records',
													2 => 'Matches',
													3 => 'Singletons',
													4 => 'Total Dids','');
	SELF.StatValue := CASE(C,1 => L.cnt_new,
													 2 => L.cnt_match,
													 3 => L.cnt_singleton,
													 4 => L.cnt_did,0);
END;

norm := NORMALIZE(pre_ds,4,normIt(LEFT,COUNTER));

filename := prefix+'Header::validation::entity::' + iter_true + '_' + WORKUNIT;
op := OUTPUT(norm,,filename,compressed,overwrite);

sfilename := prefix+'Header::validation::entity::current';
sf := Fileservices.PromoteSuperfileList([sfilename],filename,TRUE);

RETURN SEQUENTIAL(op,sf);

END;