EXPORT fn_AssignId(DATASET(Layout_Flat) src) := FUNCTION

	return 	src(Entity_Unique_ID<>'') &
					PROJECT(src(Entity_Unique_ID=''), TRANSFORM(Layout_Flat,
								self.Entity_Unique_ID := 'LN' + IntFormat(LEFT.primaryKey, 10, 1);
								self := LEFT;));
								
END;