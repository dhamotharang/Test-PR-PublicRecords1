mybase := DCA.File_DCA_Base;

do1 := output(topn(mybase, 100, -(unsigned4)process_date), named('DcaSampleRecsForQA'));
do2 := output(topn(mybase, 100, -(unsigned4)update_date), named('DcaUpdateDateSampleRecsForQA'));



export Query_New_Records := sequential(do1,do2);