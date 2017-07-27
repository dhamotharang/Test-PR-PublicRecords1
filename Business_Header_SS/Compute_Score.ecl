IMPORT did_add;

EXPORT UNSIGNED1 compute_score
(
	UNSIGNED6 left_bdid,
	UNSIGNED6 right_bdid,
	UNSIGNED1 left_name_score,
	UNSIGNED1 right_name_score,
	UNSIGNED1 left_score,
	UNSIGNED1 right_score
) := 
IF(right_bdid = 0 OR (left_name_score > right_name_score AND left_bdid != right_bdid), 
	left_score, 
	IF(left_bdid = 0 OR (left_name_score < right_name_score AND left_bdid != right_bdid), 
		right_score,
		did_add.compute_score(
			left_bdid, right_bdid, 
			left_score, right_score)));