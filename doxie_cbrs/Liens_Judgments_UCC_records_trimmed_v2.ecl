IMPORT doxie, doxie_crs;

EXPORT Liens_Judgments_UCC_records_trimmed_v2(DATASET(doxie_cbrs.layout_references) bdids, STRING6 SSNMask = 'NONE') :=
MODULE

doxie_cbrs.mac_Selection_Declare()
shared raw_jls := doxie_cbrs.Liens_Judments_records_v2(bdids, SSNMask).report_view(Max_LiensJudgmentsUCC_val)(Include_LiensJudgmentsV2_val or Include_LiensJudgmentsUCCV2_val);
doxie_cbrs.mac_Selection_Declare()
shared raw_uccs := doxie_cbrs.UCC_Records_v2(bdids, SSNMask).report_view(Max_UCCFilings_val)(Include_UCCFilingsV2_val or Include_LiensJudgmentsUCCV2_val);

doxie_cbrs.mac_Selection_Declare()
jls := choosen(raw_jls,Max_LiensJudgmentsUCC_val);
uccs := choosen(raw_uccs,Max_UCCFilings_val);

jls_trimmed := jls;
uccs_trimmed := uccs;

recjl := recordof(jls_trimmed);
recucc := recordof(uccs_trimmed);

//***** THE COMBINED LAYOUT
rec := record, maxlength(doxie_crs.maxlength_report)
	dataset(recjl) Judgment_Liens;
	dataset(recucc) UCCS;
end;

//***** PROJECT THEM IN
nada := dataset([0], {unsigned1 a});
rec getJL(nada l) := transform
	self.Judgment_Liens := global(jls_trimmed);
	self.UCCS := global(uccs_trimmed);
end;

export records := project(nada,getJL(LEFT));
export records_count := count(raw_jls) + count(raw_uccs);

END;