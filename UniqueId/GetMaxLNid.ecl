EXPORT integer GetMaxLNid(string entityid) := IF(entityid[1..2]='LN',
					(integer)entityid[3..] + 1, 1);
