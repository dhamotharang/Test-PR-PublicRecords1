﻿
EXPORT MAC_Add_Sort_Random(DSToDo) := FUNCTIONMACRO

		RETURN SORT( PROJECT(DSToDo,TRANSFORM({UNSIGNED6 RND_NUM, RECORDOF(DSToDo) }, SELF.RND_NUM := RANDOM(), SELF := LEFT)), RND_NUM);

ENDMACRO;

