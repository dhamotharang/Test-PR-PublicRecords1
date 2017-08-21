import ADV;
import did_add;
import riskwise;

/////////////////////////////////////////////////
//
// ECL Module InquiryFWeekly
//
// ECL module describing the attributes ADV 
// needs for the Inquiry FCRA Weekly file.
//
/////////////////////////////////////////////////

EXPORT InquiryFWeekly := MODULE
		
		EXPORT Layout := record
			Adv.Inquiry.mbslayout mbs;
			Adv.Inquiry.allowlayout allow_flags;
			Adv.Inquiry.businfolayout bus_intel;
			Adv.Inquiry.persondatalayout person_q;
			Adv.Inquiry.busdatalayout bus_q;
			Adv.Inquiry.bususerdatalayout bususer_q;
			Adv.Inquiry.permissablelayout permissions;
			Adv.Inquiry.searchlayout search_info;
			string source;
			unsigned8 persistent_record_id;
	END;
	
	SHARED LogicalFileName := '~persist::inquiry::fcra_base';
	EXPORT SourceName := 'InquiryFWeekly';	
	EXPORT BuildVersion := ADV.CurrentBuildVersions.File(datasetname='FCRA_InquirytableKeys' and envment='Q' and location = 'B' and cluster = 'F')[1].buildversion;

	EXPORT File := dataset(LogicalFileName, Layout, thor);
	EXPORT FileSize := count(File);
END;
