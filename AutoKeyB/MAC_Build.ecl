/*
Reinstating previous version due to (as yet) unexplained YP issues with DID field and dedup differences
*/
export MAC_Build (indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						inDID,
					//personal above.  business below
						inbname,
						infein,
						bphone,
						inbprim_name,inbprim_range,inbst,inbcity_name,inbzip,inbsec_range,
							//when one address, use same field names here as above
						inbdid,
						inkeyname,inlogical,outaction,diffing='false',
						build_skip_set='[]',
							//P in this set to skip personal phones
							//Q in this set to skip business phones
							//S in this set to skip SSN
							//F in this set to skip FEIN
							//C in this set to skip ALL personal (Contact) data
							//B in this set to skip ALL Business data

						useFakeIDs = false,
						typeStr = '', //ref doxie.lookup_bit
						useOnlyRecordIDs = false,
						FakeIDFieldType = 'unsigned6',
					  uniqueid = 'zero1',
						use_unique = False,
						skipaddrnorm = False						
						)  :=
MACRO

import autokey,doxie,ut,business_header,Business_Header_SS,RoxieKeyBuild, standard;

#uniquename(Payload_Key)


//****** APPEND FAKE IDS *******
with_seq_rec :=record
indataset;
seq_num_added :=0;
end;




added_field :=project(indataset,transform(with_seq_rec, self := left, self := []));

ut.mac_sequence_records(added_field,seq_num_added,with_sequence_num);


sort_by_uniqueid := sort(distribute(with_sequence_num, hash(uniqueid)),uniqueid,indid,inbdid,local);



recordof(sort_by_uniqueid) same_fake(sort_by_uniqueid l, sort_by_uniqueid r) := Transform
	self.seq_num_added := if(l.indid=r.indid and l.inbdid=r.inbdid and l.uniqueid=r.uniqueid, l.seq_num_added,r.seq_num_added);
	self := r;
END;
consolidate_seq_num := iterate(sort_by_uniqueid, same_fake(left,right),local);


with_seq_num_use := if(use_unique,consolidate_seq_num,with_sequence_num);


#uniquename(addFid)
{indataset, FakeIDFieldType FakeID} %addFid% (with_seq_rec le) := TRANSFORM 
	fid := le.seq_num_added + autokey.did_adder(typeStr);
	self.FakeID := fid;
    SELF.inDID := if((unsigned8)le.inDID > 0 or useOnlyRecordIDs, le.inDID, fid); 
	SELF.inBDID := if((unsigned8)le.inBDID > 0 or useOnlyRecordIDs, le.inBDID, fid);  //will be the same when both were zero
    SELF := le; 
END;


#uniquename(wtihFakeID0)
%wtihFakeID0% := PROJECT(with_seq_num_use(useFakeIDs), %addFid%(LEFT)) : independent;
	  

#uniquename(withFakeID1)
%withFakeID1% := if(use_unique,dedup(sort(%wtihFakeID0%,FakeID),FakeID),%wtihFakeID0%);

AutokeyB.MAC_FID_Payload(%withFakeID1%,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inDID,inbdid,
						inkeyname,%Payload_Key%,typeStr,
						useOnlyRecordIDs,
						FakeID)
						//theFakeID)

// Maintain the same layout that was already being used below
#uniquename(fixDID)
recordof(indataset) %fixDID%(%wtihFakeID0% l) := transform
	self.inDID := if(useOnlyRecordIDs, l.FakeID, l.inDID);
	self.inBDID := if(useOnlyRecordIDs, l.FakeID, l.inBDID);
	self := l;
end;

#uniquename(wtihFakeID)
%wtihFakeID% :=  if(useFakeIDs,PROJECT(%wtihFakeID0%, %fixDID%(left)), indataset);

//****** CREATE ADDITIONAL PERSON ADDRESSES FROM COMPANY ADDRESS ******

#uniquename(addcontactaddr)
indataset %addcontactaddr%(indataset l) := transform
	self.inprim_name := l.inbprim_name;
	self.inprim_range := l.inbprim_range;
	self.inst := l.inbst;
	self.incity_name := l.inbcity_name;
	self.inzip := l.inbzip;
	self.insec_range := l.inbsec_range;
	self := l;
end;

#uniquename(needsaddcontactaddr)
%needsaddcontactaddr% := %wtihFakeID%.inbprim_name <> '' and %wtihFakeID%.inbprim_name <> %wtihFakeID%.inprim_name;

#uniquename(withaddcontactaddr)
%withaddcontactaddr% := 
	%wtihFakeID% + 
	project(%wtihFakeID%(%needsaddcontactaddr%), %addcontactaddr%(left));

#uniquename(passtopersonkeys)
%passtopersonkeys% := if(skipaddrnorm,%wtihFakeID%,%withaddcontactaddr%);


//****** CALL THE AUTOKEY DID KEYBUILDS *******

autokey.MAC_Build_version (%passtopersonkeys% ,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,inlogical,regAutoKeys,diffing,
						build_skip_set) 
					
#uniquename(Address_Key)
#uniquename(CityStName_Key)
#uniquename(Name_Key)
#uniquename(NameWords_Key)
#uniquename(Phone_Key)
#uniquename(FEIN_Key)
#uniquename(StName_Key)
#uniquename(Zip_Key)

#uniquename(do_Payload_Key)
#uniquename(do_Address_Key)
#uniquename(do_CityStName_Key)
#uniquename(do_Name_Key)
#uniquename(do_NameWords_Key)
#uniquename(do_Phone_Key)
#uniquename(do_FEIN_Key)
#uniquename(do_StName_Key)
#uniquename(do_Zip_Key)

#uniquename(mv_Payload_Key)
#uniquename(mv_Address_Key)
#uniquename(mv_CityStName_Key)
#uniquename(mv_Name_Key)
#uniquename(mv_NameWords_Key)
#uniquename(mv_Phone_Key)
#uniquename(mv_FEIN_Key)
#uniquename(mv_StName_Key)
#uniquename(mv_Zip_Key)



#uniquename(normalizecompanynameswith_the)
%passtopersonkeys% split_company_names(%withaddcontactaddr% l, integer C) := transform
	self.inbname := choose(C,l.inbname, l.inbname[5..length(l.inbname)]);
	self := l;
END;


%normalizecompanynameswith_the% := normalize(%passtopersonkeys%,if(left.inbname[1..4]='THE ',2,1),split_company_names(left,counter));

AutoKeyB.Keys  (%normalizecompanynameswith_the% ,inbname,
						infein,
						bphone,
						inbprim_name,inbprim_range,inbst,inbcity_name,inbzip,inbsec_range,
						inbdid,
						inkeyname,
					%Address_Key%,%CityStName_Key%,%Name_Key%,%NameWords_Key%,%Phone_Key%,%FEIN_Key%,%StName_Key%,%Zip_Key%)

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Payload_Key%, '',inlogical+'Payload', %do_Payload_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Address_Key%, '',inlogical+'AddressB', %do_Address_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%CityStName_Key%, '',inlogical+'CityStNameB', %do_CityStName_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Name_Key%, '',inlogical+'NameB', %do_Name_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%NameWords_Key%, '',inlogical+'NameWords', %do_NameWords_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Phone_Key%, '',inlogical+'PhoneB', %do_Phone_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%FEIN_Key%, '',inlogical+'FEIN', %do_FEIN_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%StName_Key%,'',inlogical+'StNameB', %do_StName_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Zip_Key%, '',inlogical+'ZipB', %do_Zip_Key%, ,diffing);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Payload',inlogical+'Payload', %mv_Payload_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'AddressB',inlogical+'AddressB', %mv_Address_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'CityStNameB',inlogical+'CityStNameB', %mv_CityStName_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'NameB',inlogical+'NameB', %mv_Name_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'NameWords',inlogical+'NameWords', %mv_NameWords_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'PhoneB',inlogical+'PhoneB', %mv_Phone_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'FEIN',inlogical+'FEIN', %mv_FEIN_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'StNameB',inlogical+'StNameB', %mv_StName_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'ZipB',inlogical+'ZipB', %mv_Zip_Key%, ,diffing);

#uniquename(dobkeys)
#uniquename(mvbkeys)
%dobkeys% := parallel(
	%do_Address_Key%,
	%do_CityStName_Key%,
	%do_Name_Key%,
	%do_NameWords_Key%,
	if('Q' not in build_skip_set, %do_Phone_Key%),
	if('F' not in build_skip_set, %do_FEIN_Key%),
	%do_StName_Key%,
	%do_Zip_Key%);

%mvbkeys% := parallel(
	%mv_Address_Key%,
	%mv_CityStName_Key%,
	%mv_Name_Key%,
	%mv_NameWords_Key%,
	if('Q' not in build_skip_set, %mv_Phone_Key%),
	if('F' not in build_skip_set, %mv_FEIN_Key%),
	%mv_StName_Key%,
	%mv_Zip_Key%);

outaction := 
SEQUENTIAL(
	PARALLEL(  //build
	if(useFakeIDs and typestr = '', fail('must have valid typestr when useFakeIDs')),
	if('C' not in build_skip_set, regAutoKeys),
	if(useFakeIDs, %do_Payload_Key%), //if you are utilizing the fake dids, you will need something..not sure this is it
	if('B' not in build_skip_set, %dobkeys%)
	),
	PARALLEL(  //move to built
	if(useFakeIDs, %mv_Payload_Key%), //if you are utilizing the fake dids, you will need something
	if('B' not in build_skip_set, %mvbkeys%)
	));

ENDMACRO;			