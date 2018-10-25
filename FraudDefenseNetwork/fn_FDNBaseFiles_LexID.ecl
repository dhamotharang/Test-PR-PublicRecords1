IMPORT std, ut, tools, DID_Add, RoxieKeyBuild;

EXPORT fn_FDNBaseFiles_LexID(STRING pversion = (STRING8)Std.Date.Today()) := FUNCTION

//#########################################################################################################################################
//------------------------------------------------------- CFNA -------------------------------------------------------------------------
//#########################################################################################################################################
cfna_base                        := files().base.cfna.qa;

FraudDefenseNetwork.Mac_LexidAppend(cfna_base, cfna_base_idl);

dist_cfna                        := DISTRIBUTE(cfna_base_idl, hash(Application_ID));


//#########################################################################################################################################
//------------------------------------------------------- ERIE -------------------------------------------------------------------------
//#########################################################################################################################################
erie_base                        := files().base.erie.qa;

FraudDefenseNetwork.Mac_LexidAppend(erie_base, erie_base_idl);

dist_erie                        := DISTRIBUTE(erie_base_idl, hash(claimnumber,cleaned_name.fname,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.fname, cleaned_name_cp.lname));

//#########################################################################################################################################
//------------------------------------------------------- ERIE WatchList -------------------------------------------------------------------------
//#########################################################################################################################################
erieWL_base                        := files().base.ErieWatchList.qa;

FraudDefenseNetwork.Mac_LexidAppend(erieWL_base, erieWL_base_idl);

dist_erieWL                        := DISTRIBUTE(erieWL_base_idl, hash(alertnumber, firstname, lastname, business_name, ssn,  dob, validstartDate, entity ));

//#########################################################################################################################################
//------------------------------------------------------- GLB5 -------------------------------------------------------------------------
//#########################################################################################################################################
glb5_base                        := files().base.glb5.qa;

FraudDefenseNetwork.Mac_LexidAppend(glb5_base, glb5_base_idl);

dist_glb5                        := DISTRIBUTE(glb5_base_idl, hash(transaction_id));

//#########################################################################################################################################
//------------------------------------------------------- OIG -------------------------------------------------------------------------
//#########################################################################################################################################
oig_base                        := files().base.oig.qa;

FraudDefenseNetwork.Mac_LexidAppend(oig_base, oig_base_idl);

dist_oig                        := DISTRIBUTE(oig_base_idl, hash64(did, bdid));

//#########################################################################################################################################
//------------------------------------------------------- TextMinedCrim -------------------------------------------------------------------------
//#########################################################################################################################################
TextMinedCrim_base                        := files().base.TextMinedCrim.qa;

FraudDefenseNetwork.Mac_LexidAppend(TextMinedCrim_base, TextMinedCrim_base_idl);

dist_TextMinedCrim                        := DISTRIBUTE(TextMinedCrim_base_idl, hash(did));

//#########################################################################################################################################
//------------------------------------------------------- TIGER -------------------------------------------------------------------------
//#########################################################################################################################################
tiger_base                        := files().base.tiger.qa;

FraudDefenseNetwork.Mac_LexidAppend(tiger_base, tiger_base_idl);

dist_tiger                        := DISTRIBUTE(tiger_base_idl, hash(did));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_cfna, FileNames().Fdn_Prefix, 'CFNA', pversion, cfna_base_out, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_erie, FileNames().Fdn_Prefix, 'ERIE', pversion, erie_base_out, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_glb5, FileNames().Fdn_Prefix, 'GLB5', pversion, glb5_base_out, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_oig,  FileNames().Fdn_Prefix, 'OIG', pversion, oig_base_out, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_TextMinedCrim, FileNames().Fdn_Prefix, 'TEXTMINEDCRIM', pversion, TextMinedCrim_base_out, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_tiger, FileNames().Fdn_Prefix, 'TIGER', pversion, tiger_base_out, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(dist_erieWL, FileNames().Fdn_Prefix, 'ERIEWATCHLIST', pversion, erieWL_base_out, 3, false, true);


FDN_Lexid   :=  Sequential(parallel(cfna_base_out, erie_base_out, glb5_base_out, oig_base_out, TextMinedCrim_base_out, Tiger_base_out, erieWL_base_out)
                           ,Promote(pversion).buildfiles.New2Built);
return FDN_Lexid;

end;
