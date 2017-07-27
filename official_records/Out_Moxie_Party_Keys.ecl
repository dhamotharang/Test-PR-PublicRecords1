import Official_Records, lib_keylib, lib_stringlib, lib_metaphone;

lBaseKeyName 	:= 'key::moxie.official_records_party.';

rMoxieFileForKeybuildLayout
 :=
  record
    Official_Records.Layout_Moxie_Party;
    unsigned integer8 __filepos{virtual(fileposition)};
  end;

dMoxieFileForKeybuild := dataset(Official_Records.Name_Moxie_Party_Dev,rMoxieFileForKeybuildLayout,flat);

rKeyFieldsNormalizedLayout
 :=
  record
	dMoxieFileForKeybuild.vendor;
	dMoxieFileForKeybuild.state_origin;
	dMoxieFileForKeybuild.county_name;
	dMoxieFileForKeybuild.official_record_key;
	dMoxieFileForKeybuild.doc_instrument_or_clerk_filing_num;
	dMoxieFileForKeybuild.doc_filed_dt;
	dMoxieFileForKeybuild.process_date;
	dMoxieFileForKeybuild.entity_sequence;
	dMoxieFileForKeybuild.master_party_type_cd;
	typeof(dMoxieFileForKeybuild.county_name) new_county_name;
	string20				fname;
	string20				mname;
	string20				lname;
	string70				cname;
	string60				lfmname;
	string70				nameasis;
	string8					doc_filed_ccyymm;
	string8					process_date_qa;
	big_endian unsigned8	filepos;
  end
 ;

rKeyFieldsNormalizedLayout tNormalizeNames(rMoxieFileForKeybuildLayout pInput, integer pCounter)
 :=
  transform
	self.fname				:= choose(((pCounter - 1) % 5) + 1,pInput.fname1,pInput.fname2,pInput.fname3,pInput.fname4,pInput.fname5);
	self.mname				:= choose(((pCounter - 1) % 5) + 1,pInput.mname1,pInput.mname2,pInput.mname3,pInput.mname4,pInput.mname5);
	self.lname				:= choose(((pCounter - 1) % 5) + 1,pInput.lname1,pInput.lname2,pInput.lname3,pInput.lname4,pInput.lname5);
	self.cname				:= choose(((pCounter - 1) % 5) + 1,pInput.cname1,pInput.cname2,pInput.cname3,pInput.cname4,pInput.cname5);
	self.lfmname			:= trim(self.lname) + ' '
							+  if(trim(self.fname)='',			// NOTE:  Other LFMName is done differently!!!  /tmk/
									   '',
									   trim(self.fname)+' '
								 )
							+  self.mname;
	self.nameasis 			:= lib_keylib.keylib.compnamenosyn(self.cname);
	self.doc_filed_ccyymm 	:= pInput.Doc_Filed_Dt;
	self.process_date_qa	:= pInput.process_date;
	self.new_county_name	:= if(pCounter <= 5,
								  pInput.county_name,
								  lib_stringlib.StringLib.stringfilterout(pInput.county_name,',.-')
								 );
	self.filepos			:= (big_endian unsigned8)pInput.__filepos;
	self 					:= pInput;
  end
 ;

dKeyFieldsNormalized 		:= normalize(dMoxieFileForKeybuild,5,tNormalizeNames(left,counter));
dKeyFieldsNormalizedDist	:= distribute(dKeyFieldsNormalized,hash(filepos));

dKeySeqDeduped				:= dedup(dKeyFieldsNormalizedDist(official_record_key<>''),
									 official_record_key,entity_sequence,filepos,local
									);
kKeySeq						:= buildindex(dKeySeqDeduped,
											{official_record_key,
											 entity_sequence,
											 filepos
										    },
											lBaseKeyName + 'official_record_key.sequence_number.key',moxie,overwrite
										   );

dKeyMasterTypeSeqDeduped	:= dedup(dKeyFieldsNormalizedDist(official_record_key<>''),
									 official_record_key,master_party_type_cd,entity_sequence,filepos,local
									);
kKeyMasterTypeSeq			:= buildindex(dKeyMasterTypeSeqDeduped,
											{official_record_key,
											 master_party_type_cd,
											 entity_sequence,
											 filepos
											},	
											lBaseKeyName + 'official_record_key.master_party_type_cd.sequence_number.key',moxie,overwrite
										   );
										 

//replace county_name with new_county_name

dStCountyLFMNameDeduped		:= dedup(dKeyFieldsNormalizedDist(lname<>''),
									 state_origin,new_county_name,lfmname,filepos,local
									);
kStCountyLFMName			:= buildindex(dStCountyLFMNameDeduped,
											{state_origin,
											 new_county_name,
											 lfmname,
											 filepos
											},	
											lBaseKeyName + 'st.county.lfmname.key',moxie,overwrite
										   );

dStLFMNameDeduped			:= dedup(dStCountyLFMNameDeduped,			// NOTE:  This dedups dataset just above instead of full normalized version
									 state_origin,lfmname,filepos,local
									);
kStLFMName					:= buildindex(dStLFMNameDeduped,
											{state_origin,
											 lfmname,
											 filepos
											},	
											lBaseKeyName + 'st.lfmname.key',moxie,overwrite
										   );

dLFMNameDeduped				:= dedup(dStLFMNameDeduped,					// NOTE:  This dedups dataset just above instead of full normalized version
									 lfmname,filepos,local
									);
kLFMName					:= buildindex(dLFMNameDeduped,
											{lfmname,
											 filepos
											},	
											lBaseKeyName + 'lfmname.key',moxie,overwrite
										   );

// Replace county_name with new_county_name

dStCountyNameasisDeduped	:= dedup(dKeyFieldsNormalizedDist(nameasis<>''),
									 state_origin,new_county_name,nameasis,filepos,local
									);
kStCountyNameasis			:= buildindex(dStCountyNameasisDeduped,
											{state_origin,
											 new_county_name,
											 nameasis,
											 filepos
											},	
											lBaseKeyName + 'st.county.nameasis.key',moxie,overwrite
										   );

dStNameasisDeduped			:= dedup(dStCountyNameasisDeduped,			// NOTE:  This dedups dataset just above instead of full normalized version
									 state_origin,nameasis,filepos,local
									);
kStNameasis					:= buildindex(dStNameasisDeduped,
											{state_origin,
											 nameasis,
											 filepos
											},	
											lBaseKeyName + 'st.nameasis.key',moxie,overwrite
										   );

dNameasisDeduped			:= dedup(dStNameasisDeduped,				// NOTE:  This dedups dataset just above instead of full normalized version
									 nameasis,filepos,local
									);
kNameasis					:= buildindex(dNameasisDeduped,
											{nameasis,
											 filepos
											},
											lBaseKeyName + 'nameasis.key',moxie,overwrite
										   );


//Replace county_name with new_county_name

dStCountyDocnumDateDeduped	:= dedup(dKeyFieldsNormalizedDist,			// No filter necessary, as all state_origin *should* be filled
									 state_origin,new_county_name,doc_instrument_or_clerk_filing_num,doc_filed_ccyymm,filepos,local
									);
kStCountyDocnumDate			:= buildindex(dStCountyDocnumDateDeduped,
											{state_origin,
											 new_county_name,
											 doc_instrument_or_clerk_filing_num,
											 doc_filed_ccyymm,
											 filepos
											},	
											lBaseKeyName + 'st.county.doc_num.date.key',moxie,overwrite
										   );

dStDocnumDateDeduped		:= dedup(dStCountyDocnumDateDeduped,		// NOTE:  This dedups dataset just above instead of full normalized version
									 state_origin,doc_instrument_or_clerk_filing_num,doc_filed_ccyymm,filepos,local
									);
kStDocnumDate				:= buildindex(dStDocnumDateDeduped,
											{state_origin,
											 doc_instrument_or_clerk_filing_num,
											 doc_filed_ccyymm,
											 filepos
											},	
											lBaseKeyName + 'st.doc_num.date.key',moxie,overwrite);

dDocnumDateDeduped			:= dedup(dStDocnumDateDeduped,				// NOTE:  This dedups dataset just above instead of full normalized version
									 doc_instrument_or_clerk_filing_num,doc_filed_ccyymm,filepos,local
									);
kDocnumDate					:= buildindex(dDocnumDateDeduped,
											{doc_instrument_or_clerk_filing_num,
											 doc_filed_ccyymm,
											 filepos
											},	
											lBaseKeyName + 'doc_num.date.key',moxie,overwrite);


//Replace county_name with new_county_name

dStCountyDateLFMNameDeduped	:= dedup(dKeyFieldsNormalizedDist(lname<>''),		// filtering field that is not first field?  /tmk/
									 state_origin,new_county_name,doc_filed_ccyymm,lfmname,filepos,local
									);
kStCountyDateLFMName		:= buildindex(dStCountyDateLFMNameDeduped,
											{state_origin,
											 new_county_name,
											 doc_filed_ccyymm,
											 lfmname,
											 filepos
											},	
											lBaseKeyName + 'st.county.date.lfmname.key',moxie,overwrite);


// Process date key for QA

dStCountyPDateLFMNameDeduped	:= dedup(dKeyFieldsNormalizedDist(lname<>''),		// filtering field that is not first field?  /tmk/
									 state_origin,new_county_name,process_date_qa,lfmname,filepos,local
									);
kStCountyPDateLFMName		:= buildindex(dStCountyDateLFMNameDeduped,
											{state_origin,
											 new_county_name,
											 process_date_qa,
											 lfmname,
											 filepos
											},	
											lBaseKeyName + 'st.county.process_date.lfmname.key',moxie,overwrite);
											
dStDateLFMNameDeduped		:= dedup(dStCountyDateLFMNameDeduped,		// NOTE:  This dedups dataset just above instead of full normalized version
									 state_origin,doc_filed_ccyymm,lfmname,filepos,local
									);
kStDateLFMName				:= buildindex(dStDateLFMNameDeduped,
											{state_origin,
											 doc_filed_ccyymm,
											 lfmname,
											 filepos
											},	
											lBaseKeyName + 'st.date.lfmname.key',moxie,overwrite);

//Replace county_name with new_county_name

dStCountyDateNameasisDeduped:= dedup(dKeyFieldsNormalizedDist(nameasis<>''),	// filtering field that is not first field?  /tmk/
									 state_origin,new_county_name,doc_filed_ccyymm,nameasis,filepos,local
									);
kStCountyDateNameasis		:= buildindex(dStCountyDateNameasisDeduped,
											{state_origin,
											 new_county_name,
											 doc_filed_ccyymm,
											 nameasis,
											 filepos
											},	
											lBaseKeyName + 'st.county.date.nameasis.key',moxie,overwrite);

dStDateNameasisDeduped		:= DEDUP(dStCountyDateNameasisDeduped,		// NOTE:  This dedups dataset just above instead of full normalized version
									 state_origin,doc_filed_ccyymm,nameasis,filepos,local
									);
kStDateNameasis				:= buildindex(dStDateNameasisDeduped,
											{state_origin,
											 doc_filed_ccyymm,
											 nameasis,
											 filepos
											},	
											lBaseKeyName + 'st.date.nameasis.key',moxie,overwrite
										   );

export Out_Moxie_Party_Keys
 := 
  parallel(
			 kKeySeq
			,kKeyMasterTypeSeq
			,kStCountyLFMName
			,kStLFMName
			,kLFMName
			,kStCountyNameasis
			,kStNameasis
			,kNameasis
			,kStCountyDocnumDate
			,kStDocnumDate
			,kDocnumDate
			,kStCountyDateLFMName
			,kStCountyPDateLFMName
			,kStDateLFMName
			,kStCountyDateNameasis
			,kStDateNameasis
			)
 ;