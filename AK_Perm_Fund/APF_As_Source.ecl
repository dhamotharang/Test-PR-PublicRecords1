import header;
apf := dataset('~thor_data400::Base::AKHeader_Building',layout_apf_in,flat);
apf_pe := dataset('~thor_data400::Base::AKPEHeader_Building',layout_apf_pe_in,flat);

src_rec := record
	header.Layout_Source_ID;
	Layout_AK_Common;
end;

src_rec asSrcAPF(apf L) := transform
 self.src := 'AK';
 self.uid := 0;
 self := l;
end;

src_rec asSrcPE(apf_PE L) := transform
 self.src := 'AK';
 self.uid := 0;
 self := l;
end;

apf_out := project(apf,asSrcAPF(left));
apf_pe_out := project(apf_pe,asSrcPE(left));

all_recs := apf_out+apf_pe_out;

header.Mac_Set_Header_Source(all_recs,src_rec,src_rec,'AK',withUID)

export APF_As_Source := withUID : persist('persist::headerbuild_ak_src');