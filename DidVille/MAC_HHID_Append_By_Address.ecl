EXPORT MAC_HHID_Append_By_Address
(
	 infile,
	 outfile,
	 hhid_field,
	 lname_field,
	 prange_field,
	 pname_field,
	 srange_field,
	 state_field,
	 zip_field
):= MACRO

IMPORT ut, header_slimsort;

#uniquename(layout_inf_seq)
#uniquename(seq)
%layout_inf_seq% := RECORD
	UNSIGNED8 %seq%;
	infile;
END;

#uniquename(inf_seq)
ut.MAC_Sequence_Records_NewRec(infile, %layout_inf_seq%, %seq%, %inf_seq%)

#uniquename(inf_seq_dist)
%inf_seq_dist% := DISTRIBUTE(%inf_seq%, HASH(
	(QSTRING20) lname_field, (QSTRING28) pname_field));

#uniquename(hhid_ss_dist)
%hhid_ss_dist% := DISTRIBUTE(header_slimsort.File_Household,
	HASH(lname, prim_name));

#uniquename(join_ss)
%layout_inf_seq% %join_ss%(%hhid_ss_dist% l, %inf_seq_dist% r) := TRANSFORM
	SELF.hhid_field := l.hhid_relat;
	SELF := r;
END;

#uniquename(j1)
%j1% := JOIN(%hhid_ss_dist%, %inf_seq_dist%,
	LEFT.lname = RIGHT.lname_field AND
	LEFT.prim_range = RIGHT.prange_field AND
	LEFT.prim_name = RIGHT.pname_field AND
	LEFT.st = RIGHT.state_field AND
	(
		LEFT.zip = RIGHT.zip_field OR
		ut.zip_Dist(LEFT.zip, RIGHT.zip_field) < 50
	) AND
	(
		(
			LEFT.sec_range = RIGHT.srange_field AND
			LEFT.sec_range != '' AND
			LEFT.hhid_cnt = 1
		) OR
		LEFT.hhid_nosec_cnt = 1
	),
	%join_ss%(LEFT, RIGHT), RIGHT OUTER, LOCAL);

#uniquename(j_ded)
%j_ded% := DEDUP(%j1%, %seq%, ALL);

ut.MAC_Slim_Back(%j_ded%, TYPEOF(infile), outfile)

ENDMACRO;
