import ingenix_natlprof,ut;

export File_in_ProviderSanctions  := Module
 
  export Allied_Health	:= dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_providersanction',Ingenix_NatlProf.Layout_in_ProviderSanctions.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf			:= dataset('~thor_data400::in::ingenix_natlprof_dentists_providersanction',Ingenix_NatlProf.Layout_in_ProviderSanctions.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician			:= dataset('~thor_data400::in::ingenix_natlprof_physicians_providersanction',Ingenix_NatlProf.Layout_in_ProviderSanctions.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  File_in 							:= dataset('~thor_data400::in::Ingenix_NatlProf_ProviderSanctions',Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));

	Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc tadddates(Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_srctype L) := Transform
		self.dt_first_seen := '';
		self.dt_last_seen := '';
		self.dt_vendor_first_reported := L.processdate;
		self.dt_vendor_last_reported := L.processdate;
		self  := L;
		self	:= [];
	end;
	
	export Allsrc := project(file_in, tadddates(left));
	
end;