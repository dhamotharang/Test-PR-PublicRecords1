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
						FakeIDField = 'unsigned6 FakeID')
						//FakeIDValue = 0) 
						:=
MACRO

import ut,doxie,lib_stringlib,autokeyB2;

#uniquename(touse)

//changed inDID and inBdid 
%touse% := indataset(AutokeyB2.isFakeID(indid,typeStr) or AutokeyB2.isFakeID(inbdid,typeStr)
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