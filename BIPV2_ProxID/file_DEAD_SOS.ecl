import corp2,paw;
EXPORT file_DEAD_SOS(
	 dataset(Corp2.Layout_Corporate_Direct_Corp_Base	)	pCorpInactives  = PAW.fCorpInactives()
	,string														                  pPersistname		= '~thor_data400::persist::BIPV2_ProxID::file_current_SOS'													
) :=
function
  du := table(pCorpInactives  ,{corp_key},corp_key,local);
  du2 := table(du  ,{corp_key},corp_key)
      :persist(pPersistname);
  return du2;
end;
