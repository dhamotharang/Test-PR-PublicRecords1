



import RoxieKeybuild;

export BWR_Banko_key_build(string filedate) := function

roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_casenumber(),'foo',
						'~thor_data400::key::banko::' + filedate + '::courtcode.casenumber.caseId.payload',nonfcrakey);
						
roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_casenumber(true),'foo',
						'~thor_data400::key::banko::fcra::' + filedate + '::courtcode.casenumber.caseId.payload',fcrakey);
						

retval := sequential(parallel(nonfcrakey,fcrakey));

return retval;

end;





