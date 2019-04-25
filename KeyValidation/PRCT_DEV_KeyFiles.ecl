EXPORT PRCT_DEV_KeyFiles := module 

import Seed_Files ,Data_Services, Doxie, ut;

//Export Attribute Key_Instantid1 //
d :=  seed_files.file_InstantID;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;

newtable := table(d,newrec);

 key_InstantID := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	'~thor_data400::key::testseed::qa::instantid');


//Seed_Files.Key_InstantID
Export Key_Instantid1 := key_InstantID;
//Seed File Riskview
Export Key_RiskView2 := Seed_Files.Key_RiskView2; 

//Seed File Fraud Point

Export Key_FraudPoint := Seed_Files.Key_FraudPoint;
export key_BInstantID  := Seed_Files.key_BInstantID ;


//Seed File FLEXID
export key_FLEXID  := Seed_Files.Key_FlexID ;

// Seed file leadintegrityattributes
export key_leadintegrityattributes := Seed_Files.Key_LeadIntegrityAttributes;
 
 
// Seed file smallbusiness attributes analytics
export key_SmallBusinessAnalytics := seed_files.key_SmallBusinessAnalytics;

//seed file AML Risk attributes
export key_AMLRiskAttributesBusnV2 := seed_files.key_AMLRiskAttributesBusnV2;

// BIID_v2 keys
 export key_BIID20keypart1 := Seed_Files.BIID20_keys.BIID20keypart1;
 
 export key_BIID20keypart2 := Seed_Files.BIID20_keys.BIID20keypart2;
 
 export key_BIID20keypart3 := Seed_Files.BIID20_keys.BIID20keypart3;
  
 //profile booster
 export Key_ProfileBooster := Seed_files.Key_ProfileBooster;
 
 //RV attributes 
 export Key_RVAttributes :=  seed_files.Key_RVAttributes;
 
 //Small business financial exchange
 export key_SmallBusFinancialExchange := seed_files.key_SmallBusFinancialExchange;

//AMLriskattributes
export key_AMLRiskAttributesV2  := seed_files.key_AMLRiskAttributesV2;

//AMLriskattributesV1
export Key_AMLRiskAttributes  := seed_files.Key_AMLRiskAttributes;

//AML Risk attributes Busn V1
export Key_AMLRiskAttributesBusn := seed_files.Key_AMLRiskAttributesBusn;

//BusinessDefender
export key_BusinessDefender:=seed_files.key_BusinessDefender;

//redflags
export key_redflags:=seed_files.key_redflags;

// RV_Attributes
// export key_RVAttributes:=Seed_Files.Key_RVAttributes;

// RV_Scores
export key_RiskView:=Seed_Files.Key_RiskView;

// SBFE Models
EXPORT key_SmallBusModels := Seed_Files.key_SmallBusModels;

// SBFE Attributes
EXPORT key_SBFEAttributes :=Seed_Files.key_SmallBusFinancialExchange;

// OrderScoring
export Key_OS :=Seed_Files.Key_OS;

// OrderScoring_Att
export Key_OSAttributes :=Seed_Files.Key_OSAttributes;

// ChargeBackDefender
export Key_CBD :=Seed_Files.Key_CBD;

// ChargeBackDefender_Attr
export Key_CBDAttributes :=Seed_Files.Key_CBDAttributes;

// BS_SvcsAddrHistory
export Key_BS_Services :=Seed_Files.Key_BS_Services;

// PhoneHistoryRpt
export Key_FCRA_GongHistory :=Seed_Files.Key_FCRA_GongHistory;

// ForeClosureVacancy_Interactive
export key_FOVInteractive :=Seed_Files.key_FOVInteractive;

// ForeClosureVacancy_Renewal
export key_FOVRenewal :=Seed_Files.key_FOVRenewal;

// FraudDefender
export key_frauddefender :=Seed_Files.key_frauddefender;

// HealthCareAttributes
export Key_HealthCareAttributes :=Seed_Files.Key_HealthCareAttributes;

// Identifier2
export Key_Identifier2 :=Seed_Files.Key_Identifier2;

// Fraud Attributes 
export Key_FDAttributes :=Seed_Files.Key_FDAttributes;

// IID Intl GG2
export Key_IntlIID_GG2 :=Seed_Files.Key_IntlIID_GG2;

// LNSamllBusinessScore
export Key_LNSmallBusiness :=Seed_Files.Key_LNSmallBusiness;

// RiskviewDerogsReport
export Key_RVderogs :=Seed_Files.Key_RVderogs;

// Verification of Occupancy
export Key_VerificationOfOccupancy :=Seed_Files.Key_VerificationOfOccupancy;

// BIIDV2_1
export Key_BIIDV2_1 :=Seed_Files.BIID20_keys.BIID20keypart1;

// BIIDV2_2
export Key_BIIDV2_2 :=Seed_Files.BIID20_keys.BIID20keypart2;

// BIIDV2_3
export Key_BIIDV2_3 :=Seed_Files.BIID20_keys.BIID20keypart3;

// SBFE Attributes
// export Key_SBFEAttributes :=Seed_Files.key_SmallBusFinancialExchange;

end;