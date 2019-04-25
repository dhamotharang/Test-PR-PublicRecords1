// EXPORT Run_Models_Macro (filename,fname, mname_file,layout, model_layout_name ,date_in ) := module
EXPORT Run_Models_Macro  := module

export NormalModels (filename,fname, mname_file,layout, model_layout_name ,date_in) := FUNCTIONMACRO

IMPORT STD, ut, ML;
IMPORT Scoring_DistributionTrends.Layouts as L;
IMPORT Scoring_DistributionTrends.Constants as C;
IMPORT Scoring_DistributionTrends.Files as F;
IMPORT Scoring_DistributionTrends.XMLData as X;



//full file
ds1 := Scoring_DistributionTrends.FMAC_BuildHistory(filename, layout , model_layout_name, date_in); 
output(ds1,,C.HistoryFile_Prefix+ fname + mname_file + date_in + C.HistoryFile_Tag ,thor, compressed, overwrite );


//Create the NTiles file
dsNTile := Scoring_DistributionTrends.FMAC_GetNTiles(filename, layout, model_layout_name, date_in); 
OUTPUT(dsNTile,,C.NTileFile_Prefix + fname + mname_file + date_in + C.NTileFile_Tag,THOR,COMPRESSED,OVERWRITE,expire(30));  

//Create the Proportions File - 10
dsProportions_10 := Scoring_DistributionTrends.FMAC_GetProportions_10(ds1); 
OUTPUT(dsProportions_10,,C.ProportionFile_Prefix  + fname + mname_file + date_in + C.ProportionFile_10_Tag,THOR,COMPRESSED,OVERWRITE,expire(30));  

// Create the Proportions File - 50
dsProportions_50 := Scoring_DistributionTrends.FMAC_GetProportions_50(ds1); 
fileprop50 := OUTPUT(dsProportions_50,,C.ProportionFile_Prefix  + fname + mname_file + date_in + C.ProportionFile_50_Tag,THOR,COMPRESSED,OVERWRITE,expire(30));  


return fileprop50;
endmacro;

export SpecialModels_d1 (filename,fname, mname_file,layout, model_layout_name ,date_in ) := FUNCTIONMACRO

IMPORT STD, ut, ML;
IMPORT Scoring_DistributionTrends.Layouts as L;
IMPORT Scoring_DistributionTrends.Constants as C;
IMPORT Scoring_DistributionTrends.Files as F;
IMPORT Scoring_DistributionTrends.XMLData as X;



//full file
ds1 := Scoring_DistributionTrends.FMAC_BuildHistory(filename, layout , model_layout_name, date_in); 
output(ds1,,C.HistoryFile_Prefix+ fname + mname_file + date_in + C.HistoryFile_Tag ,thor, compressed, overwrite );


//Create the NTiles file
dsNTile := Scoring_DistributionTrends.FMAC_GetNTiles(filename, layout, model_layout_name, date_in); 
OUTPUT(dsNTile,,C.NTileFile_Prefix + fname + mname_file + date_in + C.NTileFile_Tag,THOR,COMPRESSED,OVERWRITE,expire(30));  

//Create the Proportions File - 10
dsProportions_10 := Scoring_DistributionTrends.FMAC_GetProportions_10(ds1); 
fileprop10 := OUTPUT(dsProportions_10,,C.ProportionFile_Prefix  + fname + mname_file + date_in + '_discrete_1_1',THOR,COMPRESSED,OVERWRITE,expire(30));  

// Create the Proportions File - 50
// dsProportions_50 := Scoring_DistributionTrends.FMAC_GetProportions_50(ds1); 
// fileprop50 := OUTPUT(dsProportions_50,,C.ProportionFile_Prefix  + fname + mname_file + date_in + C.ProportionFile_50_Tag,THOR,COMPRESSED,OVERWRITE,expire(30));  


return fileprop10;

endmacro;

export SpecialModels_d10 (filename,fname, mname_file,layout, model_layout_name ,date_in ) := FUNCTIONMACRO

IMPORT STD, ut, ML;
IMPORT Scoring_DistributionTrends.Layouts as L;
IMPORT Scoring_DistributionTrends.Constants as C;
IMPORT Scoring_DistributionTrends.Files as F;
IMPORT Scoring_DistributionTrends.XMLData as X;



//full file
ds1 := Scoring_DistributionTrends.FMAC_BuildHistory(filename, layout , model_layout_name, date_in); 
output(ds1,,C.HistoryFile_Prefix+ fname + mname_file + date_in + C.HistoryFile_Tag ,thor, compressed, overwrite );


//Create the NTiles file
dsNTile := Scoring_DistributionTrends.FMAC_GetNTiles(filename, layout, model_layout_name, date_in); 
OUTPUT(dsNTile,,C.NTileFile_Prefix + fname + mname_file + date_in + C.NTileFile_Tag,THOR,COMPRESSED,OVERWRITE,expire(30));  

//Create the Proportions File - 10
dsProportions_10 := Scoring_DistributionTrends.FMAC_GetProportions_10(ds1); 
fileprop10 := OUTPUT(dsProportions_10,,C.ProportionFile_Prefix  + fname + mname_file + date_in + '_discrete_10_1',THOR,COMPRESSED,OVERWRITE,expire(30));  

// Create the Proportions File - 50
// dsProportions_50 := Scoring_DistributionTrends.FMAC_GetProportions_50(ds1); 
// fileprop50 := OUTPUT(dsProportions_50,,C.ProportionFile_Prefix  + fname + mname_file + date_in + C.ProportionFile_50_Tag,THOR,COMPRESSED,OVERWRITE,expire(30));  


return fileprop10;

endmacro;

END;
