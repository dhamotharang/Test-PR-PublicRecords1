import ut,header_slimsort,doxie_build,roxiekeybuild,utilfile,personlinkingADL2V3;

export Proc_AcceptSK_toQA(string filedate, boolean pFastHeader=false) := function

roxiekeybuild.Mac_SK_Move('~thor_data400::key::did_hhid','Q',out1);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::hhid','Q',out2a);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::hhid_did','Q',out2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::zip_did','Q',out3);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::zip_did_full','Q',out4);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.ssn.did','Q',out5);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::ssn_map','Q',out6);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.phone','Q',out8);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.st.fname.lname','Q',out9);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.da','Q',out10);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.pname.prange.st.city.sec_range.lname','Q',out11);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.st.city.fname.lname','Q',out12);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.lname.fname','Q',out20);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.zip.lname.fname','Q',out21);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.pname.zip.name.range','Q',out27);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::header','Q',out13);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::header_lookups','Q',out14);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::lssi.determiner','Q',out14b)

roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::rid_did','Q',out25)
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::rid_did2','Q',out26)
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.did.ssn.date','Q',out28)
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.county','Q',out29)
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.fname_small','Q',out30)

roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::hdr_apt_bldgs','Q',out31)

roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header_ssn_address','Q',out32)
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::troy','Q',out33)
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::troy_vehicle','Q',out34)
roxiekeybuild.Mac_SK_Move('~thor_data400::key::address_research','Q',out37)
roxiekeybuild.Mac_SK_Move('~thor_Data400::key::header_nbr','Q',out38)
roxiekeybuild.Mac_SK_Move('~thor_Data400::key::header_nbr_uid','Q',out39)
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.lname.fname_alt','Q',out39b)
roxiekeybuild.Mac_SK_Move('~thor_data400::key::didtrack.rid','Q',out55)
roxiekeybuild.Mac_SK_Move('~thor_data400::key::didtrack.did','Q',out56)
Roxiekeybuild.MAC_SK_Move('~thor_data400::key::header::@version@::phonetic_lname','Q',out57);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.dts.pname.prange.st.city.sec_range.lname','Q',out58);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.dts.pname.zip.name.range','Q',out59);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.dts.fname_small','Q',out60);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.ssn4.did','Q',out61);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.ssn5.did','Q',out62);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::header_address','Q',out63);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.dob','Q',out64);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.parentlnames','Q',out65);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.zipprlname','Q',out67);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header::minors','Q',out68);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.dobname','Q',out69);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::hdr_city_name.st.percent_chance','Q',out70);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::addrrisk_geolink','Q',out71);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::max_dt_last_seen','Q',out72);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.ssn4_v2.did','Q',out73);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::aid::RawAID_to_ACECahe','Q',out74);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.dob_fname','Q',out75);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.dob_pfname','Q',out76);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.minors_hash','Q',out77);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header.piz_lname_fname','Q',out78);

roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.legacy_ssn', 'Q', out79);

roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.TUCH_dob', 'Q', out80);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::rid_did_split','Q',mq_rid_did_split);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::lab.did_rid','Q',mq_lab_did_rid);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header::address_rank','Q',mq_address_rank);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::relatives_v2','Q',mq_rel_title);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header::DMV_restricted','Q',mq_DMV_restricted);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::insuranceheader_xlink::did','Q',mq_ins_did);

out40 := doxie_build.proc_accept_header_wildkeys_toQA;

out15 := sequential(fileservices.clearsuperfile('~thor_data400::base::header_prod'),
fileservices.addsuperfile('~thor_data400::base::header_prod','~thor_data400::base::header',,true));

out16 := sequential(fileservices.clearsuperfile('~thor_data400::base::relatives_prod'),
fileservices.addsuperfile('~thor_data400::base::relatives_prod','~thor_data400::base::relatives',,true));

out17 := sequential(fileservices.clearsuperfile('~thor_data400::base::hhid_prod'),
fileservices.addsuperfile('~thor_data400::base::hhid_prod','~thor_data400::base::hhid',,true));

out18 := header_slimsort.proc_accept_sf_to_Prod; 
out19 := header_slimsort.Proc_AcceptSK_toQA;

roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::nbr_address','Q',out22,2);

gong_did := output(dataset([],header.Layout_Header),,'~thor_data400::temp::gong_history_redid',overwrite);
bank_did := output(dataset([],header.Layout_Header),,'~thor_data400::temp::bankruptcy_redid',overwrite);
lien_did := output(dataset([],header.Layout_Header),,'~thor_data400::temp::liens_redid',overwrite);

mv_nm_src := sequential(fileservices.clearsuperfile('~thor_data400::base::hss_name_source_prod'),
fileservices.addsuperfile('~thor_data400::base::hss_name_source_prod','~thor_data400::base::hss_name_source',,true));

//external sources
ut.mac_SF_Move('~thor_data400::base::tucs_did','P',mv_tucs2prod);
ut.mac_SF_Move('~thor_data400::base::transunion_did','P',mv_tult2prod);
ut.mac_SF_Move('~thor_data400::base::transunionCred_did','P',mv_transunionCred2prod);

//files used by other builds
ut.mac_SF_Move('~thor_data400::base::header_raw','P',mv_hr2prod,3);
ut.mac_SF_Move('~thor_data400::base::header_raw_syncd','P',mv_hrs2prod);
ut.mac_SF_Move('~thor_data400::base::file_header_building','P',mv_fhb2prod);
ut.mac_SF_Move('~thor_data400::base::gong_did','P',mv_gong2prod);

e_mail_success := fileservices.sendemail(
'roxiedeployment@seisint.com,' + Header.email_list.BocaDevelopers,
'Header Roxie Build Succeeded ' + filedate,
'keys:  1)   thor_data400::key::did_hhid_qa(thor_data400::key::header::HHID::'+filedate+'::did.ver),\n' + 
'       2)   thor_data400::key::hhid_did_qa(thor_data400::key::header::HHID::'+filedate+'::hhid.ver),\n' + 
'       3)   thor_data400::key::lssi.determiner_qa(thor_data400::key::lssi::'+filedate+'::determiner),\n' + 
'       4)   thor_data400::key::zip_did_qa(thor_data400::key::header::'+filedate+'::zip_did),\n' + 
'       5)   thor_data400::key::zip_did_full_qa(thor_data400::key::header::'+filedate+'::zip_did_full),\n' + 
'       6)   thor_data400::key::header.ssn.did_qa(thor_data400::key::header::'+filedate+'::ssn.did),\n' + 
'       7)   thor_data400::key::header.rid_qa(thor_data400::key::header::'+filedate+'::rid),\n' + 
'       8)   thor_data400::key::header.phone_qa(thor_data400::key::header::'+filedate+'::phone),\n' + 
'       9)   thor_data400::key::header.st.fname.lname_qa(thor_data400::key::header::'+filedate+'::st.fname.lname),\n' + 
'       10)   thor_data400::key::header.st.city.fname.lname_qa(thor_data400::key::header::'+filedate+'::st.city.fname.lname),\n' + 
'       11)   thor_data400::key::header.lname.fname_qa(thor_data400::key::header::'+filedate+'::lname.fname),\n' + 
'       12)   thor_data400::key::header.zip.lname.fname_qa(thor_data400::key::header::'+filedate+'::zip.lname.fname),\n' + 
'       13)   thor_data400::key::header.da_qa(thor_data400::key::header::'+filedate+'::da),\n' + 
'       14)   thor_data400::key::header.pname.prange.st.city.sec_range.lname_qa(thor_data400::key::header::'+filedate+'::pname.prange.st.city.sec_range.lname),\n' + 
'       15)   thor_data400::key::header.pname.zip.name.range_qa(thor_data400::key::header::'+filedate+'::pname.zip.name.range),\n' + 
'       16)   thor_data400::key::header_qa(thor_data400::key::header::'+filedate+'::data),\n' + 
'       17)   thor_data400::key::header_lookups_qa(thor_data400::key::header::'+filedate+'::lookups),\n' + 
'       18)   thor_data400::key::nbr_address_qa(thor_data400::key::header::'+filedate+'::nbr_address),\n' + 
'       19)   thor_data400::key::rid_did_qa(thor_data400::key::header::'+filedate+'::rid_did),\n' + 
'       20)   thor_data400::key::rid_did2_qa(thor_data400::key::header::'+filedate+'::rid_did2),\n' + 
'       21)   thor_data400::key::header.did.ssn.date_qa(thor_data400::key::header::'+filedate+'::did.ssn.date),\n' + 
'       22)   thor_data400::key::header.county_qa(thor_data400::key::header::'+filedate+'::county),\n' + 
'       23)   thor_data400::key::header.fname_small_qa(thor_data400::key::header::'+filedate+'::fname_small),\n' + 
'       24)   thor_data400::key::hdr_apt_bldgs_qa(thor_data400::key::header::'+filedate+'::apt_bldgs),\n' + 
'       25)   thor_data400::key::header_ssn_address_qa(thor_data400::key::header::'+filedate+'::ssn_address),\n' + 
'       26)   thor_data400::key::relatives_qa(thor_data400::key::header::'+filedate+'::relatives),\n' + 
'       27)   thor_data400::key::rel_names_qa(thor_data400::key::header::'+filedate+'::rel_names),\n' + 
'       28)   thor_data400::key::troy_qa(thor_data400::key::header::'+filedate+'::troy),\n' + 
'       29)   thor_data400::key::troy_vehicle_qa(thor_data400::key::header::'+filedate+'::troy_vehicle),\n' + 
'       30)   thor_data400::key::hhid_qa(thor_data400::key::header::'+filedate+'::hhid),\n' + 
'       31)   thor_data400::key::probationary_dids_qa(thor_data400::key::header::'+filedate+'::probationary_dids),\n' + 
'       32)   thor_data400::key::file_name_addr_qa(thor_data400::key::header_slimsort::'+filedate+'::name_addr),\n' + 
'       33)   thor_data400::key::file_name_address_st_qa(thor_data400::key::header_slimsort::'+filedate+'::name_address_st),\n' + 
'       34)   thor_data400::key::file_name_addr_NN_qa(thor_data400::key::header_slimsort::'+filedate+'::name_addr_NN),\n' + 
'       35)   thor_data400::key::file_name_zip_qa(thor_Data400::key::header_slimsort::'+filedate+'::name_zip),\n' + 
'       36)   thor_data400::key::file_name_phone_qa(thor_data400::key::header_slimsort::'+filedate+'::name_phone),\n' + 
'       37)   thor_data400::key::file_name_ssn_qa(thor_data400::key::header_slimsort::'+filedate+'::name_ssn),\n' + 
'       38)   thor_data400::key::file_name_dayob_qa(thor_data400::key::header_slimsort::'+filedate+'::name_dayob),\n' + 
'       39)   thor_data400::key::file_name_dob_qa(thor_data400::key::header_slimsort::'+filedate+'::name_dob),\n' + 
'       40)   thor_data400::key::key_nazs4_age_qa(thor_data400::key::header_slimsort::'+filedate+'::nazs4_age),\n' + 
'       41)   thor_data400::key::key_nazs4_ssn4_qa(thor_data400::key::header_slimsort::'+filedate+'::nazs4_ssn4),\n' + 
'       42)   thor_data400::key::key_nazs4_zip_qa(thor_data400::key::header_slimsort::'+filedate+'::nazs4_zip),\n' + 
'       43)   thor_data400::key::address_research_qa(thor_data400::key::header::'+filedate+'::address_research),\n' + 
'       44)   thor_data400::key::header_nbr_qa(thor_data400::key::header::'+filedate+'::header_nbr),\n' + 
'       45)   thor_data400::key::header_nbr_uid_qa(thor_data400::key::header::'+filedate+'::header_nbr_uid),\n' + 
'       46)   thor_data400::key::header.wild.ssn.did_qa(thor_data400::key::header_wild::'+filedate + '::ssn.did),\n' + 
'       47)   thor_data400::key::header.wild.st.fname.lname_qa(thor_data400::key::header_wild::'+filedate + '::st.fname.lname),\n' + 
'       48)   thor_data400::key::header.wild.pname.zip.name.range_qa(thor_data400::key::header_wild::'+filedate + '::pname.zip.name.range),\n' + 
'       49)   thor_data400::key::header.wild.lname.fname_qa(thor_data400::key::header_wild::'+filedate + '::lname.fname),\n' + 
'       50)   thor_data400::key::header.wild.phone_qa(thor_data400::key::header_wild::'+filedate + '::phone),\n' + 
'       51)   thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname_qa(thor_data400::key::header_wild::'+filedate + '::pname.prange.st.city.sec_range.lname),\n' + 
'       52)   thor_data400::key::header.wild.zip.lname.fname_qa(thor_data400::key::header_wild::'+filedate + '::zip.lname.fname),\n' + 
'       53)   thor_data400::key::header.wild.fname_small_qa(thor_data400::key::header_wild::'+filedate + '::fname_small),\n' + 
'       54)   thor_data400::key::header.wild.st.city.fname.lname_qa(thor_data400::key::header_wild::'+filedate + '::st.city.fname.lname),\n' + 
'       55)   thor_data400::key::didtrack.rid_qa(thor_data400::key::didtrack::'+filedate + '::rid),\n' + 
'       56)   thor_data400::key::didtrack.did_qa(thor_data400::key::didtrack::'+filedate + '::did),\n' + 
'       57)   thor_data400::key::header::qa::phonetic_lname(thor_data400::key::header::'+filedate + '::phonetic_lname),\n' + 
'       58)   thor_data400::key::header.dts.pname.prange.st.city.sec_range.lname_qa(thor_data400::key::header::dts::'+filedate+'::pname.prange.st.city.sec_range.lname),\n' + 
'       59)   thor_data400::key::header.dts.pname.zip.name.range_qa(thor_data400::key::header::dts::'+filedate+'::pname.zip.name.range),\n' + 
'       60)   thor_data400::key::header.dts.fname_small_qa(thor_data400::key::header::dts::'+filedate+'::fname_small),\n' + 
'       61)   thor_data400::key::header.ssn4.did_qa(thor_data400::key::header::'+filedate+'::ssn4.did),\n' + 
'       62)   thor_data400::key::header.ssn5.did_qa(thor_data400::key::header::'+filedate+'::ssn5.did),\n' + 
'       63)   thor_data400::key::header::ssn4_zip_yob_fi_qa(thor_data400::key::header::'+filedate+'::ssn4_zip_yob_fi),\n' + 
'       64)   thor_data400::key::header_address_qa(thor_data400::key::header::'+filedate+'::address),\n' + 
'       65)   thor_data400::key::header.dob_qa(thor_data400::key::header::'+filedate+'::dob),\n' + 
'       66)   thor_data400::key::header.parentlnames(thor_data400::key::header::'+filedate+'::parentlnames),\n' + 
'       68)   thor_data400::key::header.zipprlname(thor_data400::key::header::'+filedate+'::zipprlname),\n' +
'       69)   thor_data400::key::header::minors(thor_data400::key::header::'+filedate+'::minors),\n' + 
'       70)   thor_data400::key::hdr_city_name.st.percent_chance(thor_data400::key::header::'+filedate+'::city_name.st.percent_chance),\n' + 
'       71)   thor_data400::key::addrrisk_geolink(thor_data400::key::header::'+filedate+'::addrrisk_geolink),\n' + 
'       72)   thor_data400::key::addrrisk_geolink(thor_data400::key::header::'+filedate+'::max_dt_last_seen),\n' + 
'       73)   thor_data400::key::header.ssn4_v2.did(thor_data400::key::header::'+filedate+'::ssn4_v2.did),\n' +
'       74)   thor_data400::key::aid::RawAID_to_ACECahe(thor_data400::key::aid::'+filedate+'::RawAID_to_ACECahe),\n' +
'       75)   thor_data400::key::relatives_v2_qa(thor_data400::key::header::'+filedate+'::relatives_v2),\n' +
'      have been built and ready to be deployed to QA.');
							


all_keys := sequential(
											out1
											,out2a
											,out2
											,out3
											,out4
											,out5
											,out6
											,out8
											,out9
											,out10
											,out11
											,out12
											,out13
											,out14
											,out14b
											,out15
											,out16
											,out17
											,out18
											,out19
											,out20
											,out21
											,out22
											,out25
											,out26
											,out27
											,out28
											,out29
											,out30
											,out31
											,out32
											,out33
											,out34
											,out37
											,out38
											,out39
											,out39b
											,out40
											,out55
											,out56
											,out57
											,out58
											,out59
											,out60
											,out61
											,out62
											,out63
											,out64
											,out65
											,out67
											,out68
											,out69
											,out70
											,out71
											,out72
											,out73
											,out74
											,out75
											,out76
											,out77
											,out78
											,out79
											,out80
											,mq_rid_did_split
											,mq_lab_did_rid
											,mq_address_rank
											,mq_rel_title
											,mq_DMV_restricted
											,mq_ins_did
											,gong_did
											,bank_did
											,lien_did
											,mv_tucs2prod
											,mv_tult2prod
											,mv_hr2prod
											,mv_hrs2prod
											,mv_fhb2prod
											,mv_gong2prod
											,mv_transunionCred2prod
											,e_mail_success
											);

return all_keys;

end;