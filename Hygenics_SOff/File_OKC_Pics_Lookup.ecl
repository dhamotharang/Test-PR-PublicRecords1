import  okc_sexual_offenders,Data_Services;
 
 ds := dataset(Data_Services.foreign_prod+'thor_200::in::hd_sex_off::lookup::superfile',OKC_Sexual_Offenders.Layout_OKC_Pics_Lookup,csv(separator('/'),terminator(['\r\n','\r','\n']),quote('"')));
 
 OKC_Sexual_Offenders.Layout_OKC_Pics_Lookup fixState(ds l):= transform
	 // self.state_of_origin := if(StringLib.StringToUpperCase(l.state_of_origin)[1..4]='GUAM',
								// regexreplace('AMSOR.PHOTOS', StringLib.StringToUpperCase(l.state_of_origin), ''),
								// regexreplace('SOR.PHOTOS', StringLib.StringToUpperCase(l.state_of_origin), '')); //need to populate only the state

     self.state_of_origin := Map(StringLib.StringToUpperCase(l.state_of_origin) = 'CO_SOTAR' => 'CO',
		                              StringLib.StringToUpperCase(l.state_of_origin) = 'US_TRIBES' => 'US',
																    StringLib.StringToUpperCase(l.state_of_origin)[1..4]='GUAM'
								                      => regexreplace('AMSOR.PHOTOS', StringLib.StringToUpperCase(l.state_of_origin), ''),
	                                          regexreplace('SOR.PHOTOS', StringLib.StringToUpperCase(l.state_of_origin), ''));

		 self.image_file_name := StringLib.StringToUpperCase(l.image_file_name);
	 self := l;
 end;
 
 ds_project := project(ds,fixState(left));
 
export File_OKC_Pics_Lookup := ds_project;

