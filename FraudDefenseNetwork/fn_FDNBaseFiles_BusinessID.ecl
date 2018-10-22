IMPORT std, tools, ut, DID_Add, RoxieKeyBuild, Business_Header_SS, Business_HeaderV2, FraudDefenseNetwork;

EXPORT fn_FDNBaseFiles_BusinessID(STRING pversion = (STRING8)Std.Date.Today()) := FUNCTION

//#########################################################################################################################################
//------------------------------------------------------- ERIE -------------------------------------------------------------------------
//#########################################################################################################################################
erie_base                        := files().base.erie.qa;

FraudDefenseNetwork.Mac_BusinessIDAppend(erie_base, erie_base_BID);

dist_erie                        := DISTRIBUTE(erie_base_BID, hash(claimnumber,cleaned_name.fname,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.fname, cleaned_name_cp.lname));

//#########################################################################################################################################
//------------------------------------------------------- ERIE WatchList -------------------------------------------------------------------------
//#########################################################################################################################################
erieWL_base                        := files().base.ErieWatchList.qa;

FraudDefenseNetwork.Mac_BusinessIDAppend(erieWL_base, erieWL_base_BID);

dist_erieWL                        := DISTRIBUTE(erieWL_base_BID, hash(alertnumber, firstname, lastname, business_name, ssn,  dob, validstartDate, entity ));


//#########################################################################################################################################
//------------------------------------------------------- OIG -------------------------------------------------------------------------
//#########################################################################################################################################
oig_base                        := Files().base.oig.qa;

FraudDefenseNetwork.Mac_BusinessIDAppend(oig_base, oig_base_BID);

dist_oig                        := DISTRIBUTE(oig_base_BID, hash64(did, bdid));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_erie, FileNames().Fdn_Prefix, 'ERIE', pversion, erie_base_out, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_erieWL, FileNames().Fdn_Prefix, 'ERIEWATCHLIST', pversion, erieWL_base_out, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_oig, FileNames().Fdn_Prefix, 'OIG', pversion, oig_base_out, 3, false, true);

FDN_BusinessID   :=  sequential(parallel(erie_base_out, erieWL_base_out, oig_base_out)
                                ,Promote(pversion).buildfiles.New2Built);

return FDN_BusinessID;

end;
