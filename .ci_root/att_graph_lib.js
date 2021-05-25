// attribute graph utility functions
// --------------------------------------------------
let add_unique = (arr, item) => {
    if (!arr.includes(item)) arr.push(item);
};

let get_initial_map_new = (attrs) => {
  let out = new Map();
  let cur_id = 0;

  for (let key in attrs) {
    let value = attrs[key];
    let loc_name = key.trim().toLowerCase();
    let obj = {
        id: cur_id,  
        name: loc_name, 
        module: value.module.trim(), 
        attribute: value.attribute.trim(), 
        is_service: value['service:'] ? true : false, 
        is_library: value['library:'] ? true : false, 
        last_change: value['last.change:'], 
        changed_by: value['changed.by:'], 
        uses: [], 
        used_by: [], 
        _calls: null, 
        _uses: value.uses.map(str => str.trim().toLowerCase()), 
        _mincalls: null, 
    };

    out.set(loc_name, obj);
    cur_id++;
  }
  return out;
};

let convert_obj = (obj, map) => {
    for (let it of obj._uses) {
        let alt = map.get(it);
        if (alt) {
            add_unique(obj.uses, alt);
            add_unique(alt.used_by, obj);
        }
    }
    delete obj._uses;       // won't need this any more
};

let init_map = (map) => {
    for (let obj of map.values()) {
      obj._calls = null;
      obj._mincalls = null;
    }
};

let init_map_min = (map) => {
  for (let obj of map.values()) {
    obj._mincalls = null;
  }
};

let visit_node = (node, from, arr_out, depth) => {
    const max_depth = 2048;
    //const is_root = (node.used_by.length == 0);

    // if _calls is set, we've already visited this node
    if (node._calls || depth >= max_depth) return;

    node._calls = from;         // remember where we were called from

    if (node.is_service) arr_out.push(node);
    //if (node.is_service && is_root) arr_out.push(node);
    
    // while we would assume services aren't used by any other attributes, we can never be sure
    for (let nn of node.used_by) visit_node(nn, node, arr_out, depth+1);
};

let trace_call = (node, arr_out) => {
    let next = node._calls;

    arr_out.push(node);
    if (next && next != node) trace_call(next, arr_out);
};

let trace_min_call = (node, arr_out) => {
  let next = node._mincalls;

  arr_out.push(node);
  if (next && next != node) trace_min_call(next, arr_out);
};

let get_modules = (map) => {
  let out = new Map();

  for (let val of map.values()) {
    let mname = val.module.toLowerCase();
    let obj = out.get(mname);
    if (!obj) {
      obj = {name: mname, module: val.module, attributes: []};
      out.set(mname, obj);
    }
    obj.attributes.push(val);
  }

  return out;
};

// BFS code to get shortest path
let next_depth_level = (nodes) => {
  let out = [];

  // get a list of all the nodes used by the input list of nodes
  for (let parent of nodes) {
    // add each unvisited used_by node to the out array
    for (let nn of parent.used_by) {
      // if _mincalls is set, node has already been visited
      if (!nn._mincalls) {
        nn._mincalls = parent;
        out.push(nn);
      }
    }
  }

  return out;
};

let get_min_path = (map, st_obj, ed_obj) => {
  let arr = [st_obj];
  let out = null;

  // like with regular calls, the root obj is set to call itself
  st_obj._mincalls = st_obj;
  while (!out && arr.length > 0) {
    // see if the target is in the array
    for (let n of arr) {
      if (n == ed_obj) { out = n; break; }
    }

    // if we still haven't found it - check the next depth level
    if (!out) arr = next_depth_level(arr);
  }

  return out;
};

let generate_map_new = (attrs) => {
  let map = get_initial_map_new(attrs);

  for (let val of map.values()) convert_obj(val, map);

  return {attribute_map: map, module_map: get_modules(map)};
};

let clear_map = (map) => init_map(map);

let markup_services = (map, attr_name, out) => {
    let obj = map.get(attr_name);
    if (obj) visit_node(obj, obj, out, 0);

    return out;
};

let get_calls = (map, attr_name) => {
    let out = [];
    let obj = map.get(attr_name);

    if (obj) trace_call(obj, out);

    return out;
};

let get_min_calls = (map, attr_name, srv_name) => {
  let out = [];
  let obj = map.get(attr_name);
  let tar = map.get(srv_name);

  if (obj && tar) {
    init_map_min(map);

    let found = get_min_path(map, obj, tar);
    if (found) trace_min_call(found, out);
  }

  return out;
};

// exported functions
module.exports = {
  generate_map_new: generate_map_new, 
  clear_map: clear_map, 
  markup_services: markup_services, 
  get_calls: get_calls, 
  get_min_calls: get_min_calls
}
