import ut;
export in_question :=
dataset(ut.foreign_prod + 'thor_data400::in::avenger::verid::question', scrubs_verid_question.layout_question, csv(separator('~|~'), heading(1), quote('')), opt);
