Export inPopulationStats := Module

Shared	rFileHeader := Record//FA
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.FileHeader_FA.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.FileHeader_FA.File_Sequence_Number<>'',1,0));
Test_or_Production_Indicator_cnt:=sum(group,if(Business_Credit.Files.FileHeader_FA.Test_or_Production_Indicator<>'',1,0));
File_Type_Indicator_cnt:=sum(group,if(Business_Credit.Files.FileHeader_FA.File_Type_Indicator<>'',1,0));
End;
Export Pop_FileHeader_FA_stats :=TABLE(Business_Credit.Files.FileHeader_FA, rFileHeader, FEW);

Shared	rHeaderSegment := Record//AA
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Segment_Identifier<>'',1,0));
File_Segment_num_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.File_Segment_num<>'',1,0));
Sbfe_Contributor_Num_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Sbfe_Contributor_Num<>'',1,0));
Extracted_Date_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Extracted_Date<>'',1,0));
CycleEnd_Date_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.CycleEnd_Date<>'',1,0));
CycleNum_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.CycleNum<>'',1,0));
CycleLen_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.CycleLen<>'',1,0));
File_Correction_Indicator_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.File_Correction_Indicator<>'',1,0));
Overall_File_Format_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Overall_File_Format_Version<>'',1,0));
Major_AA_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_AA_Segment_Version<>'',1,0));
Minor_AA_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_AA_Segment_Version<>'',1,0));
Major_AB_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_AB_Segment_Version<>'',1,0));
Minor_AB_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_AB_Segment_Version<>'',1,0));
Major_MA_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_MA_Segment_Version<>'',1,0));
Minor_MA_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_MA_Segment_Version<>'',1,0));
Major_AD_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_AD_Segment_Version<>'',1,0));
Minor_AD_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_AD_Segment_Version<>'',1,0));
Major_PN_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_PN_Segment_Version<>'',1,0));
Minor_PN_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_PN_Segment_Version<>'',1,0));
Major_TI_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_TI_Segment_Version<>'',1,0));
Minor_TI_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_TI_Segment_Version<>'',1,0));
Major_IS_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_IS_Segment_Version<>'',1,0));
Minor_IS_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_IS_Segment_Version<>'',1,0));
Major_BS_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_BS_Segment_Version<>'',1,0));
Minor_BS_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_BS_Segment_Version<>'',1,0));
Major_BI_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_BI_Segment_Version<>'',1,0));
Minor_BI_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_BI_Segment_Version<>'',1,0));
Major_CL_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_CL_Segment_Version<>'',1,0));
Minor_CL_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_CL_Segment_Version<>'',1,0));
Major_MS_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_MS_Segment_Version<>'',1,0));
Minor_MS_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_MS_Segment_Version<>'',1,0));
Major_AH_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_AH_Segment_Version<>'',1,0));
Minor_AH_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_AH_Segment_Version<>'',1,0));
Major_ZZ_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Major_ZZ_Segment_Version<>'',1,0));
Minor_ZZ_Segment_Version_cnt:=sum(group,if(Business_Credit.Files.HeaderSegment_AA.Minor_ZZ_Segment_Version<>'',1,0));
End;
Export Pop_HeaderSegment_AA_stats :=TABLE(Business_Credit.Files.HeaderSegment_AA, rHeaderSegment, FEW);

Shared	rAccountBase := Record//AB
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Segment_Identifier<>'',1,0));
File_Segment_num_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.File_Segment_num<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Parent_Sequence_Number<>'',1,0));
AccHolder_BusinessName_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.AccHolder_BusinessName<>'',1,0));
DBA_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.DBA<>'',1,0));
Comp_Website_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Comp_Website<>'',1,0));
Legal_Busi_Structure_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Legal_Busi_Structure<>'',1,0));
Busi_Established_Date_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Busi_Established_Date<>'',1,0));
ContractAcc_Num_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.ContractAcc_Num<>'',1,0));
AccountTypeReported_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.AccountTypeReported<>'',1,0));
Acc_Status1_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Acc_Status1<>'',1,0));
Acc_Status2_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Acc_Status2<>'',1,0));
DateAccOpened_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.DateAccOpened<>'',1,0));
DateAccClosed_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.DateAccClosed<>'',1,0));
AccountCloseureBasis_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.AccountCloseureBasis<>'',1,0));
AccExpirationDate_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.AccExpirationDate<>'',1,0));
LastActivityDate_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.LastActivityDate<>'',1,0));
LastActivityType_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.LastActivityType<>'',1,0));
RecentActivityIndicator_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.RecentActivityIndicator<>'',1,0));
OrigCreditLimit_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.OrigCreditLimit<>'',1,0));
HighestCreditUsed_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.HighestCreditUsed<>'',1,0));
CurrentCreditLimit_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.CurrentCreditLimit<>'',1,0));
ReporterIndicatorLength_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.ReporterIndicatorLength<>'',1,0));
PaymentInterval_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PaymentInterval<>'',1,0));
PaymentStatusCategory_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PaymentStatusCategory<>'',1,0));
TermOfAcc_Months_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.TermOfAcc_Months<>'',1,0));
FirstPymtDueDate_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.FirstPymtDueDate<>'',1,0));
FinalPymtDueDate_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.FinalPymtDueDate<>'',1,0));
OrigRate_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.OrigRate<>'',1,0));
FloatingRate_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.FloatingRate<>'',1,0));
GracePeriod_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.GracePeriod<>'',1,0));
PaymentCategory_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PaymentCategory<>'',1,0));
PymtHistProfile12_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PymtHistProfile12<>'',1,0));
PymtHistProfile13_24_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PymtHistProfile13_24<>'',1,0));
PymtHistProfile25_36_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PymtHistProfile25_36<>'',1,0));
PymtHistProfile37_48_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PymtHistProfile37_48<>'',1,0));
PymtHistLength_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PymtHistLength<>'',1,0));
YTD_PurchasesCount_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.YTD_PurchasesCount<>'',1,0));
LTD_PurchasesCount_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.LTD_PurchasesCount<>'',1,0));
YTD_PurchasesSumAmt_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.YTD_PurchasesSumAmt<>'',1,0));
LTD_PurchasesSumAmt_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.LTD_PurchasesSumAmt<>'',1,0));
PymtAmtScheduled_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PymtAmtScheduled<>'',1,0));
RecentPymtAmt_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.RecentPymtAmt<>'',1,0));
RecentPaymentDate_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.RecentPaymentDate<>'',1,0));
RemainingBalance_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.RemainingBalance<>'',1,0));
CarriedOverAmt_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.CarriedOverAmt<>'',1,0));
NewAppliedCharges_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.NewAppliedCharges<>'',1,0));
BalloonPymtDue_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.BalloonPymtDue<>'',1,0));
BalloonPymtDueDate_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.BalloonPymtDueDate<>'',1,0));
DelinquencyDate_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.DelinquencyDate<>'',1,0));
DaysDelinquent_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.DaysDelinquent<>'',1,0));
PastDueAmt_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.PastDueAmt<>'',1,0));
Maximum_Number_of_Past_Due_Aging_Amounts_Buckets_Provided_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Maximum_Number_of_Past_Due_Aging_Amounts_Buckets_Provided<>'',1,0));
Past_Due_Aging_Bucket_Type_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Past_Due_Aging_Bucket_Type<>'',1,0));
Past_Due_Aging_Amount_Bucket_1_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Past_Due_Aging_Amount_Bucket_1<>'',1,0));
Past_Due_Aging_Amount_Bucket_2_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Past_Due_Aging_Amount_Bucket_2<>'',1,0));
Past_Due_Aging_Amount_Bucket_3_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Past_Due_Aging_Amount_Bucket_3<>'',1,0));
Past_Due_Aging_Amount_Bucket_4_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Past_Due_Aging_Amount_Bucket_4<>'',1,0));
Past_Due_Aging_Amount_Bucket_5_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Past_Due_Aging_Amount_Bucket_5<>'',1,0));
Past_Due_Aging_Amount_Bucket_6_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Past_Due_Aging_Amount_Bucket_6<>'',1,0));
Past_Due_Aging_Amount_Bucket_7_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Past_Due_Aging_Amount_Bucket_7<>'',1,0));
Maximum_Number_of_Payment_Tracking_Cycle_Periods_Provided_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Maximum_Number_of_Payment_Tracking_Cycle_Periods_Provided<>'',1,0));
Payment_Tracking_Cycle_Type_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Payment_Tracking_Cycle_Type<>'',1,0));
Payment_Tracking_Cycle_0_Current_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Payment_Tracking_Cycle_0_Current<>'',1,0));
Payment_Tracking_Cycle_1_1_30_days_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Payment_Tracking_Cycle_1_1_30_days<>'',1,0));
Payment_Tracking_Cycle_2_31_60_days_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Payment_Tracking_Cycle_2_31_60_days<>'',1,0));
Payment_Tracking_Cycle_3_61_90_days_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Payment_Tracking_Cycle_3_61_90_days<>'',1,0));
Payment_Tracking_Cycle_4_91_120_days_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Payment_Tracking_Cycle_4_91_120_days<>'',1,0));
Payment_Tracking_Cycle_5_121_150days_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Payment_Tracking_Cycle_5_121_150days<>'',1,0));
Payment_Tracking_Number_of_Times_Cycle_6_151_180_days_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Payment_Tracking_Number_of_Times_Cycle_6_151_180_days<>'',1,0));
Payment_Tracking_Number_of_Times_Cycle_7_181_or_greater_days_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Payment_Tracking_Number_of_Times_Cycle_7_181_or_greater_days<>'',1,0));
Date_Account_was_Charged_Off_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Date_Account_was_Charged_Off<>'',1,0));
Amount_Charged_Off_by_Creditor_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Amount_Charged_Off_by_Creditor<>'',1,0));
Charge_Off_Type_Indicator_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Charge_Off_Type_Indicator<>'',1,0));
Total_Charge_Off_Recoveries_to_Date_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Total_Charge_Off_Recoveries_to_Date<>'',1,0));
Government_Guarantee_Flag_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Government_Guarantee_Flag<>'',1,0));
Government_Guarantee_Category_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Government_Guarantee_Category<>'',1,0));
Portion_of_Account_Guaranteed_by_Government_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Portion_of_Account_Guaranteed_by_Government<>'',1,0));
Guarantors_Indicator_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Guarantors_Indicator<>'',1,0));
Number_of_Guarantors_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Number_of_Guarantors<>'',1,0));
Owners_Indicator_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Owners_Indicator<>'',1,0));
Number_of_Principals_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Number_of_Principals<>'',1,0));
Account_Update_Deletion_Indicator_cnt:=sum(group,if(Business_Credit.Files.AccountBase_AB.Account_Update_Deletion_Indicator<>'',1,0));
End;
Export Pop_AccountBase_AB_stats :=TABLE(Business_Credit.Files.AccountBase_AB, rAccountBase, FEW);

Shared	rMasterAccount_Contract := Record//MA
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.MasterAccount_Contract_MA.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.MasterAccount_Contract_MA.File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.MasterAccount_Contract_MA.Parent_Sequence_Number<>'',1,0));
Account_Base_Number_cnt:=sum(group,if(Business_Credit.Files.MasterAccount_Contract_MA.Account_Base_Number<>'',1,0));
Master_Account_or_Contract_Number_Identifier_cnt:=sum(group,if(Business_Credit.Files.MasterAccount_Contract_MA.Master_Account_or_Contract_Number_Identifier<>'',1,0));
End;
Export Pop_MasterAccount_Contract_MA_stats :=TABLE(Business_Credit.Files.MasterAccount_Contract_MA, rMasterAccount_Contract, FEW);

Shared	rAddress_Segment := Record//AD
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Parent_Sequence_Number<>'',1,0));
Account_Base_Number_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Account_Base_Number<>'',1,0));
Address_Line_1_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Address_Line_1<>'',1,0));
Address_Line_2_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Address_Line_2<>'',1,0));
City_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.City<>'',1,0));
State_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.State<>'',1,0));
Zip_Code_or_CA_Postal_Code_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Zip_Code_or_CA_Postal_Code<>'',1,0));
Postal_Code_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Postal_Code<>'',1,0));
Country_Code_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Country_Code<>'',1,0));
Primary_Address_Indicator_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Primary_Address_Indicator<>'',1,0));
Address_Classification_cnt:=sum(group,if(Business_Credit.Files.Address_Segment_AD.Address_Classification<>'',1,0));
End;
Export Pop_Address_Segment_AD_stats :=TABLE(Business_Credit.Files.Address_Segment_AD, rAddress_Segment, FEW);

Shared	rPhoneNumberSegment := Record //PN
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.Parent_Sequence_Number<>'',1,0));
Account_Base_Number_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.Account_Base_Number<>'',1,0));
Area_Code_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.Area_Code<>'',1,0));
Telephone_Number_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.Telephone_Number<>'',1,0));
Telephone_Extension_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.Telephone_Extension<>'',1,0));
Primary_Telephone_Indicator_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.Primary_Telephone_Indicator<>'',1,0));
Published_Unlisted_Indicator_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.Published_Unlisted_Indicator<>'',1,0));
PhoneType_cnt:=sum(group,if(Business_Credit.Files.PhoneNumber_PN.PhoneType<>'',1,0));
End;
Export Pop_PhoneNumber_PN_stats :=TABLE(Business_Credit.Files.PhoneNumber_PN, rPhoneNumberSegment, FEW);

Shared	rTax_ID_SSN_Segment := Record// TI
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.Tax_ID_SSN_TI.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Tax_ID_SSN_TI.File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Tax_ID_SSN_TI.Parent_Sequence_Number<>'',1,0));
Account_Base_AB_Number_cnt:=sum(group,if(Business_Credit.Files.Tax_ID_SSN_TI.Account_Base_AB_Number<>'',1,0));
Federal_Tax_Id_SSN_cnt:=sum(group,if(Business_Credit.Files.Tax_ID_SSN_TI.Federal_Tax_Id_SSN<>'',1,0));
Federal_Tax_ID_SSN_Identifier_cnt:=sum(group,if(Business_Credit.Files.Tax_ID_SSN_TI.Federal_Tax_ID_SSN_Identifier<>'',1,0));
End;
Export Pop_Tax_ID_SSN_TI_stats :=TABLE(Business_Credit.Files.Tax_ID_SSN_TI, rTax_ID_SSN_Segment, FEW);

Shared	rIndividualGuarantorOwner := Record//IS
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Parent_Sequence_Number<>'',1,0));
Account_Base_AB_Number_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Account_Base_AB_Number<>'',1,0));
First_Name_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.First_Name<>'',1,0));
Middle_Name_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Middle_Name<>'',1,0));
Last_Name_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Last_Name<>'',1,0));
Suffix_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Suffix<>'',1,0));
E_Mail_Address_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.E_Mail_Address<>'',1,0));
Guarantor_Owner_Indicator_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Guarantor_Owner_Indicator<>'',1,0));
Relationship_to_Business_Indicator_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Relationship_to_Business_Indicator<>'',1,0));
Business_Title_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Business_Title<>'',1,0));
Percent_of_Liability_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Percent_of_Liability<>'',1,0));
Percent_of_Ownership_cnt:=sum(group,if(Business_Credit.Files.IndividualGuarantorOwner_IS.Percent_of_Ownership<>'',1,0));
End;
Export Pop_IndividualGuarantorOwner_IS_stats :=TABLE(Business_Credit.Files.IndividualGuarantorOwner_IS, rIndividualGuarantorOwner, FEW);

Shared	rBusiness_Guarantor_Owner := Record//BS
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.Parent_Sequence_Number<>'',1,0));
Account_Base_AB_Number_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.Account_Base_AB_Number<>'',1,0));
Business_Name_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.Business_Name<>'',1,0));
Web_Address_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.Web_Address<>'',1,0));
Guarantor_Owner_Indicator_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.Guarantor_Owner_Indicator<>'',1,0));
Relationship_to_Business_Indicator_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.Relationship_to_Business_Indicator<>'',1,0));
Percent_of_Liability_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.Percent_of_Liability<>'',1,0));
Percent_of_Ownership_If_Owner_Principal_cnt:=sum(group,if(Business_Credit.Files.Business_Guarantor_Owner_BS.Percent_of_Ownership_If_Owner_Principal<>'',1,0));
End;
Export Pop_Business_Guarantor_Owner_BS_stats :=TABLE(Business_Credit.Files.Business_Guarantor_Owner_BS, rBusiness_Guarantor_Owner, FEW);

Shared	rBusiness_Industry_Identifier := Record//BI
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.Business_Industry_Identifier_BI.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Business_Industry_Identifier_BI.File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Business_Industry_Identifier_BI.Parent_Sequence_Number<>'',1,0));
Account_Base_AB_Number_cnt:=sum(group,if(Business_Credit.Files.Business_Industry_Identifier_BI.Account_Base_AB_Number<>'',1,0));
Classification_Code_Type_cnt:=sum(group,if(Business_Credit.Files.Business_Industry_Identifier_BI.Classification_Code_Type<>'',1,0));
Classification_Code_cnt:=sum(group,if(Business_Credit.Files.Business_Industry_Identifier_BI.Classification_Code<>'',1,0));
Primary_Industry_Code_Indicator_cnt:=sum(group,if(Business_Credit.Files.Business_Industry_Identifier_BI.Primary_Industry_Code_Indicator<>'',1,0));
Privacy_Indicator_cnt:=sum(group,if(Business_Credit.Files.Business_Industry_Identifier_BI.Privacy_Indicator<>'',1,0));
End;
Export Pop_Business_Industry_Identifier_BI_stats :=TABLE(Business_Credit.Files.Business_Industry_Identifier_BI, rBusiness_Industry_Identifier, FEW);

Shared	rCollateral := Record//CL
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.Parent_Sequence_Number<>'',1,0));
Account_Base_AB_Number_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.Account_Base_AB_Number<>'',1,0));
Collateral_Indicator_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.Collateral_Indicator<>'',1,0));
Type_of_Collateral_Secured_for_this_Account_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.Type_of_Collateral_Secured_for_this_Account<>'',1,0));
Collateral_Description_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.Collateral_Description<>'',1,0));
UCC_Filing_Number_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.UCC_Filing_Number<>'',1,0));
UCC_Filing_Type_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.UCC_Filing_Type<>'',1,0));
UCC_Filing_Date_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.UCC_Filing_Date<>'',1,0));
UCC_Filing_Expiration_Date_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.UCC_Filing_Expiration_Date<>'',1,0));
UCC_Filing_Jurisdiction_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.UCC_Filing_Jurisdiction<>'',1,0));
UCC_Filing_Description_cnt:=sum(group,if(Business_Credit.Files.CollateralSegment_CL.UCC_Filing_Description<>'',1,0));
End;
Export Pop_CollateralSegment_CL_stats :=TABLE(Business_Credit.Files.CollateralSegment_CL, rCollateral, FEW);

Shared	rMember_Specific := Record//MS
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.Member_Specific_Field_MS.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Member_Specific_Field_MS.File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Member_Specific_Field_MS.Parent_Sequence_Number<>'',1,0));
Account_Base_AB_Number_cnt:=sum(group,if(Business_Credit.Files.Member_Specific_Field_MS.Account_Base_AB_Number<>'',1,0));
Name_of_value_cnt:=sum(group,if(Business_Credit.Files.Member_Specific_Field_MS.Name_of_value<>'',1,0));
ValueNum_cnt:=sum(group,if(Business_Credit.Files.Member_Specific_Field_MS.ValueNum<>'',1,0));
Privacy_Indicator_cnt:=sum(group,if(Business_Credit.Files.Member_Specific_Field_MS.Privacy_Indicator<>'',1,0));
End;
Export Pop_Member_Specific_Field_MS_stats :=TABLE(Business_Credit.Files.Member_Specific_Field_MS, rMember_Specific, FEW);

Shared	rAccount_Modification_History := Record//AH
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.Account_Modification_History_AH .Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Account_Modification_History_AH .File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Account_Modification_History_AH .Parent_Sequence_Number<>'',1,0));
Account_Base_AB_Number_cnt:=sum(group,if(Business_Credit.Files.Account_Modification_History_AH .Account_Base_AB_Number<>'',1,0));
Previous_Member_ID_cnt:=sum(group,if(Business_Credit.Files.Account_Modification_History_AH .Previous_Member_ID<>'',1,0));
Previous_Account_Number_cnt:=sum(group,if(Business_Credit.Files.Account_Modification_History_AH .Previous_Account_Number<>'',1,0));
Previous_Account_Type_cnt:=sum(group,if(Business_Credit.Files.Account_Modification_History_AH .Previous_Account_Type<>'',1,0));
Type_of_Conversion_Maintenance_cnt:=sum(group,if(Business_Credit.Files.Account_Modification_History_AH .Type_of_Conversion_Maintenance<>'',1,0));
Date_Account_Converted_cnt:=sum(group,if(Business_Credit.Files.Account_Modification_History_AH .Date_Account_Converted<>'',1,0));
End;
Export Pop_Account_Modification_History_AH_stats :=TABLE(Business_Credit.Files.Account_Modification_History_AH, rAccount_Modification_History, FEW);

Shared	rTrailer_Segment := Record//ZZ
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .File_Sequence_Number<>'',1,0));
Parent_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Parent_Sequence_Number<>'',1,0));
Total_AB_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_AB_Segments<>'',1,0));
Total_MA_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_MA_Segments<>'',1,0));
Total_AD_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_AD_Segments<>'',1,0));
Total_PN_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_PN_Segments<>'',1,0));
Total_TI_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_TI_Segments<>'',1,0));
Total_IS_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_IS_Segments<>'',1,0));
Total_BS_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_BS_Segments<>'',1,0));
Total_BI_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_BI_Segments<>'',1,0));
Total_CL_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_CL_Segments<>'',1,0));
Total_MS_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_MS_Segments<>'',1,0));
Total_AH_Segments_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Total_AH_Segments<>'',1,0));
Sum_of_Balance_Amounts_cnt:=sum(group,if(Business_Credit.Files.Trailer_Segment_ZZ .Sum_of_Balance_Amounts<>'',1,0));
End;

Export Pop_Trailer_Segment_ZZ_stats :=TABLE(Business_Credit.Files.Trailer_Segment_ZZ, rTrailer_Segment, FEW);


Shared	rFileFooter_Trailer := Record//FZ
Segment_Identifier_cnt:=sum(group,if(Business_Credit.Files.FileFooter_Trailer_FZ.Segment_Identifier<>'',1,0));
File_Sequence_Number_cnt:=sum(group,if(Business_Credit.Files.FileFooter_Trailer_FZ.File_Sequence_Number<>'',1,0));
Total_AA_Segments_cnt:=sum(group,if(Business_Credit.Files.FileFooter_Trailer_FZ.Total_AA_Segments<>'',1,0));
Total_ZZ_Segments_cnt:=sum(group,if(Business_Credit.Files.FileFooter_Trailer_FZ.Total_ZZ_Segments<>'',1,0));
Total_Record_Count_cnt:=sum(group,if(Business_Credit.Files.FileFooter_Trailer_FZ.Total_Record_Count<>'',1,0));
End;
Export Pop_FileFooter_Trailer_FZ_Stats :=TABLE(Business_Credit.Files.FileFooter_Trailer_FZ, rFileFooter_Trailer, FEW);

End;