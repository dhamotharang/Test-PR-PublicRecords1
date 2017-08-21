import lib_stringlib;

Raw_in:=FEIN_CP_Extract.File_FEIN_LN_RawIN;

output(choosen(Raw_in,100),named('Fein_sample_RAWdata'));
output(count(Raw_in),named('Fein_RAW_recordCount'));

LN_DNB_Fein_Stats:= record 
	Raw_in.STATE;
	countgroup					:=count(group);
	Tax_ID_Number			    :=ave(group,if(lib_stringlib.StringLib.StringFindReplace(Raw_in.Tax_ID_Number, '0','')<>'',100,0));
	Source_Duns_Number		    :=ave(group,if(lib_stringlib.StringLib.StringFindReplace(Raw_in.Source_Duns_Number, '0','')<>'',100,0));
	Business_Name 	    		:=ave(group,if(Raw_in.Business_Name<>'' ,100,0));
	Address		     			:=ave(group,if(Raw_in.Address<>'' ,100,0));
	CITY		     			:=ave(group,if(Raw_in.CITY	<>'' ,100,0));
	ZIP		     				:=ave(group,if(lib_stringlib.StringLib.StringFindReplace(Raw_in.ZIP, '0','')<>'',100,0));
	Reference_Name_Source		:=ave(group,if(Raw_in.Reference_Name_Source	<>'',100,0));
	Date_of_Input_data			:=ave(group,if(lib_stringlib.StringLib.StringFindReplace(Raw_in.Date_of_Input_data, '0','')<>'',100,0));
    Case_Duns_Number			:=ave(group,if(lib_stringlib.StringLib.StringFindReplace(Raw_in.Case_Duns_Number, '0','')<>'',100,0));
	Confidence_Code        		:=ave(group,if(Raw_in.Confidence_Code<>'' ,100,0));
	Indirect_Direct_Source_Ind  :=ave(group,if(Raw_in.Indirect_Direct_Source_Ind	<>''  ,100,0));
	Best_FEIN_Indicator		    :=ave(group,if(Raw_in.Best_FEIN_Indicator<>'',100,0));
	Company_Name		     	:=ave(group,if(Raw_in.Company_Name<>'' ,100,0)); 
	Tradestyle			     	:=ave(group,if(Raw_in.Tradestyle<>''  ,100,0)); 
	SIC_Code		     		:=ave(group,if(lib_stringlib.StringLib.StringFindReplace(Raw_in.SIC_Code, '0','')<>'',100,0));
	Telephone_Number		    :=ave(group,if(lib_stringlib.StringLib.StringFindReplace(Raw_in.Telephone_Number, '0','')<>'',100,0));
	Top_Contact_Name		    :=ave(group,if(Raw_in.Top_Contact_Name<>''  ,100,0)); 
	Top_Contact_Title		    :=ave(group,if(Raw_in.Top_Contact_Title<>''  ,100,0)); 
	Headquarter_Paren_Duns_Nbr	:=ave(group,if(lib_stringlib.StringLib.StringFindReplace(Raw_in.Headquarter_Paren_Duns_Nbr, '0','')<>'',100,0));
	
 end;
 
  LN_DNB_Fein_PopulationStats := sort(table(Raw_in,LN_DNB_Fein_Stats,
													  STATE,
													    few),-STATE);
export Stats_Pop_Raw := LN_DNB_Fein_PopulationStats;