/* ***********************************************************************************************************
PRTE2_X_Ins_AlphaRemote.Files

*********************************************************************************************************** */
IMPORT PRTE2_Common,_control;

EXPORT Files := MODULE

      // Boca doesn't appear to keep these in Data_Services code - so I'll have to create them here using _control.IPAddress
      export aforeign_prod 				:= '~foreign::' + _control.IPAddress.aprod_thor_dali + '::';	
      export aforeign_Dev 				:= '~foreign::' + _control.IPAddress.adataland_dali + '::';	
      SHARED removeTildeFN(STRING fn2)	:= REGEXREPLACE('~',fn2,'', NOCASE);
      EXPORT Add_Foreign_aprod(STRING fn) := aforeign_prod+removeTildeFN(fn);
      EXPORT Add_Foreign_aDev(STRING fn) := aforeign_Dev+removeTildeFN(fn);

      EXPORT Reserved_VINS_Name := Add_Foreign_aDev('~thor::base::customertest::data_gathering::ALL_CT_VINs_Reserved');

      EXPORT ALL_CT_VINs_RESERVED_DS	:= DATASET(Reserved_VINS_Name,Layouts.VIN_Simple_Layout,THOR);		

      EXPORT TelematicsII_SF	:= Add_Foreign_aDev('~thor::base::CT::TelematicsII::Telematics_Quick_Data');
      EXPORT Quick_TelematicsII_DS	:= DATASET(TelematicsII_SF, Layouts.Quick_Telematics2, THOR);

END;