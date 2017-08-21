import did_add;
import riskwise;
import Adv;

/////////////////////////////////////////////////
//
// ECL Module InquiryNWeekly
//
// ECL module describing the attributes ADV 
// needs for the Inquiry Non-FCRA Weekly file.
//
/////////////////////////////////////////////////

EXPORT InquiryNWeekly := module
	SHARED LogicalFileName := '~thor_data400::out::inquiry_tracking::weekly_historical';
	EXPORT SourceName      := 'InquiryNonFCRAWeekly';	
	EXPORT BuildVersion    := did_add.get_EnvVariable('inquiry_build_version', riskwise.shortcuts.QA_neutral_roxieIP);;
	
	EXPORT File            := dataset(LogicalFileName, Adv.InquiryN.Layout, thor);
	EXPORT FileSize        := count(File);
end;