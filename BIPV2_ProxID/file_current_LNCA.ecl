import dcav2;
EXPORT file_current_LNCA(
	 dataset(dcav2.Layouts.base.companies	)	pFile_LNCA_Base	= dcav2.files().base.companies.qa
	,string														      pPersistname		= '~thor_data400::persist::BIPV2_ProxID::file_current_LNCA'													
) :=
function
  du := pFile_LNCA_Base( rawfields.enterprise_num != '');
//  du := pFile_LNCA_Base(record_type in [dcav2.Utilities.RecordType.Updated,dcav2.Utilities.RecordType.New], rawfields.enterprise_num != '');
  du_slim := table(du,{string9 enterprise_num := rawfields.enterprise_num},rawfields.enterprise_num)
    :persist(pPersistname);
  return du_slim;
end;
