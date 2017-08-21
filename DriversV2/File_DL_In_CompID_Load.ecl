export File_DL_In_CompID_Load := module

	export NE := function
	
		filterNE	:=	dataset('~thor_data400::combdmv::base', DriversV2.Layout_DL_In_CompID_Load,thor)(dl_state='NE');
		return FilterNE;
		
	end;
	
	export NV := function
	
		filterNV	:=	dataset('~thor_data400::combdmv::base', DriversV2.Layout_DL_In_CompID_Load,thor)(dl_state='NV');
		return FilterNV;
		
	end;
	
	export LA := function
	
		filterLA	:=	dataset('~thor_data400::combdmv::base', DriversV2.Layout_DL_In_CompID_Load,thor)(dl_state='LA');
		return FilterLA;
		
	end;
	
	export OR := function
	
		filterOR	:=	dataset('~thor_data400::combdmv::base', DriversV2.Layout_DL_In_CompID_Load,thor)(dl_state='OR');
		return FilterOR;
		
	end;
end;
		