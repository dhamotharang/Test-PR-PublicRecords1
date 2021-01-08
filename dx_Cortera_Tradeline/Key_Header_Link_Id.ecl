IMPORT $, doxie, data_services;

rec := $.Layouts.Layout_Tradeline_Base;

EXPORT Key_Header_Link_Id := INDEX({rec.link_id,rec.account_key,rec.ar_date}, {rec}, $.Keynames().Tradeline_Link_Id.qa);

