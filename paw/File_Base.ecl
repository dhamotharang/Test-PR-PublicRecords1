import ut;

//filtering out low score records. It might change upto test results
ut.mac_suppress_by_phonetype(files().base.built,phone,state,dsuppressWACellPhones,true,did);	

export File_Base :=dsuppressWACellPhones(score>'003');