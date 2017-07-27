import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export macAppends(inDs, outDs) := macro

///////////////// BDID SSN TAXID DID APPENDS ///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////// APPEND PROCESS HAS DEDUP AND RE-JOIN IN MACROs ///////////////////


#UNIQUENAME(did_match_set)										

%did_match_set% := ['A','D','S','P','4','Z'];

#UNIQUENAME(DIDFIle)										

did_add.MAC_Match_Flex(inDS(fname <> '' and lname <> ''), %did_match_set%,
						ssn, dob, fname, mname, lname, name_suffix,
						prim_range, prim_name, sec_range, zip5, st, personal_phone,
						appendadl, recordof(inDS),false,'',
						75, %DIDFile%);

#UNIQUENAME(didReady)

%didready% := inDS(fname = '' or lname = '') + %DIDFile%;
#UNIQUENAME(bdid_match_set)

%bdid_match_set% := ['A','P'];  

#UNIQUENAME(inBDID)
#UNIQUENAME(BDIDFile)

%inBDID% := %didready%(cname <> '');

Business_Header_SS.MAC_Match_Flex(%inBDID%, %bdid_match_set%,
									cname,
									prim_range, prim_name, zip5, sec_range, st, phone, foo,
									appendbdid, recordof(inDS), 
									false, '', %BDIDFile%);

#UNIQUENAME(appendDIDReady)

%appendDIDReady% := %BDIDFile% + %didready%(cname = '');
									
//Append SSN 

#UNIQUENAME(SSNFile)

did_add.MAC_Add_SSN_By_DID(%appendDIDReady%, appendadl, appendssn, %SSNFile%, false);

// Append Fein

#UNIQUENAME(AppendReady)

Business_Header_SS.MAC_Add_FEIN_By_BDID(%SSNFile%, appendbdid, appendtaxid, %AppendReady%)

#UNIQUENAME(AppendForward)

%AppendForward% := %AppendReady%;// : persist('~persist::acc_logs::append');


outDS := %AppendForward%;

endmacro;
