EXPORT layout_gpssi := RECORD
	STRING1		Update_Flag 										:= '';
<<<<<<< Updated upstream
	INTEGER8	Primary_Key											;
=======
	STRING8		Primary_Key											:= '';
>>>>>>> Stashed changes
	STRING8		Accuity_Location_ID							:= '';
	STRING20	Correspondent_Type							:= '';
	STRING300	Filler1													:= '';
	STRING3		ISO_Currency_Code								:= '';
	STRING11	Owner_BIC												:= '';
	STRING11	Owner_BIC_Without_Padding				:= '';
	STRING75	Owner_BIC_SSI_Account_Number    := '';
	STRING8		Clearer_Location_ID             := '';
	STRING11	Clearer_BIC                     := '';
	STRING11	Clearer_BIC_Without_Padding     := '';
	STRING8		Holder_Location_ID              := '';
	STRING11	Holder_BIC                      := '';
	STRING11	Holder_BIC_Without_Padding      := '';
	STRING75	Holder_BIC_SSI_Account_Number   := '';
	STRING1		Preferred_SSI_Indicator         := '';
	STRING8		Further_Location_ID             := '';
	STRING11	Further_BIC                     := '';
	STRING11	Further_BIC_Without_Padding     := '';
	STRING8		Further_2_Location_ID           := '';
	STRING11	Further_2_BIC                   := '';
	STRING11	Further_2_BIC_Without_Padding   := '';
	STRING10	Correspondent_Effective_Date    := '';
	STRING10	Correspondent_Deactivation_Date := '';
	STRING10	Correspondent_Update_Date       := '';
	STRING600	SSI_Notes                       := '';
	STRING35	Filler2                         := '';
	STRING35	Filler3                         := '';
	STRING35	Filler4                         := '';
	STRING35	Filler5                         := '';
	STRING35	Filler6                         := '';
	STRING35	Filler7                         := '';
	
END;