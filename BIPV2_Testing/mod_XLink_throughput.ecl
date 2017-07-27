import Tools,bipv2,Business_Header_SS,ut;
EXPORT mod_XLink_throughput := 
MODULE

/*
currently, set to use 50M records pulled with a choosen from the header file.  50M seemed like a number where things start to get stressed a little but the build doesnt take forever.  middle ground.
if the infile disappears, its easy enough to build a new one (code commented out below)
*/
strCount := 'fiftymillion';

h := if(Tools._Constants.IsDataland, bipv2.CommonBase.ds_prod, bipv2.CommonBase.DS_CLEAN);
c := dataset(ut.foreign_dataland + 'thor_data400::bipv2.xlink_latency_test_infile_'+strCount, recordof(h), thor);


// tenmillion := 10000000; //W20140107-113214-5
// c := distribute(choosen(h, tenmillion), rcid);
// output(c,,'~thor_data400::bipv2.xlink_latency_test_infile_tenmillion',overwrite);

// twentymillion := 20000000; //W20140109-182027
// c := distribute(choosen(h, twentymillion), rcid);
// output(c,,'~thor_data400::bipv2.xlink_latency_test_infile_twentymillion',overwrite);

// fiftymillion := 50000000; //W20140109-182228
// c := distribute(choosen(h, fiftymillion), rcid);
// output(c,,'~thor_data400::bipv2.xlink_latency_test_infile_fiftymillion',overwrite);

// hundredmillion := 100000000;//W20140109-182308
// c := distribute(choosen(h, hundredmillion), rcid);
// output(c,,'~thor_data400::bipv2.xlink_latency_test_infile_hundredmillion',overwrite);



rec := recordof(c);
outrec := record(rec)
	bipv2.IDlayouts.l_xlink_ids;
end;


Matchset := ['A','F','P'];

Business_Header_SS.MAC_Match_Flex
(
	 c
	,matchset
	,company_name
	,prim_range
	,prim_name
	,zip
	,sec_range
	,st
	,company_phone
	,company_fein
	,company_bdid
	,outrec
	,FALSE
	,BDID_score_field
	,outfile
	,1												//keep_count							= '1'
	,75												//score_threshold				= '75'
	,												//pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,												//pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	// ,[BIPV2.IDconstants.xlink_version_BIP_dev]
	,[BIPV2.IDconstants.xlink_version_BIP]
	,company_url											//pURL										=	''
	,contact_email									
	,p_city_name						//pCity									= ''	
	,fname	
	,mname												//pContact_mname					= ''
	,lname			
	,contact_ssn												//,contact_ssn					  = ''
	,source										//,source					        = ''
	,source_record_id												//,source_record_id				= ''
)

export out :=
parallel(
	output(choosen(outfile, 500), named('throughput_Xlink_Sample_Outfile_'+strCount)),
	output(count(outfile), named('throughput_Xlink_Count_Outfile_'+strCount)),
	output(count(outfile(seleid > 0)), named('throughput_Xlink_Count_Outfile_With_Sele_'+strCount))
);

END;

