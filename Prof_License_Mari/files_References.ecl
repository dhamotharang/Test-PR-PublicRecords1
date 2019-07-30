import ut, Data_Services;

EXPORT files_References := MODULE

export cmvtranslation	  := dataset(Data_Services.foreign_prod+'thor_data400::in::proflic_mari::using::cmvtrans',Prof_License_Mari.layouts_Reference.cmvtranslation,CSV(HEADING(1),SEPARATOR('\t')));	
export cmvboard			  	:= dataset('~thor_data400::in::proflic_mari::using::cmvboard',Prof_License_Mari.layouts_Reference.cmvboard,CSV(HEADING(1)));
export cmvprofstate		  := dataset('~thor_data400::in::proflic_mari::using::cmvprofstate',Prof_License_Mari.layouts_Reference.cmvprofstate,CSV(HEADING(1))); 	
export MARI_Parms		  	:= dataset('~thor_data400::in::proflic_mari::using::mari_parm',Prof_License_Mari.layouts_Reference.MARI_Parms,CSV(HEADING(1))); 
export MARIcmvAddlData	:= dataset('~thor_data400::in::proflic_mari::using::cmvaddldata',Prof_License_Mari.layouts_Reference.MARIcmvAddlData,CSV(HEADING(1))); 
export MARIcmvDataLimit	:= dataset('~thor_data400::in::proflic_mari::using::maridatalimit',Prof_License_Mari.layouts_Reference.MARIcmvDataLimit,CSV(HEADING(1))); 
export MARIcmvLicStatus	:= dataset(Data_Services.foreign_prod+'thor_data400::in::proflic_mari::using::cmvlicstatus',Prof_License_Mari.layouts_Reference.MARIcmvLicStatus,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'))); 
export MARIcmvLicType	  := dataset(Data_Services.foreign_prod+'thor_data400::in::proflic_mari::using::cmvlictype',Prof_License_Mari.layouts_Reference.MARIcmvLicType,CSV(HEADING(1),SEPARATOR('\t'))); 
export MARIcmvProf		  := dataset(Data_Services.foreign_prod+'thor_data400::in::proflic_mari::using::cmvprof',Prof_License_Mari.layouts_Reference.MARIcmvProf,CSV(HEADING(1),QUOTE('"'))); 
export MARIcmvSrc	      := dataset(Data_Services.foreign_prod+'thor_data400::in::proflic_mari::using::cmvsrc',Prof_License_Mari.layouts_Reference.MARIcmvSrc,CSV(HEADING(1),QUOTE('"'),SEPARATOR(','))); 
export MARIcmvState		  := dataset('~thor_data400::in::proflic_mari::using::cmvstate_abbr',Prof_License_Mari.layouts_Reference.MARIcmvState,CSV(HEADING(1))); 
export MARIDupeCmcSLPK	:= dataset('~thor_data400::in::proflic_mari::using::maridupecmcslpk',Prof_License_Mari.layouts_Reference.MARIDupeCmcSLPK,CSV(HEADING(1)));
export MARIcmvDispType	:= dataset('~thor_data400::in::proflic_mari::using::cmvdisptype',Prof_License_Mari.layouts_Reference.MARIcmvDispType,CSV(HEADING(1))); 
export MiscProfLicData	:= dataset('~thor_data400::in::proflic_mari::using::miscproflic',Prof_License_Mari.layouts_reference.MiscProfLic_ref,CSV(HEADING(1),SEPARATOR(','))); 
export NMLSSrc					:= dataset('~thor_data400::in::proflic_mari::using::nmlssrc',Prof_License_Mari.layouts_reference.nmlsSrc_ref,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'))); 

export county_names			:= dataset(Data_Services.foreign_prod+'thor_data400::in::proflic_mari::using::county_names',Prof_License_Mari.layouts_reference.county_names,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'))); 
export county_names_tx	:= dataset('~thor_data400::in::proflic_mari::txs0819::using::county_names_common',Prof_License_Mari.layouts_reference.county_names_common,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'))); 

// export USS0645_main_cmpny 	:= dataset('~thor_data400::in::proflic_mari::uss0645::using::reference_company',Prof_License_Mari.layout_USS0645.reference,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'))); 
// export USS0645_branch       := dataset('~thor_data400::in::proflic_mari::s0645::branch_record',Prof_License_Mari.layout_USS0645.reference,thor);
export WIS0854_vehicle_info := dataset('~thor_data400::in::proflic_mari::WIS0854::Vehicle_ref',Prof_License_Mari.layout_WIS0854.Layout_Vehicle_Ref,CSV(SEPARATOR(','),QUOTE('"')));
END;



						