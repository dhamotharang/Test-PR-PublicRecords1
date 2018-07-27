/*
***************************************************************************************************************************************
PRTE2_Liens_Ins._Developer_Notes
***************************************************************************************************************************************

************************************************************************************************
1/19/17 - IDEA: if you want to run on HTHOR because everything is busy you can do this and run on HTHOR *********
		NO - Never got this working for anything but the spray
		optTargetCluster := 'thor50_dev02';
		BuildInFile := PRTE2_Liens_Ins.fSprays.fSpray_Party(CSVName,optTargetCluster);
			These common build process have a problem - either need to solve or just delete it and keep PromoteSupers version
			PRTE2_Common.Mac_SF_BuildProcess(newpartyData, Files.party_IN_Name, build_party_in,,TargetCluster);		// BUGGY
		Added logic to be able to specify a targetCluster and run on HTHOR (commented out or removed for now)
			BWR_Spray_Both_Files, BWR_Spray_Main, BWR_Spray_Party, fSprays - need to add back if debugged
************************************************************************************************

2/17/17 - Details on the High Priority Insurance product that is rushing this:
It reaches out to liensv2_services.lienssearchservicefcra in http://10.173.235.21:8002/ which is PRCT PROD
Gilbert Polo - is the Alpharetta developer who is doing the NCF changes on the insurance side.

For the moment both we and Boca code are referencing Cross_Module_Files for file naming conventions.
NOTE: We only need file info here for a) Spray/DeSpray and b) Our Base file

Here's the overview for this to work with the new Boca Build:
1. status is appended to the main spreadsheet - two fields filing_status & filing_status_desc
2. For both main and party - there are the following files.
	a. spray file - temporary - these should be removed right after spraying
	b. IN files - these are in the spreadsheet layout which isn't the Boca compatible layout.
			* Main has the two fields (which must be turned into a sub-dataset) plus CT reference fields
			* Party - normal layout plus CT reference fields.
			In Files created by PRTE2_Liens_Ins.fSprays (You can spray 1 file without changing the other)
	c. BASE files - Final Boca Compatible base files - created by PRTE2_Liens_Ins.proc_build_base
			Reads both IN file super files so you don't have to spray both each time, but uses latest to build base files
***************************************************************************************************************************************
Confirmed with Shannon:
We need to create unique filing_number values.
tmsid = keep first 2-3 initials (CA, MA,etc) + keep any record type (WRIT,CHSUP,etc) + our new filing_number

Aaron discussion:
TMSID: source / filing # / amout of lien / {state / county / [OKC Court code]} {translates to a specific court}
RMSID: source / filing # / amout of lien / state / county / [CJ=civil judge, ST=state tax lien]
***************************************************************************************************************************************

Notes from Shannon:
		Here is the TMSID/RMSID code which varies by source:
		CA_Federal
		self.TMSID := 'CA' + (string)INTFORMAT((integer)L.Initial_Filing_Number,14,1);
		self.RMSID := 'CR' + (string)INTFORMAT((integer)L.Initial_Filing_Number,14,1);

		Hogan 
		self.RMSID := 'HGR'+trim(L.CASENUMBER,left,right)+trim(L.AMOUNT,left,right)+trim(L.COURTID,left,right)+trim(L.FILETYPEID,left,right);  
		-	(There is some other logic if we are missing any of these fields, but this should capture most scenarios)
		self.TMSID := 'HG'+trim(L.CASENUMBER,left,right)+trim(L.AMOUNT,left,right)+trim(L.COURTID,left,right);

		The tricky thing with the above is that you probably won’t know what the courted or filetypeid is or even what to use as the base file just 
		contains the code descriptions.  But those codes can be found here is you need some samples to use:

		HGFiling_type   := DATASET('~thor_data400::in::liensv2::hg_filing_type_lkp', LiensV2_preprocess.Layouts_Hogan.filing_type_lkp,CSV(HEADING(0),SEPARATOR('\t'),TERMINATOR(['\n', '\r\n'])));
										
		//Court Description
		HGCourt_in        := DATASET('~thor_data400::in::liensv2::hg_court_id_lkp', LiensV2_preprocess.Layouts_Hogan.court_lookup,CSV(HEADING(0),SEPARATOR('\t'),TERMINATOR(['\n', '\r\n'])));

		Since this is just test data, you could leave those court/filing codes off and still be o.k., or maybe add a sequence number to the end.

		MA STATEWIDE WRITS/Child support/Welfare
		self.tmsid  := 'MA'+'WRIT'+l.filingnumber ;
		self.rmsid  := 'MA'+'WRIT'+l.filingnumber;

		or

		self.tmsid  := 'MA'+'CHSUP'+l.filingnumber;
		self.rmsid  := 'MA'+'CHSUP'+l.filingnumber;

		or

		self.tmsid  := 'MA'+'WEFL'+l.filingnumber;
		self.rmsid  := 'MA'+'WEFL'+l.filingnumber;

		I don’t have any others as other sources are historical so they are direct mappings with no transformations done.

		Some code lookups happen in LiensV2_preprocess.Code_lkps
		Filing type code is in thor_data400::in::liensv2::hg_filing_type_lkp

*/