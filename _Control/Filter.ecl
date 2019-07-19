IMPORT $.^._Control;

EXPORT Filter(FilterSet, FilterId, ds, id) :=
MACRO
	IF(COUNT(FilterSet) <= 0, 
	   ds,
	   JOIN(DISTRIBUTE(ds, HASH64((TYPEOF(FilterSet.FilterId))id)), DISTRIBUTE(FilterSet(FilterId > (TYPEOF(FilterId)) ''), HASH64(FilterId)),
	        (TYPEOF(RIGHT.FilterId))LEFT.id = RIGHT.FilterId, TRANSFORM(LEFT), LOCAL))
ENDMACRO;