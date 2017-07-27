import dea;

layout_dea_out := record
	dea.layout_DEA_Out;
end;

export File_DEA_KeyBuilt := dataset('~thor_Data400::base::dea_BUILT',{layout_DEA_out,unsigned8 __fpos { virtual(fileposition)}},flat);