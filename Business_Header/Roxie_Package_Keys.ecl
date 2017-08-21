import aca,risk_indicators,doxie_cbrs,govdata,paw,EDA_VIA_XML,Marketing_Best,Business_Header_SS,Business_Risk;

export Roxie_Package_Keys :=
module

	export acainstitutions_keys	:= 
	module
	
		export addr := ACA.key_aca_addr;
	
	end;

	export addressHRI_keys			:=  
	module
	
		export Address_To_Sic						:= Risk_Indicators.Key_HRI_Address_To_Sic					;
	  export Sic_Zip_To_Address				:= Risk_Indicators.Key_HRI_Sic_Zip_To_Address			;
		export Address_To_Sic_filtered	:= Risk_Indicators.Key_HRI_Address_To_Sic_filtered;

	end;
	        
	export businessbest_keys			:=   // source is in these
	module
	
		export	BDID							:= Marketing_Best.Key_Marketing_Best_BDID						 	;
		export	BDID_MrktRes			:= Marketing_Best.Key_Marketing_Best_BDID_MrktRes			;
		export	MrkTitle_BDID_DID	:= Marketing_Best.Key_Best_MrkTitle_BDID_DID					;
		export	BDID_DID_MrktRes	:= Marketing_Best.Key_Best_MrkTitle_BDID_DID_MrktRes	;
	
	end;

	export Business_keys 				:=
	module
	
		export SuperGroup_GroupID 			:= Business_Header.Key_BH_SuperGroup_GroupID	;
		export SuperGroup_BDID					:= Business_Header.Key_BH_SuperGroup_BDID			;

		export Contacts_BDID						:= Business_Header.Key_Business_Contacts_BDID									;	//source in it
		export Company_Title						:= Business_Header.Key_Company_Title													;
		export Contacts_State_LFName 		:= Business_Header.Key_Business_Contacts_State_LFName					;
		export Contacts_State_City_Name	:= Business_Header.Key_Prep_Business_Contacts_State_City_Name	;
		export Contacts_FP 							:= Business_Header.Key_Business_Contacts_FP										;	//source in it
		export Contacts_DID							:= Business_Header.Key_Business_Contacts_DID									;
		export Contacts_SSN 						:= Business_Header.Key_Business_Contacts_SSN									;
		export BDID_relsByContact				:= doxie_cbrs.key_BDID_relsByContact													;
                                                                         
		export BH_Header_Words							:= Business_Header_SS.Key_Prep_BH_Header_Words							;	
		export BH_BDID_City_Zip_Fein_Phone	:= Business_Header_SS.Key_Prep_BH_BDID_City_Zip_Fein_Phone	;	
		export BH_Header_Words_Metaphone		:= Business_Header_SS.Key_BH_Header_Words_Metaphone					;	
                                                                         
		export BH_Phone											:= Business_Header_SS.Key_Prep_BH_Phone							;
		export BH_FEIN											:= Business_Header_SS.Key_Prep_BH_FEIN							;
		export BH_CompanyName								:= Business_Header_SS.Key_Prep_BH_CompanyName				;
		export BH_CompanyName_Unlimited			:= Business_Header_SS.Key_BH_CompanyName_Unlimited	;
		export BDID_NameVariations					:= Doxie_cbrs.key_BDID_NameVariations               ;
		export BH_BDID_pl										:= Business_Header_SS.Key_BH_BDID_pl                ;	//source in it
		export BH_Addr_pr_pn_zip						:= Business_Header_SS.Key_Prep_BH_Addr_pr_pn_zip    ;
		export BH_Addr_pr_pn_sr_st					:= Business_Header_SS.Key_Prep_BH_Addr_pr_pn_sr_st  ;
		export SIC_Code											:= Business_Header.Key_Prep_SIC_Code                ;
		export addr_bdid										:= doxie_cbrs.key_addr_bdid                       	;
		export ZipPRLName										:= Business_Header.Key_ZipPRLName                   ;
		export Business_Header_RCID					:= Business_Header.Key_Business_Header_RCID         ;
		export BH_Best											:= business_header.Key_BH_Best                    	;
		export BH_Best_KnowX								:= Business_Header.Key_BH_Best_KnowX                ;
		export Business_Relatives						:= business_header.Key_Business_Relatives           ;
		export Business_Relatives_Group			:= business_header.Key_Business_Relatives_Group     ;
		export Risk_bdid_table							:= Business_Risk.key_bdid_table							        ;
		export Risk_fein_table							:= Business_Risk.key_fein_table							        ;
		export Risk_groupid_cnt							:= Business_Risk.key_groupid_cnt						        ;
		export Risk_BH_Fein									:= Business_Risk.Key_BH_Fein								        ;
		export Risk_BH_BDID_Phone						:= Business_Risk.Key_BH_BDID_Phone					        ;
		export Risk_Bus_Cont_DID_2_BDID			:= Business_Risk.Key_Bus_Cont_DID_2_BDID		        ;
		export Risk_BDID_risk_table					:= Business_Risk.key_BDID_risk_table				        ;
		export Risk_Business_Header_Address	:= Business_Risk.Key_Business_Header_Address        ;	//source in it
		export bizword_frequency						:= EDA_VIA_XML.Key_bizword_frequency               	;
		export BDL2_BDID										:= Business_Header.Key_BDL2_BDID		                ;
		export BDL2_BDL											:= Business_Header.Key_BDL2_BDL			                ;
		export BDL2_GroupId									:= Business_Header.Key_BDL2_GroupId	               	;
		
		export key_Address_qa								:= business_header.RoxieKeys().NewFetch.key_Address_qa		;
		export key_Fein_qa									:= business_header.RoxieKeys().NewFetch.key_Fein_qa				;
		export key_Name_qa									:= business_header.RoxieKeys().NewFetch.key_Name_qa				;
		export key_Phone_qa									:= business_header.RoxieKeys().NewFetch.key_Phone_qa			;
		export key_Stcityname_qa						:= business_header.RoxieKeys().NewFetch.key_Stcityname_qa	;
		export key_Stname_qa								:= business_header.RoxieKeys().NewFetch.key_Stname_qa			;
		export key_Street_qa								:= business_header.RoxieKeys().NewFetch.key_Street_qa			;
		export key_Zip_qa										:= business_header.RoxieKeys().NewFetch.key_Zip_qa				;
                                    		
		export bh_commercial_sic						:= Business_Header.key_commercial_SIC_Zip									;
	end;                           
	
	export PawV2_Keys :=
	module

		export did				:= paw.Key_did			;
		export bdid				:= paw.Key_bdid			;
		export contactID	:= paw.Key_contactID;		// has source in it
		export autokeys		:= true							;
	
	end;
	
	export Govdata_Keys :=
	module

		export ca_sales_tax_bdid			:= 	govdata.key_ca_sales_tax_bdid				;
		export IA_SalesTax_BDID				:= 	govdata.Key_IA_SalesTax_BDID				;
		export fdic_bdid							:= 	govdata.key_fdic_bdid								;
		export FL_FBN_BDID						:= 	govdata.Key_FL_FBN_BDID							;
		export FL_NonProfit_BDID			:= 	govdata.key_FL_NonProfit_BDID				;
		export gov_phones_bdid				:= 	govdata.key_gov_phones_bdid					;
		export IRS_NonProfit_BDID			:= 	govdata.Key_IRS_NonProfit_BDID			;
		export ms_workers_comp_BDID		:= 	govdata.key_ms_workers_comp_BDID		;
		export or_workers_comp_bdid		:= 	govdata.key_or_workers_comp_bdid		;
		export sec_broker_dealer_BDID	:= 	govdata.key_sec_broker_dealer_BDID	;
          
	end;

end;