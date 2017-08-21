#option('skipFileFormatCrcCheck', 1);
// Process to build the Accurint_In file, Search_File and Seisint Primary Key Image file.
// Need to update the version attribute with each new run

#workunit('name','OKC Sex Offender Build ' + OKC_Sexual_Offenders.Version_Development);

OKC_Sexual_Offenders.Out_Population_Stats(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In
                                         ,OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile
										 ,OKC_Sexual_Offenders.Version_Development
										 ,DoPopulationStats);

sequential(output(OKC_Sexual_Offenders.OKC_Sex_Offender_DID)
                   ,parallel(OKC_Sexual_Offenders.Mapping_OKC_Cleaned_As_Accurint_In
					         ,OKC_Sexual_Offenders.Mapping_OKC_Cleaned_As_SearchFile)
				   ,parallel(OKC_Sexual_Offenders.File_SPrimary_Key_Image_Link
					         ,OKC_Sexual_Offenders.Stats
							 ,DoPopulationStats)
		   );