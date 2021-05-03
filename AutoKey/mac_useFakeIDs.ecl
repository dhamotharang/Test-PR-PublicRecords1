/*

THIS MACRO IS ONLY FOR THOSE WHO WISH TO useFakeIDs (an old parameter to mac_build)
see documentation on gforge->ecl->docs->autokeys
https://gforge.seisint.com/docman/?group_id=21#

**** PARAMETERS DESCRIBED ****
--required
indataset         - this is your file for which you want autokeys.  it will be built into the payload key.
outdataset        - this is your file with a FakeID field appended so that you may pass it in to AutokeyB2.Fn_Build
outaction         - this holds the action of building and moving your payload key
inkeyname         - this is the string which is used to give your keys a name.  it should be unique to your dataset.
inlogical         - this is the string which is used to give your keys a logical name.  it should be unique to your dataset.
indid             - name of field either populated with real dids or with zeros
inbdid            - name of field either populated with real bdids or with zeros

--optional
useOnlyRecordIDs  - this is recommended.  it uses unique ids rather than dids and bdids that you pass in.  it prevents unintentional deep dive.
typestr           - only here for backward compatibility.  use default unless your build already has another typestr declared.
FakeIDFieldType   - only here for backward compatibility.  use default unless your build already has another FakeIDFieldType declared.
diffing           - only here for backward compatibility.  use default unless your build already has another diffing declared.
useunique         - not recommended unless you are having problems due to a very large dataset (and still maybe not recommended)
moveToQA          - old behavior is to only move to built, but i think that is silly.

--only used when useunique = true
uniqueid          - name of field populated with uniqueid for you particular dataset (such as corp_key)

*/
export mac_useFakeIDs
  (indataset,
   outdataset,
   outaction,
   inkeyname,
   inlogical,
   indid,
   inbdid,
   useOnlyRecordIDs = true,
   typeStr = '\'AK\'',
   FakeIDFieldType = 'unsigned6',
   diffing = false,
   use_unique = false,
   uniqueid = 'junk_uniqueid',
   moveToQA = true,
   isdelta=false,
   maxFID=0,
   forcePromotion=false,
   rec_payload = '\'\''
   )
:= MACRO
import ut,RoxieKeyBuild;


//****** APPEND A UNIQUE ID TO EACH RECORD

with_seq_rec :=record
indataset;
seq_num_added :=0;
end;

added_field :=project(indataset,transform(with_seq_rec, self := left, self := []));
ut.mac_sequence_records(added_field,seq_num_added,with_sequence_num);



//**** OPTIONAL FUNCTIONALITY FOR USE_UNIQUE - Make all records with the same did, bdid, and unique id have the saMe sequence number

#if(use_unique)
  sort_by_uniqueid := sort(distribute(with_sequence_num, hash(uniqueid)),uniqueid,indid,inbdid,local);

  #uniquename(same_fake)
  recordof(sort_by_uniqueid) %same_fake%(sort_by_uniqueid l, sort_by_uniqueid r) := Transform
    self.seq_num_added := if(l.indid=r.indid and l.inbdid=r.inbdid and l.uniqueid=r.uniqueid, l.seq_num_added,r.seq_num_added);
    self := r;
  END;

  consolidate_seq_num := iterate(sort_by_uniqueid, %same_fake%(left,right),local);

  with_seq_num_use := consolidate_seq_num;
#else
  with_seq_num_use := with_sequence_num;
#end



//***** NOT SURE THIS IS NECESSARY, BUT MAINTAINS BEHAVIOR OF PUTTING FAKEID INTO DID AND BDID FIELDS IN PAYLOAD UNLESS useOnlyRecordIDs...may affect fetch
AddtoValue:=MaxFID;
#uniquename(addFid)
{indataset, FakeIDFieldType FakeID} %addFid% (with_seq_rec le) := TRANSFORM
  fid := if(isdelta,AddtoValue + le.seq_num_added + autokey.did_adder(typeStr),
            le.seq_num_added + autokey.did_adder(typeStr));
  self.FakeID := fid;
  SELF.inDID := if((unsigned8)le.inDID > 0 or useOnlyRecordIDs, le.inDID, fid);
  SELF.inBDID := if((unsigned8)le.inBDID > 0 or useOnlyRecordIDs, le.inBDID, fid);  //will be the same when both were zero
  SELF := le;
END;

#uniquename(wtihFakeID0)
%wtihFakeID0% := PROJECT(with_seq_num_use, %addFid%(LEFT)) : independent;  //see bug 23504



//***** RETURN DATASET TO BE USED FOR REST OF AUTOKEY BUILD

outdataset := %wtihFakeID0%;



//***** BUILD AND MOVE CODE FOR THE PAYLOAD KEY

#uniquename(withFakeID1)
%withFakeID1% := if(use_unique,dedup(sort(%wtihFakeID0%,FakeID),FakeID),%wtihFakeID0%) : independent;

#uniquename(Payload_Key)
AutokeyB2.MAC_FID_Payload(%withFakeID1%,inbname,
            infein,
            phone,
            inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
            inDID,inbdid,
            inkeyname,%Payload_Key%,typeStr,
            useOnlyRecordIDs,
            FakeID,
            rec_payload);

#uniquename(do_Payload_Key)
#uniquename(mv_Payload_Key)
#uniquename(mvQA_Payload_Key)
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Payload_Key%, '',inlogical+'Payload', %do_Payload_Key%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Payload',inlogical+'Payload', %mv_Payload_Key%, ,diffing);
RoxieKeyBuild.MAC_SK_Move_v2(inkeyname+'Payload','Q',%mvQA_Payload_Key%,,diffing)



//***** RETURN ACTION FOR BUILDING AND MOVING PAYLOAD KEY

outaction :=
    sequential(
      if(typestr = '', fail('must have valid typestr when useFakeIDs')),
      %do_Payload_Key%,
      if(isdelta=false or forcePromotion=true,%mv_Payload_Key%),
      if(moveToQA, %mvQA_Payload_Key%)
    );

ENDMACRO;
