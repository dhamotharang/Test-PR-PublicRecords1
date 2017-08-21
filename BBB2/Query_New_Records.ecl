Member		:= Files().Base.Member.QA;
Nonmember	:= Files().Base.NonMember.QA;


do1 := output(topn(Member, 100, -(unsigned4)date_last_seen), named('BbbMemberSampleRecsForQA'));
do2 := output(topn(Nonmember, 100, -(unsigned4)date_last_seen), named('BbbNonMemberSampleRecsForQA'));

export Query_New_Records := sequential(do1, do2);