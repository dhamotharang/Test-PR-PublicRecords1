dbase14 := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_7').base.logical(proxid = 30497239) : global;
setdots := set(dbase14,dotid);

dbase1  := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_1' ).base.logical(dotid in setdots) : global;
dbase2  := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_2' ).base.logical(dotid in setdots) : global;
dbase3  := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_3' ).base.logical(dotid in setdots) : global;
dbase4  := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_4' ).base.logical(dotid in setdots) : global;
dbase5  := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_5' ).base.logical(dotid in setdots) : global;
dbase6  := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_6' ).base.logical(dotid in setdots) : global;
dbase7  := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_7' ).base.logical(dotid in setdots) : global;
dbase8  := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_8' ).base.logical(dotid in setdots) : global;
dbase9  := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_9' ).base.logical(dotid in setdots) : global;
dbase10 := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_10').base.logical(dotid in setdots) : global;
dbase11 := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_11').base.logical(dotid in setdots) : global;
dbase12 := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_12').base.logical(dotid in setdots) : global;
dbase13 := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_13').base.logical(dotid in setdots) : global;

//dbase14 := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_14').base.logical(dotid in setdots) : global;
dbase14a := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_14a').base.logical(dotid in setdots) : global;
dbase15 := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_15').base.logical(dotid in setdots) : global;
dbase16 := BIPV2_ProxID_dev4.files(BIPV2.KeySuffix + '_16').base.logical(dotid in setdots) : global;

dagg    := BIPV2_ProxID_dev4.AggregateProxidElements(dbase14     );
dagg_1  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase1 );
dagg_2  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase2 );
dagg_3  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase3 );
dagg_4  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase4 );
dagg_5  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase5 );
dagg_6  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase6 );
dagg_7  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase7 );
dagg_8  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase8 );
dagg_9  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase9 );
dagg_10 := BIPV2_ProxID_dev4.AggregateProxidElements(dbase10);
dagg_11 := BIPV2_ProxID_dev4.AggregateProxidElements(dbase11);
dagg_12 := BIPV2_ProxID_dev4.AggregateProxidElements(dbase12);
dagg_13 := BIPV2_ProxID_dev4.AggregateProxidElements(dbase13);
//dagg_14  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase14 );
dagg_14a := BIPV2_ProxID_dev4.AggregateProxidElements(dbase14a);
dagg_15  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase15 );
dagg_16  := BIPV2_ProxID_dev4.AggregateProxidElements(dbase16 );

output(dagg   ,named('dagg'  ),all);
output(dagg_1 ,named('dagg_1'),all);
output(dagg_2 ,named('dagg_2'),all);
output(dagg_3 ,named('dagg_3'),all);
output(dagg_4 ,named('dagg_4'),all);
output(dagg_5 ,named('dagg_5'),all);
output(dagg_6 ,named('dagg_6'),all);
output(dagg_7 ,named('dagg_7'),all);
/*
output(dagg_8 ,named('dagg_8'),all);
output(dagg_9 ,named('dagg_9'),all);
output(dagg_10,named('dagg_10'),all);
output(dagg_11,named('dagg_11'),all);
output(dagg_12,named('dagg_12'),all);
output(dagg_13,named('dagg_13'),all);
//output(dagg_14 ,named('dagg_14'),all);
output(dagg_14a,named('dagg_14a'),all);
output(dagg_15 ,named('dagg_15'),all);
output(dagg_16 ,named('dagg_16'),all);
*/
output(dbase14 ,named('dbase14'),all);
output(dbase1  ,named('dbase1'),all);
output(dbase2  ,named('dbase2'),all);
output(dbase3  ,named('dbase3'),all);
output(dbase4  ,named('dbase4'),all);
output(dbase5  ,named('dbase5'),all);
output(dbase6  ,named('dbase6'),all);
output(dbase7  ,named('dbase7'),all);
/*
output(dbase8  ,named('dbase8'),all);
output(dbase9  ,named('dbase9'),all);
output(dbase10 ,named('dbase10'),all);
output(dbase11 ,named('dbase11'),all);
output(dbase12 ,named('dbase12'),all);
output(dbase13 ,named('dbase13'),all);
//output(dbase14  ,named('dbase14'),all);
output(dbase14a ,named('dbase14a'),all);
output(dbase15  ,named('dbase15'),all);
output(dbase16  ,named('dbase16'),all);
*/