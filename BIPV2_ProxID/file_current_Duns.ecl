import dnb_dmi;
EXPORT file_current_Duns(
	 dataset(dnb_dmi.Layouts.base.companies	)	pFile_DNB_Base	= dnb_dmi.files().base.companies.qa
	,string														        pPersistname		= '~thor_data400::persist::BIPV2_ProxID::file_current_Duns'	
  ,unsigned6                                pDateCutoff     = 0
  
) :=
function
  du := pFile_DNB_Base(active_duns_number = 'Y',rawfields.duns_number != '',date_last_seen > pDateCutoff);
  du_slim := table(du,{string9 duns_number := rawfields.duns_number},rawfields.duns_number)
//    :persist(pPersistname)
;
  return du_slim;
end;
