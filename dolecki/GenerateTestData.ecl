Layout_Point := RECORD
	REAL4 x;
	REAL4 y;
END;

blankset := DATASET([{0,0}],Layout_Point);

x_resolution := 10;
x_min        := 0;
x_range      := 20;
x_increment  := x_range/x_resolution;

y_resolution := 10;
y_min        := 0;
y_range      := 20;
y_increment  := y_range/y_resolution;

Layout_Point x_normit(Layout_Point l, INTEGER c) := TRANSFORM
	SELF.x := x_min + (c-0.5)*x_increment;
	SELF.y := 0;
END;

Layout_Point y_normit(Layout_Point l, INTEGER c) := TRANSFORM
	SELF.x := l.x;
	SELF.y := y_min + (c-0.5)*y_increment;
END;

ds_x  := NORMALIZE(blankset,x_resolution,x_normit(LEFT,COUNTER));
ds_xy := NORMALIZE(ds_x,y_resolution,y_normit(LEFT,COUNTER));

output(ds_xy);

export GenerateTestData := 'todo';