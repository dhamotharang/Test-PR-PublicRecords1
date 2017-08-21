export fileProcessG_AcceptSK_toQA(string pGroup
												        ) := function
import ut;

ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyAddr_search_fid, 'Q', do1)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeySearch_did, 'Q', do2)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeydeed_parcelnum, 'Q', do3)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyAssessor_parcelnum, 'Q', do4)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyDeed_fid, 'Q', do5)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyAssessor_fid, 'Q', do6)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeySearch_fid_county, 'Q', do7)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyBdid, 'Q', do8)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeyAddlnames_fid, 'Q', do9)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKeySearch_fid, 'Q', do10)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKey_Prop_Address, 'Q', do11)
ut.mac_sf_move_standard(ln_property.fileNames.versionedKey_Prop_Ownership, 'Q', do12)

// FCRA
ut.mac_sf_move_standard(ln_property.filenames.versionedKeyAddr_search_fid_fcra, 'Q', do13);
ut.mac_sf_move_standard(ln_property.filenames.versionedKeySearch_did_fcra, 'Q', do14);
ut.mac_sf_move_standard(ln_property.filenames.versionedKeyDeed_fid_fcra, 'Q', do15);
ut.mac_sf_move_standard(ln_property.filenames.versionedKeyAssessor_fid_fcra, 'Q', do16);
ut.mac_sf_move_standard(ln_property.filenames.versionedKeySearch_fid_fcra, 'Q', do17);
ut.mac_sf_move_standard(ln_property.filenames.versionedKey_Prop_Address_fcra, 'Q', do18);
ut.mac_sf_move_standard(ln_property.filenames.versionedKey_Prop_Ownership_fcra, 'Q', do19);
ut.mac_sf_move_standard(ln_property.filenames.versionedKeyAddlNames_fid_fcra, 'Q', do20);
ut.mac_sf_move_standard(ln_property.filenames.versionedKeySearch_fid_county_fcra, 'Q', do21);
ut.mac_sf_move_standard(ln_property.filenames.versionedKeySearch_bdid_fcra, 'Q', do22);

filedate := ln_property.version_build;

jobComplete := FileServices.sendemail('RoxieBuilds@seisint.com;kgummadi@seisint.com', ' LN Property Roxie Keys Moved to QA - ' + filedate,
               'Keys: 1) thor_data400::key::ln_property::qa::addr_search.fid(thor_data400::key::ln_property::'+filedate+'::addr_search.fid),\n' + 
					     '      2) thor_data400::key::ln_property::qa::search.did(thor_data400::key::ln_property::'+filedate+'::search.did),\n' + 
					     '      3) thor_data400::key::ln_property::qa::deed_parcelNum(thor_data400::key::ln_property::'+filedate+'::deed_parcelNum),\n' + 
					     '      4) thor_data400::key::ln_property::qa::assessor_parcelNum(thor_data400::key::ln_property::'+filedate+'::assessor_parcelNum),\n' + 
					     '      5) thor_Data400::key::ln_property::qa::deed.fid(thor_Data400::key::ln_property::'+filedate+'::deed.fid),\n' + 
					     '      6) thor_data400::key::ln_property::qa::assessor.fid(thor_data400::key::ln_property::'+filedate+'::assessor.fid),\n' + 
					     '      7) thor_data400::key::ln_property::qa::search.fid_county(thor_data400::key::ln_property::'+filedate+'::search.fid_county),\n' + 
               '      8) thor_data400::key::ln_property::qa::bdid(thor_data400::key::ln_property::'+filedate+'::bdid),\n' + 
               '      9) thor_data400::key::ln_property::qa::addlnames.fid(thor_data400::key::ln_property::'+filedate+'::addlnames.fid),\n' + 
               '     10) thor_data400::key::ln_property::qa::search.fid(thor_data400::key::ln_property::'+filedate+'::search.fid),\n' + 							 
			   '     11) thor_data400::key::ln_property::qa::addr.full(thor_data400::key::ln_property::'+filedate+'::addr.full),\n' +
			   '     12) thor_data400::key::ln_property::qa::did.ownership(thor_data400::key::ln_property::'+filedate+'::did.ownership),\n' +

			   '     13) thor_data400::key::ln_property::fcra::qa::addr_search.fid(thor_data400::key::ln_property::fcra::'+filedate+'::addr_search.fid),\n' +
			   '     14) thor_data400::key::ln_property::fcra::qa::search.did(thor_data400::key::ln_property::fcra::'+filedate+'::search.didp),\n' +
			   '     15) thor_data400::key::ln_property::fcra::qa::deed.fid(thor_data400::key::ln_property::fcra::'+filedate+'::deed.fid),\n' +
			   '     16) thor_data400::key::ln_property::fcra::qa::assessor.fid(thor_data400::key::ln_property::fcra::'+filedate+'::assessor.fid),\n' +
			   '     17) thor_data400::key::ln_property::fcra::qa::search.fid(thor_data400::key::ln_property::fcra::'+filedate+'::search.fid),\n' +
			   '     18) thor_data400::key::ln_property::fcra::qa::addr.full(thor_data400::key::ln_property::fcra::'+filedate+'::addr.full),\n' +
			   '     19) thor_data400::key::ln_property::fcra::qa::did.ownership(thor_data400::key::ln_property::fcra::'+filedate+'::did.ownership),\n' +
			   '     20) thor_data400::key::ln_property::fcra::qa::addlnames.fid(thor_data400::key::ln_property::fcra::'+filedate+'::addlnames.fid),\n' +
			   '     21) thor_data400::key::ln_property::fcra::qa::search.fid_county(thor_data400::key::ln_property::fcra::'+filedate+'::search.fid_county),\n' +
			   '     22) thor_data400::key::ln_property::fcra::qa::bdid(thor_data400::key::ln_property::fcra::'+filedate+'::bdid),\n' +
			   '     23) thor_data400::key::avm::qa::address(thor_data400::key::avm::'+filedate+'::address),\n' +
			   '     24) thor_data400::key::avm::qa::apn(thor_data400::key::avm::'+filedate+'::apn),\n' +
		           '          ');
			
jobFailed := FileServices.sendemail('kgummadi@seisint.com', ' LN Property Roxie Key Move to QA Failed - ' + filedate, failmessage);			

parallel(do1, do2, do3, do4, do5, do6, do7, do8, do9, do10, do11, do12,
         do13, do14, do15, do16, do17, do18, do19, do20, do21, do22)
: success(jobComplete), failure(jobFailed);

return 'AcceptSK_toQA';									
end;