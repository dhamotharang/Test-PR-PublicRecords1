IMPORT Business_Header, ut;

bh := Business_Header.File_Prep_Business_Header_Plus;
bh_ded := DEDUP(bh, bdid, source, ALL);

layout_src_seq := RECORD
	bh.source;
	UNSIGNED6 seq := 0;
	bh.state;
	bh.__filepos;
END;

ut.MAC_Sequence_Records_NewRec(bh_ded, layout_src_seq, seq, outf)

export Key_Prep_BH_Source := INDEX(
	outf,
	{source, seq, state, __filepos},
	'~thor_data400::key::business_header.src' + thorlib.wuid());