IMPORT Data_Services;

export Cluster
 :=
  module

  export Cluster_In := '~thor_data400::';	
	export Cluster_Out := Data_Services.Data_location.Prefix('FBNV2') + 'thor_data400::';
  end
 ;