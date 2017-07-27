EXPORT files := MODULE
	export file_Impulse_Email_In		:=	DATASET(Impulse_Email.cluster + 'in::impulse_email::using::impulse_email', layouts.layout_Impulse_Email_Dates_append, THOR);
	export file_Impulse_Email_Base	:=	DATASET(Impulse_Email.cluster + 'base::impulse_email', layouts.layout_Impulse_Email_final, THOR);
END;