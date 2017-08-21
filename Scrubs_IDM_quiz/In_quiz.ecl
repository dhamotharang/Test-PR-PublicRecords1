import ut;
EXPORT In_quiz := dataset(ut.foreign_prod +'thor_data400::in::avenger::idm::quiz', scrubs_IDM_quiz.layout_quiz, csv(separator('~|~'), heading(1), quote('')), opt);
