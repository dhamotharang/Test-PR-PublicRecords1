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
            typeStr = '\'AK\'', //use default
            useOnlyRecordIDs = false,
            FakeIDFieldType = 'unsigned6',
            Rep_Addr = 4,
            // lookup bit to set for representative address.  The representative address bit is set
            // for one record among a set that all share the same address.  This is useful when
            // address only is input.  In order to activate this feature one must set the stored
            // value of SetRepAddr, defined in mac_header_field_declare, to true in the query. Also,
            // if the rep_addr bit is set at something different than four this may be reflected in the query
            // by setting that value in the setRepAddrBit variable
            uniqueid = 'zero1',
            use_unique = False,
            // If use_unique is true, all records with the same uniqueid, did, and bdid will be assigned
            // the same fakeid.  This allows the payload key to be smaller (it will be deduped by fakeid)
            // as well as the other keys
            skipaddrnorm = False,
            // set to true if address normalizing takes place outside of mac_build
            by_lookup = TRUE,
            // if set to false the lookup field will be excluded from deduping before the key is built
            // and duplicate records will be sorted based first upon favored lookup bit and then highest
            // lookup bit
            favorlookupbusiness = 0,
            favorlookupperson = 0,            // if not deduping by lookup these parameters specify which lookup bits to prefer
            visitor = 'standard.MStandardBuild',
            visitorb = 'standard.MStandardBuildb',
            processCompoundNames = FALSE,
            rec_payload = '\'\''
            )  :=
MACRO

import autokey,ut,RoxieKeyBuild,standard;

#uniquename(Payload_Key)


//****** APPEND FAKE IDS *******
with_seq_rec :=record
indataset;
seq_num_added :=0;
end;


added_field :=project(indataset,transform(with_seq_rec, self := left, self := []));

ut.mac_sequence_records(added_field,seq_num_added,with_sequence_num);

sort_by_uniqueid := sort(distribute(with_sequence_num, hash(uniqueid)),uniqueid,indid,inbdid,local);

#uniquename(same_fake)
recordof(sort_by_uniqueid) %same_fake%(sort_by_uniqueid l, sort_by_uniqueid r) := Transform
  self.seq_num_added := if(l.indid=r.indid and l.inbdid=r.inbdid and l.uniqueid=r.uniqueid, l.seq_num_added,r.seq_num_added);
  self := r;
END;

// Make all records with the same did, bdid, and unique id have the sake sequence number

consolidate_seq_num := iterate(sort_by_uniqueid, %same_fake%(left,right),local);


with_seq_num_use :=if(use_unique,consolidate_seq_num,with_sequence_num);

#uniquename(addFid)
{indataset, FakeIDFieldType FakeID} %addFid% (with_seq_rec le) := TRANSFORM
  fid := le.seq_num_added + autokey.did_adder(typeStr);
  self.FakeID := fid;
  SELF.inDID := if((unsigned8)le.inDID > 0 or useOnlyRecordIDs, le.inDID, fid);
  SELF.inBDID := if((unsigned8)le.inBDID > 0 or useOnlyRecordIDs, le.inBDID, fid);  //will be the same when both were zero
  SELF := le;
END;


#uniquename(wtihFakeID0)
%wtihFakeID0% := PROJECT(with_seq_num_use(useFakeIDs), %addFid%(LEFT)) : independent;  //see bug 23504

// Use on record per fakeid in the payload key

#uniquename(withFakeID1)
%withFakeID1% := if(use_unique,dedup(sort(%wtihFakeID0%,FakeID),FakeID),%wtihFakeID0%) : independent;

AutokeyB2.MAC_FID_Payload(%withFakeID1%,inbname,
            infein,
            phone,
            inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
            inDID,inbdid,
            inkeyname,%Payload_Key%,typeStr,
            useOnlyRecordIDs,
            FakeID,
            rec_payload)

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
if(skipaddrnorm,%wtihFakeID%,
  %wtihFakeID% +
  project(%wtihFakeID%(%needsaddcontactaddr%), %addcontactaddr%(left)));

// ======= ADD ADDITIONAL CITY ACCORDING TO THE ZIP CODE, IF ANY ========
#uniquename(ds_normed)
visitor.MAC_Add_Cities (%withaddcontactaddr%, inzip, incity_name, %ds_normed%); //default: autokey.MAC_Add_Cities


//***** NORMALIZE COMPOUND NAMES

#uniquename(indataset_w_compound_names)
#uniquename(forMacBuild)
#if(processCompoundNames)
  // output('Compound Name Normalization is enabled');
  AutokeyB2.MAC_NormalizeCompoundNames(%ds_normed%, %indataset_w_compound_names%, inlname);
  %forMacBuild% := %indataset_w_compound_names%;
#else
  %forMacBuild% := %ds_normed%;
#end;

//****** CALL THE AUTOKEY DID KEYBUILDS *******
#uniquename(favor_lookup_person)
%favor_lookup_person% := favorlookupperson;

autokey.MAC_Build_version (%forMacBuild% ,infname,inmname,inlname,
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
            build_skip_set, true,
            rep_addr, by_lookup,%favor_lookup_person%,
            visitor)

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

// debug
// OUTPUT (%wtihFakeID%, NAMED ('wtihFakeID'));
// OUTPUT (%withaddcontactaddr%, NAMED ('withaddcontactaddr'));
// OUTPUT (%ds_normed%, NAMED ('ds_normed'));

// ======= ADD ADDITIONAL CITY FOR BUSINESS ACCORDING TO THE ZIP CODE, IF ANY ========
#uniquename(ds_normedB)
autokey.MAC_Add_Cities (%wtihFakeID%, inbzip, inbcity_name, %ds_normedB%);

#uniquename(normalizecompanynameswith_the)
%ds_normedB% split_company_names(%ds_normedB% l, integer C) := transform
  self.inbname := choose(C,l.inbname, l.inbname[5..length(l.inbname)]);
  self := l;
END;
%normalizecompanynameswith_the% := normalize(%ds_normedB%,if(left.inbname[1..4]='THE ',2,1),split_company_names(left,counter));


// NB: before %withaddcontactaddr% was used here;
// it looks like %wtihFakeID% should be used instead (as a start point for "Get city list" above)
// (as persons' addresses are generally ignored for business)

#uniquename(favor_lookup_business)
%favor_lookup_business% := favorlookupbusiness;

AutokeyB2.Keys  (%normalizecompanynameswith_the% ,inbname,
            infein,
            bphone,
            inbprim_name,inbprim_range,inbst,inbcity_name,inbzip,inbsec_range,
            inlookups,
            inbdid,
            inkeyname,
          %Address_Key%,%CityStName_Key%,%Name_Key%,%NameWords_Key%,%Phone_Key%,%FEIN_Key%,%StName_Key%,%Zip_Key%,
          by_lookup,%favor_lookup_business%,build_skip_set,
          visitorb)

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Payload_Key%, '',inlogical+'Payload', %do_Payload_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Address_Key%, '',inlogical+'AddressB2', %do_Address_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%CityStName_Key%, '',inlogical+'CityStNameB2', %do_CityStName_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Name_Key%, '',inlogical+'NameB2', %do_Name_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%NameWords_Key%, '',inlogical+'NameWords2', %do_NameWords_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Phone_Key%, '',inlogical+'PhoneB2', %do_Phone_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%FEIN_Key%, '',inlogical+'FEIN2', %do_FEIN_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%StName_Key%,'',inlogical+'StNameB2', %do_StName_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Zip_Key%, '',inlogical+'ZipB2', %do_Zip_Key%, ,diffing);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Payload',inlogical+'Payload', %mv_Payload_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'AddressB2',inlogical+'AddressB2', %mv_Address_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'CityStNameB2',inlogical+'CityStNameB2', %mv_CityStName_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'NameB2',inlogical+'NameB2', %mv_Name_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'NameWords2',inlogical+'NameWords2', %mv_NameWords_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'PhoneB2',inlogical+'PhoneB2', %mv_Phone_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'FEIN2',inlogical+'FEIN2', %mv_FEIN_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'StNameB2',inlogical+'StNameB2', %mv_StName_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'ZipB2',inlogical+'ZipB2', %mv_Zip_Key%, ,diffing);

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

