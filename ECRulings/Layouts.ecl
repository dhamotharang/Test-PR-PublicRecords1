export Layouts := module ;

	export Competition:=record
        string 		DartID;
        string 		DateAdded;
        string 		DateUpdated;
        string 		Website;
        string 		State;
        string 		EUID;
        string 		PolicyArea;
        string 		CaseNumber;
        string 		MemberState;
        string 		LastDecisionDate;
        string 		Title;
        string 		BusinessName;
        string 		Region;
        string 		PrimaryObjective;
        string 		AidInstrument;
        string 		CaseType;
        string 		DurationDateFrom;
        string 		DurationDateTo;
        string 		NotificationRegistrationDate;
        string 		DGResponsible;
        string      RelatedCaseNumber1;
        string 		RelatedCaseInformation1;
        string 		RelatedCaseNumber2;
        string 		RelatedCaseInformation2;
        string 		RelatedCaseNumber3;
        string 		RelatedCaseInformation3;
        string 		RelatedCaseNumber4;
        string 		RelatedCaseInformation4;
        string 		RelatedCaseNumber5;
        string 		RelatedCaseInformation5;
        string 		ProvisionalDeadlineDate;
        string 		ProvisionalDeadlineArticle;
        string 		ProvisionalDeadlineStatus;
        string 		Regulation;
        string 		RelatedLink;
	end;
	
	export DecisionPublication	:=record
        string 		DecPubID;
        string 		EUID;
        string 		DartID;
        string 		DecisionDate;
        string 		DecisionArticle;
        string 		DecisionDetails;
        string 		PressRelease;
        string 		PressReleaseDate;
        string 		PublicationJournalDate;
        string 		PublicationJournal;
        string 		PublicationJournalEdition;
        string 		PublicationJournalYear;
        string 		PublicationPriorJournal;
        string 		PublicationPriorJournalDate;
	end;
	
	export EconomicActivity:=record
		string   	EconActID;
		string   	EUID;
		string   	DartID;
		string   	EconomicActivity;
	end;
	
	export	EventDocument:=record
	string   	CompEventID;
	string   	EUID;
	string   	DartID;
	string   	EventDate;
	string   	EventDocType;
	string   	EventDocument;

end;
 export competition_DecisionPublication:=record
   competition;
   DecisionPublication-euid-dartid;
   end;
	


export  comp_DeciPub_EconomicAct:=record
competition_DecisionPublication;
EconomicActivity-euid-dartid;
   end;
export comp_DeciPub_EconomicAct_Eventdoc:=record	
		comp_DeciPub_EconomicAct;
		Eventdocument-euid-dartid;
		unsigned6 did:= 0;
		unsigned6 bdid:= 0;
		string dt_vendor_first_reported;
		string dt_vendor_last_reported;
		string dt_first_seen;
		string dt_last_seen;
end;   

export Clean_comp_DeciPub_EconomicAct_Eventdoc:=record	
		comp_DeciPub_EconomicAct_Eventdoc;
		string EU_country_code;
end;   
   end;