import doxie, tools, std, lib_stringlib, Bair;

export Keys(

	 string	 version		= ''
	,boolean pUseProd 	= false
	,boolean pUseDelta 	= false
) :=
module
	
	DataProvider := Bair.files().dataprovider_base.built;
	Layers			 := Bair_layers.Files(version,pUseProd,pUseDelta).Layers_Base.Built(data_provider_id <> 0);
	
	shared layers_search_base := join(Layers, DataProvider, left.data_provider_id = right.data_provider_id
																,transform(Bair_layers.layouts.Layers_Search_Base
																	,self.AgencyName := right.data_provider_name
																	,self := left
																	)
																,lookup
																);
																
	shared layers_payload_base := bair_layers.files(version,pUseProd,pUseDelta).Layers_Payload_Base.Keybuild;

	tools.mac_FilesIndex('layers_search_base	,	{gh4,minx,miny,maxx,maxy},{layers_search_base}'	,bair_layers.keynames(version,pUseProd,pUseDelta).agencylayer_search_key 	,	AgencyLayers_Search);
	tools.mac_FilesIndex('layers_payload_base	,	{layerid,geotype}, {__filepos}'									,bair_layers.keynames(version,pUseProd,pUseDelta).agencylayer_payload_key ,	AgencyLayers_Payload);
	
end;
