import ut;

export rename_personheaderkeys(string new_date) :=
function

all_personheaderkeys := DATASET([
{'~thor_data400::key::did_hhid_qa',                                                  '~thor_data400::key::header::hhid::'+new_date+'::did.ver'},
{'~thor_data400::key::hhid_did_qa',                                                  '~thor_data400::key::header::hhid::'+new_date+'::hhid.ver'}, 
{'~thor_data400::key::lssi.determiner_qa',                                           '~thor_data400::key::lssi::'+new_date+'::determiner'}, 
{'~thor_data400::key::zip_did_qa',                                                   '~thor_data400::key::header::'+new_date+'::zip_did'}, 
{'~thor_data400::key::zip_did_full_qa',                                              '~thor_data400::key::header::'+new_date+'::zip_did_full'}, 
{'~thor_data400::key::header.ssn.did_qa',                                            '~thor_data400::key::header::'+new_date+'::ssn.did'}, 
{'~thor_data400::key::header.rid_qa',                                                '~thor_data400::key::header::'+new_date+'::rid'}, 
{'~thor_data400::key::header.phone_qa',                                              '~thor_data400::key::header::'+new_date+'::phone'}, 
{'~thor_data400::key::header.st.fname.lname_qa',                                     '~thor_data400::key::header::'+new_date+'::st.fname.lname'}, 
{'~thor_data400::key::header.st.city.fname.lname_qa',                                '~thor_data400::key::header::'+new_date+'::st.city.fname.lname'}, 
{'~thor_data400::key::header.lname.fname_qa',                                        '~thor_data400::key::header::'+new_date+'::lname.fname'}, 
{'~thor_data400::key::header.zip.lname.fname_qa',                                    '~thor_data400::key::header::'+new_date+'::zip.lname.fname'}, 
{'~thor_data400::key::header.da_qa',                                                 '~thor_data400::key::header::'+new_date+'::da'}, 
{'~thor_data400::key::header.pname.prange.st.city.sec_range.lname_qa',               '~thor_data400::key::header::'+new_date+'::pname.prange.st.city.sec_range.lname'}, 
{'~thor_data400::key::header.pname.zip.name.range_qa',                               '~thor_data400::key::header::'+new_date+'::pname.zip.name.range'}, 
{'~thor_data400::key::header_qa',                                                    '~thor_data400::key::header::'+new_date+'::data'}, 
{'~thor_data400::key::header_lookups_qa',                                            '~thor_data400::key::header::'+new_date+'::lookups'}, 
{'~thor_data400::key::nbr_address_qa',                                               '~thor_data400::key::header::'+new_date+'::nbr_address'}, 
{'~thor_data400::key::rid_did_qa',                                                   '~thor_data400::key::header::'+new_date+'::rid_did'}, 
{'~thor_data400::key::rid_did2_qa',                                                  '~thor_data400::key::header::'+new_date+'::rid_did2'}, 
{'~thor_data400::key::header.did.ssn.date_qa',                                       '~thor_data400::key::header::'+new_date+'::did.ssn.date'}, 
{'~thor_data400::key::header.county_qa',                                             '~thor_data400::key::header::'+new_date+'::county'}, 
{'~thor_data400::key::header.fname_small_qa',                                        '~thor_data400::key::header::'+new_date+'::fname_small'}, 
{'~thor_data400::key::hdr_apt_bldgs_qa',                                             '~thor_data400::key::header::'+new_date+'::apt_bldgs'}, 
{'~thor_data400::key::header_ssn_address_qa',                                        '~thor_data400::key::header::'+new_date+'::ssn_address'}, 
{'~thor_data400::key::relatives_qa',                                                 '~thor_data400::key::header::'+new_date+'::relatives'}, 
{'~thor_data400::key::troy_qa',                                                      '~thor_data400::key::header::'+new_date+'::troy'}, 
{'~thor_data400::key::address_research_qa',                                          '~thor_data400::key::header::'+new_date+'::address_research'}, 
{'~thor_data400::key::header_nbr_qa',                                                '~thor_data400::key::header::'+new_date+'::nbr'}, 
{'~thor_data400::key::header_nbr_uid_qa',                                            '~thor_data400::key::header::'+new_date+'::nbr_uid'}, 
{'~thor_data400::key::header.lname.fname_alt_qa',                                    '~thor_data400::key::header::'+new_date+'::lname.fname_alt'}, 
{'~thor_data400::key::header.wild.ssn.did_qa',                                       '~thor_data400::key::header_wild::'+new_date+'::ssn.did'}, 
{'~thor_data400::key::header.wild.st.fname.lname_qa',                                '~thor_data400::key::header_wild::'+new_date+'::st.fname.lname'}, 
{'~thor_data400::key::header.wild.pname.zip.name.range_qa',                          '~thor_data400::key::header_wild::'+new_date+'::pname.zip.name.range'}, 
{'~thor_data400::key::header.wild.lname.fname_qa',                                   '~thor_data400::key::header_wild::'+new_date+'::lname.fname'}, 
{'~thor_data400::key::header.wild.phone_qa',                                         '~thor_data400::key::header_wild::'+new_date+'::phone'}, 
{'~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname_qa',          '~thor_data400::key::header_wild::'+new_date+'::pname.prange.st.city.sec_range.lname'}, 
{'~thor_data400::key::header.wild.zip.lname.fname_qa',                               '~thor_data400::key::header_wild::'+new_date+'::zip.lname.fname'}, 
{'~thor_data400::key::header.wild.fname_small_qa',                                   '~thor_data400::key::header_wild::'+new_date+'::fname_small'}, 
{'~thor_data400::key::header.wild.st.city.fname.lname_qa',                           '~thor_data400::key::header_wild::'+new_date+'::st.city.fname.lname'}, 
{'~thor_data400::key::header.wild.ssn.did.en_qa',                                    '~thor_data400::key::header_wild::'+new_date+'::ssn.did.en'}, 
{'~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname.en_qa',       '~thor_data400::key::header_wild::'+new_date+'::pname.prange.st.city.sec_range.lname.en'}, 
{'~thor_data400::key::header.wild.lname.fname.st.city.z5.pname.prange.sec_range_qa', '~thor_data400::key::header_wild::'+new_date+'::lname.fname.st.city.z5.pname.prange.sec_range'}, 
{'~thor_data400::key::header::qa::phonetic_lname',                                   '~thor_data400::key::header::'+new_date+'::phonetic_lname'}, 
{'~thor_data400::key::header.dts.fname_small_qa',                                    '~thor_data400::key::header::dts::'+new_date+'::fname_small'}, 
{'~thor_data400::key::header.dts.pname.prange.st.city.sec_range.lname_qa',           '~thor_data400::key::header::dts::'+new_date+'::pname.prange.st.city.sec_range.lname'}, 
{'~thor_data400::key::header.dts.pname.zip.name.range_qa',                           '~thor_data400::key::header::dts::'+new_date+'::pname.zip.name.range'}, 
{'~thor_data400::key::header.ssn4.did_qa',                                           '~thor_data400::key::header::'+new_date+'::ssn4.did'}, 
{'~thor_data400::key::header.ssn5.did_qa',                                           '~thor_data400::key::header::'+new_date+'::ssn5.did'}, 
{'~thor_data400::key::header.parentlnames_qa',                                       '~thor_data400::key::header::'+new_date+'::parentlnames'},
{'~thor_data400::key::header.dob_qa',                                                '~thor_data400::key::header::'+new_date+'::dob'},
{'~thor_data400::key::header_with_tu_qa',                                            '~thor_data400::key::header::'+new_date+'::data_with_tu'},
{'~thor_data400::key::header_address_qa',                                            '~thor_data400::key::header::'+new_date+'::address'},
{'~thor_data400::key::header.did.ssn.date_qa',                                       '~thor_data400::key::header::'+new_date+'::did.ssn.date'},
{'~thor_data400::key::header.zipprlname_qa',                                         '~thor_data400::key::header::'+new_date+'::zipprlname'},
{'~thor_data400::key::address::qa::address_type',                                    '~thor_data400::key::address::'+new_date+'::address_type'},
{'~thor_data400::key::header::minors_qa',                                            '~thor_data400::key::header::'+new_date+'::minors'}
], ut.Layout_Superkeynames.inputlayout);

return_this := ut.fLogicalKeyRenaming(all_personheaderkeys, false);

return return_this;

end;