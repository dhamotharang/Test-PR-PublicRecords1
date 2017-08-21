import demo_data;
import property;

file_in:= scramble_foreclosure2c;

property.Layout_Fares_Foreclosure to_base(file_in l) := transform
self := l;
end;

export scramble_foreclosure1 := dedup(sort(project(file_in,to_base(LEFT)),record),all);	// : persist('thor::persist::scramble_foreclosure_a');


