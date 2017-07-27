#stored ('watchtype','compid');
#if((compID.IsWeekly and compID.IsMonthly) or (~compID.IsWeekly and ~compID.IsMonthly) )
#fail
#end
CompID.Build_compID;