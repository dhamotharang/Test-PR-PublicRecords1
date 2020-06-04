layout := BIPv2_HRCHY_Platform.Layouts.prep_r2;

simpleLayout := {
	layout.proxid,
	layout.id,
	layout.parent_id,
	layout.ultimate_id,
	layout.is_sele_level,
	layout.src,
	layout.name,
	typeof(layout.dt_last_seen) dt_last_seen := 0;
};

ds := dataset([

// child from another source
 {1001, 1, 0, 1, false, 'L', 'Alpha'}
,{1002, 2, 1, 1, false, 'L', 'Alpha'}
,{1001, 3, 0, 3, false, 'D', 'Alpha'}
,{1004, 4, 3, 3, false, 'D', 'Alpha'}

// missing parent
,{1010, 10, 11, 10, false, 'L', 'Bravo'}

// parent/child with different ultimate_ids
,{1020, 20, 0, 20, false, 'L', 'Charlie'}
,{1021, 21, 20, 21, false, 'L', 'Charlie'}

// children with missing parent/ultimate and multiple proxids on a single id
,{1030, 30, 33, 33, false, 'L', 'Delta'}
,{1031, 30, 33, 33, false, 'L', 'Delta'}
,{1032, 32, 33, 33, false, 'L', 'Delta'}

// same proxid/id with differnt ultimates
,{1040, 40, 41, 41, false, 'L', 'Echo1'}
,{1041, 41,  0, 41, false, 'L', 'Echo1'}
,{1040, 40, 42, 42, false, 'L', 'Echo2'}
,{1042, 42,  0, 42, false, 'L', 'Echo2'}

// missing intermediate node
,{1050, 50,  0, 50, false, 'L', 'Fox'}
,{1052, 52, 51, 50, false, 'L', 'Fox'}
,{1053, 53, 52, 50, false, 'L', 'Fox'}

// intermediate nodes with proxid = 0
,{1060, 60,  0, 60, false, 'L', 'Golf'}
,{0,    61, 60, 60, false, 'L', 'Golf'}
,{0,    62, 61, 60, false, 'L', 'Golf'}
,{0,    63, 62, 60, false, 'L', 'Golf'}
,{1064, 64, 63, 60, false, 'L', 'Golf'}

// don't promote one of the siblings because they are leaves
,{1070, 70, 0, 70, false, 'L', 'Hotel'}
,{1071, 71, 70, 70, false, 'L', 'Hotel'}
,{1072, 71, 70, 70, false, 'L', 'Hotel'}
,{1073, 71, 70, 70, false, 'L', 'Hotel'}
,{1074, 71, 70, 70, false, 'L', 'Hotel'}

// same ids but different sources so not related
,{1080, 80,  0, 80, false, 'L', 'India1'}
,{1081, 81, 80, 80, false, 'L', 'India1'}
,{1082, 80,  0, 80, false, 'D', 'India2'}
,{1083, 81, 80, 80, false, 'D', 'India2'}

// higher rank source doesn't have parents or children
,{1090, 90,  0, 90, false, 'L', 'Juliett'}
,{1090, 90,  0, 90, false, 'D', 'Juliett'}
,{1091, 91, 90, 90, false, 'D', 'Juliett'}

// move children
,{1100, 100,   0, 100, false, 'L', 'Kilo'}
,{1102, 102, 100, 100, false, 'L', 'Kilo'}
,{1100, 100,   0, 100, false, 'D', 'Kilo'}
,{1101, 101, 100, 100, false, 'D', 'Kilo'}
,{1102, 102, 101, 100, false, 'D', 'Kilo'}
,{1103, 103, 102, 100, false, 'D', 'Kilo'}
,{1104, 104, 103, 100, false, 'D', 'Kilo'}

// merge hier
,{1110, 110,   0, 110, false, 'L', 'Lima'}
,{1111, 111, 110, 110, false, 'L', 'Lima'}

,{1111, 111,   0, 111, false, 'D', 'Lima'}
,{1112, 112, 111, 111, false, 'D', 'Lima'}

,{1112, 112,   0, 112, false, 'L', 'Lima'}
,{1113, 113, 112, 112, false, 'L', 'Lima'}

,{1113, 113,   0, 113, false, 'D', 'Lima'}
,{1114, 114, 113, 113, false, 'D', 'Lima'}

,{1114, 114,   0, 114, false, 'L', 'Lima'}
,{1115, 115, 114, 114, false, 'L', 'Lima'}

// move children
,{1120, 120, 0, 120, false, 'L', 'Mike'}
,{1121, 121, 120, 120, false, 'L', 'Mike'}
,{1120, 120, 0, 120, false, 'D', 'Mike'}
,{1121, 121, 120, 120, false, 'D', 'Mike'}
,{1120, 121, 0, 121, false, 'F', 'Mike'}
,{1122, 122, 121, 121, false, 'F', 'Mike'}
,{1123, 123, 122, 121, false, 'F', 'Mike'}

// move parent based on source ranking
,{1135, 135, 0, 135, false, 'L', 'November'}
,{1136, 136, 135, 135, false, 'L', 'November'}
,{1134, 134, 0, 134, false, 'D', 'November'}
,{1135, 135, 134, 134, false, 'D', 'November'}
,{1133, 133, 0, 133, false, 'F', 'November'}
,{1135, 135, 133, 133, false, 'F', 'November'}

// move parents
,{1145, 145, 0, 145, false, 'L', 'Oscar'}
,{1146, 146, 145, 145, false, 'L', 'Oscar'}
,{1143, 143, 0, 143, false, 'D', 'Oscar'}
,{1144, 144, 143, 143, false, 'D', 'Oscar'}
,{1145, 145, 144, 143, false, 'D', 'Oscar'}
,{1142, 142, 0, 142, false, 'F', 'Oscar'}
,{1143, 143, 142, 142, false, 'F', 'Oscar'}

// circular loop
,{1150, 150, 0, 150, false, 'L', 'Papa'}
,{1151, 151, 150, 150, false, 'L', 'Papa'}
,{1152, 152, 0, 152, false, 'L', 'Papa'}
,{1153, 153, 152, 152, false, 'L', 'Papa'}
,{1151, 151, 0, 151, false, 'D', 'Papa'}
,{1152, 152, 151, 151, false, 'D', 'Papa'}
,{1153, 153, 0, 153, false, 'D', 'Papa'}
,{1150, 150, 153, 153, false, 'D', 'Papa'}

// combine hiers
,{1160, 160, 0, 160, false, 'L', 'Quebec'}
,{1161, 161, 160, 160, false, 'L', 'Quebec'}
,{1162, 162, 0, 162, false, 'L', 'Quebec'}
,{1163, 163, 162, 162, false, 'L', 'Quebec'}
,{1160, 160, 0, 160, false, 'D', 'Quebec'}
,{1162, 162, 160, 160, false, 'D', 'Quebec'}

// proxid = 0 and missing parent
,{0, 170, 0, 170, false, 'L', 'Romeo'}
,{0, 171, 170, 170, false, 'L', 'Romeo'}
,{1172, 172, 171, 170, false, 'L', 'Romeo'}
,{1174, 174, 173, 170, false, 'L', 'Romeo'}
,{0, 174, 173, 170, false, 'L', 'Romeo'}
,{1175, 175, 174, 170, false, 'L', 'Romeo'}

// promote one of the siblings
,{1180, 180, 0, 180, false, 'L', 'Sierra'}
,{1181, 181, 180, 180, false, 'L', 'Sierra'}
,{1182, 181, 180, 180, false, 'L', 'Sierra'}
,{1183, 181, 180, 180, false, 'L', 'Sierra'}
,{1184, 184, 181, 180, false, 'L', 'Sierra'}

// proxid is it's own parent
,{1190, 190, 0, 190, false, 'L', 'Tango'}
,{1191, 191, 190, 190, false, 'L', 'Tango'}
,{1191, 192, 191, 190, false, 'L', 'Tango'}

// same id/src/proxid/ultimate_id but different parent
,{1200, 200, 0, 200, false, 'L', 'Uniform'}
,{1201, 201, 200, 200, false, 'L', 'Uniform'}
,{1202, 202, 200, 200, false, 'L', 'Uniform'}
,{1203, 203, 200, 200, false, 'L', 'Uniform'}
,{1204, 204, 201, 200, false, 'L', 'Uniform', 20150101}
,{1204, 204, 202, 200, false, 'L', 'Uniform', 20160101}
,{1204, 204, 203, 200, false, 'L', 'Uniform', 20150101}

// 1214 should belong to 1210
,{1210, 210, 0, 210, false, 'L', 'Victor'}
,{1212, 219, 210, 210, false, 'L', 'Victor'}
,{1214, 214, 219, 210, false, 'L', 'Victor'}
,{1211, 211, 0, 211, false, 'L', 'Victor'}
,{1212, 212, 211, 211, false, 'L', 'Victor'}
,{1213, 213, 212, 211, false, 'L', 'Victor'}

// circular loop
,{1220, 220, 0, 220, false, 'L', 'Whiskey'}
,{1221, 221, 220, 220, false, 'L', 'Whiskey'}
,{1222, 222, 220, 220, false, 'L', 'Whiskey'}
,{1222, 222, 0, 222, false, 'D', 'Whiskey'}
,{1220, 220, 222, 222, false, 'D', 'Whiskey'}

// 230 should become direct parent of 233
,{1230, 230, 0, 230, false, 'L', 'X-ray'}
,{1231, 231, 230, 230, false, 'L', 'X-ray'}
,{1232, 231, 230, 230, false, 'L', 'X-ray'}
,{1233, 233, 231, 230, false, 'L', 'X-ray'}
,{1231, 239, 0, 239, false, 'L', 'X-ray'}
,{1232, 238, 239, 239, false, 'L', 'X-ray'}

// circular in more than one way
,{1240, 240, 0, 240, false, 'L', 'Yankee'}
,{0, 241, 242, 240, false, 'L', 'Yankee'}
,{0, 241, 240, 240, false, 'L', 'Yankee'}
,{0, 242, 241, 240, false, 'L', 'Yankee'}
,{0, 242, 240, 240, false, 'L', 'Yankee'}
,{1243, 243, 242, 240, false, 'L', 'Yankee'}
,{1244, 244, 241, 240, false, 'L', 'Yankee'}
,{0, 245, 245, 240, false, 'L', 'Yankee'}
,{1246, 246, 245, 240, false, 'L', 'Yankee'}

       ], simpleLayout);

export _TestData := module
	export input := project(ds, transform(layout, self := left, self := []));

end;