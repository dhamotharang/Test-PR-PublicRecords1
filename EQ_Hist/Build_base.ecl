import header, address, ut, doxie, AID, idl_header;

DoBuild := distribute(Preprocess,hash(did));

pre1 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::equifax_history_BUILDING')>0,
    output('Nothing added to Base::equifax_history_BUILDING'),
    sequential(fileservices.addsuperfile('~thor_data400::Base::equifax_history_BUILDING','~thor_data400::in::quickhdr_raw_history_rf',,true)));

ut.MAC_SF_BuildProcess(DoBuild,'~thor_data400::BASE::equifax_history',bld,2,,true)

post1 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::equifax_history_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::equifax_history_BUILT','~thor_Data400::base::equifax_history_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::equifax_history_BUILDING'));

full1 := if (fileservices.getsuperfilesubname('~thor_Data400::base::equifax_history_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::in::quickhdr_raw_history_rf',1)
		,output('EQ History Base file = BUILT. Nothing Done.')
		,sequential(pre1, bld ,post1));

export build_base := full1;

