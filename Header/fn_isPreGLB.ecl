import ut; //have to create this function and import ut here because Header.isPreGLB is a filter macro and cannot import without syntax problems
export fn_IsPreGLB(unsigned3 nonglb_last_seen, unsigned3 first_seen, string2 src) := 
ut.PermissionTools.glb.HeaderIsPreGLB(nonglb_last_seen, first_seen, src);