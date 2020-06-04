import Business_Header_SS,Business_Header,ut,BIPV2_Files,BizLinkFull;

EXPORT mod_XLink := 
MODULE

export rec := BIPV2_Testing.layouts.xlink;
shared size_sample := 5000;

export HeaderRec := 
recordof(BIPV2_Files.files_proxid().DS_PROXID_BASE);
//RECORD  unsigned6 rcid;  unsigned6 dotid;  unsigned6 empid;  unsigned6 powid;  unsigned6 proxid;  unsigned6 orgid;  unsigned6 ultid;  string1 iscontact;  string5 contact_title;  string20 contact_fname;  string20 contact_mname;  string20 contact_lname;  string5 contact_name_suffix;  string1 iscorp;  string120 company_name;  string30 company_name_type;  string1 cnp_hasnumber;  string250 cnp_name;  string10 cnp_number;  string10 cnp_btype;  string20 cnp_lowv;  boolean cnp_translated;  integer4 cnp_classid;  unsigned8 company_rawaid;  unsigned8 company_aceaid;  qstring10 company_prim_range;  string2 company_predir;  qstring28 company_prim_name;  qstring4 company_addr_suffix;  string2 company_postdir;  qstring10 company_unit_desig;  qstring8 company_sec_range;  qstring25 company_p_city_name;  qstring25 company_v_city_name;  string2 company_st;  qstring5 company_zip5;  qstring4 company_zip4;  string2 source;  string34 source_group;  unsigned4 dt_first_seen;  unsigned4 dt_last_seen;  unsigned4 dt_vendor_first_reported;  unsigned4 dt_vendor_last_reported;  unsigned6 company_bdid;  string1 company_address_type;  string1 company_address_category;  string9 company_fein;  string10 company_phone;  string50 company_org_structure;  string1 company_derived_classification;  unsigned4 company_incorporation_date;  string8 company_sic_code;  string6 company_naics_code;  string1 company_foreign_domestic;  string80 company_url;  string2 company_charter_state;  string32 company_charter_number;  string1 company_name_status;  unsigned4 dt_first_seen_company_name;  unsigned4 dt_last_seen_company_name;  unsigned4 dt_first_seen_company_address;  unsigned4 dt_last_seen_company_address;  string34 vendor_id;  string34 vl_id;  boolean current;  unsigned8 source_record_id;  string34 pflag;  boolean glb;  boolean dppa;  unsigned6 group1_id;  unsigned2 phone_score;  string81 match_company_name;  string20 match_branch_city;  string25 match_geo_city;  unsigned4 dt_first_seen_contact;  unsigned4 dt_last_seen_contact;  unsigned6 contact_did;  string1 contact_type;  string35 contact_job_title;  string9 contact_ssn;  unsigned4 contact_dob;  string60 contact_email;  string30 contact_email_username;  string30 contact_email_domain;  string10 contact_phone;  unsigned8 cid;  unsigned1 contact_score;  string1 from_hdr;  string35 company_department; END;

export addIDs(
	dataset(rec) ds
	,dataset(HeaderRec) hfile
	,boolean UseBDIDPersist
	,boolean UseBIPPersist
	,string version = ''
	) := 
FUNCTION

Matchset := ['A','F','P'];

Business_Header_SS.MAC_Match_Flex
(
	 ds
	,matchset
	,company_name
	,company_prim_range
	,company_prim_name
	,company_zip
	,company_sec_range
	,company_state
	,company_phone
	,company_fein
	,bdid
	,rec
	,FALSE
	,BDID_score_field
	,outfile_v1_0							
)

outfile_v1_p := outfile_v1_0 : persist('~thor_data400::cemtemp::outfile_v1');

outfile_v1 := 
if(
	UseBDIDPersist,
	dataset('~thor_data400::cemtemp::outfile_v1', recordof(outfile_v1_0), thor),
	outfile_v1_p
);

// ******* END BDID


// ******* START BIP
Business_Header_SS.MAC_Match_Flex
(
	 ds
	,matchset
	,company_name
	,company_prim_range
	,company_prim_name
	,company_zip
	,company_sec_range
	,company_state
	,company_phone
	,company_fein
	,bdid
	,rec
	,FALSE
	,BDID_score_field
	,outfile_v2_0
	,10												//keep_count							= '1'
	,0												//score_threshold				= '75'
	,												//pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,												//pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	// ,[BIPV2.IDconstants.xlink_version_BIP_dev]
	,[BIPV2.IDconstants.xlink_version_BIP]
	,												//pURL										=	''
	email_address,									
	,company_city						//pCity									= ''	
	,fname	
	,												//pContact_mname					= ''
	,lname			
	,												//,contact_ssn					  = ''
	,src/*change to sub_source when available!*/												//,source					        = ''
	// ,src_rcid												//,source_record_id				= ''
)

outfile_v2_p := outfile_v2_0 ;//: persist('~thor_data400::cemtemp::outfile_v2');

outfile_v2_many := 
if(
	UseBIPPersist,
	dataset('~thor_data400::cemtemp::outfile_v2', recordof(outfile_v2_0), thor),
	outfile_v2_p
);

outfile_v2 := dedup(sort(outfile_v2_many, rid, -proxscore, proxid), rid);

// ** WORK FOR OUTPUTS

//just bdid
wbdid_input := outfile_v1(bdid_input > 0);
wbdid := outfile_v1(bdid > 0);
rbdidsrc := record
	wbdid.src;
	cnt := count(group);
	pct := (integer)(100 * count(group) / size_sample);
end;
tbdidsrc := table(wbdid, rbdidsrc, src, few);

//just bip
wbip := outfile_v2(proxid > 0);
rbipsrc := record
	wbip.src;
	cnt := count(group);
	pct := ((integer)(10000 * count(group) / size_sample))/100;
end;
tbipsrc0 := table(wbip, rbipsrc, src, few);
tbipsrc25 := table(wbip(proxid > 0, proxscore >= 25), rbipsrc, src, few);
tbipsrc50 := table(wbip(proxid > 0, proxscore >=  50), rbipsrc, src, few);
tbipsrc75 := table(wbip(proxid > 0, proxscore >=  75), rbipsrc, src, few);

//both
OutputLost(dataset(recordof(wbdid)) pwbdid, dataset(recordof(wbip)) pwbip, unsigned3 thresh) :=
FUNCTION

	s := '_threshold_' + (string)thresh;
	
	lost :=
	join(
		pwbdid,
		pwbip,
		left.rid = right.rid and right.proxscore < thresh,
		transform(right)
	)
	+ join(
		pwbdid,
		pwbip,
		left.rid = right.rid,
		left only
	);

	lostInHeader :=
	join(
		lost,
		hfile,
		left.bdid = right.company_bdid,
		transform(left),
		keep(1)
	);

	rlihsrc := record
		lostInHeader.src;
		cnt := count(group);
		pct := (integer)(100 * count(group) / size_sample);
	end;
	tlihsrc := table(lostInHeader, rlihsrc, src, few);

	lihsmp := 
	join(
		tlihsrc,
		sort(lostInHeader, random()), 
		left.src = right.src,
		transform(right),
		keep(20)
	);

	lostNotInHeader :=
	join(
		lost,
		hfile,
		left.bdid = right.company_bdid,
		transform(left),
		left only
	);
	
	rlnhsrc := record
		lostNotInHeader.src;
		cnt := count(group);
		pct := (integer)(100 * count(group) / size_sample);
	end;
	tlnhsrc := table(lostNotInHeader, rlnhsrc, src, few);

	lnhsmp := 
	join(
		tlnhsrc,
		sort(lostNotInHeader, random()), 
		left.src = right.src,
		transform(right),
		keep(20)
	);

	return 
	sequential(
		output(enth(lost, 100), named('lost' + s))
		,output(count(lost), named('cnt_lost' + s))
		,output(enth(lostInHeader, 100), named('lostInHeader' + s))
		,output(tlihsrc, named('lostInHeader_by_src_' + s))
		,output(count(lostInHeader), named('cnt_lostInHeader' + s))
		,output(lihsmp, named('sample_lostInHeader' + s))
		,output(enth(lostNotInHeader, 100), named('lostNotInHeader' + s))
		,output(tlnhsrc, named('lostNotInHeader_by_src_' + s))		
		,output(count(lostNotInHeader), named('cnt_lostNotInHeader' + s))
		,output(enth(lnhsmp, 100), named('sample_lostNotInHeader' + s))		
		,output(outfile_v2(proxscore >= thresh),,'~thor_data_400::bipv2external.gte' + (string)thresh,overwrite)
		,output(outfile_v2(proxscore < thresh),,'~thor_data_400::bipv2external.le' + (string)thresh,overwrite)
		
	);
end;

// ** SUPPORT FOR PRECISION REVIEW SAMPLES
import tools;

f(integer i, string s) :=
function

samps := 5;
sampsize := 20;
total := samps * sampsize;
e := enth(outfile_v2(proxid >0), total);

dsq := e[i*sampsize+1..(i+1)*sampsize];
k := bizlinkfull.Process_Biz_Layouts.key;
myk := k(proxid in set(dsq, proxid));

cr := 
{e.rid, e.src, myk.proxid, e.ProxScore, e.ProxWeight, string25 note; myk.company_name, myk.prim_range, myk.prim_name, myk.sec_range, myk.zip, myk.p_city_name, 
	myk.st, myk.company_phone, myk.company_fein, myk.fname, myk.lname, myk.contact_email
};
str_ext_note := '--- external input ---';
mykslim := 
project(
	myk,
	transform(
		cr,
		self := left,
		self.note := 'matching header data',
		self := []
	)
)+
project(
	dsq,
	transform(
		cr,
		self.proxid := left.proxid - 1, //this for sorting only and corrected before output
		self.note := str_ext_note,
		self.prim_range := left.company_prim_range,
		self.prim_name := left.company_prim_name,	
		self.zip := left.company_zip,
		self.sec_range := left.company_sec_range,
		self.p_city_name := left.company_city,
		self.st := left.company_state,
		self.contact_email := left.email_Address,
		self := left

	)
);	
krolled := tools.mac_AggregateFieldsPerID(mykslim, proxid,,,,TRUE);

return output(sort(project(krolled, transform({krolled}, self.proxid := if(left.notes[1].note = str_ext_note, left.proxid + 1, left.proxid), self := left)), proxid, notes[1].note)
, named(s+'_precision_reviews'));

end;

// ** END SUPPORT FOR PRECISION REVIEW SAMPLES


// ** ACTUAL OUTPUTS

//just bdid
// output(count(wbdid_input), named('cnt_wbdid_input'));
// output(count(wbdid), named('cnt_wbdid'));
// output(enth(wbdid, 20), named('sample_wbdid'));
// output(tbdidsrc, named('bdids_by_src'));

//just bip
output(count(wbip), named('cnt_wbip'));
output(enth(wbip, 20), named('sample_wbip'));
output(tbipsrc0, named('bips_by_src_thresh_0'));
output(tbipsrc25, named('bips_by_src_thresh_25'));
output(tbipsrc50, named('bips_by_src_thresh_50'));
output(tbipsrc75, named('bips_by_src_thresh_75'));

output(outfile_v2(proxscore < ultscore), named('IDParentsLift'));
output(outfile_v2_many,,'~thor_data_400::bipv2external.'+version+workunit);

//output precision reviews - OFF by default just because they are slow
// f(0, 'CM');
// f(1, 'TL');
// f(2, 'LB');
// f(3, 'DW');
// f(4, 'SS');


// ** END PRECISION REVIEW SAMPLES

//both
// outputLost(wbdid, wbip, 0);
// outputLost(wbdid, wbip, 25);
// outputLost(wbdid, wbip, 50);
// outputLost(wbdid, wbip, 75);
return 0;
end;//FUNCTION ************************************


END;