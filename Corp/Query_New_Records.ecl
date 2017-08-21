mycorp := Corp.File_Corp_Base;
contact	:= Corp.File_Corp_Cont_Base;


do1 := output(topn(mycorp, 100, -(unsigned4)dt_last_seen), named('CorpNewRecords'));
do2 := output(topn(contact, 100, -(unsigned4)dt_last_seen), named('ContactNewRecords'));

export Query_New_Records := sequential(do1, do2);