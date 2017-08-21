/*
 * This is extremely messy at the moment.  I am putting all of the ecl into one attribute so that I can complete
 * my version of boolean search.  Below are three sets of ecl that I used.
 *
 * 1st) 
 *     convert data to x,y points. 
 *     create initial sample cluster (grid points)
 *     calculate the distance from data to cluster points (exclude points beyond a certain distance to speed things up)
 *     take the minimum distance points and recalculate cluster points
 *
 * 2nd and third) used to take newly created cluster to repeat process
 */
export Kmeans := 'todo';

/*
 *
 *
 *
 * 1st
 *
 *
 */
REAL4 euclidean_distance(REAL4 x1,REAL4 y1,REAL4 x2,REAL4 y2) := FUNCTION
	return SQRT((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
END;

/*
 * Std dev data definition
 */
layout := buzzsaw.Mod_Data.L_Firewall_Stats;
ds := buzzsaw.Mod_Data.DS_StdDev(mean>0.0001 AND stdev>0.0001);

Layout_Data := RECORD
	REAL4 x;
	REAL4 y;
END;

Layout_Distance_Metrics := RECORD
	Layout_Data data_point;
	Layout_Data cluster_point;
	REAL4 distance;
END;

/*
 * Convert to log and make positive
 */
Layout_Data apply_ln(layout l) := TRANSFORM
	SELF.x := log(l.mean)+5;
	SELF.y := log(l.stdev)+5;
END;

ds_ln := PROJECT(ds,apply_ln(LEFT));

/*
 * Generate initial cluster set
 */
min_mean := MIN(ds_ln,x);
max_mean := MAX(ds_ln,x);
min_stdev := MIN(ds_ln,y);
max_stdev := MAX(ds_ln,y);

x_resolution := 40;
x_min        := min_mean;
x_range      := max_mean-min_mean;
x_increment  := x_range/x_resolution;

y_resolution := 40;
y_min        := min_stdev;
y_range      := max_stdev-min_stdev;
y_increment  := y_range/y_resolution;

Layout_Data x_normit(Layout_Data l, INTEGER c) := TRANSFORM
	SELF.x := x_min + (c-0.5)*x_increment;
	SELF.y := 0;
END;

Layout_Data y_normit(Layout_Data l, INTEGER c) := TRANSFORM
	SELF.x := l.x;
	SELF.y := y_min + (c-0.5)*y_increment;
END;

blankset := DATASET([{0,0}],Layout_Data);

ds_x  := NORMALIZE(blankset,x_resolution,x_normit(LEFT,COUNTER));
ds_xy := NORMALIZE(ds_x,y_resolution,y_normit(LEFT,COUNTER));
//output(ds_xy,NAMED('Initial_Cluster'),'~smd::init_stdev_cluster_1600',CSV);
//output(ds_xy,,'~smd::init_stdev_cluster_1600',CSV,OVERWRITE);

/*
 * Join original data with cluster points to calculate distances
 * exclude points that have distance greater than 1
 */
Layout_Distance_Metrics cluster_points(Layout_Data l,Layout_Data r) := TRANSFORM
	SELF.data_point := l;
	SELF.cluster_point := r;
	SELF.distance := 1+euclidean_distance(l.x,l.y,r.x,r.y);
END;

ds_cluster_metrics := JOIN(
	ds_ln,
	ds_xy,
	euclidean_distance(LEFT.x,LEFT.y,RIGHT.x,RIGHT.y)<1,
	cluster_points(LEFT,RIGHT),ALL
);

/*
 * Take the closest cluster point for each data point
 */
ds_cluster_dist := DISTRIBUTE(ds_cluster_metrics,HASH32(data_point.x));
ds_cluster_sort := SORT(ds_cluster_dist,data_point.x,data_point.y,LOCAL);

Layout_Distance_Metrics associate_data_with_cluster_point(Layout_Distance_Metrics l,Layout_Distance_Metrics r) := TRANSFORM
	SELF.data_point := l.data_point;
	SELF.cluster_point := IF(l.distance=0,r.cluster_point,IF(r.distance<l.distance,r.cluster_point,l.cluster_point));
	SELF.distance := IF(l.distance=0,r.distance,IF(r.distance<l.distance,r.distance,l.distance));
END;
ds_cluster_table := ROLLUP(ds_cluster_sort,LEFT.data_point=RIGHT.data_point,associate_data_with_cluster_point(LEFT,RIGHT));

/*
 * Group by cluster point then average the data points for the next set of cluster points
 */
ds_cluster_table_new_cluster := TABLE(ds_cluster_table,{x := AVE(GROUP,data_point.x), y := AVE(GROUP,data_point.y)},cluster_point.x,cluster_point.y);

//output(ds_cluster_sort);
//output(ds_cluster_table);
//output(ds_cluster_table_new_cluster,NAMED('First_Iteration'));
//output(ds_cluster_table_new_cluster,,'~smd::init_stdev_cluster_1600_1st_iteration',CSV,OVERWRITE);
output(ds_cluster_table_new_cluster,,'~smd::init_stdev_cluster_1600_1st_iteration_thor',OVERWRITE);






/*
 *
 *
 *
 * 2nd
 *
 *
 */
REAL4 euclidean_distance(REAL4 x1,REAL4 y1,REAL4 x2,REAL4 y2) := FUNCTION
	return SQRT((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
END;

/*
 * Std dev data definition
 */
layout := buzzsaw.Mod_Data.L_Firewall_Stats;
ds := buzzsaw.Mod_Data.DS_StdDev(mean>0.0001 AND stdev>0.0001);

Layout_Data := RECORD
	REAL8 x;
	REAL8 y;
END;

Layout_Distance_Metrics := RECORD
	Layout_Data data_point;
	Layout_Data cluster_point;
	REAL4 distance;
END;

/*
 * Convert to log and make positive
 */
Layout_Data apply_ln(layout l) := TRANSFORM
	SELF.x := log(l.mean)+5;
	SELF.y := log(l.stdev)+5;
END;

ds_ln := PROJECT(ds,apply_ln(LEFT));

ds_cluster_1 := DATASET('~smd::init_stdev_cluster_1600_1st_iteration_thor',Layout_Data,THOR);




/*
 * Join original data with cluster points to calculate distances
 * exclude points that have distance greater than 1
 */
Layout_Distance_Metrics cluster_points(Layout_Data l,Layout_Data r) := TRANSFORM
	SELF.data_point := l;
	SELF.cluster_point := r;
	SELF.distance := 1+euclidean_distance(l.x,l.y,r.x,r.y);
END;

ds_cluster_metrics := JOIN(
	ds_ln,
	ds_cluster_1,
	euclidean_distance(LEFT.x,LEFT.y,RIGHT.x,RIGHT.y)<0.4,
	cluster_points(LEFT,RIGHT),ALL
);

ds_cluster_dist := DISTRIBUTE(ds_cluster_metrics,HASH32(data_point.x));
ds_cluster_sort := SORT(ds_cluster_dist,data_point.x,data_point.y,LOCAL);

Layout_Distance_Metrics associate_data_with_cluster_point(Layout_Distance_Metrics l,Layout_Distance_Metrics r) := TRANSFORM
	SELF.data_point := l.data_point;
	SELF.cluster_point := IF(l.distance=0,r.cluster_point,IF(r.distance<l.distance,r.cluster_point,l.cluster_point));
	SELF.distance := IF(l.distance=0,r.distance,IF(r.distance<l.distance,r.distance,l.distance));
END;
ds_cluster_table := ROLLUP(ds_cluster_sort,LEFT.data_point=RIGHT.data_point,associate_data_with_cluster_point(LEFT,RIGHT));

/*
 * Group by cluster point then average the data points for the next set of cluster points
 */
ds_cluster_table_new_cluster := TABLE(ds_cluster_table,{x := AVE(GROUP,data_point.x), y := AVE(GROUP,data_point.y)},cluster_point.x,cluster_point.y);

//output(ds_cluster_sort);
//output(ds_cluster_table);
//output(ds_cluster_table_new_cluster,NAMED('First_Iteration'));
output(ds_cluster_table_new_cluster,,'~smd::init_stdev_cluster_1600_2nd_iteration',CSV,OVERWRITE);
//output(ds_cluster_table_new_cluster,,'~smd::init_stdev_cluster_1600_1st_iteration_thor',OVERWRITE);













/*
 *
 *
 *
 * 3rd
 *
 *
 */
 REAL4 euclidean_distance(REAL4 x1,REAL4 y1,REAL4 x2,REAL4 y2) := FUNCTION
	return SQRT((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
END;

/*
 * Std dev data definition
 */
layout := buzzsaw.Mod_Data.L_Firewall_Stats;
ds := buzzsaw.Mod_Data.DS_StdDev(mean>0.0001 AND stdev>0.0001);

Layout_Data := RECORD
	REAL8 x;
	REAL8 y;
END;

Layout_Distance_Metrics := RECORD
	Layout_Data data_point;
	Layout_Data cluster_point;
	REAL4 distance;
END;

/*
 * Convert to log and make positive
 */
Layout_Data apply_ln(layout l) := TRANSFORM
	SELF.x := log(l.mean)+5;
	SELF.y := log(l.stdev)+5;
END;

ds_ln := PROJECT(ds,apply_ln(LEFT));

ds_cluster_1 := DATASET('~smd::init_stdev_cluster_1600_9th_iteration',Layout_Data,CSV);




/*
 * Join original data with cluster points to calculate distances
 * exclude points that have distance greater than 1
 */
Layout_Distance_Metrics cluster_points(Layout_Data l,Layout_Data r) := TRANSFORM
	SELF.data_point := l;
	SELF.cluster_point := r;
	SELF.distance := 1+euclidean_distance(l.x,l.y,r.x,r.y);
END;

ds_cluster_metrics := JOIN(
	ds_ln,
	ds_cluster_1,
	euclidean_distance(LEFT.x,LEFT.y,RIGHT.x,RIGHT.y)<0.05,
	cluster_points(LEFT,RIGHT),ALL
);

ds_cluster_dist := DISTRIBUTE(ds_cluster_metrics,HASH32(data_point.x));
ds_cluster_sort := SORT(ds_cluster_dist,data_point.x,data_point.y,LOCAL);

Layout_Distance_Metrics associate_data_with_cluster_point(Layout_Distance_Metrics l,Layout_Distance_Metrics r) := TRANSFORM
	SELF.data_point := l.data_point;
	SELF.cluster_point := IF(l.distance=0,r.cluster_point,IF(r.distance<l.distance,r.cluster_point,l.cluster_point));
	SELF.distance := IF(l.distance=0,r.distance,IF(r.distance<l.distance,r.distance,l.distance));
END;
ds_cluster_table := ROLLUP(ds_cluster_sort,LEFT.data_point=RIGHT.data_point,associate_data_with_cluster_point(LEFT,RIGHT));

/*
 * Group by cluster point then average the data points for the next set of cluster points
 */
ds_cluster_table_new_cluster := TABLE(ds_cluster_table,{x := AVE(GROUP,data_point.x), y := AVE(GROUP,data_point.y)},cluster_point.x,cluster_point.y);

//output(ds_cluster_sort);
//output(ds_cluster_table);
//output(ds_cluster_table_new_cluster,NAMED('First_Iteration'));
output(ds_cluster_table_new_cluster,,'~smd::init_stdev_cluster_1600_10th_iteration',CSV,OVERWRITE);
//output(ds_cluster_table_new_cluster,,'~smd::init_stdev_cluster_1600_1st_iteration_thor',OVERWRITE);
