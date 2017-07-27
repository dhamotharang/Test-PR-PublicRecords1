ms_workers_base := govdata.File_MS_Workers_Comp_BDID;
count(ms_workers_base);
count(ms_workers_base(date_claim_filed <> ''));

layout_ms_workers := record
ms_workers_base.date_claim_filed;
end;

ms_workers_stat := table(ms_workers_base,layout_ms_workers);

Layout_ms_workers_Stat := RECORD
	string8 min_recording_date := min(group,ms_workers_stat.date_claim_filed);
	string8 max_recording_date := max(group,ms_workers_stat.date_claim_filed);
END;

ms_workers_Stat2 := TABLE(ms_workers_stat, Layout_ms_workers_Stat, FEW);

OUTPUT(ms_workers_Stat2);
