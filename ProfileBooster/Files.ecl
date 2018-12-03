EXPORT Files := MODULE

Import Data_Services ;

//***********************************************************************************************
//** ExtraPrefix - typically for customer test or qc test to create their own super files 
//**                without overwriting the developer's work - example: '::CT' '::QC'
//***********************************************************************************************
	EXPORT ExtraPrefix		:= '' : STORED('ExtraPrefix'); 
	
	EXPORT MMPrefix     := '~in::marketmagnifier' + ExtraPrefix;
	EXPORT MMPrefixOT   := '~out::marketmagnifier' + ExtraPrefix;
	EXPORT MMPrefixNm   := 'in::marketmagnifier' + ExtraPrefix;
	Export MMSuffix     := '::profileboosterin::';
	Export MMFNamein    := MMPrefixNm + MMSuffix;
	Export MMdain    			:= MMPrefix + MMSuffix;
	Export MMdaOT    			:= MMPrefixOT + MMSuffix;
	Export PBSuffix     := '::ProfileBooster::attributes::Append';


EXPORT Logical (string version) := Module
//****************************************************************************************
//** LogicalFiles Datasets
//** Add ' + ExtraPrefix + ' to all output datasets - 7/26/2018 by MN
//****************************************************************************************
EXPORT lg_pb01 	 	:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb02 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb03    := DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb04    := DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb05 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb06 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb07 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb08 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb09 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb10 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb11 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb12 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb13 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb14 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pb15 			:= DATASET(MMdain + version + '_01_of_15' + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	
EXPORT lg_pbOT 			:= DATASET(MMdaOT + version + PBSuffix,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(6000)));	

END;

End;
    