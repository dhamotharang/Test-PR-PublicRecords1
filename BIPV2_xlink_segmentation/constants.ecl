EXPORT constants := module
// EXPORT GOOD_CLUSTERS 	:= ['G','A_V','A_C','I_V']; //High Confidence, G - Gold, A_V - Active Valid, A_C - Active CMerge, I-V Inactive Valid 
EXPORT GOOD_CLUSTERS := ['G','A_V','I_V']; //Medium Confidence
EXPORT SEGMENTATION_THRESHOLD := 100;
EXPORT BAD_CLUSTER_PENALTY := 5;
EXPORT CATEGORY_WITH_NO_SUBCATEGORY := ['G','D', '']; 
END;
