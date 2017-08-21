export proc_build_base(string filedate) := function

import ut, did_add, header_slimsort, didville, business_header_ss, business_header,
       watchdog, lib_stringlib, AID, idl_header, Address, TopBusiness_External,unirush;



CH := unirush.functions.map_cardholders(Unirush.aid_files.cardholders,filedate);
TRANS := unirush.functions.map_transactions(Unirush.aid_files.transactions,filedate);

////////////////////////////////////////////////////////////////////////////////////////
// Pass to Address ID Prep Macro
////////////////////////////////////////////////////////////////////////////////////////
Unirush.aid_mAppdFields(CH,Address1,Address2,city,state,zip,dPreCleanCH);
////////////
Unirush.aid_mAppdFields(TRANS,Address1,Address2,city,state,zip,dPreCleanTRANS);
////////////////////////////////////////////////////////////////////////////////////////
// Pass to Address ID Macro
////////////////////////////////////////////////////////////////////////////////////////
unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(dPreCleanCH,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
dCleanCH,
lAIDAppendFlags
);
////////////
AID.MacAppendFromRaw_2Line(dPreCleanTrans,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
dCleantrans,
lAIDAppendFlags
);
////////////////////////////////////////////////////////////////////////////////////////
// Pass to Parse Address Macro
////////////////////////////////////////////////////////////////////////////////////////
Unirush.aid_ParseCleanAddress(dCleanCH,Unirush.aid_layouts.cardholder_clean,outCH);
Unirush.aid_ParseCleanAddress(dCleanTrans,Unirush.aid_layouts.transaction_clean,outTrans);

////////////////////////////////////////////////////////////////////////////////////////
// Pass Vehicle Owner records to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_flipnames(outCH,fname,mname,lname,did_ready1);
ut.mac_flipnames(outTrans,fname,mname,lname,did_ready2);


matchset := ['D','A','S','Z','4'];

did_add.mac_match_flex(
	 did_ready1
						,matchset
						,ssn
						,dob_better
						,fname
						,mname
						,lname
						,suffix
						,prim_range
						,prim_name
						,sec_range
						,zip
						,st
						,foo
						,did
						,UniRush.aid_layouts.did_rec1
						,true,did_score,75
						,did_file1)
			   

did_add.mac_match_flex(did_ready2
						,matchset
						,ssn
						,dob_better
						,fname
						,mname
						,lname
						,suffix
						,prim_range
						,prim_name
						,sec_range
						,zip
						,st
						,foo
						,did
						,UniRush.aid_layouts.did_rec2
						,true,did_score,75
						,did_file2);
				   

////////////////////////////////////////////////////////////////////////////////////////
// Output Files
////////////////////////////////////////////////////////////////////////////////////////
return 
sequential(
output(did_file1,, '~thor_data400::base::unirush::'+filedate+'::cardholders',overwrite,__compressed__),
output(did_file2,, '~thor_data400::base::unirush::'+filedate+'::transactions',overwrite,__compressed__)
);
end;



