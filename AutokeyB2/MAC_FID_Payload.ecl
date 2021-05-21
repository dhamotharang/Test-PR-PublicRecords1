export MAC_FID_Payload(indataset,inbname,
            infein,
            //indob,
            phone,
            inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
            //instates,
            //inlname1,inlname2,inlname3,
            //incity1,incity2,incity3,
            //inrel_fname1,inrel_fname2,inrel_fname3,
            //inlookups,
            indid,
            inbdid,
            inkeyname,outkey,typeStr = '\'AK\'',
            useOnlyRecordIDs = false,
            FakeIDField = 'unsigned6 FakeID',
            rec_payload = '\'\'') // caller can slim down input dataset, if desired
            :=
MACRO

import doxie, lib_stringlib, autokeyB2;

//slim down input dataset, if requested:
#UNIQUENAME(ds_in);
#IF(rec_payload != '')
  rec_payload_fakeid := RECORD
    indataset.FakeIDField;
    #EXPAND(rec_payload);
  END;
  %ds_in% := PROJECT(indataset, rec_payload_fakeid);
#ELSE
  %ds_in% := indataset;
#END;

#uniquename(touse)

//changed inDID and inBdid
%touse% := %ds_in%(AutokeyB2.isFakeID(indid,typeStr) or AutokeyB2.isFakeID(inbdid,typeStr)
           or useOnlyRecordIDs);

#uniquename(recs)
%recs% := dedup( sort (%touse%, record), record );

#uniquename(keyname)
%keyname% := if ( stringlib.stringfind(trim(inkeyname),'::qa::',1) > 0,
          inkeyname,
          inkeyname + '_' + doxie.Version_SuperKey);

//changed inDIDs and inBdids
outkey :=
INDEX(%recs%,
{FakeIDField},
{%recs%},
trim(%keyname%,left,right));

ENDMACRO;
