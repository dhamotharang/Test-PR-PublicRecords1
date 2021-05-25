#!node

let arg = process.argv.slice(2);
let use_mr = false;
let use_dep = false;
let verbose = false;
let mrid = '0';

for (let a of arg) {
  if (a.toLowerCase() == '-m') use_mr = true;
  else if (a.toLowerCase() == '-d') use_dep = true;
  else if (a.toLowerCase() == '-v') verbose = true;
  else mrid = a;
}

const fs = require('fs');
const ut = require('./utility_lib.js');

let LogControl = function() {
  this.methods = ["log", "debug", "warn", "info", "error"];
  this.buffer = {};

  // buffer logging functions
  for (let item of this.methods) this.buffer[item] = console[item];

  this.disable = function() {
    for (let item of this.methods) {
      console[item] = function() {}
    }
  }

  this.enable = function() {
    for (let item of this.methods) {
      console[item] = this.buffer[item];
    }
  }
}

// main function
let main = async function() {
  let out = new Set();
  let ok = false;

  // getting list directly from merge request is default
  if (!use_mr && !use_dep) use_mr = true;

  // disable console logging so we don't get status msgs in output (unless we're verbose)
  let ctrl = new LogControl();
  if (!verbose) ctrl.disable();

  let info = await ut.getMergeRequestInfo(mrid);

  // if we're using merge request results, add to our set
  if (use_mr) {
    if (info) {
      for (let item of info.deploy_list) {
        out.add(item.toLowerCase());
      }
      ok = true;
    }
  }

  // if we're using dependency checking, also add to our set
  if (use_dep) {
    if (info) {
      let deps = await ut.findDependencies(info.change_list);
      if (deps) {
        for (let item of deps) {
          out.add(item.toLowerCase());
        }
        ok = true;
      }
    }
  }

  // now we can log again
  if (!verbose) ctrl.enable();
  
  // output our results
  let sorted = Array.from(out).sort();
  for (let item of sorted) {
    console.log(item);
  }

  return ok;
}

// run the main function
if (arg.length == 0 || mrid.toLowerCase() == '--help') {
  console.log('Usage:');
  console.log('get_mr_query_list.js <merge_request_id> [-d/-m]');
}
else main().then((ok) => { 
  process.exit((ok) ? 0 : 2);
});
