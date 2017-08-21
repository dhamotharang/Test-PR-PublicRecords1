IMPORT ut;

EXPORT new_record_sample(string fileDate) := function
	Impulse_Email_Base	:=	dataset('~thor_data400::base::impulse_email', layouts.layout_Impulse_Email_final, THOR);
	Impulse_Email_Sample_Recs	:=	OUTPUT(CHOOSEN(Impulse_Email_Base(file_date = fileDate), 1000), NAMED('Impulse_Email_Sample_QA'));
	RETURN Impulse_Email_Sample_Recs;
END;