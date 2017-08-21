 import doxie;

df := vickers.File_Insider_Filing_Base_bid(form_id != '' and cusip != '' );
export Key_Insider_Filing_formID := index(df,{form_id,cusip},{df},'~thor_data400::key::vickers_insider_filing_formID_' + doxie.Version_SuperKey);
