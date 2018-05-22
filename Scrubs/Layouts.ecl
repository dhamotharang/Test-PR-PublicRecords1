import Salt35;
EXPORT Layouts := MODULE

//	Scrubs
export StatsOutLayout := record 
	unsigned4				processDate;
	unsigned4       RecordsTotal;
  string					SourceCode;
	string       		FieldName;
	string       		RuleName ;
	string					RuleDesc;
	unsigned4       Rulecnt ;
	decimal5_2       RulePcnt;
	decimal5_2			RuleThreshold;
	string1         RejectWarning;   // Rule pct > Threshold reject then Y else N 
	string        	InvalidValue;
	unsigned        InvalidValueCnt;
	String          Code:= '';
	string1         Severity := ''; 
end; 

export ProfileTemplateLayout       := record
	string ruleName;
	string RuleDesc:= '' ;	
	string isEnabled;
  string group_;
	string order;
	string severity;
	string RulePcnt;
	string code;
end; 

//	Scrubs Alerts
export ProfileAlertsTemplateLayout       := record
string Profile;
string Rule_Name;
string Description;
string Enabled;
string Default_Rule;
string Order;
string Code := '';
string Severity := '';
string Pass_Percentage;
string Percentage_Error_Min := '';
string Percentage_Error_Max := '';
// string ScrubsAlertsPerRelToPopulationMin := ''; Currently in Testing
string Change_To_From_Zero := '';
end;

export OrbitLayoutStep1	:=	record
		integer4 Id;
		integer4 ProfileId;
		string Name;
		boolean IsEnabled;
		string Description;
		string RuleType;
		string PassPercentage;
		string Code;
		string Severity;
	end;

export LogRecord	:=	record
				string Datasetidentifier;
				string Profile;
				string scopeidentifier;
				string Version;
				string NumRecs;
				string NumRules;
				string NumErroredRules;
				string RulesExceedingThreshold;
				string RulesExceedingSevere;
				string NumErroredRecs;
				string PcntErroredRecs;
				string NumRemovedRecs;
				string WU;
			end;
export OrbitLogLayout	:=	record
			string ProfileName;
			string version;
			UNSIGNED8 recordstotal;
			UNSIGNED4 processdate;
			STRING10  sourcecode;
			STRING    ruledesc;
			STRING    ErrorMessage;
			UNSIGNED8 rulecnt;
			decimal5_2 rulepcnt;
			STRING1   rejectwarning := '';
			Salt35.StrType rawcodemissing := '';
			UNSIGNED1 rawcodemissingcnt := 0;
		end;
		
	Export ProfileRule_Rec := record
		integer4 Id;
		integer4 ProfileId;
		string Name;
		boolean IsEnabled;
		string Description;
		string RuleType;
		Decimal5_2 PassPercentageBottom:=0.0;
		Decimal5_2 PassPercentageTop;
		//Decimal5_2 CompareToPreviousMin:=0.0;
		//Decimal5_2 CompareToPreviousMax:=0.0;
		string Code;
		string Severity;
	end;
	
	Export LoadLowerBoundRec	:=	record
		string			Name;
		decimal5_2	NewBound;
	end;
END;