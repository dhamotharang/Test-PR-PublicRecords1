export fileprocessE_AcceptSF_toQA(string pGroup
													        ) := function

import ut;

ut.mac_sf_move_standard(ln_property.fileNames.versionedBaseAssessor, 'Q', do1)
ut.mac_sf_move_standard(ln_property.fileNames.versionedBaseDeed, 'Q', do2)
ut.mac_sf_move_standard(ln_property.fileNames.versionedBaseSearch, 'Q', do3)
ut.mac_sf_move_standard(ln_property.fileNames.versionedBaseAddlNames, 'Q', do4)
ut.mac_sf_move_standard(ln_property.fileNames.versionedBasePropertyDID, 'Q', do5)

parallel(do1, do2, do3, do4, do5);

return 'AcceptSF_toQA';									
end;