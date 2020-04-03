IMPORT Data_Services, doxie;

EXPORT Constants := MODULE

		//Base/Input/Key Prefix
		EXPORT IN_PREFIX := '~prte::in::govdata';
		EXPORT FDIC_In := IN_PREFIX+'::fdic';
		EXPORT IRS_In := IN_PREFIX+'::irs';
		EXPORT Salestax_CA_In := IN_PREFIX+'::salestax_ca';
		EXPORT Salestax_IA_In := IN_PREFIX+'::salestax_ia';
		EXPORT Sec_Broker_In := IN_PREFIX+'::sec_broker';

		EXPORT BASE_PREFIX := '~prte::base::govdata';
		EXPORT FDIC_Base_Name := BASE_PREFIX+'::fdic';
		EXPORT IRS_Base_Name := BASE_PREFIX+'::irs';
		EXPORT Salestax_CA_Base_Name := BASE_PREFIX+'::salestax_ca';
		EXPORT Salestax_IA_Base_Name := BASE_PREFIX+'::salestax_ia';
		EXPORT Sec_Broker_Base_Name := BASE_PREFIX+'::sec_broker';
		
		EXPORT KEY_PREFIX				:= '~prte::key';
		EXPORT SALES_TAX_PREFIX			:= KEY_PREFIX+'::salestax::';
		EXPORT FDIC_PREFIX				:= KEY_PREFIX+'::fdic::';
		EXPORT IRSNONPROFIT_PREFIX		:= KEY_PREFIX+'::irsnonprofit::';
		EXPORT MS_WORKERS_COMP_PREFIX	:= KEY_PREFIX+'::ms_workers_comp::';
		EXPORT OR_WORKERS_COMP_PREFIX	:= KEY_PREFIX+'::or_workers_comp::';
		EXPORT SEC_BROKER_DEALER_PREFIX := KEY_PREFIX+'::sec_broker_dealer::';
																
		//Suffix
		EXPORT CA_STATE_SUFFIX	:= '::ca';
		EXPORT IA_STATE_SUFFIX	:= '::ia';
		EXPORT BDID_SUFFIX		:= '::bdid';
		EXPORT LINKIDS_SUFFIX	:= '::linkids';

		EXPORT CA_State_DBID_Suffix		:= CA_State_Suffix+BDID_SUFFIX;
		EXPORT CA_State_Linkids_Suffix 	:= CA_State_Suffix+LINKIDS_SUFFIX;
		EXPORT IA_State_DBID_Suffix		:= IA_State_Suffix+BDID_SUFFIX;
		EXPORT IA_State_Linkids_Suffix 	:= IA_State_Suffix+LINKIDS_SUFFIX;
				
		//Keys
		EXPORT Key_Salestax_CA_Bdid_Name		:= KEY_PREFIX+'::ca_sales_tax_bdid_'+doxie.Version_SuperKey;
		EXPORT Key_Salestax_CA_Bdid_Gen_Name	:= KEY_PREFIX+'::ca_sales_tax_bdid_@version@';
		
		EXPORT Key_Salestax_CA_Linkids_Name 	:= KEY_PREFIX+'::ca_sales_tax_linkids_'+doxie.Version_SuperKey;
		EXPORT Key_Salestax_CA_Linkids_Gen_Name	:= KEY_PREFIX+'::ca_sales_tax_linkids_@version@';
		
		EXPORT Key_Salestax_IA_Bdid_Name		:= KEY_PREFIX+'::ia_sales_tax_bdid_'+doxie.Version_SuperKey;
		EXPORT Key_Salestax_IA_Bdid_Gen_Name	:= KEY_PREFIX+'::ia_sales_tax_bdid_@version@';
		
		EXPORT Key_Salestax_IA_Linkids_Name 	:= KEY_PREFIX+'::ia_sales_tax_linkids_'+doxie.Version_SuperKey;
		EXPORT Key_Salestax_IA_Linkids_Gen_Name	:= KEY_PREFIX+'::ia_sales_tax_linkids_@version@';

		EXPORT Key_FDIC_Bdid_Name		:= KEY_PREFIX+'::govdata_fdic_bdid_'+doxie.Version_SuperKey;
		EXPORT Key_FDIC_Bdid_Gen_Name 	:= KEY_PREFIX+'::govdata_fdic_bdid_@version@';
		
		EXPORT Key_FDIC_Linkids_Name 		:= KEY_PREFIX+'::govdata_fdic_linkids_'+doxie.Version_SuperKey;
		EXPORT Key_FDIC_Linkids_Gen_Name 	:= KEY_PREFIX+'::govdata_fdic_linkids_@version@';
		
		EXPORT Key_Irsnonprofit_Bdid_Name			:= KEY_PREFIX+'::irs_nonprofit_bdid_'+doxie.Version_SuperKey;
		EXPORT Key_Irsnonprofit_Bdid_Gen_Name		:= KEY_PREFIX+'::irs_nonprofit_bdid_@version@';
		
		EXPORT Key_Irsnonprofit_Linkids_Name			:= KEY_PREFIX+'::irs_nonprofit_linkids_'+doxie.Version_SuperKey;
		EXPORT Key_Irsnonprofit_Linkids_Gen_Name		:= KEY_PREFIX+'::irs_nonprofit_linkids_@version@';
		
		EXPORT Key_ms_workers_comp_Bdid_Name		:= KEY_PREFIX+'::ms_workers_comp_bdid_'+doxie.Version_SuperKey;
		EXPORT Key_ms_workers_comp_Bdid_Gen_Name	:= KEY_PREFIX+'::ms_workers_comp_bdid_@version@';
		
		EXPORT Key_ms_workers_comp_Linkids_Name		:= KEY_PREFIX+'::ms_workers_comp_linkids_'+doxie.Version_SuperKey;
		EXPORT Key_ms_workers_comp_Linkids_Gen_Name	:= KEY_PREFIX+'::ms_workers_comp_linkids_@version@';
		
		EXPORT Key_or_workers_comp_Bdid_Name		:= KEY_PREFIX+'::or_workers_comp_bdid_'+doxie.Version_SuperKey;
		EXPORT Key_or_workers_comp_Bdid_Gen_Name	:= KEY_PREFIX+'::or_workers_comp_bdid_@version@';
		
		EXPORT Key_or_workers_comp_Linkids_Name		:= KEY_PREFIX+'::or_workers_comp_linkids_'+doxie.Version_SuperKey;
		EXPORT Key_or_workers_comp_Linkids_Gen_Name	:= KEY_PREFIX+'::or_workers_comp_linkids_@version@';
		
		EXPORT Key_sec_broker_dealer_Linkids_Name		:= KEY_PREFIX+'::sec_broker_dealer_linkids_'+doxie.Version_SuperKey;
		EXPORT Key_sec_broker_dealer_Linkids_Gen_Name	:= KEY_PREFIX+'::sec_broker_dealer_linkids_@version@';
		
END;