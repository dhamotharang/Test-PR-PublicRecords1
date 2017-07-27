import doxie_build,ut,doxie,autokey;

prekey := if (fileservices.getsuperfilesubcount('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing added to Offenders BUILDING file.'),
		fileservices.addsuperfile('~thor_data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_offenders_' + doxie_build.buildstate,0,true));
		
ut.MAC_SK_BuildProcess(doxie_build.key_prep_offenders,'~thor_Data400::key::corrections_offenders_' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenders_' + doxie_build.buildstate,key,2)
ut.MAC_SK_BuildProcess(doxie_build.key_prep_offenders_docnum,'~thor_Data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,key2,2)
ut.MAC_SK_BuildProcess(doxie_build.key_prep_offenders_OffenderKey,'~thor_Data400::key::corrections_offenders_OffenderKey_' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenders_OffenderKey_' + doxie_build.buildstate,key3,2)

f := file_offenders_keybuilding;

xl :=
RECORD
	f;
	unsigned6 i_did;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('CRIM'))| ut.bit_set(0,0);
END;
xl xpand(f le,integer cntr) := 
TRANSFORM 
	SELF.i_did := cntr + autokey.did_adder('CRIM'); 
	SELF := le; 
END;
DS := PROJECT(f,xpand(LEFT,COUNTER));

AutoKey.MAC_Build(DS,fname,mname,lname,
						ssn,
						dob,
						zero,
						prim_name,prim_range,st,v_city_name,zip5,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						i_did,
						'~thor_data400::key::corrections_'+doxie_build.buildstate,outaction)

i := index(ds,{sdid := i_did},{(STRING60)offender_key},'~thor_data400::key::corrections_fdid_'+ doxie_build.buildstate);
ut.MAC_SK_BuildProcess(i,'~thor_data400::key::corrections_fdid_'+ doxie_build.buildstate,
					'~thor_data400::key::corrections_fdid_'+ doxie_build.buildstate,d);


postkey := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILT','~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING')
		);
		
export proc_build_DOC_offenders_key := if(fileservices.getsuperfilesubname('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate,1),
			output('BASE = BUILT, nothing done for offenders'),
			sequential(prekey,key,key2,key3,outaction,d,postkey));
			
