import _validate;
export File_cleaned(string pVersion) := function

	File_in:= ECRulings.File_Joined;
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
	ECRulings.Layouts.comp_DeciPub_EconomicAct_Eventdoc trans_clean(ECRulings.Layouts.comp_DeciPub_EconomicAct_Eventdoc l):=transform 
		self.Website  										:=trimUpper(l.Website);
		self.State  											:=trimUpper(l.State);
		self.PolicyArea  									:=trimUpper(l.PolicyArea);
		self.Region  											:=trimUpper(l.Region);
		self.PrimaryObjective  						:=trimUpper(l.PrimaryObjective);
		self.AidInstrument  							:=trimUpper(l.AidInstrument);
		self.CaseType  										:=trimUpper(l.CaseType);
		self.RelatedCaseNumber1  					:=trimUpper(l.RelatedCaseNumber1);
		self.RelatedCaseInformation1  		:=trimUpper(l.RelatedCaseInformation1);
		self.RelatedCaseNumber2  					:=trimUpper(l.RelatedCaseNumber2);
		self.RelatedCaseInformation2  		:=trimUpper(l.RelatedCaseInformation2);
		self.RelatedCaseNumber3  					:=trimUpper(l.RelatedCaseNumber3);
		self.RelatedCaseInformation3  		:=trimUpper(l.RelatedCaseInformation3);
		self.RelatedCaseNumber4  					:=trimUpper(l.RelatedCaseNumber4);
		self.RelatedCaseInformation4  		:=trimUpper(l.RelatedCaseInformation4);
		self.RelatedCaseNumber5  					:=trimUpper(l.RelatedCaseNumber5);
		self.RelatedCaseInformation5  		:=trimUpper(l.RelatedCaseInformation5);
	  self.DecisionArticle  						:=trimUpper(l.DecisionArticle);//---AlphaNumeric
	  self.DecisionDetails  						:=trimUpper(l.DecisionDetails);
	  self.PressRelease  								:=trimUpper(l.PressRelease);//-----AlphaNumeric
	  self.PublicationJournal  					:=trimUpper(l.PublicationJournal);
	  self.PublicationPriorJournal  		:=trimUpper(l.PublicationPriorJournal);//AlphaNumeric
	  self.BusinessName  								:=trimUpper(l.BusinessName);
		self.MemberState  								:=trimUpper(l.MemberState);
		self.DateAdded										:=if(_validate.date.fIsValid(l.DateAdded),l.DateAdded,'');
		self.DateUpdated									:=if(_validate.date.fIsValid(l.DateUpdated),l.DateUpdated,'');
		self.LastDecisionDate							:=if(_validate.date.fIsValid(l.LastDecisionDate),l.LastDecisionDate,'');
		self.ProvisionalDeadlineDate			:=if(_validate.date.fIsValid(l.ProvisionalDeadlineDate),l.ProvisionalDeadlineDate,'');
		self.DecisionDate									:=if(_validate.date.fIsValid(l.DecisionDate),l.DecisionDate,'');
		self.PressReleaseDate							:=if(_validate.date.fIsValid(l.PressReleaseDate	),l.PressReleaseDate	,'');
		self.PublicationJournalDate				:=if(_validate.date.fIsValid(l.PublicationJournalDate	),l.PublicationJournalDate	,'');
		self.PublicationPriorJournalDate	:=if(_validate.date.fIsValid(l.PublicationPriorJournalDate),l.PublicationPriorJournalDate,'');
		self.EventDate										:=if(_validate.date.fIsValid(l.EventDate	),l.EventDate	,'');
		self.NotificationRegistrationDate	:=if(_validate.date.fIsValid(l.NotificationRegistrationDate),l.NotificationRegistrationDate, if(_validate.date.fIsValid(l.NotificationRegistrationDate[7..10]+ l.NotificationRegistrationDate[4..5]+l.NotificationRegistrationDate[1..2]),l.NotificationRegistrationDate[7..10]+ l.NotificationRegistrationDate[4..5]+l.NotificationRegistrationDate[1..2],''));
		self.DurationDateTo								:=if(_validate.date.fIsValid(l.DurationDateTo),l.DurationDateTo, if(_validate.date.fIsValid(l.DurationDateTo[7..10]+ l.DurationDateTo[4..5]+l.DurationDateTo[1..2]),l.DurationDateTo[7..10]+ l.DurationDateTo[4..5]+l.DurationDateTo[1..2],''));
		self.DurationDateFrom							:=if(_validate.date.fIsValid(l.DurationDateFrom),l.DurationDateFrom, if(_validate.date.fIsValid(l.DurationDateFrom[7..10]+ l.DurationDateFrom[4..5]+l.DurationDateFrom[1..2]),l.DurationDateFrom[7..10]+ l.DurationDateFrom[4..5]+l.DurationDateFrom[1..2],''));
		self.dt_vendor_first_reported  		:=	pVersion[1..8];
		self.dt_vendor_last_reported   		:= 	pVersion[1..8];
		self.dt_first_seen								:=	pVersion[1..8];
		self.dt_last_seen									:=	pVersion[1..8];
		self.EconomicActivity           	:= trimUpper(l.EconomicActivity);
		self.EventDocType									:= trimUpper(l.EventDocType);
		self.EventDocument								:= trimUpper(l.EventDocument);
		self															:= l;
	end;
	File_out:=project(File_in,trans_clean(left));


 CountryCodeLayout := record,MAXLENGTH(100)
			
			string Country;
			string CountryCode;
			
		end;							
		  
		  
		CountryCodeTable := dataset('~thor_data400::lookup::ECRulings::Countrycodes',CountryCodeLayout,CSV(SEPARATOR(['|']), quote('"'), TERMINATOR(['\r\n', '\n'])));
	
	
 ECRulings.Layouts.Clean_comp_DeciPub_EconomicAct_Eventdoc findCountryCode(ECRulings.Layouts.comp_DeciPub_EconomicAct_Eventdoc l, CountryCodeLayout r ) := transform
			self.EU_country_code       :=  r.CountryCode;
			self         			   := l;
		end;
		
		joinEU_country_code := 	join(File_out,CountryCodeTable,
									trim(left.MemberState,left,right) = trim(right.Country,left,right),
									findCountryCode(left,right),
									left outer, lookup
								):persist('~thor_data400::ECRulings::Cleaned_Joined_file');	
	return joinEU_country_code;
end;