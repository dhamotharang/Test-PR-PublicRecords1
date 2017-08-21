import ln_property, ut;

export fileProcessD_BuildPropDIDBase() := function

ut.MAC_SF_Build_standard(ln_property.Prop_DID, ln_property.filenames.versionedBasePropertyDID, buildPropertyDID, ln_property.version_build);																					

												
sequential(buildPropertyDID);			
										
																																		
return 'BuildPropDIDBase';
end;																	