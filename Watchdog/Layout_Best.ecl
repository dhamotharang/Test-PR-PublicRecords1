import _Control, watchdog;

boolean is_NewLayout:=true ; // for build set to true so it will build the file in new layout 
 
watchdog.Mac_layout_Best(watchdog.layout_Best_v2,is_NewLayout,outlayout); 

export Layout_Best :=  outlayout;
