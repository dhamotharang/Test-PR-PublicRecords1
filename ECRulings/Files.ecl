import versioncontrol;
export Files(string pversion='') := module;

//Note: following...(trimUpper(dartID)<>'DARTID') will filter out any header records from raw input
export  RawIN_Competition 					:=dataset('~thor_data400::raw_base::ecrulings_competition',ECRulings.Layouts.Competition,csv(heading(1),separator('|'),terminator(['\r\n','\n']))) (trim(stringlib.StringToUppercase(DartID),left,right)<>'DARTID');
export  RawIN_DecisionPublication 	:=dataset('~thor_data400::raw_base::ecrulings_decisionpublication',ECRulings.Layouts.DecisionPublication,csv(heading(1),separator('|'),terminator(['\r\n','\n'])))(trim(stringlib.StringToUppercase(DartID),left,right)<>'DARTID');
export  RawIN_EconomicActivity 			:=dataset('~thor_data400::raw_base::ecrulings_economicactivity',ECRulings.Layouts.EconomicActivity,csv(heading(1),separator('|'),terminator(['\r\n','\n'])))(trim(stringlib.StringToUppercase(DartID),left,right)<>'DARTID');
export  RawIN_EventDocument 				:=dataset('~thor_data400::raw_base::ecrulings_eventdocument',ECRulings.Layouts.Eventdocument,csv(heading(1),separator('|'),terminator(['\r\n','\n'])))(trim(stringlib.StringToUppercase(DartID),left,right)<>'DARTID');

 versioncontrol.macBuildFileVersions(Filenames(pversion).Base, ECRulings.Layouts.Clean_comp_DeciPub_EconomicAct_Eventdoc, Base); 
								
export Keybase :=	dataset( _Dataset().thor_cluster_files +'base::'+  _Dataset().name +'::'+pversion+'::data',ECRulings.Layouts.Clean_comp_DeciPub_EconomicAct_Eventdoc,flat);	//logical file
 

	 end;