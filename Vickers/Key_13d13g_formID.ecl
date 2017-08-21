
import doxie;

df := file_13d13g_base_bid(form_id != '' and cusip != '' );

export Key_13d13g_formID  := index(df,{form_id,cusip},{df},'~thor_data400::key::vickers_13d13g_formID_' + doxie.Version_SuperKey);
