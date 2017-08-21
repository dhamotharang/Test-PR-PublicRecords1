import AMS,DEA,NPPES,Prof_License,ABMS,GSA,CLIA,NCPDP,ut;

Export key:=module
	r:={unsigned8 lnpid:=0,{AMS.Files().Base.Main.QA}};
	dAMS := dedup(dataset('~thor_data400::base::ams::20140224a::main',r,flat)(lnpid>0),lnpid,ams_id,all);
	iAMS:=index(dAMS,{lnpid},{ams_id},ut.foreign_prod+'thor_data400::key::ams::20140224::main::lnpid');
	export AMS_lnpid:=iAMS;
	export bld_AMS_lnpid:=buildindex(AMS_lnpid,'~thor_data400::key::ams::20140224::main::lnpid',update);

	r:={unsigned8 lnpid:=0,{dea.File_DEA}};
	dDEA := dedup(dataset('~thor_data400::base::dea_w20140305-154146a',r,flat)(lnpid>0),lnpid,DEA_REGISTRATION_NUMBER,all);
	iDEA:=index(dDEA,{lnpid},{DEA_REGISTRATION_NUMBER},ut.foreign_prod+'thor_data400::key::dea::20140303::lnpid');
	export DEA_lnpid:=iDEA;
	export bld_DEA_lnpid:=buildindex(DEA_lnpid,'~thor_data400::key::dea::20140303::lnpid',update);

	r:={unsigned8 lnpid:=0,{nppes.File_NPPES_Keybuild}};
	dNPPES := dedup(dataset('~thor_data400::keybuild::nppes_w20140306-180003a',r,flat)(lnpid>0),lnpid,NPI,all);
	iNPPES:=index(dNPPES,{lnpid},{NPI},ut.foreign_prod+'thor_data400::key::nppes::20140227::lnpid');
	export NPPES_lnpid:=iNPPES;
	export bld_NPPES_lnpid:=buildindex(NPPES_lnpid,'~thor_data400::key::nppes::20140227::lnpid',update);

	r:={unsigned8 lnpid:=0,{Prof_License.File_prof_license_base_AID}};
	dPL := dedup(dataset('~thor_data400::base::prof_licenses_aid_w20140304-212240a',r,flat)(lnpid>0,prolic_key<>''),lnpid,prolic_key,all);
	iPL:=index(dPL,{lnpid},{prolic_key},ut.foreign_prod+'thor_data400::key::prolicv2::20140304::lnpid');
	export PL_lnpid:=iPL;
	export bld_PL_lnpid:=buildindex(PL_lnpid,'~thor_data400::key::prolicv2::20140304::lnpid',update);

	r:={ABMS.Files().base.main.qa};
	dABMS := dedup(dataset('~thor_data400::base::abms::20140207a::main',r,flat)(lnpid>0,biog_number<>''),lnpid,biog_number,all);
	iABMS:=index(dABMS,{lnpid},{biog_number},ut.foreign_prod+'thor_data400::key::abms::20140207::main::lnpid');
	export ABMS_lnpid:=iABMS;
	export bld_ABMS_lnpid:=buildindex(ABMS_lnpid,'~thor_data400::key::abms::20140207::main::lnpid',update);

	r6:={unsigned8 lnpid:=0,{GSA.File_GSA_Base}};
	dGSA := dedup(dataset('~thor_data400::base::gsa_w20140306-041506a',r6,flat)(lnpid>0),lnpid,gsa_id,all);
	iGSA:=index(dGSA,{lnpid},{gsa_id},ut.foreign_prod+'thor_data400::key::gsa::20140306::lnpid');
	export GSA_lnpid:=iGSA;
	export bld_GSA_lnpid:=buildindex(GSA_lnpid,'~thor_data400::key::gsa::20140306::lnpid',update);

end;
// CLIA.Append_IDs
// thor_data400::key::clia::20140227::lnpid

// NCPDP.fAppend_ADLS
// thor_data400::key::ncpdp::20131209::lnpid


// JBello_stuff.key.bld_AMS_lnpid;
// JBello_stuff.key.AMS_lnpid;

// JBello_stuff.key.bld_DEA_lnpid;
// JBello_stuff.key.DEA_lnpid;

// JBello_stuff.key.bld_NPPES_lnpid;
// JBello_stuff.key.NPPES_lnpid;

// JBello_stuff.key.bld_PL_lnpid;
// JBello_stuff.key.PL_lnpid;

// JBello_stuff.key.bld_ABMS_lnpid;
// JBello_stuff.key.ABMS_lnpid;

// JBello_stuff.key.bld_GSA_lnpid;
// JBello_stuff.key.GSA_lnpid;