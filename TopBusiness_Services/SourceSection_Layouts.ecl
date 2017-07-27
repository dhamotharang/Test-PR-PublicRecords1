import BIPV2, iesp;

export SourceSection_Layouts := module;

 export rec_SourceCount := record
    BIPV2.IDlayouts.l_header_ids;
		string50 category_desc;
    unsigned3 category_doccount;
		TopBusiness_Services.Layouts.rec_input_ids_wSrc.Section;
		TopBusiness_Services.Layouts.rec_input_ids_wSrc.Source;
	end;

  export rec_SourceChild_Item := record 
		//TopBusiness_Services.Layouts.rec_input_ids_wSrc.acctno; //???
    BIPV2.IDlayouts.l_header_ids;
		//TopBusiness_Services.Layouts.rec_input_ids_wSrc.IdType; //???
		//TopBusiness_Services.Layouts.rec_input_ids_wSrc.IdValue; //???
		TopBusiness_Services.Layouts.rec_input_ids_wSrc.Section;
		TopBusiness_Services.Layouts.rec_input_ids_wSrc.Source;
	  //TopBusiness_Services.Layouts.rec_input_ids_wSrc.Address; //???
	  //TopBusiness_Services.Layouts.rec_input_ids_wSrc.Name; //???
	end;

  export rec_SourceParent := record
    BIPV2.IDlayouts.l_header_ids;
		string50  category_name;
    unsigned3 category_doccount;
		dataset(rec_SourceChild_Item) SourceDocs
		        {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)}; 
  end;

  export rec_ids_plus_SourceCategory := record
    BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_TopBusinessSourceCategory;
	end;		

  export rec_ids_plus_SourceSection := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
    BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_TopBusinessSourceSection;
	end;		

  export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.topbusinessReport.t_TopBusinessSourceSection;
	end;

end;
/* iesp.topbusiness_share
export topbusiness_share := MODULE
 export t_TopBusinessSourceDocInfo := record
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string20 IdType {xpath('IdType')};
	string100 IdValue {xpath('IdValue')};
	string25 Section {xpath('Section')};
	string2 Source {xpath('Source')};
	share.t_Address Address {xpath('Address')};
	share.t_NameAndCompany Name {xpath('Name')};
 end;
end;
*/
/* iesp.TopBusinessReport
...
export t_TopBusinessSourceCategory := record
	string50 Name {xpath('Name')};
	unsigned DocCount {xpath('DocCount')};
	dataset(topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {xpath('SourceDocs/SourceDoc'), MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
end;
		
export t_TopBusinessSourceSection := record
	unsigned AllSourcesCount {xpath('AllSourcesCount')};
	dataset(topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {xpath('SourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ALLSRCDOC_RECORDS)};
	dataset(t_TopBusinessSourceCategory) Categories {xpath('Categories/Category'), MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SOURCE_RECORDS)};
end;
...
*/