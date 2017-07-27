import ut;

pre1 := if (fileservices.getsuperfilesubcount('~thor_Data400::base::did_ssn_glb_BUILDING') > 0,
		output('Nothing added to SSN_GLB Building superfile'),
		fileservices.addsuperfile('~thor_Data400::base::did_ssn_glb_BUILDING','~thor_Data400::base::did_ssn_glb',0,true));

ut.MAC_SK_BuildProcess(key_prep_did_ssn,'~thor_Data400::key::did_ssn_glb','~thor_Data400::key::did_ssn_glb',ssnglb,2)

post1 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::did_ssn_glb_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::did_ssn_glb_BUILT','~thor_Data400::base::did_ssn_glb_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::did_ssn_glb_BUILDING'));

pre2 := if (fileservices.getsuperfilesubcount('~thor_Data400::base::did_ssn_nonglb_BUILDING') > 0,
		output('Nothing added to SSN_NonGLB Building superfile'),
		fileservices.addsuperfile('~thor_Data400::base::did_ssn_Nonglb_BUILDING','~thor_Data400::base::did_ssn_Nonglb',0,true));

ut.MAC_SK_BuildProcess(key_prep_did_ssn_NonGlb,'~thor_Data400::key::did_ssn_nonglb','~thor_Data400::key::did_ssn_nonglb',ssnnonglb,2)

post2 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::did_ssn_nonglb_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::did_ssn_nonglb_BUILT','~thor_Data400::base::did_ssn_nonglb_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::did_ssn_nonglb_BUILDING'));

pre3 := if (fileservices.getsuperfilesubcount('~thor_Data400::base::did_ssn_nonUtil_BUILDING') > 0,
		output('Nothing added to SSN_NonUtil Building superfile'),
		fileservices.addsuperfile('~thor_Data400::base::did_ssn_nonUtil_BUILDING','~thor_Data400::base::did_ssn_nonUtil',0,true));

ut.MAC_SK_BuildProcess(key_prep_did_ssn_NonUtil,'~thor_Data400::key::did_ssn_NonUtil','~thor_Data400::key::did_ssn_NonUtil',ssnnonUtil,2)

post3 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::did_ssn_NonUtil_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::did_ssn_NonUtil_BUILT','~thor_Data400::base::did_ssn_nonUtil_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::did_ssn_NonUtil_BUILDING'));

pre4 := if (fileservices.getsuperfilesubcount('~thor_Data400::base::did_ssn_NonGlb_NonUtil_BUILDING') > 0,
		output('Nothing added to SSN_NonGLB_NonUtil Building superfile'),
		fileservices.addsuperfile('~thor_Data400::base::did_ssn_NonGlb_NonUtil_BUILDING','~thor_Data400::base::did_ssn_NonGlb_NonUtil',0,true));

ut.MAC_SK_BuildProcess(key_prep_did_ssn_NonGlb_NonUtil,'~thor_Data400::key::did_ssn_NonGlb_NonUtil','~thor_Data400::key::did_ssn_NonGlb_NonUtil',ssnnonglbnonUtil,2)

post4 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::did_ssn_NonGlb_NonUtil_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::did_ssn_NonGlb_NonUtil_BUILT','~thor_Data400::base::did_ssn_NonGlb_NonUtil_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::did_ssn_NonGlb_NonUtil_BUILDING'));

full1 := if (fileservices.getsuperfilesubname('~thor_Data400::base::did_ssn_glb_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::did_ssn_glb',1),
		output('SSN_GLB Base = BUILT. Nothing Done.'),
		sequential(pre1,ssnglb,post1));
		
full2 := if (fileservices.getsuperfilesubname('~thor_Data400::base::did_ssn_nonglb_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::did_ssn_nonglb',1),
		output('SSN_NonGLB Base = BUILT. Nothing Done.'),
		sequential(pre2,ssnnonglb,post2));

full3 := if (fileservices.getsuperfilesubname('~thor_Data400::base::did_ssn_nonUtil_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::did_ssn_nonUtil',1),
		output('SSN_NonUtil Base = BUILT. Nothing Done.'),
		sequential(pre3,ssnnonutil,post3));

full4 := if (fileservices.getsuperfilesubname('~thor_Data400::base::did_ssn_nonGLB_NonUtil_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::did_ssn_nonGlb_NonUtil',1),
		output('SSN_NonGLB_NonUtil Base = BUILT. Nothing Done.'),
		sequential(pre4,ssnnonglbnonutil,post4));

export did_ssn_keys := sequential(full1,full2,full3,full4);
