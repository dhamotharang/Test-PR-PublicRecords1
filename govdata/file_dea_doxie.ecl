import dea;

/*
layout_dea_out := record
	layout_dea_in;
	string12	did;
	string3		score;
	string9		best_ssn;
end;
*/
export file_dea_doxie := dataset('~thor_data400::base::dea_BUILT',{dea.layout_dea_out,unsigned8 __fpos {virtual(fileposition)}},flat);