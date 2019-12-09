import Gong,PhonesPlus_v2;

//CCPA-799 VC: Input files with optout applied
EXPORT File_OptedOut_Inputs := Module;

	ds_Gong 	  := Gong.Key_History_Phone;
  EXPORT Gong := PhonesInfo.fn_Apply_OptOut.Gong(ds_Gong):persist('~thor400_sta_eclcc::persist::optedout::gong'); //Apply optout close to input as we don't carry DID forward.

  //Not needed as phonesplus already has the optout
	// ds_Phonesplus     := PhonesPlus_v2.Key_Phonesplus_Fdid;
  // EXPORT Phonesplus := PhonesInfo.fn_Apply_OptOut.pplus(ds_Phonesplus):persist('Persist::Optedout::Gong'); //Apply optout close to input as we don't carry DID forward.


End;