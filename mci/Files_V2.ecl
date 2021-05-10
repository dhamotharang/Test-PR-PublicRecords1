﻿import ut, MCI, tools;

EXPORT Files_V2(STRING pVersion, boolean pUseProd, string gcid, string pHistMode) := MODULE

  export from_batch  			:= dataset(MCI.Filenames_V2(pVersion,pUseProd,gcid,pHistMode).batch_lInputTemplate, MCI.layouts_V2.from_batch, csv(separator('|'),heading(1),quote('')));
	export batch_history  	:= dataset(MCI.Filenames_V2(pVersion,pUseProd,gcid,pHistMode).batch_lInputHistTemplate, MCI.layouts_V2.from_batch, csv(separator('|'),heading(1),quote('')));
  // export from_batch  			:= dataset(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).batch_lInputTemplate, MCI.layouts_V2.from_batch, csv(separator('|'),heading(0),quote('')));
	// export batch_history  	:= dataset(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).batch_lInputHistTemplate, MCI.layouts_V2.from_batch, csv(separator('|'),heading(0),quote('')));

	 /* Base File Versions */
	 tools.mac_FilesBase(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).member_Base, MCI.layouts_V2.Base, member_base);
	 tools.mac_FilesBase(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).processed_input, MCI.layouts_V2.input_processing, processed_input);
	 tools.mac_FilesBase(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).asheader, MCI.layouts_V2.as_header, asheader);
	 tools.mac_FilesBase(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).temp_header, MCI.layouts_V2.temp_header, temp_header);
	 tools.mac_FilesBase(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).tobatch_file, MCI.layouts_V2.to_batch, tobatch_file);
	 tools.mac_FilesBase(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).tobatch_metrics_file, MCI.layouts_V2.metrics_fields, tobatch_metrics_file);
	 tools.mac_FilesBase(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).slim_history_file, MCI.layouts_V2.slim_history, slim_history);
	 tools.mac_FilesBase(Filenames_V2(pVersion,pUseProd,gcid,pHistMode).aggregate_report_file, MCI.layouts_V2.aggregate_fields, aggregate_report_file);
	 	 
END;
