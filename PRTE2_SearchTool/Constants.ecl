import data_services, _Control;
EXPORT Constants := Module
  shared prefix := if(_Control.ThisEnvironment.Name = 'Dataland', Data_Services.foreign_prod, '~');
	Export Key_Business_Header_Contacts_BDID := prefix + 'prte::key::business_header::20140206a::contacts::bdid';
	Export Key_BDID_PL := prefix 	+ 'prte::key::business_header::20140206a::search::bdid.pl';
	Export Key_Linkids := prefix 	+ 'prte::key::bipv2::business_header::20160725::linkids';
	Export Key_Business_Header_Contacts  := prefix + 'prte::key::business_header::20140206a::contacts::bdid';
	Export Key_BipV2_Contacts := prefix + 'prte::key::bipv2::business_header::20160718::contact_linkids';
	Export FCRA_Header := prefix +'prte::key::fcra::header::qa::data';
	Export File_Person_Header := prefix +'prte::base::header';
	Export SearchTool_Prefix := '~prte::key::searchtool::';
	Export Key_Business_Header_Relatives_BDID := prefix + 'prte::key::business_header::20140206a::relatives::bdid1';
	Export Key_SuperGroup_Bdid := prefix + 'prte::key::business_header::20140206a::supergroup::bdid';
	Export Key_BH_Best := prefix + 'prte::key::business_header::20140206a::best::filepos.data';
	Export Key_Bipv2_seleid_relative := prefix + 'prte::key::bipv2_seleid_relative::20160725::seleid::rel::assoc';
	Export Key_BipV2_Industry := prefix + 'prte::key::bipv2::20160725::industry_linkids';
	Export Key_Best_Linkids := prefix + 'prte::key::bipv2_best::20160725::linkids';
End;