#!node

let arg = process.argv.slice(2);
let file = arg[0] ? arg[0] : '';

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
  let ok = false;

  // disable console logging so we don't get status msgs in output
  let ctrl = new LogControl();
  ctrl.disable();

  let atts = ut.getServicesFromFile(file);
  let deps = await ut.findDependencies(atts);

  // now we can log again
  ctrl.enable();

  if (deps) {
    let sorted = deps.sort();
    for (let item of sorted) {
      console.log(item);
    }
    ok = true;
  }

  return ok;
}

// run the main function
if (arg.length == 0 || file.toLowerCase() == '--help') {
  console.log('Usage:');
  console.log('get_dependency_list.js <attribute_list_file>');
}
else main().then((ok) => { 
  process.exit((ok) ? 0 : 2);
});
