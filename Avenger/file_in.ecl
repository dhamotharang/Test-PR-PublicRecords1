import ut, avenger;

EXPORT file_in := module

export question :=

dataset(ut.foreign_prod + 'thor_data400::in::avenger::verid::question', avenger.layout_in.question, csv(separator('~|~'), heading(1), quote('')));

export transaction := 

dataset(ut.foreign_prod + 'thor_data400::in::avenger::verid::transaction', avenger.layout_in.transaction, csv(separator('~|~'), heading(1), quote('')))(TRANSACTIONSTARTTIME <> '');


export transaction_201201 := 
dataset(ut.foreign_prod + 'thor_data400::in::avenger::verid::transaction', avenger.layout_in.transaction, csv(separator('|'), heading(1), quote('')))(~regexfind('~', transactionid ));
;

export quiz := 

dataset(ut.foreign_prod +'thor_data400::in::avenger::idm::quiz', avenger.layout_in.quiz, csv(separator('~|~'), heading(1), quote('')));

export quiz_processed := 

dataset(ut.foreign_prod +'thor_data400::in::avenger::idm::quiz::processed', avenger.layout_in.quiz, csv(separator('~|~'), heading(1), quote('')));

export assertion :=

dataset(ut.foreign_prod + 'thor_data400::in::avenger::assertion_jan_jul', avenger.layout_in.assertion, csv(separator('|'), heading(1), quote('')));

export factranking :=

dataset(ut.foreign_prod + 'thor_data400::in::avenger::verid::factranking::201403', avenger.layout_in.factranking, csv(separator('~|~'), heading(1), quote('')));


export VERID_lookup := dataset(ut.foreign_prod + 'thor_data400::in::avenger::lookup_20140910',avenger.layout_in.lookup_rec, csv(separator('~|~'), heading(1), quote('')));

invalid_account_layout := record

string company_id;
string	company_name;
string	Account_id;
string	account_name;
string	active;

end;

export invalid_idm_account := dataset(ut.foreign_prod + 'thor_data400::in::idm_invalid_account', invalid_account_layout, CSV(heading(1), separator([',']), TERMINATOR(['\n'])));


end;