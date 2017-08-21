export _Extract_Superfiles := sequential(


//payload
FileServices.CreateSuperFile(FLAccidents.Constants.cluster  + '::out::promonitor::accidents',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster  + '::out::promonitor::accidents_delete',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster  + '::out::promonitor::accidents_father',false)
);
