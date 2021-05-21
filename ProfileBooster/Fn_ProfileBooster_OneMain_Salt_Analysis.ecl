IMPORT ProfileBooster, STD;

EXPORT Fn_ProfileBooster_OneMain_Salt_Analysis(STRING OldSaltProfileName, STRING NewSaltProfileName, STRING EmailList) := FUNCTION

	SaltAnalysisLayouts := ProfileBooster.Layouts_ProfileBooster_OneMain_Salt_Analysis;

	OldSaltProfile := DATASET('~' + OldSaltProfileName, SaltAnalysisLayouts.ProfileLayout, THOR);
	NewSaltProfile := DATASET('~' + NewSaltProfileName, SaltAnalysisLayouts.ProfileLayout, THOR);


	// Set up various alert options for each field - some I might not care if the exact record count differs, I just care if the percent difference is high enough
	Disable_RecordCountChanged := ['ProspectTimeOnRecord', 'ProspectTimeLastUpdate', 'PropTimeLastSale', 'LifeEvTimeLastMove', 'CrtRecTimeNewest', 
	'CrtRecFelonyTimeNewest', 'CrtRecMsdmeanTimeNewest', 'CrtRecEvictionTimeNewest', 'CrtRecLienJudgTimeNewest', 'CrtRecBkrptTimeNewest',
	'OccBusinessAssociationTime'];

	SaltAnalysisLayouts.Value_Layout_Enhanced calculateAlerts(SaltAnalysisLayouts.Value_Layout old, SaltAnalysisLayouts.Value_Layout new, STRING FieldName) := TRANSFORM
		SELF.val := old.val;
		SELF.cnt_old := old.cnt;
		SELF.cnt_new := new.cnt;
		SELF.pcnt_old := old.pcnt;
		SELF.pcnt_new := new.pcnt;
		cnt_diff := (INTEGER8)new.cnt - (INTEGER8)old.cnt;
		cnt_change := cnt_diff / old.cnt;
		pcnt_change := (REAL8)cnt_change * (REAL8)100.0;
		SELF.cnt_diff := cnt_diff;
		SELF.cnt_percent_change := pcnt_change;
		
		RecordCountChanged := old.cnt != new.cnt;
		PercentChangeGreater25 := ABS(pcnt_change) >= 25.0;
		PercentChangeGreater50 := ABS(pcnt_change) >= 50.0;
		PercentChangeGreater100 := ABS(pcnt_change) >= 100.0;
		PercentChangeGreater150 := ABS(pcnt_change) >= 150.0;
		PercentChangeGreater200 := ABS(pcnt_change) >= 200.0;
		
		SELF.Alerts := 
			IF(RecordCountChanged AND FieldName NOT IN Disable_RecordCountChanged, DATASET([{'Record Count Diff'}], SaltAnalysisLayouts.Alerts_Layout)) +
			MAP(PercentChangeGreater200 => DATASET([{'% Change >= 200%'}], SaltAnalysisLayouts.Alerts_Layout),
				PercentChangeGreater150 => DATASET([{'% Change >= 150%'}], SaltAnalysisLayouts.Alerts_Layout),
				PercentChangeGreater100 => DATASET([{'% Change >= 100%'}], SaltAnalysisLayouts.Alerts_Layout),
				PercentChangeGreater50 => DATASET([{'% Change >= 50%'}], SaltAnalysisLayouts.Alerts_Layout),
				PercentChangeGreater25 => DATASET([{'% Change >= 25%'}], SaltAnalysisLayouts.Alerts_Layout),
											DATASET([], SaltAnalysisLayouts.Alerts_Layout));
	END;

	compareProfiles := JOIN(OldSaltProfile, NewSaltProfile, LEFT.FldNo = RIGHT.FldNo AND LEFT.FieldName = RIGHT.FieldName, TRANSFORM(SaltAnalysisLayouts.EnhancedProfileLayout,
		field_name := LEFT.FieldName;
	Frequent_Terms_Enhanced := JOIN(LEFT.Frequent_Terms, RIGHT.Frequent_Terms, LEFT.val = RIGHT.val, calculateAlerts(LEFT, RIGHT, field_name), FULL OUTER);
		SELF.Frequent_Terms := Frequent_Terms_Enhanced;
	all_Alerts := ROLLUP(PROJECT(Frequent_Terms_Enhanced, TRANSFORM(SaltAnalysisLayouts.alerting, SELF.Alerts := LEFT.Alerts)), TRUE, TRANSFORM(SaltAnalysisLayouts.alerting, SELF.Alerts := LEFT.Alerts + RIGHT.Alerts));
		unique_Alerts := DEDUP(SORT(PROJECT(all_Alerts.Alerts, TRANSFORM(SaltAnalysisLayouts.Alerts_Layout, SELF.Alert := LEFT.Alert)), Alert), Alert);
		SELF.Alerts := unique_Alerts;
		SELF := LEFT));

	profileAlerts := compareProfiles(EXISTS(Alerts));
	
	IF(COUNT(profileAlerts) > 0, FAIL('Salt analysis had a change of greater than 25% in one or more fields.')) :
	FAILURE(STD.System.Email.SendEmail(EmailList,'Salt analysis had a change of greater than 25% in one or more fields.', 'The failed workunit is:' + WORKUNIT + ' The error message is: ' + FAILMESSAGE));

	SaltAnalysisName := 'One_Main_Salt_Analysis_' + ((STRING)STD.Date.Today())[1..6];

	OUTPUT(compareProfiles, NAMED('Profile_Comparison'));
	OUTPUT(profileAlerts, NAMED('Profile_Alerts'));	
	OUTPUT(compareProfiles,, SaltAnalysisName + '_Profiles.csv', csv(heading(single), quote('"')), overwrite);
	OUTPUT(profileAlerts,, SaltAnalysisName + '_Alerts.csv', csv(heading(single), quote('"')), overwrite);
 
	RETURN 'SUCCESSFUL';
END;

