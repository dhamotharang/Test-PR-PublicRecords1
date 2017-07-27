import doxie;

MAC_Field_Declare()

sif := record
	string state 	:= state_value;
	string did 	:= did_value;
	string rtype 	:= rtype_value;
	string id		:= id_value;
	string b_date := date_b_value;
	string e_date := date_e_value;
	integer b_seq	:= seq_b_value;
	integer e_seq	:= seq_e_value;
	integer seq := seq_value;
	boolean isANeighbor := true;
	set of unsigned6 dids := did_values;
	Layout_DidSearch didData := did_data;
end;
  
doxie.MAC_LocalRemoteCombo(sif, Image_Local, 
						'Images.Image_All', neighbor_service, 
						Layout_ImageService, id != '',
						'Image_Errors', results_out) 

export Image_Records := results_out;