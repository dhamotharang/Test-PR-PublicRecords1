import _Control;
export LibraryUse := MODULE

/*
This module lets you control whether you are using ECL libraries.
Currently supports:
	NID.lib_PFirst
	AutoHeaderI.LIB_FetchI_Hdr_Indv
*/

/*
BEGIN ECL YOU ARE ENCOURAGED TO SANDBOX!!!!!!!!!!!!!!
*/

export ForceOff_AllLibraries := FALSE;
// export ForceOff_AllLibraries := TRUE;

//*** Libraries that are ON by default ***

export ForceOffOne_NID__lib_PFirst := FALSE;
// export ForceOffOne_NID__lib_PFirst := TRUE;

export ForceOffOne_AutoHeaderI__LIB_FetchI_Hdr_Indv := FALSE;
// export ForceOffOne_AutoHeaderI__LIB_FetchI_Hdr_Indv := TRUE;

export ForceOffOne_Risk_Indicators__LIB_InstantID_Function := FALSE;
// export ForceOffOne_Risk_Indicators__LIB_InstantID_Function := TRUE;

export ForceOffOne_Risk_Indicators__LIB_Boca_Shell_Function := FALSE;
// export ForceOffOne_Risk_Indicators__LIB_Boca_Shell_Function := TRUE;

export ForceOffOne_Models__LIB_RiskView_V40 := FALSE;
// export ForceOffOne_Models__LIB_RiskView_V40 := TRUE;

export ForceOffOne_Models__LIB_RiskView_V41 := FALSE;
// export ForceOffOne_Models__LIB_RiskView_V41 := TRUE;

export ForceOffOne_Models__LIB_RiskView_V50 := FALSE;
// export ForceOffOne_Models__LIB_RiskView_V50 := TRUE;

export ForceOffOne_Models__LIB_FraudAvisor_V20 := FALSE;
// export ForceOffOne_Models__LIB_FraudAvisor_V20 := TRUE;

//*** Libraries that are OFF by default ***

// export ForceOffOne_Business_Risk_BIP__LIB_Business_Shell := FALSE;
export ForceOffOne_Business_Risk_BIP__LIB_Business_Shell := TRUE;

// export ForceOffOne_AutoHeaderI__LIB_FetchI_Hdr_Biz := FALSE;
export ForceOffOne_AutoHeaderI__LIB_FetchI_Hdr_Biz := TRUE;

// cleaner library is shared between Thor and Roxie, so by default it should be OFF,
// so that no sandboxing would be required for the build jobs (dev and prod).
// At the same time it must be ON, when deploying queries from QA roxie repository.
export ForceOffOne_Address__LIB_Cleaning := _Control.ThisEnvironment.IsPlatformThor;

// eventually we'll create a library for these models, so we can put this toggle in library use as well
export ForceOff_Bocashell_Models := false;
// export ForceOff_Bocashell_Models := true;

/*
END ECL YOU ARE ENCOURAGED TO SANDBOX!!!!!!!!!!!!!!!
*/

export ForceOff_NID__lib_PFirst := ForceOff_AllLibraries OR ForceOffOne_NID__lib_PFirst;
export ForceOff_AutoHeaderI__LIB_FetchI_Hdr_Indv := ForceOff_AllLibraries OR ForceOffOne_AutoHeaderI__LIB_FetchI_Hdr_Indv;
export ForceOff_AutoHeaderI__LIB_FetchI_Hdr_Biz := ForceOff_AllLibraries OR ForceOffOne_AutoHeaderI__LIB_FetchI_Hdr_Biz;
export ForceOff_Risk_Indicators__LIB_InstantID_Function := ForceOff_AllLibraries OR ForceOffOne_Risk_Indicators__LIB_InstantID_Function;
export ForceOff_Risk_Indicators__LIB_Boca_Shell_Function := ForceOff_AllLibraries OR ForceOffOne_Risk_Indicators__LIB_Boca_Shell_Function;
export ForceOff_Models__LIB_RiskView_V40 := ForceOff_AllLibraries OR ForceOffOne_Models__LIB_RiskView_V40;
export ForceOff_Models__LIB_RiskView_V41 := ForceOff_AllLibraries OR ForceOffOne_Models__LIB_RiskView_V41;
export ForceOff_Models__LIB_RiskView_V50 := ForceOff_AllLibraries OR ForceOffOne_Models__LIB_RiskView_V50;
export ForceOff_Models__LIB_FraudAdvisor_V20 := ForceOff_AllLibraries OR ForceOffOne_Models__LIB_FraudAvisor_V20;
export ForceOff_Business_Risk_BIP__LIB_Business_Shell := ForceOff_AllLibraries OR ForceOffOne_Business_Risk_BIP__LIB_Business_Shell;
export ForceOff_Address__LIB_Cleaning := ForceOff_AllLibraries OR ForceOffOne_Address__LIB_Cleaning;


end;