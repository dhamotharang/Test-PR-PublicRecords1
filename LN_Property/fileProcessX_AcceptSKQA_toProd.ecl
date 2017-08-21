export fileProcessX_AcceptSKQA_toProd() := function
import ut;

ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyAddr_search_fid, 'P', do1)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeySearch_did, 'P', do2)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeydeed_parcelnum, 'P', do3)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyAssessor_parcelnum, 'P', do4)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyDeed_fid, 'P', do5)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyAssessor_fid, 'P', do6)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeySearch_fid_county, 'P', do7)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyBdid, 'P', do8)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyAddlnames_fid, 'P', do9)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeySearch_fid, 'P', do10)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKey_Prop_Address, 'P', do11)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKey_Prop_Ownership, 'P', do12)

filedate := ln_property.version_build;

jobComplete := FileServices.sendemail('jtolbert@seisint.com, jbreffni@seisint.com', ' LN Property Roxie Keys Moved from QA to prod - ' + filedate,
               'Keys: 1) thor_data400::key::ln_property::prod::addr_search.fid,\n' + 
					     '      2) thor_data400::key::ln_property::prod::search.did,\n' + 
					     '      3) thor_data400::key::ln_property::prod::deed_parcelNum,\n' + 
					     '      4) thor_data400::key::ln_property::prod::assessor_parcelNum,\n' + 
					     '      5) thor_Data400::key::ln_property::prod::deed.fid,\n' + 
					     '      6) thor_data400::key::ln_property::prod::assessor.fid,\n' + 
					     '      7) thor_data400::key::ln_property::prod::search.fid_county,\n' + 
               '      8) thor_data400::key::ln_property::prod::bdid,\n' + 
               '      9) thor_data400::key::ln_property::prod::addlnames.fid,\n' + 
               '     10) thor_data400::key::ln_property::prod::search.fid,\n' + 							 
			         '     11) thor_data400::key::ln_property::prod::addr.full,\n' +
			         '     12) thor_data400::key::ln_property::prod::did.ownership,\n' +
		           '          ');
			
jobFailed := FileServices.sendemail('jtolbert@seisint.com, jbreffni@seisint.com', ' LN Property Roxie Key Move QA to Prod Failed - ' + filedate, failmessage);			

parallel(do1, do2, do3, do4, do5, do6, do7, do8, do9, do10, do11, do12)
: success(jobComplete), failure(jobFailed);

return 'AcceptSK_toQA';									
end;