/*
ssi_link := record
	string ssi_link_href {xpath('link/@href')};
	string ssi_link_rel {xpath('link/@rel')};
	layouts.layout_link entityReference {xpath('link')};
end;
*/
ssiset_link := record
	string ssiset_link_href {xpath('ssiSet/link/@href')};
	string ssiset_link_rel {xpath('ssiSet/link/@rel')};
end;


export layout_ssiset := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource {xpath('@resource')};
	string source {xpath('@source')};
	string status	 {xpath('status')};		
	string presence_link_href {xpath('presence/link/@href')};
	string presence_link_rel {xpath('presence/link/@rel')};
	dataset(layouts.layout_link) ssi_reference {xpath('ssis/ssi/link')};
	dataset(ssiset_link) extendsSSI {xpath('extendsSSISet')};
	string validationDate {xpath('validationDate')};
	string validationDate_accuracy {xpath('validationDate/@accuracy')};
	string renewalDate {xpath('renewalDate')};
	string renewalDate_accuracy {xpath('renewalDate/@accuracy')};
end;
