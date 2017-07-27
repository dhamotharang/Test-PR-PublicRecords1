import iesp;
export ParentSection_Layouts := module

	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
		string1 BusinessReportFetchLevel;
	end;
	
	export rec_Input := record
		string25 acctno;
		iesp.share.t_businessIdentity;
	end;
	
	export relationship_rec := record
		string25 SubjectRole;
		string25 RelativeRole;
	end;
	
 // take out all the // lines after iesp.topbusiness.t_TopBusinessRelativeRec is updated.
 // is updated.
	export rec_relative := record	 
	iesp.share.t_BusinessIdentity;
		iesp.share.t_BusinessIdentity BusinessIds;
		dataset(relationship_rec) relationships //
		       {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_RELATIONSHIP_RECORDS)};	
		string2 CompanyNameSource;//
	string50 CompanyNameSourceDocId;//
	string2 TINSource;//
	string9 TIN;//
	string2 URLSource; // 
	string80 URL;//
	string2 Source;//
	string50 SourceDocId;//
	string10 SourceParty;//
	string120 CompanyName;
	iesp.share.t_Address Address;
	iesp.share.t_name Name;
	string12 uniqueID;
	iesp.share.t_PhoneInfo PhoneInfo;
	string10 phone; // used to set the wirelessIndicator field
	string1 PhoneType;
	boolean ActiveEDA;
	boolean Disconnected;
	string1 WirelessIndicator;
	boolean HasDerog;//
	string3 timezone;
	dataset (iesp.topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {xpath('SourceDocs/SourceDoc'), 
			MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
	end;
	
	export rec_tmpFinal := record
		string25 acctno;
		iesp.share.t_businessIdentity;
		unsigned6 orig_ultid; 
		unsigned6 orig_orgid; 
		unsigned6 orig_seleid;
		unsigned6 orig_proxid;
	  unsigned6 orig_powid; 
		unsigned6 orig_empid; 
		unsigned6 orig_dotid;
		dataset(rec_relative) Parents {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PARENT_RECORDS)};
		dataset (iesp.topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {xpath('SourceDocs/SourceDoc'), 
			MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)}; 
	end;
	
	export rec_final := record
	   string25 acctno;
		 iesp.TopBusinessReport.t_TopBusinessParentSection;
  end;
	
end;
