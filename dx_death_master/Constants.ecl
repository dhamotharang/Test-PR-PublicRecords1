export Constants := module
  // Data Restrictions:
  // 0 - Enforce all restrictions (DEFAULT).      
  // 1 - Skip GLB, apply source and opt-out restrictions.     
  // 2 - Skip glb and source restrictions, apply (CCPA) opt-out.      
  // 3 - Skip all restrictions.                  
  export integer1 DataRestrictions := enum(integer1, enforceAll=0, skipGLB=1, skipGLBAndSource=2, skipAll=3);
end;
