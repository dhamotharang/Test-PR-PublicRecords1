#workunit('name', 'DKC Emerges Keys');

import emerges, _Control;

export DKC_Emerges(string dkc_server_name, string dkc_volume) := function

	dkc_server := map (dkc_server_name = 'edata10' => _control.IPAddress.edata10,
										 dkc_server_name = 'edata12' => _control.IPAddress.edata12,
										 dkc_server_name = 'edata14' => _control.IPAddress.edata14,
										 dkc_server_name
										 );
										 
//Emerges Voters Moxie DKC

	/*fileservices.dkc('~thor_data400::key::moxie.emerges_vote.fpos.data.key',dkc_server,dkc_volume+'/emerges_vote.fpos.data.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.lfmname.key',dkc_server,dkc_volume+'/emerges_vote.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_vote.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.st.lfmname.key',dkc_server,dkc_volume+'/emerges_vote.st.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.st.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_vote.st.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.st.city.lfmname.key',dkc_server,dkc_volume+'/emerges_vote.st.city.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.st.city.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_vote.st.city.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.z5.lfmname.key',dkc_server,dkc_volume+'/emerges_vote.z5.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.z5.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_vote.z5.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.dob.lfmname.key',dkc_server,dkc_volume+'/emerges_vote.dob.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.dob.fmlname.key',dkc_server,dkc_volume+'/emerges_vote.dob.fmlname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.mfname.dob.key',dkc_server,dkc_volume+'/emerges_vote.mfname.dob.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.ssn.key',dkc_server,dkc_volume+'/emerges_vote.ssn.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.state.type.lfmname.key',dkc_server,dkc_volume+'/emerges_vote.state.type.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.did.key',dkc_server,dkc_volume+'/emerges_vote.did.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn.key',dkc_server,dkc_volume+'/emerges_vote.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',dkc_server,dkc_volume+'/emerges_vote.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.z5.street_name.predir.postdir.prim_range.lname.key',dkc_server,dkc_volume+'/emerges_vote.z5.street_name.predir.postdir.prim_range.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_vote.qa_date.st.lfmname.key',dkc_server,dkc_volume+'/emerges_vote.qa_date.st.lfmname.key',,,,true);*/

//Emerges Hunt Moxie DKC

	fileservices.despray('~thor_data400::emerges::hunt_out',dkc_server,dkc_volume+'/emerges_hunt.d00',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.lfmname.key',dkc_server,dkc_volume+'/emerges_hunt.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_hunt.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.st.lfmname.key',dkc_server,dkc_volume+'/emerges_hunt.st.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.st.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_hunt.st.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.st.city.lfmname.key',dkc_server,dkc_volume+'/emerges_hunt.st.city.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.st.city.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_hunt.st.city.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.z5.lfmname.key',dkc_server,dkc_volume+'/emerges_hunt.z5.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.z5.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_hunt.z5.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.dob.lfmname.key',dkc_server,dkc_volume+'/emerges_hunt.dob.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.dob.fmlname.key',dkc_server,dkc_volume+'/emerges_hunt.dob.fmlname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.mfname.dob.key',dkc_server,dkc_volume+'/emerges_hunt.mfname.dob.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.ssn.key',dkc_server,dkc_volume+'/emerges_hunt.ssn.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.state.type.lfmname.key',dkc_server,dkc_volume+'/emerges_hunt.state.type.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.did.key',dkc_server,dkc_volume+'/emerges_hunt.did.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn.key',dkc_server,dkc_volume+'/emerges_hunt.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',dkc_server,dkc_volume+'/emerges_hunt.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.z5.street_name.predir.postdir.prim_range.lname.key',dkc_server,dkc_volume+'/emerges_hunt.z5.street_name.predir.postdir.prim_range.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_hunt.qa_date.st.lfmname.key',dkc_server,dkc_volume+'/emerges_hunt.qa_date.st.lfmname.key',,,,true);

//Emerges CCW Moxie DKC

	fileservices.despray('~thor_data400::emerges::ccw_out',dkc_server,dkc_volume+'/emerges_ccw.d00',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.unique_id.key',dkc_server,dkc_volume+'/emerges_ccw.unique_id.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.lfmname.key',dkc_server,dkc_volume+'/emerges_ccw.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_ccw.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.st.lfmname.key',dkc_server,dkc_volume+'/emerges_ccw.st.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.st.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_ccw.st.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.st.city.lfmname.key',dkc_server,dkc_volume+'/emerges_ccw.st.city.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.st.city.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_ccw.st.city.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.z5.lfmname.key',dkc_server,dkc_volume+'/emerges_ccw.z5.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.z5.dph_lname.fname.mname.lname.key',dkc_server,dkc_volume+'/emerges_ccw.z5.dph_lname.fname.mname.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.dob.lfmname.key',dkc_server,dkc_volume+'/emerges_ccw.dob.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.dob.fmlname.key',dkc_server,dkc_volume+'/emerges_ccw.dob.fmlname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.mfname.dob.key',dkc_server,dkc_volume+'/emerges_ccw.mfname.dob.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.ssn.key',dkc_server,dkc_volume+'/emerges_ccw.ssn.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.state.type.lfmname.key',dkc_server,dkc_volume+'/emerges_ccw.state.type.lfmname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.did.key',dkc_server,dkc_volume+'/emerges_ccw.did.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn.key',dkc_server,dkc_volume+'/emerges_ccw.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',dkc_server,dkc_volume+'/emerges_ccw.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.z5.street_name.predir.postdir.prim_range.lname.key',dkc_server,dkc_volume+'/emerges_ccw.z5.street_name.predir.postdir.prim_range.lname.key',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.emerges_ccw.qa_date.st.lfmname.key',dkc_server,dkc_volume+'/emerges_ccw.qa_date.st.lfmname.key',,,,true);

	return 'DKC of emerges keys successful';

end;