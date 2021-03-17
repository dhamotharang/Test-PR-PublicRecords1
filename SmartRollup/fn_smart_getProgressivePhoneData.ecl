IMPORT doxie,iesp,PersonReports, Royalty, gateway, std;

EXPORT fn_smart_getProgressivePhoneData :=  MODULE

   SHARED AddPhoneHRICodes( dataset(personReports.layouts.PhoneHRILayout) tmpPhoneHRI_Input,
                                                             doxie.IDataAccess mod_access) := FUNCTION
                                                                                                                                                                                            
			              maxHriPer_value	:= iesp.Constants.MaxCountHRI;	// needed for the macro 1 line below		   
                              doxie.mac_addHRIPhone(tmpPhoneHRI_Input,TmpPhoneHRI, mod_access);
                              return(TmpPhoneHRI);
        END;                              
                       
         EXPORT ProgressivePhoneResults( dataset (doxie.layout_references) dids                         
                                                                        ,doxie.IDataAccess mod_access
                                                                        ,PersonReports.IParam._smartlinxreport  mod_smartlinx) := FUNCTION

                    ProgPhone_mod := MODULE(doxie.Iparam.ProgressivePhoneParams)
                EXPORT DATASET(Gateway.Layouts.Config) Gateways_In := DATASET([], Gateway.Layouts.Config);
		     EXPORT BOOLEAN 	 IncludePhonesFeedback			:= FALSE;
                EXPORT BOOLEAN 	 type_a_with_did 						:= FALSE;
                EXPORT BOOLEAN 	 useNeustar 								:= FALSE;
                EXPORT BOOLEAN 	 default_sx_match_limit 		:= FALSE;
                EXPORT BOOLEAN 	 isPFR 											:= FALSE;        
                EXPORT STRING   ScoreModel                       := mod_smartlinx.ScoreModel; 
                EXPORT UNSIGNED1 MaxNumAssociate            := 0;
		     EXPORT UNSIGNED1 MaxNumAssociateOther       := 0;
		     EXPORT UNSIGNED1 MaxNumFamilyOther          := 0;
		     EXPORT UNSIGNED1 MaxNumFamilyClose          := 0;
		     EXPORT UNSIGNED1 MaxNumParent            		:= 0;
		     EXPORT UNSIGNED1 MaxNumSpouse            		:= 0;
		     EXPORT UNSIGNED1 MaxNumSubject            	:=  mod_smartlinx.maxNumSubject; 
		     EXPORT UNSIGNED1 MaxNumNeighbor            	:= 0;
		     EXPORT BOOLEAN	 ReturnPhoneScore						:= FALSE;
	          EXPORT BOOLEAN 	 UsePremiumSource_A 				:= mod_smartlinx.UsePremiumSourceA and 
                                                                                                                        ~doxie.compliance.isPhoneMartRestricted(mod_smartlinx.DataRestrictionMask) and
                                                                                                                        mod_access.isValidGLB();
		     EXPORT INTEGER 	 PremiumSource_A_limit 			:= mod_smartlinx.PremiumSourceAlimit; 
	    	     EXPORT BOOLEAN 	 RunRelocation 							:= FALSE;            
            END;              
              // call to phone shell.  Version 8 of phone shell is ensured to be used by passing in the 'Common_Score' model
              //
              PHonesV3 := doxie.fn_progressivePhone.ByDidonly(dids, progphone_mod);                    
              Phones :=    CHOOSEN(PROJECT(PhonesV3.PhoneInfo, TRANSFORM(iesp.smartlinxReport.t_SLRBestPhone,                                                                                                           
                             SELF.UniqueID := (STRING) LEFT.acctno;
                             SELF.Name.last := LEFT.Subj_last; 
                             SELF.Name.MIddle := LEFT.Subj_Middle;
                             SELF.Name.first := LEFT.subj_first;
                             SELF.Phone10 := LEFT.Subj_Phone10;                                
                             SELF.DateFirstSeen := iesp.ECL2ESP.toDateYM((unsigned3)LEFT.subj_date_first);
                             SELF.DateLastSeen := iesp.ECL2ESP.toDateYM((unsigned3)LEFT.subj_date_last);                   
                             SELF.address := iesp.ECL2ESP.SetAddress(LEFT.prim_name, LEFT.prim_range, LEFT.predir, LEFT.postdir,LEFT.addr_suffix,
																        LEFT.unit_desig, LEFT.sec_range, LEFT.p_city_name,LEFT.st, LEFT.zip5, 
                                                                                                       '','','','','',''),               
                             SELF.CarrierName := LEFT.Meta_Carrier_Name;                              
                             SELF.TypeFlag := LEFT.Meta_ServLine_Type; // LEFT.Subj_phone_type;
                             SELF.NewType:= TRIM(LEFT.subj_phone_type_new,LEFT,RIGHT);                                                 
                             SELF.vendorId :=  LEFT.Vendor;                                                    
                             SELF.ListedName :=  LEFT.subj_name_dual;
                                     
                             personReports.layouts.PhoneHRILayout  addPhoneHRI() := transform                   
                                 SELF.phone := LEFT.Subj_Phone10;
	                            SELF.zip := LEFT.zip5;
	                            SELF.lname := LEFT.Subj_last; 
	                            SELF.prim_name :=  LEFT.prim_name;
	                            SELF.prim_range :=  LEFT.prim_range;
	                            SELF.st := LEFT.st;
	                            SELF.sec_range := left.sec_range;
	                            SELF.predir :=  LEFT.predir;
	                            SELF.postdir := LEFT.postdir;
                                 SELF.hri_Phone := DATASET ([], Risk_Indicators.Layout_Desc);
                                 SELF := [];
                              END;   
                              AddHRIPhoneIndicators := false; // std.str.toUpperCase(LEFT.Meta_ServLine_Type) = 'LANDLINE';
                              tmpPhoneHRI_Input  := IF (AddHriPhoneIndicators, DATASET([AddPhoneHRI()]),
                                                                      DATASET([],personReports.layouts.PhoneHRILayout));                                                                                                             
                                                                                             			                                                                                                      
                              TmpPhoneHRI := IF (AddHRIPhoneIndicators, AddPhoneHRICodes(tmpPhoneHRI_Input, mod_access),
                                                                               DATASET([],personReports.layouts.PhoneHRILayout));  
                            SELF.HighRiskIndicators  := CHOOSEN(PROJECT(tmpPhoneHRI[1].hri_phone,TRANSFORM(iesp.share.t_RiskIndicator,
                                                                                                 SELF.RiskCode:=LEFT.hri,
                                                                                                  SELF.Description:=LEFT.desc)),iesp.Constants.MaxCountHRI);                                                                                                                    
                   //note to reference   iesp.transform_progressive_phones to set particular fields.
                   SELF := [];
                   )), iesp.Constants.BR.MaxPhonesPlus);                   
             return Phones;
         END;
         
           EXPORT CalculateBestSmartLinxRecPhoneRoyalties( DATASET(iesp.smartlinxreport.t_SLRBestPhone) ds_in
                                                                                                          ,STRING2 source) := FUNCTION                                                                                                      
             Royalty.RoyaltyEFXDataMart.MAC_GetWebRoyalties(ds_in, ds_equifax_royalties, NewType, source); 
              ds_Royalties               :=  ds_equifax_royalties;                                                                             
              RETURN ds_Royalties;
         END;

END;
