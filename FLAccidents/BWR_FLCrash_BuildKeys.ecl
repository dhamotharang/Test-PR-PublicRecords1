//this program is to build flcrash keys
import ut;

pre0 := sequential(
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash0_building') > 0,
			output('Nonthing added to flcrash0_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash0_building','~thor_data400::base::flcrash0',,true)),
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash1_building') > 0,
			output('Nonthing added to flcrash1_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash1_building','~thor_data400::base::flcrash1',,true)),	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash2v_building') > 0,
			output('Nonthing added to flcrash2v_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash2v_building','~thor_data400::base::flcrash2v',,true)),	
     	if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash3v_building') > 0,
			output('Nonthing added to flcrash3v_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash3v_building','~thor_data400::base::flcrash3v',,true)),	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash4_building') > 0,
			output('Nonthing added to flcrash4_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash4_building','~thor_data400::base::flcrash4',,true)),	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash5_building') > 0,
			output('Nonthing added to flcrash5_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash5_building','~thor_data400::base::flcrash5',,true)),	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash6_building') > 0,
			output('Nonthing added to flcrash6_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash6_building','~thor_data400::base::flcrash6',,true)),	
          if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash7_building') > 0,
			output('Nonthing added to flcrash7_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash7_building','~thor_data400::base::flcrash7',,true)),	  
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash_did_building') > 0,
			output('Nonthing added to flcrash_did_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash_did_building','~thor_data400::base::flcrash_did',,true)),	  	
		fileservices.finishsuperfiletransaction()
		);
		
ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash0,
                       '~thor_data400::key::flcrash0_',
				   '~thor_data400::key::flcrash0',bk0,2);
ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash1,
                       '~thor_data400::key::flcrash1_',
				   '~thor_data400::key::flcrash1',bk1,2);
ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash2v,
                       '~thor_data400::key::flcrash2v_',
				   '~thor_data400::key::flcrash2v',bk2,2);
ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash3v,
                       '~thor_data400::key::flcrash3v_',
				   '~thor_data400::key::flcrash3v',bk3,2);
ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash4,
                       '~thor_data400::key::flcrash4_',
				   '~thor_data400::key::flcrash4',bk4,2);
ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash5,
                       '~thor_data400::key::flcrash5_',
				   '~thor_data400::key::flcrash5',bk5,2);
ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash6,
                       '~thor_data400::key::flcrash6_',
				   '~thor_data400::key::flcrash6',bk6,2);
ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash7,
                       '~thor_data400::key::flcrash7_',
				   '~thor_data400::key::flcrash7',bk7,2);

ut.MAC_SK_BuildProcess(flaccidents.Key_Flcrash_AccNbr,
                       '~thor_data400::key::flcrash_accnbr_',
				   '~thor_data400::key::flcrash_accnbr',bk_accnbr,2);

ut.MAC_SK_BuildProcess(flaccidents.Key_Flcrash_Bdid,
                       '~thor_data400::key::flcrash_bdid_',
				   '~thor_data400::key::flcrash_bdid',bk_bdid,2);

ut.MAC_SK_BuildProcess(flaccidents.Key_Flcrash_Did,
                       '~thor_data400::key::flcrash_did_',
				   '~thor_data400::key::flcrash_did',bk_did,2);

ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash_DLNbr,
                       '~thor_data400::key::flcrash_dlnbr_',
				   '~thor_data400::key::flcrash_dlnbr',bk_dlnbr,2);

ut.MAC_SK_BuildProcess(flaccidents.Key_FLCrash_TagNbr,
                       '~thor_data400::key::flcrash_tagnbr_',
				   '~thor_data400::key::flcrash_tagnbr',bk_tagnbr,2);

ut.MAC_SK_BuildProcess(flaccidents.Key_Flcrash_VIN,
                       '~thor_data400::key::flcrash_vin_',
				   '~thor_data400::key::flcrash_vin',bk_vin,2);

pre1 := sequential(
		fileservices.startsuperfiletransaction(),
		
		fileservices.clearsuperfile('~thor_data400::base::flcrash0_built'),
		fileservices.addsuperfile('~thor_data400::base::flcrash0_built','~thor_data400::base::flcrash0_building',,true),
		fileservices.clearsuperfile('~thor_data400::base::flcrash0_building'),
		
		fileservices.clearsuperfile('~thor_data400::base::flcrash1_built'),
		fileservices.addsuperfile('~thor_data400::base::flcrash1_built','~thor_data400::base::flcrash1_building',,true),
		fileservices.clearsuperfile('~thor_data400::base::flcrash1_building'),
		
		fileservices.clearsuperfile('~thor_data400::base::flcrash2v_built'),
		fileservices.addsuperfile('~thor_data400::base::flcrash2v_built','~thor_data400::base::flcrash2v_building',,true),	
		fileservices.clearsuperfile('~thor_data400::base::flcrash2v_building'),
		
		fileservices.clearsuperfile('~thor_data400::base::flcrash3v_built'),
		fileservices.addsuperfile('~thor_data400::base::flcrash3v_built','~thor_data400::base::flcrash3v_building',,true),	
		fileservices.clearsuperfile('~thor_data400::base::flcrash3v_building'),
		
		fileservices.clearsuperfile('~thor_data400::base::flcrash4_built'),
		fileservices.addsuperfile('~thor_data400::base::flcrash4_built','~thor_data400::base::flcrash4_building',,true),	
		fileservices.clearsuperfile('~thor_data400::base::flcrash4_building'),
		
		fileservices.clearsuperfile('~thor_data400::base::flcrash5_built'),
		fileservices.addsuperfile('~thor_data400::base::flcrash5_built','~thor_data400::base::flcrash5_building',,true),	
		fileservices.clearsuperfile('~thor_data400::base::flcrash5_building'),
		
		fileservices.clearsuperfile('~thor_data400::base::flcrash6_built'),
		fileservices.addsuperfile('~thor_data400::base::flcrash6_built','~thor_data400::base::flcrash6_building',,true),	
		fileservices.clearsuperfile('~thor_data400::base::flcrash6_building'),
		
		fileservices.clearsuperfile('~thor_data400::base::flcrash7_built'),
		fileservices.addsuperfile('~thor_data400::base::flcrash7_built','~thor_data400::base::flcrash7_building',,true),	
		fileservices.clearsuperfile('~thor_data400::base::flcrash7_building'),
		
          fileservices.clearsuperfile('~thor_data400::base::flcrash_did_built'),
		fileservices.addsuperfile('~thor_data400::base::flcrash_did_built','~thor_data400::base::flcrash_did_building',,true),	
		fileservices.clearsuperfile('~thor_data400::base::flcrash_did_building'),

          fileservices.finishsuperfiletransaction()
		);

export bwr_flcrash_buildkeys := sequential(pre0,
                                           parallel(bk0,bk1,bk2,bk3,bk4,bk5,bk6,bk7,bk_accnbr,bk_bdid,bk_did,bk_dlnbr,bk_tagnbr,bk_vin),
							        pre1);