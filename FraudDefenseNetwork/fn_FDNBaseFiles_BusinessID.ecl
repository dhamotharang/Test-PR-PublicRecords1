IMPORT std, tools, ut, DID_Add, RoxieKeyBuild, Business_Header_SS, Business_HeaderV2, FraudDefenseNetwork;

EXPORT fn_FDNBaseFiles_BusinessID(STRING pversion = (STRING8)Std.Date.Today()) := FUNCTION

//#########################################################################################################################################
//------------------------------------------------------- ERIE -------------------------------------------------------------------------
//#########################################################################################################################################
erie_base                        := files().base.erie.qa;

FraudDefenseNetwork.Mac_BusinessIDAppend(erie_base, erie_base_BID);

dist_erie                        := DISTRIBUTE(erie_base_BID, hash(claimnumber,cleaned_name.fname,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.fname, cleaned_name_cp.lname));


//#########################################################################################################################################
//------------------------------------------------------- OIG -------------------------------------------------------------------------
//#########################################################################################################################################
oig_base                        := Files().base.oig.qa;

FraudDefenseNetwork.Mac_BusinessIDAppend(oig_base, oig_base_BID);

dist_oig                        := DISTRIBUTE(oig_base_BID, hash64(did, bdid));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_erie, FileNames().Fdn_Prefix, 'ERIE', pversion, erie_base_out, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_oig, FileNames().Fdn_Prefix, 'OIG', pversion, oig_base_out, 3, false, true);

FDN_BusinessID   :=  parallel(erie_base_out,oig_base_out);

return FDN_BusinessID;

end;
