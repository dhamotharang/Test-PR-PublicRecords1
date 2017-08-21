update_file:= DATASET('~thor400_84::in::experian::cp', Experian_Evaluation.Layout_Experian_CP_In, THOR);
full_file1:= DATASET('~thor400_84::in::experian::cp_full', Experian_Evaluation.Layout_Experian_CP_In, THOR);
full_file4:= DATASET('~thor400_84::in::experian::cpchf04f', Experian_Evaluation.Layout_Experian_CP_In, THOR);
full_file5:= DATASET('~thor400_84::in::experian::cpchf05f', Experian_Evaluation.Layout_Experian_CP_In, THOR);

full_file:= full_file1 + full_file4 + full_file5;

Layout_Rec_Type := RECORD
	Experian_Evaluation.Layout_Experian_CP_In;
	STRING1 RecType;
END;

Layout_Rec_Type t_rec_type_update (update_file L) := TRANSFORM
	SELF.RecType := 'U';
	SELF := L;
END;

t_update := PROJECT(update_file, t_rec_type_update(LEFT));

Layout_Rec_Type t_rec_type_full (full_file L) := TRANSFORM
	SELF.RecType := 'F';
	SELF := L;
END;

t_full := PROJECT(full_file, t_rec_type_full(LEFT));


export File_Experian_CP_In := t_update + t_full;
