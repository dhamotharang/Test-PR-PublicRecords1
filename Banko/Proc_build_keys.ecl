import roxiekeybuild,dx_Banko;

EXPORT Proc_build_keys(string filedate) := function

KeyCaseNum         := '~thor_data400::key::banko::' + filedate + '::courtcode.casenumber.caseId.payload';
KeyCaseNumFcra     := '~thor_data400::key::banko::fcra::' + filedate + '::courtcode.casenumber.caseId.payload';
KeyFullCaseNum     := '~thor_data400::key::banko::' + filedate + '::courtcode.fullcasenumber.caseId.payload';
KeyFullCaseNumFcra := '~thor_data400::key::banko::fcra::' + filedate + '::courtcode.fullcasenumber.caseId.payload';
KeyDeltarid        := '~thor_data400::key::banko::' + filedate + '::Delta_rid';
KeyDeltaridFcra    := '~thor_data400::key::banko::fcra::' + filedate + '::Delta_rid';

RoxieKeybuild.MAC_build_logical(dx_Banko.Key_Banko_courtcode_casenumber(0), Banko.Data_Key_Banko_courtcode_casenumber(), '', KeyCaseNum, nonfcrakey);
RoxieKeybuild.MAC_build_logical(dx_Banko.Key_Banko_courtcode_casenumber(1), Banko.Data_Key_Banko_courtcode_casenumber(true), '', KeyCaseNumFcra, fcrakey);

RoxieKeybuild.MAC_build_logical(dx_Banko.Key_Banko_courtcode_Fullcasenumber(0), Banko.Data_Key_Banko_courtcode_Fullcasenumber(), '', KeyFullCaseNum, nonfcrafullkey);
RoxieKeybuild.MAC_build_logical(dx_Banko.Key_Banko_courtcode_Fullcasenumber(1), Banko.Data_Key_Banko_courtcode_Fullcasenumber(true), '', KeyFullCaseNumFcra, fcrafullkey);

RoxieKeybuild.MAC_build_logical(dx_Banko.Key_Banko_Delta_rid(0), Banko.Data_Key_Banko_Delta_rid(), '', KeyDeltarid, nonfcraridkey);
RoxieKeybuild.MAC_build_logical(dx_Banko.Key_Banko_Delta_rid(1), Banko.Data_Key_Banko_Delta_rid(true), '', KeyDeltaridFcra, fcraridkey);


//Add to "build" superfile
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::@version@::courtcode.casenumber.caseId.payload','D',mvnonfcra,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::fcra::@version@::courtcode.casenumber.caseId.payload','D',mvfcra,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::@version@::courtcode.fullcasenumber.caseId.payload','D',mvnonfcrafull,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::fcra::@version@::courtcode.fullcasenumber.caseId.payload','D',mvfcrafull,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::@version@::Delta_rid','D',mvnonfcraRid,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::fcra::@version@::Delta_rid','D',mvfcraRid,filedate);


return  sequential( parallel(nonfcrakey,fcrakey,nonfcrafullkey,fcrafullkey,nonfcraridkey,fcraridkey)
                   ,mvnonfcra,mvfcra,mvnonfcrafull,mvfcrafull,mvnonfcraRid,mvfcraRid
									);
end;																							 


// Roxie keys	
//	abbreviated case number keys				
// roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_casenumber(),'foo',
						// '~thor_data400::key::banko::' + filedate + '::courtcode.casenumber.caseId.payload',nonfcrakey);
// roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::@version@::courtcode.casenumber.caseId.payload','D',mvnonfcra,filedate);

// roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_casenumber(true),'foo',
						// '~thor_data400::key::banko::fcra::' + filedate + '::courtcode.casenumber.caseId.payload',fcrakey);
// roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::fcra::@version@::courtcode.casenumber.caseId.payload','D',mvfcra,filedate);
// full case number keys				
// roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_fullcasenumber(),'foo',
						// '~thor_data400::key::banko::' + filedate + '::courtcode.fullcasenumber.caseId.payload',nonfcrafullkey);
// roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::@version@::courtcode.fullcasenumber.caseId.payload','D',mvnonfcrafull,filedate);

// roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_fullcasenumber(true),'foo',
						// '~thor_data400::key::banko::fcra::' + filedate + '::courtcode.fullcasenumber.caseId.payload',fcrafullkey);
// roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::fcra::@version@::courtcode.fullcasenumber.caseId.payload','D',mvfcrafull,filedate);
