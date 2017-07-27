/*--SOAP--
<message name="VinDecoderService" wuTimeout="300000">
	<part name="VIN" 	type = 'xsd:string' />
	<part name="VINBatch_in" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

IMPORT vehicleV2_services;
export VinDecoderService() := function
	string30 vin := '' : stored('VIN');
  
	batch_rec_layout:=record
		VehicleV2_Services.Layout_Vehicle_Vin.vin;
	end;
	
	vin_batch_in := DATASET ([], batch_rec_layout) : STORED ('VINBatch_in', FEW);

	vin_ds_batch := project(vin_batch_in,transform(VehicleV2_Services.Layout_Vehicle_Vin,self:=left,self:=[]));
  vin_ds_single := dataset([{vin,''}],VehicleV2_Services.Layout_Vehicle_Vin);
  vin_ds := if(vin<>'',vin_ds_single,vin_ds_batch);

	vina_data_all:=dedup(VehicleV2_Services.Get_Polk_Vina_Data(vin_ds,true),record);
	vina_data:=if(vin<>'',choosen(vina_data_all,Vina.Constants.MaxVinDecoderRows),vina_data_all);
	
	Vin_final := project(vina_data, VehicleV2_Services.Layout_Report_Vehicle);					 
	return output(Vin_final, named('Results'));

end;

//KMHLA32J*JA****** will return dups