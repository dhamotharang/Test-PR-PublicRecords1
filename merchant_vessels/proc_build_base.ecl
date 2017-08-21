import didville,did_add,ut,business_header_ss,business_header;

pre := sequential(
	fileservices.startsuperfiletransaction(),
	fileservices.clearsuperfile('~thor_data400::in::merch_vessels_FATHER'),
	fileservices.addsuperfile('~thor_Data400::in::merch_vessels_FATHER','~thor_data400::in::merch_vessels_IN',0,true),
	fileservices.clearsuperfile('~thor_data400::in::merch_vessels_IN'),
	fileservices.addsuperfile('~thor_Data400::in::merch_vessels_IN','~thor_data400::in::merchant_vessels_' + version),
	fileservices.finishsuperfiletransaction()
	);

df := file_merchant_vessel_current;

seqrec := record
	unsigned4	seq;
	df;
end;

seqrec into_seq(df L, integer C) := transform
	self.seq := c;
	self := l;
end;

dfseq := project(df,into_seq(LEFT,COUNTER));

didville.Layout_Did_InBatch into_dib(dfseq L) := transform
	self.ssn := '';
	self.dob := '';
	self.phone10 := '';
	self.addr_suffix := L.suffix;
	self.z5 := L.zip;
	self := L;
end;

dfdib := project(dfseq,into_dib(LEFT));

did_add.mac_match_fast_roxie(dfdib,outf1,'','','ALL',true,true)

layout_did_mv into_out(outf1 L, dfseq R) := transform
	self.did := L.did;
	self := R;
end;

outf2 := join(outf1,dfseq,left.seq = right.seq,into_out(LEFT,RIGHT),hash);

dfbdid := outf2(compname != '');

myset := ['A'];

business_header_ss.mac_match_flex(dfbdid,myset,
						compname,
						prim_range,prim_name,zip,sec_range,st,
						foo,foo,
						bdid,
						layout_did_mv,
						false,foo,
						outf3);


outfinal := outf3 + outf2(compname = '');

ut.MAC_SF_BuildProcess(outfinal,'~thor_data400::base::merch_vessels',do_it,2)

export proc_build_base := sequential(pre,do_it);