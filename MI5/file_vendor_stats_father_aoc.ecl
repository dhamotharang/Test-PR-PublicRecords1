
import crim_cp_ln;

export file_vendor_stats_father_aoc := 
if(fileservices.GetSuperFileSubCount('~thor_data400::base::crim_vendor_stats_aoc_father')=1,
				dataset('~thor_data400::base::crim_vendor_stats_aoc_father',layout_vendor_stats_aoc,thor),
			dataset([],layout_vendor_stats_aoc));
