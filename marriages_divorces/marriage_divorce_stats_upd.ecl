#workunit('name','MARRIAGE/DIVORCE STATS')
import marriages_divorces;

export marriage_divorce_stats_upd := function

layout_marrdiv_stats := record
	File_Marriage_Divorce_Base.state_origin;
	File_Marriage_Divorce_Base.source_file;
	File_Marriage_Divorce_Base.source_county;
	File_Marriage_Divorce_Base.filing_type;
	total_records := count(group);
end;

mardiv_stats := table(File_Marriage_Divorce_Base,
					  layout_marrdiv_stats,
					  File_Marriage_Divorce_Base.state_origin, File_Marriage_Divorce_Base.source_file, File_Marriage_Divorce_Base.source_county, File_Marriage_Divorce_Base.filing_type,
					  few);

return output(mardiv_stats,,all);

end;